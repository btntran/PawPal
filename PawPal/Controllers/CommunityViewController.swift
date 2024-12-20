//
//  CommunityViewController.swift
//  PawPal
//
//  Created by Khang Nguyen on 10/12/24.
//

import UIKit

class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    // table view and search bar
    @IBOutlet weak var listView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Highlight Bar under each section
    @IBOutlet weak var postHighlightBar: UIView!
    @IBOutlet weak var commentHighlightBar: UIView!
    @IBOutlet weak var communityHighlightBar: UIView!
    @IBOutlet weak var shelterHighlightBar: UIView!
    
    // Sort button
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var currentSortedButton: UIButton! //update the value every time user change different sorted
    
    
    // Original Data
    var dataArray: [CommunityPost] = [
        CommunityPost(title: "Dog 1", content: "Content 1", category: "post", comment: 1, reaction: 3),
        CommunityPost(title: "Dog 2", content: "Content 2", category: "shelter", comment: 2, reaction: 4),
        CommunityPost(title: "Cat 3", content: "Content 3", category: "community", comment: 5, reaction: 6),
        CommunityPost(title: "Fish 4", content: "Content 3", category: "comment", comment: 5, reaction: 6),
        CommunityPost(title: "Bird 5", content: "Content 3", category: "comment", comment: 5, reaction: 6),
        CommunityPost(title: "Bird 6", content: "Content 3", category: "post", comment: 5, reaction: 6)
    ]
    
    // Array after filtering
    var filteredDataArray: [CommunityPost] = []
    
    // Current post type, change filter array dynamically based on the search bar keyword or current post type.
    var currentPostType = "post" {
        didSet {
            if let searchText = searchBar.text, !searchText.isEmpty {
                filteredDataArray = dataArray.filter { post in
                    (post.title.lowercased().contains(searchText.lowercased()) ||
                    post.content.lowercased().contains(searchText.lowercased())) &&
                    post.category == currentPostType
                }
            } else {
                filteredDataArray = dataArray.filter { $0.category == currentPostType }
            }
            listView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredDataArray = dataArray.filter { $0.category == currentPostType }
        
        self.listView.register(UINib(nibName: "CommunityTableCell", bundle: nil), forCellReuseIdentifier: "CommunityTableCell")
        self.listView.rowHeight = UITableView.automaticDimension
        self.listView.estimatedRowHeight = 70
        self.listView.dataSource = self
        self.listView.delegate = self
        self.searchBar.delegate = self
        configureMenu()
    }
    
    private func configureMenu(){
        let latestAction = UIAction(title:"Latest", handler: handleSortSelection(_:))
        let oldestAction = UIAction(title: "Oldest", handler: handleSortSelection(_:))
        let mostLikedAction = UIAction(title: "Most Liked", handler: handleSortSelection(_:))
        let sortMenu = UIMenu(title:"Sorted by", children: [latestAction, oldestAction, mostLikedAction])
        sortButton.menu = sortMenu
        sortButton.showsMenuAsPrimaryAction = true

    }
    
    // Incomplete sort selection
    @objc func handleSortSelection(_ action: UIAction) {
        switch action.title {
        case "Latest":
            // Sort data by latest
            currentSortedButton.titleLabel!.text = "Latest"
            print("Sort by Latest")
        case "Oldest":
            // Sort data by oldest
            currentSortedButton.titleLabel!.text = "Oldest"
            print("Sort by Oldest")
        case "Most Liked":
            // Sort data by most liked
            currentSortedButton.titleLabel!.text = "Likes"
            print("Sort by Most Liked")
        default:
            break
        }
        // Reload your data display, such as a UITableView or UICollectionView
    }

    
    // MARK: - Button Actions
    @IBAction func postButtonPressed(_ sender: UIButton) {
        currentPostType = "post"
        postHighlightBar.backgroundColor = UIColor.orange
        commentHighlightBar.backgroundColor = UIColor.clear
        communityHighlightBar.backgroundColor = UIColor.clear
        shelterHighlightBar.backgroundColor = UIColor.clear
    }
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        currentPostType = "comment"
        postHighlightBar.backgroundColor = UIColor.clear
        commentHighlightBar.backgroundColor = UIColor.orange
        communityHighlightBar.backgroundColor = UIColor.clear
        shelterHighlightBar.backgroundColor = UIColor.clear
    }
    
    @IBAction func communityButtonPressed(_ sender: UIButton) {
        currentPostType = "community"
        postHighlightBar.backgroundColor = UIColor.clear
        commentHighlightBar.backgroundColor = UIColor.clear
        communityHighlightBar.backgroundColor = UIColor.orange
        shelterHighlightBar.backgroundColor = UIColor.clear
    }
    
    @IBAction func shelterButtonPressed(_ sender: UIButton) {
        currentPostType = "shelter"
        postHighlightBar.backgroundColor = UIColor.clear
        commentHighlightBar.backgroundColor = UIColor.clear
        communityHighlightBar.backgroundColor = UIColor.clear
        shelterHighlightBar.backgroundColor = UIColor.orange
    }
    
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = filteredDataArray[indexPath.row]
        if let cell = listView.dequeueReusableCell(withIdentifier: "CommunityTableCell", for: indexPath) as? CommunityTableCell {
            cell.setTitle(title: post.title)
            cell.setDescription(description: post.content)
            cell.setNumComment(numComment: post.comment)
            cell.setNumReaction(numReaction: post.reaction)
            return cell
        }
        return UITableViewCell()
    }
    
    // SearchBar Delegate Methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredDataArray = dataArray.filter { $0.category == currentPostType }
        listView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredDataArray = dataArray.filter { $0.category == currentPostType }
        } else {
            filteredDataArray = dataArray.filter { post in
                (post.title.lowercased().contains(searchText.lowercased()) ||
                post.content.lowercased().contains(searchText.lowercased())) &&
                post.category == currentPostType
            }
        }
        listView.reloadData()
    }
}
