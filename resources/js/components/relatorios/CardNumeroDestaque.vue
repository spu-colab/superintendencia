<template>
  <!--
  <v-container fill-height fluid grid-list>
    <v-layout align-start justify-start row wrap>
      <v-flex d-flex col xs12>
        -->
        <v-card class="mx-auto" :loading="carregando" tile>
          <v-card-title v-if="titulo">
            <div class="overline mb-4">
              <v-icon :color="iconColorTitulo">{{ iconTitulo }}</v-icon>
              {{ titulo }}
            </div>
          </v-card-title>

          <v-card-subtitle>
            <p class="text-right numero">
              <slot></slot>
            </p>
          </v-card-subtitle>

          <v-card-text v-if="!carregando">
              <slot name="detalhe"></slot>
          </v-card-text>
        </v-card>
        <!--
      </v-flex>
    </v-layout>
  </v-container>
  -->
</template>

<script>
export default {
  props: {
    carregando: {
      type: Boolean,
      default: false
    },
    titulo: {
      type: String,
      default: null
    },
    icon: {
      type: String,
      default: null
    },
    iconTitulo: {
      type: String,
      default: null
    },
    iconColorTitulo: {
      type: String,
      default: "yellow"
    },
    color: {
      type: String,
      default: "yellow"
    }
  }
};
</script>

<style scoped>
.titulo {
    width: 100%;
    font-size: 13pt;
    line-height: 7pt;
    font-weight: 300;
    color: grey;
    text-align: end;
}
.numero {
  font-size: 40pt;
  font-weight: 600;
  color: #838383;
  line-height: 15pt;
}
.profile {
  position: absolute;
  left: -10pt;
  top: -10pt;
  z-index: 1;
}
</style>