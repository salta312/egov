//
//  Service.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/23/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class Service: NSObject {
    var name:String!
    var image:UIImage!
    var color: UIColor!
    init(name:String!, image:UIImage){
        self.name=name
        self.image=image
    }
    init( name:String!, image:UIImage, color:UIColor){
        self.name=name
        self.image=image
        self.color = color
    }

}
