import type { EncodingOption } from 'node:fs';
import { readdir, readFile, writeFile } from 'node:fs/promises';
import { join } from 'node:path';
import xmlFormat from 'xml-formatter';

export interface ConfigMap {
    apiVersion: string;
    kind: "ConfigMap";
    metadata: {
        name: string;
    };
    data: Record<string, string>;
}

const fileOut: string = 'config-map.yml';
const fileOutPath: string = join(__dirname, fileOut);
const filesMap = new Map<string, string>();
const recursive: boolean = true;
const encoding: EncodingOption = 'utf-8';
const dir: string = 'xslt_desa';
const filesPath: string = join(__dirname, dir);

try {
    const files: string[] = await readdir(filesPath, { encoding, recursive });

    for (const file of files) {
        const filePath: string = join(filesPath, file);
        
        try {
            // Leer el contenido del archivo
            const fileContent: string = await readFile(filePath, encoding);
            
            // Limpiar contenido inicial: quitar espacios en blanco excesivos y normalizar saltos de línea
            const initialClean = fileContent
                .trim()
                .replace(/\r\n/g, '\n')     // Convertir CRLF a LF
                .replace(/\r/g, '\n')       // Convertir CR a LF
                .replace(/\s+$/gm, '')      // Quitar espacios al final de cada línea
                .replace(/^\s*\n/gm, '')    // Quitar líneas que solo tienen espacios
                .replace(/\n{3,}/g, '\n\n') // Reducir múltiples líneas vacías a máximo 2
                .replace(/\\\s*\n\s*/g, '\n'); // Limpiar continuaciones de línea con backslash
            
            // Formatear XML para asegurar estructura consistente
            let formattedContent: string;
            try {
                formattedContent = xmlFormat(initialClean, {
                    indentation: '    ', // 4 espacios de indentación
                    filter: (node) => node.type !== 'Comment', // Mantener comentarios
                    collapseContent: true, // Colapsar contenido de texto simple
                    lineSeparator: '\n',
                    whiteSpaceAtEndOfSelfclosingTag: false
                });
                
                // Limpiar espacios adicionales que puedan quedar tras el formateo
                formattedContent = formattedContent
                    .replace(/\s+$/gm, '')      // Quitar espacios al final de líneas
                    .replace(/^\s*\n/gm, '')    // Quitar líneas vacías con solo espacios
                    .trim();
                    
            } catch (xmlError) {
                console.warn(`⚠️  No se pudo formatear XML en ${file}, usando contenido limpio original:`, (xmlError as Error).message);
                formattedContent = initialClean;
            }
            
            filesMap.set(file, formattedContent);
            
            console.log(`✅ Procesado: ${file} (${formattedContent.length} caracteres, ${formattedContent.split('\n').length} líneas)`);
        } catch (fileError) {
            console.error(`Error leyendo archivo ${file}:`, fileError);
        }
    }

    // Convertir Map a objeto
    const dataMap = Object.fromEntries(filesMap);

    // Crear estructura del ConfigMap
    const configMap: ConfigMap = {
        apiVersion: "v1",
        kind: "ConfigMap",
        metadata: { 
            name: "config-map" 
        },
        data: dataMap
    };

    // Configurar YAML para usar formato de bloque literal para strings multilinea
    const yamlOptions = {
        indent: 2,
        lineWidth: 0, // Sin límite de ancho de línea
        minContentWidth: 0,
        doubleQuotedAsJSON: false,
        blockQuote: 'literal', // Usar formato de bloque literal |
        flowCollectionPadding: false,
        mapAsMap: false
    };

    // Generar YAML manualmente para mejor control del formato
    let yamlContent = `apiVersion: v1\nkind: ConfigMap\nmetadata:\n  name: config-map\ndata:\n`;
    
    for (const [filename, content] of Object.entries(dataMap)) {
        // Indentar cada línea del contenido XML con 4 espacios (2 para data + 2 adicionales)
        const indentedContent = content
            .split('\n')
            .map(line => line.length > 0 ? `    ${line}` : '')
            .join('\n');
        
        yamlContent += `  ${filename}: |\n${indentedContent}\n`;
    }

    await writeFile(fileOutPath, yamlContent, { encoding });

    console.log(`\n✅ ConfigMap generado exitosamente en: ${fileOutPath}`);
    console.log(`📁 Archivos procesados: ${filesMap.size}`);
    
    // Mostrar las primeras líneas del resultado para verificación
    console.log('\n📋 Primeras líneas del ConfigMap generado:');
    const lines = yamlContent.split('\n').slice(0, 10);
    lines.forEach((line, i) => console.log(`${String(i + 1).padStart(2, ' ')}: ${line}`));
    
} catch (error) {
    console.error('❌ Error ejecutando el script:', error);
    process.exit(1);
}