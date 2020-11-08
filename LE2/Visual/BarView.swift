//
//  BarView.swift
//  LE2
//
//  Created by Beverly Abadines on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

import SwiftUI

struct BarView: View{
    var value:CGFloat
    let numberOfSamples: Int = 30
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient:Gradient(colors:[.blue,.purple]),startPoint:.top,endPoint:.bottom))
            .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples))*10/CGFloat(numberOfSamples), height: value)
        }
    }
}
