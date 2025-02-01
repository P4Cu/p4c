https://mohundro.com/blog/2024-08-03-how-i-manage-my-dotfiles/

```
    if ($whatIf) {
        log "Linking $($map.Link) to $($map.Target)"
    }
    else {
        if ((Get-Item $map.Target) -is [System.IO.DirectoryInfo] -and $IsWindows) {
            New-Item -Path $_.Link -ItemType Junction -Value $_.Target
        }
        else {
            New-Item -Path $_.Link -ItemType SymbolicLink -Value $_.Target
        }
    }
```

`winget search`
`winget install`
