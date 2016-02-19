



<div class="fieldcontain ${hasErrors(bean: closedAlignmentInstance, field: 'rpre', 'error')} required">
	<label for="rpre">
		<g:message code="closedAlignment.rpre.label" default="Rpre" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rpre" value="${fieldValue(bean: closedAlignmentInstance, field: 'rpre')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedAlignmentInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="closedAlignment.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${closedAlignmentInstance?.createdBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedAlignmentInstance, field: 'lastModifiedBy', 'error')} ">
	<label for="lastModifiedBy">
		<g:message code="closedAlignment.lastModifiedBy.label" default="Last Modified By" />
		
	</label>
	<g:textField name="lastModifiedBy" value="${closedAlignmentInstance?.lastModifiedBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedAlignmentInstance, field: 'qtc', 'error')} required">
	<label for="qtc">
		<g:message code="closedAlignment.qtc.label" default="Qtc" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="qtc" value="${fieldValue(bean: closedAlignmentInstance, field: 'qtc')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedAlignmentInstance, field: 'factor', 'error')} required">
	<label for="factor">
		<g:message code="closedAlignment.factor.label" default="Factor" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="factor" value="${fieldValue(bean: closedAlignmentInstance, field: 'factor')}" required=""/>

</div>

