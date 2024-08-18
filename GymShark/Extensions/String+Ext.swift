//
//  String+Ext.swift
//  GymShark
//
//  Created by hanif hussain on 18/08/2024.
//

import Foundation

extension String{
    var htmlConvertedString : String{
        let string = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return string
    }}
