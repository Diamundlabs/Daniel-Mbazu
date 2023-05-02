
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract POE {
    mapping(uint => bytes32) public documentHashes;
    mapping(bytes32 => bool) public proofs;
    uint public documentId;

    function storeProof(string memory document) public {
        bytes32 documentHash = calculateHash(document);
        documentHashes[documentId] = documentHash;
        proofs[documentHash] = true;
        documentId++;
    }

    function calculateHash(string memory document) public view returns (bytes32) {
        bytes32 documentHash = sha256(abi.encodePacked(msg.sender, block.timestamp, document));
        return documentHash;
    }

    function getDocumentHash(uint index) public view returns (bytes32) {
        require(index < documentId, "Index out of range");
        bytes32 documentHash = documentHashes[index];
        return documentHash;
    }

    function proofExists(bytes32 documentHash) public view returns (bool) {
        return proofs[documentHash];
    }
}
