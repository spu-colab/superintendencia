<template>
    <div>
        <v-file-input label="Arquivo" placeholder="Enviar arquivo do seu dispositivo" 
            :accept="mimes" @change="uploadFile"
            outlined dense show-size prepend-icon="publish"></v-file-input>
        <!--
        <div class="large-12 medium-12 small-12 filezone">
            <input type="file" id="files" ref="files" multiple v-on:change="handleFiles()"/>
            <p>
                Arreste e solte seu arquivo aqui
            </p>
        </div>

        <div v-for="(file, key) in files" v-bind:key="key" class="file-listing">
            <img class="preview" v-bind:ref="'preview'+parseInt(key)"/>
            {{ file.name }}
            <div class="success-container" v-if="file.id > 0">
                Success
            </div>
            <div class="remove-container" v-else>
                <a class="remove" v-on:click="removeFile(key)">Remove</a>
            </div>
        </div>

        <a class="submit-button" v-on:click="submitFiles()" v-show="files.length > 0">Submit</a>
        -->
    </div>
</template>

<script>
    import rotas from './../rotas-servico.js'

    export default {
        props: {
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
            },
            mimes: {
                type: String,
                required: true
            },
        },

        data() {
            return {
                // files: []
            }
        },

        methods: {

            uploadFile(file) {
                console.log(__filename + ".uploadFile()", file)
                let formData = new FormData()
                formData.append('disco', this.disco)
                formData.append('diretorio', this.diretorio)
                formData.append('arquivo', file)
                this.$http.post(this.uploadURL, formData).then(
                    this.onUploadFileResponse,
                    this.onUploadFileError,
                )
            },

            onUploadFileResponse(response) {
                console.log(__filename + ".onUploadFileResponse()", response)
                this.$store.commit("sistema/mensagem", "Upload do arquivo '" + response.body.nome + "' realizado com sucesso")
                this.$emit("file-uploaded", response)
            },

            onUploadFileError(error) {
                console.log(__filename + ".onUploadFileError()", error)
                let mensagemErro = ''
                for (const campo in error.body.errors) {
                    if (error.body.errors.hasOwnProperty(campo)) {
                        mensagemErro += " " + error.body.errors[campo];
                        
                    }
                }
                this.$store.commit("sistema/alerta", "Erro ao enviar arquivo: " + mensagemErro )

            },

            /*
            handleFiles() {
                let uploadedFiles = this.$refs.files.files;

                for(var i = 0; i < uploadedFiles.length; i++) {
                    this.files.push(uploadedFiles[i]);
                }
                this.getImagePreviews();
            },

            getImagePreviews(){
                for( let i = 0; i < this.files.length; i++ ){
                    if ( /\.(jpe?g|png|gif)$/i.test( this.files[i].name ) ) {
                        let reader = new FileReader();
                        reader.addEventListener("load", function(){
                            this.$refs['preview'+parseInt( i )][0].src = reader.result;
                        }.bind(this), false);
                        reader.readAsDataURL( this.files[i] );
                    }else{
                        this.$nextTick(function(){
                            this.$refs['preview'+parseInt( i )][0].src = '/img/generic.png';
                        });
                    }
                }
            },

            removeFile( key ){
                this.files.splice( key, 1 );
                this.getImagePreviews();
            },

            submitFiles() {
                for( let i = 0; i < this.files.length; i++ ){
                    if(this.files[i].id) {
                        continue;
                    }
                    let formData = new FormData();
                    formData.append('arquivo', this.files[i]);

                    this.$http.post(rotas.rotas().arquivo.upload, formData)
                        .then(
                            response => {
                                console.log(response)
                                this.files[i].id = response['data']['id'];
                                this.files.splice(i, 1, this.files[i]);
                                this.$store.commit('sistema/mensagem', 'Arquivo salvo com sucesso!')
                                
                            },
                            error => {
                                console.log(error.body)
                                this.$store.commit('sistema/alerta', error.body.message)
                            }
                        )
                }
            },
            */
        }
    }
</script>

<style scoped>
/*
    input[type="file"]{
        opacity: 0;
        width: 100%;
        height: 200px;
        position: absolute;
        cursor: pointer;
    }
    .filezone {
        outline: 2px dashed grey;
        outline-offset: -10px;
        background: #ccc;
        color: dimgray;
        padding: 10px 10px;
        min-height: 200px;
        position: relative;
        cursor: pointer;
    }
    .filezone:hover {
        background: #c0c0c0;
    }

    .filezone p {
        font-size: 1.2em;
        text-align: center;
        padding: 50px 50px 50px 50px;
    }
    div.file-listing img{
        max-width: 90%;
    }

    div.file-listing{
        margin: auto;
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }

    div.file-listing img{
        height: 100px;
    }
    div.success-container{
        text-align: center;
        color: green;
    }

    div.remove-container{
        text-align: center;
    }

    div.remove-container a{
        color: red;
        cursor: pointer;
    }

    a.submit-button{
        display: block;
        margin: auto;
        text-align: center;
        width: 200px;
        padding: 10px;
        text-transform: uppercase;
        background-color: #CCC;
        color: white;
        font-weight: bold;
        margin-top: 20px;
    }
*/
</style>
