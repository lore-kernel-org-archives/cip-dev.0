Return-Path: <SRS0=Bq0x=KW=lists.cip-project.org=bounce+64572+6472+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D4C4707F
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 07:11:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2BD613B6
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 07:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2BD613B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6472+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OiJiYY4521723xsgFVEUmjeH; Thu, 27 May 2021 00:11:09 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.114])
 by mx.groups.io with SMTP id smtpd.web08.3647.1622099467928731209
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 May 2021 00:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIumBUxTCyOYz4OYRo95pNEacjS3IXwa73SYIh4p7UZlSomZ9WvbeWpboreQcnR+KANVT/1L8mCTWvWBw69iDQ4FuGEd5gntyRNjStfxaSNWgE/Um1TA77QbVlCyDS7G6LmRBGJD9PHgMpEtuQEeZenLHODe/LpKEoiwlCAq+IZ8yL6jBOjfFQeDbyCXX2EdcgZsL6v9j/DGEfXc7jqL3Xu3otLEnPgA3YcqsOBLeOmj+biRDzcnt470ITixp21g1vJHK9AQbX2YJih/dnaLlsvM74EsUBslcwe6rBECoMkHSKC825abAAFHDnxpb9B62ISXwkzx9HfSyFTvcrA7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIWKoGjg3GSQ2Dj6POYXq1UWZOBlpiSocUzBc7wN8gk=;
 b=Zgd2kQ/gm9PEBXwesem33gQ4KSVoCF3+MmGS0RAp168byyuiq0xqh9VQYsCVY7gAI5CFEgC54FqBR3/WAGvnt0rNyCoxI6HLw9Iwc5R+BlOJB+Floeivz73Gsj6Adho0GEE/lpjlt8u44FswckdeNJUnQgjdqNgnlV49QUvMDS7TobV0Ov29TmhYHwfn9hnN11CgO6lPpAdjQ3oyF+kDbVfgp3YJB0VgIZ42ViRAYwdIJEme9Tl+iZqW/8hHhLonOuQC588qWDfxsyr45eCEc6maL2NIj7Up4PZpEDsPuHhyD2W+uMadtB3UXwLFHZF3XRe7LI+0h5pwJPFt+EMu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OS3PR01MB5976.jpnprd01.prod.outlook.com (2603:1096:604:d8::13)
 by OSAPR01MB4836.jpnprd01.prod.outlook.com (2603:1096:604:67::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 07:11:03 +0000
X-Received: from OS3PR01MB5976.jpnprd01.prod.outlook.com
 ([fe80::7926:766b:bbe9:4ad6]) by OS3PR01MB5976.jpnprd01.prod.outlook.com
 ([fe80::7926:766b:bbe9:4ad6%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 07:11:03 +0000
From: "Hung Tran" <hung.tran.jy@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AddSlBMPrYwUnUoRQr27IsfFgmvpSgAMnQgA
Date: Thu, 27 May 2021 07:11:02 +0000
Message-ID: 
 <OS3PR01MB5976212A27BE928E8D0F51BFC6239@OS3PR01MB5976.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972D72BA28167827F3DDC92A0239@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB4972D72BA28167827F3DDC92A0239@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [210.245.28.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5247d70-17ab-46c8-2b67-08d920de96b8
x-ms-traffictypediagnostic: OSAPR01MB4836:
x-microsoft-antispam-prvs: 
 <OSAPR01MB4836BA351FC2A76E8AF65F42C6239@OSAPR01MB4836.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 93T2An/O4DiBxaGCMlkiMxGvp5jnIeWA3aS86pnk8E60Rs/gnzGaVw6LNboqOxxyovRv9McRi9tKDaf6B0QnasmnYsQehfCBjwTB9XWCrRJJIxg4pqk9LcHCdv2I/uGKGEVenBzgsxvAh7IAiYhpHrylZ0PRjz9p/k5bBzdw+esw+j5twSkhf7TUU9IWgraQsbrLnvzcrPBqbs9FZlJbID5V0VRqQAusHqe1HJDAK0DDMAYQWfMwKOcRGtWcMKLXFAMS00NAfLj7hq1oR/pca7hByC7ieZL4SbzixnpmAHgdSI14QRB/rFKmmVPiyznkP1DUpsbVym4Ivr2Tz9ufGmFXVSQkIXJXZdulkvqTf6D/X1b1HXexXYgtx37Rpwm3KyPbv6MVoz7k4JZKaxi5VcIkiEB7YSUG431qLl3Ynw8GJljsHuh6JolrakRc/v3Ud7wWuM1c/Hs8QOocxcjigAwgYSrxY7v5G52gF9bMfVxPfvtp034fGKVNmCXbl4BDQKvkhhyNLZBhGXAf8LXFVd9TTcSfkcdQuY9XnHWScJceRknS4HVWVM9lFaQbWn5hOgTmRgRmWqqD6280RRU9RMGwXppC8/RiLTr5GyMa3RSUW9GMstSW6ptUJIRV+PyMA6XxyGKUqz3bZ5WS21T0T11ITfotjdabvFRLnzICBLTuHZRNGNVxnMJNFXbHnzoCIjz7pC4iyh3rj1Pt49rT/dXML/F+KJCo1qxDX5DXD08=
x-ms-exchange-antispam-messagedata: 
 =?iso-8859-1?Q?2H20csKyfaHO22ilxaooezxVzBQvlYWjk0bTpA8lIVqR/TF9fpWnLmFfvh?=
 =?iso-8859-1?Q?BUkrkA/m1gk2KLl66xUo8w1TZoou1LBOwMcMfp5V28vfVTILByRKlSEYxU?=
 =?iso-8859-1?Q?ObJOcy28YmCemOjwwAp/q714H4WlpbpXyajG2T9gohMu9/VMI/rQ4AsjU1?=
 =?iso-8859-1?Q?hx9+aVFm99i/L9geNQKFNAZSTKfedtdXs4qjmhl2Ti1QZK68MxyHkAK5l1?=
 =?iso-8859-1?Q?CXds4xBkuWnJJ9W2ba1tcl6hbCoeYQtWx9cL1glOh1NKXh+xJMtGVfXR4X?=
 =?iso-8859-1?Q?zoqWJWxhsEmnn8X2G/C/osEmbD461UR+ajySTHZ2qoI0+xQkuDXfSVLI0T?=
 =?iso-8859-1?Q?E5HoEr83TPVeMEA09YQP4/SNEXbjH493UacfkfLwDdeD8fHBJnMxDm+JRK?=
 =?iso-8859-1?Q?6J1ZVUg1Ww0hUkvND+aD8NfmquQE8mF+qX/nOtgTPdSm7q/EQqadBlzyZQ?=
 =?iso-8859-1?Q?XvtAty5GD/qsE4iqPY2nMy5p1yVOgIrC8Bo0iOuMa+aUnJfdgAp9sGIgDd?=
 =?iso-8859-1?Q?MyHpshDuVex0zY8lxEXhTGjP4AUSP2QfSvylRNa0iNlB2Xug0JF5dkwoB0?=
 =?iso-8859-1?Q?+cX6zzxnMP/pvsX9wHI/pyRd3khm5H6hFLAzfFzk4muaCrdXxZ78eqFYQR?=
 =?iso-8859-1?Q?K/NzngDsCCBf7BYmL7fv+/8oYsOSxMhygX3wdTyUkibxkBBA8HxUHURa3Z?=
 =?iso-8859-1?Q?pcTLcsLIm7g1VC/csbgRYd8+YqHIJet0R9sCQ1dE4b7J0FR0L7DUCPJnUa?=
 =?iso-8859-1?Q?iaeUTWckYOvYd0DL+mKkWrSnOlRqsyTBgc7relE8YYLEbVlCJlDhjwy+HF?=
 =?iso-8859-1?Q?5kWDxhLIIzA4UYz1zMNFKff8guNpfmxpDhEy4Oct41S+MxA2H3w9CMvOEd?=
 =?iso-8859-1?Q?+z9YAyLhwKp+s1OGJCf7OICauYqThnxEeTpICMCtY2xfYN4hGlg9MHx4D/?=
 =?iso-8859-1?Q?UxOED4QbEqtRh8SlkdulkdD2xkgtOoNgUNIH3h16ZL4di722hpIo+G0zWy?=
 =?iso-8859-1?Q?Vf6MEeW1gYvTBr5NtPXPdhfMA4JBoZJuflSlZ+WtNaIWCcY9yOH/qGUd1A?=
 =?iso-8859-1?Q?q8IqPtRumshKHGCISfOdZV8cP+IUMwJAVZUAMvnJK7T1pZVZVZB9ab4VtT?=
 =?iso-8859-1?Q?uUhmwim764Zn9ApUx3CJVDdmpDaOYwOWCzBeqytg7T4FGW+E6ymZo8Ye0v?=
 =?iso-8859-1?Q?/kW9JNF8n0NSAxUCgs++ZmRYLv3zUzkS2l6fVIGsuDOZWNkWoaobhxUF4w?=
 =?iso-8859-1?Q?W2xh2Ietu9ww3UNoVHOrSomXcNiYNnsP4dNJN8xon+RmUDpxysVUNguvw6?=
 =?iso-8859-1?Q?XEzQf/6XASMiGDwWRtIFmGJLhZI7Ke0HjsywAdQFWuwfccTcSE14EtDDkg?=
 =?iso-8859-1?Q?WZ7/Ga8ZlE?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5976.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5247d70-17ab-46c8-2b67-08d920de96b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 07:11:03.1294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0rsoe5GWFg/PO8o8+ijjFCMeENCausVz1KGSrGeXdoQOLUyBtE0kFauZHuN/Z/TTA2VTRxrqWV6Hzu3XcSplROtDHzLhIXGAdzaR/JpdJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4836
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jCHBj1edbPTVIOaOHlIhf2kqx4520388AA=
Content-Type: multipart/mixed; boundary="r53ssnYsPfSxhJJK2qpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622099469;
 bh=H33eju7RZ5mxTnvQg2iVsg97jXIiJIjgsqGlS7xRBvw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cvUNHPZRIdeTR+2TCVu+jmYBMMK9ugYN2aGfTydmrghwpjHvDPvq9lkHTQzEgUWNPPB
 FYuhufDvFvMAQ2yDpoqRGRdfh7FYJiTSWTxJKV9s/ChI9ZgqPfclvuWRxgrgyVcu0tc/G
 UuU0XoRJ4cXrREr6jWAFSkzrilGPtQi5A/U=

--r53ssnYsPfSxhJJK2qpy
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

AFAICT, issue in Freenode IRC is very big now.
https://gist.github.com/joepie91/df80d8d36cd9d1bde46ba018af497409
https://lwn.net/Articles/856543/

Regards,
Hung.

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of masashi.kudo@cybertrust.co.jp via lists.cip-project.org
Sent: Thursday, May 27, 2021 8:10 AM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D5&day=3D27&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest USEast=A0 UK=A0=A0=A0=A0=A0=A0=A0=A0 DE=A0=A0=A0=A0=A0=A0=A0=A0 TW=
=A0=A0=A0=A0=A0=A0=A0 JP
02:00=A0=A0=A0=A0 05:00=A0=A0=A0=A0 10:00=A0=A0=A0=A0 11:00=A0=A0=A0=A0 17:=
00=A0=A0=A0=A0 18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-20-09.00.log.=
html

* Action item
=A0 1. Combine root filesystem with kselftest binary - iwamatsu=20
=A0=A02. Do some experiment to lower burdens on CI - patersonc
=A0 3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kern=
el Team
=A0 4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team
=A0 5. Update Testing table below with 5.10 info - patersonc
=A0=A0=A0=A0=A0 https://wiki.linuxfoundation.org/civilinfrastructureplatfor=
m/ciptesting/centalisedtesting/cioverview


* Kernel maintenance updates
* Kernel testing
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--r53ssnYsPfSxhJJK2qpy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6472): https://lists.cip-project.org/g/cip-dev/message=
/6472
Mute This Topic: https://lists.cip-project.org/mt/83115707/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--r53ssnYsPfSxhJJK2qpy--
