//
//  PetFriendlyView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//


//
//  PetFriendlyView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

struct PetFriendlyView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack {
            // Placeholder de Mapa
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 250)
                VStack {
                    Image(systemName: "map.fill")
                        .font(.largeTitle)
                        .foregroundColor(themeManager.colors.secondary)
                    Text("Mapa de la zona")
                        .foregroundColor(.gray)
                }
            }
            
            List {
                Section(header: Text("Lugares Cercanos")) {
                    Label("Parque Central", systemImage: "tree.fill")
                    Label("Café 'El Gato'", systemImage: "cup.and.saucer.fill")
                    Label("Plaza Mascotas", systemImage: "bag.fill")
                }
            }
        }
        .navigationTitle("Explorar")
    }
}

#Preview {
    PetFriendlyView()
        .environmentObject(ThemeManager())
}