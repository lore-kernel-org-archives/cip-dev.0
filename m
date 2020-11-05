Return-Path: <SRS0=bfRB=EL=lists.cip-project.org=bounce+64572+5749+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01309C00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:50:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4062083B
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nuDMuIcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4062083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5749+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ums8YY4521723x4Ta3rr2wnS; Thu, 05 Nov 2020 03:50:41 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.122])
 by mx.groups.io with SMTP id smtpd.web10.6325.1604577039683919179
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 03:50:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivcbaJzUOZALKif66hWKJS3YwCg1p74Sykf6WWp8Jo4kc6X4TwmKoe+sew5fO9SH3TEqljBmhNf9aCFnPNZMqKMRGgxf6eusZ+vYv1BTNnDHiC5q3r7BWsPVnz8j3Lo26wAdLlI5uXJgqF7h8P4TYnK48jCtDblYaWYuxM0LniB41hWOBePyTsfWnWwsPm/tukmD+1wLc/alYj0BQUuBPP3tGocQ1XJUs6sQOhDoptdB0ezKIduMUFM6rHX7M2PHygF49etxdxnyCC20Vx0a6l8dME1nBFjscf9KK4JeSYXhdeLl+4Jh22qjE+wCNqa1WZfdg8nN42cBxtId8LtA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y000NxUAAkr7T7ohQW8EbIYAXKqAAkHOhunxgiFMwMg=;
 b=DBKZkNegZdb1yBcCnuP6dsd4XInCwNUYPICXfIh4j2vKUZNur2EP6SlGlnOA3USMqiR+4yJBU2H5SIl3avEyUNSTDnqjRKv9H2Vh6X57sZSgO2/MGEAfPC5eFTLeR7Lt5WVUH9ExJrld184GdyFJEV1lBTLHuqMuDDV0F5yQCudy4aj1mdUz454xnrl5fiHDncvK6NeN0mxbFs2hPentKKx3wK1wCBKGHb+uRcFrrRnvD1+JeJ3HCrHIfebTsNSTup6iKplY6vH0/qbFM7zz+7X0/gBz0yuX10V8+0D36ATUS7RXSE4/hm2pIe0yQ/Qe5YNxUddJ3IsTV8DJZZ0WoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2550.jpnprd01.prod.outlook.com (2603:1096:604:1d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 11:50:36 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 11:50:36 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774e1: Add USB2.0 phy and host (EHCI/OHCI) device nodes
Thread-Topic: [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774e1: Add USB2.0
 phy and host (EHCI/OHCI) device nodes
Thread-Index: AQHWs2bckJpCtcTsXUK5P/cx8Wd7zKm5a7wQ
Date: Thu, 5 Nov 2020 11:50:36 +0000
Message-ID: 
 <OSBPR01MB50483903B8E5EF6CDB2B85F2AAEE0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201105095039.4751-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201105112854.GA8073@duo.ucw.cz>
In-Reply-To: <20201105112854.GA8073@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32686654-cd72-4e80-342b-08d881810296
x-ms-traffictypediagnostic: OSBPR01MB2550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB25504A6E441C5E3520BEA99DAAEE0@OSBPR01MB2550.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 rP0nQt1FLswY+eimifrP6z+QpqVm4iQEYgbhvxD2ic/+UqkhBQpsszpRUiBblkzrw7QOmtg4Azx14w/yEfsRxc6XIqlqXzP8ZLu4Uxr0yar3R5t/Frldz3a9sx5U32XlfJQFEGtzo/gtxx6f/7Nk3EwT6nOZ2hWU5a20MqKGd6cMw+tBv9sAa9qWtN9GvFG7mrf7edG2ziD0UsJdm2tzz3dltqn+V1HlwFkD961psfopzrsjkswXTftgJAsbgi4yjoUpEx3zVnsSGT7q3RzRuG1EC1PoTNfCmufrwFx2U87Tnl4Evr777i3RjYjTAa7kTcutAA76ARndsNzTwtL+blfNzDHn+k5aar35yxz1EUZd8+imXrcIbh7Y5OsAmLAkkaBkRxuiLZKfWn6XoqSWEg==
x-ms-exchange-antispam-messagedata: 
 yW6Gd5ngs5KvDVeGgjpi/sJTPWw4fKrFP4hzKU/EsRuqrrpWY371dsvJMadvckL+EQfYirJ6X0AfpJhmVIeHyZE191if15b96Zu3tdwf5WfD/bE/SeeYeO9AvKYY+MxANRecvwEgdGzxLSsywd5uQIWPR4l51vlOOcoRL1r00rRRd2Zg5envPwb4cshxlmVvgxNf77pAWd45qNqK8yQAnFaFTXBTtON8UmcKlm91BpoEbXmpaizWzvuojBQE2XQ3DIWepCmTQVK3uJt1I5YcjEddGm+e+SLa4s4bnLEm1qx/yIvzo7CNcK+Mdlxum/lWMZksX21dGgzmkIBpYpV40fqul+EM99wW+lswdCdxyo2hAfA7xQbocJz9eXrcpY8Yp49ZGfj1M1Y/ZztWdbYz3ZubeYAosdIpDFD9+KPypTWQ6uczGnyu47QrIU9msr6ZICIX0zgCAcpL3tFdF1VZatre8bDqUFudCE+2ixb3jvUnCwhjh4r6jUA8dkEYc9ZGsFdkMzbssZvC1gXxv99wDYHbHery0tUnHx9BFzA+JAvM878h7XuKIhDDbT0+L86ii6Xm3zYsBE5bUeoBOqySCUKVO1Lfsh6kXJbkImIuziTxFmJUhBSJkMnddkr9/ZlxsJPI8nTE8cGlBKaoP9dECg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32686654-cd72-4e80-342b-08d881810296
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 11:50:36.5948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfwssJ1xJkko262pSTooa0Kk+WGUts85LbKatY1JCyM0NxEiQI9qO33o00d4xjCiCKFkayD5H48wxblwUASYj4hP9IRDpyHxQuKir+bL6wPZhmrOdX5wCTlxl7BmL7f4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2550
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: utn931xT0HN52HSZLBlQ3S0qx4520388AA=
Content-Type: multipart/mixed; boundary="deG6vBCb6o8acL5gjRtf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604577041;
 bh=I8sGDhxBi7qPwEwV87UxClCgfK7Fav9kHJGR3FCNURY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=nuDMuIcqMqY2ulx9unrTAz0o+aAEYycrVoTD8xHj8sba09a+zj+qKPysYa5w4gKiVJA
 Zv52TKkIb4Asyxn7F4M1lgZSp5wGEsnlpCoKuyk8+BEwYCFNb0OAV6HPa+nJvdB27SBxB
 Q0uCosP7sVgIu/YZ5Zfjjf2YN/Jd8Ef6x/g=

--deG6vBCb6o8acL5gjRtf
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 05 November 2020 11:29
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774e1: Add US=
B2.0 phy and host (EHCI/OHCI) device nodes
>=20
> Hi!
>=20
> > commit 92b2c276e15c7f93f1148329a1f713c51b26f652 upstream.
> >
> > Add USB2.0 phy and host (EHCI/OHCI) device nodes on RZ/G2H SoC dtsi.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.ren=
esas.com>
> > Link: https://lore.kernel.org/r/1594919915-5225-7-git-send-email-prabha=
kar.mahadev-lad.rj@bp.renesas.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 55 ++++++++++++++++++-----
> >  1 file changed, 43 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boo=
t/dts/renesas/r8a774e1.dtsi
> > index 271045556aa0..106d64a8112a 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
> > @@ -1468,45 +1468,76 @@
> >  		};
> >
> >  		ohci0: usb@ee080000 {
> > +			compatible =3D "generic-ohci";
>=20
> Should this have more complete compatible listed, too, for the
> unlikely case hardware problem is discovered?
>=20
Controller is compatible with the generic OHCI driver as of now there are n=
o known hardware limitations. If in future if we come encounter any hardwar=
e issue we will add SoC specific platform string with the fix.

Hope this is OK with you.

Cheers,
Prabhakar

--deG6vBCb6o8acL5gjRtf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5749): https://lists.cip-project.org/g/cip-dev/message=
/5749
Mute This Topic: https://lists.cip-project.org/mt/78047674/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--deG6vBCb6o8acL5gjRtf--
