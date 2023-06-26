Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D00AEB64DC
	for <webhook@archiver.kernel.org>; Mon, 26 Jun 2023 17:37:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.2673.1687801038494661336
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jun 2023 10:37:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 35QHbFEX2093792; Tue, 27 Jun 2023 02:37:15 +0900
X-Iguazu-Qid: 2rWg3PKRhoJOX6PDv8
X-Iguazu-QSIG: v=2; s=0; t=1687801034; q=2rWg3PKRhoJOX6PDv8; m=4+0goTGd266pQpKrwSVIuwskbmXDyLfw/wEkJEYbtRU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 35QHbDEA3014961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 27 Jun 2023 02:37:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vny6cvJOizstMwCKpoz9HWlvK5jJ80rdUcA/kM72YaN6DTfA6vbYM6ElieHqBh5iIJuN2dpZMqCNpZWwHU2bHC/fYuin1Lv7D0eNa0o86taHVKwyMJBoH9+ULUq5aX6G8xBl/IF6qILKjBlj20k5oVjfzAHFxk5dJ0h8wpr80IEgzi5GG/AYj1h919SlgPsnSLd1lScqUW1JYaf+OgeS4UlNPkC3jGwfW7IAq7DrNtnndqOOkPkOSHQ0G4/km5r2acNGN1zLhDI+ZOpWVLLDoPmj2UQ213WNxldtxmTgVER1L5fqf8t1SF0WeEUeJFGdI1qXBUCCbVY2jzaM4Yb7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKeidyGDbkoQrx8MN/Fcp7FQU2pR7GOHZg3Ei04xZ+A=;
 b=Ng18SH2qFhh+p8T3J5VZ5SgvKFR6u24M4lsrj17mde6FJfbNz2cLAv77ShdMKNdliKCBj+Jev/rsU08o0twWUfi1wXXcaxZ080aWvU1nd5Ny+wOK6tz2qvaQnZyes6BZMHK3lN6jkWkzZDXDEVvv0dIm1l263oUf/3HJ+iOVDQXiPd/BvCUjE/V3j9ivpVXV1ee0IyPU7tWCJP6fSCNBt3mSDsvBzGznwaSY6F3yeNgomQm4fO7Mq32z4TMU5aa+9UC17Q36Kpx7doddNU46jDC70p0LLDEanDsx+ipeFS9VlpIbcLKG5Vr542NCVShao43xUqPkt6j48KRRWP0E1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <yukiho.fujisawa.te@renesas.com>, <Chris.Paterson2@renesas.com>,
        <kento.yoshida.wz@renesas.com>
Subject: RE: [cip-core] Package Proposal #3 (basic security openssl)
Thread-Topic: [cip-core] Package Proposal #3 (basic security openssl)
Thread-Index: AdmlyLrzDGKsYpQSQLuVveqmE7OEdgCi4pkQ
Date: Mon, 26 Jun 2023 17:37:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB8295918249BCC02FC6B3152AE126A@TYCPR01MB8295.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB5976DD21C889975CE5FA8BA3C623A@OS3PR01MB5976.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB5976DD21C889975CE5FA8BA3C623A@OS3PR01MB5976.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8295:EE_|OSZPR01MB8419:EE_
x-ms-office365-filtering-correlation-id: 8447e810-1bc6-45c9-777f-08db766bf8d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4p6JleXSMCy+xL2qjVo/laiQsSPYkkjv5fWxaSeKNjF6+SXhqX/0C1WqI3k+evN9oFT0AUdUMieJmCLijmYqB+Vjmrzw9zkBwBHX6bAxuoMRLdcOJchMt/FBMoS4PlndMzQj9X8f1GrqXYscT5axy84xXRQfGzC0hbgI0Qk9cCZOuDiVeDEeV92qG7BZNFbPk5qKON3Ogfu1Cmj+8R87XWY3fgjpPb1jf7QHiVvwL5xa9hgRLBLyJRjXhafeiRq/HdgY0vD1yBhI75Xg79LWlpjNKMMiWif5wR3ror7NQ0FeyA4grZbuDhVr3TrTLNA6uY1/WV1ZHW6DeY77bXi3g/ysIQN5na7PzgGyShfatPC8Rg17F12V977RRMmDk7lVR8jIVBL4pU+/a8M5Uiz/WghrUhCdg99a9GxtS+pIE1Uu9KqecUc/cl9nSioGwEa/jZA6oFMYmArd/BZptV8SHjUB3KMyMrvMXK0vRO6EPTLiaVpmJwlTjKKdXcQPOE+RaFJ7IcEW3Fvjo40vAbm05k5CLgZXtvRFImGgbpppxIQu7ugleUkVtosCVlIvLuqBtWWUvsy4d+n3oh9taAufihl+z77AH4DgTeJDd1yDMwdeXsluvKBN4vJiKd1ATNuWywu2eaXC/ofWstSmK8vZ3A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8295.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(2906002)(186003)(71200400001)(7696005)(122000001)(38100700002)(83380400001)(6506007)(26005)(53546011)(9686003)(55016003)(41300700001)(54906003)(38070700005)(86362001)(478600001)(316002)(66556008)(66446008)(4326008)(66946007)(6916009)(33656002)(64756008)(66476007)(76116006)(15650500001)(5660300002)(52536014)(8676002)(8936002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZW1FbEFQS2ZQYkdLTDUyM2l4TWR2RU14dUV2OHZYR0JxdVV3UTE2dTls?=
 =?iso-2022-jp?B?RTZibnhqeWZsZXgrTFREVkZRcFF6QjN2NWVNRVpTQXM4U0NEQlFqQ2lF?=
 =?iso-2022-jp?B?eWlrVWw5MXdMamFxZ2s0MnlZd1BlRUU1R0Z3RlY3cHIydU0wVFZxemhS?=
 =?iso-2022-jp?B?cDZ0NHdQcHI5a1k2a3pvVnpJMXBxTFNxQlNIM2J4VUZMdFZuc0VYbThy?=
 =?iso-2022-jp?B?QU02Ynh2TGsyeklWTW5nUlQ2anRZcmNFTGdNcmxyRU5wVVg2WnBVajlu?=
 =?iso-2022-jp?B?bk1pK3R6Tkpjc2pCNXJqRVF2Rm1RSnlBQ3dFdWdqUi81ZTZlUXFOUnlw?=
 =?iso-2022-jp?B?WFhpMytPQjVuZ0E2a3pjRnNWYjZzbUVzNGNQSXVuQXZtZTNoS0VranlK?=
 =?iso-2022-jp?B?aWFmSGprOFBOZTM3VHFraTc3RmVzM1pIbXNXV0JCNEtMc2J3dkZnUnR0?=
 =?iso-2022-jp?B?d2Y3Uk9zdk5XOHd6S0RWb2I1bzZ0RWl0dXRnUUlxMlJlSndvNmwraExZ?=
 =?iso-2022-jp?B?cHpTMjR1OU9Gb1RraGEwa20vOHVmUklNS0o0RUFzaEMzUlo3cy9kd1lI?=
 =?iso-2022-jp?B?TnF1MWpkTUx5WFp1eGZkeDlvbkZEdHhNVzBzaXZUVGV4MXlIYy8xaWxM?=
 =?iso-2022-jp?B?TVR5alpVWThZSDVkeHFzcGc5Z2xHMHFibVpqazkvN2FuRHpmdU92cElH?=
 =?iso-2022-jp?B?aW9TY1Q1OVVUVVZ1ZEhtMnpBOUtQUEc4N1NnMmxCZk05dDRaaURvMGRL?=
 =?iso-2022-jp?B?dVdBNXFtTTUxTXphdDYzU0E0bjhuTzhJbzIvSmhNRHlMYnlXNjJ4RHBN?=
 =?iso-2022-jp?B?YndVMmFVS25EODYyMFowVWU4RTZ3YjljVXYwS1NHaGtsWW5LU0hXOUc3?=
 =?iso-2022-jp?B?aFFtZUZqSzFLcGNPc3dGbnlxNXVrdWRNVkpoVWF6cUZwa1BaUnJwL0x1?=
 =?iso-2022-jp?B?WE1qbjg4cytKSU5SUTY3RXQ0N2ZWQnB3ek9zTzZ4UlZETVBWd1psc2RI?=
 =?iso-2022-jp?B?czdJMFpCZWpZOENWaWdLeU4yNWQrOW9ZWW9MQzlXMi9NU0FBMGczaklB?=
 =?iso-2022-jp?B?eDBJOXpHZVhZQlBiMjlFdE8xcjJIc1U2a2g0bkprbTZxamdaNVZOQ0px?=
 =?iso-2022-jp?B?aTFmQW1oVHJQUlhJYnAwd3J2WWc3SFRrcXlwMjRJdHJTQzRjK3MxRHB2?=
 =?iso-2022-jp?B?cGx3ZnNMR2t4VHVKM0NOc2FjUERrZGZVa1NGaTlDL1diMUdSRHRTNGdk?=
 =?iso-2022-jp?B?RjBtWGkrV0paWjJBMFVMVHU2TFo5SzRMNURUWGkvRHZOY3JpTEwrQTZw?=
 =?iso-2022-jp?B?T0s5Rks1NnlGVEZMRkJWTEZUSkt1aFZPU2d6bzJmZGZFeEdPaEI1MGJn?=
 =?iso-2022-jp?B?emNsUjNuMUZoMWdYd2NNZ1RhRm9MZUxKekRQKzB5QlpiZTNTMzkyMnpm?=
 =?iso-2022-jp?B?SVB6UWhndC84TEFXanJnMXJ5MEo2V2hTeUxNWWdQOTZ4U0M0MFNYM2R5?=
 =?iso-2022-jp?B?Nm95ODdVc2hEUHM4T0tURWtZZlBkWDZ1cTBVQ3JIdlYyeXVnVC9kZEU1?=
 =?iso-2022-jp?B?bHFqaXE4dE9vNUpvc2lyN2Z6OXM1K28yaVRJY2MyNFF0NktTK2QyY1JI?=
 =?iso-2022-jp?B?M1BVTEdrTVhBWFhxQ1gzQzVaTUg3cGFiVy9KZWRWMkpXb0FpaTZvenp6?=
 =?iso-2022-jp?B?a1FIdXFKV0QzeGFTVWNjakN6RFdIRmoyRnErRXRoY3FLaXRONXk0b1VX?=
 =?iso-2022-jp?B?RnUxRWhraUxWNkZ4VmpLSzhGMEI3aWl1aXN0ZDVuMzVkS1JzUHJtSlB6?=
 =?iso-2022-jp?B?NXY5UVlYNkYyS3I4RHlwSHZxbSszWGgzVklXUkRONGFuKy9OT2pOSDhy?=
 =?iso-2022-jp?B?MGMreFQ1NUd4TU9HU0FNelZHL3JwZS9PdGcxZ3RoRFlNR0JSc1JpK1E2?=
 =?iso-2022-jp?B?MFl2TjZnM0hib3lISUduRk1FanpLKzBGSEJ3UXh0QXhzVWhpcjVWVmd1?=
 =?iso-2022-jp?B?eHVRSjdsZXJQeXFxMElhdjdHOWJEeUZoKzl6aUZuQWhCRVBWdzVzQTdK?=
 =?iso-2022-jp?B?OEZvNFd6Q2VpMFdVSnFEUVdDMWhkaDNmQjFxdHFXaW1PRTN1dlhMdkFW?=
 =?iso-2022-jp?B?d09YbEZZOWN1Wm9LT1hHczBJUGc3YlZONDMvMTJwNW9UeUYrTFU4alN4?=
 =?iso-2022-jp?B?U0wwUjZVWFUvWFY1TDFibjlDN25iQ04xOXl3MzZhSVRHQ3JVOURFaEpx?=
 =?iso-2022-jp?B?RnVkYzhNcGF0ZDN1QjJpS1BROUVNUXJuQmxBdDZlY205dUtpV21vTVBK?=
 =?iso-2022-jp?B?dE9RMHZyNEs3QWVqZUp1Qlg2QWYxL0ZtaWc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB8295918249BCC02FC6B3152AE126ATYCPR01MB8295jpnp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YBx/N5QTnw+ldTmg650y53TUz+gtXITooe07JdCev5sqUT+px3c+HRnBVD+5MCs68TSenLTrtI2+Ynd4pIjecwK7LDfnwzLfYNSu20taO7QGGW5TsrMwrChJu2zmTlF1zKPukyhkLsRGK+ugD1pYyO3ko1IW5HMQJqNr92a7ZOqM3CZNd2g447B1Zd58Lcyb+3j7wBBVHY5Z5n3Fg+tGWaevoj4B2JFkLLD5szCJeuBrVvRjnXLzqxhU/89jA8/51PO9G37/6EHlB6DwccJ2BbeyhRF5k9vaSkrdTdGx7junoYOmV5L9tp4fwnJWbtv6TFbXIDEZ06HylDirpAOFY3KWxF5kf0S3TSOi1zDgJ/MgWwj/WQx0SkRiccvFF8j751mR5ezHMA0yikTXe7Xv0Kv8YHgTNbk3MUV8nlN/oWeJh8jxM06XglWt0pNeJzfw393PMS9xhX/rMRvRkdO3o8L+BCTaHGPX/CLltx1VIOhx7WWQgskIgVs4/sx7QVa+vKyaNIbvL5bH6M9qn2/iSkeBGmOaIxUNihf87uSEaH5OwqFaX9HCUneeapXjNVrM5rxwXjOhqqMBHwwX3tKKXctTrD99kcDKGjJS+neIPu/Y8UzwqZfEwpWMF9JWMJdsq0vjheKz0MnAk76Nsa531GX3vakXjoR0Z/PnvuoNIs2nMw8C4p2tTBdygcQgBQwxQuAy9iQYjgbNNVRTOBxwdTAhYrMR3EUPLRtQRvsUVpE3dL9WNvlCi7HxakS/Oz6w3JXzbKPOgDzvBsKXMolt2MUbI7EkY7Bn9aYfP8zcJRqQ7+KURFe8sgcF+BXHiNBpFxIxmOb1n7RrjGaGkYfNPA==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8295.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8447e810-1bc6-45c9-777f-08db766bf8d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 17:37:11.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksguDM6AUCm3EBbaWRa82YnAb1k4cXbe+MuerbPGptWu1rYOrmL9rmO1b7ElrJ22Iw5rEJkU308TWUhis4kAMMBm1FMWEeIOgTS+v39+yCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8419
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jun 2023 17:37:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12153

--_000_TYCPR01MB8295918249BCC02FC6B3152AE126ATYCPR01MB8295jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Hung-san,

Thank you for sharing the proposal information.
The WG will check the content then discuss necessity/difficulties based on =
the members=1B$B!G=1B(B opinion.

Best regards,
Kazu

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Hung Tran
Sent: Friday, June 23, 2023 9:02 PM
To: cip-dev@lists.cip-project.org
Cc: Yukiho Fujisawa <yukiho.fujisawa.te@renesas.com>; Chris Paterson <Chris=
.Paterson2@renesas.com>; Kento Yoshida <kento.yoshida.wz@renesas.com>
Subject: [cip-dev] [cip-core] Package Proposal #3 (basic security openssl)

Hello Kazu-san and CIP Core members,

This is the proposal from Renesas, as mentioned in our meeting recently.
Sorry for taking so long with this.

Basically the proposal only include 1 software, openssl.
In our opinion, it is an essential software, and should be maintained long =
time (with CVE appears frequently).

The proposal is generated by script. It include 1 source package, 3 binary =
packages, with 2 basic dependency (already included in current list).

Regards,
Hung.

--_000_TYCPR01MB8295918249BCC02FC6B3152AE126ATYCPR01MB8295jpnp_
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
	{font-family:=1B$B^b%4%7%C%/=1B(B;
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=1B$B^b%4%7%C%/=1B(B";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.19
	{mso-style-type:personal-reply;
	font-family:=1B$B^b%4%7%C%/=1B(B;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Hello Hung-san,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Thank you for sharing the proposal information.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">The WG will check the content then discuss necessity/difficulti=
es based on the members=1B$B!G=1B(B opinion.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B">Kazu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:=1B$B^b%4%=
7%C%/=1B(B"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0mm 0mm 0mm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0mm =
0mm 0mm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> cip-dev=
@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;
<b>On Behalf Of </b>Hung Tran<br>
<b>Sent:</b> Friday, June 23, 2023 9:02 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org<br>
<b>Cc:</b> Yukiho Fujisawa &lt;yukiho.fujisawa.te@renesas.com&gt;; Chris Pa=
terson &lt;Chris.Paterson2@renesas.com&gt;; Kento Yoshida &lt;kento.yoshida=
.wz@renesas.com&gt;<br>
<b>Subject:</b> [cip-dev] [cip-core] Package Proposal #3 (basic security op=
enssl)<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello Kazu-san and CIP Core mem=
bers,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This is the proposal from Renes=
as, as mentioned in our meeting recently.<br>
Sorry for taking so long with this.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Basically the proposal only inc=
lude 1 software, openssl.<br>
In our opinion, it is an essential software, and should be maintained long =
time (with CVE appears frequently).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The proposal is generated by sc=
ript. It include 1 source package, 3 binary packages, with 2 basic dependen=
cy (already included in current list).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Regards,<br>
Hung.<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYCPR01MB8295918249BCC02FC6B3152AE126ATYCPR01MB8295jpnp_--


