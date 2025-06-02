//
//  PlantsCard.swift
//  FloraLab
//
//  Created by Otávio Augusto on 12/02/25.
//
import SceneKit
import SwiftUI

struct PlantScene: UIViewRepresentable {
    typealias UIViewType = SCNView
    typealias Context = UIViewRepresentableContext<PlantScene>
    
    @StateObject private var motion =  MotionManager()
    let plant: String

    func updateUIView(_ uiView: UIViewType, context: Context) {}
    func makeUIView(context: Context) -> UIViewType {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.backgroundColor = UIColor.clear
        view.scene = SCNScene(named: plant)!
        return view
    }
}

struct PlantVisualizer: View {
    @StateObject private var motion =  MotionManager()
    var plant: BasePlant?
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color("Rain").shadow(.inner(color: Color("Nightime").opacity(0.5), radius: 12, x: motion.x * -3, y: motion.y * -3)))
            if let model = plant?.modelName {
                PlantScene(plant: model)
            } else {
                Image(systemName: "waveform.path.ecg")
                    .foregroundStyle(Color("BlueCode"))
                    .font(.system(size: 60))
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .rotation3DEffect(.degrees(motion.y * 4), axis: (x: -1, y: 0, z: 0))
        .rotation3DEffect(.degrees(motion.x * 4), axis: (x: 0, y: 1, z: 0))
    }
}
