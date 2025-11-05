// 获取账户余额

(async () => {
    
    let address; // 在外部声明，以便两个部分都能使用

    console.log("--- 6.3.3 获取账户余额 (Web3.js) ---");
    try {
        const accounts = await web3.eth.getAccounts();
        address = accounts[0];

        const balanceWeiWeb3 = await web3.eth.getBalance(address); // 结果是 Wei (字符串)
        
        console.log("Web3.js 余额 (Wei):", balanceWeiWeb3);
        console.log("Web3.js 余额 (ETH):", web3.utils.fromWei(balanceWeiWeb3, "ether"));
    } catch (e) {
        console.error("Web3.js 部分出错:", e);
    }

    console.log("\n" + "---".repeat(10) + "\n");

    console.log("--- 6.3.3 获取账户余额 (Ethers.js) ---");
    try {
        // Ethers v5 (Remix) 必须手动创建 Provider
        const provider = new ethers.providers.Web3Provider(web3.currentProvider);
        
        // 确保我们有地址（如果 web3 部分失败，就重新获取）
        if (!address) {
            const accountsEthers = await provider.listAccounts();
            address = accountsEthers[0];
        }

        const balanceWeiEthers = await provider.getBalance(address); // 结果是 BigNumber 对象
        console.log("Ethers.js 余额 (Wei):", balanceWeiEthers.toString());
        // (注意: v5 的工具函数在 ethers.utils 中)
        console.log("Ethers.js 余额 (ETH):", ethers.utils.formatEther(balanceWeiEthers));
    } catch (e) {
        console.error("Ethers.js 部分出错:", e);
    }
})();