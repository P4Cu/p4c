#!/usr/bin/env python3

from subprocess import check_output, check_call

# TODO: redirect output to journalctl
# TODO: use this by default
# TODO: add 'default' setup in case of failure
# TODO: xwindow (name) by desktop (monitor bind)

output = check_output(['/usr/bin/xrandr', '--listactivemonitors'], universal_newlines=True)
output = output.splitlines()
assert(len(output))
output[0].startswith("Monitors:")
primary=None
secondaries=[]
for line in output[1:]:
    [counter, symbol, resolution, name] = line.split()
    if symbol.startswith('+*'):
        primary=name
    else:
        secondaries += [name,]

if not primary:
    print('No primary window! taking first as primary')
    primary = secondaries[0]
    secondaries = secondaries[1:]
print('Primary:', primary)
print('Secondaries:', secondaries)

check_call('MONITOR={} nohup polybar primary &'.format(primary), cwd='/tmp', shell=True, executable='/bin/bash')
for monitor in secondaries:
    check_call('MONITOR={} nohup polybar secondary &'.format(monitor), cwd='/tmp', shell=True, executable='/bin/bash')
