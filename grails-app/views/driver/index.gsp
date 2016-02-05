

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'driver.label', default: 'Driver')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-driver" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-driver" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'driver.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'driver.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'driver.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'driver.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="lastModifiedBy" title="${message(code: 'driver.lastModifiedBy.label', default: 'Last Modified By')}" />
					
						<th><g:message code="driver.maker.label" default="Maker" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${driverInstanceList}" status="i" var="driverInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${driverInstance.id}">${fieldValue(bean: driverInstance, field: "name")}</g:link></td>
					
						<td><g:formatDate date="${driverInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${driverInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: driverInstance, field: "createdBy")}</td>
					
						<td>${fieldValue(bean: driverInstance, field: "lastModifiedBy")}</td>
					
						<td>${fieldValue(bean: driverInstance, field: "maker")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${driverInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
