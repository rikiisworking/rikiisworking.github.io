// Renders og.png — the 1200×630 link-preview image (LinkedIn, Slack, …).
// Run via tools/make-og.sh, which fetches the font first.
// Usage: swift tools/og.swift <NotoSans.ttf> <out.png>
//
// To change the card, edit the TEXT block below and re-run.

import AppKit
import CoreText

// ---------- TEXT ----------
let eyebrow = "BACKEND ENGINEER  ·  TOKYO"
let name = "Changho Park"
let taglineLines = [
    "High-throughput, low-latency data systems",
    "and real-time APIs, built mostly in Go.",
]
let metrics: [(value: String, label: String)] = [
    ("−85%", "API response time"),
    ("30–120×", "faster data pipeline"),
    ("~10 MB/s", "peak order-book ingestion"),
]

// ---------- COLOURS (match the light theme tokens in index.html) ----------
func hex(_ h: UInt32) -> NSColor {
    NSColor(srgbRed: CGFloat((h >> 16) & 0xff) / 255, green: CGFloat((h >> 8) & 0xff) / 255,
            blue: CGFloat(h & 0xff) / 255, alpha: 1)
}
let bg = hex(0xF7F6F2), ink = hex(0x15181D), muted = hex(0x4A505A), faint = hex(0x6B717A)
let accent = hex(0x00749C), accentSoft = hex(0xE3F0F5), line = hex(0xCFCCC2)

// ---------- Setup ----------
let args = CommandLine.arguments
guard args.count == 3 else {
    FileHandle.standardError.write("usage: swift og.swift <NotoSans.ttf> <out.png>\n".data(using: .utf8)!)
    exit(1)
}
CTFontManagerRegisterFontsForURL(URL(fileURLWithPath: args[1]) as CFURL, .process, nil)

func noto(_ size: CGFloat, _ weight: CGFloat) -> NSFont {
    let wghtAxis = 0x77676874 // 'wght' variation axis
    let desc = NSFontDescriptor(fontAttributes: [
        .family: "Noto Sans",
        NSFontDescriptor.AttributeName(rawValue: kCTFontVariationAttribute as String): [wghtAxis: weight],
    ])
    return NSFont(descriptor: desc, size: size)!
}

let W = 1200, H = 630
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H, bitsPerSample: 8,
                           samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                           colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)!
// Flip so y grows downward, like CSS
let t = NSAffineTransform(); t.translateX(by: 0, yBy: CGFloat(H)); t.scaleX(by: 1, yBy: -1); t.concat()

// Draws text with its top edge at y (text itself must be un-flipped)
func text(_ s: String, _ x: CGFloat, _ y: CGFloat, _ font: NSFont, _ color: NSColor, kern: CGFloat = 0) {
    NSGraphicsContext.saveGraphicsState()
    let flip = NSAffineTransform(); flip.translateX(by: x, yBy: y + font.ascender); flip.scaleX(by: 1, yBy: -1); flip.concat()
    NSAttributedString(string: s, attributes: [.font: font, .foregroundColor: color, .kern: kern]).draw(at: .zero)
    NSGraphicsContext.restoreGraphicsState()
}

// ---------- Layout ----------
let L: CGFloat = 88

bg.setFill(); NSRect(x: 0, y: 0, width: W, height: H).fill()
accent.setFill(); NSRect(x: 0, y: 0, width: 10, height: H).fill()

accentSoft.setFill(); NSBezierPath(ovalIn: NSRect(x: L - 2, y: 86, width: 22, height: 22)).fill()
accent.setFill(); NSBezierPath(ovalIn: NSRect(x: L + 4, y: 92, width: 10, height: 10)).fill()
text(eyebrow, L + 36, 88, noto(20, 500), accent, kern: 3)

text(name, L - 4, 140, noto(104, 700), ink, kern: -2)

for (i, lineText) in taglineLines.enumerated() {
    text(lineText, L, 296 + CGFloat(i) * 48, noto(34, 300), muted)
}

line.setFill(); NSRect(x: L, y: 448, width: CGFloat(W) - 2 * L, height: 1.5).fill()

for (i, m) in metrics.enumerated() {
    let x = L + CGFloat(i) * 340
    text(m.value, x, 478, noto(44, 700), ink, kern: -0.5)
    text(m.label, x, 540, noto(20, 400), faint)
}

NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: args[2]))
print("wrote \(args[2])")
