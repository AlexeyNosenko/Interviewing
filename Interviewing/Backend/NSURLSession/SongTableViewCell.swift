//
//  SongTableViewCell.swift
//  Interviewing
//
//  Created by Алексей on 09.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func downloadTapped(_ cell: SongTableViewCell)
    func pauseTapped(_ cell: SongTableViewCell)
    func cancelTapped(_ cell: SongTableViewCell)
    func resumeTapped(_ cell: SongTableViewCell)
}

class SongTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonDownload: UIButton!
    
    // MARK: - Variables
    var delegate : SongTableViewCellDelegate?
    var showDownloadControls = false
    
    // MARK: - Actions

    @IBAction func pauseOrResumeTapped(_ sender: Any) {
        if buttonPause.titleLabel?.text == "pause" {
            delegate?.pauseTapped(self)
        } else {
            delegate?.resumeTapped(self)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.cancelTapped(self)
    }
    
    @IBAction func downloadTapped(_ sender: Any) {
        delegate?.downloadTapped(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateDisplay(progress: Float, totalSize: String){
        progressView.isHidden = false
        progressView.progress = progress
        labelResult.isHidden = false
        labelResult.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
    
    func configure(_ track: Track, downloaded: Bool, download: Download?){
        self.labelName.text = track.name
        self.labelArtist.text = track.artist
        
        if let download = download {
            showDownloadControls = true
            let title = download.isDownloading ? "Pause" : "Resume"
            buttonPause.setTitle(title, for: .normal)
        }
        
        buttonPause.isHidden = !showDownloadControls
        buttonCancel.isHidden = !showDownloadControls
        buttonDownload.isHidden = downloaded || showDownloadControls
    }
}
