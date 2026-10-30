Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9659.1793361302016759552
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 04:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=dUTb2/ck;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.14, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzU+hmSgWeawznNkYZowNhzaoS1zUU23mf2uiudalAnR2UPWfhe+AbpP7KLgnfwu3XekDdTppQUB6RdArejhlhzTxUdBQurC0VkqhqU9DrKwYzXY8kgDrocP+G/m+1JiQnubTTfQjVlNlc1i1jisG1Q16rnXngoFGfopkYg7wMkxZtJbEhz2x8103agKeKn1aGl9Qkr9/3KZkKjlBfCfVSkdFa1pT72xqblNwq3YbxWDxkCsnvnJGz/k1lZiNWulfJQQBC7328J+z5J8pIKTdr3lL5ngWnfn5i3cRT0C5ZjdrwS+ChpL+/nCPIyuMcjDFKBuMqg4zT42uktX4N9wvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEclO+VwNa05oKYeDUxDzFlnNyDc55Qip9DuIelJdSY=;
 b=q40l4fuWcMx7D03GNUJAr72LMapPQ75h/HyjMj2DqXUOXhcDAWCcxfHw6Lm6XhNsFfTlZGWO0nj0QuV9hU1+itdyBNspmvDjA14DECUwn+lUeDcXuclD7Nz650dX010bSWqfjb2MtWuAE6gAaPO1LKeeJ4gZYjLbRWeA8E9oPOZ27+zFaIL0ddrl1lSpSYzs/J0RtKFLTxercmO6QjqhyioLxYH+2E1PZOAGk4IgMX2gJd4mNe4jDUDTA+onVaX9Nqum8zu30+FRXnk2YLWHopNAffVZ/rPnHFLRIo/JQcz9zIZ8fGci+4hvTSxW28KuzwQOxRuLYv4A5lVb0R0dOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEclO+VwNa05oKYeDUxDzFlnNyDc55Qip9DuIelJdSY=;
 b=dUTb2/cksL+qnpsXNWM21T1Pwx0SWq+2vViUXSZjjKSELmUnYLrDK7nvWejWPODaM23j2xW5gN6EB2gGgt05HVLrvRMQQ3Ulp+cfnKjG1JT45N473iN1v2a7FgrjdlfPu7059uEz4z0yjKEzhDRNAVmb7hjVfGVSnwnmp2+0rIc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSRPR01MB11724.jpnprd01.prod.outlook.com (2603:1096:604:22d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:54:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:54:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"pavel@nabladev.com" <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, uli
	<uli@fpond.eu>
Subject: RE: [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore function
 parameter for suspend/resume
Thread-Topic: [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore function
 parameter for suspend/resume
Thread-Index: AQHdaDZpQMcgKSoNbUCVky+geQlr07cV+h/A
Date: Fri, 30 Oct 2026 11:54:55 +0000
Message-ID: <TY3PR01MB11346488446A3CD141D0F4877866D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <1793341067-15723-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
In-Reply-To: <1793341067-15723-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSRPR01MB11724:EE_
x-ms-office365-filtering-correlation-id: c63997a9-a5a0-475a-8f27-08df367c9d9b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|11063799006|261028144727099003|261021121427099003|10067099003|261022105027099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: 68xj/LNmFAMzdZAwcYegsmzdNarvJ9Yx8aYKMwb+OOYQFdBLvpSFmEwbzJ0lHh9NIfBdT7V1+xTmQSEXaJHyUqU7hiBnz2kNcdKGQG2xtRV3ugRIwCEqvX7ylWa8UAzKzb9tkzukl/ig79/zgI+Npu5R2pTh+ZvZ8MR04XKpGeyDsxOVuEIUSIjLsCjdbwcnnhfaMA+FqKiaaIJm/4QYMu4UqkxrgWwXrh9IOy+84pf4bVU/6LWkM4QFLyRsFf6qr9EWoyTNXVUXgJxuWCQzlbNGs2vkH18tQp9brAf3L5BQk8kKAQEQEmcMxEHA/cPoF0n2YDxxwGlbGo2RPydLiSZi7OYVhbTjGE8EeHuuoK3ELbvkJPT1pPEMszwLUApDn1LrRzE1XiPR78PC8gQa7D9PisuYSkBse8nO5Hqj3Zohf8PATHj2YL+6Yf7voVKJq5rVFTIKSBTDW8i7VmNCypHxtoGMRkOp7Rf3aZjMRksZUqXe11RMhq+IHEHM7IA+/YrT7MT32uTMzWdys+6iQ9uKt5ap0t4xJueVIK59onYgdvVroZy0MfL1xkoiZbzuJiPDRJlWq/Jz9ZBsHAcRv2KVf6uwaTNX6QTg97wtlnoo36Rp23yC5tf0ezodhrq0nlesR8z0bqwXPZQAYYAKJqSl0HcpVVLZWH4rSPDtiWsBX7Gds1Kt6PEYKXqkUEzS9S1yipA1bxcaf1Tqtg7ApxujqnU0zd8kSRtQDFoOje4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(10067099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wTm5udQ3LnOTOq/R+T9sp/7jv8xu96S9QyfA9Y2EOWhlR7Yam99NlmeT2w5U?=
 =?us-ascii?Q?Gqzom2wNNZdbaiAQPvlKyxn2/rLZz1pc+excrjLq4igHKFRvpnWUbuYZsv2a?=
 =?us-ascii?Q?Z9BMq0jV5/sV2MGdJAP2x8IwR4jGLoqu9QcRq4Ob4ZjSyjoVypeLfOyd8z3z?=
 =?us-ascii?Q?cEQt38K8xkeF6/uh6SfJd9sDCjJWIJjeQ9NPXRjzNPpJORCRiiSiTPKFmKVm?=
 =?us-ascii?Q?NuIdigMguqkgzYRpo6AKN58JNP6xUVyuNe7MTWmHXIbhJrUcpoKAuBT8D2vl?=
 =?us-ascii?Q?E8td63C0BN1bZb4q/AdAYpWGQCDOVaMnFLc9Br3fCTQOl0gnYPMjoyqZ+Rpw?=
 =?us-ascii?Q?E9DkXVHmsPamqNuFJqYH+xPAXl2mLIqKexaBhyXy2lMBbaK5dC/VIZiPemy0?=
 =?us-ascii?Q?UPtB4v2uyud7nX3K5QYdjnnVZTpyDgD/OXkT9pfjXqmf4QrvwCMm+KnscvTT?=
 =?us-ascii?Q?FPMRI+g661yksoDuEcQvUGsQEiOKPvecu2M6kWoGIjWBZMWeXHkWXCT585f0?=
 =?us-ascii?Q?NEqUPPBDJdhK6wRrh/sHjeKV3lHoGVi91fUp5X1St83uS4YIVSSHER7L+WNJ?=
 =?us-ascii?Q?X4bgVRQfligBmmlf5lCi68cIfjcu+h2tKQeDKJEdxqFPsQboncfZnaAxdTcF?=
 =?us-ascii?Q?oaFI9clgim+4E99eZajUmLhPoNGKh1F9XrlIaYTUvMKPmUQaRDoxhFbxisq3?=
 =?us-ascii?Q?fS/Fcp+Q7a7MuFbyS9H33Kiuy5zYP3olXbhsDXzgnkXRME4vlQ9PdAWD4z5V?=
 =?us-ascii?Q?Nbe8j1C16Nx6pc3cOxHkmLNEiYlswU1fiwFvGnwdIC52ny1gReQNhXFiR+fn?=
 =?us-ascii?Q?JoNqgllzN82GmE3CL3E01ib021v/vYuAuwOE+FCquUDIAT2AR5D5yBGnRMXN?=
 =?us-ascii?Q?1dET4AatJ4rut6O3By+RopGzFQ7jvyMX6zGbeu57b6NronuZ0LlZa+Q/9ddl?=
 =?us-ascii?Q?9gcPECt4L72GygJse4k0Z+QxBdN6Kc8y4n0WUjiw++JGSHKBOPQwMwde2v35?=
 =?us-ascii?Q?YhpJ4Wd2f/pE7FB5RtZsGaRD8r/2xPIjBJJ0XEHRET9R1yCt8B5YpInng7e/?=
 =?us-ascii?Q?6E+zUQzfLokfM0dl74biMZEfsZg6KjjogAGCjOGzZaqNxZ4Q/KAZiH88452u?=
 =?us-ascii?Q?xVl6FOIpZJNLHRMIFVMZXRwhDo2s17ln8wmtssy+asX8WAxaMzEByj9hWSoz?=
 =?us-ascii?Q?nn7+hsiop3bgVVRlWF5Y/DYaGbdGJlu82XT0gWf36wWOqtRXFEY6qudEvSXw?=
 =?us-ascii?Q?XgV0T58QYVU/jLIa5n0tptJui+/Y4w4lMgNIdNsc2wRqQ4jXl4hiUCyr9q94?=
 =?us-ascii?Q?JpHbbfWWIxMDgV73AODOV+gYemQG3EUMFmhtjR2DboGr1K1uVMLA4Umd4679?=
 =?us-ascii?Q?h+F9VMjXmro49IV1B1QDatBpuHI1qE5LDL34xQWFF0fVOFxrYWLz4QBjcXJG?=
 =?us-ascii?Q?pnv2DEYgju6JV+qPxoqTE5aMfaFlcCFONsTiqaq+yOho4uY4VM/m8YKadFbz?=
 =?us-ascii?Q?aQQPdYPBINn+hwXWW8r2Ledj0Uv7rOkCr5LY9yyNDJK/UnmchFh1pLyzzJTm?=
 =?us-ascii?Q?r9uOG+M7sOvl32Cjsco8sl9RKBrnQiNMr2P2yk8cfellFJ+znRWqE9QeDWf3?=
 =?us-ascii?Q?9zgGI5bUYJuyNU4VXT7ztNm8uyQp4pHpDNWHM655cpN/r/n3pA9TXb/fNLi0?=
 =?us-ascii?Q?1KhwC/GA+q05krZNlk4Fvw9gb1egqSG7PqYOIqvbjV5nG2NqP9/xgRgnTGlD?=
 =?us-ascii?Q?g9e3OyCFyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63997a9-a5a0-475a-8f27-08df367c9d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 11:54:55.7801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAP92iAHgPuIbiLsmQkdOzJJ26wWJdIrjVd6gITk1OLRsEGfoSGWveSdsOg5ERieegEnuH0D4vKxSYIS2ddkPF71PBnJLzLtVvrFmZNKLG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11724
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 11:55:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24586

Hi Nobuhiro-San,

> -----Original Message-----
> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> Sent: 30 October 2026 06:18
> Subject: [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore function param=
eter for suspend/resume
>=20
> Commit 20a4a45ee35f ("syscore: Pass context data to callbacks") modified =
the callback functionality in
> `syscore`. This commit also included updates to the relevant drivers; how=
ever, irqchip/renesas-rzv2h was
> not included in these changes and therefore requires its own fix.
> This restore function parameter for rzv2h_irqc_irq_{suspend,resume}(), an=
d use register_syscore() instead
> of register_syscore_ops().
>=20
> Fixes: f443abb80780 ("irqchip/renesas-rzv2h: Add suspend/resume support")
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

I will test this patch once it hit 6.12.y-cip.=20

Cheers,
Biju

> ---
>=20
> NOTE: This is an issue that occurs after merging v6.12.114.
>=20
>  drivers/irqchip/irq-renesas-rzv2h.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-re=
nesas-rzv2h.c
> index c12f7072f5cc..a5ef1b42380c 100644
> --- a/drivers/irqchip/irq-renesas-rzv2h.c
> +++ b/drivers/irqchip/irq-renesas-rzv2h.c
> @@ -508,7 +508,7 @@ static int rzv2h_icu_swpe_set_irqchip_state(struct ir=
q_data *d, enum irqchip_irq
>  	return 0;
>  }
>=20
> -static int rzv2h_irqc_irq_suspend(void)
> +static int rzv2h_irqc_irq_suspend(void *data)
>  {
>  	struct rzv2h_irqc_reg_cache *cache =3D &rzv2h_icu_data->cache;
>  	void __iomem *base =3D rzv2h_icu_data->base; @@ -521,7 +521,7 @@ static=
 int
> rzv2h_irqc_irq_suspend(void)
>  	return 0;
>  }
>=20
> -static void rzv2h_irqc_irq_resume(void)
> +static void rzv2h_irqc_irq_resume(void *data)
>  {
>  	struct rzv2h_irqc_reg_cache *cache =3D &rzv2h_icu_data->cache;
>  	void __iomem *base =3D rzv2h_icu_data->base; @@ -537,11 +537,16 @@ stat=
ic void
> rzv2h_irqc_irq_resume(void)
>  	writel_relaxed(cache->nitsr, base + ICU_NITSR);  }
>=20
> -static struct syscore_ops rzv2h_irqc_syscore_ops =3D {
> +static const struct syscore_ops rzv2h_irqc_syscore_ops =3D {
>  	.suspend	=3D rzv2h_irqc_irq_suspend,
>  	.resume		=3D rzv2h_irqc_irq_resume,
>  };
>=20
> +
> +static struct syscore rzv2h_irqc_syscore =3D {
> +	.ops =3D &rzv2h_irqc_syscore_ops,
> +};
> +
>  static const struct irq_chip rzv2h_icu_tint_chip =3D {
>  	.name			=3D "rzv2h-icu",
>  	.irq_eoi		=3D rzv2h_icu_tint_eoi,
> @@ -873,7 +878,7 @@ static int rzv2h_icu_init_common(struct device_node *=
node, struct device_node *p
>=20
>  	rzv2h_icu_data->info =3D hw_info;
>=20
> -	register_syscore_ops(&rzv2h_irqc_syscore_ops);
> +	register_syscore(&rzv2h_irqc_syscore);
>=20
>  	ret =3D rzv2h_icu_setup_irqs(pdev, irq_domain);
>  	if (ret)
> --
> 2.55.0
>=20

