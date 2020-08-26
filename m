Return-Path: <SRS0=iQm2=CE=lists.cip-project.org=bounce+64572+5257+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B4C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0EF2083B
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ldjyIWF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0EF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5257+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ItCqYY4521723xzs1SwDSL0z; Wed, 26 Aug 2020 04:35:15 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.94])
 by mx.groups.io with SMTP id smtpd.web10.6956.1598423572253395643
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 23:32:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6V7oJyrMVbVVlr350ueEN8WU4sLXeMPR2P7GvTj4Gr8GVpDjWgJRNHcDwPwvRljOTpYq7FCqB2mEBfggaEmiNdMv7hRXZ23PqYoV8+wfkcJ2ssN8GpZWtypYK/4F6ctcMfDGLS5/KwL0JGtP+Y6ovCey+5CkGn2g3skjO2pfWYeC9lf8KzPdfKxQwskwiaZuicXGTanHtS7C9kKvHFjrS9gESimrN77AUI/sUjrDEsebrgZPWqT2IDa5T458dl+67IKLs0o3v+5ShEUgPqij4KerL2i2gVGvj9lK+VKD42om72HREEG6JZVpfRGo2/PoU8rvP1tDHkrTqSypFW2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrWFoXCI5hU2Rpl3HE4PtWnQBPZAQ5D6TR3v+W33kso=;
 b=fFZvOsOKq2so6XJie5mR6X/KSspg5KPf+bnr5nvelFpZ2s1BH3C691m6Q6Zij6GYJ5tngYWdtto9RxCG1G/PPD1KHYRVXHZcEUIEMqvYzCZFGPRe7s4mvp0Lk3QF65EZ/Q3J4AjdzYG9vbgig5MPv1QmGK2Vxpr26TXr2UJ2ca9fK3wK4elqLIS1hQG+pbM5z7mA2Qu7/hHUwqBdssUBpIlet7MmOvjc0Zk15r0yaq53qxSh9FX2yoCFH1PHmu74NbR9hnwS+lM8Fj6N0kz1GrfmLpRg8FtXSsc5AFjQc4YqVbyrZLDJQ1r28Efvx8wK1a/33iN9XjpBSFhRxlbdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB5161.jpnprd01.prod.outlook.com
 (2603:1096:404:111::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 06:32:48 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 06:32:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Thread-Topic: [PATCH 4.19.y-cip 01/12] arm64: dts: renesas:
 r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Thread-Index: 
 AQHWdkbqXtL0A747EU6r2uPCYoBY1Kk/ufqAgADSAtCABZBzAIAAurmggAKQDQCAAJFE8A==
Date: Wed, 26 Aug 2020 06:32:48 +0000
Message-ID: 
 <TYBPR01MB530908ABFF44B4CA8C8D8F6786540@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
 <20200819180505.GB5567@amd>
 <TYBPR01MB5309709F469C1BBDCB012749865A0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200823193502.GD25365@duo.ucw.cz>
 <TYBPR01MB53091561C3CC410E46A6A6F686560@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200825215126.GA28711@amd>
In-Reply-To: <20200825215126.GA28711@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f06b7b7b-da55-4502-e3da-08d84989d9e0
x-ms-traffictypediagnostic: TY2PR01MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB5161BFF5E87A8DBCB377AC3C86540@TY2PR01MB5161.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 62JugYZdIEhUuOi7YxS56eMMYAnix9BrB6DKTJWVzrfqsB1KlJ86KOCJj3TU5f8d5t+Gz5PzFTOV3B7uJ6xmQhyByKSunAyXTdY5emqP6aouxIbZtTS8i+om3xw7p8vjAQxfFOmVvRDNwFQXs9L8uA1soS5V0yT5liUM02rNkHBKSX7II7akuKgOI03QgpZG9tBdhpUrcE4+Z3hgeDlUPJIyj7om/0eKEMEpmUpau6/vsMSuzYqkPFpqJxUt7M8PMuH7oVD2toO4LLZEqZR7Kjj+UgekQTeiyucLiPQkFgbATZpSAKdX1d/A6bh26PTh53DMNJHkwrWZ67CRm/9CMA==
x-ms-exchange-antispam-messagedata: 
 zLkHpFuqA30ePKBnsynpIH4INCJ1ePp5zEPj9/2sgn2XAIzIVheQZJf0cqdVCWzoPQH+s3Uaf6RHgKqc2a6b8osv2Kgv+Gj7hXgyKxh95N66XFCnkoRZJjWDu3/IhROH2WDzMmeUiKrdaENMPlWhvzUtaCNs+HSnOxThgE8TD1HgU79JzLWa+dv+Yb5hTRFI81pYs80Qdo3JHpqS2pP8QTMBwVVQA/fz1xTj5P/Qp3FFBEMdct8i86YpKKhRMg7C2tFJs1cWKx52tjOEIjcrRnmqDkVBqUtB1kXtNHlbfEEdggNb4SrpNS6JmSjOaX0kYoY7SMU/M/i0NorhKE1tkaT+AozP6l+UikGuTAyu3vqqRHmt6sITQ7vKBxBNIZAbojq+j4UbRbDOUoWxJcrwalWWLHo6oCFPuHweK6rgCoYmb4xNggnUIshNUUQr4h2NGRgoauhCxgCKo/J0rYrtjA1xn2KEwjgsb+ZyqEhmYSBNGDen1G6P8Tfq6dZOc0DH5ev/cABZ1/O7W41z7L6q3+c7GcQFwbKDmqHH9GJbqTp7hSSwDOglomTGhT2iaXPcdYwAGqfl8XZJQ7b1jA/EWAvoMFj0vYGr+ywepiWrUK2LQWYTEx251Ee2x8oCR/7PlmXLNdzQXqXpPeyqhW+JlQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06b7b7b-da55-4502-e3da-08d84989d9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 06:32:48.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjVliiKgt1os66cTPm+3EpN/4Rj1gF9HyQsS0LZOig+uodipwgbmd9KEIUSDBtsEQXRs8g867bQhAVcQYBc6y7ncbEEqcK07z6Uv/6W3QgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5161
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: e2k3lE5ahms7YWDmcSt67W6ox4520388AA=
Content-Type: multipart/mixed; boundary="qBZCNITEyi2bhYCjbfNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441715;
 bh=GlYRRDUEqUaGZ0YsS+wV/AeQvfHojHzg090Bd3Qid7E=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ldjyIWF6JYlrchw3nlL+uQrbOG04kEqjbs4cidKOb98Idp7SUbdxtySLXuMN5wEASEn
 h+KWNJu+BTovFrqZArCGOOtVr/5BDgCoqpTSh9rpOVxzLKbEyt3COC5Es8esxFMxVSgNF
 FXi4QcOTafqHxR+X6e8uX4A1XzvgIVZclD8=

--qBZCNITEyi2bhYCjbfNR
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihop=
e-
> rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
>
> Hi!
>
> > > I believe it would be better to always use explicit revision in
> > > these cases; anything else is fairly confusing, as kernel update
> > > breaks your setup (aka a regresssion).
> > >
> > > Now, if -rev2 had few copies, and people really have -rev4, there
> > > will not be much breakage. But imagine if rare -rev5 is released in
> future...
> > >
> > > But mainline already made the choice. I'd just prefer not making
> > > same choice in future.
> > >
> > > Now, what to do here? One way would be to apply a series, but add a
> > > README.cip file explaining incompatible change (and any future stuff
> > > people need to know).
> >
> > OK. Either README.cip or " by including more information on the referen=
ce
> hardware and test information on CIP wiki." as suggested by Nobuhiro.
> > Please let us know, How do we want to proceed?
> >
>
> I guess we should really have README file in the tree, explaining potenti=
al
> compatibility issues and anything unusual happening in the tree. I went
> through old changelogs, and collected these for 4.19
> tree:
>
> * -cip3: MDS sampling vulnerability fixes
>
> This release includes many CVE fixes including MDS (Microarchitectural Da=
ta
> Sampling: CVE-2018-12130, CVE-2018-12126, CVE-2018-12127, CVE-2019-
> 11091). These fixes were more extensive and harder to review than usual f=
or
> -stable tree.
>
> * -cip9: m57621-mmc driver was removed
>
> m57621-mmc driver was removed due to uncertainty about its licensing.
>
> * -cip34: Support for Renesas RZ/G2[MN] revision 4 board
>
> In -cip34, support for revision 4 of the board was merged. After the merg=
e,
> r8a774a1-hihope-rzg2m*.dtb files are suitable for revision 4 of the board=
; if
> you want to produce dtb files for revision 2 of the board, append -rev2 t=
o the
> file names.
>
> ---
>
> Does that sound ok?

Yes, It looks good to me.

Cheers,
Biju


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--qBZCNITEyi2bhYCjbfNR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5257): https://lists.cip-project.org/g/cip-dev/message=
/5257
Mute This Topic: https://lists.cip-project.org/mt/76290781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qBZCNITEyi2bhYCjbfNR--
