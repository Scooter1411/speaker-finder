

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
						<th><g:message code="parameterSet.driver.label" default="Driver" /></th>
					
						<g:sortableColumn property="vas" title="${message(code: 'parameterSet.vas.label', default: 'Vas')}" />
					
						<g:sortableColumn property="qts" title="${message(code: 'parameterSet.qts.label', default: 'Qts')}" />
					
						<g:sortableColumn property="qes" title="${message(code: 'parameterSet.qes.label', default: 'Qes')}" />
					
						<g:sortableColumn property="qms" title="${message(code: 'parameterSet.qms.label', default: 'Qms')}" />
					
						<g:sortableColumn property="cms" title="${message(code: 'parameterSet.cms.label', default: 'Cms')}" />					
					
						<g:sortableColumn property="fs" title="${message(code: 'parameterSet.fs.label', default: 'Fs')}" />
					
						<g:sortableColumn property="le" title="${message(code: 'parameterSet.le.label', default: 'Le')}" />
					
						<g:sortableColumn property="mms" title="${message(code: 'parameterSet.mms.label', default: 'Mms')}" />
					
						<g:sortableColumn property="nvc" title="${message(code: 'parameterSet.nvc.label', default: 'Nvc')}" />
					
						<g:sortableColumn property="pmax" title="${message(code: 'parameterSet.pmax.label', default: 'Pmax')}" />
					
						<g:sortableColumn property="re" title="${message(code: 'parameterSet.re.label', default: 'Re')}" />
					
						<g:sortableColumn property="sd" title="${message(code: 'parameterSet.sd.label', default: 'Sd')}" />
					
						<g:sortableColumn property="spl" title="${message(code: 'parameterSet.spl.label', default: 'Spl')}" />
					
						<g:sortableColumn property="xmax" title="${message(code: 'parameterSet.xmax.label', default: 'Xmax')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'parameterSet.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'parameterSet.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="createdBy" title="${message(code: 'parameterSet.createdBy.label', default: 'Created By')}" />
					
						<g:sortableColumn property="lastModifiedBy" title="${message(code: 'parameterSet.lastModifiedBy.label', default: 'Last Modified By')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${parameterSetInstanceList}" status="i" var="parameterSetInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${parameterSetInstance.id}">${fieldValue(bean: parameterSetInstance, field: "driver")}</g:link></td>

						<td>${fieldValue(bean: parameterSetInstance, field: "vas")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "qts")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "qes")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "qms")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "cms")}</td>
					
					
						<td>${fieldValue(bean: parameterSetInstance, field: "fs")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "le")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "mms")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "nvc")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "pmax")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "re")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "sd")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "spl")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "xmax")}</td>
					
						<td><g:formatDate date="${parameterSetInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${parameterSetInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "createdBy")}</td>
					
						<td>${fieldValue(bean: parameterSetInstance, field: "lastModifiedBy")}</td>
					
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
