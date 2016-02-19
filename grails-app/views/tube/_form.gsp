



<div class="fieldcontain ${hasErrors(bean: tubeInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="tube.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="20" required="" value="${tubeInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: tubeInstance, field: 'diameter', 'error')} required">
	<label for="diameter">
		<g:message code="tube.diameter.label" default="Diameter" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="diameter" value="${fieldValue(bean: tubeInstance, field: 'diameter')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: tubeInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="tube.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" readonly="readonly" value="${tubeInstance?.createdBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: tubeInstance, field: 'lastModifiedBy', 'error')} ">
	<label for="lastModifiedBy">
		<g:message code="tube.lastModifiedBy.label" default="Last Modified By" />
		
	</label>
	<g:textField name="lastModifiedBy" readonly="readonly" value="${tubeInstance?.lastModifiedBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: tubeInstance, field: 'area', 'error')} required">
	<label for="area">
		<g:message code="tube.area.label" default="Area" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="area" value="${fieldValue(bean: tubeInstance, field: 'area')}" required=""/>

</div>

