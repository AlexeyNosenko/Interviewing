//
//  SongsVC + URLSessionDownloadDelegate.swift
//  Interviewing
//
//  Created by Алексей on 10.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

extension SongsViewController: URLSessionDownloadDelegate{
    // действие при окончании загрузки
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        
        let download = downloader.activeDownloads[url]
        downloader.activeDownloads[url] = nil
        
        let path = localFilePath(for: url)
        print("Path = \(path)")
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: url)
        
        do{
            try fileManager.copyItem(at: location , to: path)
            download?.track.downloaded = true
        } catch let error {
            print("Could not copy file to disk \(error.localizedDescription)")
        }
        
        if let index = download?.track.index {
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .none)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard let url = downloadTask.originalRequest?.url,
        let download = downloader.activeDownloads[url]  else {
            return
        }
    
        download.progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
    
        DispatchQueue.main.async {
            if let trackCell = self.tableView.cellForRow(at: IndexPath(row: download.track.index,
                                                                       section: 0)) as? SongTableViewCell {
                trackCell.updateDisplay(progress: Float(download.progress), totalSize: totalSize)
            }
        }
        
    }
}
