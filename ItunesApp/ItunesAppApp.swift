//
//  ItunesAppApp.swift
//  ItunesApp
//
//  Created by Juan Emilio Eguizabal on 08/06/2023.
//

import SwiftUI

@main
struct ItunesAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: AlbumListViewModel(service: ItunesService(url: "https://itunes.apple.com/search?term=thebeatles&media=music&entity=album&attribute=artistTerm")))
        }
    }
}
