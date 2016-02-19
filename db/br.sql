drop view enclosure_view;
drop view vented_enclosure_view12;
drop view vented_enclosure_view11;
drop view vented_enclosure_view;
drop view vented_enclosure_view6;
drop view vented_enclosure_view5;
drop view vented_enclosure_view4;
drop view vented_enclosure_view3;
drop view vented_enclosure_view2;
drop view vented_enclosure_view1;
create view vented_enclosure_view1 as
select 
    m.name || ' ' ||d.name as Driver, ps.id as parameter_set_id, a.id as vented_alignment_id, a.rpre, a.vx, ps.qes, ps.qms, ps.qts,  ps.sd as sd,
	ps.fs,ps.re, ps.pmax, ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd, 2.83 * 2.83 / ps.re as p0
from Parameter_set PS, Driver d, maker m, alignment a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'VentedAlignment'
and ( a.vx < 1.5 or ps.sd > 400 );

create or replace view vented_enclosure_view2 as
select 
	driver, parameter_set_id, vented_alignment_id, rpre, vx, qes, qes1, qts, vas, vd, re, fs, p0, pmax, sd,
	1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
from vented_enclosure_view1;
	
create or replace view vented_enclosure_view3 as
select
    driver, parameter_set_id, vented_alignment_id, rpre, vx, qes, qes1, qts, vd, qts1, eff, p0, pmax, vas, fs, sd,
	
    112 + 10 * log( eff ) / log(10) as spl1,
	15 * vas * power( qts1, 2.87 ) as vb,
	0.26 * fs / power( qts1, 1.4 ) as f3,
	0.42 * fs / power( qts1, 0.9 ) as fb,
    CASE WHEN (VX = 1.0) THEN '*' ELSE ' ' END AS MARK
from vented_enclosure_view2;	

create or replace view vented_enclosure_view4 as
select 
    driver, parameter_set_id, vented_alignment_id, rpre, vx, qes, qes1, qts, vd, qts1, eff, p0, pmax, vas, fs, sd,
	spl1, vb, f3, fb, MARK,
	vas / vb * ( power( fs / 10, 3 ) ) as vmax,
	vb * vx as vbx
from vented_enclosure_view3;

create or replace view vented_enclosure_view5 as
select 
    driver, parameter_set_id, vented_alignment_id, rpre, vx, qes, qes1, qts, vd, qts1, eff, p0, pmax, vas, fs, sd,
	spl1, vb, f3, fb, MARK, vmax, vbx,
	fs * power(( vas / vbx ), 0.5) as f3x,
	fs * power(( vas / vbx ), 0.32) as fbx,  	
    spl1 + 10 * log( pmax / p0 ) / log(10) as spl3
from vented_enclosure_view4 where vx <= vmax;

create or replace view vented_enclosure_view6 as
select 
    driver, parameter_set_id, vented_alignment_id, rpre, vx, qes, qes1, qts, vd, qts1, eff, p0, pmax, vas, fs, sd,
	spl1, vb, f3, fb, MARK, vmax, vbx, f3x, fbx, spl3,
	( 20 * log( 0.37 * f3x * f3x * vd ) / log(10) ) + 4 as spl2
from vented_enclosure_view5;

create or replace view vented_enclosure_view as
select 
    driver, parameter_set_id, vented_alignment_id, rownum as id, pmax, rpre, MARK, spl1 as spl, vbx as vb, fs, sd,
	spl2 as spl_mech,
    p0 * exp(( spl2 - spl1)/10*log(10)) as pmech,
	spl3 as spl_ele,
	f3x as f3
from vented_enclosure_view6 order by driver, rpre, vb;

create or replace view enclosure_view as
select 
    driver, parameter_set_id, closed_alignment_id as alignment_id, rownum as id, pmax, rpre, spl, vb, spl_mech, pmech, spl_ele, f3, 'ClosedEnclosure' as class
from closed_enclosure_view
union all
select 
    driver, parameter_set_id, vented_alignment_id as alignment_id, rownum as id, pmax, rpre, spl, vb, spl_mech, pmech, spl_ele, f3, 'VentedEnclosure' as class
from vented_enclosure_view;

create or replace view tube as 
select 40 as dlist, '1x40mm' as dname from dual union all
select 50,'1x50mm' from dual union all
select 70,'1x70mm' from dual union all
select 100,'1x100mm' from dual union all
select 141,'2x100mm' from dual union all
select 173,'3x100mm' from dual union all
select 200,'4x100mm' from dual union all
select 224,'5x100mm' from dual union all
select 245,'6x100mm' from dual; 

create or replace view tube1 as 
select dlist, dname, 
3.1416 / 4 * power( dlist / 10, 2 ) as sv
from tube;

create or replace view vented_enclosure_view11 as
select 
    driver,   parameter_set_id, vented_alignment_id, id, pmax, rpre, MARK, spl, vb,
	spl_mech, pmech, spl_ele, f3, t.sv,  t.dname, t.dlist,
	 (((10 * power(343, 2)  * t.sv )/(4*power(3.1416,2)*power(fs,2)*vb)) - 0.825 * ( power(t.sv,0.5) ))*10 as l,
	 sqrt( sd / 5 ) * 10 as dwunsch
from vented_enclosure_view ve, tube1 t order by driver, rpre, vb, t.dlist;

create or replace view vented_enclosure_view12 as
select 
    driver, parameter_set_id, vented_alignment_id, id, pmax, rpre, MARK, spl, vb,
	spl_mech, pmech, spl_ele, f3, l, dname, dwunsch, 
	( dlist - dwunsch ) / dwunsch as dkorr2
from vented_enclosure_view11 ve where l < 700 and l > 20;

create or replace view vented_enclosure_view13 as
select 
    driver, parameter_set_id, vented_alignment_id, id, pmax, rpre, MARK, spl, vb,
	spl_mech, pmech, spl_ele, f3, l, dname, dwunsch, dkorr2,
	CASE WHEN ( abs(dkorr2) < 0.1 ) THEN ' ' 
	CASE WHEN ( dkorr2 > 0.1 ) THEN '+' 
	ELSE '-' END AS dkorr,
from vented_enclosure_view12;



