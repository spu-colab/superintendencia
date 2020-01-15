<template>
  <v-container fill-height fluid grid-list>
    
    <!-- layout geral -->
    <v-layout align-start justify-start row wrap>

      <!-- primeira coluna -->
      <v-flex d-flex col xs12 md9 justify-start>
        <v-layout align-start justify-start row wrap>

          <!-- parametros -->
          <v-flex d-flex col xs12 justify-start>
            <v-layout align-start row wrap>
              <!-- Data De -->
              <v-flex col xs12 md4 xl2>
                <v-menu ref="menuDataDe"
                  :close-on-content-click="false"
                  :nudge-right="40"
                  v-model="menuDataDe"
                  lazy
                  transition="scale-transition"
                  offset-y
                  full-width
                  max-width="290px"
                  min-width="290px">

                  <v-text-field  tabindex="5" 
                      mask="##/##/####" return-masked-value
                      slot="activator"
                      v-model="dataDeFormatada"
                      label="Demandas recebidas de:"
                      hint="DD/MM/AAAA"
                      persistent-hint
                      prepend-icon="event" 
                      @blur="dataDe = parseDate(dataDeFormatada)"
                      />
                  <v-date-picker v-model="dataDe" no-title @input="menuDataDe = false" locale="pt-br" />
                </v-menu>
              </v-flex>

              <!-- Data Até -->
              <v-flex col xs12 md4 xl2>
                <v-menu ref="menuDataAte"
                  :close-on-content-click="false"
                  :nudge-right="40"
                  v-model="menuDataAte"
                  lazy
                  transition="scale-transition"
                  offset-y
                  full-width
                  max-width="290px"
                  min-width="290px">

                  <v-text-field  tabindex="5" 
                    mask="##/##/####" return-masked-value
                    slot="activator"
                    v-model="dataAteFormatada"
                    label="até:"
                    hint="DD/MM/AAAA"
                    persistent-hint
                    prepend-icon="event" 
                    @blur="dataAte = parseDate(dataAteFormatada)"
                    />
                  <v-date-picker v-model="dataAte" no-title @input="menuDataAte = false" locale="pt-br" />
                </v-menu>
              </v-flex>

              <v-flex col xs12 md4 xl2>
                <v-btn @click="aplicarParametros" :disabled="!computedAplicarParametrosValido">
                  <v-icon>done</v-icon>
                  Aplicar
                </v-btn>
                <div v-if="this.mensagemParametros.length > 0" class="red--text">{{ mensagemParametros }}</div>                
              </v-flex>

              <v-flex col xs12>
                <v-divider></v-divider>
              </v-flex>

              <v-flex col xs12>
                {{ mensagemParametrosAplicados }}
              </v-flex>

            </v-layout>
          </v-flex>
          <!-- fim de parâmetros -->

          <!-- estatíticas -->
          <v-flex d-flex col xs12 md5>
            <card-numero-destaque
              :carregando="!carregouDemandasAbertasPorSituacao"
              icon="show_chart"
              color="primary"
              titulo="Recebidas do período"
              icon-titulo="move_to_inbox"
              icon-color-titulo="primary"
            >
              {{ demandasAbertasPorSituacao.recebidas }}
              <template slot="detalhe">
                <v-layout align-start justify-center row wrap>
                  <v-flex d-flex xs12 row justify-center>
                    <v-divider></v-divider>
                  </v-flex>
                  <v-flex d-flex col xs6 justify-start>
                    <h6>
                      <v-icon color="green">done</v-icon>
                      Resolvidas: <strong>{{ demandasAbertasPorSituacao.resolvidas }}</strong>
                    </h6>
                  </v-flex>
                  <v-flex d-flex col xs6 justify-start>
                    <h6>
                      <v-icon color="green">play_circle_filled</v-icon>
                      Em análise: <strong>{{ demandasAbertasPorSituacao.em_analise }}</strong>
                    </h6>
                  </v-flex>
                  <v-flex d-flex col xs6 justify-start>
                    <h6>
                      <v-icon color="orange">alarm</v-icon>
                      Atrasadas: <strong>{{ demandasAbertasPorSituacao.atrasadas }}</strong>
                    </h6>
                  </v-flex>
                  <v-flex d-flex col xs6 justify-start>
                    <h6>
                      <v-icon color="red">gavel</v-icon>
                      Sentenças: <strong>{{ demandasAbertasPorSituacao.sentencas_judiciais }}</strong>
                    </h6>
                  </v-flex>
                </v-layout>
              </template>
            </card-numero-destaque>
          </v-flex>
          <!-- fim de estatíticas -->

          <!-- natureza das demandas -->
          <v-flex d-flex col xs12 md7>
            <card-grafico titulo="Natureza das Demandas" :carregando="!carregouDemandasPorNaturezaOrgao">
              <grafico-pizza
                :chartdata="demandasNaturezaOrgao"
                :options="opcoesRelatorioNaturezaOrgao"
                style="height:200px; position: 'relative';"
              />
            </card-grafico>
          </v-flex>  
          <!-- fim de natureza das demandas -->

          <v-flex d-flex row xs12>
            &nbsp;
          </v-flex>

          <!-- origem das demandas -->
          <v-flex d-flex col xs12 md6>
            <card-grafico titulo="Origem das Demandas" :carregando="!carregouDemandasPorDemandante">
              <grafico-barra-horizontal
                :chartdata="demandasPorDemandante"
                :options="opcoesRelatorioDemandasPorDemandante"
              />
            </card-grafico>
          </v-flex>
          <!-- fim de origem das demandas -->

          <!-- distribuição das demandas -->
          <v-flex d-flex col xs12 md6>
            <card-grafico titulo="Distribuição" :carregando="!carregouDemandasAbertasPorDistribuicao">
              <grafico-barra-horizontal
                :chartdata="demandasAbertasPorDistribuicao"
                :options="opcoesRelatorioDemandasAbertasPorDistribuicao"
              />
            </card-grafico>
          </v-flex>
          <!-- distribuição das demandas -->

        </v-layout>
      </v-flex>
      <!-- fim da primeira coluna -->


      <!-- segunda coluna -->
      <v-flex d-flex col xs12 md3 justify-start>
        <!-- Relatórios -->
        
          <v-layout col wrap>
            
            <v-flex d-flex row xs12>
              <h3>Relatórios</h3>
            </v-flex>           

            <v-flex  d-flex row xs12>
              <v-card>
                  <v-card-text>
                    <h4>Demandas por Núcleo</h4>
                    <v-checkbox v-model="incluirReprimidas" label="Incluir Reprimidas"></v-checkbox>
                    <v-btn @click="gerarRelatorioDemandasPorNucleo" :disabled="carregandoRelatorioDemandasPorNucleo">
                      <v-progress-circular indeterminate v-if="carregandoRelatorioDemandasPorNucleo" color="grey" size="20" width="3"></v-progress-circular>
                      Gerar
                    </v-btn>
                  </v-card-text>
              </v-card>
            </v-flex>
          </v-layout>
        <!-- Fim de Relatórios -->

      </v-flex>      
      <!-- fim de segunda coluna -->

      <v-flex d-flex row xs12>
        <v-divider inset></v-divider>
      </v-flex>

      <!-- Entrada x Saída -->
      <v-flex d-flex col xs12>
        <card-grafico titulo="Entrada x Saída Diária (últimos 30 dias)"
            :carregando="!carregouDemandasEntradaSaidaDiaria">
          <grafico-barra
            :chartdata="demandasEntradaSaidaDiaria"
            :options="opcoesRelatorioEntradaSaidaDiaria"
            style="height:200px; position: 'relative';"
          />
        </card-grafico>
      </v-flex>

    </v-layout>
  </v-container>
</template>

<script>
const d3 = require("d3-scale-chromatic");

import rotas from "./../rotas-servico.js";
import CardGrafico from "./relatorios/CardGrafico";
import CardNumeroDestaque from "./relatorios/CardNumeroDestaque";
import GraficoBarra from "./relatorios/GraficoBarra";
import GraficoBarraHorizontal from "./relatorios/GraficoBarraHorizontal";
import GraficoPizza from "./relatorios/GraficoPizza";

export default {
  components: {
    CardGrafico,
    GraficoBarra,
    GraficoBarraHorizontal,
    GraficoPizza
  },
  data: (vm) => {
    return {
      // parametros
      mensagemParametrosAplicados: '',
      mensagemParametros: '',
      menuDataDe: false,
      dataDe: null,
      dataDeFormatada: null,
      menuDataAte: false,
      dataAte: null,
      dataAteFormatada: null,

      carregandoRelatorioDemandasPorNucleo: false,
      incluirReprimidas: false,

      carregouDemandasEntradaSaidaDiaria: false,
      demandasEntradaSaidaDiaria: null,
      opcoesRelatorioEntradaSaidaDiaria: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          position: "bottom"
        }
      },

      carregouDemandasPorNaturezaOrgao: false,
      demandasNaturezaOrgao: null,
      opcoesRelatorioNaturezaOrgao: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          display: true,
          position: "left"
        }
      },

      carregouDemandasPorDemandante: false,
      demandasPorDemandante: null,
      opcoesRelatorioDemandasPorDemandante: {
        responsive: true,
        maintainAspectRatio: true,
        scales: {
          xAxes: [
            {
              stacked: true
            }
          ],
          yAxes: [
            {
              stacked: true
            }
          ]
        },
        legend: {
          position: "bottom"
        }
      },
      menuDataDeDemandante: false,
      menuDataAteDemandante: false,
      dataDeDemandasPorDemandante: null,
      dataAteDemandasPorDemandante: new Date().toLocaleDateString(),

      carregouDemandasAbertasPorDistribuicao: false,
      demandasAbertasPorDistribuicao: null,
      opcoesRelatorioDemandasAbertasPorDistribuicao: {
        legend: {
          display: false
        },
        responsive: true,
        maintainAspectRatio: false
      },

      carregouDemandasAbertasPorSituacao: false,
      demandasAbertasPorSituacao: null,
      opcoesRelatorioDemandasAbertasPorSituacao: {
        legend: {
          position: "right"
        },
        responsive: true,
        maintainAspectRatio: false
      },


    };
  },
  methods: {

    async aplicarParametros() {
      this.mensagemParametrosAplicados = ''
      if(this.dataDe != null && this.dataAte != null) {
        let periodo = 'de ' + this.dataDeFormatada + ' a ' + this.dataAteFormatada
        this.mensagemParametrosAplicados = 'Estatísticas para o período: ' + periodo
      }
      return this.carregarRelatorios();
    },

    formatDate(date) {
      // console.log('formatDate')
      if (!date) return null;
      const [year, month, day] = date.split('-')
      let ret = `${day}/${month}/${year}`
      // console.log(ret)
      return ret
    },

    parseDate (date) {
      // console.log('parseDate')
      if (!date) return null
      const [day, month, year] = date.split('/')
      let ret = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`
      // console.log(ret)
      return ret
    },

    calculatePoint(colorRangeInfo, i, intervalSize) {
      var { colorStart, colorEnd, useEndAsStart } = colorRangeInfo;
      return useEndAsStart
        ? colorEnd - i * intervalSize
        : colorStart + i * intervalSize;
    },

    interpolateColors(dataLength, colorScale, colorRangeInfo) {
      var { colorStart, colorEnd } = colorRangeInfo;
      var colorRange = colorEnd - colorStart;
      var intervalSize = colorRange / dataLength;
      var i, colorPoint;
      var colorArray = [];

      for (i = 0; i < dataLength; i++) {
        colorPoint = this.calculatePoint(colorRangeInfo, i, intervalSize);
        colorArray.push(colorScale(colorPoint));
      }

      return colorArray;
    },

    async carregarDemandasEntradaSaidaDiaria() {
      this.carregouDemandasEntradaSaidaDiaria = false;
      this.demandasEntradaSaidaDiaria = {
        labels: [],
        datasets: [
          {
            label: "Criadas",
            backgroundColor: "red",
            data: []
          },
          {
            label: "Respondidas",
            backgroundColor: "green",
            data: []
          }
        ]
      };
      return this.$http
        .get(rotas.rotas().demanda.relatorio.entradaSaidaDiaria)
        .then(res => {
          // console.log(res.data)
          res.data.forEach(registroDiario => {
            if (
              registroDiario.criadas +
              registroDiario.respondidas +
              registroDiario.canceladas
            ) {
              var dia = new Date(registroDiario.dia + " 00:00:01");
              this.demandasEntradaSaidaDiaria.labels.push(
                dia.getDate() + "/" + (dia.getMonth() + 1)
              );
              this.demandasEntradaSaidaDiaria.datasets[0].data.push(
                registroDiario.criadas
              );
              this.demandasEntradaSaidaDiaria.datasets[1].data.push(
                registroDiario.respondidas
              );
            }
          });
          this.carregouDemandasEntradaSaidaDiaria = true;
        })
        .catch(err => {
          console.log(err);
        });
    },

    async carregarDemandasNaturezaOrgao() {
      this.carregouDemandasPorNaturezaOrgao = false;
      this.demandasNaturezaOrgao = {
        labels: [],
        datasets: [
          {
            data: []
          }
        ]
      };

      let url = rotas.rotas().demanda.relatorio.abertasPorNaturezaOrgao
      if(this.dataDe != null && this.dataAte != null) {
        url = url + '/' + this.dataDe + '/' + this.dataAte
      }
      return this.$http.get(url).then(res => {
          res.data.forEach(element => {
            this.demandasNaturezaOrgao.labels.push(element.natureza);
            this.demandasNaturezaOrgao.datasets[0].data.push(
              element.quantidade
            );
          });

          const colorRangeInfo = {
            colorStart: 0.2,
            colorEnd: 1,
            useEndAsStart: true
          };

          // gerar automaticamente as cores do grafico
          let colors = this.interpolateColors(
            this.demandasNaturezaOrgao.datasets[0].data.length,
            d3.interpolateBlues,
            colorRangeInfo
          );
          this.demandasNaturezaOrgao.datasets[0].backgroundColor = colors;

          this.carregouDemandasPorNaturezaOrgao = true;
        })
        .catch(err => {
          console.log(err);
        });
    },

    async carregarDemandasPorDemandante() {
      this.carregouDemandasPorDemandante = false;
      this.demandasPorDemandante = {
        labels: [],
        datasets: [
          {
            label: "Nova",
            data: [],
            backgroundColor: "red"
          },
          {
            label: "Em análise",
            data: [],
            backgroundColor: "green"
          },
          {
            label: "Pronta",
            data: [],
            backgroundColor: "orange"
          },
          {
            label: "Aguardando assinatura",
            data: [],
            backgroundColor: "black"
          },
          {
            label: "Aguardando AR",
            data: [],
            backgroundColor: "purple"
          },
          {
            label: "Resolvida",
            data: [],
            backgroundColor: "grey"
          }
        ]
      };

      let url = rotas.rotas().demanda.relatorio.abertasPorDemandante
      if(this.dataDe != null && this.dataAte != null) {
        url = url + '/' + this.dataDe + '/' + this.dataAte
      }
      return this.$http.get(url).then(res => {
          let outros = {
            nova: 0,
            em_analise: 0,
            pronta: 0,
            aguardando_assinatura: 0,
            aguardando_ar: 0,
            resolvida: 0
          };
          res.data.forEach(element => {
            if (element.total > 10) {
              this.demandasPorDemandante.labels.push(element.orgao);
              this.demandasPorDemandante.datasets[0].data.push(element.nova);
              this.demandasPorDemandante.datasets[1].data.push(
                element.em_analise
              );
              this.demandasPorDemandante.datasets[2].data.push(element.pronta);
              this.demandasPorDemandante.datasets[3].data.push(
                element.aguardando_assinatura
              );
              this.demandasPorDemandante.datasets[4].data.push(
                element.aguardando_ar
              );
              this.demandasPorDemandante.datasets[5].data.push(
                element.resolvida
              );
            } else {
              outros.nova += element.nova;
              outros.em_analise += element.em_analise;
              outros.pronta += element.pronta;
              outros.aguardando_assinatura += element.aguardando_assinatura;
              outros.aguardando_ar += element.aguardando_ar;
              outros.resolvida += element.resolvida;
            }
          });
          this.demandasPorDemandante.labels.push("Outros");
          this.demandasPorDemandante.datasets[0].data.push(outros.nova);
          this.demandasPorDemandante.datasets[1].data.push(outros.em_analise);
          this.demandasPorDemandante.datasets[2].data.push(outros.pronta);
          this.demandasPorDemandante.datasets[3].data.push(
            outros.aguardando_assinatura
          );
          this.demandasPorDemandante.datasets[4].data.push(
            outros.aguardando_ar
          );
          this.demandasPorDemandante.datasets[5].data.push(outros.resolvida);

          this.carregouDemandasPorDemandante = true;
        })
        .catch(err => {
          console.log(err);
        });
    },

    async carregarDemandasAbertasPorDistribuicao() {
      this.carregouDemandasAbertasPorDistribuicao = false;
      this.demandasAbertasPorDistribuicao = {
        labels: [],
        datasets: [
          {
            label: "Demandas",
            backgroundColor: "blue",
            data: []
          }
        ]
      };
      let url = rotas.rotas().demanda.relatorio.abertasPorDistribuicao
      if(this.dataDe != null && this.dataAte != null) {
        url = url + '/' + this.dataDe + '/' + this.dataAte
      }
      return this.$http.get(url).then(res => {
          res.data.forEach(element => {
            this.demandasAbertasPorDistribuicao.labels.push(
              element.colaborador
            );
            this.demandasAbertasPorDistribuicao.datasets[0].data.push(
              element.demandas_distribuidas
            );
          });
          this.carregouDemandasAbertasPorDistribuicao = true;
        })
        .catch(err => {
          console.log(err);
        });
    },

    carregarDemandasAbertasPorSituacao_() {
      this.carregouDemandasAbertasPorSituacao = false;
      this.demandasAbertasPorSituacao = {
        labels: [
          "Nova",
          "Em análise",
          "Pronta",
          "Aguardando assinatura",
          "Aguardando AR"
        ],
        datasets: [
          {
            data: [],
            backgroundColor: ["red", "green", "orange", "black", "purple"]
          }
        ]
      };
      return this.$http
        .get(rotas.rotas().demanda.relatorio.abertasPorSituacao)
        .then(res => {
          res.data.forEach(element => {
            this.demandasAbertasPorSituacao.datasets[0].data.push(element.nova);
            this.demandasAbertasPorSituacao.datasets[0].data.push(
              element.em_analise
            );
            this.demandasAbertasPorSituacao.datasets[0].data.push(
              element.pronta
            );
            this.demandasAbertasPorSituacao.datasets[0].data.push(
              element.aguardando_assinatura
            );
            this.demandasAbertasPorSituacao.datasets[0].data.push(
              element.aguardando_ar
            );
          });
          this.carregouDemandasAbertasPorSituacao = true;
        })
        .catch(err => {
          console.log(err);
        });
    },

    async carregarDemandasAbertasPorSituacao() {
      this.carregouDemandasAbertasPorSituacao = false;
      this.demandasAbertasPorSituacao = {};

      let url = rotas.rotas().demanda.relatorio.abertasPorSituacao
      if(this.dataDe != null && this.dataAte != null) {
        url = url + '/' + this.dataDe + '/' + this.dataAte
      }
      return this.$http.get(url).then(res => {
          res.data.forEach(element => {
            this.demandasAbertasPorSituacao = element;
          });
          this.carregouDemandasAbertasPorSituacao = true;
        })
        .catch(err => {
          console.log(err);
        });
    },

    async gerarRelatorioDemandasPorNucleo() {
      let formData = new FormData()
      formData.append('incluirReprimidas', this.incluirReprimidas)

      this.carregandoRelatorioDemandasPorNucleo = true;
      let url = rotas.rotas().demanda.relatorio.abertasPorDivisaoOrganograma;
      return this.$http.post(url, formData, { responseType: "arraybuffer" }).then(
        response => {
          console.log(response.data);
          let blob = new Blob([response.data], {
            type: response.headers.get("content-type")
          });
          const data = window.URL.createObjectURL(blob);
          window.open(data, "_blank");
          this.carregandoRelatorioDemandasPorNucleo = false;
        },
        error => {
          console.log(error.body);
          this.$store.commit("sistema/alerta", error.body.message);
          this.carregandoRelatorioDemandasPorNucleo = false;
        }
      );
    },

    async carregarRelatorios() {
      this.carregarDemandasEntradaSaidaDiaria();
      this.carregarDemandasAbertasPorSituacao();
      this.carregarDemandasNaturezaOrgao();
      this.carregarDemandasPorDemandante();
      this.carregarDemandasAbertasPorDistribuicao();
    }

    
  },

  watch: {

    dataDe(val) {
      console.log(this.dataDe)
      this.dataDeFormatada = this.formatDate(this.dataDe)
    },

    dataAte(val) {
      console.log(this.dataAte)
      this.dataAteFormatada = this.formatDate(this.dataAte)
    },

  },

  computed: {
    computedDataDeDemandasPorDemandante() {
      return this.formatDate(this.dataDeDemandasPorDemandante);
    },
    computedDataAteDemandasPorDemandante() {
      return this.formatDate(this.dataAteDemandasPorDemandante);
    },
    computedAplicarParametrosValido() {
      this.mensagemParametros = ''
      // validando o período
      if(this.dataDe == null && this.dataAte == null) {
        return true
      }
      if(this.dataDe != null && this.dataAte != null) {
        let dateDe = new Date(this.dataDe);
        let dateAte = new Date(this.dataAte);
        if(dateAte.getTime() > dateDe.getTime()) {
          return true
        } else {
          this.mensagemParametros = 'Período informado é inválido.'
          return false
        }
      }
      this.mensagemParametros = 'Parâmetros inválidos.'
      return false;
    }
  },

  async mounted() {
    return this.carregarRelatorios();
  }
};
</script>



