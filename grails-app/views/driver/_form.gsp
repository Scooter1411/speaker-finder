



<div class="fieldcontain ${hasErrors(bean: driverInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="driver.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${driverInstance?.name}"/>

</div>

