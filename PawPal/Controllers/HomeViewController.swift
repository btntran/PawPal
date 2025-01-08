//
//  HomeViewController.swift
//  PawPal
//
//  Created by Khang Nguyen on 10/12/24.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    // Sample posts array
    var posts: [Post] = [
        Post(avatar: UIImage(systemName: "person.circle")!, title: "First Post", body: "This is the body of the first post."),
        Post(avatar: UIImage(systemName: "person.circle")!, title: "Second Post", body: "This is the body of the second post."),
        Post(avatar: UIImage(systemName: "person.circle")!, title: "Third Post", body: "This is the body of the third post.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the screen title
        title = "PawPal"
        
        // Hide the back button on the navigation bar
        navigationItem.hidesBackButton = true
        
        // Set up the table view
        setupTableView()
    }

    // MARK: - TableView Setup
    func setupTableView() {
        // Register the PostCell XIB
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        tableView.delegate = self
        tableView.dataSource = self

        // Enable automatic row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }

    // MARK: - UITableViewDataSource Methods

    // Each post is a separate section
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count // One section per post
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Only one row per section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            fatalError("Unable to dequeue PostCell")
        }

        // Configure the cell with the post data
        let post = posts[indexPath.section] // Use section as index
        cell.configure(with: post)
        return cell
    }

    // MARK: - UITableViewDelegate Methods

    // Add spacing between cells using footers
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Space between cells
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear // Transparent footer
        return spacerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected post: \(posts[indexPath.section].title)")
    }

    // MARK: - Logout Button
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
