//
//  DetailsCell.swift
//  MoviesApp
//
//  Created by DATA on 10/13/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    public static let identifier = "DetailsCell"
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func displayHit(movie:Hit){
        let fullPosterPath = "\(MovieServiceManager.basePosterUrl)w1280\(movie.backdropPath)"
        fullPosterPath.downloadImage { (image) in
            DispatchQueue.main.sync {
                self.posterImage.image = image
            }
        }
        originalTitleLabel.text = movie.originalTitle
        overview.text = movie.overview
        dateLabel.text = movie.releaseDate
        displayRating(movie: movie)
    }
    
    func displayRating(movie: Hit){
        ratingLabel.text = "\(movie.voteAverage)"
        ratingImage.layer.cornerRadius = ratingImage.frame.height/2
        ratingImage.layer.masksToBounds = true
        if movie.voteAverage<5{
            ratingImage.tintColor = .red
        } else if (movie.voteAverage > 5 && movie.voteAverage < 8) {
            ratingImage.tintColor = .yellow
        }
        
    }
}
