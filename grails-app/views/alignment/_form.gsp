



<div class="fieldcontain ${hasErrors(bean: alignmentInstance, field: 'rpre', 'error')} required">
	<label for="rpre">
		<g:message code="alignment.rpre.label" default="Rpre" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rpre" value="${fieldValue(bean: alignmentInstance, field: 'rpre')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: alignmentInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="alignment.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${alignmentInstance?.createdBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: alignmentInstance, field: 'lastModifiedBy', 'error')} ">
	<label for="lastModifiedBy">
		<g:message code="alignment.lastModifiedBy.label" default="Last Modified By" />
		
	</label>
	<g:textField name="lastModifiedBy" value="${alignmentInstance?.lastModifiedBy}"/>

</div>

