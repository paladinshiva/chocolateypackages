﻿$name    = "reconsole-script"

$start   = "$ENV:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

$tools   = Split-Path $MyInvocation.MyCommand.Definition
$content = Join-Path (Split-Path $tools) "content"

$target  = Join-Path $content "reconsole.ahk"
$icon    = Join-Path $content "reconsole.ico"
$link    = Join-Path $start "reconsole.lnk"

try {
  $shell = New-Object -ComObject "Wscript.Shell"
  $shortcut = $shell.CreateShortcut($link)
  $shortcut.WorkingDirectory = $content
  $shortcut.TargetPath = $target
  $shortcut.IconLocation = $icon
  $shortcut.Save()

  & $link

  Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $_.Exception.Message
  throw 
}