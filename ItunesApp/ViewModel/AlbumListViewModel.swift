//
//  AlbumListViewModel.swift
//  ItunesApp
//
//  Created by Juan Emilio Eguizabal on 08/06/2023.
//

import Foundation

class AlbumListViewModel: ObservableObject {
    var service: ItunesServiceType?
    
    @Published var albumList: [AlbumViewModel] = []
    
    init(service: ItunesServiceType?) {
        self.service = service
        self.service?.delegate = self
    }
    
    func getAlbumList() {
        service?.getItems()
    }
}

extension AlbumListViewModel: ItunesServiceDelegate {
    func itemsArrived(items: Array<ItunesItemResponse>) {
        DispatchQueue.main.async {
            self.albumList = items.map({AlbumViewModel(title: $0.collectionName ?? "")})
        }
    }
    
    func itemsFailedToArrive(_ error: CustomError?) {
        // TODO: Should present alert error
    }
}
