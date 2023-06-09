//
//  ContentView.swift
//  ItunesApp
//
//  Created by Juan Emilio Eguizabal on 08/06/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: AlbumListViewModel
    var body: some View {
        List(viewModel.albumList) { viewModel in
            AlbumCell(viewModel: viewModel)
        }
        .onAppear {
            viewModel.getAlbumList()
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AlbumListViewModel(service: nil))
    }
}
