X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.121])
 by mx.groups.io with SMTP id smtpd.web12.31947.1641824206280473432
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 06:16:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=S9NN6x2J;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.121, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCcXm7Tj9Zouq26vkb12bZv6A4YbeiJlpQd71/SP60qwXLHyXYaDsEERl0R5nKuU/3VAIPkg3LmBw+dF0ZJUHl5r4+9Wq7QRoMKoeFGT1PXCT+TkDFGc4KKEdU1idbGem3WiSGXAEqX5W8dV4/FH2ssFE8n9jfHpomCE13oWzRRJOqs30vKtma0DLKR28xCf2ppH3tgaGHQLX4weP1eQdfOMss/QLKn20g7exPIXDR8np8iH4hJTlB58dmTCG3fPejdUc6eKSqtjK+7r68xKKxpcpb0qRhpgvPaR2aOrOLv3lbnL5hnS2VCZAaU8qn5LRScnI6MClbtsSicGlViXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0ozB7sdMotu0fJKmee31lzqHpizOGimM1KAty8DvPY=;
 b=YnbhCdvnAkfsusjSIVYzPBQmQ/sVl9Yl3oOhqDCd6k3lOJBrblym/mYSfxeuiLfxEiYhbuug5hkrljPms3wA8dPbmz7IkIWKrEM32mvQ44jSXkkjXFVLz2xOYh7X6jmDY89iZmecmPagf/7dDvvGYloaHBEeFOyo2iiOccmjHz4ChqWFnod+i+zjkp5zt/+80HL/27tCo0qHshLUZZrGi1yG4DPlkTqVyKGRR+eINx7HYXxS/YD8vaqbpCqFAbATJtVGxvuWLFrjguEajPQv8c19cTZtOIG5rhUonEVCPExobEL49vhLoi38WL0hPg8YYOFcya3ssym6vADboOct2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0ozB7sdMotu0fJKmee31lzqHpizOGimM1KAty8DvPY=;
 b=S9NN6x2J86W15j9/UilvN/k2YS24ac6c4Ty//2pRir7Q77oIFVGaD9huqjnwD3CfcWeE0hAhmq68wbkmC/eJrEKorSEMCLT5VyVcf48uXZn2SEGwfpa9FXQ07DxQJOssGF4dWCEoeeLzwmtCXtoPJXrUy3B2/Ao5KiVNOT+mv3M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB2551.jpnprd01.prod.outlook.com (2603:1096:604:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 14:16:41 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%7]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 14:16:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v2 5.10.y-cip 15/15] clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
Thread-Topic: [PATCH v2 5.10.y-cip 15/15] clk: renesas: r9a07g044: Mark
 IA55_CLK and DMAC_ACLK critical
Thread-Index: AQHYBhjINLunRuMl4U6oVL9ByYP9baxcSr0w
Date: Mon, 10 Jan 2022 14:16:41 +0000
Message-ID: 
 <OS0PR01MB5922EF302739734E1311CBF486509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110115348.14297-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110115348.14297-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3acca5c-96fc-456e-2754-08d9d443d2f0
x-ms-traffictypediagnostic: OSBPR01MB2551:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB2551C7E246CA6317E14B225D86509@OSBPR01MB2551.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 duUi6iNZjXn+8DRJyHmu+M1b8bQQvwZojgnN0GBbG9LE1C44vKFTvrNmIgsgbV8gtXxsVadOV9EEeccC/yq36utXc9NivI87rjOT8RtsskgHqaKzutIaZiMZoKMgLgNHH7fN1mqYDwlLq0xq9tjGwj9yejViZC1Su+Gs5iBhuFXrv4QSD9AhugHogwQbVLoHybGYJPb+sWkPsX/HsuE/F1MgA0oE6f+zWAYWkTVAXdG5+LJC5mAYV+dJVMdbfG3kNoQjxvs2M4ikywD0mow9jY9Dj8xNG+bM1GgVnItf1ywYURqL7rRxQuddYryFOm2WW1dazxybQv4gGYqDjGFCyG9QeXGbqQuf6wNtWrj3msAvACbRiqakUYtqZp7JgXlicKxBrzVZ4cs9EZOYyelgcI8xZS1xV5Rxe0yvAe9U5ji0JtBWntYVPx3pFc4jplMq4dF+X/BjMoEKmh0LeheZ4xMv2exUspyFTGAMb+P9OAMQHHYXXFWevA55yGfFnQKwzqo8CTyrvNxV6c80tBZ9HGzDg44VGS9iQFXnnpyI49gImFPZlq6P4W9CqFpGmbVTPlhquoszhg7aiOLquN2aX5ulYpepB9GWUlwkq+azczG/52faXBFFnn5w0twHwyCpqYFOz/IUVOrpoYyZuhf49O98s8BFiQMqeNaVagHKogu04NtL+Bxl6lYD+9MA0tJ6Q4UjL6+6EuK6dxa5R9iA93CGr89c4qhFlvFXeUnrzs/CqFDfpwe4Lh7H0oMmj1jGbowb+6KwoD18l++DNZYuh8iKeWF2pHlH2ut63aWFbbIH932QYz7UMhjsvKb2QhmoRYnvosDlVehMHWlA15PDLA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38100700002)(316002)(8936002)(26005)(45080400002)(33656002)(66446008)(122000001)(38070700005)(110136005)(53546011)(66476007)(6506007)(71200400001)(66946007)(5660300002)(64756008)(52536014)(76116006)(66556008)(86362001)(8676002)(7696005)(55016003)(83380400001)(9686003)(508600001)(966005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6Hb5v6plFvhyh72iYJ5WWZGPDVppieH86fJuVnZLRnS9rUb4vdG4uo4dzGDl?=
 =?us-ascii?Q?K0kis3iBxXi7Kwi/5+68VGyq2EWpW/WzZbR4VmQGqT0DGPPFmgnoyMefknHu?=
 =?us-ascii?Q?HxJFkWGT71oGotDsMX8fofcahBV37BymMqnR+N6TYS/O+KUneCbunN1MmJdU?=
 =?us-ascii?Q?RW1TH53glwKPY9qD7+NkKPFh5Bv2CHQKRkbANXU6/5wWeTEz0vnmJOnOJzPa?=
 =?us-ascii?Q?g4WSzBu0aWYPfJFV7bKJEetkqj/gc07DxPmIxsVR/jGRK+5Jzf8tc8M0cKwG?=
 =?us-ascii?Q?HPdNLbsFBjmF2iD3Q87+OeUcfk857B64WFfTrKvzUf3LALB4QDP6q9zz7k+h?=
 =?us-ascii?Q?Kfb8wzpqLVnjCfYrAVnrjXMxlp41SAXM+xlEdqi90f2uKB/KJnhukKq7ngwj?=
 =?us-ascii?Q?Ad0ElmOtACJ9wCZj0cxdVaQCBng4j35TIS+A79q0n6EU/0CB+6+tA9ateEER?=
 =?us-ascii?Q?f2gyoFxVYBHIgudguSfCLNiX3LWDfXQGrOV3kjBuK0164MYhQlYAY4SxoBXR?=
 =?us-ascii?Q?tMyJkxP5daVe9BG/uCOoI+9wxytgrtHg1Y5pNaA56RAYtZ7WNdN1yo/iyaXi?=
 =?us-ascii?Q?81BefbxPEr95Lh5kLV+zyZ0F/M9s9gRkGXwaF5QgoyJJPKbgaKCX59X1aNxB?=
 =?us-ascii?Q?JE0Sfl1TsPSROYrPYKNPLoeVzNLf58/HJjrU7y13EI0Q5EPc/ywn5TwFMinj?=
 =?us-ascii?Q?qJ0pgrdseQNUy6JnsfM4q3Kk/CQG8GYNpiBPuaJ3sMB9faBFsykpGiuWBr59?=
 =?us-ascii?Q?CmejPrT6132cTk+bUlgrc9RV0PWCZIIkB3+/nubgNUAp9A6YY/GUxgJrs+4s?=
 =?us-ascii?Q?C812/ee/i1bmhAFIXor2PRKYshzw6dWfsaXUHXHxos+pULawSOQKblQpOW2y?=
 =?us-ascii?Q?t0dWSdmXDXMnp6KijeNxhb/yRiDFKNMjY+Q473ALA5MNYolraPRo+gi3IRuM?=
 =?us-ascii?Q?Ym4k6VySGbvLIbewelpLRVEL9JJixv//mziTGmaGUyEsrYDABlT1IaaCYttN?=
 =?us-ascii?Q?iVUrlNit4OARL3oAhA5krPT+9cKfX936bab+PIE2fN+RCjbvmUQUGFN6Dgz4?=
 =?us-ascii?Q?mLRr9HkR01r51Phzn51PtRBNE1ChspDy43krq4jpN5SKu2J5Af5cpPgrPQdi?=
 =?us-ascii?Q?7f1+gsE0EK2Z23+iVhLxuVYuLaeXX/Jib0/swJki+McevNraCtxMb1aY35fp?=
 =?us-ascii?Q?wrfORW+zyM7isl+zTShZjVPiGItJZfl9WotkqpsOocNqLpPAWsxn9s8MvQia?=
 =?us-ascii?Q?FC4wO0rIbs81qGkz6eygyUJZdJeRbgNH3ICA9sk6IUfdHPrqB2ppEo4qcTey?=
 =?us-ascii?Q?BhKqBOxFKUQIrWD6pQVetJdMHkzXZZB51Ao73euSLgI7YQtD5yXgKro8nUtr?=
 =?us-ascii?Q?lpX16nJObeAxGKGCWue6uSBeHTz9lDNxLaH4xLQ1XENAOxWNaTB4MHApUbPD?=
 =?us-ascii?Q?IrwtiiL1IY59kG5NERIZwlpzjjazmLkfwuXhpBKsx9dEqj2Nw8t1+giukb4f?=
 =?us-ascii?Q?GkZRMbAb+7/nLk6r/6WgejeuV2DCU9cOJOsSmV3kuuBmm0fWOz0AHNF/SgF3?=
 =?us-ascii?Q?hX+qigkJeQ6m1bXQT5buxZJ367Yz4HjQC+vuJRlPiCYeOUSrf81dAOKo0VEf?=
 =?us-ascii?Q?/zN/Qf9kXLZXVMDrO1VCrhfqXU0wkdmW7Vm/PZcTMC0Z1Y76OVi9+aKkP1Cr?=
 =?us-ascii?Q?N9rMIw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3acca5c-96fc-456e-2754-08d9d443d2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 14:16:41.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VEJiSJeA9Lyu1Fl+G6uh5hStVYNbVMCukX8RgTFKtr1mw6o8m3bBqbcEaLAruG+4Bx3pxDO+WsknHFseVAvBhHDY/rXaBw54zUNjuwkg8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2551
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

Hi Pavel,

Is it possible to rearrange this patch before [1] and after [2]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commi=
t/?h=3Dlinux-5.10.y-cip&id=3Ddcbef66029571fbada7522b2db0790e5ff054c66

[2]https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit=
/?h=3Dlinux-5.10.y-cip&id=3De2568c0c7de565a5688544907422ca470844df87

Regards,
Biju

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: 10 January 2022 11:54
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH v2 5.10.y-cip 15/15] clk: renesas: r9a07g044: Mark
> IA55_CLK and DMAC_ACLK critical
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 664bb2e45b89cd8213e3c9772713323f75e21892 upstream.
>=20
> Add IA55_CLK and DMAC_ACLK as critical clocks.
>=20
> Previously it worked ok, because of a bug in clock status function and th=
e
> following patch in this series fixes the original bug.
>=20
> Fixes: c3e67ad6f5a2 ("dt-bindings: clock: r9a07g044-cpg: Update
> clock/reset definitions")
> Fixes: eb829e549ba6 ("clk: renesas: r9a07g044: Add DMAC clocks/resets")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ker
> nel.org%2Fr%2F20210922112405.26413-1-
> biju.das.jz%40bp.renesas.com&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesa=
s.c
> om%7Caeb9b6b957aa49e6f56908d9d42fe9c4%7C53d82571da1947e49cb4625a166a4a2a%=
7
> C0%7C0%7C637774124514054919%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
C
> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DwXeuDZQzz=
gtj
> OFIfHrsD4SATdusLeUJ6nbLvvxlnBt4%3D&amp;reserved=3D0
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/renesas/r9a07g044-cpg.c
> b/drivers/clk/renesas/r9a07g044-cpg.c
> index 4c94b94c4125..1490446985e2 100644
> --- a/drivers/clk/renesas/r9a07g044-cpg.c
> +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> @@ -186,6 +186,8 @@ static struct rzg2l_reset r9a07g044_resets[] =3D {
>=20
>  static const unsigned int r9a07g044_crit_mod_clks[] __initconst =3D {
>  	MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
> +	MOD_CLK_BASE + R9A07G044_IA55_CLK,
> +	MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
>  };
>=20
>  const struct rzg2l_cpg_info r9a07g044_cpg_info =3D {
> --
> 2.17.1


