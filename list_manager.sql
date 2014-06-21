create or replace package "LIST_MANAGER" is
--------------------------------------------------------------
-- create procedure for table "MY_LIST_KEEPER"
   procedure "INS_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  in varchar2,
      "P_ITEM_VALUE"   in varchar2          default null
   );
--------------------------------------------------------------
-- update procedure for table "MY_LIST_KEEPER"
   procedure "UPD_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  in varchar2,
      "P_ITEM_VALUE"   in varchar2          default null,
      "P_MD5"          in varchar2          default null
   );
--------------------------------------------------------------
-- delete procedure for table "MY_LIST_KEEPER"
   procedure "DEL_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number
   );
--------------------------------------------------------------
-- get procedure for table "MY_LIST_KEEPER"
   procedure "GET_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  out varchar2,
      "P_ITEM_VALUE"   out varchar2
   );
--------------------------------------------------------------
-- get procedure for table "MY_LIST_KEEPER"
   procedure "GET_MY_LIST_KEEPER" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  out varchar2,
      "P_ITEM_VALUE"   out varchar2,
      "P_MD5"          out varchar2
   );
--------------------------------------------------------------
-- build MD5 function for table "MY_LIST_KEEPER"
   function "BUILD_MY_LIST_KEEPER_MD5" (
      "P_LIST_ITEM_ID" in number,
      "P_MY_CATEGORY"  in varchar2,
      "P_ITEM_VALUE"   in varchar2          default null,
      "P_COL_SEP"      in varchar2          default '|'
   ) return varchar2;
 
end "LIST_MANAGER";
