//
//  ContentView.swift
//  Cache
//
//  Created by 전건우 on 2019/12/13.
//  Copyright © 2019 Daou Technology Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel = .init()
    
    var body: some View {
        VStack {
            ConfigurationView(numberOfSets: $viewModel.numberOfSets, numberOfBlocks: $viewModel.numberOfBlocks, numberOfWords: $viewModel.numberOfWords).padding()
            List {
                /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
