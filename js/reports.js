let reports = [
    {
        id: 1, text: "Informações gerenciais", open: 1, items: [
            {id: 2, text: "Frequência de passagem", userdata: {
                    titulo: "Relatório sintético de capturas",
                    subtitulo: "Demonstrativo de frequências por ponto de acesso",
                    descricao: "Relatório das passagens por ponto de acesso. Apresenta o ponto de acesso, as datas e as frequências de captura para o período selecionado ou os últimos 30 dias.",
                    origem: "/smart/public/diario",
                    campos: [
                        {nome:"data", label:"Data", filtro:"date"},
                        {nome:"identificacoes", label:"Identificações", totais: true, media: true},
                        {nome:"capturas", label:"Capturas", totais: true, media: true},
                    ]
                }
            }
        ]
    }
];