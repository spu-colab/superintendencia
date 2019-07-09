<template>
    <v-container fill-height fluid grid-list>       
        <v-layout justify-start column fill-height>
            <!-- Carregando conteúdo -->
            <v-layout v-if="carregando" column align-center justify-center fill-height>
                <v-progress-circular
                    :size="100"
                    :width="9"
                    color="grey"
                    indeterminate
                ></v-progress-circular>                
            </v-layout>
            <!-- Conteúdo carregado... -->
            <div v-else>
                <v-layout row align-start>
                    <v-toolbar flat style="margin-bottom: 15px">
                        <v-spacer></v-spacer>
                        <v-toolbar-items>
                            <v-btn flat small 
                                @click="editando = !editando">
                                <v-icon>edit</v-icon>
                            </v-btn>
                            <v-btn flat small :disabled="!editando"
                                @click="salvar">
                                <v-icon>save_alt</v-icon>
                            </v-btn>
                        </v-toolbar-items>
                    </v-toolbar>
                </v-layout>
                <v-layout justify-start row>
                    <v-text-field v-if="editando" label="Título"
                        v-model="entidadeAtual.titulo" placeholder="Título deste conteúdo"
                        ></v-text-field>
                    <div v-else class="conteudo" id="titulo">{{ entidadeAtual.titulo }}</div>
                </v-layout>
                <v-layout column fill-height>
                    <ckeditor v-if="editando" 
                        :editor="editor" 
                        :config="editorConfig" 
                        v-model="entidadeAtual.conteudo">
                    </ckeditor>
                    <div v-else class="conteudo" id="conteudo" v-html="entidadeAtual.conteudo"></div>
                </v-layout>
            </div>
        </v-layout>
    </v-container>
</template>

<script>
import ClassicEditor from '@ckeditor/ckeditor5-build-classic'
// import CKFinder from '@ckeditor/ckeditor5-ckfinder/src/ckfinder';
import rotas from './../rotas-servico.js'
export default {
    props: ['id'],
    data() {
        return {
            carregando: true,
            editando: false,
            entidadeAtual: null,

            editor: ClassicEditor,   
            editorConfig: {
                ckfinder: {
                    // Upload the images to the server using the CKFinder QuickUpload command.
                    uploadUrl: rotas.rotas().conteudo.upload
                }
            }
            
        };
    },
    methods: {
        carregarConteudo(id) {
            this.carregando = true;
            this.editando = false;
            console.log(id);
            if(id>0) {
                this.entidadeAtual = {
                    id: null,
                    titulo: 'Documento não encontrado',
                    conteudo:'Ocorreu alum'
                }
            } else {
                this.entidadeAtual = {
                    id: id
                }
                this.$http
                    .get(rotas.rotas().conteudo.consultar + this.entidadeAtual.id)
                    .then(
                        response => {
                            // console.log('consultando conteudo :' + this.entidadeAtual.id)
                            // console.log(response)
                            if(response.status == 404) {
                                this.erro = true
                            } else {
                                this.entidadeAtual = response.body
                                this.carregando = false
                                this.editando = false
                            }
                        },
                        error => {
                            console.log(error)
                            this.$store.commit('sistema/alerta', 'Erro ao carregar conteúdo de id: ' + this.entidadeAtual.id)
                        }
                    )
            }
            this.carregando = false
        },

        salvar() {
            let formData = new FormData()
            formData.append('conteudo[id]', this.entidadeAtual.id)
            formData.append('conteudo[titulo]', this.entidadeAtual.titulo)
            formData.append('conteudo[conteudo]', this.entidadeAtual.conteudo)

            if(this.entidadeAtual.id != null) {
                formData.append('_method', 'PUT')      
            }

            let url = this.entidadeAtual.id == null ?
                rotas.rotas().conteudo.criar : 
                rotas.rotas().conteudo.editar + '' + this.entidadeAtual.id;

            this.$http.post(url, formData)
                .then(
                    response => {
                        console.log(response)
                        this.$store.commit('sistema/mensagem', 'Conteúdo cadastrado com sucesso!')
                        this.carregarConteudo(response.body.id)
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', 'Erro ao salvar conteúdo')
                    }
                )

        }
    },
    mounted() {
        this.carregarConteudo(this.id);
    }
}
</script>

<style scoped>
div.conteudo#titulo {
    color: #1976D2;
    font-size: 20pt;
    font-weight: 600;
}
div.conteudo#conteudo {
    margin-top: 16pt;
    color: #4a4a4a;
    font-size: 13pt;
}
</style>

