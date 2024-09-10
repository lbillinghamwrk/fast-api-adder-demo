def test_adding_ints(test_client):
    response = test_client.get("/calculator/39/add/3")
    assert response.status_code == 200
    response_json = response.json()
    assert response_json["answer"] == 42
    assert response_json["calc"] == "39 + 3 = 42"
