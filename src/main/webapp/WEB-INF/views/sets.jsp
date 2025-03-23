<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<html>
<head>
    <title>K-PAC Sets</title>

    <style>
        .checkbox-container {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            max-width: 20rem;
            padding: 1rem;
            border: 0.1rem solid #ccc;
            border-radius: 0.5rem;
            background: #f9f9f9;
        }
        .checkbox-container span {
            display: flex;
            align-items: center;
            padding: 0.3rem;
            border-radius: 0.3rem;
            border: 0.1rem solid #ccc;
            background: #fff;
            cursor: pointer;
            font-size: 1rem;
            transition: background 0.2s ease-in-out;
        }
        .checkbox-container span:hover {
            background: #f0f0f0;
        }
        .checkbox-container label {
            display: flex;
            align-items: center;
            background: #f8f8f8;
            padding: 0.5rem 0.75rem;
            border-radius: 0.3rem;
            border: 0.07rem solid #ccc;
            cursor: pointer;
            font-size: 1rem;
        }
        .checkbox-container input[type="checkbox"] {
            margin-right: 0.5rem;
        }
    </style>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/suite.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css" />
    <script src="${pageContext.request.contextPath}/resources/js/suite.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/utils.js" defer></script>
    <script>
        function initGrid() {
            var grid = new dhx.Grid("grid", {
                columns: [
                    { id: "id", header: [{ text: "ID" }, { content: "comboFilter", filterConfig: { multiselection: true } }], align: "center", minWidth: 150 },
                    { id: "title", header: [{ text: "Title" }, { content: "inputFilter" }], minWidth: 150 },
                    { id: "delete", header: "Delete", htmlEnable: true, sortable: false, align: "center" }
                ],
                adjust: true,
                sortable: true,
                selection: "row",
                tooltip: false,
                data: [
                    <c:forEach var="set" items="${sets}" varStatus="status">
                        {
                            id: "${set.id}",
                            title: "${set.title}",
                            delete: `<a href="#" onclick="deleteItem('${pageContext.request.contextPath}/sets/${fn:escapeXml(set.id)}'); return false;" title="Delete" class="del">🗑️</a>`
                        }<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ]
            });

            grid.events.on("cellDblClick", function(row, column) {
                window.open("${pageContext.request.contextPath}/sets/" + row.id);
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
    <h2>K-PAC Sets</h2>
    <form action="${pageContext.request.contextPath}/sets" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" maxlength="250" required/>
        <label>Select K-PACs:</label>
        <div class="checkbox-container">
            <c:forEach var="kpac" items="${allKpacs}">
                <label for="kpac-${kpac.id}"><input type="checkbox" id="kpac-${kpac.id}" name="kpacIds" value="${kpac.id}" />&nbsp;${kpac.title}</label>
            </c:forEach>
        </div>
        <input type="submit" value="Add Set"/>
    </form>
    <div id="grid"></div>
</body>
</html>