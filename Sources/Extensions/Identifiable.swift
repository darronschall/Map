//
//  IdentifiableObject.swift
//  Map
//
//  Created by Paul Kraft on 23.04.22.
//

import Foundation

public struct IdentifiableObject<Object: AnyObject>: Identifiable, Equatable {

    let object: Object

    public var id: ObjectIdentifier {
        ObjectIdentifier(object)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
