import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/ranking")
public class RankingServlet extends HttpServlet {

private static final String URL = "jdbc:mysql://mysql.railway.internal:3306/ferrovia";
private static final String USER = "root";
private static final String PASS = "GfRgaVLRPNzrkTPydkDSXSCGxsysLEDy";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String remover = request.getParameter("remover");
        if (remover != null) {
            try (Connection con = DriverManager.getConnection(URL, USER, PASS)) {
                PreparedStatement ps = con.prepareStatement("DELETE FROM jogadores WHERE id = ?");
                ps.setInt(1, Integer.parseInt(remover));
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("ranking");
            return;
        }

        List<String[]> jogadores = new ArrayList<>();
        try (Connection con = DriverManager.getConnection(URL, USER, PASS)) {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT id, nome, pontuacao FROM jogadores ORDER BY pontuacao DESC");
            while (rs.next()) {
                jogadores.add(new String[]{
                    String.valueOf(rs.getInt("id")),
                    rs.getString("nome"),
                    String.valueOf(rs.getInt("pontuacao"))
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("jogadores", jogadores);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String pontuacao = request.getParameter("pontuacao");
        if (nome != null && !nome.isEmpty() && pontuacao != null && !pontuacao.isEmpty()) {
            try (Connection con = DriverManager.getConnection(URL, USER, PASS)) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO jogadores (nome, pontuacao) VALUES (?, ?)");
                ps.setString(1, nome);
                ps.setInt(2, Integer.parseInt(pontuacao));
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("ranking");
    }
}