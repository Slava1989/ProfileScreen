//
//  UIImage+Extensions.swift
//  ProfileScreen
//
//  Created by Veaceslav Chirita on 5/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

extension UIViewController {
    func fixOrientation(originalImage: UIImage) -> UIImage? {
        guard let cgImage = originalImage.cgImage else {
            return nil
        }

        if originalImage.imageOrientation == UIImage.Orientation.up {
            return originalImage
        }

        let width  = originalImage.size.width
        let height = originalImage.size.height

        var transform = CGAffineTransform.identity

        switch originalImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: width, y: height)
            transform = transform.rotated(by: CGFloat.pi)

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.rotated(by: 0.5*CGFloat.pi)

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: height)
            transform = transform.rotated(by: -0.5*CGFloat.pi)

        case .up, .upMirrored:
            break
        }

        switch originalImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        default:
            break;
        }

        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        guard let colorSpace = cgImage.colorSpace else {
            return nil
        }

        guard let context = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: UInt32(cgImage.bitmapInfo.rawValue)
            ) else {
                return nil
        }

        context.concatenate(transform);

        switch originalImage.imageOrientation {

        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: height, height: width))

        default:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        }

        // And now we just create a new UIImage from the drawing context
        guard let newCGImg = context.makeImage() else {
            return nil
        }

        let img = UIImage(cgImage: newCGImg)

        return img;
    }
}
