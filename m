Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EBAC83F27
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 14:04:45 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.68])
 by mx.groups.io with SMTP id smtpd.web10.16921.1724940276419116605
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Aug 2024 07:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=VHPWHvI5;
 spf=pass (domain: renesas.com, ip: 52.101.125.68, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRQ6vdsW7/64ADJSXXezx+oYq3gxwNoo7adamSGxtgVbdejOTI7o1//0sFQoqFq4jRgpxhMMqUkPT4JIMT/fYtdFgFEkOx+d1I7JcMZcx/yIzmUv+vrxv9BjyZyYu6bDU/ssJXic1YKcDhsSskuQe/Ku474UEQsQhQzhROnjm5B9Q156o8oui3vkU7CXusmjAh/b29ylni4EonAGFLMFV689MG8lbpReo/Bq5FOkrOQvUuo+moL+WXxgTOGt/Z7kqnFedJC110OHGPxHz2KQTwv+OeiihU74GtAPshsBnvLcGokDPu3SJtVFlXBavpw800Een3qEKRfnxvlk/p5rpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ez1Ws9DFgluv9bhRqovZ9eQhJgpO9Ywt7hJZoJl4qA=;
 b=RDkVfAJ9S96cR8PrJT9yo2vAZvxriQbX4hd3nRtgBSaa+CrSRawHx2eMR8ROc4K71evumWiO5D5QRtGgvCHEo84s9yhd8xtN5m6Vcz/4TW+cQ5Rs1b8wNlz+kSJfuwyxy/EMhz1+kKbZ4erGoYmFaUkKiIqdLVFTHA8kEHp4tgV+Q9UillCO7ZnS/SJ9YAalr5e27M8iw34/pxjBwErTQzLLSB1e9FfWJesMxD+hZvjdS8S0UVaoHzqloPwofA7peZwGzCmBOLud5RLrhzgfCmKnhB4YOG36XyWA77Lf9pC4hr/wEjd+AYUkjjknUTvifbyeSoYdXDKChX+ArsAApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ez1Ws9DFgluv9bhRqovZ9eQhJgpO9Ywt7hJZoJl4qA=;
 b=VHPWHvI5LutZ0fJZbtw5vC4BJKAWabztLbFauY08bF2Kclnp6/ippN60La8dtRvlss6rSsvUn6y+I1tzc98hCJ4syXLwkQmR8B5BXVU54u6hPg3R4aHXQ5LPb7dnT1lAQyIsYBRkkxV0XtRiQWmn4XfL/Wty6faC/iDaDrpvBvk=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TY4PR01MB13001.jpnprd01.prod.outlook.com (2603:1096:405:1dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 14:04:32 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 14:04:32 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>, "Adler,
 Michael" <michael.adler@siemens.com>
Subject: RE: Issue with 'small' Gitlab runners
Thread-Topic: Issue with 'small' Gitlab runners
Thread-Index: Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEw
Date: Thu, 29 Aug 2024 14:04:31 +0000
Message-ID: 
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TY4PR01MB13001:EE_
x-ms-office365-filtering-correlation-id: 2d841224-7b43-4cdf-47bf-08dcc8338167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?d+nurwnvfX+bine9oS26OhYRaTokovkJixf1Xj7/MRGScj+TK/UbB2+6?=
 =?Windows-1252?Q?WiixZ4DX62scpyD/TOwNhNaTRZdoSxT7XqGgiXgkTlaAtd9Q7k7K0geL?=
 =?Windows-1252?Q?STSB+mJyIkEM1/x0V1xVq1dKOX5WNYiaK0+pgavVBrmbYwiDwIyz3KhD?=
 =?Windows-1252?Q?UU31jpQOCPLGnDfQHAuYVVfIR1WKXPLWfS+Wz0U2Bjmu946qawc1uCQs?=
 =?Windows-1252?Q?NpGlEnTtyU3coZy8ThVzNi1jYyh2uVI5Pjm7FXNeVb++cQfEiVqLWJmm?=
 =?Windows-1252?Q?4nevMP9hePMZ7TW4dL8R6jyt8fI6hKr92jLIH+bH8r1EDBHNKsba8R3n?=
 =?Windows-1252?Q?4ECf0658+QKogxGtsj/mYhc68S0WLlhaW436RIClj97eLLyjQcT88Zk+?=
 =?Windows-1252?Q?GZ/Y1CjrqyoLsj8uP8MyZ+AnmWgEz/dy1Pdy/ZOieatY0zLXMVAEPUsw?=
 =?Windows-1252?Q?Tpr5WC9JXkk/bkp/VzL2Z3e70bqP3iHxGChaun3Tmnk16vLyXwJ8WCPg?=
 =?Windows-1252?Q?KBjJ6gkWduKGyq0ZPrZTIIX9BeTEpi6mFQSMGQwRzZ06I/KVRUdfrXeC?=
 =?Windows-1252?Q?yufkXy95fm0aNKRWJGL4OjfY1UN2oFZ8qaAz6577tiT214WJarn02QXi?=
 =?Windows-1252?Q?qOuaTvGpzG2WmFYYW+RED/QgTiO9O0Q6W5cKj8hV8PQX7DksZ/UMl3Fs?=
 =?Windows-1252?Q?R78Mls1CDDPsBOFLbigKdBF7nptv0qHbV/0CbCSaVdiLP9YGpOaaJ0lC?=
 =?Windows-1252?Q?Xmi573cStQWYV0VIt6ZW3wJs+aWD1kjGL0S0OnJu4pxNdaYSOjLmcZ5S?=
 =?Windows-1252?Q?rfQqVj+BZgZ1RoHhwLNqjcuthNUDAsvAu/1+T16PziAS7eVfY6LyLitm?=
 =?Windows-1252?Q?JMEDKUZDcPq4T/xWD1SAYs4dLXRjFfUrkcT4wBmODr94yYL8Ngju9tRm?=
 =?Windows-1252?Q?R4YFxXO6drVCnsqp00k3sJPR77ObeRRboZ1OrIQdAqrpq3UTEBm34Q5Z?=
 =?Windows-1252?Q?kKMfA90f8t5IhKSM4+U3vfZWYojhu0KQlu3jURbYj70Tk2BaTSdQz16K?=
 =?Windows-1252?Q?pddHtYDUJGOTJMAcNu2nf2CdENu4PuJVlsk2yVzvtbk1+jr3kEWnHjzr?=
 =?Windows-1252?Q?kCVx3O4qFQtvF+U5QU64tyL/omekKkvALngujfiGZ29NsW116NN7aKdz?=
 =?Windows-1252?Q?bJrLUBJs9NIfNOPaUapKU39bUrcoqO7Ajww1fu944CMNzgTniIztPjHR?=
 =?Windows-1252?Q?41e4RkX6bNrYCfdPJDWrT8/NMyU85aJ2ZqPctsHJEX5kW1/UVmr3FydQ?=
 =?Windows-1252?Q?bbEEO0NcrYIaFoB92Sdp9oVVf8ztjHBW5KvKz79Ub57ns10qR8z+UQFZ?=
 =?Windows-1252?Q?zxleOo+m+3bEX6mKuMH4bdrFjvvSq9Xuh2UD/+htSNwDd4gW7xOB6r74?=
 =?Windows-1252?Q?wxl1ES+poPR3DNCAOfp17bisQGCD0hVLnyCeldklSmbXqilFmymJBjpd?=
 =?Windows-1252?Q?rd42bVbOjr+i3DV3eCIaFaxTsa7mDQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?GHPzeOe/b5FRTIKDKLFgkuvqk+6daEinWaGRdz5YOOCrWz4oZfd6IgUx?=
 =?Windows-1252?Q?/Aaibn5IVx0c4LI+buE7oa56iZ2+uhaphPyl7B+m4F647dM9o1n3PDfO?=
 =?Windows-1252?Q?wDpeKgY/ul4Vxy11pFvFLHen15HEeXGnatKfAyCQjPlMMdI0rzWgAV36?=
 =?Windows-1252?Q?7wTXXvkLMceXN/EK15I4KMehwisXOVobPqEKOk+TvJCt2wmBVNYTqcl0?=
 =?Windows-1252?Q?mclKS3msrrKyLkenPKz/0ngilS8aoC73JJp70Z/MHw7CJA/klc6YCQB7?=
 =?Windows-1252?Q?F5amm/xedgiWWp2DVhV+PV+BW0oLBlgd77kt/xH+zQPyd9zIiYf3eSWH?=
 =?Windows-1252?Q?sO637VYYqFAmpDe//JRqCFOS26EK/ip2eUAFO2MFplEzsqYLuIMWlrLG?=
 =?Windows-1252?Q?h7t/7u8rZ5Qyj0V2P+6AvLx1IVC6l+cScpbcAcJVTzvLCq8Ta6EJi8tM?=
 =?Windows-1252?Q?vfcs3kWLEGicgGZW3VvDtsXpZ6IFN6MlV8DK/Rx0O404gqu14vq54mex?=
 =?Windows-1252?Q?pTzpeH8q/M8Nl42jYeEHvwminMcuOUEoMH/V/wrP1gljRmyZ/dFPjjts?=
 =?Windows-1252?Q?yUSXlnZaWnbi/oQt0CgvmO4hJYwIsZDeXOKlJQlE0EOENihQsGVYigD4?=
 =?Windows-1252?Q?Q+zIRQ9sLb15Xz1Y6sfAkAiqSVdYupOBQSFcWmc8U6vKy9gFcczCG7gW?=
 =?Windows-1252?Q?vB6hgaH6yxllaokW7yQ/uB7ccN45Pssf6iBxZr9bAayX9qG8S4Q4evxU?=
 =?Windows-1252?Q?nYqEkbkfpCx6USezO3Y8O2IPsKH7nOECXqu/gOMf/Ko4GjEETOXPT2K+?=
 =?Windows-1252?Q?pq/7dtP2Jd+Ghy4QHb9jXMF3YO5tYB2hjBBbbp5fZDyJUfjcAHRsSjvj?=
 =?Windows-1252?Q?2zUqYho0jM9PFUKbwNn32KrKVoAQb6AxiLcPyc5YwoiPToA1ssMDnaCj?=
 =?Windows-1252?Q?5Rjs0HyFcT0mlSTbTsKucCFjeSCFBytQCzwpoYlHWavQ40HYO8dz3erH?=
 =?Windows-1252?Q?1ZCFyYWSPruLaW1n0z23cs07EWA7IRS2YGOTFU0p6zXeMo6j7gOs9kwJ?=
 =?Windows-1252?Q?3U8adGYU3P3b8Byzdjoh54RJq+dDL27OMosoIiZ29hLcY4kmjY5dUSEM?=
 =?Windows-1252?Q?niXbIRi8+0MLpncSmpYO+MaSFf1ASkg9d/sfUaXkyTVNMGSEwGhYg0aG?=
 =?Windows-1252?Q?w4SSuRbD2NGHwKwVp6KPVDW2YfeGepZUhdn4P5sRhZTOhSFj4GUQx/9i?=
 =?Windows-1252?Q?u06tGx6Ri+gumQayQd6u++d6+gByAye/gHrjiH0uVlPOeOKZiaXe3nN3?=
 =?Windows-1252?Q?/onLPHqkTFOGr3n5+r5WnvlJFHxDQ29I80Sf8oJw5szXg3WmI63eoP2A?=
 =?Windows-1252?Q?AMkF65Zr7wnL6ZljFr7+RHpmo6QmEU9WUHsql0Y/WyIkzwBYLq/zcfbV?=
 =?Windows-1252?Q?bF21eu24nz0CzOoogIQdvcDB/BSB1gjQbS+6iBCj6/4XAsLKMW4TNUyV?=
 =?Windows-1252?Q?YDLOl7UKNl5r7Fgdc438P9AWfgiP7Ou2IAg7bXchsvsd56fElJHgaL8V?=
 =?Windows-1252?Q?3HPPbJ12j7odwyCG4HJVQUbC1YXj0FMohnRPamAxZczRDg8NEp0c6EYm?=
 =?Windows-1252?Q?Jht5NFZNal7Y+lZXj2Yi/tCH/8nXwyhwxXNv7E/davLOL71qlSwwPOrf?=
 =?Windows-1252?Q?TClF5vEYv8q+QPubyDnEdhClbZLzmVpof8i4eOcXZ5eIR4blw2UhXA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB12402CF459412685A6824CB45B7962TYYPR01MB12402jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d841224-7b43-4cdf-47bf-08dcc8338167
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 14:04:31.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFvQehm+0KArbjgAi1irwOgo3wSatxykKmShnPwiQWYyG/2hox8Ewjk484KnodIVexX4GqUOZjD4cMlLC9T9xli1lEE2o447cGM1BueHar8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Aug 2024 14:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16834

--_000_TYYPR01MB12402CF459412685A6824CB45B7962TYYPR01MB12402jp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Sai,

I=92m not sure of the cause of this.
The job is quite happily running on that very same pod. I=92m not sure why =
the pod would be destroyed before the GitLab job actually finishes.

Do you know if the final aws s3 sync actually happens?

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Thursday, August 29, 2024 1:54 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; dinesh.=
kumar@toshiba-tsip.com
Subject: Issue with 'small' Gitlab runners

Hello Chris,

The cve-checks job in isar-cip-core uses =93small=94 Gitlab runners. Previo=
usly, there was no issue but recently it is getting stuck in the middle wit=
h this error message -> pods "runner-zwslwy9eu-project-10191315-concurrent-=
0-n51tahuh" not found.

cve-checks (#7693633828) =B7 Jobs =B7 cip-project / cip-core / isar-cip-cor=
e =B7 GitLab<https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7=
693633828>

Can you please look into this issue ?

Thanks and regards,
Sai Ashrith Sathujoda

--_000_TYYPR01MB12402CF459412685A6824CB45B7962TYYPR01MB12402jp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Hello Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">I=92m not sure of the cause of this.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">The job is quite happily running on that very same pod. I=92m not sure=
 why the pod would be destroyed before the GitLab job actually finishes.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Do you know if the final aws s3 sync actually happens?<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none">Kind regards, Chris<o:p></o:p></span>=
</p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> Sai.Sat=
hujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Thursday, August 29, 2024 1:54 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; =
dinesh.kumar@toshiba-tsip.com<br>
<b>Subject:</b> Issue with 'small' Gitlab runners<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello Chris,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The <b>cve-checks</b> job in is=
ar-cip-core uses =93small=94 Gitlab runners. Previously, there was no issue=
 but recently it is getting stuck in the middle with this error message -&g=
t;
<b>pods &quot;runner-zwslwy9eu-project-10191315-concurrent-0-n51tahuh&quot;=
 not found</b>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://gitlab.com/c=
ip-project/cip-core/isar-cip-core/-/jobs/7693633828">cve-checks (#769363382=
8) =B7 Jobs =B7 cip-project / cip-core / isar-cip-core =B7 GitLab</a><o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Can you please look into this i=
ssue ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards, <o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith Sathujoda &nbsp;<o:=
p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYYPR01MB12402CF459412685A6824CB45B7962TYYPR01MB12402jp_--

