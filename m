Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E54C83F1D
	for <webhook@archiver.kernel.org>; Sun, 13 Jul 2025 18:57:35 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.60])
 by mx.groups.io with SMTP id smtpd.web10.62346.1752433048535693614
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Jul 2025 11:57:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=r8LuRBbw;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.60, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6VDR7hsDACshQT/Pcs96Py4tfPFgdASk19IkX+bsnliNk2SrB8vUSdrfM1vu1UzyIwmQLsnkZd5wt2WuDNdfnXvJchqnrYABHTAkU1e4I88GG4HgzEyf1mVPLT4J04FUYTOHxlhzC1tUxemnSzCNIu99GD3UTjkpA1f7Xao0rQac9jJoAWK4tKhq5nYMPEpMYQczMwnqL2La02D24jT+RZjsUEJDZicQ4UJYwypXWH57+m0w/hD0lTsWo9RIiEVbgLVqbmoLVpon18qD36/Gi4Ec4Iv82h1ndLYLdfe8XTLc2pRzkU+dKBW/hLoHpzb0A46zigHpDvkqSW+olS6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrqE/H5c4cM7iL5NwOdx2tW+LbTcFjmZ3cSfF8o2BiM=;
 b=RzJxY3/p4sCBn9S/UKNWcccKzR/litCmPwwFJrQkw0qimAUPT3QsnjrPfgAIspL2CUBBD+JXkHEpQINVS+KUgpx51xCIsomG6M24RJEj19XPwPkPRWW6k/YSCDB74kk5F3K+R3X9ZF4R1SuBwotNXYtxQk/NvQPSOG6UK8GavyBpw44NPCc3oLWZrnZuPfnVU8Lh3peHCy/fSnizygCJOiey2xJF3xUPMGmh8VEyqewlh+X0+7UPQzWjSz6mU9GnPFnalfaAGVscI9EDGesTPmsz8r4qw7Uax/tloPexRdj7Cmcjs/zTsFDQGhS4NYr8y6/1U/eichP2vBqu3WXe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrqE/H5c4cM7iL5NwOdx2tW+LbTcFjmZ3cSfF8o2BiM=;
 b=r8LuRBbwyGjE+I5EZPIVyjQBLWpliXx/1dXBUC5zidfiIVnLgKB/cNDEbi4wezl0uhSyfurPB77hQLE0MHuc3lvDRUKfxdZt4VZOPt/dUX7thgdmk5hZ2inbjoHLenjUWVFrDnHWBQNcaxRF3lRfZpU4D6wmQarrNVaZK0jonqw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12936.jpnprd01.prod.outlook.com (2603:1096:405:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Sun, 13 Jul
 2025 18:57:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8922.028; Sun, 13 Jul 2025
 18:57:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Thread-Index: AQHb8nxiU9sF3maKdkq21LXgCcTUiLQv1HsAgACUrEA=
Date: Sun, 13 Jul 2025 18:57:17 +0000
Message-ID: 
 <TY3PR01MB11346B27385EF1C42125F09AC8655A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
 <aHODWBPDTudaoNV/@duo.ucw.cz>
In-Reply-To: <aHODWBPDTudaoNV/@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12936:EE_
x-ms-office365-filtering-correlation-id: 8d384b7a-a0ea-48b8-9f7a-08ddc23f16a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?CsZJiaDz5c7ynrcKCPw19J45zJ/BwgDurL16uUHBhjrMaMso/7WbvyBedwrW?=
 =?us-ascii?Q?FVV1sazfdo+8wVb+SNCE6RKjWVoyGu7XTgJ/1ZKffC8erVrAweizgczlenrU?=
 =?us-ascii?Q?cZ5eLvtvYUilzuBgwVcf9nxzOYtlyEaTiSYU48LwZnjhtu84GUXYdQsgJMPy?=
 =?us-ascii?Q?Ti0Ach4Thiv8p11R6sHzR/ECvGVgyMVT7M5imtyUqo4R3RlNT5aCQt/rk8Zi?=
 =?us-ascii?Q?ozyGmpK9spo5zqYSPI7Nae232Yy6haAfspZjq6aH2Kqo+0/OdhQrBCEvm3tZ?=
 =?us-ascii?Q?S8jPFPjYKZ4gMfV2Ek+YLWY+VzVK7/hjBp1AbxwJzsVR2bdtg2nEGJp04yJW?=
 =?us-ascii?Q?dYL4BXRpDjXO/461SdpnE3Fdejim3qGNu/iUDwdE/n7WEkNAWgfFd2ot1eIL?=
 =?us-ascii?Q?Q4rE0n5eC0F20FIyeSTVf5bPJVN4ZgcyBfLQpKZyj2bhyMRYt0v5lPr2ZLdQ?=
 =?us-ascii?Q?0w/j4nph5XFo7xYYj0DfysHPbvnhDGefQfFbQD5FLjSJeMuVm9BaJTE6ZjPX?=
 =?us-ascii?Q?psMOqjh8nJVGDQd3h25B3VH4z0Uom72EFr0cqXEOq0QpgXGy4AI/ypNEC5VZ?=
 =?us-ascii?Q?URusNbjcuFxKGF/UeBNObNMAg9zVDoXka5RdcOuZo9pc4yracHfdkDSbdT0s?=
 =?us-ascii?Q?utV1bBkS1I6pDLn4uwSdMRaob9rsmtKL+aY5JPNCsE09bfbX0dW7ICv1prid?=
 =?us-ascii?Q?vu93QwYMXnL9BRE1srss3etRL+ntrDhjYeSvS0dBvrd6cTxdsPj5pdDMipSU?=
 =?us-ascii?Q?/uv9VevlaxJId+JAQlpTOdrv6NXpGzbJ/Lv9R0Akg4+ghn8a/KyDO9AAXJ1b?=
 =?us-ascii?Q?3zHkd5Lb2+MTo4/nOIBovYEhBx4KGcWuaTRAMp6nmo0AgDG4WVbOUN8hthCB?=
 =?us-ascii?Q?q06Pqd5MqcZ4f4LbtfneYoGjYkCWWO9IPqZhxLgjSUixAdxyrdfWedGY9i1h?=
 =?us-ascii?Q?oUsLEXvpZFD+T4665uyBOQXLBxOV1TGU4/RN8yG6S2blmlKxPHLxCshw1Sz3?=
 =?us-ascii?Q?/Rxnfe8kwj08cDpFUhjqRgV6ZJezOmVdBMxGDo0D2KLHgVHccdHIzYlhZ+cV?=
 =?us-ascii?Q?JSwyEvPmlSq9dRbzv6fD4Wlv+N3o4FmWapV/i1KV/ym6GnX4aTj0Ly5Y3kFN?=
 =?us-ascii?Q?ckXK/Foo8JkDSDsEXnJ2bHpuWrODXu16BhZo0au6YUb8wS/r1HxtDresa58W?=
 =?us-ascii?Q?yzZ34SBQQiIpDMxGPpegWUSF36Z0QU68d7GuTlBAfaXpoqjDHTH8kHupKmvg?=
 =?us-ascii?Q?GS4keSOObzXaCi7M6IepTs6K5WhEKP0HwVTnc3LZTOyp8slgi+CxDC7vc0cI?=
 =?us-ascii?Q?SYKNqNXY2FsHMV3Hliyv5DYxtM1ucd76+VtLkWFNxlEO0KeGJmY3yNDLkUxD?=
 =?us-ascii?Q?KIGDZpPBF5XCsERE4AglhdGqCprLfPiQ4/Se8aUPYdQ9K4XXFLNvqGofktmY?=
 =?us-ascii?Q?YQAEEFnWUvZyv6W+QOhF9BgsrTeZQcSYdRWFISzrqDRBQFPzcmUQ8A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Hn3/xf8uON9xgMEyuGht5VTJAqi47+wZsg5a9HB9mO6wzm5SHhhKDkwg/XIO?=
 =?us-ascii?Q?r/2kgHoOVY0/fBsueA6vHAlgTlnrgG7NTPPCotGRUsh+T1oJ9+qVO1im4omN?=
 =?us-ascii?Q?BQam3e4zcKxIjJqhHhDdINxcGYB/LpBoc5fYWo9o1w9yDliwXIVGS66Jj1Ul?=
 =?us-ascii?Q?oj/LmIGauc7jA9W9B95zvxoR+tLzeQmF9jn5HsE5hP+uWRnhLD2nO2Vcrppd?=
 =?us-ascii?Q?Mfe9BDDXz+0O8JBn+gfCLPiMxaGsndxL39d9XNiLkCJPyjbQf0M1f15PuzI7?=
 =?us-ascii?Q?8pLJjkbZh263L8v1Ih7HjRI+mh9s9LSaMFIr93zs2snOoqAbOXFXvVHYcFVr?=
 =?us-ascii?Q?J2T3+aavlPXbQmXrVKZ/TP3VWdAe+s8StYKBBa154JCymNcA3mDiy2JeqyLp?=
 =?us-ascii?Q?XE/7uym0TO+05g7EMyQI5XLFoC5Teb3uoRTHyDvdmDgkX5/33QJUv9dUW75w?=
 =?us-ascii?Q?H4lRQLz9fz2cJCZ+JLkxUlzw0+1PWU5DtBirCSplbgc2XaBMkqqcyITcmZOO?=
 =?us-ascii?Q?W4bEFuwfG1zn1j6keHvylxCv3q6wzjxnH+PrIPUBnf5RDhm9jVSsPytCkBy6?=
 =?us-ascii?Q?1jvuGlmwR349+s8bQMd60FK5maVJRav272H9VJ25RGD1TEl8JyLz8anFq8Y7?=
 =?us-ascii?Q?zBlG1J8NTw2KXg8GbrE0/ZtUu+8nxZVr/4tK8G3NXDWNlJJl/RPlRTuA23cR?=
 =?us-ascii?Q?fnfDeGgYE5CA2ODzVg+hnGQgi3XY6sYrUJgSgEU36CisSAzXDAX4upqBw534?=
 =?us-ascii?Q?msW53/NMDStdExOjly0RGb0pGw5330dlh5OkoKMFMxtv9zJPKCh00cwFZhC0?=
 =?us-ascii?Q?9wQ5YGgVIe8Z2BKiL5vfiLsiYXaslt0bS2ZKI9vlKuWGe/H3Y2Hc0A2/V6X3?=
 =?us-ascii?Q?GNOMMQAtZlH0hrFXL1VP57tWrwbvt4ApVx/IO2BRx29eOmsSUtqnDigvq1lt?=
 =?us-ascii?Q?mTlKEHcl2J/R8U8I/KiqJVDZoXrQYWwS8H0pH4oOhGjJuG0vwCtoZlAtJ9tT?=
 =?us-ascii?Q?slyjpiZO3xm9h+PJYOlcNRoCZw3WMzVg46GyEKPu5g6Eb7n27p2s+PwnN4q1?=
 =?us-ascii?Q?gzFTDuqjrOmh5lk5gQxHaGihCGqpVVUQrpzUQ4T8rVOWoZMmh/W7njyC7A27?=
 =?us-ascii?Q?z+BOAueBVOzMa1utn4zKFk/uLhTDRtVW3g22nLhne9IK5fxHAI/y0lPqEjn5?=
 =?us-ascii?Q?+fofWegV/N1ZQ1n/Ywgn5JVLvAG3nnpi0IFFC2iOeNXJcA7edrxRivSMm0iv?=
 =?us-ascii?Q?7OtB4HrDabWPum9PxHuEausvb/MiGYbjVdIP+iWoqP2xa6MtZi9SF7x7dCMY?=
 =?us-ascii?Q?wUZocQA/OmMyGksbNaDiHgYVvwC8Q0LGNFtYb+BvQgmfEjd0VPAwttTsxGVp?=
 =?us-ascii?Q?UOYCKqPhtUa2kpU5ewoyGinA/MZO8nzP5sowxBOfcHKs5cmCmJAZTA4jGiYH?=
 =?us-ascii?Q?YyBhbiYzYv2Db76GfZOLyoaHqYFzXXDIhTdWzBR+j0VUzeyziHXtMBlnPT6a?=
 =?us-ascii?Q?Md6B7KiPzWj+0e8W9Kdo8OC/3KdQXomFsd2S+WAybi9hV/Bt2tuUW6lm3Xob?=
 =?us-ascii?Q?y67bJz8ia5+w0QKPm80u9LGXZ/cfiIPBIaZrAwhGnO7xjTVqMAusQfaiOU2m?=
 =?us-ascii?Q?NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d384b7a-a0ea-48b8-9f7a-08ddc23f16a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2025 18:57:17.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wLbatL4mPo2mb7ySPXNvO9b4WcRV6VRZLQl3WIfhfsZ/QAW+zAos1kiNHuc6PrDqWExHd8boOArBFLfxbdUL2lGecKmPmgIwCyiIDnP4dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12936
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Jul 2025 18:57:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19424

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 13 July 2025 10:59
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
>=20
> Hi!
>=20
> > This patch series for enhancing RZ/G2L DU driver.
> > All the patches are cherry-picked from mainline.
>=20
> Thank you, looks good to me. I assume it is same as 6.1 version?
>=20
> Mailing list damaged the patches, but 6.1 version came in ok, so I guess =
I can just apply that
> instead. (Assuming no other comments and okay tests).
>=20
> (And I guess we should think about sending patches as one series "6.1,
> 6.12 -- subject", when they are identical).

Yes, I agree. But I have notices that, sometimes cherry-pick adjusts the li=
ne position for patches
automatically even though it is identical patches across 5.10/6.1/6.12.
In such cases, if applying patch fails one can cherry-pick it.

Eg:
6.12:
	.driver_features	=3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.dumb_create		=3D rzg2l_du_dumb_create,
+	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(rzg2l_du_dumb_create),

6.1:
	.prime_handle_to_fd	=3D drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle	=3D drm_gem_prime_fd_to_handle,
 	.gem_prime_mmap		=3D drm_gem_prime_mmap,
+	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(rzg2l_du_dumb_create),

>=20
> I also assume 5.10 version is identical, with the dmabuf patch dropped?

Yes, I confirm.

Cheers,
Biju

