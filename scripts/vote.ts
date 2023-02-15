import { ethers } from "hardhat";

async function main() {
    const ONE_GWEI = 1_000_000_000;
    const [admin, voter1, voter2] = await ethers.getSigners();
    const contender1 = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4";
    const contender2 = "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2";
    const contender3 = "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db";
    const VotingContract = await ethers.getContractFactory("votingContract");
    const votingContract = await VotingContract.deploy("NonoCoin", "NC");
    await votingContract.deployed();
    console.log(`Contract address is ${votingContract.address}`);

    /////////////////
    await votingContract.mintToken(5000);
    console.log(await votingContract.balanceOf(votingContract.address));



    // await votingContract.allowance(votingContract.address, admin.address)

    // await votingContract.transfer(votingContract.address, admin.address, 200);

    // await votingContract.purchaseToken({ value: 200 * ONE_GWEI })

    // let registration = await votingContract.registerContenders(contender1, contender2, contender3);
    // console.log(await registration);


    // let getContenders = await votingContract.contenders;
    // console.log(getContenders);

    // const adminBalance = await votingContract.balanceOf(admin.address);
    // console.log(adminBalance);


    // let VoteContenders = await votingContract.connect(admin).voteContenders(contender1, contender2, contender3);
    // // let getContendersAfter = await votingContract.contenders;
    // // console.log(getContendersAfter);

    // await votingContract.endVoting();


    // let checkBal = await votingContract.balanceOf("0x5FbDB2315678afecb367f032d93F642f64180aa3");
    // console.log(await checkBal.wait().)
    // const _checkBal = await checkBal;
    // console.log(_checkBal);

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

//0x5FbDB2315678afecb367f032d93F642f64180aa3