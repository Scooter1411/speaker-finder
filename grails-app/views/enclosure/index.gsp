

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'enclosure.label', default: 'Enclosure')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-enclosure" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-enclosure" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="pmax" title="${message(code: 'enclosure.pmax.label', default: 'Pmax')}" />
					
						<g:sortableColumn property="spl" title="${message(code: 'enclosure.spl.label', default: 'Spl')}" />
					
						<g:sortableColumn property="splMech" title="${message(code: 'enclosure.splMech.label', default: 'Spl Mech')}" />
					
						<g:sortableColumn property="pmech" title="${message(code: 'enclosure.pmech.label', default: 'Pmech')}" />
					
						<g:sortableColumn property="splEle" title="${message(code: 'enclosure.splEle.label', default: 'Spl Ele')}" />
					
						<g:sortableColumn property="f3" title="${message(code: 'enclosure.f3.label', default: 'F3')}" />
					
						<th><g:message code="enclosure.alignment.label" default="Alignment" /></th>
					
						<th><g:message code="enclosure.parameterSet.label" default="Parameter Set" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${enclosureInstanceList}" status="i" var="enclosureInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${enclosureInstance.id}">${fieldValue(bean: enclosureInstance, field: "pmax")}</g:link></td>
					
						<td>${fieldValue(bean: enclosureInstance, field: "spl")}</td>
					
						<td>${fieldValue(bean: enclosureInstance, field: "splMech")}</td>
					
						<td>${fieldValue(bean: enclosureInstance, field: "pmech")}</td>
					
						<td>${fieldValue(bean: enclosureInstance, field: "splEle")}</td>
					
						<td>${fieldValue(bean: enclosureInstance, field: "f3")}</td>
					
						<td>${fieldValue(bean: enclosureInstance, field: "alignment")}</td>
					
						<td>${fieldValue(bean: enclosureInstance, field: "parameterSet")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${enclosureInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
