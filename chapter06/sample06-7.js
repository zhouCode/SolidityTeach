// 演示 6.3.4 - 6.3.9
// 使用 Ethers.js v5

(async () => {
    try {
        console.log("=== Ethers.js v5 (Remix) 演示开始 ===");

        // --- 准备工作：手动创建 v5 Provider 和 Signer ---
        const provider = new ethers.providers.Web3Provider(web3.currentProvider);
        const accountAddresses = await provider.listAccounts();
        const fromAddress = accountAddresses[0];
        const toAddress = accountAddresses[1];
        const signer1 = provider.getSigner(fromAddress);

        console.log(`准备从 ${fromAddress} 发送 1 ETH 到 ${toAddress}`);

        // --- 6.3.9 估算交易的 Gas 用量 ---
        const txParams = {
            to: toAddress,
            value: ethers.utils.parseEther("1.0") 
        };
        const gasEstimate = await provider.estimateGas(txParams);
        console.log(`[6.3.9] 估算 Gas (estimateGas): ${gasEstimate.toString()} Gwei`);

        // --- 6.3.8 向以太坊网络提交交易 ---
        console.log("[6.3.8] 正在提交交易 (sendTransaction)..."); 
        const txResponse = await signer1.sendTransaction(txParams);
        const txReceipt = await txResponse.wait(); 
        console.log("[6.3.8] 交易已确认！哈希:", txReceipt.transactionHash);

        // --- 6.3.7 获取交易的收据对象 ---
        const receipt = await provider.getTransactionReceipt(txReceipt.transactionHash); 
        console.log(`[6.3.7] 获取收据 (getTransactionReceipt): 状态 ${receipt.status}, Gas使用 ${receipt.gasUsed.toString()}`);
        
        const txHash = receipt.transactionHash;
        const blockNum = receipt.blockNumber;
        const txIndex = receipt.transactionIndex;
        
        // --- 6.3.6 根据交易哈希获取交易对象 ---
        const tx = await provider.getTransaction(txHash); 
        console.log(`[6.3.6] 获取交易 (getTransaction): 交易金额 ${ethers.utils.formatEther(tx.value)} ETH`);

        // --- 6.3.4 获取指定区块中的交易数量 ---

        // 用 provider.getBlockWithTransactions()，它会返回完整的交易对象
        const block = await provider.getBlockWithTransactions(blockNum); 
        
        const txCountInBlock = block.transactions.length;
        // 这次，它应该会正确打印 "1"
        console.log(`[6.3.4] 区块 ${blockNum} 中的交易数 (getBlockWithTransactions.length): ${txCountInBlock}`);


        // --- 6.3.5 获取指定区块中的交易详情 ---
        // (现在 block.transactions 是一个包含完整交易对象的数组)
        const txFromBlock = block.transactions[txIndex]; 
        
        // 这次，txFromBlock 将是
        // 一个有效的交易对象，不再是 undefined
        console.log(`[6.3.5] 从区块获取交易 (block.transactions[i]): 哈希 ${txFromBlock.hash}`);
        console.log(`[6.3.5] 从区块获取交易 (getTransactionFromBlock): 详情: `);
        for (const key in txFromBlock) {
            console.log(`${key}: ${txFromBlock[key]}`); // 输出: a, b, c
        }
        console.log("=== Ethers.js v5 (Remix) 演示结束 ===");

    } catch (e) {
        console.error("Ethers.js v5 脚本出错:", e);
    }
})();