// imd: resident input-source switcher, so callers skip im-select's ~35ms startup.
//
//   switch: echo com.apple.keylayout.ABC 1<> /tmp/imd-$UID.fifo
//   query:  cat /tmp/imd-$UID.current
//
// Install with ./install.sh (builds it and runs it via ~/Library/LaunchAgents/local.imd.plist).
import Carbon
import Foundation

let uid = getuid()
let fifoPath = "/tmp/imd-\(uid).fifo"
let currentPath = "/tmp/imd-\(uid).current"

func currentID() -> String {
    let source = TISCopyCurrentKeyboardInputSource().takeRetainedValue()
    guard let ptr = TISGetInputSourceProperty(source, kTISPropertyInputSourceID) else { return "" }
    return Unmanaged<CFString>.fromOpaque(ptr).takeUnretainedValue() as String
}

// TISCopyCurrentKeyboardInputSource lags a switch until the change notification arrives (~20ms),
// so select() records the id it picked instead of reading it back.
func writeCurrent(_ id: String = currentID()) {
    try? (id + "\n").write(toFile: currentPath, atomically: true, encoding: .utf8)
}

// TISCreateInputSourceList takes ~20ms (the bulk of im-select's latency); look up each id once.
var sources: [String: TISInputSource] = [:]

func lookup(_ id: String) -> TISInputSource? {
    if let source = sources[id] { return source }
    let filter = [kTISPropertyInputSourceID as String: id] as CFDictionary
    guard let list = TISCreateInputSourceList(filter, false)?.takeRetainedValue() as? [TISInputSource],
          let source = list.first else { return nil }
    sources[id] = source
    return source
}

func select(_ id: String) {
    guard !id.isEmpty else { return }
    guard let source = lookup(id) else {
        FileHandle.standardError.write("unknown input source: \(id)\n".data(using: .utf8)!)
        return
    }
    TISSelectInputSource(source)
    writeCurrent(id)
}

unlink(fifoPath)
guard mkfifo(fifoPath, 0o600) == 0 else { fatalError("mkfifo \(fifoPath) failed: errno \(errno)") }
// O_RDWR keeps a writer open ourselves, so read() never hits EOF between clients.
let fd = open(fifoPath, O_RDWR)
guard fd >= 0 else { fatalError("open \(fifoPath) failed: errno \(errno)") }

Thread {
    var pending = Data()
    var buf = [UInt8](repeating: 0, count: 256)
    while true {
        let n = read(fd, &buf, buf.count)
        guard n > 0 else { continue }
        pending.append(contentsOf: buf[0..<n])
        while let nl = pending.firstIndex(of: UInt8(ascii: "\n")) {
            let line = String(decoding: pending[pending.startIndex..<nl], as: UTF8.self)
                .trimmingCharacters(in: .whitespaces)
            pending.removeSubrange(pending.startIndex...nl)
            DispatchQueue.main.async { select(line) }
        }
    }
}.start()

DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name(kTISNotifySelectedKeyboardInputSourceChanged as String),
    object: nil, queue: .main
) { _ in writeCurrent() }  // manual toggles (e.g. right Cmd)

_ = lookup("com.apple.keylayout.ABC")
_ = lookup(currentID())
writeCurrent()
RunLoop.main.run()
