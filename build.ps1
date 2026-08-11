$ErrorActionPreference = "Stop"

Write-Host "Downloading servlet-api..."
Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar" -OutFile "servlet-api.jar"

Write-Host "Creating classes directory..."
$classesDir = "web\WEB-INF\classes"
if (!(Test-Path -Path $classesDir)) {
    New-Item -ItemType Directory -Path $classesDir | Out-Null
}

Write-Host "Building classpath..."
$libPath = "build\web\WEB-INF\lib"
if (Test-Path -Path "web\WEB-INF\lib") {
    $libPath = "web\WEB-INF\lib"
}

$jars = Get-ChildItem -Path $libPath -Filter "*.jar" | Select-Object -ExpandProperty FullName
$cp = "servlet-api.jar"
if ($jars.Count -gt 0) {
    $cp += ";" + ($jars -join ";")
}
Write-Host "Classpath: $cp"

Write-Host "Compiling Java sources..."
$javaFiles = (Get-ChildItem -Path src\java -Filter "*.java" -Recurse | Select-Object -ExpandProperty FullName) -join " "
cmd.exe /c "javac -encoding UTF-8 -cp `"$cp`" -d `"$classesDir`" $javaFiles"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Compilation failed."
    exit 1
}

Write-Host "Copying lib folder to web/WEB-INF/lib..."
$targetLib = "web\WEB-INF\lib"
if (!(Test-Path -Path $targetLib)) {
    New-Item -ItemType Directory -Path $targetLib | Out-Null
}
if (Test-Path -Path "build\web\WEB-INF\lib") {
    Copy-Item -Path "build\web\WEB-INF\lib\*.jar" -Destination $targetLib -Force
}

Write-Host "Packaging into WAR file..."
if (!(Test-Path -Path "dist")) {
    New-Item -ItemType Directory -Path "dist" | Out-Null
}
cmd.exe /c "jar -cvf dist\DEMO_duan.war -C web ."

Write-Host "Build complete! DEMO_duan.war is ready."
