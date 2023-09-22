Return-Path: <michael.kadel@karlstorz.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7DE6FE35
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 14:10:57 +0000 (UTC)
Received: from mx08-0040c702.pphosted.com (mx08-0040c702.pphosted.com [185.183.31.154])
 by mx.groups.io with SMTP id smtpd.web11.22561.1695391854166853498
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Sep 2023 07:10:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@karlstorz.com header.s=S-DKIM-20210427 header.b=l4jgUPr5;
 spf=pass (domain: karlstorz.com, ip: 185.183.31.154, mailfrom: michael.kadel@karlstorz.com)
Received: from pps.filterd (m0267678.ppops.net [127.0.0.1])
	by mx07-0040c702.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38MBvqaJ001037
	for <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 14:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlstorz.com;
	 h=from:to:subject:date:message-id:content-type:mime-version; s=
	S-DKIM-20210427; bh=65bS9ElDHYxG7xSJF38p1eUklNKiYjTwYr7LYS/k6Io=; b=
	l4jgUPr5wjMPsmdyMUta6JtZcxjtoibMR1owzJCwcrvQ8HtEKwRogDts+GrY3PEm
	50K4OYGpiCejUxHPN3vJ2RgvMj49e81HjT6vn2ausfzZKbnoFt7WA8AbftYNInS2
	AtLlEw6errL7vZY8lgcl/6wFp4qJH6I1DgQF0EgaWTiYAgkpk/Ok2518QUDipMnA
	Du9kGNjZ1oiJbDv+XR2hLXb8qqEUD3tGhB7UncLVaCKQQuIJuIU/34NAvLP63Sbt
	2WxOurfA7auk2knzw/1pJ4GgAbKFna4G63t/gr3v7/WjK2xcK4i+yTYYZgSgegzg
	55l0cTnKskZDE51LQYAMsA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx07-0040c702.pphosted.com (PPS) with ESMTPS id 3t8trrksxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 14:10:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJN23cNGW5hprnJGjA7E1Q/z1BPJJdZXivEAmNw016RAprDXYezN9lJlw8Zf5ZjfWx98yET2UzkwKSRvI+e8VKUVwmTk1i6H4ZJkW5f4NpSrum0GhlWgQA9HdCAk1dqR+QhHSOTDubsoQf4SikIIh9ibNrxi+kiCplf0tt4LZGjXJfjIn6JcH1+G0kQDizBhyjR0sZ/E/g049h59VqdXZnID1Z5f284S8VKr3o9X+06pW+mIX2tSJjzRO2hYZIZfYo5oBbPptZfTz0Gj2oaRFxmr1vomGs1I/oL/ympJLLDmwX1cdfJU1bDQc/KK1GI2XTNeu90g+Ap+xNoBMkm3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auVu8lmsMC576CdvxGJaJmmtT0OgM7tdszN2FpDajkQ=;
 b=m+MoQld3Y5027bR2s2W9eXA5ZjpgObYzeZO6Dsquh/+OQ2EXIA7fAyfxVh1qWKEjIBj6Oa7YCLXaCZgy2eKDJQzwzPiIxmymFrVpghOzrLAVZVtxn1T+Dz00g9wm4sCY04uHer7ydY2RN0Nw2PZupd0WUbo+wQoH10MIa+E554OwNz1vZY9rEXGfuikp6LDRqscvCr3QKJQDadKrzg2J11HXqchx87PyNjEWKtwNsgXLfx6mGkuIyaFxZvceBVfMfGTUlHhcpN2MpU1ft1RrXdRLWR3oniynDPZUaKoraRrdFBvKtwyNp4jkgM4JWZT8fDr3hwmVnP/my35LsUEybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=karlstorz.com; dmarc=pass action=none
 header.from=karlstorz.com; dkim=pass header.d=karlstorz.com; arc=none
Received: from DS7PR19MB5976.namprd19.prod.outlook.com (2603:10b6:8:81::22) by
 SA0PR19MB4317.namprd19.prod.outlook.com (2603:10b6:806:90::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Fri, 22 Sep 2023 14:10:47 +0000
Received: from DS7PR19MB5976.namprd19.prod.outlook.com
 ([fe80::fd83:ca66:ab60:dd73]) by DS7PR19MB5976.namprd19.prod.outlook.com
 ([fe80::fd83:ca66:ab60:dd73%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 14:10:47 +0000
From: "Kadel, Michael" <Michael.Kadel@karlstorz.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: projected EOL v4.4 SLTS
Thread-Topic: projected EOL v4.4 SLTS
Thread-Index: AdntXlGyvVNP2aOtSR+1N/Cdxn+mxg==
Date: Fri, 22 Sep 2023 14:10:47 +0000
Message-ID: 
 <DS7PR19MB5976CF5A1AE42B817D05116EEFFFA@DS7PR19MB5976.namprd19.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5976:EE_|SA0PR19MB4317:EE_
x-ms-office365-filtering-correlation-id: 3805aa1a-3215-4dac-3f0f-08dbbb75b7e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Q9sxcXt6rlCnIpNJMTOCHPV1qbTRSHGdTFxFar6AMRrm7roFf6oYTq8SSDUuaZSZvAOS876Xm74ITsLsrghflhYRPxuIWGpguUfZTpuvy7tFnOJc5bHbWSCRUf5x8YJk620cwkJtzQtAsdPqejPKMD/CJPy4t/5Ts35W/mrmhV7MWRbpY7hHw4uj2BuEEd77TRynO6HGxAR4cdXVh0c+Z5TGQiVkPeJwA77cj+02LXzbT/2ytbEr9qDKsfie5Cz5A7H/O+6FcVuyZ85Kqq8YCPUO9LP2ax6fn8WdOdp72bCtbwcsvd5EmAf4TBbd3c5mUgpTzX4FvKKlKhBbvghmOYlqeLcYMJb1L7v2tXdA/xJKrrQMl2AbOPn2sE3RcCLeLnueqGVSCYeqZEcp6MhPPXjNJuU+YKRAJeQpBhCWxmwQyqqTlmRxAhhbzQyk+Q4uweUa6p6pz0LhBkRHkFewN9p8YxVRNOaIjdAoYZqO03283C3FYIG9yo+X1V69QRz5gCIN1IhsDpwRgUaAdptcAwrmnOMEeIWdiFi6zEJZGfc5RRJ+5HOly5CWOMy1XsAqn5/S4dP4R0VEtR+XJsv2pgamnk6iq6ZCIWLSPN8yDM2CtH7CHiutMVDQnI7NvlgE8+5JzDlS+gePdBXQceO0XA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5976.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(38100700002)(99936003)(166002)(38070700005)(122000001)(33656002)(86362001)(26005)(6506007)(8936002)(7696005)(2906002)(5660300002)(52536014)(66946007)(76116006)(71200400001)(8676002)(55016003)(66476007)(316002)(66556008)(83380400001)(41300700001)(478600001)(6916009)(64756008)(66446008)(66574015)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?oh6dn4jWdEvp1Y3Sps7mvxBZVES8cpEl4G20l4zSH5Mpbd+KO0PUuDWN+A?=
 =?iso-8859-1?Q?btxobbBdk1YjJslPWHXNDJq80VPdZYxsNFkhlgdzGdqvnnOYgrWe2tbpML?=
 =?iso-8859-1?Q?m5MVtZE5vr5ndSopzD5hRxynGdAUdVtSbaL1oDPuD32wFKIb+Li3BEw4yi?=
 =?iso-8859-1?Q?b3Gr3zW8PhulTHHkJ8vgiWrDYK6GM/sFwujRGCGFKf8xD//HCMO6lfT+Oz?=
 =?iso-8859-1?Q?BUfdaz0wraVc1CIekweE06hI+AKMlKDbdvmE3cHMhYV1U3VCgxtg6DpA+E?=
 =?iso-8859-1?Q?qljnGcDqPyYC46VN0j/VJbyByq3VmZ+pir7HkDrJlb2QusWYj9Iq7B1jSy?=
 =?iso-8859-1?Q?OUMCkapgpARzrhjHwfC6uFbWCFke8HovmXwWBY2fhHWDe5MT/P3Har5+ql?=
 =?iso-8859-1?Q?qyhLATmvdurTTlGVQ5if85TzyAnou0IPmgton2xlklUyFT9KZW0Jzphs5a?=
 =?iso-8859-1?Q?wGtEFNEbaHmj/9JrPtMTEcxuGN0F1hO11oiT4ljkI8/Ai14DDkhQr/+cN4?=
 =?iso-8859-1?Q?irFCQyreJhn6tvIlalPvzqaRm+Nh3yWOWJzIQ1dUerjGnWhinehSDJuzSa?=
 =?iso-8859-1?Q?DDsm9KMVDZrNlpmAiMGJImo8CWxHi8qdrKQ5k3O0qGWrP+Rn83sB/aqO1d?=
 =?iso-8859-1?Q?RQCQPoIVBaiaMcOKSXBahfSk7DMN/i6S3mYpq63aWlwipBYS/YDHFGkRHd?=
 =?iso-8859-1?Q?8BcWZwokaJz9mL4bPr0mQoEe4jWK6p8z9zitI5ZRRFC1TDyLMW5udNc4Y8?=
 =?iso-8859-1?Q?Sj4R4DVfxUZlcd1Iu0zWwd6rtkTE6e0xKWlFJ4WodUZctc7o+rJVawzxKi?=
 =?iso-8859-1?Q?v6P4Ew0m1IFz4Wfg3CBMxBvPtRPfSbEbATMjEMculqwN54r9PraSB3Dw/i?=
 =?iso-8859-1?Q?x7TnPRCbn7JsfKl1nhAHngfnB7l+lPe3jgbTpjhXSJK3hyp0L0xQlHe0R1?=
 =?iso-8859-1?Q?puL3/77YxQgkSVu/rp50kbiJdAxenMuf0M0lVp/S5sa2l0WEcec59TH+Y2?=
 =?iso-8859-1?Q?kpv+ka9xZum8FG9EXdLjrYYFwzBiNJxDL5DxEaWrNzuot+5zxXLVztluVk?=
 =?iso-8859-1?Q?XmHh+O+dkqrv4R/850tQyPtkvWh6UJsBOb56c5MkgtDFabtM5EQyNldom8?=
 =?iso-8859-1?Q?cA8Z4b3+0PYb22Z+wGgmWmTjSAr9xy/989HDZdp9lK5IWzhxGC+A701b0f?=
 =?iso-8859-1?Q?Ir39C0/1+mwLYDIzH4VSdG90YPIaV7DYpi9Num/sTRVy0reInW4OWrkgaw?=
 =?iso-8859-1?Q?so45Xn2S7QDFpS9Qp8tGFlsZhzybX6M9dUK06JR2zO8yJzt9Snem2WMY1f?=
 =?iso-8859-1?Q?QZ05oQpZVxnlos0+w7D1XpG0cJhhNO0ecTGZxOmURN/cYzn9zbNA9GY/Ti?=
 =?iso-8859-1?Q?QZ5nL2YxWRMoDLZ+ahzD03FJH7W07h2dCjrAWQBk3V/BtYZmvleJApZ27E?=
 =?iso-8859-1?Q?kctEuVpyXyRKvAG9yhOnF3XRnw7MPEYEjYMrxXtQc+55D6+By9F/nHnD4X?=
 =?iso-8859-1?Q?tRigzs6ACh4IgpN34bSYlYMAl4YVMYRzgkS/iXfmz9t/WVGfcb9ZDStddK?=
 =?iso-8859-1?Q?eddGSnnS25yVCCB/mHGgN7UpfRdy1SjUAFNK1dU1zPWp01PojKiSkSGbCf?=
 =?iso-8859-1?Q?PU2p6li01dbFvJcrCbZL7iYoSyejxS9MwC3OjIO8ZIh86Luqoj6ukudQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/related;
	boundary="_006_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_";
	type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: karlstorz.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5976.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3805aa1a-3215-4dac-3f0f-08dbbb75b7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:10:47.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a0b6f21-e6e1-4ed6-9dcf-e60e7190f648
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhuqU2W7TPZ3KYM4kr8//hXVbeaVOUVk+KPhf9x/sK1Lej7uRyVjBKpetiSLXdJQ+BKlRV+PCXXCbA1JV611lI2Id0bKwjk0o7oAi73gGFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4317
X-Proofpoint-ORIG-GUID: _WIu4pTzSop55LER-PHGBbtrQ0V2UqeC
X-Proofpoint-GUID: _WIu4pTzSop55LER-PHGBbtrQ0V2UqeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_12,2023-09-21_01,2023-05-22_02
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 14:10:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13209

--_006_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_
Content-Type: multipart/alternative;
	boundary="_000_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_"

--_000_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello cip-dev group,

I do have a question regarding the projected EOL v4.4 SLST.

It is said that the projected EOL v4.4 SLTS is 2027, possibly 2036.
When can we expect a decision that the v4.4 SLTS is extended to 2036 or not=
?

Thanks a lot,
Michael
Mit freundlichen Gr=FC=DFen / Best Regards
KARL STORZ SE & Co. KG
i.A. Michael Kadel
Product Security Analyst
Global Research and Development

Tel.:
E-Mail: Michael.Kadel@KarlStorz.com<mailto:Michael.Kadel@KarlStorz.com>
Follow KARL STORZ: [cid:image001.jpg@01D9ED6F.572BA090] <https://www.linked=
in.com/company/karlstorz/>  [cid:image002.jpg@01D9ED6F.572BA090] <https://w=
ww.facebook.com/KARLSTORZ>  [cid:image003.gif@01D9ED6F.572BA090] <https://w=
ww.youtube.com/channel/UCLd331YH_xb-YcssLVdcvEQ>
www.karlstorz.com<http://www.karlstorz.com/>

Hausadresse:
KARL STORZ SE & Co. KG
Betriebsst=E4tte Berlin
Scharnhorststra=DFe 3
10115 Berlin/Germany

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
KARL STORZ SE & Co. KG
Dr.-Karl-Storz-Stra=DFe 34
78532 Tuttlingen/Germany
Sitz der Gesellschaft/ Place of Business: Tuttlingen
Handelsregister/ Commercial Register: Stuttgart HRA 450442
USt.-ID-Nr./ VAT-ID-No.: DE 142931059
WEEE-Reg.-Nr./ WEEE Reg.-No.: DE 74465858

Pers=F6nlich haftender Gesellschafter/ Unlimited Partner:
KARL STORZ Verwaltungs SE
Dr.-Karl-Storz-Stra=DFe 34
78532 Tuttlingen/Germany
Sitz der Gesellschaft/ Place of Business: Tuttlingen
Handelsregister/ Commercial Register: Stuttgart HRB 762524
Gesch=E4ftsf=FChrender Direktor/ Managing Director:
Karl-Christian Storz
Vorsitzende des Verwaltungsrats/ Chair of the Supervisory Board:
Dr. h. c. mult. Sybill Storz
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Datenschutzmitteilung f=FCr Gesch=E4ftspartner / Business Partner Data Prot=
ection Notice<https://www.karlstorz.com/business-partner-data-protection.ht=
m>


--_000_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello cip-dev group,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I do have a question regarding =
the projected EOL v4.4 SLST.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">It is said that the projected E=
OL v4.4 SLTS is 2027,
<b><i>possibly 2036.</i></b><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">When can we expect a decision t=
hat the v4.4 SLTS is extended to 2036 or not?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks a lot,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Michael<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-=
serif;mso-fareast-language:EN-GB">Mit freundlichen Gr=FC=DFen / Best Regard=
s
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-=
serif;mso-fareast-language:EN-GB">KARL STORZ SE &amp; Co.
</span><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Aria=
l&quot;,sans-serif;mso-fareast-language:EN-GB">KG
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-f=
amily:&quot;Arial&quot;,sans-serif;mso-fareast-language:EN-GB">i.A. Michael=
 Kadel<br>
Product Security Analyst<br>
</span><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Aria=
l&quot;,sans-serif;mso-fareast-language:DE-CH">Global Research and Developm=
ent</span><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;A=
rial&quot;,sans-serif;mso-fareast-language:EN-GB"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-f=
amily:&quot;Arial&quot;,sans-serif;mso-fareast-language:EN-GB"><br>
</span><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-se=
rif;mso-fareast-language:EN-GB">Tel.:&nbsp;&nbsp;
<br>
E-Mail: </span><span lang=3D"EN-GB" style=3D"font-size:9.0pt;font-family:&q=
uot;Arial&quot;,sans-serif;mso-fareast-language:EN-GB"><a href=3D"mailto:Mi=
chael.Kadel@KarlStorz.com"><span lang=3D"DE" style=3D"color:#0563C1">Michae=
l.Kadel@KarlStorz.com</span></a></span><span style=3D"font-size:9.0pt;font-=
family:&quot;Arial&quot;,sans-serif;mso-fareast-language:EN-GB"><br>
</span><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-se=
rif;mso-fareast-language:DE">Follow KARL STORZ:
</span><a href=3D"https://www.linkedin.com/company/karlstorz/"><span lang=
=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-seri=
f;color:windowtext;mso-fareast-language:DE;text-decoration:none"><img borde=
r=3D"0" width=3D"10" height=3D"10" style=3D"width:.1083in;height:.1083in" i=
d=3D"Bild_x0020_1" src=3D"cid:image001.jpg@01D9ED6F.572BA090"></span></a><s=
pan style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-serif;mso-f=
areast-language:DE">&nbsp;</span><a href=3D"https://www.facebook.com/KARLST=
ORZ"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Arial&=
quot;,sans-serif;color:windowtext;mso-fareast-language:DE;text-decoration:n=
one"><img border=3D"0" width=3D"10" height=3D"10" style=3D"width:.1083in;he=
ight:.1083in" id=3D"Bild_x0020_2" src=3D"cid:image002.jpg@01D9ED6F.572BA090=
"></span></a><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,s=
ans-serif;mso-fareast-language:DE">
</span><a href=3D"https://www.youtube.com/channel/UCLd331YH_xb-YcssLVdcvEQ"=
><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:windowtext;mso-fareast-language:DE;text-decoration:none"><img border=3D=
"0" width=3D"16" height=3D"10" style=3D"width:.1666in;height:.1083in" id=3D=
"Grafik_x0020_6" src=3D"cid:image003.gif@01D9ED6F.572BA090"></span></a><spa=
n style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-serif;mso-far=
east-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-f=
amily:&quot;Arial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode=
:line"><a href=3D"http://www.karlstorz.com/"><span lang=3D"DE" style=3D"col=
or:#0563C1">www.karlstorz.com</span></a></span><span lang=3D"EN-US" style=
=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-serif;mso-fareast-la=
nguage:DE;layout-grid-mode:line">
</span><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-se=
rif;mso-fareast-language:DE;layout-grid-mode:line"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Ari=
al&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><b><span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-farea=
st-language:DE">Hausadresse:
</span></b><span style=3D"mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-=
language:DE">KARL STORZ SE &amp; Co. KG
</span><span style=3D"mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-=
language:DE">Betriebsst=E4tte Berlin</span><span style=3D"mso-fareast-langu=
age:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-=
language:DE">Scharnhorststra=DFe 3</span><span style=3D"mso-fareast-languag=
e:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-=
language:DE">10115 Berlin/Germany
</span><span style=3D"mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-=
language:DE">&nbsp;</span><span style=3D"mso-fareast-language:DE"><o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</span><span style=3D"mso-fareast-language:DE"><o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">KARL STORZ</span><span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">
 SE &amp; Co. KG</span><span style=3D"mso-fareast-language:DE"><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">Dr.-Karl-Storz-Stra=DFe 34</span><span style=3D"mso-fareast-language:D=
E"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">78532 Tuttlingen/Germany</span><span style=3D"mso-fareast-language:DE"=
><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">Sitz de=
r Gesellschaft/<i> Place of Business</i>: Tuttlingen</span><span style=3D"m=
so-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">Handels=
register/<i> Commercial Register</i>: Stuttgart HRA 450442</span><span styl=
e=3D"mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">USt.-ID=
-Nr./
<i>VAT-ID-No.</i>: DE 142931059</span><span style=3D"mso-fareast-language:D=
E"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">WEEE-Re=
g.-Nr./
<i>WEEE Reg.-No.</i>: DE 74465858</span><span style=3D"mso-fareast-language=
:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">&nbsp;<=
/span><span style=3D"mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">Pers=F6nlich haftender Gesellschafter/</span><i><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;mso-fareast-language:DE;=
layout-grid-mode:line">
<span style=3D"color:black">Unlimited Partner</span></span></i><span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;m=
so-fareast-language:DE;layout-grid-mode:line">:</span><span style=3D"mso-fa=
reast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">KARL STORZ Verwaltungs SE</span><span style=3D"mso-fareast-language:DE=
"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">Dr.-Karl-Storz-Stra=DFe 34</span><span style=3D"mso-fareast-language:D=
E"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">78532 Tuttlingen/Germany</span><span style=3D"mso-fareast-language:DE"=
><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE;layout-grid-mode:l=
ine">S</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif;mso-fareast-language:DE;layout-grid-mode:line">itz
 der Gesellschaft/<i> Place of Business</i>: Tuttlingen</span><span style=
=3D"mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">Handels=
register/<i> Commercial Register</i>: Stuttgart HRB 762524</span><span styl=
e=3D"mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">Gesch=
=E4ftsf=FChrender Direktor/<i> Managing Director</i>:</span><span style=3D"=
mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">Karl-Ch=
ristian Storz</span><span style=3D"mso-fareast-language:DE"><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">Vorsitz=
ende des Verwaltungsrats/
<i>Chair of the Supervisory Board:</i></span><span style=3D"mso-fareast-lan=
guage:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">Dr. h. =
c. mult. Sybill Storz</span><span style=3D"mso-fareast-language:DE"><o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE;layout-grid-mode:line">=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</span><span style=3D"mso-fareast-language:DE"><o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;mso-fareast-language:DE">&nbsp;</span><span style=3D"m=
so-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:DE"><a href=3D"h=
ttps://www.karlstorz.com/business-partner-data-protection.htm"><span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0563C1=
">Datenschutzmitteilung f=FCr Gesch=E4ftspartner /
<i>Business Partner Data Protection Notice</i></span></a><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_--

--_006_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_
Content-Type: image/jpeg; name="image001.jpg"
Content-Description: image001.jpg
Content-Disposition: inline; filename="image001.jpg"; size=728;
	creation-date="Fri, 22 Sep 2023 14:10:46 GMT";
	modification-date="Fri, 22 Sep 2023 14:10:46 GMT"
Content-ID: <image001.jpg@01D9ED6F.572BA090>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAALAAsDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC4dCtr
vR7S9uLmOyjjtVklkSEu0haQrlueTWHq1tc6Lqk+nfaHcQNgMjFQQRkHHbrS3GrX4jksBct9mX90
I8DAVWJA9etW0Uasv26+zNcSk73JIzjgdOOgFfQQU4u7eh8zJ05r3Vqf/9k=

--_006_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_
Content-Type: image/jpeg; name="image002.jpg"
Content-Description: image002.jpg
Content-Disposition: inline; filename="image002.jpg"; size=702;
	creation-date="Fri, 22 Sep 2023 14:10:46 GMT";
	modification-date="Fri, 22 Sep 2023 14:10:46 GMT"
Content-ID: <image002.jpg@01D9ED6F.572BA090>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAALAAsDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwB/hbTL
fVdXEd08XlRoztHI5XzODjGO3GT7Vl3zbb6YRlFQOcC3YmP/AICTyRWr4UGPEYA6CGbH/fDVlwRI
0KkjnHqa91X9o7+R532Uf//Z

--_006_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_
Content-Type: image/gif; name="image003.gif"
Content-Description: image003.gif
Content-Disposition: inline; filename="image003.gif"; size=699;
	creation-date="Fri, 22 Sep 2023 14:10:46 GMT";
	modification-date="Fri, 22 Sep 2023 14:10:46 GMT"
Content-ID: <image003.gif@01D9ED6F.572BA090>
Content-Transfer-Encoding: base64

R0lGODlhEAALAHcAMSH/C01TT0ZGSUNFOS4wDQAAAAFzUkdCAK7OHOkAIf8LTVNPRkZJQ0U5LjAY
AAAADG1zT1BNU09GRklDRTkuMEKHRfUGACH/C01TT0ZGSUNFOS4wFQAAAAlwSFlzAAAOxAAADsQB
lSsOGwAh/hpTb2Z0d2FyZTogTWljcm9zb2Z0IE9mZmljZQAh/wtNU09GRklDRTkuMBgAAAAMY21Q
UEpDbXAwNzEyAAAAA0gAc7wALAAAAAAQAAsAhv0cHP0YGfwXGPwbGv4AAP8AAP8BAP4FBf0eHv4N
Df0NDf0ODv4+Pv0uLv0iIv0iIf0uLf49Pf0qKv1dXf1dXP1BQP1GRf15eP1qav1jY/16ev1oZ/1q
af1lY/5oZv1ravx5ef1sa/58e/1ycv1tbP1paf1sbP1ycf6Xlv6Zmf2Tkv2Hh/2Yl/2AgP2BgP2L
jPyMi/2xsP2ysf25uf2hoP2jof2mpv2npv7Ozv3Oz/3Y1/7///329v3i4P3i4f7j4/7j5P///wEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwdwgEExEwwNDgABAgMPEBEUMkE4BAWUlZaUBDkoBQadBpWenQUpF5yiGBmT
pp8aG6sFKjszFQeeBRwdrys7OzoIpgUeH68sPCAJryEtrxYSk6EFLjQE0Ku2NT0KqpeWCz5BPzYv
IiMkGCUmJyIwN0A7gQA7

--_006_DS7PR19MB5976CF5A1AE42B817D05116EEFFFADS7PR19MB5976namp_--

