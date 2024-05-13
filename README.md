# 8086-Microprocessor-Project

Hello everyone! 👋 This is a small project developed during our university's Microprocessor course. Here we constructed four cipher-decipher algorithms using only Assemply language for 8086 microprocessor with the help from YouTube tutorials, ChatGPT, StackOverflow, and various other free online resources.

##### **For this project to work make sure to download (For educational institutions faculties might provide) and install EMU8086 software. 
##### *([Softonic Download Link](https://emu8086-microprocessor-emulator.en.softonic.com/download) + [Activation Code](https://gist.github.com/joao-neves95/8cb68b4904226efc28f5f1fb2ce65f33#gistcomment-5046549)) 

## Group Members:
- [Md. Ratul Mushfique](https://www.facebook.com/ratul.mushfique/)
- [Sadman Safiur Rahman](https://www.facebook.com/sadmansafiur.rahman)
- [Mohd. Shadman Ahmed Razeen](https://www.facebook.com/profile.php?id=100008473509371)

## Project Description:
Ciphering is the process of encoding a message using a cryptographic algorithm to make it unreadable to unauthorized parties, while deciphering is the process of reversing the encryption to retrieve the original message. In this project a user can encrypt(cipher) and decrypt(decipher) a certain input given to the emu8086 terminal. Since, there are 4 different algorithms that are constructed here, the user has the power to choose which algorithm he/she will be using. Moreover, the user also has the choice to use if the algorithms will find the ciphered or deciphered text of the input given in the terminal. Now, here is a brief explanation about the four algorithms that we implemented/updated/created,

### 1. Updated Vigenere Cipher:
In this varian of Vignere Cipher Algorithm, the user provides an encrypted message and two secret letters. Each letter of the encrypted message and the secret letters are converted to numerical values when arithmatic operations gets conducted on them. Characters in the odd positions' is added to the first secret letter, and the even positions' added to the second secret letter. The result is converted back to characters to get the encrypted message.

#### Example:
Secret Letters: AB
Message: ‘this’
Even positions: t, i
Odd positions: h, s

#### Cipher:
t + A - 115 => 116 + 65 - 115 => B [66]
h + B - 115 => 104 + 66 - 115 => 7 [55]
i + A - 115 => 105 + 65 - 115 => 7 [55]
s + B - 115 => 115 + 66 - 115 => B [66]

#### Decipher:
The encrypted text is B77B
>B-A +115 => 66-65+115 => t [116]
>7-B +115 => 55-66+115 => h [104]
>7-A +115 => 55-65+115 => i [105]
>B-B +115 => 66-66+115 => s [115]


### 2. RRS (Ratul-Razeen-Sadman) Algorithm:
This algorithm utilizes the equation of motion 𝑠 = 𝑣𝑡, where
s = ciphered secret text
v = positions of uppercase alphabatical characters in the ASCII table
t = last iteration number/lenth of the text in the input

Each letter's position in the uppercase alphabetical order is multiplied by the last iteration number or the length of the message on the input text to determine the new position.
The new position is then converted back to characters to get the encrypted message.

#### Cipher:
For encryption, each letter's position in the alphabet is calculated based on its ASCII value relative to 'A' (65). This position is then substracted by 65 and then added by 1 to determine its position in the sequence of alphatical order e.g. 'A' = 65 -65 = 0+1 = 1st character in the order. After the number is multiplied by a factor ('t'), adjusted to get the actual ASCII valued character in the output, and converted back to a character to form the ciphertext.
(A=v1)--> (65-65) = 0+1 = 1*3 = 3 = (3-1)+65 = 67 = C = s1
(B=v2)--> (66-65) = 1+1 = 2*3 = 6 = (6-1)+65 = 70 = F = s2
(C=v3)--> (67-65) = 3+1 = 3*3 = 9 = (9-1)+65 = 73 = I = s3

#### Decipher:
During decryption, the process is reversed.
The encrypted text is CFI
V1 = s1/t  =>(3/3) =1 -1+65 >> A [65]
V2 = s2/t  =>(6/3) =2 -1+65 >> B [66]
V3 = s3/t => (9/3) =3 -1+65 >> C [67]

### 3. Caesar Algorithm:
This algorithm shifts each letter in the message by three characters. For ciphering, each character is shifted forward by three bits, and for deciphering, each character is shifted backward by three bits.

### Cipher:
Input: AbC.
Output: DeF
Input: XYZ
Output: [/]

### Decipher:
Input: DeF
Output: AbC

### 4. Mirror Cipher-Decipher Algorithm using Stack:
For ciphering, each letter of the message is pushed into a stack to reverse the order. After popping from the stack, 10h is added to each element and inserted into a defined array. For deciphering, the reverse process is followed by subtracting 10h from each element.

#### Cipher:
Input: GREAT GOOD
After push and pop: DOOG TAERG
Output: T__W0dQUbW

#### Decipher:
Input: T__W0dQUbW
After push and pop: WbUQd0W__T
Output: GREAT GOOD

Each algorithm presents a unique approach to encryption and decryption, providing various levels of security and complexity.








