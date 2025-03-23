<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<html>
<head>
    <title>Contents of Set: ${set.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/suite.css"/>
    <script src="${pageContext.request.contextPath}/resources/js/suite.js"></script>
    <script>
        function initGrid() {
            const grid = new dhx.Grid("grid", {
                columns: [
                    { id: "id", header: [{ text: "ID" }, { content: "comboFilter", filterConfig: { multiselection: true } }], align: "center", minWidth: 150 },
                    { id: "title", header: [{ text: "Title" }, { content: "inputFilter" }], minWidth: 150 },
                    { id: "description", header: [{ text: "Description" }, { content: "inputFilter" }], minWidth: 150 }
                ],
                adjust: true,
                sortable: true,
                selection: "row",
                tooltip: false,
                data: [
                    <c:forEach var="kpac" items="${kpacs}" varStatus="status">
                        { id: "${kpac.id}", title: "${kpac.title}", description: "${kpac.description}" }<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ]
            });
        }
        window.onload = initGrid;
    </script>
</head>
<body>
    <div class="breadcrumbs">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <c:if test="${not empty set}">
            &gt; <a href="${pageContext.request.contextPath}/sets">K-PAC Sets</a>
            &gt; <span>${set.title}</span>
        </c:if>
        <c:if test="${empty set}">
            &gt; <span>K-PACs</span>
        </c:if>
    </div>
    <h2>Contents of Set: ${set.title}</h2>
    <div id="grid"></div>
</body>
</html>