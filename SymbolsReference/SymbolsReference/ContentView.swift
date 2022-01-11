//
//  ContentView.swift
//  SymbolsReference
//
//  Created by Abraham Hunt on 1/10/22.
//

import SwiftUI

struct ContentView: View {
    static let symbols: [Symbol] = try! JSONDecoder().decode([Symbol].self, from: Data(contentsOf: Bundle.main.url(forResource: "sf_symbols", withExtension: ".json")!))
    var visibleSymbols: [Symbol] {
        if searchString.isEmpty { return Self.symbols }
        return Self.symbols.filter({ $0.name.contains(searchString) })
    }
    
    @State var searchString: String = ""
    
    struct Symbol: Decodable, Identifiable {
        let name: String
        let id = UUID()
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            self.name = string
        }
    }
        
    var body: some View {
        VStack {
            TextField("Search", text: $searchString).padding().autocapitalization(.none)
            List(visibleSymbols) { symbol in
                HStack {
                    Text("\(symbol.name)")
                    Image(systemName: symbol.name)
                }
            }
        }.font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
