import type { EncodingOption } from 'node:fs';
import { readdir, readFile, writeFile, mkdir } from 'node:fs/promises';
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

interface GroupFiles {
    [groupName: string]: Map<string, string>;
}

const outputDir: string = 'configmaps';
const outputDirPath: string = join(__dirname, outputDir);
const recursive: boolean = true;
const encoding: EncodingOption = 'utf-8';
const dir: string = 'xslt_desa';
const filesPath: string = join(__dirname, dir);

// Sufijos válidos para las acciones
const validSuffixes = ['_C_IN.xsl', '_C_OUT.xsl', '_P_IN.xsl', '_P_OUT.xsl', '_R_IN.xsl', '_R_OUT.xsl'];

/**
 * Extrae el grupo del nombre del archivo basado en los sufijos válidos
 */
function extractGroupFromFilename(filename: string): string | null {
    const validSuffix = validSuffixes.find(suffix => filename.endsWith(suffix));
    if (validSuffix) {
        return filename.replace(validSuffix, '');
    }
    return null;
}

/**
 * Procesa el contenido XML/XSLT limpiándolo y formateándolo
 */
async function processXMLContent(content: string, filename: string): Promise<string> {
    // Limpiar contenido inicial: quitar espacios en blanco excesivos y normalizar saltos de línea
    const initialClean = content
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
        console.warn(`⚠️  No se pudo formatear XML en ${filename}, usando contenido limpio original:`, (xmlError as Error).message);
        formattedContent = initialClean;
    }
    
    return formattedContent;
}

/**
 * Genera el contenido YAML del ConfigMap
 */
function generateConfigMapYAML(configMapName: string, dataMap: Record<string, string>): string {
    let yamlContent = `apiVersion: v1\nkind: ConfigMap\nmetadata:\n  name: ${configMapName}\ndata:\n`;
    
    for (const [filename, content] of Object.entries(dataMap)) {
        // Indentar cada línea del contenido XML con 4 espacios (2 para data + 2 adicionales)
        const indentedContent = content
            .split('\n')
            .map(line => line.length > 0 ? `    ${line}` : '')
            .join('\n');
        
        yamlContent += `  ${filename}: |\n${indentedContent}\n`;
    }
    
    return yamlContent;
}

try {
    // Crear directorio de salida si no existe
    try {
        await mkdir(outputDirPath, { recursive: true });
    } catch (error) {
        // El directorio ya existe, continuar
    }

    const files: string[] = await readdir(filesPath, { encoding, recursive });
    const groupedFiles: GroupFiles = {};
    let processedFiles = 0;
    let skippedFiles = 0;

    console.log(`🔍 Procesando archivos en directorio: ${dir}`);
    console.log(`📂 Sufijos válidos: ${validSuffixes.join(', ')}\n`);

    // Agrupar archivos por nombre base
    for (const file of files) {
        const groupName = extractGroupFromFilename(file);
        
        if (!groupName) {
            console.warn(`⚠️  Archivo omitido (no coincide con sufijos válidos): ${file}`);
            skippedFiles++;
            continue;
        }

        const filePath: string = join(filesPath, file);
        
        try {
            // Leer el contenido del archivo
            const fileContent: string = await readFile(filePath, encoding);
            
            // Procesar contenido XML/XSLT
            const formattedContent = await processXMLContent(fileContent, file);
            
            // Inicializar grupo si no existe
            if (!groupedFiles[groupName]) {
                groupedFiles[groupName] = new Map<string, string>();
            }
            
            groupedFiles[groupName].set(file, formattedContent);
            
            console.log(`✅ Procesado: ${file} → Grupo: ${groupName} (${formattedContent.length} caracteres, ${formattedContent.split('\n').length} líneas)`);
            processedFiles++;
            
        } catch (fileError) {
            console.error(`❌ Error leyendo archivo ${file}:`, fileError);
        }
    }

    console.log(`\n📊 Resumen del procesamiento:`);
    console.log(`   - Archivos procesados: ${processedFiles}`);
    console.log(`   - Archivos omitidos: ${skippedFiles}`);
    console.log(`   - Grupos encontrados: ${Object.keys(groupedFiles).length}\n`);

    // Generar ConfigMap para cada grupo
    const generatedConfigMaps: string[] = [];
    
    for (const [groupName, filesMap] of Object.entries(groupedFiles)) {
        const configMapName = groupName.toLowerCase().replace(/_/g, '-');
        const dataMap = Object.fromEntries(filesMap);
        
        // Crear estructura del ConfigMap
        const configMap: ConfigMap = {
            apiVersion: "v1",
            kind: "ConfigMap",
            metadata: { 
                name: configMapName 
            },
            data: dataMap
        };

        // Generar contenido YAML
        const yamlContent = generateConfigMapYAML(configMapName, dataMap);
        
        // Escribir archivo
        const outputFileName = `${configMapName}-configmap.yml`;
        const outputFilePath = join(outputDirPath, outputFileName);
        
        await writeFile(outputFilePath, yamlContent, { encoding });
        
        console.log(`✅ ConfigMap generado: ${outputFileName}`);
        console.log(`   - Nombre del ConfigMap: ${configMapName}`);
        console.log(`   - Archivos incluidos: ${filesMap.size}`);
        console.log(`   - Archivos: ${Array.from(filesMap.keys()).join(', ')}`);
        
        generatedConfigMaps.push(outputFileName);
        
        // Mostrar las primeras líneas del ConfigMap para verificación
        console.log(`   - Primeras líneas:`);
        const lines = yamlContent.split('\n').slice(0, 8);
        lines.forEach((line, i) => console.log(`     ${String(i + 1).padStart(2, ' ')}: ${line}`));
        console.log('');
    }

    console.log(`\n🎉 ¡Proceso completado exitosamente!`);
    console.log(`📁 ConfigMaps generados en: ${outputDirPath}`);
    console.log(`📋 Archivos generados: ${generatedConfigMaps.join(', ')}`);
    
    // Generar script de aplicación para Kubernetes (opcional)
    const applyScript = generatedConfigMaps
        .map(file => `kubectl apply -f ${file}`)
        .join('\n');
    
    const applyScriptPath = join(outputDirPath, 'apply-configmaps.sh');
    await writeFile(applyScriptPath, `#!/bin/bash\n# Script para aplicar todos los ConfigMaps generados\n\n${applyScript}\n`, { encoding });
    
    console.log(`📜 Script de aplicación generado: apply-configmaps.sh`);
    
} catch (error) {
    console.error('❌ Error ejecutando el script:', error);
    process.exit(1);
}