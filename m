Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F54DC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 10:59:24 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.web11.11374.1741949952627758035
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 03:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=EYKL+5EB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnvFWuy0OzsauxQtsc38nPpMKlNiWr2P+znHZugyOaqEDvDqHk6GzhEHV9QqvqcmFF9uowYvNVHMYp3dUYvPbmP9RIlitk9dYTcbfmjpQbAMqNM0vQQLI3FYGIt5QWipovbKvm1a6i6PIz9QV650syaMRHjjLFQiwOSJGlu5HyqiYFlMpI20/f3ryL+aun5zG4VsPgHsu0aATiVBeL3XaM/vxzjH7WHGWTIvm2UxgVnvf4Uai1U5fciOkJ6AHxcePb6QLMOUXEuLK3RUlbwnz88Iofg2pHjHXINp1Zg8WofR0u6ZkcReBloI+Kygm1n0ySIjAR5nFHXQxdHPGJwNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoWDGYaEI4RYH7k4SjRDWbwvBFEZLVFjxjGQEQvp2PM=;
 b=rZPrxh7KCIUyYrjrsEOm43lZRCF9NFkDUBxZEYmlkL597LDeWxiCF3uP53x2UEz8Ny2v0ZgDWpv18jzPzINNNjI7fxvMZKGYUSe9Kupdwk+vsbHLJkAtIfK/ktoOgpchiaiBS5mscLc+TFwdWTlzFUo4nKqcyGAfL/V9o7lgmgT/bEdQ54EbXGFQ3Y06CbE7z9elL6x2nMzuEzKWkz9x5pfarYF00EQiDSZAx4pfT8ZxhYcsv/QkwAA9GfBpJfaW2/ldK9VwRaivvjDocsVICvGmBDon1rm+MTZoAsZNsb858/ckjwJ/rCVhhulEjAQaFRgy5qYD0/IsFu9O0cIK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoWDGYaEI4RYH7k4SjRDWbwvBFEZLVFjxjGQEQvp2PM=;
 b=EYKL+5EBzDzbpmiCCC4nNZtaeyumjjbJPTdywYOaXjLLOlD3dSVydvn1818eJvDw3k4HQKFVgfm1vKuIbOcCzdmna0fs1cn7a7gg8nSgctRAlrntJ90RGp1C4wXvd+EypB2mJFE/NAhqHm7Z8qq1c72NAOXAKdAXhlDptTNmR0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB10339.jpnprd01.prod.outlook.com (2603:1096:400:253::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 10:59:08 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.024; Fri, 14 Mar 2025
 10:59:08 +0000
Date: Fri, 14 Mar 2025 11:58:50 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 21/85] soc: renesas: Add RZ/G3E (R9A09G047)
 config option
Message-ID: <Z9QL1CDHG0lZ7DTa@tom-desktop>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-22-tommaso.merciai.xr@bp.renesas.com>
 <Z9QELAp5qdsDUqkX@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9QELAp5qdsDUqkX@duo.ucw.cz>
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB10339:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e41aefd-360e-47e9-c753-08dd62e73e92
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pmT0VnM8DhRHTll/bua/SCn4S5MMaaZZGDH8POcKY7xad0T/cEwmuTXEh1Ma?=
 =?us-ascii?Q?vuwI2pUAHyOk9+pE7nWaLqhLqBszBm7QlO2h3jQbdJCG5Be0PPNq3GQCfXMz?=
 =?us-ascii?Q?aSTsqU6l43fzwaJM93T3A6OsX4krnylumobzxIahRgk8DUBpKvRS4ZEYrn6r?=
 =?us-ascii?Q?3/TKGVTuOE4asbmhbE7/XuMq1U9GCpHm0AtQ3K46Iz8q+ZjpW0mhVz0MPrAX?=
 =?us-ascii?Q?IoCp3HHb0Lr5ezfymFJSnL49b83UeblK8rZeZbWi+WIhaa+qOaBGR411tCVd?=
 =?us-ascii?Q?oSNQGEoLxtWx3IldC8W1vcyuyUngod5SZpywwQo6qRwamCmiOH4VyOmcO9ZY?=
 =?us-ascii?Q?IHg1a9g5Er/2IR28DFa80CyvMNe8U9TtW1buCoeM/4WRvSHVl4NqdWDmmzbD?=
 =?us-ascii?Q?hC4eTqgbj5t18jT4GYnCvVaqOM++bW5ARFRFFXTrRls+UkhCi5PMP4z1Ys9t?=
 =?us-ascii?Q?GTHpRRy4vL24dqyer9zA8SJOMbchGARI18rIGkrxtg9L2gO4z5Qi4sIAWFko?=
 =?us-ascii?Q?vcLoH9NSEYdWEaF9oq8EaALa3rKdn+LD8dMt4vMdHJhsBbvnBn8rCydheqAF?=
 =?us-ascii?Q?VtVoqO7GmjeyJycDi/LDF2jujwAvxlm3WD+smO0IVZZMKrxn6pRR8Sfc9fSs?=
 =?us-ascii?Q?qc+g9MJRQEYTWnQy0dVBf+6nNp/TBWtKxktpU+flv8iEqPf8Mn1p3/D1y8hc?=
 =?us-ascii?Q?ivqbZ1ruNYARW8OjIblBP9GbD7XlfHgHfjPqhvAg2zq3ylg1p2eMHrg3WziX?=
 =?us-ascii?Q?/P5uM6yWfx0DFK+LufjF/78yDyp79MkcHGEDkeMfkodLOfNupVRfVZ5jA8Se?=
 =?us-ascii?Q?cZzLIc5LZYXSJxtq4WnEkqNDRN1HmifirUiGX7TD8gqiNQ96sURB6oucSrGy?=
 =?us-ascii?Q?s7cQDfZO7UPeEiOxzuATbFbVtVmouCScLboyarNs9SfEE2r+DFWifxkFkVLI?=
 =?us-ascii?Q?ugnzyGdmga+r2BYTmqYC5b+lI1shjjSRlPchGD8u0uDm3Z1QjUtpK5bzXZ3m?=
 =?us-ascii?Q?Svrg81BFI6WRyjg5hntw/pmmyWhWhOTnhbhQEX64Zc/5m+WkEbhpcf3Yj4/R?=
 =?us-ascii?Q?WLUnJgHc/4kWEPje7lKCSHBTdrtRNDGTXWXWPjJrC+Y5AlqoJtlwXZJfGZnd?=
 =?us-ascii?Q?nXVUNyZ75X/MPemw0EVjjbkEbzEKs5QaW34uJ4n2G0LV4cH8/sCQ18g/Avku?=
 =?us-ascii?Q?lfhgU0uBwlqMwcpxJ24fgqSBar/nI6p0wAMhrdlkoOOaIeTdoaRUiL6QKhC0?=
 =?us-ascii?Q?BBT3M8v3vJ0cpYuz9wZGVp+Nmy5wBM25WsTzbkBDaewCi2nIJP4PeH7L8Vhg?=
 =?us-ascii?Q?YhkHhEvCHctQkqxZm2roPAjf1spTF4gH3W4n1ddRuQRQFv/6QZSAAvFmHW2o?=
 =?us-ascii?Q?8AnD4NVeUUFCOd7E0GFPRIx5PfTfv9O7fGxP1sJZ83xXjnZ6KAhahdSHAJxC?=
 =?us-ascii?Q?BqXYLuwgHJa6T/Wd3w3/xqvayP8kjzRy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OudhemfmY7WytdEdR4WqbEvne/OuQ4XkY2BdD9Z3I+P0sXSjFh5m45zSuHZ7?=
 =?us-ascii?Q?2NIQvyYtnHG0sTj6/fdcgiv/5SInjhYyXVoX9ehY/aGWJlh123yNcgkUIIU8?=
 =?us-ascii?Q?+2rO+wBNlvGg2lfN/XpqzwpvoX4+Orp1OKJTasHFEIDC+tZpAhc06Y9lNQ/w?=
 =?us-ascii?Q?R8zQtWnLnlPna8aZ5TEzoZ4G4KYqpKRRUjH4mx93S03U/G6L41aiEZ6jTiGM?=
 =?us-ascii?Q?5H2eVhd8N61o/bqU3ELnTrGMxmT7UKPCEEVXqAdsfIV9s9BZ/K6A3luJgUSY?=
 =?us-ascii?Q?drlVaXtnyr7yuTZstOl0Wibru9RKZ6bWXUDhVPHG/798iqycQdFL8/Tr24J9?=
 =?us-ascii?Q?mdESBKlrRoF8NIHIhqGHBp+Ud+s1Y8tBv0j9/yEuvt1q4HUluLoTEjqdhPgr?=
 =?us-ascii?Q?mHGQUWdarckl0oqDim5eEgaJvm6GfIVP1DrLhclP8Up/ubYHdD46i4C90z9a?=
 =?us-ascii?Q?y+8btSFGQJ9RB1OJa7yQd4Bdd6Vype5moJCafriJHhq+kt2VytNbNhq9gFgn?=
 =?us-ascii?Q?ksbhy/cMrtgUf1m5HbG8+Ctxs+0RVE1yhpl36t5bmxSjl4FgYHDbk9pKKKyN?=
 =?us-ascii?Q?coh0hZa2e1Pd3o7blwHv1qXpAaUECX/9ZaqG9MeSgrWFOCR3P69cFn8DgLHE?=
 =?us-ascii?Q?E8qIyiqU9Rz33F0cE2WyZj+qXOIPsoGh6JVaby9TR9ZKKXgXOhmlK3+zHz7Z?=
 =?us-ascii?Q?hnjKHzCMlEBiL4UavjJ7YYXvPBePvcHkyV5uq2K2CwyAXmG4ltzy8q4icgrg?=
 =?us-ascii?Q?A2gzHCiV+7x3FVYPsznhGK5ha09TVWPh6Zrkc5KiVlIy55zPrUEseix+Y1zS?=
 =?us-ascii?Q?WQHv2/jXhUhkXgnh+yv6d1eXN526nbG3wzPsb8c4S8LJPfKpmz4x8Dtjlw7W?=
 =?us-ascii?Q?wG9xohOpHxtvHTeoHK8JuJ+JvDGinn/PAmKv3bZoFme2rYbPUjErC7c6a9ay?=
 =?us-ascii?Q?Y+6Oq89bAKdi9AeXMngvDo6ITUu96PF6YLJnsszD+oVCyTtjStl0byJ7o+8/?=
 =?us-ascii?Q?hVP/iW1b8ZwAxeiShIK2MkC782XONyd3+sA3AuesXhr62yA4+d7uRzZ+Wkbn?=
 =?us-ascii?Q?FVF0EKJrD3BLlGvAHPoWSW8FjkCftg1pctscCks2AYxqpBZy1c8a3JA31kY4?=
 =?us-ascii?Q?J5/nxnRetYiqgcUkkHl3qW5x0muirMUovkF06+2SFDMwdUQXvtWqZeR7KNxg?=
 =?us-ascii?Q?cpvGWovB3IOYggPyyVTqgevPoBBf3eGVB3d+ijqDsL0p8QYS6FFqjnJ0PBf1?=
 =?us-ascii?Q?0w9Wbpj8Tz73GKq8Odh9cWF5ZP34vXTT13k92epSnMeJHLqddVUsUEU9Waw9?=
 =?us-ascii?Q?AoKYCU9r2Rg0Djn6SwIGmEBKIPPy6qGJxLWO9M5wVNorSr9otSHhEfqiGzhI?=
 =?us-ascii?Q?myu39t/B6F8O9ro4j1zw6bVzruxLXI+7YpPzyA6JLIM2OVrVjjGiho0w5+XD?=
 =?us-ascii?Q?Yjk2bDCWX728kh4C5nRVAxkU9fsIPJnrc9FXxk6TQY1AIboHVu1EZersjCOu?=
 =?us-ascii?Q?J3eLhC82k+kIvfz9J9hd27zyUhwH28H5uvWYoWJ+cLwbQw5HBxppJLOv5/sv?=
 =?us-ascii?Q?P552F3niUa2+CCaOmNEeFRuoo3U3HztsMxa48M1SYc0nrFZkNrsk3pBEqzSu?=
 =?us-ascii?Q?e0CQDeLReXA9kP3LE3q3a2A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e41aefd-360e-47e9-c753-08dd62e73e92
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 10:59:08.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYtCHrGpvECnPnrQmS++amOzfe/N5We6mYHTrKp0mwGgOuB+J/+8LkyWtWrF11pRLMcTddJD8yfOzCKkclfQxbLTZKJeWikNsV62ZCITEKfLw6I7U2HLkaA9qcgwdPXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10339
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 10:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18212

Hi Pavel,

Thanks for your review.

On Fri, Mar 14, 2025 at 11:25:48AM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > 
> > commit 	12e0bd600e3c2f33f9db0e3b91f6b8d8d95b7dbe upstream.
> 
> There's strange whitespace between "commit" and hash.

Ouch.
Will fix that, thanks.

> 
> > Add a configuration option for the RZ/G3E SoC.
> 
> But what I wanted to say is that this seems like good place where to
> split the series. If you are enabling it, it should already be
> booting.

Fully agree, thanks.
At this point we can boot using initramfs.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
Tommaso.


