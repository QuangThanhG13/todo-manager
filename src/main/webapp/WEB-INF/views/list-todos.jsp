<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todos for <c:out value="${name}" /></title>
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value="/resources/static/css/theme.css" />" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--bg-gradient-start);
            background-image: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-end) 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
            color: var(--text-color);
        }

        .container {
            background-color: var(--container-bg);
            border-radius: 16px;
            box-shadow: 0 12px 25px var(--shadow-color);
            padding: 2rem;
            width: 100%;
            max-width: 900px;
            margin-bottom: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 1rem;
        }

        h1 {
            color: var(--text-color);
            font-size: 28px;
            font-weight: 700;
        }

        .user-info {
            background-color: #7e57ff;
            color: white;
            padding: 10px 15px;
            border-radius: 25px;
            font-weight: bold;
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
            animation: pulse 2s infinite;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 0;
            color: var(--text-muted);
        }

        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 0.5rem;
            color: var(--text-secondary);
        }

        .empty-state p {
            font-size: 16px;
            color: var(--text-muted);
        }

        .btn-edit {
            border: 1px solid var(--edit-color);
            color: var(--edit-color);
            margin-right: 5px;
        }

        .btn-delete {
            border: 1px solid var(--delete-color);
            color: var(--delete-color);
        }

        .btn {
            background-color: var(--btn-color);
            color: var(--btn-text);
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
            filter: brightness(1.1);
        }

        .add-btn {
            background: linear-gradient(to right, #7e57ff, #6a4cbf);
            color: white;
            padding: 15px 25px;
            border-radius: 50px;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            margin: 30px auto;
            display: block;
            width: 200px;
            text-align: center;
            animation: bounce 1s infinite alternate;
            transition: transform 0.3s;
        }

        .add-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 15px rgba(0,0,0,0.3);
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
            background-color: var(--table-bg);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px var(--shadow-color);
        }

        caption {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: var(--text-secondary);
            text-align: left;
            font-weight: 500;
        }

        th {
            background-color: var(--table-header-bg);
            color: var(--text-secondary);
            font-weight: 600;
            text-align: left;
            padding: 1rem;
            border-bottom: 2px solid var(--table-border);
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid var(--table-border);
            color: var(--text-color);
        }

        tbody tr:hover {
            background-color: var(--table-hover);
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
            background-color: var(--toggle-bg);
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
            background-color: var(--toggle-handle);
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .toggle-slider {
            background-color: var(--toggle-checked);
        }

        input:focus + .toggle-slider {
            box-shadow: 0 0 1px var(--toggle-checked);
        }

        input:checked + .toggle-slider:before {
            transform: translateX(30px);
        }

        /* Pagination Styles */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
            gap: 0.5rem;
        }

        .pagination a, .pagination span {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            text-decoration: none;
            color: var(--btn-color);
            background-color: var(--pagination-bg);
            border: 1px solid var(--btn-color);
            transition: all 0.2s;
        }

        .pagination a:hover {
            background-color: var(--btn-color);
            color: var(--btn-text);
        }

        .pagination .current-page {
            background-color: var(--btn-color);
            color: var(--btn-text);
            font-weight: bold;
        }

        .pagination .disabled {
            color: var(--text-muted);
            border-color: var(--border-color);
            cursor: not-allowed;
        }

        .pagination .disabled:hover {
            background-color: var(--pagination-bg);
            color: var(--text-muted);
        }

        /* Completed styles */
        .todo-item {
            transition: all 0.3s ease;
        }

        .todo-completed {
            background-color: rgba(76, 175, 80, 0.1);
        }

        .todo-completed td {
            text-decoration: line-through;
            opacity: 0.7;
        }

        .todo-completed td:nth-child(3), 
        .todo-completed td:nth-child(4) {
            text-decoration: none;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-align: center;
            min-width: 100px;
        }

        .status-pending {
            background-color: #e2e3fc;
            color: #4a4de7;
            border: 1px solid rgba(74, 77, 231, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .status-pending::before {
            content: '';
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #4a4de7;
            animation: pulse-blue 1.5s infinite;
        }

        @keyframes pulse-blue {
            0% { opacity: 0.6; transform: scale(0.9); }
            50% { opacity: 1; transform: scale(1.1); }
            100% { opacity: 0.6; transform: scale(0.9); }
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        /* Filter controls */
        .filter-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .filter-buttons {
            display: flex;
            gap: 10px;
        }

        .filter-btn {
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid var(--border-color);
            background: transparent;
            color: var(--text-color);
            cursor: pointer;
            transition: all 0.2s;
            font-weight: 500;
        }

        .filter-btn.active {
            background: linear-gradient(to right, #7e57ff, #6a4cbf);
            color: white;
            border-color: transparent;
        }

        .search-container {
            position: relative;
            width: 250px;
        }

        .search-input {
            width: 100%;
            padding: 10px 15px 10px 35px;
            border-radius: 20px;
            border: 1px solid var(--border-color);
            background-color: var(--container-bg);
            color: var(--text-color);
            font-size: 14px;
        }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        /* Animations */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        @keyframes bounce {
            0% { transform: translateY(0); }
            100% { transform: translateY(-5px); }
        }

        /* Completed checkmark animation */
        .checkmark {
            width: 25px;
            height: 25px;
            border-radius: 50%;
            display: block;
            stroke-width: 2;
            stroke: #fff;
            stroke-miterlimit: 10;
            box-shadow: inset 0px 0px 0px #4BB543;
            animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s both;
            position: relative;
            margin: 0 auto;
            top: 5px;
        }

        .checkmark__circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            stroke-width: 2;
            stroke-miterlimit: 10;
            stroke: #4BB543;
            fill: none;
            animation: stroke .6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
        }

        .checkmark__check {
            transform-origin: 50% 50%;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            animation: stroke .3s cubic-bezier(0.65, 0, 0.45, 1) .8s forwards;
        }

        @keyframes stroke {
            100% {
                stroke-dashoffset: 0;
            }
        }

        @keyframes scale {
            0%, 100% {
                transform: none;
            }
            50% {
                transform: scale3d(1.1, 1.1, 1);
            }
        }

        @keyframes fill {
            100% {
                box-shadow: inset 0px 0px 0px 30px #4BB543;
            }
        }

        /* Change status button styles */
        .status-change-btn {
            margin-top: 8px;
            padding: 6px 12px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 500;
            font-size: 12px;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .mark-complete-btn {
            background: linear-gradient(to right, #4ecdc4, #2cbfc7);
            color: white;
        }

        .mark-complete-btn:hover {
            background: linear-gradient(to right, #2cbfc7, #2ba6a9);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .mark-progress-btn {
            background: linear-gradient(to right, #8e44ad, #9b59b6);
            color: white;
        }

        .mark-progress-btn:hover {
            background: linear-gradient(to right, #7d3c96, #8e44ad);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        /* Updated styles for the status container */
        .status-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 5px;
        }

        /* Status message styles */
        .status-message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            position: relative;
            animation: slideDown 0.5s ease-out forwards;
        }

        .status-message.success {
            background-color: #d4edda;
            color: #155724;
            border-left: 5px solid #28a745;
        }

        .status-message.info {
            background-color: #d1ecf1;
            color: #0c5460;
            border-left: 5px solid #17a2b8;
        }

        .status-message-close {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
            color: inherit;
            opacity: 0.7;
        }

        .status-message-close:hover {
            opacity: 1;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
    <script>
        function updateStatus(todoId, currentStatus) {
            try {
                console.log("Starting update status process");
                console.log("Parameters:", {todoId, currentStatus, currentStatusType: typeof currentStatus});
                
                // Create form
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'update-todo-status';
                form.style.display = 'none';
                console.log("Form created:", form);
                
                // Todo ID field
                const idField = document.createElement('input');
                idField.type = 'hidden';
                idField.name = 'id';
                idField.value = todoId;
                form.appendChild(idField);
                console.log("ID field added:", idField);
                
                // Status field - invert current status
                const statusField = document.createElement('input');
                statusField.type = 'hidden';
                statusField.name = 'completed';
                // Ensure value is a string "true" or "false" for proper parameter binding
                statusField.value = (currentStatus === "true") ? "false" : "true";
                form.appendChild(statusField);
                console.log("Status field added with value:", statusField.value);
                
                // Add form to body and submit
                document.body.appendChild(form);
                console.log("Form appended to document, submitting now");
                form.submit();
                console.log("Form submitted");
            } catch(e) {
                console.error('Error in updateStatus function:', e);
                console.error('Error stack:', e.stack);
                alert('Lỗi khi cập nhật trạng thái: ' + e.message);
            }
        }

        // Filter functions
        function filterTodos(filter) {
            // Update active button
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            document.getElementById('filter-' + filter).classList.add('active');
            
            // Show/hide todos based on filter
            const rows = document.querySelectorAll('.todo-item');
            rows.forEach(row => {
                const isCompleted = row.classList.contains('todo-completed');
                
                if (filter === 'all') {
                    row.style.display = '';
                } else if (filter === 'active' && isCompleted) {
                    row.style.display = 'none';
                } else if (filter === 'completed' && !isCompleted) {
                    row.style.display = 'none';
                } else {
                    row.style.display = '';
                }
            });
        }

        // Search function
        function searchTodos() {
            const searchText = document.getElementById('todo-search').value.toLowerCase();
            const rows = document.querySelectorAll('.todo-item');
            
            rows.forEach(row => {
                const todoText = row.querySelector('td:first-child').textContent.toLowerCase();
                if (todoText.includes(searchText)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Execute when document is ready
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize with "all" filter active
            document.getElementById('filter-all').classList.add('active');
            
            // Add event listener to search input
            document.getElementById('todo-search').addEventListener('input', searchTodos);
        });

        // Status message handling
        function closeStatusMessage() {
            document.getElementById('status-message').style.display = 'none';
        }
    </script>
</head>
<body>

<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>
<%@ include file="common/theme-toggle.jspf"%>

    <!-- Main Todo List Page -->
    <div class="container">
        <div class="header">
            <h1>Your Todos</h1>
            <div class="user-info">
                Hello, <c:out value="${name}" default="User" />
            </div>
        </div>

        <!-- Status Message (if available) -->
        <c:if test="${not empty statusMessage}">
            <div id="status-message" class="status-message ${statusType}">
                ${statusMessage}
                <span class="status-message-close" onclick="closeStatusMessage()">×</span>
            </div>
        </c:if>

        <!-- Use JSTL to check if there are todos -->
        <c:choose>
            <c:when test="${not empty todos}">
                <!-- Filter Controls -->
                <div class="filter-controls">
                    <div class="filter-buttons">
                        <button id="filter-all" class="filter-btn" onclick="filterTodos('all')">All</button>
                        <button id="filter-active" class="filter-btn" onclick="filterTodos('active')">Active</button>
                        <button id="filter-completed" class="filter-btn" onclick="filterTodos('completed')">Completed</button>
                    </div>
                    <div class="search-container">
                        <span class="search-icon">🔍</span>
                        <input type="text" id="todo-search" class="search-input" placeholder="Search todos...">
                    </div>
                </div>

                <table>
                    <caption>Your Todos are</caption>
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${todos}" var="todo">
                            <tr class="todo-item ${todo.done ? 'todo-completed' : ''}">
                                <td><c:out value="${todo.desc}" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty todo.targetDate}">
                                            <c:out value="${todo.targetDate}" />
                                        </c:when>
                                        <c:otherwise>
                                            No date set
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="toggle-container">
                                    <div class="status-container">
                                        <c:choose>
                                            <c:when test="${todo.done}">
                                                <div class="status-badge status-completed">
                                                    <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                                                        <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                                                        <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                                                    </svg>
                                                    Completed
                                                </div>
                                                <button class="status-change-btn mark-progress-btn" onclick="window.location.href='update-status?id=${todo.id}'; return false;">
                                                    <span>↩</span> Mark as In Progress
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="status-badge status-pending">In Progress</div>
                                                <button class="status-change-btn mark-complete-btn" onclick="window.location.href='update-status?id=${todo.id}'; return false;">
                                                    <span>✓</span> Mark as Completed
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <button class="btn btn-edit" onclick="location.href='/update-todo?id=${todo.id}'">Edit</button>
                                    <button class="btn btn-delete" onclick="location.href='/delete-todo?id=${todo.id}'">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination Navigation -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:choose>
                            <c:when test="${currentPage > 0}">
                                <a href="list-todos?page=${currentPage - 1}">&laquo; Previous</a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled">&laquo; Previous</span>
                            </c:otherwise>
                        </c:choose>
                        
                        <c:forEach begin="0" end="${totalPages - 1}" var="page">
                            <c:choose>
                                <c:when test="${page == currentPage}">
                                    <span class="current-page">${page + 1}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="list-todos?page=${page}">${page + 1}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        
                        <c:choose>
                            <c:when test="${currentPage < totalPages - 1}">
                                <a href="list-todos?page=${currentPage + 1}">Next &raquo;</a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled">Next &raquo;</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <!-- Todo Stats -->
                <div style="margin-top: 20px; text-align: center; font-size: 14px; color: var(--text-secondary);">
                    <c:set var="totalTodos" value="${0}" />
                    <c:set var="completedTodos" value="${0}" />
                    
                    <c:forEach items="${todos}" var="todo">
                        <c:set var="totalTodos" value="${totalTodos + 1}" />
                        <c:if test="${todo.done}">
                            <c:set var="completedTodos" value="${completedTodos + 1}" />
                        </c:if>
                    </c:forEach>
                    
                    <!-- Calculate completion percentage based on completed todos count -->
                    <c:set var="completionPercentage" value="${totalTodos > 0 ? (completedTodos * 100) / totalTodos : 0}" />
                    <div>Completed ${completedTodos} of ${totalTodos} todos (${completionPercentage}%)</div>
                    <div class="progress" style="height: 8px; margin-top: 8px; border-radius: 4px; background-color: var(--border-color);">
                        <div class="progress-bar" style="height: 100%; width: ${completionPercentage}%; background: linear-gradient(to right, #7e57ff, #6a4cbf); border-radius: 4px;"></div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>No todos yet</h3>
                    <p>Add your first todo to get started</p>
                </div>
            </c:otherwise>
        </c:choose>

        <a class="btn add-btn" href="add-todo">
            <span style="font-size: 20px; margin-right: 8px;">+</span> Add New Todo
        </a>
    </div>
    
    <script src="webjars/jquery/1.9.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="<c:url value="/resources/static/js/theme.js" />"></script>
</body>
</html>