Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1FC36014
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:40:41 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.45])
 by mx.groups.io with SMTP id smtpd.web11.15778.1743504039653733709
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:40:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=njmR3CGh;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.45, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2siEgurffJMoA6i2ayPrB0pAMb3lkuwez9W5RneXjHSbTW3P/ZmZdVxX4HJLuVWe0pPA+yiiIjyndq0rYwjFzQPbb/474fAnWq+XNjUlX84LKPkYgyL3u7aw2g+Daq0SJFUirqnCzOU/yexMCTfLFAwz30u1qhvrA7i4kWa2hyST2oHDJYPOaFmK9/f0dRfY61TaKTFTe/iuiMcVQWk4O+0LtgIW26ciLJnb1WzFB/1z9ONePLhGO7rUCHWPHII648aCGtP+VvagYSkU5567PAfWV5w4iSTjf9IevuqHMiVHcJn2tbuhcTUPxjuK4uVHjF4uKTiUR2h9BqXid3+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4tgNMbKJgeGP/OFeY5c/zaXmu+tarBxrL459YnlwME=;
 b=h664e7YSJCSaCqm9PRSqlT7lDI1ogHIKDvJ7EyjZdsXwLjHlmYjRB8vHYKnzAEvSNgiD5QvZzHUNBEcIkqfntxIkx73wVvzX92xpLlrqN9m4EXL0OzxJt+UIzn7o9sgXG2Fa8G1GW3zuzGpThgsSUZfBXdupV0tnE0TJR0FBr2gIn6sdWKocp9kWwkXzZZRLF1hOT5tda/W+BACB5pRlP/b0lqIYnXXSyae2C3B8vyw2Eh4zEIo7jAd07gSqSCAny4kXOq1L7LSjSFs5v+CfOkcsIsmgGI2KpB9ZQUJpEPNTuHf9ccoJ8B0vdgEqRQHk1Mdso6z7PLOvaG4XR+r1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4tgNMbKJgeGP/OFeY5c/zaXmu+tarBxrL459YnlwME=;
 b=njmR3CGh4Ozub0yKcfy+ESsJFvs8eICXJJKGugj3NgGw54EqVwZpFcUnW5phCcWbxPaLT6uSGZGwCJ6eDq8FkG++UCgsqco6iRPFGF6kc25IeYvjOuPwiKNSNOYGRrZ2g1h4dMmDBQkuTYPYUXpSARIPy23ATqcwQ7LNYKCgG4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14077.jpnprd01.prod.outlook.com (2603:1096:604:35e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Tue, 1 Apr
 2025 10:40:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 10:40:31 +0000
Date: Tue, 1 Apr 2025 12:40:22 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/13] Add RZ/G3E pinctrl support
Message-ID: <Z-vClkjiSVvSTQfh@tom-desktop>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
 <Z+vAGQRiwGV7SrKJ@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+vAGQRiwGV7SrKJ@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14077:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f99e79-069c-4635-6d18-08dd7109a00c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6y1tf2FHinVGr+p7HwcfoBNv0/6kYofzTKqTt7/afuQRNsZ15IKtbJilW6fK?=
 =?us-ascii?Q?pTt/s3lP1zkukUK1deFsSQ8vfba67F5pAjCxMLIoYW4zYUBzSDxJHGRl+YAD?=
 =?us-ascii?Q?+OBkKkjmzNpg2v2pzbqd/+kvHLFuzzlo/jOSDr4gTHDpu7i6atm48+42wn1D?=
 =?us-ascii?Q?nDBY7kARUaMKJC7RRCb2QSfeImvABqRCHb9FYTOoNaLrEE+wcaYhpNCPTfF/?=
 =?us-ascii?Q?pMekMsgH7STs0RvtG7I0VWQevWzaZ9NdVHgkO6iESwANHlZiFgWCADxMb55D?=
 =?us-ascii?Q?sRBgzza3mOSSHWy6ffYwcGKPWCr00J4yVhy4uBtlVWWFeX9WEk9BZZpfD3Ki?=
 =?us-ascii?Q?iUVp6kUM8GrYnnWw+UTQ7bQz8o7f8Csa4sMWzLFY6RDva5H9H/g9AwYgAFlg?=
 =?us-ascii?Q?jRoghCxcvmDlQ73x4DdLDFYBFlv15qSfSRh0SETGBg6t1BzcPg/tC2ObIHox?=
 =?us-ascii?Q?gaCcAn6e9W8WXS1SnCxBR4GOnV+LYMlgwqC4I6Xw9JyZxjWEM1VtvnMDrbKw?=
 =?us-ascii?Q?DOpWprlDRr8PHXoTOQUWELi7znDUxpOB4MQPJp8mYTX/JYFLdg/fmLaMkfLA?=
 =?us-ascii?Q?4xDqWaYB+pAeR3t4MPTNnupuiu39sDiSV/0tPYvhDnVXRSYFwNUmtdLyKr6y?=
 =?us-ascii?Q?g235OGbpVw5aDUENiz14VUhE3mf7rQRDy09ifwV1v3WngHFL1kO4zGMSFJWq?=
 =?us-ascii?Q?wd68x6zjoXYHmk3BMhJKqnmSCuctOI/DDlZDEB/UUBgbCFjg5rOjO1qYsnFN?=
 =?us-ascii?Q?ZDsTrzU2gsWibE5fUngJ6sz8sptP1ikJ0QhosFTAFdFykjEOpnpyf0nYxrne?=
 =?us-ascii?Q?Aspc6MmWdq5O5XX0ihr6pXoBdPZF6/uDnY29VaU82SHAl/jhA9I1W+5e9lP9?=
 =?us-ascii?Q?pleekpIFllvZuqOclIDG2ZI0shHyDRbPSkq+HFcZDNGA4fxTJvXq8gfzdGBF?=
 =?us-ascii?Q?d6Gbd9/UNFePUW1L4dxVGD6DWS1D8FObmbD3pGMqCxMqEPopRmzOALTfN6+F?=
 =?us-ascii?Q?JJlwQhX0PM+jadAfEZ8QAD11IKLkqjo+CxSHsJERGEprH5FfXRjyhrpjul18?=
 =?us-ascii?Q?BaCsEpXKhnCgov7GK6gHfsbe2nTHzqVKp6HDK33YOmkMJkKcttFt2+BIA+PG?=
 =?us-ascii?Q?xwmU+gkezsAl1U5qoNQ9x1l8pt475gqleoIqVnGgK3X82pnCkdc6iHTXZAiJ?=
 =?us-ascii?Q?yKHAe1WO2MF6fL4NjqgQGP0rtN515uelu4FPlaklAEJHlD7dvr+uh366d269?=
 =?us-ascii?Q?4OQvJTzNGzCXF8basXXJbJ6qWwZu0mfnm/wksrMQ3VUbgFv90r6HBBt8yNpf?=
 =?us-ascii?Q?DC0I0sffOvxTnlp1QI7FB0qV0uGfECw9qaz+nHnkGhiWjEbFqVDBuhJ7dyJt?=
 =?us-ascii?Q?uLsGsZP16Lc0aKerDuOpsCwWhrU/c2E5BLq56SYBHk5lQYz3IF97UbTbSTZ8?=
 =?us-ascii?Q?LOnqauav81l/FPDhadqV6wlpclxymKySEoIr06fqpbAGps0rULuYoA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8oQt9vmG+/2ONaiwGwRgvhAUDuwO2bwqyHCRz1MQsWwlYNry4zzBVvlzUJTS?=
 =?us-ascii?Q?Dv7MF3AUg5Nsd6h4oZjdqufvRjBwqk2CINxMb72PZ3JEhhIpGROAiA9N/dQw?=
 =?us-ascii?Q?Nwnf/FTPclrVYsgD3YV66mmMaPVF3d9ehGiYXKzggJPRQYPAAFVD0vGvZau6?=
 =?us-ascii?Q?YjFNhdw6GKG3ver1qCjk9ZdOaJrQqRhJSaZPOQoUSNWNxz5HCLVQJjYTaCMC?=
 =?us-ascii?Q?9lmtOMjWJm4gZqlDiY3nKEsCKpkE7LLR8RweqXY2Y/RyZemoAXKq5E8YZTAb?=
 =?us-ascii?Q?3xGVi4GUTjgQw0Qe2ctkK77Kd020gt242HpW49vhqz3lITl+yKqn5xKFhS6N?=
 =?us-ascii?Q?q5hri8z675bD6nNiHaRPgR0I7BNBr4ohN0dEDqWIl+jUOOyOgQgaGr21vhCm?=
 =?us-ascii?Q?BHaqLYz23Q9pdk+SOwDp8wsCuO4yM8RUD60cXuK0obg93QxleZR9mPaHfm2f?=
 =?us-ascii?Q?o2wqv0JuxkYncN2pU5TBoQHuBdEZX+L3HJaYs+Fu1S8rZwPkP9r3gLQTVt/F?=
 =?us-ascii?Q?GeivcsgAUOF8CJ2oOXVEHTyPBRXki5aQMomkHgGKska5K7+TH4A+Io3ZLKb2?=
 =?us-ascii?Q?i7DTxtoyPJ/WdjfNsBIXtJ31Le90WP0l7LZJQcoCYKWVzCnAmCgeDfmNosWD?=
 =?us-ascii?Q?5W5lEE7fvSDQqzGX2zbGtZv48yy0fnuVn3i0O8YPs/kXZ1ZpDV+ZnfR+z7gs?=
 =?us-ascii?Q?/opgrXGWUOoSVz0/+lccpIY8snBWW2dyeX6BUOH2oY7AgMHMCVlaE9rqJkaU?=
 =?us-ascii?Q?iErJZUiEdE2nQWt044Y/9Fi1p7WzaFupf8W+rmprBsVj/+mFixJ0rRI2jGKV?=
 =?us-ascii?Q?imZikZKT3qTnwlXdEsISCHV28cmz0NgYQDwLq0ZkbKjKLTTW838cbJWGM7WU?=
 =?us-ascii?Q?M6WDSkHjV+2gHjtOXoSNiaswQywaGMWDUGwmScOxJpxbsr0gW007slvLGZkL?=
 =?us-ascii?Q?O5TSGuozikKMxgvTg0vYfqV8gPCIj4XQJhdv3z8A4V4IJw/+1xqeDfi8lcF9?=
 =?us-ascii?Q?F8ZtF57d5sNUVl7/nGVmZWDvjCJ2DsryJp6mFZM6JiXQoMn5PsnG4LOCep4r?=
 =?us-ascii?Q?Dtgi1Zm9A8cMbFT2rAEBrXst2coBMgtYwwURqRmaEjq8fdnXUf4mdhV/mNZX?=
 =?us-ascii?Q?JoY9W+ZdWkZ1C3MqgX3XNG44STE9LokvoA/PS+Op3uFIFQ+/LnsPva/z7WjY?=
 =?us-ascii?Q?EYx2KpLHsLdrPYljofgwpdPTallvUqFYBd6VM5QvT9cCNTghiGoNI1vNEjT8?=
 =?us-ascii?Q?pPvUeMhkxg6HqR68PqcuXbRX1X+Gl7IJkX1bkCPkljku7qS6P9eYmrXhgYYc?=
 =?us-ascii?Q?zbR2PHZsQnjAw8JsJ44TlCoYeXFa1OCVwFNstUpbYkwXaAtEE60NOSeHfX7x?=
 =?us-ascii?Q?8J23+eIXU9AwNACzb+KYzrugCuoPNsuIjWLW7pqeSUgUzXwdk71v4GKdHONc?=
 =?us-ascii?Q?YPfGFp1bWJ/F60fBjOLneuiPQPz/DQBWFV3Gq7bJNCvlAa+y4R55F77MC1NL?=
 =?us-ascii?Q?ipGs0RMMdHueysWzT6pdkeTsRX5gI9TBnxRXS9v8zd3kGmYYTrvqAhjmTnC5?=
 =?us-ascii?Q?ciKm5Ha6JQnouEpd+VxjyXRX3LZrK7qzTRAv78BjSa986obBkRy3Jdo6ADve?=
 =?us-ascii?Q?Cjdp1ZNf3K59O/ZyMDg+Ejw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f99e79-069c-4635-6d18-08dd7109a00c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 10:40:31.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXqJFstAsSCKaUK9xuzhXUcG0q5+xsU79hK3cHk3NFyPCgFyKgwf+kn6KbDLcaFlMTt4GxW3lCb3xmf64V+y7U0g6wnd1NwJT5F4ks8+IEcGnNF01tH5qv6Pr+vU7zzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18452

Hi Pavel,
Thanks for your comment.

On Tue, Apr 01, 2025 at 12:29:45PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This patch series adds pin controller support for the Renesas RZ/G3E(R9A09G047)
> > SoC to linux-6.12.y-cip kernel, this series adds also device node for SCIF
> > pincontrol into RZ/G3E SMARC EVK board dts.
> > The RZ/G3E PFC (Pin Function Controller) is almost similar to the one found
> > into the RZ/V2H which is in turn similar to the one found into the RZ/G2L SoC,
> > for this reason pinctrl-rzg2l.c has been re-used.
> > 
> > All patches are cherry-picked from mainline kernel.
> 
> I believe 5/ was misapplied and is no longer neccessary.

Yes, sorry.

> 
> If it passes testing and there are no other comments, I can apply the
> series.

Thanks for the update!

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
Tommaso

