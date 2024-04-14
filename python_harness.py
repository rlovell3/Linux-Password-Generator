# A simple Python script to call the password script.

import subprocess

def main():
    # Call the script with the -auto flag
    result = subprocess.run(['./password_gen.sh', '-a', '-sC', '-l50'], capture_output=True, text=True)

    # Get the output
    password = result.stdout.strip()

    print(f"The generated password is: {password}")

if __name__ == "__main__":
    main()