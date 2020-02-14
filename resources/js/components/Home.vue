<template>
    <v-container fluid>
        <v-row align="stretch">
            <!-- Base de Conhecimento -->
            <v-col xs="12" md="4">
                <v-card class="align-stretch" href="http://10.209.232.158/wordpress" target="_blank">
                    <v-img src="/images/baseconhecimento.jpg" aspect-ratio="2.75" />
                    <v-card-title primary title>
                        Base de Conhecimento
                    </v-card-title>
                    <v-card-subtitle>
                        Espaço criado para que todos os colaboradores da SPU-SC tenham liberdade para criar, compartilhar e ter acesso ao conhecimento produzido na Superintendência.
                    </v-card-subtitle>
                </v-card>
            </v-col>

            <!-- Geovisualização -->
            <v-col xs="12" md="4">
                <v-card class="align-stretch" to="/geo">
                    <v-img src="/images/geo.jpg" aspect-ratio="2.75" />
                    <v-card-title primary title>
                        Geovisualizador
                    </v-card-title>
                    <v-card-subtitle>
                        Conheça nosso painel de geovisualização das demandas juridicas.
                    </v-card-subtitle>
                </v-card>
            </v-col>

            <!-- Demandas Jurídicas e de Controle -->
            <v-col xs="12" md="4">
                <v-card class="align-stretch" to="/nujuc">
                    <v-img src="/images/juridicas.jpg" aspect-ratio="2.75" />
                    <v-card-title primary title>
                        Demandas Jurídicas e de Controle
                    </v-card-title>
                    <v-card-subtitle>
                        Módulo de gestão das demandas jurídicas e de controle
                    </v-card-subtitle>
                </v-card>
            </v-col>

            <!-- Metas SPU-SC -->
            <v-col cols="12">
                <v-layout align-start justify-space-between row>
                    <card-indicadores-estrategicos/>
                </v-layout>
            </v-col>

        </v-row>
        
    </v-container>

</template>

<script>
import rotas from './../rotas-servico.js'
import CardGrafico from './relatorios/CardGrafico'
import GraficoBarra from './relatorios/GraficoBarra'
import GraficoBarraHorizontal from './relatorios/GraficoBarraHorizontal'
import GraficoPizza from './relatorios/GraficoPizza'
import CardIndicadoresEstrategicos from './governanca/CardIndicadoresEstrategicos'

export default {
    components: {
        CardGrafico, GraficoBarra, GraficoBarraHorizontal, GraficoPizza
    },
    data: () => {
        return {

            carregouDemandasEntradaSaidaDiaria: false,
            demandasEntradaSaidaDiaria: null,
            opcoesRelatorioEntradaSaidaDiaria: {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    position: 'bottom'
                },
            },

            carregouDemandasPorDemandante: false,
            demandasPorDemandante: null,
            opcoesRelatorioDemandasPorDemandante: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    xAxes: [{
                        stacked: true
                    }],
                    yAxes: [{
                        stacked: true
                    }]
                },
                legend: {
                    position: 'bottom'
                },
            },
            menuDataDeDemandante: false,
            menuDataAteDemandante: false,
            dataDeDemandasPorDemandante: null,
            dataAteDemandasPorDemandante: (new Date()).toLocaleDateString(),

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
                    position: 'right'
                },
                responsive: true,
                maintainAspectRatio: false,
            },

        }
    },
    methods: {
        carregarDemandasEntradaSaidaDiaria () {
            this.carregouDemandasEntradaSaidaDiaria = false
            this.demandasEntradaSaidaDiaria = {
                labels: [],
                datasets: [
                    {
                        label: 'Criadas',
                        backgroundColor: 'red',
                        data: []
                    },
                    {
                        label: 'Respondidas',
                        backgroundColor: 'green',
                        data: []
                    }
                ]
            }
            this.$http.get(rotas.rotas().demanda.relatorio.entradaSaidaDiaria)
                .then(res => {
                    // console.log(res.data)
                    res.data.forEach((registroDiario) => {
                        if(registroDiario.criadas +  registroDiario.respondidas + registroDiario.canceladas) {
                            var dia = new Date(registroDiario.dia + " 00:00:01")
                            this.demandasEntradaSaidaDiaria.labels.push(dia.getDate() + '/' + (dia.getMonth()+1))
                            this.demandasEntradaSaidaDiaria.datasets[0].data.push(registroDiario.criadas)
                            this.demandasEntradaSaidaDiaria.datasets[1].data.push(registroDiario.respondidas)
                        }
                    })
                    this.carregouDemandasEntradaSaidaDiaria = true
                })
                .catch(err => {
                    console.log(err)
                })
        },

        carregarDemandasPorDemandante() {
            this.carregouDemandasPorDemandante = false
            this.demandasPorDemandante = {
                labels: [],
                datasets: [
                    {
                        label: 'Nova',
                        data: [],
                        backgroundColor: 'red'
                    },
                    {
                        label: 'Em análise',
                        data: [],
                        backgroundColor: 'green'
                    },
                    {
                        label: 'Pronta',
                        data: [],
                        backgroundColor: 'orange'
                    },
                    {
                        label: 'Aguardando assinatura',
                        data: [],
                        backgroundColor: 'black'
                    },
                    {
                        label: 'Aguardando AR',
                        data: [],
                        backgroundColor: 'purple'
                    },
                    {
                        label: 'Resolvida',
                        data: [],
                        backgroundColor: 'grey'
                    },
                ],
            }
            this.$http.get(rotas.rotas().demanda.relatorio.abertasPorDemandante)
                .then(res => {
                    let outros = {
                        nova: 0,
                        em_analise: 0,
                        pronta: 0,
                        aguardando_assinatura: 0,
                        aguardando_ar: 0,
                        resolvida: 0
                    }
                    res.data.forEach((element) => {
                        if(element.total > 10) {
                            this.demandasPorDemandante.labels.push(element.orgao)
                            this.demandasPorDemandante.datasets[0].data.push(element.nova)
                            this.demandasPorDemandante.datasets[1].data.push(element.em_analise)
                            this.demandasPorDemandante.datasets[2].data.push(element.pronta)
                            this.demandasPorDemandante.datasets[3].data.push(element.aguardando_assinatura)
                            this.demandasPorDemandante.datasets[4].data.push(element.aguardando_ar)
                            this.demandasPorDemandante.datasets[5].data.push(element.resolvida)
                        } else {
                            outros.nova += element.nova
                            outros.em_analise += element.em_analise
                            outros.pronta += element.pronta
                            outros.aguardando_assinatura += element.aguardando_assinatura
                            outros.aguardando_ar += element.aguardando_ar
                            outros.resolvida += element.resolvida
                        }
                    })
                    this.demandasPorDemandante.labels.push('Outros')
                    this.demandasPorDemandante.datasets[0].data.push(outros.nova)
                    this.demandasPorDemandante.datasets[1].data.push(outros.em_analise)
                    this.demandasPorDemandante.datasets[2].data.push(outros.pronta)
                    this.demandasPorDemandante.datasets[3].data.push(outros.aguardando_assinatura)
                    this.demandasPorDemandante.datasets[4].data.push(outros.aguardando_ar)
                    this.demandasPorDemandante.datasets[5].data.push(outros.resolvida)

                    this.carregouDemandasPorDemandante = true
                })
                .catch(err => {
                    console.log(err)
                })
        },

        carregarDemandasAbertasPorDistribuicao () {
            this.carregouDemandasAbertasPorDistribuicao = false
            this.demandasAbertasPorDistribuicao = {
                labels: [],
                datasets: [
                    {
                        label: 'Demandas',
                        backgroundColor: 'blue',
                        data: []
                    }
                ]
            }
            this.$http.get(rotas.rotas().demanda.relatorio.abertasPorDistribuicao)
                .then(res => {
                    res.data.forEach((element) => {
                        this.demandasAbertasPorDistribuicao.labels.push(element.colaborador)
                        this.demandasAbertasPorDistribuicao.datasets[0].data.push(element.demandas_distribuidas)
                    })
                    this.carregouDemandasAbertasPorDistribuicao = true
                })
                .catch(err => {
                    console.log(err)
                })
        },

        carregarDemandasAbertasPorSituacao () {
            this.carregouDemandasAbertasPorSituacao = false
            this.demandasAbertasPorSituacao = {
                labels: ['Nova', 'Em análise', 'Pronta', 'Aguardando assinatura', 'Aguardando AR'],
                datasets: [
                    {
                        data: [],
                        backgroundColor: [
                            'red',
                            'green',
                            'orange',
                            'black',
                            'purple',
                        ]
                    }
                ]
            }
            this.$http.get(rotas.rotas().demanda.relatorio.abertasPorSituacao)
                .then(res => {
                    res.data.forEach((element) => {
                        this.demandasAbertasPorSituacao.datasets[0].data.push(element.nova)
                        this.demandasAbertasPorSituacao.datasets[0].data.push(element.em_analise)
                        this.demandasAbertasPorSituacao.datasets[0].data.push(element.pronta)
                        this.demandasAbertasPorSituacao.datasets[0].data.push(element.aguardando_assinatura)
                        this.demandasAbertasPorSituacao.datasets[0].data.push(element.aguardando_ar)
                    })
                    this.carregouDemandasAbertasPorSituacao = true
                })
                .catch(err => {
                    console.log(err)
                })
        },
        
        formatDate (date) {
            if (!date) return null
            return date
            /*

            const [year, month, day] = date.split('/')
            return `${day}/${month}/${year}`
            */
        },

    },

    computed: {
        computedDataDeDemandasPorDemandante () {
            return this.formatDate(this.dataDeDemandasPorDemandante)
        },
        computedDataAteDemandasPorDemandante () {
            return this.formatDate(this.dataAteDemandasPorDemandante)
        }
    },

    async mounted () {
        this.carregarDemandasEntradaSaidaDiaria();
        this.carregarDemandasAbertasPorDistribuicao();
        this.carregarDemandasAbertasPorSituacao();
        this.carregarDemandasPorDemandante();
    }
}
</script>
