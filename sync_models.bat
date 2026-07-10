@echo off
:: ==============================================================================
:: 3D WebViewers Models Sync Script
::
:: [Usage]
:: Double-click this file or run .\sync_models.bat from your terminal.
::
:: [What it does]
:: 1. Updates the submodule (_3rdparty\3DWebViewer) from remote.
:: 2. Copies models.json to assets\json\models.json.
:: ==============================================================================

echo [1/2] Updating submodule (_3rdparty\3DWebViewer)...
git submodule update --remote _3rdparty\3DWebViewer
if %errorlevel% neq 0 (
    echo [ERROR] Failed to update submodule.
    pause
    exit /b %errorlevel%
)

echo.
echo [2/2] Copying models.json to assets\json\models.json...
copy /Y "_3rdparty\3DWebViewer\models.json" "assets\json\models.json"
if %errorlevel% neq 0 (
    echo [ERROR] Failed to copy file.
    pause
    exit /b %errorlevel%
)

echo.
echo ==============================================================================
echo Sync completed successfully!
echo Please commit the changes to assets\json\models.json using Git.
echo ==============================================================================
pause
