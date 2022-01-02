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
    let curveLinesRotationAngles: [CGFloat] = []

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

    func configureDetailsView() {
        var scenery: Scenery = .greenCircle
        for (index, point) in points.enumerated() {
            let view = UIImageView()
            view.frame = .init(x: point.x, y: point.y, width: 50, height: 50)
            if index%2 == 0 {
                view.image = UIImage(named: "curveLine")
                let scale = CGAffineTransform(scaleX: 2.7, y: 2.7)
                let rotate = CGAffineTransform(rotationAngle: 0) //curveLinesRotationAngles[index/2])
                view.transform = scale.concatenating(rotate)
            } else {
                view.image = UIImage(named: "\(scenery)")
                scenery = scenery.cicleScenery()
            }
            addSubview(view)
        }
    }

    private struct Constants {
        static let worldImage = UIImage(named: "world")
        static let radius: CGFloat = 150
    }
}
