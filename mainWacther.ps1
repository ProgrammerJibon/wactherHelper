Add-Type -AssemblyName PresentationFramework

function Reload-Env {
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("PATH","User")
}

function Check-PythonInstalled {
    Reload-Env
    try {
        $ver = & python --version 2>$null
        if ($LASTEXITCODE -eq 0) { return $true }
        return $false
    } catch {
        return $false
    }
}

while ($true) {

    if (Check-PythonInstalled) {
        echo "Python is installed."
        break
    }

    $choice = [System.Windows.MessageBox]::Show(
        "Python is required. Install now?",
        "Python Required",
        "YesNo",
        "Warning"
    )

    if ($choice -eq "Yes") {

        $store = Start-Process "ms-windows-store://pdp/?productid=9P7QFQMJRFP7" -PassThru

        while ($true) {

            if (Check-PythonInstalled) { break }

            $storeRunning = Get-Process -Id $store.Id -ErrorAction SilentlyContinue
            if (-not $storeRunning) { break }

            Start-Sleep -Seconds 2
        }

        continue
    }
    else {
        Restart-Computer -Force
    }
}



pip install opencv-python
