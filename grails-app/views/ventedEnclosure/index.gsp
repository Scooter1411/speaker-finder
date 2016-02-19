

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ventedEnclosure.label', default: 'VentedEnclosure')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-ventedEnclosure" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-ventedEnclosure" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="pmax" title="${message(code: 'ventedEnclosure.pmax.label', default: 'Pmax')}" />
					
						<g:sortableColumn property="spl" title="${message(code: 'ventedEnclosure.spl.label', default: 'Spl')}" />
					
						<g:sortableColumn property="splMech" title="${message(code: 'ventedEnclosure.splMech.label', default: 'Spl Mech')}" />
					
						<g:sortableColumn property="pmech" title="${message(code: 'ventedEnclosure.pmech.label', default: 'Pmech')}" />
					
						<g:sortableColumn property="splEle" title="${message(code: 'ventedEnclosure.splEle.label', default: 'Spl Ele')}" />
					
						<g:sortableColumn property="f3" title="${message(code: 'ventedEnclosure.f3.label', default: 'F3')}" />
					
						<g:sortableColumn property="vb" title="${message(code: 'ventedEnclosure.vb.label', default: 'Vb')}" />
					
						<th><g:message code="ventedEnclosure.alignment.label" default="Alignment" /></th>
					
						<th><g:message code="ventedEnclosure.closedAlignment.label" default="Closed Alignment" /></th>
					
						<g:sortableColumn property="length" title="${message(code: 'ventedEnclosure.length.label', default: 'Length')}" />
					
						<th><g:message code="ventedEnclosure.parameterSet.label" default="Parameter Set" /></th>
					
						<th><g:message code="ventedEnclosure.tube.label" default="Tube" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${ventedEnclosureInstanceList}" status="i" var="ventedEnclosureInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${ventedEnclosureInstance.id}">${fieldValue(bean: ventedEnclosureInstance, field: "pmax")}</g:link></td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "spl")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "splMech")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "pmech")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "splEle")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "f3")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "vb")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "alignment")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "closedAlignment")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "length")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "parameterSet")}</td>
					
						<td>${fieldValue(bean: ventedEnclosureInstance, field: "tube")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ventedEnclosureInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
