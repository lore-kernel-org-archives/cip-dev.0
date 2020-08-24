Return-Path: <SRS0=u9GD=CC=lists.cip-project.org=bounce+64572+5236+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF1C433E1
	for <cip-dev@archiver.kernel.org>; Mon, 24 Aug 2020 11:53:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F491206BE
	for <cip-dev@archiver.kernel.org>; Mon, 24 Aug 2020 11:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SrbIzt0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F491206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5236+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fQEUYY4521723xirvIWl1kFF; Mon, 24 Aug 2020 04:53:09 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.137])
 by mx.groups.io with SMTP id smtpd.web10.190264.1598251585462522678
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2020 23:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9sk/L44kUeID/nmVIToZnlRegRbW1FLoMvDpAjoIxDf3f6sNOsRFWz5RyawnP7Sr1PbjhPCvPQ5yCr08R2eDnrYutYFDTime8VTzsMRdzV/KepVMOv51bwYzKXK6z70TgNPenDqF/tFIZGPJyC1TWsTLpKVHbaWJ2LpId8K+ZTsKMlIlbDJecrqogpNV2DWswhq+A01mGUX1Zelo6IT5YjM57SSYp6HYgDIP0X97ZT+WKaP7Oj3tFhjZWvvq7lK4kEMmkksTNZhPwRlT5dyqJN8gz73sUOT9BykYE04TbW817ywTl7/js/7GY+LbQoY4tRAVcIFroT9wVgzVoqx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuL9QgrL2EZrT6B3xL208y4nKwNjV6zSNTDEjRFc4TE=;
 b=SARt+SPAqc1u5CiTFMEotuZvOy58BqCOw7XusA1WQItKJA2n7ZCX/auP3dQ4FKW/nht9oJgCTpidWzK5P1bq20vjqjLSSv/eLzV+GExfyzAfVGwJYBJCZGFl+Ux/6uhSOV/zcOioeUJMPWt6GQ7+Ijx3sFbQsYDRnFXzG8mutuv/NaqpJnfsoOZ+q5og1If9oTlykLCNy3X6iCHin2SjtCKZefYL9a7bM9htvVbjI2ei5riXjuJ54J+nTadROjr0qJFLcqrYN0LmxVBfbqatF8LutJUkfBabo3TxxJbwyWXeOVqzxuKE7MDf0LMsDKNCrx3XNIZCxMz2pXWvAuXSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB3836.jpnprd01.prod.outlook.com
 (2603:1096:404:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 06:46:17 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 06:46:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Thread-Topic: [PATCH 4.19.y-cip 01/12] arm64: dts: renesas:
 r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Thread-Index: AQHWdkbqXtL0A747EU6r2uPCYoBY1Kk/ufqAgADSAtCABZBzAIAAurmg
Date: Mon, 24 Aug 2020 06:46:16 +0000
Message-ID: 
 <TYBPR01MB53091561C3CC410E46A6A6F686560@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
 <20200819180505.GB5567@amd>
 <TYBPR01MB5309709F469C1BBDCB012749865A0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200823193502.GD25365@duo.ucw.cz>
In-Reply-To: <20200823193502.GD25365@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afd65116-cb0b-405d-78e9-08d847f966c4
x-ms-traffictypediagnostic: TY2PR01MB3836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB3836145F3619F03A3793814586560@TY2PR01MB3836.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 vSn+LZgzqxMsfGIenODMr8iWbFzQICLHbEP1XA+1KyDcle2j5JR16DCuhnAZiLf+rVzs4h5gG/iOPGhM/FO11XST9HOGs2CuOU85GP/Yvpqbph5HJd8sW9l97eZfJb715AIly2TZWzGe9HeuR6i3ixYRxlUAOTrCMvh55fqZNe8ZI73u6KNyKeD3P5NCwegqOQxeU/uMiT5zAIB2PwLIDMhhW//9UKEFWiTSbo+SgBuvNUS+iiDCvJlMA9Z7Hrerg13AShVGBa6XT3QWv6QdSneEZn/22DUoEwLpRLk2koqZYIZokNwFcKGUoo8A+dEdczSDaUlXJwk6/0aTL13tUw==
x-ms-exchange-antispam-messagedata: 
 O4Qovwq7cQC+rVidP114sZCq1Rxpo8VriIkiPAkn9RXAmGhwCPIfcWHaWne/VggsIzwj22VJ+l93SjdUQT7fC3khvcMgzryM/RJxQrezsEPnsCGtsIWuE/us+SB/EiInTIGVmsQctHUC4adfEOo9dn12IM6PI96/gA5HYWKwnrVdR/WdFRSUmj/49QPY4oYfCOLhj+qoOODmzvVAaGAf2LZNTRkNM91lmDOx0q8uQ+DEOTg2c8KrxiWhCVV30e9tP4QjMn7hRsVYV7aAeTA7JeGA5yfA4zefIx5tB98o+dfiZIgEO83DfRP/OsBVZvl53D5iJXVMQeqhp3e/dXansiCW5B6seOWrbMAHpRXUcZJ/6KfG8UEaN9djodevEhTYG0oLKJnFblNIvV42IRmG2EzPM4h4WuFBhlIqdbRzuG37q3nmVNnI052a8pgI0XBthu12e5pK14oCmNibWTMbuXWvKoIsnfRWRBFWD4uqCnPVfYVkZX4zcx+nhJiGybU2M0xGpMa4A8Pm3iRVSsPurMDSFwujfUI2vmk9SeLeotkG5APyfQbJ0jKFjLNKLOR3IlRa9Zk6VciYcfTd8rjgN3YGdB1GjfjamGGqw/4Byba83y6fDEVNONcH/lzAkwUJenAUu4Pm0gRxTT/VikNmog==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd65116-cb0b-405d-78e9-08d847f966c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 06:46:16.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRD+Cl8f76gkh4iqYqB/XtBKfz/Z3t2ZbwZOFYRAhhbl8TnWqWQK/Hc0WEqq2S0Df7Zy87D97FwoZ8RWTB2QabEVUa5dShmO9tc1QP+W5OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3836
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Tv613vBy4wvsy9zCkRJQl0iFx4520388AA=
Content-Type: multipart/mixed; boundary="i6x5vjREY5ZqRd5mOYEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598269989;
 bh=LnKm/blDav0my44c6m71WUevI8+g3ueDWy2xFIRykTs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=SrbIzt0BGd9iVWw/tXjUN+phfJdHXKHmRpiUGBEzZJO+m2nbO1dmDQ+rrkX/waH+frl
 /BoB5laBHJe8lU62XzQIm7R5B4CvsRmKdeqYOg+wwujaco8/VN+78I/FFyNo6+NuaEY4a
 ifMKx66JTrwGOL42yUVKeZkXIjEDIMjmLBg=

--i6x5vjREY5ZqRd5mOYEi
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
> > > Ok, so this is anti-social:
> > >
> > > > -dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m.dtb
> > > > +dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m-rev2.dtb
> > >
> > > This renames dts away, but at the end of series, new dts is created
> > > with the r8a774a1-hihope-rzg2m.dts name, but this time it is for rev4=
 (not
> rev2) board.
> > >
> > > So... people with rev2 boards and existing build script will get rev4=
 dts..
> > > without any error.
> >
> > Yes, that is true. But if you agree, We need to use our latest/greatest
> SoC/board as the main SoC/Board and rest are with explicit revision in
> dts/dtb .
> >
>
> I believe it would be better to always use explicit revision in these cas=
es;
> anything else is fairly confusing, as kernel update breaks your setup (ak=
a a
> regresssion).
>
> Now, if -rev2 had few copies, and people really have -rev4, there will no=
t be
> much breakage. But imagine if rare -rev5 is released in future...
>
> But mainline already made the choice. I'd just prefer not making same cho=
ice
> in future.
>
> Now, what to do here? One way would be to apply a series, but add a
> README.cip file explaining incompatible change (and any future stuff peop=
le
> need to know).

OK. Either README.cip or " by including more information on the reference h=
ardware and test information on CIP wiki." as suggested by Nobuhiro.
Please let us know, How do we want to proceed?

Cheers,
Biju


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--i6x5vjREY5ZqRd5mOYEi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5236): https://lists.cip-project.org/g/cip-dev/message=
/5236
Mute This Topic: https://lists.cip-project.org/mt/76290781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--i6x5vjREY5ZqRd5mOYEi--
