@echo off
REM Quick Setup for Azure OpenAI Testing
REM Sets environment variables and runs test

echo ========================================
echo Azure OpenAI Environment Setup
echo ========================================
echo.

REM Set Azure OpenAI credentials
set AZURE_OPENAI_API_KEY=6CwE55InRG2OQa59XCrGSjqMX1RmvXDqrNoD4w2MiGWl7nUxUgxYJQQJ99BIAC77bzfXJ3w3AAAAACOGEovm
set AZURE_OPENAI_ENDPOINT=https://ltts-cariad-ddd-mvp-ai-foundry.cognitiveservices.azure.com
set AZURE_OPENAI_MODEL=gpt-4.1-mini

echo Environment variables set:
echo   AZURE_OPENAI_API_KEY: [HIDDEN]
echo   AZURE_OPENAI_ENDPOINT: %AZURE_OPENAI_ENDPOINT%
echo   AZURE_OPENAI_MODEL: %AZURE_OPENAI_MODEL%
echo.

REM Run the test
echo Running configuration test...
echo.
python test_azure_openai.py

if errorlevel 1 (
    echo.
    echo ========================================
    echo CONFIGURATION TEST FAILED
    echo ========================================
    echo.
    echo See error messages above for troubleshooting.
    pause
    exit /b 1
)

echo.
echo ========================================
echo CONFIGURATION TEST PASSED
echo ========================================
echo.
echo You can now run the AI resolution script with these environment variables.
echo.
echo To run the AI resolution script:
echo   python ai_multilayer_resolution.py --ort-result ort-results/analyzer/analyzer-result.yml --pypi-results pypi-licenses/pypi-licenses-full.json --scancode-dir scancode-results --uncertain-packages uncertain-packages/uncertain-packages.json --output ai-multilayer-resolution.html
echo.
pause
