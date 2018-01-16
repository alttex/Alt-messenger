//
//  MessagesModel.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/16/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import Foundation

class Contact {
    
    private var _name = "User";
    private var _id = "";
    
    init(id: String, name: String) {
        _id = id;
        _name = name;
    }
    
    var name: String {
        get {
            return _name;
        }
    }
    
    var id: String {
        return _id;
    }
    
}



