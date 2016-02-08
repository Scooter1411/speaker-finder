
create or replace view vented_enclosure_view1 as
select 
    m.name || ' ' ||d.name as Driver, ps.id as parameter_set_id, a.id as vented_alignment_id, a.rpre, a.qtc, a.factor, ps.qes, ps.qms, ps.qts, 
	ps.fs,ps.re, ps.pmax, ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd, 2.83 * 2.83 / ps.re as p0
from Parameter_set PS, Driver d, maker m, alignment_view a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ventedAlignment';

create or replace view vented_enclosure_view2 as
select 
	driver, parameter_set_id, vented_alignment_id, rpre, qtc, factor, qes, qes1, qts, vas, vd, re, fs, p0, pmax,
	1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
from vented_enclosure_view1;
	
create or replace view vented_enclosure_view3 as
select
    driver, parameter_set_id, vented_alignment_id, rpre, qtc, factor, qes, qes1, qts, vd, qts1, eff, p0, pmax,
	
    112 + 10 * log( eff ) / log(10) as spl1,
    --316000 * qts1 / re / fs as cs,
    --qtc /qts1 * fs as fc,
	
	15 * vas * power( qts1, 2.87 ) as vb,
	0.26 * fs / power( qts1, 1.4 ) as f3,
	0.42 * fs / power( qts1, 0.9 ) as fb
from vented_enclosure_view2 where qtc > qts1;	

create or replace view vented_enclosure_view4 as
select 
    driver, parameter_set_id, vented_alignment_id, rpre, qtc, vd, p0, spl1,  pmax, vb,
    factor * fc as f3
from vented_enclosure_view3;

create or replace view vented_enclosure_view5 as
select 
    driver, parameter_set_id, vented_alignment_id, rpre, spl1, qtc, vb, pmax, 
	20 * log( 0.37 * f3 * f3 * vd ) / log(10) as spl2,
	f3, p0,
    spl1 + 10 * log( pmax / p0 ) / log(10) as spl3
from vented_enclosure_view4;

create or replace view vented_enclosure_view as
select 
    driver, parameter_set_id, vented_alignment_id, rownum as id, pmax, rpre, spl1 as spl, qtc, vb,
	spl2 as spl_mech,
    p0 * exp(( spl2 - spl1)/10*log(10)) as pmech,
	spl3 as spl_ele,
	f3
from vented_enclosure_view5 order by driver, rpre, qtc;

create or replace view enclosure_view as
select 
    driver, parameter_set_id, closed_alignment_id, rownum as id, pmax, rpre, spl, qtc, vb, spl_mech, pmech, spl_ele, f3, 'ClosedEnclosure' as class
from closed_enclosure_view
union all
select 
    driver, parameter_set_id, vented_alignment_id, rownum as id, pmax, rpre, spl, qtc, vb, spl_mech, pmech, spl_ele, f3, 'ventedEnclosure' as class
from vented_enclosure_view;

create or replace view vented_enclosure_view_rounded as
SELECT driver, round(pmax,0), rpre, round(spl,1), qtc, round(vb,1), round(spl_mech,1), round(pmech,1), round(spl_ele,1),	round(f3,1) 
FROM vented_ENCLOSURE_VIEW;
