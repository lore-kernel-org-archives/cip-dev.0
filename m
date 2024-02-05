Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546E5C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 17:58:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.719.1707155936375044087
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 09:58:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 415Hwr1O575860; Tue, 6 Feb 2024 02:58:54 +0900
X-Iguazu-Qid: 2rWhlMYPaAOfGg2S37
X-Iguazu-QSIG: v=2; s=0; t=1707155933; q=2rWhlMYPaAOfGg2S37; m=tp1uEuyALstumdbXbqFRo37pVPVvrB+lfXUFvjnbmmU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 415HwqX82857267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 6 Feb 2024 02:58:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ors0RmMBDjH8hSn4nGb2m2I3ZNJXqsXp/ervElvQqNWAu6WmrGS+0icpuTXcSjZD4ucE8ZN1sZDiC72S4UUQbU0euH2Ks3n4M70GpBO4cfsFH1joBhgIAiWwMG2NcpZNQtegE13tCqwp46hLNc84hxOcTF848hmdTD4FjM7h7ekePaSM9pGlH3ovfUjyZfS/gYpKv/b7+Cbw150lk0PV2iLxYsovoh+FM6z7PMhtdlPzufqkL8/j0Zo1Mw2IsrPEftaFsLCJqZOMfqlhFCgetZ9rmg5zHT3V08qCH6puzQgHecGyUf8MOOHhBWYLmV5wwifGi1U7RgxutKuGaG07yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d7zlkUCrLIAOmQmpt8Dr5ZoxgXMfScpjlywiZhjm6s=;
 b=Gqf2jGhvOMEnvso0GrJubrj3Z0H8/ieL8FNcEWAIyo1i10qOa21WVShAb5EZ+v9Vnt9bD3fyM3FvvpFhh5QRqf0ulkFumb9a3EuGLXepGDjDhejvVRykAmSKCLgmcXyVmM1/ebAj7nyzZM1bcknJI+xarkpmUSAP9YcLzsxIqxxLBfSl27QtqvWows37tZNtNVyhF0W28O7JhD2vqOUqJ9v51BW53eQyW7mCzxbvnqpyjUOGVzOFFuUoH/Xnx8QjxkXg9tt7IhGnuaHbTOJnpWHu8e6kfQKz6NFy4HKOKiKXCQND9Z74VOr5i2wjENFTLsfdwRBKc4+bo+NhhwZsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Topic: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Index: AdpYW/mgLfuVvDVHQv2V4kqjG1tanA==
Date: Mon, 5 Feb 2024 17:58:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB7729:EE_
x-ms-office365-filtering-correlation-id: 3bb0801d-da4c-4f67-d25c-08dc2674184d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JwpmtOrzhKyce/YlptCPc5vuUPIct4o+F9jo56MiCtha3q8w+daH4x5x6QWxKRk1ymLoKhYuerM3c2b7vazGs3aeRbZgeQzDQEPMKh5ZGXFhucdbnIRrkXgLVHmeqXHJKON1D80FjDgoFQGIWswlRLiv21PN1zPNPODLPMaaCRhHjhX0xaJqdHb5J1msEEkM7gTTZ99Y4lHR0CsRtIrHm8dM2cxa2mG4cVkiGTWjCUDOXTPaY/ralUIfDfe+ZoPcl8pbGyMZ1UC/MK5ZV98P1JFKv0uIPdydhTQeidcbl5ng2lleXvoZigpYVVjL4uacy96X0rZIuz8I5TEOCP52Csj/euSB5gv8LhO/3bhQH/MXChjnNAG5O/KLHJlUD8Jk373ZBEspbj+3ap8sGnmWev07FVQE9lb/aWy2SPDpGofe6PD5gMc9Uxo62ZfiNavGh5FsndVmSzyil1qJEW51vZosBreGhsnVaEw8JAwunNet8KFCNCC1PCvaiDXUlpBZMUz99233TEV9E+xgT3yFO8F1WIBLdHSW9Vnfj2iv3ik=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(166002)(38100700002)(99936003)(7696005)(6506007)(33656002)(316002)(55016003)(122000001)(26005)(86362001)(41300700001)(107886003)(52536014)(4326008)(8676002)(9326002)(8936002)(9686003)(71200400001)(2906002)(478600001)(966005)(4744005)(5660300002)(66946007)(66556008)(6916009)(66446008)(54906003)(64756008)(66476007)(76116006)(85182001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZitoeG54VGoyOGhmTkswNE84WHU1cmZiaFhWV1JTMk12M05BQWJLK0Fq?=
 =?iso-2022-jp?B?ZSsxaFNyR2NRWW9SVlkzUytsby82anBGUGZaNXlWVkV4TGwvdTNnUG1Y?=
 =?iso-2022-jp?B?L0xRcENVajc3b2xOSndqcVlabVFxSEFQSDdSTWJSejBXbDFhY2l2VWlv?=
 =?iso-2022-jp?B?M1NtalBhOW1JYVZ2ajM4OGZzZDZEWVI1WTlFNzByTW9mZDJhOTF0Ui9U?=
 =?iso-2022-jp?B?VC9uSjdTTHBwQVJkZVlNcDAwS0Y2bkp2ZE5lM3creDhWZ09BU0JqOXk3?=
 =?iso-2022-jp?B?U2dXT3dJUkJkZFlOZzNtUjNiR3VkS3p6Y1UwQ2lXSm1VWmUxMDdoVHJu?=
 =?iso-2022-jp?B?Y2xXRXJjWS8rMUYyb1AwWDNRRE91K2tWSStFMGlva05Ka0RpSnFoazZa?=
 =?iso-2022-jp?B?aGlycEQ2amdlV0xwYnpjbzRTLzRycU9RZTNHS1RiYjJCTGtobDJZZG40?=
 =?iso-2022-jp?B?SHpVamRkVlh6YnRxajZKM0JBbDl1bzh2WGs3TC8zNnZON2J0Ty9IYVZv?=
 =?iso-2022-jp?B?YVBTdGVoUldqR0J2SzhSak1rTVRnRlZId2NHNzF3cG42L05DOFpGRGhw?=
 =?iso-2022-jp?B?aTJXdjFYVkZVQ1ZwclhrWGRTb2pVeCtaSEVDbGRaOHlGZXhTR3RodXZR?=
 =?iso-2022-jp?B?aUhPQ0J0ZEduZUt6d0pZdXNDVHl5UDdjMEFRUWVNdGxSV0ZUQS9DVDU4?=
 =?iso-2022-jp?B?TGRLeGhLdzBNUUVZNlRZb0QvTzBxaWlWaExUVVh1KzFHRlJLc2dzNFpo?=
 =?iso-2022-jp?B?Y1J4cnNSbjlhYjArVDgvWXVMeS9ZeDBmOGovSERWUzljd1YwVG1yS1Zi?=
 =?iso-2022-jp?B?ejlPTjVaNUd3S2xnS2xDdDRTQ25iR1FQZTByWnR4Nk9KWURIanp4cWJJ?=
 =?iso-2022-jp?B?NFBXeHYvZGc0YnFhOWR2M3dldmozR1JYZXB3V1RVYlcya0VoWWxrMlRn?=
 =?iso-2022-jp?B?eldwUkVZeWtQVFZMYnBUZDhzWVUrQ0EvWUsycTFtWExVRU1wQ3MzNHc5?=
 =?iso-2022-jp?B?S1dySTQvakEyWk01LzkxeDh1Y1hSSGdqZ2dxUnhIL0prQzVuMHppTUVv?=
 =?iso-2022-jp?B?V3hscm00cjNGUTBVUjc0bVFSVUhsSWgrbWpISVhlSlplYi9aUnFGQitj?=
 =?iso-2022-jp?B?ZzRIS2dUdGt6aFhaRjZCT3VsS1A2cGpocEErZEJGSGQ5VXhTUlovM0xW?=
 =?iso-2022-jp?B?OXc2MFAzckJseDJLTUtTaVBFZUdvRlhZbm5PQnFpWHVKM2hXN2RkT3BB?=
 =?iso-2022-jp?B?L20wRG5GT2kydUlXS3ZZV3phTzF2RlJQaEtrOHZyem9kSy9ISUlva0Nj?=
 =?iso-2022-jp?B?WHkxTzBaZkdRaWg1ZGZodXRnbDJQOWQ0T0dnMncydXFPSnNTdzl6NFZW?=
 =?iso-2022-jp?B?YTRiMGpHUExiT1VUVWhSTXIvUStXQXl4MVpOWXNXeDgxajVIaVlBcXND?=
 =?iso-2022-jp?B?UFZ3ems0VWk0SGJ2c1MrUUlnTjQ5NysxWlo4VEx2WFNSR0Zwblh6ZWNV?=
 =?iso-2022-jp?B?YzdaUlVNdllEMUtSRkhFT0dTSmtFZE8xc2l3QVB2MDdKNUZRdjcrMTV6?=
 =?iso-2022-jp?B?SXpGQ1hIMGRybDBMcVErUFRYL21XRlorL083bzdxNFhCUjQ2WVdkQ2ts?=
 =?iso-2022-jp?B?ZWUyWWRVZWkwYnA2OFdJWko3YlJtNzBHYU5KRWFEYlVaeTdscW5OdGg4?=
 =?iso-2022-jp?B?dXJtaithamhlSm5hQjJmWVFlZ29zM3NHVWZiY1Nxek5nUDVUOWRFdUk5?=
 =?iso-2022-jp?B?ZGEzbGdLcTFTR0dHSkZsY0JKbXJ5NVVuUFhqNVZ4eEJBaWdOenY3U3pC?=
 =?iso-2022-jp?B?d1lLR1A4aXM3NlY1S2Ntb3h6OVdhbHJWRzZlSHdVaDZOQ3pLT2NTN3Uw?=
 =?iso-2022-jp?B?QmJEdDQ3WDA3V1BxWHhWQmpVcGJ3cWZlbDZmNEVrWUNXZHJqclhpZUpY?=
 =?iso-2022-jp?B?QjNKeHVpODlyODI5eStsR1p0T1ZYcjA3bTVQWWlyVWRtTkZ2anBZd2hR?=
 =?iso-2022-jp?B?RWhpaW5lQXdNeFpacEYvdGVVV2M3M3UzU1Q5ZlpMbS9ZVGxBNVQvMHAx?=
 =?iso-2022-jp?B?eWZRRW1SQVRoc2JyTU1aeFcvU3Z4UzNjR0ZVbmRLRWVBVi95U3BpTy9X?=
 =?iso-2022-jp?B?Mk0weUZRS3kxZzd0enk1YnBrTUlYRVMwQXhJTnBxcHRvdnRkblY1K05Y?=
 =?iso-2022-jp?B?cUU4MmxjN3M2L2hCV2tSZ2dXNVhIaTdhdmNyRVlMVzdBeEtEcTM0clBw?=
 =?iso-2022-jp?B?WGFZcXU5OHBPYUQxZXc1amZ1ckF5QmxqeXljSmdRRjd5aU11Tno4UmF6?=
 =?iso-2022-jp?B?MFp6RGhSUTF5NnNJZVUwS3lyd3l2U1NpeWc9PQ==?=
Content-Type: multipart/mixed;
	boundary="_004_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb0801d-da4c-4f67-d25c-08dc2674184d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 17:58:44.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zak+RLxe339AMZ7UAs4k00Upc9u5MsaTWJENPhLHdZWcojblxua0zOvxuU7/xNoSsLAORLgWx0spWO3Iyts4c+5M9XuzSnJVNpoExV1VVA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 17:58:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14744

--_004_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_"

--_000_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Hope you are doing well.

Please review the job definitions attached to this mail and kindly provide =
your review comments.

Doubts:

  1.  Do I need to add these definitions in this repository?. https://gitla=
b.com/cip-project/cip-testing/test-definitions
  2.  I am not sure how to schedule these LAVA jobs in CIP LAVA lab. Can yo=
u please help me with this ?
  3.  I remember you installed swtpm and ovmf packages in lab-renesas-cip s=
lave. Can you install those packages all the CIP LAVA slave machines Chris =
?

Thanks and Regards,
Sai Ashrith ( T S I P )

--_000_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:145242541;
	mso-list-type:hybrid;
	mso-list-template-ids:1258724112 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please review the job definitions attached to this m=
ail and kindly provide your review comments.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Doubts: <o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Do I need to add these definitions in this repository?.
<a href=3D"https://gitlab.com/cip-project/cip-testing/test-definitions">htt=
ps://gitlab.com/cip-project/cip-testing/test-definitions</a><o:p></o:p></li=
><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1=
 lfo1">I am not sure how to schedule these LAVA jobs in CIP LAVA lab. Can y=
ou please help me with this ?<o:p></o:p></li><li class=3D"MsoListParagraph"=
 style=3D"margin-left:0in;mso-list:l0 level1 lfo1">I remember you installed=
 swtpm and ovmf packages in lab-renesas-cip slave. Can you install those pa=
ckages all the CIP LAVA slave machines Chris ?<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith ( T S I P )<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_--

--_004_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_
Content-Type: application/x-zip-compressed; name="LAVA_TEST_DEFINITIONS.zip"
Content-Description: LAVA_TEST_DEFINITIONS.zip
Content-Disposition: attachment; filename="LAVA_TEST_DEFINITIONS.zip";
	size=15122; creation-date="Mon, 05 Feb 2024 17:53:37 GMT";
	modification-date="Mon, 05 Feb 2024 17:58:42 GMT"
Content-Transfer-Encoding: base64

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
Ait5vTVLCaKMeronAui7toDn9JaSazwV0sezrVOYZYf7BgNd0xg+iWHubzLu8NEx6bWDybkxiJPT
jV9h5wNSPhaetcH4hFowGA1nmANELppMdq5sUO+FiaRr3HuSeE3RACKf3GBvwoSEr9d3jgpS33Kk
E17fYG4+0oMfbT0McPI43lcBY5Euc6SMPFhEQ3egh7Vj9BQWrjydHSFGQfly9hi4dByc5Nzgk3fo
4DG+QRsIGqzpAktH4nOxkd1LDZnt6ty3G/V8TyNb0072df4hKa5i9S44LPFhA9rgJJFSCf3Lk0WT
K50SmYwGvgXFMaVY32iZ3nRc0SXFGsdKi/1v0E/vIjWX7rX2/DCKPa6meFfrejm/E/0cFiNxrQ6S
Rfc3GGCcYh4eKFAQqKyi0sN9FP92Y0KPwdWDsXyNmWXWjz7/gk9RjmUm/48EmvZxcOZYPHvDVht8
bEDS4QuE/RNNqTrwcTBlCfwYBQxv7Ur4FpPp42C0hFevLp59M+mx/ByOPP2vc+Q80sumL2J1DK22
/Q3S9wrvgemnzy/myRADAkK/jDyOPps88CeKxzElnUttjcr9L6m4lghaFbUrHDiC9K5iwuJUnbe6
43ncJd+6g38AUEsBAhQAFAAAAAgAWKVFWLHlBt21AwAANQgAACkAAAAAAAAAAQAgAAAAAAAAAExB
VkFfVEVTVF9ERUZJTklUSU9OUy9hcm1fSUVDX3Rlc3RpbmcudHh0UEsBAhQAFAAAAAgAiapFWGS7
7W6kBAAAzgsAACgAAAAAAAAAAQAgAAAA/AMAAExBVkFfVEVTVF9ERUZJTklUSU9OUy9hcm1fc2Vj
dXJlYm9vdC50eHRQSwECFAAUAAAACABRukVYV4uPJJkFAADGDgAAJgAAAAAAAAABACAAAADmCAAA
TEFWQV9URVNUX0RFRklOSVRJT05TL2FybV9zd3VwZGF0ZS50eHRQSwECFAAUAAAACAApukVYsb2a
TLwDAABDCAAAKwAAAAAAAAABACAAAADDDgAATEFWQV9URVNUX0RFRklOSVRJT05TL2FybTY0X0lF
Q190ZXN0aW5nLnR4dFBLAQIUABQAAAAIAHS2RVhJB6YS8gQAADEMAAAqAAAAAAAAAAEAIAAAAMgS
AABMQVZBX1RFU1RfREVGSU5JVElPTlMvYXJtNjRfc2VjdXJlYm9vdC50eHRQSwECFAAUAAAACACx
qEVYZ4T8WZQFAAC9DgAAKAAAAAAAAAABACAAAAACGAAATEFWQV9URVNUX0RFRklOSVRJT05TL2Fy
bTY0X3N3dXBkYXRlLnR4dFBLAQIUABQAAAAIAE2lRVhBTsY7xAMAAMwHAAApAAAAAAAAAAEAIAAA
ANwdAABMQVZBX1RFU1RfREVGSU5JVElPTlMveDg2X0lFQ190ZXN0aW5nLnR4dFBLAQIUABQAAAAI
ACW6RVhQ+ZRRPAQAANsIAAAoAAAAAAAAAAEAIAAAAOchAABMQVZBX1RFU1RfREVGSU5JVElPTlMv
eDg2X3NlY3VyZWJvb3QudHh0UEsBAhQAFAAAAAgAm6hFWIySU8eqBQAAXA4AACYAAAAAAAAAAQAg
AAAAaSYAAExBVkFfVEVTVF9ERUZJTklUSU9OUy94ODZfc3d1cGRhdGUudHh0UEsBAhQAFAAAAAgA
VKlFWEi5AA3uBAAAeAwAACsAAAAAAAAAAQAgAAAAVywAAExBVkFfVEVTVF9ERUZJTklUSU9OUy94
ODZfd2R0X3Rlc3RpbmdfMS50eHRQSwECFAAUAAAACABEukVYLsyl7moFAACcDQAAKwAAAAAAAAAB
ACAAAACOMQAATEFWQV9URVNUX0RFRklOSVRJT05TL3g4Nl93ZHRfdGVzdGluZ18yLnR4dFBLBQYA
AAAACwALALsDAABBNwAAAAA=

--_004_OS3PR01MB6103A1EC373CEA6213199114C2472OS3PR01MB6103jpnp_--


