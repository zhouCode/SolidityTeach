// --- 任务一：区块链浏览器 (答案) ---

console.log("--- 任务一：区块链浏览器 ---");

// 1. 获取账户列表
let myAccounts;
(async () => {
    myAccounts = await web3.eth.getAccounts(); //
    console.log("可用账户:", myAccounts);

    // 2. 获取第一个账户的余额
    const addressToCheck = myAccounts[0];
    const balanceInWei = await web3.eth.getBalance(addressToCheck); //
    console.log("账户余额:", web3.utils.fromWei(balanceInWei, "ether"), "ETH");

})();


// 3. 获取当前区块编号 和区块详情
(async () => {
    const blockNum = await web3.eth.getBlockNumber(); //
    console.log("当前区块号:", blockNum);

    const block = await web3.eth.getBlock(blockNum, true); //
    console.log("最新区块详情:", block);
    
    // 4. 获取区块中的交易数量
    console.log("区块中的交易数量:", block.transactions.length); //
})();