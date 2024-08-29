$certPath = Read-Host "Enter the path to save certificates and signed files (e.g., C:\SignCode)"
$caCertName = Read-Host "Enter the name for the CA certificate (e.g., COMPANY_CA)"
$spcCertName = Read-Host "Enter the name for the code-signing certificate (e.g., COMPANY_SPC)"
$executableName = Read-Host "Enter the name of the executable to sign (e.g., Example.exe)"
$email = Read-Host "Enter the email for the certificate (e.g., info@company.com)"
$timestampUrl = Read-Host "Enter the timestamp server URL (e.g., http://timestamp.sectigo.com)"

Set-Location "C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64"

Write-Host "Creating CA certificate..."
.\makecert.exe -r -pe -n "CN=$caCertName Code Signing Certificate, E=$email" -ss CA -sr LocalMachine -a sha256 -cy authority -sky signature -sv "$certPath\$caCertName.pvk" "$certPath\$caCertName.cer"

Write-Host "Adding CA certificate to the Root store..."
certutil -user -addstore Root "$certPath\$caCertName.cer"

Write-Host "Creating code-signing certificate..."
.\makecert.exe -pe -n "CN=$caCertName, E=$email" -a sha256 -cy end -sky signature -ic "$certPath\$caCertName.cer" -iv "$certPath\$caCertName.pvk" -sv "$certPath\$spcCertName.pvk" "$certPath\$spcCertName.cer"

Write-Host "Converting to PFX..."
.\pvk2pfx.exe -pvk "$certPath\$spcCertName.pvk" -spc "$certPath\$spcCertName.cer" -pfx "$certPath\$spcCertName.pfx"

Write-Host "Signing the executable..."
.\signtool.exe sign /v /f "$certPath\$spcCertName.pfx" /t $timestampUrl "$certPath\$executableName"

Write-Host "Verifying the signature..."
.\signtool.exe verify /pa "$certPath\$executableName"

Write-Host "Process completed."
explorer.exe $certPath