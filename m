Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E2C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:59 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13273.1784294032093665889
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PATl/wAj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBF62jX/LH3afNv5G1EW/XxE6DFFktVFdbNkVVPoRsdI9rP3i2KB6yXjFp5cEjRRffhZIqmYks+x+81Nl8R0vL31PPDc3tmZqeXeVQX0ueUVNvLN3buKCmsmAH4Sby1seh2LSrymeauiDccU1puU8Pr8sFnH4uh5RFMFwiY92HhgMwL7OstDZDv+V3D9RRAbJZN5M1x27IHDVlmHMYjbLGSd2DPNONKdstr7nvQStp7vGl7UpVRcGav390kO7Z1Ml9+Ojcd6d/NJMkUyiujJZKLVmDspDPHW5u8xZvDZfkUepXHWXr39cipgdUml2KfUldWAiQ4Hcixv75uRJkiMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHKSsnjmj7z31+vLY8L9qk2GNUB79yPzdi7cFPdDRsA=;
 b=oupIK+ziK4i7RTsLY5uXkLwtZTZ4TxSbLwmZ4YMxF+cmEGcOj/UAyyLTGlsh7dWdbPU/SVc5RSM1sjyFfQ05CgwS+CggXGKsS/9vq0K9tznOQm/b8bN7OHsV3B2bXlqPThMNYDLXHwV8K0aelCtziPsXkBxn+dP7LJ6GR7KkhIQRhBW5dAtGbGzNskm17reNFbAEsMiXsxPL6MSeMlzJwPSximBA45wdA8KEJZ24HgoO9xdEkEMiRyHUBKWvyJ6PGuuMAfign4VpuYH1HelX8LVDiR8BbpnNAwP7AvIqzjKzX1GH85ffjQozmM04E2kbPvLe5eT1NLCk2NYziDlMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHKSsnjmj7z31+vLY8L9qk2GNUB79yPzdi7cFPdDRsA=;
 b=PATl/wAjiBQmnpmxF06Iny67lIu+rmp5VqtsnO+P+gJtHM9lqqjXGEF6frvLYeOIkqsaZ5MXplIDPmmOYk7vhMfE97xIxx4lba2UfL6M5eS590u107A4XHnwg/CHCQrz/koDbKhmUS04949cTHRFJ3GhEs7IoD9lk/GuLx0yxL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:48 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/23] hwmon: (lm75) remove now-unused include
Date: Fri, 17 Jul 2026 15:12:30 +0200
Message-ID: <20260717131241.2233788-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: fb093dc0-1d61-407f-ac9f-08dee4053ce4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	k3NXl4UTsPFRJLZmRo7CIGweEne9ZP9IeJXm9NhSSNzYVU99y59vPmDrXsV8Zw/MPnFQdv1yf1qK9DwBlySvaGre9LzE3uShHru8wjdi0Gq1lG5gGSmxt03WQdlv5u7Xv3JXa/KKpT0PK+lX19QQQCyhd2aotEATW9a/+fBBeOzmFK39Y86mhTNWAeMT73OCDjs9n623AbQsdgFvqkof1UR1/+rBRuRiLsuYmF87nNiXwUyjbSpgAYka5e485tji8HbG5U3rRvjvR5Ga1cLD8uL4hIaB2r165AdY8LErsBG7b6tnKv7MqNDfp4NO9CK7rsgJ7VXZYmhv5c/xZCFdnD+2rQVJrIsVkHTOTtjak9ITN5HipFirwOLS0xAJjIRvVvff+7Ox4VmtIP3K34th0lwk11/prChLPkYhjxhDkTEBkMIbrAPv3k+Zg3OSo106Zn6fS7RWN/yBpMKN9drPaH1wbhK0+PMpSV4pJtdC5odrgY5Vz5LTHlZKPKUqeBmhBZE6aG4A17JPPBRIKnCfFNjmC6DM3DCILb/8/LLkjg24vs8UTBQ8/N+AvUUT0O8WXXmnnEVL8dcYnwrdwSl/bC42i+aKT3EUPmzTExFX8MOSwMmaz2x+6l04SVWB8gKjtlXbNTxiVP2uoYJFh+cymQt8p/GyCzzIMAbnaRT5L70snM0XfpRUbXXzwtmaE+fhgmvT0xkfHntm78KOIoRz48fcqRj/QdoVa42MSNaKKz0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ad/KMt4LIxUrT65bvKkgygXg2IGWwo+o44sOPbNd4fy/l04acMpPdnX7cUYm?=
 =?us-ascii?Q?ziM/89f1aODBW0iTqQgIr4d6HT7F/YYx2VKYVQW5bg3bMkqPH39idOm73qqF?=
 =?us-ascii?Q?0xBoyJhJzmEu3lA7DlETggMPfy3lFu69xS3cZKPQxtA4dQ/TateaFHf3PPLd?=
 =?us-ascii?Q?e5xujqxLPnqhQJSRIp0tS2WVGdfMvXeenaGaBJaugaHVCV08TNp8sjDW1hxr?=
 =?us-ascii?Q?iJpsPUR0hisOFvGV6VtCnIN1I+5hYSVZ4lZalwVKp8JKOTVodkMqlERmNCkM?=
 =?us-ascii?Q?0KJPN+KlVOsj6qagXSXzDApLuU86B3pU7jBrPJGzESOUj6XF3nbx9JNilI7o?=
 =?us-ascii?Q?kz7/jNe1JtA5NI/vY1Quu1krPOgLO/7lggATThHZva456rd+zNnuh0d3Uevb?=
 =?us-ascii?Q?WC96wOi0u7RdHU2cuptT3t1tJA9EKfWWzieb8f+Ayg4ZzyYCIGLOAkkrG/11?=
 =?us-ascii?Q?waJO8QtKsxytfHHeFkaOgo3HFnBbGfNP/ibl8hrwJKY/sPcJTAP1b9yQuuXn?=
 =?us-ascii?Q?HqVU8QhOvN1XlkJsUzDrzKKPUTDwB4t/IQ0UQEAeyXILtWHpxv0UD9U+rt8K?=
 =?us-ascii?Q?Zzqscf7UVj7+jxs+GirSLNxGzxn3QKvBnxsPEaaPSdlNPnQrpRX5DQkvPbPp?=
 =?us-ascii?Q?3lN4NiOosbQRcfPFwx1TxSzzXHp0EIfGOevG4l4LdC6CUJcTiP6/hCX1ObLi?=
 =?us-ascii?Q?Baw8VqaLeSOnGjM22GSx/eTm+hmw5pgvW9u17EE6avJFjhdmUexJjMjlgdC7?=
 =?us-ascii?Q?hFq0WOc+LMGi9pX2GXrYvkNgM5N4fT04UwaNQ7+jgEUX1zmI1U/BGTF/tE39?=
 =?us-ascii?Q?j9WELNHnA37zfxSjzgZmL8Ccduk/IBqyzqreM7GSsvFfTnNhV2BZ8hywj806?=
 =?us-ascii?Q?dzrW4H0BbaMKMcXVcmHmTcRN5uuDN4D3bjgeZyganLkyG6L7dzsPLbLh187l?=
 =?us-ascii?Q?Qrd1nE3mDDknOwEECKAmBmZnJWf5hYSRZG/UvQp8WSTPfez4CkiYF2MbS6Pm?=
 =?us-ascii?Q?ibu1P9ZILmLv2NMk05qu+sXGX5kmaO/UMbFseB1f9uV7UxAaKJu6Y2uucNnA?=
 =?us-ascii?Q?DnTrmVI20tQIT/xXnu0yWufrk5C5LLBcJGhUu4LxO+jUjp7V9VZQWUUgjthg?=
 =?us-ascii?Q?ZJgQnzJ4dmUZ1S+P5Tzd227cIBxGXULs7j4NYK5++xdLdn/DCjCJvtxTNr5/?=
 =?us-ascii?Q?i/oYz9pkpfxvVq9NZurlz0ieXY7pOND8H6OqONQ3nj0dbwUp5a2ctHMXXk7F?=
 =?us-ascii?Q?FN/LU8zPPfdZr8kwEnFK8kiAKjxuC1GTmFJWX0ADll3eMOBuYcjaEXkLJY04?=
 =?us-ascii?Q?BEcRowmKjVWM/qAFIpzG14NyKnl/Yk38GkRQKcYe0bwT1Pf8JokDxTCGCaWJ?=
 =?us-ascii?Q?TtS/pgGpXrWYrgXjM52Gp4iCOaRHf9ldXGNxdtwMxppWCclA7gYyw8kr5rg2?=
 =?us-ascii?Q?x2ohk4IXBCJcV5Y7cXB3FiyOGdiSD7DzuG+4V1XaSZFJq485nTKgYhhcOfpH?=
 =?us-ascii?Q?FiQyt0TnmbbZPFj0rsfORBsqByksGZFG1xtkfsi0NF+lnzDOsBdKOBkTeiSo?=
 =?us-ascii?Q?u3j03nCuDK16lWfQWyL2yJDvYDDANtAbij7/qKL422J0Mu/nqrzMbU4cDk3B?=
 =?us-ascii?Q?ga0aEk+ycuZ6o5Q/YZYGiYETeDKBVGb7N6Cme5LPZFRARVu20AfyIF0oiX8Z?=
 =?us-ascii?Q?csh7dFX4R6bGae+WpAvSBtliHEPNA95WM0JMOPhoCMsqCEqDhvrBRuhQqPyK?=
 =?us-ascii?Q?iBfdgNW0v1jQP91JkJU7N9eDx2Eato9e341EHJZGpTWZVEvimi/v?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb093dc0-1d61-407f-ac9f-08dee4053ce4
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:48.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SELPnJT3h0jK1kX+fykihsiMMXL4iRNfrJ9MTAwENcTBAQ4kwyfF7KVFkNxvk8/2f4ttVv2c6hwXi5+jgpdv1ZZKY8gm8+SjXX90YZpMCu8GuJUYXT17TbqfAemgRVV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23640

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

commit cfe09564467b8217b992aa329430897d0983e7db upstream.

Including hwmon-sysfs.h is not needed since sysfs code got removed from
this file in commit 08b024338166 ("hwmon: (lm75) Convert to use new hwmon
registration API").

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://lore.kernel.org/r/20231228-hwmon-cleanup-include-v1-1-e36f65a=
ee1f0@bootlin.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 10784d496278..58f8be462816 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -11,7 +11,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
--=20
2.54.0


