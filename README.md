# NumberConverter-MASM-
**Description**
NumberConverter is an x86 assembly language program written in MASM (.486).  

This program allows users to input a number in binary format using the ZM code, where the maximum length of the number is 16 bits. The most significant bit in the variable represents the sign bit, which is appropriately processed to display positive or negative values in the decimal (DEC) output. Users can input a binary number, and the program converts and displays the number in binary (BIN), octal (OCT), decimal (DEC), and hexadecimal (HEX) formats.


**Features**
- Convert user input from binary (in ZM code) to binary, octal, decimal, and hexadecimal.
- Display the converted values in the console.
- Handle user inputs including binary numbers and special keys such as 'q' to exit and 'backspace' to correct input.
- Process the sign bit (MSB) to display correct positive or negative decimal values.


**Example Output**

```asm
podaj liczbe lub nacisnij klawisz q aby zakonczyc program: 0000111100001111
wartosc BIN: 0000111100001111
wartosc OCT: 03617
wartosc DEC: +3855
wartosc HEX: 0F0F
```
