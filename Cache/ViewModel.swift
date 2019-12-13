//
//  ViewModel.swift
//  Cache
//
//  Created by 전건우 on 2019/12/13.
//  Copyright © 2019 Daou Technology Inc. All rights reserved.
//

import Combine

class ViewModel: ObservableObject {
    @Published var numberOfSets: Int = 0
    @Published var numberOfBlocks: Int = 0
    @Published var numberOfWords: Int = 0
    @Published var index: Int = 0
    
    func refresh() {
        self.numberOfSets = 0
        self.numberOfBlocks = 0
        self.numberOfWords = 0
        self.index = 0
    }
}
