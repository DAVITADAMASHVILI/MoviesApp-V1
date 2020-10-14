//
//  ViewController.swift
//  MoviesApp
//
//  Created by DATA on 10/12/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    @IBOutlet weak var categoriesTable: UITableView!
    
    let categories = ["Top Rated", "Popular"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTable.dataSource = self
        categoriesTable.delegate = self
        categoriesTable.register(UINib.init(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: CategoryCell.identifier)
        setLogo()
    }
    
    func setLogo(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        navigationItem.titleView = imageView
        
    }

}

extension MainPageViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier) as! CategoryCell
        cell.categoryLabel.text = categories[indexPath.row]
        switch indexPath.row {
        case 0:
            MovieServiceManager.fetchTop(page: 1) { (hits) in
                cell.hits = hits
                cell.reload()
            }
        case 1:
            MovieServiceManager.fetchPopular(page: 1) { (hits) in
                cell.hits = hits
                cell.reload()
            }
        default:
            break
        }
        cell.navigationController = navigationController
        cell.storyboard = storyboard
        return cell
        
    }
    
    
}

