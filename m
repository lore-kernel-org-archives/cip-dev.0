Return-Path: <adithya.balakumar.f33@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E02ECA5FA7
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.59779.1790605707362073315
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Sep 2026 07:28:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adithya.balakumar.f33@mail.toshiba header.s=key2.smx header.b=SPOVzNlC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: adithya.balakumar.f33@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:MIME-Version;i=
	adithya.balakumar.f33@mail.toshiba;s=key2.smx;t=1790605704;x=1791815304;bh=yk
	FgSwgx19xKa1vlaxXlZgIYnp5wQEjmStLgKaXCazs=;b=SPOVzNlCAoCO/v+/TSVDlc7hwLShle2U
	nOvlu08K35t+chz6CDsm1m38CkBSYpphvZ9U7gS3kCedeVlzM1pkYPAVSEHExK4npPG2cPV89nDuy
	wNMn1m0XE+7r2DvlSkaQH+Km+3/0Dv2hc7EZ79wx1YHZK1AErmiDpIncm137TBMdKLvDEOVAkC1qZ
	VkO1m34QZMyKth0sVXlEpj1e9LblApNYMnYpS7QACgCS4Uqi/q0SxPHLGUSb+2P1pJsd0XE3JzTGU
	I35KilZACVBXbpCL5FvZuM9oRnEmJxAQJx/GGN6TkfMwUu9mgKd6HcoJhj+BWpOu99Jrvy49vdptW
	lQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 68SESNLM1943336; Mon, 28 Sep 2026 23:28:23 +0900
X-Iguazu-Qid: 2rWgdPSRELBS2t1AsT
X-Iguazu-QSIG: v=2; s=1; t=1790605703; q=2rWgdPSRELBS2t1AsT; m=rcfccQc0mn/ViAultfx15WWCg/xNbg9iDRvfTDL7V94=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4htkF273QMz1xnf; Mon, 28 Sep 2026 23:28:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTMkBVJ3mnabhMqHsc+ei1kDZoc+ju/UwgMmNQQd7qjrP8RBbXojQTdTPKbPc97laqUrfxGiQ4t54qbODA64jrKo0q/AC14TxYvYGKKiF9lAqzRVovM0RvE/G8vKObKDETnNo8Q2j28nionzPD+42i40Q9+giADKHJbWqmiNPai85P2llWFdJdrmmMa7dtlu4+/nBwixc+H+UcevV5Jn2M5cfP8fDIdBhW7iABS6BhXGQvJMfBkUTVPax7ZQ44ssOW5D+FWOuAxpwcX8+oRytZE0VBT18HJo+iT6UYoEldtUrscTviqQAPa49FFJ01nIk8VgoVooyO0/bj3mpelXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qWLUWaJ2vVcYYw2FkaEN4+xkvQBjWwgbhriJTkYWLo=;
 b=D8g2eGA8EKPjU4dfZihEhjqn7BC/OYpepGxJHEB5I+BysCBdhdufZD78shn8Ud3scuX3zBcYRRHKWtwLuhOd9zOdCGTw+DD7pEaryBADrs7Hf3I3DDPQZW31YrAXK5/+6CzcFPzvHsXEwPwr4eYOuKyZPbN/ZvIRZ4d9kQKf+39EmBwYynFzp4pwA7fDpjEhoJWtlr6H+jelGA0cTxK/XHpC/3LhPL/BsbKqBcHlaHt7jMyPpzXAQw5Ox6hIpZLF6nEag1wFXt547R51KzrEra8D5iQM9l3+eT5D8dMtZHzDgF2AQJtWxBF+loD02bub/Hc7a37G/ulviagwedRskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <adithya.balakumar.f33@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <cip-security@lists.cip-project.org>
Subject: [isar-cip-core] Next steps for open SVV-3 findings (#152, #154)
Thread-Topic: [isar-cip-core] Next steps for open SVV-3 findings (#152, #154)
Thread-Index: Ad1PVEvzLW453R+YS+6WJawaOR0w2Q==
Date: Mon, 28 Sep 2026 14:28:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB881489BC0FC77380BA9DEAF4D78D2@OSZPR01MB8814.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8814:EE_|TY7PR01MB13704:EE_
x-ms-office365-filtering-correlation-id: f2a2eebc-db25-4de8-1456-08df1d6cbe4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|18002099003|8096899003|56012099006|13003099007|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 h0fNWHFkeBERK4FSx7Mjtc6PoRlPLQBFe9l2HeC6UsRktddg5k0lKTR3d5sjHMr3vXG7dn7wHKxy1WHuzfCOQcutPQeDG1TpSqZWvgrzfjIkK4MtRV+p76Yxctm6VdzSWUCpqm5+uO7telq0x1PLMuJngaLBqAoRdlNIetq60wmnhhwCwMg+Nj3fgMvKVaxHWnY9W420JBEb9AKe4WL8/eYcqjcT+G0HWmReh0CDdFq7nMxsANalwE89jtSefpeDcadPVKd/e/4TUJ0h4lZVnufBuwmZcD+TruS74PXtOBm72Bk8d6fIFBUJPxRY0g3XoiJMYQkNsaxWVVD5aqAbtE6bRTCrMXf8kn9Njf9GDPPxenMfLTUs3sVRiWak/5cY3/zS0a8AvLOoD5nvy6GY9M6102dQZ7vJd+U1ROZhl3cAF9OO0wPORNXyDoYbJ+BiqvsbaWI9QgctYC9ltdHSB9DoyeqR1NGHPDbm6QekqWjC/nwhEn2hDI+wyy+mtOgUX3S7Hmr3DEEUfITNqlQ8yhmbBgB0Qj1vz3qe6dPdS0wR2xdsHU/wcjtm3dRvEY439u55w7Pt4FFgtO8KwBXLb1hP5F/eiGD2ys1fG9BCo0zL9WoLbibtvkbpWuGbQbukrCjBuzaE8+jal2WMajEZPVFZ4k0yLkzSfhBUMQlCNdAuyWyGQb6jMU8nfCEde83uXGVub2BoE9K7trrqMFnuow==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8814.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(18002099003)(8096899003)(56012099006)(13003099007)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VVcyMk5nUU9KbDEvcmcrN1prQTlSLzQvVlZqM1AxaXlHYzRJM0dQYVUx?=
 =?iso-2022-jp?B?ejBXNXFtNERUanVnNGxCYTZaVWw1K1dNQ2dDcnNscjNuWjQ3YVJhN0k4?=
 =?iso-2022-jp?B?QVhWWFZPRmlzaC9DbzJEczJSWG92NWVyVUVYSjNEUUNOMm1keGgyZXIx?=
 =?iso-2022-jp?B?VHl6dlBpS1FBeTZUMTNScThxb2tnWW05UEtZMEExRjJ4R2hZRkg0WjFU?=
 =?iso-2022-jp?B?QWw2UnJIbllPK3M4SEt3SG5BS3pLRlFydUlrbC8rNmhkaVRIOU1KcmpO?=
 =?iso-2022-jp?B?bnhrWEVlbTFzYXhIYmtiZFVvMzZkWkwrU1p4cXRDM0F0UmdFVEVVWTRn?=
 =?iso-2022-jp?B?N2tQbk5weUNha0I0QVBJQmlPdDlxdHU5Q1RRbEszZDI2TFlsUk44YWNk?=
 =?iso-2022-jp?B?R3FrSytENW9WcUVuVktIZ2JhSldPZDlZWVRYaVJUbXpPaEtnRXJWTkEv?=
 =?iso-2022-jp?B?MFNNTXQrTWdvVS93cHNkUjRKeUtjRytiUXAyalRzWkJwRmdBM256S0U4?=
 =?iso-2022-jp?B?ZmJCOUM1N296UDRxbUcrVEZGMUJaTklNWHJNWEc2a1VuazdiUkRjalpG?=
 =?iso-2022-jp?B?VkhUZXM4QW1wemEwUHRVdUxvanppZWtEbzNmc05TVFBUU01OcGZpRTYz?=
 =?iso-2022-jp?B?SThJdUVySklnKzZWVGZCa3U0YnRQQUpRYjZjeFNwZEhlNnlBU0RzTVJN?=
 =?iso-2022-jp?B?UGRKcll2NDZXdXB0RnFoSWsvaFkvL2ZGQUd6L1g3a3llWjVZT1ZHR05Y?=
 =?iso-2022-jp?B?WFphN2syQ0Fqei94cWthVzBnT0ZNek9TWWJFL3IvY1haOHU1TU13cG1J?=
 =?iso-2022-jp?B?T0NSaDUxRHFsalpsNzBsZGFkcTBaOFZrYUhteDF1YXFuZTFNMm1Bb0NX?=
 =?iso-2022-jp?B?TGRpdmdiNXNDY3o5RXpVTGdTS2NEWHFzSWhVMWpFbkFnZUlxLzF2VlRT?=
 =?iso-2022-jp?B?VENNVzl3VzZhZ3pmcjl2MWplRjFsNDFaS2xoVHJ1ZXBxUlFkNVA1QWlV?=
 =?iso-2022-jp?B?OTNNcDRhRWQvdi9DMStXOW4yTlV5Z0lJeHNsbjFUK0ludE5sQjJWQkl0?=
 =?iso-2022-jp?B?MHhyWjRPS1Jyc3AwU0d5NEJZeG9zUE4rMUZSbVk3OHNiUjlEK3k1ZmpM?=
 =?iso-2022-jp?B?eFBOQUE3dk81Z3RSckhKbWxIZUpqV2oxNG5FWVhXZDFVeSszRmpycnYr?=
 =?iso-2022-jp?B?aUtTckhtY2FBTWdkYnR2eXg0dEFaM25ZNXN5R3l6T0k5aXRVY1lXNWNJ?=
 =?iso-2022-jp?B?dkViUU14ekFDVzNWQS9uY3NWU1pobzBZUlZpSjJCSjJsZUFzcEcxSGZs?=
 =?iso-2022-jp?B?ZTlUMTdBdXozUXRuT0NyZTR0VTlLRE85VW90Vk44VlJlc0QxZUQyNlFw?=
 =?iso-2022-jp?B?WHEvS2lzWUYwb202VVhtTllWQjVxMWMxSlc5SHVFMlZFU09yWCs1ZGpF?=
 =?iso-2022-jp?B?RGNCQm9jMDZQZDJJZ2l0akN6K1Z5OFo2S21tTDJBdDkwemQ0S29EN0Zk?=
 =?iso-2022-jp?B?VkhJSzE0YVBoMFkzSERSM1NGMGFtV0VralZrOUtBb2JDUWV5SUpuN1Zx?=
 =?iso-2022-jp?B?a2lGTGN1NWFCeERFU3NuRk9PU0ZMSUtVMEFDNk1WVXBIZURvOTV1ODVD?=
 =?iso-2022-jp?B?a0t4dVVycFh3YksvTmpwNlFNVytjbVZYZHNjcU9IV3dSYTFUa1FXYjZ6?=
 =?iso-2022-jp?B?RWV4a2d5YWtpTkZ1TlFEMGVuN2JTemRUSnY0UitWOUFCVXY3cTVrcExN?=
 =?iso-2022-jp?B?d3N1eWRDci9BdDIvZlFQTXFZakxLWG9mN1ZTOHk1U0lOVDMxajl6SG5K?=
 =?iso-2022-jp?B?S0lxMkNmcCtxeS9jdmFHTmFkWU01TDZXcFE5d3JEcm1NNE1NeE51ZUF6?=
 =?iso-2022-jp?B?ekwyNndkZEpaQ3E2NUlkZnNkQmxiOE1Wbmp3dER6ajczdDZFTUJtWW55?=
 =?iso-2022-jp?B?MGxHY0xTSmJMbFJFT2J0bWtnUmVWUDI4S2ZBN0UvRjZDNWtYVnhtREha?=
 =?iso-2022-jp?B?R09RYUVsYnpBejN6OWtBcVFtRlRFbUd1ZnRwdHhGRUdxZE1YOTRjN1Z6?=
 =?iso-2022-jp?B?NmhPTEZzRzB4bFAyN3VRWWJJenhZOUNCSHJvMlk5NjhXRlNPTWZNQ3RI?=
 =?iso-2022-jp?B?SmZmWitXOSttemFkQ1BUVUNuYzB1V3hsSGxvSEZVUnQrNkNPQndtN2lG?=
 =?iso-2022-jp?B?cnNNWmFnWW1SOWRoOGFnRkRWME9iMVhUNFF6T3BKOFFwbFlRbkIxM09L?=
 =?iso-2022-jp?B?WVNzWmV4NmhZOGlGaEpRYllwNDJ4NWJ0dnpzemZPNisrZEJyb3lNNC9r?=
 =?iso-2022-jp?B?TEgxQmtQNHd4ZVhIZFF0YXBZZ0FwWCtNQXRTUStYcEN1YlNwMDFhWW9a?=
 =?iso-2022-jp?B?MGp0OVp3QmdjU29wOUFaZHAzQnh0bEJLYUtSc0EzQ3gwUkg1V3I0THVU?=
 =?iso-2022-jp?B?elcrclhzVU5UaXBtQmxiNVd1aWtmY2hrYmJCRzFVdGVjZWlFS2xMb0Zp?=
 =?iso-2022-jp?B?R1NvNzhvQlI3RWpuRFYxK0tDamx4ZjFWTjJiYVR2d2MzVis2aGVEQzhJ?=
 =?iso-2022-jp?B?cGxGZ1pkTT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB881489BC0FC77380BA9DEAF4D78D2OSZPR01MB8814jpnp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	FRemF95FFWW6RthTrPYjISo8QTGvNVD8e8S/GVS1fdQrReFFki0Yn1j6L/mRCXagx/IamRoAKSZ2DCLlehn0oAxvMhxhiqCr/m++j9rhvTaILcQCsK6aGoAdcYlWyx+a22DGPf0slc0VFaH62gHDKEcOFmOHACA4mwuP/qOIDsuhU3Efu2CdZBP2ymPqlZNPzDJ8Si5lgbgsfYvgR8ermk7CcYjMlSxjd9I9Pa39y4la400QKTAyM6oKP8XC6rssxwM+Cqn98cDz+nQk8NmLv8beaCjDFV3DhXgR0hdNnbHjwViAPxUe0Ufklog2hSu75TyagOKZ5aqzbaISDpnbLA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8814.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a2eebc-db25-4de8-1456-08df1d6cbe4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 14:28:19.6090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fY+I8KHKBZoYwuSGCW0yWh3HGvp1GtqyWPNzZU6tXb3YLTjVDP3U7KvvDzAqSQ5Bp8yJT8Xb17uztwfF0Pf11PUxJnSPLRnH/4fXXYltdKDe7FuiaUVFCTvDmlzDHQju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Sep 2026 14:28:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24368

--_000_OSZPR01MB881489BC0FC77380BA9DEAF4D78D2OSZPR01MB8814jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

Two issues from the SVV-3 vulnerability testing during the IEC 62443-4-2 as=
sessment are still open in isar-cip-core. The SWG would like to discuss the=
m in the WG and agree on how to proceed.

1. PIE disabled for fail2ban-server in the security image (#152) [1]

=1B$B!H=1B(Bchecksec --proc-all=1B$B!I=1B(B on the bookworm-based security =
image shows that fail2ban-server is built without PIE, which weakens addres=
s space randomization. There is already a bug report in the Debian BTS for =
this, but the maintainer has not responded. Details of the same in the gitl=
ab issue (#152) in isar-cip-core.

As a possible way forward, the SWG could consider preparing a fix and shari=
ng it upstream with Debian. Even if the fix is not backported to bookworm, =
newer versions of the package would benefit from it. We would welcome the W=
G's thoughts on whether this is worth pursuing, or whether there is a bette=
r approach.

2. sudo - CVE-2023-42465 open in bookworm (#154) [2]

Our findings:

  *   The CVE affects only bookworm and older releases.
  *   It is a hardware-based attack (rowhammer) and requires physical acces=
s to the device.
  *   The code path that the upstream fix changes is not part of the Debian=
 build of sudo.
  *   The Debian security tracker notes that no backport is planned.

Proposed next step: we believe no action is needed. We suggest documenting =
the rationale above and closing the issue, unless the WG sees a reason to d=
o otherwise.

We would appreciate the WG's input on both issues

[1] #152: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_item=
s/152
[2] #154: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_item=
s/154

Best regards,
Adithya Balakumar

--_000_OSZPR01MB881489BC0FC77380BA9DEAF4D78D2OSZPR01MB8814jpnp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
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
/* List Definitions */
@list l0
	{mso-list-id:924069015;
	mso-list-type:hybrid;
	mso-list-template-ids:-1080654890 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1644772753;
	mso-list-type:hybrid;
	mso-list-template-ids:1447827218 67698689 67698691 67698693 67698689 67698=
691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi All,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Two issues from the=
 SVV-3 vulnerability testing during the IEC 62443-4-2 assessment are still =
open in isar-cip-core. The SWG would like to discuss them in the WG and agr=
ee on how to proceed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1. PIE disabled for=
 fail2ban-server in the security image (#152) [1]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">=1B$B!H=1B(Bcheckse=
c --proc-all=1B$B!I=1B(B on the bookworm-based security image shows that fa=
il2ban-server is built without PIE, which weakens address space randomizati=
on. There is already a bug report in the Debian BTS for this,
 but the maintainer has not responded. Details of the same in the gitlab is=
sue (#152) in isar-cip-core.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">As a possible way f=
orward, the SWG could consider preparing a fix and sharing it upstream with=
 Debian. Even if the fix is not backported to bookworm, newer versions of t=
he package would benefit from it. We
 would welcome the WG's thoughts on whether this is worth pursuing, or whet=
her there is a better approach.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">2. sudo &#8211; CVE=
-2023-42465 open in bookworm (#154) [2]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Our findings:<o:p><=
/o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo2"><span style=3D"font-size:11.0pt">The CVE affects only bookworm and ol=
der releases.<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D=
"margin-left:0in;mso-list:l0 level1 lfo2"><span style=3D"font-size:11.0pt">=
It is a hardware-based attack (rowhammer) and requires physical access to t=
he device.<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"ma=
rgin-left:0in;mso-list:l0 level1 lfo2"><span style=3D"font-size:11.0pt">The=
 code path that the upstream fix changes is not part of the Debian build of=
 sudo.<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin=
-left:0in;mso-list:l0 level1 lfo2"><span style=3D"font-size:11.0pt">The Deb=
ian security tracker notes that no backport is planned.<o:p></o:p></span></=
li></ul>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Proposed next step:=
 we believe no action is needed. We suggest documenting the rationale above=
 and closing the issue, unless the WG sees a reason to do otherwise.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">We would appreciate=
 the WG's input on both issues<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[1] #152: <a href=
=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/152"=
>
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/152</a><=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[2] #154: <a href=
=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/154"=
>
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/154</a><=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Adithya Balakumar<o=
:p></o:p></span></p>
</div>
</body>
</html>

--_000_OSZPR01MB881489BC0FC77380BA9DEAF4D78D2OSZPR01MB8814jpnp_--


