import { dbank } from "../../declarations/dbank";

async function handleCurrVisibleBalance (){
  const currAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = currAmount.toFixed(2);
}

window.addEventListener("load", async () => {
  console.log("Finished loading");
  await handleCurrVisibleBalance();
});

document.querySelector("form").addEventListener("submit", async function (event) {
  event.preventDefault();
  // console.log("Submitted");

  const button = document.querySelector("#submit-btn");
  
  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);
  
  button.setAttribute("disabled", true);
  button.value = "Processing...";

  if(!isNaN(inputAmount)){
    await dbank.topUp(inputAmount);
    document.getElementById("input-amount").value = "";
  }
  
  if(!isNaN(outputAmount)){
    await dbank.widthdraw(outputAmount);
    document.getElementById("withdrawal-amount").value = "";
  }

  await dbank.compound();
  handleCurrVisibleBalance();
  
  button.removeAttribute("disabled");
  button.value = "Finalise Transaction";

  
});


// dfx canister --network=ic call fg7gi-vyaaa-aaaal-qadca-cai redeem '("a048d338-8e3c-442e")'