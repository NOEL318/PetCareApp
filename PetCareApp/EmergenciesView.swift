//
//  EmergenciesView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//


//
//  EmergenciesView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

struct EmergenciesView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Cabecera de alerta
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    Text("Hospital del Dr Simi")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .background(themeManager.colors.primary) // Color dinámico
                .cornerRadius(20)
                
                // Lista de teléfonos
                VStack(alignment: .leading, spacing: 15) {
                    ContactRow(title: "Ambulancia Veterinaria", phone: "911-PET")
                    ContactRow(title: "Hospital del Dr Simi 24h", phone: "555-0123")
                    ContactRow(title: "Control de Intoxicaciones", phone: "800-0182989")
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Emergencias")
    }
}

// Subcomponente local para esta vista
struct ContactRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    let title: String
    let phone: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(phone).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "phone.circle.fill")
                    .font(.title)
                    .foregroundColor(themeManager.colors.primary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    EmergenciesView()
        .environmentObject(ThemeManager())
}
