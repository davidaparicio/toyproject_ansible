#!/usr/bin/env python3
import os
import sys

def printVars(*args, **kwargs):
    print("positional arguments")
    print(args)
    print("keyword arguments/splat args (empty when run as script)")
    print(kwargs)

if __name__ == "__main__":
    args = sys.argv
    python_executable_path = os.environ['_']
    print(f"python={python_executable_path}")
    print(f"file={args[0]}")
    # args[0] = current file
    # args[1:] = function args : (*unpacked)
    printVars(*args[1:])
    sys.exit(0)

# https://www.executeprogram.com/courses/python-for-programmers/lessons/variadic-functions
# https://book.pythontips.com/en/latest/args_and_kwargs.html
