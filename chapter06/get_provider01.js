// get_provider01.js
// 1. 引入库
// 如果使用 NPM:
import Web3 from 'web3';
// 如果使用 <script> 标签, Web3 会被自动挂载到 window 对象上

async function runWeb3() {
    let web3;

    // 2. 实例化和连接 Provider
    // 检查是否有现代钱包 (MetaMask, etc.)
    if (window.ethereum) {
        console.log("检测到钱包，正在连接...");
        web3 = new Web3(window.ethereum);
        try {
            // 请求用户授权账户
            await window.ethereum.request({ method: 'eth_requestAccounts' });
        } catch (error) {
            console.error("用户拒绝了连接请求");
            return;
        }
    } else {
    // 如果没有钱包，提供一个"只读"的备用 Provider
    // (!! 注意：您需要注册 Infura/Alchemy 来获取 YOUR_API_KEY)
        console.log("未检测到钱包，使用只读 Provider (Infura)");
        const readOnlyProvider = new Web3.providers.HttpProvider('https://mainnet.infura.io/v3/YOUR_API_KEY');
        web3 = new Web3(readOnlyProvider);
    }

    // --- 从这里开始，才是您在 Remix 中运行的代码 ---
    try {
        console.log("开始执行脚本...");
        const nodeInfo = await web3.eth.getNodeInfo();
        console.log(nodeInfo);

        const protocolVersion = await web3.eth.getProtocolVersion();
        console.log("Protocol Version:", protocolVersion);
    } catch (e) {
        console.error("执行 web3 脚本时出错:", e);
    }
}

// 启动函数
runWeb3();