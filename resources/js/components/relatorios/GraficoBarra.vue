<script>
import { Bar, mixins } from 'vue-chartjs'
const { reactiveData } = mixins

export default {
    extends: Bar,
    props: {
        chartdata: {
            type: Object,
            default: null
        },
        options: null
    },
    mounted () {
        this.renderChart(this.chartdata, this.options)
    }
}
</script>