var $pluginID = "com.mob.sharesdk.WhatsApp";eval(function(p,a,c,k,e,r){e=function(c){return(c<62?'':e(parseInt(c/62)))+((c=c%62)>35?String.fromCharCode(c+29):c.toString(36))};if('0'.replace(0,e)==0){while(c--)r[e(c)]=k[c];k=[function(e){return r[e]||e}];e=function(){return'([1-9a-wzA-Z]|1\\w)'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('a F={"G":"covert_url"};7 b(6){9.V=6;9.l={"D":3,"E":3};9._currentUser=3}b.d.6=7(){m 9.V};b.d.v=7(){m"b"};b.d.cacheDomain=7(){m"SSDK-Platform-"+9.6()};b.d.R=7(){5(9.l["E"]!=3&&9.l["E"][F.G]!=3){m 9.l["E"][F.G]}k 5(9.l["D"]!=3&&9.l["D"][F.G]!=3){m 9.l["D"][F.G]}m $1.2.R()};b.d.localAppInfo=7(K){5(W.X==0){m 9.l["D"]}k{9.l["D"]=K}};b.d.serverAppInfo=7(K){5(W.X==0){m 9.l["E"]}k{9.l["E"]=K}};b.d.saveConfig=7(){};b.d.isSupportAuth=7(){m false};b.d.authorize=7(L,settings){a c={"n":$1.2.o.H,"p":"平台［"+9.v()+"］不支持授权功能!"};$1.native.ssdk_authStateChanged(L,$1.2.g.q,c)};b.d.cancelAuthorize=7(4){};b.d.getUserInfo=7(query,4){a c={"n":$1.2.o.H,"p":"平台［"+9.v()+"］不支持获取用户信息功能!"};5(4!=3){4($1.2.g.q,c)}};b.d.addFriend=7(L,user,4){a c={"n":$1.2.o.H,"p":"平台["+9.v()+"]不支持添加好友方法!"};5(4!=3){4($1.2.g.q,c)}};b.d.getFriends=7(cursor,size,4){a c={"n":$1.2.o.H,"p":"平台["+9.v()+"]不支持获取好友列表方法!"};5(4!=3){4($1.2.g.q,c)}};b.d.callApi=7(I,method,params,4){a c={"n":$1.2.o.H,"p":"平台［"+9.v()+"］不支持调用API功能!"};5(4!=3){4($1.2.g.q,c)}};b.d.createUserByRawData=7(rawData){m 3};b.d.share=7(L,e,4){a w=3;a B=3;a t=3;a u=3;a x=3;a y=3;a c=3;a h=9;a M=e!=3?e["@M"]:3;a r={"@M":M};a 6=$1.2.i(9.6(),e,"6");5(6==3){6=$1.2.s.Y}5(6==$1.2.s.Y){6=9.Z(e)}$1.C.isPluginRegisted("com.1.sharesdk.connector.10",7(8){5(8.j){$1.C.canOpenURL("10://",7(8){5(8.j){switch(6){N $1.2.s.11:w=$1.2.i(h.6(),e,"w");h.12([w],7(8){w=8.j[0];$1.C.ssdk_whatsappShareText($1.utils.urlEncode(w),7(8){a f=8.j;5(8.z==$1.2.g.O){f={};f["P"]=8.j;f["w"]=w}5(4!=3){4(8.z,f,3,r)}})});J;N $1.2.s.13:a A=$1.2.i(h.6(),e,"A");5(14.d.15.16(A)===\'[17 18]\'){B=A[0]}5(B!=3){h.19(B,7(imageUrl){x=$1.2.i(h.6(),e,"S");y=$1.2.i(h.6(),e,"T");$1.C.ssdk_whatsappShareImage(B,x,y,7(8){a f=8.j;5(8.z==$1.2.g.O){f={};f["P"]=8.j;f["A"]=[B]}5(4!=3){4(8.z,f,3,r)}})})}k{c={"n":$1.2.o.Q,"p":"分享参数B不能为空!"};5(4!=3){4($1.2.g.q,c,3,r)}}J;N $1.2.s.1a:t=$1.2.i(h.6(),e,"t");5(t!=3){x=$1.2.i(h.6(),e,"S");y=$1.2.i(h.6(),e,"T");$1.C.ssdk_whatsappShareAudio(t,x,y,7(8){a f=8.j;5(8.z==$1.2.g.O){f={};f["P"]=8.j}5(4!=3){4(8.z,f,3,r)}})}k{c={"n":$1.2.o.Q,"p":"分享参数t不能为空!"};5(4!=3){4($1.2.g.q,c,3,r)}}J;N $1.2.s.1b:u=$1.2.i(h.6(),e,"u");5(u!=3){x=$1.2.i(h.6(),e,"S");y=$1.2.i(h.6(),e,"T");$1.C.ssdk_whatsappShareVideo(u,x,y,7(8){a f=8.j;5(8.z==$1.2.g.O){f={};f["P"]=8.j}5(4!=3){4(8.z,f,3,r)}})}k{c={"n":$1.2.o.Q,"p":"分享参数u不能为空!"};5(4!=3){4($1.2.g.q,c,3,r)}}J;default:c={"n":$1.2.o.UnsupportContentType,"p":"不支持的分享类型["+6+"]"};5(4!=3){4($1.2.g.q,c,3,r)}J}}k{c={"n":$1.2.o.NotYetInstallClient,"p":"分享平台［"+h.v()+"］尚未安装客户端，不支持分享!"};5(4!=3){4($1.2.g.q,c,3,r)}}})}k{c={"n":$1.2.o.Q,"p":"平台["+h.v()+"]需要依靠1c.1d进行分享，请先导入1c.1d后再试!"};5(4!=3){4($1.2.g.q,c,3,r)}}})};b.d.19=7(I,4){5(!/^(file\\:\\/)?\\//.test(I)){$1.C.downloadFile(I,7(8){5(8.j!=3){5(4!=3){4(8.j)}}k{5(4!=3){4(3)}}})}k{5(4!=3){4(I)}}};b.d.12=7(U,4){5(9.R()){$1.2.convertUrl(9.6(),3,U,4)}k{5(4){4({"j":U})}}};b.d.Z=7(e){a 6=$1.2.s.11;a A=$1.2.i(9.6(),e,"A");a t=$1.2.i(9.6(),e,"t");a u=$1.2.i(9.6(),e,"u");5(14.d.15.16(A)===\'[17 18]\'){6=$1.2.s.13}k 5(t!=3){6=$1.2.s.1a}k 5(u!=3){6=$1.2.s.1b}m 6};$1.2.registerPlatformClass($1.2.platformType.b,b);',[],76,'|mob|shareSDK|null|callback|if|type|function|data|this|var|WhatsApp|error|prototype|parameters|resultData|responseState|self|getShareParam|result|else|_appInfo|return|error_code|errorCode|error_message|Fail|userData|contentType|audio|video|name|text|||state|images|image|ext|local|server|WhatsAppInfoKeys|ConvertUrl|UnsupportFeature|url|break|value|sessionId|flags|case|Success|raw_data|APIRequestFail|convertUrlEnabled|menu_display_x|menu_display_y|contents|_type|arguments|length|Auto|_getShareType|whatsapp|Text|_convertUrl|Image|Object|toString|apply|object|Array|_getImagePath|Audio|Video|ShareSDKConnector|framework'.split('|'),0,{}))