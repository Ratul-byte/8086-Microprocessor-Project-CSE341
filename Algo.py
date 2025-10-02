
import sys

def updated_vigenere(text, key, mode):
    """
    Encrypts or decrypts text using the Updated Vigenere Cipher.
    """
    if len(key) != 2:
        return "Error: Key must be two characters long."

    result = ""
    for i, char in enumerate(text):
        if mode == 'c':
            if i % 2 == 0:
                result += chr((ord(char) + ord(key[0])) - 115)
            else:
                result += chr((ord(char) + ord(key[1])) - 115)
        elif mode == 'd':
            if i % 2 == 0:
                result += chr((ord(char) + 115) - ord(key[0]))
            else:
                result += chr((ord(char) + 115) - ord(key[1]))
    return result

def rrs_cipher(text, mode):
    """
    Encrypts or decrypts text using the RRS algorithm.
    """
    t = len(text)
    result = ""
    for char in text:
        if mode == 'c':
            v = ord(char) - 65 + 1
            s = (v * t - 1) + 65
            result += chr(s)
        elif mode == 'd':
            s = ord(char) - 65 + 1
            v = (s // t - 1) + 65
            result += chr(v)
    return result

def caesar_cipher(text, mode):
    """
    Encrypts or decrypts text using the Caesar cipher.
    """
    result = ""
    for char in text:
        if mode == 'c':
            result += chr(ord(char) + 3)
        elif mode == 'd':
            result += chr(ord(char) - 3)
    return result

def mirror_cipher(text, mode):
    """
    Encrypts or decrypts text using the Mirror Cipher.
    """
    reversed_text = text[::-1]
    result = ""
    for char in reversed_text:
        if mode == 'c':
            result += chr(ord(char) + 16)
        elif mode == 'd':
            result += chr(ord(char) - 16)
    return result

def main():
    """
    Main function to run the cipher program.
    """
    print("Select a cipher algorithm:")
    print("1. Updated Vigenere Cipher")
    print("2. RRS Algorithm")
    print("3. Caesar Cipher")
    print("4. Mirror Cipher")

    choice = input("Enter your choice (1-4): ")

    if choice not in ['1', '2', '3', '4']:
        print("Invalid choice.")
        sys.exit(1)

    mode = input("Enter 'c' for cipher or 'd' for decipher: ").lower()
    if mode not in ['c', 'd']:
        print("Invalid mode.")
        sys.exit(1)

    text = input("Enter the message: ")

    if choice == '1':
        key = input("Enter the two-character key: ")
        result = updated_vigenere(text, key, mode)
    elif choice == '2':
        result = rrs_cipher(text, mode)
    elif choice == '3':
        result = caesar_cipher(text, mode)
    elif choice == '4':
        result = mirror_cipher(text, mode)

    print("Result:", result)

if __name__ == "__main__":
    main()
