import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Prelude "mo:base/Prelude";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor Token {

    Debug.print(debug_show("hello"));
    let owner : Principal = Principal.fromText("vjqvg-opd27-dxyi2-576oz-fhdqe-jfg4b-7zt2q-ae4yr-65tcw-f2cti-bae");  
    let totalSupply : Nat = 231400000; //231.4 Million
    let symbol : Text = "JUG";

    private stable var balanceEntries: [(Principal,Nat)]=[];
    private var balances = HashMap.HashMap<Principal,Nat>(1,Principal.equal, Principal.hash); //Our ledger to keep track of balances //Private means it cna only be modified from the token actor

    if(balances.size()==0){
        balances.put(owner,totalSupply);
    };
    public query func balanceOf(who: Principal): async Nat{
        
        let balance : Nat = switch (balances.get(who)){
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSymbol(): async Text{ //faster query method to just read data from blockchain
        return symbol;
    };

    public shared(msg) func payOut(): async Text{ // here msg is the principal id of the entity who will call this shared functions from their actors
        Debug.print(debug_show(msg.caller));

        if(balances.get(msg.caller) == null){
            let amount = 2500;
            let result = await transfer(msg.caller,amount);
            return "JUGAAR works. JUG has been deposited";
        }else {
            return "JUGAAR PE JUGAAR. You have already claimed JUG";
        }
        
    };

    public shared(msg) func transfer(to: Principal, amount: Nat) : async Text{

        let sender : Principal = msg.caller;
        let receiver: Principal = to;

        let senderBal : Nat = await balanceOf(sender);
        

        let diff : Nat = senderBal - amount;


        if(sender==receiver){
            return "Nice Try to Jugaar. Cant send JUGS to yourself";
        }else if(diff>=0){
            let receiverBal : Nat = await balanceOf(receiver);
            balances.put(sender, senderBal - amount);
            balances.put(receiver, receiverBal + amount);
            return "JUGAAR done";
        }
        else{
            return "JUGAAR Failed. Not enough JUGS";
        }
    };

    system func preupgrade(){ //trigerred before the upgrade dfx deploy
        balanceEntries:= Iter.toArray(balances.entries());
    };
    system func postupgrade(){ //trigerred after the upgrade dfx deploy
        balances:= HashMap.fromIter<Principal,Nat>(balanceEntries.vals(),1,Principal.equal, Principal.hash); //putting values back into the balances hashmap

        if(balances.size()==0){
            balances.put(owner,totalSupply);
        };
    };
};