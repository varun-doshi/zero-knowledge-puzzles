pragma circom 2.1.8;

// Create a circuit that takes an array of four signals
// `in`and a signal s and returns is satisfied if `in`
// is the binary representation of `n`. For example:
// 
// Accept:
// 0,  [0,0,0,0]
// 1,  [1,0,0,0]
// 15, [1,1,1,1]
// 
// Reject:
// 0, [3,0,0,0]
// 
// The circuit is unsatisfiable if n > 15

template toBinary(){
    signal input in;
    signal output out[4];

    for(var i=0; i<4;i++){
        out[i] <-- (in >> i) & 1;
        out[i] * (out[i] -1 ) === 0;
    }
    
}

template FourBitBinary() {
    signal input in[4];
    signal input n;
    signal remainder[4];
    var c=0;

    component binary = toBinary();
    binary.in <== n;

    remainder <== binary.out;

    for(var i=0;i<4;i++){
        remainder[i] - in[i] === 0;
    }


}

component main{public [n]} = FourBitBinary();
