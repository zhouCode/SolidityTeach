// 获取指定区块详情

(async () => {

    // let blockNum; // 在外部定义，以便两个部分都能使用

    console.log("--- 6.2.4 获取指定区块详情 (Web3.js) ---");
    try {
        const blockNum = await web3.eth.getBlockNumber(); // 获取当前区块号
        console.log("Web3.js 当前区块号:", blockNum);

        // true = 包含完整交易对象
        const blockWeb3 = await web3.eth.getBlock(blockNum, true); 
        console.log("Web3.js 区块哈希:", blockWeb3.hash);
        console.log("Web3.js (含交易) 区块中的交易数量:", blockWeb3.transactions.length);
    } catch (e) {
        console.error("Web3.js 部分出错:", e);
    }

    console.log("\n" + "---".repeat(10) + "\n");

    console.log("--- 6.2.4 获取指定区块详情 (Ethers.js) ---");
    try {
        // Ethers v5 (Remix) 必须手动创建 Provider
        const provider = new ethers.providers.Web3Provider(web3.currentProvider);
        
        // Ethers.js 方式 (对应 web3.eth.getBlock(num, false))
        const blockEthers = await provider.getBlock(blockNum);
        // Ethers.js 默认只返回交易哈希
        // blockEthers.transactions 是一个哈希数组
        console.log("Ethers.js 区块哈希:", blockEthers.hash);
        console.log("Ethers.js (仅哈希) 区块中的交易数量:", blockEthers.transactions.length);

        // Ethers.js 方式 (对应 web3.eth.getBlock(num, true))
        const blockEthersWithTx = await provider.getBlockWithTransactions(blockNum);
        // blockEthersWithTx.transactions 是一个完整的交易对象数组
        console.log("Ethers.js (含交易) 区块中的交易数量:", blockEthersWithTx.transactions.length);
        
    } catch (e) {
        console.error("Ethers.js 部分出错:", e);
    }
})();