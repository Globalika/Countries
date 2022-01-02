//
//  DetailsContentForIPadView.swift
//  CountriesOfTheWorld
//
//  Created by Volodymyr Seredovych on 02.01.2022.
//

import Foundation
import UIKit

class DetailsContentForIPadView: UIView, DetailsContentProtocol {
    public var countryCode = String() {
        didSet {
            let image = UIImage(named: countryCode.lowercased())
            header.countryImageView.image = image
        }
    }

    var countryInfo = [(String, String)]() {
        didSet {
            removeAllSubviews()
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

    var sceneryPoints: [CGPoint] = []
    let curveLinesRotationAngles: [CGFloat] = []
    var sceneryPointsAmount: Int = 0
    var worldCenterCoords = CGPoint()

    override var frame: CGRect {
        didSet {
            worldCenterCoords = CGPoint(x: center.x - Constants.worldImageXInset,
                                        y: center.y)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDetailsView()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func configureDetailsView() {
        configureHeader()
        configureWorldImage()
        if !countryInfo.isEmpty {
            countSceneryPointsPositions()
            addLabels()
            addSceneryImages()
        }
    }

    func configureHeader() {
        addSubview(header)
        setHeaderConstraints()
    }

    func configureWorldImage() {
        addSubview(worldImageView)
        worldImageView.frame = CGRect(x: worldCenterCoords.x + Constants.worldImageTopLeftInset.top,
                                      y: worldCenterCoords.y + Constants.worldImageTopLeftInset.left,
                                      width: Constants.worldImageSideLength,
                                      height: Constants.worldImageSideLength)
    }

    func countSceneryPointsPositions() {
        sceneryPoints.removeAll()
        sceneryPointsAmount = countryInfo.count * 2
        let angle: CGFloat = CGFloat(360 / sceneryPointsAmount)
        var point = CGPoint()
        var pointAngle: CGFloat = 0
        for _ in 0..<sceneryPointsAmount {
            point.x = worldCenterCoords.x + round(cos(Double(pointAngle/180)*Double.pi) * Constants.radius)
            point.y = worldCenterCoords.y - round(sin(Double(pointAngle/180)*Double.pi) * Constants.radius)
            sceneryPoints.append(point)
            pointAngle += angle
        }
    }

    func setupLabel(label: UILabel) {
        label.numberOfLines = 0
        label.minimumScaleFactor = Constants.labelMinimumScaleFactor
        label.adjustsFontSizeToFitWidth = true
    }

    private func addLabels() {
        for (index, point) in sceneryPoints.enumerated() where index % 2 != 0 {
            let pointAngle = Double(360 / sceneryPointsAmount * (index))
            let label = UILabel()
            setupLabel(label: label)
            label.setAttributedText(descriptionText: countryInfo[index/2].0,
                                    descriptionTextFont: .systemFont(ofSize: Constants.labelDescriptionFontSize,
                                                                     weight: Constants.labelDescriptionFontWeight),
                                    dataText: countryInfo[index/2].1,
                                    dataTextFont: .systemFont(ofSize: Constants.labelDataFontSize,
                                                              weight: Constants.labelDataFontWeight))
            addSubview(label)
            let xadd: CGFloat = round(cos(Double(pointAngle/180)*Double.pi) * Constants.labelXPositionMultiplier)
            let yadd: CGFloat = round(sin(Double(pointAngle/180)*Double.pi) * Constants.labelYPositionMultiplier)
            label.frame = CGRect(x: point.x + xadd,
                                 y: point.y - yadd,
                                 width: Constants.labelFrameWidth,
                                 height: Constants.labelFrameheight)
        }
    }

    private func addSceneryImages() {
        var scenery: Scenery = .greenCircle
        for (index, point) in sceneryPoints.enumerated() {
            let view = UIImageView()
            view.frame = .init(x: point.x,
                               y: point.y,
                               width: Constants.sceneryFrameSideLenght,
                               height: Constants.sceneryFrameSideLenght)
            if index%2 == 0 {
                var pointAngle = CGFloat(360 / sceneryPointsAmount * index)
                view.image = Constants.curveLineImage
                let angleRadian = -(pointAngle * Double.pi / 180)
                let rotate = CGAffineTransform(rotationAngle: angleRadian)
                view.transform = Constants.sceneryScale.concatenating(rotate)
            } else {
                view.image = UIImage(named: "\(scenery)")
                scenery = scenery.cicleScenery()
            }
            addSubview(view)
        }
    }

    func setHeaderConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.topAnchor),
            header.leftAnchor.constraint(equalTo: self.leftAnchor),
            header.rightAnchor.constraint(equalTo: self.rightAnchor),
            header.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        ])
    }

    private struct Constants {
        static let worldImage = UIImage(named: "world")
        static let curveLineImage = UIImage(named: "curveLine")
        static let radius: CGFloat = 150
        static let labelDescriptionFontSize: CGFloat = 15
        static let labelDescriptionFontWeight: UIFont.Weight = .thin
        static let labelDataFontSize: CGFloat = 20
        static let labelDataFontWeight: UIFont.Weight = .bold
        static let headerHeight: CGFloat = 160
        static let worldImageXInset: CGFloat = 180
        static let worldImageSideLength: CGFloat = 220
        static let worldImageTopLeftInset = UIEdgeInsets(top: -90, left: -90, bottom: 0, right: 0)
        static let labelXPositionMultiplier: CGFloat = 75
        static let labelYPositionMultiplier: CGFloat = 55
        static let labelFrameWidth: CGFloat = 120
        static let labelFrameheight: CGFloat = 70
        static let sceneryScale = CGAffineTransform(scaleX: 2.7, y: 2.7)
        static let sceneryFrameSideLenght: CGFloat = 50
        static let labelMinimumScaleFactor: CGFloat = 0.7
    }
}
