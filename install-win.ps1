# GitHub's cert is making PowerShell cry so make more permissive
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

# try see if Git has been installed
$check_git = Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | select DisplayName
$found_git = $FALSE
$found_docker = $FALSE

foreach ($item in $check_git) {
  if ($item.DisplayName -match "Git version.*") {
    $found_git = $TRUE
  }
  if ($item.DisplayName -match "Docker.*") {
    $found_docker = $TRUE
  }
}

# if git hasn't been installed
if ($found_git) {
  Write-Host "Git for Windows appears to already be installed"
} else {
  $git_api_url = "https://api.github.com/repos/git-for-windows/git/releases/latest"
  Write-Host "Find git for Windows latest releases: $git_api_url"
  $result = Invoke-RestMethod -Uri $git_api_url
  $bit = if ([Environment]::Is64BitProcess) {64} else {32}
  $git_url = $FALSE
  $exe_name = ""

  # look for the main exe installer
  $regex = "Git-\d+\.\d+\.\d+-$bit-bit\.exe"
  Write-Host "Looking for proper file: $regex"
  for ($i = 0; $i -lt $result.assets.Length -and !$git_url; $i++) {
    if ($result.assets[$i].name -match $regex) {
      $git_url = $result.assets[$i].browser_download_url
      $exe_name = $result.assets[$i].name
    }
  }

  # download Git for Windows
  if ($git_url) {
    $exe_path = "C:\Users\IEUser\Downloads\$exe_name"
    Write-Host "Downloading $git_url to $exe_path."

    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($git_url, $exe_path)

    Write-Host "Running $exe_path."
    $p = Start-Process $exe_path -wait
  }
}

# try see if Git has been installed
$check_docker = Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Docker* | select DisplayName

foreach ($item in $check_docker) {
  if ($item.DisplayName -match "Docker*") {
    $found_docker = $TRUE
  }
}

# if docker hasn't been installed, download and install
if ($found_docker) {
  Write-Host "Docker for Windows appears to already be installed"
} else {
  $docker_url = "https://download.docker.com/win/stable/InstallDocker.msi"
  $exe_path = "C:\Users\IEUser\Downloads\InstallDocker.msi"

  Write-Host "Downloading $docker_url to $exe_path."

  $wc = New-Object System.Net.WebClient
  $wc.DownloadFile($docker_url, $exe_path)

  Write-Host "Running $exe_path."
  $p = Start-Process $exe_path -wait
}

# use git to checkout fulcrum

# run fulcrum init
