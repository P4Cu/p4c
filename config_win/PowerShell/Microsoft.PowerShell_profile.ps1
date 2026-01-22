Write-Host "Powershell version:" $PSVersionTable.PSVersion.ToString()

# TODO:
# https://github.com/artiga033/PwshComplete
# https://github.com/PowerShell/Modules/tree/master/Modules/Microsoft.PowerShell.UnixCompleters
# https://github.com/tillig/ps-bash-completions


# ---------- Configure Readline --------------------------------------------------------------------
Write-Host "Loading $PROFILE, check keys by Get-PSReadLineKeyHandler"
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward
#Set-PSReadLineKeyHandler -Chord "Ctrl+Enter" -Function AcceptSuggestion


# ---------- Load cached VS2022 env ----------------------------------------------------------------
#. "$PSScriptRoot\vs_envfile.ps1"


# ---------- Set PATH-------------- ----------------------------------------------------------------
$env:PATH += ";$HOME\bin"
Get-ChildItem "$HOME\bin\completions" -File -Filter "*.ps1" | ForEach-Object { . $_.FullName }
$env:PATH += ";$HOME\.cargo\bin"
$env:PATH += ";$HOME\.nuget\packages\nuget.commandline\6.11.0\tools"
$env:PATH += ";C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.42.34433\bin\Hostx64\x64"
$env:PATH = "C:\ProgramData\anaconda3\;${env:PATH}"


# ---------- Configure posh ------------------------------------------------------------------------
# Install-Module posh-git -Scope CurrentUser -Force
Import-Module posh-git -NoClobber
oh-my-posh init pwsh --config wholespace | Invoke-Expression


# ---------- Configure misc ------------------------------------------------------------------------
Invoke-Expression (& { (zoxide init powershell | Out-String) })



# ---------- Aliases -------------------------------------------------------------------------------
function ranger { cd $(lf.exe -print-last-dir) }
Set-Alias -Name g -Value git
function cdg
{
	$gitRoot = git rev-parse --show-toplevel 2>$null
	if ($gitRoot)
	{
		Set-Location $gitRoot
	} else
	{
		Write-Host "Not inside a Git repository."
	}
}
function Git-CleanSafe
{
	git clean -ixd --exclude=".vs" --exclude="*.user"
}

