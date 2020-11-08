//
//  ContentView.swift
//  LE2
//
//  Created by Beverly Abadines on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var isRecording: Bool = false
    var body: some View {
        VStack{
            Button(action: {
                self.isRecording.toggle()
                }) {
               HStack {
                
                Text(self.isRecording == true ? "Recording": "START")
                       .font(.title)
                Image(systemName: self.isRecording == true ? "pause.fill" : "play.fill")
                .resizable().frame(width:50,height:50)
                    .aspectRatio(contentMode: .fit)
                }
                .padding(30)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(self.isRecording == true ? Color.gray : Color.white)
               .background(self.isRecording == true ? Color.black : Color.red)
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

