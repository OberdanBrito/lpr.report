class Reportcenter {

    constructor(cell) {

        let that = this;

        this.relatorio =  null;

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
                    header: true,
                    text: 'Estrutura da informação',
                    collapsed_text: 'Estrutura da informação',
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
            that.relatorio = this.getUserData(id, "info");
            that.Preprocessamento();
            return true;
        });

    }

    Preprocessamento() {

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
                        that.PreVisualizar();
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

    Processar(origem, callback) {

        let campos = [];
        this.relatorio.campos.filter(function (item) {
            campos.push(item.nome);
        });

        let info = new Info();
        info.api = origem;
        info.Listar({
            fields: campos.join(','),
            callback: function (response) {
                callback(response);
            }
        });

    }

    PreVisualizar() {

        let that = this;

        this.layout.attachEvent("onContentLoaded", function(){

            let ifr = that.layout.cells('b').getFrame().contentWindow.document;
            ifr.getElementById("rpt-titulo").textContent = that.relatorio.titulo;
            ifr.getElementById("rpt-subtitulo").textContent = that.relatorio.subtitulo;
            ifr.getElementById("rpt-atualizado").textContent = new Date().toLocaleString("pt-BR", {timeZone: "America/Sao_Paulo"});

            that.relatorio.campos.filter(function (item) {

                if (item.group === true)
                    return;

                let tdfieldname = document.createElement('td');
                tdfieldname.textContent = item.label;
                ifr.getElementById('rpt-fields').appendChild(tdfieldname);

            });

            let totais = {};
            that.relatorio.campos.filter(function (item) {

                if (item.group === true)
                    return;

                if (item.totais === true) {
                    totais[item.nome] = 0;
                } else {
                    totais[item.nome] = '-';
                }
            });

            that.Processar(that.relatorio.origem,function (response) {

                response.dados.filter(function (linha) {
                    let tr = document.createElement('tr');
                    that.relatorio.campos.filter(function (item) {

                        if (item.group === true)
                            return;

                        let td = document.createElement('td');

                        let value = linha[item.nome];
                        if (item.format !== undefined)
                            value = item.format(value);

                        td.textContent = value;

                        if (item.center === true)
                            td.className = 'center';

                        tr.appendChild(td);

                        if (item.totais === true) {
                            totais[item.nome] += parseInt(linha[item.nome]);
                        }




                    });
                    ifr.getElementById('rpt-data').appendChild(tr);
                });


                let trtotal = document.createElement('tr');
                trtotal.className = 'rpt-totals row-p';

                for (let elem in totais) {

                    let td = document.createElement('td');
                    td.textContent = totais[elem];
                    trtotal.appendChild(td);
                }

                ifr.getElementById('rpt-totals').appendChild(trtotal);
                that.layout.cells('b').progressOff();

            });

        });

        this.layout.cells('b').progressOn();
        this.layout.cells('b').attachURL(this.relatorio.modelo);

    }
}