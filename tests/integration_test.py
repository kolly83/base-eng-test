import requests
import os
import pytest

# The base URL of the deployed API (can be fetched from environment variables or Terraform output)
BASE_URL = os.getenv("API_URL", "https://8d6l67jj61.execute-api.eu-west-2.amazonaws.com/dev")

@pytest.mark.integration
def test_lambda_handler():
    url = f"{BASE_URL}/event-handler"
    payload = {"question": "How are you?"}
    response = requests.post(url, json=payload)
    assert response.status_code == 200
    assert response.json() == "I am fine, thank you!"
