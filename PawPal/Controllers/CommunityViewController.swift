//
//  CameraViewController.swift
//  PawPal
//
//  Created by Khang Nguyen on 10/12/24.
//

import UIKit

class CommunityViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var listView: UITableView!
    var dataArray = ["Post1", "Post2", "Post3", "Post4", "Post5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Register Call
        self.listView.register(UINib(nibName: "CommunityTableCell", bundle: nil), forCellReuseIdentifier: "CommunityTableCell")
        self.listView.rowHeight = UITableView.automaticDimension
        self.listView.estimatedRowHeight = 70
        // Data source
        self.listView.dataSource = self
        self.listView.delegate = self
        
    }

}

extension CommunityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = listView.dequeueReusableCell(withIdentifier: "CommunityTableCell", for: indexPath) as? CommunityTableCell{
            cell.setTitle(title: dataArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
