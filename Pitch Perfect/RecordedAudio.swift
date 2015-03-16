//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Phai Minh Hoang on 3/13/15.
//  Copyright (c) 2015 Phai. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    // Contructor of RecordedAudio class
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}