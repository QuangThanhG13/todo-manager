<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todos for <c:out value="${name}" /></title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #6b6bff;
            background-image: linear-gradient(135deg, #6b6bff 0%, #8989ff 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
        }

        .container {
            background-color: rgba(245, 245, 250, 0.95);
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            padding: 2rem;
            width: 100%;
            max-width: 800px;
            margin-bottom: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 1rem;
        }

        h1 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
        }

        .user-info {
            background-color: #6b6bff;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 0;
            color: #888;
        }

        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 0.5rem;
            color: #666;
        }

        .empty-state p {
            font-size: 16px;
            color: #888;
        }

        .btn-edit {
      border: 1px solid #6366f1;
      color: #6366f1;
      margin-right: 5px;
    }

    .btn-delete {
      border: 1px solid #ef4444;
      color: #ef4444;
    }

        .btn {
            background-color: #6b6bff;
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #5959ff;
        }

        .add-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 1.1rem;
            width: 200px;
            margin: 2rem auto 0;
        }

        .footer {
            text-align: center;
            margin-top: auto;
            padding: 1rem 0;
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
        }

        caption {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: #555;
            text-align: left;
            font-weight: 500;
        }

        th {
            background-color: #f5f5f5;
            color: #555;
            font-weight: 600;
            text-align: left;
            padding: 1rem;
            border-bottom: 2px solid #eee;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        tbody tr:hover {
            background-color: #f9f9f9;
        }

        .action-links {
            display: flex;
            gap: 0.5rem;
            justify-content: center; /* Align items horizontally */
        }

        .action-links a {
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.2s;
            display: inline-block; /* Ensure they respect width/height settings */
            width: auto; /* Adjust as needed */
            text-align: center; /* Center text within the link */
        }

        .edit-link {
            color: #6b6bff;
            border: 1px solid #6b6bff;
        }

        .edit-link:hover {
            background-color: #6b6bff;
            color: white;
        }

        .delete-link {
            color: #ff6b6b;
            border: 1px solid #ff6b6b;
        }

        .delete-link:hover {
            background-color: #ff6b6b;
            color: white;
        }

        /* Completed Status Styles */
        .completed-true {
            color: #4CAF50;
            font-weight: 500;
        }

        .completed-false {
            color: #F44336;
            font-weight: 500;
        }

        /* Toggle Switch Styles */
        .toggle-container {
            display: flex;
            justify-content: center;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 30px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 22px;
            width: 22px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .toggle-slider {
            background-color: #4CAF50;
        }

        input:focus + .toggle-slider {
            box-shadow: 0 0 1px #4CAF50;
        }

        input:checked + .toggle-slider:before {
            transform: translateX(30px);
        }
    </style>
    <script>
        function updateStatus(todoId, currentStatus) {
            // Create form with todo id and new status (toggled)
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'update-todo-status';

            // Todo ID
            const idField = document.createElement('input');
            idField.type = 'hidden';
            idField.name = 'id';
            idField.value = todoId;
            form.appendChild(idField);

            // New Status (opposite of current)
            const statusField = document.createElement('input');
            statusField.type = 'hidden';
            statusField.name = 'completed';
            statusField.value = !currentStatus;
            form.appendChild(statusField);

            // Submit form
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>

<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>



    <!-- Main Todo List Page -->
    <div class="container">
        <div class="header">
            <h1>Your Todos</h1>
            <div class="user-info">Hello, <c:out value="${name}" /></div>
        </div>

        <!-- Use JSTL to check if there are todos -->
        <c:choose>
            <c:when test="${not empty todos}">
                <table>
                    <caption>Your Todos are</caption>
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Date</th>
                            <th>Completed</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${todos}" var="todo">
                            <tr>
                                <td><c:out value="${todo.desc}" /></td>
                                <td><fmt:formatDate value="${todo.targetDate}" pattern="dd/MM/yyyy" /></td>
                                <td class="toggle-container">
                                    <label class="toggle-switch">
                                        <input type="checkbox"
                                               <c:if test="${todo.done}">checked</c:if>
                                               onchange="updateStatus(${todo.id}, ${todo.done})">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </td>
                                <td>
                                    <button class="btn btn-edit" onclick="location.href='/update-todo?id=${todo.id}'">Edit</button>
                                    <button class="btn btn-delete" onclick="location.href='/delete-todo?id=${todo.id}'">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>No todos yet</h3>
                    <p>Add your first todo to get started</p>
                </div>
            </c:otherwise>
        </c:choose>

        <a class="btn add-btn" href="add-todo">
            <span>+</span> Add New Todo
        </a>
    </div>
      <%@ include file="common/footer.jspf"%>

</body>
</html>