DATAS SEGMENT
    BUF DB 05H
    	DB ?
    	DB 05H DUP('?')
    LIB DB 0DH,0AH,'data'  
    	DB 0DH,0AH,'name'
	    DB 0DH,0AH,'time'
	    DB 0DH,0AH,'file'
	    DB 0DH,0AH,'code'
	    DB 0DH,0AH,'path'
	    DB 0DH,0AH,'user'
        DB 0DH,0AH,'exit'
 	    DB 0DH,0AH,'quit'
	    DB 0DH,0AH,'text','$' 
	REPLACE DB 'disk'
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,ES:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV ES,AX
    LEA DX,BUF
    MOV AH,0AH
    INT 21H
    LEA SI,BUF[2]
    LEA DI,LIB[2]
    MOV BX,DI
    MOV CX,10
    L:
    CLD
    PUSH CX
    MOV CX,4
    REPZ CMPSB
    JNZ N
    POP CX
    MOV SI,BX
    LEA DI,REPLACE
    MOV CX,4
    M:
    MOV AL,[DI]
    MOV [SI],AL
    INC DI
    INC SI
    LOOP M 
    JMP EXIT
    N:
    ADD BX,6
    MOV DI,BX
    LEA SI,BUF[2]
    LOOP L
    EXIT:
    LEA DX,LIB
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
CODES ENDS
END START
