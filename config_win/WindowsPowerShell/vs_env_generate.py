from pathlib import Path
from typing import Dict, List
from subprocess import check_output
import sys
import os

r"""
Equivalent of:
    function vsenv
    {
	    pushd "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools"
	    cmd /c "VsDevCmd.bat&set" |
		    foreach {
			    if ($_ -match "=")
			    {
				    $v = $_.split("=", 2); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])" 
			    }
		    }
	    popd
	    Write-Host "`nVisual Studio 2022 Command Prompt variables set." -ForegroundColor Yello
    }
"""


def find_added_elements(dict1: Dict[str, List[str]], dict2: Dict[str, List[str]]):
    """Finds elements added within lists and new keys.
       Returns a dictionary where values are lists of added elements.
    """

    all_keys = set(key for key in dict2.keys() if not key.startswith('__'))  # All keys from both dicts

    diff_dict = {}
    new_dict = {}

    for key in all_keys:
        if key not in dict1:  # Entirely new key
            new_dict[key] = ';'.join(dict2[key])
        else: #Key exists in both
            added = list(set(dict2[key]) - set(dict1[key]))
            if added:
                diff_dict[key] = added
    return new_dict, diff_dict

def parse_env_to_dict(text: str):
    v: dict[str, List[str]] = {}
    for line in text.splitlines():
        if line.startswith("*"):
            continue
        try:
            key, _, value = line.partition('=')
            v[key] = value.split(';')
        except:
            pass
    return v

def get_env_from_cmd(cmd, cwd=None):
    text = check_output(['cmd', '/c', cmd], cwd=cwd, universal_newlines=True)
    return parse_env_to_dict(text)

if "__VSENV_SOURCED" in os.environ:
    print("This script has to be run without __VSENV_SOURCED environment!")
    sys.exit(1)

a = get_env_from_cmd("set")
b = get_env_from_cmd('''VsDevCmd.bat & set''', cwd="C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools" )
new_dict, diff_dict = find_added_elements(a, b)

lines = []
lines.append('''if ($env:__VSENV_SOURCED) { return }''')
lines.append('''$env:__VSENV_SOURCED = "1"''')
lines.append('''Write-Host "`nVisual Studio 2022 Command Prompt variables set." -ForegroundColor Yello''') 
# write new env
for k,v in new_dict.items():
    lines.append(f'''$env:{k} = "{v}"''')
for k,v in diff_dict.items():
    v = ";".join(v)
    lines.append(f'''$env:{k} = "{v};$env:{k}"''')
Path('vs_envfile.ps1').write_text("\n".join(lines))
