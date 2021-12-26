//
//  ContentView.swift
//  lesson3
//
//  Created by Виталий  on 26.12.2021.
//
//

import SwiftUI

struct ContentView: View {

    private let apiManager: ApiManagerProtocol = ApiManager()

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                apiManager.loadUsers { print($0) }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}