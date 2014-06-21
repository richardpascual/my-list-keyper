create or replace package body "LIST_MANAGER" is
--------------------------------------------------------------
-- create procedure for table "MY_LIST_KEEPER"
   procedure "INS_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  in varchar2,
      "P_ITEM_VALUE"   in varchar2          default null
   ) is 
 
   begin
 
      insert into "MY_LIST_KEEPER" (
         "LIST_ITEM_ID",
         "MY_CATEGORY",
         "ITEM_VALUE"
      ) values ( 
         "P_LIST_ITEM_ID",
         "P_MY_CATEGORY",
         "P_ITEM_VALUE"
      );
 
   end "INS_MY_LIST_KEEPER";
--------------------------------------------------------------
-- update procedure for table "MY_LIST_KEEPER"
   procedure "UPD_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  in varchar2,
      "P_ITEM_VALUE"   in varchar2          default null,
      "P_MD5"          in varchar2          default null
   ) is 
 
      "L_MD5" varchar2(32767) := null;
 
   begin
 
      if "P_MD5" is not null then
         for c1 in (
            select * from "MY_LIST_KEEPER" 
            where "LIST_ITEM_ID" = "P_LIST_ITEM_ID" FOR UPDATE
         ) loop
 
            "L_MD5" := "BUILD_MY_LIST_KEEPER_MD5"(
               c1."LIST_ITEM_ID",
               c1."MY_CATEGORY",
               c1."ITEM_VALUE"
            );
 
         end loop;
 
      end if;
 
      if ("P_MD5" is null) or ("L_MD5" = "P_MD5") then 
         update "MY_LIST_KEEPER" set
            "LIST_ITEM_ID"   = "P_LIST_ITEM_ID",
            "MY_CATEGORY"    = "P_MY_CATEGORY",
            "ITEM_VALUE"     = "P_ITEM_VALUE"
         where "LIST_ITEM_ID" = "P_LIST_ITEM_ID";
      else
         raise_application_error (-20001,'Current version of data in database has changed since user initiated update process. current checksum = "'||"L_MD5"||'", item checksum = "'||"P_MD5"||'".');  
      end if;
 
   end "UPD_MY_LIST_KEEPER";
--------------------------------------------------------------
-- delete procedure for table "MY_LIST_KEEPER"
   procedure "DEL_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number
   ) is 
 
   begin
 
      delete from "MY_LIST_KEEPER" 
      where "LIST_ITEM_ID" = "P_LIST_ITEM_ID";
 
   end "DEL_MY_LIST_KEEPER";
--------------------------------------------------------------
-- get procedure for table "MY_LIST_KEEPER"
   procedure "GET_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  out varchar2,
      "P_ITEM_VALUE"   out varchar2
   ) is 
 
      ignore varchar2(32676);
   begin
 
      "GET_MY_LIST_KEEPER" (
         "P_LIST_ITEM_ID",
         "P_MY_CATEGORY",
         "P_ITEM_VALUE",
         ignore
      );
 
   end "GET_MY_LIST_KEEPER";
--------------------------------------------------------------
-- get procedure for table "MY_LIST_KEEPER"
   procedure "GET_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  out varchar2,
      "P_ITEM_VALUE"   out varchar2,
      "P_MD5"          out varchar2
   ) is 
 
   begin
 
      for c1 in (
         select * from "MY_LIST_KEEPER" 
         where "LIST_ITEM_ID" = "P_LIST_ITEM_ID" 
      ) loop
         "P_MY_CATEGORY"  := c1."MY_CATEGORY";
         "P_ITEM_VALUE"   := c1."ITEM_VALUE";
 
         "P_MD5" := "BUILD_MY_LIST_KEEPER_MD5"(
            c1."LIST_ITEM_ID",
            c1."MY_CATEGORY",
            c1."ITEM_VALUE"
         );
      end loop;
 
   end "GET_MY_LIST_KEEPER";
--------------------------------------------------------------
-- build MD5 function for table "MY_LIST_KEEPER"
   function "BUILD_MY_LIST_KEEPER_MD5" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  in varchar2,
      "P_ITEM_VALUE"   in varchar2          default null,
      "P_COL_SEP"      in varchar2          default '|'
   ) return varchar2 is 
 
   begin
 
      return sys.utl_raw.cast_to_raw(sys.dbms_obfuscation_toolkit.md5(input_string=> 
         "P_MY_CATEGORY"  ||"P_COL_SEP"||
         "P_ITEM_VALUE"   ||"P_COL_SEP"||
         ''
      ));
 
   end "BUILD_MY_LIST_KEEPER_MD5";
 
end "LIST_MANAGER";
