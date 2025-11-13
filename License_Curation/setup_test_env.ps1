# Quick Setup for Azure OpenAI Testing
# Sets environment variables and runs test

Write-Host "========================================"
Write-Host "Azure OpenAI Environment Setup"
Write-Host "========================================"
Write-Host ""

# Set Azure OpenAI credentials
$env:AZURE_OPENAI_API_KEY = "6CwE55InRG2OQa59XCrGSjqMX1RmvXDqrNoD4w2MiGWl7nUxUgxYJQQJ99BIAC77bzfXJ3w3AAAAACOGEovm"
$env:AZURE_OPENAI_ENDPOINT = "https://ltts-cariad-ddd-mvp-ai-foundry.cognitiveservices.azure.com"
$env:AZURE_OPENAI_MODEL = "gpt-4.1-mini"

Write-Host "Environment variables set:"
Write-Host "  AZURE_OPENAI_API_KEY: [HIDDEN]"
Write-Host "  AZURE_OPENAI_ENDPOINT: $env:AZURE_OPENAI_ENDPOINT"
Write-Host "  AZURE_OPENAI_MODEL: $env:AZURE_OPENAI_MODEL"
Write-Host ""

# Run the test
Write-Host "Running configuration test..."
Write-Host ""
python test_azure_openai.py

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "========================================"
    Write-Host "CONFIGURATION TEST FAILED"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "See error messages above for troubleshooting."
    exit 1
}

Write-Host ""
Write-Host "========================================"
Write-Host "CONFIGURATION TEST PASSED"
Write-Host "========================================"
Write-Host ""
Write-Host "You can now run the AI resolution script with these environment variables."
Write-Host ""
Write-Host "To run the AI resolution script:"
Write-Host "  python ai_multilayer_resolution.py --ort-result ort-results/analyzer/analyzer-result.yml --pypi-results pypi-licenses/pypi-licenses-full.json --scancode-dir scancode-results --uncertain-packages uncertain-packages/uncertain-packages.json --output ai-multilayer-resolution.html"
Write-Host ""
