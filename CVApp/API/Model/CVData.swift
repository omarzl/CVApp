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
    let backgroundColor: String
    
    init(text: String = "", image: String = "", textColor: String = "", backgroundColor: String = "") {
        self.text = text
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    enum CodingKeys: String, CodingKey {
        case text, image
        case textColor = "text_color"
        case backgroundColor = "background_color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = (try? container.decode(String.self, forKey: .text)) ?? ""
        image = (try? container.decode(String.self, forKey: .image)) ?? ""
        textColor = (try? container.decode(String.self, forKey: .textColor)) ?? ""
        backgroundColor = (try? container.decode(String.self, forKey: .backgroundColor)) ?? ""
    }
}
