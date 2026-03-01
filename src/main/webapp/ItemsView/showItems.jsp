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
            /* COOL COLOR GRADIENT: Deep Teal to Arctic Blue */
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
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
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            padding: 40px;
            max-width: 1200px;
            width: 100%;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: margin-right 0.4s ease;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.8rem;
            font-weight: 700;
            /* COOL TEXT GRADIENT */
            background: linear-gradient(45deg, #2c5364, #00d2ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Table styles */
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 40px;
            overflow: hidden;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(44, 83, 100, 0.1);
        }

        /* COOL HEADER: Teal Blue */
        thead { background: linear-gradient(135deg, #2c5364 0%, #203a43 100%); }

        thead tr th {
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 20px 15px;
            text-align: left;
        }

        tbody tr { transition: all 0.3s ease; border-bottom: 1px solid rgba(0, 0, 0, 0.05); }
        tbody tr:hover { background-color: rgba(0, 210, 255, 0.05); transform: translateY(-2px); }
        tbody td { padding: 18px 15px; color: #445; }

        /* Action Buttons */
        td a {
            display: inline-block;
            padding: 8px 18px;
            margin-right: 5px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.85rem;
            transition: 0.3s;
        }
        /* Edit Button: Ocean Blue */
        td a:first-child { background: #3a7bd5; color: white; }
        /* Delete Button: Muted Coral (to stay visible but not clash) */
        td a:last-child { background: #e67e22; color: white; }

        .button-wrapper {
            display: flex;
            justify-content: center;
            width: 100%;
            margin-top: 20px;
        }

        .add-btn {
            display: inline-block;
            padding: 16px 45px;
            background: linear-gradient(45deg, #2c5364, #3a7bd5);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            box-shadow: 0 8px 25px rgba(44, 83, 100, 0.4);
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        .add-btn:hover { transform: translateY(-3px); box-shadow: 0 12px 30px rgba(58, 123, 213, 0.5); }

        /* NOTIFICATIONS */
		.msg-container {
		    position: fixed;
		    top: 25px;
		    left: 25px;
		    padding: 15px 30px;
		    border-radius: 8px;
		    color: white;
		    font-weight: 600;
		    z-index: 9999;
		    box-shadow: 0 10px 20px rgba(0,0,0,0.3);
		    animation: slideIn 0.5s ease-out;
		    display: flex;
		    align-items: center;
		    min-width: 250px;
		}
        
        /* Side Panel Styling */
        .side-panel {
            height: 100%; width: 0; position: fixed; z-index: 1000;
            top: 0; right: 0; background-color: #fff; overflow-x: hidden;
            transition: 0.4s; box-shadow: -5px 0 15px rgba(0,0,0,0.1); padding-top: 60px;
        }
        .side-panel a {
            display: block; padding: 15px 25px; text-decoration: none;
            color: #333; margin: 5px 20px; border-radius: 8px; background: #f0f4f7;
        }
        .side-panel a:hover { background: #2c5364; color: white; }

        .toggle-btn {
            position: fixed; top: 20px; right: 20px; z-index: 1100;
            background: white; color: #2c5364; border: none;
            width: 45px; height: 45px; border-radius: 50%; cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2); font-size: 1.2rem;
        }

        @keyframes slideIn { from { transform: translateX(-100%); } to { transform: translateX(0); } }
    </style>
</head>
<body>
<div id="sidePanel" class="side-panel">
    <button style="position:absolute; top:10px; right:20px; background:none; border:none; font-size:2rem; cursor:pointer;" onclick="togglePanel()"></button>
    <h2 style="margin-left:20px; margin-bottom:20px;">Menu</h2>
    <a href="${pageContext.request.contextPath}/UserController?action=changePasswordView">Change Password</a>
    <a href="${pageContext.request.contextPath}/UserController?action=logout">Logout</a>
    <a href="${pageContext.request.contextPath}/UserController?action=deleteAccount">Delete Account</a>
</div>

<button class="toggle-btn" onclick="togglePanel()">☰</button>

<div class="layer" id="mainLayer">
    <h1>Inventory</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>InStock</th>
                <th>Owner</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Items> items = (List<Items>) session.getAttribute("allItems");
                if(items != null && !items.isEmpty()){
                    for(Items item : items){
            %>
            <tr>
                <td><strong>#<%=item.getId() %></strong></td>
                <td><%=item.getName() %></td>
                <td>$<%=item.getPrice() %></td>
                <td><%=item.getTotalNumbers() %></td>
                <td><%=item.getUserName() %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/ItemsController?action=getItem&id=<%=item.getId()%>&actiontype=updateItem">Edit</a>
                    <a href="${pageContext.request.contextPath}/ItemsController?action=getItem&id=<%=item.getId()%>&actiontype=removeItem">Delete</a>
                </td>
            </tr>
            <% 
                    } 
                } else { 
            %>
            <tr>
                <td colspan="6" style="text-align:center; padding: 30px; color:#2c5364;">No items available.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
    
    <div class="button-wrapper">
        <a href="${pageContext.request.contextPath}/ItemsView/addItems.jsp" class="add-btn">Add New Item</a>
    </div>
    <% 
        String flashMsg = (String) session.getAttribute("flashMessage");
        String flashType = (String) session.getAttribute("flashType");
        if (flashMsg != null) { 
            String bgColor = "linear-gradient(45deg, #27ae60, #2ecc71)"; // Default Green
            String icon = "✓ ";
            if ("error".equals(flashType)) {
                bgColor = "linear-gradient(45deg, #c0392b, #e74c3c)"; // Red
                icon = "⚠ ";
            }
    %>
        <div class="msg-container" id="notif" style="background: <%= bgColor %>;">
            <%= icon %> <%= flashMsg %>
        </div>
    <% 
        session.removeAttribute("flashMessage"); 
        session.removeAttribute("flashType");
        }else { }
    %>
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

const notif = document.getElementById('notif');
if (notif) {
    setTimeout(() => {
        notif.style.opacity = "0";
        notif.style.transition = "0.5s";
        setTimeout(() => notif.remove(), 500);
    }, 4000); 
}
</script>
</body>
</html>