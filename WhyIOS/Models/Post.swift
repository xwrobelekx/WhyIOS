//
//  Post.swift
//  WhyIOS
//
//  Created by Kamil Wrobel on 9/5/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


struct Post: Codable {
    
    let name: String
    let reason: String
    let cohort: String?
    let uuid: String = UUID().uuidString
}


// [String: [String: String]]
