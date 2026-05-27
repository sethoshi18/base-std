// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IB20Stablecoin} from "src/interfaces/IB20Stablecoin.sol";
import {B20Constants} from "src/lib/B20Constants.sol";

import {B20StablecoinTest} from "test/lib/B20StablecoinTest.sol";

contract B20StablecoinReserveURITest is B20StablecoinTest {
    function test_reserveURI_success_defaultIsEmptyString() public view {
        assertEq(
            IB20Stablecoin(address(token)).reserveURI(),
            "",
            "reserveURI() must be empty by default"
        );
    }

    function test_reserveURI_returnsStorageValue(string calldata uri) public {
        _grantRole(B20Constants.METADATA_ROLE, admin);
        vm.prank(admin);
        IB20Stablecoin(address(token)).updateReserveURI(uri);

        assertEq(
            IB20Stablecoin(address(token)).reserveURI(),
            uri,
            "reserveURI() must return stored value"
        );
    }
}
