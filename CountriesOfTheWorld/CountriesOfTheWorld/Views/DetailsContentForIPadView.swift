//
//  DetailsContentForIPadView.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 02.01.2022.
//

import Foundation
import UIKit

protocol DetailsContentProtocol: UIView {
    var countryCode: String { get set }
    var countryInfo: [(String, String)] { get set }
}

class DetailsContentForIPadView: UIView, DetailsContentProtocol {
    public var countryCode = String() {
        didSet {
            let image = UIImage(named: countryCode.lowercased())
            header.countryImageView.image = image
        }
    }

    var countryInfo = [(String, String)]() {
        didSet {
            configureDetailsView()
        }
    }

    var header: CountriesDetailsHeaderForIPad = {
        var header = CountriesDetailsHeaderForIPad()
        header.contentMode = .scaleAspectFit
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()

    let worldImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constants.worldImage
        return view
    }()

    var points: [CGPoint] = []
    let curveLinesRotationAngles: [CGFloat] = []
    var pointsAmountIncludeScenery: Int = 0

    override var frame: CGRect {
        didSet {
            center = CGPoint(x: frame.size.width/2 - 90, y: frame.size.height/2 + 20)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDetailsView()
        addSubview(worldImageView)
        worldImageView.frame = CGRect(x: center.x-100, y: center.y-100, width: 240, height: 240)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func countPointsPositions() {
        pointsAmountIncludeScenery = countryInfo.count * 2
        if pointsAmountIncludeScenery != 0 {
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
    }

    func configureDetailsView() {
        countPointsPositions()
        if pointsAmountIncludeScenery != 0 {
            addLbels()
            var scenery: Scenery = .greenCircle
            for (index, point) in points.enumerated() {
                let view = UIImageView()
                view.frame = .init(x: point.x, y: point.y, width: 50, height: 50)
                if index%2 == 0 {
                    view.image = UIImage(named: "curveLine")
                    let scale = CGAffineTransform(scaleX: 2.7, y: 2.7)
                    let rotate = CGAffineTransform(rotationAngle: 0)
                    view.transform = scale.concatenating(rotate)
                } else {
                    view.image = UIImage(named: "\(scenery)")
                    scenery = scenery.cicleScenery()
                }
                addSubview(view)
            }
        }
    }

    func addLbels() {
        if !countryInfo.isEmpty {
            for (index, point) in points.enumerated() where index % 2 != 0 {
                let pointAngle = Double(360 / pointsAmountIncludeScenery * (index))
                let label = UILabel()
                label.lineBreakMode = .byTruncatingTail
                label.numberOfLines = 3
                label.minimumScaleFactor = 0.5
                label.adjustsFontSizeToFitWidth = true
                label.setAttributedText(descriptionText: countryInfo[index/2].0,
                                        descriptionTextFont: .systemFont(ofSize: Constants.labelDescriptionFontSize,
                                                                         weight: Constants.labelDescriptionFontWeight),
                                        dataText: countryInfo[index/2].1,
                                        dataTextFont: .systemFont(ofSize: Constants.labelDataFontSize,
                                                                  weight: Constants.labelDataFontWeight))
                addSubview(label)
                let xadd: CGFloat = round(cos(Double(pointAngle/180)*Double.pi)*75)
                let yadd: CGFloat = round(sin(Double(pointAngle/180)*Double.pi)*55)
                label.frame = CGRect(x: point.x + xadd,
                                     y: point.y - yadd,
                                     width: 120,
                                     height: 70)
            }
        }
    }

    private struct Constants {
        static let worldImage = UIImage(named: "world")
        static let radius: CGFloat = 150
        static let labelDescriptionFontSize: CGFloat = 15
        static let labelDescriptionFontWeight: UIFont.Weight = .thin
        static let labelDataFontSize: CGFloat = 20
        static let labelDataFontWeight: UIFont.Weight = .bold
    }
}
