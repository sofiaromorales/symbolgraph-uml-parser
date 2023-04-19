//
//  File.swift
//  
//
//  Created by Sofia Rodriguez Morales on 12/4/23.
//

import Foundation

protocol DTO: Decodable {
    associatedtype T: Decodable
    func transform(_ json: String) throws -> T
}
