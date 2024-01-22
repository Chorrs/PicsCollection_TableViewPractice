//
//  ViewController.swift
//  PicsCollection_TableViewPractice
//
//  Created by Chorrs on 7.01.24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            let nib = UINib(nibName: "MyTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "MyCellId")
        }
    }
    
   private let images: [String] = ["https://arthive.net/res/media/img/oy800/work/cf5/528820@2x.webp",
        "https://arthive.net/res/media/img/ox400/work/f72/675272@2x.webp",
        "https://arthive.net/res/media/img/ox400/work/a93/675281@2x.webp",
        "https://arthive.net/res/media/img/ox400/work/d09/503559@2x.webp",
        "https://arthive.net/res/media/img/ox400/work/b82/528066@2x.webp"]

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellId", for: indexPath) as! MyTableViewCell
        
        cell.configure(path: images[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

