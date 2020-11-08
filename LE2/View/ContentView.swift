//
//  ContentView.swift
//  LE2
//
//  Created by Beverly Abadines on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext)private var viewContext

    
//    @ObservedObject private var mic = MicMonitor(numberOfSamples:30)
    private var speechManager = SpeechManager()

    @State var isListening = false
    
    var body: some View {
        NavigationView{
            VStack{
                RoundedRectangle(cornerRadius:25)
                    .fill(Color.primary.opacity(0))
                    .padding()
    //                .overlay(VStack{
    //                  visualizerView()
    //                })
                    .opacity(isListening ? 1: 0)
                recordButton()
            }
        }
    }
    
    private func recordButton()->some View{
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
    }

    private func normalizedSoundLevel(level:Float)->CGFloat{
        let level = max(0.2,CGFloat(level)+50) / 2
        return CGFloat(level*4)
    }
    
//    private func visualizerView()->some View {
//        VStack{
//            HStack(spacing:4){
//                ForEach(mic.soundSamples,id:\.self){level in
//                    BarView(value:self.normalizedSoundLevel(level:level))
//                }
//            }
//        }
//    }
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

