.model small
.stack 100h
.data 
    msgApresentacao db "SOMA DE 0 A 9 $" 
    msgDigite db "Digite os numeros: $"  
    msgResultado db "Resultado: $"
.code   
INICIO:
    MOV AX, @data
    MOV DS, AX 
 
    MOV BL, 0 ; inicializando BL em 0  
    MOV CL, 0 ; inicializando CL em 0

@MSG_ENTRADA:
    LEA DX, msgApresentacao ; impressao da msgApresentacao
    MOV AH, 9
    INT 21H   
    
    MOV AH, 2  ; quebra de linha
    MOV DL, 10 ;
    INT 21H    ;
    MOV DL, 13 ;
    INT 21H    ; 

    LEA DX, msgDigite ; impressao da msgEntrada
    MOV AH, 9
    INT 21H  

@INSERINDO_PILHA:    
    MOV AH, 1 ; entrada do numero
    INT 21H
    
    CMP AL, 13 ; se tecla = enter (termino da entrada), imprime a soma
    JE @IMPRESSAO
    
    SUB AL, 48 ; convertendo de ASCII para DEC para fazer a soma correctamente
      
    PUSH AX ; inserindo o numero digitado na pilha
    INC CL ; incrementando contador de numeros digitados
    JMP @INSERINDO_PILHA 
    
@SOMA:
    POP AX
    ADD BL, AL; somando valor do topo da pilha com BL 
    
    DEC CL ; decrementando contador de numeros digitados
    
    CMP CL, 0 ; comparando contador com 0
    JE @IMPRESSAO ; se CL = 0, imprimir resultado
    JMP @SOMA    ; se nao continua a somar
          
@IMPRESSAO: 
    MOV AH, 2  ; quebra de linha
    MOV DL, 10 ;
    INT 21H    ;
    MOV DL, 13 ;
    INT 21H    ; 

    LEA DX, msgResultado ; impressao da msgResultado
    MOV AH, 9
    INT 21H
    
    ADD BL, 30H ; reconvertendo de DEC para ASCII para fazer mostrar o resultado correctamente
    MOV AH, 2   ; imprimindo o resultado
    MOV DL, BL
    INT 21H
    JMP @FIM 
   
@FIM:  
    MOV AH, 4CH
    INT 21H
    END INICIO