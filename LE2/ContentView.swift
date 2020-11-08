//
//  ContentView.swift
//  LE2
//
//  Created by Beverly Abadines on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

import SwiftUI
import UIKit
import Speech



struct ContentView: View {
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?

    func recordAndRecognizeSpeech(){
        let node = audioEngine.inputNode 
        let recordingFormat = node.outputFormat(forBus:0)
        node.installTap(onBus: 0, bufferSize:1024, format:recordingFormat) { buffer, _ in self.request.append(buffer)
        }
    }
    
    
    
    @State var isListening: Bool = false
    var body: some View {
        VStack{
            Button(action: {
                self.isListening.toggle()
                }) {
               HStack {
                
                Text(self.isListening == true ? "Listening": "START")
                       .font(.title)
                Image(systemName: self.isListening == true ? "pause.fill" : "play.fill")
                .resizable().frame(width:50,height:50)
                    .aspectRatio(contentMode: .fit)
                }
            .padding(30)
            .aspectRatio(contentMode: .fill)
            .foregroundColor(self.isListening == true ? Color.gray : Color.white)
            .background(self.isListening == true ? Color.black : Color.red)
            .cornerRadius(100)
            }
            Text("Echo...echo")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ContentView().environment(\.colorScheme, .dark)

            }
            ContentView().environment(\.colorScheme, .light)
        }
    }
}

