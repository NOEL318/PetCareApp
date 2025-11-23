//
//  CaregiversView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//


//
//  CaregiversView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

struct CaregiversView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1...5, id: \.self) { i in
                    HStack(spacing: 15) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading) {
                            Text("Cuidador \(i)")
                                .font(.headline)
                            Text("⭐⭐⭐⭐⭐ (4.\(i))")
                                .font(.caption)
                                .foregroundColor(themeManager.colors.primary)
                            Text("Disponible hoy")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("$15/h")
                            .font(.headline)
                            .foregroundColor(themeManager.colors.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                }
            }
            .padding()
        }
        .navigationTitle("Cuidadores")
    }
}

#Preview {
    CaregiversView()
        .environmentObject(ThemeManager())
}