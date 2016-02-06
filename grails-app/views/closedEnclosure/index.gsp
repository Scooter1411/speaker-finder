

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'closedEnclosure.label', default: 'ClosedEnclosure')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-closedEnclosure" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-closedEnclosure" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="pmax" title="${message(code: 'closedEnclosure.pmax.label', default: 'Pmax')}" />
					
						<g:sortableColumn property="spl" title="${message(code: 'closedEnclosure.spl.label', default: 'Spl')}" />
					
						<g:sortableColumn property="splMech" title="${message(code: 'closedEnclosure.splMech.label', default: 'Spl Mech')}" />
					
						<g:sortableColumn property="pmech" title="${message(code: 'closedEnclosure.pmech.label', default: 'Pmech')}" />
					
						<g:sortableColumn property="splEle" title="${message(code: 'closedEnclosure.splEle.label', default: 'Spl Ele')}" />
					
						<g:sortableColumn property="f3" title="${message(code: 'closedEnclosure.f3.label', default: 'F3')}" />
					
						<g:sortableColumn property="vb" title="${message(code: 'closedEnclosure.vb.label', default: 'Vb')}" />
					
						<th><g:message code="closedEnclosure.closedAlignment.label" default="Closed Alignment" /></th>
					
						<th><g:message code="closedEnclosure.parameterSet.label" default="Parameter Set" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${closedEnclosureInstanceList}" status="i" var="closedEnclosureInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${closedEnclosureInstance.id}">${fieldValue(bean: closedEnclosureInstance, field: "pmax")}</g:link></td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "spl")}</td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "splMech")}</td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "pmech")}</td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "splEle")}</td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "f3")}</td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "vb")}</td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "closedAlignment")}</td>
					
						<td>${fieldValue(bean: closedEnclosureInstance, field: "parameterSet")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${closedEnclosureInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
