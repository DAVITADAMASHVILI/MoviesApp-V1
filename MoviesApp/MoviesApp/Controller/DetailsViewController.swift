//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by DATA on 10/13/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    @IBOutlet weak var detailsTable: UITableView!
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    var movie: Hit?
    var isFavourite = false
    var currentMovieID: MovieID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        guard let movie = movie else {
            return
        }
        navigationItem.title = movie.title
        detailsTable.delegate = self
        detailsTable.dataSource = self
        detailsTable.register(UINib.init(nibName: CategoryCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryCell.identifier)
        getFavourite()
    }
    
    func getFavourite(){
        guard let movie = movie else {
            return
        }
        for movieID in MovieServiceManager.fetchFavourites(){
            if Int(movieID.id) == movie.id{
                currentMovieID = movieID
                isFavourite = true
                favourite()
            }
        }
    }
    
    func favourite(){
        favouriteButton.image = UIImage(systemName: "heart.fill")
    }
    
    func notFavourite(){
        favouriteButton.image = UIImage(systemName: "heart")
    }
    
    @IBAction func onFavourite(_ sender: UIBarButtonItem) {
        if isFavourite{
            MovieServiceManager.deleteFavourite(movieID: currentMovieID!)
            notFavourite()
        } else {
            guard let movie = movie else {return}
            MovieServiceManager.saveFavourite(movie: movie)
            favourite()
        }
    }
    
    
    
}

extension DetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? UITableView.automaticDimension : 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = detailsTable.dequeueReusableCell(withIdentifier: DetailsCell.identifier) as! DetailsCell
            guard let movie = movie else{
                return cell
            }
            cell.displayHit(movie: movie)
            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier) as! CategoryCell
            
            cell.categoryLabel.text = "Cast"
            cell.navigationController = navigationController
            cell.storyboard = storyboard
            
            guard let movie = movie else {
                return cell
            }
            
            MovieServiceManager.fetchCast(id: movie.id) { (cast) in
                cell.cast = cast
                cell.reload()
                
            }
            
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier) as! CategoryCell
            
            cell.categoryLabel.text = "Similar"
            cell.navigationController = navigationController
            cell.storyboard = storyboard
            
            guard let movie = movie else {
                return cell
            }
            
            MovieServiceManager.fetchSimilar(id: movie.id) { (similar) in
                cell.hits = similar
                cell.reload()
                
            }
            return cell
            
        
        default:
            return UITableViewCell.init()
        }
        
    }
    
    
}
