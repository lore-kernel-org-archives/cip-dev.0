Return-Path: <SRS0=v8mm=GJ=lists.cip-project.org=bounce+64572+6046+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE3C433DB
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:10:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9A522EBD
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9A522EBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6046+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HCgFYY4521723xeaORB4F5bR; Wed, 06 Jan 2021 09:10:16 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.128])
 by mx.groups.io with SMTP id smtpd.web11.11208.1609953014823082810
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 09:10:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIzTTqp3G/DOsWZNY21oWhAhUKYuHK0kfhp4JaPRKjDtGyAf5SgMGykZMNdXxvXMxb8v5JJIOiXYebQ2PBwlT8nQK3ro399D6qoJNRfDdZnLaPDJilEVIRUNuQ28sy5MHUHRSrmlgxHikv/M1Bj/7k5P4RfxfpjwU/VYLcj2dKuB0U+msujpu4kVhsOWtSvGiBQBsR/us6vXEytHZVYSN+PSfvbQnH87yqficiw4sdVZNKoD1CSSLMTSjOGHuPeMOzxTFcEbfAxJhOWnJCLL+OBZXVrD8+jk92FTwvE9KFOnBbN2jHsqCjWlCdqaCkStAtxgGeNGbsVv0fpI1nP/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1ZKD+fv9PGJ5YVxjrEp+Ln1EA/o+pe7vQnrTXwhb2E=;
 b=Do9rdpf1u1qtRNUSmeFwI3v1wepPJOWcaZ2qnAQvXM9Q7KhMgWlg6YE7UWdKwp+YbWQiSwAuShI0hXzJBHP+R7MSzrwd44ytDzbYYGAh3g7U3THygZ61JHuyMGE59kFVWxcufvG8UB6rxPrFc42ccCp4VHaGBLv32KqXs41eqNtAPHUhCPwTvrDQw+BrFOIE+nifcpLTDktjFHcV4bc6hBGwtXiILExeW+Xv20ChaIs0AyU7P3CUdY7Dik/46dgpY7kLsjNpl5P3FAv2sWLPrxDfImrW8ayFIZlabL/MSofhqyIxN0NKba7ZBcTHIyrg+5gZmspogmsxMkPkfFYjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB4977.jpnprd01.prod.outlook.com (2603:1096:604:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 6 Jan
 2021 17:10:11 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 17:10:11 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] spi: spi-mem: Make spi_mem_default_supports_op() static inline
Thread-Topic: [PATCH 4.19.y-cip] spi: spi-mem: Make
 spi_mem_default_supports_op() static inline
Thread-Index: AQHW5E6LZB9Nnm8LHEK2tWMwdRA0lKoa1Lyw
Date: Wed, 6 Jan 2021 17:10:11 +0000
Message-ID: 
 <OSBPR01MB5048A740682574B32F85FCB2AAD00@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20210106132221.17458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210106170816.GA16394@duo.ucw.cz>
In-Reply-To: <20210106170816.GA16394@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7955b552-08fd-4f85-103a-08d8b265ed47
x-ms-traffictypediagnostic: OSAPR01MB4977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB4977B008C5EEF87965ACDEEEAAD00@OSAPR01MB4977.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 mSwAOIFTPZA56pqWr98KhlU2G5s7zz84bUKG0OuCgU1SdXcjQTIh6LwLDhfmc1xHJT4nZ/lbNX4xYaRBoj2uW/NsBFAR2JAIa1TrhQH2x3CcEZza6PVuKLSOP2vLRhEs7DuHtjoz6YfUMsqSk4RvqLbnik9iUze1LqSMKdJvpmXadoBAM2HkjMrLv0Ey6UPVxP/Ic6McMQui8/xBX9/t0/0rrdLXy2VgkX8LC5Xgtvrbl7xtp5j3a2TQV+XXSo4HnJJRBszuJ6no/seaiEJUg0HkX+N8MyXvSJjNC5kNL4ZgN0NicEpR91rh9sfRqrXc2v1BpxHXZSRW5+L2Nhk8D+Y8POLzvRTrFa3O9Sb/+tciS7b+nFLWbeSbuJJCoLjP5Q6Js2BgcSWPQOPbNXgl1g==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?iCaQoEndMcqyjTvA+A0vztOG0B8g0KcD8lTbbmC6GbpS6AGlniLKW+HsQy1L?=
 =?us-ascii?Q?9eQ/xSURg1r0+h+qsV/s4tefyt82hcZyuE7H0v2g43Lnjx/xV8yzosOsNUnF?=
 =?us-ascii?Q?eYoM/Kr+Q2EzAo6i9zLG6cOYIaPGXrzVD7j4Fpf19uwYAaVswuXSlXM11ZNT?=
 =?us-ascii?Q?0nXssjS48Fh7gBGO6AeJj3kbDpoWNEsu127xTjONkcT6+FkxStpu+LfyNJHa?=
 =?us-ascii?Q?FVbaXV5TrQc01GHIvPABEPyySiI64nlBA8wUWgiOgGdFEf5Tlyu061wXooG0?=
 =?us-ascii?Q?VXzHqhZDy7nVnoQSIet2u+lLA/MRfbSAu3qzqhgecfZJlaNXrPfqnjBbMXds?=
 =?us-ascii?Q?7LTT21cxw0R3OXCE78m2HHynjqhQOePireUW7yZ9zr1QIrWHurjC15BX/4U+?=
 =?us-ascii?Q?820DtWR2zxDDF75q3X7C6AFRx6j223gXJjJGyrMQOFXoDTdRlzbJLhH/3cWw?=
 =?us-ascii?Q?f23We+JKzMkV+ZBBOVceAzBZlI8XhtVh4XektX3EpDYeUC3jpRnRF2EAjPpi?=
 =?us-ascii?Q?aTWXKBVX8FW1MegjBJXXgwGcPW0kNgUQrZdg0O5PHHsc5BDxxTg8efcrzNYU?=
 =?us-ascii?Q?rFAy3wPl2bxn8kr/r9L/wK8DNpC1ISScmsjJlrOiEX6dKUGov/f2O2UyNX2S?=
 =?us-ascii?Q?buZt99SP70walliLbYlPQKTxCuh8XRllYXUU+lDBbAZmnOskqMbrvK5NgxPl?=
 =?us-ascii?Q?obO+Rrq1ifL2DSVkI6L0liCLT1yUKW4HVseC2PoG76v/MytXhNKySKvfaF+C?=
 =?us-ascii?Q?LjaF2maqcYT4tNkF9Cu8cqBgrzbykQZdTaz0aG3f+kbh48H+nb2dTDSGT5gP?=
 =?us-ascii?Q?AMlv/XRV7Bp+FE59aiCjgaGOrdHT74Q5pLMtuvS02vLcSInqJPc9/isxYbZH?=
 =?us-ascii?Q?NJ5Ok0INq/7zFrMD6vFn6cI7Eihi7MG9KQpnbGSU0GVJ598dZzJyZeUHdK/9?=
 =?us-ascii?Q?SK14FS3nE+rwWnL/Im/CpElJkWiY+OOwtmIWKdMN4hc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7955b552-08fd-4f85-103a-08d8b265ed47
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 17:10:11.3624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHRRsr262TZVimyo1vDCxsCz1G8CUL2v8ua1Tl4KxlDnVEUitujglbV7mac9gEYwR1+KwRDByHeIJuHFlT8cA37kF3v1fsmmZOgQlYgeZMPqInqjSZDkM6/zWMCVcMDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4977
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0vyOR1HHyTDuMrwCD35h5xwDx4520388AA=
Content-Type: multipart/mixed; boundary="HQfMM1zYCr8t0IH2GSqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609953016;
 bh=IAnliB9za8e7ofRGbPExg2Y7Gvo0kDyp/Z7DbvHN2y4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=SxWFpyhZDeleMkmHtXVbCLGKOeIBegIKZ8M0oKDdb8QEMkC/CR4SsgsTsW30W7ktg4D
 sV7IwP6BvflglmNFNUiBPKkF+ujUiDuRS055nfA+/GUCmJIOJee/3smtD9NqOUeWLBGXx
 A2IS0lfNnDeUZECi2uFTRmSkDn2hkXcBlr4=

--HQfMM1zYCr8t0IH2GSqf
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 06 January 2021 17:08
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip] spi: spi-mem: Make spi_mem_default_suppor=
ts_op() static inline
>=20
> Hi!
>=20
> > This is a incremental patch on top of series [1], as you pointed out in
> > patch [2] the function should be static, this patch fixes this issue
> > and is backported from upstream kernel.
>=20
> Thank you! I pushed applied and pushed the three series leading to
> this ("Add Renesas RPC-IF driver", "Add missing rpc-if clock on
> RZ/G2{E,M,N} SoC'", "Optimize pinctrl and add QSPI[01] pins for
> RZ/G2{H,M,N,E}".)
>=20
> This looks okay to me, so I'll test it and push it in few minutes.
>=20
Thank you.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HQfMM1zYCr8t0IH2GSqf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6046): https://lists.cip-project.org/g/cip-dev/message=
/6046
Mute This Topic: https://lists.cip-project.org/mt/79474032/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HQfMM1zYCr8t0IH2GSqf--
