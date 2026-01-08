Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47556CF6A8F
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:30 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2998.1767864561319719598
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Q1bXwAfN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXsxMhGXBFP6Ax6FzUIkRmsrPIMA9IezCSatcDAUl/S+ab7NdVniU8itATEBzw5PSruYnh/HRc8f7Vgbpuq66d8QxtadWX/9aSgQ9PHnatlUmo3b+fk15FTuxr6jzidRTz9mtdapCjdSfWfBCtxkmNEgZOGXcQ510eaYblYphGvi3auNxFh1BKF9XaHlgrCaDy+UMgbn5kH7RMAoV/ZYc6q+UX0mwyLA9C3e+6SIVQ6/whRS69PQHgOmhErxU48fnjwliJ7+j9oRJrmffbra/J1rVLodBn1NNK78hYJrdORJdLH8+0xI1BxOHRGK0pqw7FJRCD+zgDVP2PE7GMGexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+TBAXe2MiikEwGbz6g3USKKAHR0S5ZhUz6BOx5QxUU=;
 b=Hzc/D3vEhjLT6jhH95r0q5gREQJ5XCIw9hESVTiEnTDKNTdU+xpC9Dr88ADE8YY3Vx4Ejww1aDGGXWCK/1Ior6WWoSAU9Aj5B4CDsY5BJx6lljNbwuRBHd844IfnkbpqL0E8/unr43a/pof/ClXS7sjRwUS2H0XzEXDBmECGCyrUOIzafP56jbr8Stle+p3PjYC2bcdqKgypVP9DQ5wsZ1Shfx+ElvfAk0SQiZkNh9nWRIcG6bAQdQWuMPHQg8xV758eO1XjPnLWPEroFAFtBYVlqWHMjPzh8jKxfiRUIpEwBTiPGETqP2P8VQPutLa689OnDOfwoK3RZx0MIGM7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+TBAXe2MiikEwGbz6g3USKKAHR0S5ZhUz6BOx5QxUU=;
 b=Q1bXwAfN60Nh2keNexEhSfzU3EgAGLsvf3aOFTUSe/O1PKe7vhc7YqBcgW2Okv7mWI+FdoQv+sI4iKxtiL4/brgNtZBXz0tGrgMCpdp+CPY+j+d+7vbohcb7U+fiKDwNSs1pZiP7EoUnVQGFvzBKM0OclI+z85gN/gbZap25tkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:19 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/22] i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
Date: Thu,  8 Jan 2026 10:28:12 +0100
Message-ID: <20260108092823.489287-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 09784671-eba3-4162-2744-08de4e98660a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PyW3LnFyaq0kQLuNzK5o/fYZ8l3iurn6qSewQMGhTRhf4/IXfxCxAwdCIk7f?=
 =?us-ascii?Q?ZhhQvNRokj0jKmJXcRa4rti4DYDREB/Vxz9v1iWXKOERgahQK3j/97oAWF7p?=
 =?us-ascii?Q?rlVfhvZ4hnLMom/7pixNriYkSry0bHEI4lUJV/X9MY2RqY6o8ypTZ/3ymPcB?=
 =?us-ascii?Q?iu56b8huhmL5uhczioyrUVhmPDpnB0x4tN7EtuDvL67Nexql/w/BAfy696ud?=
 =?us-ascii?Q?AHcGsfyzK6x5FlBN+pL/SmgVKi8sebiF6EeC14Lzct2gdTVtoQQOi1BujfBr?=
 =?us-ascii?Q?lCtPUWFqSRNZxv9HVDy9AHUg6/Z3N+dE92sCjEZWHhydjmNz/VViK3oXfq7z?=
 =?us-ascii?Q?HSxPre+AsNzyf7Dw8klu+QOzXFvrGBzpNnEqxjgA1k47ZmtC0V32lmTZRpdc?=
 =?us-ascii?Q?pl9QVm+Y7Q+LRPby6VvSeWRVh9JfLUgfV9GKczFDw4qYy1JTn84UD2wmGRdK?=
 =?us-ascii?Q?izARsY79i9OzQsLSQzTqCX6lfIPOGjRzOA2WTg6AZG9lf/jXzfR03puP74g9?=
 =?us-ascii?Q?PPUDApLBncLLVuI5Z7XOpapRioaIJ5Z4uBUkul1rqQ2DhaAZddtbQQ6M3tQ9?=
 =?us-ascii?Q?MXbwzWvXW2q0Jq5OiJAC/OOazjQcx0aev2goqhluE/NxXMxfg6d4IVV56DcR?=
 =?us-ascii?Q?m6pEBKX47lXUx3tDjQD+gge1opFdSQA2riWhqaJ3NPXbm1f9jo/CQrrVCH8N?=
 =?us-ascii?Q?WO5Epc1sxLkA+bRMz3Wdj4DIM/F3tumneunmFd1HYojq6IsGO4zv8wYkzJpf?=
 =?us-ascii?Q?bL3ReXxYLTrHgYyxPLU/KIHaNvHKVSCPXpuoSG1qhTjCRE8YVYMOMJUy6T5S?=
 =?us-ascii?Q?/opE1GAuIfJZ+bP1vJQUnIr++MKLsUdt0mVjA7OrSsil40Z/okZC0z/bZ/T/?=
 =?us-ascii?Q?qN18mdxaCX4kezi6q/XcI4pMVe77i6+WufiH/YMcGNkMXkV+N9VmH5+mfxuV?=
 =?us-ascii?Q?EXFzOQ3/Ml/PSU66wjrjTZ4ZG/5ujc2/ZlvdiZwhM1RTPMB44MihmkCQ8QET?=
 =?us-ascii?Q?Z5+ZkGe0YIwnHZ87g+8ugNjaIQCjl9/G88yunEs72SKEMULtLfIQbCT2ezj9?=
 =?us-ascii?Q?xDYdxBcozIV5kLhWSSXQVUidze5InsEQ3JRLPRop3G/UkxMIOM0xBiqqhF5R?=
 =?us-ascii?Q?iAbZIY2txMoVzwOOsGCYs5Rfnn06HyAErHGv5BQcKwMfShjlZIYy+7o1khSF?=
 =?us-ascii?Q?pvJPXS+VZqNtVJTQLNWEyE+pY93/ZG5fZb0xU9exAl5bMajYDq5JJVW602uM?=
 =?us-ascii?Q?Zi7ANqplE+2b1Qiw4IIDqMZzDhhDL647dJpRfbaZYNHWxPLaZCCBIfEYDet8?=
 =?us-ascii?Q?q6i9TUlbjkLsDo5IoPssiKlsIOH46f5hdWA/1XyXFI4LvckvuXRAZmHiz45A?=
 =?us-ascii?Q?uoLwJ1vPjFYBUUHr7NhYn/qQ2D7k5qXW8YZDlxir7IhzSfkbsZxv3w8VAW0F?=
 =?us-ascii?Q?tMN2UWTqQY/0IHtBGaucCTaB916NiHI0wIfmib4UQo/CTan8iMino4Iv/t5H?=
 =?us-ascii?Q?0YIMMIMx0feqBNwzO6meMKVStwFWBFvfG7q+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BCzx5BAxUBHdZXJNN26xv71AEMIJjsnVMNiZYBsm5G2vLxKfCoOJZE/3p7fN?=
 =?us-ascii?Q?zclNHBjquw9xRGsN5cE6Zrkm9JYIqHTBsebh5Qu4IDXog78+zVk1uj1cZ9mx?=
 =?us-ascii?Q?E4G/B7LHWNJKeSRDP+Zwn6Y/bKYdysLQjiZqQNqRze2BUnhRsnlii/Al0aBZ?=
 =?us-ascii?Q?jZNJVN/HE3ZrXpAX6HmiVfL3p5HejNTI0PMdQF6BzLbFV7ipMAclOiI4QVJu?=
 =?us-ascii?Q?+nl4ycZKFYBU1r0Ld5AhtHj6t1p1RscZkATeDrrBZqs1//AwPFTPH8YALaOe?=
 =?us-ascii?Q?rxIcLrLgCVlA/sX0Zw1T4csOVwajAZEeNpIE0aogURtihjd+NTzjI4brBE+z?=
 =?us-ascii?Q?lpCkKon7s7tzkcU+yGW2gu7GMKlrTMmAgKxULsQSlW9W016YmTLkOlL2b0O7?=
 =?us-ascii?Q?JeylNDAqBuHN/apMsgomoH5vKSanIJgEUIysqm8/JRj/9LtvcvYXEJfljM7B?=
 =?us-ascii?Q?EU8cC5mYfXBKxZoh/yU+rMkyWayy3w8lbwAVMvMCvkbVNZUj/NZOrfqirYBL?=
 =?us-ascii?Q?oRY8TctFoJPo9GdY8NtEGdmf0pgMqLiIssONHkVhWmjiJLVaOJBcz+UPUtcp?=
 =?us-ascii?Q?F81O+Kqql8Rjp7bTNHJTrqIJfzbamFvs7rpl+vgpEyD17y2rxNU32AKuyq5Z?=
 =?us-ascii?Q?7YoEAZcEPLiIlcUAEC3BOpIrFpha/EkOJTX+LlKvDjJI7ummqeobVv+EQ3cc?=
 =?us-ascii?Q?i7HrkcZTmhqh+b2coZt+15eOctujCz/TUVAd5brnZXeVOVWWl+X4DjOyJFma?=
 =?us-ascii?Q?+emWMzSt6Y+O0SBBuWC1ZUNx3I1oOFdPj0+awha16ktv/3AMlmHmEm43lMWm?=
 =?us-ascii?Q?hEPr3Krax+SRonCoVQDu2Oj4uBCyF9mc2fUo1sOzZZ4dXDmollCc+tEXZtKF?=
 =?us-ascii?Q?ABrJKfsc/0bEbjOt8RskGUYkSvbgXnEG7XNraerryuRJuCs1u7iL4fKzpCMx?=
 =?us-ascii?Q?AsiPzB+r82Bd58W2jiqk2fujfmcaX4fWVirLlqKL0mY52kaPztYLd9OaNN61?=
 =?us-ascii?Q?NFdgCaBr5kss2li34JMpLBKTJ1vN0UEXCbcIU9gsd2TZr8062oTuILhDZaH3?=
 =?us-ascii?Q?gWP/TMgttJsd+m5woGYYhgtwUkBlTJGksuOHmLWYj5ODgday7BJK69wA1mli?=
 =?us-ascii?Q?rfaAlV15JwLsdd+2fq48IwHoazQHtNOv7LhhKsRCSY3lI2WSf+N42NEqenGU?=
 =?us-ascii?Q?NwxBfxdE0S5wdbs4FQD10OXsct5CNUPXHGniLhi/qZx3b2yF1a2sj7DEjL8a?=
 =?us-ascii?Q?kNQQNDhsZ/yDhHRbVB4H0vXiQYPnWbS/EkrM4oVkFHGgEYP8GUoC8WwKme8h?=
 =?us-ascii?Q?l1UkwW5jxvrN09OLgepxNzLoG8KF22XHqPrDbXgOrlL88D2LjHz5QEHNFXs1?=
 =?us-ascii?Q?3s1HIaDXNR3fvQpDVwbjHH0R/+wK+iQs5P6afuhGcCWVey48O5EZN7OhPqhP?=
 =?us-ascii?Q?sN8xGp/lsYnx4QkBBnCwrkogf+5AC5pi7oAmrtVtBDXKr1dJnZiKjhkBBrZv?=
 =?us-ascii?Q?Qw+kAnq1m7Vr6frzBzIVN3T+bjC1EoLEvgUnw9levB2q2rv4i90eucmvPNoL?=
 =?us-ascii?Q?9kVbVoIsinH1EZOqxY2a7MYRQRGwBtTACB81rNHQG/0woy35Fs7EvAcPa3e3?=
 =?us-ascii?Q?qfft/u3oK0dArxCJ+gQ2eCA6Inu3vr1ZInGLmw/7LUuRNtp0frbSIxKZEHxm?=
 =?us-ascii?Q?XZ2fQKv4TPPDgNXQdPY5xsR0mrdrde5rMdn844AOvbatBYJdAOGTzYi4mW2N?=
 =?us-ascii?Q?5Y4kqSJedSwUd87h6vHjrULbNQleBJ2Y7fbbPRp5QcgNCpvR6Xgc?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09784671-eba3-4162-2744-08de4e98660a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:19.0382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCRlN76HtrJZEpB82k/8tmq7KKq1hbzWvrPqvHSlGyzbuV3eJC68piCZsZNkMisZFrkWkwOjrl/BJbFJ626vAyNFVh+qyXKsmhSn2+VAIeoNOgiL/GHBiQOR361dKiw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21447

From: Jorge Marques <jorge.marques@analog.com>

commit 733b439375b494e8a6950ab47d18a4b615b73cb3 upstream.

The I3C abstraction expects u8 buffers, but some controllers operate with
a 32-bit bus width FIFO and cannot flag valid bytes individually. To avoid
reading or writing outside the buffer bounds, use 32-bit accesses where
possible and apply memcpy for any remaining bytes

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250624-i3c-writesl-readsl-v3-1-63ccf0870f=
01@analog.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i3c/internals.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 1906c711f38a..d16a79953709 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,41 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+
+/**
+ * i3c_writel_fifo - Write data buffer to 32bit FIFO
+ * @addr: FIFO Address to write to
+ * @buf: Pointer to the data bytes to write
+ * @nbytes: Number of bytes to write
+ */
+static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
+				   int nbytes)
+{
+	writesl(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp =3D 0;
+
+		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
+		writel(tmp, addr);
+	}
+}
+
+/**
+ * i3c_readl_fifo - Read data buffer from 32bit FIFO
+ * @addr: FIFO Address to read from
+ * @buf: Pointer to the buffer to store read bytes
+ * @nbytes: Number of bytes to read
+ */
+static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
+				  int nbytes)
+{
+	readsl(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp;
+
+		tmp =3D readl(addr);
+		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
+	}
+}
+
 #endif /* I3C_INTERNAL_H */
--=20
2.43.0


