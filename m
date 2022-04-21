Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E0FC6786C
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web09.16074.1650503559164074799
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 18:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 23L1CTdt022689;
 Thu, 21 Apr 2022 10:12:29 +0900
X-Iguazu-Qid: 34trWdh3M6ueDEGZFK
X-Iguazu-QSIG: v=2; s=0; t=1650503549; q=34trWdh3M6ueDEGZFK;
 m=c0uXq09Q3M5KsBrteWlbxU0/nT8QedCDUshGd23dZKo=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1512) id 23L1CRBt037974
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Apr 2022 10:12:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq59LBJbwH3iHOAaCoAa47JSZCcafpqsj+KbkVvLKXkYddPA9Xn8V5Vwtga3CsGKenJ6VpaeQ0G0srXS6x9HEKxzMWHmsofbvLlKI8oBHhxAzsBymh2sGbsS8V/uEVcZTU1kKJ+vHr78hiiRpS+1IFB0hFvFW73vYxa1E2B1RfqwJW2KoYUxC9DIQRdVv1irS4Q+JwpTRL4DEmKty5IKhzbE3OGvuJyvSiqDkLQKRParli+huqFBlLq+kZkDurqxmBpEp/DyKwmiNM3TNKwRZIQdpGUMQbCJcyCJNzuEEVWqHO3/tO+E41XYFD7JR/k3MjPUVQVkzjstRthL7aB7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0tOqQEQtFCveWgSG2knmqVPXNa5Rc+oMJFQqvhTnfs=;
 b=jL/+HdRsUNyv2liVfnG66GZf3BQVceEfKNJ/RMvPXuiB4Xf4a2518HZOg/SMhM0MUxkRncU9GPGkGS4u3pQo14rA2hq9pST3x6h5aQp9NI5nFeXVpW1iL6Qcojq+lSV0ZHVsXiBXDfyAl2eOzr/oE5GWC6jX1dAuv+oySRSzSOu7RS+B1fmx+Mv/e/WJNIwRSkuL9kmAElqcBAuDcZ14VaUUgD9z4pkiG4l6LXdn7XPxG8n+KhCITmrC7ullcaag4UGxvEzQLplceaKBjHD2IRp62z7wvd7v9pAaUetAOFL/7sEAWHIs4pGYtT+f8Qt4KCB0Us8EHk6BuPhq1doBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Topic: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Index: AQHYVP55INr87SHk8Eu9cb5sTJuVsaz5ickw
Date: Thu, 21 Apr 2022 01:12:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420CAD2775ACC96157525E292F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220420213424.27837-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26dca8b7-60b1-473b-6dd9-08da2333fec1
x-ms-traffictypediagnostic: TYCPR01MB6947:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB6947D87CB8A905F06433ADDB92F49@TYCPR01MB6947.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JX9OokvMjyEcFvs/RLsNC683DTYi2BkAFTCkZg5uavRqBQg2oDCvQC9h9hWVbSnMhfzIDigwQZfOUUZAGvpYnEnMJ8KM6dgHSDW5hQx2KIagrH6kdER8JGDrnMQIc81ZG/AL3LmTT3LWxGBjbqnLc0AssP1svdGixxCiX9a5kS4KWnUNsHLS8ja39z/KfccsaBECUPE08ta3Aq9RBN9mCltr655BGwapleX1qZT7BQRQH04dtyDsXoTuko+PlAM/HViEPHJBBgtgnapfkHO4mXTbnEZx6Qs1nB3q9OrF1f0SYcEDYf9C/aw7vwqIPp1g5UGRpSg78Ckz+bf20K7GFjqYhZBjIFaINCL73DUwY+NBR16XmSceg2PN4fxlSicxI2S5Lr5y2cmk1pkcg23hnkHmwR18sftq6b9yJGfYJuQKZg4EjO0grcqRUdx+xbRWOzb3Eo+C7dgpxuYuTeDakH6+q3tAaZ+Z5yeV7GJfMTfk/FS3ePE4qvnq7t5oF9612AtLmz4jW7Bdsk4QpC0k0j8hfHSZgFXk73LrRNY49HxF+nFod0+pmGt7cUeeK8+Fd7PkKwZkTqaCwBunHLeUvVYy0fZKAK+t4ICpm9VYd/hr20+mlhJWHHyvHO+DcSinWFwP3BcIPjm0Zdhqvf0/w0IuxLYdEJ3WiFof3qlQZtLLHiS7lp4RRKrrHokmisjC1t7IZu9S5K+t2B/s2sRqfo+KeVhwPt7ARTb5ExIk3+k+0N25bHP1XoID8A+RxK+ySjGMU4IgzZAtNxyM9XLEclBvSl7BzWJjFVh8wpzlGVM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(30864003)(186003)(508600001)(26005)(2906002)(71200400001)(316002)(966005)(4326008)(76116006)(110136005)(8676002)(38070700005)(86362001)(122000001)(38100700002)(66476007)(66556008)(66946007)(64756008)(66446008)(33656002)(55016003)(53546011)(83380400001)(8936002)(7696005)(5660300002)(52536014)(6506007)(9686003)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MmxWK0NGTDZNdG1LL3RNQzBTd2VKNGtCNS9xcUtWOHlIVXJ4NjNwTHVW?=
 =?iso-2022-jp?B?dWdMTWIvWjV6aEtJcXZDc3lMazN1cFRLcDRqWUo4WHQ1NVlLdm0yTWxS?=
 =?iso-2022-jp?B?YlRFQXpKNjAzVXQycVNiZGRtTlNTQU96bmVtcWg0MTdrVDhnemR0dU1H?=
 =?iso-2022-jp?B?U0FTdWo5MW5VTzNQKy9mOGtteFJFbDVSeU1MTEllcVd5ZjVzZ0Q0WFZ1?=
 =?iso-2022-jp?B?ZEdLR1RIcjVLVGVwMFd1UUVOOTRCWHlscnJiS0xMcVdZRWNUWUhIU2VF?=
 =?iso-2022-jp?B?ZjdpOG95bmlRSWIrNEhmTmFUb0NuRmwvSlJDTFh2MEY2djgrRTRFMGZC?=
 =?iso-2022-jp?B?NDA0YWhzSmM5dDN4VldDbHJBK2NuVTlQSXFxMlRxSCtkbmFDOXRrQXRl?=
 =?iso-2022-jp?B?dDNYc3RQM3BJK1VPdWxHNlU5dkNnSVJnNDNVUU9vNW5Sc2ZqQzRLenNF?=
 =?iso-2022-jp?B?UVlYajlKYTZLNlFGVmc5MWhaSkh0ZUJ2bTBNMHB2WUdBVEZmc2FYUnFj?=
 =?iso-2022-jp?B?Z1Q2TU5oR3NsY0U0RjY4d2R6NWhjRUJubkhXNG5JZllIeTAvMVJNNm9G?=
 =?iso-2022-jp?B?UkU1clByUS9IbE82am9qL09FRTBja21ucmJWUDNXdVZYSlNMWXdVcU5F?=
 =?iso-2022-jp?B?U0FnemxXVGw3a3NpZE9taG1ZSmJYcTZpT0ZucWovZWtlNXdHNVFmYzhY?=
 =?iso-2022-jp?B?VjZBcUMwdkFvSVpjR2Z0U0p3MVJVWUd1a2JSbTlFNTFRdXpBTUNmc2dB?=
 =?iso-2022-jp?B?QXNrRThZb0lNNzVaeDBPT01kVnFzU2NMUTFQb0J5Wk5ySmJwMGVBSXJB?=
 =?iso-2022-jp?B?MWVRM1RjWXo5TTBjcklRSElveFdiQjczbmxvMlloRGpuNERhV2JKRHpw?=
 =?iso-2022-jp?B?UVUxYXAvdHlPdjZaU0FEN1ExZ0JaRytLREJVN3NtUzJEREhwaGlCZFRM?=
 =?iso-2022-jp?B?UENCRElHSE41UjhPdFE5NU5yNmh2UHZvR1NqMTBsdDEvMDBPTkdkREFD?=
 =?iso-2022-jp?B?djNva25BODF1TEw3ZVZNc3ZIZnAyZFU2Q1lMMjRhUk5XUUJVT3dlV3E1?=
 =?iso-2022-jp?B?LzI2em4wZkE2K3pkSmk0ZUVYbmRwOU1tV3k5aU9RcVBONzNjUjNkRndn?=
 =?iso-2022-jp?B?VTFPcFdCTXJieHBTckIyTG13RnMyNEtWVHhWcUhoVzM3Tmxycjl3NUkv?=
 =?iso-2022-jp?B?REIxYncwdjB4aTBKNXdadHZYQlh5WGU0WFhsZS9NcmlabmVheStoem1J?=
 =?iso-2022-jp?B?UHZ1V2djWlkrWUhrL3FweG02UDJpVHpoYlpyMjA0amJOOGdjaFlDdXEz?=
 =?iso-2022-jp?B?UWpobDFveUZadk5oeFd5Zy9GNG1renRJWERxTUxrNm9nMHhwSTZTa3I3?=
 =?iso-2022-jp?B?eU51Smg1TDlLeW9vWnQwelZmUVE4NkZxMjBTRnJsMkNMQ0JoTXpXY3V2?=
 =?iso-2022-jp?B?a1dzb2lISmxZbkdsQ1d5UGdQQytxeml1M1ZSVXF2THJwRDhTUjVtN2tI?=
 =?iso-2022-jp?B?Q0RLaXFCaG8wVVBsSTJhZld2WFQxNk4wc1pxcmRUR1ZaWXRNK0NxdDdY?=
 =?iso-2022-jp?B?UnBBbStSUzBEU2lkL0FOeWNNbEFoZVVWVEdBZVpiUEtMTUdXTDAvVkds?=
 =?iso-2022-jp?B?L2pDSXJLbW03ZWdQT3RMc1lhenpXVVEyV0lza3lxY3BlekU2T2FjN0la?=
 =?iso-2022-jp?B?UTllNWJHZDJrVlNBRHFxdnVGN0tXQVloL2tJUmIxeGpNT0ljKzNTV0t5?=
 =?iso-2022-jp?B?NWtseXgxcWZYYkpOZGRzd3ZnV1JRLzZVUTZjTjRhYUc3YThuZWdsb2lM?=
 =?iso-2022-jp?B?cllCNTBvcVJJK3RrcktPb08wUEIzc0JsZkd0QjViYWVDd3R3bnk5THlT?=
 =?iso-2022-jp?B?UDEvd0piZmJ1MnF0V0E0YVJoOVl4RmJVMTlSRkVNVlphU3paL29NL3Nh?=
 =?iso-2022-jp?B?NTg3VWdCcGhTTEhUYjhRM2lMVHNVbHlKMmlFZjZqbmwvTzBvY0pFVHBD?=
 =?iso-2022-jp?B?VFFpd0F2NUlXOCtoMmYyb2pCbU5ienZsNVY3ZnRLMm5sSG00VlFIMVNq?=
 =?iso-2022-jp?B?bEczSVBCeDB0ZXZveEtwQUloSTU2TkxWSkN0eUlVV3NCc3kyT05LcjVM?=
 =?iso-2022-jp?B?RWlxVkJpL2NYbWxQNUgyTjYvRU5wYU5TelgxK3BBdzkzZCtWYS9PTmcr?=
 =?iso-2022-jp?B?SGhmSmNSSTRwa3Y3NFVJbXBuSDYrdytuNmE0OTQxeGZUVkJLbUgyL21Q?=
 =?iso-2022-jp?B?YUdRb0pmdlE1L1I2QTRVK21Lbjducm05QzNVanRxYnNNdExiZEhkclpI?=
 =?iso-2022-jp?B?bG1laTJqeEtPbm1aMUVtSVFwQ3l6cjJwanBwNStydzlQbnJVVzd3M3lX?=
 =?iso-2022-jp?B?R0FTYXJVTzJpSE8wZGorZmdOWnlKbndtNTYxZWlEaDdkMGh0SkE3OEJK?=
 =?iso-2022-jp?B?S0wxK1U0bERYV0J5SDNIWXNpVlJ4eWdNOG9qeU1KWTVoWmtEQW93SU1J?=
 =?iso-2022-jp?B?WkZocWJ5c1lISjIrSjl4SER2SXdCUTVYZ2JleHdjdit6ZklKRFBwNzhY?=
 =?iso-2022-jp?B?UklnblNobz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 26dca8b7-60b1-473b-6dd9-08da2333fec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 01:12:25.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 v3uBnZI7IV4FMkjn0eksTs9VoVc2Oq6lij5lNskieeUq7Yprs7OeXbF9xaZwqCfyfNmjgkDnE/thO2oZuaKt00g3yjKxAaJ+nSRyQWCEXNhK1dLsuXUh5f+LsBut7nqv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6947
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8148

Hi Lad,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, April 21, 2022 6:34 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 03e786bd43410fa93e5d2459f7a43e90ff0ae801 upstream.
>=20
> Add serial sound interface(SSIF-2) driver support for RZ/G2L SoC.
>=20
> Based on the work done by Chris Brandt for RZ/A SSI driver.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Link:
> https://lore.kernel.org/r/20210813091156.10700-2-biju.das.jz@bp.renesas.c=
o
> m
> Signed-off-by: Mark Brown <broonie@kernel.org>
> [PL: Dropped using modern terminology]
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  sound/soc/sh/Kconfig  |   6 +
>  sound/soc/sh/Makefile |   4 +
>  sound/soc/sh/rz-ssi.c | 871
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 881 insertions(+)
>  create mode 100644 sound/soc/sh/rz-ssi.c
>=20
> diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig index
> ef8a29b9f641..f19bd15c0900 100644
> --- a/sound/soc/sh/Kconfig
> +++ b/sound/soc/sh/Kconfig
> @@ -44,6 +44,12 @@ config SND_SOC_RCAR
>  	help
>  	  This option enables R-Car SRU/SCU/SSIU/SSI sound support
>=20
> +config SND_SOC_RZ
> +	tristate "RZ/G2L series SSIF-2 support"
> +	depends on ARCH_R9A07G044 || COMPILE_TEST
> +	help
> +	  This option enables RZ/G2L SSIF-2 sound support.
> +
>  ##
>  ## Boards
>  ##
> diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile index
> 51bd7c81671c..f6fd79948f6a 100644
> --- a/sound/soc/sh/Makefile
> +++ b/sound/soc/sh/Makefile
> @@ -22,3 +22,7 @@ snd-soc-migor-objs		:=3D migor.o
>=20
>  obj-$(CONFIG_SND_SH7760_AC97)	+=3D snd-soc-sh7760-ac97.o
>  obj-$(CONFIG_SND_SIU_MIGOR)	+=3D snd-soc-migor.o
> +
> +# RZ/G2L
> +snd-soc-rz-ssi-objs		:=3D rz-ssi.o
> +obj-$(CONFIG_SND_SOC_RZ)	+=3D snd-soc-rz-ssi.o
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c new file mode
> 100644 index 000000000000..7e0d3a4485e3
> --- /dev/null
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -0,0 +1,871 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Renesas RZ/G2L ASoC Serial Sound Interface (SSIF-2) Driver // //
> +Copyright (C) 2021 Renesas Electronics Corp.
> +// Copyright (C) 2019 Chris Brandt.
> +//
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <sound/soc.h>
> +
> +/* REGISTER OFFSET */
> +#define SSICR			0x000
> +#define SSISR			0x004
> +#define SSIFCR			0x010
> +#define SSIFSR			0x014
> +#define SSIFTDR			0x018
> +#define SSIFRDR			0x01c
> +#define SSIOFR			0x020
> +#define SSISCR			0x024
> +
> +/* SSI REGISTER BITS */
> +#define SSICR_DWL(x)		(((x) & 0x7) << 19)
> +#define SSICR_SWL(x)		(((x) & 0x7) << 16)
> +#define SSICR_MST		BIT(14)
> +#define SSICR_CKDV(x)		(((x) & 0xf) << 4)
> +
> +#define SSICR_CKS		BIT(30)
> +#define SSICR_TUIEN		BIT(29)
> +#define SSICR_TOIEN		BIT(28)
> +#define SSICR_RUIEN		BIT(27)
> +#define SSICR_ROIEN		BIT(26)
> +#define SSICR_MST		BIT(14)
> +#define SSICR_BCKP		BIT(13)
> +#define SSICR_LRCKP		BIT(12)
> +#define SSICR_CKDV(x)		(((x) & 0xf) << 4)
> +#define SSICR_TEN		BIT(1)
> +#define SSICR_REN		BIT(0)
> +
> +#define SSISR_TUIRQ		BIT(29)
> +#define SSISR_TOIRQ		BIT(28)
> +#define SSISR_RUIRQ		BIT(27)
> +#define SSISR_ROIRQ		BIT(26)
> +#define SSISR_IIRQ		BIT(25)
> +
> +#define SSIFCR_AUCKE		BIT(31)
> +#define SSIFCR_SSIRST		BIT(16)
> +#define SSIFCR_TIE		BIT(3)
> +#define SSIFCR_RIE		BIT(2)
> +#define SSIFCR_TFRST		BIT(1)
> +#define SSIFCR_RFRST		BIT(0)
> +
> +#define SSIFSR_TDC_MASK		0x3f
> +#define SSIFSR_TDC_SHIFT	24
> +#define SSIFSR_RDC_MASK		0x3f
> +#define SSIFSR_RDC_SHIFT	8
> +
> +#define SSIFSR_TDC(x)		(((x) & 0x1f) << 24)

This is not used.=20
If you use it, you can use SSIFSR_TDC_SHIFT and SSIFSR_TDC_MASK.

> +#define SSIFSR_TDE		BIT(16)
> +#define SSIFSR_RDC(x)		(((x) & 0x1f) << 8)

Same above.

> +#define SSIFSR_RDF		BIT(0)
> +
> +#define SSIOFR_LRCONT		BIT(8)
> +
> +#define SSISCR_TDES(x)		(((x) & 0x1f) << 8)
> +#define SSISCR_RDFS(x)		(((x) & 0x1f) << 0)
> +
> +/* Pre allocated buffers sizes */
> +#define PREALLOC_BUFFER		(SZ_32K)
> +#define PREALLOC_BUFFER_MAX	(SZ_32K)
> +
> +#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /*
> 8k-44.1kHz */
> +#define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
> +#define SSI_CHAN_MIN		2
> +#define SSI_CHAN_MAX		2
> +#define SSI_FIFO_DEPTH		32
> +
> +struct rz_ssi_priv;
> +
> +struct rz_ssi_stream {
> +	struct rz_ssi_priv *priv;
> +	struct snd_pcm_substream *substream;
> +	int fifo_sample_size;	/* sample capacity of SSI FIFO */
> +	int period_counter;	/* for keeping track of periods transferred */
> +	int sample_width;
> +	int buffer_pos;		/* current frame position in the buffer */
> +	int running;		/* 0=3Dstopped, 1=3Drunning */
> +
> +	int uerr_num;
> +	int oerr_num;
> +
> +	int (*transfer)(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm);
> +};
> +
> +struct rz_ssi_priv {
> +	void __iomem *base;
> +	struct platform_device *pdev;
> +	struct reset_control *rstc;
> +	struct device *dev;
> +	struct clk *sfr_clk;
> +	struct clk *clk;
> +
> +	int irq_int;
> +	int irq_tx;
> +	int irq_rx;
> +
> +	spinlock_t lock;
> +
> +	/*
> +	 * The SSI supports full-duplex transmission and reception.
> +	 * However, if an error occurs, channel reset (both transmission
> +	 * and reception reset) is required.
> +	 * So it is better to use as half-duplex (playing and recording
> +	 * should be done on separate channels).
> +	 */
> +	struct rz_ssi_stream playback;
> +	struct rz_ssi_stream capture;
> +
> +	/* clock */
> +	unsigned long audio_mck;
> +	unsigned long audio_clk_1;
> +	unsigned long audio_clk_2;
> +
> +	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
> +	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
> +};
> +
> +static void rz_ssi_reg_writel(struct rz_ssi_priv *priv, uint reg, u32
> +data) {
> +	writel(data, (priv->base + reg));
> +}
> +
> +static u32 rz_ssi_reg_readl(struct rz_ssi_priv *priv, uint reg) {
> +	return readl(priv->base + reg);
> +}
> +
> +static void rz_ssi_reg_mask_setl(struct rz_ssi_priv __iomem *priv, uint =
reg,
> +				 u32 bclr, u32 bset)
> +{
> +	u32 val;
> +
> +	val =3D readl(priv->base + reg);
> +	val =3D (val & ~bclr) | bset;
> +	writel(val, (priv->base + reg));
> +}
> +
> +static inline struct snd_soc_dai *
> +rz_ssi_get_dai(struct snd_pcm_substream *substream) {
> +	struct snd_soc_pcm_runtime *rtd =3D
> asoc_substream_to_rtd(substream);
> +
> +	return asoc_rtd_to_cpu(rtd, 0);
> +}
> +
> +static inline bool rz_ssi_stream_is_play(struct rz_ssi_priv *ssi,
> +					 struct snd_pcm_substream
> *substream) {
> +	return substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK; }
> +
> +static inline struct rz_ssi_stream *
> +rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream
> +*substream) {
> +	struct rz_ssi_stream *stream =3D &ssi->playback;
> +
> +	if (substream->stream !=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		stream =3D &ssi->capture;
> +
> +	return stream;
> +}
> +
> +static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
> +				  struct rz_ssi_stream *strm)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&ssi->lock, flags);
> +	ret =3D !!(strm->substream && strm->substream->runtime);
> +	spin_unlock_irqrestore(&ssi->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int rz_ssi_stream_init(struct rz_ssi_priv *ssi,
> +			      struct rz_ssi_stream *strm,
> +			      struct snd_pcm_substream *substream) {
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +
> +	strm->substream =3D substream;
> +	strm->sample_width =3D samples_to_bytes(runtime, 1);
> +	strm->period_counter =3D 0;
> +	strm->buffer_pos =3D 0;
> +
> +	strm->oerr_num =3D 0;
> +	strm->uerr_num =3D 0;
> +	strm->running =3D 0;
> +
> +	/* fifo init */
> +	strm->fifo_sample_size =3D SSI_FIFO_DEPTH;
> +
> +	return 0;
> +}
> +
> +static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
> +			       struct rz_ssi_stream *strm)
> +{
> +	struct snd_soc_dai *dai =3D rz_ssi_get_dai(strm->substream);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ssi->lock, flags);
> +	strm->substream =3D NULL;
> +	spin_unlock_irqrestore(&ssi->lock, flags);
> +
> +	if (strm->oerr_num > 0)
> +		dev_info(dai->dev, "overrun =3D %d\n", strm->oerr_num);
> +
> +	if (strm->uerr_num > 0)
> +		dev_info(dai->dev, "underrun =3D %d\n", strm->uerr_num); }
> +
> +static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
> +			    unsigned int channels)
> +{
> +	static s8 ckdv[16] =3D { 1,  2,  4,  8, 16, 32, 64, 128,
> +			       6, 12, 24, 48, 96, -1, -1, -1 };
> +	unsigned int channel_bits =3D 32;	/* System Word Length */
> +	unsigned long bclk_rate =3D rate * channels * channel_bits;
> +	unsigned int div;
> +	unsigned int i;
> +	u32 ssicr =3D 0;
> +	u32 clk_ckdv;
> +
> +	/* Clear AUCKE so we can set MST */
> +	rz_ssi_reg_writel(ssi, SSIFCR, 0);
> +
> +	/* Continue to output LRCK pin even when idle */
> +	rz_ssi_reg_writel(ssi, SSIOFR, SSIOFR_LRCONT);
> +	if (ssi->audio_clk_1 && ssi->audio_clk_2) {
> +		if (ssi->audio_clk_1 % bclk_rate)
> +			ssi->audio_mck =3D ssi->audio_clk_2;
> +		else
> +			ssi->audio_mck =3D ssi->audio_clk_1;
> +	}
> +
> +	/* Clock setting */
> +	ssicr |=3D SSICR_MST;
> +	if (ssi->audio_mck =3D=3D ssi->audio_clk_1)
> +		ssicr |=3D SSICR_CKS;
> +	if (ssi->bckp_rise)
> +		ssicr |=3D SSICR_BCKP;
> +	if (ssi->lrckp_fsync_fall)
> +		ssicr |=3D SSICR_LRCKP;
> +
> +	/* Determine the clock divider */
> +	clk_ckdv =3D 0;
> +	div =3D ssi->audio_mck / bclk_rate;
> +	/* try to find an match */
> +	for (i =3D 0; i < ARRAY_SIZE(ckdv); i++) {
> +		if (ckdv[i] =3D=3D div) {
> +			clk_ckdv =3D i;
> +			break;
> +		}
> +	}
> +
> +	if (i =3D=3D ARRAY_SIZE(ckdv)) {
> +		dev_err(ssi->dev, "Rate not divisible by audio clock
> source\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * DWL: Data Word Length =3D 16 bits
> +	 * SWL: System Word Length =3D 32 bits
> +	 */
> +	ssicr |=3D SSICR_CKDV(clk_ckdv);
> +	ssicr |=3D SSICR_DWL(1) | SSICR_SWL(3);
> +	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +	rz_ssi_reg_writel(ssi, SSIFCR,
> +			  (SSIFCR_AUCKE | SSIFCR_TFRST |
> SSIFCR_RFRST));
> +
> +	return 0;
> +}
> +
> +static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream
> +*strm) {
> +	bool is_play =3D rz_ssi_stream_is_play(ssi, strm->substream);
> +	u32 ssicr, ssifcr;
> +
> +	ssicr =3D rz_ssi_reg_readl(ssi, SSICR);
> +	ssifcr =3D rz_ssi_reg_readl(ssi, SSIFCR) & ~0xF;
> +
> +	/* FIFO interrupt thresholds */
> +	rz_ssi_reg_writel(ssi, SSISCR,
> +			  SSISCR_TDES(strm->fifo_sample_size / 2 - 1) |
> +			  SSISCR_RDFS(0));
> +
> +	/* enable IRQ */
> +	if (is_play) {
> +		ssicr |=3D SSICR_TUIEN | SSICR_TOIEN;
> +		ssifcr |=3D SSIFCR_TIE | SSIFCR_RFRST;
> +	} else {
> +		ssicr |=3D SSICR_RUIEN | SSICR_ROIEN;
> +		ssifcr |=3D SSIFCR_RIE | SSIFCR_TFRST;
> +	}
> +
> +	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +	rz_ssi_reg_writel(ssi, SSIFCR, ssifcr);
> +
> +	/* Clear all error flags */
> +	rz_ssi_reg_mask_setl(ssi, SSISR,
> +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> +			      SSISR_RUIRQ), 0);
> +
> +	strm->running =3D 1;
> +	ssicr |=3D is_play ? SSICR_TEN : SSICR_REN;
> +	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +
> +	return 0;
> +}
> +
> +static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream
> +*strm) {
> +	int timeout;
> +
> +	strm->running =3D 0;
> +
> +	/* Disable TX/RX */
> +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
> +
> +	/* Disable irqs */
> +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> +			     SSICR_RUIEN | SSICR_ROIEN, 0);
> +	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> +
> +	/* Clear all error flags */
> +	rz_ssi_reg_mask_setl(ssi, SSISR,
> +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> +			      SSISR_RUIRQ), 0);
> +
> +	/* Wait for idle */
> +	timeout =3D 100;
> +	while (--timeout) {
> +		if (rz_ssi_reg_readl(ssi, SSISR) | SSISR_IIRQ)
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (!timeout)
> +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> +
> +	/* Hold FIFOs in reset */
> +	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> +			     SSIFCR_TFRST | SSIFCR_RFRST);
> +
> +	return 0;
> +}
> +
> +static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int
> +frames) {
> +	struct snd_pcm_substream *substream =3D strm->substream;
> +	struct snd_pcm_runtime *runtime;
> +	int current_period;
> +
> +	if (!strm->running || !substream || !substream->runtime)
> +		return;
> +
> +	runtime =3D substream->runtime;
> +	strm->buffer_pos +=3D frames;
> +	WARN_ON(strm->buffer_pos > runtime->buffer_size);
> +
> +	/* ring buffer */
> +	if (strm->buffer_pos =3D=3D runtime->buffer_size)
> +		strm->buffer_pos =3D 0;
> +
> +	current_period =3D strm->buffer_pos / runtime->period_size;
> +	if (strm->period_counter !=3D current_period) {
> +		snd_pcm_period_elapsed(strm->substream);
> +		strm->period_counter =3D current_period;
> +	}
> +}
> +
> +static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct
> +rz_ssi_stream *strm) {
> +	struct snd_pcm_substream *substream =3D strm->substream;
> +	struct snd_pcm_runtime *runtime;
> +	u16 *buf;
> +	int fifo_samples;
> +	int frames_left;
> +	int samples =3D 0;
> +	int i;


Please use reverse christmas tree order.

> +
> +	if (!rz_ssi_stream_is_valid(ssi, strm))
> +		return -EINVAL;
> +
> +	runtime =3D substream->runtime;
> +	/* frames left in this period */
> +	frames_left =3D runtime->period_size - (strm->buffer_pos %
> +					      runtime->period_size);
> +	if (frames_left =3D=3D 0)
> +		frames_left =3D runtime->period_size;
> +
> +	/* Samples in RX FIFO */
> +	fifo_samples =3D (rz_ssi_reg_readl(ssi, SSIFSR) >>
> +			SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
> +
> +	/* Only read full frames at a time */
> +	while (frames_left && (fifo_samples >=3D runtime->channels)) {
> +		samples +=3D runtime->channels;
> +		fifo_samples -=3D runtime->channels;
> +		frames_left--;
> +	}
> +
> +	/* not enough samples yet */
> +	if (samples =3D=3D 0)
> +		return 0;
> +
> +	/* calculate new buffer index */
> +	buf =3D (u16 *)(runtime->dma_area);
> +	buf +=3D strm->buffer_pos * runtime->channels;
> +
> +	/* Note, only supports 16-bit samples */
> +	for (i =3D 0; i < samples; i++)
> +		*buf++ =3D (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
> +
> +	rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> +	rz_ssi_pointer_update(strm, samples / runtime->channels);
> +
> +	/*
> +	 * If we finished this period, but there are more samples in
> +	 * the RX FIFO, call this function again
> +	 */
> +	if (frames_left =3D=3D 0 && fifo_samples >=3D runtime->channels)
> +		rz_ssi_pio_recv(ssi, strm);
> +
> +	return 0;
> +}
> +
> +static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct
> +rz_ssi_stream *strm) {
> +	struct snd_pcm_substream *substream =3D strm->substream;
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	int sample_space;
> +	int samples =3D 0;
> +	int frames_left;
> +	int i;
> +	u32 ssifsr;
> +	u16 *buf;

Please use reverse christmas tree order.

> +
> +	if (!rz_ssi_stream_is_valid(ssi, strm))
> +		return -EINVAL;
> +
> +	/* frames left in this period */
> +	frames_left =3D runtime->period_size - (strm->buffer_pos %
> +					      runtime->period_size);
> +	if (frames_left =3D=3D 0)
> +		frames_left =3D runtime->period_size;
> +
> +	sample_space =3D strm->fifo_sample_size;
> +	ssifsr =3D rz_ssi_reg_readl(ssi, SSIFSR);
> +	sample_space -=3D (ssifsr >> SSIFSR_TDC_SHIFT) &
> SSIFSR_TDC_MASK;
> +
> +	/* Only add full frames at a time */
> +	while (frames_left && (sample_space >=3D runtime->channels)) {
> +		samples +=3D runtime->channels;
> +		sample_space -=3D runtime->channels;
> +		frames_left--;
> +	}
> +
> +	/* no space to send anything right now */
> +	if (samples =3D=3D 0)
> +		return 0;
> +
> +	/* calculate new buffer index */
> +	buf =3D (u16 *)(runtime->dma_area);
> +	buf +=3D strm->buffer_pos * runtime->channels;
> +
> +	/* Note, only supports 16-bit samples */
> +	for (i =3D 0; i < samples; i++)
> +		rz_ssi_reg_writel(ssi, SSIFTDR, ((u32)(*buf++) << 16));
> +
> +	rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_TDE, 0);
> +	rz_ssi_pointer_update(strm, samples / runtime->channels);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rz_ssi_interrupt(int irq, void *data) {
> +	struct rz_ssi_stream *strm =3D NULL;
> +	struct rz_ssi_priv *ssi =3D data;
> +	u32 ssisr =3D rz_ssi_reg_readl(ssi, SSISR);
> +
> +	if (ssi->playback.substream)
> +		strm =3D &ssi->playback;
> +	else if (ssi->capture.substream)
> +		strm =3D &ssi->capture;
> +	else
> +		return IRQ_HANDLED; /* Left over TX/RX interrupt */
> +
> +	if (irq =3D=3D ssi->irq_int) { /* error or idle */
> +		if (ssisr & SSISR_TUIRQ)
> +			strm->uerr_num++;
> +		if (ssisr & SSISR_TOIRQ)
> +			strm->oerr_num++;
> +		if (ssisr & SSISR_RUIRQ)
> +			strm->uerr_num++;
> +		if (ssisr & SSISR_ROIRQ)
> +			strm->oerr_num++;
> +
> +		if (ssisr & (SSISR_TUIRQ | SSISR_TOIRQ | SSISR_RUIRQ |
> +			     SSISR_ROIRQ)) {
> +			/* Error handling */
> +			/* You must reset (stop/restart) after each interrupt */
> +			rz_ssi_stop(ssi, strm);
> +
> +			/* Clear all flags */
> +			rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ |
> +					     SSISR_TUIRQ | SSISR_ROIRQ |
> +					     SSISR_RUIRQ, 0);
> +
> +			/* Add/remove more data */
> +			strm->transfer(ssi, strm);
> +
> +			/* Resume */
> +			rz_ssi_start(ssi, strm);
> +		}
> +	}
> +
> +	if (!strm->running)
> +		return IRQ_HANDLED;
> +
> +	/* tx data empty */
> +	if (irq =3D=3D ssi->irq_tx)
> +		strm->transfer(ssi, &ssi->playback);
> +
> +	/* rx data full */
> +	if (irq =3D=3D ssi->irq_rx) {
> +		strm->transfer(ssi, &ssi->capture);
> +		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int
> cmd,
> +			      struct snd_soc_dai *dai)
> +{
> +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> +	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
> +	int ret =3D 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		/* Soft Reset */
> +		rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
> +		rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
> +		udelay(5);
> +
> +		ret =3D rz_ssi_stream_init(ssi, strm, substream);
> +		if (ret)
> +			goto done;
> +
> +		ret =3D strm->transfer(ssi, strm);
> +		if (ret)
> +			goto done;
> +
> +		ret =3D rz_ssi_start(ssi, strm);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		rz_ssi_stop(ssi, strm);
> +		rz_ssi_stream_quit(ssi, strm);
> +		break;
> +	}
> +
> +done:
> +	return ret;
> +}
> +
> +static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int
> +fmt) {
> +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		break;
> +	default:
> +		dev_err(ssi->dev, "Codec should be clk and frame
> consumer\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * set clock polarity
> +	 *
> +	 * "normal" BCLK =3D Signal is available at rising edge of BCLK
> +	 * "normal" FSYNC =3D (I2S) Left ch starts with falling FSYNC edge
> +	 */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		ssi->bckp_rise =3D false;
> +		ssi->lrckp_fsync_fall =3D false;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		ssi->bckp_rise =3D false;
> +		ssi->lrckp_fsync_fall =3D true;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		ssi->bckp_rise =3D true;
> +		ssi->lrckp_fsync_fall =3D false;
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +		ssi->bckp_rise =3D true;
> +		ssi->lrckp_fsync_fall =3D true;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* only i2s support */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		break;
> +	default:
> +		dev_err(ssi->dev, "Only I2S mode is supported.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> +	unsigned int sample_bits =3D hw_param_interval(params,
> +
> 	SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
> +	unsigned int channels =3D params_channels(params);
> +
> +	if (sample_bits !=3D 16) {
> +		dev_err(ssi->dev, "Unsupported sample width: %d\n",
> +			sample_bits);
> +		return -EINVAL;
> +	}
> +
> +	if (channels !=3D 2) {
> +		dev_err(ssi->dev, "Number of channels not matched: %d\n",
> +			channels);
> +		return -EINVAL;
> +	}
> +
> +	return rz_ssi_clk_setup(ssi, params_rate(params),
> +				params_channels(params));
> +}
> +
> +static const struct snd_soc_dai_ops rz_ssi_dai_ops =3D {
> +	.trigger	=3D rz_ssi_dai_trigger,
> +	.set_fmt	=3D rz_ssi_dai_set_fmt,
> +	.hw_params	=3D rz_ssi_dai_hw_params,
> +};
> +
> +static const struct snd_pcm_hardware rz_ssi_pcm_hardware =3D {
> +	.info			=3D SNDRV_PCM_INFO_INTERLEAVED	|
> +				  SNDRV_PCM_INFO_MMAP		|
> +				  SNDRV_PCM_INFO_MMAP_VALID,
> +	.buffer_bytes_max	=3D PREALLOC_BUFFER,
> +	.period_bytes_min	=3D 32,
> +	.period_bytes_max	=3D 8192,
> +	.channels_min		=3D SSI_CHAN_MIN,
> +	.channels_max		=3D SSI_CHAN_MAX,
> +	.periods_min		=3D 1,
> +	.periods_max		=3D 32,
> +	.fifo_size		=3D 32 * 2,
> +};
> +
> +static int rz_ssi_pcm_open(struct snd_soc_component *component,
> +			   struct snd_pcm_substream *substream) {
> +	snd_soc_set_runtime_hwparams(substream,
> &rz_ssi_pcm_hardware);
> +
> +	return snd_pcm_hw_constraint_integer(substream->runtime,
> +
> SNDRV_PCM_HW_PARAM_PERIODS);
> +}
> +
> +static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component
> *component,
> +					    struct snd_pcm_substream
> *substream) {
> +	struct snd_soc_dai *dai =3D rz_ssi_get_dai(substream);
> +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> +	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
> +
> +	return strm->buffer_pos;
> +}
> +
> +static int rz_ssi_pcm_new(struct snd_soc_component *component,
> +			  struct snd_soc_pcm_runtime *rtd)
> +{
> +	snd_pcm_set_managed_buffer_all(rtd->pcm,
> SNDRV_DMA_TYPE_DEV,
> +				       rtd->card->snd_card->dev,
> +				       PREALLOC_BUFFER,
> PREALLOC_BUFFER_MAX);
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_driver rz_ssi_soc_dai[] =3D {
> +	{
> +		.name			=3D "rz-ssi-dai",
> +		.playback =3D {
> +			.rates		=3D SSI_RATES,
> +			.formats	=3D SSI_FMTS,
> +			.channels_min	=3D SSI_CHAN_MIN,
> +			.channels_max	=3D SSI_CHAN_MAX,
> +		},
> +		.capture =3D {
> +			.rates		=3D SSI_RATES,
> +			.formats	=3D SSI_FMTS,
> +			.channels_min	=3D SSI_CHAN_MIN,
> +			.channels_max	=3D SSI_CHAN_MAX,
> +		},
> +		.ops =3D &rz_ssi_dai_ops,
> +	},
> +};
> +
> +static const struct snd_soc_component_driver rz_ssi_soc_component =3D {
> +	.name		=3D "rz-ssi",
> +	.open		=3D rz_ssi_pcm_open,
> +	.pointer	=3D rz_ssi_pcm_pointer,
> +	.pcm_construct	=3D rz_ssi_pcm_new,
> +};
> +
> +static int rz_ssi_probe(struct platform_device *pdev) {
> +	struct rz_ssi_priv *ssi;
> +	struct clk *audio_clk;
> +	int ret;
> +
> +	ssi =3D devm_kzalloc(&pdev->dev, sizeof(*ssi), GFP_KERNEL);
> +	if (!ssi)
> +		return -ENOMEM;
> +
> +	ssi->pdev =3D pdev;
> +	ssi->dev =3D &pdev->dev;
> +	ssi->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ssi->base))
> +		return PTR_ERR(ssi->base);
> +
> +	ssi->clk =3D devm_clk_get(&pdev->dev, "ssi");
> +	if (IS_ERR(ssi->clk))
> +		return PTR_ERR(ssi->clk);
> +
> +	ssi->sfr_clk =3D devm_clk_get(&pdev->dev, "ssi_sfr");
> +	if (IS_ERR(ssi->sfr_clk))
> +		return PTR_ERR(ssi->sfr_clk);
> +
> +	audio_clk =3D devm_clk_get(&pdev->dev, "audio_clk1");
> +	if (IS_ERR(audio_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
> +				     "no audio clk1");
> +
> +	ssi->audio_clk_1 =3D clk_get_rate(audio_clk);
> +	audio_clk =3D devm_clk_get(&pdev->dev, "audio_clk2");
> +	if (IS_ERR(audio_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
> +				     "no audio clk2");
> +
> +	ssi->audio_clk_2 =3D clk_get_rate(audio_clk);
> +	if (!(ssi->audio_clk_1 || ssi->audio_clk_2))
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "no audio clk1 or audio clk2");
> +
> +	ssi->audio_mck =3D ssi->audio_clk_1 ? ssi->audio_clk_1 :
> +ssi->audio_clk_2;
> +
> +	ssi->playback.transfer =3D rz_ssi_pio_send;
> +	ssi->capture.transfer =3D rz_ssi_pio_recv;
> +	ssi->playback.priv =3D ssi;
> +	ssi->capture.priv =3D ssi;
> +
> +	/* Error Interrupt */
> +	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
> +	if (ssi->irq_int < 0)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Unable to get SSI int_req IRQ\n");
> +
> +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
> +			       0, dev_name(&pdev->dev), ssi);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "irq request error (int_req)\n");
> +
> +	/* Tx and Rx interrupts (pio only) */
> +	ssi->irq_tx =3D platform_get_irq_byname(pdev, "dma_tx");
> +	if (ssi->irq_tx < 0)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Unable to get SSI dma_tx IRQ\n");
> +
> +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_tx, &rz_ssi_interrupt,
> 0,
> +			       dev_name(&pdev->dev), ssi);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "irq request error (dma_tx)\n");
> +
> +	ssi->irq_rx =3D platform_get_irq_byname(pdev, "dma_rx");
> +	if (ssi->irq_rx < 0)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Unable to get SSI dma_rx IRQ\n");
> +
> +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_rx, &rz_ssi_interrupt,
> 0,
> +			       dev_name(&pdev->dev), ssi);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "irq request error (dma_rx)\n");
> +
> +	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(ssi->rstc))
> +		return PTR_ERR(ssi->rstc);
> +
> +	reset_control_deassert(ssi->rstc);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_resume_and_get(&pdev->dev);
> +
> +	spin_lock_init(&ssi->lock);
> +	dev_set_drvdata(&pdev->dev, ssi);
> +	ret =3D devm_snd_soc_register_component(&pdev->dev,
> &rz_ssi_soc_component,
> +					      rz_ssi_soc_dai,
> +
> ARRAY_SIZE(rz_ssi_soc_dai));
> +	if (ret < 0) {
> +		pm_runtime_put(ssi->dev);
> +		pm_runtime_disable(ssi->dev);
> +		reset_control_assert(ssi->rstc);
> +		dev_err(&pdev->dev, "failed to register snd component\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int rz_ssi_remove(struct platform_device *pdev) {
> +	struct rz_ssi_priv *ssi =3D dev_get_drvdata(&pdev->dev);
> +
> +	pm_runtime_put(ssi->dev);
> +	pm_runtime_disable(ssi->dev);
> +	reset_control_assert(ssi->rstc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rz_ssi_of_match[] =3D {
> +	{ .compatible =3D "renesas,rz-ssi", },
> +	{/* Sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, rz_ssi_of_match);
> +
> +static struct platform_driver rz_ssi_driver =3D {
> +	.driver	=3D {
> +		.name	=3D "rz-ssi-pcm-audio",
> +		.of_match_table =3D rz_ssi_of_match,
> +	},
> +	.probe		=3D rz_ssi_probe,
> +	.remove		=3D rz_ssi_remove,
> +};
> +
> +module_platform_driver(rz_ssi_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Renesas RZ/G2L ASoC Serial Sound Interface
> +Driver"); MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> --
> 2.17.1

Best regards,
  Nobuhiro


