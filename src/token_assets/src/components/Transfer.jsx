import React, { useState } from "react";
import {token} from "../../../declarations/token";
import { Principal } from "../../../../node_modules/@dfinity/principal/lib/cjs/index";

function Transfer() {
  
  const [recipient,setRecipient] = useState("");
  const [amount,setamount] = useState("");
  const [buttonText,setButtonText] = useState("");
  const [isDisable, setDisable] = useState(false);


  async function handleClick() {


    const user=Principal.fromText(recipient);
    const amountToTranfser=Number(amount);
    setDisable(true);
    let return_val= await token.transfer(user,amountToTranfser);
    setDisable(false);
    setButtonText(return_val);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={recipient}
                onChange={(e)=>{setRecipient(e.target.value)}}

              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e)=>{setamount(e.target.value)}}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled= {isDisable}>
          Transfer
          </button>
          
        </p>
        <label>{buttonText}</label>
      </div>
    </div>
  );
}

export default Transfer;
