Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB92C55162
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 05:56:57 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb.securemx.jp [210.130.202.130])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6741.1785505273516695348
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2026 06:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=samarth.atreya.k63@mail.toshiba header.s=key2.smx header.b=GZAyt8Sk;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.130, mailfrom: samarth.atreya.k63@mail.toshiba)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 66VCrV7t337593; Fri, 31 Jul 2026 21:53:31 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:MIME-Version;i=
	samarth.atreya.k63@mail.toshiba;s=key2.smx;t=1785502373;x=1786711973;bh=l/YJ1
	PUE36VaGHQUcvIRi5eg8Uga7zXxaMt0pGwY8iE=;b=GZAyt8SkFKHcEG9uxWkIBHq5awD+MvIhl3o
	FhkEwmATtdwGDs/OS1XSH1+Zk9I2v3t31DEZbORlSjTTzssxwHZtaN7BIe67iYIC5hbwel7oUSSgv
	hJTTlrCYtPozKj0Xhz3RkIlFs4oDugrxZk7euGjvoLBXP0ssl5KWnQGau58CB3PKXfrSzqkR3ZlNp
	UxsIzGdrkTzsIiE8zidUruaw9hhDhPgAscWiyUbbh4RPChLuGeziHZdsm+laXU33lgnZ8f1JEE8fr
	5X/Vm7iEEsGje6Gw+6RSEp605yGpAeoLVyQPOzBbzpjTvmL9ww8rJe/YmR1kZZAMPMfeyPsPxHkQ=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 66VCqq6p3984977; Fri, 31 Jul 2026 21:52:52 +0900
X-Iguazu-Qid: 2rWhDvWdSFNnyyVfow
X-Iguazu-QSIG: v=2; s=1; t=1785502372; q=2rWhDvWdSFNnyyVfow; m=s1MzDvsAc30asl8kXLMd2nzzS34U/rj5fpyaFPPlV3U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hBQw40TTpz1xng; Fri, 31 Jul 2026 21:52:52 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtF4o6zmWEKhWZiERuw4y3+SFwsKflFImuRi+TVo/H5pvFWWlPWMcIpK9Jkc20np/P5F8ZcVdhbWKJE83JNjYPHqn/yayxueHA0vgs3Puo87n2Y7ziesXNIMFtzoeeLimTkGkxIEv907DKCEVi1EbkogXyhR8AcalQd+TUkFhFZdvAtgEaJ7pVI57+KYLaYbUciL1KebI5qbdpArOLOQR+ohoNbv/cBgN7aznV45asuMNNUBLeKGUGj36E9Wp5eCh6lh6vj56hy0q7PKOoBd5e8bpAFnbnImKvOgEdUtf3cy1M7ka6IPfXvACDBQrMnvjtzalVhNwnOU+g0Fhz5+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMeORBFlAKAkf2WlMtBGZupK+wpsRNz9V7LRpipQ1eM=;
 b=cDJAvjaQcNTymRaQd9DsF5RwSDNWwO7AGtLbtZWJ21Fo8cPLYCVBOlMA0z5sWbkQODqiLGRBh/uGv+iSPe/Gb5g9fIosojUNVR457cyUTW+1WzKgrLVwRdaeVKTrUJeMEMdtfhf8lAxu1Tj+6k5FYggdfSaW1Gxr8nW8Bn4IMF0PgCcSIY/KIFgchrxS/T6vdTbUcUZRjvxwfO4RYi4I4gp2SipSQlv9aXnSOBFOgI9x0jSaum5KxoBzMbvMupP/lPD10TGwKM4bPAWtVo3SankMQ34QUyjvXllj3BmT2+j1FNiaYywCN11g98ohmOZAF8jWMMe/T6wjBPNQhUuAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <samarth.atreya.k63@mail.toshiba>
To: <submit@bugs.debian.org>, <bernat@debian.org>
CC: <cip-dev@lists.cip-project.org>, <kumar.dinesh.h95@mail.toshiba>
Subject: [cip-dev] PATCH: libsepol: Enable Autopkgtest for libcbor package
Thread-Topic: [cip-dev] PATCH: libsepol: Enable Autopkgtest for libcbor
 package
Thread-Index: Ad0g6sYPm+0Z8hUrRNyw+70Ic990vw==
Date: Fri, 31 Jul 2026 12:52:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY4PR01MB156245BCE9C799F433EE08327B3C82@TY4PR01MB15624.jpnprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB15624:EE_|TYCPR01MB8437:EE_
x-ms-office365-filtering-correlation-id: fda88633-a885-4b0a-6784-08deef029fc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|6049299003|376014|18002099003|8096899003|4053099003|38070700021|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: 
 iF27mmwjRNootPB3Vyb28185y5pnbedfW8Zym6zoEEqvSpDxYdvSaKgWjhzqv0zXEkpiN86USl3tj6Hshws1LeprRBCJEmZZyKbiNge+LDFEoebTzXRo2XpqGsmttDwxqDoAi4kSylHRSzTtMfq4kUI7pWC21bSi8hil1H4ejHI8W2GvHLfq8kGsYKX9yH5VRM40PHwE1HQWI1yvZPc9JLEZvwI0JmNJVVqdFSbgrZX9nho0B1i4C8fgPHPWQ84HqoJw3rfP8AIqJnn1cUi8/tj9RUAoxEHey8HfNMQL4WZ7vJ6CWa9WJ7CcZTdU7nQDcMX20M4YsWCXIZMgyKENh2uLlVwx3RUmGlCyrMABqwwaTtBt8wjxLoCsn6ISdK1kLeW/qsUSUdkP8tjOJAj/5cpkrVWz0r9BrrY1D9EzkfMn82pPtHL/WyFIm5OuAlCcUX/ttG/rSITayKkjqev0KSH0GjreKr+01uHWhNh72w/x+mDHU4VWf2ZMNAGlvJehsKVhUSMHbncC8hrOqe5sSwAJ0iLIdv1S4pFUxHaybv28PL3zgTXIacnReoJTFaj+kkrPfC8oYt/xA5tqKmaLU8cQD3Pjm7Ggt2iueFfyy8YJOuup685yiSOxFjzhmrkF5z9BVVnc3mU/MdDZUpqXILyxIfflDtR/sdyDuBW7QCSawDgc/Ku3dzC4b6kgVN2F3B/UVwxojKIRDt4yEESrZNUF+a6eKoPdRIkdJWno+qc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB15624.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(6049299003)(376014)(18002099003)(8096899003)(4053099003)(38070700021)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QmtzdzRCeUgyZ3pWSnNJVXFacWZGRG9XOVY0STdpQ0x2WXUzTGN6YTIx?=
 =?iso-2022-jp?B?UlhmZkVMSHZjM1phRlFlZWJkdlhUaVJCdEFoK3RDaDc5SUlCczVuVmN3?=
 =?iso-2022-jp?B?M2Q4Mkgwbmk3MEMzOUFMVEpvMlNBaWg0cEV0SHVMV3Z2WjRaRGFVK0c3?=
 =?iso-2022-jp?B?R24xeUV6VFhCcUNkaXJZM2EzS2FRVXZUdzdRRlg5VHRNSTc5bk42NTNz?=
 =?iso-2022-jp?B?SFdXSlRjQUlOVk5oZnZxSWRiOHRhTXFRYVpKam9HOVk5Qk5tSmIwaHcx?=
 =?iso-2022-jp?B?UkJoQlAxR040OHlrd1EzWENENHg2cjIvWnI4Nnh1N3ZKbkZOUmh6WUJs?=
 =?iso-2022-jp?B?aTRuTU1qa1B0MDJHNTEyd0xMaXdzUWNVd3ZvaHVCNWNDcTFpUVlHaXQ3?=
 =?iso-2022-jp?B?QlpNOUQzZ0lQVHNRYzV5VUZOSTdBenVxZVRKTHNMVnArQUhqaUJsUG42?=
 =?iso-2022-jp?B?UGE4WUhLdkJ0ZkpjQkxQL3BkblgvWFBGYTlGQ1RCaFlSZHI4Vno4aFho?=
 =?iso-2022-jp?B?RXViQTlSdy9hbkFFekQwY0FIeDZsZ2gvcnd2MFA5M2R1OWRtQ1dGMjVy?=
 =?iso-2022-jp?B?R1BQY1pyL3lxVlNlbkVSbGduY1ptMlQ5WThWTDRUVUs5eFBVaXFKOEVX?=
 =?iso-2022-jp?B?dTBWQ2VxR2ZwcUZxNTl5MFJNMzNSU3hTSWE1Ujdxd2xQMnEwWnAvS0c4?=
 =?iso-2022-jp?B?WEtYT21YTVRxWWttVlRNQi8xcjJ2WXg5MG1vRk9jU2lsN0QyOHRDb1kv?=
 =?iso-2022-jp?B?eHhwbVFBRDhKeU1XUWMxRlhVQldEN0tDVlZMa1Q0RDYvbUNYaEFVTnVJ?=
 =?iso-2022-jp?B?ZS8rY1VSSFE3UjlwMUNzRURJQUlLKzlDQ2FRSGRSL3pkRk1TaGpJWSsw?=
 =?iso-2022-jp?B?RVVPWkZubmRIMm5qaEg2T3NHbDJ0eEJxZldyQjZPM0cyNWRCUVlDMHZq?=
 =?iso-2022-jp?B?eE1kWjhxZnhBcmFxU2hyRVkvSFBIRDZWQlMwYVdzRHY5akRpVzNlOUYv?=
 =?iso-2022-jp?B?TE1pNXBHS2RuYVc5NHBqWjF0UjRVVDlaa0FDTTE4dGd4aGF2MXRLaWxU?=
 =?iso-2022-jp?B?bmdOZnZRYXNZUzRCOTFWNDFBVXgwcHFOOXpUVWlvT24wQWhUSzVVTUtP?=
 =?iso-2022-jp?B?V0RCcVhpK1JhKzcwR1ZyYmVtZUR6YVFjQXk3TkFVRXloTGRoSlpUUXlu?=
 =?iso-2022-jp?B?UTE5eGJua0hWUytZT1FYZ2FwKzFaQjFMRU0vZkFLSVBUZHFaamZ5cGd1?=
 =?iso-2022-jp?B?WVgzeDkwN0ZlQkNFRUtLb29wTy9LTURkNTFZYzVhTU1YU2Q5RUxLdWFD?=
 =?iso-2022-jp?B?aHpZbXJ0ZHI3Mzc4NithZmpldkhuVkN6OUdDbnUvdVZ1cHQ5UTUrdmw1?=
 =?iso-2022-jp?B?NlAzWXlyUS9MNzlhc0FlRytjMVlFSk1GUWlWNW9QRHdiVnhlVFRYQ3FU?=
 =?iso-2022-jp?B?NFNxTVA4U3lZK2hIdll5MkJUWENrUnBMaWtlMGs0ODZnd2dmNitSbXM2?=
 =?iso-2022-jp?B?TW9BZ0N5Ylg2TC92MkEzRkRabUpvcHNtRWNKTjBjbEJsbVptNXdDaVVE?=
 =?iso-2022-jp?B?cmVDK05YOCtJNGNxVWtXOCt5dXV4Q2xRNTFkZ3ZlNUI2U3AzYUJWWHlH?=
 =?iso-2022-jp?B?YS9KODhLdkNXQ3hxU3JzK1E2UVFTbXcwelJKek0zMGQwR2xFeUxseWJV?=
 =?iso-2022-jp?B?aU90OHgxa284bW5wZ2JCOFoxd2FoYjc4T20yVmlPZFF1bG9PdXRVTDZP?=
 =?iso-2022-jp?B?bElyUytTODN4NUppOE9HVVdLR3Z3aUx4ZGVUT3UvL0sra2txVVY1Q1Vn?=
 =?iso-2022-jp?B?Nk93UEc0TGFoR3pJdlEzWXcvVGpoYVlmWCtSWVdXa2RybzA3aEM2d3dH?=
 =?iso-2022-jp?B?bjc3eFlsSG9jNVlzbU9oOGtPZ0tNN0xKRE9qT1h5aEJkWG9wOThQaWN5?=
 =?iso-2022-jp?B?NWJRQmNnWm1BdG9Iak9oQUFhYnpycFdZTVZ3UnpqWW95c1JFdUhYcjIx?=
 =?iso-2022-jp?B?bUdvQUpUY2lNVTVFOFNTN2J4ZVdXdk5yTlpkT3pkQ3hkSDB3Z2hLcE5P?=
 =?iso-2022-jp?B?ZWRqOFZqVjREeVRORlczK0V6cTNlakdEbHFrMmhwNlVka1hPR0g0VDlr?=
 =?iso-2022-jp?B?enFxZGZ4RC93ZzlNNmtHWFZQMHdlYVpudE9TTXYzY1dCV1p5MmpBdU9H?=
 =?iso-2022-jp?B?N0ptRGlXZDFVVkNHL0swQTlHSWNVVkdsdW9NcGpXWVp5d3JkWURmNEdn?=
 =?iso-2022-jp?B?cmxOYzRxQWkwM2ovcUFPZncvc0RCalloWVBTQzQycFc2SXhGWXh3VkhV?=
 =?iso-2022-jp?B?dzVSMXZ5M002RVZrV0Z4Yjc3cjRhVVl2Mlp3STYwN0ZwT0ZpNFNwNFc4?=
 =?iso-2022-jp?B?MWpRL2FiK25XNlFuazVJOWVHTGdvWEdzVG1EdEc0VGlOTFp2dnJhSUgr?=
 =?iso-2022-jp?B?UU9BbytxQ3Q5bmxWV21QNXpJTDFZdGtNK09HREhvZnU4RnN5R3c5TDlX?=
 =?iso-2022-jp?B?YnRIUksySGJPdHJ5R1o3cHpTZ211UU1GZzM4a0FNeDNhYXZPckgzenRj?=
 =?iso-2022-jp?B?dUN3NE45Ty9GT095NFVPOUZoVVpBSWdwcTl1YThqWkhXa0ps?=
x-ms-exchange-antispam-messagedata-1: irpieBq4u3Gb3u9+YNM/zwh5CHJztCVSzKs=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	lpD8aLGXxHWj2YFoJBdP1rDKpSdRDsiR47uKApIEZ5jf1MYlsBpUWAMi53la9uZtPWmwRdLsD51Kw9HCYayRcyLQzUY/zj0jYL/J+iFXHBfhZLCkej32QWYp08X7aslwoPqASidDMwnXgZpGNCyeyTUd52/iAr8lc65g1MkYbDNLKF6EmMqPse12+V8EYWrpFzItAPzrtjyGhWLBFwvvXMoG21KQ2cHM4CL/JHl5BJwzbgMHMJDHrpWj/gDkkVd2fc6Wk7zVCAV2k7Nf5F61nelKaKCGnjJ6RUpMYr94EGG3+2gMCmHKclwDZjfbeJ9Djpo/Mtm/0a8zgSgTxEOfvg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB15624.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda88633-a885-4b0a-6784-08deef029fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 12:52:48.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wH4xC4n2brWd7LJUFXI7PwFGn06uv4wxBuTVg+i0H/M4goB0bdaSXJoshdZRjsHhxYqaRrToGCB7R9YuhWu6cXGOXap8m8sMbu0YgkQRAQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8437
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 05:56:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23850

--_004_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_
Content-Type: multipart/alternative;
	boundary="_000_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_"

--_000_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Source: libcbor
Version: 0.10.2-2.1
Severity: wishlist
Dear Maintainer,
This patch enables autopkgtest for libcbor by adding a control, makefile an=
d a run_tests file (uses makefile to validate the upstream tests against th=
e installed package)

Also created MR:
https://salsa.debian.org/debian/libcbor/-/merge_requests/4

Please review the patch and provide feedback.
Kind regards,
Samarth Atreya

--_000_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Source: libcbor<o:p></o:p></p>
<p class=3D"MsoNormal">Version: 0.10.2-2.1<o:p></o:p></p>
<p class=3D"MsoNormal">Severity: wishlist<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">Dear Maintainer,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">This patch enables autopkgtest for libcbor by adding=
 a control, makefile and a run_tests file (uses makefile to validate the up=
stream tests against the installed package) &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Also created MR:<o:p></o:p></p>
<p class=3D"MsoNormal">https://salsa.debian.org/debian/libcbor/-/merge_requ=
ests/4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please review the patch and provide feedback.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">Kind regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Samarth Atreya<o:p></o:p></p>
</div>
</body>
</html>

--_000_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_--

--_004_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_
Content-Type: application/octet-stream;
	name="0001-d-tests-enable-tests-via-autopkgtest.patch"
Content-Description: 0001-d-tests-enable-tests-via-autopkgtest.patch
Content-Disposition: attachment;
	filename="0001-d-tests-enable-tests-via-autopkgtest.patch"; size=1744;
	creation-date="Fri, 31 Jul 2026 12:47:39 GMT";
	modification-date="Fri, 31 Jul 2026 12:52:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MGUzZTllYjExYzg3OTdjNmI1YTBiYWM4YjdhNWMzMjFhNTNhYzg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZXJuYWxvZmNvcm4yIDxzYW1hcnRoLmk2MDBAdG9zaGliYS10
c2lwLmNvbT4KRGF0ZTogVHVlLCAyOCBKdWwgMjAyNiAxNzozNjoxOCArMDUzMApTdWJqZWN0OiBb
UEFUQ0hdIGQvdGVzdHM6IGVuYWJsZSB0ZXN0cyB2aWEgYXV0b3BrZ3Rlc3QKCi0tLQogZGViaWFu
L3Rlc3RzL2NvbnRyb2wgICB8ICAzICsrKwogZGViaWFuL3Rlc3RzL21ha2VmaWxlICB8ICA4ICsr
KysrKysrCiBkZWJpYW4vdGVzdHMvcnVuLXRlc3RzIHwgMTEgKysrKysrKysrKysKIDMgZmlsZXMg
Y2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRlYmlhbi90ZXN0
cy9jb250cm9sCiBjcmVhdGUgbW9kZSAxMDA2NDQgZGViaWFuL3Rlc3RzL21ha2VmaWxlCiBjcmVh
dGUgbW9kZSAxMDA3NTUgZGViaWFuL3Rlc3RzL3J1bi10ZXN0cwoKZGlmZiAtLWdpdCBhL2RlYmlh
bi90ZXN0cy9jb250cm9sIGIvZGViaWFuL3Rlc3RzL2NvbnRyb2wKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMC4uZTQ4MzVhNgotLS0gL2Rldi9udWxsCisrKyBiL2RlYmlhbi90ZXN0
cy9jb250cm9sCkBAIC0wLDAgKzEsMyBAQAorVGVzdHM6IHJ1bi10ZXN0cworUmVzdHJpY3Rpb25z
OiBhbGxvdy1zdGRlcnIKK0RlcGVuZHM6IEAsIGdjYywgbGliYzYtZGV2LCBwa2ctY29uZmlnLCBs
aWJjbW9ja2EtZGV2CmRpZmYgLS1naXQgYS9kZWJpYW4vdGVzdHMvbWFrZWZpbGUgYi9kZWJpYW4v
dGVzdHMvbWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZmE2OTRk
ZAotLS0gL2Rldi9udWxsCisrKyBiL2RlYmlhbi90ZXN0cy9tYWtlZmlsZQpAQCAtMCwwICsxLDgg
QEAKK0NGTEFHUyA9IC1XYWxsICQoc2hlbGwgcGtnLWNvbmZpZyAtLWNmbGFncyBsaWJjYm9yIGNt
b2NrYSkKK0xETElCUyA9ICQoc2hlbGwgcGtnLWNvbmZpZyAtLWxpYnMgbGliY2JvciBjbW9ja2Ep
IC1sbQorU1VQUE9SVCA9IGFzc2VydGlvbnMuYyB0ZXN0X2FsbG9jYXRvci5jIHN0cmVhbV9leHBl
Y3RhdGlvbnMuYworRVhDTFVERSA9IHVuaWNvZGVfdGVzdCAKK1RFU1RTID0gJChmaWx0ZXItb3V0
ICQoRVhDTFVERSksJChwYXRzdWJzdCAlLmMsJSwkKHdpbGRjYXJkICpfdGVzdC5jKSkpCithbGw6
ICQoVEVTVFMpCiskKFRFU1RTKTogJTogJS5jICQoU1VQUE9SVCkKKwljYyAtdiAkKENGTEFHUykg
LW8gJEAgJDwgJChTVVBQT1JUKSAkKExETElCUykKZGlmZiAtLWdpdCBhL2RlYmlhbi90ZXN0cy9y
dW4tdGVzdHMgYi9kZWJpYW4vdGVzdHMvcnVuLXRlc3RzCm5ldyBmaWxlIG1vZGUgMTAwNzU1Cmlu
ZGV4IDAwMDAwMDAuLmRlMjI0MzAKLS0tIC9kZXYvbnVsbAorKysgYi9kZWJpYW4vdGVzdHMvcnVu
LXRlc3RzCkBAIC0wLDAgKzEsMTEgQEAKKyMhL2Jpbi9zaAorc2V0IC1lCitjZCAiJEFVVE9QS0dU
RVNUX1RNUCIKK3NyYz0iJE9MRFBXRCIKKworY3AgIiRzcmMiL3Rlc3QvKl90ZXN0LmMgLgorY3Ag
IiRzcmMiL3Rlc3QvYXNzZXJ0aW9ucy4qICIkc3JjIi90ZXN0L3Rlc3RfYWxsb2NhdG9yLiogXAor
ICAgIiRzcmMiL3Rlc3Qvc3RyZWFtX2V4cGVjdGF0aW9ucy4qIC4KK2NwIC1yICIkc3JjIi90ZXN0
L2RhdGEgLiAyPi9kZXYvbnVsbCB8fCB0cnVlCitjcCAiJHNyYyIvZGViaWFuL3Rlc3RzL21ha2Vm
aWxlIC4vTWFrZWZpbGUKK21ha2UgCi0tIAoyLjQ3LjMKCg==

--_004_TY4PR01MB156245BCE9C799F433EE08327B3C82TY4PR01MB15624jp_--

