//
//  HomeView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

// 1. Enum para controlar las pestañas
enum Tab: String, CaseIterable {
    case home = "Inicio"
    case emergencies = "Urgencias"
    case caregivers = "Cuidadores"
    case feed = "Feed"
    case profile = "Perfil"
}

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    // 2. Estado para saber qué pestaña está activa (Por defecto: Inicio)
    @State private var selectedTab: Tab = .home
    
    // Grid para la vista de Inicio
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // CAPA 1: EL CONTENIDO CAMBIANTE
            // Usamos un switch para decidir qué pantalla pintar
            switch selectedTab {
            case .home:
                HomeContent(columns: columns, selectedTab: $selectedTab) // Pasamos el binding para poder navegar desde los botones grandes también
            case .emergencies:
                EmergenciesView()
            case .caregivers:
                CaregiversView()
            case .feed:
                FeedView()
            case .profile:
                ProfileView()
            }
            
            // CAPA 2: BARRA DE NAVEGACIÓN
            // Le pasamos la variable 'selectedTab' para que sepa cuál pintar azul
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.horizontal)
                .padding(.bottom, 10)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// --- SUB-VISTA: CONTENIDO DEL HOME (Para no ensuciar el switch) ---
struct HomeContent: View {
    let columns: [GridItem]
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var selectedTab: Tab // Recibimos el control para cambiar pestañas
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    // BOTONES GRANDES QUE AHORA CAMBIAN LA PESTAÑA
                    
                    // Botón Urgencias -> Cambia a pestaña .emergencies
                    Button(action: { selectedTab = .emergencies }) {
                        HomeCard(icon: "phone.fill", title: "Emergencias 24/7")
                    }
                    
                    // Botón Cuidadores -> Cambia a pestaña .caregivers
                    Button(action: { selectedTab = .caregivers }) {
                        HomeCard(icon: "shield.checkerboard", title: "Cuidadores Verificados")
                    }
                    
                    // Botón Lugares (Este no tiene pestaña propia en la barra, así que usamos NavigationLink clásico)
                    NavigationLink(destination: PetFriendlyView()) {
                        HomeCard(icon: "mappin.and.ellipse", title: "Explorar Lugares Pet Friendly")
                    }
                    
                    // Botón Reservas (Igual, navegación clásica)
                    NavigationLink(destination: ReservationsView()) {
                        HomeCard(icon: "calendar", title: "Mis Reservas")
                    }
                    
                    // Botón Perfil -> Cambia a pestaña .profile
                    Button(action: { selectedTab = .profile }) {
                        HomeCard(icon: "person.fill", title: "Perfil y Mascotas")
                    }
                }
                .padding(.bottom, 100)
            }
            .padding()
        }
    }
}

// --- COMPONENTE: TARJETA ROJA ---
struct HomeCard: View {
    @EnvironmentObject var themeManager: ThemeManager
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(themeManager.colors.primary)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// --- COMPONENTE: BARRA FUNCIONAL ---
struct CustomTabBar: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var selectedTab: Tab // Vinculación bidireccional
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarItem(icon: "house.fill", tab: .home, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(icon: "cross.case.fill", tab: .emergencies, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(icon: "person.2.fill", tab: .caregivers, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(icon: "list.bullet.rectangle.fill", tab: .feed, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(icon: "person.fill", tab: .profile, selectedTab: $selectedTab)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 25)
        .background(themeManager.colors.secondary)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// --- COMPONENTE: ITEM DE BARRA INTERACTIVO ---
struct TabBarItem: View {
    @EnvironmentObject var themeManager: ThemeManager
    let icon: String
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var isSelected: Bool {
        selectedTab == tab
    }
    
    var body: some View {
        Button(action: {
            // Acción: Cambiar la pestaña seleccionada con animación suave
            withAnimation(.spring()) {
                selectedTab = tab
            }
        }) {
            VStack(spacing: 4) {
                ZStack {
                    // El círculo blanco solo aparece si está seleccionado
                    if isSelected {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40)
                            .transition(.scale) // Animación de aparición
                    }
                    
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        // Si está seleccionado, el icono toma el color del tema. Si no, es gris claro/blanco opaco.
                        .foregroundColor(isSelected ? themeManager.colors.secondary : .white.opacity(0.7))
                }
                
                // Texto opcional (puedes ocultarlo si no está seleccionado para ahorrar espacio)
                if isSelected {
                    Text(tab.rawValue)
                        .font(.caption2)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ThemeManager())
        .withAccessibility()
}
