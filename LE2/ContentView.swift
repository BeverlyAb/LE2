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
    var body: some View {
        VStack{
           
                Button(action: {
                    print("Recordingz")
                }) {
               HStack {
                Text("START")
                       .font(.title)
                Image(systemName:"play")
                    .resizable().frame(width:50,height:50)
                    .aspectRatio(contentMode: .fit)
                }
                .padding(30)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.white)
                .background(Color.red)
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

