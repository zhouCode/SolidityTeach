// --- 任务一：与已部署合约交互 (Counter.sol) ---
// (注意：ABI 和 ADDRESS 必须由学生在自己的环境中获取)

(async () => {
    try {
        // TODO 1: (示例 ABI，实际应从 Remix 复制)
        const YOUR_ABI = [
	{
		"inputs": [],
		"name": "count",
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
		"name": "increment",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];
        
        // TODO 2: (示例地址，实际应从 Remix 复制)
        const YOUR_ADDRESS = "0xE5f2A565Ee0Aa9836B4c80a07C8b32aAd7978e22"; // <-- 替换为你的地址
        
        const accounts = await web3.eth.getAccounts();
        
        // TODO 3: 实例化合约对象
        const myContract = new web3.eth.Contract(YOUR_ABI, YOUR_ADDRESS);
        
        // 4. 读取初始值
        // TODO 4: 补全 .call()
        const initialCount = await myContract.methods.get().call();
        console.log("初始 Count:", initialCount);

        // 5. 发送交易 (increment)
        console.log("正在发送 increment() 交易...");
        // TODO 5: 补全 .send()
        await myContract.methods.increment().send({ from: accounts[0] });

        // 6. 验证新值
        // TODO 6: 补全 .call()
        const newCount = await myContract.methods.get().call();
        console.log("新的 Count:", newCount);

    } catch (e) {
        console.error("任务一出错:", e.message);
    }
})();