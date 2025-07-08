//
//  NavigationBarModifier.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor
    var titleColor: UIColor
    var showShadow: Bool = true

    init(backgroundColor: UIColor, titleColor: UIColor, showShadow: Bool = true) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.showShadow = showShadow
    }

    func body(content: Content) -> some View {
        content
            .background(NavBarConfigurator(
                backgroundColor: backgroundColor,
                titleColor: titleColor,
                showShadow: showShadow
            ))
    }
}

struct NavBarConfigurator: UIViewControllerRepresentable {
    var backgroundColor: UIColor
    var titleColor: UIColor
    var showShadow: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        DispatchQueue.main.async {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
            
            if !showShadow {
                appearance.shadowColor = .clear
            }

            let navBar = UINavigationBar.appearance()
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
