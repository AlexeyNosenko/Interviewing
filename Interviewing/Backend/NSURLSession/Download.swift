//
//  Download.swift
//  Interviewing
//
//  Created by Алексей on 10.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

class Download{
    var track: Track
    
    init(track: Track) {
        self.track = track
    }
    
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    var progress: Double = 0.0
}
