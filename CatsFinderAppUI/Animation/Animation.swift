//
//  Animation.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 01.11.2022.
//

import SwiftUI
import Lottie

struct LoaderImage: UIViewRepresentable {
    let animationName: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(animationName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
