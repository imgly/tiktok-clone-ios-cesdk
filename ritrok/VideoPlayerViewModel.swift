//
//  VideoPlayerViewModel.swift
//  ritrok
//
//

import SwiftUI
import AVKit

class VideoPlayerViewModel: ObservableObject {
  @Published var videoURLs: [URL] = []
  @Published var currentVideoIndex: Int = 0

  var currentVideoURL: URL? {
    guard !videoURLs.isEmpty else { return nil }
    return videoURLs[currentVideoIndex]
  }

  init() {
    loadVideosFromDocumentsDirectory()
  }

  func loadVideosFromDocumentsDirectory() {
    let fileManager = FileManager.default
    guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

    do {
      let files = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
      videoURLs = files.filter { $0.pathExtension.lowercased() == "mp4" || $0.pathExtension.lowercased() == "mov" }
    } catch {
      logger.error("Failed to load videos: \(error.localizedDescription)")
    }
  }

  func playNextVideo() {
    guard !videoURLs.isEmpty else { return }
    currentVideoIndex = (currentVideoIndex + 1) % videoURLs.count
  }

  func addVideo(_ url: URL) {
    videoURLs.append(url)
    if videoURLs.count == 1 {
      currentVideoIndex = 0
    }
  }
}

