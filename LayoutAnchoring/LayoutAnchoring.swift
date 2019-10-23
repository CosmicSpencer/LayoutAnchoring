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

	convenience init(_ sized: CGSize) {
		self.init(frame: CGRect(x: 0, y: 0,
								width: sized.width,
								height: sized.height))
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
	
	
    @discardableResult func top(to anchor: NSLayoutYAxisAnchor,
                                constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        let c = top.constraint(equalTo: anchor, constant: constant)
		c.isActive = true
		return c
	}
	
    @discardableResult func top(to other: LayoutAnchoring,
                                constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
		return top(to: other.top, constant: constant)
	}
	
    @discardableResult func leading(to other: NSLayoutXAxisAnchor,
                                    constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
		let c = leading.constraint(equalTo: other, constant: constant)
		c.isActive = true
		return c
	}
	
    @discardableResult func leading(to other: LayoutAnchoring,
                                    constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        return leading(to: other.leading, constant: constant)
	}
	
    @discardableResult func left(to other: NSLayoutXAxisAnchor,
                                 constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
		let c = left.constraint(equalTo: other, constant: constant)
		c.isActive = true
		return c
	}
	
    @discardableResult func left(to other: LayoutAnchoring,
                                 constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        return left(to: other.left, constant: constant)
	}
	
    @discardableResult func bottom(to other: NSLayoutYAxisAnchor,
                                   constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
		let c = bottom.constraint(equalTo: other, constant: constant)
		c.isActive = true
		return c
	}
	
    @discardableResult func bottom(to other: LayoutAnchoring,
                                   constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        return bottom(to: other.bottom, constant: constant)
	}
	
    @discardableResult func right(to other: NSLayoutXAxisAnchor,
                                  constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        let c = right.constraint(equalTo: right, constant: constant)
		c.isActive = true
		return c
	}
	
    @discardableResult func right(to other: LayoutAnchoring,
                                  constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        return right(to: other.right, constant: constant)
	}
	
    @discardableResult func trailing(to other: NSLayoutXAxisAnchor,
                                     constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
		let c = trailing.constraint(equalTo: other, constant: constant)
		c.isActive = true
		return c
	}
	
    @discardableResult func trailing(to other: LayoutAnchoring,
                                     constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
		return trailing(to: other.trailing, constant: constant)
	}
	
	@discardableResult func topLeading(to other: LayoutAnchoring,
                                       inset: UIEdgeInsets = .zero)
        -> [NSLayoutConstraint]
    {
		return [top(to: other, constant: inset.top), leading(to: other, constant: inset.left)]
	}
	
	@discardableResult func topTrailing(to other: LayoutAnchoring,
                                        inset: UIEdgeInsets = .zero)
        -> [NSLayoutConstraint]
    {
        return [top(to: other, constant: inset.top), trailing(to: other, constant: inset.right)]
	}
	
	@discardableResult func bottomLeading(to other: LayoutAnchoring,
                                          inset: UIEdgeInsets = .zero)
        -> [NSLayoutConstraint]
    {
        return [bottom(to: other, constant: inset.bottom), leading(to: other, constant: inset.left)]
	}
	
	@discardableResult func bottomTrailing(to other: LayoutAnchoring,
                                           inset: UIEdgeInsets = .zero)
        -> [NSLayoutConstraint]
    {
        return [bottom(to: other, constant: inset.bottom), trailing(to: other, constant: inset.right)]
	}
	
	@discardableResult func topBottom(to other: LayoutAnchoring,
									  inset: UIEdgeInsets = .zero)
		-> [NSLayoutConstraint]
	{
		return [top(to: other, constant: inset.top), bottom(to: other, constant: inset.bottom)]
	}

	@discardableResult func leadingTrailing(to other: LayoutAnchoring,
									  inset: UIEdgeInsets = .zero)
		-> [NSLayoutConstraint]
	{
		return [leading(to: other, constant: inset.left), trailing(to: other, constant: inset.right)]
	}

    @discardableResult func fit(to other: LayoutAnchoring,
                                inset: UIEdgeInsets = .zero)
        -> [NSLayoutConstraint]
    {
        return topLeading(to: other, inset: inset) + bottomTrailing(to: other, inset: inset)
	}
	
    @discardableResult func width(to other: LayoutAnchoring,
                                  multiplier: CGFloat = 1,
                                  constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        let c = widthAnchor.constraint(equalTo: other.widthAnchor,
                                       multiplier: multiplier,
                                       constant: constant)
		c.isActive = true
		return c
	}
	
	@discardableResult func width(_ constant: CGFloat) -> NSLayoutConstraint {
		let c = widthAnchor.constraint(equalToConstant: constant)
		c.isActive = true
		return c
	}
	
	@discardableResult func height(to other: LayoutAnchoring,
                                   multiplier: CGFloat = 1,
                                   constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        let c = heightAnchor.constraint(equalTo: other.heightAnchor,
                                        multiplier: multiplier,
                                        constant: constant)
		c.isActive = true
		return c
	}
	
	@discardableResult func height(_ constant: CGFloat) -> NSLayoutConstraint {
		let c = heightAnchor.constraint(equalToConstant: constant)
		c.isActive = true
		return c
	}
	
	@discardableResult func square() -> NSLayoutConstraint {
		let c = NSLayoutConstraint(item: self,
								   attribute: .height,
								   relatedBy: .equal,
								   toItem: self,
								   attribute: .width,
								   multiplier: 1,
								   constant: 0)
		c.isActive = true
		return c
	}
	
    @discardableResult func size(to other: LayoutAnchoring,
                                 multiplier: CGFloat = 1,
                                 constant: CGFloat = 0)
        -> [NSLayoutConstraint]
    {
		return [width(to: other), height(to: other)]
	}
	
	@discardableResult func sized(_ size: CGSize) -> [NSLayoutConstraint] {
		return [width(size.width), height(size.height)]
	}

	@discardableResult func centerX(to other: LayoutAnchoring, constant: CGFloat = 0)
		-> NSLayoutConstraint
	{
		let c = centerX.constraint(equalTo: other.centerX, constant: constant)
		c.isActive = true
		return c
	}

	@discardableResult func centerY(to other: LayoutAnchoring, constant: CGFloat = 0)
		-> NSLayoutConstraint
	{
		let c = centerY.constraint(equalTo: other.centerY, constant: constant)
		c.isActive = true
		return c
	}
	
	@discardableResult func center(to other: LayoutAnchoring, constant: CGPoint = .zero)
		-> [NSLayoutConstraint]
	{
		let constraints = [centerX(to: other, constant: constant.x),
						   centerY(to: other, constant: constant.y)]
		constraints.forEach { $0.isActive = true }
		return constraints
	}
	
	@discardableResult func top(to topTo: NSLayoutYAxisAnchor? = nil,
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

	@discardableResult func snapTop(to other: LayoutAnchoring,
									   inset: UIEdgeInsets = .zero)
		-> [NSLayoutConstraint]
	{
		return [leading(to: other.leading, constant: inset.left),
				top(to: other.top, constant: inset.top),
				trailing(to: other.trailing, constant: inset.right)]
	}

	@discardableResult func snapBottom(to other: LayoutAnchoring,
									   inset: UIEdgeInsets = .zero)
		-> [NSLayoutConstraint]
	{
		return [leading(to: other.leading, constant: inset.left),
				bottom(to: other.bottom, constant: inset.bottom),
				trailing(to: other.trailing, constant: inset.right)]
	}
    
    @discardableResult func vSpace(to other: LayoutAnchoring,
                                   multiplier: CGFloat = 1,
                                   constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
		return bottom(to: other.top, constant: constant)
    }

    @discardableResult func hSpace(to other: LayoutAnchoring,
                                   multiplier: CGFloat = 1,
                                   constant: CGFloat = 0)
        -> NSLayoutConstraint
    {
        return trailing(to: other.leading, constant: constant)
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
	
	@discardableResult func inset(by inset: UIEdgeInsets) -> Array {
		return self + inset
	}
	
	@discardableResult func inset(by amount: CGFloat) -> Array {
		return self + [amount, amount, -amount, -amount]
	}
	
	@discardableResult func offset(by amount: CGFloat) -> Array {
		return self + amount
	}
}

@discardableResult public func + (lhs: [NSLayoutConstraint], rhs: CGFloat) -> [NSLayoutConstraint] {
	return lhs + [CGFloat](repeating: rhs, count: lhs.count)
}

@discardableResult public func - (lhs: [NSLayoutConstraint], rhs: CGFloat) -> [NSLayoutConstraint] {
	return lhs + -rhs
}

@discardableResult public func + (lhs: [NSLayoutConstraint], rhs: [CGFloat]) -> [NSLayoutConstraint] {
	assert(lhs.count == rhs.count, "Error: The number of elements on the left side does not match the right side. \(lhs.count) vs \(rhs.count) items")
	
	return lhs.enumerated().map {
		$0.element.constant += rhs[$0.offset]
		return $0.element
	}
}

@discardableResult public func - (lhs: [NSLayoutConstraint], rhs: [CGFloat]) -> [NSLayoutConstraint] {
	return lhs + rhs.map { -$0 }
}

@discardableResult public func + (lhs: [NSLayoutConstraint], rhs: UIEdgeInsets) -> [NSLayoutConstraint] {
	return lhs + [rhs.top, rhs.left, rhs.bottom, rhs.right]
}

@discardableResult public func - (lhs: [NSLayoutConstraint], rhs: UIEdgeInsets) -> [NSLayoutConstraint] {
	return lhs + UIEdgeInsets(top: -rhs.top,
							  left: -rhs.left,
							  bottom: -rhs.bottom,
							  right: -rhs.right)
}

@discardableResult public func * (lhs: [NSLayoutConstraint], rhs: [CGFloat]) -> [NSLayoutConstraint] {
	assert(lhs.count == rhs.count, "Error: The number of elements on the left side does not match the right side. \(lhs.count) vs \(rhs.count) items")
	
	return lhs.enumerated().map {
		return $0.element.multiplier(setTo: rhs[$0.offset])
	}
}

@discardableResult public func * (lhs: [NSLayoutConstraint], rhs: CGFloat) -> [NSLayoutConstraint] {
    return lhs * [CGFloat](repeating: rhs, count: lhs.count)
}

@discardableResult public func + (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
    return ([lhs] + rhs).first!
}

@discardableResult public func - (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
    return ([lhs] - rhs).first!
}

@discardableResult public func * (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
    return ([lhs] * rhs).first!
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


extension UILabel {
	public convenience init(_ text: String? = nil, font: UIFont? = nil, alignment: NSTextAlignment? = nil, textColor: UIColor? = nil) {
		self.init()
        
        if let text = text {
            self.text = text
        }
        
        if let font = font {
            self.font = font
        }
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
		
		if let color = textColor {
			self.textColor = color
		}
        
		sizeToFit()
	}
}

extension UIButton {
    public convenience init(_ title: String? = nil, image: UIImage? = nil, font: UIFont? = nil, textColor: UIColor? = nil) {
		self.init()
        
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        if let image = image {
            setImage(image, for: .normal)
        }
		
		if let font = font {
			titleLabel?.font = font
		}
		
		if let textColor = textColor {
			setTitleColor(textColor, for: .normal)
		}
		
		sizeToFit()
	}
}


public func hStack(views: [UIView],
				   spacing: CGFloat? = nil,
                   alignment: UIStackView.Alignment? = nil,
                   distribution: UIStackView.Distribution? = nil)
    -> UIStackView
{
    return stack(views: views,
				 axis: .horizontal,
                 spacing: spacing,
                 alignment: alignment,
				 distribution: distribution)
}

public func vStack(views: [UIView],
				   spacing: CGFloat? = nil,
                   alignment: UIStackView.Alignment? = nil,
                   distribution: UIStackView.Distribution? = nil)
    -> UIStackView
{
	return stack(views: views,
				 axis: .vertical,
                 spacing: spacing,
                 alignment: alignment,
                 distribution: distribution)
}

public func stack(views: [UIView],
				  axis: NSLayoutConstraint.Axis = .vertical,
                  spacing: CGFloat? = nil,
                  alignment: UIStackView.Alignment? = nil,
                  distribution: UIStackView.Distribution? = nil)
    -> UIStackView
{
    views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    let stack = UIStackView(arrangedSubviews: views)
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    stack.axis = axis

    if let spacing = spacing {
        stack.spacing = spacing
    }
    
    if let alignment = alignment {
        stack.alignment = alignment
    }
    
    if let distribution = distribution {
        stack.distribution = distribution
    }
    
    return stack
}
@discardableResult public func equalWidths(_ views: [UIView])
    -> [NSLayoutConstraint]
{
    
    guard views.count > 1,
        let first = views.first else {
        return [] // nothing to set equal
    }
    
    return views[1...].map {
        $0.width(to: first)
    }
}

@discardableResult public func equalHeights(_ views: [UIView])
    -> [NSLayoutConstraint]
{
    
    guard views.count > 1,
        let first = views.first else {
            return [] // nothing to set equal
    }
    
    return views[1...].map {
        $0.height(to: first)
    }
}


@discardableResult public func equalSizes(_ views: [UIView])
    -> [NSLayoutConstraint]
{
    return equalWidths(views) + equalHeights(views)
}



public class Space: UIView {
	override init(frame: CGRect) {
		super.init(frame: .zero)
	}
	
	public convenience init(width: CGFloat? = nil, height: CGFloat? = nil) {
		self.init(frame: .zero)
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if let width = width {
			self.width(width)
		}
		
		if let height = height {
			self.height(height)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


public class FlexibleSpace: UIView {
	public convenience init() {
		self.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

public class PaddingView: UIView {
	public convenience init(_ view: UIView, inset insets: UIEdgeInsets) {
		self.init(frame: .zero)
		
		translatesAutoresizingMaskIntoConstraints = false
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		view.fit(to: self, inset: insets)
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
