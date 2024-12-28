//
//  CustomSignatureView.swift
//  DemoUI
//
//  Created by MAHESHWARAN on 28/12/24.
//

import SwiftUI
import PencilKit

struct CustomSignatureView: View {
  
  @State private var canvasView = PKCanvasView()
  @State private var selectedImage: UIImage?
  
  var body: some View {
    VStack(spacing: 20) {
      titleView(for: "Draw your Signature")
      
      PKCanvasRepresentable(canvasView: $canvasView, selectedImage: $selectedImage)
        .frame(height: 300)
        .background(Color.gray.opacity(0.1), in: .rect(cornerRadius: 16))
      
      toolbarView
      
      Divider()
            
      imageView
    }
    .padding(.horizontal)
    .frame(maxHeight: .infinity, alignment: .top)
  }
  
  // MARK: - PKCanvasRepresentable
  
  struct PKCanvasRepresentable: UIViewRepresentable {
    
    @Binding var canvasView: PKCanvasView
    
    @Binding var selectedImage: UIImage?
    
    func makeUIView(context: Context) -> PKCanvasView {
      canvasView.tool = PKInkingTool(.pen, color: .black, width: 1)
      canvasView.drawingPolicy = .anyInput
      canvasView.backgroundColor = .clear
      loadSelectedImage(to: canvasView)
      return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
    
    func loadSelectedImage(to canvas: PKCanvasView) {
      guard let image = selectedImage else { return }
      
      let imageView = UIImageView(image: image)
      imageView.frame = .init(x: 0, y: 0, width: image.size.width, height: image.size.height)
      imageView.contentMode = .scaleAspectFit
      imageView.clipsToBounds = true
      
      let subView = canvas.subviews[0]
      subView.addSubview(imageView)
      subView.sendSubviewToBack(imageView)
      canvas.becomeFirstResponder()
    }
  }
  
  // MARK: - ToolBar
  
  private var toolbarView: some View {
    HStack(spacing: 10) {
      Button("Reset Image") {
        selectedImage = nil
      }
      .foregroundStyle(.red)
      .buttonStyle(.bordered)
      
      Button("Clear") {
        canvasView.drawing = PKDrawing()
      }
      .buttonStyle(.bordered)
      
      Button("Save") {
        // To check empty case
        if !canvasView.drawing.bounds.isEmpty {
          selectedImage = canvasView.toImage
        }
      }
      .buttonStyle(.borderedProminent)
    }
  }
  
  // MARK: - Image View
  
  @ViewBuilder
  private var imageView: some View {
    if let selectedImage {
      titleView(for: "Selected Signature")
      
      Image(uiImage: selectedImage)
      
      shareButton(for: selectedImage)
    }
  }

  // MARK: - Share
  
  private func shareButton(for image: UIImage) -> some View {
    let image = Image(uiImage: image)
    
    return ShareLink(
      item: image,
      preview: SharePreview("Share Signature", image: image)) {
      Label("Share", systemImage: "square.and.arrow.up")
    }
  }
  
  // MARK: - Title
  
  func titleView(for title: String = "Signature") -> some View {
    Text(title)
      .font(.callout)
      .foregroundStyle(.secondary)
      .padding()
  }
}

// MARK: - Image Converter

extension PKCanvasView {
  
  var toImage: UIImage {
    let imageRenderer = UIGraphicsImageRenderer(bounds: drawing.bounds)
    
    return imageRenderer.image { context in
      layer.render(in: context.cgContext)
    }
  }
}

// MARK: - Preview

struct CustomSignatureView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSignatureView()
  }
}
