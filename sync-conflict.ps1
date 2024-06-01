# after resume
# run check to find conflit files
# c:\Users\markosf\1progs\1sync\
# *.sync-conflict-*

Write-Host "Syncthing conflict check..."
Write-Host "Sleeping for 2 minutes"

# Start-Sleep -Seconds (2 * 60)
timeout 120

$paths = @("c:\Users\markosf\1progs\1sync", "c:\bac")
# $paths = @("c:\bac")
# $paths = @("C:\Path\To\First\Folder", "D:\Path\To\Second\Folder")  # Define your array of paths here
$foundFiles = $false

foreach ($path in $paths) {
  $files = Get-ChildItem -Path $path -Recurse -Filter "*.sync-conflict-*" -File -ErrorAction SilentlyContinue
  if ($files) {
    $foundFiles = $true
    $files | ForEach-Object { Write-Output $_.FullName }
  }
}

if ($foundFiles) {
  Write-Host "Press any key to exit..."
  $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}


# Define the path to the log file
$logFilePath = "C:\Users\markosf\AppData\Local\Syncthing\syncthing.log"
$todaysDate = (Get-Date).ToString("yyyy/MM/dd")
# $todaysDate = "2024/04/18"
# Retrieve the filtered log entries
$filteredLogs = Get-Content $logFilePath |
  Select-String -Pattern "\[VVIXM\] $todaysDate" |
  Select-String -Pattern "insufficient space"

# Output the filtered log entries
$filteredLogs | Write-Output
if ($filteredLogs) {
  Start-Process "http://127.0.0.1:8384/"
  "Press any key to exit..."
  $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}


# Get-Content "C:\Users\markosf\AppData\Local\Syncthing\syncthing.log" | Select-String -Pattern "\[VVIXM\] 2024/04/18" | Write-Output
