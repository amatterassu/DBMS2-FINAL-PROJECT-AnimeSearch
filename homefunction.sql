create or replace TYPE t_home_tab IS OBJECT
                (img_url varchar2(200),
                 title varchar2(200),
                 synopsis varchar2(4000));
--DROP TYPE t_home_tab FORCE;

create or replace TYPE t_h_table IS TABLE OF t_home_tab;

create or replace FUNCTION fun_home
     RETURN t_h_table IS
     t_result t_h_table := t_h_table();

    cursor cur_home is
        select img_url ,title ,synopsis
        from (select * from anime4 where world_popularity = 'the MOST famous' order by popularity asc)
        where rownum <= 8; 
BEGIN
    FOR i IN cur_home LOOP
        t_result.extend;
            t_result(t_result.count) := t_home_tab(null, null,null);
            t_result(t_result.count).img_url :=  i.img_url;
            t_result(t_result.count).title :=  i.title;
            t_result(t_result.count).synopsis :=  i.synopsis;

    END LOOP;
    RETURN t_result;
END; 

select * from table(fun_home);