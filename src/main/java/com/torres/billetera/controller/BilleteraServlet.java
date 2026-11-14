
package com.torres.billetera.controller;

import com.torres.billetera.model.Movimiento;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billetera")
public class BilleteraServlet extends HttpServlet {

    private static final BigDecimal SALDO_INICIAL =
            new BigDecimal("250.00");

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        inicializarBilletera(session);

        mostrarBilletera(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        inicializarBilletera(session);

        String tipo = request.getParameter("tipo");
        String montoTexto = request.getParameter("monto");

        BigDecimal saldo =
                (BigDecimal) session.getAttribute("saldo");

        @SuppressWarnings("unchecked")
        List<Movimiento> movimientos =
                (List<Movimiento>) session.getAttribute("movimientos");

        try {

            if (tipo == null || montoTexto == null
                    || montoTexto.trim().isEmpty()) {

                throw new IllegalArgumentException(
                        "Todos los campos son obligatorios.");
            }

            if (!tipo.equals("RECARGA")
                    && !tipo.equals("GASTO")) {

                throw new IllegalArgumentException(
                        "Seleccione un movimiento válido.");
            }

            BigDecimal monto = new BigDecimal(montoTexto.trim());

            if (monto.compareTo(BigDecimal.ZERO) <= 0) {

                throw new IllegalArgumentException(
                        "El monto debe ser mayor que cero.");
            }

            if (tipo.equals("GASTO")) {

                if (monto.compareTo(saldo) > 0) {

                    throw new IllegalArgumentException(
                            "Saldo insuficiente para realizar el gasto.");
                }

                saldo = saldo.subtract(monto);

            } else {

                saldo = saldo.add(monto);
            }

            session.setAttribute("saldo", saldo);

            movimientos.add(0, new Movimiento(tipo, monto));

            request.setAttribute("mensaje",
                    "Movimiento registrado correctamente.");

        } catch (NumberFormatException e) {

            request.setAttribute("error",
                    "Ingrese un monto numérico válido.");

        } catch (IllegalArgumentException e) {

            request.setAttribute("error", e.getMessage());
        }

        mostrarBilletera(request, response);
    }

    private void inicializarBilletera(HttpSession session) {

        if (session.getAttribute("saldo") == null) {

            session.setAttribute("saldo", SALDO_INICIAL);
        }

        if (session.getAttribute("movimientos") == null) {

            session.setAttribute("movimientos",
                    new ArrayList<Movimiento>());
        }
    }

    private void mostrarBilletera(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/billetera.jsp"
        ).forward(request, response);
    }
}
