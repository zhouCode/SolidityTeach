// full_flow.js
// 6.4 和 6.5：部署合约并与之交互

// 1. 粘贴 ABI: (它应该是一个 [...] 数组)
const CONTRACT_ABI = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_initialNumber",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "get",
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
		"name": "myNumber",
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
				"internalType": "uint256",
				"name": "_newNumber",
				"type": "uint256"
			}
		],
		"name": "set",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

// 2. 粘贴 Bytecode: (它应该是一个 "0x..." 长字符串)
const CONTRACT_BYTECODE = "608060405234801561000f575f80fd5b5060405161021d38038061021d83398181016040528101906100319190610074565b805f819055505061009f565b5f80fd5b5f819050919050565b61005381610041565b811461005d575f80fd5b50565b5f8151905061006e8161004a565b92915050565b5f602082840312156100895761008861003d565b5b5f61009684828501610060565b91505092915050565b610171806100ac5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c806323fd0e401461004357806360fe47b1146100615780636d4ce63c1461007d575b5f80fd5b61004b61009b565b60405161005891906100c9565b60405180910390f35b61007b60048036038101906100769190610110565b6100a0565b005b6100856100a9565b60405161009291906100c9565b60405180910390f35b5f5481565b805f8190555050565b5f8054905090565b5f819050919050565b6100c3816100b1565b82525050565b5f6020820190506100dc5f8301846100ba565b92915050565b5f80fd5b6100ef816100b1565b81146100f9575f80fd5b50565b5f8135905061010a816100e6565b92915050565b5f60208284031215610125576101246100e2565b5b5f610132848285016100fc565b9150509291505056fea26469706673582212203bad5dccb2ee0341c30d23c7546eff9b0ff4d8eea06556f2cd1df39e9edb23f764736f6c63430008180033";

// 3. 定义合约的构造函数参数 (我们的是 _initialNumber)
const INITIAL_VALUE = 123;


(async () => {
    
    console.log("=== 完整流程演示开始 ===");

    // =============================================
    // --- 1. Web3.js 演示 (部署与交互) ---
    // =============================================
    console.log("\n--- 1. Web3.js 演示 ---");
    try {
        const accounts = await web3.eth.getAccounts();
        const deployerAccount = accounts[0];
        console.log("Web3.js 将使用账户:", deployerAccount);

        // 1.1 创建合约对象 (此时没有地址)
        const storageContract_Web3 = new web3.eth.Contract(CONTRACT_ABI);

        // 1.2 准备部署交易
        const deployTx = storageContract_Web3.deploy({
            data: CONTRACT_BYTECODE,
            arguments: [INITIAL_VALUE] // 传入构造函数参数
        });

        // 1.3 发送部署交易
        console.log("Web3.js 正在部署合约...");
        const deployedContract = await deployTx.send({
            from: deployerAccount,
            gas: 1500000 // (需要估算，但 150w 足够)
        });
        
        const contractAddress_Web3 = deployedContract.options.address;
        console.log("Web3.js 合约已部署在:", contractAddress_Web3);

        // 1.4 与合约交互
        console.log("Web3.js 正在调用 set(42)...");
        await deployedContract.methods.set(42).send({ from: deployerAccount });

        console.log("Web3.js 正在调用 get()...");
        const value_Web3 = await deployedContract.methods.get().call();
        console.log("Web3.js 读取到的值:", value_Web3); // 应该是 "42"

    } catch (e) {
        console.error("Web3.js 部分出错:", e);
    }

})();