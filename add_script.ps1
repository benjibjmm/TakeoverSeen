param (
    [string]$directory,
    [string]$line_to_add
)

# Vérification si le répertoire existe
if (-Not (Test-Path $directory)) {
    Write-Host "Le répertoire spécifié n'existe pas : $directory"
    exit
}

# Boucle à travers chaque fichier HTML, ASPX, et ASPXC
Get-ChildItem -Recurse -Path $directory -Include *.html, *.aspx, *.aspxc | ForEach-Object {
    $file = $_.FullName
    $content = Get-Content $file -Raw
    if ($content -match '</body>') {
        $content = $content -replace '</body>', "$line_to_add`n</body>"
        Set-Content -Path $file -Value $content
    }
}

Write-Host "Line added to all HTML, ASPX, and ASPXC files."
