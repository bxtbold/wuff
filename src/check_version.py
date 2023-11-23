import sys

if sys.version_info < (3, 8):
    print("Python 3.8 or higher is required.")
    sys.exit(1)
else:
    print("Python 3.8 or higher is installed.")
    sys.exit(0)
