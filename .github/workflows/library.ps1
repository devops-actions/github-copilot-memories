function Write-Message {
    param(
        [string] $message,
        [bool] $logToSummary = $false
    )
    Write-Host $message
    if ($logToSummary) {
        $summaryPath = $env:GITHUB_STEP_SUMMARY
        if ($null -ne $summaryPath -and ($summaryPath.Trim()).Length -gt 0) {
            Add-Content -Path $summaryPath -Value $message
        }
    }
}
