Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D4FD7066
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 10:09:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72451.1773742130516089659
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 03:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=MEy4d4e8;
 spf=pass (domain: renesas.com, ip: 52.101.229.23, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTiAGKpomJCejbvwJZ/KZ+J2VIesx6/8HZ0mc3oeKN/p3FvQ9u7IORnY0bkQ7UITknj/WoePFfoD42FZMftYcSrvIHv1Cb13pu/BnCJGXW93odJhpJnmpxdJYh+QeNQp6VFyI+/sza7tNi4WFnbfE4HNMLm2DWOv7t9+jDxvWqRUrhHPw2nSKQ9pzRZDuWbT2h5y9viJX8z1SqKlydxz4QQrbdcOflHS2yJGnJSVfTCcy5W8DX0wOH+LlynPCW9Q4cYsWbrGPgTpmIYGOq7oIKwo1802Isw6Vh7NMevwfU3tSzRooCgll7ago5fhXT4hVC/NThYDHLeh5sXybDSN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9E5aemRiKQgF8YOrovRPHtD+y1ahhDV3spVZQAHt9U=;
 b=d6K21STZJ5Stdh6oB1VUqAZpHEX5QAAr1WP70eo1igqEMkJ+nsDGmZS0qbkM48AcgN2qbzotEezkn5em4FU4F+bvdrRfPdA4XGwuS3L8AWJLuCzH2Niu7ZNI3sciJ7kJQUDNFE2+zVsagzc4zG6W1kRP3xBF5MjHC8HxbFTHEesT1sF5oKK2RK5aI/v+I2VKc6ZXC/I0XuTRrdTTsozxjESmqMWvC70AXCO0ZeBK3vcvaf+REsRss9kYv65n/aZKraG58frTzxkg/4MelfrQcBgt2T5CX0tgTQKpI3zHvqNZJWvuSs24Sm61I3wha5atda0tOA2Rj69BmzAHY+0VqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9E5aemRiKQgF8YOrovRPHtD+y1ahhDV3spVZQAHt9U=;
 b=MEy4d4e8H0Aov7KsLOoyfVV4P3adPo8dOigSTmhBsvorb7rVHZtvyHF73oWGB0pqhmkbGeaL/khgth1WeOSvdk+o01X3JYOQyyEMsS/DF/xB9p11Gl002Wzb/e05yNgUKD8qaAW1ZM0f+L5welBLPNoxnoMfn1iodcNb5F9+n3A=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by TYYPR01MB13225.jpnprd01.prod.outlook.com (2603:1096:405:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 10:08:46 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%3]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 10:08:35 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "pavel@nabladev.com"
	<pavel@nabladev.com>, "masami.ichikawa@cybertrust.co.jp"
	<masami.ichikawa@cybertrust.co.jp>, uli <uli@fpond.eu>
Subject: RE: [ANNOUNCE] Release v5.10.251-cip70
Thread-Topic: [ANNOUNCE] Release v5.10.251-cip70
Thread-Index: AdyysicQDBmKBhleQPmTXOq74MpVEgDQ0WAw
Date: Tue, 17 Mar 2026 10:08:35 +0000
Message-ID: 
 <OSZPR01MB81230F9D0E8455689D3C7A1FB741A@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: 
 <TY7PR01MB14818C5A866AAFB66A71EA103CD45A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818C5A866AAFB66A71EA103CD45A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|TYYPR01MB13225:EE_
x-ms-office365-filtering-correlation-id: a612bc89-1a7d-4a83-e552-08de840d2718
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003|7053199007;
x-microsoft-antispam-message-info: 
 sQTTnEFeN6azqjzDw/GyFl4oukVvugp+cgr59B+pIw8v9oluwtxx+6hC9UN4oeJ8azOyiBdGjHo/5+BJrqZmhsE0Ds3yeW4n2MxiEkburUxp3skZsgEhsaFXHolt9AbtdCcy3VS5UzUlmC+XjGlcC/eelOsetkAdyxZrLb6ByjVbN+4SNgdNVkIqbXLIs0alKOZN4AXWpgEfrpySE+thd/8nrYHCl5xq+GenYZLS4ojWe/52f1SUw7z94JBDGgts3hWpb6BHAgDczTGZMigdoT/qF/vF/Xx4fXBcq5nP3EoPindYTCph5IIJcJtaSI1f5Wmy6iDNtL+nKub0Kx3ilRaqKmCY1iq8/ARkJttXlTW9QeAz5SDmk1FhqDyRkTEw5cbDdVQ1v90HARZY0GnZ09wu3sHsdcNgfyGhXqxnMXO8TjZye3KfXUK2iOj9stmQAaepmh6DiGTtuGTqK+l3eftd+5CoVxhQ77/h8OvVMFl1Dcu3UWOlKT6c6r/ycGmzofdFDrRI/0VU/x0mdesjGVt6WG1RV2n29dnM6N51rSmigpRYrgiMViFifRd+mG5HhLO+91Ck2xi83ICAgXOPAxIYuw6Do2QM24CoOlUe2DRS3GfRQr+DbTDg5U4xGwnNnZjtHGwXfhV4xm/W/8PpRptIweSt4wF+mrbZxjZiZLR2sJnYiYxy+NqEsuulUFPImIfhZzVtz4ED4kJIPqkV5/g/Tgadbj/XXzTdO4q2rYg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M2pPYjNyaTFVeTlXZ1FrTGE1NURwZGloQTVRZHovTmJ4SElwZkpuZVRX?=
 =?iso-2022-jp?B?VDc2NVVBVjl6RWptV1hkQXkwWXBGbi9vQjA2alZVOEVYcEw1VGtwR01w?=
 =?iso-2022-jp?B?RXRoc3poaVhway9iNkRBRFVBbTJhSWF5cXBtc2Mxa1g0enMwbnFZYVN5?=
 =?iso-2022-jp?B?NCttUEJ1TnBPSGRxczFQUmxXOHFIZzRqcWpHMnE2Q2ZOaWpkMU9BaGxo?=
 =?iso-2022-jp?B?YkxiNVlLSU43cEFDaEY1Vzl1M24wQ2hnVzNkc3VGSlVQaTd1L0lGalFj?=
 =?iso-2022-jp?B?UldoN3BCd1dwc0hvNGUvSHhLRk9FMHF5SkZpVWhlenZqd096ZFNFcjMr?=
 =?iso-2022-jp?B?OVFDME55TlF6K3NvSndKQXJndjZrdnV5Uk1QUHFXaDBFQlRvMXlvT2RV?=
 =?iso-2022-jp?B?MjVDRXl3NGJ5WDVKQnNITEU2a0p0UHV2Ly9CUlArWkRBTFo3Q0NYb0Nx?=
 =?iso-2022-jp?B?b3Z6Z3VoZFg3YUdZZGhTMnB5ZmYxdk9TUWhsRVNyN0orMytnT2toenk2?=
 =?iso-2022-jp?B?N0hhSVh6eE1NVTMrVGZVUkRMaVZrb0I0S1g1UW1nbmlqMng1R0dxRjND?=
 =?iso-2022-jp?B?aGdJc2tNY1FGNlpjUmxtUkNjOEUzUkJpM2pwUHJ2TkUyOWlBTmFFa1U5?=
 =?iso-2022-jp?B?RHJwK2VaYWlvVDVzU1lnclJDMEdicmEyWUo4QW8rU09PREFmczNkQlRY?=
 =?iso-2022-jp?B?WHUvQ3NWV3lJaHJpQW5OWisvcTFiZUNUcEppQXd2UjVhY1JMZzgyNEZh?=
 =?iso-2022-jp?B?M0FiTGZHb3hUNHR2cjF6N1RZT2FkQUxzOGwydkpUcWtIZlhFRDJ3QTFZ?=
 =?iso-2022-jp?B?QmNrR1JoNk9EQ1ZONVdMV1ZrekY3Q1JPZm4rUTQxdGQ3bnFWSUJUVEQr?=
 =?iso-2022-jp?B?YXdvNDJabmhWMHVlZ0wzSjhMUVdoTjlHOFhGLzZzL0lxMUs4OVcvYUFz?=
 =?iso-2022-jp?B?SmVhYyt2ak41MjI4aTNraXhERG0vUGpyTDk2dnM4dDhnOEtCeDBFYXY3?=
 =?iso-2022-jp?B?VzQyVTEyY3o4N0V5SENLbWhGZmxGMldqdlczYXF1bkNnV1ZBNFRTVGoz?=
 =?iso-2022-jp?B?U3ZEY3F1amdMMTFtR2NpWjRGaDJwYkFzQktPTGN3akxTSGxDdGdWWmlM?=
 =?iso-2022-jp?B?bDkvTGdrWWtEdlQrc1ZhOForcW9WR1VTUmowZVZIR01RYkZINUpjK0xD?=
 =?iso-2022-jp?B?S1pBL1J3VVgvbUJWbUc1c2p6WGpadHl1Qi9waVBzd0xoZzNTeFhQaWdy?=
 =?iso-2022-jp?B?T3RoZmEyb1d6ODdLOGRSMDhOdDhhQXB0OVVOaG1DRHM5MzJlc3RlYk03?=
 =?iso-2022-jp?B?emFjWmdiY0poRWU3ZUdTMERFTGdXMXVwWHNiY2haSnlHMWJYYkdMZGZh?=
 =?iso-2022-jp?B?L2tGdjhJd1V2eGdYa2VWaXg0YzFHSyt1SE91eFU1UG05eEFrOWJVM3Vw?=
 =?iso-2022-jp?B?QzlIQVJjRHd1aW9rWUlCVzJnTjFraWlSNGhyUEk5U3QxM3hXM1Q5bzQw?=
 =?iso-2022-jp?B?VGIrdjlyam85TjV0WW1idTBhanVlQmhtWVBTSFVVNk5RTW85SlUrekRt?=
 =?iso-2022-jp?B?V3ZDVk5TbmxvYUZuR0hhUHlmT1VuN2dKMzlzWnBiSWpWYXpIaWlSeDUr?=
 =?iso-2022-jp?B?bG10bFBBWjZvWFB6THhuNnBjRlByZU9qOVlDK3J0bVBYNW5BUGNlS2hI?=
 =?iso-2022-jp?B?UndzVWsvZTg5TDRLdnRCWUVpMEY1a2RLUWhFZHJLeGRUWnB1bTl1NTNG?=
 =?iso-2022-jp?B?NGlxWXMyaTNvWFBiTjlJaDI3TkhzV1RHQkpBUFdoTzhHSEw4b0lwNjlQ?=
 =?iso-2022-jp?B?TSszMjBiZkFSbW1Vc0ExQUxRaU5jcXh3bXI1eFYwcXNEOU96VlMxRGRp?=
 =?iso-2022-jp?B?YlVJZjE5RFExMHcrMVA4dzVVbVJkRTVyc2VhbUlqZEhOWDFQWCtTeU03?=
 =?iso-2022-jp?B?UDVMU0R4R05UV0loY1l3SlphVDN4aVlnYkVBSXI3TGp2aitETHN4OW8v?=
 =?iso-2022-jp?B?aFdsTXlPZ0lEelZ2LzNqcHFkWXl3S21hK1lzQlF6bHFkZXJOS0g4SWM2?=
 =?iso-2022-jp?B?UlhneXlHeXVxRVI0ZlBCYlNjdzJwejdXbFl6T1NiNjY0K295US8vY1Nr?=
 =?iso-2022-jp?B?Nzk2V1VXY3owSTZ5bnZVN1E1K2dPdXhSTnNJaisrUTRrMSszU3FaWmNH?=
 =?iso-2022-jp?B?Uk8zdkEwV2lsR3BpQVR2K0o3V3VhSC9Qay93NHJPbCsreTZicVdKMXJL?=
 =?iso-2022-jp?B?YnJJdFl5Zy9tRGc5aDBJdURXVGltSytzMGZxK0RkbExvZVVmSEN3S2No?=
 =?iso-2022-jp?B?SGhjSFBoNnJMTHdOUEtrTWFlazg1Vit0M2RvZWcwblBhOHJvdDd2RWU3?=
 =?iso-2022-jp?B?S2w0UElaaDJZYlhTOW1QcGlCNURVTi9TWnQ3V0dkNytjVWNqbUJBMHM5?=
 =?iso-2022-jp?B?ZTlZdTkwRWxOZ21MUit1VHBMcnZPcTJLTGVmR1pSTmJoT3lJNkxpakU1?=
 =?iso-2022-jp?B?eGdKbUpVaXhmSmROY2QzN21ISllBM1IwWlRmdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a612bc89-1a7d-4a83-e552-08de840d2718
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 10:08:35.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJDZWt5Vurc/2qqVa+Hh86RfcSQUKDd+Nz3QHIH1Zj4Kl4r+Y3Y/+qq4ITaANOsuxeN4iCS6jKuLxqYIrRhUbLFMomNWFMtZqiaJWaSlee4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13225
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 10:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22432

Hello Iwamatsu-san,

> From: nobuhiro.iwamatsu.x90@mail.toshiba
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Sent: 13 March 2026 06:51
>=20
> Hi all,
>=20
> CIP kernel team has released Linux kernel v5.10.251-cip70.
> The linux-5.10.y-cip tree has been updated base version from v5.10.249 to
> v5.10.251.

Our KernelCI pipeline has reported a build issue for this release:
https://dashboard.kernelci.org/tree/cip/linux-5.10.y-cip/99e8b9912822c35e38=
8d236d0aadca61195f75e6

Specifically, the riscv cip_merged_defconfig build has " error: =1B$B!F=1B(=
Bphys_ram_base=1B$B!G=1B(B undeclared (first use in this function) "
https://dashboard.kernelci.org/build/maestro%3A69b3acb5e8c48c93579bdc61
https://dashboard.kernelci.org/issue/maestro%3A51c12e2d53ea10cd0ae264568f82=
d96b2dbc0245?iv=3D1

Kind regards, Chris


> This release includes updates to the ASoC for Renesas ARM SoCs.
>=20
> Information about this release is as follows:
>=20
>   v5.10.251-cip70:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-5.10.y-cip
>     commit hash:
>       99e8b9912822c35e388d236d0aadca61195f75e6
>     fixed CVEs:
>       CVE-2025-38201: netfilter: nft_set_pipapo: clamp maximum map bucket
> size to INT_MAX
>       CVE-2025-71235: scsi: qla2xxx: Delay module unload while fabric sca=
n
> in progress
>       CVE-2026-23222: crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY
> scatterlists correctly
>       CVE-2025-71232: scsi: qla2xxx: Free sp in error path to fix system
> crash
>       CVE-2022-50516: fs: dlm: fix invalid derefence of sb_lvbptr
>       CVE-2025-71237: nilfs2: Fix potential block overflow that cause
> system hang
>       CVE-2025-71236: scsi: qla2xxx: Validate sp before freeing associate=
d
> memory
>       CVE-2026-23229: crypto: virtio - Add spinlock protection with
> virtqueue notification
>     added commits:
>       CIP: Bump version suffix to -cip70 after merge from stable
>       ASoC: renesas: rz-ssi: Add support for 32 bits sample width
>       ASoC: renesas: rz-ssi: Add support for 24 bits sample width
>       ASoC: renesas: rz-ssi: Move DMA configuration
>       ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entr=
y
>       ASoC: renesas: rz-ssi: Use dev variable in probe()
>       ASoC: renesas: rz-ssi: Fix
> rz_ssi_priv::hw_params_cache::sample_width
>       ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
>       dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
>       iopoll: Do not use timekeeping in read_poll_timeout_atomic()
>       i2c: riic: Move suspend handling to NOIRQ phase
>=20
> Best regards,
>   Nobuhiro


