let  Web3=require('web3');
let web3= new Web3(new Web3.providers.HttpProvider("https://eth-ropsten.alchemyapi.io/v2/qq9OueYBuxnnODdvCm_KTGRRGQMdW0lL"));
const erc20=require('./erc20')
const abi=[
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_assetId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_priceInWei",
				"type": "uint256"
			}
		],
		"name": "acceptBid",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_acceptedToken",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			}
		],
		"name": "BidAccepted",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			}
		],
		"name": "BidCancelled",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "nftAddress",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "assetId",
				"type": "uint256"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "bidder",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "priceInWei",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "expiresAt",
				"type": "uint256"
			}
		],
		"name": "BidCreated",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_assetId",
				"type": "uint256"
			}
		],
		"name": "cancelBid",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_assetId",
				"type": "uint256"
			}
		],
		"name": "cancelOrder",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "cutPerMillion",
				"type": "uint256"
			}
		],
		"name": "ChangedFeePerMillion",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_assetId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_priceInWei",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_expiresAt",
				"type": "uint256"
			}
		],
		"name": "createOrder",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			},
			{
				"internalType": "bytes",
				"name": "",
				"type": "bytes"
			}
		],
		"name": "onERC721Received",
		"outputs": [
			{
				"internalType": "bytes4",
				"name": "",
				"type": "bytes4"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			}
		],
		"name": "OrderCancelled",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "seller",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "nftAddress",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "assetId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "priceInWei",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "expiresAt",
				"type": "uint256"
			}
		],
		"name": "OrderCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "buyer",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "priceInWei",
				"type": "uint256"
			}
		],
		"name": "OrderSuccessful",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "priceInWei",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "expiresAt",
				"type": "uint256"
			}
		],
		"name": "OrderUpdated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "previousOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "Paused",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_assetId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_priceInWei",
				"type": "uint256"
			}
		],
		"name": "safeExecuteOrder",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_assetId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_priceInWei",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_expiresAt",
				"type": "uint256"
			}
		],
		"name": "safePlaceBid",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_cutPerMillion",
				"type": "uint256"
			}
		],
		"name": "setOwnerCutPerMillion",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bool",
				"name": "_setPaused",
				"type": "bool"
			}
		],
		"name": "setPaused",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "Unpaused",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_assetId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_priceInWei",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_expiresAt",
				"type": "uint256"
			}
		],
		"name": "updateOrder",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "_INTERFACE_ID_ERC721",
		"outputs": [
			{
				"internalType": "bytes4",
				"name": "",
				"type": "bytes4"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "acceptedToken",
		"outputs": [
			{
				"internalType": "contract IERC20",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "bidByOrderId",
		"outputs": [
			{
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			},
			{
				"internalType": "address",
				"name": "bidder",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "price",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "expiresAt",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "cutPerMillion",
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
		"name": "maxCutPerMillion",
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
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "orderByAssetId",
		"outputs": [
			{
				"internalType": "bytes32",
				"name": "id",
				"type": "bytes32"
			},
			{
				"internalType": "address",
				"name": "seller",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "nftAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "price",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "expiresAt",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
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
		"name": "paused",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
const contractaddress='0x58E5431c617136Fc642867Ae68e6F012d5Ed89d9';
const contract=new web3.eth.Contract(abi,contractaddress);

// allGetFunctions=async()=>{
//     try{
//     let acceptedToken=await contract.methods.acceptedToken().call();
//     console.log("acceptedToken===>",acceptedToken);
//     let owner=await contract.methods.owner().call();
//     console.log("owner===>",owner);
//     let cutPerMillion=await contract.methods.cutPerMillion().call();
//     console.log("cutPerMillion===>",cutPerMillion); 
//     let maxCutPerMillion=await contract.methods.maxCutPerMillion().call();
//     console.log("maxCutPerMillion===>",maxCutPerMillion);

// 	const bidByOrderId = await contract.methods.bidByOrderId("0xd3Ff00D23c84a79B8F521F6707F5BDf2A9a8A3E4","0").call();
//     console.log("bidByOrderId====>", bidByOrderId);
    
// 	const orderByAssetId = await contract.methods.orderByAssetId("0xd3Ff00D23c84a79B8F521F6707F5BDf2A9a8A3E4","0").call();
//     console.log("orderByAssetId====>", orderByAssetId);
//     }
// 	catch(error){
//         console.log("error===672",error)
//     }
// }
// allGetFunctions();

// const createOrder=async()=>{
//     try {
//         var count = await web3.eth.getTransactionCount("0xd3Ff00D23c84a79B8F521F6707F5BDf2A9a8A3E4");
//         console.log("count===>",count);
//         const data = await contract.methods.createOrder("0xb7974ab852BD6c6c001414B25DD5B8B8a424de86","2","10000000000000000000","1644172412").encodeABI()
        
//         console.log('helloooo===>',await web3.eth.getGasPrice());
//         var rawTransaction = {
//             "to": contractaddress,
//             "nonce": web3.utils.toHex(count),
//             "gasPrice": web3.utils.toHex('17000000640'),
//             "gasLimit": web3.utils.toHex('3000000'),
//             "data": data,
        
//         };

//         const signedTx = await web3.eth.accounts.signTransaction(rawTransaction, '5adcef2aac5893784f5bc18948cd2e18e2e39287a1293c46bfee991ec78de180')
//         console.log('helloooo===>', signedTx);

//         const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
//         console.log(`Transaction hash: ${receipt.transactionHash}`);

//     } catch (error) {
//         console.log("error========>", error);
//     }
// }
// createOrder();


// const updateOrder=async()=>{
//     try {
//         var count = await web3.eth.getTransactionCount("0xd3Ff00D23c84a79B8F521F6707F5BDf2A9a8A3E4");
//         console.log("count===>",count);
//         const data = await contract.methods.updateOrder("0xb7974ab852BD6c6c001414B25DD5B8B8a424de86","2","10000000000000","1644172412").encodeABI()
        
//         console.log('helloooo===>',await web3.eth.getGasPrice());
//         var rawTransaction = {
//             "to": contractaddress,
//             "nonce": web3.utils.toHex(count),
//             "gasPrice": web3.utils.toHex('17000000640'),
//             "gasLimit": web3.utils.toHex('210000'),
//             "data": data,
        
//         };

//         const signedTx = await web3.eth.accounts.signTransaction(rawTransaction, '5adcef2aac5893784f5bc18948cd2e18e2e39287a1293c46bfee991ec78de180')
//         console.log('helloooo===>', signedTx);

//         const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
//         console.log(`Transaction hash: ${receipt.transactionHash}`);

//     } catch (error) {
//         console.log("error========>", error);
//     }
// }
// updateOrder();


const acceptBid=async()=>{
    try {
        var count = await web3.eth.getTransactionCount("0xd3Ff00D23c84a79B8F521F6707F5BDf2A9a8A3E4");
        console.log("count===>",count);
        const data = await contract.methods.acceptBid("0xb7974ab852BD6c6c001414B25DD5B8B8a424de86","2","1000000000").encodeABI()
        
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
acceptBid();
