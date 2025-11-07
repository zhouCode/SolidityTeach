// 获取账户列表

(async () => {
    console.log("--- 6.3.1 获取账户列表 (Web3.js) ---");
    try {
        let accountsWeb3 = await web3.eth.getAccounts();
        console.log("Web3.js 账户:", accountsWeb3, "..."); // accountsWeb3 是地址字符串数组
    } catch (e) {
        console.error("Web3.js 部分出错:", e);
    }

    console.log("\n" + "---".repeat(10) + "\n");

    console.log("--- 6.3.1 获取账户列表 (Ethers.js) ---");
    try {
        // Ethers v5 (Remix) 必须手动创建 Provider
        const provider = new ethers.providers.Web3Provider(web3.currentProvider);
        
        // Ethers.js v5 获取账户列表 (对应 web3.eth.getAccounts)
        const accountsEthers = await provider.listAccounts();
        console.log("Ethers.js 账户:", accountsEthers[0], "..."); // accountsEthers 也是地址字符串数组

        // 获取 Signer 对象的方式如下：
        // Signer 是一个包含私钥并可以签署交易的对象
        const signer0 = provider.getSigner(accountsEthers[0]);
        console.log("Ethers.js 第一个签名者 (Signer) 对象:", signer0);
        
    } catch (e) {
        console.error("Ethers.js 部分出错:", e);
    }
})();