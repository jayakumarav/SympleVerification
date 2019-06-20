clear;

%enter application number below
application = 1;

%this line may need to be modified for your computer Vivado path
%hdlsetuptoolpath('toolName','XILINX VIVADO','ToolPath','C:\Xilinx\Vivado\2015.4\bin\vivado.bat');

%!!!!!DO NOT CHANGE BELOW THIS LINE!!!!!
load('arch.mat')

if application == 1
    load('edg.mat')
elseif application == 2
    load('pid.mat');
else
    application = 0;
end

%data type definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stateNumBits = 4;
stateIterationNumBits = 6;
errorFlagNumBits = 22;

stateType = fixdt(0,stateNumBits);
stateIterationType = fixdt(0,stateIterationNumBits);
errorFlagType = fixdt(0,errorFlagNumBits);

FBErrorCodeNumBits = stateNumBits + stateIterationNumBits + errorFlagNumBits;
FBErrorCodeType = fixdt(0,FBErrorCodeNumBits);

taskNumBits = 8;
functionNumBits = 8;
instantiationNumBits = 8;
globalBitsNotUsed = 8;

globalErrorCodePrefixNumBits = taskNumBits + functionNumBits + instantiationNumBits + globalBitsNotUsed;
globalErrorCodePrefixType = fixdt(0,globalErrorCodePrefixNumBits);

dataTypeNumBits = 8;
fractionalNumBits = 24;

dataType = fixdt(0, dataTypeNumBits);
fractionalType = fixdt(0, fractionalNumBits);

A2D_dataType = fixdt(0, 12);



%for local sequencer counters and for task memory size
task_memory_addr_bits = 8;
task_memory_addr_type = fixdt(0, task_memory_addr_bits);

%type for task instruction pointer and outputs
task_inst_data_type = 'int32';
task_inst_ptr_type = 'uint32';

%type for function block select
fb_select_type = 'uint8';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%timing parameters
timeout = int32(50);

mem_wait = 2; %measured from latch address
inst_wait = 2; %measured from latch address

MUX_FUNCTION_DELAY = uint32(2);

functionMaxDelay = uint32(50);

%FB ERROR Code Masks
mask.error.stateErrorBit = uint32(1);
mask.error.timeoutBit = uint32(2);
mask.error.overflowBit = uint32(4);
mask.error.underflowBit = uint32(8);
mask.error.divideByZeroBit = uint32(16);
mask.error.inputOverflowBit = uint32(32);
mask.error.outputOverflowBit = uint32(64);
mask.error.abortBit = uint32(128);
mask.error.typeBit = uint32(256);

%mask.error.inShiftsBit = uint32(16);
%mask.error.outShiftsBit = uint32(32);
% Mask locations
% Error masks
mask.errorBits =    uint32(bin2dec('00000000001111111111111111111111'));
mask.iterNumBits =  uint32(bin2dec('00001111110000000000000000000000'));
mask.stateBits =    uint32(bin2dec('11110000000000000000000000000000'));

% Global data type masks
mask.typeBits =     uint32(bin2dec('11111111000000000000000000000000'));
mask.fractionBits = uint32(bin2dec('00000000111111111111111111111111'));

% Left shift necessary to push integer codes to proper mask
mask.errorBitsShift = 0;
mask.iterNumBitsShift = 22;
mask.stateBitsShift = 28;
mask.dataTypeBitsShift = 24;

%FB State codes (0-15)
init_code = uint8(0);
idle_code = uint8(1);
read_input_code = uint8(2);
execute_code = uint8(3);
write_output_code = uint8(4);
done_code = uint8(5);
error_code = uint8(6);

%FB_enumerations
NOR = 1;
AND = 2;
NOT = 3;
OR = 4;
XOR = 5;
NAND = 6;
BNOR = 7; %was 11;
BAND = 8; %was 12;
BNOT = 9; %was 13;
BOR = 10; %was 14;
BXOR = 11; %was 15;
BNAND = 12; %was 16;
MAX = 13; %was 21;
MIN = 14; %was 22;
MUX = 15; %was 23;
GT = 16; %was 24;
GE = 17; %was 25;
EQ = 18; %was 26;
LT = 19; %was 27;
LE = 20; %was 28;
NE = 21; %was 29;
ADD = 22; %was 40;
SUB = 23; %was 41;
MUL = 24; %was 42;
DIV = 25; %was 43;
BSL = 26; %was 50;
BSR = 27; %was 51;
MOV = 28; %was 100;

%task sequence stop character
eof = int32(2147483647); %31 ones

%task sequencer config parameters
mem_wait = 2;
ctrl_wait = 2;
inst_wait = 2;
sel_wait = 2;

% Type Data
%bool.type = uint8(bitshift(1,mask.dataTypeBitsShift));
bool.type = uint8(1);
safebool.true = uint32(bin2dec('10101010101010101010101010101010'));
safebool.false = bitcmp(safebool.true);
safebool.type = uint8(2);
int.type = uint8(3);
Q.type = uint8(4);
