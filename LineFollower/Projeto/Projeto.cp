#line 1 "C:/Users/aluno/Downloads/Projeto/Projeto/Projeto.c"
#line 25 "C:/Users/aluno/Downloads/Projeto/Projeto/Projeto.c"
sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

void blank(char * word, int len);
void setCMD();
void setPreValue();
void setLapTime();

unsigned char uc_RB0;
unsigned char uc_RB1;
unsigned char uc_RB2;
unsigned char uc_RB3;
unsigned char uc_RB4;
unsigned char cmd_state;

int param;
int prev;
int go_stop;
int speed,ki,kp,kd;

unsigned int input_number;

unsigned long milis;
unsigned long miliseconds;

char half_line[8];
char full_line[16];
char serial_output[16];
char serial_input[16];

void interrupt(){
 if(INTCON.TMR0IF==1){

 TMR0H = 0xFC;
 TMR0L = 0x18;
 INTCON.TMR0IF = 0;
 milis++;
 }
}

void main()
{

 T0CON.TMR0ON = 1;
 T0CON.T08BIT = 0;
 T0CON.T0CS = 0;
 T0CON.T0SE = 0;
 T0CON.PSA = 0;
 T0CON.T0PS2 = 0;
 T0CON.T0PS1 = 0;
 T0CON.T0PS0 = 0;

 TMR0H = 0xFC;
 TMR0L = 0x18;

 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 INTCON.GIE = 1;
 INTCON.PEIE = 1;



 ADCON1=0x0E;
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);


 UART1_Init(9600);
 Delay_ms(1000);


 TRISB.RB0=1;
 TRISB.RB1=1;
 TRISB.RB2=1;
 TRISB.RB3=1;
 TRISB.RB4=1;
 uc_RB0=0;
 uc_RB1=0;
 uc_RB2=0;
 uc_RB3=0;
 uc_RB4=0;

 ki=0;
 kp=0;
 kd=0;
 prev=0;
 speed=0;
 param=0;
 milis=0;
 go_stop=0;
 cmd_state=0;
 miliseconds=0;
 input_number=0;

 lcd_Out(1,1,"Speed:");
 lcd_Out(2,1,"Prev:");
 IntToStr(speed,half_line);
 lcd_Out(2,11,half_line);
 while(1)
 {
 if(UART1_Data_Ready()){
 UART1_Read_Text(serial_input," ",16);

 if(serial_input[0]=='L'){
 miliseconds=milis;
 milis=0;
 setLapTime();
 lcd_Out(2,1,full_line);
 }
 }
 if((PORTB.RB0==0)&&(uc_RB0==0)){
 uc_RB0=1;
 }
 if((PORTB.RB0==1)&&(uc_RB0==1)){
 uc_RB0=0;
 param=param-input_number;
 input_number=(input_number+1)%10;
 param=param+input_number;
 }
 if((PORTB.RB1==0)&&(uc_RB1==0)){
 uc_RB1=1;
 }
 if((PORTB.RB1==1)&&(uc_RB1==1)){
 uc_RB1=0;
 param=param*10;
 input_number=0;
 }
 if((PORTB.RB2==0)&&(uc_RB2==0)){
 uc_RB2=1;
 }
 if((PORTB.RB2==1)&&(uc_RB2==1)){
 uc_RB2=0;
 param=0;
 input_number=0;
 cmd_state=(cmd_state+1)%4;
 switch(cmd_state){
 case 0:lcd_Out(1,1,"Speed:");
 prev=speed;
 break;
 case 1:lcd_Out(1,1,"Kp:   ");
 prev=kp;
 break;
 case 2:lcd_Out(1,1,"Ki:   ");
 prev=ki;
 break;
 case 3:lcd_Out(1,1,"Kd:   ");
 prev=kd;
 break;
 default:break;
 }
 setPreValue();
 }
 if((PORTB.RB3==0)&&(uc_RB3==0)){
 uc_RB3=1;
 }
 if((PORTB.RB3==1)&&(uc_RB3==1)){
 uc_RB3=0;
 setCMD();
 UART1_Write_Text(serial_output);
 switch(cmd_state){
 case 0:speed=param;break;
 case 1:kp=param;break;
 case 2:ki=param;break;
 case 3:kd=param;break;
 default:break;
 }
 prev=param;
 setPreValue();
 }
 if((PORTB.RB4==0)&&(uc_RB4==0)){
 uc_RB4=1;
 }
 if((PORTB.RB4==1)&&(uc_RB4==1)){
 uc_RB4=0;
 if(go_stop){
 UART1_Write_Text("s");
 go_stop=0;
 }else{
 UART1_Write_Text("g");
 go_stop=1;
 }
 }
 IntToStr(param,half_line);
 lcd_Out(1,11,half_line);

 }
}

void blank(char * word,int len){
 int i;
 for(i=0; i<len;i++){
 word[i]=' ';
 }
}

void setCMD(){
 char value[8];
 int index,index2;
 blank(&serial_output,16);
 IntToStr(param,value);
 switch(cmd_state){
 case 0:serial_output[0]='m';
 serial_output[1]='t';
 break;
 case 1:serial_output[0]='k';
 serial_output[1]='p';
 break;
 case 2:serial_output[0]='k';
 serial_output[1]='i';
 break;
 case 3:serial_output[0]='k';
 serial_output[1]='d';
 break;
 default:break;
 }
 for(index=0;index<8;index++){
 if(value[index]!=' ')break;
 }
 for(index,index2=2;index<8;index++,index2++){
 if(value[index]=='\n')break;
 serial_output[index2]=value[index];
 }
}

void setPreValue(){
 lcd_Out(2,1,"Prev:           ");
 IntToStr(prev,half_line);
 lcd_Out(2,11,half_line);
}

void setLapTime(){
 int seconds;
 int minutes;
 char string_aux[7];

 minutes=miliseconds/60000;
 miliseconds=miliseconds%60000;
 seconds=miliseconds/1000;
 miliseconds=miliseconds%1000;

 blank(full_line,16);
 IntToStr(miliseconds,string_aux);
 full_line[15]=(string_aux[5]!=' ')?string_aux[5]:'0';
 full_line[14]=(string_aux[4]!=' ')?string_aux[4]:'0';
 full_line[13]=(string_aux[3]!=' ')?string_aux[3]:'0';
 full_line[12]=':';
 IntToStr(seconds,string_aux);
 full_line[11]=(string_aux[5]!=' ')?string_aux[5]:'0';
 full_line[10]=(string_aux[4]!=' ')?string_aux[4]:'0';
 full_line[9]=':';
 if(minutes<100){
 IntToStr(minutes,string_aux);
 full_line[8]=(string_aux[5]!=' ')?string_aux[5]:'0';
 full_line[7]=(string_aux[4]!=' ')?string_aux[4]:'0';
 }else{
 full_line[8]='+';
 full_line[7]='9';
 full_line[6]='9';
 }
 full_line[0]='L';
 full_line[1]='a';
 full_line[2]='p';
}
