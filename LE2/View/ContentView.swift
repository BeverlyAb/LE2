//
//  ContentView.swift
//  LE2
//
//  Created by Beverly Abadines on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

import SwiftUI
import CoreData
import UIKit
import AVFoundation


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
//        \Todo.created, ascending: true)],animation: .default) private var todos: FetchedResults<Todo>
    @FetchRequest(
        entity: Todo.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Todo.id, ascending: true)
        ]
    ) var todos: FetchedResults<Todo>
    
    @ObservedObject private var mic = MicMonitor(numberOfSamples:30)
    private var speechManager = SpeechManager()

    @State var isListening = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
//                List{
////                     ForEach(todos, id:\.id) { item in
////                            Text(item.text ?? "XX")
////                    } .onDelete(perform: deleteItems)
//                }
//                .navigationTitle("Test")
                RoundedRectangle(cornerRadius:CGFloat(25))
                    .fill(Color.primary.opacity(0))
                    .padding()
                    .overlay(VStack{
                      visualizerView()
                    })
                    .opacity(isListening ? 1.0: 0.0)
                recordButton()
                .onAppear(){
                    self.speechManager.checkPermissions()
                }
                
            }
        }
    }
    private func deleteItems(offsets: IndexSet){
        withAnimation {
            offsets.map{todos[$0]}.forEach(viewContext.delete)
            do{
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func recordButton()->some View{
    Button(action: {
//        self.isListening.toggle()
        self.listenIn()
        }) {
       HStack {
        Text(self.isListening == true ? "Listening": "START")
               .font(.title)
        Image(systemName: self.isListening == true ? "pause.fill" : "play.fill")
            .resizable().frame(width:50.0,height:50.0)
            .aspectRatio(contentMode: .fit)
        }
        .padding(30)
        .aspectRatio(contentMode: .fill)
        .foregroundColor(self.isListening == true ? Color.gray : Color.white)
        .background(self.isListening == true ? Color.black : Color.red)
        .cornerRadius(100)
        }
    }
    private func speak(){
        let utterance = AVSpeechUtterance(string: "You have the right decline to a search. You have the right to remain silent. You have the right to talk to a lawyer")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        print("I spoke")
    }
    private func listenIn() {
        if speechManager.isRecording {
            self.isListening = false
            mic.stopMonitoring()
            speechManager.stopRecording()
            speak()
        } else {
            self.isListening = true
            mic.startMonitoring()
           
   
            speechManager.start{ (speechText) in
                guard let text = speechText, !text.isEmpty else {
                    self.isListening = false
                    return
                }
                DispatchQueue.main.async {
                    withAnimation{
                        let newItem = Todo(context:self.viewContext)
                        newItem.id = UUID()
                        newItem.text = text
                        newItem.created = Date()
                        print(newItem.text ?? "XX")
            
                        do {
                            try self.viewContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        speechManager.isRecording.toggle()
    }

    private func normalizedSoundLevel(level:Float)->CGFloat{
        let level = max(0.2,CGFloat(level)+50) / 2
        return CGFloat(level*4)
    }
    
    private func visualizerView()->some View {
        VStack{
            HStack(spacing:4){
                ForEach(mic.soundSamples,id: \.self){level in
                    BarView(value:self.normalizedSoundLevel(level:level))
                }
            }
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

