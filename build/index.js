var __create = Object.create;
var __getProtoOf = Object.getPrototypeOf;
var __defProp = Object.defineProperty;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __toESM = (mod, isNodeMode, target) => {
  target = mod != null ? __create(__getProtoOf(mod)) : {};
  const to = isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target;
  for (let key of __getOwnPropNames(mod))
    if (!__hasOwnProp.call(to, key))
      __defProp(to, key, {
        get: () => mod[key],
        enumerable: true
      });
  return to;
};
var __commonJS = (cb, mod) => () => (mod || cb((mod = { exports: {} }).exports, mod), mod.exports);

// node_modules/xml-parser-xo/dist/cjs/index.js
var require_cjs = __commonJS((exports, module) => {
  Object.defineProperty(exports, "__esModule", { value: true });
  exports.ParsingError = undefined;

  class ParsingError extends Error {
    constructor(message, cause) {
      super(message);
      this.cause = cause;
    }
  }
  exports.ParsingError = ParsingError;
  var parsingState;
  function nextChild() {
    return element(false) || text() || comment() || cdata() || processingInstruction(false);
  }
  function nextRootChild() {
    match(/\s*/);
    return element(true) || comment() || doctype() || processingInstruction(false);
  }
  function parseDocument() {
    const declaration = processingInstruction(true);
    const children = [];
    let documentRootNode;
    let child = nextRootChild();
    while (child) {
      if (child.node.type === "Element") {
        if (documentRootNode) {
          throw new Error("Found multiple root nodes");
        }
        documentRootNode = child.node;
      }
      if (!child.excluded) {
        children.push(child.node);
      }
      child = nextRootChild();
    }
    if (!documentRootNode) {
      throw new ParsingError("Failed to parse XML", "Root Element not found");
    }
    if (parsingState.xml.length !== 0) {
      throw new ParsingError("Failed to parse XML", "Not Well-Formed XML");
    }
    return {
      declaration: declaration ? declaration.node : null,
      root: documentRootNode,
      children
    };
  }
  function processingInstruction(matchDeclaration) {
    const m = matchDeclaration ? match(/^<\?(xml(-stylesheet)?)\s*/) : match(/^<\?([\w-:.]+)\s*/);
    if (!m)
      return;
    const node = {
      name: m[1],
      type: "ProcessingInstruction",
      attributes: {}
    };
    while (!(eos() || is("?>"))) {
      const attr = attribute();
      if (attr) {
        node.attributes[attr.name] = attr.value;
      } else {
        return;
      }
    }
    match(/\?>/);
    return {
      excluded: matchDeclaration ? false : parsingState.options.filter(node) === false,
      node
    };
  }
  function element(matchRoot) {
    const m = match(/^<([^?!</>\s]+)\s*/);
    if (!m)
      return;
    const node = {
      type: "Element",
      name: m[1],
      attributes: {},
      children: []
    };
    const excluded = matchRoot ? false : parsingState.options.filter(node) === false;
    while (!(eos() || is(">") || is("?>") || is("/>"))) {
      const attr = attribute();
      if (attr) {
        node.attributes[attr.name] = attr.value;
      } else {
        return;
      }
    }
    if (match(/^\s*\/>/)) {
      node.children = null;
      return {
        excluded,
        node
      };
    }
    match(/\??>/);
    let child = nextChild();
    while (child) {
      if (!child.excluded) {
        node.children.push(child.node);
      }
      child = nextChild();
    }
    if (parsingState.options.strictMode) {
      const closingTag = `</${node.name}>`;
      if (parsingState.xml.startsWith(closingTag)) {
        parsingState.xml = parsingState.xml.slice(closingTag.length);
      } else {
        throw new ParsingError("Failed to parse XML", `Closing tag not matching "${closingTag}"`);
      }
    } else {
      match(/^<\/[\w-:.\u00C0-\u00FF]+\s*>/);
    }
    return {
      excluded,
      node
    };
  }
  function doctype() {
    const m = match(/^<!DOCTYPE\s+\S+\s+SYSTEM[^>]*>/) || match(/^<!DOCTYPE\s+\S+\s+PUBLIC[^>]*>/) || match(/^<!DOCTYPE\s+\S+\s*\[[^\]]*]>/) || match(/^<!DOCTYPE\s+\S+\s*>/);
    if (m) {
      const node = {
        type: "DocumentType",
        content: m[0]
      };
      return {
        excluded: parsingState.options.filter(node) === false,
        node
      };
    }
  }
  function cdata() {
    if (parsingState.xml.startsWith("<![CDATA[")) {
      const endPositionStart = parsingState.xml.indexOf("]]>");
      if (endPositionStart > -1) {
        const endPositionFinish = endPositionStart + 3;
        const node = {
          type: "CDATA",
          content: parsingState.xml.substring(0, endPositionFinish)
        };
        parsingState.xml = parsingState.xml.slice(endPositionFinish);
        return {
          excluded: parsingState.options.filter(node) === false,
          node
        };
      }
    }
  }
  function comment() {
    const m = match(/^<!--[\s\S]*?-->/);
    if (m) {
      const node = {
        type: "Comment",
        content: m[0]
      };
      return {
        excluded: parsingState.options.filter(node) === false,
        node
      };
    }
  }
  function text() {
    const m = match(/^([^<]+)/);
    if (m) {
      const node = {
        type: "Text",
        content: m[1]
      };
      return {
        excluded: parsingState.options.filter(node) === false,
        node
      };
    }
  }
  function attribute() {
    const m = match(/([^=]+)\s*=\s*("[^"]*"|'[^']*'|[^>\s]+)\s*/);
    if (m) {
      return {
        name: m[1].trim(),
        value: stripQuotes(m[2].trim())
      };
    }
  }
  function stripQuotes(val) {
    return val.replace(/^['"]|['"]$/g, "");
  }
  function match(re) {
    const m = parsingState.xml.match(re);
    if (m) {
      parsingState.xml = parsingState.xml.slice(m[0].length);
      return m;
    }
  }
  function eos() {
    return parsingState.xml.length === 0;
  }
  function is(prefix) {
    return parsingState.xml.indexOf(prefix) === 0;
  }
  function parseXml(xml, options = {}) {
    xml = xml.trim();
    const filter = options.filter || (() => true);
    parsingState = {
      xml,
      options: Object.assign(Object.assign({}, options), { filter, strictMode: options.strictMode === true })
    };
    return parseDocument();
  }
  if (typeof module !== "undefined" && typeof exports === "object") {
    module.exports = parseXml;
  }
  exports.default = parseXml;
});

// node_modules/xml-formatter/dist/cjs/index.js
var require_cjs2 = __commonJS((exports, module) => {
  var __importDefault = exports && exports.__importDefault || function(mod) {
    return mod && mod.__esModule ? mod : { default: mod };
  };
  Object.defineProperty(exports, "__esModule", { value: true });
  var xml_parser_xo_1 = __importDefault(require_cjs());
  function newLine(state) {
    if (!state.options.indentation && !state.options.lineSeparator)
      return;
    state.content += state.options.lineSeparator;
    let i;
    for (i = 0;i < state.level; i++) {
      state.content += state.options.indentation;
    }
  }
  function indent(state) {
    state.content = state.content.replace(/ +$/, "");
    let i;
    for (i = 0;i < state.level; i++) {
      state.content += state.options.indentation;
    }
  }
  function appendContent(state, content) {
    state.content += content;
  }
  function processNode(node, state, preserveSpace) {
    if (typeof node.content === "string") {
      processContent(node.content, state, preserveSpace);
    } else if (node.type === "Element") {
      processElementNode(node, state, preserveSpace);
    } else if (node.type === "ProcessingInstruction") {
      processProcessingIntruction(node, state);
    } else {
      throw new Error("Unknown node type: " + node.type);
    }
  }
  function processContent(content, state, preserveSpace) {
    if (!preserveSpace) {
      const trimmedContent = content.trim();
      if (state.options.lineSeparator) {
        content = trimmedContent;
      } else if (trimmedContent.length === 0) {
        content = trimmedContent;
      }
    }
    if (content.length > 0) {
      if (!preserveSpace && state.content.length > 0) {
        newLine(state);
      }
      appendContent(state, content);
    }
  }
  function isPathMatchingIgnoredPaths(path, ignoredPaths) {
    const fullPath = "/" + path.join("/");
    const pathLastPart = path[path.length - 1];
    return ignoredPaths.includes(pathLastPart) || ignoredPaths.includes(fullPath);
  }
  function processElementNode(node, state, preserveSpace) {
    state.path.push(node.name);
    if (!preserveSpace && state.content.length > 0) {
      newLine(state);
    }
    appendContent(state, "<" + node.name);
    processAttributes(state, node.attributes);
    if (node.children === null || state.options.forceSelfClosingEmptyTag && node.children.length === 0) {
      const selfClosingNodeClosingTag = state.options.whiteSpaceAtEndOfSelfclosingTag ? " />" : "/>";
      appendContent(state, selfClosingNodeClosingTag);
    } else if (node.children.length === 0) {
      appendContent(state, "></" + node.name + ">");
    } else {
      const nodeChildren = node.children;
      appendContent(state, ">");
      state.level++;
      let nodePreserveSpace = node.attributes["xml:space"] === "preserve" || preserveSpace;
      let ignoredPath = false;
      if (!nodePreserveSpace && state.options.ignoredPaths) {
        ignoredPath = isPathMatchingIgnoredPaths(state.path, state.options.ignoredPaths);
        nodePreserveSpace = ignoredPath;
      }
      if (!nodePreserveSpace && state.options.collapseContent) {
        let containsTextNodes = false;
        let containsTextNodesWithLineBreaks = false;
        let containsNonTextNodes = false;
        nodeChildren.forEach(function(child, index) {
          if (child.type === "Text") {
            if (child.content.includes(`
`)) {
              containsTextNodesWithLineBreaks = true;
              child.content = child.content.trim();
            } else if ((index === 0 || index === nodeChildren.length - 1) && !preserveSpace) {
              if (child.content.trim().length === 0) {
                child.content = "";
              }
            }
            if (child.content.trim().length > 0 || nodeChildren.length === 1) {
              containsTextNodes = true;
            }
          } else if (child.type === "CDATA") {
            containsTextNodes = true;
          } else {
            containsNonTextNodes = true;
          }
        });
        if (containsTextNodes && (!containsNonTextNodes || !containsTextNodesWithLineBreaks)) {
          nodePreserveSpace = true;
        }
      }
      nodeChildren.forEach(function(child) {
        processNode(child, state, preserveSpace || nodePreserveSpace);
      });
      state.level--;
      if (!preserveSpace && !nodePreserveSpace) {
        newLine(state);
      }
      if (ignoredPath) {
        indent(state);
      }
      appendContent(state, "</" + node.name + ">");
    }
    state.path.pop();
  }
  function processAttributes(state, attributes) {
    Object.keys(attributes).forEach(function(attr) {
      const escaped = attributes[attr].replace(/"/g, "&quot;");
      appendContent(state, " " + attr + '="' + escaped + '"');
    });
  }
  function processProcessingIntruction(node, state) {
    if (state.content.length > 0) {
      newLine(state);
    }
    appendContent(state, "<?" + node.name);
    processAttributes(state, node.attributes);
    appendContent(state, "?>");
  }
  function formatXml(xml, options = {}) {
    options.indentation = "indentation" in options ? options.indentation : "    ";
    options.collapseContent = options.collapseContent === true;
    options.lineSeparator = "lineSeparator" in options ? options.lineSeparator : `\r
`;
    options.whiteSpaceAtEndOfSelfclosingTag = options.whiteSpaceAtEndOfSelfclosingTag === true;
    options.throwOnFailure = options.throwOnFailure !== false;
    try {
      const parsedXml = (0, xml_parser_xo_1.default)(xml, { filter: options.filter, strictMode: options.strictMode });
      const state = { content: "", level: 0, options, path: [] };
      if (parsedXml.declaration) {
        processProcessingIntruction(parsedXml.declaration, state);
      }
      parsedXml.children.forEach(function(child) {
        processNode(child, state, false);
      });
      if (!options.lineSeparator) {
        return state.content;
      }
      return state.content.replace(/\r\n/g, `
`).replace(/\n/g, options.lineSeparator);
    } catch (err) {
      if (options.throwOnFailure) {
        throw err;
      }
      return xml;
    }
  }
  formatXml.minify = (xml, options = {}) => {
    return formatXml(xml, Object.assign(Object.assign({}, options), { indentation: "", lineSeparator: "" }));
  };
  if (typeof module !== "undefined" && typeof exports === "object") {
    module.exports = formatXml;
  }
  exports.default = formatXml;
});

// index.ts
var {readdir, readFile, writeFile, mkdir} = (() => ({}));

// node:path
var L = Object.create;
var h = Object.defineProperty;
var D = Object.getOwnPropertyDescriptor;
var T = Object.getOwnPropertyNames;
var _ = Object.getPrototypeOf;
var E = Object.prototype.hasOwnProperty;
var R = (s, e) => () => (e || s((e = { exports: {} }).exports, e), e.exports);
var N = (s, e, r, t) => {
  if (e && typeof e == "object" || typeof e == "function")
    for (let i of T(e))
      !E.call(s, i) && i !== r && h(s, i, { get: () => e[i], enumerable: !(t = D(e, i)) || t.enumerable });
  return s;
};
var j = (s, e, r) => (r = s != null ? L(_(s)) : {}, N(e || !s || !s.__esModule ? h(r, "default", { value: s, enumerable: true }) : r, s));
var k = R((W, w) => {
  function v(s) {
    if (typeof s != "string")
      throw new TypeError("Path must be a string. Received " + JSON.stringify(s));
  }
  function C(s, e) {
    for (var r = "", t = 0, i = -1, a = 0, n, l = 0;l <= s.length; ++l) {
      if (l < s.length)
        n = s.charCodeAt(l);
      else {
        if (n === 47)
          break;
        n = 47;
      }
      if (n === 47) {
        if (!(i === l - 1 || a === 1))
          if (i !== l - 1 && a === 2) {
            if (r.length < 2 || t !== 2 || r.charCodeAt(r.length - 1) !== 46 || r.charCodeAt(r.length - 2) !== 46) {
              if (r.length > 2) {
                var f = r.lastIndexOf("/");
                if (f !== r.length - 1) {
                  f === -1 ? (r = "", t = 0) : (r = r.slice(0, f), t = r.length - 1 - r.lastIndexOf("/")), i = l, a = 0;
                  continue;
                }
              } else if (r.length === 2 || r.length === 1) {
                r = "", t = 0, i = l, a = 0;
                continue;
              }
            }
            e && (r.length > 0 ? r += "/.." : r = "..", t = 2);
          } else
            r.length > 0 ? r += "/" + s.slice(i + 1, l) : r = s.slice(i + 1, l), t = l - i - 1;
        i = l, a = 0;
      } else
        n === 46 && a !== -1 ? ++a : a = -1;
    }
    return r;
  }
  function F(s, e) {
    var r = e.dir || e.root, t = e.base || (e.name || "") + (e.ext || "");
    return r ? r === e.root ? r + t : r + s + t : t;
  }
  var m = { resolve: function() {
    for (var e = "", r = false, t, i = arguments.length - 1;i >= -1 && !r; i--) {
      var a;
      i >= 0 ? a = arguments[i] : (t === undefined && (t = process.cwd()), a = t), v(a), a.length !== 0 && (e = a + "/" + e, r = a.charCodeAt(0) === 47);
    }
    return e = C(e, !r), r ? e.length > 0 ? "/" + e : "/" : e.length > 0 ? e : ".";
  }, normalize: function(e) {
    if (v(e), e.length === 0)
      return ".";
    var r = e.charCodeAt(0) === 47, t = e.charCodeAt(e.length - 1) === 47;
    return e = C(e, !r), e.length === 0 && !r && (e = "."), e.length > 0 && t && (e += "/"), r ? "/" + e : e;
  }, isAbsolute: function(e) {
    return v(e), e.length > 0 && e.charCodeAt(0) === 47;
  }, join: function() {
    if (arguments.length === 0)
      return ".";
    for (var e, r = 0;r < arguments.length; ++r) {
      var t = arguments[r];
      v(t), t.length > 0 && (e === undefined ? e = t : e += "/" + t);
    }
    return e === undefined ? "." : m.normalize(e);
  }, relative: function(e, r) {
    if (v(e), v(r), e === r || (e = m.resolve(e), r = m.resolve(r), e === r))
      return "";
    for (var t = 1;t < e.length && e.charCodeAt(t) === 47; ++t)
      ;
    for (var i = e.length, a = i - t, n = 1;n < r.length && r.charCodeAt(n) === 47; ++n)
      ;
    for (var l = r.length, f = l - n, c = a < f ? a : f, d = -1, o = 0;o <= c; ++o) {
      if (o === c) {
        if (f > c) {
          if (r.charCodeAt(n + o) === 47)
            return r.slice(n + o + 1);
          if (o === 0)
            return r.slice(n + o);
        } else
          a > c && (e.charCodeAt(t + o) === 47 ? d = o : o === 0 && (d = 0));
        break;
      }
      var A = e.charCodeAt(t + o), z = r.charCodeAt(n + o);
      if (A !== z)
        break;
      A === 47 && (d = o);
    }
    var b = "";
    for (o = t + d + 1;o <= i; ++o)
      (o === i || e.charCodeAt(o) === 47) && (b.length === 0 ? b += ".." : b += "/..");
    return b.length > 0 ? b + r.slice(n + d) : (n += d, r.charCodeAt(n) === 47 && ++n, r.slice(n));
  }, _makeLong: function(e) {
    return e;
  }, dirname: function(e) {
    if (v(e), e.length === 0)
      return ".";
    for (var r = e.charCodeAt(0), t = r === 47, i = -1, a = true, n = e.length - 1;n >= 1; --n)
      if (r = e.charCodeAt(n), r === 47) {
        if (!a) {
          i = n;
          break;
        }
      } else
        a = false;
    return i === -1 ? t ? "/" : "." : t && i === 1 ? "//" : e.slice(0, i);
  }, basename: function(e, r) {
    if (r !== undefined && typeof r != "string")
      throw new TypeError('"ext" argument must be a string');
    v(e);
    var t = 0, i = -1, a = true, n;
    if (r !== undefined && r.length > 0 && r.length <= e.length) {
      if (r.length === e.length && r === e)
        return "";
      var l = r.length - 1, f = -1;
      for (n = e.length - 1;n >= 0; --n) {
        var c = e.charCodeAt(n);
        if (c === 47) {
          if (!a) {
            t = n + 1;
            break;
          }
        } else
          f === -1 && (a = false, f = n + 1), l >= 0 && (c === r.charCodeAt(l) ? --l === -1 && (i = n) : (l = -1, i = f));
      }
      return t === i ? i = f : i === -1 && (i = e.length), e.slice(t, i);
    } else {
      for (n = e.length - 1;n >= 0; --n)
        if (e.charCodeAt(n) === 47) {
          if (!a) {
            t = n + 1;
            break;
          }
        } else
          i === -1 && (a = false, i = n + 1);
      return i === -1 ? "" : e.slice(t, i);
    }
  }, extname: function(e) {
    v(e);
    for (var r = -1, t = 0, i = -1, a = true, n = 0, l = e.length - 1;l >= 0; --l) {
      var f = e.charCodeAt(l);
      if (f === 47) {
        if (!a) {
          t = l + 1;
          break;
        }
        continue;
      }
      i === -1 && (a = false, i = l + 1), f === 46 ? r === -1 ? r = l : n !== 1 && (n = 1) : r !== -1 && (n = -1);
    }
    return r === -1 || i === -1 || n === 0 || n === 1 && r === i - 1 && r === t + 1 ? "" : e.slice(r, i);
  }, format: function(e) {
    if (e === null || typeof e != "object")
      throw new TypeError('The "pathObject" argument must be of type Object. Received type ' + typeof e);
    return F("/", e);
  }, parse: function(e) {
    v(e);
    var r = { root: "", dir: "", base: "", ext: "", name: "" };
    if (e.length === 0)
      return r;
    var t = e.charCodeAt(0), i = t === 47, a;
    i ? (r.root = "/", a = 1) : a = 0;
    for (var n = -1, l = 0, f = -1, c = true, d = e.length - 1, o = 0;d >= a; --d) {
      if (t = e.charCodeAt(d), t === 47) {
        if (!c) {
          l = d + 1;
          break;
        }
        continue;
      }
      f === -1 && (c = false, f = d + 1), t === 46 ? n === -1 ? n = d : o !== 1 && (o = 1) : n !== -1 && (o = -1);
    }
    return n === -1 || f === -1 || o === 0 || o === 1 && n === f - 1 && n === l + 1 ? f !== -1 && (l === 0 && i ? r.base = r.name = e.slice(1, f) : r.base = r.name = e.slice(l, f)) : (l === 0 && i ? (r.name = e.slice(1, n), r.base = e.slice(1, f)) : (r.name = e.slice(l, n), r.base = e.slice(l, f)), r.ext = e.slice(n, f)), l > 0 ? r.dir = e.slice(0, l - 1) : i && (r.dir = "/"), r;
  }, sep: "/", delimiter: ":", win32: null, posix: null };
  m.posix = m;
  w.exports = m;
});
var x = j(k());
var u = x;
var J = x;
var P = function(s) {
  return s;
};
var S = function() {
  throw new Error("Not implemented");
};
u.parse ??= S;
J.parse ??= S;
var g = { resolve: u.resolve.bind(u), normalize: u.normalize.bind(u), isAbsolute: u.isAbsolute.bind(u), join: u.join.bind(u), relative: u.relative.bind(u), toNamespacedPath: P, dirname: u.dirname.bind(u), basename: u.basename.bind(u), extname: u.extname.bind(u), format: u.format.bind(u), parse: u.parse.bind(u), sep: "/", delimiter: ":", win32: undefined, posix: undefined, _makeLong: P };
var y = { sep: "\\", delimiter: ";", win32: undefined, ...g, posix: g };
g.win32 = y.win32 = y;
g.posix = g;
var { resolve: B, normalize: G, isAbsolute: H, join: K, relative: Q, toNamespacedPath: U, dirname: V, basename: X, extname: Y, format: Z, parse: $, sep: I, delimiter: O } = g;

// index.ts
var import_xml_formatter = __toESM(require_cjs2(), 1);
var __dirname = "/home/yigs-isc/config-map-gen";
var outputDir = "configmaps";
var outputDirPath = K(__dirname, outputDir);
var recursive = true;
var encoding = "utf-8";
var dir = "xslt_desa";
var filesPath = K(__dirname, dir);
var validSuffixes = ["_C_IN.xsl", "_C_OUT.xsl", "_P_IN.xsl", "_P_OUT.xsl", "_R_IN.xsl", "_R_OUT.xsl"];
function extractGroupFromFilename(filename) {
  const validSuffix = validSuffixes.find((suffix) => filename.endsWith(suffix));
  if (validSuffix) {
    return filename.replace(validSuffix, "");
  }
  return null;
}
async function processXMLContent(content, filename) {
  const initialClean = content.trim().replace(/\r\n/g, `
`).replace(/\r/g, `
`).replace(/\s+$/gm, "").replace(/^\s*\n/gm, "").replace(/\n{3,}/g, `

`).replace(/\\\s*\n\s*/g, `
`);
  let formattedContent;
  try {
    formattedContent = import_xml_formatter.default(initialClean, {
      indentation: "    ",
      filter: (node) => node.type !== "Comment",
      collapseContent: true,
      lineSeparator: `
`,
      whiteSpaceAtEndOfSelfclosingTag: false
    });
    formattedContent = formattedContent.replace(/\s+$/gm, "").replace(/^\s*\n/gm, "").trim();
  } catch (xmlError) {
    console.warn(`⚠️  No se pudo formatear XML en ${filename}, usando contenido limpio original:`, xmlError.message);
    formattedContent = initialClean;
  }
  return formattedContent;
}
function generateConfigMapYAML(configMapName, dataMap) {
  let yamlContent = `apiVersion: v1
kind: ConfigMap
metadata:
  name: ${configMapName}
data:
`;
  for (const [filename, content] of Object.entries(dataMap)) {
    const indentedContent = content.split(`
`).map((line) => line.length > 0 ? `    ${line}` : "").join(`
`);
    yamlContent += `  ${filename}: |
${indentedContent}
`;
  }
  return yamlContent;
}
try {
  try {
    await mkdir(outputDirPath, { recursive: true });
  } catch (error) {}
  const files = await readdir(filesPath, { encoding, recursive });
  const groupedFiles = {};
  let processedFiles = 0;
  let skippedFiles = 0;
  console.log(`\uD83D\uDD0D Procesando archivos en directorio: ${dir}`);
  console.log(`\uD83D\uDCC2 Sufijos válidos: ${validSuffixes.join(", ")}
`);
  for (const file of files) {
    const groupName = extractGroupFromFilename(file);
    if (!groupName) {
      console.warn(`⚠️  Archivo omitido (no coincide con sufijos válidos): ${file}`);
      skippedFiles++;
      continue;
    }
    const filePath = K(filesPath, file);
    try {
      const fileContent = await readFile(filePath, encoding);
      const formattedContent = await processXMLContent(fileContent, file);
      if (!groupedFiles[groupName]) {
        groupedFiles[groupName] = new Map;
      }
      groupedFiles[groupName].set(file, formattedContent);
      console.log(`✅ Procesado: ${file} → Grupo: ${groupName} (${formattedContent.length} caracteres, ${formattedContent.split(`
`).length} líneas)`);
      processedFiles++;
    } catch (fileError) {
      console.error(`❌ Error leyendo archivo ${file}:`, fileError);
    }
  }
  console.log(`
\uD83D\uDCCA Resumen del procesamiento:`);
  console.log(`   - Archivos procesados: ${processedFiles}`);
  console.log(`   - Archivos omitidos: ${skippedFiles}`);
  console.log(`   - Grupos encontrados: ${Object.keys(groupedFiles).length}
`);
  const generatedConfigMaps = [];
  for (const [groupName, filesMap] of Object.entries(groupedFiles)) {
    const configMapName = groupName.toLowerCase().replace(/_/g, "-");
    const dataMap = Object.fromEntries(filesMap);
    const configMap = {
      apiVersion: "v1",
      kind: "ConfigMap",
      metadata: {
        name: configMapName
      },
      data: dataMap
    };
    const yamlContent = generateConfigMapYAML(configMapName, dataMap);
    const outputFileName = `${configMapName}-configmap.yml`;
    const outputFilePath = K(outputDirPath, outputFileName);
    await writeFile(outputFilePath, yamlContent, { encoding });
    console.log(`✅ ConfigMap generado: ${outputFileName}`);
    console.log(`   - Nombre del ConfigMap: ${configMapName}`);
    console.log(`   - Archivos incluidos: ${filesMap.size}`);
    console.log(`   - Archivos: ${Array.from(filesMap.keys()).join(", ")}`);
    generatedConfigMaps.push(outputFileName);
    console.log(`   - Primeras líneas:`);
    const lines = yamlContent.split(`
`).slice(0, 8);
    lines.forEach((line, i) => console.log(`     ${String(i + 1).padStart(2, " ")}: ${line}`));
    console.log("");
  }
  console.log(`
\uD83C\uDF89 ¡Proceso completado exitosamente!`);
  console.log(`\uD83D\uDCC1 ConfigMaps generados en: ${outputDirPath}`);
  console.log(`\uD83D\uDCCB Archivos generados: ${generatedConfigMaps.join(", ")}`);
  const applyScript = generatedConfigMaps.map((file) => `kubectl apply -f ${file}`).join(`
`);
  const applyScriptPath = K(outputDirPath, "apply-configmaps.sh");
  await writeFile(applyScriptPath, `#!/bin/bash
# Script para aplicar todos los ConfigMaps generados

${applyScript}
`, { encoding });
  console.log(`\uD83D\uDCDC Script de aplicación generado: apply-configmaps.sh`);
} catch (error) {
  console.error("❌ Error ejecutando el script:", error);
  process.exit(1);
}
