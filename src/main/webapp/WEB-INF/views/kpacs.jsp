<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<html>
<head>
    <title>K-PAC List</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/suite.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css" />
    <script src="${pageContext.request.contextPath}/resources/js/suite.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/utils.js" defer></script>
    <script>
        var contextPath = "${pageContext.request.contextPath}";

        function initGrid() {
            if (typeof dhx === "undefined") {
                console.error("DHTMLX Suite is not loaded!");
                return;
            }

            var dataset = [
                <c:forEach var="kpac" items="${kpacs}" varStatus="status">
                <c:if test="${not empty kpac}">
                {
                    id: "${kpac.id}",
                    title: "${kpac.title}",
                    description: "${kpac.description}",
                    creationDate: parseDate("${kpac.creationDate}"),
                    delete: `<a href="#" onclick="deleteItem('${pageContext.request.contextPath}/kpacs/${fn:escapeXml(kpac.id)}'); return false;" title="Delete" class="del">🗑️</a>`
                }<c:if test="${!status.last}">,</c:if>
                </c:if>
                </c:forEach>
            ];

            dataset = dataset.filter(function(item) {
                return item != null;
            });

            const grid = new dhx.Grid("grid", {
                columns: [
                    {
                        id: "id",
                        header: [
                            { text: "ID" },
                            {
                                content: "comboFilter",
                                filterConfig: { multiselection: true }
                            }
                        ],
                        sortable: true,
                        minWidth: 150,
                        align: "center"
                    },
                    {
                        id: "title",
                        header: [
                            { text: "Title" },
                            { content: "inputFilter" }
                        ],
                        sortable: true,
                        minWidth: 150
                    },
                    {
                        id: "description",
                        header: [
                            { text: "Description" },
                            { content: "inputFilter" }
                        ],
                        sortable: true,
                        minWidth: 150
                    },
                    {
                        id: "creationDate",
                        header: [{ text: "Creation Date" }, { content: "selectFilter" }],
                        type: "date",
                        dateFormat: "%d-%m-%Y",
                        align: "center",
                        sortable: true
                    },
                    {
                        id: "delete",
                        header: "Delete",
                        sortable: false,
                        align: "center",
                        htmlEnable: true
                    }
                ],
                data: dataset,
                adjust: true,
                sortable: false,
                selection: "row",
                tooltip: false
            });
        }

        function handleFormSubmit(event) {
            const dateInput = document.querySelector("input[name='creationDate']");
            const errorElement = document.getElementById("dateError");

            if (!validateDate(dateInput.value)) {
                event.preventDefault();
                errorElement.textContent = "Incorrect date format. Please use DD-MM-YYYY.";
            } else {
                errorElement.textContent = "";
            }
        }

        window.onload = function() {
            try {
                initGrid();
            } catch(e) {
                console.error("Error initializing grid:", e);
            }
            const form = document.querySelector("form");
            form.addEventListener("submit", handleFormSubmit);
        };
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
    <h2>K-PAC List</h2>
    <form action="${pageContext.request.contextPath}/kpacs" method="post" accept-charset="UTF-8">
        Title: <input type="text" name="title" maxlength="250" required/>
        Description: <input type="text" name="description" maxlength="2000" required/>
        Creation Date: <input type="text" name="creationDate" placeholder="DD-MM-YYYY" required/>
        <div id="dateError" class="error"></div>
        <input type="submit" value="Add K-PAC"/>
    </form>
    <div id="grid"></div>
</body>
</html>
