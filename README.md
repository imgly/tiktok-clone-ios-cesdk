# RitRok - A TikTok Clone for iOS

Welcome to the TikTok Clone for iOS, a sample project demonstrating how to build a TikTok-like app using Swift and IMG.LY's CreativeEditor SDK (CE.SDK). This project guides you through setting up a video recording, editing, and playback app using the powerful tools provided by IMG.LY. With this project, you will be able to create a robust video-sharing application featuring similar functionalities to TikTok. Read the original [blog post](https://img.ly/blog/how-to-build-a-tiktok-clone-for-ios/) for an in-depth guide.

Table of Contents
-----------------

*   [Introduction](#introduction)
    
*   [Features](#features)
    
*   [Requirements](#requirements)
    
*   [Installation](#installation)
    
*   [Usage](#usage)
    
*   [Project Structure](#project-structure)
    
*   [Building Your TikTok Clone](#building-your-tiktok-clone)
    
*   [Further Customization](#further-customization)
    
*   [References](#references)
    
*   [License](#license)
    

Introduction
------------

This repository contains the source code for building a TikTok-like app using Swift and the IMG.LY CreativeEditor SDK. The app allows users to record videos, apply various edits such as filters, stickers, and audio, and then export the finished product. The CreativeEditor SDK simplifies the process by adding a camera module and advanced video editing features to your app, allowing for rapid development of feature-rich applications.
Consult the officical documentation on how to integrate the CE.SDK [Mobile Editor](https://img.ly/docs/cesdk/mobile-editor/quickstart) and [Mobile Camera](https://img.ly/docs/cesdk/mobile-camera/quickstart)

Features
--------

*   **Video Recording**: Capture video clips directly within the app.
    
*   **Video Editing**: Apply filters, add stickers, text, and audio to your videos.
    
*   **Playback**: Play back the edited videos within the app.
    
*   **Exporting**: Export the final video to a standard video file format.
    

Requirements
------------

*   Xcode 12.0 or later
    
*   iOS 13.0 or later
    
*   Swift 5.3 or later
    
*   IMG.LY CreativeEditor SDK license (for both Camera and VideoEditor SDKs)
    

Installation
------------

1.  Install the required dependencies using Swift Package Manager:
    
    *   Open the project in Xcode.
        
    *   Navigate to File > Add Packages....
        
    *   Add the CreativeEditor SDK using the following URL `https://github.com/imgly/IMGLYUI-swift`
        
    *   Select the IMGLYUI package which includes all necessary submodules like IMGLYCamera, IMGLYVideoEditor, etc.
        
3.  Ensure that you have properly set up the necessary permissions in your app's Info.plist file to access the camera, microphone, and photo library.
    

Usage
-----

### Setting Up the Project

To start working on the TikTok clone:

1.  **Project Setup**: After cloning the repository, open the project in Xcode and ensure that the IMG.LY CreativeEditor SDK is integrated as per the instructions above.
    
2.  Permissions: Make sure you have added the appropriate entries in your Info.plist for camera and microphone usage:

    ```xml
      <key>NSCameraUsageDescription</key>
      <string>Lets you record videos</string>
      <key>NSMicrophoneUsageDescription</key>
      <string>Lets you record audio with your videos</string>
    ```
    
3.  **Run the App**: Build and run the project on a physical device to test the video recording and editing features.
    

### Building Your TikTok Clone

The TikTok clone involves the following key components:

*   **Video Recording**: Using IMGLYCamera, you can capture video clips directly within the app.
    
*   **Video Editing**: The IMGLYVideoEditor provides a range of editing tools, including adding filters, stickers, and audio. You can customize the appearance and behavior of these tools according to your app's requirements.
    
*   **Playback Controller**: The app uses Apple's AVPlayer for video playback, with customizations to support swiping through videos and looping playback.
    

#### Example Code Snippets

To initialize the Video Editor:

```swift
let engine = EngineSettings(license: "<your-license-key>", userID: "<your-user-id>")
let videoEditor = VideoEditor(engine: engine)
```

To capture and edit a video:

```swift
VideoEditor(engine)
  .imgly.onCreate({ engine in
    try await engine.scene.create(fromVideo: Bundle.main.url(forResource: "sample_video", withExtension: "mov")!)
  })
```

Further Customization
---------------------

The IMG.LY CreativeEditor SDK allows extensive customization:

*   **Assets**: Customize the assets used in the editor (stickers, filters, etc.) by loading them from a local bundle or a remote server.
    
*   **UI Customization**: Modify the colors, icons, and layout of the editor to match your app's design language.
    
*   **Advanced Features**: Integrate more complex workflows by leveraging the underlying CreativeEngine APIs.
    

For more detailed customization options, refer to the official [CE.SDK documentation](https://img.ly/docs/cesdk/introduction/#creator).

References
----------

*   [IMG.LY CreativeEditor SDK Documentation](https://img.ly/docs/cesdk/introduction/)
    
*   [IMG.LY VideoEditor SDK](https://img.ly/docs/vesdk/)
    
*   [IMG.LY Camera SDK](https://img.ly/docs/cesdk/mobile-camera/)
    

License
-------

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.