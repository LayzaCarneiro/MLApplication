//
//  ContentView.swift
//  MLChallenge
//
//  Created by Layza Maria Rodrigues Carneiro on 30/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            KNN()
        }
    }
}

#Preview {
    ContentView()
}
