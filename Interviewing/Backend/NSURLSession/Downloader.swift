//
//  Downloader.swift
//  Interviewing
//
//  Created by Алексей on 10.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

class Downloader{
    var downloadSession: URLSession?
    var activeDownloads: [URL : Download] = [:]
    
    func startDownload(_ track: Track){
        print("download")
        let download = Download.init(track: track)
        download.task = downloadSession?.downloadTask(with: download.track.previewURL)
        download.task?.resume()
        download.isDownloading = true
        activeDownloads[download.track.previewURL] = download
        print("download success")
    }
    
    func pauseDownload(_ track: Track){
        guard let downloads = activeDownloads[track.previewURL] else {
            return
        }
        if downloads.isDownloading {
            downloads.task?.cancel(byProducingResumeData: { (data) in
                downloads.resumeData = data
            })
            downloads.isDownloading = false
        }
    }
    
    func cancelDownload(_ track: Track){
        if let downloads = activeDownloads[track.previewURL]{
            downloads.task?.cancel()
            activeDownloads[track.previewURL] = nil
        }
    }
    
    func resumeDownload(_ track: Track){
        guard let downloads = activeDownloads[track.previewURL] else {
            return
        }
        if let resumeData = downloads.resumeData {
            downloads.task = downloadSession?.downloadTask(withResumeData: resumeData)
        } else {
            downloads.task = downloadSession?.downloadTask(with: track.previewURL)
        }
        downloads.task?.resume()
        downloads.isDownloading = true
    }
}
