//
//  FavouritedViewController.swift
//  MoviesApp
//
//  Created by DATA on 10/14/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit

class FavouritedViewController: UIViewController {
    @IBOutlet weak var moviesCollection: UICollectionView!
    var hits = [Hit]()
    var movieIDs: [MovieID]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        moviesCollection.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        getFavourited()
        moviesCollection.reloadData()
    }
    func getFavourited(){
        movieIDs = MovieServiceManager.fetchFavourites()
        guard let movieIDs = movieIDs else {return}
        if movieIDs.count == 0 {return}
        for movieID in movieIDs{
            MovieServiceManager.searchMovie(title: movieID.name!) { (hits) in
                for hit in hits{
                    if hit.title == movieID.name && hit.id == movieID.id{
                        self.hits.append(hit)
                        DispatchQueue.main.sync {
                            self.moviesCollection.reloadData()
                        }
                        break
                    }
                }
            }
        }
    }

}

extension FavouritedViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 130, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 1, bottom: 1, right: 1 * CGFloat(hits.count+1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hits.count == 0 ? 1:hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        if indexPath.row >= hits.count{
            return cell
        }
        
        cell.displayMovie(movie: hits[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsViewController else{return}
        detailsVC.movie = hits[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    
}
