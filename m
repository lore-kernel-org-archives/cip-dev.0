Return-Path: <SRS0=E7AS=7X=lists.cip-project.org=bounce+64572+4792+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB6C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 10 Jun 2020 13:02:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12BB20734
	for <cip-dev@archiver.kernel.org>; Wed, 10 Jun 2020 13:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZJycgSIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12BB20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4792+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id B9j1YY4521723xWhnqMuSVFp; Wed, 10 Jun 2020 06:02:23 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web10.10067.1591794140168835301
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jun 2020 06:02:21 -0700
IronPort-SDR: TGpsJo46EErYnh1Ye9lB3C3RN72eWokSwfDk716KPOxH8q0RFF0xMayA+uy58f7Z/STthmX4t4
 ynA9m5aIFdGA==
X-IronPort-AV: E=Sophos;i="5.73,496,1583173800"; 
   d="c'?scan'208,217";a="4220142"
X-Received: from unknown (HELO TOSBLRMBX0319.TOSHIBA-TSIP.COM) ([172.28.80.120])
  by peak.toshiba-tesi.com with ESMTP; 10 Jun 2020 19:00:55 +0530
X-Received: from TOSBLRMBX0119.TOSHIBA-TSIP.COM (172.28.80.118) by
 TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 10 Jun 2020 18:32:17 +0530
X-Received: from TOSBLRMBX0119.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0119.TOSHIBA-TSIP.COM ([fe80::fc54:5765:a052:196%9]) with mapi id
 15.01.1847.003; Wed, 10 Jun 2020 18:32:17 +0530
From: "Dinesh Kumar" <dinesh.kumar@toshiba-tsip.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: [cip-dev] Share your suggestions for supporting session lock requirement in CIP
Thread-Topic: Share your suggestions for supporting session lock requirement
 in CIP
Thread-Index: AdY/Iijpzub5lY9cRtm76jsyK2EKtA==
Date: Wed, 10 Jun 2020 13:02:17 +0000
Message-ID: <3999decc9e9743b7b4061b38b91f4575@TOSHIBA-TSIP.COM>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.80.121]
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: A6npSETQN4uy25q0Gmb4RnB0x4520388AA=
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591794143;
 bh=HMl4w6I+XOOQ8qoeG8hj75YMPBwEgL1JCzgyPpYsjzY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZJycgSIu91lpMQu3l9vG4OWoo4UwRAqxr+lPlezCZBqQ63kB0IyZOW/Hdq6wkCdgbtD
 4aJZopBbJbOrd37pgfl2S5JNJxpMgVZhAED8NHTbhVCYa/5lYk4Q2zN5ZUcYY7nD2QNYA
 M1+k5VlMOE4qa+One9BMKaEy7gWJzj7cM6A=

--_004_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_
Content-Type: multipart/alternative;
	boundary="_000_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_"

--_000_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

IEC-62443-4-2 has following two requirements related to session termination=
 and session lock.
CR2.5 Req-1 Session lock: Component should support session lock after a con=
figurable time period of inactivity.
CR2.6 Req-2 Remote session termination: Component should support terminatin=
g remote session after a configurable time of inactivity

CR2.6 Req-2 can be met by adding system variable TMOUT.

For meeting CR2.5 we need following changes in CIP.

1.       Systemd code changes

2.       Add deamon which subscribes to dbus notification(sample code attac=
hed)

3.       Add vlock Debian package which performs session lock

4.       Enable dbus in systemd

Systemd code change are as follows.


--- a/src/login/logind.c

+++ b/src/login/logind.c

@@ -1019,7 +1019,7 @@ static int manager_dispatch_idle_action(sd_event_sour=
ce *s, uint64_t t, void *us

                     (m->idle_action_not_before_usec <=3D 0 || n >=3D m->id=
le_action_not_before_usec + m->idle_action_usec)) {

                         log_info("System idle. Taking action.");



-                        manager_handle_action(m, 0, m->idle_action, false,=
 false);

+                        manager_handle_action(m, 0, m->idle_action, false,=
 true);

                         m->idle_action_not_before_usec =3D n;

                 }

It means there are several changes required in CIP as well as it would be d=
ifficult to maintain for long term, if we chose this option.

My request is, if anyone has any better idea to achieve session lock, pleas=
e share so we can evaluate it further.

Thanks & Regards,
Dinesh Kumar

The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the =

recipient and may contain privileged information. =

If you are not the intended recipient, please notify the
sender and delete the message along with any =

attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail =

are those of the individual sender except where the sender =

specifically states them to be the views of =

Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer =

system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility =

is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.

--_000_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_
Content-Type: text/html; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	mso-fareast-language:EN-IN;}
span.coderay
	{mso-style-name:coderay;}
span.line
	{mso-style-name:line;}
span.head3
	{mso-style-name:head3;}
span.filename2
	{mso-style-name:filename2;}
span.change3
	{mso-style-name:change3;}
span.directive2
	{mso-style-name:directive2;}
span.predefined-type2
	{mso-style-name:predefined-type2;}
span.integer2
	{mso-style-name:integer2;}
span.delimiter9
	{mso-style-name:delimiter9;}
span.content6
	{mso-style-name:content6;}
span.delete2
	{mso-style-name:delete2;}
span.predefined-constant2
	{mso-style-name:predefined-constant2;}
span.insert2
	{mso-style-name:insert2;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:338700431;
	mso-list-type:hybrid;
	mso-list-template-ids:-407596782 1074331663 1074331673 1074331675 10743316=
63 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">IEC-62443-4-2 has following two requirements related=
 to session termination and session lock.<o:p></o:p></p>
<p class=3D"MsoNormal"><b>CR2.5 Req-1 Session lock: </b>Component should su=
pport session lock after a configurable time period of inactivity<b>.<o:p><=
/o:p></b></p>
<p class=3D"MsoNormal"><b>CR2.6 Req-2 Remote session termination: </b>Compo=
nent should support terminating remote session after a configurable time of=
 inactivity<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">CR2.6 Req-2 can be met by adding system variable TMO=
UT.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For meeting CR2.5 we need following changes in CIP. =
<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">1.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span><![endif]>Systemd code changes<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">2.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span><![endif]>Add deamon which subscribes to dbus notification(sa=
mple code attached)<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">3.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span><![endif]>Add vlock Debian package which performs session loc=
k<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">4.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span><![endif]>Enable dbus in systemd<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Systemd code change are as follows.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<pre style=3D"background:white"><span class=3D"head3"><span lang=3D"EN" sty=
le=3D"color:#484848">--- </span></span><span class=3D"filename2"><span lang=
=3D"EN" style=3D"color:#484848">a/src/login/logind.c</span></span><span cla=
ss=3D"coderay"><span lang=3D"EN" style=3D"color:#484848"><o:p></o:p></span>=
</span></pre>
<pre style=3D"background:white"><span class=3D"head3"><span lang=3D"EN" sty=
le=3D"color:#484848">&#43;&#43;&#43; </span></span><span class=3D"filename2=
"><span lang=3D"EN" style=3D"color:#484848">b/src/login/logind.c</span></sp=
an><span class=3D"coderay"><span lang=3D"EN" style=3D"color:#484848"><o:p><=
/o:p></span></span></pre>
<pre style=3D"background:white"><span class=3D"change3"><span lang=3D"EN" s=
tyle=3D"color:#484848">@@ -1019,7 &#43;1019,7 @@</span></span><span class=
=3D"coderay"><span lang=3D"EN" style=3D"color:#484848"> </span></span><span=
 class=3D"directive2"><span lang=3D"EN" style=3D"color:#484848">static</spa=
n></span><span class=3D"coderay"><span lang=3D"EN" style=3D"color:#484848">=
 </span></span><span class=3D"predefined-type2"><span lang=3D"EN" style=3D"=
color:#484848">int</span></span><span class=3D"coderay"><span lang=3D"EN" s=
tyle=3D"color:#484848"> manager_dispatch_idle_action(sd_event_source *s, ui=
nt64_t t, </span></span><span class=3D"directive2"><span lang=3D"EN" style=
=3D"color:#484848">void</span></span><span class=3D"coderay"><span lang=3D"=
EN" style=3D"color:#484848"> *us<o:p></o:p></span></span></pre>
<pre style=3D"background:white"><span class=3D"coderay"><span lang=3D"EN" s=
tyle=3D"color:#484848">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (m-&gt=
;idle_action_not_before_usec &lt;=3D </span></span><span class=3D"integer2"=
><span lang=3D"EN" style=3D"color:#484848">0</span></span><span class=3D"co=
deray"><span lang=3D"EN" style=3D"color:#484848"> || n &gt;=3D m-&gt;idle_a=
ction_not_before_usec &#43; m-&gt;idle_action_usec)) {<o:p></o:p></span></s=
pan></pre>
<pre style=3D"background:white"><span class=3D"coderay"><span lang=3D"EN" s=
tyle=3D"color:#484848">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; log_info(</span></span><span class=3D"delimiter9"><span l=
ang=3D"EN" style=3D"color:#484848">&quot;</span></span><span class=3D"conte=
nt6"><span lang=3D"EN" style=3D"color:#484848">System idle. Taking action.<=
/span></span><span class=3D"delimiter9"><span lang=3D"EN" style=3D"color:#4=
84848">&quot;</span></span><span class=3D"coderay"><span lang=3D"EN" style=
=3D"color:#484848">);<o:p></o:p></span></span></pre>
<pre style=3D"background:white"><span class=3D"coderay"><span lang=3D"EN" s=
tyle=3D"color:#484848"><o:p>&nbsp;</o:p></span></span></pre>
<pre style=3D"background:white"><span class=3D"delete2"><span lang=3D"EN" s=
tyle=3D"color:#484848">-</span></span><span class=3D"line"><span lang=3D"EN=
" style=3D"color:#484848">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; manager_handle_action(m, </span></span><span class=3D"intege=
r2"><span lang=3D"EN" style=3D"color:#484848">0</span></span><span class=3D=
"line"><span lang=3D"EN" style=3D"color:#484848">, m-&gt;idle_action, </spa=
n></span><span class=3D"predefined-constant2"><span lang=3D"EN" style=3D"co=
lor:#484848">false</span></span><span class=3D"line"><span lang=3D"EN" styl=
e=3D"color:#484848">, </span></span><span class=3D"predefined-constant2"><s=
pan lang=3D"EN" style=3D"color:#484848">false</span></span><span class=3D"l=
ine"><span lang=3D"EN" style=3D"color:#484848">);</span></span><span class=
=3D"coderay"><span lang=3D"EN" style=3D"color:#484848"><o:p></o:p></span></=
span></pre>
<pre style=3D"background:white"><span class=3D"insert2"><span lang=3D"EN" s=
tyle=3D"color:#484848">&#43;</span></span><span class=3D"line"><span lang=
=3D"EN" style=3D"color:#484848">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; manager_handle_action(m, </span></span><span class=3D"=
integer2"><span lang=3D"EN" style=3D"color:#484848">0</span></span><span cl=
ass=3D"line"><span lang=3D"EN" style=3D"color:#484848">, m-&gt;idle_action,=
 </span></span><span class=3D"predefined-constant2"><span lang=3D"EN" style=
=3D"color:#484848">false</span></span><span class=3D"line"><span lang=3D"EN=
" style=3D"color:#484848">, </span></span><span class=3D"predefined-constan=
t2"><span lang=3D"EN" style=3D"color:#484848">true</span></span><span class=
=3D"line"><span lang=3D"EN" style=3D"color:#484848">);</span></span><span c=
lass=3D"coderay"><span lang=3D"EN" style=3D"color:#484848"><o:p></o:p></spa=
n></span></pre>
<pre style=3D"background:white"><span class=3D"coderay"><span lang=3D"EN" s=
tyle=3D"color:#484848"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;m-&gt;idle_action_not_before_usec =3D n;<o:p></o:p></span=
></span></pre>
<pre style=3D"background:white"><span class=3D"coderay"><span lang=3D"EN" s=
tyle=3D"color:#484848">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></span></pr=
e>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It means there are several changes required in CIP a=
s well as it would be difficult to maintain for long term, if we chose this=
 option.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My request is, if anyone has any better idea to achi=
eve session lock, please share so we can evaluate it further.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-IN">Thanks &a=
mp; Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-IN">Dinesh Ku=
mar<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{font-family:"Calibri",sans-serif;}
.MsoPapDefault
	{margin-bottom:8.0pt;
	line-height:107%;}
 /* Page Definitions */
 @page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
 /* List Definitions */
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>





<div class=3D"WordSection1 ">

<p class=3D"MsoNormal" style=3D"margin-top:2.0pt;margin-right:0in;margin-bo=
ttom:2.0pt;
margin-left:0in;line-height:normal;text-autospace:none"><span  style=3D"fon=
t-family: Times New Roman, serif;"><span style=3D"font-size: 16px;">.</span=
></span></p></body>
</html>

--_000_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_--

--_004_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_
Content-Type: text/plain; name="subscribe_systemd_lock_signal.c"
Content-Description: subscribe_systemd_lock_signal.c
Content-Disposition: attachment; filename="subscribe_systemd_lock_signal.c";
	size=1440; creation-date="Wed, 10 Jun 2020 12:16:40 GMT";
	modification-date="Wed, 10 Jun 2020 12:16:35 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGRidXMvZGJ1cy1nbGliLmg+DQojaW5jbHVkZSA8c3RkaW8uaD4NCg0Kc3RhdGlj
IHZvaWQNCnRlc3RfaGludF9zaWduYWxfaGFuZGxlciAoREJ1c0dQcm94eSAqIHByb3h5LA0KICAg
ICAgIGdwb2ludGVyIHVzZXJfZGF0YSkNCnsNCiAgcHJpbnRmKCJJIGFtIGhlcmUiKTsNCiAgZ193
YXJuaW5nICgiQ2FsbCBiYWNrIGlzIGNhbGxlZCIpOw0KfQ0KDQpnaW50DQptYWluIChnaW50IGFy
Z2MsIGdjaGFyICphcmd2W10pDQp7DQoJcHJpbnRmKCJJbiBNYWluXG4iKTsNCglEQnVzR0Nvbm5l
Y3Rpb24gKmRidXNfZ2xpYl9jb25uZWN0aW9uID0gTlVMTDsNCglHTWFpbkxvb3AgKmxvb3AgPSBO
VUxMOw0KCUdFcnJvciAqZXJyb3IgPSBOVUxMOw0KCURCdXNHUHJveHkgKmNvbnRyb2xfcHJveHkg
PSBOVUxMOw0KDQoJZ190eXBlX2luaXQgKCk7DQoNCglsb29wID0gZ19tYWluX2xvb3BfbmV3IChO
VUxMLCBGQUxTRSk7DQoNCglkYnVzX2dsaWJfY29ubmVjdGlvbiA9IGRidXNfZ19idXNfZ2V0IChE
QlVTX0JVU19TWVNURU0sICZlcnJvcik7DQoJaWYgKGVycm9yICE9IE5VTEwpew0KCQlnX3dhcm5p
bmcgKCJGYWlsZWQgY29ubmVjdGluZyB0byBzeXN0ZW0gYnVzOiAlcyIsIGVycm9yLT5tZXNzYWdl
KTsNCgkJZGJ1c19nbGliX2Nvbm5lY3Rpb24gPSBOVUxMOw0KCQlnX2Vycm9yX2ZyZWUgKGVycm9y
KTsNCgl9DQoJaWYgKGRidXNfZ2xpYl9jb25uZWN0aW9uICE9IE5VTEwpew0KCQljb250cm9sX3By
b3h5ID0gZGJ1c19nX3Byb3h5X25ld19mb3JfbmFtZSggZGJ1c19nbGliX2Nvbm5lY3Rpb24sDQog
ICAgICAgICAgICAib3JnLmZyZWVkZXNrdG9wLmxvZ2luMSIsDQogICAgICAgICAgICAiL29yZy9m
cmVlZGVza3RvcC9sb2dpbjEvc2Vzc2lvbi9fMzIiLA0KICAgICAgICAgICAgIm9yZy5mcmVlZGVz
a3RvcC5sb2dpbjEuU2Vzc2lvbiINCiAgICAgICAgICAgICk7DQoJCWlmIChjb250cm9sX3Byb3h5
ID09IE5VTEwpDQoJCXsNCgkJCWdfd2FybmluZyAoIkZhaWxlZCB0byBnZXQgcHJveHkiKTsNCgkJ
fQ0KICAgIH0NCglpZiAoY29udHJvbF9wcm94eSAhPSBOVUxMKXsNCiAgICAgICAgZGJ1c19nX3By
b3h5X2FkZF9zaWduYWwoIGNvbnRyb2xfcHJveHksDQogICAgICAgICAgICAiTG9jayIsDQogICAg
ICAgICAgICBHX1RZUEVfSU5WQUxJRA0KICAgICAgICAgICAgKTsNCg0KCQlkYnVzX2dfcHJveHlf
Y29ubmVjdF9zaWduYWwoIGNvbnRyb2xfcHJveHksDQogICAgICAgICAgICAiTG9jayIsDQogICAg
ICAgICAgICBHX0NBTExCQUNLKHRlc3RfaGludF9zaWduYWxfaGFuZGxlciksDQogICAgICAgICAg
ICBOVUxMLA0KICAgICAgICAgICAgTlVMTA0KICAgICAgICAgICAgKTsNCg0KICAgIH0NCg0KCWdf
ZGVidWcoIlN0YXJ0aW5nIG1haW5sb29wIik7DQoJZ19tYWluX2xvb3BfcnVuIChsb29wKTsNCg0K
CXJldHVybiAwOw0KfQ0K

--_004_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4792): https://lists.cip-project.org/g/cip-dev/message=
/4792
Mute This Topic: https://lists.cip-project.org/mt/74795832/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--_004_3999decc9e9743b7b4061b38b91f4575TOSHIBATSIPCOM_--
