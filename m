Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49421C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 10:26:58 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.100])
 by mx.groups.io with SMTP id smtpd.web11.17641.1640168815717848846
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 02:26:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=EOpHl6g1;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.100,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUO21BpCGHyHXHVGOeS4OGOgfkSusHKeCF93BoVACO2NxFoPdPtLnoJXd8DAHGOnDbJDjIRlmQyDCSPEobcXUfksfyTSQywvfWqBcSpUs1SbBfAi59viDNVFzY61B7k0QHei/3nautCWKlrwmJJpuWjCtigMVLNkzZSdPTvqDTvGZIJ9h3UBf7rblsm6amTzk23pyNeeCy0mA7RbnNOULOAsl+uePQVkBNRc3oWdZBDckcWXSJ30p3JygNvuKT7NzuNrZFijFrseIMk3gg9PZit8fbucdzEMZxz8iOcjjHzNecwFfdiWSqpmFVto3D1L8A/B1pMufyI41tNun9zQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No6xxdbsqavvBGUKpNzAAiM+vjlK3xYPBsZ1GLhelVg=;
 b=jlMbdD+DpK20oQ0HPK/ssyaMzZSfUsj3QQ6Gq61c14F1IVzBFeYI2dTafZFFTeIZj9tZHgjJk5Pu/2/dSUO9Xuw59kGKB1qcERUCAP4h1/NEzv8ELifXJIlf0UXT8aKFuR1Pd6XUV+vgU8y+13IcAjtLssLto8s+c69qwUrP90UVoe7jLEo7wi18BkmrEM7xnQwjZEexTNR3xwuURedU4E/fozAiE9JcxR4j8liL1oy6M4j0kWghm3llX8q0ctxZiVyz3qkzlaHY0PEexJ+RowGHetM8I9Ly/GRfAb4PXXpXYMNsH1ShfhE50srHEoPWLsMTyIS/oo+Cr//UhvL94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No6xxdbsqavvBGUKpNzAAiM+vjlK3xYPBsZ1GLhelVg=;
 b=EOpHl6g1FRuMC2lp7Ncci4W1t2jWYy6oo/IonlSczxrCgoPB7NcyxSyXBrxUrhAFdnfgMiVqms+aw6x373kl3B69ayJigciAzahqsbIfjiqiIICNgytdCKEaTrc3gia4GVgCdoJAl+66wKrArvXgJKwekl/bvuaFf97fBOKPFak=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSBPR01MB2294.jpnprd01.prod.outlook.com (2603:1096:603:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.18; Wed, 22 Dec
 2021 10:26:51 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 10:26:51 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut static
Thread-Topic: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut static
Thread-Index: AQHX9xtgFU7AfH0TZ0Gm72DsV9F7IKw+TiwA
Date: Wed, 22 Dec 2021 10:26:51 +0000
Message-ID: 
 <OSZPR01MB7019BD70B5EFFBF39C4AD183AA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133139.21624-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222100453.GD15186@amd>
In-Reply-To: <20211222100453.GD15186@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88cb73a3-8193-4271-53f7-08d9c53591a7
x-ms-traffictypediagnostic: OSBPR01MB2294:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB2294D4762F6A163F2DBF87B4AA7D9@OSBPR01MB2294.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mRhPcYFWxc6/tqScUtDMIQW5QzBnsBEd7Of/2StiMrY3TRaC8EQYBYF/rWY+GTXWSGeF8BPiYHaV85bVi7mnAfz+tPeV6V2ske7NG7Gz2KYGTKCPcGwmi7LV5MzOP/mbrOCjO1Wj4wXHpJDGXZ1NEFcL1Vax1DW/W7TIeVXOtfHA6GlypapgZIMU+Kw6L1cFbHsSpOgs7zXGeWSzsB0YCobXlTl3oKpKYidmvT7w1NmfeQA0fy5EpIhu8+0J4GWQUs5SSsTAf8UuwyQMEqRJbiNwqW3C8G83DymEb7UcYDeo7MfvaUgh9PqP3C6sPDiAm9dtMQ/I5x2MZ38Xg9F9TIrBDZ2W3ocA/bHwRFXqWuUsY1kmVSgeHdIrEdh5G8/SaaV0IMn7vV+3LDmS6wtqbVqkobU3K82j4Jn8BIKSpEnFKbvbihvos4aVZbvbFZFuOSsknDNcqKr6wsNxPzOROETbv2FdEfRuIsAWPUv2bzJ3dWdoQOFNbV2pEim/SxPbEsGpcWOnsB4bWIC4zRt3rz46JcleDVBaGgqyq4FVKMobC7CI5Uou4Dfgc9SzI8nojJJrb9qoKv1cRS0tlvIqNjVtNqkleA09alTCbAxZZmg1FDowmsquuMoVnGgJs01cTqu1I3e2rBriIE/JlfIwZjKTrIoA4iZmzdWiSyhqZTDRToWdxoS3PhAaUM1r6J5p3NGvNpPQg2p9fqiuMTgX9A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66476007)(508600001)(110136005)(5660300002)(86362001)(66946007)(76116006)(66556008)(55016003)(66446008)(9686003)(7696005)(71200400001)(8676002)(8936002)(54906003)(316002)(6636002)(6506007)(53546011)(186003)(26005)(83380400001)(38070700005)(52536014)(2906002)(4326008)(33656002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?blU/tIdC5fD9ZhQirkmMPbLwMxZcqlsRN9tSrUImXyU/j7WeDFbx30Yj26PN?=
 =?us-ascii?Q?Zl2u+HijT14e3yh7zEoWKusKYmB7LTGaiblGUXMfJ1th+UQTHcAUBu7XcG7k?=
 =?us-ascii?Q?lAcBiarT5bFBZ7U7pJhhudTJM0E+Ejgg5sDAEKICNA1p2kYOp3dePCu64ZRp?=
 =?us-ascii?Q?ey7+HXeYvdz1E831VeOco8u2ppVPj6YrjuJH+0E5C8TnhNGZi9GB/8EHCIgL?=
 =?us-ascii?Q?nP6kYxTRFzZiul11pX2VPMroVy+tzZjoNnZYEmIMykVhI3wnBeDilipt0v0o?=
 =?us-ascii?Q?VL+yNjXzhUGcA6q88AEgRuhMaY7qUhN8Bys51L8HUsJbeVGuToJKvkcFOGSP?=
 =?us-ascii?Q?VXXJ7aPprI78G9ndA38oG+HFRuMLhDDM4rC6J9Eiaa0Z4UCJzkO3/yOM7k3D?=
 =?us-ascii?Q?7GaHShvTtTx096+wHjzo2qe7zzWFgPKv4TDhpRImUUnbxUHMnS+IypdV6gvY?=
 =?us-ascii?Q?bb8Ubipf3B9oaduDO3jQ2TGzhXzU6ZDsnhMQuW9PSIYeeyGZgY/Uqv8o7vgS?=
 =?us-ascii?Q?r85hJ/nIKLEEe7Xr/ZiA2I5opeoznIZ0RPr6XST1UmieJUmfNG2tv1X7SlSh?=
 =?us-ascii?Q?JZOOuaxvUmAGIotGbwWC4hK5W40ytPlVJsz6saEZQx/onsEc3WUo47sdFKPE?=
 =?us-ascii?Q?LlDsVyqOWWc/X5oiKXTs+dNcM50MfpOvkbFdWgnKrqSCGjLBbpVlPwPa9YH6?=
 =?us-ascii?Q?jivtTZ4dtdMQSB4tQ9u5avVSSr0JmgEvBH1Nep/jE2wJGjnYf/AuU+02EeSn?=
 =?us-ascii?Q?ja3usKcbOXiK8PVZNxe+QnQ6YaWZpJYCiOuc1zn3DrCFdAygMZgqGEK8icRX?=
 =?us-ascii?Q?loA5G78qmLTu/FWRayv8ddUzLWW/GRCPEtopsFB/A5q6h3HXEvJdU46jX/s1?=
 =?us-ascii?Q?4uqBFQehSrS7EYpTV6VOA6nfwGEWcQmaE6xf7DoMKcUWJtIEO2zEmI2Jqioj?=
 =?us-ascii?Q?5H3lS3RIY2WFX8kJ9US7h61FNBbkbMlLkP6k/6BwrqLcuno7XbeJVcRQKRDX?=
 =?us-ascii?Q?ygkEm/40b01l4jxs05W5W9u5xjFf3KK9U/woh59ajnWmrtOmXP9kJ3QjnqmN?=
 =?us-ascii?Q?ZWcbtv77rcBBAUZzULLyU9Tb6Xxn0Ge8/thG/TGn17u8aLwv2ZfWqIwxtVgG?=
 =?us-ascii?Q?yQXBTHqrg8zhONVqR6XsAKDm6KOGju43D2zBDtf4b7stpJwlsYeo7YzHZwm0?=
 =?us-ascii?Q?z1rGD/rZgVqyJVF+geR3UdyiwD6AihPt2LKuymc5ylyuspUAECFnC4duiArA?=
 =?us-ascii?Q?Xr1OuOXTuAXgL95Vk4M4LU4Cu8Xq8evVACaTeCW2TWmiJGtcMHZTgay1/m/j?=
 =?us-ascii?Q?Z/BJrH1iFh1l8AWBWyaA0QiXHqBFebZ0rY3+PtoWX1eZNlvPTOWyH+rPkeqt?=
 =?us-ascii?Q?0555Pl0uR9c+y6wZT9FD8bC1Cmj+Slrqw4WO1xOXpSDC9RKm9HIKMbFMrbTe?=
 =?us-ascii?Q?iOvGM4g8u+se9tRwo5m3He+kG4TRzpymqT+bmuNQrl/vV+aMe+4pleducuOW?=
 =?us-ascii?Q?QRy0kUZ6e0OXQZICx5CubW1T4syYo7D6gHDHQlPh47+MKg2PL4pFDx5W0HlR?=
 =?us-ascii?Q?iD28N+Ggo9uupuR88lAQ3wEUfMjw0/UvOvzSCwI2bIJ0511NjrP95RbreX4I?=
 =?us-ascii?Q?kQnEr8Rsy56E1ziyQtBzWT+6nB41RoFkSfwAN4oXIioyJPY9qjOZY1eAL5qy?=
 =?us-ascii?Q?5H6carCDIMVp0Nhpf2WW+zhpGMaWLt2kLtjq89tffRzYp7WVXdNic9Ph4R3h?=
 =?us-ascii?Q?/Eb+OhSCPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 88cb73a3-8193-4271-53f7-08d9c53591a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 10:26:51.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ws8Ll+7oDq4B2cm79NRgC4N0oABrS/UCx0jPFltrpfI3/htgQbaGpgrmtG4xDk4rX2NdodHn55BpfhpFxwyS5NRrdGKsj8GUHLTSvc9rbmRvmR7SFjndHAzrq7uTlwUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 10:26:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7231

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 22 December 2021 10:05
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut st=
atic
>=20
> Hi!
>=20
> > commit 4c0eee50658746b0333d35a75d3db6e0aac08ef9 upstream.
> >
> > Don't populate the read-only array ds_lut on the stack but instead it
> > static. Also makes the object code smaller by 163 bytes:
> >
> > Before:
> >    text    data     bss     dec     hex filename
> >   23508    4796       0   28304    6e90 ./drivers/dma/sh/rz-dmac.o
> >
> > After:
> >    text    data     bss     dec     hex filename
> >   23281    4860       0   28141    6ded ./drivers/dma/sh/rz-dmac.o
>=20
> Heh.
>=20
> > @@ -574,7 +574,7 @@ static void rz_dmac_issue_pending(struct dma_chan
> > *chan)  static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth
> > ds)  {
> >  	u8 i;
> > -	const enum dma_slave_buswidth ds_lut[] =3D {
> > +	static const enum dma_slave_buswidth ds_lut[] =3D {
> >  		DMA_SLAVE_BUSWIDTH_1_BYTE,
> >  		DMA_SLAVE_BUSWIDTH_2_BYTES,
> >  		DMA_SLAVE_BUSWIDTH_4_BYTES,
>=20
> Array could be avoided altogether; you could check for power of two and t=
hen count bits. That would
> give even shorter code, but I'm not sure about readability.
>=20
We might loose readability, Ill let Biju decide on this.

> I'd also not mind using usual convention here: return int, >=3D 0 success=
, < 0 errno.
>=20
Agreed.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

