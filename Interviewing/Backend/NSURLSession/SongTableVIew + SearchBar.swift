//
//  SongTableVIew + SearchBar.swift
//  Interviewing
//
//  Created by Алексей on 09.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension SongsViewController: UISearchBarDelegate {
    
    func dissmissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dissmissKeyboard()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        updateListSong(searchBar.text!) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView.reloadData()
        }
    }
    
    func updateListSong(_ searchText: String, completion: @escaping () -> ()){
        // 1
        dataTask?.cancel()
        // 2
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "media=music&entity=song&term=\(searchText)"
            // 3
            guard let url = urlComponents.url else { return }
            // 4
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                // 5
                if let error = error {
                    
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.serialization(data)
                    // 6
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
            // 7
            dataTask?.resume()
        }
        print("end load data")
    }
    
    func serialization(_ data: Data){
        var response: [String : Any]
        tracks.removeAll()
        
        do {
            response = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
        } catch {
            return
        }
        
        guard let array = response["results"] as? [Any] else{
            return
        }
        
        var index = 0
        for result in array {
            if let r = result as? [String : Any],
            let trackName  = r["trackName"] as? String,
            let artistName = r["artistName"] as? String,
            let previewUrl = r["previewUrl"] as? String,
            let pUrl = URL(string: previewUrl){
                tracks.append(Track.init(name: trackName, artist: artistName, previewURL: pUrl, index: index))
                index += 1
            }
        }
    }
}
