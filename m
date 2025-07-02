Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E28EC83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:43 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.17])
 by mx.groups.io with SMTP id smtpd.web11.20585.1751452654129427249
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PAGEvYvl;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFQ7IrLc6P04o+SyaMqt26xTV7d3MMjy06kuA+MsRhUiSbzBh1RwgjjvhGEqikbxHvWYU8TiCVbSAA54AWHri/TqPjXbU5ngoAgKQso4aJxPMAZM8OxTLkceJpwTziQGmBb4omXhmOoclpHZfsiNvJUcQOwY/RY09Yf2v4BvYawVtAs3BJmQgD0MU+9jGjfZKqPtA4lnX4uzcjhkd5tHsmUGy+u2z50LefxDgXCphpDxdBxAJfHCyRM3VSW1mKxM/kKLNJSfeMkt2FipE9eCdSY8O7dWNHEajsEbqlCFmsS3n3mVREZNctqD16q06sX2MalAJ68tSJsjbeq9Y5WQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXag+CBNTgKy4DgyNhXQwfeBCzqB9bs1KdkQB1hG6LI=;
 b=xtcPqV0ELTRpD3rUg5fNVEx9SoBze5uJUnPw3/tSnaT6uFcw1qxxVU2zPK1ohF43PMfu7eZ4hcRkiZ9ST7S0pKR8YbqEefRr5cR37bc4CDYOTYiAley3eEYIVQAxqU6ub5/FX2HhL5C74Lh89FLjJjXAkzarEXIo1ttUNiSvDceU8FmOAI2Osz9iKOwtAsSP6GuMYpUCIK6zKO7pnba2hQzif/z0h/m8CZHXsljnoPSUlXa/YLHvaXfMstQSJfL9U7PtibTKTRJN4Ghgh+aNr6SLUhMo16C+tTiNnZIphRBq/++YLG8sBTbLiSoiVQguqTtGxoChd7RpKA9LJmRejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXag+CBNTgKy4DgyNhXQwfeBCzqB9bs1KdkQB1hG6LI=;
 b=PAGEvYvlwrlizYRJKsSCVAdUegKzaNqJr1ISIABmHM50BYSD94eBeqNF+qY64yds5dN9zjbvJQNyzt/O/C943BCA8HIslf9iljkA2MbVx+ckXYN9cqlFmF7nnPmd+iLFHN0Bhw70Mh3ROD4APbxzmgyLaY0XK4UA7ANO1rIgvXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13822.jpnprd01.prod.outlook.com (2603:1096:405:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 10:37:30 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Date: Wed,  2 Jul 2025 12:36:58 +0200
Message-ID: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13822:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bf58d2-62c9-484c-b2dc-08ddb9547215
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JEmjdTtWQE/RWv45IGzb5qxPuF8PezNG+x+XwCV51dUz0IdyZkqgsBzZu4wF?=
 =?us-ascii?Q?LcJHBYLLQfcwvnJFfFQraKFrsC5894EfrQsHS6vQyA45v24DW4wY+z1yGp09?=
 =?us-ascii?Q?/g4oIY4AAO5JitwXspfSh8Z0rLCe0kFerowf7XDFSMbXEuR5nqrKLzD5DCGQ?=
 =?us-ascii?Q?kcpqSKnwbAKjenyuqw0DBQcBy68zKeWbmSivSMNggTjK+kmLWLuZTXN0EC0P?=
 =?us-ascii?Q?2Ljln4a9KsF22EG9FxtHhlDEvKqaSCEXAI2SGHUyECsWxbrckuNtCd9ePO8Q?=
 =?us-ascii?Q?aM5LVjxSM+8sJ+ljiLkx1jZJXnwHf18CipDSPk/PQCd4HRDs1yf2F9NOoLx8?=
 =?us-ascii?Q?rCsxx+lQaOqPIHuJ0uGKVlw0gPIn5v5BeifvbIGBsd6h+jR6th0TT0OlDqj7?=
 =?us-ascii?Q?Ut6V4WhkNjZKjU4LKTl6jF0VUXf16jf586v5ZQ6kRj2h3BtawtacesnWNYGU?=
 =?us-ascii?Q?3+ko3Yje5BJCVSRSa5NiZH+wqbPBwWmmuNa+HPwXEOOexcYxv6oi+tUqeyHg?=
 =?us-ascii?Q?q71uI7KXrhes8su03ghFdGekgN5YQYrwO+pvjHdlzm+TBnFavkP7vNnt/Tyt?=
 =?us-ascii?Q?YlZYeT6iyAtzxkwvfnfZy+6Sq1nlYgfJB6hNnGecw5WLYqoAwJFHcrn6WcVQ?=
 =?us-ascii?Q?xZ1dOnXP9cUaZtWPC3xTwgO9IOCvjJQmdAYFzYV15Sb8PrKqpWKEX7hSN4a/?=
 =?us-ascii?Q?tcbwmb8eTo2YDOlTS/HW2Zl9jaVYoIecM5HTOaGAsbwehFkueJIWgfCK+MPI?=
 =?us-ascii?Q?dFKjjXzTXe1yoLFvAnLNB6oLQmniFiizD0El1pguxiWo9cqcdFroKnWhpes2?=
 =?us-ascii?Q?4WENtihFAacfNcXEHK5VAgEGROACKZ5unWtq96s7SWXL7qH8WM4l4E5U7yfm?=
 =?us-ascii?Q?DPkgrks+eTDeTPodFZuUA7KwE9//1rl4zqUvA7+PUhSHu8sfoqmITOZPJXnG?=
 =?us-ascii?Q?MkA54IWyW0aR4efeWHh9kk8AJc4uTNRVS9u+dA044ZRq8NYGI0QDBNH5/MvO?=
 =?us-ascii?Q?x1gfTpt42atNgRBjkXwznawpS6suPxFjf5YljPEdeeIZwSQQQtBwEDaqDgQt?=
 =?us-ascii?Q?YJNDAs42duRFYMMcnaJs18tq0Ax/BgBAwByHOCluvEVelldXs0VyT6bD0gns?=
 =?us-ascii?Q?hMiitXWVVF9653eJZxvkIb7lJ7rVR8WhEITkbQQozyILeu9mq3LPza95Lmvs?=
 =?us-ascii?Q?uzA/Ud95iGaDEiVHcylaaMTix5sM1pA36ojcGhLOJlhxJCA2p1XJdyFpASD4?=
 =?us-ascii?Q?acKF0rrNcJZY3Z7Ifiubgji/v0Gdtscbn8M+M5aPINYqn/gdyUGvkCsN3HGj?=
 =?us-ascii?Q?iOW5XfPjzA96owgIstybbsmGlwmm0scbisRNeaQG6zGF0eyVp3hY/77qhJm4?=
 =?us-ascii?Q?QpFlEe0G+otdPpzVykpHIr+c8NAGkyaLF8YPPRc4nUAYO1fdgp+K1GTP0n/a?=
 =?us-ascii?Q?1G+DVDj3666oTOWuoV0VM0I5Z1uxFjb7WCX20YDkXJJEJF4Xj5eB2g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VaHkR/oe+0n2SUbAJMM3RrnqCZWE5EnZXM446rUOFbxyM7IkOtJacW+FtWMl?=
 =?us-ascii?Q?2B3YWKowogvkvEsPLsOn0VCm4g96mX6qRiU6L684l4Rx/Z25++bKC4Rf3Pes?=
 =?us-ascii?Q?tGgmL5llMXKTRughiBBvSkW3JIuh9xVM5NN5LbUXXck8xPHwGqBFncTHxiyU?=
 =?us-ascii?Q?fLcb6QKqPXiHVEBCaIfDDMFKSUmJjOCwm/2aSx3SgFSLuGXh3dx4MY16wQeg?=
 =?us-ascii?Q?2YFcvlZToGHGsTSOOrRL4cZV6U1Rkl9T6mGuJnazDUjOsO9G3oOXzRlsXoMm?=
 =?us-ascii?Q?jrYVTJ3PISkUcGlxUtX9ohUHtdyw6RcgMp4VRgkva+VYU4HoiRarWIXT6sTL?=
 =?us-ascii?Q?CWpihavfIE1f7br3NY2uPhGyQNqZr6jfuUuT05OKyh2vTjTqSJc5WJnvxf68?=
 =?us-ascii?Q?OTlnDX/9kxT0S1jnXLdPjLa6pPSydQMt82TMVlAHFO7WMBYp0fpH63bRc4iP?=
 =?us-ascii?Q?GB769bNZI8ncUqTIUoruukV1+xSC69ZHqgrV8cSkW+kDbXyeTljgtKZBDH2T?=
 =?us-ascii?Q?JbnSsmCzQmnHsR4ObAnRfmcaCc5TetXCUf2itnNxEbOIVYd96GW2BB7fIu4b?=
 =?us-ascii?Q?1/lgptnfCExE9GTiFuxI8NEYRkPc19Qx7nYtBC8lfn/5gDZLMR2eiUXZI0XT?=
 =?us-ascii?Q?qIJ7fhT3U9twNzw5zrwfbTdGOLadxaUKL9NMlB2Yb/v0zFPEWgocrLVRzj0F?=
 =?us-ascii?Q?vmXcOQdj3P7kEFAz3PE4D1SSGKv7Y6Wiex7P0pF1niGFowISWVg91Xp8mtfG?=
 =?us-ascii?Q?1f149m2cW3ovkA52zbINpbJKnSAgiuIvgXjQvtLa3leRaISk0/mNx7a0mF9L?=
 =?us-ascii?Q?2LL/7xGhVbOrUJ3Rr0XKqlseB8n9aaDtSDqVdbsAL42ar9YYUq4P2XTx6CqL?=
 =?us-ascii?Q?sTTUGa/jEyEcoGmXOXhhAwHkEWa6iJ0IjEUvJisNEjAqwCGYMLTDd4+xkJHP?=
 =?us-ascii?Q?9wsCLKT1g/sfUfdxVlHVFNHsoQzqzQ5yQvmpUD12kr4RlVJuAsIWqEILuNJg?=
 =?us-ascii?Q?SNhUcGWd7638c0CNyCL+xQBm1rcKN7IzUmQaLlje8xG6ePsrlySq5DkmR+qv?=
 =?us-ascii?Q?bfOD1nrwVJ7ZgxMC9rFfqaN23a99zBwtoPGAmzDBL9fpFPrGm+nPOdmlmGCW?=
 =?us-ascii?Q?1/8BOIDRekhF3OwyVv21GcDK+LMourWs2EIfYfVm3sGBhsi7kWpLQm9/9e32?=
 =?us-ascii?Q?9zEn3YHV6vqeSICejIAJWtVB77XPuBbrqU+dkTa20pRdvpxOoiTzlAqT64di?=
 =?us-ascii?Q?ZXiaPcLfgIidDfUzP228YMkN0323CqqBA5YYWGIo8zvPTRf8qRdPYkClVKsX?=
 =?us-ascii?Q?/Mdk2W500QHoVNMRHB7wvXSpchiJ+d84jjV3ydRaKCxrD9iFocqqU8CWdjhZ?=
 =?us-ascii?Q?3YFEJfLQznkn9R2wGcuUV2sAnvF1xG7uz/veXkjk/lOtIJT4MNQAemz1PaL+?=
 =?us-ascii?Q?9RQtXi0G7bMfPiRuwt3ggI0F9hxo+xTiPlfI2UQf3/8Bh8wuVlNpRNZLW06R?=
 =?us-ascii?Q?Lw47uyADyJDesWGW0mKwaEyYv2ek9wVlDuaZCUjBv3CWZ+81Sqbo18Ps/VXl?=
 =?us-ascii?Q?K3+8P5/L0rL1htqwt8CTVTEjZ0lp6VO1nKWK9+B0AHIjXfdwCJ5HMwXfnSl6?=
 =?us-ascii?Q?L637BlhVauUrK4RZhY4kTXQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bf58d2-62c9-484c-b2dc-08ddb9547215
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:30.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rRokCI4AJk7NFHhuPzabnGzZyh+3JTxT7Z3lUzMJ3xkT1Hd+Yws2q8kDYD8mTzg1l7TNoKizHt48K6fBJR/700GYG5SQBlJIG7cIrxz1NSgNJFHKlT2sHa5RWHHLaUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13822
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19298

Dear All,

This patch series adds support for the Mali-G52 GPU on the RZ/G3E SoC into
linux-cip 6.12.y Linux Kernel.

The changes include updating the device tree bindings, adding the GPU node
to the SoC device tree, and enabling the GPU on the R9A09G047E57 SMARC SoM =
board.

Thanks & Regards,
Tommaso

Biju Das (2):
  clk: renesas: r9a09g047: Add ICU clock/reset
  clk: renesas: r9a09g047: Add CANFD clocks and resets

Fabrizio Castro (1):
  clk: renesas: r9a09g057: Add entries for the DMACs

John Madieu (1):
  clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP

Lad Prabhakar (3):
  clk: renesas: rzv2h: Refactor PLL configuration handling
  clk: renesas: r9a09g057: Add clock and reset entries for GE3D
  dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC

Tommaso Merciai (5):
  clk: renesas: r9a09g047: Add CRU0 clocks and resets
  clk: renesas: r9a09g047: Add clock and reset entries for GE3D
  dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
  arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52

 .../bindings/gpu/arm,mali-bifrost.yaml        |  4 ++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 49 +++++++++++++++++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 15 ++++++
 drivers/clk/renesas/r9a09g047-cpg.c           | 53 ++++++++++++++++++-
 drivers/clk/renesas/r9a09g057-cpg.c           | 40 +++++++++++++-
 drivers/clk/renesas/rzv2h-cpg.c               | 13 +++--
 drivers/clk/renesas/rzv2h-cpg.h               | 34 +++++++++---
 7 files changed, 193 insertions(+), 15 deletions(-)

--=20
2.43.0


