// Vygeneruje jednoduchý úvodní obrázek článku (1200×675): přechod + symbol.
// swift make-obrazek.swift vystup.png symbol r1 g1 b1 r2 g2 b2
import AppKit
let a = CommandLine.arguments
let out = a[1], symbolName = a[2]
let c1 = (Double(a[3])!, Double(a[4])!, Double(a[5])!), c2 = (Double(a[6])!, Double(a[7])!, Double(a[8])!)
let w = 1200, h = 675
let space = CGColorSpace(name: CGColorSpace.sRGB)!
let ctx = CGContext(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: 0, space: space, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!
let colors = [CGColor(srgbRed: c1.0, green: c1.1, blue: c1.2, alpha: 1), CGColor(srgbRed: c2.0, green: c2.1, blue: c2.2, alpha: 1)] as CFArray
ctx.drawLinearGradient(CGGradient(colorsSpace: space, colors: colors, locations: [0, 1])!, start: CGPoint(x: 0, y: CGFloat(h)), end: CGPoint(x: CGFloat(w), y: 0), options: [])
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)
if let symbol = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil)?.withSymbolConfiguration(.init(pointSize: 300, weight: .regular)) {
    let s = symbol.size
    let tinted = NSImage(size: s, flipped: false) { r in symbol.draw(in: r); NSColor.white.withAlphaComponent(0.92).set(); r.fill(using: .sourceAtop); return true }
    tinted.draw(in: NSRect(x: (CGFloat(w) - s.width) / 2, y: (CGFloat(h) - s.height) / 2, width: s.width, height: s.height))
}
NSGraphicsContext.restoreGraphicsState()
let dest = CGImageDestinationCreateWithURL(URL(fileURLWithPath: out) as CFURL, "public.png" as CFString, 1, nil)!
CGImageDestinationAddImage(dest, ctx.makeImage()!, nil); CGImageDestinationFinalize(dest)
print("ok \(out)")
