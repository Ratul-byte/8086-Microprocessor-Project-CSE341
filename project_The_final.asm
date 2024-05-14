data segment
    ; add your data here!
    arr db  40 dup (?)
    arr2 db 2 dup(?)
    arr3 db 40 dup (?)    
    arr4 db 40 dup (?)
    var1 db "Enter your message: $"
    var2 db "Enter cipher-decipher method: $"
    ; 1= method 1
    ; 2= method 2
    ; 3= method 3
    var3 db "Enter secret key: $"   
    var4 db "The secret message is: $" 
    var5 db "the encrypted text is: $"
    pick db ?
    decide db "Enter 'C' for Cipher or 'D' for Decipher: $"
    choose db "Do you want to decipher this message (Y for yes): $"
    ;var4 db "Enter message length: $"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:  
    mov ax, data
    mov ds, ax
    mov es, ax
    ; add your code here 
    ;load array
    
    ;lea dx, var4
    ;mov ah, 9
    ;int 21h 
    
    ;mov ah, 1
    ;int 21h
    ;mov ah, 0
    ;sub ax, 30h ; e.g = '3' of hex is 33h
    ;mov di, ax ;len of array
    
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    lea dx, var2
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    mov bl, al
    
    cmp bl, '1'
    je vigenere
    cmp bl, '2'
    je rrs
    cmp bl, '3'
    je caesar
    cmp bl, '4'
    je stacks
    
vigenere:
   
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h   
    
    
    lea dx, decide     ; deciding the mode of action
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h
    
    
    cmp al, 'C'   
    je vignere_cipher:
    cmp al, 'D'   
    je vignere_decipher:
    
    
    
    vignere_cipher: 
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h
    
        lea dx, var3
        mov ah, 9
        int 21h
        
        mov cx, 2      ;initializing the secret letter array
        mov si, 0
        
        input2:
            mov ah, 1  ;input for taking 2 secret keys
            int 21h
            mov arr2[si], al  ;array for two secret keys
            inc si
            loop input2
            
            mov ah, 2
            mov dl, 0Dh
            int 21h
            mov dl, 0Ah
            int 21h
               
            mov cx,40    ; initialising the message array 
            mov si,0
            
            lea dx, var1
            mov ah, 9
            int 21h
            
        input1: 
            mov ah,1
            int 21h
            
            cmp al, '$'      ;checking if the last character is $ sign
            jne next_step
            jmp algo_end     ;stopping taking input when $sign is found
            
        next_step:    
            mov bl, al
            
            
            mov ax, si
            mov bh, 2
            div bh            ; dividing the si(position) checking if its even or odd
            
            mov arr[si], bl   ; storing the message
            
            cmp ah, 0         
            je even
            jmp odd
            
        even:             ; the even position letters gets processed
            mov dx, si
            mov si, 0       ; for not taking 0 as a char.
            mov bh, arr2[si]
            add bl, bh
            mov si, dx
            jmp next_phase
            
        odd:              ; the odd position letters gets processed
            mov dx, si
            mov si, 1
            mov bh, arr2[si]
            add bl, bh
            mov si, dx
            jmp next_phase 
             
        next_phase:
            sub bl, 115    
            mov arr3[si], bl  ;the value gets stored in array
            add si, 1 
            mov di,si      ;storing the number of input characters
            loop input1
            
        algo_end:    
            mov ah, 2
            mov dl, 0Dh
            int 21h
            mov dl, 0Ah
            int 21h
            
             
        lea dx, var5
        mov ah, 9
        int 21h             
                     
        mov cx, 40
        mov si, 0
        
        vig_view:
            mov dl, arr3[si]
            mov ah, 2
            int 21h
            inc si
            loop vig_view  
            
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h  
        
        lea dx, choose
        mov ah, 9
        int 21h       
                
        mov cx, di  ;initializing for deciphering (the number of input characters)
        mov si, 0        
                
        mov ah, 1
        int 21h
        cmp al, 'Y'   ; if user wants to see the message to be deciphered
        je decipher_text
        jmp exit2
        
           
        
        
       
        decipher_text: 
            mov bl, arr3[si]
            add bl, 115  
            mov ax, si
            mov bh, 2
            div bh   
            
            cmp ah, 0
            je even2        ;checking if the position is even or odd
            jmp odd2
                      
        even2:
            mov dx, si
            mov si, 0
            mov bh, arr2[si]
            sub bl, bh
            mov si, dx
            jmp vig_next_phase2
            
        odd2:
            mov dx, si
            mov si, 1
            mov bh, arr2[si]
            sub bl, bh
            mov si, dx
            jmp vig_next_phase2 
             
        vig_next_phase2:    
            mov arr4[si], bl
            add si, 1
            loop decipher_text              
              
            
            
            mov ah, 2
            mov dl, 0Dh
            int 21h
            mov dl, 0Ah
            int 21h  
            
            lea dx, var4
            mov ah, 9
            int 21h
            
            mov cx, 40
            mov si, 0
            
        view2:
            mov dl, arr4[si]
            mov ah, 2
            int 21h
            inc si
            loop view2 
             
        jmp exit2
        
        
    vignere_decipher:  ;only decipher the text when the user
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h
        
        lea dx, var3
        mov ah, 9
        int 21h
        
        mov cx, 2         ;initializing the secret letter array
        mov si, 0
        
        decipher_input2:
            mov ah, 1    ;input for taking 2 secret keys
            int 21h
            mov arr2[si], al  ;array for two secret keys
            inc si
            loop decipher_input2
            
            mov ah, 2
            mov dl, 0Dh
            int 21h
            mov dl, 0Ah
            int 21h
               
            mov cx,40        ;initializing the array iteration
            mov si,0
            
            lea dx, var1
            mov ah, 9
            int 21h
            
        decipher_input1:   ; taking the cipher text as input
            mov ah,1
            int 21h
            
            cmp al, '$'
            jne next_step2
            jmp algo_end2 
            
        next_step2:    
            mov bl, al
            add bl, 115
            
            mov ax, si
            mov bh, 2
            div bh
            
            mov arr[si], bl 
            
            cmp ah, 0
            je even3
            jmp odd3
            
        even3:    
        
            mov dx, si
            mov si, 0
            mov bh, arr2[si]   ;accessing the 1st secret character
            sub bl, bh
            mov si, dx
            jmp vig_next_phase3
            
        odd3:
            mov dx, si
            mov si, 1
            mov bh, arr2[si]   ;accessing the 2nd secret character
            sub bl, bh
            mov si, dx
            jmp vig_next_phase3 
             
        vig_next_phase3:
           
            mov arr3[si], bl
            add si, 1 
            mov di,si
            loop decipher_input1
            
        algo_end2:    
            mov ah, 2
            mov dl, 0Dh
            int 21h
            mov dl, 0Ah
            int 21h 
                     
        lea dx, var5
        mov ah, 9
        int 21h 
         
                     
        mov cx, 40          ;initializing the array iteration
        mov si, 0
        
        view3:                 ;viewing the deciphered text
            mov dl, arr3[si]
            mov ah, 2
            int 21h
            inc si
            loop view3  
       
       jmp exit2
       

stacks:
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    lea dx, decide   ; to cipher or decipher
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h
    
    
    cmp al, 'C'   
    je cipher9
    
    cmp al, 'D'   
    je decipher9

    
    cipher9:
        mov cx, 40  ;random limit
        mov si, 0    
    
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h
    
        lea dx, var1  
        mov ah, 9
        int 21h
        
    push1:
        mov ah, 1     ;taking input
        int 21h
        cmp al, '$'
        je pop1_init  ;instruction to go to pop
        jmp keep_up   ; push the input in stack
        
        keep_up:
            push ax
            inc si      ; forward indexing that will be used as range later
            loop push1
            
    pop1_init:
        mov bp,1    ; condition that we are doing cipher bp=1
        mov cx, si
        mov si, 0   ; restart indexing for new loop
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h
        
        pop1:
            pop bx     ;popping value and storing it on bl
            mov dl, bl
            add dl, 10h  ; adding 10h with each val
            mov ah, 2
            int 21h
            mov arr[si], dl  ; storing the value in array
            inc si
            loop pop1
            cmp bp, 1   ; condition check
            je choice2
            jmp exit2
            
            choice2:       ; choice for deciphering what we ciphered before
                mov ah, 2
                mov dl, 0Dh
                int 21h
                mov dl, 0Ah
                int 21h
        
                lea dx, choose
                mov ah, 9
                int 21h
        
                mov ah, 1
                int 21h
                cmp al, 'Y'   ; if user wants to see the message to be deciphered
                je decipher9  ; goes to decipher func
                jmp exit2
                
                ;do_decipher2:
                    ;loop decipher9
                    ;jmp exit2
                
            
    decipher9:
        cmp bp, 1
        je ciphered       ;if we have the generated a cipher text  
        jmp not_ciphered  ;if not
        
        ciphered:
            mov cx, si       ;si that we last pushed in keep_up funtion
            mov si, 0
            loop_push:           ; loop for pushing the values that was stored reversely in array
                mov ax, 0
                mov al, arr[si]
                push ax
                inc si
                loop loop_push
                jmp pop2_init
        
    not_ciphered:
        mov cx, 40  ;random limit
        mov si, 0    
    
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h
    
        lea dx, var1
        mov ah, 9
        int 21h
        
    push2:
        mov ah, 1
        int 21h
        cmp al, '$'
        je pop2_init
        jmp keep_up2
        
        keep_up2:
            push ax
            inc si
            loop push2
            
        
    pop2_init:
        mov bp,0     ;initializing to its previous state 
        mov cx, si
        mov si, 0
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h
        
        pop2:
            pop bx     ;the popped value present in bl
            mov dl, bl
            sub dl, 10h
            mov ah, 2
            int 21h
            inc si
            loop pop2
            jmp exit2
        
    
rrs:
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    lea dx, decide
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h
    
    
    cmp al, 'C'   
    je cipher
    cmp al, 'D'   
    je decipher
    
cipher:

    mov cx, 40  ;random limit
    mov si, 0    
    
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    lea dx, var1
    mov ah, 9
    int 21h
    jmp next_phase2
    
   
next_phase2:
    mov ah, 1
    int 21h
    
    cmp al, '$'
    jne inserting1
    jmp formula_part1
    
inserting1:
    mov arr[si], al  ; inserting original text in an array to traverse
    inc si
    loop next_phase2
    
     
formula_part1:
    mov di, si ; here di is the number of texts typed
    mov cx, 40
    mov si, 0
    
formula_loopC:            
    mov ax, 0
    mov al, arr[si]     
    inc al       ; A/a as the first position of respective alphabatical order
    sub al, 65   ; since A(65)-A = 0 so 
            ;for multiplication purpose and 
            ;defining A as first letter 
            ;we are subtracting by 65
            ;the value of v 
            ;(1st, 2nd, 3rd letter... the ASCII serial from "A")
            ;stored in ax for multiplication 
    
    mov bx, 0
    mov bx, di  ; t = len of array
    mul bl      ; here, s = vt where, v==al; t==bl
    
    dec al     ; since indexing starting 
               ;from 0 we are substracting find the 
               ;actual alphabetical/ascii code 
               ;sequencial position
    add al, 65
    
    mov arr3[si], al
    inc si  ;forward indexing
    
    loop formula_loopC
    
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h 
    
    mov cx, di
    mov si, 0
    mov bp, 1 ; this indicates that we ciphered a text
    jmp view
    
decipher:

    mov cx, 40
    mov si, 0    
    
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    lea dx, var1
    mov ah, 9
    int 21h
    jmp next_phase3
    
   
next_phase3:
    mov ah, 1
    int 21h
    
    cmp al, '$'
    jne inserting2
    jmp formula_part2
    
inserting2:
    mov arr[si], al ; inserting original text in an array to traverse
    inc si     ;forward indexing
    loop next_phase3
    
     
formula_part2:
    mov di, si
    mov cx, 40
    mov si, 0
    
formula_loopD:
    mov al, arr[si]
    inc al
    sub al, 65 
    mov ah, 0  ; cuz we have ah=1 cuz of input instruction
    
    mov bx, 0
    mov bx, di
    div bl   ; v = s/t
    
    dec al ; to find the right ASCII val
    add al, 65
    
    mov arr3[si], al ;storing the value of v (the original text)
    inc si           
    
    loop formula_loopD
    
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    mov cx, di   ; the correct message length 
    mov si, 0
    mov bp, 0
    jmp view
    
view:
    mov dl, arr3[si]
    mov ah, 2
    int 21h
    inc si
    loop view
    cmp bp, 1 ; checking if we ciphered first
    je choice
    jmp exit2
    
    choice:
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0Ah
        int 21h
        
        lea dx, choose
        mov ah, 9
        int 21h
        
        mov ah, 1
        int 21h
        cmp al, 'Y'   ; if user wants to see the message to be deciphered
        je do_decipher
        jmp exit2
        
        do_decipher:
            mov cx, di  ;last pushed in formula_part1
            mov si, 0
            mov ah, 0
            
            decipher_loop:
                mov al, arr3[si] ;previously stored (an alt for deciphering if inputs cant be typed on emulator)
                mov arr[si], al
                inc si
                loop decipher_loop
                jmp formula_part2
                
caesar:
    mov ah, 2                  
    mov dl, 0Dh                
    int 21h                    
    mov dl, 0Ah                
    int 21h

    ; Get user's choice (Cipher or Decipher)
    lea dx, decide             ; Load the address of the 'decide' string into DX
    mov ah, 9                  
    int 21h                    

    mov ah, 1                  
    int 21h                    
    mov pick, al               ; Store the user's choice in the 'pick' variable

    ; load array
    mov cx, 40                  ; Set CX to 5 (number of characters to read)
    mov si, 0                  ; Set SI to 0 (index for the array)
              
    mov ah, 2                 
    mov dl, 0Dh              
    int 21h                    
    mov dl, 0Ah                
    int 21h      
              
    lea dx, var1               ; Load the address of the 'var1' string into DX
    mov ah, 9                  
    int 21h                    

    L1:
    mov ah, 1                 
    int 21h                    
           
    cmp al, '$'
    jne next
    jmp output       
    
    next:
    mov bl, al                 
      
    ; Shift the character based on user's choice
    cmp pick, 'C'              ; Compare the user's choice with 'C' (Cipher)
    je cipher2                  ; Jump to 'cipher' if the user chose Cipher
    cmp pick, 'D'              ; Compare the user's choice with 'D' (Decipher)
    je decipher2                ; Jump to 'decipher' if the user chose Decipher

    cipher2:
        add bl, 3               ; Shift the character by 3 bits forward for Cipher
        jmp store_character     ; Jump to 'store_character' to store the modified character

    decipher2:
        sub bl, 3               ; Shift the character by 3 bits backward for Decipher
        jmp store_character     ; Jump to 'store_character' to store the modified character

    store_character:
        mov arr[si], bl         ; Store the modified character in the array
        inc si                  ; Increment SI to move to the next position in the array
        mov di, si
        loop L1                 ; Repeat the loop until CX becomes zero

    ; Output a newline
    output:
    mov ah, 2                  
    mov dl, 0Dh                
    int 21h                    
    mov dl, 0Ah                
    int 21h                   

    ; Output the modified string
    
    mov cx, di                  ; Set CX to 40 (number of characters to print)
    mov si, 0                  ; Set SI to 0 (index for the array)

    L2:
    mov dl, arr[si]            
    mov ah, 2                  
    int 21h                    
    inc si                     ; Increment SI to move to the next position in the array
    loop L2                    ; Repeat the loop until CX becomes zero    
         
    
exit2:
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.




