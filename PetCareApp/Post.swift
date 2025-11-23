//
//  FeedView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

// 1. Modelo de Datos
struct Post: Identifiable {
    let id = UUID()
    let author: String
    let authorImage: String
    let timeAgo: String
    let category: String
    let imageContent: String
    let title: String
    let description: String
    let likes: Int
}

struct FeedView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    // DETECTOR DE MODO OSCURO
    @Environment(\.colorScheme) var colorScheme
    
    // Variable Computada para el color de iconos/texto
    // Si es Dark Mode -> Usa Cyan (Accent). Si es Light -> Usa Azul (Secondary)
    var adaptiveColor: Color {
        return colorScheme == .dark ? themeManager.colors.accent : themeManager.colors.secondary
    }
    
    // 2. Datos de prueba
    let posts: [Post] = [
        Post(author: "Dr. Veterinario", authorImage: "cross.case.fill", timeAgo: "2h", category: "Salud", imageContent: "heart.text.square.fill", title: "¡Cuidado con el calor!", description: "En días soleados, recuerda que el asfalto puede quemar las almohadillas de tu perro. Pon tu mano 5 segundos; si quema, no pasees.", likes: 1240),
        Post(author: "Pet News", authorImage: "newspaper.fill", timeAgo: "5h", category: "Noticia", imageContent: "syringe.fill", title: "Campaña de Vacunación", description: "Este fin de semana habrá campaña gratuita de vacunación antirrábica en el parque central. ¡No faltes!", likes: 856),
        Post(author: "Entrenador Canino", authorImage: "figure.walk.dog", timeAgo: "1d", category: "Tip", imageContent: "tennisball.fill", title: "Ansiedad por separación", description: "Deja juguetes interactivos cuando salgas de casa para mantener su mente ocupada y reducir el estrés.", likes: 2300)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // --- HEADER PERSONALIZADO (ADAPTATIVO) ---
            HStack {
                Text("Pet Feed")
                    .font(.title)
                    .fontWeight(.bold)
                    // CAMBIO AQUÍ: Usa el color adaptativo
                    .foregroundColor(adaptiveColor)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Image(systemName: "plus.app")
                        .font(.title2)
                    Image(systemName: "heart")
                        .font(.title2)
                    Image(systemName: "bell.badge")
                        .font(.title2)
                }
                // CAMBIO AQUÍ: Usa el color adaptativo
                .foregroundColor(adaptiveColor)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .background(Color(.systemBackground))
            
            // --- CONTENIDO SCROLLABLE ---
            ScrollView {
                VStack(spacing: 0) {
                    
                    // SECCIÓN 1: HISTORIAS
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            StoryCircle(name: "Tu Tip", icon: "plus", isMyStory: true)
                            StoryCircle(name: "Nutrición", icon: "carrot.fill", isMyStory: false)
                            StoryCircle(name: "Higiene", icon: "drop.fill", isMyStory: false)
                            StoryCircle(name: "Juegos", icon: "figure.play", isMyStory: false)
                            StoryCircle(name: "Adopción", icon: "pawprint.fill", isMyStory: false)
                        }
                        .padding()
                    }
                    
                    Divider()
                    
                    // SECCIÓN 2: EL FEED
                    ForEach(posts) { post in
                        FeedPostView(post: post)
                            .padding(.bottom, 10)
                    }
                    
                    // Espacio al final
                    Color.clear.frame(height: 100)
                }
            }
        }
    }
}

// MARK: - COMPONENTE: Círculo de Historias
struct StoryCircle: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme // Necesario aquí también
    
    let name: String
    let icon: String
    let isMyStory: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: isMyStory ? [.gray.opacity(0.3)] : [themeManager.colors.primary, themeManager.colors.accent],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
                    .frame(width: 68, height: 68)
                
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.title2)
                    // CAMBIO AQUÍ: Lógica adaptativa para el icono
                    .foregroundColor(isMyStory ? .blue : (colorScheme == .dark ? themeManager.colors.accent : themeManager.colors.secondary))
            }
            Text(name)
                .font(.caption)
                .foregroundColor(.primary)
        }
    }
}

// MARK: - COMPONENTE: Tarjeta del Post
struct FeedPostView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme // Necesario aquí también
    
    let post: Post
    @State private var isLiked = false
    @State private var isSaved = false
    
    // Variable auxiliar local
    var adaptiveColor: Color {
        return colorScheme == .dark ? themeManager.colors.accent : themeManager.colors.secondary
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // HEADER POST
            HStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 32, height: 32)
                    // CAMBIO AQUÍ: Icono del autor
                    .overlay(Image(systemName: post.authorImage).font(.caption).foregroundColor(adaptiveColor))
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(post.author)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary) // El autor siempre legible
                    Text(post.category)
                        .font(.caption2)
                        .foregroundColor(themeManager.colors.primary)
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.primary)
            }
            .padding(10)
            
            // IMAGEN
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray6))
                    .aspectRatio(1.0, contentMode: .fit)
                
                Image(systemName: post.imageContent)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    // CAMBIO AQUÍ: La imagen placeholder
                    .foregroundColor(adaptiveColor.opacity(0.5))
            }
            
            // ACCIONES
            HStack(spacing: 16) {
                Button(action: { withAnimation { isLiked.toggle() }}) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(isLiked ? .red : .primary)
                }
                Image(systemName: "bubble.right").font(.title2)
                Image(systemName: "paperplane").font(.title2)
                Spacer()
                Button(action: { withAnimation { isSaved.toggle() }}) {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .font(.title2)
                        // CAMBIO AQUÍ: El icono de guardar
                        .foregroundColor(isSaved ? themeManager.colors.primary : .primary)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            
            // TEXTO
            VStack(alignment: .leading, spacing: 4) {
                Text("\(post.likes) Me gusta").font(.footnote).bold()
                (Text(post.author).bold() + Text(" ") + Text(post.description))
                    .font(.footnote)
                    .lineLimit(3)
                Text("Hace \(post.timeAgo)").font(.caption).foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    // Truco para ver el Dark Mode en el Preview
    FeedView()
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
