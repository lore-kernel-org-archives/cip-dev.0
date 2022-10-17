Return-Path: <sarath_pt@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E89C433FE
	for <webhook@archiver.kernel.org>; Mon, 17 Oct 2022 13:01:33 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web08.40462.1666011691397465159
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Oct 2022 06:01:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: sarath_pt@mentor.com)
X-IronPort-AV: E=Sophos;i="5.95,191,1661846400"; 
   d="scan'208,217";a="84709955"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 17 Oct 2022 05:01:09 -0800
IronPort-SDR: pPhlqfCNZKUk2GraZjrwGUM5Be28UDNbrUCfQ8snN5eL8EIDnoR9PtOknacGGV2GqnUPrKcg44
 DPs6wGjwA/lNW2YqgsyAx0RKjVbuOBP7fYOVokpeZzd9IeWgrq5Nq9fD4zBTyMx7IzfIzj1rDk
 O2jFF/KCPHB9jSntXOGoJvV2NLHneUNIERQ1ZHDlHY4ng15EAY5+D68gH2VbWlm1cYDnoYhoBK
 zrrq+oLEUXLxIN+MK3jFxoI+I1TAf6qvTpEaKKlLQgY+7stnV1ya+F7mOdBihFr3lLVczBERps
 WTs=
From: "P T, Sarath" <Sarath_PT@mentor.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Tests run on CIP-LAVA platform
Thread-Topic: Tests run on CIP-LAVA platform
Thread-Index: Adjh9pXyvPJeWbcCTVG87YJuWZoCXgALVGaA
Date: Mon, 17 Oct 2022 13:01:04 +0000
Message-ID: <6f438000c8004b20b927ac2d992238dd@mentor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.34.91.1]
Content-Type: multipart/alternative;
	boundary="_000_6f438000c8004b20b927ac2d992238ddmentorcom_"
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Oct 2022 13:01:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9767

--_000_6f438000c8004b20b927ac2d992238ddmentorcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Team ,

I can see in Linaro/test-definitions (https://github.com/Linaro/test-defini=
tions/tree/master/automated/linux) there are 123 test-suites are present bu=
t only 4 test-suites are running on cip lava ?

Few more queries I am having regarding this.
      i)   Is CIP  running the full QA of Linaro/test-definitions test-suit=
es in any other platform ?
      ii)  All of the tests which has been run in the LAVA CIP platform is =
2mins duration. Is there a particular reason for choosing these much durati=
on of tests ?

Regards
Sarath P T


From: P T, Sarath
Sent: 17 October 2022 12:34
To: 'cip-dev@lists.cip-project.org' <cip-dev@lists.cip-project.org>
Subject: Tests run on CIP-LAVA platform

Hi Team,

I could able to see there are few tests are running in the CIP LAVA platfor=
m. I am showing the list below what all LAVA tests are running in the CIP L=
AVA platform.


Test-case

CIP LAVA job link

Status

Comments


i)                 spectre-meltdown-checker-test

https://lava.ciplatform.org/scheduler/job/686074

Not run

Reason of failure

./spectre-meltdown-checker.sh: Permission denied.


ii)               hackbench

https://lava.ciplatform.org/results/634343

PASS




iii)             cyclictest

https://lava.ciplatform.org/results/634097

SKIP

Reason of failure

$ ./cyclictest.sh -D 2m -p 98 -i 1000 -t 1 -a 0 -h '' -w '' this command is=
 giving "/usr/bin/cyclictest: unrecognized option" error


iv)              cyclicdeadline

https://lava.ciplatform.org/results/633692

Not run

Reason of failure


while executing cyclicdeadline.sh getting an error like

/usr/bin/cyclicdeadline: invalid option -- 'q'



Is there any specific reason why few test-cases are running through LAVA ?


Regards

Sarath P T


--_000_6f438000c8004b20b927ac2d992238ddmentorcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:-apple-system;}
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
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
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
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:571349227;
	mso-list-type:hybrid;
	mso-list-template-ids:1799420930 1074331663 1074331673 1074331675 10743316=
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
@list l1
	{mso-list-id:880089531;
	mso-list-type:hybrid;
	mso-list-template-ids:985673192 1074331663 1074331673 1074331675 107433166=
3 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l1:level1
	{mso-level-start-at:3;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1418867105;
	mso-list-type:hybrid;
	mso-list-template-ids:-2115962418 1074331663 1074331673 1074331675 1074331=
663 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l2:level1
	{mso-level-start-at:3;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3
	{mso-list-id:2048095819;
	mso-list-type:hybrid;
	mso-list-template-ids:-1634539996 1474486544 1074331673 1074331675 1074331=
663 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l3:level1
	{mso-level-number-format:roman-lower;
	mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:54.0pt;
	text-indent:-36.0pt;
	mso-ansi-font-size:10.5pt;
	font-family:-apple-system;
	color:#172B4D;}
@list l3:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l4
	{mso-list-id:2074110938;
	mso-list-type:hybrid;
	mso-list-template-ids:-1106091848 1074331663 1074331673 1074331675 1074331=
663 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l4:level1
	{mso-level-start-at:3;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l4:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l4:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level9
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
<p class=3D"MsoNormal">Hi Team ,<span style=3D"color:#1F497D"><br>
<br>
</span><span style=3D"font-family:-apple-system;color:#242424;background:wh=
ite">I can see in Linaro/test-definitions (</span><a href=3D"https://github=
.com/Linaro/test-definitions/tree/master/automated/linux" target=3D"_blank"=
 title=3D"https://github.com/Linaro/test-definitions/tree/master/automated/=
linux"><span style=3D"font-size:10.5pt;font-family:-apple-system;color:#4F5=
2B2;background:white;text-decoration:none">https://github.com/Linaro/test-d=
efinitions/tree/master/automated/linux</span></a><span style=3D"font-family=
:-apple-system;color:#242424;background:white">)
 there are 123 test-suites are present but only 4 test-suites are running o=
n cip lava ?</span><span style=3D"color:#1F497D"><br>
<br>
</span>Few more queries I am having regarding this.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i)&nbsp;&nbsp;&nbsp;Is CIP&nbsp;&nbsp;r=
unning the full QA of Linaro/test-definitions test-suites in any other plat=
form ?
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ii)&nbsp;&nbsp;All of the tests which h=
as been run in the LAVA CIP platform is 2mins duration.
<span style=3D"font-family:-apple-system;color:#242424;background:white">Is=
 there a particular reason for choosing these much duration of tests ?</spa=
n><span style=3D"color:#1F497D">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><br>
</span>Regards<br>
Sarath P T<span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><br>
<br>
<o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-fareast-languag=
e:EN-IN">From:</span></b><span lang=3D"EN-US" style=3D"mso-fareast-language=
:EN-IN"> P T, Sarath
<br>
<b>Sent:</b> 17 October 2022 12:34<br>
<b>To:</b> 'cip-dev@lists.cip-project.org' &lt;cip-dev@lists.cip-project.or=
g&gt;<br>
<b>Subject:</b> Tests run on CIP-LAVA platform<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Team,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I could able to see there are few tests are running =
in the CIP LAVA platform. I am showing the list below what all LAVA tests a=
re running in the CIP LAVA platform.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" style=3D"border-collapse:collapse">
<tbody>
<tr>
<td width=3D"170" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">Test-=
case</span></strong><o:p></o:p></p>
</td>
<td width=3D"306" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">CIP L=
AVA job link</span></strong><o:p></o:p></p>
</td>
<td width=3D"53" valign=3D"top" style=3D"width:116.9pt;border:solid windowt=
ext 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">Statu=
s</span></strong><o:p></o:p></p>
</td>
<td width=3D"158" valign=3D"top" style=3D"width:116.9pt;border:solid window=
text 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:#F4F5F7">Comme=
nts</span></strong><o:p></o:p></p>
</td>
</tr>
<tr>
<td width=3D"170" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:54.0pt;text-indent:-36.0=
pt;mso-list:l3 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">i)<span style=3D"font:7.=
0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">spectre=
-meltdown-checker-test</span><o:p></o:p></p>
</td>
<td width=3D"306" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/scheduler/job=
/686074">https://lava.ciplatform.org/scheduler/job/686074</a><o:p></o:p></p=
>
</td>
<td width=3D"53" valign=3D"top" style=3D"width:116.9pt;border-top:none;bord=
er-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid window=
text 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">Not run<o:p></o:p></p>
</td>
<td width=3D"158" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#C00000;letter-spacing:-.05pt;background:white;font-wei=
ght:normal">Reason of failure
<o:p></o:p></span></strong></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.5pt;font-family:-appl=
e-system;color:#172B4D;letter-spacing:-.05pt;background:white"><br>
<strong><span style=3D"font-family:-apple-system">./spectre-meltdown-checke=
r.sh</span></strong></span></b><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">: Permi=
ssion denied.</span><o:p></o:p></p>
</td>
</tr>
<tr>
<td width=3D"170" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:54.0pt;text-indent:-36.0=
pt;mso-list:l3 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">ii)<span style=3D"font:7=
.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">hackben=
ch</span><o:p></o:p></p>
</td>
<td width=3D"306" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/results/63434=
3">https://lava.ciplatform.org/results/634343</a><o:p></o:p></p>
</td>
<td width=3D"53" valign=3D"top" style=3D"width:116.9pt;border-top:none;bord=
er-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid window=
text 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">PASS<o:p></o:p></p>
</td>
<td width=3D"158" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</td>
</tr>
<tr>
<td width=3D"170" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:54.0pt;text-indent:-36.0=
pt;mso-list:l3 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">iii)<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">cyclict=
est</span><o:p></o:p></p>
</td>
<td width=3D"306" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/results/63409=
7">https://lava.ciplatform.org/results/634097</a><o:p></o:p></p>
</td>
<td width=3D"53" valign=3D"top" style=3D"width:116.9pt;border-top:none;bord=
er-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid window=
text 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">SKIP<o:p></o:p></p>
</td>
<td width=3D"158" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#C00000;letter-spacing:-.05pt;background:white;font-wei=
ght:normal">Reason of failure
<o:p></o:p></span></strong></p>
<p class=3D"MsoNormal"><span style=3D"color:#172B4D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:-apple-s=
ystem;color:#172B4D;letter-spacing:-.05pt;background:white">$<strong><span =
style=3D"font-family:-apple-system"> ./cyclictest.sh -D 2m -p 98 -i 1000 -t=
 1 -a 0 -h '' -w ''</span></strong> this
 command is giving <strong><span style=3D"font-family:-apple-system">&#8220=
;/usr/bin/cyclictest: unrecognized option&#8221;
</span></strong>error</span><o:p></o:p></p>
</td>
</tr>
<tr>
<td width=3D"170" valign=3D"top" style=3D"width:116.85pt;border:solid windo=
wtext 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoListParagraph" align=3D"right" style=3D"margin-left:54.0pt;t=
ext-align:right;text-indent:-36.0pt;mso-list:l3 level1 lfo2">
<![if !supportLists]><span style=3D"font-size:10.5pt;font-family:-apple-sys=
tem;color:#172B4D"><span style=3D"mso-list:Ignore">iv)<span style=3D"font:7=
.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#172B4D;letter-spacing:-.05pt;background:white">cyclicd=
eadline</span><o:p></o:p></p>
</td>
<td width=3D"306" valign=3D"top" style=3D"width:116.85pt;border-top:none;bo=
rder-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wind=
owtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/results/63369=
2">https://lava.ciplatform.org/results/633692</a><o:p></o:p></p>
</td>
<td width=3D"53" valign=3D"top" style=3D"width:116.9pt;border-top:none;bord=
er-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid window=
text 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal">Not run<o:p></o:p></p>
</td>
<td width=3D"158" valign=3D"top" style=3D"width:116.9pt;border-top:none;bor=
der-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windo=
wtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt">
<p class=3D"MsoNormal"><strong><span style=3D"font-size:10.5pt;font-family:=
-apple-system;color:#C00000;letter-spacing:-.05pt;background:white;font-wei=
ght:normal">Reason of failure
<o:p></o:p></span></strong></p>
<p style=3D"margin:0cm;margin-bottom:.0001pt;background:white"><span style=
=3D"font-size:10.5pt;font-family:-apple-system;color:#172B4D;letter-spacing=
:-.05pt"><br>
<br>
while executing <strong><span style=3D"font-family:-apple-system">cyclicdea=
dline.sh</span></strong> getting an error like</span><span style=3D"color:#=
172B4D"><o:p></o:p></span></p>
<p style=3D"background:white;margin:0.75rem 0px 0px;box-sizing: border-box;=
font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;white-s=
pace:pre-wrap;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thic=
kness: initial;text-decoration-style: initial;text-decoration-color: initia=
l;word-spacing:0px">
<strong><span style=3D"font-size:10.5pt;font-family:-apple-system;color:#17=
2B4D;letter-spacing:-.05pt">/usr/bin/cyclicdeadline: invalid option -- 'q'<=
/span></strong><span style=3D"font-size:10.5pt;font-family:-apple-system;co=
lor:#172B4D;letter-spacing:-.05pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Is there any specific=
 reason why few test-cases are running through LAVA ?
<br>
<br>
<br>
Regards <br>
<br>
Sarath P T <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_6f438000c8004b20b927ac2d992238ddmentorcom_--

