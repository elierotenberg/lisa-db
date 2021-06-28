import requests
import json

spec = requests.get(
    "http://localhost:8055/server/specs/oas",
    params={"access_token": "api-client-dev-token"},
).json()

with open("directus.spec.json", "w") as f:
    f.write(json.dumps(spec, indent=2))
