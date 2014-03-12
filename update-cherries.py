#!/usr/bin/python3

import json
import os
import urllib.request


# **********************************************************************
# Config

URL_GERRIT = 'https://gerrit.omnirom.org'

CHERRY_CONFIG = 'manifest/cherries.txt'
CHERRY_SCRIPT = 'manifest/pick-cherries.sh'


# **********************************************************************
# Read cherries from config file

gCherries = list()

def readCherries():
    with open(CHERRY_CONFIG, 'r') as f:
        for line in f:
            line = line.strip()
            if (len(line) == 0) or (line[0] == '#'):
                continue
            gCherries.append(line.split(' '))


# **********************************************************************
# Get cherry details from web page

def getCherryDetails(cherry):
    url = '%s/changes/?q=%s&o=CURRENT_REVISION' % (URL_GERRIT, cherry[1])
    response = urllib.request.urlopen(url).read().decode("utf-8")
    if response[0:4] == ")]}'":
        response = response[4:]
    data = json.loads(response)[0]
    data['path'] = cherry[0]
    return data


# **********************************************************************
# Validate cherry

def validateCherry(data):
    st = data['status']
    if st == 'NEW':
        print('Adding cherry %d %s' % (data['_number'], data['subject']))
        return True
    elif st == 'MERGED':
        print('Ignoring merged cherry %d %s' % (data['_number'], data['subject']))
        return False
    elif st == 'ABANDONED':
        print('Ignoring abandoned cherry %d %s' % (data['_number'], data['subject']))
        return False
    else:
        print('Unknown status %s for %d %s' % (data['status'], data['_number'], data['subject']))
        return False


# **********************************************************************
# Main

readCherries()

with open(CHERRY_SCRIPT, 'w') as f:
    f.write('#!/bin/sh\n\n')
    f.write('set -e\n\n')
    for cherry in gCherries:
        data = getCherryDetails(cherry)
        if validateCherry(data):
            revision = data['revisions'][data['current_revision']]['fetch']['http']
            f.write('# %s\n' % data['subject'])
            f.write('# URL: https://gerrit.omnirom.org/%d\n' % data['_number'])
            f.write('( cd %s; \\\n' % data['path'])
            f.write('  git fetch %s %s && \\\n' % (revision['url'], revision['ref']))
            f.write('  git cherry-pick FETCH_HEAD )\n\n')

os.chmod(CHERRY_SCRIPT, 0o755)

