//
//  ResultTableViewCell.swift
//  AppleSearch
//
//  Created by Michael Di Cesare on 10/3/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLable: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    var musicItem: MusicSearchResult? {
        didSet {
            guard let item = musicItem else {return}
            titleLabel.text = item.trackName
            subtitleLable.text = item.artistName
            artworkImageView.image = nil
            //artworkImageView.image = nil
            SearchResultsController.getMusicImageFor(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                    self.artworkImageView.image = image
                    }
                } else {
                    print("image was nil")
                }
            }
        }
    }
    
    var appItem: AppSearchResults? {
        didSet {
            guard let item = appItem else {return}
            titleLabel.text = item.trackName
            subtitleLable.text = item.description
            artworkImageView.image = nil
            SearchResultsController.getAppImageFor(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                    self.artworkImageView.image = image
                    }
                } else {
                    print("image was nil")
                }
            }
        }
    }
 

} // end of class
