func javaScriptQuoted(_ value: String) -> String {
    "'" + value.unicodeScalars.map { scalar -> String in
        switch scalar {
        case "\\": "\\\\"
        case "'": "\\'"
        case "\n": "\\n"
        case "\r": "\\r"
        case "\u{2028}": "\\u2028"
        case "\u{2029}": "\\u2029"
        case "<": "\\u003C"
        default: String(scalar)
        }
    }.joined() + "'"
}
