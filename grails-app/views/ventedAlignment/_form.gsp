



<div class="fieldcontain ${hasErrors(bean: ventedAlignmentInstance, field: 'rpre', 'error')} required">
	<label for="rpre">
		<g:message code="ventedAlignment.rpre.label" default="Rpre" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rpre" value="${fieldValue(bean: ventedAlignmentInstance, field: 'rpre')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedAlignmentInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="ventedAlignment.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${ventedAlignmentInstance?.createdBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedAlignmentInstance, field: 'lastModifiedBy', 'error')} ">
	<label for="lastModifiedBy">
		<g:message code="ventedAlignment.lastModifiedBy.label" default="Last Modified By" />
		
	</label>
	<g:textField name="lastModifiedBy" value="${ventedAlignmentInstance?.lastModifiedBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedAlignmentInstance, field: 'vx', 'error')} required">
	<label for="vx">
		<g:message code="ventedAlignment.vx.label" default="Vx" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="vx" value="${fieldValue(bean: ventedAlignmentInstance, field: 'vx')}" required=""/>

</div>

