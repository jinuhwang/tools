# WLAN Card disappearing issue after suspention
# Dmesg
# PM: suspend entry (deep)
# IRQ 139 137 122 125 126 no longer affine
# <Malfunction>
# ACPI: Low-level resume complete
# ACPI: Waking up from system sleep state S3
# ACPI: EC: interrupt unblocked
# ath10k_pci : Refused to change power state, currently in D3
# usb 1-3: reset full-speed USD device number 3 using xhci_hcd
# usb 1-3: device descriptor read/64, error -71
# usb 1-3: rset full-speed USB device number 3 using xhci_hcd
# usb 1-3: device descriptor read/64, error -71
# usb 1-3: Device not responding to setup address.
# usb 1-3: device not accepting address 3, error -71
# acpi LNXPOWER:00~13: Turning OFF
# usb 1-3: USB disconnect, device number 3
# OOM killer enabled
# Restarting tasks ...
# PM: suspend exit
# usb 1-3: new full-speed USB device number 7 using xhci_hcd
# ath10k_pci 0000:3a:00.0: failed to wake target for write32 of 0x0000000000 at 0x00034400: -110
# usb 1-3: device descriptor read/64, error -71
# ath10k_pci 0000:3a:00.0: failed to wake target for read32 of 0x0000000000 at 0x00034400: -110
# usb 1-3: device descriptor read/64, error -71
# usb 1-3: new full-speed USB device number 8 using xhci_hcd
# usb 1-3: device descriptor read/64, error -71
# usb usb1-port3: attempt power cycle
# usb 1-3: new full-speed USB device number 9 using xhci_hcd
# usb 1-3: Device not respoinding to setup address.
# usb 1-3: new full-speed USB device number 10 using xhci_hcd
# usb 1-3: Device not respoinding to setup address.
# usb usb1-port3: unable to enumerate USB device
# <Normal behavior>
# acpi LNXPOWER:00~13: Turning OFF
# pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000
# pci 0000:3a:00.0: reg 0x10: [mem 0x0000000-0x001fffff 64bit]
# pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
# pci 0000:3a:00.0: BAR 0: assigned [mem 0xdc000000-0xdc1fffff 64bit]
# done.
# ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
# ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
# PM: suspend exit
# usb 1-3: new full-speed USB device number 11 using xhci_hcd
# ath10k_warn: 70 callbacks suppressed
# : unsupported HTC service id: 1536

# usb 1-3 is originally
# New USB device found, idVendor=0cf3, idProduct=e301, bcdDevice=0.01
# ath10k_pci 0000:3a:00.0 on start up
# : enabling device (0000 -> 0002)
# : pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
# : qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
# : kconfig debugfs 1 tracing 1 dfs 0 testmode 0
# : firmware ver WLAN.RM.4.4.1-00140-QCARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp crc32 29eb8ca1
# : board_file api 2 bmi_id N/A crc32 c15a244d
# : unsupported HTC service id: 1536
# : htt-ver 3.60 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
# : unsupported HTC service id: 1536


# <Try out>
# 0000:00:3a:00.0 missing under /sys/bus/pci
echo 1 | sudo tee /sys/bus/pci/rescan
# still missing

lsusb
# BUS 001 DEVICE 011 Atheros Communication, inc
lsusb -v -s 001:011
lspci
# 00:3a.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless network adapter
lspci -v -s 00:3a

rfkill list
# Already unblocked
rfkill unblock all


nmcli networking off && nmcli networking on
nmcli radio wifi off && nmcli radio wifi on;
