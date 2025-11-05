// --- 任务二：交易的提交与分析 (答案) ---

console.log("--- 任务二：交易的提交与分析 ---");

const contractAddress = "0x0813d4a158d06784FDB48323344896B2B1aa0F85"; // <-- 替换成你的合约地址
let fromAccount;

(async () => {
    try {
        // 1. 获取操作账户
        const accounts = await web3.eth.getAccounts();
        fromAccount = accounts[0];

        // 2. 定义交易内容
        const txToSend = {
            from: fromAccount,
            to: contractAddress,
            value: web3.utils.toWei("1", "ether")
        };

        // 3. 估算交易的Gas用量
        const gasEstimate = await web3.eth.estimateGas(txToSend); //
        console.log("预估Gas量:", gasEstimate);
        txToSend.gas = gasEstimate;

        // 4. 提交交易
        console.log("正在发送交易...");
        const receipt = await web3.eth.sendTransaction(txToSend); //

        // 5. 获取交易收据
        console.log("交易已确认，收据:", receipt); //
        const txHash = receipt.transactionHash;
        console.log("交易哈希(TxHash):", txHash);
        
        // 6. 根据交易哈希获取交易对象
        const txDetails = await web3.eth.getTransaction(txHash); //
        console.log("完整的交易详情:", txDetails);

    } catch (err) {
        console.error("交易失败:", err.message);
    }
})();