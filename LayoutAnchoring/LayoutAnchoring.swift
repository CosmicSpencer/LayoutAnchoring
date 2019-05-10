//
//  LayoutAnchoring.swift
//  TestNonStoryboard
//
//  Created by Spencer Hall on 4/17/19.
//  Copyright © 2019 Spencer Hall. All rights reserved.
//

import UIKit


public extension UIEdgeInsets {
	init(margin: CGFloat) {
		self.init(top: margin, left: margin, bottom: margin, right: margin)
	}
}

public struct LayerSettings {
	var borderColor: CGColor?
	var borderWidth: CGFloat = 0
	var cornerRadius: CGFloat = 0
}

public extension LayerSettings {
	init(cornerRadius: CGFloat = 0) {
		self.cornerRadius = cornerRadius
	}
}

public extension UIView {
	convenience init(_ screen: UIScreen) {
		self.init(frame: screen.bounds)
	}

	func setLayerSettings(_ settings: LayerSettings) {
		layer.borderColor = settings.borderColor
		layer.borderWidth = settings.borderWidth
		layer.cornerRadius = settings.cornerRadius
	}
}

public protocol LayoutAnchoring {
	var leadingAnchor: NSLayoutXAxisAnchor { get }
	var trailingAnchor: NSLayoutXAxisAnchor { get }
	var leftAnchor: NSLayoutXAxisAnchor { get }
	var rightAnchor: NSLayoutXAxisAnchor { get }
	var topAnchor: NSLayoutYAxisAnchor { get }
	var bottomAnchor: NSLayoutYAxisAnchor { get }
	var widthAnchor: NSLayoutDimension { get }
	var heightAnchor: NSLayoutDimension { get }
	var centerXAnchor: NSLayoutXAxisAnchor { get }
	var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutAnchoring {}
extension UILayoutGuide: LayoutAnchoring {}

public extension LayoutAnchoring {
	var top: NSLayoutYAxisAnchor { return topAnchor }
	var bottom: NSLayoutYAxisAnchor { return bottomAnchor }
	var left: NSLayoutXAxisAnchor { return leftAnchor }
	var right: NSLayoutXAxisAnchor { return rightAnchor }
	var leading: NSLayoutXAxisAnchor { return leadingAnchor }
	var trailing: NSLayoutXAxisAnchor { return trailingAnchor }
	
	var centerX: NSLayoutXAxisAnchor { return centerXAnchor }
	var centerY: NSLayoutYAxisAnchor { return centerYAnchor }
	
	
	func top(to anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
		return top.constraint(equalTo: anchor)
	}
	
	func top(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return top(to: other.top)
	}
	
	func leading(to other: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return leading.constraint(equalTo: other)
	}
	
	func leading(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return leading(to: other.leading)
	}
	
	func left(to other: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return left.constraint(equalTo: other)
	}
	
	func left(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return left(to: other.left)
	}
	
	func bottom(to other: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
		return bottom.constraint(equalTo: other)
	}
	
	func bottom(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return bottom(to: other.bottom)
	}
	
	func right(to other: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return right.constraint(equalTo: right)
	}
	
	func right(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return right(to: other.right)
	}
	
	func trailing(to other: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return trailing.constraint(equalTo: other)
	}
	
	func trailing(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return trailing(to: other.trailing)
	}
	
	func topLeading(to other: LayoutAnchoring) -> [NSLayoutConstraint] {
		return [top(to: other), leading(to: other)]
	}
	
	func topTrailing(to other: LayoutAnchoring) -> [NSLayoutConstraint] {
		return [top(to: other), trailing(to: other)]
	}
	
	func bottomLeading(to other: LayoutAnchoring) -> [NSLayoutConstraint] {
		return [bottom(to: other), leading(to: other)]
	}
	
	func bottomTrailing(to other: LayoutAnchoring) -> [NSLayoutConstraint] {
		return [bottom(to: other), trailing(to: other)]
	}
	
	func fit(to other: LayoutAnchoring) -> [NSLayoutConstraint] {
		return topLeading(to: other) + bottomTrailing(to: other)
	}
	
	func width(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return widthAnchor.constraint(equalTo: other.widthAnchor)
	}
	
	func height(to other: LayoutAnchoring) -> NSLayoutConstraint {
		return heightAnchor.constraint(equalTo: other.heightAnchor)
	}
	
	func size(to other: LayoutAnchoring) -> [NSLayoutConstraint] {
		return [width(to: other), height(to: other)]
	}
	
	func center(to centers: LayoutAnchoring)
		-> [NSLayoutConstraint]
	{
		return [
			centerXAnchor.constraint(equalTo: centers.centerX),
			centerYAnchor.constraint(equalTo: centers.centerY)
		]
	}
	
	func top(to topTo: NSLayoutYAxisAnchor? = nil,
			 leadingTo: NSLayoutXAxisAnchor? = nil,
			 bottomTo: NSLayoutYAxisAnchor? = nil,
			 trailingTo: NSLayoutXAxisAnchor? = nil)
		-> [NSLayoutConstraint]
	{
		var constraints = [NSLayoutConstraint]()
		
		if let top = topTo {
			constraints.append(self.top(to: top))
		}
		
		if let leading = leadingTo {
			constraints.append(self.leading(to: leading))
		}
		
		if let bottom = bottomTo {
			constraints.append(self.bottom(to: bottom))
		}
		
		if let trailing = trailingTo {
			constraints.append(self.trailing(to: trailing))
		}
		
		return constraints
	}
}


public extension Array where Element == NSLayoutConstraint {
	var isActive: Bool {
		get {
			return reduce(true) { $0 && $1.isActive }
		}
		set {
			forEach { $0.isActive = newValue }
		}
	}
	
	func inset(by inset: UIEdgeInsets) -> Array {
		return self + inset
	}
	
	func inset(by amount: CGFloat) -> Array {
		return self + [amount, amount, -amount, -amount]
	}
	
	func offset(by amount: CGFloat) -> Array {
		return self + amount
	}
}

public func + (lhs: [NSLayoutConstraint], rhs: CGFloat) -> [NSLayoutConstraint] {
	return lhs + [CGFloat](repeating: rhs, count: lhs.count)
}

public func - (lhs: [NSLayoutConstraint], rhs: CGFloat) -> [NSLayoutConstraint] {
	return lhs + -rhs
}

public func + (lhs: [NSLayoutConstraint], rhs: [CGFloat]) -> [NSLayoutConstraint] {
	assert(lhs.count == rhs.count, "Error: The number of elements on the left side does not match the right side. \(lhs.count) vs \(rhs.count) items")
	
	return lhs.enumerated().map {
		$0.element.constant += rhs[$0.offset]
		return $0.element
	}
}

public func - (lhs: [NSLayoutConstraint], rhs: [CGFloat]) -> [NSLayoutConstraint] {
	return lhs + rhs.map { -$0 }
}

public func + (lhs: [NSLayoutConstraint], rhs: UIEdgeInsets) -> [NSLayoutConstraint] {
	return lhs + [rhs.top, rhs.left, rhs.bottom, rhs.right]
}

public func - (lhs: [NSLayoutConstraint], rhs: UIEdgeInsets) -> [NSLayoutConstraint] {
	return lhs + UIEdgeInsets(top: -rhs.top,
							  left: -rhs.left,
							  bottom: -rhs.bottom,
							  right: -rhs.right)
}

public func * (lhs: [NSLayoutConstraint], rhs: [CGFloat]) -> [NSLayoutConstraint] {
	assert(lhs.count == rhs.count, "Error: The number of elements on the left side does not match the right side. \(lhs.count) vs \(rhs.count) items")
	
	return lhs.enumerated().map {
		return $0.element.multiplier(setTo: rhs[$0.offset])
	}
}

public func * (lhs: [NSLayoutConstraint], rhs: CGFloat) -> [NSLayoutConstraint] {
	return lhs * [CGFloat](repeating: rhs, count: lhs.count)
}

public extension NSLayoutConstraint {
	func multiplier(setTo multiplier: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(
			item: firstItem as Any,
			attribute: firstAttribute,
			relatedBy: relation,
			toItem: secondItem,
			attribute: secondAttribute,
			multiplier: multiplier,
			constant: constant)
	}
}
