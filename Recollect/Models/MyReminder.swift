//
//  MyReminder.swift
//  Recollect
//
//  Created by student on 2022-07-24.
//

import Foundation
import UIKit

// Strcuture for reminder
// Codable to hold data 
struct myReminder: Codable{
    let title: String
    let body: String
    let date: Date
    let identifer: String
}
