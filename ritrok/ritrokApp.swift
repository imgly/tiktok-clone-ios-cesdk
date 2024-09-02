//
//  ritrokApp.swift
//  ritrok
//
//

import SwiftUI
import os

//Create a logger we can use everywhere
let logger = Logger(subsystem: "com.example.ritrok", category: "application")

@main
struct ritrokApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
