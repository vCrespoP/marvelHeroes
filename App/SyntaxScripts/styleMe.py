#!/usr/bin/env python3
# -*- coding: utf-8 -*-


### ------------------
### Imports and pipes
### ------------------

import os
import sys
import subprocess
# Make sure to execute in a terminal 
# export PYTHONIOENCODING=UTF-8

import time
import argparse



### ------------------
### Run terminal
### ------------------
def run(params):
    p = subprocess.Popen(params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in p.stdout.readlines():
        print(line)
    return p.wait()


# Configuration/Default variables
defaultCodePath = '../Code/Project'

parser = argparse.ArgumentParser(description = 'Unifies code style')
parser.add_argument('-p', '--path',
					action = 'store',
					dest = 'codePath',
					default = defaultCodePath,
                    help = 'Path to main code folder')

args = parser.parse_args()

# Swift lint it
print("Swift Linting (Autocorret + Format)...")
start = time.time()
os.chdir(args.codePath)
os.system("swiftlint autocorrect --format")
end = time.time()
print("Time to lint: %.2f seconds" % (end - start))


# Clean Up
print("Cleaning...")


print("")
print("🎉 The Swag train has arrived, code with style 🎉")
print("")

