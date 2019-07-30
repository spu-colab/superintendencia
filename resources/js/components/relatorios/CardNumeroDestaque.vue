<template>
  <v-container fill-height fluid grid-list>
    <!-- primeira linha -->
    <v-layout align-start justify-start row wrap>
      <v-flex d-flex col xs12>
        <v-card tile class="mx-autor">
          <v-card-title v-if="titulo">
            <div class="titulo">{{ titulo }}</div>
          </v-card-title>
          <v-layout>
            <v-flex shrink>
              <v-avatar
                class="profile"
                :size="$vuetify.breakpoint.smAndUp ? 80 : 50"
                :color="color"
                tile
              >
                <v-icon x-large>{{ icon }}</v-icon>
              </v-avatar>
            </v-flex>
            <v-flex>
              <v-container fill-height fluid grid-list>
                <v-layout align-start justify-center row wrap>
                  <p class="text-lg-center text-color-grey">
                    <span class="numero">
                      <slot></slot>
                    </span>
                  </p>
                </v-layout>
              </v-container>
            </v-flex>
          </v-layout>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  props: {
    titulo: {
      type: String,
      default: null
    },
    icon: {
      type: String,
      default: null
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