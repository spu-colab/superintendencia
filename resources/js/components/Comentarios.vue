<template>
  <v-container fluid>
    <div v-for="comentario in comentarios" :key="comentario.id">
      <v-layout row>
        <v-flex xs12 md3 xl2>
          <v-layout column align-center justify-center>
            <v-list-tile-avatar>
              <v-icon large>person</v-icon>
            </v-list-tile-avatar>
            <div class="body-1 font-weight-bold blue-grey--text darken-3--text">{{ comentario.usuario.name }}</div>       
            <div class="caption blue-grey--text darken-3--text">{{ formatarDataHora(comentario.dataHora) }}</div>       
          </v-layout>
        </v-flex>
        <v-flex xs12 md9 xl10 class="pre-formatted">
          {{ comentario.comentario }}
        </v-flex>
      </v-layout>
      <v-divider/>
    </div>
  </v-container>

</template>
<script>
import Utils from './../Utils'
export default {
    props: {
        comentarios: {
            type: Array,
        }
    },
    methods: {
      formatarDataHora(dataHora) {
        return Utils.formatarDataHora(dataHora)
      }
    }
}
</script>

<style scoped>
.pre-formatted {
  white-space: pre-wrap;
}
</style>