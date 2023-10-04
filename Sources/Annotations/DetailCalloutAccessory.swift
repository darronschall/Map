//
//  DetailCalloutAccessory.swift
//  Map
//
//  Created by Darron Schall on 10/4/23.
//

#if !os(watchOS)

import Foundation
import MapKit
import SwiftUI

private struct DetailCalloutAccessory<Annotation: MapAnnotation, Content: View>: MapAnnotation {

    // MARK: Static Functions

    static func registerView(on mapView: MKMapView) {
        Annotation.registerView(on: mapView)
    }

    // MARK: Stored Properties

    private let wrappedAnnotation: Annotation
    private let content: () -> Content

    // MARK: Computed Properties

    var annotation: MKAnnotation {
        wrappedAnnotation.annotation
    }

    // MARK: Initialization

    init(_ annotation: Annotation, @ViewBuilder content: @escaping () -> Content) {
        self.wrappedAnnotation = annotation
        self.content = content
    }

    // MARK: Methods

    func view(for mapView: MKMapView) -> MKAnnotationView? {
        guard let view = wrappedAnnotation.view(for: mapView) else {
            return nil
        }

        if Content.self != EmptyView.self {
            view.canShowCallout = true

            view.detailCalloutAccessoryView = NativeHostingController(rootView: content()).view

            #if canImport(UIKit)
            view.detailCalloutAccessoryView!.backgroundColor = .clear
            #endif
        } else {
            view.canShowCallout = false
            view.detailCalloutAccessoryView = nil
        }

        return view
    }

}

extension MapAnnotation {

    public func detailCalloutAccessory<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some MapAnnotation {
        DetailCalloutAccessory(self, content: content)
    }

}

#endif
