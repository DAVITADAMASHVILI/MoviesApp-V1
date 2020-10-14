//
//  MovieCell.swift
//  MoviesApp
//
//  Created by DATA on 10/14/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    public static let identifier = "MovieCell"
    @IBOutlet weak var posterImage: CustomImage!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func displayMovie(movie:Hit){
        setPoster(path: movie.posterPath)
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
    }
    
    func displayCast(cast: Cast){
        
        titleLabel.text = cast.name
        dateLabel.text = ""
        
        guard let path = cast.profilePath else {
            return
        }
        setPoster(path: path)
        
    }
    
    func setPoster(path: String){
        let fullPosterPath = "\(MovieServiceManager.basePosterUrl)w780\(path)"
        fullPosterPath.downloadImage { (image) in
            DispatchQueue.main.sync {
                self.posterImage.image = image
            }
        }
    }
    
}
