//
//  CVData.swift
//  CVApp
//
//  Created by Omar Zúñiga Lagunas on 2/3/20.
//  Copyright © 2020 Omar Zúñiga Lagunas. All rights reserved.
//

import Foundation

struct CVData: Decodable {
    
    let text: String
    let image: String
    let textColor: String
    
    init(text: String = "", image: String = "", textColor: String = "") {
        self.text = text
        self.image = image
        self.textColor = textColor
    }
    
    enum CodingKeys: String, CodingKey {
      case text, image, textColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = (try? container.decode(String.self, forKey: .text)) ?? ""
        image = (try? container.decode(String.self, forKey: .image)) ?? ""
        textColor = (try? container.decode(String.self, forKey: .textColor)) ?? ""
    }
}
