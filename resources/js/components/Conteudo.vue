<template>
    <v-container fill-height fluid grid-list>       
        <v-layout justify-start column fill-height>
            <v-layout v-if="carregando" column align-center justify-center fill-height>
                <v-progress-circular
                    :size="100"
                    :width="9"
                    color="grey"
                    indeterminate
                ></v-progress-circular>                
            </v-layout>
            <div v-else>
                <v-layout row align-start>
                    <v-toolbar flat>
                        <v-spacer></v-spacer>
                        <v-toolbar-items>
                            <v-btn flat>Salvar</v-btn>
                        </v-toolbar-items>
                    </v-toolbar>
                </v-layout>
                <v-layout justify-start row>
                    <v-text-field label="Título"
                        v-model="entidadeAtual.titulo" placeholder="Título deste conteúdo"
                        ></v-text-field>
                </v-layout>
                <v-layout column fill-height>
                    <ckeditor :editor="editor" v-model="entidadeAtual.conteudo">
                    </ckeditor>
                </v-layout>
            </div>
        </v-layout>
    </v-container>
            
    
</template>

<script>
import CKEditor from '@ckeditor/ckeditor5-vue'
import ClassicEditor from '@ckeditor/ckeditor5-build-classic'
export default {
    components: {
        // Use the <ckeditor> component in this view.
        ckeditor: CKEditor.component
    },
    data() {
        return {
            carregando: true,
            editor: ClassicEditor,
            entidadeAtual: null
        };
    },
    methods: {
        carregarConteudo() {
            this.entidadeAtual = {
                titulo: 'Título do documento',
                conteudo:'Opa! Deu certo'
            }
            this.carregando = false
        }
    },
    mounted() {
        setTimeout(this.carregarConteudo, 1500);
    }
}
</script>
