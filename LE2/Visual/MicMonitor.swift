//
//  MicMonitor.swift
//  LE2
//
//  Created by Beverly Abadines on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

//import Foundation
import UIKit
import AVFoundation

class MicMonitor: ObservableObject{
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    private var currentSample: Int
    private let numberOfSamples: Int
    
    @Published public var soundSamples: [Float]
    
    init(numberOfSamples:Int){
        self.numberOfSamples = numberOfSamples > 0 ? numberOfSamples : 10
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
        
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission{ (success) in
                if !success {
                    fatalError("Record permission denied. No visualization available. ERR 3")
                }
            }
        }
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recordingSetting: [String:Any] = [
            AVFormatIDKey: NSNumber(value:kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recordingSetting)
            try audioSession.setCategory(.playAndRecord, mode: .default, options:[])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func startMonitoring(){
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(timer) in
            self.audioRecorder.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
    }
    public func stopMonitoring(){
        audioRecorder.stop()
    }
    
    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}
