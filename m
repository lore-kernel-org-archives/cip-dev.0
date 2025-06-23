Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83731C7EE33
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:42 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.web10.376.1750690055884036756
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VW/b+H6/;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1nKkEYi9BHjPbBdDR4bT+JN59Wy+835i8JuA33wW+SoqGzga0h1qbDakrhZnyVMebTSY0FRMQREkHvimG7ohyXtXwv/G+4od1eydBiUwm3cb7bGKlYTg2P4CfFOQJ1uPFnCCB15WKwJkZprsr0o6sRwl2wbS1Fp7M3+4m8oi90ZeI3rYG30KhMDECzZRrJ1XMBg4mFUgedTMiaat9C8A1kvvzlJGsviBGw/tCspZKPDemOzJRv1nGtcnCleOJQzWDOw7VXtnmcuz0SubI1W7TNTRlfjBFzjtOUd6kS0rHzDMCjRap6jyJacW6vBiG6BKB7b1a2UMrXfnr40TUqjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrK/xya3FvcCx/jHc8HjIIibUWVV39X5k+AgmcjI/Ks=;
 b=sqDYm8xWOSjDk7z+Wo67jOsC8BrLoG/x2ng1fugrfr+AMUyS/OhlHPOViUgb6N98bsCi7hfz+Q9c0wlJgC+iv77QMzNh3tKvdxWkEaTURNU+bk4bdqJ4YIVOnZt+yg6lzo7h8COaK8l0JRXtgrbO2+uICxo3w3hjtsuBY3BF9E0ilRovMmJto0qy1ARNWKmFbVey5VpMZZ643ETGBzMvX7/LRqYB5R2I3tQf88udfAhKUph5JFZw7cbT7ijhAJy4vXWCLIegTvv7+vqAF/aGz2F2m/e4mfe3R7FOh8+SkfKZRv5Kt1Yz5pluGA4BhbIlVz9WRqcsmKbfzaLGKG0qog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrK/xya3FvcCx/jHc8HjIIibUWVV39X5k+AgmcjI/Ks=;
 b=VW/b+H6/oOhVl9yu3DPrjWcCX8wNvRCBI7RS1VfXm1Ec6/0btyEiux5Tb3+2uQ5vNWQKCY2XJQ9OvvvsRWbGkXoEUa6IqAQKH+p75LfPEvY3nDrxbSC3iBoCTXBSZ2ro8VOnh5WGM+14LgD0rpvOnO5/ie5sZ9DoYavxkpAdSjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:34 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/17] mmc: renesas_sdhi: use typedef for dma_filter_fn
Date: Mon, 23 Jun 2025 16:46:32 +0200
Message-ID: <20250623144639.2119707-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b5e65a-d06d-4455-1669-08ddb264e37b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ereJt9Nkwx5L6GwXeJ5HtZe2LPNTyjb39rd2i5L2wYmIISH/g+iQNlWtwxJv?=
 =?us-ascii?Q?KW5fhRLXYpFeKwEy6ZqkPwjaNNew11vEgKGJw/0xSEuspOJNTVJ7DUJk3SkC?=
 =?us-ascii?Q?qDxlcvAquLPulbds065vVMrM7LjsmPHODigWHHB4d/sUVtbR0hXm7BjVHcUK?=
 =?us-ascii?Q?auA/0k2dYAYtroXc2mXHdfIGctjCfSIYdPCyU9RzECo5fdsXtsWRMsL4sQYB?=
 =?us-ascii?Q?LC4yECsG+hOC9F4SDmoijg6WygBF8y5mmxFKJzGIVmGK1/WmBh5jYUDobOGN?=
 =?us-ascii?Q?H358y+7nNSgPnAp1WDCy3LihSQQYYlH16T8bNJQdzYCILfIGZWL5ZD+mMtol?=
 =?us-ascii?Q?mGm/A3QToiZOJroTnAdH1LdJxDCEZtDlHoawi8wW3D9+Mxf8gdrhQe4c4z1M?=
 =?us-ascii?Q?ImcLTPCFq8MlgnfwYd7NM1eBJosA9OityO21lT/d2X6tiBiOHBvIvPTfiIuS?=
 =?us-ascii?Q?LDXSqoHu5gxE+nVZQQcGEnzl9S7SjinRzlZVGy44GcK1QGsmmpPTgTA4Pvoe?=
 =?us-ascii?Q?wxuM8IPblSM9LnIB/lgnLWSbZiVStEoTNdsPSJYEc5+Z9hKHVjrJ24qB4Bl5?=
 =?us-ascii?Q?sDUM39U77PgYG54v+ocBEzk56RscNGY9kGgCoj/LLRSSFWaegewldp+gkbFc?=
 =?us-ascii?Q?iL62j669HSUOmY39ggkI1crkcfRP6obLyqMJzXu/xWl/XVUArU8SGFmK8Zjt?=
 =?us-ascii?Q?BTT4ojNxz+UWeoDQY6SPYy6mcAWVxMgg+Fv/ftOPhM+AUem/PCiJHGkzWR0q?=
 =?us-ascii?Q?rOuBYG+wVPF3CFhxmIcS9Pq7YY6HuDxc5NsFSWVYMdnE7WMpXPHk2n5zJDCy?=
 =?us-ascii?Q?Bihko0I/kQW3SpU9sX3DWc3ph1Gh1RthkJ4hlhV6QXIGp7FHnjcwBHTvr+qj?=
 =?us-ascii?Q?XntPHYTWt4gUhUlgagMMbYiHtZuuazwr2fK8rNoxkyk2m3org3W35iPhj41j?=
 =?us-ascii?Q?X3oOcyLzNTqcN8ynlYCC9r+FRIdyHfwyRwvolN+3JolygMk5mRHC7foC/eMA?=
 =?us-ascii?Q?kbD1s02xAVsSlOBEpcNxvypYUSRnlBihJzbnC9Wpjns4Xlubme1hVpey+vS2?=
 =?us-ascii?Q?Img2O0gTuqdhrsGE7H9rcElxXETfNhaZVyKXW/v6r2TtssEEr/DNIMPBUOgm?=
 =?us-ascii?Q?KpyettA3AYDu/YQIPEpKbYloEzI3Q1huEo9J1KljhWC0NLMCc86dI3PO6GAN?=
 =?us-ascii?Q?MgZuzWTnQ6DNoMTzRePKqNnLhIHfmiIGVU9mxZ47oSY1JIPDDvmPmmpct4Jo?=
 =?us-ascii?Q?2r9Rr0NbtdE9RFSoEs1+U6stAs25YfgWFlARcVNLeX4JHcfUWRKcNYlRFMId?=
 =?us-ascii?Q?PUE2K0hmJXWqGZ2aIJ7zzzE2oKbukavqkh4BOaDq6TVrwm9SE0EFQgRtO9MH?=
 =?us-ascii?Q?XoTPNfeBzzV/pwBaYICsEvjaNHu9uaLFyNTK8HHG6AbelFkfv9mjS3vklVBo?=
 =?us-ascii?Q?WMEAFhfHH9VIVENN8walct0c57M4/j3rcEXxjm48yQ5zgBDUbdMPOnCN35Zo?=
 =?us-ascii?Q?UvEJ4GyO5BA86Ho=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Qo0Q5RokMwvkaTDq0aCFQQyPGfN8GS1W1wYq4xVekP2DKW2JzEbeC/gZECFa?=
 =?us-ascii?Q?ObNcOGxuzrovLZn6f1FWruZ1JDs8bBoRXvYUrspns2dR4Bwh4ZQk0S2kjJ7H?=
 =?us-ascii?Q?QCR+FyHGAVByQF1JoGDHlxKMhKSS1GfN/RRyMkSQLGCdYIjkBG+cUvD989ei?=
 =?us-ascii?Q?QWu19uS8ulA6rAuT9xaepNWcPnKhZiJSGZRgtEBnrzBF6Gxqi8Ou4CrjwPZg?=
 =?us-ascii?Q?0QyuXVta3u9XXSbL84CqWsDxiG7y3maqyOnxJ0O1Z16NMSkZcxhhWDbE7iJf?=
 =?us-ascii?Q?zn31Rc+xFNBUNHxr9VosN40PToJLT+Owes9LzLVy53teW9nANsMFTT7l0qWK?=
 =?us-ascii?Q?WVQNL3kTvZFT6L/6yHh7ENUWoy17qRuqNhUEk/49Pr3Wj0ZfOdLC5A5ACH8G?=
 =?us-ascii?Q?QPQJuE/co2ydU8IXQxxAUhTzjtFvr4EBjUMzi+NofjGvqQkH52qgFxa4iLmX?=
 =?us-ascii?Q?2J73KJW0Xrqo9NOpg0Q3gSEqsmE1UPBRG3jqqcuOYy0uUmeOA0h0dUVdeVnn?=
 =?us-ascii?Q?NqY/bMIH0AqsldteH9a9DJ6KCK2yA2peKTU3xepq3LtIitUU6pfAFmC+YWs/?=
 =?us-ascii?Q?2qWPZ3Qq1/VrUPoVpUBz7DKixYjZTHWUB5TLgIrJvVMClLUsjidhO8XGcIpd?=
 =?us-ascii?Q?FKteQvnfZWcnSw79S8A4lA0nLsRoHHdLH8VuxWHxBam/8UfZP12NryD3i6Eg?=
 =?us-ascii?Q?4C658jtLNgId/mDtlTJki5tSfTu0rfE3OU+vw40Lgul4b4Re3l1np2yG3+LX?=
 =?us-ascii?Q?fn+tXhmLD9O1aMG8FEMNBGnkJ+T46ToPVSfheJBSrGmIgLfvE3NfsHvv9dLX?=
 =?us-ascii?Q?dLR+sRwjE+lesU7Cibqd0NXTEpxJdkQcOabq0jAH7S4+H/m3GkFfNAOCQDK2?=
 =?us-ascii?Q?etzByXdMzIC02sRHR/zK4oYWCk1AJu0N9+CmFQky9oa1PWt79a6QpVOKwq1J?=
 =?us-ascii?Q?lKWweAQTZyiAh+AKxzuBgAMU3whgiVBCvXIMlS1pamu5dOmDelcrt5/zAnNp?=
 =?us-ascii?Q?oePdVjZThQzj9DKEPN8fLjAJzfLJVZeROdoTy/8xrN/u+ljCFWQAN4I8HDCa?=
 =?us-ascii?Q?gZ5sJ/LxZUT5A9SMmjNtGb+3KIR6dWoVQWbs7BHj4hSJX0M0t3frb9Ytvqys?=
 =?us-ascii?Q?6JCzv6IoXBdn7srVR00555FjZ8hw6l6SYIt4SVwL7/eYN4VuDWNay1Z0YjmX?=
 =?us-ascii?Q?Z2vvkJGl31UaxMtE6tYNQ4XDVcBSCX4BkPp1jZAaD4bSAW33DVwCQXwFk5IZ?=
 =?us-ascii?Q?nhX3k1IVgLB0GjQ3qzdwIW2ZjPCBSjLt4QOi8bFKrOnu+vygMzBjdxwOl23k?=
 =?us-ascii?Q?1qBTk8c+0eXHHU17V94u7f0ZLYjGR4bSjYFHrgI2lIFLfUQqprOaK7pHkjZC?=
 =?us-ascii?Q?U7KBL/OIIsg8IGjr4V39OtScgK5DYU5crUxrhkqg5/uPR7Z3KFZ+z0/cSd7f?=
 =?us-ascii?Q?0GaIB7BRA63ssEl0+TdAapd8tbZ/hDahmcOTqi900vbBxZSXgX3f4VfIpCPX?=
 =?us-ascii?Q?Y/Je3Exdblt4ZmUHqNMkdodTecTPNzm0jzTrEyBUaJqS5zINpjhJ+qojDwMR?=
 =?us-ascii?Q?ty58bXyS63GNXixRZgXTmchmN88hGaH+FyayjTze122w3tqdTH4qUhuFNf0D?=
 =?us-ascii?Q?OsOwBdkWQo3WOkgezSUdjsE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b5e65a-d06d-4455-1669-08ddb264e37b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:34.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9k1KiYJTuicFyI5JNLQYzL4vjaWmoRdszQzIspdRnHnh2MFQyv+vuZetguI3chAutv7SH8vL/LhpMSiiKfos3rHpwEeLa9fu6M4CdBT2SQDEQ+Ui/w7Dh7NhXHFkr6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19197

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit d6e5288c8bf4f9bfbb9d3630d8605f45f15a525f upstream.

Use existing typedef for dma_filter_fn to avoid duplicating type
definition.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240208202137.630281-1-krzysztof.kozlowski=
@linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index 68da3da9e2e5..770850ee067f 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -9,6 +9,7 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
=20
+#include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include "tmio_mmc.h"
=20
@@ -63,7 +64,7 @@ struct renesas_sdhi_of_data_with_quirks {
 struct renesas_sdhi_dma {
 	unsigned long end_flags;
 	enum dma_slave_buswidth dma_buswidth;
-	bool (*filter)(struct dma_chan *chan, void *arg);
+	dma_filter_fn filter;
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
 	struct completion dma_dataend;
 	struct tasklet_struct dma_complete;
--=20
2.43.0


