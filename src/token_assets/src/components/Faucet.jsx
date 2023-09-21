import React, { useState } from "react";
import {token,canisterId, createActor} from "../../../declarations/token";
import { AuthClient} from "../../../../node_modules/@dfinity/auth-client/lib/cjs/index";


function Faucet(props) {


  const [isDisable, setDisable] = useState(false);
  const [buttonText,setButtonText] = useState("Create Wallet and JUGAAR Me Some Token");

  async function handleClick(event) {
    setDisable(true);

    const authClient = await AuthClient.create();
    const identity = await authClient.getIdentity();

    const authenticatedCanister = createActor(canisterId,{
      agentOptions: {
        identity,
      },
    });

    const result= await authenticatedCanister.payOut();
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
      <label>Your Account is {props.uPrincipal}</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisable}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
