// in MOTOKO language 'class' is called as 'actor'

import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));
  
  // var currentVal = 300;
  //  we can make a variable Orthogonal Persistent, (i.e., not changing value when rerunning canisters, value gets saved, in different iterations)
  stable var currentVal: Float = 300;
  // var currentVal = 300;
  // currentVal := 150;    // to ReAssign values we can't directly use '=' operator, instead ':=' is used

  // Debug.print("Namaste");
  // print function only accept 'text' type, so we can't direcly use 'currentVal' in it
  // Debug.print(debug_show(currentVal));

  let id = 20394209243857;
  // id := 420394204;      // will give errors    
  // 'let' is used for Constants in Motoko, unlike JS
  // Debug.print(debug_show(id));

  public func myName() {
    Debug.print("Pranjal Kumar");
  };

  //    by-default functions are Private, we made it Public, so that we can use it via Command-Line
  //   'func' keyword is used to create functions

  //  function() to DEPOSIT balance
  public func topUp(amount: Float) {     // (varName: DataType)    -> Nat means Natural No.    
    currentVal += amount;
    Debug.print(debug_show(currentVal));  
    //  we even need to close functions with SemiColon ';'  
  };    

  // topUp();    // if we are keeping a function public, we can't call it directly inside same actor(i.e. class)
  //        we can also call Functions via Command-Line    // ex: dfx canister call dbank topUp   // here 'dbank' is project name


  //  function() to WITHDRAW balance
  public func widthdraw(amount: Float){
    let tempRes: Float = currentVal-amount;
    if(tempRes >= 0.0){
      currentVal -= amount;
      Debug.print(debug_show(currentVal));
    }
    else{
      Debug.print("Low Balance for the transaction to happen🤷‍♂️")
    }
  };


  // normal update functions like above widthdraw() methods takes load of time, because they are performed inside BLockChain, so for simple queries, which don't require saving values, we use 'query' instead

  public query func checkBalance() : async Float {    // : Nat is used to tell the return type & async is used with every function which returns
    return currentVal;
  };
  


  public func compound () : async Float{
    let currTime = Time.now();
    let rate = 0.001;
    let timePassedNS = currTime-startTime;    // time elapsed in Nano-seconds
    let timePassedS = timePassedNS / 1000000000;
    // to calculate Compounded Amount: p(1+(r/n))^(nt)
    currentVal := currentVal * ((1.0+rate)** Float.fromInt(timePassedS));
    startTime := currTime;
    return currentVal;
  }


}

// dfx stop  ->  to stop previous running servers
// dfx start  ->  to start our server
// dfx start --clean  ->  to start our server and stopping previous ones
// dfx deploy  ->  to deploy our canister app
