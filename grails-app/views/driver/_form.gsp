



<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="driver.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="60" required="" value="${driverInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="driver.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" readonly="readonly" value="${driverInstance?.createdBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'lastModifiedBy', 'error')} ">
	<label for="lastModifiedBy">
		<g:message code="driver.lastModifiedBy.label" default="Last Modified By" />
		
	</label>
	<g:textField name="lastModifiedBy" readonly="readonly" value="${driverInstance?.lastModifiedBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'maker', 'error')} required">
	<label for="maker">
		<g:message code="driver.maker.label" default="Maker" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="maker" name="maker.id" from="${Maker.list()}" optionKey="id" required="" value="${driverInstance?.maker?.id}" class="many-to-one"/>

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

