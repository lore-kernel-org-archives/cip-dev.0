Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B0C48260
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 20:39:07 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.81])
 by mx.groups.io with SMTP id smtpd.web11.565.1707424742570725277
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Feb 2024 12:39:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=cdFOo9D3;
 spf=pass (domain: renesas.com, ip: 40.107.113.81, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUzAMN+Dcqsd7qU1lyVDBtpH67q1MeiWnmSGFcwsMrSScvwpPy7tjA9I/LzCcTQxet/GtMMY/InmY4qIcb3givjZFV6Fmo06p40NMm4ZtMjikvr09EqU0XUFug4gqKQaqguyGEWfP9lGrPXO4xJBP9u97L/XOxn7yvg6hoZB3uZjjfiiqov9VX/y9o8SpbhvuUQj0/6XH9KedXn/pVMKQ6XI6Ugb1zYDPAc3XcBmN9TbunUPoZlF95RJEJ5NdSW1CPF8/stx8hx/n4zk909Q1UxVNMCiFdflLImPBDm7krq/0Mj6sI4q8vdva/Sw8p1TBCPJ8j6AU8ZmhyFXnSVt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXl0H1AxB6isakGsiuTeRBGYLDrcuSOJZjR0Z3ttsag=;
 b=J1qnfNlRQmIyca+T9VD+VaK+N1IBF8ctz8SznO2anYSTA7IR+QkMZvo4jppYwltpd07KHe8lYUUXyDQ9PvTNffI8hwOXX/1uULjr1jP22OaNj1myCJzAKITHyAfn+6P4oslyHoB+I+58pxtSfPk56ZhJB9vtcqLNYOBVSuHaDob/nBMQMMPfCJNU+2SrZHw2cB9gAedbiZlIwXAz1ohQv0LgymSxRksQLWGgugYTHQMwiDRo460027gOMbw3R3aVpqEiI9OL4SzjZB76AKNXrwBer6pzwmLqCtbxRzW9vQHPP8lYx/fAN+qYFvITtXciHVIr7NWAu59qTmpIn++zuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXl0H1AxB6isakGsiuTeRBGYLDrcuSOJZjR0Z3ttsag=;
 b=cdFOo9D3Yyj0l/yR0xCmbAafAJin7T4c3Z9tH6NChoyDunQ5F08eSYr00SEdLGWSAQYQoyBp9u9wJr1Mfc3GLFhurLWMs5fohwbsBAKCXeMjSKt7boG0TIckhjFiKZGITferDEQ2GlcfUkqKlvpU5rb+1Znbk5kkpcAK4OYeNH8=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB10649.jpnprd01.prod.outlook.com (2603:1096:400:291::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Thu, 8 Feb
 2024 20:38:57 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 20:38:57 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Topic: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Index: AdpYW/mgLfuVvDVHQv2V4kqjG1tanACcarPQ
Date: Thu, 8 Feb 2024 20:38:57 +0000
Message-ID: 
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB10649:EE_
x-ms-office365-filtering-correlation-id: a9d2f4c5-ed2e-447c-2339-08dc28e5f92d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F/IG71I+0mba9e9lygtcJVKfm00Ha0xsGcraNOb8I0Hrq/hwiB4xj3QZoqEjff6nZf8b5EQfsfJCcweqqOUB89jJNIVhFQqRRBI2kGWBiVTveWtvDmj/crzLPSyIWzkw+u/ZcA1W/jnzRKzLEdctk4gyDh6LJd0TqJ4Yffwg37n4/LgwY/Vzv0mM4386s0EMaIuSyfCRsvf+vshmwcJgZfc4p5JyQmuHXfAwrp70/c7DqUurqnmsPhnWE37ESzGVVLe2xsFJk7XNXOs0Mba/TY1YN3B0KiXmcOFg+HxTaOI4zfSIwR2tcN2Vwpn7pxBhAUyywMCUVgFt2rfNtXIPaLh+D7gIjqzyQicFJKT7Bb3l/ERlsr/DPEO3J+CwDgMcwrTMQLx6NbCqXDwiMdLjKvzT/yg34vhTE1jmPHx0lkoAH3PraFFSocqUrKmI6US3P75ZSwCByGjq3mpoy1bvV6eKJsk2MmnGky5COWcfV4pjceX9vbeFIMc3Eb+CUDPBC9VdyjfhajtQtV2lPzhVXPECxNSr+yGNDfsgCVUZu+IG+BEo8hPG1t4xC6RpVJoR7yKnfmA9Dbz8thCS7tEpq039htZoxc+Ms3mwYLr9BBk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(166002)(33656002)(86362001)(316002)(6916009)(66556008)(76116006)(66476007)(66446008)(64756008)(54906003)(9686003)(66946007)(6506007)(7696005)(966005)(478600001)(2906002)(5660300002)(52536014)(9326002)(8676002)(8936002)(4326008)(15650500001)(122000001)(38100700002)(26005)(71200400001)(83380400001)(53546011)(38070700009)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YjJlRkMrc3dFR0s5ZDhzcExJeEZueHBzbFhSQWJsY1BlZy9ueTlqbjR6?=
 =?iso-2022-jp?B?R3hGZlNMSjhMdHI2bW5ZaGkrN1htR1owR3NyaWJtT0RQa0pxRmhZVFU4?=
 =?iso-2022-jp?B?WS96SWM2bU5sZWlIZ21JbDIydFVmTFFZanQrbUdlMXJzWXpmYXBUemRn?=
 =?iso-2022-jp?B?a3BnRWtRZFE5dnl0bHNhc1JjUkpGYmxKOXBGckZmc1dlWmFPOW9WTWNT?=
 =?iso-2022-jp?B?bUhJUkVrYnViSVk2WGlBU1YvcCtmZituK05FQ2p6UWx4Zm4vSXpIRjhU?=
 =?iso-2022-jp?B?c2dXSDJvekpqa2cyTDB1WkwxdWxIb25lMXNES2hjYWhUVDZOZVlEL2s5?=
 =?iso-2022-jp?B?VHZ3b2ZMMHJVZW55N2gzSEdNQWNoTTVmQ1o2eEdMUklNZE5Bcm5yaFJm?=
 =?iso-2022-jp?B?NHNoTW5iWkd1bFc0Zzkya25URUVXU2xDRmE5WVpLNzI1Lzh3LzN2NkQ3?=
 =?iso-2022-jp?B?MGs0RXVJQVY1VzZvb3pOMnRST1FXeTkyNG9yUjRQSlNuakVXV080WFlP?=
 =?iso-2022-jp?B?MGpCeGxKREl3M1N1c1JmbWN0ZGxudyt3NTJhUiswNnpJcC8rYnZqcVpl?=
 =?iso-2022-jp?B?WWoyTXZhcVJjaXFWTmZGZ3d6U1FkWWp6RFlsMjdoVDRFT1hwQUV6YVFj?=
 =?iso-2022-jp?B?aERtZi9vcGVtbUl2RFBadkQ4dGw2MDN3V01FRjVBbEZrNG9VM1k4MFY0?=
 =?iso-2022-jp?B?b3B2aFlQeWFzR0R4dDdRUWxVbHlOdFd1SUxJTm8wUGNZUExHQ2h1Tncy?=
 =?iso-2022-jp?B?K0pvMngyVTUrc2dBWVpZd0N3VkN1ZEJhbGJkWWo5K1pMSEdqanV5eGVC?=
 =?iso-2022-jp?B?enJHRHpOV1QvMHAxbUhadDQ2M0tDSHM4U0dLZ3NBQVVSWHNIN3VWcGtI?=
 =?iso-2022-jp?B?dFNWRnIvRU4zQXFvTjRiVWlkUkdqRlZHbmlQTE1IbHpmeWUxZkZhWjQ5?=
 =?iso-2022-jp?B?ZkZCS1ZKQktTaGZwYjFuanNQQVFFbEhyRVlTeGlWSTNGVk9XWHgyNVA0?=
 =?iso-2022-jp?B?VHFpVWJxQVZyOVhpUUMrb3JWaThFSVp3RU92WTg5MVZqSkQvRCtFN0FJ?=
 =?iso-2022-jp?B?eVFQb1N4ZEkzZXhCeUFMSk9pOEQ2MCtEUWZNb1J4S003OHBzcmIySGlz?=
 =?iso-2022-jp?B?TEpKOEMzU1VhTUUvZXpJdFh6ZjJMZlNQQWl5YjZ2a0Nxd1FQMmxtLzNW?=
 =?iso-2022-jp?B?Tzh3aGVqNCtKUFY0OWY1eTRQbFArMEZCclFNWHFPczZKN1Vic3prY3Jv?=
 =?iso-2022-jp?B?dEE5SXRZQXl4UDRkbzZnSFRVVDNsYnRpTEl5cU16Tnk5bUh1RnVjMTJE?=
 =?iso-2022-jp?B?VFJzVUowWDBJbEtQV2N1Vi82UkxIbXRId0JRcUFIWFM0Zko3ZUpORlor?=
 =?iso-2022-jp?B?VGVITDI1aXlkZGVjc1VsbHViSk0zOGpnb01RUGNHandGd3FCdWJURnBa?=
 =?iso-2022-jp?B?MGo5eHNFUmR6eFVIL3RJUUxSV0pEQ3EwVGt0eVJKYzh6cnJHdHZ4Nkth?=
 =?iso-2022-jp?B?QjlROVNIU1lPVHB5TElSeWRFaTFycGJYMGcxbkcySm1rdkpPVVk5Nlg0?=
 =?iso-2022-jp?B?a1A2elVtcmNUVnhwbzhMRWdQWXBtaVBSem5WUm1UV2NSWEZZY0JpWXB5?=
 =?iso-2022-jp?B?QWJzeUNuOTg2QjArbVkzQTRRcFAyZXRpeVNmVmZpMGxvU3JiUk1Kd2I5?=
 =?iso-2022-jp?B?S05EQjQwcll4L3pPUUJYbDFPb3Y0MUdRUmZjTGc2NWNUY0NGQTNyRzha?=
 =?iso-2022-jp?B?VzlBZU5zNEU4MXlMK3JtRHNXYW1kaVpodHVXKzQraFpHT0cwbTFZWVpW?=
 =?iso-2022-jp?B?MmFGYVJCVnFjWmtKOFVGUHJWVjFybTJSYTgzcjY5Z1U3djZCd3NNZEJC?=
 =?iso-2022-jp?B?dGN2R0JQUmVUYmpVVGUxL090OURCcmRtei9hZXRPYVVLVnc4bmhxY2pB?=
 =?iso-2022-jp?B?OVdkNXMyUHA2ajVaSGN2NnRSYy9aNjlLdkwzblVtQUVDTUdheDZOQUtz?=
 =?iso-2022-jp?B?R2FrYmFSZlA5L0dJaGtXaHhaSXV0NHhFY0kzTzNlV2QrcVVqdHR3UlMx?=
 =?iso-2022-jp?B?aG1JaGVXdktYMGVTQmh1T1U1dmk1a0dCUDhXV3Nvd0JSaTdGR3g1Umo5?=
 =?iso-2022-jp?B?eWxFQ3lXNnNTbm9Pd1RoV3g3SFJDWFRqaDRrU0U3VjVsdmorK3FKb0lR?=
 =?iso-2022-jp?B?b1AvWkxIK2dRVWozN1hCU1c4YmlqQ1dZWjNpL2p4OGxWMCtwR3c0NGpO?=
 =?iso-2022-jp?B?T3VVSDZmOTE0TkF1bGNTbHlrbFNXRDlnR3RkVGF4cWpWMTNiYVhPRmtv?=
 =?iso-2022-jp?B?Q3c1d2IrQmtVTFY0OFVNSXVRUFFEdnV1RkE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB118625EE66B03E0DE98380BDFB7442TYWPR01MB11862jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d2f4c5-ed2e-447c-2339-08dc28e5f92d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 20:38:57.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zW+S84M3Y04HMoJFtbs+OH+CqYdXmwdJyYqQDm4gK4Sg7abJuqSL0LVL72SztzLeM8eJlYnAzdwsC8AQN42Og1w3K2DiKRDHISvJlUtfa6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10649
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Feb 2024 20:39:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14920

--_000_TYWPR01MB118625EE66B03E0DE98380BDFB7442TYWPR01MB11862jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Sai,

Firstly, let=1B$B!G=1B(Bs get some background for this request.

What is it you=1B$B!G=1B(Bre testing? And when is it you=1B$B!G=1B(Bd like =
the tests to run?
I=1B$B!G=1B(Bm guessing isar-cip-core? And whenever a change is made on _an=
y_ of the branches? E.g. next, master or feature branches?

On the Linux kernel side of things, the test pipelines are driven by linux-=
cip-pipelines<https://gitlab.com/cip-project/cip-testing/linux-cip-pipeline=
s> using the scripts provided in linux-cip-ci<https://gitlab.com/cip-projec=
t/cip-testing/linux-cip-ci>.
However, neither of these repositories are currently set up for cip core te=
sting.
We=1B$B!G=1B(Bd need to add something to isar-cip-core to trigger the test =
jobs, and have a way to create the LAVA test job definitions we need there.

That said, perhaps the templates and submit_tests.sh script from linux-cip-=
ci could be updated to be able to run these security tests?
The build side of isar-cip-core can obviously stay as it is now.
Take a look through the above repos and see if we could integrate your job =
definitions into the same lava template style. Or whether you think it woul=
d be cleaner to take a fresh approach specifically for cip core/security te=
sting.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Monday, February 5, 2024 5:59 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; dinesh.=
kumar@toshiba-tsip.com
Subject: LAVA test job definitions ( software update, secure boot and IEC l=
ayer testing )

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

--_000_TYWPR01MB118625EE66B03E0DE98380BDFB7442TYWPR01MB11862jp_
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
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle22
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
/* List Definitions */
@list l0
	{mso-list-id:145242541;
	mso-list-type:hybrid;
	mso-list-template-ids:1258724112 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
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
	{mso-list-id:1970280379;
	mso-list-template-ids:684634070;}
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
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Firstly, let=1B$B!G=1B(Bs get=
 some background for this request.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">What is it you=1B$B!G=1B(Bre =
testing? And when is it you=1B$B!G=1B(Bd like the tests to run?<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(Bm guessing isar-=
cip-core? And whenever a change is made on _<i>any</i>_ of the branches? E.=
g. next, master or feature branches?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">On the Linux kernel side of t=
hings, the test pipelines are driven by
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines">=
linux-cip-pipelines</a> using the scripts provided in
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci">linux-c=
ip-ci</a>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">However, neither of these rep=
ositories are currently set up for cip core testing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">We=1B$B!G=1B(Bd need to add s=
omething to isar-cip-core to trigger the test jobs, and have a way to creat=
e the LAVA test job definitions we need there.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">That said, perhaps the templa=
tes and submit_tests.sh script from linux-cip-ci could be updated to be abl=
e to run these security tests?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">The build side of isar-cip-co=
re can obviously stay as it is now.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Take a look through the above=
 repos and see if we could integrate your job definitions into the same lav=
a template style. Or whether you think it would
 be cleaner to take a fresh approach specifically for cip core/security tes=
ting.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN-GB">Kind regar=
ds, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> Sai.Sat=
hujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Monday, February 5, 2024 5:59 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; =
dinesh.kumar@toshiba-tsip.com<br>
<b>Subject:</b> LAVA test job definitions ( software update, secure boot an=
d IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope you are doing well.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Please review the job definitio=
ns attached to this mail and kindly provide your review comments.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Doubts: <o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo3"><span lang=3D"EN-US">Do I need to add these definitions in this repos=
itory?.
<a href=3D"https://gitlab.com/cip-project/cip-testing/test-definitions">htt=
ps://gitlab.com/cip-project/cip-testing/test-definitions</a><o:p></o:p></sp=
an></li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0=
 level1 lfo3"><span lang=3D"EN-US">I am not sure how to schedule these LAVA=
 jobs in CIP LAVA lab. Can you please help me with this ?<o:p></o:p></span>=
</li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 le=
vel1 lfo3"><span lang=3D"EN-US">I remember you installed swtpm and ovmf pac=
kages in lab-renesas-cip slave. Can you install those packages all the CIP =
LAVA slave machines Chris ?<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and Regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith ( T S I P )<o:p></o=
:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYWPR01MB118625EE66B03E0DE98380BDFB7442TYWPR01MB11862jp_--

