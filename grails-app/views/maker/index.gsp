

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'maker.label', default: 'Maker')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-maker" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-maker" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
<<<<<<< HEAD:grails-app/views/maker/index.gsp
						<g:sortableColumn property="name" title="${message(code: 'maker.name.label', default: 'Name')}" />
=======
						<g:sortableColumn property="rpre" title="${message(code: 'alignment.rpre.label', default: 'Rpre')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'alignment.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'alignment.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'alignment.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="lastModifiedBy" title="${message(code: 'alignment.lastModifiedBy.label', default: 'Last Modified By')}" />
>>>>>>> 31a21eb335dfb7b03323bd9498ef71be639a1d9b:grails-app/views/alignment/index.gsp
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${makerInstanceList}" status="i" var="makerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
<<<<<<< HEAD:grails-app/views/maker/index.gsp
						<td><g:link action="show" id="${makerInstance.id}">${fieldValue(bean: makerInstance, field: "name")}</g:link></td>
=======
						<td><g:link action="show" id="${alignmentInstance.id}">${fieldValue(bean: alignmentInstance, field: "rpre")}</g:link></td>
					
						<td><g:formatDate date="${alignmentInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${alignmentInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: alignmentInstance, field: "createdBy")}</td>
					
						<td>${fieldValue(bean: alignmentInstance, field: "lastModifiedBy")}</td>
>>>>>>> 31a21eb335dfb7b03323bd9498ef71be639a1d9b:grails-app/views/alignment/index.gsp
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${makerInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
