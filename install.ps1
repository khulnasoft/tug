$version="0.60.2"

$tug_base=Split-Path -Parent $MyInvocation.MyCommand.Definition

function check_binary () {
  Write-Host "  - Checking tug executable ... " -NoNewline
  $output=cmd /c $tug_base\bin\tug.exe --version 2>&1
  if (-not $?) {
    Write-Host "Error: $output"
    $binary_error="Invalid binary"
  } else {
    $output=(-Split $output)[0]
    if ($version -ne $output) {
      Write-Host "$output != $version"
      $binary_error="Invalid version"
    } else {
      Write-Host "$output"
      $binary_error=""
      return 1
    }
  }
  Remove-Item "$tug_base\bin\tug.exe"
  return 0
}

function download {
  param($file)
  Write-Host "Downloading bin/tug ..."
  if (Test-Path "$tug_base\bin\tug.exe") {
    Write-Host "  - Already exists"
    if (check_binary) {
      return
    }
  }
  if (-not (Test-Path "$tug_base\bin")) {
    md "$tug_base\bin"
  }
  if (-not $?) {
    $binary_error="Failed to create bin directory"
    return
  }
  cd "$tug_base\bin"
  $url="https://github.com/khulnasoft/tug/releases/download/v$version/$file"
  $temp=$env:TMP + "\tug.zip"
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  if ($PSVersionTable.PSVersion.Major -ge 3) {
    Invoke-WebRequest -Uri $url -OutFile $temp
  } else {
    (New-Object Net.WebClient).DownloadFile($url, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$temp"))
  }
  if ($?) {
    (Microsoft.PowerShell.Archive\Expand-Archive -Path $temp -DestinationPath .); (Remove-Item $temp)
  } else {
    $binary_error="Failed to download with powershell"
  }
  if (-not (Test-Path tug.exe)) {
    $binary_error="Failed to download $file"
    return
  }
  echo y | icacls $tug_base\bin\tug.exe /grant Administrator:F ; check_binary >$null
}

download "tug-$version-windows_amd64.zip"

Write-Host 'For more information, see: https://github.com/khulnasoft/tug'
