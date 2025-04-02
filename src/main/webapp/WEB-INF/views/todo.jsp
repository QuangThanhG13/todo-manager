<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Your Todo</title>
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="webjars/bootstrap-datepicker/1.0.1/css/datepicker.css" rel="stylesheet">
    <style>
        body {
            background-color: #7e57ff;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 50px;
        }

        .container {
            max-width: 550px;
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            margin: 0 auto;
        }

        .page-header {
            margin-top: 0;
            color: #5a44b6;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-control {
            height: 45px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-control:focus {
            border-color: #7e57ff;
            box-shadow: 0 0 0 0.2rem rgba(126, 87, 255, 0.25);
        }

        label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }

        .btn-success {
            background-color: #5a44b6;
            border-color: #5a44b6;
            font-weight: 600;
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 5px;
        }

        .btn-success:hover {
            background-color: #4b3999;
            border-color: #4b3999;
        }

        .text-warning {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }

        .footer {
            text-align: center;
            color: white;
            margin-top: 40px;
            font-size: 14px;
        }

        .optional-field {
            color: #6c757d;
            font-size: 13px;
            font-weight: normal;
            margin-left: 5px;
        }
    </style>
</head>
<body>
<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>

    <div class="container">
        <h2 class="page-header">
            <c:choose>
                <c:when test="${todo.id == 0}">Add New Todo</c:when>
                <c:otherwise>Edit Todo</c:otherwise>
            </c:choose>
        </h2>
        <form:form method="post" commandName="todo">
            <form:hidden path="id"/>
            <fieldset class="form-group">
                <form:label path="desc">Description</form:label>
                <form:input path="desc" type="text" class="form-control"
                    required="required" placeholder="What needs to be done?"/>
                <form:errors path="desc" cssClass="text-warning" />
            </fieldset>

            <fieldset class="form-group">
                <form:label path="targetDate">
                    Target Date
                    <span class="optional-field">(Optional)</span>
                </form:label>
                <form:input path="targetDate" type="text" class="form-control" id="targetDate"
                    placeholder="dd/mm/yyyy"/>
                <form:errors path="targetDate" cssClass="text-warning" />
            </fieldset>

            <button type="submit" class="btn btn-success btn-block">Save Todo</button>
        </form:form>
    </div>


    <%@ include file="common/footer.jspf"%>

    <script src="webjars/jquery/1.9.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="webjars/bootstrap-datepicker/1.0.1/js/bootstrap-datepicker.js"></script>

    <script>
        $(document).ready(function() {
            $('#targetDate').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            });

            // If the field is empty, set default to today
            if ($('#targetDate').val() === '') {
                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();

                $('#targetDate').datepicker('update', dd + '/' + mm + '/' + yyyy);
            }

            // When submitting the form with empty date, set to today
            $('form').submit(function() {
                if ($('#targetDate').val() === '') {
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();

                    $('#targetDate').val(dd + '/' + mm + '/' + yyyy);
                }
            });
        });
    </script>
</body>
</html>