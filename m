Return-Path: <SRS0=RA38=D6=lists.cip-project.org=bounce+64572+5670+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A4C388F9
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:16:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7CB20882
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qwCM0iBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7CB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5670+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9IEHYY4521723x8DVcZnZaaD; Fri, 23 Oct 2020 13:16:29 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.104])
 by mx.groups.io with SMTP id smtpd.web10.2340.1603484188203172820
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 13:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcgY3GLmfLAJLHtSjsF/4eQC1MvSJ/1uEKUI+EYgc5y1vAll6dhTclA9c69f0QxY3VlvGxPWHKJwxRFDDIXFjOeaq/9QiqgySeyAOlBP1tSxQsQvd3MofBs9yhIVdbGr4lID/MJAKE6KeutEGDL9aoXILXzcYK2pjEqppTO5mLWSIpVSzSULUuotu7ynVSQFpSLykOeGPTQu14HxWkQahWwsNcNS83cErxAJTUSPt/an7CSreoVZlDSG5HhWEHtcOCh1upGGBxW2jwFnkVvBPWLMW53ZxA0hoH9cGpm/bTJa/P4rB4VECaAPrQuLWRoVa8xFfTybGEdmvsUAQdL2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYoNgYMF7PwYvtT9Jc1Sg30b358o3sqatr3EKv+5kdI=;
 b=H8psFdaNdSbmlRXIkvNxhx3ocJx2vlXMH72Gs+iqR7ySxm4/JMbZtVPj8O2CkOFQvt93uwn9xEH/jkfLmFAxhHstzYHXdcvVE7E47XFEXKS/iI8Jx6y0Z9Zk0yqNtkILNEaf8du26PHjpH4ygXhCOsrofnhhMICBNxSF+6tm6v3JydTNmJKwhUwoItkSRE9W58rA69FF8fiG84GZaoIhHnBx1Df3UdQCAOSb3jFDpTbtx/5vRT5Ua+aSAirCJZ3mSlafsqHq6Ll0mY6wLgrHItTwM2+t9cFtmRGv6wml1NjHqnDfxrW5lG471xOZhhNRPUlyqW1uHypD3csA37vgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB2260.jpnprd01.prod.outlook.com (2603:1096:603:1b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 20:16:25 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 20:16:25 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] PCI: rcar: Add endpoint mode support
Thread-Topic: [PATCH 4.19.y-cip 4/6] PCI: rcar: Add endpoint mode support
Thread-Index: AQHWqXSFYmjja6JTBUa216fmGX/U8Kmlnsvg
Date: Fri, 23 Oct 2020 20:16:24 +0000
Message-ID: 
 <OSBPR01MB50487F84AAFD3B0C556CBE33AA1A0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023165805.1910-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023194131.GC6002@duo.ucw.cz>
In-Reply-To: <20201023194131.GC6002@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f060c0d7-3b6c-45aa-3358-08d877908448
x-ms-traffictypediagnostic: OSAPR01MB2260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB226004CDE85F680BF02662BEAA1A0@OSAPR01MB2260.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 1ktaVvNAGEehUQvJKog/qRqKOpixPk8WA1w4iNwLgqB8HuqwP5ewUPC3byScxKORiYKQBCj6eOa130l4YWnMXY/aNj9mMFxCymAdYCcycYpdM0xdZq982Wo5h+TXbhtKye+2MDe3PGbQ0OkmA5letamPYiP5XsPy/2T6snznB9OixV8KHwZu+elLwPuKak90jXx8xSsb2pV6nOisXcF/D2aNeyRLw9EpaBou9UUUF/NU4z4P5secXLry33gfJFz1qxrDiR9qIuoK9zhUPOmsQK5DmG9We8qPFoXtEm6Fdv7LSieGgSkwmy48ku8Lne8d
x-ms-exchange-antispam-messagedata: 
 yQQInujyoYDJ9CYlTLp10BHT0ml5yHnRvvBnFuvRwJL/KHdD8rbggKC89l8C6xezR+wMi5m/mcZIZhk2Kd5iqhRbsPnnF716U/JTiU+LOgf3itbwcBfiMp4ZxAerA0sTNWE38BdqzClLlg77YQ19KsYWLPnqUK7lpdZU5U/0FMbbgpmdVecB4d+hsaC2Fno+Yzi4/3PKpMVHCg4ZUoXgsDPuIHCz87FAezc0aqHNGXqkq7MEv/S0gA/q2xd73B9umf3luf/wN1eGjWQDe2rsGEftanSlxHqgxGywewnBmIR0UFbeel3VAYVROLEVstFtqKDZLXG5oRZupH991lzqJjwJT/cZt6Hlr27lY12Hq8G/rbPpwVGgY8RviOIar0tqA5EaYUQrEAx+lhukvAanN04fLB4lwImPFH+q/vat3lgxRczohlDIz33mOOndGcdzjNm9p+6nYkovYTWU6l2lpaW1cXN2iglS7pb+TyFMTwJF1+/Lnw8GyiX3uM3hfdJpble4eUFNbYjS4JBNs3/xpPhPZ/diFfCJAtFuXGCgOwULGDcy9gPLlrHHt/C+/qDg3EEBMgunAlOROLGQHkQaiRBrwSphnCFpsrk05f0kOq0FvgNgNfe9aFAPT/vEQ5rtvhe3H2X5HlnIcGNgUjqHDg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f060c0d7-3b6c-45aa-3358-08d877908448
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 20:16:25.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOTTdqsagxKTImmMLFhAyErHr5CECEcA67xkWGo4RUCewlErepf9zpxZpyMBz2Fl+ndtfhx5tDYp8SRymJ24aeVGUTuEGJpz/QNRxv0Gyll7ctxFTSsdAlbnD3n7PX0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2260
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 36cf3iqBg9DX2q87KMEiUaQFx4520388AA=
Content-Type: multipart/mixed; boundary="HM9IuYJpX05L9sDplkam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603484189;
 bh=LVVjY2WWLQupr12t7eib8nJIcUkGME/ORiKkIB5ka8o=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=qwCM0iBRJegOQk44MjWRwwYTSQSO0GQA0+trWSSfbisxoMbrNk4Tw2bFDyeI86CLD7w
 YLvVvFGoh6vCpH2Uu9Ma6HNSUqREEP/APZjluHB/CpKOj4aBQhSZ8O1Uzic2QW5Nt57Vy
 7LGySQv6VvTwRYhZxfI1gLYz8euo10X++9k=

--HM9IuYJpX05L9sDplkam
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 October 2020 20:42
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 4/6] PCI: rcar: Add endpoint mode support
>=20
> Hi!
>=20
>=20
> > Add support for R-Car PCIe controller to work in endpoint mode.
> >
>=20
> > +static int rcar_pcie_ep_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rcar_pcie_endpoint *ep;
> > +	struct rcar_pcie *pcie;
> > +	struct pci_epc *epc;
> > +	int err;
> > +
> > +	ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> > +	if (!ep)
> > +		return -ENOMEM;
> > +
> > +	pcie =3D &ep->pcie;
> > +	pcie->dev =3D dev;
> > +
> > +	pm_runtime_enable(dev);
> > +	err =3D pm_runtime_get_sync(dev);
> > +	if (err < 0) {
> > +		dev_err(dev, "pm_runtime_get_sync failed\n");
> > +		goto err_pm_disable;
> > +	}
>=20
> I believe this should go to pm_put.
>=20
Agreed pm_runtime_get_sync() increments the runtime PM usage counter even w=
hen it fails. I'll fix this in upstream first and then backport.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HM9IuYJpX05L9sDplkam
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5670): https://lists.cip-project.org/g/cip-dev/message=
/5670
Mute This Topic: https://lists.cip-project.org/mt/77756297/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HM9IuYJpX05L9sDplkam--
