Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678EACCF2E8
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:01 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31403.1792405557545157339
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=AlvEk+Dn;
 spf=pass (domain: siemens.com, ip: 40.107.130.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoInvYDJP6rxQhUK3dWKxCdOpxz/anK3Ly6QF2DDIcPyKv2z//TGy4RVeJLpDuPVViyLVE8Xo5b9e1GkR7myFSFPdyHbFCmx+dUBaKTDutlE0QAnL/DvSvRB0p0PE/R+tmW8yueZnaewC7RV3wiL9xm2tvrGM6zw+xC8Apc8ZsVR2OL0Vt7IfpiBFNm7A4kUqSHXRwkmTo+zRjCPk5+dsc8Mv8gxVZPh+3SDW5/ZrNLiVm0xY5kRqFUGJTxmvCyEXKajrQKNXgtYBVaGjLkbY6WVvh+8/fWLQQCwus/Hh9bKY0bBX3YJBCA9n7WzVM/icVLTTW84zdacmYBWg/8g2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3OgEHgT3JdVJisF0uBOgwCJf3flMWPbVMRQhc8aH58=;
 b=M1g361gfuSUJ8ZQNWH37/0mXjODrfv4ZF3P67hTRUBeqMo5/HsjjUyNFEMNXETJAcxydgdTMmiEkKl294Yoxkku1juHz2eqGjm5tN7xBL5n+WPXf1P5YL8ykNRLscE2XX1Ot+7A14ry8j0XD5yLlIAX8YI50SPQk0U6Hwbvwmw2UCewRc0q7t8jQjXSt4mLLSrvuV9XjbPiByWz8v4R/CnloYWIyGzdxgBUXfRz3egdkRJ0oYCmCs4WWu/Bg7zshlYP6ayfdNPrg/NpiKBLm8ODd8pgqz/HusYxT20o7amXYxeeIjyMvj8LhIKGu32j3hQV8jWhDJ1opI/rS6x7SsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3OgEHgT3JdVJisF0uBOgwCJf3flMWPbVMRQhc8aH58=;
 b=AlvEk+DnSRDlWwHyxCprvbb8MPAi3Iddz8zuzcVl7eiCrDSSFwu4tT7N7Vnb4Fjm3XUaJBrMhAYQdR3y3nHNa5wxF5fF9ncBOMmsmwvBJn895z1Sntv2xJXdiIifUz9BXrfoptBRrA2dmgUkbPZYScq3d+uKaW/gZpcu/PVnTvOGEq1+3uCStyzPTBeWrX6B1Kp2UgToav5++9zFFhCDvpF+XNPaeJFQo2Mz7dW/ULm3ccsSPSKco0Km0LfUxxFNGMDM2zlrXyXWBcP9Uc1mtmkX98I5RH+3cR8DYrrMf9YhCEYM3b7aQocDQd2kEozWLFnjBfOrLFg08w1V5M3SnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:53 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:53 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 09/12] Kconfig: add option to generate initramfs with dracut
Date: Mon, 19 Oct 2026 12:25:20 +0200
Message-ID: <20261019102541.672620-10-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f44579-5ebb-4b61-2df2-08df2dcb5a99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	R6KdhDHmfEUcFmPJ3OANK6tLb9+gMUT0Ys6+wvjK0qD+pVapFmPB8xgfXj8Xbn0XNYYaNB1ysNKN9bZOvebISe09R+XFHmE2I4JnNej1CIstkrz/wNRZQTfnJnXGJOQvm95YRPsjfFxMXB17fd5QSgfljfGjhkUoXrMZ8bt2Y3THlUeoP1atfHDkaynXwhKPwPslNlD6F6J1GYuvHW2MERTyt4MErCUbZ9KoGf9DscQ559/m2OAYGZW/Mkwc4tq8ZbhB807tdlVXoG8D9h5sRPu1vx7mmU9SL+5ItGBNEXBPxZ/F6nnGYgDsNbazvpVmjzMztgfAX3w1tUZK+3vBwKAEcARtkL8U8FTMrPtedHWO/ZMyh292+Rg0keozwWHw1A0jEHyxwtnPfjPuFJ90kP/w8yi/7hdMalblEHWVoTeO0P3hpaJUwC9yM1MXNStSNvqvBqm70A+Yw/VyoDL9h19ZqgqKBiirufV4ab0pn1f9X2dOWUiP/TP+f8UaPzq1E47A4XPS1PH0qOCrDCSVN97MKA5gbec6HeKAzHwOe5eU+cKno8iT4bpEZxQ7Y2UK4ER0rkao+kiONVg6Xk72Pk2/38K0cWry+SAa7ILOWV6V1rL5tP9xnjBZuhRn5yZMzB8PEJ/Q8+xPxpqjwu+4b6WDwgp9DJzGtpbvR+xLVYI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QP6yJKQ+6o3/gUTJJjhyPiRi5TWo5G0ppCaO+likQI0KSCcB5ksKXlkwjAng?=
 =?us-ascii?Q?VCOTgLbh8juBfMpZlfqwBk4HzTnht7QuGw5H8o3FpgPuvHR+rbcbOQL5PWfK?=
 =?us-ascii?Q?UgNFa91TtswgPEy+LY8VUJepF1FgHOfYtd9cxGSDxBj9ToMGA8L9LowP7vW5?=
 =?us-ascii?Q?6DWsDTsXi7NfrI13tIvV65IG3jq/eJ/A9HSrfbxILoDc4vg4ELwblIexpJFD?=
 =?us-ascii?Q?feq3tRHwT6AGUtocCNIvJ8ORJ6AMXbk3QdqTUlVVElHsqel8hYnPwh92ANZg?=
 =?us-ascii?Q?x1CQKlt1mLnGqEk30M27NcIo0YHF/xjjiHwgnv/F2WmRx0RmKkdHjg0neD8U?=
 =?us-ascii?Q?NaUnd75xGQHrG8EcwIfT8Jf/Ui8echjWFnvOAoEOI89CkVxupR8R8hM059+g?=
 =?us-ascii?Q?rtlUgPdoOWozeZOgUNAX+84cFBRHrHLg7A4hwipEGmGctvE7WL4SR5OpkNGP?=
 =?us-ascii?Q?QORCyPnfxVlAVuliDoKulLzd8dw54r99SpbIK4I84T6SEQoiotzEPZGUpXis?=
 =?us-ascii?Q?U8xRIfAnl1xwyfOWycWklmTzRngIJTSHGgrvIp6kjMEb7ItKBkiWjAgnJtP/?=
 =?us-ascii?Q?lM07AMko/laTTsnpEyK/ZaNdnvKlI6H3faP9caFfPyoHOyAWABAmOZrzGZVE?=
 =?us-ascii?Q?+BlbyWcIIUwu/gX5hWfGJeDyiQZs5SP+70F8ypvfMYjPfFTWjI8nNhRp1aoQ?=
 =?us-ascii?Q?Bvs6HaZx7ReVnZYz9RfuXOfjOqSRUVNo8tU0sfR4aAzn+yFRKZ8Md08dUK4v?=
 =?us-ascii?Q?/bEFlmjAajtYZeoaAt+Qz71G3nqGBiJEDbeZJ1NBXD42YWKe7ovFpiBe/H+X?=
 =?us-ascii?Q?FUGxZcFps+Vjxeyi5uqja6cLV8cRgPjPrH4uwuhBrw4fD0iT0qWrp2vo0Z4a?=
 =?us-ascii?Q?gLV/T+ZT3ugbB5GpPhLkRw9Mdfx0p5/OvzjkgmTWAHnumHaSP+ic7rTEGitu?=
 =?us-ascii?Q?lqhnQTc7qjIadlf0i7UkLQShNZlNBKmepzr5iCb9FkTyoPCp7Onfkdk83ft0?=
 =?us-ascii?Q?m6CUulAoU1Piror7lx8x3WdxRpCk9RLIYOALoDI3B+CUqMeSTpvw4juaAQm1?=
 =?us-ascii?Q?Kv09aCTEdukmOfi5Pty4lRBVdq7Km5cBy+IPGZNcbI3KyolJDr2jZBUilBWi?=
 =?us-ascii?Q?tP/D7KPmKdjHkmsV7O2p/RrLVZMzKy9chxvRXUAURK6tC7xS1T7ME6fOgFOh?=
 =?us-ascii?Q?GIAeR1n/Kr8jHoOS6LCrFoaZ/weZM+H62HpNCoweFn6RdDhOjTpZeV5fJ9+S?=
 =?us-ascii?Q?24+fzEaVGx0AHb/Vw1iUVPmYezBFFTzAe/+PViw0Nrq4vBmYbZuDIVMVL7ae?=
 =?us-ascii?Q?T76ctufHeAi2KwvSls5BAoYIhQxQKc61eDFtl2dphfk+jfyBFCyB6rSyLBCC?=
 =?us-ascii?Q?ho670Igmk9crEapHUIy3ZlsrmYz/7DRWmq4NrDAwbprXoQQqXJvbKseTotHF?=
 =?us-ascii?Q?BmwOAMcBiZI7kq0p8+BTjzKQi3TJFSgn7FumTfSQLvOa5ddFX04Hfc2Rhjvv?=
 =?us-ascii?Q?5epgABUbZeLq38eUMqZFD5bruVDYx/w+PgBHUSsVGfyC4oNc8VB7jhlvOPiF?=
 =?us-ascii?Q?myBLQwnXH+8hYVZFz9PGS2Sfs3r9nm7pKj+v95IpgQCejnKC4BNbLHs+mP3f?=
 =?us-ascii?Q?GSk59gxKKCP82Re6Hy5UshoNzRoJurcS51TJYDzfI+V9nw8gsoNOpAGUMPh1?=
 =?us-ascii?Q?WjDPhychwstrRJcKMw78ywGTZT+ZwOoaBJFjmhzjLShdN6YqM2Y5AAN/b/C1?=
 =?us-ascii?Q?HOWQ6GxcemqVp/qEkaCVWC5hjZP1HWs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f44579-5ebb-4b61-2df2-08df2dcb5a99
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:53.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNzCTufCegLmOYfP/p0SKGD7ERB9P8t6Sh8K5KNbJP/bmCPHc0uMHIp1pytqCQ5IWDYwIoiHQZv0PgMwraBKU8Hnji0Tl2zZxVc5NXjyZYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24489

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Kconfig b/Kconfig
index c5dc3019..3fe7036a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -279,6 +279,21 @@ config KAS_INCLUDE_TESTING
 	string
 	default "kas/opt/test.yml" if IMAGE_TESTING
=20
+config IMAGE_DRACUT
+	bool "Use dracut to generate the initramfs"
+	depends on !DEBIAN_BUSTER && !DEBIAN_BULLSEYE && !DEBIAN_BOOKWORM
+	help
+	  Generate the initramfs with dracut instead of initramfs-tools.
+	  The rootfs is always protected with dm-verity. Without secure
+	  boot the unified kernel image and its root hash are unsigned:
+	  verity then only selects the A/B rootfs and detects accidental
+	  corruption, it does not protect against tampering.
+	  See also ./doc/README.dracut.md.
+
+config KAS_INCLUDE_DRACUT
+	string
+	default "kas/opt/dracut.yml" if IMAGE_DRACUT
+
 if !KERNEL_4_4 && !KERNEL_4_19 && !NO_KERNEL
=20
 config IMAGE_SECURITY
--=20
2.55.0


