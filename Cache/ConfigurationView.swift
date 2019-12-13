//
//  ConfigurationView.swift
//  Cache
//
//  Created by 전건우 on 2019/12/13.
//  Copyright © 2019 Daou Technology Inc. All rights reserved.
//

import SwiftUI

struct ConfigurationView: View {
    @Binding var numberOfSets: Int
    @Binding var numberOfBlocks: Int
    @Binding var numberOfWords: Int
    
    var body: some View {
        VStack {
            Stepper(value: $numberOfSets) {
                Text("number of sets: \(numberOfSets)")
            }
            Stepper(value: $numberOfBlocks) {
                Text("number of blocks: \(numberOfBlocks)")
            }
            Stepper(value: $numberOfWords) {
                Text("number of words: \(numberOfWords)")
            }
        }
    }
}

struct inputView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(numberOfSets: .constant(0), numberOfBlocks: .constant(0), numberOfWords: .constant(0))
    }
}
