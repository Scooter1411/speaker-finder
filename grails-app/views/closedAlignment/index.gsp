

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'closedAlignment.label', default: 'ClosedAlignment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-closedAlignment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-closedAlignment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="rpre" title="${message(code: 'closedAlignment.rpre.label', default: 'Rpre')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'closedAlignment.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'closedAlignment.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'closedAlignment.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="lastModifiedBy" title="${message(code: 'closedAlignment.lastModifiedBy.label', default: 'Last Modified By')}" />
					
						<g:sortableColumn property="qtc" title="${message(code: 'closedAlignment.qtc.label', default: 'Qtc')}" />
					
						<g:sortableColumn property="factor" title="${message(code: 'closedAlignment.factor.label', default: 'Factor')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${closedAlignmentInstanceList}" status="i" var="closedAlignmentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${closedAlignmentInstance.id}">${fieldValue(bean: closedAlignmentInstance, field: "rpre")}</g:link></td>
					
						<td><g:formatDate date="${closedAlignmentInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${closedAlignmentInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: closedAlignmentInstance, field: "createdBy")}</td>
					
						<td>${fieldValue(bean: closedAlignmentInstance, field: "lastModifiedBy")}</td>
					
						<td>${fieldValue(bean: closedAlignmentInstance, field: "qtc")}</td>
					
						<td>${fieldValue(bean: closedAlignmentInstance, field: "factor")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${closedAlignmentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
