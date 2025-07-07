Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C1C8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:00:57 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.14])
 by mx.groups.io with SMTP id smtpd.web11.56051.1751878849493561415
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:00:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vD5l6jfG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYL44Yj1pdOZJ6aLOXAR3HPgihfZ7t4WUZp4v6TNwmOqrDhtcj5F9yrR8d4mx2sZDf7LciYwP/neRCQADSdFAZniIro15nGHng2+P5eI2ToLYoPeuaMHy6CYqe4qQaXgjSDccFQbTh1JZxkXOEFlMO1PuDvhJrxJXtyk3UPdP4K8PYYjK3ETTVqPzRxBe44jfjBMR77YmKAlljlXrURQTyCn+OWFBsGNtsECMyEzRNxrK3TDVZn49Zr6ohSFkPILWGvnQRq5+2TgesKL/TkQGbl27ILE8IeGIC3Zt0IuZB0ySQQpj+nQFI+VvvA50d0TYFwtzkzPWnDvr9TovMFpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O2Fnss4N1JGY74a9BUkWPV732SN4vpXw36KZ7145N8=;
 b=WUNyESK3g62MLHz3SimtAKnuNgYmkOG8GLj8OfcwV6fxlX6jmOpGewgNyGrhyDgN/6gcTc8AG3rouodsjs7NKZTVHtFqcfVwyilhu+pWUOBicDu0HeopUJvhgk0rfKzx9OoYigreO3ZRqQQTpW6ea+w6WJh2Y26jMXJj+adPIB15bi1Q67rpxuz8gTXw6Jzw5EsEE8qXlBs+ChEZDSUIhddf0xDTFayqOnaZDNeV+TGWhQvVEAsjKcJZaKGnbpxqf9KfOZTbmdYX77EDDHtTQ97RWeMmLCihvks5J8kMHlj/rY8mtOi7HfW8QcOEAFHxQOZA7LjHeeyIYus80X8aNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O2Fnss4N1JGY74a9BUkWPV732SN4vpXw36KZ7145N8=;
 b=vD5l6jfGXN3MCKP/RXL1FR93cRBTPUmBA65/CslxpqJ7Q8Pqbs12h5UMGWEGs0hLmiP8vJS9zPr8bE97NdnjEamhQjEg/sc9oBj0vx22v3iXwkVrcUWSG6zRky58X4Q9D/dRMeIxy293PNoYZazAcfGxQMszyfu5ilQMLeyxLTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSOPR01MB12395.jpnprd01.prod.outlook.com (2603:1096:604:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 09:00:42 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 09:00:42 +0000
Date: Mon, 7 Jul 2025 11:00:30 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp
CC: cip-dev@lists.cip-project.org, pavel@denx.de,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Message-ID: <aGuMrge1aBQ0Grtr@tom-desktop>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB14818CB81D68F62448BF2E546924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <TY7PR01MB14818CB81D68F62448BF2E546924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSOPR01MB12395:EE_
X-MS-Office365-Filtering-Correlation-Id: 462af409-242d-40a8-f1e4-08ddbd34c06d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RF+3jG3+SHCSkpv4eWOKBCFLDlSB21qunbRwYFnSb8G2229240hWbBNcz0K8?=
 =?us-ascii?Q?N6+bYrUMN0AluigIbmSN57HfKscO6RJd+c/shCZyVFkcqNrJ0NWm0o4ihZCs?=
 =?us-ascii?Q?rnPStcg7bCl5XwOXP+tvef2W+GK28NpshF6Q7TCF1Sy3MTFZ88sbamQcib4J?=
 =?us-ascii?Q?yIW7I3CtxHEpzchhK6QaY1Lg1MBt75miUntq9UEiUFUOJ9SYUr++Y8gQRSrf?=
 =?us-ascii?Q?Q3D8mrQ3innVKDR8Rd6ZRnLdBdYDw25q3l++EsCLXkY1ueI6tyB+C/4+fU0k?=
 =?us-ascii?Q?PbV/RWq0+emjWeygN0kz+4LR/3joTRba8HhAnNgL7tKO2eIcWN2rx7IUdLR6?=
 =?us-ascii?Q?nVlauP5HMn3ChvhRDKN2qdi27Ixy7ccm9zpvHeN6jZ5TA/nsfayAuGn9egBz?=
 =?us-ascii?Q?zjsMp7Y2hSVsmlGXA3D1Enkdv5MrAIo0BPAOLdwMX4gKe06r4P7psI84MjQM?=
 =?us-ascii?Q?ISC2lL5yRBqAtfjCXT680AGuiDndiHrJRWJyn4w1j7akAHbDRIeuak3yib8z?=
 =?us-ascii?Q?fgbJWSh+q7V4O4mNek5hv8kVXhogYsrKurdthMYHLIxUUoSqE3f+vcITetuD?=
 =?us-ascii?Q?84/5JXiHnvfLYSZpXvlK8AALPpbE/xZ/1DTmLKpy1MuiJe4TachXSN4M8Hws?=
 =?us-ascii?Q?960sFump2T95w+/O+vxhRPj1psW6mnzSk2dC5mE1rj6BTh7Wu/8vfs8VEuK9?=
 =?us-ascii?Q?v5LWq+9/4uQKG3+ROWBrT+pYST8sGaJgw07Eris5V+77SJAoc50zh2WyAtk2?=
 =?us-ascii?Q?nCaoqO3b13sA8TZPeVTf/vAlAk9cCkxz7c5S2KIdU2LCa7QfRyL2jxLMfdp/?=
 =?us-ascii?Q?YeMLzWn7FwNbKp8sOJ+HFpwfbImlFyU1f5IYPYe1xjMOUyR4nv0W2vB+m7zL?=
 =?us-ascii?Q?6zz/kmZCHr+huKFd42to/OaaQv6UY+AvA/DPE6nchjfwgpQ8JmOa45BqULJD?=
 =?us-ascii?Q?K+5OJfcxx6yJrJPfL7sFV1jd5Ce23eDQdMkLyRVMLfoVhA63laY4UKfjuH6R?=
 =?us-ascii?Q?8eouolgbsG2yoWr3QH0t2Md8dSw7rQV0FCTtTa6dTuunlBLmw/qM61XUrUER?=
 =?us-ascii?Q?DLIGgEHS35WOsSlB1PjdOmPJdccVrPcs/KI5sJB0Iq0LKf0HfQut2zZfvD9w?=
 =?us-ascii?Q?1iG+4U7j1dHRl7tq9c5d/kzflVITm1RFaHjIISj0FUnn+SABt8jEmo8m5muB?=
 =?us-ascii?Q?p9A4UcoccwVNe6tBZYdH5XwEjCX5jSg19RTt36YKIVGFYY/MoBKYOU8gv/54?=
 =?us-ascii?Q?vIbs+rFOVMr6OpE+uzZKPFGWp47xn10G7wSK0tq67+eXUsERv8gDwqTmFeLH?=
 =?us-ascii?Q?TbZ0Vh1bAbmDyBZNmbcdGb+cgPNNVrCnZ3KOP3Z7xTLq6Nfm59uG4XfdS1nx?=
 =?us-ascii?Q?+1aWvZkEmH+MO1NjFNvNiiCbfjqKBKlWwQtJrHSiwQEWq6fts254ploKd/VK?=
 =?us-ascii?Q?EYkc9swEJcmlaRegvltFnMzGlpaOGkaKiURbG+DSaeHHSaqRzGhxG0SL501w?=
 =?us-ascii?Q?FrnZMZmT1lP4ir8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aS0hKMSOSAtKs2wMXv9IEye5WCSz/oe/SaeMXR6qrH4U3X01TJC4TIDzuS9D?=
 =?us-ascii?Q?hqLc5oY8Zdti5atlDJ0sAOKSs2wpYudNQ6cqUK73K2M4jzYoTMfNCj6MySgF?=
 =?us-ascii?Q?1c0IgAlcV2i03qveLNq2rDDzQKjOnKuFBu1cprxQsHlMKO5IrDOuAzVxZnP7?=
 =?us-ascii?Q?/PzuFwKlBWcQ9NmJXAWy89pp2Ezt2TNa/me930dqg/jvJ5yxiWV8qE5Am401?=
 =?us-ascii?Q?T5Cx0ETbEQzTCHsgvllAa0NwhpYtMW7rStmVSgzq07668pSNO1BQ+lquoGyZ?=
 =?us-ascii?Q?H5okM2NSpX3Zruhjm3oUxKYLTRS8R+rg26doGfPAO7FGm4a/fED9C2KCvPfH?=
 =?us-ascii?Q?CJ+y3caKDkHDX6DnWrtjxJdw+HQ9aYGnJq/1YeeheYmsPmcobpKvSmNRr7/+?=
 =?us-ascii?Q?k0dfJr4M6RfAbY0xFdLVYSdCR0xV3zQwJy5I9F9VE2wbi0p3YigS/SYR0EBR?=
 =?us-ascii?Q?NJopLfhtLdKK9OUqHTz8qcsAu4BkvSE4ya5EQoslWpbpnW4rrj7ROoO63wbs?=
 =?us-ascii?Q?JuN03UAC9aAHlvPvRdzZKWF/7o39JHscAUSAaXJAHgYKQ1IFM6KjniWqmPES?=
 =?us-ascii?Q?S/d9zbc+P3HyKIWdtktCHmJXqWa6UjkkptDHekQzfimJzQw+wlWhaDmY60HH?=
 =?us-ascii?Q?adUleV7S/51TYle7A7AMzdpUpcm1gezzbDXWKU4O8PRWBqq7HzcxHe6MllCF?=
 =?us-ascii?Q?X++VrBbl8zomQRlmBLOmrGERI5IoWgBkLQsJg+7knYF803tTdAsHfjlHYBxR?=
 =?us-ascii?Q?HlOnlNc7zZJ97YRBT3G1dJbGe5F22076UBd0B0ApMCryo2u+WtRVQ8FzMX5W?=
 =?us-ascii?Q?So8C+rmJJwFS0pdcW9HaC4AXwymz4ku12aYAeldYYAaJjTnOeyD3yz5a1DGp?=
 =?us-ascii?Q?QlD9OuHEfGIz1AGv8tJPu0O7wh29OKVsV50ZpP8/NSVJGg4IMmNR7WUf+vGr?=
 =?us-ascii?Q?CTCmXsY7NdBZJ+AI5d5lS+jAs5K9CKpGRuMfw35wj/n/uJ89y+T8PkfawZVF?=
 =?us-ascii?Q?xCzRqe8qe+lxBD8o7ATWK40R4v6opcUCEGJN32wRvcKlYkAuMzy9sOcm4tyU?=
 =?us-ascii?Q?3EhPk++nZOyb/I4lQKVH9yzxyj5eTKrXmxmOnrdNn/L/dnPzUm+jIVLrZ38t?=
 =?us-ascii?Q?X3xlE2PDLsJbnRNEg+t1n7VRYCUwMgnduhnWagGXR9a8pMLlm87FefLBa26M?=
 =?us-ascii?Q?0d91FTW9j0XXEClNtVd0SkLEpKfBe1u4rplXtuyk8Ha9su7ll8urGsbjp8Ke?=
 =?us-ascii?Q?P1rKcLJd3MOSOVFEVJ2UbnpZEkCF77dGNU/mKXPVv44H6K+x9nJvXOqwWtFy?=
 =?us-ascii?Q?3fSnA7IJIWfruGMMVn4OxySRquViiIlLtQLureke29C7nFo09ZdxUKvyDEHT?=
 =?us-ascii?Q?yPEwos/gwvt06znhy/ZVql1JuU4zusw70wmAgBYJ2/PPNDwpnNxCjPjnzBmB?=
 =?us-ascii?Q?R2qog07ph5cxwOtwE+QAowAO90P+YvTIrhuDNCxbJlVaetN3xMadf24mcZld?=
 =?us-ascii?Q?MOhgZH+83ziBCS0kGRsQjNinhZaJSHBMH3WXadoG03HMOvmamHVhMOcphaXQ?=
 =?us-ascii?Q?5GAIPeh0kE95WnbDz9MeCOLlsFLYWUA2/EfFHpC2G/xuf1cQmv0I5Fw3dFXx?=
 =?us-ascii?Q?xcqV2txx3Uv2wo9DJ4lq8Xk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462af409-242d-40a8-f1e4-08ddbd34c06d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:00:42.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+DDVBxINM9bmOfQlKdfyO7tlUEIIsirJpL3Dg+iJYQdg2iGQ2IO5ieN4XJ/zhYcyaadRyOIhzyXsB++LkyeM5qDf5WE2vVVaxp+/9J90cAvBEXqgN3F0+qSSoCEo2KS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12395
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:00:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19369

Hi Nobuhiro,

On Mon, Jul 07, 2025 at 05:00:34AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp =
wrote:
> Hi all,
>=20
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: Friday, July 4, 2025 6:07 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE=
 =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B
> > =EF=BC=A3=EF=BC=B0=EF=BC=B4) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel =
Machek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> > Subject: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
> >=20
> > Dear All,
> >=20
> > This series adds support for the RZ/G3E ICU driver into linux 6.12.y-ci=
p.
> >=20
> > The ICU block on the RZ/G3E SoC is almost identical to the one found on=
 the
> > RZ/V2H SoC, with the following differences:
> >  - The TINT register base offset is 0x800 instead of zero.
> >  - The number of supported GPIO interrupts for TINT selection is 141
> >    instead of 86.
> >  - The pin index and TINT selection index are not in the 1:1 map
> >  - The number of TSSR registers is 16 instead of 8
> >  - Each TSSR register can program 2 TINTs instead of 4 TINTs
> >=20
> > This series applies on top of [1]
> >=20
> > [1]
> > https://patchwork.kernel.org/project/cip-dev/list/?series=3D978150&stat=
e=3D%2
> > A&archive=3Dboth
> >=20
> > Thanks & Regards,
> > Tommaso
> >=20
> > Biju Das (14):
> >   dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E
> >     SoC
> >   irqchip/renesas-rzv2h: Fix wrong variable usage in
> >     rzv2h_tint_set_type()
> >   irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
> >   irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
> >   irqchip/renesas-rzv2h: Use
> >     devm_reset_control_get_exclusive_deasserted()
> >   irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()
> >   irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
> >   irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
> >   irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
> >   irqchip/renesas-rzv2h: Update TSSR_TIEN macro
> >   irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
> >   irqchip/renesas-rzv2h: Add RZ/G3E support
> >   irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
> >   arm64: dts: renesas: r9a09g047: Add ICU node
> >=20
> > Fabrizio Castro (2):
> >   dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt
> >     Controller
> >   irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
> >=20
> > Philipp Zabel (2):
> >   reset: replace boolean parameters with flags parameter
> >   reset: Add devres helpers to request pre-deasserted reset controls
> >=20
> >  .../renesas,rzv2h-icu.yaml                    | 280 ++++++++
> >  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  90 +++
> >  drivers/irqchip/Kconfig                       |   7 +
> >  drivers/irqchip/Makefile                      |   1 +
> >  drivers/irqchip/irq-renesas-rzv2h.c           | 601
> > ++++++++++++++++++
> >  drivers/reset/core.c                          | 119 +++-
> >  drivers/soc/renesas/Kconfig                   |   1 +
> >  include/linux/reset.h                         | 274 ++++++--
> >  8 files changed, 1278 insertions(+), 95 deletions(-)  create mode 1006=
44
> > Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-ic=
u.y
> > aml
> >  create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c
> >=20
>=20
> I reviewed this series, looks good to me. I can apply, if there are no ot=
her comments and test was OK.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for your work!

Regards,
Tommaso

>=20
> Best regards,
>   Nobuhiro
>=20

