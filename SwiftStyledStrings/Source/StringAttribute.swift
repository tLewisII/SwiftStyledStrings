//
//  StringAttribute.swift
//  AttributedStringBuilder
//
//  Created by Terry Lewis II on 7/28/14.
//  Copyright (c) 2014 Blue Plover Productions LLC. All rights reserved.
//

import Foundation

extension StringAttribute : Monoid {
    public typealias M = StringAttribute
    public func mempty() -> M {
        return .List([])
    }
    
    public func mappend(a:M) -> M {
        return self.append(a)
    }
}

public enum StringAttribute {
    case List([StringAttribute])
    case Font(UIFont)
    case ParagraphStyle(NSParagraphStyle)
    case BgColor(UIColor)
    case FgColor(UIColor)
    case Ligature(UInt)
    case Kern(Float)
    case StrikeThrough(NSUnderlineStyle)
    case Underline(NSUnderlineStyle)
    case StrokeWidth(Float)
    case Shadow(NSShadow)
    case VerticalGlyph(Int)
    case TextEffect
    case Attachment(NSTextAttachment)
    case Link(NSURL)
    case BaselineOffset(Float)
    case UnderlineColor(UIColor)
    case StrikeThroughColor(UIColor)
    case Obliqueness(Float)
    case Expansion(Float)
    case WritingDirection([NSWritingDirection])
    
    public func append(attr:StringAttribute) -> StringAttribute {
        switch (self, attr) {
        case let (.List(a), .List(b)):  return .List(a <> b)
        case let (.List(a), _):         return .List(a <> [attr])
        case let (_, .List(b)):         return .List([self] <> b)
        default:                        return .List([self, attr])
        }
    }
    
    private func key() -> NSString {
        switch self {
        case .Font(_):                  return NSFontAttributeName
        case .ParagraphStyle(_):        return NSParagraphStyleAttributeName
        case .BgColor(_):               return NSBackgroundColorAttributeName
        case .FgColor(_):               return NSForegroundColorAttributeName
        case .Ligature(_) :             return NSLigatureAttributeName
        case .Kern(_):                  return NSKernAttributeName
        case .StrikeThrough(_):         return NSStrikethroughStyleAttributeName
        case .Underline(_):             return NSUnderlineStyleAttributeName
        case .StrokeWidth(_):           return NSStrokeWidthAttributeName
        case .Shadow(_):                return NSShadowAttributeName
        case .VerticalGlyph(_):         return NSVerticalGlyphFormAttributeName
        case .TextEffect:               return NSTextEffectAttributeName
        case .Attachment(_):            return NSAttachmentAttributeName
        case .Link(_):                  return NSLinkAttributeName
        case .BaselineOffset(_):        return NSBaselineOffsetAttributeName
        case .UnderlineColor(_):        return NSUnderlineColorAttributeName
        case .StrikeThroughColor(_):    return NSStrikethroughColorAttributeName
        case .Obliqueness(_):           return NSObliquenessAttributeName
        case .Expansion(_):             return NSExpansionAttributeName
        case .WritingDirection(_):      return NSWritingDirectionAttributeName
        default:                        return ""
        }
    }
    
    
    private func makeAttribute() -> (String, AnyObject) {
        switch self {
        case let .Font(v):                  return (self.key(), v)
        case let .ParagraphStyle(v):        return (self.key(), v)
        case let .BgColor(v):               return (self.key(), v)
        case let .FgColor(v):               return (self.key(), v)
        case let .Ligature(v):              return (self.key(), v)
        case let .Kern(v):                  return (self.key(), v)
        case let .StrikeThrough(v):         return (self.key(), v.toRaw())
        case let .Underline(v):             return (self.key(), v.toRaw())
        case let .StrokeWidth(v):           return (self.key(), v)
        case let .Shadow(v):                return (self.key(), v)
        case let .VerticalGlyph(v):         return (self.key(), v)
        case let .TextEffect(v):            return (self.key(), NSTextEffectLetterpressStyle)
        case let .Attachment(v):            return (self.key(), v)
        case let .Link(v):                  return (self.key(), v)
        case let .BaselineOffset(v):        return (self.key(), v)
        case let .UnderlineColor(v):        return (self.key(), v)
        case let .StrikeThroughColor(v):    return (self.key(), v)
        case let .Obliqueness(v):           return (self.key(), v)
        case let .Expansion(v):             return (self.key(), v)
        case let .WritingDirection(v):      return (self.key(), v.map{$0.toRaw()})
        default:                            return ("", "")
        }
    }
    
    
    public func attributeDict() -> [String : AnyObject] {
        var dict = [String : AnyObject]()
        switch self {
        case let .List(a): return a.reduce([:]) { $0 <> $1.attributeDict() }
        default:
            let (k, v):(String, AnyObject) = self.makeAttribute()
            return [k : v]
        }
    }
    
    public func build(s:String) -> NSAttributedString {
        let dict = self.attributeDict()
        return NSAttributedString(string:s, attributes:dict)
    }
}
