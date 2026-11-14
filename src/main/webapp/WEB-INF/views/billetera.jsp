<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Mi Billetera Digital</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        body {
            background: #f1f5f9;
            font-family: Arial, sans-serif;
        }

        .navbar {
            background: #172b4d;
        }

        .card {
            border: none;
            border-radius: 14px;
        }

        .saldo {
            font-size: 36px;
            font-weight: bold;
            color: #198754;
        }

        .titulo {
            font-weight: bold;
            color: #172b4d;
        }

        .btn-principal {
            background: #2864dc;
            color: white;
            border: none;
        }

        .btn-principal:hover {
            background: #174bb5;
            color: white;
        }

        .recarga {
            background: #d1fae5;
            color: #047857;
            font-weight: bold;
        }

        .gasto {
            background: #fee2e2;
            color: #b91c1c;
            font-weight: bold;
        }

        .contenedor {
            max-width: 1100px;
            margin: auto;
        }

    </style>

</head>

<body>

<!-- BARRA SUPERIOR -->

<nav class="navbar navbar-dark shadow-sm">

    <div class="container">

        <span class="navbar-brand fw-bold">
            💳 Mi Billetera Digital
        </span>

        <span class="text-white">
            JSP + Servlet
        </span>

    </div>

</nav>


<div class="container contenedor mt-4">

    <div class="row g-4">

        <!-- SALDO DISPONIBLE -->

        <div class="col-md-6">

            <div class="card shadow-sm p-4">

                <h6 class="text-secondary">
                    SALDO DISPONIBLE
                </h6>

                <div class="saldo">

                    S/ <c:out value="${saldo}"/>

                </div>

                <small class="text-secondary">

                    <c:out value="${movimientos.size()}"/>
                    movimientos registrados

                </small>

            </div>

        </div>


        <!-- INFORMACION -->

        <div class="col-md-6">

            <div class="card shadow-sm p-4 h-100">

                <h5 class="titulo">
                    Información de la billetera
                </h5>

                <p class="text-secondary mb-2">

                    Administra tus recargas y gastos
                    desde una sola plataforma.

                </p>

                <div class="alert alert-primary mb-0">

                    Los datos se conservan durante
                    la sesión HTTP.

                </div>

            </div>

        </div>


        <!-- HISTORIAL -->

        <div class="col-md-7">

            <div class="card shadow-sm p-4">

                <h5 class="titulo mb-3">
                    Movimientos recientes
                </h5>

                <c:choose>

                    <c:when test="${empty movimientos}">

                        <div class="alert alert-light text-center">

                            Aún no hay movimientos registrados.

                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="table-responsive">

                            <table class="table align-middle">

                                <thead class="table-dark">

                                    <tr>

                                        <th>Tipo</th>
                                        <th>Monto</th>
                                        <th>Fecha</th>

                                    </tr>

                                </thead>

                                <tbody>

                                    <c:forEach var="movimiento"
                                               items="${movimientos}">

                                        <tr>

                                            <td>

                                                <c:choose>

                                                    <c:when test="${movimiento.tipo == 'RECARGA'}">

                                                        <span class="badge recarga">
                                                            Recarga
                                                        </span>

                                                    </c:when>

                                                    <c:otherwise>

                                                        <span class="badge gasto">
                                                            Gasto
                                                        </span>

                                                    </c:otherwise>

                                                </c:choose>

                                            </td>

                                            <td class="fw-bold">

                                                S/ <c:out value="${movimiento.monto}"/>

                                            </td>

                                            <td>

                                                <small>
                                                    <c:out value="${movimiento.fechaFormateada}"/>
                                                </small>

                                            </td>

                                        </tr>

                                    </c:forEach>

                                </tbody>

                            </table>

                        </div>

                    </c:otherwise>

                </c:choose>

            </div>

        </div>


        <!-- FORMULARIO -->

        <div class="col-md-5">

            <div class="card shadow-sm p-4">

                <h5 class="titulo mb-3">
                    Nuevo movimiento
                </h5>


                <!-- MENSAJE DE EXITO -->

                <c:if test="${not empty mensaje}">

                    <div class="alert alert-success">

                        <c:out value="${mensaje}"/>

                    </div>

                </c:if>


                <!-- MENSAJE DE ERROR -->

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">

                        <c:out value="${error}"/>

                    </div>

                </c:if>


                <form action="${pageContext.request.contextPath}/billetera"
                      method="POST">

                    <div class="mb-3">

                        <label class="form-label">
                            Tipo de movimiento
                        </label>

                        <select name="tipo"
                                class="form-select"
                                required>

                            <option value="RECARGA">
                                Recarga
                            </option>

                            <option value="GASTO">
                                Gasto
                            </option>

                        </select>

                    </div>


                    <div class="mb-3">

                        <label class="form-label">
                            Monto (S/)
                        </label>

                        <input type="number"
                               name="monto"
                               class="form-control"
                               placeholder="Ejemplo: 100.00"
                               min="0.01"
                               step="0.01"
                               required>

                    </div>


                    <button type="submit"
                            class="btn btn-principal w-100">

                        Registrar movimiento

                    </button>

                </form>

            </div>

        </div>

    </div>


    <footer class="text-center text-secondary mt-4 mb-4">

        Billetera Digital | Evaluación T1 |
        Soluciones Web y Aplicaciones Distribuidas

    </footer>

</div>

</body>

</html>