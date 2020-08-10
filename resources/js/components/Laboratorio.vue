<template>
    <v-container>
        <h1>Laboratório</h1>
        <arquivo-input label="Arquivo:" mimes="text/plain,application/octet-stream,application/json" 
            disco="public" diretorio="static/geo" uploadURL="/api/arquivo/upload" />
    </v-container>
</template>

<script>
import ArquivoInput from './ArquivoInput'
export default {
}
</script>