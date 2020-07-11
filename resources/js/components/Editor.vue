<template>
    <div>
        {{ conteudo }}
        <div id="editorjs" class="editor"></div>
    </div>
</template>

<script>
import EditorJS from '@editorjs/editorjs'
// import Header from '@editorjs/header'


export default {
    props: {
        conteudo: {
            type: String
        }
    },

    data() {
        return {
            editorJS: null
        }
    },

    methods: {

        inicializar() {
            this.editorJS = new EditorJS({
                holder: 'editorjs',
                tools: {
                },
                onReady: () => {
                    console.log("Editor.onReady", this)
                    this.editorJS.toolbar.open();
                },
                onChange: () => {
                    this.onChange()
                },
                data: {
                    blocks: [
                        {
                            type: "paragraph",
                            data: {
                                text: this.conteudo
                            } 
                        }
                    ]
                }
            })

            // this.editorJS.api.insert("string", "teste")
        },

        onChange() {
            /*
            let conteudo = this.editorJS.save()
            console.log("Editor.onChange", conteudo)
            this.$emit('on-update', this.conteudo)
            */
        }

    },

    mounted() {
        this.inicializar()
    }
}
</script>

<style scoped>
div.editor {
    display: block;
    width: 100%;
    height: 100%;
    min-height: 400px;
    border: #818181;
    border-style: solid;
    border-width: thin;
    border-radius: 20px;
}
</style>