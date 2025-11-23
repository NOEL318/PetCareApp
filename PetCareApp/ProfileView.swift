//
//  ProfileView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//


//
//  ProfileView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(themeManager.colors.secondary)
                
                Text("Noel Rincón")
                    .font(.title2)
                    .bold()
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Mis Mascotas")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Image(systemName: "pawprint.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(themeManager.colors.primary)
                        VStack(alignment: .leading) {
                            Text("Silver")
                                .font(.headline)
                            Text("Schnauzer - 19 años")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Perfil")
    }
}

#Preview {
    ProfileView()
        .environmentObject(ThemeManager())
}
