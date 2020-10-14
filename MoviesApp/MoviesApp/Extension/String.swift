//
//  String.swift
//  MoviesApp
//
//  Created by DATA on 10/12/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit

extension String {
    
    func downloadImage(completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: self) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
    
}
