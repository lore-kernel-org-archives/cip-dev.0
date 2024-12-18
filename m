Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87470E77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 10:39:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.43])
 by mx.groups.io with SMTP id smtpd.web10.102396.1734518371012317233
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 02:39:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=EY6S1CsN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.43, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuLQjr3yzy38ip4BMeOAk0O8FiuT6hi88FI2DE3fE2JBsQVcbcuO6YOe3vq/0f+8nZFrb+DMHw/v4AWB/Xwn8f4AskAIlMzuulOJ+wxQxX53CDlZ+SoNVTb7vyTVC3I0ZZ24unNcCSuq8QE5eycIbKiBa7b+HRNQTLlDp1cg+lRI0Yuk4+jM0PjVIn3VR3W5kXPkcq4zu+ikg0PuwMzli4paghvI1laaLLWpoyc0FyJdRan9M+oZVJIJ5cYlfuRRysMVMXh0P90lT77tyVj8x6z6/QlwyrTKZ9Tyz/jBcwjW5wXnSHMRWxKVGGYdwyut729j5u7HTs7UPzlnHInUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd/OIYfYzDkMKv73HQttER8pvHmsQsPzrBX0qIn4FC4=;
 b=WWeSc0Lg/Z55PEjH4c9mAx/H4M02Y5B2M6gTyWwM1DJJVDZK/cEHXuXaNJHoQxk6XpAL9Wus+S9+RYhFSjfWZyJ+EFE9nDJlgGUMCwhjGh+JgNeTZI9AGdSFk0xRAgdpbPtUm94/5GCextgoLwx1rTA2wYEdtJZlzM0VCq1DEQRlbEaRLX9vEvvX6DRQderoNGjn0UdWuYvby2lGFHi+Z5dUs7vsNu8AQL+ezJrF1ITAL71u33iKWtz7F3B9BhZqOIqnsgNTnYS6FADR4atCMPHDsYnP+wu99GUAeWuugKGkGJMBBZwttdQ4nCTPnTIWm43WHe+26WpYfJtF+GNajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd/OIYfYzDkMKv73HQttER8pvHmsQsPzrBX0qIn4FC4=;
 b=EY6S1CsNOS9Seg9L5QVE9pEtaJLq4aKut2vofnl57TGjoyXpY0jqyoOWD7UfjWRQsQSUG5Dnr33Xk77UCPnRWEqPPrCGWQ2rFfQQevMkcDnSFQDzizlcpaVQSUXRtfE7IuvKI5s7/optOwJGX4qDG+fSWpldOU517DNjdUY+5mI=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB8691.jpnprd01.prod.outlook.com (2603:1096:400:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 10:39:26 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 10:39:26 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDIV
 clk
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
 FOUTPOSTDIV clk
Thread-Index: AQHbS/isN1RpgMbtP0GwjyqLJDZ/ubLr2iTw
Date: Wed, 18 Dec 2024 10:39:26 +0000
Message-ID: 
 <OSZPR01MB701902FE30A554F6C65B52F7AA052@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <181032168C715C4E.8579@lists.cip-project.org>
In-Reply-To: <181032168C715C4E.8579@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB8691:EE_
x-ms-office365-filtering-correlation-id: cd4f38cb-3642-4554-8172-08dd1f503e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?6uym4Zll5rV/BInT10C3EwZLBUKDtSslU0DIdblAai8xwGGmsiEZR60hJydp?=
 =?us-ascii?Q?K1MylJnNSrNTUCw5U2Iz0JwQaJ/xpJ1j5l7SZOv8aiIsj9sGaGZxU3GO//M7?=
 =?us-ascii?Q?M2I3BBKnj+2dOiimhN/ljl4KUViRjIOaA0nbOjp6Zp4xsX5T8Ol00GIWJvk2?=
 =?us-ascii?Q?NyiX87a9BHaeobqOf/2R4N9J1XDnfDTRnYFNJXO89dsqjRrytXYlzCQ8XRQo?=
 =?us-ascii?Q?Bp6CjUxKDD//axZ/tlvUkrkh1bFqjmVM8Xayq8gfg+sFvUv6pUfTi5oeQjc5?=
 =?us-ascii?Q?pnPFxoHaOcyYBl0wt9WHwgr/trF+2qQYSSslX+nIlSdQVaj0yKO0rTBzFXez?=
 =?us-ascii?Q?qvjrt+EWUR9Wn2Mapb6CkDF19KdDV46AF6yh1PjMRLDfSRDc4ABAbYIIhKHq?=
 =?us-ascii?Q?zFWWARX4HDj38RCOiQl83pv55ZQf3D6TqlBHDDOo2vxCCCFgxcu99Gkqc+Ye?=
 =?us-ascii?Q?JClKxnvbx3ddJaT/YihphDKsDcE0WEOcOf/up2ukf+UnkY3g7ITGeVKLjXzd?=
 =?us-ascii?Q?n95ReG8+yL1L037P55pFFhRpz6e5RqKKiwx5DSY8IATG2kyvzgaeoeZ2bj6Y?=
 =?us-ascii?Q?wabCBKvSV7vRqE6OAkjBIYSBlwaWwvXGiv+6nKhbTkOELoQ+2JvFmYiySFEC?=
 =?us-ascii?Q?IDTAfobv0xAE/4WvnATUWgWzlMjWTx6pl8l9jm+/eUGLWGLfj3q5vbAamtR8?=
 =?us-ascii?Q?mZFskvW2Gg5SRk9BQuR+4vaAiC0Q9+SDQ90xeMzqniJdFcoyC5Jist7mdlRo?=
 =?us-ascii?Q?9x/cKxO7heVc5TnDGNUfWOOw8Nkycl4yYUx95r3uS/4bcIa9jx/Kp4U6UNHI?=
 =?us-ascii?Q?uQYVFIsp1hFD6vg3RMEzQA+1c6GcXOSQxICP74EqGY8qGTUbrlVFHRbk7f1y?=
 =?us-ascii?Q?ut69sDZm6vxbtIXQT1yYBuQhia3NRLQ+F6Y8jLKhm9H75k7QKWcBqsIFQw26?=
 =?us-ascii?Q?cZ5fdjYDxAdcmaUnRPmVhZaLZxlTBSlrhA+7B8Ml0WJ/9qrFjKlIDlPayEBI?=
 =?us-ascii?Q?RZgz9QFKqxiaSsT4aG8mn6uC48XfP8gaR38uTG5LOoFgcJtabaZOXzochsuL?=
 =?us-ascii?Q?ANtkGUuRYHq/Z1sLNvJFShEurF2bo4/mfqTz3Vw9aru5scLrp2Y6RdwMK15a?=
 =?us-ascii?Q?yZ1MyrCSS4GmLp36AGsdnym6LKbLiVApVllnlcfHDO0Z/GGalZEyxR4Enj5F?=
 =?us-ascii?Q?/LUuKhYedO6JpW074r+PCwonQDcfPWymJM6f5TkxKp0k8lg4wad6ff5tAucE?=
 =?us-ascii?Q?tJUQd0qdCs93+BIP+qAWf4b7nFG9vMU19ziDUDTFp17H8szZQrHKbvm8L20o?=
 =?us-ascii?Q?CpWzLNqFHvjXymFXaLhlg5iPRn1h+b5rGlqFv7HPZns8qZozKPO2MqRiH1h/?=
 =?us-ascii?Q?TUuDmIVvKlUAShzdwQCF4y/RumofyhbhF4eZTutcwoHb042NUg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?q6CYsvxulsOm9alm20dXHbAvwlGPehLiXYFHorgpcU7Kg1qHiQ0E8VFcjIjO?=
 =?us-ascii?Q?M6NBp72jbWFPcRVrcQfcfnLB7s7t5oB4NfADU1TfyJy47qxkPbLpbNNkDpu0?=
 =?us-ascii?Q?HjyaAP7E0TQ1JxuGTn6A/gAo2/V4GCITZanryFjPyV6Wb84Eg0TOXU2UQ3wG?=
 =?us-ascii?Q?90gw3YMVtD/rh3f2B7/YPY8UVfLfa8EVpGw/bRJMr0qSpD8mCDoyopudUCTQ?=
 =?us-ascii?Q?oK/7p8x5iFC+sHS6NJ3gPFjovc/eJWzJT8lk/CYq4qAEx8OpgigNbIRHxlfP?=
 =?us-ascii?Q?opPrRgv28hCL0q+N5NbYRvMO21gh5aJrpyH5yIstQHJi2pRCwTrBPRTk/H7g?=
 =?us-ascii?Q?bw8z4QU6fQV9SwFFARzk72lrtoa6veXIsbyZxXiF3LZ8YQJWFhH1QNyURkMJ?=
 =?us-ascii?Q?sn9kaZxs5jlt+lySwX7hvBzxw5mcUdp8Fkr0NNwpi8Byb1XyUKKOAxVwCI5E?=
 =?us-ascii?Q?LtLYxeHYDEWyxthw4deocg5OhlssSxE/Z+tRARC08eS7qqPOkEngNRggFRtC?=
 =?us-ascii?Q?J8CAv54WS5s38ggEaFbnQfD5/azCwo8c/pg3Jz6JlQYUDmODRWHyw0TuhdQW?=
 =?us-ascii?Q?JTvr32heAUvjUGsNjP8eXL0uQVu2zKPIUSKny4y8sqsTxEcGqj3nwTGNZpIz?=
 =?us-ascii?Q?MQJJcau+54KuPzwkoTuav3jVcGEdJS0HqvVdy4auVY1eTcZe42O+pA86QCrZ?=
 =?us-ascii?Q?KrXtDrItnyefkyGGv1WX6442z1MbAjIpxAP8lJqtmZEmKa7N9zxoLylJqMUv?=
 =?us-ascii?Q?sXkJnmvUTVCvoV1lo5SMm+ZOVW0Nzc0aOb/olyBHRgyPO5YxO498pPxWcxM1?=
 =?us-ascii?Q?tw8hWx3gBDQ6/s9vE4JH4n20Bjb1QImRgNnPmgC4LyP/m6Vbcd6BHz7Ttg83?=
 =?us-ascii?Q?r+au1T7TRVlxTUnXYErCsSnoMcPzmA0W4+5pbqpIJ0E2fl3cqISdCs0UhF8J?=
 =?us-ascii?Q?eJ9n2aO8ml+4IkYBDCZi2NVbWOGY+v0vWetImtpA4tQ8UJNH+FgklLq2A5xu?=
 =?us-ascii?Q?yc+XNmxAsrM6h1wFK/cA/sqfZMVRk24D8PN4SL5ShlKeBqXtpdLwB3jmoSap?=
 =?us-ascii?Q?bY4qfUpGUyY6d1HsRB5YdooRLofcYrdBXJXzkSkxpTdEE9xeZHlCH9zD0ibQ?=
 =?us-ascii?Q?gHCIyc7F6Nwjp091n5UkPT2pNnnviOtB6aspzDoDpIqSwXTODUjGJRqeFMnK?=
 =?us-ascii?Q?uJDyHbz+GbLvWpQAge2O02GpjROTPe+zAYsxtIcg8eaW39vdPvJtIcOJtSim?=
 =?us-ascii?Q?05nDpHIxBk130iJhZPq6lLvogA4e9ERiomi/enyUie3eU9UX3j5MviFHmI9F?=
 =?us-ascii?Q?7JiUVY+bx+Gd6VyCHAiV18UD5CKu4L5TOpwcSgLjJ1qesam9NFknKUqBeYsq?=
 =?us-ascii?Q?3XzVOfuC+MUcS64VEViqzQn0aQI3pdMNOgxvqGJvvLIeJti0iWAXvnhrN4+T?=
 =?us-ascii?Q?VnB5SuGOci8EeZMN/SzqvWczNXyDsKwWXjJ8qGI6Vi71iBjXn6zIAHYE4SYH?=
 =?us-ascii?Q?IBHHcknDLssX0Lfr0EDLC0wXsHk9//0vuKBDM9fpPatftXsFakJpMTIaXN5E?=
 =?us-ascii?Q?FwwhB6VJTiCkyJrXiWRAFBvpHmm3QMaGLm581hX/pvA8KBtwTnwsx2rGJVEf?=
 =?us-ascii?Q?KE5IlvkoKN5hP0c7j+DQ2po=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4f38cb-3642-4554-8172-08dd1f503e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 10:39:26.3715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyJHDdw1fTY9ePfce4SUEWwX3H3Hl4SkaGTedmoL/Ma+VJcImAMy6jHGLKtNPVsK4yjFvqpEgzCOI4Ef7Q4d64cp7v1lqPQO5Y6m6AuycExryKKr/7/u8qgP7+UJ1PJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8691
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 10:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17443

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Lad Prabhakar via lists.cip-project.org
> Sent: 11 December 2024 18:15
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDI=
V
> clk
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit dabf72b85f298970e86891b5218459c17b57b26a upstream.
>=20
> While computing foutpostdiv_rate, the value of params->pl5_fracin is
> discarded, which results in the wrong refresh rate. Fix the formula for
> computing foutpostdiv_rate.
>=20
> Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/20241024134236.315289-1-
> biju.das.jz@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/clk/renesas/rzg2l-cpg.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
Gentle ping for review.

Cheers,
Prabhakar
=20
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-
> cpg.c index b1952d2ee8c2..379292eb6fb1 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -556,7 +556,7 @@ static unsigned long
> rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param *params,
>  			       unsigned long rate)
>  {
> -	unsigned long foutpostdiv_rate;
> +	unsigned long foutpostdiv_rate, foutvco_rate;
>=20
>  	params->pl5_intin =3D rate / MEGA;
>  	params->pl5_fracin =3D div_u64(((u64)rate % MEGA) << 24, MEGA); @@ -
> 565,10 +565,11 @@ rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param
> *params,
>  	params->pl5_postdiv2 =3D 1;
>  	params->pl5_spread =3D 0x16;
>=20
> -	foutpostdiv_rate =3D
> -		EXTAL_FREQ_IN_MEGA_HZ * MEGA / params->pl5_refdiv *
> -		((((params->pl5_intin << 24) + params->pl5_fracin)) >> 24) /
> -		(params->pl5_postdiv1 * params->pl5_postdiv2);
> +	foutvco_rate =3D div_u64(mul_u32_u32(EXTAL_FREQ_IN_MEGA_HZ * MEGA,
> +					   (params->pl5_intin << 24) + params-
> >pl5_fracin),
> +			       params->pl5_refdiv) >> 24;
> +	foutpostdiv_rate =3D DIV_ROUND_CLOSEST_ULL(foutvco_rate,
> +						 params->pl5_postdiv1 * params-
> >pl5_postdiv2);
>=20
>  	return foutpostdiv_rate;
>  }
> --
> 2.43.0


