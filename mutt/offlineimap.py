#! /usr/bin/env python2
from subprocess import check_output


def get_pass():
    return check_output("gpg2 -dq ~/.gmail.gpg", shell=True).strip("\n")

print get_pass()
