

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ventedAlignment.label', default: 'VentedAlignment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-ventedAlignment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-ventedAlignment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="rpre" title="${message(code: 'ventedAlignment.rpre.label', default: 'Rpre')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'ventedAlignment.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'ventedAlignment.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'ventedAlignment.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="lastModifiedBy" title="${message(code: 'ventedAlignment.lastModifiedBy.label', default: 'Last Modified By')}" />
					
						<g:sortableColumn property="vx" title="${message(code: 'ventedAlignment.vx.label', default: 'Vx')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${ventedAlignmentInstanceList}" status="i" var="ventedAlignmentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${ventedAlignmentInstance.id}">${fieldValue(bean: ventedAlignmentInstance, field: "rpre")}</g:link></td>
					
						<td><g:formatDate date="${ventedAlignmentInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${ventedAlignmentInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: ventedAlignmentInstance, field: "createdBy")}</td>
					
						<td>${fieldValue(bean: ventedAlignmentInstance, field: "lastModifiedBy")}</td>
					
						<td>${fieldValue(bean: ventedAlignmentInstance, field: "vx")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ventedAlignmentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
