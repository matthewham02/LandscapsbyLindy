$port = if ($env:PORT) { [int]$env:PORT } else { 8080 }
$root = $PSScriptRoot

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Serving $root on http://localhost:$port/"

$mime = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
}

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $req = $context.Request
    $res = $context.Response

    $path = [System.Uri]::UnescapeDataString($req.Url.AbsolutePath.TrimStart('/'))
    if ([string]::IsNullOrWhiteSpace($path)) { $path = "index.html" }
    $file = Join-Path $root $path
    if ((Test-Path $file -PathType Container)) { $file = Join-Path $file "index.html" }

    $fullRoot = (Resolve-Path $root).Path
    $valid = (Test-Path $file -PathType Leaf)
    if ($valid) {
        $fullFile = (Resolve-Path $file).Path
        if (-not $fullFile.StartsWith($fullRoot)) { $valid = $false }
    }

    if ($valid) {
        $ext = [System.IO.Path]::GetExtension($file).ToLower()
        $type = $mime[$ext]
        if (-not $type) { $type = "application/octet-stream" }
        $bytes = [System.IO.File]::ReadAllBytes($file)
        $res.ContentType = $type
        $res.ContentLength64 = $bytes.Length
        $res.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $res.StatusCode = 404
        $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
        $res.OutputStream.Write($msg, 0, $msg.Length)
    }
    $res.Close()
}
