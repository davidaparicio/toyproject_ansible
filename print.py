import sys

def printVars(*args, **kwargs):
    print("positional arguments")
    print(args)
    print("keyword arguments/splat args")
    print(kwargs)

if __name__ == "__main__":
    args = sys.argv
    # args[0] = current file
    # args[1:] = function args : (*unpacked)
    printVars(*args[1:])
