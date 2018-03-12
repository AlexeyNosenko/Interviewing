//
//  SongsTableViewController.swift
//  Interviewing
//
//  Created by Алексей on 09.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import AVKit

class SongsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataTask: URLSessionDataTask?
    var downloader: Downloader = Downloader()
    
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    func localFilePath(for url: URL) -> URL{
       return documentPath.appendingPathComponent(url.lastPathComponent)
    }
    
    var defaultSession = URLSession.init(configuration: .default)
    lazy var downloadSession: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession.init(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self as UISearchBarDelegate
        downloader.downloadSession = downloadSession
        self.tableView.tableFooterView = UIView()
    }
    
    func playTrack(_ track: Track){
        let playerVC = AVPlayerViewController()
        present(playerVC, animated: true)
        let localUrl = localFilePath(for: track.previewURL)
        let player = AVPlayer.init(url: localUrl)
        playerVC.player = player
        player.play()
    }
}

extension SongsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SongTableViewCell
        cell.delegate = self
        let track = tracks[indexPath.row]
        cell.configure(track, downloaded: track.downloaded, download: downloader.activeDownloads[track.previewURL])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        if track.downloaded{
            playTrack(track)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SongsViewController: SongTableViewCellDelegate{
    func tapped(_ cell: SongTableViewCell, action: (Track) -> ()){
        if let indexPath = tableView.indexPath(for: cell){
            let track = tracks[indexPath.row]
            action(track)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func downloadTapped(_ cell: SongTableViewCell) {
        tapped(cell) { [weak self] (track) in
            self?.downloader.startDownload(track)
        }
    }
    
    func pauseTapped(_ cell: SongTableViewCell) {
        tapped(cell) { [weak self] (track) in
            self?.downloader.pauseDownload(track)
        }
    }
    
    func cancelTapped(_ cell: SongTableViewCell) {
        tapped(cell) { [weak self] (track) in
            self?.downloader.cancelDownload(track)
        }
    }
    
    func resumeTapped(_ cell: SongTableViewCell) {
        tapped(cell) { [weak self] (track) in
            self?.downloader.resumeDownload(track)
        }
    }
}


