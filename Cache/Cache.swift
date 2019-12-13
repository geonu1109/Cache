//
//  Cache.swift
//  Cache
//
//  Created by 전건우 on 2019/12/13.
//  Copyright © 2019 Daou Technology Inc. All rights reserved.
//

import Foundation

class Cache: ObservableObject {
    private var sets: [CacheSet]
    
    let numberOfSets: Int
    let numberOfBlocks: Int
    let numberOfWords: Int
    
    init(numberOfSets: Int, numberOfBlocks: Int, numberOfWords: Int) {
        self.numberOfSets = numberOfSets
        self.numberOfBlocks = numberOfBlocks
        self.numberOfWords = numberOfWords
        
        self.sets = (0 ..< numberOfSets).map { _ in CacheSet(numberOfBlocks: numberOfBlocks, numberOfWords: numberOfWords) }
    }
    
    func findAddress(_ address: Int) -> Bool {
        let index: Int = address / (self.numberOfSets * self.numberOfWords)
        return self.sets[index].findAddress(address)
    }
}

fileprivate class CacheSet {
    let blocks: [CacheBlock]
    
    let numberOfBlocks: Int
    let numberOfWords: Int
    
    init(numberOfBlocks: Int, numberOfWords: Int) {
        self.numberOfBlocks = numberOfBlocks
        self.numberOfWords = numberOfWords
        
        self.blocks = (0 ..< numberOfBlocks).map { _ in CacheBlock(numberOfWords: numberOfWords) }
    }
    
    func findAddress(_ address: Int) -> Bool {
        for block in blocks {
            guard let startAddress = block.startAddress else {
                continue
            }
            if startAddress == (address - address % numberOfWords) {
                block.age = 0
                return true
            }
        }
    }
}

fileprivate class CacheBlock {
    var startAddress: Int? = nil
    var age: Int = 0
    let numberOfWords: Int
    
    init(numberOfWords: Int) {
        self.numberOfWords = numberOfWords
    }
}
