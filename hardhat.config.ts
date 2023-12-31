import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "solidity-coverage"
import "hardhat-watcher"
const config: HardhatUserConfig = {
  solidity: {
    version:"0.8.18",
    
    
  },
  paths:{
    artifacts:"../amzfront/src/artifacts"
  },
  networks:{
    hardhat:{
      chainId:1337
    }
  },
   watcher: {
    compilation: {
      tasks: ['compile'],

    },
 test: {
      tasks: [{ command: 'test', params: { testFiles: ['{path}'] } }],
      files: ['./test/**/*'],
      verbose: true,
     
    }
  },
};

export default config;
