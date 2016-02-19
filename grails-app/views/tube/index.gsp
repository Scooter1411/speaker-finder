

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tube.label', default: 'Tube')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tube" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tube" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'tube.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="diameter" title="${message(code: 'tube.diameter.label', default: 'Diameter')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'tube.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'tube.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'tube.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="lastModifiedBy" title="${message(code: 'tube.lastModifiedBy.label', default: 'Last Modified By')}" />
					
						<g:sortableColumn property="area" title="${message(code: 'tube.area.label', default: 'Area')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tubeInstanceList}" status="i" var="tubeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${tubeInstance.id}">${fieldValue(bean: tubeInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: tubeInstance, field: "diameter")}</td>
					
						<td><g:formatDate date="${tubeInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${tubeInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: tubeInstance, field: "createdBy")}</td>
					
						<td>${fieldValue(bean: tubeInstance, field: "lastModifiedBy")}</td>
					
						<td>${fieldValue(bean: tubeInstance, field: "area")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${tubeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
