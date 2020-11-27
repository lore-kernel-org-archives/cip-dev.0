Return-Path: <SRS0=hWpS=FB=lists.cip-project.org=bounce+64572+5885+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45190C64E75
	for <cip-dev@archiver.kernel.org>; Fri, 27 Nov 2020 10:34:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BE6208B3
	for <cip-dev@archiver.kernel.org>; Fri, 27 Nov 2020 10:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Iksg7koD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BE6208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5885+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jwaWYY4521723xmx0eykZXQM; Fri, 27 Nov 2020 02:34:15 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.137])
 by mx.groups.io with SMTP id smtpd.web08.16773.1606473253615906182
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2020 02:34:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuDRtSk6UTBgblfd3QUiVa6trOKP5/AUkQv9AqARDlcE3K+SSf2fqODpuMgPrXrWCS57W0hKYI0bYcXPq1UbGnJIhjOAhboniurWRwqm6PrRSokxIA7rNgmPa5XrkIa8z5EAQgQck8gqLXTFgkTo8N2J1j2SSnspEBk2tfI2t0DTfUzs4VVxoPaQmBnRx/TfweOaRhu3+phwOefxIO7xnb9qSAwUX64+J/4c5ZpoKNxII8Rd8jzJNb3oiZSzJ71w8W5M5uVMLFrDRD+uZJGIHDPpedyUphSsAc97Xf7d3KVKUtKc571WveSDvATWeNQTQZzeZvE/16M2gWwvvjclMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8QyM3mO5NslxTMkcIAa++F4s3kzB9Ghf8krtzdYRIU=;
 b=gyvzR2HVNTPwY3TlZwyN4Ek8rDm5eudiasefV0tmUozHEf9GJgNEuBQ0tHFG9QjA06aMS6nPfHrF+jzX9QfyuTxeXgkyeAt/e4ErbCMaX3ttsOYwrwAIXc0ee3jFarwNbfr4LhKoFVqiGUkhiMstEIgCm/BDkb1GFEiz/FxuEkP+qr3G83GCMHWVpVPTKyVdlCNcOlon9edG0bfDM6tc/8QliOAIq+JbzrwU/mpkvByu2jBM/mk7KdnyEZvV+21k/2xaO+YZz6TNYK5tB4Od/0tMvUlMvOsQYYmiSQoMaSWijMxCHxWhq/1cfsmZhlyE97p+Gt+pG2BM2sBCdw6cpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS3PR01MB5656.jpnprd01.prod.outlook.com (2603:1096:604:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Fri, 27 Nov
 2020 10:34:09 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Fri, 27 Nov 2020
 10:34:09 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] arm64: dts: renesas: r8a774c0: Fix MSIOF1 DMA channels
Thread-Topic: [PATCH 4.19.y-cip] arm64: dts: renesas: r8a774c0: Fix MSIOF1 DMA
 channels
Thread-Index: AQHWxBdBIstQa4z9JUOZeglNLZ24kqnapplA
Date: Fri, 27 Nov 2020 10:34:08 +0000
Message-ID: 
 <OSBPR01MB50485C4015CA09B8AF42A156AAF80@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201126113711.5176-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201126171153.GA27329@duo.ucw.cz>
In-Reply-To: <20201126171153.GA27329@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8cea110-79db-46f7-9751-08d892bff953
x-ms-traffictypediagnostic: OS3PR01MB5656:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS3PR01MB56560165CD34C2B770662860AAF80@OS3PR01MB5656.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 /tl3Hn2ATyHUAoxqu55LDb4ZGzUH1oQBDEptjKUBafD8+RF7aFWkcBdl9BIlVo41q/My8EJYBfHsv4hlX4gRuhpnpDEsespxFMZbK/kp4bkueVCZ68/yYBs54C3iMoV4QIjudvg3WvaVzJhuXOcsxT8ZtR5l/aQlwd38RHWnpG2vr3PNvKMN4nuSszckpN+sx7RILQGnQq22wYzq+UUU2W8tCYUb5L8N/kKIeYA9eFZAXNUr7e+/3B5FsfN8/Ey5s1tQ8cVJO1uyiWnWaL0xMtNaEi6L8lCFpSbFtafpOHow2MY6wTDSX0hiF380554/OcnjAw/0D8/sRe3Ergo91A==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?SiwSasPG0x4giSJ/1dDqmIVZivmzu6ifGZeqvRX2VnP5ajKGLvTVYwOrdzOc?=
 =?us-ascii?Q?aQ+10x5AxNz1tlw8sCnsC/TxWsChk/M70if3Zew8yMl/CMnrDuJ6LFTRffqB?=
 =?us-ascii?Q?qcg+v3mafxtmvp4IIjwb2F2p3ECu5Qgf71I8PcV1xVMuzRrUUR/hPCurJUN8?=
 =?us-ascii?Q?qFiu8Gb6V+nWswAEi9hvieERLWczT0Zj335Kolv9v6MuOkhnYb5A9Um3XpTf?=
 =?us-ascii?Q?NrvHk8COl0bM9thn5wKxzfC/Qbf1s2pVirrnJ6ZCfu34YCAvMLVkkgn+n9++?=
 =?us-ascii?Q?NgAK30MbRhLZcurGbwQ8k0QRB+mQU5idp+hDIy/Z8nbfO+Tf71smfs8S7HrT?=
 =?us-ascii?Q?AmfKRm7OJYmUmQJ3mJin9wtixgx8zYKUURHPIlGvLdegBwvoWk4bMLFv+k8L?=
 =?us-ascii?Q?dS81doYfRGplChwEjymJ1sMDQyqwUPsG6oBVtb5FBIuO1kgCrRzrkRDV4Uz2?=
 =?us-ascii?Q?gV+CrXJK42idhtUUraUoXiPZ5qfae9mRe/VpEsroKZveeS4GURo9qRioVgSF?=
 =?us-ascii?Q?RJyy/0XiBwFQysqYKEiENCrr+Kd3kCO7255kK3ePTB8i+hfZ+8IWbjBcRlmn?=
 =?us-ascii?Q?dyF4k+6/1dgZ+X2JoDV2GhNnnJdRbsSpfanZcnlX92kNhP46Myx6pFJjsCs3?=
 =?us-ascii?Q?s5I+J7oBM6u0l9UuLK6WJ/M8PHtfm+1mvJ6gPPDmw64jK2U0kOW1TN33w4P3?=
 =?us-ascii?Q?i2azaNEt10YvBNx099jRb069CixFoqrv1eM3QXA6lnaSYp9alLjL6FrG5834?=
 =?us-ascii?Q?rVxR1Tp3nUvtWsrJFmksHKeFbqpchaPGFaXggbv/eB3VLVSMqAFVIVwe3T/I?=
 =?us-ascii?Q?+Ugi3T6ctbQ5RK0w3fqZYoeqhf4xKm8nV01EN2GTV/ZnFOdbtdfFVcWeEkam?=
 =?us-ascii?Q?/hw57KmtVyEgRU/MW7kaJCmiRWfNNssepvZcC6vQrA+sV3LLjccYUhsoNg2v?=
 =?us-ascii?Q?qZRB4kJZTqwv5qb4wOs91WlIUSJnujnCPtltXEzKPhU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cea110-79db-46f7-9751-08d892bff953
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 10:34:08.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUrTFRjAyN4lmrhdxGsDhz9SN97frHWnLwpf0vYbVHc0hfIHUP6OY0VGZN9P7TMi8YJTfLYOsnIB9VR8iwD8rdyUJ0bgzrr/RApeFz8IjNfVkEZ5hC29n8Xt9Ny0ionw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5656
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: u1Wv1hmIYs309ifsg2Q1NDcWx4520388AA=
Content-Type: multipart/mixed; boundary="OyLfZG9rdzAhrruQZIlz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606473255;
 bh=YJ40HDaNnpUou80tQM/gohbOVidd0ns3zbQDxf9VOEo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Iksg7koDDJEif75XQrxvVShOeBGTh5zoHVOI/qha2DHyTKikEeVjsu0SyTe2Hkhir8m
 GbIob8r5F9qwAajs5rwdh0IHVGsYtUF3I+Bmy8I0CdZKCEXk9EOqel64jhjwP/qmEta8E
 qWytVqaMyvYFBGsvYg6z89Sdd2L98efjqoI=

--OyLfZG9rdzAhrruQZIlz
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 26 November 2020 17:12
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip] arm64: dts: renesas: r8a774c0: Fix MSIOF1=
 DMA channels
>=20
> Hi!
>=20
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > commit c91dfc9818df5f43c10c727f1cecaebdb5e2fa92 upstream.
> >
> > According to Technical Update TN-RCT-S0352A/E, MSIOF1 DMA can only be
> > used with SYS-DMAC0 on R-Car E3.
>=20
> Looks good to me, I can apply it if there are no other comments.
>=20
> (I note you switched from dmac1 + dmac2 to dma_0_ only. I believe you
> double checked that's okay, but I wonder how it worked before the
> patch?)
>=20
Yes I have cross checked this information. Luckily MSIOF1 wasn't populated =
on the dev board.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OyLfZG9rdzAhrruQZIlz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5885): https://lists.cip-project.org/g/cip-dev/message=
/5885
Mute This Topic: https://lists.cip-project.org/mt/78527519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OyLfZG9rdzAhrruQZIlz--
