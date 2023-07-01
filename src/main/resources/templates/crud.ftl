<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD Cidades</title>
    <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
        <nav class="navbar navbar-expand-sm bg-dark">
        <#if (Session.usuarioAtual)??>
            <span class="navbar-brand text-white">${Session.usuarioAtual}</span>
        <#else>
            <span class="navbar-brand text-white">Anônimo</span>
        </#if>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a 
                        href="/logout"
                        class="nav-link btn btn-secondary"
                        >Sair da aplicação</a>
                </li>
            </ul>
        </nav>

    <div class="container-fluid">
        <div class="jumbotron mt-5">
            <h1>GERENCIAMENTO DE CIDADES</h1>
            <P>UM CRUD PARA CRIAR, ALTERAR, EXCLUIR E LISTAR CIDADES</P>
        </div>
            <#if cidadeAtual??>
                <form action="/alterar" method="POST" class="needs-validation" novalidate>
                <input value="${(cidadeAtual.nome)!}" name="nomeAtual" type="hidden">
                <input  value="${(cidadeAtual.estado)!}" name="estadoAtual" type="hidden">
            <#else>
                <form action="/criar" method="POST" class="needs-validation" novalidate>
            </#if>
            <div class="form-group">
                <label for="nome">Cidade:</label>
                <input required value="${(cidadeAtual.nome)!}${nomeInformado!}" name="nome" type="text" class="form-control ${(nome??)?then('is-invalid', '')}" placeholder="Informe o nome da cidade" id="nome">

                <div class="invalid-feedback">
                    ${nome!}
                </div>
            </div>
            <div class="form-group">
                <label for="estado">Estado:</label>
                <input maxlength="2" required value="${(cidadeAtual.estado)!}${estadoInformado!}" name="estado" type="text" class="form-control ${(estado??)?then('is-invalid', '')}" placeholder="Informe o estado ao qual a cidade pertence" id="estado">
            
                <div class="invalid-feedback">
                    ${estado!}
                </div>
            </div>
            <#if cidadeAtual??>
                <button type="submit" class="btn btn-warning">CONCLUIR ALTERAÇÃO</button>
            <#else>
                <button type="submit" class="btn btn-primary">CRIAR</button>
            </#if>
            
        </form>
        <table class="table table-striped table-hover mt-5">
            <thead class="thead-dark">
                <tr>
                    <th>Nome</th>
                    <th>Estado</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <#list listaCidades as cidade>
                    <tr>
                        <td>${cidade.nome}</td>
                        <td>${cidade.estado}</td>
                        <td>
                            <div class="d-flex d-justify-content-center">
                                <a href="/preparaAlterar?nome=${cidade.nome}&estado=${cidade.estado}" class="btn btn-warning mr-3">ALTERAR</a>
                                <a href="/excluir?nome=${cidade.nome}&estado=${cidade.estado}" class="btn btn-danger">EXCLUIR</a>
                            </div>
                        </td>
                    </tr>
                </#list>
            </tbody>
        </table>
    </div>
</body>
</html>