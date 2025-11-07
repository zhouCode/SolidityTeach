// 演示 6.3.4 - 6.3.9
// 使用 web3.js
(async () => {
    try {
        console.log("=== Web3.js 演示开始 ===");

        // --- 准备工作：获取账户 ---
        const accounts = await web3.eth.getAccounts();
        const fromAccount = accounts[0];
        const toAccount = accounts[1];
        console.log(`准备从 ${fromAccount} 发送 1 ETH 到 ${toAccount}`);

        // --- 6.3.9 估算交易的 Gas 用量 ---
        const txParams = {
            from: fromAccount,
            to: toAccount,
            value: web3.utils.toWei("1", "ether")
        };
        const gasEstimate = await web3.eth.estimateGas(txParams);
        console.log(`[6.3.9] 估算 Gas (estimateGas): ${gasEstimate} Gwei`);

        // --- 6.3.8 向以太坊网络提交交易 ---
        console.log("[6.3.8] 正在提交交易 (sendTransaction)...");
        // sendTransaction 会返回"收据"
        const txReceipt = await web3.eth.sendTransaction(txParams);
        console.log("[6.3.8] 交易已确认！哈希:", txReceipt.transactionHash);

        // --- 6.3.7 获取交易的收据对象 ---
        // (注意：上一步的 txReceipt 就是收据了，这里我们为了演示 API 重新获取一次)
        const receipt = await web3.eth.getTransactionReceipt(txReceipt.transactionHash); 
        console.log(`[6.3.7] 获取收据 (getTransactionReceipt): 状态 ${receipt.status},
         Gas使用 ${receipt.gasUsed}`);
        console.log(`[6.3.7] 收据详情：`);
        for (const key in receipt) {
            console.log(`${key}: ${receipt[key]}`); // 输出: a, b, c
        }
        console.log(`=== 收据详情输出结束！ ===`);

        // 我们需要收据中的信息来进行下一步
        const txHash = receipt.transactionHash;
        const blockNum = receipt.blockNumber;
        const txIndex = receipt.transactionIndex;

        // --- 6.3.6 根据交易哈希获取交易对象 ---
        const tx = await web3.eth.getTransaction(txHash); 
        console.log(`[6.3.6] 获取交易 (getTransaction): 交易金额 ${web3.utils.fromWei(tx.value, "ether")} ETH`);

        // --- 6.3.4 获取指定区块中的交易数量 ---
        const txCountInBlock = await web3.eth.getBlockTransactionCount(blockNum);
        console.log(`[6.3.4] 区块 ${blockNum} 中的交易数 (getBlockTransactionCount): ${txCountInBlock}`);


        // --- 6.3.5 获取指定区块中的交易详情 ---
        const txFromBlock = await web3.eth.getTransactionFromBlock(blockNum, txIndex); 
        console.log(`[6.3.5] 从区块获取交易 (getTransactionFromBlock): 哈希 ${txFromBlock.hash}`);
        console.log(`[6.3.5] 从区块获取交易 (getTransactionFromBlock): 详情: `);
        for (const key in txFromBlock) {
            console.log(`${key}: ${txFromBlock[key]}`); // 输出: a, b, c
        }
        console.log("=== Web3.js 演示结束 ===");

    } catch (e) {
        console.error("Web3.js 脚本出错:", e);
    }
})();