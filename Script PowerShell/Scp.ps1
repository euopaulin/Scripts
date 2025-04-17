Write-Output "Ola, mundo"
$idade = [int]24

if (18 -gt $idade) {
    Write-Output "18 é maior que $idade"
}
elseif (18 -lt $idade) {
    Write-Output "18 é menor que $idade"
}
else {
    Write-Output "18 é igual que $idade"
}

$servico = Get-Process

foreach ($proc in $servico) {
    Write-Output "Nome: $($pro.Name) | CPU: $($proc."CPU")"
    Start-Sleep -Seconds 3
}
Write-Output "Specs da maquina do IPEA:"
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, OSArchitecture, Version

Write-Output "GPU Specs:"
$gpuInfo = Get-CimInstance -ClassName Win32_VideoController | Select-Object Name, DriverVersion, AdapterRAM

foreach ($gpu in $gpuInfo) {
    $ramGB = [math]::Round($gpu.AdapterRAM / 1GB, 2) # Converte para GB com duas casas decimais
    Write-Output "Nome: $($gpu.Name)"
    Write-Output "Driver: $($gpu.DriverVersion)"
    Write-Output "RAM: $ramGB GB"
}