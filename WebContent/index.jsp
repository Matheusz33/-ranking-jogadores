<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Ranking de Jogadores</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f0f0f0; display: flex; justify-content: center; padding: 40px; }
    .container { background: white; padding: 30px; border-radius: 10px; width: 500px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h1 { text-align: center; color: #333; }
    form { display: flex; gap: 10px; margin-bottom: 20px; }
    input { flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 5px; }
    button { padding: 8px 16px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; }
    table { width: 100%; border-collapse: collapse; }
    th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
    th { background: #4CAF50; color: white; }
    tr:nth-child(1) td { font-weight: bold; color: goldenrod; }
    tr:nth-child(2) td { color: silver; }
    tr:nth-child(3) td { color: #cd7f32; }
    .btn-excluir { background: #e53935; padding: 5px 10px; font-size: 12px; }
    .btn-excluir:hover { background: #b71c1c; }
  </style>
</head>
<body>
<div class="container">
  <h1>🏆 Ranking de Jogadores</h1>
  <form action="ranking" method="post">
    <input type="text" name="nome" placeholder="Nome do jogador" required />
    <input type="number" name="pontuacao" placeholder="Pontuação" required />
    <button type="submit">Adicionar</button>
  </form>
  <table>
    <tr><th>#</th><th>Nome</th><th>Pontuação</th><th>Ação</th></tr>
    <%
      List<String[]> jogadores = (List<String[]>) request.getAttribute("jogadores");
      if (jogadores != null) {
        int pos = 1;
        for (String[] j : jogadores) {
    %>
    <tr>
      <td><%= pos++ %></td>
      <td><%= j[1] %></td>
      <td><%= j[2] %></td>
      <td><a href="ranking?remover=<%= j[0] %>"><button class="btn-excluir">Excluir</button></a></td>
    </tr>
    <% } } %>
  </table>
</div>
</body>
</html>