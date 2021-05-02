create or replace TYPE t_line_tab IS OBJECT(title varchar2(200), members number(10,0));

create or replace TYPE t_ltable IS TABLE OF t_line_tab;

create or replace FUNCTION line_chart
    RETURN t_ltable IS
    t_result t_ltable := t_ltable();

    CURSOR cur_line IS 
        select title , members 
        from (select * from anime4 order by members desc)
        where rownum <= 10;

BEGIN
    FOR i IN cur_line LOOP
        t_result.extend;
            t_result(t_result.count) := t_line_tab(null, null);
            t_result(t_result.count).title :=  i.title;
            t_result(t_result.count).members := i.members;
    END LOOP;
    RETURN t_result;
END;

    select * from table(line_chart);
--------------------------------------------------------------------------------------------

create or replace TYPE t_pie_tab IS OBJECT(title varchar2(200), episodes number(10,0));

--DROP TYPE t_anime_tab FORCE;

create or replace TYPE t_atable IS TABLE OF t_pie_tab;

create or replace FUNCTION pie_chart--(p_title IN anime4.title%TYPE)
    RETURN t_atable IS
    t_result t_atable := t_atable();

    CURSOR cur_pie IS 
        select title , episodes 
        from (select * from anime4 where episodes is not null order by episodes desc) 
        where rownum <= 10;

BEGIN
    FOR i IN cur_pie LOOP
        t_result.extend;
            t_result(t_result.count) := t_pie_tab(null, null);
            t_result(t_result.count).title :=  i.title;
            t_result(t_result.count).episodes := i.episodes;
    END LOOP;
    RETURN t_result;
END;

select * from table(pie_chart);

