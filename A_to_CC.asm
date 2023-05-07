DATA SEGMENT
	  BUF1 DB 0FFH
	 	   DB ?
	 	   DB 0FFH DUP('?')
	  BUF2 DB 0DH,0AH,0FDH DUP('?')   
DATA ENDS

CODE SEGMENT
	 ASSUME CS:CODE,DS:DATA
	 START:
	 MOV AX,DATA
	 MOV DS,AX
	 LEA DX,BUF1
	 MOV AH,0AH
	 INT 21H
	 MOV CX,0
	 MOV CL,BUF1[1]
	 LEA SI,BUF1[2]
	 LEA DI,BUF2[2]
	 L:
	 CMP BYTE PTR [SI],'A'
	 JNE M
	 MOV WORD PTR [DI],'CC'
	 ADD DI,2
	 INC SI
	 JMP N	 
	 M:
	 MOV AL,[SI]
	 MOV [DI],AL
	 INC DI
	 INC SI
	 N:
	 LOOP L
	 
MOV BYTE PTR [DI],'$'
	 LEA DX,BUF2
	 MOV AH,09H
	 INT 21H
	 MOV AX,4C00H
	 INT 21H
CODE ENDS
END