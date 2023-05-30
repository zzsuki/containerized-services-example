import sys
import socket
import json
from urllib.request import urlopen
from urllib.error import URLError


def check_port(ip, port):
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(3)
            result = sock.connect_ex((ip, port))
            return result == 0
    except Exception:
        return False

def check_http_status(ip):
    url = f"http://{ip}"
    try:
        with urlopen(url, timeout=3) as response:
            if response.status == 200:
                data = json.loads(response.read().decode())
                return data.get('status', '').lower() == 'ok'
    except (URLError, json.JSONDecodeError):
        pass

    return False

def main():
    if len(sys.argv) < 2:
        print("Usage: python check_ip.py <target_ip>")
        sys.exit(1)

    target_ip = sys.argv[1]

    if check_port(target_ip, 80):
        print("True")
    else:
        print("False")

if __name__ == "__main__":
    main()