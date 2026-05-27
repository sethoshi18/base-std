// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IB20Stablecoin} from "src/interfaces/IB20Stablecoin.sol";
import {IB20} from "src/interfaces/IB20.sol";
import {B20Constants} from "src/lib/B20Constants.sol";

import {B20StablecoinTest} from "test/lib/B20StablecoinTest.sol";

contract B20StablecoinUpdateReserveURITest is B20StablecoinTest {
    function test_updateReserveURI_revert_unauthorized(address caller, string calldata newURI) public {
        _assumeValidCaller(caller);
        vm.assume(caller != admin);

        vm.prank(caller);
        vm.expectRevert(
            abi.encodeWithSelector(IB20.AccessControlUnauthorizedAccount.selector, caller, B20Constants.METADATA_ROLE)
        );
        IB20Stablecoin(address(token)).updateReserveURI(newURI);
    }

    function test_updateReserveURI_updatesStorageAndEmitsEvent(string calldata newURI) public {
        _grantRole(B20Constants.METADATA_ROLE, admin);
        vm.expectEmit(false, false, false, true, address(token));
        emit IB20Stablecoin.ReserveURIUpdated();

        vm.prank(admin);
        IB20Stablecoin(address(token)).updateReserveURI(newURI);

        assertEq(
            IB20Stablecoin(address(token)).reserveURI(),
            newURI,
            "reserveURI() must return updated value"
        );
    }
}
