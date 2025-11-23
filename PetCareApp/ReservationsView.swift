//
//  ReservationsView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//


//
//  ReservationsView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

struct ReservationsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        List {
            Section(header: Text("Próximas")) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Paseo con Roberto")
                            .font(.headline)
                            .foregroundColor(themeManager.colors.secondary)
                        Text("Mañana, 10:00 AM")
                            .font(.subheadline)
                    }
                    Spacer()
                    Text("Confirmado")
                        .font(.caption)
                        .padding(5)
                        .background(themeManager.colors.accent.opacity(0.3))
                        .cornerRadius(5)
                }
            }
            
            Section(header: Text("Historial")) {
                Text("Veterinaria (20 Nov)")
                Text("Guardería (15 Nov)")
            }
        }
        .navigationTitle("Mis Reservas")
    }
}

#Preview {
    ReservationsView()
        .environmentObject(ThemeManager())
}