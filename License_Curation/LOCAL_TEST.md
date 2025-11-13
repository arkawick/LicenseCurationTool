# Local Testing Guide

Before pushing to GitHub, test the AI resolution script locally to ensure it works correctly.

## Quick Test

### 1. Set Environment Variables

**Windows Command Prompt:**
```cmd
set AZURE_OPENAI_API_KEY=6CwE55InRG2OQa59XCrGSjqMX1RmvXDqrNoD4w2MiGWl7nUxUgxYJQQJ99BIAC77bzfXJ3w3AAAAACOGEovm
set AZURE_OPENAI_ENDPOINT=https://ltts-cariad-ddd-mvp-ai-foundry.cognitiveservices.azure.com
set AZURE_OPENAI_MODEL=gpt-4.1-mini
```

**Windows PowerShell:**
```powershell
$env:AZURE_OPENAI_API_KEY="6CwE55InRG2OQa59XCrGSjqMX1RmvXDqrNoD4w2MiGWl7nUxUgxYJQQJ99BIAC77bzfXJ3w3AAAAACOGEovm"
$env:AZURE_OPENAI_ENDPOINT="https://ltts-cariad-ddd-mvp-ai-foundry.cognitiveservices.azure.com"
$env:AZURE_OPENAI_MODEL="gpt-4.1-mini"
```

**Linux/Mac:**
```bash
export AZURE_OPENAI_API_KEY="6CwE55InRG2OQa59XCrGSjqMX1RmvXDqrNoD4w2MiGWl7nUxUgxYJQQJ99BIAC77bzfXJ3w3AAAAACOGEovm"
export AZURE_OPENAI_ENDPOINT="https://ltts-cariad-ddd-mvp-ai-foundry.cognitiveservices.azure.com"
export AZURE_OPENAI_MODEL="gpt-4.1-mini"
```

### 2. Test Configuration

```bash
python test_azure_openai.py
```

**Expected Output:**
```
================================================================================
AZURE OPENAI CONFIGURATION TEST
================================================================================

📋 Configuration:
  API Key: ✓ Set
  Endpoint: https://ltts-cariad-ddd-mvp-ai-foundry.cognitiveservices.azure.com
  Model Deployment: gpt-4.1-mini
  API Version: 2025-01-01-preview

🔌 Testing Azure OpenAI connection...
  ✓ Client initialized successfully

🤖 Testing model deployment with simple prompt...
  ✓ Model responded: Hello, ORT!

================================================================================
✅ SUCCESS! Azure OpenAI is configured correctly.
================================================================================
```

### 3. Test AI Resolution Script

If the configuration test passes, test the actual script:

```bash
python ai_multilayer_resolution.py \
  --ort-result ort-results/analyzer/analyzer-result.yml \
  --pypi-results pypi-licenses/pypi-licenses-full.json \
  --scancode-dir scancode-results \
  --uncertain-packages uncertain-packages/uncertain-packages.json \
  --output ai-multilayer-resolution.html
```

**Expected Output:**
```
✓ Azure OpenAI client initialized
  Using model deployment: gpt-4.1-mini

📊 Loading multi-layer license data...
📦 Loading ORT licenses...
   ✓ Loaded 79 packages from ORT

🤖 Running AI analysis on problematic packages...
   Analyzing 1 conflict packages...
      [1/1] docutils
   Analyzing 2 missing license packages...
      [1/2] matplotlib-inline
      [2/2] sphinx-reredirects

✅ Report generated: ai-multilayer-resolution.html
```

## Troubleshooting

### Error: DeploymentNotFound

**Problem:**
```
Error code: 404 - {'error': {'code': 'DeploymentNotFound'...
```

**Solution:**
Your `AZURE_OPENAI_MODEL` doesn't match your Azure deployment name. Check Azure Portal:

1. Go to https://portal.azure.com
2. Navigate to your Azure OpenAI resource
3. Click **"Model deployments"**
4. Copy the exact deployment name (case-sensitive!)
5. Update your environment variable

### Error: Invalid API Key

**Problem:**
```
Error code: 401 - Unauthorized
```

**Solution:**
Your API key is incorrect or expired. Get a new one:

1. Go to https://portal.azure.com
2. Navigate to your Azure OpenAI resource
3. Click **"Keys and Endpoint"**
4. Copy KEY 1 or KEY 2
5. Update your environment variable

### Using Model: gpt-4o-mini (Wrong!)

**Problem:**
The script shows it's using `gpt-4o-mini` but your deployment is `gpt-4.1-mini`

**Solution:**
The `AZURE_OPENAI_MODEL` environment variable is not set. Set it explicitly:
```bash
export AZURE_OPENAI_MODEL="gpt-4.1-mini"
```

## GitHub Secrets

Once local testing works, ensure you have these secrets configured in GitHub:

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Add these secrets:

| Secret Name | Value |
|-------------|-------|
| `AZURE_OPENAI_API_KEY` | Your API key from Azure Portal |
| `AZURE_OPENAI_ENDPOINT` | `https://ltts-cariad-ddd-mvp-ai-foundry.cognitiveservices.azure.com` |
| `AZURE_OPENAI_MODEL` | `gpt-4.1-mini` (your deployment name) |

**Note:** The workflow now defaults to `gpt-4.1-mini` if `AZURE_OPENAI_MODEL` secret is not set, so setting this secret is optional if you're using the default deployment.

## What Changed

### Before (Broken):
- Workflow defaulted to `gpt-4o-mini`
- API version was `2024-08-01-preview` (old)
- Deployment name mismatch caused 404 errors

### After (Fixed):
- Workflow defaults to `gpt-4.1-mini` (matches your Azure deployment)
- API version is `2025-01-01-preview` (current)
- Matches configuration from working `ort_curation_script_html.py`

## Files Modified

1. `ai_multilayer_resolution.py` - Updated API version and default deployment
2. `enhanced-ort-workflow.yml` - Fixed default deployment name
3. `AZURE_OPENAI_SETUP.md` - Updated documentation
4. `CLAUDE.md` - Added configuration reference
5. `test_azure_openai.py` - Created test script
