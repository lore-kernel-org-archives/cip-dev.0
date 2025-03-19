Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A3C35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:49:00 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.52])
 by mx.groups.io with SMTP id smtpd.web11.4018.1742377735650642023
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tchwBWoL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMqu0vd8zZYV1ek475J5h09QohV3RJIpHZIhZAZSRSzaKMBNpFfK3G9rVqEjO/ncp+RCHCfNqpEg2nKq3S40TSxuRvE3v1JvSXj/5Po0dPcYjvQHwjxAvRTumAB5OJUwvi1YrMLXicxYtMUd4NKFMkCgeGOmnY7Szay0HOKOdOEnb5LI+bwB7a1HHckCScuCVtttXjbAO+RFlkXGcE7576inOdZk7Ej7mUO87kbQEHc8AKPgbC+u4V69sOhTbWqWTHPpo1ST/+maoXXkv7tdzrsknZISXBtz3Mp/FSycr65mNIPm+5QVdW+3WevaUMcfsYACfMSwMOkzzM88miNefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26InnTN8EjTovqj7z/2RUG+mC2Xwqz42cMoF2exaqE8=;
 b=hi8H/vYEjGSXRlPZ4VzXlVbzLILSBBq2SK5rvqxAjTzlqQzBoOgNZkBiOERq+rtfEjmd13Pz8o5sOVx6jIL4XnzU9VkIpu/yk+WF/bQlsym7+mE/C3ivF67XlrFtd/pYBSQRXiM3e06Nt5EYRvFQ/feOPxfBFxCqeJzB6Rxh0xRmdge60JEBO9/fOxejkf1qrQpXF9w2s5rLGNEteV8CE46I/NRlv1ZxQBRnBIfUF9fWcfEAwQxHDSxbodMy3ntAcfpWpxTzVJeOwAtAlPbBwlQDOY74BiedFEwpOpXUNXtmWeMblEBM6bYflLk3nTJjt4zRXgsArfRqu1nzNENm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26InnTN8EjTovqj7z/2RUG+mC2Xwqz42cMoF2exaqE8=;
 b=tchwBWoLJja1ZEf8YAERpVfD8EbHXrLTt4JYy0WyBR0w2eApSrWQvk4KxFxQaXHM8S5DdmxNb0EAX2dKGvRaHB5tpskWadSJ5m2ProKnpR9oJptHbiCHAUR5e0qiIxdYCy6YnT3hRAtU2UJ1Xxz5TemwjNnUrf99qlYw1DMNBik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:51 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/12] serial: sh-sci: Use plain struct copy in early_console_setup()
Date: Wed, 19 Mar 2025 10:47:50 +0100
Message-ID: <20250319094754.2404386-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9dc4d7-69c8-4724-b5b3-08dd66cb4143
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZHlEZQMOsZm6Ksvg1aKKK9NXLCk2JddZ/LUB9hR17W305mTxHd9dv0HUBgdD?=
 =?us-ascii?Q?YXnxlejBBPmBlEtavgb1oVYTLe9kQEvngGXwtrklUgS4PNlRe+9rJf+XaGiX?=
 =?us-ascii?Q?cAoCipnLgefwfPxPc6vuzPIrXk0s9umOWs64zOgykDG2M976lATGEUCZstqS?=
 =?us-ascii?Q?K9N46O8llv3COMT70G2k1PM9EXeWsHwE9b9LI9bTCSrFJ4pWQLti6/12pUBw?=
 =?us-ascii?Q?0vq2ahey+4j8AUuFbRJI19rSw8WcXMkQznn8O9kimskttZHRc4t9H4kkQr9V?=
 =?us-ascii?Q?wrXzZwisefF2ODQhyG/adElkLRRTCRNDahI48YSejbf2xVlPEc8sROWPlf85?=
 =?us-ascii?Q?0QnVJHWHjl9AOgp1xQrgDmfPdm9S2XxeZv5w1B6nj6Ra9hYOMKk86YyJytq5?=
 =?us-ascii?Q?uz3ol4s0SuDHd4f9WgkZhC3EyJdUFwm+O7ca4dnZGFEthcOi0Ng+N9IgFYnh?=
 =?us-ascii?Q?1EW/kXvekz5gXqVkwS06mlmPj1nndzEMU3xPwMOvE8OFU7o2G4Rys/egpSNc?=
 =?us-ascii?Q?3vkIwrndt4RwMH7G0E3evx5gLG9BP/sRX+BEZhw4CZig6KexidFGANAS4ghM?=
 =?us-ascii?Q?UBwCm8RG9mpQhBepDwix3r217A4bcSijN0xsZPVnXb9yh+yv6bYR/O2Ue/kS?=
 =?us-ascii?Q?0ga9FDXbEk7llgxRx5Jv8Grnnx5pazszzUsM1wVdspRy7hJMZdckebom34Wl?=
 =?us-ascii?Q?cA83icuzRQxbO+qIspcpoWYcIcByW3G3m6vdumkWpjEoXtF9Ou8ZK/WwiBoL?=
 =?us-ascii?Q?Cong1CmNlbK1WMgj9F8B8AtjJbm/U82elibNPMzFz/6wErk/S0vZM7MIiCgp?=
 =?us-ascii?Q?cf2qMSjA4Z3hYvj4pM458dSIpVo969DyHbzMefE+29gCF6QbCFxg+OCdyHbR?=
 =?us-ascii?Q?SLZxKfjYuD0g97KKlHEzLyPtsVrVW8D9R7tkROyrgddaoDgeEwczy6Ft7Bn4?=
 =?us-ascii?Q?GGnvRlaCNmBW0esLELkTBvANQlW2FZWOcdI5l+eI8CJ3XktKLZlAjlykTtgd?=
 =?us-ascii?Q?rx6zbilivoMqmsK21Oqf4/HnHGwrHhpn0+B8pKLaPbCna/PJDFpBsIjj3nGC?=
 =?us-ascii?Q?WPkJDFtkZ1l0eIUpLbNsLifUv7PMU6p8T7SWE5uLBBo4OjtjUA1aFxFfRVg1?=
 =?us-ascii?Q?Xj/b+ae2ueFiMenWwsEWhpohB1wP6OCXyngoZlVXYAxK9XbwJt5PZd9koUjs?=
 =?us-ascii?Q?QNKL22Qhvbu8kFy43fAtmetf8tYbEmZxt4mZUau/U7iqYoTFX16mxen/76yB?=
 =?us-ascii?Q?cyR8ePJd5vCyewL0W4gF9gmiHzZ9d24ZaNVTGCmIANNk8kNJ0eRDe9cc4QNc?=
 =?us-ascii?Q?+037+bkjlakF6NIGATYegrLLm2kPqQU4mB6JyEqZfkDS3+B1lKUO+aBtJ2xW?=
 =?us-ascii?Q?HZkcxsDkiD23VO64TJ/YaQi6xx+hJC8xY2WcdCsH1tF36QdOOrjBiSRqniFx?=
 =?us-ascii?Q?A02oIFGctQ33ORLyzwwXaosWVIDwX0R5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hQjqF8fdhoAiyrURfUh84/pZCAJNC7Hxjoa2RLHzhhsSI92e3y1/R0tqPIkl?=
 =?us-ascii?Q?nJWFOtAQW36ikEM2GVqgC+RUPftcHnbCh9yP1nd7K6a4pCsLdI+dbKrcNqot?=
 =?us-ascii?Q?240v3UG3RwJKumcfK5vlsQazNyY6rDmNwQfn5G9kSna3OBJpFHlJaPvTq5Pz?=
 =?us-ascii?Q?R0HAlkxxqCVOC8fxsFi1CKUg45PfOTllZq8mT7zm2cdNiojG4vbECXbDZq8b?=
 =?us-ascii?Q?0Y4EC9Clh8wcjonq3J/+ZTX0gSyuUJZUn8/B1UT4HYI6df/2C/wsKWh2FubQ?=
 =?us-ascii?Q?YQZ5MbmSytfSO/gD3e0crG9Ywkpm9TZdOFTOnGQefUsTw3uNdB+DFnOU+FHm?=
 =?us-ascii?Q?oUz5OIZYIYndlF8y0pQkJw4QGheyFJlzFOX+J/nltc4EkSP37xzh1So3xEqa?=
 =?us-ascii?Q?xywHxesBJhSDq3vczSCJ43ul7VMAyDSuBM6uICCd55j+GElhFOZZ6hRpNizH?=
 =?us-ascii?Q?aJDoro7HQKv7jIBQJV6ijzTGIBWTV3ollySqlpISiO8o48VojW0teRtctKkH?=
 =?us-ascii?Q?yvdhJLmo9ozfL13yDUoyKmcSMvGgsguw0UHrlYJySksklKnMfi9TYPRV33Al?=
 =?us-ascii?Q?PS1YFlhOmVZ+9vNxlQV/TvCYhbaW4Ed94D31mKE48ZjkY7gpD7ChyeqVyJPo?=
 =?us-ascii?Q?+jDb9BjuwGfUGNlLu/W5zfOS+Mn7J5K2sm20KGknJY9ytyV6UO3/BE9a72/3?=
 =?us-ascii?Q?MJefywOdZ8dX/LFf1BVxdVUl9+jNVvJL/CJtISlF3wZiql9bacZ1kYQMJRaS?=
 =?us-ascii?Q?V0aKmcQlw13o30ykP3YlXtx7nfyiN8elVIyhCuBjLrfgrVUdh6tgpUSsi8oS?=
 =?us-ascii?Q?Hlqzb+VYn21eq6kJKvvsc+CU0I0wd/w75p3GubTfFZp4X5KbYYeIXBOzX60g?=
 =?us-ascii?Q?Q2nwjTZSP2SIOkt7Lop4qTRZzdwek2mrqIuX4RRjJzcwT/I4PfK8LCdjzIrq?=
 =?us-ascii?Q?gy+qZb9oYriHzSFP8eHFpNjM/VXDxrMJFdVgLmy1pPvOK9CPrUbA4gRjIqKb?=
 =?us-ascii?Q?nXf3eAEj2QzFWHuGWa/nlLEUoTgiBbielMxBmk+3unGmnPDODTZKw/u5kwkt?=
 =?us-ascii?Q?16DeGa7UojJx0pS1wdEh6bFPNs4d/6nFVXWkk8fFXq3ufzEDQhkCgU8odAVH?=
 =?us-ascii?Q?OLtY0hfynwqCZ5rC2wJat/4B+StgMJLu8EFUvZHjx4Q2MSLeaa+60NKoBtDt?=
 =?us-ascii?Q?Ijw/nq8SeNVqhC8l5UfrW6gNU3w124h72x9yQO/XLt3do9Je/2V8v7P4T364?=
 =?us-ascii?Q?cw7LR8ZARWEDG7zPN/e04Mm/HddleK3X7fa/eQLMoTeFCTPR799h6mTMqx/o?=
 =?us-ascii?Q?PQBLsOl7NxOigKTG9aIh0w689oTi4ZTXFq9MKiyQTRc0V4tWhSVN5skXcrK9?=
 =?us-ascii?Q?lY8r06azLEEpsXxJjiLt3UUd7HQYvF47FzYfqfVZEQ1VY3EApRYRADikPMsE?=
 =?us-ascii?Q?0ua8vJksh7LuaaCpV2V9SeijxqeMoi5BMcAGTsL3F443/xMgAQdK0WKTxyCx?=
 =?us-ascii?Q?VNh3Y4FvWePMQ12BZg0fph/CFHeqZPH3obZQ8EJnvGlzmDQCR5NEYPIttIgS?=
 =?us-ascii?Q?Zdo43tkCXWvhZuuUigHNcEKEp7MYzSXF9DEClacPvpSvuVFJPBxNHqIhPulf?=
 =?us-ascii?Q?S7F7o81ZxZ02u0hca4YW8A0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9dc4d7-69c8-4724-b5b3-08dd66cb4143
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:51.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+qpZ8tiYq5pSUDNeYq8I8/v55d5a9IjGBVfvxf5/OmhUXDQSx40UpK2Jrc2PtfQk7y22/ZBCidUBg3yteAHz+8Bwjmt+ZJIhY3Wf/tcWhoHftgHfcRuWa9oomCAATF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:49:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18255

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c1117a2fefbcce30cced3a180585e0adebc0fa89 upstream.

Using memcpy() prevents the compiler from doing any checking on the
types of the passed pointer parameters.  Copy the structure using struct
assignment instead, to increase type-safety.

No change in generated code on all relevant architectures
(arm/arm64/riscv/sh).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/e097e5c11afe5bd4c01135779c9a40e707ef6374.17=
33243287.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ff69124e5336..d1140fec861b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3566,7 +3566,7 @@ static int __init early_console_setup(struct earlycon=
_device *device,
 	device->port.serial_in =3D sci_serial_in;
 	device->port.serial_out	=3D sci_serial_out;
 	device->port.type =3D type;
-	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	sci_ports[0].port =3D device->port;
 	port_cfg.type =3D type;
 	sci_ports[0].cfg =3D &port_cfg;
 	sci_ports[0].params =3D sci_probe_regmap(&port_cfg);
--=20
2.43.0


