

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'parameterSet.label', default: 'ParameterSet')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-parameterSet" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-parameterSet" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="cms" title="${message(code: 'parameterSet.cms.label', default: 'Cms')}" />
					
						<th><g:message code="parameterSet.driver.label" default="Driver" /></th>
					
						<g:sortableColumn property="fs" title="${message(code: 'parameterSet.fs.label', default: 'Fs')}" />
					
						<g:sortableColumn property="le" title="${message(code: 'parameterSet.le.label', default: 'Le')}" />
					
						<g:sortableColumn property="mms" title="${message(code: 'parameterSet.mms.label', default: 'Mms')}" />
					
						<g:sortableColumn property="nvc" title="${message(code: 'parameterSet.nvc.label', default: 'Nvc')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${parameterSetInstanceList}" status="i" var="parameterSetInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${parameterSetInstance.id}">${fieldValue(bean: parameterSetInstance, field: "cms")}</g:link></td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "driver")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "fs")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "le")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "mms")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "nvc")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${parameterSetInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
