module unauthorized(a,b,e,reverse,y,e1);
input [7:0] a; 
input [7:0] b; 
input e;    
input reverse;   
output [7:0] y;
output e1;
wire [7:0] w;
wire [7:0] or_out;
wire e2;
wire [7:0] y1;
wire not_reverse;
not not2(not_reverse,reverse);
and and1(w[0],b[0], e);
and and2(w[1],b[1], e);
and and3(w[2],b[2], e);
and and4(w[3],b[3], e);
and and5(w[4],b[4], e);
and and6(w[5],b[5], e);
and and7(w[6],b[6], e);
and and8(w[7],b[7], e);
and and9(y1[0],w[0],a[0]);
and and10(y1[1],w[1],a[1]);
and and11(y1[2],w[2],a[2]);
and and12(y1[3],w[3],a[3]);
and and13(y1[4],w[4],a[4]);
and and14(y1[5],w[5],a[5]);
and and15(y1[6],w[6],a[6]);
and and16(y1[7],w[7],a[7]);
and and17(y[0],y1[0],not_reverse);
and and18(y[1],y1[1],not_reverse);
and and19(y[2],y1[2],not_reverse);
and and20(y[3],y1[3],not_reverse);
and and21(y[4],y1[4],not_reverse);
and and22(y[5],y1[5],not_reverse);
and and23(y[6],y1[6],not_reverse);
and and24(y[7],y1[7],not_reverse);
or(e2,y[0],y[1],y[2],y[3],y[4],y[5],y[6],y[7]);
not not1(e1,e2);
endmodule

module twoTofourDecorder(enable,a,y1);
input enable;
input [1:0]a;
output [3:0]y1;
wire enb,na,nb,en;
wire [3:0]y;
not n3(en,enable);
not n0(enb,en);
not n1(na,a[1]);
not n2(nb,a[0]);
nand nand1(y[0],enb,na,nb),nand2(y[1],enb,na,a[0]),nand3(y[2],enb,a[1],nb),nand4(y[3],enb,a[1],a[0]);
not n4(y1[0],y[0]), n5(y1[1],y[1]),n6(y1[2],y[2]),n7(y1[3],y[3]);
endmodule

module transaction_card(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,enable,duration,weight,capacity,power,hours,card_number,isPaidCard,final_enable);
input [3:0] PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD;
input [3:0] HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD;
input enable;
input [3:0] duration, weight,power,hours,capacity;
input [3:0] card_number;
output isPaidCard;
wire [7:0] price1,price2,price3,price4,price5,validity;
output final_enable;
amount a1(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,1'b1,duration,weight,price2);
electric_charge e1(FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,enable,duration,power,price1);
cng c1(HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,enable,duration,capacity,price4);
eightBitAdderSub s1(1'b0,price1,price2,price3);
eightBitAdderSub s3(1'b0,price3,price4,price5);
fourBitMultiplier f2(1'b1,card_number,4'b0101,validity);
and(final_enable,validity[2],validity[1]);
and(isPaidCard,final_enable,enable);
endmodule

module transaction_cash(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,enable,duration,weight,capacity,power,hours,cash,isPaidCash,balance);
input [3:0] PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD;
input [3:0] HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD;
input enable;
input [3:0] duration,weight,power,hours,capacity;
input [7:0] cash;
output isPaidCash;
output [7:0] balance;
wire [7:0] balance1;
wire [7:0] price1,price2,price3,price4,price5;
electric_charge e1(FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,enable,duration,power,price1);
cng c1(HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,enable,duration,capacity,price4);
amount a1(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,1'b1,duration,weight,price2);
eightBitAdderSub s1(1'b0,price1,price2,price3);
eightBitAdderSub s3(1'b0,price3,price4,price5);
eightBitAdderSub s2(1'b1,cash,price5,balance1);
and(isPaidCash,enable,enable);
and(balance[0],enable,balance1[0]);
and(balance[1],enable,balance1[1]);
and(balance[2],enable,balance1[2]);
and(balance[3],enable,balance1[3]);
and(balance[4],enable,balance1[4]);
and(balance[5],enable,balance1[5]);
and(balance[6],enable,balance1[6]);
and(balance[7],enable,balance1[7]);
endmodule

module threeTofourDecoder(enable,y,result);
input enable;
input [2:0]y;
output [7:0]result;
wire y2_n;
wire [7:0] result1;
not(y2_n,y[2]);
twoTofourDecorder t1(y2_n,y[1:0],result1[3:0]);
twoTofourDecorder t2(y[2],y[1:0],result1[7:4]);
and(result[0],result1[0],enable);
and(result[1],result1[1],enable);
and(result[2],result1[2],enable);
and(result[3],result1[3],enable);
and(result[4],result1[4],enable);
and(result[5],result1[5],enable);
and(result[6],result1[6],enable);
and(result[7],result1[7],enable);
endmodule

module rc_adder(c_in,a0,a1,a2,a3,b0,b1,b2,b3,s0,s1,s2,s3,s4);
input c_in,a0,a1,a2,a3,b0,b1,b2,b3;
output s0,s1,s2,s3,s4;
wire w0,w1,w2,w3;
fadder fa0(a0,b0,c_in,s0,w0);
fadder fa1(a1,b1,w0,s1,w1);
fadder fa2(a2,b2,w1,s2,w2);
fadder fa3(a3,b3,w2,s3,s4);
endmodule

module passwordChecker(enable,password,input_password,password_matched);
input enable;
input [3:0] password;
input [3:0] input_password;
output password_matched;
wire final_password_matched;
wire result;
wire [3:0] xor_result;
xor xor_gate_0(xor_result[0], password[0], input_password[0]);
xor xor_gate_1(xor_result[1], password[1], input_password[1]);
xor xor_gate_2(xor_result[2], password[2], input_password[2]);
xor xor_gate_3(xor_result[3], password[3], input_password[3]);
or or_gate(result, xor_result[0], xor_result[1], xor_result[2], xor_result[3]);
and(final_password_matched,result,enable);
not not1(password_matched,final_password_matched);
endmodule

module amount(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,enable,duration,weight,price);
input [3:0] PRICE_1;
input [3:0] PRICE_2;
input [3:0] WEIGHT_THRESHOLD;
input enable;
input [3:0] duration, weight;
output [7:0] price;
wire [7:0] price1,price2,price3;
wire equal,greater,less,w1;
fourBitcomparator c1(weight,WEIGHT_THRESHOLD,equal,greater,less);
or(w1,less,equal);
fourBitMultiplier f1(w1,duration,PRICE_1,price1);
fourBitMultiplier f2(greater,duration,PRICE_2,price2);
or(price3[0],price1[0],price2[0]);
or(price3[1],price1[1],price2[1]);
or(price3[2],price1[2],price2[2]);
or(price3[3],price1[3],price2[3]);
or(price3[4],price1[4],price2[4]);
or(price3[5],price1[5],price2[5]);
or(price3[6],price1[6],price2[6]);
or(price3[7],price1[7],price2[7]);
and(price[0],enable,price3[0]);
and(price[1],enable,price3[1]);
and(price[2],enable,price3[2]);
and(price[3],enable,price3[3]);
and(price[4],enable,price3[4]);
and(price[5],enable,price3[5]);
and(price[6],enable,price3[6]);
and(price[7],enable,price3[7]);
endmodule

module inverter(a,b,e,code_enable,y);
input [7:0] a;    
input [7:0] b;    
input e;
input code_enable; 
output [7:0] y;
wire [7:0] and_out;
wire [7:0] and_out_b;
wire enable;
and and17(enable,e,code_enable);
and and1(and_out[0],a[0], enable);
and and2(and_out[1],a[1], enable);
and and3(and_out[2],a[2], enable);
and and4(and_out[3],a[3], enable);
and and5(and_out[4],a[4], enable);
and and6(and_out[5],a[5], enable);
and and7(and_out[6],a[6], enable);
and and8(and_out[7],a[7], enable);
and and9(and_out_b[0],b[0], enable);
and and10(and_out_b[1],b[1], enable);
and and11(and_out_b[2],b[2], enable);
and and12(and_out_b[3],b[3], enable);
and and13(and_out_b[4],b[4], enable);
and and14(and_out_b[5],b[5], enable);
and and15(and_out_b[6],b[6], enable);
and and16(and_out_b[7],b[7], enable);
xor xor1(y[0],and_out[0], and_out_b[0]);
xor xor2(y[1],and_out[1], and_out_b[1]);
xor xor3(y[2],and_out[2], and_out_b[2]);
xor xor4(y[3],and_out[3], and_out_b[3]);
xor xor5(y[4],and_out[4], and_out_b[4]);
xor xor6(y[5],and_out[5], and_out_b[5]);
xor xor7(y[6],and_out[6], and_out_b[6]);
xor xor8(y[7],and_out[7], and_out_b[7]);
endmodule

module half_adder(a,b,y,c);
input a,b;
output y,c;
xor xor1(y,a,b);
and and1(c,a,b);
endmodule

module fadder(a,b,cin,sum,carry);
input a,b,cin;
output sum,carry;
wire w1,w2,w3,w4,w5;
xor xor1(sum,w1,cin), xor2(w1,a,b);        
and and1(w2,a,b), and2(w3,b,cin), and3(w4,a,cin);
or or1(w5,w2,w3), or2(carry,w5,w4);
endmodule

module fourBitAdder (
    input [3:0] a,
    input [3:0] b,
    output [4:0] sum
);
wire c1,c2,c3,c4;
fadder f1(a[0],b[0],1'b0,sum[0],c1);
fadder f2(a[1],b[1],c1,sum[1],c2);
fadder f3(a[2],b[2],c2,sum[2],c3);
fadder f4(a[3],b[3],c3,sum[3],c4);
and(sum[4],c4,c4);
endmodule

module fireManagement(enable,temp,firePosition,componentsRun,combatSystem);
parameter safeTemp = 4'b0100;
input enable;
input [3:0] temp; 
input [7:0] firePosition;
output componentsRun;
output combatSystem;
wire greater,equal,less;
wire w1,w2;
fourBitcomparator comp(temp,safeTemp,equal,greater,less);
or(w1,equal,less);
and(componentsRun,w1,enable);
or(w2,firePosition[0],firePosition[1],firePosition[2],firePosition[3],firePosition[4],firePosition[5],firePosition[6],firePosition[7]);
and(combatSystem,w2,enable);
endmodule

module electric_charge(FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,enable,duration,power,price);
input [3:0] FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD;
input [3:0] duration, power;
input enable;
output [7:0] price;
wire [7:0] price1,price2,price3;
wire final_enable,w1,greater,equal,less;
and(final_enable,enable,enable);
fourBitcomparator c1(power,CHARGE_THRESHOLD,equal,greater,less);
or(w1,equal,less);
fourBitMultiplier f1(w1,duration,CHARGE_PRICE,price1);
fourBitMultiplier f2(greater,duration,FAST_CHARGE_PRICE,price2);
or(price3[0],price1[0],price2[0]);
or(price3[1],price1[1],price2[1]);
or(price3[2],price1[2],price2[2]);
or(price3[3],price1[3],price2[3]);
or(price3[4],price1[4],price2[4]);
or(price3[5],price1[5],price2[5]);
or(price3[6],price1[6],price2[6]);
or(price3[7],price1[7],price2[7]);
and(price[0],final_enable,price3[0]);
and(price[1],final_enable,price3[1]);
and(price[2],final_enable,price3[2]);
and(price[3],final_enable,price3[3]);
and(price[4],final_enable,price3[4]);
and(price[5],final_enable,price3[5]);
and(price[6],final_enable,price3[6]);
and(price[7],final_enable,price3[7]);
endmodule

module display(a,e,y);
input e;
input [7:0]a;
output [7:0]y;
and and1(y[0],a[0],e),and2(y[1],a[1],e),and3(y[2],a[2],e),and4(y[3],a[3],e),and5(y[4],a[4],e),and6(y[5],a[5],e),and7(y[6],a[6],e),and8(y[7],a[7],e);
endmodule

module fourBitcomparator(a,b,c0,c1,c2);
input [3:0] a,b;
output c0,c1,c2;
wire w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30,w31,w32,w33,w34,w35,w36,w37,w38,w39,w40;
not not0(w0,a[0]);
not not1(w1,a[1]);
not not2(w2,a[2]);
not not3(w3,a[3]);
not not4(w4,b[0]);
not not5(w5,b[1]);
not not6(w6,b[2]);
not not7(w7,b[3]);
and and0(w8,a[0],w4);
and and1(w9,a[1],w5);
and and2(w10,a[2],w6);
and and3(w11,a[3],w7);
and and4(w12,b[0],w0);
and and5(w13,b[1],w1);
and and6(w14,b[2],w2);
and and7(w15,b[3],w3);
nor nor0(w16,w8,w12);
nor nor1(w17,w9,w13);
nor nor2(w18,w10,w14);
nor nor3(w19,w11,w15);
and and8(c0,w16,w17,w18,w19);
and and9(w20,w17,w18,w19,w8);
and and10(w21,w17,w18,w19,w12);
and and11(w22,w18,w19,w9);
and and12(w23,w18,w19,w13);
and and13(w24,w19,w10);
and and14(w25,w19,w14);
or or1(c1,w20,w22,w24,w11);
or or2(c2,w21,w23,w25,w15);
endmodule

module cng(HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,enable,duration,capacity,price);
input [3:0] HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD;
input [3:0] duration, capacity;
input enable;
output [7:0] price;
wire [7:0] price1,price2,price3;
wire final_enable,w1,greater,equal,less;
and(final_enable,enable,enable);
fourBitcomparator c1(capacity,CAPACITY_THRESHOLD,equal,greater,less);
or(w1,equal,less);
fourBitMultiplier f1(w1,duration,SMALL_CAPACITY_PRICE,price1);
fourBitMultiplier f2(greater,duration,HIGH_CAPACITY_PRICE,price2);
or(price3[0],price1[0],price2[0]);
or(price3[1],price1[1],price2[1]);
or(price3[2],price1[2],price2[2]);
or(price3[3],price1[3],price2[3]);
or(price3[4],price1[4],price2[4]);
or(price3[5],price1[5],price2[5]);
or(price3[6],price1[6],price2[6]);
or(price3[7],price1[7],price2[7]);
and(price[0],final_enable,price3[0]);
and(price[1],final_enable,price3[1]);
and(price[2],final_enable,price3[2]);
and(price[3],final_enable,price3[3]);
and(price[4],final_enable,price3[4]);
and(price[5],final_enable,price3[5]);
and(price[6],final_enable,price3[6]);
and(price[7],final_enable,price3[7]);
endmodule

module binTonum(enable,a,y3);
input enable;
input [7:0] a;
output [3:0] y3;
wire [2:0] y1;
wire [3:0] y2;
wire [3:0] y;
fadder f1(a[2],a[3],a[1],s1,c1);
fadder f2(a[5],a[6],a[4],s2,c2);
fadder f3(s1,s2,a[0],y1[0],c3);
fadder f4(c1,c2,c3,y1[1],y1[2]);
half_adder h1(y1[0],a[7],y2[0],c4);
half_adder h2(c4,y1[1],y2[1],c5);
half_adder h3(c5,y1[2],y2[2],y2[3]);
fourBitSubtractor sub(4'b1000, y2,y);
and(y3[0],y[0],enable);
and(y3[1],y[1],enable);
and(y3[2],y[2],enable);
and(y3[3],y[3],enable);
endmodule

module and_gate(a,b,y);
input a,b;
output y;
and(y,a,b);
endmodule

module eightBitAdderSub(k,a,b,sum);
input k;
input [7:0] a,b;
output [8:0] sum;
wire c1,c2,c3,c4,c5,c6,c7,c8;
wire w0,w1,w2,w3,w4,w5,w6,w7;
xor(w0,k,b[0]);
xor(w1,k,b[1]);
xor(w2,k,b[2]);
xor(w3,k,b[3]);
xor(w4,k,b[4]);
xor(w5,k,b[5]);
xor(w6,k,b[6]);
xor(w7,k,b[7]);
fadder f1(a[0],w0,k,sum[0],c1);
fadder f2(a[1],w1,c1,sum[1],c2);
fadder f3(a[2],w2,c2,sum[2],c3);
fadder f4(a[3],w3,c3,sum[3],c4);
fadder f5(a[4],w4,c4,sum[4],c5);
fadder f6(a[5],w5,c5,sum[5],c6);
fadder f7(a[6],w6,c6,sum[6],c7);
fadder f8(a[7],w7,c7,sum[7],c8);
endmodule

module fourBitSubtractor(a,b,y);
parameter k=1'b1;
input [3:0] a,b;
output [3:0] y;
xor(w0,k,b[0]);
xor(w1,k,b[1]);
xor(w2,k,b[2]);
xor(w3,k,b[3]);
fadder f1(a[0],w0,k,y[0],c1);
fadder f2(a[1],w1,c1,y[1],c2);
fadder f3(a[2],w2,c2,y[2],c3);
fadder f4(a[3],w3,c3,y[3],c4);
endmodule

module fourBitMultiplier(enable,a,b,r);
input [3:0] a,b;
input enable;
wire [7:0] c;
output [7:0] r;
wire w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17;
and_gate and0(a[0],b[0],c[0]), and1(a[1],b[0],w0), and2(a[2],b[0],w1), and3(a[3],b[0],w2);
and_gate and4(a[0],b[1],w3), and5(a[1],b[1],w4), and6(a[2],b[1],w5), and7(a[3],b[1],w6);
and_gate and8(a[0],b[2],w7), and9(a[1],b[2],w8), and10(a[2],b[2],w9), and11(a[3],b[2],w10);
and_gate and12(a[0],b[3],w11), and13(a[1],b[3],w12), and14(a[2],b[3],w13), and15(a[3],b[3],w14);
rc_adder fa0(0,w3,w4,w5,w6,w0,w1,w2,0,c[1],w15,w16,w17,w18);
rc_adder fa1(0,w7,w8,w9,w10,w15,w16,w17,w18,c[2],w19,w20,w21,w22); 
rc_adder fa2(0,w11,w12,w13,w14,w19,w20,w21,w22,c[3],c[4],c[5],c[6],c[7]);
and(r[0],c[0],enable);
and(r[1],c[1],enable);
and(r[2],c[2],enable);
and(r[3],c[3],enable);
and(r[4],c[4],enable);
and(r[5],c[5],enable);
and(r[6],c[6],enable);
and(r[7],c[7],enable);
endmodule

module main_circuit(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,temp,firePosition,duration,power,capacity,password,user_password,weight,cash,card_number,park_sequence,additional,code,hours,reverse,password_matched,isPaidCash,isPaidCard,result,alarm_status);
input [3:0] PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD;
input [3:0]password;
input [3:0]user_password;
input [7:0]park_sequence;
input [7:0]additional;
input [2:0]code;
input [3:0]hours;
input [3:0] temp;
input [7:0] firePosition;
input [3:0] weight;
input [3:0] duration;
input [3:0] power;
input [7:0] cash;
input [3:0] capacity;
input [3:0] card_number;
input reverse;
output password_matched,isPaidCash,isPaidCard;
output [7:0] result,alarm_status;
wire componentsRun,combatSystem;
wire [3:0] count;
wire [7:0] new_park_sequence, print_park, price, op_code,balance,price1,price2;
wire invert_enable;
fireManagement f1(1'b1,temp,firePosition,componentsRun,combatSystem);
passwordChecker p1(componentsRun,password,user_password,password_matched);
threeTofourDecoder t1(password_matched,code,op_code);
binTonum b1(op_code[0],park_sequence,count);
amount a1(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,op_code[1],duration,weight,price);
display d1(park_sequence,op_code[2],print_park);
unauthorized u1(park_sequence,additional,op_code[3],reverse,alarm_status,invert_enable);
inverter i1(park_sequence,additional,invert_enable,op_code[3],new_park_sequence);
transaction_cash t2(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,op_code[4],duration,weight,capacity,power,hours,cash,isPaidCash,balance);
transaction_card t3(PRICE_1,PRICE_2,WEIGHT_THRESHOLD,FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,op_code[5],duration,weight,capacity,power,hours,card_number,isPaidCard);
electric_charge e1(FAST_CHARGE_PRICE,CHARGE_PRICE,CHARGE_THRESHOLD,op_code[6],duration,power,price1);
cng c1(HIGH_CAPACITY_PRICE,SMALL_CAPACITY_PRICE,CAPACITY_THRESHOLD,op_code[7],duration,capacity,price2);
or(result[0],new_park_sequence[0],print_park[0],price[0],price1[0],price2[0], balance[0],count[0]);
or(result[1],new_park_sequence[1],print_park[1],price[1],price1[1],price2[1], balance[1],count[1]);
or(result[2],new_park_sequence[2],print_park[2],price[2],price1[2],price2[2], balance[2],count[2]);
or(result[3],new_park_sequence[3],print_park[3],price[3],price1[3],price2[3], balance[3],count[3]);
or(result[4],new_park_sequence[4],print_park[4],price[4],price1[4],price2[4], balance[4]);
or(result[5],new_park_sequence[5],print_park[5],price[5],price1[5],price2[5], balance[5]);
or(result[6],new_park_sequence[6],print_park[6],price[6],price1[6],price2[6], balance[6]);
or(result[7],new_park_sequence[7],print_park[7],price[7],price1[7],price2[7], balance[7]);
endmodule