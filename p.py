from io import BytesIO
from pathlib import Path

import img2pdf
from pdf2image import convert_from_path


def pilimg2bytes(img):
    b = BytesIO()
    img.save(b, format='png')
    b.seek(0)
    return b


def convert(src_file, dst_file):
    imgs = convert_from_path(src_file)
    with Path(dst_file).open('wb') as f:
        f.write(img2pdf.convert([pilimg2bytes(img) for img in imgs]))


def main():
    import sys
    src = Path(sys.argv[1])
    dst = Path(sys.argv[2])
    convert(src, dst)


if __name__ == '__main__':
    main()
