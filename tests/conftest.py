import pytest
from fastapi.testclient import TestClient

from fast_api_adder_demo.main import app


@pytest.fixture(scope="function")
def test_client():
    with TestClient(app) as test_client:
        yield test_client
