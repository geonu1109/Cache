//
//  Cache.swift
//  Cache
//
//  Created by 전건우 on 2019/12/13.
//  Copyright © 2019 Daou Technology Inc. All rights reserved.
//

import Foundation

class CacheConfiguration {
    let numberOfSets: Int
    let numberOfBlocks: Int
    let numberOfWords: Int
    
    init(numberOfSets: Int, numberOfBlocks: Int, numberOfWords: Int) {
        self.numberOfSets = numberOfSets
        self.numberOfBlocks = numberOfBlocks
        self.numberOfWords = numberOfWords
    }
}

class Cache: CustomDebugStringConvertible {
    let configuration: CacheConfiguration
    let sets: [CacheSet]
    
    var debugDescription: String {
        return sets.enumerated().map { (index, set) in
            return "set\(index):\n\(set.debugDescription)"
        }.joined(separator: "\n")
    }
    
    init(configuration: CacheConfiguration) {
        self.configuration = configuration
        self.sets = (0 ..< configuration.numberOfSets).map { _ in CacheSet(configuration: configuration) }
    }
    
    func findAddress(_ address: Int) -> Bool {
        let index: Int = address / (self.configuration.numberOfWords * 4) % self.configuration.numberOfSets
        let result = self.sets[index].findAddress(address)
        self.sets.forEach { $0.increaseAge() }
        return result
    }
}

class CacheSet: CustomDebugStringConvertible {
    let configuration: CacheConfiguration
    let blocks: [CacheBlock]
    
    var debugDescription: String {
        return blocks.enumerated().map { (index, block) in
            return "block\(index): \(block.debugDescription)"
        }.joined(separator: "\n")
    }
    
    init(configuration: CacheConfiguration) {
        self.configuration = configuration
        self.blocks = (0 ..< configuration.numberOfBlocks).map { _ in CacheBlock(configuration: configuration) }
    }
    
    func findAddress(_ address: Int) -> Bool {
        let result: Bool = blocks.map { (block) -> Bool in
            return block.hasAddress(address)
        }.reduce(false) { $0 || $1 }
        
        if result {
            return true
        }
        else {
            let index = blocks.enumerated().reduce(nil) { (result: (Int, CacheBlock)?, element) in
                let (index, cache) = element
                
                guard let result = result else {
                    return element
                }
                if result.1.startAddress == nil {
                    return result
                }
                else if cache.startAddress == nil {
                    return element
                }
                else {
                    return result.1.age < cache.age ? element : result
                }
            }?.0 ?? 0
            blocks[index].setAddress(address)
            return false
        }
    }
    
    func increaseAge() {
        self.blocks.forEach { $0.increaseAge() }
    }
}

class CacheBlock: CustomDebugStringConvertible {
    let configuration: CacheConfiguration
    var startAddress: Int? = nil
    var endAddress: Int? {
        return startAddress.map { $0 + self.configuration.numberOfWords * 4 - 1 }
    }
    var age: Int = 0
    
    var debugDescription: String {
        return "startAddress: \(startAddress.flatMap { String($0, radix: 16) } ?? "nil"), age: \(age)"
    }
    
    init(configuration: CacheConfiguration) {
        self.configuration = configuration
    }
    
    func hasAddress(_ address: Int) -> Bool {
        guard let startAddress = self.startAddress, let endAddress = self.endAddress else {
            return false
        }
        let result: Bool = address >= startAddress && address <= endAddress
        if result {
            self.age = 0
        }
        return result
    }
    
    func setAddress(_ address: Int) {
        self.startAddress = address - address % (self.configuration.numberOfWords * 4)
        self.age = 0
    }
    
    func increaseAge() {
        guard startAddress != nil else {
            return
        }
        self.age += 1
    }
}
