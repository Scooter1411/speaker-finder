



<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'company', 'error')} required">
	<label for="company">
		<g:message code="driver.company.label" default="Company" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="company" required="" value="${driverInstance?.company}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="driver.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${driverInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'parameterSets', 'error')} ">
	<label for="parameterSets">
		<g:message code="driver.parameterSets.label" default="Parameter Sets" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${driverInstance?.parameterSets?}" var="p">
    <li><g:link controller="parameterSet" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="parameterSet" action="create" params="['driver.id': driverInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'parameterSet.label', default: 'ParameterSet')])}</g:link>
</li>
</ul>


</div>

