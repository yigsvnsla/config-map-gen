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
var import_xml_formatter = __toESM(require_cjs2(), 1);
import { readdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";
var __dirname = "/home/yigs-isc/config-map-gen";
var fileOut = "config-map.yml";
var fileOutPath = join(__dirname, fileOut);
var filesMap = new Map;
var recursive = true;
var encoding = "utf-8";
var dir = "xslt_desa";
var filesPath = join(__dirname, dir);
try {
  const files = await readdir(filesPath, { encoding, recursive });
  for (const file of files) {
    const filePath = join(filesPath, file);
    try {
      const fileContent = await readFile(filePath, encoding);
      const initialClean = fileContent.trim().replace(/\r\n/g, `
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
        console.warn(`⚠️  No se pudo formatear XML en ${file}, usando contenido limpio original:`, xmlError.message);
        formattedContent = initialClean;
      }
      filesMap.set(file, formattedContent);
      console.log(`✅ Procesado: ${file} (${formattedContent.length} caracteres, ${formattedContent.split(`
`).length} líneas)`);
    } catch (fileError) {
      console.error(`Error leyendo archivo ${file}:`, fileError);
    }
  }
  const dataMap = Object.fromEntries(filesMap);
  const configMap = {
    apiVersion: "v1",
    kind: "ConfigMap",
    metadata: {
      name: "config-map"
    },
    data: dataMap
  };
  const yamlOptions = {
    indent: 2,
    lineWidth: 0,
    minContentWidth: 0,
    doubleQuotedAsJSON: false,
    blockQuote: "literal",
    flowCollectionPadding: false,
    mapAsMap: false
  };
  let yamlContent = `apiVersion: v1
kind: ConfigMap
metadata:
  name: config-map
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
  await writeFile(fileOutPath, yamlContent, { encoding });
  console.log(`
✅ ConfigMap generado exitosamente en: ${fileOutPath}`);
  console.log(`\uD83D\uDCC1 Archivos procesados: ${filesMap.size}`);
  console.log(`
\uD83D\uDCCB Primeras líneas del ConfigMap generado:`);
  const lines = yamlContent.split(`
`).slice(0, 10);
  lines.forEach((line, i) => console.log(`${String(i + 1).padStart(2, " ")}: ${line}`));
} catch (error) {
  console.error("❌ Error ejecutando el script:", error);
  process.exit(1);
}
