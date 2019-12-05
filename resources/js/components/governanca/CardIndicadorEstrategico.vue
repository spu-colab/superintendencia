<template>
    <v-card>
        <table class="indicador" width="100%" border="0">
            <tbody>
                <tr>
                    <td class="colunaMetaSPU">
                        {{ meta.identificacao }}
                    </td>
                    <td class="colunaMetaEspecifica" :colspan="meta.valoresMensais.length + 1">
                        #{{ meta.metaEspecifica }}
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="background-color: #e7f5ff;">&nbsp;</td>
                    <td class="colunaTipoValor">
                        &nbsp;
                    </td>
                    <th v-for="valorMensal in meta.valoresMensais" :key="valorMensal.mes">
                        {{ valorMensal.mes }}
                    </th>
                    <!--
                    <th>
                        Total
                    </th>
                    -->
                </tr>
                <tr>
                    <td>Previsto</td>
                    <td v-for="valorMensal in meta.valoresMensais" :key="valorMensal.mes">
                        {{ valorFormatado(valorMensal.previsto, meta.percentual) }}
                    </td>
                    <!--
                    <td>
                        {{ valorTotalPrevisto(meta) }}
                    </td>
                    -->
                </tr>
                <tr>
                    <td>Realizado</td>
                    <td v-for="valorMensal in meta.valoresMensais" :key="valorMensal.mes" :class="computedClasseRealizado(valorMensal)">
                        {{ valorFormatado(valorMensal.realizado, meta.percentual) }}
                    </td>
                    <!--
                    <td>
                        {{ valorTotalRealizado(meta) }}
                    </td>
                    -->
                </tr>
            </tbody>
        </table>
    </v-card>
</template>

<script>
import { isNumber } from 'util'
export default {
    props: {
      meta: Object, 
    },
    methods: {
        computedClasseRealizado: (valorMensal) => {
            if (valorMensal.realizado == null) {
                return ''
            }
            return valorMensal.realizado >= valorMensal.previsto ? 'metaAtingida' : 'metaNaoAtingida'
        },
        valorFormatado(valor, percentual) {
            if(valor == null) {
                return ''
            }
            let retorno = valor;
            if(isNumber(valor)) {
                retorno = valor.toLocaleString('pt-BR')
            }
            if(percentual) {
                retorno = retorno + '%'
            }
            return retorno
        },
        valorTotalPrevisto(meta) {
            let retorno = 0;
            for (let index = 0; index < meta.valoresMensais.length; index++) {
                const valorMensal = meta.valoresMensais[index];
                retorno += valorMensal.previsto;                
            }
            return this.valorFormatado(retorno, meta.percentual)
        },
        valorTotalRealizado(meta) {
            let retorno = 0;
            for (let index = 0; index < meta.valoresMensais.length; index++) {
                const valorMensal = meta.valoresMensais[index];
                retorno += valorMensal.realizado;                
            }
            return this.valorFormatado(retorno, meta.percentual)
        }

    }

}
</script>

<style scoped>
table.indicador {
    color: #495057;
}

table.indicador th {
    text-align: center;
}

table.indicador td {
    font-size: 10pt;
    padding: 3pt;
    text-align: center;
}

table.indicador td.colunaMetaSPU {
    background-color:#74c0fc;
    font-size: 20pt;
    color: white;
    font-weight: 600;
    width: 70px;
}

table.indicador td.colunaMetaEspecifica {
    text-align: left;
    padding: 10pt;
    background-color: #e7f5ff;
    font-size: 13pt;
    font-weight: 500;
}

table.indicador td.colunaTipoValor {
    width: 80px;
}

table.indicador td.metaNaoAtingida {
    background-color: #ffe066;
}

table.indicador td.metaAtingida {
    background-color: #69db7c;
}

table.indicador tr:hover {
    background-color: #FAFAFA;
    color: black;
}

table.indicador td:hover, table.indicador td.metaNaoAtingida:hover, table.indicador td.metaAtingida:hover {
    cursor: default;
    background-color: #d8dee9;
}

</style>