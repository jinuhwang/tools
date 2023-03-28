#!/usr/bin/env python

import argparse
from pathlib import Path
from PyPDF2 import PdfReader



if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("INPUT_PDF_PATH")
    parser.add_argument("OUTPUT_TXT_DIR")

    args = parser.parse_args()

    pdf_path = Path(args.INPUT_PDF_PATH)
    txt_dir = Path(args.OUTPUT_TXT_DIR)

    reader = PdfReader(pdf_path)

    txt_dir.mkdir(exist_ok=True, parents=True)

    for i, page in enumerate(reader.pages):
        text = page.extract_text()
        with open(txt_dir / f"{pdf_path.stem}_{i}.txt", "w") as f:
            f.write(text)

