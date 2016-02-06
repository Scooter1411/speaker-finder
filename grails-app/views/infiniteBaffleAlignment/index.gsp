

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infiniteBaffleAlignment.label', default: 'InfiniteBaffleAlignment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-infiniteBaffleAlignment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-infiniteBaffleAlignment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="rpre" title="${message(code: 'infiniteBaffleAlignment.rpre.label', default: 'Rpre')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'infiniteBaffleAlignment.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'infiniteBaffleAlignment.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'infiniteBaffleAlignment.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="lastModifiedBy" title="${message(code: 'infiniteBaffleAlignment.lastModifiedBy.label', default: 'Last Modified By')}" />
					
						<g:sortableColumn property="nvc" title="${message(code: 'infiniteBaffleAlignment.nvc.label', default: 'Nvc')}" />
					
						<g:sortableColumn property="rpara" title="${message(code: 'infiniteBaffleAlignment.rpara.label', default: 'Rpara')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${infiniteBaffleAlignmentInstanceList}" status="i" var="infiniteBaffleAlignmentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${infiniteBaffleAlignmentInstance.id}">${fieldValue(bean: infiniteBaffleAlignmentInstance, field: "rpre")}</g:link></td>
					
						<td><g:formatDate date="${infiniteBaffleAlignmentInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${infiniteBaffleAlignmentInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: infiniteBaffleAlignmentInstance, field: "createdBy")}</td>
					
						<td>${fieldValue(bean: infiniteBaffleAlignmentInstance, field: "lastModifiedBy")}</td>
					
						<td>${fieldValue(bean: infiniteBaffleAlignmentInstance, field: "nvc")}</td>
					
						<td>${fieldValue(bean: infiniteBaffleAlignmentInstance, field: "rpara")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${infiniteBaffleAlignmentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
