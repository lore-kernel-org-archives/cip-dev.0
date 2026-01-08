Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D307CF6A94
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2992.1767864544907232297
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cAmw6h7i;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrpNcwThHp1DuG6DEXUPbYGhP2hroT0mHCBlZE+1sW6H2vwn4yarciKpc/YgEE7oBi0KbwHBnHRQ6GShKWoi4YzHaRmRhJtn5eH2VtC5dvRx8CiIeIJfm4EhQZLFESWgMCW+Fag4lQ4CjCunwLQZhH0fm/QwEY0x7AWAUiIQk346R7ZWRMxIiLpxP+DeI5AxChp7TNkNpNG2larBdLqPonWZFQNqm/hgXrfVqVngOhP3k5319x+xhQ/hr/KpEKrVtBCODwsXf07NUARTq9+2YP+bjrntbQ02CYaai3kNxcmdHebVPSzjeIQWtHPhcZmefBj6piQev95bGSVBit7twQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsDSS9T+DCA4b0iOArxO/6vdwF62M4GmkfqFKiuujc4=;
 b=dGOLuwSdwOG420xlsScG+Laueu28UxYrb3LFOhBzCGWCWMPXz9Ya4kVLJtRhHIX+EmZvh/wfG8/tffNZPimGOR+w8ueAIz7TSKofB3dUENtHHpyzCNwtzTZB5O+92mTQQWEg9qrn1wOum5JyubDWvyAx8lfONg+mCkkanuMtxRmIElsWjmh/YWY1SiEQLQRNSi7VSnM5izWHSqovHSxHYSa7ZvDUeGTAwNNLfMPF4XG09YJdmX/0SffYox4J9sMCN6ECovBM4iHTqEKDDhQsyKPbOV8UTc855MUptfxSNrYHsCWzFTdHKNCK5XD+wgNkoYYqG6F0n0C3tWPyaLrjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsDSS9T+DCA4b0iOArxO/6vdwF62M4GmkfqFKiuujc4=;
 b=cAmw6h7iJftoxOOmiXE0uX+6hQhy8kqkIz9hLev8+zaAZrTKlXhqe6b0NnoStLsNrfl+N9H04p7zcAm8A7vHq4b3FfVnTfSVBXKvMzlG2gAc3TFm6QEe1HEquRxCMdEZHWY1oyQS6qXvTHr1tsn968/oTeSWrT8MGdBTZJMQdyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:29:00 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/22] i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK
Date: Thu,  8 Jan 2026 10:28:06 +0100
Message-ID: <20260108092823.489287-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d08aa8-3d7b-45c1-f8c5-08de4e985b0e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PKLLnKDJMdlyZHHi9YbA0f2ZEmWtzuay0WofuwZHzFQ+v2KD6WZYmFM+WnOv?=
 =?us-ascii?Q?4V9CaePRRZgsPMiSU+j06X9Da1dHP29iwH6kBZYJJpvNLDttEbyk2xvpKxBe?=
 =?us-ascii?Q?9uMti/h7K/1n1POjmo6YOYoQikCYppy51OBEQ+7oy29yPl5emIRM8AEYe1QT?=
 =?us-ascii?Q?wcaKas2UwbM3gPOXFLvelGKrXfSkgxn+w8aU1hSTzlqQdiZC1Tsbe42IHQYa?=
 =?us-ascii?Q?6I1lMYZT4jVneRTGQPWr7WDuqcjAoStQ++vwXXk2VylNnISOGasIYY8evKGs?=
 =?us-ascii?Q?2k9NZXArMgNNbi0b/xPRhWJ6TAu2DsJxjCERUwOf7rEwqSO7xaFLC9earYQR?=
 =?us-ascii?Q?avS8Z735qlHSM+ZUtbf5EfV8Fz0Q2CNJxfnU2PSurDMcC96z909sQshDBuhb?=
 =?us-ascii?Q?Dsf714i6lReGi6kZOPC6XU+Un7Pqc8LdIQVatufAvC3eSUNXzp589mhY7Eal?=
 =?us-ascii?Q?zCAP8RS/wXArDseRooyw4HIU/V3aHZTJqlDtoekHLgZ2u5A4e2780JGCAIQJ?=
 =?us-ascii?Q?lAZ6Y4xMYU+/COCgFPbsh/R2W4c6dNAyVc2BG+ExyctcqJr0O/6alkF0y+Mk?=
 =?us-ascii?Q?/JmaXD8txxl47ggbiC3Lqmce1BBavPRE4w41GNSIbIJ8gsN9H5P/s4kJcyh2?=
 =?us-ascii?Q?2QLRzqxdNC1G2CEQNE1jGPSSKPQ5ElIwDU/4NzGHH3RzeOFBIAB8I4XXCF6D?=
 =?us-ascii?Q?M/vf8wJ7TcK7iXhlW2CC+lZr6xgkgXbIhmkveXSoo2QP87lDAh12CBpjLK+p?=
 =?us-ascii?Q?U8UnrbdSkgaM65xl5Qqf1VfOO6HGwSx7O4qXXu8BOhi6DYD4EoVh5CxImXCu?=
 =?us-ascii?Q?FpIuC4tmg3/WSxa0wfFCeLhbQYsuxNAm6PyTSqYfOncJw9h/kJ9XKkJMJvyq?=
 =?us-ascii?Q?ZsstO0lDkMaXNkF0W4sP4pfZvb8ZZYVE/d3GPlpYS63j7D7nBNb5gy/33m51?=
 =?us-ascii?Q?MspcCNZCHEx0OTSEkXkWC6FAtDy92U7k2tuZ3XgzhCTvZlJLclF3dbKbH5r6?=
 =?us-ascii?Q?BkXExJ+5D7I4X2E/UIu9siv3y3o6oC+BJ+JpCUoDt/XPhTvLk/UBxjzkLJ7B?=
 =?us-ascii?Q?hF1/Ps+A53mQ5lfyFR7xBsdfKAOLjGTd1DQe6B6wm+5K9EOD3LIJOIwuJr/c?=
 =?us-ascii?Q?83L9b0KbtQ47id0/4nl2aE/Qt8Xc9qGRwqrrZWGrWB8wOviCsWN+uuhYIJDF?=
 =?us-ascii?Q?3zx2yuIgzHUpdYw1X63v1eJ3e6yq6P+icpHom1CUnU5bVMh0v9gNxBJdrVtz?=
 =?us-ascii?Q?ZiINRBcwAbf/S4yDVvRQBQ0281QcNfeNScp7Mq2Ye/FC0vFq5Vw4jZxW94mc?=
 =?us-ascii?Q?qLaCG8fl2lZFKVT+HuzritxQ/fbxDf2N7ZkBpsu+hZLWq1LdYHIA0yzYbwmG?=
 =?us-ascii?Q?KNg/LaBzWL1r+NlGda9P3Uud2XLn8i5lhKo4GcI96Xd/PD/SM2eE3JlK7hfe?=
 =?us-ascii?Q?1Ot+3+ivBiD7qdSqU5LjkxYiRNmAXXAS6iQm4ViMC5Exp/ctVXvOvgPtpeMr?=
 =?us-ascii?Q?NKG4OzUOvKLtHtj94uYltuPR7ibp+Kf6hx8/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sCRRnIueiXsedanDCc6Qcq+a1aFm9BRwlJ9NNEOW2ADY3H03UsNwwQMHHtef?=
 =?us-ascii?Q?S0TPQhm3uyql1Fkv3SoAwcQZjlL3DtCpPvkR+2mKjv4Zwh+dl5hC5lkjBKNu?=
 =?us-ascii?Q?s7jW9nYw6/PWble0HzC2q/rsX4Y7GjT9sXLZkEAo9lkitijABLmBHUpt9cal?=
 =?us-ascii?Q?Gq7+2FZbzJPcRQp7DvWavaO14fAEG5kBT2Ae8sO05nFDfkif55AbVVC5Dc53?=
 =?us-ascii?Q?YTgkjWEBCQkEJ+jDZPjuKZQeEqIuEsOwDIiB2AdJ0qN0sDLU0SiiipCRQB0i?=
 =?us-ascii?Q?kFS1oE9Fot8bly2SHb7/BeHCNO5JEotB6BAjTNnRWbs0L9MK9XIqNDl+mWjx?=
 =?us-ascii?Q?9287zQp+qQxxOV3Lqtx07EKU8EtlzXHYgheXPizgopMm14EztGRKoHL/VZI3?=
 =?us-ascii?Q?whzBDuCFv4T+A1nYniBufVq2MJPJqMPPiltVFfUfRMhoTuJ+EZ1/pr8iE366?=
 =?us-ascii?Q?AbklvvxsxtbjjgFwAbqsmX4l58mY0/0KuzC9X2cK3fVcJs0gw16OKBeOt3jd?=
 =?us-ascii?Q?pEPQgTeqJrz06vwTxMyaV5VmtvaEPEFnpSlM9jiG+gSeVmY0gXDQdlxshXIK?=
 =?us-ascii?Q?4tZzVBS4JIJlgzKnq/UdU4yNiHO/Rbe55f199bMk47fTs7jqrDHbkSclVCA8?=
 =?us-ascii?Q?AHnDoaHXhNfUW9VcFW6uEywgYp+R0vjqOaRR7AjoCz6N4i4I4HGx8ycJOpTB?=
 =?us-ascii?Q?fgWnr/gxqHrnR2BfEN8Pi9EZHSV5PHK0YIg71bQBaCWtGpUhDrZizcOov3mG?=
 =?us-ascii?Q?1ZwWvZXv2ZtsFdjdzVJsY+Wp935wI25zUtp+5RvE+wxzEy2F2kGxz3HilnzB?=
 =?us-ascii?Q?RnJ8mD/rOcpjRCFhfBvONeJRXtiGarTmIsRsjIFzaavWRNKhzOelOe3N05Wk?=
 =?us-ascii?Q?7NjPLCbGUWFGF838Z9oF5OSjn1ZFUtt9UBCtPjC0dLhKvBYgYdYocJXn16Be?=
 =?us-ascii?Q?psZlfVaukLgHfwpndGufZ0EAfcCEiS2qFCXmpZ9Edc8MsVOdLk+WYnmAyT49?=
 =?us-ascii?Q?/+iXloHA/S/ySrxy/760aP5ehKTPgG6qegjMQl6p8gAu4cE4DU4ZvDkgrE/K?=
 =?us-ascii?Q?0w7KwUBI0sI4yDTiTBO22lL51CFFIK3KFd6242Lw4372bZrAS13y9XbIP56n?=
 =?us-ascii?Q?zEfIge5cM8bskjQ3z8lfbH7WWtKlc4bKq11eRWMR8PFtSX9Nv9L2KGq4uQ4Y?=
 =?us-ascii?Q?kec9IcSwnJhTuBPPlqK9jeq2p0wgeNJhKhLM0wLDURGYRG9GpyaltkfBQwre?=
 =?us-ascii?Q?mB7ONVOCMC07qWCrd33Zxk5bkUAA5/PH5mvoCnXS+5dHSgPYmyrYd05z5r+N?=
 =?us-ascii?Q?zpCS46ykvZ24/8gXDrRkg0HzIr0hGOeb2THRstgmLf1zsyMm/Jz60+qal5J0?=
 =?us-ascii?Q?UnfHpCBfJBm9qn0Livv0ubsQSMqJosabrMt0WnWOwpGrEZdf95XGs/UmeyVV?=
 =?us-ascii?Q?gxjR1oEzHpvNmoo+yeQ5p8ho1ZGDP9uMudCI/6xTBCqmvdPOd8gqsxjCqOqZ?=
 =?us-ascii?Q?PbgWeF1c/UegU72I6nh3fYKvqcodEeYAeztFaWfA6Lq0Wc7HADD0K1RecEVy?=
 =?us-ascii?Q?6DUl3gBmdlovUJLUpc1lqrO+M76UnF8WRf97RqlXYYzmfUQkZBqb0xhfRYTA?=
 =?us-ascii?Q?LVaGowoyWdfAoK66Fo6kYmVbgHMQubSrIdQA3QoVsajUl6A8eaxVXeQQ15/t?=
 =?us-ascii?Q?ByKReZOjivwk1A8PIf294xoGtZUXmB5939y9gkdASW4NPe4WgXP6a+6TGJ14?=
 =?us-ascii?Q?H9dJEx4iEdNNm4peV/kNtY/CUqwz4WW/TJ4lzypDN9GLYYoX4mw7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d08aa8-3d7b-45c1-f8c5-08de4e985b0e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:00.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9Rd3ZeYSicU0jaU+YsCNx0sYL+PB3IpC/cUZpzarRSxCSKlBmaaXsuhi1AeyQ5r95FJG2b/5zClQC1cEOI+0G+2olPG55/YQysZuXlEB+66DCDQjFyTv0GUkk/F1vg1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21441

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit f6ca73063754950bf3fbad753e3a9557e3aa85e3 upstream.

As the mask is part of the enum, document it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20241102132841.2446176-1-alexandre.belloni@=
bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/i3c/master.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2f731c6c16ea..a82a3d5b00e1 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -289,6 +289,7 @@ enum i3c_open_drain_speed {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ * @I3C_ADDR_SLOT_EXT_STATUS_MASK: address slot mask with extended informa=
tion
  * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are p=
referred by some devices,
  *			       such as the "assigned-address" property in a device tree sourc=
e.
  * On an I3C bus, addresses are assigned dynamically, and we need to know =
which
--=20
2.43.0


