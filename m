Return-Path: <SRS0=62d8=B6=lists.cip-project.org=bounce+64572+5164+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB1C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 11:09:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7066C2078D
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 11:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="a/+t9q2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7066C2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5164+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iw8BYY4521723xhxhiVp68Um; Thu, 20 Aug 2020 04:09:48 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.91])
 by mx.groups.io with SMTP id smtpd.web12.104951.1597906494513305599
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 23:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaKbitcNySbh/+a2c+to0MSWV0ZBxkjEnUzbyt1xdlXHg1+mmdXeuNDFFP7Lo8IizZ10MFwSWTEJsAeCJi7GK2HzmWggOXlozAzKSCZg/dDl2KnVnEq8IusQvqc252lLrRio6+4gBsGp72Ls7KsZVVEMk1mKFDpDgjQ2sjWw1GDA7fqysYLz799kwhtsjqbO5aeK1AQmFAds0GFAoAfdQ3gkJ+7GCBhlp2945o+V15mh/L4YR2QUY5iuTYZ3gbssqLd1DRUoIgXstvTae0R2cwTLOvLCIlYIkYQ8p5xNrsgT3yGL9aQPKH1uaF3fhEsy4iU57IXRk5onznx2DuHMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnJMQMPW85nOfaXrdxHjSh0pZ0rpG25qv7IKQAZU0Y4=;
 b=HyYVyT+xX8vTXn6uttUq/s17NcQnTzQvV6UZF2oaVz8Ddk1NtVQf5CMuinfRSkf8h9S6WPJQ2Zh2UVwgfScb7sLnd91Js38LzGpIVMVbLOSMMjqirKczUYVC7gAHnS3fDhCJOhFmlJjlcTEz70gIaetCt01Jj7v4RR/wRIIWWYt20C3EKb4+7QSyDobth++XroQGhgqdaGvH6HCQ4TEIhZdafEQKcry1HXTloQVQmkNNSol03MifAESphiJrhh6+cwRDaoVkZT1X9lH0+PeRmSIox/Se43DjYCpYRIcXbiUloRLJmPFhY9cWRZAwadYkEWXnTuyLWAp2j1/17C7png==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB2811.jpnprd01.prod.outlook.com
 (2603:1096:404:6f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 06:54:50 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 06:54:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Thread-Topic: [PATCH 4.19.y-cip 01/12] arm64: dts: renesas:
 r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Thread-Index: AQHWdkbqXtL0A747EU6r2uPCYoBY1Kk/ufqAgADSAtA=
Date: Thu, 20 Aug 2020 06:54:49 +0000
Message-ID: 
 <TYBPR01MB5309709F469C1BBDCB012749865A0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
 <20200819180505.GB5567@amd>
In-Reply-To: <20200819180505.GB5567@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9aecdb2c-b77f-48b6-7b17-08d844d5eef9
x-ms-traffictypediagnostic: TY2PR01MB2811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB281109E9AE334D5466E6AB11865A0@TY2PR01MB2811.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Yt+EPkwG7hPl58h5SoBrPs5pEvegnlLOcnkbNVc+91hi6DAouT988nlSifsiR0LoCoBXSZqwcxtgwfH1kJtBTH23MgHKBCgvUrPK0RhEznZRfFEn14iIdRbqMhVj3BG6VRpiP/8nXFWVveTRvPUvgotS+lhAd25zZ0aH/kwBapFtSLjeJ6i39E4sz4E7uT5JipxD2UrxFTICj/AAaBzfai5Bl2qAkrUVrLPq7Pwyn0RQjWeWj2F3o59wS74tENCuMTU/4WnPxFy8iQS8PIU2zG40ls5UuP1aQTG8AugZDuyNBKNL9uLb7LOuwkr4uslF
x-ms-exchange-antispam-messagedata: 
 EDcVEFBgfpKzWUBOO94SXKOPGH3iXPk6BSP5a6zdREUbhN/8ZNq/pmUo1pWljWcfyWdPjFH/vvp+DOiHN99AZgOwPZZ0+Mtz2X8s/R5SIZ/t2EoZpxzjihWtkjIKXdhFlLyWGeTJ/AC+g9CklDPmgcOIT8UnCMvN4xHhjwBgIGdG9iUTMuuJd3svm6H/0x5/KQ28IIaKpuT6gkE4OIqmE/wQt+F6UlmWOrRc3+A3pF4nFzKRDmGuMISYnD9KHogFg9ems7eNgzBfD+QccwJG9z664BCYZi39kpRrCEB9IOhsyGuHCjgMzBO5nWzPammhSBO17sxR/5tRyaYWg/k52aYflDPAGn28HXAbLkWQG/rn+8Lvnb5uitCGS9Ur8TRlzvZSPZWv6P37zE6ga1X1RcH5QXSXGBqwSNzwC5ng9HrCf8FGQPVDsFIqDB6Y/kTVruFMos/06pRL0P/fq0dO35+aai2oOyNDnYOhnacef4CjvWqTQVS850ItkWmzmOjc3HEGPTUSccamkJ1XBBfLnWOvMKqowZa8oYTtcfWJprfHPTot9matPv5DUQEG+mbrMGfq3Thcjt9RIp0TwNqfY87bQ1uhsZkx75mVJJuIyeeAx3wh4Y89rB1AyBs2hlkaCqOTCGPY/xc0eLu3S/tcRQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aecdb2c-b77f-48b6-7b17-08d844d5eef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 06:54:49.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZJYDY+UHD40Vr8pWVcPJ9X1HAMLb2K7Ba0AsQTO3/z3pKklxma+WswScnD64C6tnV4vWqMDtGfLbMpyGKzh4w407j9oKAOzriPoaxQaZnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2811
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6TV1ktWCHtWptjRUTcHFkzP0x4520388AA=
Content-Type: multipart/mixed; boundary="b0UmGbf0daej0ICJTBTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597921788;
 bh=ZByGs0eUFMM54BCODC5bfFlXmhDxlQy2nvvQ/MKqlEY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=a/+t9q2D0kB/X3/yvbZsyp69YrFFEJrLmb2rw5GAwD5muscqQqX0gB7XsRfC9ZI+o3Z
 5RPGU2/cTgCNFlvYOlwf4J3GhhkvFmcrI5ngWtVTfAFKrOqQ2EAecV2u394eQqcu/ne6N
 IiNO7rwj7maIz33ACqYwaS5mAR9jm2WXrno=

--b0UmGbf0daej0ICJTBTk
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
> Ok, so this is anti-social:
>
> > -dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m.dtb
> > +dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m-rev2.dtb
>
> This renames dts away, but at the end of series, new dts is created with =
the
> r8a774a1-hihope-rzg2m.dts name, but this time it is for rev4 (not rev2) b=
oard.
>
> So... people with rev2 boards and existing build script will get rev4 dts=
..
> without any error.

Yes, that is true. But if you agree, We need to use our latest/greatest SoC=
/board as the main SoC/Board and rest are with explicit revision in dts/dtb=
 .

The existing users can read gpio values to differentiate rev2.0/rev4.0 boar=
ds and load the appropriate dtb/execute the test script accordingly.

>
> Would it be better to always require explicit revision in dts/dtb name?

This is our thoughts on this.  We need to use our latest/greatest SoC/board=
 as the main SoC/Board and rest are with explicit revision in dts/dtb .
So this is inline with your suggested comment.

Please share your comments, I may be wrong.

Cheers,
Biju


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--b0UmGbf0daej0ICJTBTk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5164): https://lists.cip-project.org/g/cip-dev/message=
/5164
Mute This Topic: https://lists.cip-project.org/mt/76290781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--b0UmGbf0daej0ICJTBTk--
