Return-Path: <SRS0=oGbC=FH=lists.cip-project.org=bounce+64572+5937+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F09C71156
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 10:29:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FD920758
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 10:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FD920758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5937+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cQTPYY4521723xMrpXU6d9tn; Thu, 03 Dec 2020 02:29:02 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.102])
 by mx.groups.io with SMTP id smtpd.web11.8295.1606991341000897336
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Dec 2020 02:29:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvw5Wb9CMZ95XubJeAARB6uixDdkMAg8jW570IEILQhj5ds/P6zbZjno0aFEAaNGnAB1ULCLU/KBHnfBY2NmeegsNVHvmSM6qbmAu70em8FCYeWqyJ1d2mzJ0FHL0ckSCjgrSvy6BcD/SWOky6sjKOsQ3u6m6oy9waekxxD6LhT6vrypkTTBe396J00hkWIclJTIzn74JRWLOU1vt5fT/2jNOL7tDp959HXM53sAzIUMbZv9XkJDkpP+3eMI5XkdDE8qVDylJYTlIHT/CtENKSjYXvyXyrrOJGlekQL8jJz/VbkF83+vogApUd/TNCTbo8rXYyuM/jjwh+dIscI9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iPR7RAO4lc3SvyJuiXaWbjl7Vfk85F4dUYRd4UQsXY=;
 b=SQqIagt0JrhpB4Da8VqlK14sRuXoxrNVlBOYzPCZOocAUE7v8WUSEB0rQ4U5+jnuCHZjWCbNOivl0uDWBTRIAAEr9AhO1A85w+HzP02D3W3eQB2DeFXTDByh411Ju0t9RrRAzZrMbJlGUwcurw/ufTd6FZzAxCgaxUutWOfX1cKBpRzcg4w+2s581/AL89LF9S2YD43bwXr1wrujwdpDKnP5w5+nSprKwbRi4TVtY4SdeE1NHF8nyQgJsD/99wJ1ugYSRmyFcXCvIJ8AFa6UXyUtX0v+LVkEm3easTbgYqTKTumg3fekBTQp7q6lxXISGhD2/Ob7U2/QAs7rCfgaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB4978.jpnprd01.prod.outlook.com (2603:1096:604:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 10:28:56 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 10:28:56 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Thread-Topic: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x
 SoC's
Thread-Index: AQHWwprqAJYvGLScc0eNiEWnfsB2T6nYidAggAyuLcA=
Date: Thu, 3 Dec 2020 10:28:56 +0000
Message-ID: 
 <OSBPR01MB504886569B850A38A6C77EA3AAF20@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201124194918.GB4916@amd> <164AB40B65E6E3DF.27508@lists.cip-project.org>
In-Reply-To: <164AB40B65E6E3DF.27508@lists.cip-project.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bb2c9b7-2e8e-431a-8659-08d897763d70
x-ms-traffictypediagnostic: OSAPR01MB4978:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB49787B23E478B9C88A31F651AAF20@OSAPR01MB4978.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 /fQQzJd169z/pCb44kDpp5RSUVumSvl0SD8dcX8hma+Rk3CONfEklBx0BKZW51wvoisDgTo/kBkyMWLXC55Gf8uDvYTDRJJUv9eRFTkLswwzQ130rm2/gIhVrUBQgC+mBtoFK7x48Ss59iecsivVVKegpKVO8fK615SP8aDSaoOt7TJo+sIevQnlQOOsTS12nGdqVUraJBR5dMn2lDbrhBtTdwkdldYZ4eaPm+wNIf6BLsk9h5TyXWfw+5G6auGFqxYlFQBTAMIER7ZDFGMMbdjHDyHZgMN/9tL1SUFWJl7iTqiX7qL+vvDMe1Telxb02wJJf+b13EdVk/a4jhZ1qA==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?HcweXXXkk+lYQicYhtqktVJgpOCNzTafoh2rZU9jsgNPMxZYx0p+MtftP4+F?=
 =?us-ascii?Q?NdEiQwacr5+XSp4VYrCsln7bfceE0OZNNP9mTVirquEM2NG4VrsezeMyI4sB?=
 =?us-ascii?Q?UYE3HJcMZ9qFaQNS5vR4esXbvK2wAkkdw70n6H8c0HJtceI952/A6RVnsDrS?=
 =?us-ascii?Q?7N2WqUBRAZohffXzdp/NVF6w1b8tZLjREncVf/1nAHpRaPUymzoeL4oAWS3v?=
 =?us-ascii?Q?b1oEpwtjfBbUaRjpJFRldFJ9+NNaNdnSTsHlclVJaC0bBklgn6KZGsmHmlwo?=
 =?us-ascii?Q?LHYAEM3WskzIT5z4XiekVMaYYzU0RPWh8HgxBvfgYJZBKVvS8huUVzfg4g28?=
 =?us-ascii?Q?SK4BhSySYpxruXd1LOwwGLCTaexuq50G0DadO7Myyu73i9mfKjowy5Y3PKts?=
 =?us-ascii?Q?lr0bhRvyWQ8THAQPoZQIN+RlvTPFX/nbqNPSuMq++FKzjwVA8DwjqRwpOE1b?=
 =?us-ascii?Q?QRQzlYe8GZcepQ8YLbyplQ7Dilj3VuZWdf2dGMhmVBUmxnrBRQxAlFcGGdrn?=
 =?us-ascii?Q?2agz/h/kSR/lG/aHHf/CN3uJ51dPBqm4ew5Wn4cAaFMwy2MnAsI2ye9BD/qu?=
 =?us-ascii?Q?n2my+oKWaRSUyebPGnXJZYtJmQq2DPkOv9PIiBKYKX3shJXCrfzhtpWDM574?=
 =?us-ascii?Q?3yLEr08obeLytGjIWEhvHz8vdRLQKMoiBtikKQ+ci7kPY5YVOtix4HyxsD98?=
 =?us-ascii?Q?XxKVEsYfQlwJqEo2XctnaW84ggmEkexSfEPlc3Oy/NQv6mqZj0eFablnqFGZ?=
 =?us-ascii?Q?yPDcyhe0lwx3wBCTMe0eUHfSFuGCX8Hb5zld+km70UngipAwBU2JzUiZGh/N?=
 =?us-ascii?Q?aTXwlRKp6LZ8P17NPC+4LKH8H78/OCLbOMqHx55qXGB2qA4tojpBHvrQRsxd?=
 =?us-ascii?Q?fpd1nYdMViKFnx8xwaXKyDOjNM5FH3S9rtfXl5kfjdHgSihKyAQWKxaRsWTt?=
 =?us-ascii?Q?sVCZm9I3dZ5B7YCglIt72x9afs74MimF5X6jBIQd138=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb2c9b7-2e8e-431a-8659-08d897763d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 10:28:56.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rGkwbrkBtZSYWR7WTanJDop2CCXFxfAs0P8MfCXi5BeVK8hVPYvMkBjQrZkq3tgSby/xcdq9cAxJ61atuubyiBWD5owlSIvR2x1WM2ZRuUW4hn3bFLH1Xk4Re8k5RIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4978
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: a5R4YUP7q8cVlL0rQTNKPjxlx4520388AA=
Content-Type: multipart/mixed; boundary="ze68nfOUF4TB5vsvodVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606991342;
 bh=fnpIHYr4KX475s43Y0sSC9V46Wk87BkwdEjJXw00rCw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=M/GCW+CGKRsYHuuRi/oEkUtP8VxQSl+QH4XOa0HNgvfsAQV1e+cF90vFQP9Abwq6JhF
 Zb+mC1RTt/NQ/5BORRdhhobpE179ltdfjeHAU2sEkdCF38WrvtlSJdkLb7So5+m1YLICy
 mTlrhVbCcDb/EONn8aFcCeyZ/3VHR1MXhvM=

--ze68nfOUF4TB5vsvodVD
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel, Nobuhiro,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Lad Prabhakar via
> lists.cip-project.org
> Sent: 25 November 2020 08:50
> To: Pavel Machek <pavel@denx.de>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ=
/G2x SoC's
>=20
> Hi Pavel,
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 24 November 2020 19:49
> > To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamats=
u@toshiba.co.jp>; Pavel
> Machek
> > <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: Re: [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC=
's
> >
> > Hi!
> >
> > > This patch series adds SPI driver for the Renesas RPC-IF.
> > > Alongside relevant changes for spi-mem have been also
> > > backported. This enables accessing SPI flash chip connected
> > > to RPC-IF on RZ/G2x boards.
> > >
> > > We currently only aim to backport just the driver hence there
> > > are no changes to dts/i files. The driver has been tested on
> > > RZ/G2{EM} with all the required dts/i changes [1].
> >
> > Okay, that was quick.
> >
> > What is your plan, merge dts changes soon? Or is the driver useful
> > even without the dts changes?
> >
> We only plan to upstream/backport driver, pinctrl and clock atm (consumer=
s needing this feature will
> have to manually enable the DTS)
>=20
> > > Changes for v2:
> > > * Patches {1, 3, 4}/7 unchanged
> > > * Patch 2/7
> > >    * Fixed reference leak for OF node in rpcif_probe()
> > >    * Fixed overwriting return value in error path of rpcif_manual_xfe=
r()
> > >    * Replaced C++ style comment with C style
> > >    * Replaced tab with a space between struct and struct name
> > >    * Fixed a typo in commit message (s/absract/abstract)
> > > * Patch 5/7
> > >    * Fixed reference leak in spi_mem_access_start for PM
> > > * Patch 6/7
> > >    * Return early in spi_mem_dirmap_dirmap_{read/write}
> > > * Patch 7/7
> > >    * Replaced C++ style comment with C style
> > >    * Used __maybe_unused for rpcif_spi_{suspend,resume} and dropped
> > >      CONFIG_PM_SLEEP ifdef checks
> > >    * Elaborated the description for SPI_RPCIF config
> > >    * Dropped the label err_put_ctlr from rpc_spi_probe()
> >
> > Thanks for the changes; they are probably good (I have yet to take
> > close look), but I wonder if we should wait until they hit next or
> > mainline? If upstream maintainer disagrees, we would get divergence...
> >
> Agreed when the fixes hit linux-next I shall post a v3.
>=20
Fixes to the driver have hit Linux-next, is it OK if I re-spin a v3 now or =
wait for it to hit -rc release ?

Cheers,
Prabhakar

--ze68nfOUF4TB5vsvodVD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5937): https://lists.cip-project.org/g/cip-dev/message=
/5937
Mute This Topic: https://lists.cip-project.org/mt/78482875/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ze68nfOUF4TB5vsvodVD--
