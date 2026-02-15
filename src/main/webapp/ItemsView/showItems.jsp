

<%@page import="Items.model.Items"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show Items</title>
    <style type="text/css">
        /* Reset and base styles */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 20px;
        }

        /* Layer container */
        .layer {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            max-width: 1200px;
            width: 100%;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: margin-right 0.4s ease;
        }

        /* Table heading */
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2.8rem;
            font-weight: 700;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Table styles */
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 40px;
            overflow: hidden;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        thead { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }

        thead tr th {
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.95rem;
            padding: 20px 15px;
            text-align: left;
            border-bottom: none;
        }

        tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.5s ease forwards;
        }

        tbody tr:nth-child(even) { background-color: rgba(102, 126, 234, 0.05); }
        tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        tbody td { padding: 18px 15px; color: #555; font-size: 0.95rem; }
        td strong { color: #333; font-weight: 600; font-size: 1rem; }

        td a {
            display: inline-block;
            padding: 8px 18px;
            margin-right: 10px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td a:first-child {
            background: linear-gradient(45deg, #4CAF50, #8BC34A);
            color: white;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        }
        td a:first-child:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
        }

        td a:last-child {
            background: linear-gradient(45deg, #f44336, #FF9800);
            color: white;
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
        }
        td a:last-child:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(244, 67, 54, 0.4);
        }

        /* Add button */
        .f { display: block; margin: 0 auto; padding: 0; border: none; background: none; cursor: pointer; }
        .f a {
            display: inline-block;
            padding: 18px 40px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
        }
        .f a:hover { transform: translateY(-3px); box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6); }

        /* Scrollbar styling */
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: rgba(0, 0, 0, 0.05); border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: linear-gradient(45deg, #667eea, #764ba2); border-radius: 10px; }

        /* Side Panel Styles */
        .side-panel {
            height: 100%;
            width: 0;
            position: fixed;
            z-index: 1000;
            top: 0;
            right: 0;
            background-color: #fff;
            overflow-x: hidden;
            transition: 0.4s;
            box-shadow: -2px 0 10px rgba(0,0,0,0.3);
            padding-top: 60px;
            border-left: 1px solid rgba(0,0,0,0.1);
        }
        .side-panel h2 { margin-left: 20px; margin-bottom: 30px; color: #333; }
        .side-panel a {
            display: block;
            padding: 15px 25px;
            text-decoration: none;
            font-size: 1rem;
            color: #fff;
            transition: 0.3s;
            border-radius: 8px;
            margin: 5px 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            text-align: center;
        }
        .side-panel a:hover { background: linear-gradient(135deg, #764ba2, #667eea); }
        .close-btn {
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 2rem;
            border: none;
            background: none;
            cursor: pointer;
        }
        .toggle-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1100;
            font-size: 1.5rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        /* Animation for table rows */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        tbody tr:nth-child(1) { animation-delay: 0.1s; }
        tbody tr:nth-child(2) { animation-delay: 0.2s; }
        tbody tr:nth-child(3) { animation-delay: 0.3s; }
        tbody tr:nth-child(n+4) { animation-delay: 0.4s; }
    </style>
</head>
<body>

<!-- Toggle Side Panel -->
<div id="sidePanel" class="side-panel">
    <button class="close-btn" onclick="togglePanel()">×</button>
    <h2>User Settings</h2>
    <a href="${pageContext.request.contextPath}//UsersView/changePassword.jsp">Change Password</a>
    <a href="${pageContext.request.contextPath}/UserController?action=logout">Logout</a>
    <a href="${pageContext.request.contextPath}/UserController?action=deleteAccount">Delete Account</a>
</div>

<!-- Toggle Button -->
<button id="toggleBtn" class="toggle-btn" onclick="togglePanel()">☰</button>

<!-- Main Table Layer -->
<div class="layer" id="mainLayer">
    <table>
        <h1>Items</h1>
        <thead>
            <tr>
                <th>ID</th>
                <th>NAME</th>
                <th>PRICE</th>
                <th>TOTAL_NUMBER</th>
                <th>Who Added This</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Items> items = (List<Items>) request.getAttribute("allItems");
                if(items != null && !items.isEmpty()){
                    for(Items item : items){
            %>
            <tr>
                <td><%=item.getId() %></td>
                <td><%=item.getName() %></td>
                <td><%=item.getPrice() %></td>
                <td><%=item.getTotalNumbers() %></td>
                <td><%=item.getUserId() %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/ItemsController?action=getItem&id=<%=item.getId()%>">Update</a>
                    <a href="${pageContext.request.contextPath}/ItemsController?action=removeItem&id=<%=item.getId()%>">Delete</a>
                </td>
            </tr>
            <% } } %>
        </tbody>
    </table>
    
    <c:if test="${not empty sessionScope.flashMessage}">
		    <div id="flashMessage"
		         class="flash ${sessionScope.flashType}">
		        ${sessionScope.flashMessage}
		    </div>
		
		    <script>
		        setTimeout(() => {
		            const msg = document.getElementById("flashMessage");
		            if (msg) {
		                msg.style.opacity = "0";
		                setTimeout(() => msg.style.display = "none", 500);
		            }
		        }, 3000);
		    </script>
		
		    <!-- ❌ REMOVE immediately so it appears ONCE -->
		    <c:remove var="flashMessage" scope="session"/>
		    <c:remove var="flashType" scope="session"/>
		</c:if>

    <button class="f">
        <a href="${pageContext.request.contextPath}/ItemsView/addItems.jsp">Add Item</a>
    </button>
</div>

<script>
function togglePanel() {
    const panel = document.getElementById("sidePanel");
    const layer = document.getElementById("mainLayer");
    if(panel.style.width === "250px") {
        panel.style.width = "0";
        layer.style.marginRight = "0";
    } else {
        panel.style.width = "250px";
        layer.style.marginRight = "250px";
    }
}
</script>
</body>
</html>
