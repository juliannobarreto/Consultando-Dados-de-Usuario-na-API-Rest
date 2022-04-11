//
//  InforUsers.swift
//  API.teste
//
//  Created by user212674 on 4/7/22.
//

import UIKit

class InforUsers: Codable {
    
    var page: Int?
    var per_page: Int?
    var total: Int?
    var total_pages: Int?
    var data: [UsersModel]
    var token: Int?
}
