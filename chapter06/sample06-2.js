// 获取当前区块号

(async () => {
    console.log("--- 6.2.2 获取当前区块编号 (Web3.js) ---");
    try {
        const blockNumWeb3 = await web3.eth.getBlockNumber();
        console.log("Web3.js 当前区块号:", blockNumWeb3);
    } catch (e) {
        console.error("Web3.js 部分出错:", e);
    }

    console.log("\n" + "---".repeat(10) + "\n");

    console.log("--- 6.2.2 获取当前区块编号 (Ethers.js) ---");
    try {
        // Ethers v5 (Remix) 必须手动创建 Provider
        const provider = new ethers.providers.Web3Provider(web3.currentProvider);
        
        // 使用我们自己创建的 provider 实例
        const blockNumEthers = await provider.getBlockNumber();
        console.log("Ethers.js 当前区块号:", blockNumEthers);
    } catch (e) {
        console.error("Ethers.js 部分出错:", e);
    }
})();