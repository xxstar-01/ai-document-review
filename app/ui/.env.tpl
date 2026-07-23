# Entra app registration for the UI app
VITE_TENANT_ID="${VITE_TENANT_ID}"
VITE_CLIENT_ID="${VITE_CLIENT_ID}"

# Add the API Entra app reg client ID below
VITE_API_SCOPE="${VITE_API_SCOPE}"

# Optional: override API origin for local dev/proxy-less setups.
# Examples:
# - VITE_API_ORIGIN=http://127.0.0.1:5611
# - VITE_API_ORIGIN=
VITE_API_ORIGIN="${VITE_API_ORIGIN}"

# Optional: Vite dev-server proxy target (when VITE_API_ORIGIN is empty).
# Default: http://127.0.0.1:5611
VITE_API_PROXY_TARGET="${VITE_API_PROXY_TARGET}"

# Your storage account details
VITE_STORAGE_ACCOUNT="${VITE_STORAGE_ACCOUNT}"
VITE_STORAGE_DOCUMENT_CONTAINER="${VITE_STORAGE_DOCUMENT_CONTAINER}"
