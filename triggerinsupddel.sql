begin
    EXECUTE IMMEDIATE 'CREATE TABLE anime_trigg_tab(id number, cur_date date, old_id number, new_id number,old_title varchar2(30), new_title varchar2(30), old_episodes number, new_episodes number, action varchar2(30), author varchar2(30))';
end;

drop table anime_trigg_tab;

select*from anime_trigg_tab;
------------------------------------------
create or replace trigger add_upp_del 
After insert or update or delete on anime4 
for each row
begin    
    IF INSERTING THEN 
        insert into anime_trigg_tab
        values(1, sysdate, :OLD.id , :NEW.id , :OLD.title , :NEW.title ,:OLD.episodes, :NEW.episodes, 'INSERT', user);
    END IF;
    
    IF UPDATING THEN 
        insert into anime_trigg_tab
        values(1, sysdate, :OLD.id , :NEW.id , :OLD.title , :NEW.title ,:OLD.episodes, :NEW.episodes, 'UPDATE', user);
    END IF;  
    
    IF DELETING THEN 
        insert into anime_trigg_tab
        values(1, sysdate, :OLD.id , :NEW.id , :OLD.title , :NEW.title ,:OLD.episodes, :NEW.episodes, 'DELETE', user);
    END IF;
end;

select*from anime_trigg_tab;

