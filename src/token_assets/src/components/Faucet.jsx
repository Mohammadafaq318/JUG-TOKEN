import React, { useState } from "react";
import {token} from "../../../declarations/token";

function Faucet() {


  const [isDisable, setDisable] = useState(false);
  const [buttonText,setButtonText] = useState("Create Wallet and JUGAAR Me Some Token");

  async function handleClick(event) {
    setDisable(true);
    const result= await token.payOut();
    setButtonText(result);
   
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Setup Account and get your free JUGAAR tokens here! Claim 2,500 JUG coins to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisable}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
