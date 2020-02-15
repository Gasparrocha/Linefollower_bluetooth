
_interrupt:

;Projeto.c,67 :: 		void interrupt(){
;Projeto.c,68 :: 		if(INTCON.TMR0IF==1){       //quando ha overflow do timer 0.
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;Projeto.c,70 :: 		TMR0H = 0xFC;            // 64536 high bits
	MOVLW       252
	MOVWF       TMR0H+0 
;Projeto.c,71 :: 		TMR0L = 0x18;            // 64536 low bits
	MOVLW       24
	MOVWF       TMR0L+0 
;Projeto.c,72 :: 		INTCON.TMR0IF = 0;       // Limpa o flag de estouro do timer0
	BCF         INTCON+0, 2 
;Projeto.c,73 :: 		milis++;
	MOVLW       1
	ADDWF       _milis+0, 1 
	MOVLW       0
	ADDWFC      _milis+1, 1 
	ADDWFC      _milis+2, 1 
	ADDWFC      _milis+3, 1 
;Projeto.c,74 :: 		}
L_interrupt0:
;Projeto.c,75 :: 		}
L_end_interrupt:
L__interrupt97:
	RETFIE      1
; end of _interrupt

_main:

;Projeto.c,77 :: 		void main()
;Projeto.c,80 :: 		T0CON.TMR0ON = 1;        // Liga timer0
	BSF         T0CON+0, 7 
;Projeto.c,81 :: 		T0CON.T08BIT = 0;        // Define contagem no modo 16 bits.
	BCF         T0CON+0, 6 
;Projeto.c,82 :: 		T0CON.T0CS = 0;          // Timer0 operando como temporizador.
	BCF         T0CON+0, 5 
;Projeto.c,83 :: 		T0CON.T0SE = 0;          // Contagem borda de decida
	BCF         T0CON+0, 4 
;Projeto.c,84 :: 		T0CON.PSA = 0;           // Prescaler ativado.
	BCF         T0CON+0, 3 
;Projeto.c,85 :: 		T0CON.T0PS2 = 0;         // Define prescaler 1:2
	BCF         T0CON+0, 2 
;Projeto.c,86 :: 		T0CON.T0PS1 = 0;         // Define prescaler 1:2
	BCF         T0CON+0, 1 
;Projeto.c,87 :: 		T0CON.T0PS0 = 0;         // Define prescaler 1:2
	BCF         T0CON+0, 0 
;Projeto.c,89 :: 		TMR0H = 0xFC;            // 64536 high bits
	MOVLW       252
	MOVWF       TMR0H+0 
;Projeto.c,90 :: 		TMR0L = 0x18;            // 64536 low bits
	MOVLW       24
	MOVWF       TMR0L+0 
;Projeto.c,92 :: 		INTCON.TMR0IE = 1;       // Habilita interrupcao do timer0.
	BSF         INTCON+0, 5 
;Projeto.c,93 :: 		INTCON.TMR0IF = 0;       // Apaga flag de estouro do timer0
	BCF         INTCON+0, 2 
;Projeto.c,94 :: 		INTCON.GIE = 1;          // Habilita as interrupcoes nao-mascaradas.
	BSF         INTCON+0, 7 
;Projeto.c,95 :: 		INTCON.PEIE = 1;         // Habilita as interrupcoes dos perifericos.
	BSF         INTCON+0, 6 
;Projeto.c,99 :: 		ADCON1=0x0E;        //Configura pinos do PORTB como digitais e RA0 (PORTA) como analogico
	MOVLW       14
	MOVWF       ADCON1+0 
;Projeto.c,100 :: 		Lcd_Init();         //INICIALIZA DISPLAY LCD
	CALL        _Lcd_Init+0, 0
;Projeto.c,101 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);//Apaga cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Projeto.c,102 :: 		Lcd_Cmd(_LCD_CLEAR);//ENVIA O COMANDO DE LIMPAR TELA PARA O DISPLAY LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Projeto.c,105 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Projeto.c,106 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
	NOP
;Projeto.c,109 :: 		TRISB.RB0=1;
	BSF         TRISB+0, 0 
;Projeto.c,110 :: 		TRISB.RB1=1;
	BSF         TRISB+0, 1 
;Projeto.c,111 :: 		TRISB.RB2=1;
	BSF         TRISB+0, 2 
;Projeto.c,112 :: 		TRISB.RB3=1;
	BSF         TRISB+0, 3 
;Projeto.c,113 :: 		TRISB.RB4=1;
	BSF         TRISB+0, 4 
;Projeto.c,114 :: 		uc_RB0=0;
	CLRF        _uc_RB0+0 
;Projeto.c,115 :: 		uc_RB1=0;
	CLRF        _uc_RB1+0 
;Projeto.c,116 :: 		uc_RB2=0;
	CLRF        _uc_RB2+0 
;Projeto.c,117 :: 		uc_RB3=0;
	CLRF        _uc_RB3+0 
;Projeto.c,118 :: 		uc_RB4=0;
	CLRF        _uc_RB4+0 
;Projeto.c,120 :: 		ki=0;
	CLRF        _ki+0 
	CLRF        _ki+1 
;Projeto.c,121 :: 		kp=0;
	CLRF        _kp+0 
	CLRF        _kp+1 
;Projeto.c,122 :: 		kd=0;
	CLRF        _kd+0 
	CLRF        _kd+1 
;Projeto.c,123 :: 		prev=0;
	CLRF        _prev+0 
	CLRF        _prev+1 
;Projeto.c,124 :: 		speed=0;
	CLRF        _speed+0 
	CLRF        _speed+1 
;Projeto.c,125 :: 		param=0;
	CLRF        _param+0 
	CLRF        _param+1 
;Projeto.c,126 :: 		milis=0;
	CLRF        _milis+0 
	CLRF        _milis+1 
	CLRF        _milis+2 
	CLRF        _milis+3 
;Projeto.c,127 :: 		go_stop=0;
	CLRF        _go_stop+0 
	CLRF        _go_stop+1 
;Projeto.c,128 :: 		cmd_state=0;
	CLRF        _cmd_state+0 
;Projeto.c,129 :: 		miliseconds=0;
	CLRF        _miliseconds+0 
	CLRF        _miliseconds+1 
	CLRF        _miliseconds+2 
	CLRF        _miliseconds+3 
;Projeto.c,130 :: 		input_number=0;
	CLRF        _input_number+0 
	CLRF        _input_number+1 
;Projeto.c,132 :: 		lcd_Out(1,1,"Speed:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Projeto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Projeto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,133 :: 		lcd_Out(2,1,"Prev:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Projeto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Projeto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,134 :: 		IntToStr(speed,half_line);
	MOVF        _speed+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _speed+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _half_line+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_half_line+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Projeto.c,135 :: 		lcd_Out(2,11,half_line);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _half_line+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_half_line+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,136 :: 		while(1)
L_main2:
;Projeto.c,138 :: 		if(UART1_Data_Ready()){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;Projeto.c,139 :: 		UART1_Read_Text(serial_input," ",16);
	MOVLW       _serial_input+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_serial_input+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr3_Projeto+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr3_Projeto+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       16
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;Projeto.c,141 :: 		if(serial_input[0]=='L'){
	MOVF        _serial_input+0, 0 
	XORLW       76
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;Projeto.c,142 :: 		miliseconds=milis;
	MOVF        _milis+0, 0 
	MOVWF       _miliseconds+0 
	MOVF        _milis+1, 0 
	MOVWF       _miliseconds+1 
	MOVF        _milis+2, 0 
	MOVWF       _miliseconds+2 
	MOVF        _milis+3, 0 
	MOVWF       _miliseconds+3 
;Projeto.c,143 :: 		milis=0;
	CLRF        _milis+0 
	CLRF        _milis+1 
	CLRF        _milis+2 
	CLRF        _milis+3 
;Projeto.c,144 :: 		setLapTime();
	CALL        _setLapTime+0, 0
;Projeto.c,145 :: 		lcd_Out(2,1,full_line);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _full_line+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_full_line+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,146 :: 		}
L_main5:
;Projeto.c,147 :: 		}
L_main4:
;Projeto.c,148 :: 		if((PORTB.RB0==0)&&(uc_RB0==0)){
	BTFSC       PORTB+0, 0 
	GOTO        L_main8
	MOVF        _uc_RB0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
L__main95:
;Projeto.c,149 :: 		uc_RB0=1;
	MOVLW       1
	MOVWF       _uc_RB0+0 
;Projeto.c,150 :: 		}
L_main8:
;Projeto.c,151 :: 		if((PORTB.RB0==1)&&(uc_RB0==1)){
	BTFSS       PORTB+0, 0 
	GOTO        L_main11
	MOVF        _uc_RB0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
L__main94:
;Projeto.c,152 :: 		uc_RB0=0;
	CLRF        _uc_RB0+0 
;Projeto.c,153 :: 		param=param-input_number;
	MOVF        _input_number+0, 0 
	SUBWF       _param+0, 1 
	MOVF        _input_number+1, 0 
	SUBWFB      _param+1, 1 
;Projeto.c,154 :: 		input_number=(input_number+1)%10;
	MOVLW       1
	ADDWF       _input_number+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _input_number+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _input_number+0 
	MOVF        R1, 0 
	MOVWF       _input_number+1 
;Projeto.c,155 :: 		param=param+input_number;
	MOVF        R0, 0 
	ADDWF       _param+0, 1 
	MOVF        R1, 0 
	ADDWFC      _param+1, 1 
;Projeto.c,156 :: 		}
L_main11:
;Projeto.c,157 :: 		if((PORTB.RB1==0)&&(uc_RB1==0)){
	BTFSC       PORTB+0, 1 
	GOTO        L_main14
	MOVF        _uc_RB1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
L__main93:
;Projeto.c,158 :: 		uc_RB1=1;
	MOVLW       1
	MOVWF       _uc_RB1+0 
;Projeto.c,159 :: 		}
L_main14:
;Projeto.c,160 :: 		if((PORTB.RB1==1)&&(uc_RB1==1)){
	BTFSS       PORTB+0, 1 
	GOTO        L_main17
	MOVF        _uc_RB1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
L__main92:
;Projeto.c,161 :: 		uc_RB1=0;
	CLRF        _uc_RB1+0 
;Projeto.c,162 :: 		param=param*10;
	MOVF        _param+0, 0 
	MOVWF       R0 
	MOVF        _param+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _param+0 
	MOVF        R1, 0 
	MOVWF       _param+1 
;Projeto.c,163 :: 		input_number=0;
	CLRF        _input_number+0 
	CLRF        _input_number+1 
;Projeto.c,164 :: 		}
L_main17:
;Projeto.c,165 :: 		if((PORTB.RB2==0)&&(uc_RB2==0)){
	BTFSC       PORTB+0, 2 
	GOTO        L_main20
	MOVF        _uc_RB2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
L__main91:
;Projeto.c,166 :: 		uc_RB2=1;
	MOVLW       1
	MOVWF       _uc_RB2+0 
;Projeto.c,167 :: 		}
L_main20:
;Projeto.c,168 :: 		if((PORTB.RB2==1)&&(uc_RB2==1)){
	BTFSS       PORTB+0, 2 
	GOTO        L_main23
	MOVF        _uc_RB2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
L__main90:
;Projeto.c,169 :: 		uc_RB2=0;
	CLRF        _uc_RB2+0 
;Projeto.c,170 :: 		param=0;
	CLRF        _param+0 
	CLRF        _param+1 
;Projeto.c,171 :: 		input_number=0;
	CLRF        _input_number+0 
	CLRF        _input_number+1 
;Projeto.c,172 :: 		cmd_state=(cmd_state+1)%4;
	MOVF        _cmd_state+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _cmd_state+0 
;Projeto.c,173 :: 		switch(cmd_state){
	GOTO        L_main24
;Projeto.c,174 :: 		case 0:lcd_Out(1,1,"Speed:");
L_main26:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Projeto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Projeto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,175 :: 		prev=speed;
	MOVF        _speed+0, 0 
	MOVWF       _prev+0 
	MOVF        _speed+1, 0 
	MOVWF       _prev+1 
;Projeto.c,176 :: 		break;
	GOTO        L_main25
;Projeto.c,177 :: 		case 1:lcd_Out(1,1,"Kp:   ");
L_main27:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Projeto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Projeto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,178 :: 		prev=kp;
	MOVF        _kp+0, 0 
	MOVWF       _prev+0 
	MOVF        _kp+1, 0 
	MOVWF       _prev+1 
;Projeto.c,179 :: 		break;
	GOTO        L_main25
;Projeto.c,180 :: 		case 2:lcd_Out(1,1,"Ki:   ");
L_main28:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Projeto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Projeto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,181 :: 		prev=ki;
	MOVF        _ki+0, 0 
	MOVWF       _prev+0 
	MOVF        _ki+1, 0 
	MOVWF       _prev+1 
;Projeto.c,182 :: 		break;
	GOTO        L_main25
;Projeto.c,183 :: 		case 3:lcd_Out(1,1,"Kd:   ");
L_main29:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Projeto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Projeto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,184 :: 		prev=kd;
	MOVF        _kd+0, 0 
	MOVWF       _prev+0 
	MOVF        _kd+1, 0 
	MOVWF       _prev+1 
;Projeto.c,185 :: 		break;
	GOTO        L_main25
;Projeto.c,186 :: 		default:break;
L_main30:
	GOTO        L_main25
;Projeto.c,187 :: 		}
L_main24:
	MOVF        _cmd_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
	MOVF        _cmd_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
	MOVF        _cmd_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
	MOVF        _cmd_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main29
	GOTO        L_main30
L_main25:
;Projeto.c,188 :: 		setPreValue();
	CALL        _setPreValue+0, 0
;Projeto.c,189 :: 		}
L_main23:
;Projeto.c,190 :: 		if((PORTB.RB3==0)&&(uc_RB3==0)){
	BTFSC       PORTB+0, 3 
	GOTO        L_main33
	MOVF        _uc_RB3+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
L__main89:
;Projeto.c,191 :: 		uc_RB3=1;
	MOVLW       1
	MOVWF       _uc_RB3+0 
;Projeto.c,192 :: 		}
L_main33:
;Projeto.c,193 :: 		if((PORTB.RB3==1)&&(uc_RB3==1)){
	BTFSS       PORTB+0, 3 
	GOTO        L_main36
	MOVF        _uc_RB3+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
L__main88:
;Projeto.c,194 :: 		uc_RB3=0;
	CLRF        _uc_RB3+0 
;Projeto.c,195 :: 		setCMD();
	CALL        _setCMD+0, 0
;Projeto.c,196 :: 		UART1_Write_Text(serial_output);
	MOVLW       _serial_output+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_serial_output+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Projeto.c,197 :: 		switch(cmd_state){
	GOTO        L_main37
;Projeto.c,198 :: 		case 0:speed=param;break;
L_main39:
	MOVF        _param+0, 0 
	MOVWF       _speed+0 
	MOVF        _param+1, 0 
	MOVWF       _speed+1 
	GOTO        L_main38
;Projeto.c,199 :: 		case 1:kp=param;break;
L_main40:
	MOVF        _param+0, 0 
	MOVWF       _kp+0 
	MOVF        _param+1, 0 
	MOVWF       _kp+1 
	GOTO        L_main38
;Projeto.c,200 :: 		case 2:ki=param;break;
L_main41:
	MOVF        _param+0, 0 
	MOVWF       _ki+0 
	MOVF        _param+1, 0 
	MOVWF       _ki+1 
	GOTO        L_main38
;Projeto.c,201 :: 		case 3:kd=param;break;
L_main42:
	MOVF        _param+0, 0 
	MOVWF       _kd+0 
	MOVF        _param+1, 0 
	MOVWF       _kd+1 
	GOTO        L_main38
;Projeto.c,202 :: 		default:break;
L_main43:
	GOTO        L_main38
;Projeto.c,203 :: 		}
L_main37:
	MOVF        _cmd_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main39
	MOVF        _cmd_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main40
	MOVF        _cmd_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main41
	MOVF        _cmd_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main42
	GOTO        L_main43
L_main38:
;Projeto.c,204 :: 		prev=param;
	MOVF        _param+0, 0 
	MOVWF       _prev+0 
	MOVF        _param+1, 0 
	MOVWF       _prev+1 
;Projeto.c,205 :: 		setPreValue();
	CALL        _setPreValue+0, 0
;Projeto.c,206 :: 		}
L_main36:
;Projeto.c,207 :: 		if((PORTB.RB4==0)&&(uc_RB4==0)){
	BTFSC       PORTB+0, 4 
	GOTO        L_main46
	MOVF        _uc_RB4+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main46
L__main87:
;Projeto.c,208 :: 		uc_RB4=1;
	MOVLW       1
	MOVWF       _uc_RB4+0 
;Projeto.c,209 :: 		}
L_main46:
;Projeto.c,210 :: 		if((PORTB.RB4==1)&&(uc_RB4==1)){
	BTFSS       PORTB+0, 4 
	GOTO        L_main49
	MOVF        _uc_RB4+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
L__main86:
;Projeto.c,211 :: 		uc_RB4=0;
	CLRF        _uc_RB4+0 
;Projeto.c,212 :: 		if(go_stop){
	MOVF        _go_stop+0, 0 
	IORWF       _go_stop+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main50
;Projeto.c,213 :: 		UART1_Write_Text("s");
	MOVLW       ?lstr8_Projeto+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_Projeto+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Projeto.c,214 :: 		go_stop=0;
	CLRF        _go_stop+0 
	CLRF        _go_stop+1 
;Projeto.c,215 :: 		}else{
	GOTO        L_main51
L_main50:
;Projeto.c,216 :: 		UART1_Write_Text("g");
	MOVLW       ?lstr9_Projeto+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Projeto+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Projeto.c,217 :: 		go_stop=1;
	MOVLW       1
	MOVWF       _go_stop+0 
	MOVLW       0
	MOVWF       _go_stop+1 
;Projeto.c,218 :: 		}
L_main51:
;Projeto.c,219 :: 		}
L_main49:
;Projeto.c,220 :: 		IntToStr(param,half_line);
	MOVF        _param+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _param+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _half_line+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_half_line+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Projeto.c,221 :: 		lcd_Out(1,11,half_line);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _half_line+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_half_line+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,223 :: 		}
	GOTO        L_main2
;Projeto.c,224 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_blank:

;Projeto.c,226 :: 		void blank(char * word,int len){
;Projeto.c,228 :: 		for(i=0; i<len;i++){
	CLRF        R1 
	CLRF        R2 
L_blank52:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_blank_len+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__blank100
	MOVF        FARG_blank_len+0, 0 
	SUBWF       R1, 0 
L__blank100:
	BTFSC       STATUS+0, 0 
	GOTO        L_blank53
;Projeto.c,229 :: 		word[i]=' ';
	MOVF        R1, 0 
	ADDWF       FARG_blank_word+0, 0 
	MOVWF       FSR1 
	MOVF        R2, 0 
	ADDWFC      FARG_blank_word+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;Projeto.c,228 :: 		for(i=0; i<len;i++){
	INFSNZ      R1, 1 
	INCF        R2, 1 
;Projeto.c,230 :: 		}
	GOTO        L_blank52
L_blank53:
;Projeto.c,231 :: 		}
L_end_blank:
	RETURN      0
; end of _blank

_setCMD:

;Projeto.c,233 :: 		void setCMD(){
;Projeto.c,236 :: 		blank(&serial_output,16);
	MOVLW       _serial_output+0
	MOVWF       FARG_blank_word+0 
	MOVLW       hi_addr(_serial_output+0)
	MOVWF       FARG_blank_word+1 
	MOVLW       16
	MOVWF       FARG_blank_len+0 
	MOVLW       0
	MOVWF       FARG_blank_len+1 
	CALL        _blank+0, 0
;Projeto.c,237 :: 		IntToStr(param,value);
	MOVF        _param+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _param+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       setCMD_value_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(setCMD_value_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Projeto.c,238 :: 		switch(cmd_state){
	GOTO        L_setCMD55
;Projeto.c,239 :: 		case 0:serial_output[0]='m';
L_setCMD57:
	MOVLW       109
	MOVWF       _serial_output+0 
;Projeto.c,240 :: 		serial_output[1]='t';
	MOVLW       116
	MOVWF       _serial_output+1 
;Projeto.c,241 :: 		break;
	GOTO        L_setCMD56
;Projeto.c,242 :: 		case 1:serial_output[0]='k';
L_setCMD58:
	MOVLW       107
	MOVWF       _serial_output+0 
;Projeto.c,243 :: 		serial_output[1]='p';
	MOVLW       112
	MOVWF       _serial_output+1 
;Projeto.c,244 :: 		break;
	GOTO        L_setCMD56
;Projeto.c,245 :: 		case 2:serial_output[0]='k';
L_setCMD59:
	MOVLW       107
	MOVWF       _serial_output+0 
;Projeto.c,246 :: 		serial_output[1]='i';
	MOVLW       105
	MOVWF       _serial_output+1 
;Projeto.c,247 :: 		break;
	GOTO        L_setCMD56
;Projeto.c,248 :: 		case 3:serial_output[0]='k';
L_setCMD60:
	MOVLW       107
	MOVWF       _serial_output+0 
;Projeto.c,249 :: 		serial_output[1]='d';
	MOVLW       100
	MOVWF       _serial_output+1 
;Projeto.c,250 :: 		break;
	GOTO        L_setCMD56
;Projeto.c,251 :: 		default:break;
L_setCMD61:
	GOTO        L_setCMD56
;Projeto.c,252 :: 		}
L_setCMD55:
	MOVF        _cmd_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_setCMD57
	MOVF        _cmd_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_setCMD58
	MOVF        _cmd_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_setCMD59
	MOVF        _cmd_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_setCMD60
	GOTO        L_setCMD61
L_setCMD56:
;Projeto.c,253 :: 		for(index=0;index<8;index++){
	CLRF        setCMD_index_L0+0 
	CLRF        setCMD_index_L0+1 
L_setCMD62:
	MOVLW       128
	XORWF       setCMD_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setCMD102
	MOVLW       8
	SUBWF       setCMD_index_L0+0, 0 
L__setCMD102:
	BTFSC       STATUS+0, 0 
	GOTO        L_setCMD63
;Projeto.c,254 :: 		if(value[index]!=' ')break;
	MOVLW       setCMD_value_L0+0
	ADDWF       setCMD_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(setCMD_value_L0+0)
	ADDWFC      setCMD_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setCMD65
	GOTO        L_setCMD63
L_setCMD65:
;Projeto.c,253 :: 		for(index=0;index<8;index++){
	INFSNZ      setCMD_index_L0+0, 1 
	INCF        setCMD_index_L0+1, 1 
;Projeto.c,255 :: 		}
	GOTO        L_setCMD62
L_setCMD63:
;Projeto.c,256 :: 		for(index,index2=2;index<8;index++,index2++){
	MOVLW       2
	MOVWF       setCMD_index2_L0+0 
	MOVLW       0
	MOVWF       setCMD_index2_L0+1 
L_setCMD66:
	MOVLW       128
	XORWF       setCMD_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setCMD103
	MOVLW       8
	SUBWF       setCMD_index_L0+0, 0 
L__setCMD103:
	BTFSC       STATUS+0, 0 
	GOTO        L_setCMD67
;Projeto.c,257 :: 		if(value[index]=='\n')break;
	MOVLW       setCMD_value_L0+0
	ADDWF       setCMD_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(setCMD_value_L0+0)
	ADDWFC      setCMD_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_setCMD69
	GOTO        L_setCMD67
L_setCMD69:
;Projeto.c,258 :: 		serial_output[index2]=value[index];
	MOVLW       _serial_output+0
	ADDWF       setCMD_index2_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_serial_output+0)
	ADDWFC      setCMD_index2_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       setCMD_value_L0+0
	ADDWF       setCMD_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(setCMD_value_L0+0)
	ADDWFC      setCMD_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Projeto.c,256 :: 		for(index,index2=2;index<8;index++,index2++){
	INFSNZ      setCMD_index_L0+0, 1 
	INCF        setCMD_index_L0+1, 1 
	INFSNZ      setCMD_index2_L0+0, 1 
	INCF        setCMD_index2_L0+1, 1 
;Projeto.c,259 :: 		}
	GOTO        L_setCMD66
L_setCMD67:
;Projeto.c,260 :: 		}
L_end_setCMD:
	RETURN      0
; end of _setCMD

_setPreValue:

;Projeto.c,262 :: 		void setPreValue(){
;Projeto.c,263 :: 		lcd_Out(2,1,"Prev:           ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_Projeto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_Projeto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,264 :: 		IntToStr(prev,half_line);
	MOVF        _prev+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _prev+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _half_line+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_half_line+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Projeto.c,265 :: 		lcd_Out(2,11,half_line);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _half_line+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_half_line+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Projeto.c,266 :: 		}
L_end_setPreValue:
	RETURN      0
; end of _setPreValue

_setLapTime:

;Projeto.c,268 :: 		void setLapTime(){
;Projeto.c,273 :: 		minutes=miliseconds/60000;
	MOVLW       96
	MOVWF       R4 
	MOVLW       234
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _miliseconds+0, 0 
	MOVWF       R0 
	MOVF        _miliseconds+1, 0 
	MOVWF       R1 
	MOVF        _miliseconds+2, 0 
	MOVWF       R2 
	MOVF        _miliseconds+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       setLapTime_minutes_L0+0 
	MOVF        R1, 0 
	MOVWF       setLapTime_minutes_L0+1 
;Projeto.c,274 :: 		miliseconds=miliseconds%60000;
	MOVLW       96
	MOVWF       R4 
	MOVLW       234
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _miliseconds+0, 0 
	MOVWF       R0 
	MOVF        _miliseconds+1, 0 
	MOVWF       R1 
	MOVF        _miliseconds+2, 0 
	MOVWF       R2 
	MOVF        _miliseconds+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       FLOC__setLapTime+0 
	MOVF        R1, 0 
	MOVWF       FLOC__setLapTime+1 
	MOVF        R2, 0 
	MOVWF       FLOC__setLapTime+2 
	MOVF        R3, 0 
	MOVWF       FLOC__setLapTime+3 
	MOVF        FLOC__setLapTime+0, 0 
	MOVWF       _miliseconds+0 
	MOVF        FLOC__setLapTime+1, 0 
	MOVWF       _miliseconds+1 
	MOVF        FLOC__setLapTime+2, 0 
	MOVWF       _miliseconds+2 
	MOVF        FLOC__setLapTime+3, 0 
	MOVWF       _miliseconds+3 
;Projeto.c,275 :: 		seconds=miliseconds/1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FLOC__setLapTime+0, 0 
	MOVWF       R0 
	MOVF        FLOC__setLapTime+1, 0 
	MOVWF       R1 
	MOVF        FLOC__setLapTime+2, 0 
	MOVWF       R2 
	MOVF        FLOC__setLapTime+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       setLapTime_seconds_L0+0 
	MOVF        R1, 0 
	MOVWF       setLapTime_seconds_L0+1 
;Projeto.c,276 :: 		miliseconds=miliseconds%1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FLOC__setLapTime+0, 0 
	MOVWF       R0 
	MOVF        FLOC__setLapTime+1, 0 
	MOVWF       R1 
	MOVF        FLOC__setLapTime+2, 0 
	MOVWF       R2 
	MOVF        FLOC__setLapTime+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _miliseconds+0 
	MOVF        R1, 0 
	MOVWF       _miliseconds+1 
	MOVF        R2, 0 
	MOVWF       _miliseconds+2 
	MOVF        R3, 0 
	MOVWF       _miliseconds+3 
;Projeto.c,278 :: 		blank(full_line,16);
	MOVLW       _full_line+0
	MOVWF       FARG_blank_word+0 
	MOVLW       hi_addr(_full_line+0)
	MOVWF       FARG_blank_word+1 
	MOVLW       16
	MOVWF       FARG_blank_len+0 
	MOVLW       0
	MOVWF       FARG_blank_len+1 
	CALL        _blank+0, 0
;Projeto.c,279 :: 		IntToStr(miliseconds,string_aux);
	MOVF        _miliseconds+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _miliseconds+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       setLapTime_string_aux_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(setLapTime_string_aux_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Projeto.c,280 :: 		full_line[15]=(string_aux[5]!=' ')?string_aux[5]:'0';
	MOVF        setLapTime_string_aux_L0+5, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setLapTime70
	MOVF        setLapTime_string_aux_L0+5, 0 
	MOVWF       ?FLOC___setLapTimeT165+0 
	GOTO        L_setLapTime71
L_setLapTime70:
	MOVLW       48
	MOVWF       ?FLOC___setLapTimeT165+0 
L_setLapTime71:
	MOVF        ?FLOC___setLapTimeT165+0, 0 
	MOVWF       _full_line+15 
;Projeto.c,281 :: 		full_line[14]=(string_aux[4]!=' ')?string_aux[4]:'0';
	MOVF        setLapTime_string_aux_L0+4, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setLapTime72
	MOVF        setLapTime_string_aux_L0+4, 0 
	MOVWF       ?FLOC___setLapTimeT170+0 
	GOTO        L_setLapTime73
L_setLapTime72:
	MOVLW       48
	MOVWF       ?FLOC___setLapTimeT170+0 
L_setLapTime73:
	MOVF        ?FLOC___setLapTimeT170+0, 0 
	MOVWF       _full_line+14 
;Projeto.c,282 :: 		full_line[13]=(string_aux[3]!=' ')?string_aux[3]:'0';
	MOVF        setLapTime_string_aux_L0+3, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setLapTime74
	MOVF        setLapTime_string_aux_L0+3, 0 
	MOVWF       ?FLOC___setLapTimeT175+0 
	GOTO        L_setLapTime75
L_setLapTime74:
	MOVLW       48
	MOVWF       ?FLOC___setLapTimeT175+0 
L_setLapTime75:
	MOVF        ?FLOC___setLapTimeT175+0, 0 
	MOVWF       _full_line+13 
;Projeto.c,283 :: 		full_line[12]=':';
	MOVLW       58
	MOVWF       _full_line+12 
;Projeto.c,284 :: 		IntToStr(seconds,string_aux);
	MOVF        setLapTime_seconds_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        setLapTime_seconds_L0+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       setLapTime_string_aux_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(setLapTime_string_aux_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Projeto.c,285 :: 		full_line[11]=(string_aux[5]!=' ')?string_aux[5]:'0';
	MOVF        setLapTime_string_aux_L0+5, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setLapTime76
	MOVF        setLapTime_string_aux_L0+5, 0 
	MOVWF       ?FLOC___setLapTimeT182+0 
	GOTO        L_setLapTime77
L_setLapTime76:
	MOVLW       48
	MOVWF       ?FLOC___setLapTimeT182+0 
L_setLapTime77:
	MOVF        ?FLOC___setLapTimeT182+0, 0 
	MOVWF       _full_line+11 
;Projeto.c,286 :: 		full_line[10]=(string_aux[4]!=' ')?string_aux[4]:'0';
	MOVF        setLapTime_string_aux_L0+4, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setLapTime78
	MOVF        setLapTime_string_aux_L0+4, 0 
	MOVWF       ?FLOC___setLapTimeT187+0 
	GOTO        L_setLapTime79
L_setLapTime78:
	MOVLW       48
	MOVWF       ?FLOC___setLapTimeT187+0 
L_setLapTime79:
	MOVF        ?FLOC___setLapTimeT187+0, 0 
	MOVWF       _full_line+10 
;Projeto.c,287 :: 		full_line[9]=':';
	MOVLW       58
	MOVWF       _full_line+9 
;Projeto.c,288 :: 		if(minutes<100){
	MOVLW       128
	XORWF       setLapTime_minutes_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setLapTime106
	MOVLW       100
	SUBWF       setLapTime_minutes_L0+0, 0 
L__setLapTime106:
	BTFSC       STATUS+0, 0 
	GOTO        L_setLapTime80
;Projeto.c,289 :: 		IntToStr(minutes,string_aux);
	MOVF        setLapTime_minutes_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        setLapTime_minutes_L0+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       setLapTime_string_aux_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(setLapTime_string_aux_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Projeto.c,290 :: 		full_line[8]=(string_aux[5]!=' ')?string_aux[5]:'0';
	MOVF        setLapTime_string_aux_L0+5, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setLapTime81
	MOVF        setLapTime_string_aux_L0+5, 0 
	MOVWF       ?FLOC___setLapTimeT195+0 
	GOTO        L_setLapTime82
L_setLapTime81:
	MOVLW       48
	MOVWF       ?FLOC___setLapTimeT195+0 
L_setLapTime82:
	MOVF        ?FLOC___setLapTimeT195+0, 0 
	MOVWF       _full_line+8 
;Projeto.c,291 :: 		full_line[7]=(string_aux[4]!=' ')?string_aux[4]:'0';
	MOVF        setLapTime_string_aux_L0+4, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_setLapTime83
	MOVF        setLapTime_string_aux_L0+4, 0 
	MOVWF       ?FLOC___setLapTimeT200+0 
	GOTO        L_setLapTime84
L_setLapTime83:
	MOVLW       48
	MOVWF       ?FLOC___setLapTimeT200+0 
L_setLapTime84:
	MOVF        ?FLOC___setLapTimeT200+0, 0 
	MOVWF       _full_line+7 
;Projeto.c,292 :: 		}else{
	GOTO        L_setLapTime85
L_setLapTime80:
;Projeto.c,293 :: 		full_line[8]='+';
	MOVLW       43
	MOVWF       _full_line+8 
;Projeto.c,294 :: 		full_line[7]='9';
	MOVLW       57
	MOVWF       _full_line+7 
;Projeto.c,295 :: 		full_line[6]='9';
	MOVLW       57
	MOVWF       _full_line+6 
;Projeto.c,296 :: 		}
L_setLapTime85:
;Projeto.c,297 :: 		full_line[0]='L';
	MOVLW       76
	MOVWF       _full_line+0 
;Projeto.c,298 :: 		full_line[1]='a';
	MOVLW       97
	MOVWF       _full_line+1 
;Projeto.c,299 :: 		full_line[2]='p';
	MOVLW       112
	MOVWF       _full_line+2 
;Projeto.c,300 :: 		}
L_end_setLapTime:
	RETURN      0
; end of _setLapTime
