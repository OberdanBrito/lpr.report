class Reportcenter {

    constructor(cell) {

        let that = this;

        this.layout = cell.attachLayout({
            pattern: '2U',
            offsets: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            },
            cells: [
                {
                    id: 'a',
                    header: false,
                    width: 250
                },
                {
                    id: 'b',
                    header: false
                }
            ]
        });

        this.Tree = this.layout.cells('a').attachTreeView({
            items: reports
        });

        this.Tree.attachEvent("onDblClick", function (id) {
            that.Preprocessamento(id);
            return true;
        });

    }

    Preprocessamento(relatorio) {

        let that = this;

        this.layout.cells('b').attachToolbar({
            icon_path: "./img/report/toolbar/",
            items:[
                {type: "buttonSelect", id: "processar", text: "Processar", img: "processar.svg", options:[
                    {id: "procview", type: "obj", text: "Pré-visualizar", img: "visualizar.svg"},
                    {id: "procself", type: "obj", text: "Exibir em outra aba", img: "visualizar.svg"}
                ]},
                {type: "separator", id: "sep1"},
                {type: "button", id: "pdf", text:"Exportar PDF", img: "pdf.svg"},
                {type: "button", id: "xls", text:"Exportar Excel", img: "excel.svg"},
                {type: "button", id: "email", text:"Enviar por e-mail", img: "email.svg"},
                {type: "separator", id: "sep1"},
                {type: "button", id: "print", text:"Imprimir", img: "imprimir.svg"},
            ],
            onclick: function (toolbar_id) {

                switch (toolbar_id) {
                    case 'procview':
                        that.Processar(relatorio);
                        break;
                    case 'procself':
                        break;
                    case 'pdf':
                        break;
                    case 'xls':
                        break;
                    case 'email':
                        break;
                    case 'print':
                        break;
                }

            }
        });

    }

    Processar(relatorio, callback) {

        let campos = [];
        this.Tree.getUserData(relatorio, "campos").filter(function (item) {
            campos.push(item.nome);
        });

        let info = new Info();
        info.api = this.Tree.getUserData(relatorio, "origem");
        info.Listar({
            fields: campos.join(','),
            callback: function (response) {
                console.debug(response);
            }
        });

    }
}