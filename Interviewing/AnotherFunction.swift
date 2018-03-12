//
//  AnotherFunction.swift
//  Interviewing
//
//  Created by Алексей on 21.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

extension Date{
    func toString(dateFormat: String = "dd.MM.yyyy")
        -> String{
        let dateFormatter = DateFormatter()
        return dateFormatter.string(from: self)
    }
}
