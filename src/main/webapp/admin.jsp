<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Admin Panel</title></head>
<body>
    <h1>Admin Panel</h1>

    <h2>All Listings</h2>
    <table border="1">
        <tr><th>ID</th><th>Name</th><th>Seller</th><th>Action</th></tr>
        <c:forEach var="p" items="${products}">
            <tr>
                <td><c:out value="${p.id}" /></td>
                <td><c:out value="${p.name}" /></td>
                <td><c:out value="${p.sellerId}" /></td>
                <td>
                    <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="${p.id}">
                        <button type="submit">Remove</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <h2>All Orders</h2>
    <table border="1">
        <tr><th>ID</th><th>Buyer</th><th>Status</th><th>Total</th></tr>
        <c:forEach var="o" items="${orders}">
            <tr>
                <td><c:out value="${o.id}" /></td>
                <td><c:out value="${o.buyerId}" /></td>
                <td><c:out value="${o.status}" /></td>
                <td><c:out value="${o.totalAmount}" /></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
