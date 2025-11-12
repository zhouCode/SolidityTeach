// --- 任务二：通过JS脚本部署新合约 (Storage.sol) ---
// (注意：ABI 和 BYTECODE 必须由学生在自己的环境中获取)

(async () => {
    try {
        // TODO 1: (示例 ABI，实际应从 Remix 复制)
        const YOUR_ABI = [
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
		"inputs": [],
		"name": "retrieve",
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
		"name": "store",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]; 
        
        // TODO 2: (示例 Bytecode，实际应从 Remix 复制)
        const YOUR_BYTECODE = "6080604052348015600e575f5ffd5b5060405161020f38038061020f8339818101604052810190602e9190606b565b805f81905550506091565b5f5ffd5b5f819050919050565b604d81603d565b81146056575f5ffd5b50565b5f815190506065816046565b92915050565b5f60208284031215607d57607c6039565b5b5f6088848285016059565b91505092915050565b6101718061009e5f395ff3fe608060405234801561000f575f5ffd5b506004361061003f575f3560e01c806323fd0e40146100435780632e64cec1146100615780636057361d1461007f575b5f5ffd5b61004b61009b565b60405161005891906100c9565b60405180910390f35b6100696100a0565b60405161007691906100c9565b60405180910390f35b61009960048036038101906100949190610110565b6100a8565b005b5f5481565b5f5f54905090565b805f8190555050565b5f819050919050565b6100c3816100b1565b82525050565b5f6020820190506100dc5f8301846100ba565b92915050565b5f5ffd5b6100ef816100b1565b81146100f9575f5ffd5b50565b5f8135905061010a816100e6565b92915050565b5f60208284031215610125576101246100e2565b5b5f610132848285016100fc565b9150509291505056fea264697066735822122015892740c9029885570313e1f77e6ac040e379574999203eb4efdde62c7874e864736f6c634300081e0033"; // <-- 替换为你的 Bytecode

        
        const accounts = await web3.eth.getAccounts();
        
        // 3. 创建合约对象（不带地址）
        // TODO 3: 补全 web3.eth.Contract(abi)
        const contract = new web3.eth.Contract(YOUR_ABI);

        console.log("正在部署 Storage 合约...");
        // 4. 准备部署交易
        // TODO 4: 补全 .deploy() 方法，传入 bytecode 和构造函数参数 [10]
        const deployTx = contract.deploy({
            data: YOUR_BYTECODE,
            arguments: [10] // 构造函数的 _initialNumber
        });

        // 5. 发送部署交易
        // TODO 5: 补全 .send()
        const deployedContract = await deployTx.send({
            from: accounts[0],
            gas: 1500000 
        });
        
        console.log("合约已部署在:", deployedContract.options.address);
        
        // 6. 与新部署的合约交互
        console.log("调用 retrieve()，初始值应为10:");
        let value = await deployedContract.methods.retrieve().call();
        console.log("值:", value);

        console.log("正在调用 store(77)...");
        // TODO 6: 补全 .store(77).send()
        await deployedContract.methods.store(77).send({ from: accounts[0] });

        console.log("再次调用 retrieve()，值应为77:");
        // TODO 7: 补全 .retrieve().call()
        value = await deployedContract.methods.retrieve().call();
        console.log("新值:", value);

    } catch (e) {
        console.error("任务二出错:", e.message);
    }
})();