import SwiftUI
import EffectsLibrary

struct ContentView: View {
    @State private var config = ConfettiConfig(
        content: [
            .emoji("❤️", 1),
            .emoji("❤️", 1),
            .emoji("❤️", 1)
        ],
        //        backgroundColor: .blue,
        intensity: .low,
        lifetime: .short,
        //        initialVelocity: .medium,
        fadeOut: .fast,
        spreadRadius: .medium,
        //        emitterPosition: .bottom,
        fallDirection: .upwards
    )

    @State private var showConfetti = false // Add this state variable
    @State private var confettiOpacity = 0.0 // Add this for opacity control

    // Create feedback generator
    let impactGenerator = UIImpactFeedbackGenerator(style: .medium)

    func playHapticSequence() {
        // Play initial haptic
        impactGenerator.impactOccurred()

        // Create 9 more haptics with delays
        for i in 1...9 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                self.impactGenerator.impactOccurred()
            }
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // BOX 1
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Box 1")
                            .frame(maxWidth: 262, minHeight: 185, maxHeight: 185)
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(10)
                            .overlay(
                                Image("missy")
                                    .resizable()
                                    .scaledToFit()
                            )
                            .background(
                                RoundedRectangle(cornerRadius:10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }

                    // BOX 2
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Box 2")
                            .frame(maxWidth: 262, minHeight: 185, maxHeight: 185)
                            .background(Color.white)
                            .overlay(
                                Image("lordbusiness")
                                    .resizable()
                                    .scaledToFit()
                            )
                            .overlay(
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }

                    // BOX 3
                    HStack(spacing: 1) {
                        Spacer()
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Box 3")
                                .frame(maxWidth: 262, minHeight: 185, maxHeight: 185)
                                .background(Color.blue)
                                .overlay(
                                    Image("venom")
                                        .resizable()
                                        .scaledToFit()
                                )
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }

                    // BOX 4
                    VStack(alignment: .trailing) {
                        ConfettiView(config: config)
                            .opacity(confettiOpacity) // Add opacity binding
                            .animation(.easeOut(duration: 1.0), value: confettiOpacity) // Animate opacity changes

                        Button(action: {
                            // Trigger haptic sequence
                            playHapticSequence()

                            showConfetti = true
                            confettiOpacity = 1.0 // Fade in

                            // Start fading out after a delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    confettiOpacity = 0.0 // Fade out
                                }
                            }

                            // Reset after animation completes
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                showConfetti = false
                            }
                        }) {
                            Text("Box 4")
                                .frame(maxWidth: 262, minHeight: 185, maxHeight: 185)
                                .background(Color.white)
                                .border(Color.gray, width: 1)
                                .overlay(
                                    Image("venom")
                                        .resizable()
                                        .scaledToFit()
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)

                }

            }


        }
        .padding()
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            impactGenerator.prepare()

            //            ConfettiView(config: config)
        }



    }


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
