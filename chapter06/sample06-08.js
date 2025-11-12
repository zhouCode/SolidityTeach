// function_selector_demo.js
(async () => {
    
    console.log("--- 函数选择器演示 ---");
    console.log("例子: 'sum_for(uint256)'");

    const functionSignature = "sum_for(uint256)";

    // --- 1. Web3.js (现代 v1.x) 方式 ---
    // (Remix 自动注入了 web3.utils)
    try {
        const hash_web3 = web3.utils.keccak256(functionSignature);
        console.log("\nWeb3.js (keccak256) 哈希结果:", hash_web3);
        
        // 截取前 4 字节 (0x + 8 个字符)
        const selector_web3 = hash_web3.substring(0, 10);
        console.log("Web3.js 函数选择器:", selector_web3);
    } catch(e) {
        console.error("Web3.js 出错:", e);
    }

    // --- 2. Ethers.js (v5) 方式 ---
    // (Remix 自动注入了 ethers.utils)
    try {
        // Ethers.js 需要先将字符串转为 bytes
        const textBytes = ethers.utils.toUtf8Bytes(functionSignature);
        const hash_ethers = ethers.utils.keccak256(textBytes);
        console.log("\nEthers.js (keccak256) 哈希结果:", hash_ethers);

        const selector_ethers = hash_ethers.substring(0, 10);
        console.log("Ethers.js 函数选择器:", selector_ethers);
    } catch(e) {
        console.error("Ethers.js 出错:", e);
    }

})();