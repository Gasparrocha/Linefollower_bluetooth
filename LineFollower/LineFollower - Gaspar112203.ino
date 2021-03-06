#include <SoftwareSerial.h>
//10 25
/**************/
/*Motor Driver*/
/**************/
//Motor driver pins
#define ENL   7
#define INL1  5
#define INL2  6
#define ENR   2
#define INR1  3
#define INR2  4
//Motor driver atributes
int LMSpeed, RMSpeed;
byte spConst = 80;
byte turnSpeed = 80;
byte rOffset;
byte lOffset;
bool startDrive=false;
//Motor driver functions
void drive(int cor){  
  LMSpeed = spConst + cor;
  RMSpeed = spConst - cor;
 
  if(LMSpeed < 0) {LMSpeed = 0;}
  if(LMSpeed > 255) {LMSpeed = 255;}

  if(RMSpeed < 0) {RMSpeed = 0;}
  if(RMSpeed > 255) {RMSpeed = 255;}
  
  analogWrite(ENL,LMSpeed);
  analogWrite(ENR,RMSpeed);
  digitalWrite(INL1,LOW);
  digitalWrite(INL2,HIGH);
  digitalWrite(INR1,HIGH);
  digitalWrite(INR2,LOW);
}
void neutralMove(){
  analogWrite(ENL,0);
  analogWrite(ENR,0);
  digitalWrite(INL1,LOW);
  digitalWrite(INL2,LOW);
  digitalWrite(INR1,LOW);
  digitalWrite(INR2,LOW);
}

/***************/
/*Sensor Header*/
/***************/
//Sensor header pins
#define E3 50
#define E2 46
#define E1 42
#define D1 38
#define D2 34
#define D3 30
//Sensor header atributes
float error;
//Sensor header functions
int updateError(){
  error=0;
  float avg=0;
  if(digitalRead(E3)) {error=error-2.5;avg+=1; }
  if(digitalRead(E2)) {error=error-1.5;avg+=1; }
  if(digitalRead(E1)) {error=error-0.5;avg+=1; }
  if(digitalRead(D1)) {error=error+0.5+1;avg+=1; }
  if(digitalRead(D2)) {error=error+1.5+1;avg+=1; }
  if(digitalRead(D3)) {error=error+2.5+1;avg+=1; }
  error=(!avg)? 0:error/avg;
  return (avg>=5)? 1:0;
}

/*****************/
/*Bluetooth HC-05*/
/*****************/
//Bluetooth pins
#define RX 11
#define TX 10
//Bluetooth atrinutes
SoftwareSerial btooth(RX,TX);
bool isMessageNew=0;
String command;
//Bluetooth functions
void listenMessage() {  
  if (btooth.available())
  {
    while(btooth.available()) {
      delay(1);
      command += (char)btooth.read();  
    }
    isMessageNew=true;
    btooth.println(command);
  }
}


//PID atributes
unsigned long lapTime=0;
float Kp=1, Ki=1 ,Kd=1;
float P=0, D=0;
float PID_value=0;
float I=0;
float previous_error;

void setup() {
  //Motor driver setup
  pinMode(ENL, OUTPUT);
  pinMode(INL1,OUTPUT);
  pinMode(INL2,OUTPUT);
  pinMode(ENR, OUTPUT);
  pinMode(INR1, OUTPUT);
  pinMode(INR2, OUTPUT);
  neutralMove();
  //Sensor header setup
  pinMode(E3,INPUT);
  pinMode(E2,INPUT);
  pinMode(E1,INPUT);
  pinMode(D1,INPUT);
  pinMode(D2,INPUT);
  pinMode(D3,INPUT);
  //Bluetooth setup
  btooth.begin(9600);
  while(!btooth);
  btooth.println("Type commands:");
}

void loop() {
  listenMessage();
  if(isMessageNew){ 
      parseMessage();
      btooth.print("state: ");
      btooth.println(startDrive);
      btooth.print("Kp: ");
      btooth.print(Kp,4);
      btooth.print(" Ki: ");
      btooth.print(Ki,4);
      btooth.print(" Kd: ");
      btooth.print(Kd,4);
      btooth.print(" Speed:");
      btooth.println(spConst);
  }
  if(startDrive){
    if(updateError()){
      btooth.print("Lap: ");
      btooth.println((float)(millis()-lapTime)/1000,3);
      while(updateError());
      lapTime=millis();
    }
    calculate_pid();
    
    drive((int)PID_value);

  }else{
    neutralMove();
  }
}



void calculate_pid()
{

  P = error;
  I = I + error*0.001;
  D = (error - previous_error)/.001;
  
  PID_value = (Kp*P) + (Ki*I) + (Kd*D);
      
  previous_error=error;
}

void parseMessage(){
  char op[]={command[0],command[1]};
  float num;
  command.remove(0,2);
  num = command.toFloat();
  switch(op[0]){
    case 'k':
      switch(op[1]){
        case 'p': Kp=num; break;
        case 'i': Ki=num; break;
        case 'd': Kd=num; break;
        default:
          btooth.println("\nUnknown cmd\n");
        break;
      }
    break;
      case 'm':
      switch(op[1]){
        case 'r': rOffset=num; btooth.println(rOffset); break;
        case 'l': lOffset=num; btooth.println(lOffset); break;
        case 't': spConst=num; break;
        default:
          btooth.println("\nUnknown cmd\n");
        break;
      }
    break;
    case 'g': startDrive = true; break;
    case 's': startDrive = false; break;
    default:
      if(!command[0]=='e' && !command[1]=='c')
        btooth.println("\nUnknown cmd\n");
    break;
  }
  command="";
  isMessageNew=false;
}
