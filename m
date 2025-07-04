Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5CDC83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.34])
 by mx.groups.io with SMTP id smtpd.web11.8445.1751619980896622719
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=AUUWH6EV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN2oOoQve8SzXdqWXS43pkq3S14ElxZ/KbaffVGdi7nIbQyGvhKeMy/FtOAOCQdffc4awc7X0Xtr8T9ldViof/1IlLhVZxO7543fkvshzV4a3NstgToQ9Sui+lbPvwO8WJpcOVO6eLTxabFQd5ghuTq9KWoW2frJg0UaSfjx/bgbByEUyBZ9Ka3a0CnmWUARfDMjv2iyLM32nITTVYLmtuP4XtuUFK/WOyuu0HKhvx4kaZbbqDuj1sT6t2HT29BwsjECCiwZphqJs5ksltnPbe9wSIk+InXEqgnZNIEMcVSdZ0Q2iYBpQMLHIX8RebCVHm3q6WUlBYkgr9tMmD0YEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNsgukJSY47NAhl0v0svR/eJ5emNBpE8xki+nmHQ2wI=;
 b=BKNmJdU18z8Rpj0J8qfL0Xvz1pfDMXv5nkOfSiXt/L3hzp3rK+M5cXCYgmmMU3+iiNJVHDh1q/fagb9iQQRD5wV7X3148erhMc2AZx82FtbTJrzcKVnX5CQLwdoi4pCn5vJX2O8tlb6gQgqBzlWUKYPJgiemk9tO+drx30bvxdqQCbq8hma0Oqil0kLQHyyOrkP4AZsst5/95Bvz5fm1XYhHtZyi41uu3jSlRJHXh7XOTfHTeGV22LQzc3sTeB5Pbg3F9fbJXlFrc61ATaP4uAQ0RGZohB7cAkdiqCZwGrjzCrrRRfUIqxhc8XtREr7aUezrcviSu53dRyNBcQMVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNsgukJSY47NAhl0v0svR/eJ5emNBpE8xki+nmHQ2wI=;
 b=AUUWH6EVZFwEk72JBiiotCz5L38sENl1pz5FeOwI4FhL3U+gsMZi4RreKzcbBQwP9UtWZBw6NVGZxUr0vqgV9HMCYBDQ9DWKvnL38UfvyimcysbASbFVwAz5at/KXC297gNYR/W2ZPEHCDC2tQJlMja4UKIFssw7p2CIvRbMZqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:16 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/14] Add Support for RZ/G3E ICU
Date: Fri,  4 Jul 2025 11:05:42 +0200
Message-ID: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: f589d24e-1b4d-4583-79a9-08ddbada0803
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y3iiSF8nHTShEL1PlAgOVNr7Sd9GtZqh0RvknFgFyZxESbQBjJT58WSH/JPJ?=
 =?us-ascii?Q?eSRktCl2Sf1wivgD430jpEE6Ok8wAain/AF5nl905Cs3oppuNCgjFS44AZZq?=
 =?us-ascii?Q?ISwUASKeof7FLkl+WB3G24k3VeFG3FN3tzD6hlol/hyq1aeWTtEVUsFBc8UJ?=
 =?us-ascii?Q?3/nC/LE60cWTN9cBC6BbwivYxja4kmqQ4OgA0ByxN6dXefG65s7mmQoqJ5V3?=
 =?us-ascii?Q?g1XkINNA58Av0XmDfAFBvzFi3f3+Eyh9zhTVnc8h5IsX+DUx7ib2bXi2aOci?=
 =?us-ascii?Q?mdpfjttjnaUF0Rk7Q/efnX4dPONQAkCIAqAIPJ8hMzhNB5YUb5RKSU/9hPhZ?=
 =?us-ascii?Q?RKBjJFQdmzs2sndDIKKXShhRmFQaUPr3MCcqHIaBVSYDZ64tMRC6KYX50zxM?=
 =?us-ascii?Q?HKFjQxJ23BNLrE8zVGC9DY6eQ8iueYlvF3K56cDVhColizENJFeJeLnMlLyg?=
 =?us-ascii?Q?KhX03ndla0crWw/iE8pWt7QSd4/5S1R1U/MTMXIb08FJn4g/Vdy7lbz1GcPP?=
 =?us-ascii?Q?aWUtV9gzOg74s+4ExbHV9dVjkoms9nNCA7vw5lQlBu3MjXq+dEDnfra0KBE0?=
 =?us-ascii?Q?lplI0vRLr4b0tK4tdgY9UIPSwyKPwqH7quh8aMnFqNAGqTZJ6OFaKTuigdnj?=
 =?us-ascii?Q?969HFMSniXnFEH0B7deY94s4cBKSutHV/3ZtOH0Gq6PJSYZfuxgorQNUNSX2?=
 =?us-ascii?Q?ZZ4E4f6A04kgZ7L6YRdgf2CZlwqqt3RKOb7zp3OdCIDQ2nEze9AUx9z+uUlP?=
 =?us-ascii?Q?9cgJd3OGzXbNYv+ZoZCkI/6xazL9BaMlXOkdYpWixnawJ3dew7m3BBV1kzpa?=
 =?us-ascii?Q?x1/bvac7UPEBKo5y0I3Mk0fNpp44zdE/U964ZhIBpusMZwXURyQdxHwQEMZ9?=
 =?us-ascii?Q?7K2P/WojGF2rSUFjD2fSx/j4OR29ys9s+OwWnnNYy7sG6+WQPa0PCqMUJe0u?=
 =?us-ascii?Q?4uom42+WNxNmpoBTvBTWJXjYRstScOvY7Sw4bhxLrWntMCXAHU4Xsvzm7SDe?=
 =?us-ascii?Q?NIRikJf3oBk0kJAbqVjkarEtWRzY2bxIWTGtD/ssB2YG/VD1uUOvX9AK679c?=
 =?us-ascii?Q?YSXJectSK5RHlpHRUPQmdH/+RgwRskO99RRDVVqGvUND8Cw4n8/t3tvU1IDg?=
 =?us-ascii?Q?sl5OMXWf6/6r6mUZC0y0JfY8nI87LfibCZYagPD0r/gCFlro98k00/dXUhd/?=
 =?us-ascii?Q?vQtsZq5jzqHiY5XAoyaPb65+SqAndiO6FdJtiVsxqk32OMKjqR7fd+vPtpIC?=
 =?us-ascii?Q?uhNClVeMnIebPQAa8BSSI4O6tqdwcQJlHdRVLJ4zoZUm6dJcPU8RfTc95jNB?=
 =?us-ascii?Q?EsgOZfS5YgaV7Hsrh48M4KiofRWe3EI3unb6PjEc1vPMvTwZcWd3ivvwzP5J?=
 =?us-ascii?Q?ao9tw+z8/hx8mWj4RIXHohhBwk1xJJv0YhiYa5mMy2N589nyX42eDmLEnlQl?=
 =?us-ascii?Q?IscAwYXtjjCkeIKilNjUkxk0XyRF6KcczTYVoeDKXUS9d6F8yJsw3J7pV9My?=
 =?us-ascii?Q?bzQWrkfMG9jicPI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H+E2g64t6RSZALTH4O8tho5YjaR0j8nfpoNRDhHKMfEk+oOaygdbEff7tae9?=
 =?us-ascii?Q?D435SZYlk/29PlWT8i9MB/tW2CCbW+u5V/Ci+bBkKTVckbo6rW3z34PW4ldM?=
 =?us-ascii?Q?DS9CABDi527cpoo6xRv1Rnne3BiVioi9cHuu2hSS64ITmbXsf7NifkaqyabP?=
 =?us-ascii?Q?B4Duffdqf+6lhIAJ8EEmJz5Kji7QNb3/TJE1yjAD7U09hDDaFbE+qvl9/dRV?=
 =?us-ascii?Q?q5gAk9zi+sQZ/ClIY2Du5IomWxfqj6NKnYMMSst8Iv5w0gCu3UCkVaMR9i/6?=
 =?us-ascii?Q?QXrLKNWMv/RZXYDE8ucQ8RzEt8Z235iBcdtM7XHpK561aOd8zCB/ZyYgDroe?=
 =?us-ascii?Q?dlNJ8J+YfD9Moz9n4mStjTlosMFRjTwpUPu1JnTrzh0hblsKlM2QQ000CMgI?=
 =?us-ascii?Q?rxI7yFCvgX2FMwFwifyIeQes0bx/MAvzlCbHuWDAZ4cawMg7z5fc5qpxQRHV?=
 =?us-ascii?Q?Hb4Er4uieNu5jpkndv9JI3rixbXKD+DKSC4UXPdUSP3V0oJcLP+dtOme95KE?=
 =?us-ascii?Q?HhU/WeyqzsoxUfUO0jwkgJpndKA6pFpZX9w8Vjk4Fc2kocVqcE3FfWP27GWk?=
 =?us-ascii?Q?yxLKbDdg6KAvbjEuQk1j7z+1znoglBpDOCcb7/RxVAplrZuQml83hIPx9J2B?=
 =?us-ascii?Q?Mkf87jL/PaqduWlhxZ+Gl9J0UFQ/1WGf5pepXsiPjkA8A7zlxiCjMzqEpmgX?=
 =?us-ascii?Q?7cIi6QVST46Z8KxuEaNBPyShhXuiIxCqOUYkd5YrAkep+mJXtK6sr84rX+Ry?=
 =?us-ascii?Q?ll12YRDFW1uEKC6Ew0NgRGx2yHv/pWji5tyI0u258NUXmEn0N5vmbtulsUfQ?=
 =?us-ascii?Q?wA5JH4uZiUNj7iSNce/06N8ekwcBfkB6Mz1PReH2u64rD5bxuWIMWgJrm1Td?=
 =?us-ascii?Q?wlLYvduzT/GcmpY2sMXT5Anb/Hb7kGJaO+dORq6eixk5iZQN7fkHbW/V2fGV?=
 =?us-ascii?Q?dH1Olwck9T2koUOU5ubGWgmw2VmWUXEUYsYFE5EjtNS1hEyFfPBYb7x0yGc8?=
 =?us-ascii?Q?lvNcpc53sD06AS4MvHilqjB3kWt4XGOQ1ix1OwuiCpkMlVg+hKJ1f4j3telb?=
 =?us-ascii?Q?wBc+uCIpdSXnB+Su+wnb9RgoXIVCNw0FomQOf7w59F+0OR4W7pH7CHkklCAU?=
 =?us-ascii?Q?ftge5CgVqcr/z2jJuW7WqN4moYvHhSRG/jDpFlGdObuEnarmy045PknMNGFx?=
 =?us-ascii?Q?ogbXws8jMb016CCxpXC3wx8Q3vX6zHfhouSm7+sJauiDcucbv4UooN5MPfWL?=
 =?us-ascii?Q?jdNM/ZpUwAiYXee9PVQJkTJREob7VYz44Rl7Q/Oc3u6vk8P+DzJTsXPG2Jjj?=
 =?us-ascii?Q?Kb57RIHrMjZQT0sehV64EIw4fWaqUdz2ZImpSAZ8EiuD9l8gQrGR7iVp2B6m?=
 =?us-ascii?Q?xMRGwHisoxRbH+GyXOPt5WDOwpxUJDdn0CsxNPSVVU9Ve6xjxSf7IWCaRjWj?=
 =?us-ascii?Q?urLil08TeeFnp/z0cJ5RvErYfTa7jKYttKkmF71eo5RxOJ1lsMma4yiabi/S?=
 =?us-ascii?Q?GwssXPs14DKV/vqYLWioAtyavugMvvUe9qGG1iKSfFPomrauJWNLmJmskxek?=
 =?us-ascii?Q?lSmTADYTIiWcPfbQuwkKDK0SeYNcDEaHQ4wCaG17knutXJQC80oI9VkoOO0c?=
 =?us-ascii?Q?UF+xTWboP10FGdFuAl/IqI0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f589d24e-1b4d-4583-79a9-08ddbada0803
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:16.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGx7Q5OhnpYZrj9v7XXQvHGsBwPGLvjHb2do1amEvvoIn1QpBhcqqR6OUrT+y6G7lqwnz6K9uxE4/XN7LtRiwjT7nD6x63PupFa5FR+D7JzLklvOBTwu+n1ZSsxaqRpn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19329

Dear All,

This series adds support for the RZ/G3E ICU driver into linux 6.1.y-cip.

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:
 - The TINT register base offset is 0x800 instead of zero.
 - The number of supported GPIO interrupts for TINT selection is 141
   instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

This series applies on top of [1]

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D978149&stat=
e=3D%2A&archive=3Dboth

Thanks & Regards,
Tommaso

Biju Das (12):
  dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E
    SoC
  irqchip/renesas-rzv2h: Fix wrong variable usage in
    rzv2h_tint_set_type()
  irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
  irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
  irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
  irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
  irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
  irqchip/renesas-rzv2h: Update TSSR_TIEN macro
  irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
  irqchip/renesas-rzv2h: Add RZ/G3E support
  irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
  arm64: dts: renesas: r9a09g047: Add ICU node

Fabrizio Castro (2):
  dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt
    Controller
  irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver

 .../renesas,rzv2h-icu.yaml                    | 280 ++++++++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  90 +++
 drivers/irqchip/Kconfig                       |   7 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-renesas-rzv2h.c           | 602 ++++++++++++++++++
 drivers/soc/renesas/Kconfig                   |   1 +
 6 files changed, 981 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
renesas,rzv2h-icu.yaml
 create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c

--=20
2.43.0


