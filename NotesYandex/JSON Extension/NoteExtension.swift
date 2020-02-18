//
//  NoteExtension.swift
//  NotesYandex
//
//  Created by Сергей Прокопьев on 14.02.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit


extension Note {
    
    static func parse(json: [String:Any]) -> Note? {
        guard let title = json["title"] as? String else {return nil}
        guard let content = json["content"] as? String else {return nil}
        guard let uid = json["uid"] as? String else {return nil}
        var color = UIColor.white
        switch json["color"] {
            case .some:
                let (r,g,b,a) = json["notesColor"] as! (CGFloat,CGFloat,CGFloat,CGFloat)
                color = UIColor.init(red: r, green: g, blue: b, alpha: a)
            case .none:
                color = UIColor.white
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        var selfDestructDate : Date? = nil
        switch json["selfDestructDate"] {
        case .some:
            selfDestructDate = dateFormatter.date(from: json["selfDestructDate"] as! String)
        case .none:
            print("none")
        }
        
        var importance = Importance.regular
        switch json["importance"] as? Int {
            case 1: importance = Importance.important
            case 0: importance = Importance.nomatter
            default: importance = Importance.regular
        }
        
        return Note(uid: uid, title: title, content: content, color: color, importance: importance, dateSelfDistraction: selfDestructDate)
    }
    
    
    var json: [String:Any] {
        get {
            var dict: [String:Any] = ["uid": uid]
            dict["title"] = title
            dict["content"] = content
            switch color {
            default:
                dict["notesColor"] = (color.cgColor.components![0],
                                      color.cgColor.components![1],
                                      color.cgColor.components![2],
                                      color.cgColor.components![3])
            }
            
            switch importance {
            case .important:
                dict["importantly"] = 0
            case .nomatter:
                dict["importantly"] = 1
            case .regular:
                fallthrough
            default: break
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            switch dateSelfDistraction {
            case .some:
                dict["selfDestructDate"] = dateFormatter.string(from: dateSelfDistraction!)
            case .none:
                print("none")
            }
            
            return dict
        }
    }
    
}
