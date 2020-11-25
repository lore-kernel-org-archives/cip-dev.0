Return-Path: <SRS0=obUU=E7=lists.cip-project.org=bounce+64572+5872+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BA5C56201
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:49:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4141820637
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kgZvpgSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4141820637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5872+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id efvrYY4521723xaqIWjamltX; Wed, 25 Nov 2020 00:49:38 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.125])
 by mx.groups.io with SMTP id smtpd.web08.4224.1606294176938302947
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 00:49:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBJLQ4/LS+gOuAuxLOwnPtRESHQzouvb7xjIlU57nFPYEFWqmprNDIIgWp+LIAhMepJ8vhdxPL0c7XscpVUdR31pRsQWWEYvPth0Ticdi4vX5idN0dXBmezN+TC6EOZ50P3s4NQEGidteicnQUmcNbVzTTwYAbhHvkiwapjtCu91iVXPjTl50xHON4yigJLD45bTwGcS8vJl2HTYnstO0CJspUUlRs+hqrLGYJlKUUHdmH/XYXbEBCZvPkvsHjqJ4SjoR/e7Xqaocm0bOfVU4Inb0uhw8WTpKVrO93USQp2tRkjPS6Sh5QOvDIF9bI7Ktfa6aMfrP7OkJXWuEbLVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCJ4HJHWNx2k5DnraLzMsj+d6cfq4vfKHB4mwIt8tAw=;
 b=hGvX52ENyB3xYVv/B1GjinFwr08fqWrIx8XRPoaPkviYNOglu5GhBL6fmTpKMuU76jv3jt5CAn6w6Wqei/O8nkuaWmw2BXFIzxt7kQY4cXmUrcApCT/0YnYWJtEIW0abxG4EU44nC1PhSgRxHtTGBRsAIEZTfgK6xmQWR+iU/qKCHm3c0Hbi3p1JM2COCnHgpXYHZTq+wVIj6mgdQunKQuSzCMvmmzVqH3CI5qIIjhEYT6RguZW0kPdmrXK2i/mxH/UhCuIbFfFBA2xCesYRwNMgdFdGiCl2cj1O6ET7I1gKLEiMTa/ArJgHafVTdAhXO3kpHvm18biqhnX+9+zVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2343.jpnprd01.prod.outlook.com (2603:1096:604:12::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 08:49:33 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Wed, 25 Nov 2020
 08:49:32 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Thread-Topic: [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Thread-Index: AQHWwprqAJYvGLScc0eNiEWnfsB2T6nYidAg
Date: Wed, 25 Nov 2020 08:49:32 +0000
Message-ID: 
 <OSBPR01MB504836177875007ABDF2C00BAAFA0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201124194918.GB4916@amd>
In-Reply-To: <20201124194918.GB4916@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ed10588-11f8-4e64-5aea-08d8911f076a
x-ms-traffictypediagnostic: OSBPR01MB2343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB23433DF8898333ACC3C4BC19AAFA0@OSBPR01MB2343.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 sjXAUfGMPvlZaeLtrzqaXNH/71LhzKV1tFWLByvSoh1qZoUEwCprFihhrQCuF0IITnNyPxtyssGX1KmmIiJsvYy4PCsGmhS0vcyUBcgq5ueTV+OxJZaZFX/DC88/GkY1413L6a91uxQBRAhNZeuzbyefvsNrYcWfN7XoqsNXb00ZioELF6uPuoH75IXnG8fKziAOzOvREeYp7ZegojMNvlR8I3KMiPOMrR9NzNBNdIqfhqgd+Zs7v7MQAX8Gl9AP/q2KPGJsjD+XyTXqCxAyMhq8rPcgo38fLSL97szysmHJVG3VpDiwP7hYnC0D8ugyRzioGZe4M1wl1Bv9zQWsog==
x-ms-exchange-antispam-messagedata: 
 lt0Z60qhIrmsRPieYFOKxQ7Zor3oxrIqE3q0hgQPrM1QZNOkPFfJsGjxOdWNL4QKGdNrKp1D7D1crGfQ1Nuw7bRGmElIfqF9rsBrSIbOWAqvsZlQqPAIU8Bv6Gaun6rxv6co+9yZsCJJgCmz33xXVg4F7nDqdzPCW/6LiMsMnUWsGNszEzUjT0qv29HoPjbGrHgf607i3tl8pez8/vey34EcLyhK9f+At+q6WdMwPmLXMCSM4mk8GuWKtVp3YYeuMinLIsCYEZjEEyFnv94C/Bj9TsAMgQHHCk4bTKZV0L4Ie3fikt3trEYNQGf5vQsZBXaKg6p5xOnVrS+lRiI08q3ykfQO1AceK1B/6h6oY3YKMQKJtdrnL1DZtxpsNtocbsCBMx4Z2BN79pFl5nm3KMGOy1uqJbHgDt7UW3keu/pXPLbl9++9wDrSsKNR9eLExrttsGEYREYt9BRHK9nCVdk787BhTcMFbozDfWatAv2Vd4edSnJGisjtBAYs8YXnSr25xqsmTx03/pCGFIiT7gyGXSKwta8SeJKQrYu2Xt8cUL5lrzUzV4C1eX+Qvj4CsP85ZfelNmWqXnxmRRkzGe7cCBXInKXs7k/hJaUX9fsq5E+2WLsNCd9E1fFyh4fXpEfxy0oM8hgRMgXwFK4rwboQocsH1rSKcgKRRPyF3/g/R8sQED7tCSii7C1ZAMJBBInHcJEV871JpBoIdY+0eFXJA7cgzXFu0YE478ArFLEF/qR7eOjyRPt7PkHjmJH2oUcrbtBCK5XOG5OIq/KTOFQW/J8EsAnEC9UvMT4mZGcy6gPDi9hZ96KmZSCvdWDK4QU83qyCYg0hKH+C//a8vAKtRUfgCEBEAXKozqlb6wNULoikEdXZadIPYXRgJesc4gDuUne0pmA4syP5XcCszg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed10588-11f8-4e64-5aea-08d8911f076a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 08:49:32.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBelNkPcxVezcHD7wBFkBYBdHc98If+rcu7UeRIXsQQtMfdtqJeNOjB8z/zC+V3eAKhYWtugOS0CsPLCOYafhG7TDPWnOZl68Mga/1yQWCs5q8dwLSTA56/NxkNikuhx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2343
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GgFlKDfgecNRH9AW2xmo0mPMx4520388AA=
Content-Type: multipart/mixed; boundary="LShgrZHOFVgTDFn4V2k0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606294178;
 bh=pAizej8RuENGQeW0krVpjoi7RcN4hcnvr4xTVX90NrY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=kgZvpgSXjzmgbkXF0wN5i5EUgbWlQC8tqBk0bITR7j9F2aKrLYiblR/2q9rNsJA/dVe
 t47EE4EJNupZM8XKRrHfBpqob3YGanfMxzRqeUGhIkfc/dtCK95/twtxTs57sMAdNOQdD
 KquCfrZazaw8OKdE0LkE2pkki+cRHSVu1ws=

--LShgrZHOFVgTDFn4V2k0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 24 November 2020 19:49
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
>=20
> Hi!
>=20
> > This patch series adds SPI driver for the Renesas RPC-IF.
> > Alongside relevant changes for spi-mem have been also
> > backported. This enables accessing SPI flash chip connected
> > to RPC-IF on RZ/G2x boards.
> >
> > We currently only aim to backport just the driver hence there
> > are no changes to dts/i files. The driver has been tested on
> > RZ/G2{EM} with all the required dts/i changes [1].
>=20
> Okay, that was quick.
>=20
> What is your plan, merge dts changes soon? Or is the driver useful
> even without the dts changes?
>=20
We only plan to upstream/backport driver, pinctrl and clock atm (consumers =
needing this feature will have to manually enable the DTS)

> > Changes for v2:
> > * Patches {1, 3, 4}/7 unchanged
> > * Patch 2/7
> >    * Fixed reference leak for OF node in rpcif_probe()
> >    * Fixed overwriting return value in error path of rpcif_manual_xfer(=
)
> >    * Replaced C++ style comment with C style
> >    * Replaced tab with a space between struct and struct name
> >    * Fixed a typo in commit message (s/absract/abstract)
> > * Patch 5/7
> >    * Fixed reference leak in spi_mem_access_start for PM
> > * Patch 6/7
> >    * Return early in spi_mem_dirmap_dirmap_{read/write}
> > * Patch 7/7
> >    * Replaced C++ style comment with C style
> >    * Used __maybe_unused for rpcif_spi_{suspend,resume} and dropped
> >      CONFIG_PM_SLEEP ifdef checks
> >    * Elaborated the description for SPI_RPCIF config
> >    * Dropped the label err_put_ctlr from rpc_spi_probe()
>=20
> Thanks for the changes; they are probably good (I have yet to take
> close look), but I wonder if we should wait until they hit next or
> mainline? If upstream maintainer disagrees, we would get divergence...
>=20
Agreed when the fixes hit linux-next I shall post a v3.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LShgrZHOFVgTDFn4V2k0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5872): https://lists.cip-project.org/g/cip-dev/message=
/5872
Mute This Topic: https://lists.cip-project.org/mt/78482875/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LShgrZHOFVgTDFn4V2k0--
