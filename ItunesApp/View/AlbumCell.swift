//
//  AlbumCell.swift
//  ItunesApp
//
//  Created by Juan Emilio Eguizabal on 08/06/2023.
//

import SwiftUI

struct AlbumViewModel: Identifiable {
    let id = UUID()
    let title: String
}

struct AlbumCell: View {
    var viewModel:  AlbumViewModel
    
    var body: some View {
        Text(viewModel.title)
    }
}

struct AlbumCell_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCell(viewModel: AlbumViewModel(title: "Sgt Peppers"))
    }
}
