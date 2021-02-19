//
//  UIImage+Extension.swift
//  FundAll_App
//
//  Created by David U. Okonkwo on 2/19/21.
//

import UIKit

extension UIImage {
    public static func loadImage(from url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
