Return-Path: <SRS0=+Ggy=GB=lists.cip-project.org=bounce+64572+5979+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4762CC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 29 Dec 2020 11:34:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B69207B8
	for <cip-dev@archiver.kernel.org>; Tue, 29 Dec 2020 11:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B69207B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5979+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zTu3YY4521723xNAWEgFfQfG; Tue, 29 Dec 2020 03:34:09 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.97])
 by mx.groups.io with SMTP id smtpd.web09.10813.1609241647610348430
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Dec 2020 03:34:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWnDb/ePw/4LDcnnPftz7PBXluFyKF96DkDwPTxPR3g8JucD6r/EUHJwwVcAdd4924BKUm/37IOeqfNRY/PsDKgiZUEKTh3GDw544Sm4sHZq+FntoBa3k8RbIAs5zd1+hzCZP7Yzo03HGuv9lcp3fM0BOwHvWkOd1nixojb+RCT9gHWHjvNJcv4FWL9a144Fe0rXUw0ZX1ETj1MNHNV3CCXI8MmYG8PweAB9OmjRPpWDXSM1BQKcfUqb8k6S5oy+Y58wQBviU3Qqa5B8R21fQb9DaSya1FcA9F6v7ex6al23FM8zzqL4OUCrC73wcPfRLFu8sum03SPVWdTsInvWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ3VNO09VaXRMHtZdP29CAcqj6dR4HAgLT+Ju/Sy1mo=;
 b=BKx/V+VGfTBpupk5IffOhd8pEuOulp+QB7YEzQ+CDYQTtFRn+SuffFienfn3OPZJRI16C78TutjAPwNY2b07VtR7CI7qJh0tK4eoP4k5g2G99VrqEXEXkh5XZ6Cgnn8LPcWHns7ue+17HC84rKUQV19+53dpmRrFEvLw79/+CITxDnaI4YeFMZIfktzEXr5jrj9gaNC1Zfc0nyvQqeI7Tm5oGXhfSjd+0grWPnpxefGTDeh3zh8hzeKNEWENC9nUFdPkSOXRDFzxza6zLf7TgZF8fTBmPxfWXbSThCK+7zVGM+6BF5c4fhqbhsXr+LZQ0ggZaJHu8DLLL8CSfCFTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB2098.jpnprd01.prod.outlook.com (2603:1096:603:15::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 11:34:03 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 11:34:03 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Fix dt nodes sorting
Thread-Topic: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Fix dt nodes sorting
Thread-Index: AQHW2MBlUndXrVbsPE64tTwhiXn27KoN+kyg
Date: Tue, 29 Dec 2020 11:34:02 +0000
Message-ID: 
 <OSBPR01MB5048A1008A67E0C6BF0AFB42AAD80@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201222112714.24595-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201223001310.GA13078@amd>
In-Reply-To: <20201223001310.GA13078@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b771281e-33e7-41cc-838f-08d8abeda4be
x-ms-traffictypediagnostic: OSAPR01MB2098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB2098F9E72E1461F9F7F525BCAAD80@OSAPR01MB2098.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 yPoO6koGWVaPcCp/d+IraDXGPqWhdR+2QZk42dxnacvAauADFeL1Qj2qPSTVUcR2wIjaOviJvvZlauEGqyhR1UVo4Zda2Sv0LiHbnF9I3Wxyf0KEm7U4ubClJ3r7bX7eCqlwD2mxy6zPPxLJph48Qs7DDvs8S/kzvpfUBSiMOUqXcZdRvIMuk+b1I3Dmu3KY/fR4FgSbwlbpiSmE32xkeu3GYZL6C7Dnu7XQIyb1QsHTe6naxnmEqGyaAZpgqleV7BU+SwE2S4Pv8INLaouDlT3Z3sytgI5Hb9j8tFwnn+LfwTYIJql+TykXb2Yq9TLBdHf+NYFAJUbi2sx6S0nb0GhiALYzErr7IMA6ghZPbi8l6rsEeDMjpakOW1VkgRe1Ysz0JlyG7SNa4s3hcMxcww==
x-ms-exchange-antispam-messagedata: 
 ZdBcS/KCGR/r3bo6XRU72IvW5Ip1v17zPNWE653ou+IatBVQh4pfBQQVDZXWhR+UDFDXHoYqSWJ5dA82IFYqvAtdLjK02M13+mb1/NgmcHPxznyWb7fmqA2JQur2NZqHxKANG9brFB7YUDmsZNksefQjrqO2KNWHhzE3ZoAI0Oj0FbmP+eUGhulMPIJUi3G+FSSDoB2n3BWG5mDmJiE3NJ3zAgFImzo9RIvJ2aMcEN+kduyu8woOXZlPVWKar1oHaGBrJAN67HPhgnXxMpwsz1VFSq5y3RE+BeKIK0jTtSn+pKl6YszKxu++j5cEdBCgINmRzvXjerBxD6PcV3QygiLbBcb3Z28lpCsup7EmT9Gc9ED/MG0Nlj3USNPhgKx8u9NQD8KGWYXuGuj3YgG8AyfmP2il5nvmHWDRZdz4RTsQ1VRPGAQTv9gcRLibvRZVDZp+u+kLrKEjD7FNzlrzhK+GUEVYptGd4ql9xaGwlmgv7AASEX0myPLTQ55UW0Y6o8VNdxy5wOkYxhhpgNJYhUumS7QU4ZH0cV/TxyNSrfV4xzorvWtGE2Aa5GOUodoGr7l1u1rVgTxVe9EjLwSWWECKqlZFE7VeZNJTyeWqurxycuzDJ3cLnN/HVkUEbxwVLZL5+XOXxux4aonPvl+VI3l4LwSHPFCYtc4U43fq04PpaYZCX1z/92Dxzp/7kRGn6tQqgGmjgx396VgaHY4092H2N3/k8H8nwz0/vEf5bR4=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b771281e-33e7-41cc-838f-08d8abeda4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 11:34:03.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99BzPkwLST/tAeTUtSgal6yGiF82W3+uiLRgS7D/X78Ijab+xwXybqLjJHsxTbdpQpaYgmCz5NxcCnsu0bnMbheAoewhmzGOwipkLC6bbVi2bxGoQGeVCwgLQP+JYBUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2098
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jm4Eji1ch3s9BWT3CL4ZZv6Ix4520388AA=
Content-Type: multipart/mixed; boundary="Wu5FnKwq6mTiT20OaB3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609241649;
 bh=H3kThXKKzOxnRPpH06id7y7obqQMU/QzmKDHaEblOmQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=CzYSfxUiWDfcCoSVf2Q5GaWF/pLWf9Cwq/mod0CTP+t+loMLbQFgy7S33KKTJ5zWA3U
 lHO4wsHjM6r21Na/FcZccjcwcI0/A7O2piViuJIzpE1qtWrk/pFONezgJGqpANZdzLuEH
 oEmPVLYgdklRKOJnuRLo9Au809KkW7GnMbo=

--Wu5FnKwq6mTiT20OaB3L
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 December 2020 00:13
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Fix dt nodes sort=
ing
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit 73aa5b7c941145b7a1a53f31b6a71dfe98007870 upstream.
> >
> > Some r8a7745-iwg22d-sodimm.dts device nodes are not sorted alphabetical=
ly.
> > This patch fixes the sorting of nodes and also fixes a typo in the stmp=
e
> > node.
>=20
> I see why this is good idea for mainline, but do we need it in 4.4?
>=20
Yes this is needed in 4.4-cip.

> I guess it makes patch backporting easier, but maybe that can wait for
> such backport?
>=20
Agreed will drop this for now and re-visit when such a instance occurs.

> >  		/* 3.25 MHz ADC clock speed */
> >  		st,adc-freq =3D <1>;
> > -		/* ADC converstion time: 80 clocks */
> > +		/* ADC conversation time: 80 clocks */
> >  		st,sample-time =3D <4>;
>=20
> I believe this is wrong. Should be "conversion"?
>
Oops.

Cheers,
Prabhakar
=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Wu5FnKwq6mTiT20OaB3L
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5979): https://lists.cip-project.org/g/cip-dev/message=
/5979
Mute This Topic: https://lists.cip-project.org/mt/79146851/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Wu5FnKwq6mTiT20OaB3L--
