//
//  ContentView.swift
//  Cache
//
//  Created by 전건우 on 2019/12/13.
//  Copyright © 2019 Daou Technology Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let configuration: CacheConfiguration
    let cache: Cache
    
    @State var text: String = ""
    
    var body: some View {
        HStack {
            TextField("주소 입력", text: self.$text).textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: self.buttonTapped) {
                Text("입력")
            }
        }.padding()
    }
    
    init() {
        let configuration: CacheConfiguration = .init(numberOfSets: 2, numberOfBlocks: 2, numberOfWords: 1)
        let cache: Cache = .init(configuration: configuration)
        
        self.configuration = configuration
        self.cache = cache
    }
    
    func startConsole() {
        while true {
            guard let address: Int = readLine().flatMap(Int.init) else {
                print("fail to convert input text to number")
                continue
            }
            print("address: \(String(address, radix: 16))")
        }
        
    }
    
    func buttonTapped() {
        guard let address: Int = Int(self.text, radix: 16) else {
            print("변환 실패")
            return
        }
        print("address: \(String(address, radix: 16))")
        if self.cache.findAddress(address) {
            print("hit")
        }
        else {
            print("miss")
        }
        self.text = ""
        print(self.cache.debugDescription)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
