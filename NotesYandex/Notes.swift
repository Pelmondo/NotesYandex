//
//  Notes.swift
//  NotesYandex
//
//  Created by Сергей Прокопьев on 12.02.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit


struct Note {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let dateSelfDistraction: Date?
    
    
    
    init(uid:String = UUID().uuidString, title: String, content: String, color: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
         importance: Importance, dateSelfDistraction: Date? = nil) {
        self.title = title
        self.content = content
        self.importance = importance
        self.uid = uid
        self.color = color
        self.dateSelfDistraction = dateSelfDistraction
    }
}



enum Importance {
    case nomatter
    case regular
    case important
}

