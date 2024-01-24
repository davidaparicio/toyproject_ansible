#!/usr/bin/env python3
import os
import sys
import pwd


def printVars(*args, **kwargs):
    print("positional arguments")
    print(args)
    print("keyword arguments/splat args (empty when run as script)")
    print(kwargs)


# UNIX correct username with Ansible become https://stackoverflow.com/a/2899055
def get_username():
    return pwd.getpwuid(os.getuid())[0]


if __name__ == "__main__":
    args = sys.argv
    user = get_username()
    print(f"user={user}|uid={os.getuid()}")
    # Not working with Ansible become
    # python_executable_path = os.environ["_"]
    print(f"python={sys.executable}")
    print(f"file={args[0]}")
    # args[0] = current file
    # args[1:] = function args : (*unpacked)
    printVars(*args[1:])
    sys.exit(0)

# https://www.executeprogram.com/courses/python-for-programmers/lessons/variadic-functions
# https://book.pythontips.com/en/latest/args_and_kwargs.html
