<template>
    <div>
        <v-input :label="label"
          :messages="mensagens" 
        >
            <slot slot="append">
                <v-row>
                    <v-col>
                        <v-tooltip top>
                            <template v-slot:activator="{ on }">
                                <v-btn v-on="on" @click="abrirJanelaSelecao">
                                    <v-icon>attach_file</v-icon>
                                </v-btn>
                            </template>
                            <span>Selecionar arquivo</span>
                        </v-tooltip>
                    </v-col>
                    <v-col>
                        <v-tooltip top>
                            <template v-slot:activator="{ on }">
                                <v-btn v-on="on" @click="limparCampo">
                                    <v-icon>close</v-icon>
                                </v-btn>
                            </template>
                            <span>Limpar seleção</span>
                        </v-tooltip>
                    </v-col>
                </v-row>
            </slot>
          <v-text-field disabled :value="arquivo ? arquivo.nome : ''"></v-text-field>
        </v-input>
        <v-dialog v-model="exibirJanelaSelecao" persistent max-width="80%">
            <v-card>
                <v-card-title>Seleção de Arquivo</v-card-title>
                <v-card-text>
                    <v-container>
                        
                        <v-simple-table fixed-header>
                            <template v-slot:default>
                            <thead>
                                <tr>
                                    <th class="text-left">Arquivo</th>
                                    <th class="text-left">Tipo</th>
                                    <th class="text-right">Tamanho (bytes)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="arquivo in arquivos" :key="arquivo.nome">
                                    <td @click="selecionouArquivo(arquivo)">{{ arquivo.nome }}</td>
                                    <td>{{ arquivo.mime }}</td>
                                    <td class="text-right">{{ arquivo.tamanho }}</td>
                                </tr>
                            </tbody>
                            </template>
                        </v-simple-table>
                        
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-container>
                        <v-row>
                            <v-col xs=9 md=6>
                                <arquivo-upload :mimes="mimes" 
                                    :disco="disco" :diretorio="diretorio" :uploadURL="uploadURL"
                                    @file-uploaded="onFileUploaded"></arquivo-upload>
                            </v-col>
                            <v-col xs=1 md=1>
                                <v-spacer></v-spacer>
                            </v-col>
                            <v-col xs=2 md=5>
                                <v-container>
                                    <v-spacer></v-spacer>
                                    <v-btn @click="cancelarSelecao">Cancelar</v-btn>
                                </v-container>
                            </v-col>
                            <!-- <v-btn @click="confirmarSelecao" color="primary">Confirmar</v-btn> -->
                        </v-row>
                    </v-container>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
import ArquivoUpload from './ArquivoUpload'
export default {
    props: {
        arquivo: {
            type: Object
        },
        label: {
            type: String,
            required: true
        },
        mimes: {
            type: String,
            required: true
        },
        disco: {
            type: String,
            required: true
        },
        diretorio: {
            type: String,
            required: true
        },
        uploadURL: {
            type: String,
            required: true,
        }
    },
    data() {
        return {
            mensagens: [],
            exibirJanelaSelecao: false,
            arquivos: null
        }
    },
    methods: {

        carregarArquivos() {
            // console.log("ArquivoInput.carregarArquivos")
            this.arquivos = null
            let parametros = {
                disco: this.disco,
                diretorio: this.diretorio
            }
            this.$http.get("/api/arquivo", { params: parametros }).then(
                this.onCarregarArquivosResponse,
                this.onCarregarArquivosError
            )
        },

        onCarregarArquivosResponse(response) {
            // console.log("ArquivoInput.onCarregarArquivosResponse", response)
            this.arquivos = []
            response.body.forEach(arquivo => {
                this.arquivos.push(arquivo)
            });
        },

        onCarregarArquivosError(error) {
            console.log("ArquivoInput.onCarregarArquivosError", error)
        },

        onFileUploaded(response) {
            // console.log(__filename + ".onFileUploaded()", response)
            if(response.status === 201) {
                this.selecionouArquivo(response.body)
            }
        },

        abrirJanelaSelecao() {
            this.exibirJanelaSelecao = true
            this.carregarArquivos()
        },

        fecharJanelaSelecao() {
            this.exibirJanelaSelecao = false
            this.arquivos = null
        },

        cancelarSelecao() {
            this.fecharJanelaSelecao()
        },

        /*
        confirmarSelecao() {
            this.fecharJanelaSelecao()
        },
        */

        selecionouArquivo(arquivo) {
            this.$emit('arquivo-selecionado', arquivo)
            this.fecharJanelaSelecao()
        },

        limparCampo() {
            this.$emit('arquivo-selecionado', null)
        }

    },
  
}
</script>