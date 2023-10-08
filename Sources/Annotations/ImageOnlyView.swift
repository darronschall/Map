//
//  ImageOnlyView.swift
//
//  Helper for optimizing ViewMapAnnotation content where the content
//  contains a single image.
//
//  Created by Darron Schall on 10/10/23.
//

import SwiftUI

#if canImport(UIKit)

import UIKit

public protocol ImageOnlyView: View {
    var image: UIImage { get }
}

#else

public protocol ImageOnlyView: View {
    var image: NSImage { get }
}

#endif


extension ImageOnlyView {
    public var body: some View {
        EmptyView()
    }
}
