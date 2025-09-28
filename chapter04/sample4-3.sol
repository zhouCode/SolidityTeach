// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//声明合约
contract Demo{
  function print_weekday(uint _index) public pure returns(string memory) {
      string memory weekday = "";
      if(_index==1) {
        weekday = "Monday";
      }
      else if(_index==2){
        weekday = "Tuesday";  
      }
      else if(_index==3){
        weekday = "Wednesday";  
      }
      else if(_index==4){
        weekday = "Thursday";  
      }
      else if(_index==5){
        weekday = "Friday";  
      }
      else if(_index==6){
        weekday = "Saturday";  
      }
      else if(_index==7){
        weekday = "Sunday";  
      }
      else{
        weekday="Out of range";
      }
      return weekday;
  }
}
