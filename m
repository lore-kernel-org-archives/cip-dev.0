Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE112C88E67
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:01:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14067.1789365706913717718
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 23:01:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=fLjOyd+g;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789365704;x=1790575304;bh=kQy6CHZ4QrIFfxbJbJd65m/k8qK8sxoimlPTt
	S77EJI=;b=fLjOyd+gW8tSrDWfzsD9VBHmR1e5AvUHiz4eoo2EHwo0dKaein3ahXgTDO+iSYpjCEA
	ppmQW/cq8JC6hOO8wsBOieIba/O9ZT7izmW6z7va6bik+NBUBV2Qn8IZXtPTZUcmIvep8wA9JJoF7
	Jr2EpBilsbfqgHQK6BcHYTLE7uQFkYKPL+i/SyJFvkVbeE5Bu0MZWwGhyDR2jkgaJoFl+FSbt4W9q
	vMFhjpZm2zpOdCirSekzAi5YAGCVtbqBJLTCuE202TtHyTklpgP4WFXJY9rQSmqMHoZ8K4E7skSTJ
	r7XiZjX9fLdD+T6I4w+vt1HmFcHx0yZFoTg6mezH3FJQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 68E61iZA2076966; Mon, 14 Sep 2026 15:01:44 +0900
X-Iguazu-Qid: 2yAb15SChPNlNGpCT8
X-Iguazu-QSIG: v=2; s=1; t=1789365703; q=2yAb15SChPNlNGpCT8; m=k6wwOsIi4y2zYScaCjABwPIUH4VCEpGTu7yRTsUv6gY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hjvfv1XStz1xnZ; Mon, 14 Sep 2026 15:01:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AckZYR/8suue3j+uWaSLA2vznbTAfVxhyNROfjUv0/OXAQV6b6CtGWfkvtwRXYfWHkB8uApv55HF+yPrs4ycZA75dxnOBPQxDhaDyzr1Iv2lxljMcRHGC9r2g+11xFlFGiuqy+ZNt/W/BBpC4EtGbHG6/KV88trHoP+t1FmY1q+PogfXbOHJI5xLCLIznIaka0YpUTjqoF1aFPL/wTghBg+tn2i5DOrEgXGxYvQxYbU84pA/YgOHFK2bpsVHNNS50W9wsuw4a47FTVyPVxdqyQyw0gmMb1QQPDskSuo2vACXR/9AyeBx3qUV0RGmcnFMhn6TfSvWCzuVp+J9s39HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlePcPiCmPSwKyEORM2xSB/vNxLtQ2E2qM6K2U8r9X0=;
 b=m7/oT/okBny5LUPeZl8ZhkEgueowQ8HyW+J0PxvStM4JhRkcgcPP+L1wsH8u/NzpjpUECXjTxAa5snTf2lO3C2jyl/Phttf/opT0GVN3gVKY8CV3dlQNgtpfqFVNrSb4eKhhHfePNKP1NH6F08ZuSJ5Bw/LR4nPoH33mx6+9qcwahlZfsbtErk7SIVvNEDSb/uXPmbVFcfIP7+CNOrECa8cfcjHi/IkPJIB8+/nnqqFzW94mqJeU1jEkiWzow5+2ocmwG7vsQWHB3hqh9nnF7EuxLq5ddjnFaBDftDy0bOWRCrbqfGLriJSL/RoQDzYy/g6P/PdHkVRcgO4XS79vsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi:
 Backport old info1 register layout
Thread-Topic: [cip-dev] [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi:
 Backport old info1 register layout
Thread-Index: AQHdQfYhdBW1pH9PckSpd0a3Cu0adLbNmHJg
Date: Mon, 14 Sep 2026 06:01:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F24F9C791A224F65FADDCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9574:EE_
x-ms-office365-filtering-correlation-id: f349fa97-4ba7-41f9-b3ed-08df1225a507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 AmGAIHDrqj+dhxmnPQtPjVRLqQSjTVMQpPEaAJdl74WaxEvF0+t7eZgA4l9E2lzubPSvnnAajuLcnjCQ3rVEdkSo8gDTKQvzgprWd7lDgUV1NKptIUo6fiWbw7uBclGZDeqj03zu+iY8dvZCb69FF6Hc11y9qqvNJ65VKB3RzI0H7FUbMA5S2ZPSA8fcK8q95IbkcMuh9LQ2DKo9ilbh8YLhk4VbyOCzwG/bWEHu/Pli/x08AA0f3CQT7mdTmdFZx4pKLbzMKpCgEDXZ2xiiEzFsb+Y7cZac1HxJ8ZHrUiXNH943Y9XQ4mnk4kbKtiU/mAHucZdELmm3bWLGS8rEDbeUzdCuUOxgkIFb54dWrrzG2PlfoNJ6FU/I5GKDo7KVCfadQM6alTC6TBysejA6MwliiYCeyC9QvQzW6YUoxV6CHY/HP4egbPep/y+8vPFed1WqBAmsXDtfW7ahlhxir2E52i7epaK1owIsevInl2u2cpk9q+jV1X2ySnmVpsEtm9peHX9Mebq1yMqcPfzWAUuAeDkh1TUE2frjuhyoJNgOUfzVzjAHeamnr3eYeQZo8hDUQw4ECotlqA4WFYkL0KXEu0pAewzsd0HnCYhCVa0UoclWV3Ey7jORYMqoOEHz/EZGySEDAkvNoTe9js1BPJcsHVLROUs5csb6FKrmcNt4e3aRSxu9rn0NYOd0ydmH0nWuFF8pXWXl9zlgq7CMLi8WnyBmYDGvqinhoTT+Ovo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?alA2Ym84WTZHNUtNNjhVdXBJbVdFRS95TzNyQ2FVWVlOVzlqSmltd0Ir?=
 =?iso-2022-jp?B?Z2U4Qi9HVjQ4MUpSU3ZXME1wMWVFOHlJbEJYOGowMTRKZis1UE1qQkJB?=
 =?iso-2022-jp?B?U3U4YVpMU3NJTmcxOXcxTjFDeUJoNEtOSXF0VFN5dlhwTVUxNXVTUmdK?=
 =?iso-2022-jp?B?N29vajZ5d2F1RksrZTVOQlFZYWRkN0xhd2VmV3czTHFEL1gwRWhmY1FL?=
 =?iso-2022-jp?B?ZHQyZjRkdWdoQmVKYnNYdUhad0wvUWs2eWJZRlZ6eEozanBGTW9PUSsv?=
 =?iso-2022-jp?B?OHZ3KzRNOUxXc3VPemtlU1hGaDAwcU9oZnpyK3VrS3dINGFiZUZUenFm?=
 =?iso-2022-jp?B?RlJQUTR0Tmd6NWdGdWdSTmtodDhLVTlhUDJ1NERkRGJLVEc2OFhFTmI5?=
 =?iso-2022-jp?B?eHRTc0xUVzJBRkkrWVdObVpxQUx0TjlPVllBS3Q3am9UNkJsNitJZG1E?=
 =?iso-2022-jp?B?Q1RsWDBzSTJLWFk4RXJXaFZJMnQ3cUk0Q3RtWFhYTTFrZDdDNTV1MjN4?=
 =?iso-2022-jp?B?czRBT285UUlPSk4wOHkyOUxVUXQzSVhHRTZjTzc4cXJqOGl5Q3ZDQXdl?=
 =?iso-2022-jp?B?Z2ZBK3NQNndvSzZqcWlxa2IrcUVRcGxpQnhRTmxvTUNUbVZwYUlkTHY3?=
 =?iso-2022-jp?B?ajJuMDk3czBTbGRwbG8xVUV6OFZGdGVlalhBVDVRZGpPNkRIbTNJeWJN?=
 =?iso-2022-jp?B?eHpRMSs2TTNSUnBYa3hBeTRPQkltSXlYSEZILzNQUHFUUXh4S3pld29L?=
 =?iso-2022-jp?B?NjB2WGkxbkluM1JLS0pKajRaNGY2R29ta1IySTVaNXBDT2NZa3hFWlVK?=
 =?iso-2022-jp?B?N2JhcWlGWFgzSWJsTGN6LzEra1pra1BuMUlZb3c2UTlLckxYNWJkeEI2?=
 =?iso-2022-jp?B?Q2hTdHcrRTFVV25rNTMyRlJkMjFtVnQwM2MxK3FtZGNOajlqeVN2YWNu?=
 =?iso-2022-jp?B?U1ZKY0lCUGFINkVSQkNwb0hFWEtaOFV2NVNwWnF3bjZXVWtNQmF6MmVr?=
 =?iso-2022-jp?B?SXAxTHRuajBiUUx5aUtxd0VTVWdyazlYOEtnazI2aDR1eFhVVUhtQ3R6?=
 =?iso-2022-jp?B?UmFoaEZrWXp2V2hSck42TmVIMDlKQ3Z2ekd6azFxY0t6QTZ3aytGbFB5?=
 =?iso-2022-jp?B?WmdPeDcvTE5oUkNPcW5jSVFXekprU3pvb2lXdjVoN3RXOVpvWjV1b3RH?=
 =?iso-2022-jp?B?ZDZtaGFTcDlwZEtXT2g4ZjIxMXV2dy9lQ1ZscWNZcktSR1VCaVo5SnQr?=
 =?iso-2022-jp?B?ZUQ3c050dDdxcnlYZkF2L2RncytvdmlGemJLc1c4WEtBMUVES0hicFkv?=
 =?iso-2022-jp?B?NmlGdmhrZmVkRjJHZDRFQnVYTklQSzhoeGh4OElHV1JqT2NEYXpWR2hx?=
 =?iso-2022-jp?B?WXJKRWZNeWt0UmthZ2ZrYmF6QytDbHQxV1pXOUYvaG1sWXI4NVBaMWdB?=
 =?iso-2022-jp?B?bU1vZmlWZ3RJM00vM2Y3MmVURnVldDNTOVYva0dUYXVUK2pVQmdPY2Rj?=
 =?iso-2022-jp?B?RE5Pa094aU5FazBnc25PV3FVYjgxYzdyazR5amUwdzF3SXR3ZmRERW9G?=
 =?iso-2022-jp?B?R0RSM1VKV1dPNmlYT1o1QmN4WTFNY084TlZ6WGptV3BIV2tFUWQzUnIx?=
 =?iso-2022-jp?B?cmgzOUdrUEZjcEppeEd6c1BwU3hzTWl3L3RURUVqUDNkSXhoSUVQZkw5?=
 =?iso-2022-jp?B?cGQ5SStYVUw4YnhEY1hnRndNeVVXTHFNb3YrU3hwUzN4UFprSE1qamRN?=
 =?iso-2022-jp?B?S2dkaFJ0Yisva3V6VGFjdmlhWkViM2RhbXlZUHMvZnhsWmZ5SnNnM2Vo?=
 =?iso-2022-jp?B?UlByUFhuVnNYSU50aERjMTAwRk9ndklXU29HdUdsQ2tBaW5rcEJTZUhk?=
 =?iso-2022-jp?B?R0o5SE9JUTkycEFzL09LK1M2SXBlRGNQQW5jb3NESjNYdy9ZNWpkVmY4?=
 =?iso-2022-jp?B?NmdaSE13RHpmamR3eERFaXlLYVhwZG9ydGVpelNEWnZkTUFsNFJ2UHBy?=
 =?iso-2022-jp?B?NXYrS29vQi95eEl0T3dMOUt5VGVVdVNXUnpxNG5JUUJiWFExOHRNOE52?=
 =?iso-2022-jp?B?ODdIVE9YZjdhR1pjbzYzVlVlb3N5dTN5REgrRytpWHByU2dMemhhaVFO?=
 =?iso-2022-jp?B?LzZDdEt6QWQyNllZYVRML3owNGZXR3M0bVhzR2R6RmRQQlRSY0xxVkV5?=
 =?iso-2022-jp?B?UEtNNC9BVXgxL3BrSUlaSzB2aG15WUNZZjl6OU9wLzR6VkxTL21Cd042?=
 =?iso-2022-jp?B?MGhXWUZWc3JaWEFzZlBuaTBOM1R0U3U2UHd1Ym9IV0JZYitqcFlPVkFE?=
 =?iso-2022-jp?B?QmJLMEswczhOK1kxUEEySGFLNzE4bDNkTkVPYTk5N1l0SVFwQzZXYlhH?=
 =?iso-2022-jp?B?Vnd4a0Z0QTFSQjVDQWtha05PbW9XZ2YzRThyVWdVMHZGYWtPZXUvYmRN?=
 =?iso-2022-jp?B?T1RJTVNUa1BPTm1icCtlRnZYayt3dkZvS0ZJQnJGM3hkbG5wQkNSRFpk?=
 =?iso-2022-jp?B?TngyOU12T0d5RTArVkFNS09QendDaVFINWNrTG5STDRLY2dSNUVNNVJV?=
 =?iso-2022-jp?B?bkVrVDV2Yz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	P72TSkqxo9A83DD+JHo7JNYzP/8c8N62Pj9Af8zoZvsaggw1Se+VQjjIOz+XW2JoPjeN8Toof2+Ep2i2quN1FMioiSkOHUxizzaYLMnY2d4weIuCyIQGtFcmCkGcmXOE2Z1Ov/cd/lXXoRSBAS3Q+gVWvgbPerBKTXqEfkXWYujxIKyLoqs0uSWvQPaGIMwZ9UMp0xM9rRFoYNMoGTVMZxWnUeeVdfSPoNebfSOoErjSo9+AykLIJ51JQ0UorDdDQC0pS3Cer33AV+0AZ/73FqAu0mMItM7DtO9Oz+wqtXHZA4lUo0jsCrou9TxjobGxop/AdqhZF1KfXLb84Pdz9A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f349fa97-4ba7-41f9-b3ed-08df1225a507
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 06:01:40.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtclFDUOndrZ69KJE3JwqgHB1no3aVnXXeQYmKiLu++pUjEwgH7IrTqb4FB7msVFdvVULGV+qy4gfkSzVfzbd17CytV+LHD0hexGDh/urG7tDCjdoBOumi8S/SHfwgBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9574
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 06:01:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24162

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of claudiu beznea
> Sent: Friday, September 11, 2026 11:02 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
> Cc: cip-dev@lists.cip-project.org
> Subject: [cip-dev] [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi:
> Backport old info1 register layout
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Some early Gen3 SoCs have the DTRANEND1 bit at a different location than =
all
> later SoCs. Series backports necessary patches to differentiate b/w old a=
nd
> new register layout. While at it, and since the code is aligned for doing=
 it now,
> backport the patches to enable RZ/G2N and RZ/G2E though their own
> compatible.
>=20
> All the patches backported here (except RZ/G2N and RZ/G2E ones) are alrea=
dy
> present in v6.1 and v6.12 CIP kernels.
>=20
> Thank you,
> Claudiu
>=20
> Geert Uytterhoeven (1):
>   mmc: renesas_sdhi: Add missing checks for the presence of quirks
>=20
> Lad Prabhakar (2):
>   mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
>   mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
>=20
> Wolfram Sang (10):
>   mmc: renesas_sdhi: remove accessor function for internal_dmac
>   mmc: tmio: add callback for dma irq
>   mmc: renesas_sdhi: remove outdated headers
>   mmc: renesas_sdhi: remove a stale comment
>   mmc: renesas_sdhi: make 'fixed_addr_mode' a quirk
>   mmc: renesas_sdhi: make 'dmac_only_one_rx' a quirk
>   mmc: renesas_sdhi: style fix for proper function bodies
>   mmc: renesas_sdhi: add quirk for broken register layout
>   mmc: renesas_sdhi: improve naming of DMA struct
>   mmc: renesas_sdhi: take DMA end interrupts into account
>=20
> Yoshihiro Shimoda (1):
>   mmc: renesas_sdhi: Refactor renesas_sdhi_probe()
>=20
>  drivers/mmc/host/renesas_sdhi.h               |  25 +-
>  drivers/mmc/host/renesas_sdhi_core.c          |  96 +------
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 269
> ++++++++++++++----
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   3 +-
>  drivers/mmc/host/tmio_mmc.h                   |   1 +
>  drivers/mmc/host/tmio_mmc_core.c              |   3 +
>  6 files changed, 236 insertions(+), 161 deletions(-)

I reviewed this series, looks good to me.
I can apply this if tests are OK and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284=
5750901

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


