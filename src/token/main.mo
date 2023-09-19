import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Prelude "mo:base/Prelude";



actor Token {

    var owner : Principal = Principal.fromText("vjqvg-opd27-dxyi2-576oz-fhdqe-jfg4b-7zt2q-ae4yr-65tcw-f2cti-bae");  
    var totalSupply : Nat = 231400000; //231.4 Million
    var symbol : Text = "JUG";

    var balances = HashMap.HashMap<Principal,Nat>(1,Principal.equal, Principal.hash);

    balances.put(owner,totalSupply);


    public query func balanceOf(who: Principal): async Nat{
        
        let balance : Nat = switch (balances.get(who)){
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSymbol(): async Text{
        return symbol;
    };
};