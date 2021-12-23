//
//  SetApp.swift
//  Set
//
//  Created by Taher Poonawala on 20/06/21.
//

import SwiftUI

@main
struct SetApp: App {
    let games = SetViewModel()
    var body: some Scene {
        WindowGroup {
            SetView(viewmodel: games)
        }
    }
}
