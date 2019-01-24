//
//  Issue.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Foundation

struct Issue: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    var id: Id.Issue
    var title: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let idNum = try values.decode(Int.self, forKey: .id)
        self.id = "\(idNum)"
        self.title = try values.decode(String.self, forKey: .title)
    }
}

extension Issue: IssueDisplayable {
    var owner: String {
        return "Owner"
    }
}
