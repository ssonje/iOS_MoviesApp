//
//  ContentView.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject var moviesViewModel = MoviesViewModel()

    var body: some View {
        MoviesTabView()
            .environmentObject(moviesViewModel)
    }
}

#Preview {
    ContentView()
}
