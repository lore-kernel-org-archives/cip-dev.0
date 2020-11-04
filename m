Return-Path: <SRS0=6QVN=EK=lists.cip-project.org=bounce+64572+5736+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F017C2D0A3
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 11:04:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69A320867
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 11:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vlI0Ah6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69A320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5736+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6mHVYY4521723x8P90jlan2H; Wed, 04 Nov 2020 03:04:32 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.138])
 by mx.groups.io with SMTP id smtpd.web10.11245.1604487870492136786
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2020 03:04:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2tyvj2WrRNsdEQ/DHtPwdgMdJeVn7xADeK/yRv8BOAshrOCmG2/IsGcjzoGm4xnA21i3mc6c+GaZlZmz3WYByd6JYS0NWMqBAjIBJUMOtI3k6OoxpUm0J0JzGu5QlIguxz0eavKuETaBTzW5K8hWFnIb9DEtjIoy1HkzeYdJ8NmwEGuXa8Xsyxhm4VF9ADic2lZ2hBQ03U8epbh0Xk76KWBLB+8AGlWD5IiBm4hBTo+MFJw5ndVjNCcYXRbdYKy0RAAnWp5Fvb6ro0UfH2zP7QQtpxBVTW6fmJmBXmFu47sO8snGztbpaH5iJsM8EfS27gEb2Nx8uVTZg5UeHTSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySc/BXd4/cNptKIchjzmL/yqrLRP2ZacT5IRkdvpmvg=;
 b=nWBQWTseZ0GYhSEeq6Z75QTeotLuOFntH72VrtXK6gv3vuy2aU9WW+VNSJSMIBrtHRrQIBeNR23WMIOUZ+Vb1nQ17aXVeWcyj3p0jTWjGkz0PUX5DmcUKzWlfBbO3bgOGrD6OVxtoIB0DPCk2GxZbAuBwiOqXFRzelJISg+AdL4aiCbuAT8Xgo2VnQmN9j8v54CZ9GqXfHeYRPBdo2IIHsG56qfjre+WqTcKAPyzfToYl5TOJ7fts0KL2HH/zau313bio5hd2y/YKkATJWMjzXv8VF11FLP0yRMPwLPNXkZUc1vDOEwC5HufytOXIvc+Q8ElIZOjj975YH+tBxJgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS0PR01MB5476.jpnprd01.prod.outlook.com (2603:1096:604:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 11:04:26 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 11:04:26 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1, DU, HDMI, LVDS, PWM and sound support
Thread-Topic: [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1,
 DU, HDMI, LVDS, PWM and sound support
Thread-Index: AQHWsgd//I5iIs3v20mmEg7J7HgJK6m3P6TAgABlSoCAACrBQA==
Date: Wed, 4 Nov 2020 11:04:26 +0000
Message-ID: 
 <OSBPR01MB5048C1E56BE8E9C5BC4CF78DAAEF0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983B43D8C63FD5AFE24C87892EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20201104082839.GA5821@amd>
In-Reply-To: <20201104082839.GA5821@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3166d16c-c07e-4050-376e-08d880b164c7
x-ms-traffictypediagnostic: OS0PR01MB5476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB5476CF8F961CE8E8CB69572EAAEF0@OS0PR01MB5476.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Cbu9k/YbUqNlBte/iqIT1jm59+LU5iWc1S3DOpjBP/E6R+RrofwlE86zR8+GAurZWYUJ/e65mCGGNkLEW/nmxDud2NZHPp5fxlMuNqcNCgDflzKWOggXiaXaQvuwEo8/0t6+Ulb2vTbGs/H25pzfMr7GixbnyodJkJDxuY4muu3BFXNG4sP87g3jct751684PlWjNBzMCMKNOXhLacAKPxzMDJ7rL/OqaEWwb3I1zXo/Uw7hNwaQKmgxyPD8X18XE4hq77PviYuKWi+LNhJTesbPf/h8Lbm2NgGWEbPpyPsLVe7Vi8ScO7cpz26n5v5j
x-ms-exchange-antispam-messagedata: 
 cx/dTJ3d4fuYBTxSvcV6ZFOPPZP2s92foAGXBisZyqgkrGfK/CS1hOaxNwAOL/lX4ZKm2xA2iJiDBsVqgM7UoRXsBEPD0bKHUEWTLd9liwbEfpEFE7Tj8zLjj3y3mKzu2SUU9WxewnkAN3woMdkirPPROL06sdb0xFxJsB+vbu1R1f30vr9kaxpxPlcbHYZvFpPLOEhaEKyfAcKaasuVvNimCGLKHylldKjTQo1UX3Ung0T8hc+TJzKG3v7FoUceg+5JevyV7W2+FsCskuYFRK1phQi4CI/4t+t77N09+ajhkvfAB/yIYe/fan/Elf9tK0XMuDeQXr+8WrkAcyJyWuScu5L83071K+2pWE6JP9m5pg/rWKHkJYteEPBoXu1xIpbG98Xi06+c10k0wv6yqj9vZK0Eo7jNsJE+5HxFsDVIrFH4Pj9ZNPprskAytlm9FGDyvcnbIus9fuPjkoogjIAgdb0T2L2VlxY4hs2QTknfGLr7B3fjRmY7CLixt4yMjF4S9qIFxxiNfndLDG+YghAk07bbE7qP/R33DE4EcxbpjzIqhjRkAULPoVRSNoLrbI7ia9h6wd1Bb2fHH+r8rPHpQ5m+cSrF5xADcatWUZ/xeRTAZyY4p/P3LXtQUKrmrxhcW+3WGORCGR8GlMTjIA==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3166d16c-c07e-4050-376e-08d880b164c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 11:04:26.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VkGIpx3gBcGxZPVNqDqTNRMGepa2ziMskNDlbtklX0QvVftEpcHZb7mSr/nGSE2XsfVdbn3nSv9u2BV/ilgNcPjmvkpd7E30Yqi21Kc8NoaEjFOhFptafxb3M6HFUohg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5476
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EZ5TMqzL3XQQCsNXrMBqNyBjx4520388AA=
Content-Type: multipart/mixed; boundary="6A7ntY8s2JrbYu8yLLhu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604487872;
 bh=zdP9dX2kripxabKDWJO3qrfPC6aAUAu0zWD3zxomgd0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=vlI0Ah6Xpx+4V+Ejnaep2KMArz30dPAZG7RrX/08W7V0epZAXKiw1MLnB3L+K/Zdzgd
 JDsmwXrJeJ7oyDvDMBG5ZSa0acjlbbF3bP4M3odpx/gloOVAgOHC2+5iklJUj6D8fcqRb
 Vcure0Hx+KZg4k7Zr3zE828tspEVi2gLJBU=

--6A7ntY8s2JrbYu8yLLhu
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel, Nobuhiro,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 04 November 2020 08:29
> To: nobuhiro1.iwamatsu@toshiba.co.jp
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-=
dev@lists.cip-project.org; pavel@denx.de; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FD=
P1, DU, HDMI, LVDS, PWM and sound support
>=20
> Hi!
>=20
> > > This patch series adds support for following peripheral to Renesas
> > > RZ/G2H,
> > > * FCPF, FCPV
> > > * FDP1
> > > * PWM
> > > * DU, HDMI, LVDS
> > > * Sound
> > >
> > > All the patches have been cherry picked from Linux kernel
> > > v5.10-rc2.
>=20
> > >  create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h=
-ex-idk-1110wr.dts
> > >
> >
> > I reviewed this patch series. I commented to 17/17.
> > I don't think this issue will affect our reference board, but it should=
 be fixed.
> >
> > And looks good to me without 17/17.
>=20
> I don't see any problems with patches up-to 16, and our testing
> passes, so I applied that.
>=20
Thank you.

Cheers,
Prabhakar

--6A7ntY8s2JrbYu8yLLhu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5736): https://lists.cip-project.org/g/cip-dev/message=
/5736
Mute This Topic: https://lists.cip-project.org/mt/78011684/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6A7ntY8s2JrbYu8yLLhu--
