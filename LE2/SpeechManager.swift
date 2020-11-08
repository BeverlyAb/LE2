//
//  SpeechManager.swift
//  LE2
//
//  Created by Beverly on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
// Followed https://www.youtube.com/watch?v=0KUspKQ6GYk&ab_channel=DevTechie
//

import Foundation
import Speech

class SpeechManager {
    public var isRecording = false
    private var audioEngine: AVAudioEngine!
    private var inputNote: AVAudioInputNode!
    private var audioSession: AVAudioSession!
    
    private var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?

    func checkPermissions(){
        SFSpeechRecognizer.requestAuthorization{(authStatus) in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized: break
                default:
                    print("Speech is unavailable. ERR: 1")
                }
            }
            
        }
    }
    
    func start(completion: @escaping (String?)->Void){
        if isRecording{
            stopRecording()
        } else {
            startRecording(completion:completion)
        }
    }
    
    func startRecording(completion: @escaping (String?)->Void){
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable else {
            print("Speech is unavailable. ERR: 2")
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest!.shouldReportPartialResults = true
        
        recognizer.recognitionTask(with: recognitionRequest!){ (result, error) in
            guard error == nil else {
                print("ERR: \(error!.localizedDescription)")
                return
            }
            guard let result = result else {return}
            if result.isFinal {
                completion(result.bestTranscription.formattedString)
            }
        }
        audioEngine = AVAudioEngine()
        inputNote = audioEngine.inputNode
        let recordingFormat = inputNote.outputFormat(forBus:0)
        inputNote.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer,_) in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        
        do{
            audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record,mode: .spokenAudio,options:.duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try audioEngine.start()
        }catch {
            print(error)
        }
    }
    
    func stopRecording(){
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        audioEngine.stop()
        
        inputNote.removeTap(onBus: 0)
        try? audioSession.setActive(false)
        audioSession = nil
    }
}
