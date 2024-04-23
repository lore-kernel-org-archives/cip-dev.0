Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA05C4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 11:54:02 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.75])
 by mx.groups.io with SMTP id smtpd.web11.16376.1713873235297895589
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 04:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=MtkpWtBY;
 spf=pass (domain: renesas.com, ip: 40.107.114.75, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOEFEGnBaPQQXRF+vj6/JQGjJ9IY+Eh6Si9xu3uoQWnVVLhD2nv+N3oxD5SYF0/GLNA0WjXVl2i+wokPvF43yGKNmaziWKIj3jSMgc/gMzvR/9Wc4wETo/c89LWUo8khvAuwBK6Fl6BuAqUngwxhc0Go9MhbcvdQtTVRwcakZ+NbxVW+UVEXxjNBP9SCJDC6y+wZ7r+NbzwIGym7ECpUdWJW465KhB2igvusq1zfbUEoqkK2pKqfCnBcv2zeVPggCReFC2Ut03ACV68ArBkzB2q+tLxvLS8hsUq46nvjy6bpiNc7ajrQkz7Movg3itKCCZoOu+9pogC2gHoZknbdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYw/c/BMcn104GJbvtakqqMcjScred9XuLsz9dA3+ew=;
 b=JYDZ1xHim8H31v32yssTbWr7W/zEHCQHF+DVEe2By5Ga6wge6gs8dwZcXpsAnnnn2E3T5CQvsrWeCVX9cnI1g1nO5dwNkam7GPGEGmJTquDelKz1aCVNKswtzGmLcsObYkeUZebGvz2ZcDPwMRxLyIZ5fTssqtCUnW/rOEixNyHlPsPX2IuKAYFGN60EWPZRy8AKXk0x3IzstwijUVVQKCbMfx8g593RXYoA3AamlilXKcI006wz6GJAMWRKlj6eQ6gfqlpqFQwtyd2U7GZlC1eTW5q5QDznTF7Ygxjs1L4HSbL/auded2uPEUEIRN4JGyZiGhmlWFoUWnGseXWdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYw/c/BMcn104GJbvtakqqMcjScred9XuLsz9dA3+ew=;
 b=MtkpWtBYP+qM3LcROg2FHGAIQqY2oCLTfkmZ9kxunrkcmEZPlSjK6XDvoz0riPjice4kmwJ/vt7ORa67FGLlx57fh4BlRIjHr7Jxyd6G3mCGY0JLFFvv2b9by+baflebTNBsHPha/++HFlN9hPpoa1dq3Z6Qy+Vl1QSOEYVgeI8=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB11620.jpnprd01.prod.outlook.com (2603:1096:400:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:53:50 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:53:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Request for review
Thread-Topic: Request for review
Thread-Index: AdqReXLWuxh2CefnRPmS/nUttLvDRgD+2Zcg
Date: Tue, 23 Apr 2024 11:53:50 +0000
Message-ID: 
 <TYWPR01MB11862444EBF1D061F158EAA5BB7112@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103707207861000A78DD172C20E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103707207861000A78DD172C20E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB11620:EE_
x-ms-office365-filtering-correlation-id: 6d37b86c-cd62-47b5-5e69-08dc638c0ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?5aJcV/JYFZIQAsHvWhRtvap8Nlx16B+6oPTncR1bYLjWdUhnHRGDRKBv?=
 =?Windows-1252?Q?EFTIzzOGiF2pqIYx2c9u7DIEL8/UeQMS1x4nXETytmztnPo9tryqWIaL?=
 =?Windows-1252?Q?0DsrK4K9nhUKSEo8P8IB63PvyuGVzOTwRCbDsQ+MN6VgEdbpcmacYtU1?=
 =?Windows-1252?Q?zU5Sy1I2gVVXlll8q5XEsJJW5fsbEEKSdCVeV/6R9vt50+BSdtAUPd4k?=
 =?Windows-1252?Q?QrbeP0DzxKvUCxOHBcO/wJ5/iztGj0ZcM4v9z/JCJK2k/RrWT9cA+cyg?=
 =?Windows-1252?Q?FNWgHg0Vjdpj2qFeMzmxbBDTn25uk5h+7X//6xhJKB68W7bal06zEKEz?=
 =?Windows-1252?Q?pTPqcYCBR9ZPX5tfbJd8KlhGX8bFN8Xcpm0E+BcOas8KCzHssH9qd0XI?=
 =?Windows-1252?Q?yvdyQUD9ulLUqi6c8zhp+2LL3lzX71QJr+x8MprIuLmSj5wfxy29rzl+?=
 =?Windows-1252?Q?f6NorNuTmqbfBUoST8e8F0cnqCZTbIPD0om4B0hP6vnhBSgqpfmhWSNf?=
 =?Windows-1252?Q?QvFWQug6rHxW3peDn11Ju5fF3cRuMtUgA9qBVdeUZKftJxvNMY0IOW2w?=
 =?Windows-1252?Q?6HahcZpbcHZmxLZJyRBpbl06pXCKPOzzTrPw19A46QYxumuAc/1McZ29?=
 =?Windows-1252?Q?JDeymxIx3Tl0jHvHk8JbNr78DqCVmgI5LrA8nN7h9kt26ISQl9BCe9gX?=
 =?Windows-1252?Q?PXRqGq7rjyH1bBnOnJDIXUtoKya7CQGQ9ya2JYYs/+anmhe9epAzR7k0?=
 =?Windows-1252?Q?6k43yXwfcspJZopw+HjuqADCN0r+SRTf3UI3tGPoR0Bi2EE0r/nIrafS?=
 =?Windows-1252?Q?Hb5QNMZvNLUxBh4smFI9VzMyKHa9Q38HqrtVt6FvTj7Ky/adFjy3NKca?=
 =?Windows-1252?Q?JXByXHspRSrzang+lWkX1QjMgG+shE5VcthJ2R8CZTqCw8sMnNZuEpYT?=
 =?Windows-1252?Q?uNT9Xzbi/Xw/DxhH+GkBbwrLzi8kDa2d1IRO4ReVcgj92bGBhmuabCel?=
 =?Windows-1252?Q?TG1k0wWrkUJSi/BmALxx/kEen864Pm99W7p58dGInVo+d6BIYuS4bdl7?=
 =?Windows-1252?Q?gSoEG2LkxajEZRoBatn0f+w4n6F5H/+Kl/pRtVdL/qpjaDHjrXWIqlsl?=
 =?Windows-1252?Q?bCstNV3nGbbTynAIRqfNfHATPwqAdD34z2g+pcWYBTdHefyFwA6zDVow?=
 =?Windows-1252?Q?+TRJ40CDykalIPB57A++VlS7y7AnS5m9VzXksTqgBQQPip/TNM87mlcb?=
 =?Windows-1252?Q?Hk9Gv/7ZUVjwcEGgkuvW8LsBp8o/nM79y9OUxvHKluORPqZKJv9zkEPP?=
 =?Windows-1252?Q?UoGr8A7fayYKV91wk5uQeHgFnRjs6jdxqhF4KUc8QOVUvTelQPFRbGYT?=
 =?Windows-1252?Q?rq3ynFtQwJFmle0AknHwtPxO5crMMNcSnaFOHpr/y/Hczi3/xgGr7jV8?=
 =?Windows-1252?Q?l8tf5ToWeIoh5M4cqzUnhw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?lCdlpowEY+0Zjr4i49PADZ4VRRH3hcddCYAiHDyCoh2aABewL/1XoojF?=
 =?Windows-1252?Q?zISX9dc4qq+67KMlmv07QXWPdA/PFePpJasgnQvTR9xqKOWZiapNhKIv?=
 =?Windows-1252?Q?nhDBD+iMcoZJqRQFG0EthF9Ij0pyajQ2OWNHztBmtiQaFkAAoL25LOzw?=
 =?Windows-1252?Q?F38E+jaaC/1ZunvOxsYv5H5NO01PTpZdvdhTjsLW5i4JMV2lnOUNIq63?=
 =?Windows-1252?Q?MHw6IqHr/AkciOn07/tpOyDJpXCjquyY2GnKKfIs2AeXm0VLBzcSwo9M?=
 =?Windows-1252?Q?MrVfzHveWuspPEgzkpWJE6U7pDTt5Nw50ihGXCgEP/p7H27+FaiHtYeA?=
 =?Windows-1252?Q?EIUJL5YME4vWqj8n42Q1MZS+nROzaF0geYmXEiiE0UvQqxzt19xA2lAe?=
 =?Windows-1252?Q?aH+yuY7Oyi9BPcMOxBvN987fSQT57Z7GSbkbhhE9NR+qsofK7gAaWab/?=
 =?Windows-1252?Q?6Fh+3Wy0TE6zHQK4o76ExqRY6GXZst8nfQnuL7RKws8hncMLMOkwQcKX?=
 =?Windows-1252?Q?01PuAQODUaGk5ACfC2l+6ZRsM2rprLd/xQ5enwKEpLcE2QNxnf656ViL?=
 =?Windows-1252?Q?zQJoKpiY//BNW3fNxbPtzfogBiZ+yDHyIj008Qayd5VAjqKfQsv9DWZe?=
 =?Windows-1252?Q?Dbb3xDlkZuUWZId6A9gig4NBWj+QvHqQvSveu3Ol8eP1AM5T5J6a57yS?=
 =?Windows-1252?Q?Sb7eaxweZJmW+Qb/zpH50gCbIEVRLK72XCLtxhaqVKYFhaiRcq3byQbj?=
 =?Windows-1252?Q?EID3EaW0NG00qbChXhayAAkzcAHAebXksjYfZl6CXZvQzg25eGFF+3Km?=
 =?Windows-1252?Q?IISPHlxo+FdQxqolGLpSaZS5QTxuQeEmlQPt19rOg7aw54+hdRPlBtsr?=
 =?Windows-1252?Q?tX7PD7aDgT8wXuj4lJHyHPyXGQV7SOI/RAXciN8XnfFojwPbnmRLFXT2?=
 =?Windows-1252?Q?Lbh3ZeQPuD4zER+8Zy+tvQCznLnsVokDbSQoJM6sbI8ycrCKwJujHKCU?=
 =?Windows-1252?Q?MLXQgpfOLZEL1G47HPAEVIoAk12PHl5uQpIJkdHH1pemKh1JEcgqjPGo?=
 =?Windows-1252?Q?Hm/LbmTz60LCSrBQKq3OiKxOnFAz7st3V1pTk14PVSHTnsbH6fO32Uj8?=
 =?Windows-1252?Q?AaEcM4+CLFETpSKliIlroWroB5l5ITOjQHTD+wuMpJDiUaUFVEMSFU/K?=
 =?Windows-1252?Q?wTqNfGN/Jd8imRkpdV6shZ50qqClGODi8RdCKFsvUIGy/Y7VBmjiPsCb?=
 =?Windows-1252?Q?o9bfZaMdlacvtt2MBMXBaxQA+EObh1gxljhDdT1fvn+LE975lrcGls5m?=
 =?Windows-1252?Q?7YOHh+CkN6mOCjyXi2MUkK5A5r6irclgqBVWoRsvAy6gccM33Z/TKYmi?=
 =?Windows-1252?Q?FpS05mct9JRhaJnoosZKBrOuH8PPzLWgUEu/bxbUYyOR+DvE5m3RFuSk?=
 =?Windows-1252?Q?VS5DReYXfnslFFuGTbg9lOxlo1LbUg1dUrEztBcbre2kGYMpIsHW6v4G?=
 =?Windows-1252?Q?gJVBBFV8XoRFLl+mYyykbpDVLs7IAzZVPTqqapOj4aYGk8kzhaZtuqBL?=
 =?Windows-1252?Q?Nszr+SwAAfZ17+ii1BXNbwYnJhHNsF/QkGQ37qt6ob2UIf1Zsji9Ac0M?=
 =?Windows-1252?Q?5HGY70OQqdy98ucNXInwx5RVgJsWfgngpgfnXUrH/doJqg8Xl4vJmleL?=
 =?Windows-1252?Q?yik+JQuhFvee99iYUpxVB/+jcx3sJEk7y3sZ74r1W/4f5VFe4bil4Q?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB11862444EBF1D061F158EAA5BB7112TYWPR01MB11862jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d37b86c-cd62-47b5-5e69-08dc638c0ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 11:53:50.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrnfSBU3DF9QI4odxhKmQszPs5SuMFUJlvLVU/tyQIx7eP71ytkNdzdbUjzc+dNVmcbqanKleMKMQkEgSUqcQuw7vkyaJDPNj94p6lrIhKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11620
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 11:54:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15740

--_000_TYWPR01MB11862444EBF1D061F158EAA5BB7112TYWPR01MB11862jp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Done!

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Thursday, April 18, 2024 11:21 AM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; cip-dev=
@lists.cip-project.org
Subject: Request for review

Hello Chris,

Hope you are doing well.

All the changes were made based on your review comments in this MR -> job_d=
efinitions: Add swupdate, secureboot and IEC job definitions (!1) =B7 Merge=
 requests =B7 cip-playground / cip-core-ci =B7 GitLab<https://gitlab.com/ci=
p-playground/cip-core-ci/-/merge_requests/1> . Please review it.

We created another MR in which we are preparing the job definitions using f=
unctionality-based templates so that we do not have store all the definitio=
ns in the repository. -> Draft: Build test definitions from templates (!2) =
=B7 Merge requests =B7 cip-playground / cip-core-ci =B7 GitLab<https://gitl=
ab.com/cip-playground/cip-core-ci/-/merge_requests/2> . Please review this =
as well and provide your feedback.

Thanks and regards,
Sai Ashrith Sathujoda



--_000_TYWPR01MB11862444EBF1D061F158EAA5BB7112TYWPR01MB11862jp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:#7030A0;}
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
<body lang=3D"EN-GB" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Done!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-ligatures:none">Kin=
d regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:non=
e"> Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Thursday, April 18, 2024 11:21 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; =
cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Request for review<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello Chris,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope you are doing well.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">All the changes were made based=
 on your review comments in this MR -&gt;
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/1=
">job_definitions: Add swupdate, secureboot and IEC job definitions (!1) =
=B7 Merge requests =B7 cip-playground / cip-core-ci =B7 GitLab</a> . Please=
 review it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We created another MR in which =
we are preparing the job definitions using functionality-based templates so=
 that we do not have store all the definitions in the repository. -&gt;
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/2=
">Draft: Build test definitions from templates (!2) =B7 Merge requests =B7 =
cip-playground / cip-core-ci =B7 GitLab</a> . Please review this as well an=
d provide your feedback.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith Sathujoda<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYWPR01MB11862444EBF1D061F158EAA5BB7112TYWPR01MB11862jp_--

