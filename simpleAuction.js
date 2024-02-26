let  Web3=require('web3');
let web3= new Web3(new Web3.providers.HttpProvider("https://eth-ropsten.alchemyapi.io/v2/SaaaeRwVO5MFpTBPSXi_5Y-x-qKpDeLr"));

const abi=[
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "biddingTime",
				"type": "uint256"
			},
			{
				"internalType": "address payable",
				"name": "beneficiaryAddress",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "AuctionAlreadyEnded",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "AuctionEndAlreadyCalled",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "AuctionNotYetEnded",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "highestBid",
				"type": "uint256"
			}
		],
		"name": "BidNotHighEnough",
		"type": "error"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "winner",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "AuctionEnded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "bidder",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "HighestBidIncreased",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "auctionEnd",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "auctionEndTime",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "beneficiary",
		"outputs": [
			{
				"internalType": "address payable",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "bid",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "highestBid",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "highestBidder",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "withdraw",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
const contractaddress='0x9379b392870b3B7EB27A63330777B044Ba8b9826'
const contract=new web3.eth.Contract(abi,contractaddress)



const allGetFunction=async()=>{
    let highestBid=await contract.methods.highestBid().call();
    console.log("highestBid===>",highestBid.toString());
    let highestBidder=await contract.methods.highestBidder().call();
    console.log("highestBidder===>",highestBidder)
    let beneficiary=await contract.methods.beneficiary().call();
    console.log("beneficiary===>",beneficiary)
    const auctionEndTime=await contract.methods.auctionEndTime().call();
    console.log("auctionEndTime===>",auctionEndTime)
}



const withdraw=async()=>{
    try {
        var count = await web3.eth.getTransactionCount("0xd3Ff00D23c84a79B8F521F6707F5BDf2A9a8A3E4");
        console.log("count===>",count);
        const data = await contract.methods.withdraw().encodeABI()
        
        console.log('helloooo===>',await web3.eth.getGasPrice());
        var rawTransaction = {
            "to": contractaddress,
            "nonce": web3.utils.toHex(count),
            "gasPrice": web3.utils.toHex('17000000640'),
            "gasLimit": web3.utils.toHex('210000'),
            "data": data,
        
        };

        const signedTx = await web3.eth.accounts.signTransaction(rawTransaction, '5adcef2aac5893784f5bc18948cd2e18e2e39287a1293c46bfee991ec78de180')
        console.log('helloooo===>', signedTx);

        const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
        console.log(`Transaction hash: ${receipt.transactionHash}`);

    } catch (error) {
        console.log("error========>", error);
    }
}


const auctionEnd=async()=>{
    try {
        var count = await web3.eth.getTransactionCount("0xd3Ff00D23c84a79B8F521F6707F5BDf2A9a8A3E4");
        console.log("count===>",count);
        const data = await contract.methods.auctionEnd().encodeABI()
        
        // console.log('helloooo===>',await web3.eth.getGasPrice());
        var rawTransaction = {
            "to": contractaddress,
            "nonce": web3.utils.toHex(count),
            "gasPrice": web3.utils.toHex('17000000640'),
            "gasLimit": web3.utils.toHex('210000'),
            "data": data
        };

        const signedTx = await web3.eth.accounts.signTransaction(rawTransaction, '5adcef2aac5893784f5bc18948cd2e18e2e39287a1293c46bfee991ec78de180')
        console.log('helloooo===>', signedTx);

        const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
        console.log(`Transaction hash: ${receipt.transactionHash}`);

    } catch (error) {
        console.log("error========>", error);
    }
}




const bid=async()=>{
    try {
        var count = await web3.eth.getTransactionCount("0xe09566Ab8775aE444f5cC8887247f0EDF3a547d4");
        console.log("count===>",count);
        const data = await contract.methods.bid().encodeABI()
        
        console.log('helloooo===>',await web3.eth.getGasPrice());
        // console.log('215 ===>',web3.utils.fromWei)

        var rawTransaction = {
            "to": contractaddress,
            "nonce": web3.utils.toHex(count),
            "gasPrice": web3.utils.toHex('17000000640'),
            "gasLimit": web3.utils.toHex('210000'),
            "data": data,
            "value":web3.utils.toWei('0.003')
        };
        
        const signedTx = await web3.eth.accounts.signTransaction(rawTransaction, '3633e825c4cfe79028883e8fc10ce8d87410396864cbba9ebb07de3429190500')
        console.log('helloooo===>', signedTx);

        const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
        console.log(`Transaction hash: ${receipt.transactionHash}`);

    } catch (error) {
        console.log("error========>", error);
    }
}
allGetFunction();
withdraw();
bid();
auctionEnd();