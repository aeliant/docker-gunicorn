import requests

HOST='localhost'
PORT='54300'

def test_container_response():
    """Check availability and validity of returned response."""
    path = '/test/route'
    response = requests.get('http://%s:%s%s' % (HOST, PORT, path))

    assert response.status_code == 200
    assert isinstance(response.json(), dict)
    assert 'message' in response.json()
    assert response.json().get('message') == 'hello'
