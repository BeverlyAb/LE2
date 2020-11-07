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
                print("Recording")
            }) {
            Text("Here to Listen")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(15)
                .padding(10)
                .border(Color.pink, width: 3)
                .cornerRadius(4)
              
            
        }
        Divider()
        
        Text("Echo...echo")
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
