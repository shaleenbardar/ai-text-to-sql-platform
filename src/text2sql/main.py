import os

from dotenv import load_dotenv


load_dotenv()


def main():
    environment = os.getenv("APP_ENV", "unknown")
    print(f"Application environment: {environment}")


if __name__ == "__main__":
    main()