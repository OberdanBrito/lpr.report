let reports = [
    {
        id: 1, text: "Informações gerenciais", open: 1, items: [
            {id: 2, text: "Frequência de passagem", userdata: {
                    info: {modelo: './html/modelos/analiticos/tabela.html',
                        titulo: "Relatório analítico de capturas LPR",
                        subtitulo: "Demonstrativo de frequências por ponto de acesso",
                        descricao: "Relatório das passagens por ponto de acesso. Apresenta o ponto de acesso, as datas e as frequências de captura para o período selecionado ou os últimos 30 dias.",
                        origem: "/smart/public/diario_captura_analitico",
                        campos:[
                            {nome:"data", label:"Data"},
                            {nome:"cliente", label:"Cliente", group: true},
                            {nome:"ponto", label:"Ponto", group: true},
                            {nome:"coletor", label:"Coletor"},
                            {nome:"identificacoes", label:"Identificações", totais: true, media: true},
                            {nome:"ident_hora", label:"Ident./Hora", totais: false, media: true},
                            {nome:"capturas", label:"Capturas", totais: true, media: true},
                            {nome:"cap_hora", label:"Capt./Hora", totais:false, media: true},
                            {nome:"avgprocess", label:"Méd. T. Process.", totais:false, media: true},
                            {nome:"minprocess", label:"Mín. T. Process.", totais:false, media: true},
                            {nome:"maxprocess", label:"Máx. T. Process.", totais:false, media: true},
                            {nome:"avgconfidence", label:"Méd. LPR", totais:false, media: true, format: function (item) {
                                    return item + '%'
                                }},
                            {nome:"minconfidence", label:"Mín. LPR", totais:false, media: true},
                            {nome:"maxconfidence", label:"Máx. LPR", totais:false, media: true}
                        ]
                    }
                }
            }
        ]
    }
];