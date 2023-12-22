// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract LogisticsDocumentation {
    struct Document {
        string documentHash; 
        address uploader;   
        uint256 timestamp;   
    }

    mapping(uint256 => Document) public documents; 
    uint256 public documentCount; 

    event DocumentAdded(uint256 indexed docId, string documentHash, address indexed uploader, uint256 timestamp);
    
    function addDocument(string memory _documentHash) public {
        require(bytes(_documentHash).length > 0, "Document hash cannot be empty");
        documentCount++;
        documents[documentCount] = Document(_documentHash, msg.sender, block.timestamp);
        emit DocumentAdded(documentCount, _documentHash, msg.sender, block.timestamp);
    }

    function getDocument(uint256 _docId) public view returns (string memory, address, uint256) {
        require(_docId > 0 && _docId <= documentCount, "Invalid document ID");
        Document memory doc = documents[_docId];
        return (doc.documentHash, doc.uploader, doc.timestamp);
    }

    function getTotalDocuments() public view returns (uint256) {
        return documentCount;
    }
}
