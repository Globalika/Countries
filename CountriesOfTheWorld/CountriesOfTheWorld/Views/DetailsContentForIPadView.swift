//
//  DetailsContentForIPadView.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 02.01.2022.
//

import Foundation
import UIKit

class DetailsContentForIPadView: UIView {
    let worldImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constants.worldImage
        return view
    }()
    var countryInfo = [(String, String)]()
    var points: [CGPoint] = []
    let curveLinesRotationAngles: [CGFloat] = [0, 90, 180, 0, 90, 180]

    init(countryInfo: [(String, String)], frame: CGRect) {
        super.init(frame: frame)
        self.countryInfo = countryInfo
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func countPointsPositions() {
        let pointsAmountIncludeScenery = countryInfo.count * 2
        let angle: CGFloat = CGFloat(360 / pointsAmountIncludeScenery)
        var point = CGPoint()
        var pointAngle: CGFloat = 0
        for _ in 0..<pointsAmountIncludeScenery {
            point.x = center.x + round(cos(Double(pointAngle/180)*Double.pi) * Constants.radius)
            point.y = center.y - round(sin(Double(pointAngle/180)*Double.pi) * Constants.radius)
            points.append(point)
            pointAngle += angle
        }
    }

    private struct Constants {
        static let worldImage = UIImage(named: "world")
        static let radius: CGFloat = 150
    }
}
