//
//  CommunityPost.swift
//  PawPal
//
//  Created by Khang Nguyen on 12/17/24.
//

import UIKit

struct CommunityPost{
    let id = UUID()
    let title: String
    let content: String
    let category: String
    let comment: Int
    let reaction: Int
}
