<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Todo</title>
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="webjars/bootstrap-datepicker/1.0.1/css/datepicker.css" rel="stylesheet">
    <link href="<c:url value="/resources/static/css/theme.css" />" rel="stylesheet">
    <style>
        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 50px;
        }

        .container {
            max-width: 550px;
            background-color: var(--container-bg);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 25px var(--shadow-color);
            margin: 0 auto;
        }

        .page-header {
            margin-top: 0;
            color: var(--header-color);
            font-weight: 600;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-control {
            height: 45px;
            border: 1px solid var(--input-border);
            border-radius: 5px;
            font-size: 16px;
            background-color: var(--container-bg);
            color: var(--text-color);
        }

        .form-control:focus {
            border-color: var(--btn-bg);
            box-shadow: 0 0 0 0.2rem var(--input-focus-shadow);
        }

        label {
            font-weight: 600;
            color: var(--label-color);
            margin-bottom: 8px;
        }

        .btn-success {
            background-color: var(--btn-bg);
            border-color: var(--btn-bg);
            font-weight: 600;
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 5px;
            color: white;
        }

        .btn-success:hover {
            background-color: var(--btn-hover-bg);
            border-color: var(--btn-hover-bg);
        }

        .text-warning {
            color: var(--error-color);
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }

        .footer {
            text-align: center;
            color: var(--footer-color);
            margin-top: 40px;
            font-size: 14px;
        }

        .optional-field {
            color: var(--optional-color);
            font-size: 13px;
            font-weight: normal;
            margin-left: 5px;
        }
    </style>
</head>
<body>
<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>
<%@ include file="common/theme-toggle.jspf"%>

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

    <script src="webjars/jquery/1.9.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="webjars/bootstrap-datepicker/1.0.1/js/bootstrap-datepicker.js"></script>
    <script src="<c:url value="/resources/static/js/theme.js" />"></script>

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