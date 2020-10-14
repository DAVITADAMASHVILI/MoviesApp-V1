//
//  CategiryCell.swift
//  MoviesApp
//
//  Created by DATA on 10/14/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    public static let identifier = "CategoryCell";
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var moviesCollection: UICollectionView!
    var hits:[Hit]?
    var cast:[Cast]?
    var navigationController: UINavigationController?
    var storyboard: UIStoryboard?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviesCollection.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func reload(){
        DispatchQueue.main.sync {
            self.moviesCollection.reloadData()
        }
    }
    
}

extension CategoryCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 130, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 1, bottom: 1, right: 1 * CGFloat(hits?.count ?? 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hits?.count ?? cast?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        if hits != nil {
            guard let currenthit = hits?[indexPath.row] else{
                return cell
            }
            cell.displayMovie(movie: currenthit)
        }
        
        if cast != nil{
            guard let currentCast = cast?[indexPath.row] else{
                return cell
            }
            cell.displayCast(cast: currentCast)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hits = hits else {
            return
        }
        guard let detailsVC = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsViewController else{return}
        detailsVC.movie = hits[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    
    
}
