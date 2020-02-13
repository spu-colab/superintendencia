<template>
  <v-container fluid>
    <v-row v-for="comentario in comentarios" :key="comentario.id">
        <v-col xs="12" md="3" xl="2" class="text-center">
            <v-avatar>
              <v-icon large>person</v-icon>
            </v-avatar>
            <div class="body-1 font-weight-bold blue-grey--text darken-3--text">{{ comentario.usuario.name }}</div>       
            <div class="caption blue-grey--text darken-3--text">{{ formatarDataHora(comentario.dataHora) }}</div>       
        </v-col>
        <v-col xs="12" md="9" xl="10" class="pre-formatted">
          {{ comentario.comentario }}
        </v-col>
      <v-divider/>
    </v-row>
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