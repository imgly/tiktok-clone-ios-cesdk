//
//  ContentView.swift
//  ritrok
//
//

import SwiftUI
import AVKit
import IMGLYVideoEditor
import IMGLYEngine

struct ContentView: View {

  @StateObject private var viewModel = VideoPlayerViewModel()
  @State private var isPresented = false

  let endMonitor = NotificationCenter.default.publisher(for: NSNotification.Name.AVPlayerItemDidPlayToEndTime)

  let engine = EngineSettings(license: "<your license key>",
                              userID: "<your unique user id>")
  var body: some View {
    VStack {
      Spacer()
      if let currentVideoURL = viewModel.currentVideoURL {
        VideoPlayer(player: AVPlayer(url: currentVideoURL))
            .edgesIgnoringSafeArea(.all)
        .onAppear {
          //player.play()
        }
        .onReceive(endMonitor) { _ in
         // player.seek(to: .zero)
         // player.play()
        }
        .gesture(
          DragGesture(minimumDistance: 50, coordinateSpace: .local)
            .onEnded { value in
              if value.translation.height < 0 {
                viewModel.playNextVideo()
              }
            }
        )

    } else {
      Text("It looks like you don't have any video")
          .font(.headline)
          .padding()
  }

  Spacer()
      Button(action: {
          isPresented = true
      }) {
          Image(systemName: "plus.circle.fill")
              .resizable()
              .frame(width: 50, height: 50)
              .padding()
      }
      .fullScreenCover(isPresented: $isPresented) {
        NavigationView {
          VideoEditor(engine)
            .imgly.onExport({ engine, eventHandler in
              do {
                guard let page = try? engine.scene.getCurrentPage() else
                {logger.error("Unable to get page to export."); isPresented = false; return}
                let exportTask = Task {
                  for try await export in try await engine.block.exportVideo(page,
                                                                             mimeType: MIMEType.mp4) {
                    switch export {
                    case let .progress(renderedFrames, encodedFrames, totalFrames):
                      logger.debug("Rendered \(renderedFrames) frames and encoded \(encodedFrames) frames out of \(totalFrames)")
                    case let .finished(video: videoData):
                      return videoData
                    }
                  }
                  return Blob()
                }
                guard let file = try? await exportTask.value else {logger.error("Unable to export scene.");  isPresented = false; return}
                guard let documentDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { logger.error("Documents directory not found");  isPresented = false; return}
                let filePath = documentDirectory.appending(component: UUID().uuidString).appendingPathExtension("mp4")

                try file.write(to: filePath)
              } catch (let error as NSError) {
                logger.error("could not write finished file: \(error.localizedDescription)")
              }
              eventHandler.send(.exportCompleted(action: {
                viewModel.loadVideosFromDocumentsDirectory()
                isPresented = false
              }))
            })
            .imgly.onCreate({ engine in
              try await engine.scene.load(from: VideoEditor.defaultScene)
              // Add asset sources

              let bundleURL = Bundle.main.url(forResource: "IMGLYAssets", withExtension: "bundle")!

                try await engine.addDefaultAssetSources(baseURL: bundleURL)

              try await engine.addDemoAssetSources(sceneMode: engine.scene.getMode(),
                                                   withUploadAssetSources: true)
              try await engine.asset.addSource(TextAssetSource(engine: engine))

              //try await engine.block.expo

          })
         /*.imgly.colorPalette([.init("hey", CGColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 0.8)),
                               .init("Green", .imgly.green),
                               .init("Yellow", .imgly.yellow),
                               .init("Red", .imgly.red),
                               .init("Black", .imgly.black),
                               .init("White", .imgly.white),
                               .init("Gray", CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5))              ])*/
      }

    }

    }
    .padding()
  }
}

#Preview {
  ContentView()
}
