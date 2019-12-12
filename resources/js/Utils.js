export default {
    parseDate (date) {
        // console.log(date)
        if (!date) return null

        const [day, month, year] = date.split('/')
        let retorno = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`
        // console.log('parseDate = ')
        // console.log(retorno)
        return retorno
    },
    formatDate (date) {
        // console.log(date)
        if (!date) return null
        
        const [year, month, day] = date.split('-')
        let retorno = `${day}/${month}/${year}`
        // console.log('formatDate =')
        // console.log(retorno)
        return retorno
    },
    validacao: {
        obrigatorio: v => !!v || 'Preenchimento obrigatório.',
        min15: v => !!v && v.length >= 15 || 'No mínimo 15 caracteres' ,
        min8: v => !!v && v.length >= 8 || 'No mínimo 8 caracteres' ,
        min3: v => !!v && v.length >= 3 || 'No mínimo 3 caracteres',
        min2: v => !!v && v.length >= 2 || 'No mínimo 2 caracteres',
        email: v => {
            if(v == null || v.length == 0) {
                return true
            }
            return /.+@.+\..+/.test(v) || 'E-mail precisa ser válido'
        }
    }
}