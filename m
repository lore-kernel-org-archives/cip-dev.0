Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA213CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:33 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.web10.987.1755705984726682326
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BlHlg9n0;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD5kQi1iVVzniDB99uRo1ImXwavcDxFFTqs3fkS3+qOzRuvx6IoYDKVxJoM42C0a6OjgQDjurY9a+OD7ie+000dXOGx24/sgF/I9UUkD16iierbpx0yoSFogMrP3414R5yPAiWMbC26QvqYE91APe+it8yM+EOxRQBShxBuhO/hui7Dn3C/Op+qYsu1rcQWLwNqMZmQbHmNxv0L3GQtLCzgGeBJsJdnjRg6GLkWPSwaovpC923eE/y9pQn+3WabO6UL/64JaRRV/1tb3zkRQLuyYDUTCvBLsAFJJtsVaSStTeyCT/hF7TiSNVLJyRTgFlhPVh/7GjbE1ipEciTMWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/gcGjzu9u0vdlo6sxeafi7ilkIT3wU74cQiCpDejzI=;
 b=ffiqox7r4KTYN5YVcyTLQWih4w7JXfuYxh8EglEuO2UNAAhP+scl6CK638hZI+s42nERo9qzY/dSfh8cBktdrfVfhJ923zkx4EZL6onaHJl1IaaKbHd5V9+pQK+y3XQzcdAKDuY/8NpYjds/G0DRhFEFEpBGwYGc0Hw8wP+cP8JITvhzFbmhotHez+0I0jvcjyAwo715npjEavm2EnILLCQ1WDH5IYiE1ke8ActlNj2RrBvG2vbymz52+1MVH1/ldZwW4PK1GNSaKfLPaUKSCi7cY2utUypgVwW+A4/vbClNo/uus+WVl+sZZfwDp6W3wwZjh0mElvDibx7iPDj5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/gcGjzu9u0vdlo6sxeafi7ilkIT3wU74cQiCpDejzI=;
 b=BlHlg9n00O3g3Nrly+EqdfPsMegwz4LKbwAV03RLOwF8XXqSANj5sZbo8nhNHqgekOb9ncEB2QzoM7wkHZ4IYf/E2zi4sx0IxiDlpsBrxm30AqMqG0+t7XG1eMngIQ138QBNVVb6CVTZEb7U0E6Yc9VGNmrtbRme80bEGwx7qrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:22 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 41/55] media: rzg2l-cru: Add function pointer to check if FIFO is empty
Date: Wed, 20 Aug 2025 18:03:57 +0200
Message-ID: <20250820160413.801341-42-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4910de-5b86-442e-f3fa-08dde00381cc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Dwjz8Dx2EsSi9D4rTzQReibQvAZlxCA5tXSUmFo7rD0w7GsEW+C6/NVZqtE3?=
 =?us-ascii?Q?rSNasanlMsW4QpPHZQdCf1yYBdy2LsBTc9ieWZasskL86NtiwAh9Kb4E3xHN?=
 =?us-ascii?Q?Fo7ikerOlRox7zz1/0+cn/OVofXkJB3YPn3Bw9SLcydAykCLn4h3iq1FW899?=
 =?us-ascii?Q?YXxPqZkVBroJQXQZV7AevZajFW7SmAVpohuaHwatgQoTe5cNEFAfo2wUTjYh?=
 =?us-ascii?Q?4kCZrSll1VJTP0nnvwO2I/eQ7pnyJKCPPqXbjvokz1Cw4ALOLBwa9zckngBw?=
 =?us-ascii?Q?7gE1YFear6LoCITuojFAXtCTOZlf/eQzx1URu+a6Ees0mkFAwug7C0ZSZymJ?=
 =?us-ascii?Q?BXPI+JtW3SnwkXoLm6ZwkgD3855VYD0pBUjroj20FDWzk+5V77b5OeC2NkQY?=
 =?us-ascii?Q?E3tvwc8gI2Io3141uvAhmr+ol1JP6l0y8+EAMZc6PU2HrVsiXaEPfMpZKZOt?=
 =?us-ascii?Q?s+HyeXS+eT+akRbcuIi9gUjwyXs2PFSSg/sj3CpR+dZ40XQPDaubMR79Mr6o?=
 =?us-ascii?Q?8cBS3Xmf9kXiadFVVJ7jIZ0KgPtJCzbetdbdkZalQFPXZiE4nIrlbgm9wl+N?=
 =?us-ascii?Q?Qpy/hr9G1ETDvp/AWFLWOEVg72HNtBP0Bk/MzNTJZUSyA3Ml14i+X+mXclOd?=
 =?us-ascii?Q?lC7+tSvqtIlnBivLd2C02TycER+xuHXSN8ot+Gz3q3Z01DxNa7vZxc8PfKEm?=
 =?us-ascii?Q?ZDP+hbtJqCAhUFWBrmUqQILrIsvID/5n1ZqemQYGbZVIZs7Q1rWbiMNZTfkp?=
 =?us-ascii?Q?o83HXz4IZVn61Xx51rDsVdUEOZVyW/K2pGUssjAlabIK/t2mFhgwv8U/zW34?=
 =?us-ascii?Q?XRWQ2CcjhcK8U+zDrbLEpQqWQaHj9PcZ7QyroslGHFCiLv9ik/OlUf9JAgrz?=
 =?us-ascii?Q?+DnZZyEUWyiL9UcT8gQVE5kXhwOzRndSV/8bK7UZAf+tWSfbJHHqw+RSYW18?=
 =?us-ascii?Q?sGhutoDsH8c5kwqqByqxzlirtxxBZqULMzrABwvpFNDaT3M7Z98IpH2PyQIC?=
 =?us-ascii?Q?KEmhoQfLQekUTRZAeciG41F08b2ooSl0yyJbmOP2RohA0ymHXgm10PZQsZyo?=
 =?us-ascii?Q?qfQJ9VfLBX/I6RKyRo0fDAzXRCKVphegm/DR7nq6dACK7Q5SEkEwGPaRmyjM?=
 =?us-ascii?Q?C1QH65h4EqmDWOX7ydDNmYfqlpC0b/5NsDQ3uk/N2NFkAeN706TQByQqUbH7?=
 =?us-ascii?Q?6/Yh8Lppe2Y9X0nCBqVWZh2XbDPyJD7SWJzo5P3ldElnw9CAmywZEDL4aLeq?=
 =?us-ascii?Q?OnYGUbY8HscbwegQU8hI5AI2s838Dqjr9QHeHHyIH9b0cZeglFbUBOt+vw9f?=
 =?us-ascii?Q?rusiFIlWT7D754MfFgMgtdcJ/YiOf+ACDBKaqjGLQ4xeKJ5x3IM58G6POrOc?=
 =?us-ascii?Q?ModxiRy/hBWSDbr1iPLaqyB2cTppckefzjjp7oqeC/iNXkE8KnOkx/iUvafQ?=
 =?us-ascii?Q?3HnTksHxPmcxK5c8F8PPtYup3HBviSlAeChl/EV4gRZZvoSx7qKFwh3kQxU5?=
 =?us-ascii?Q?71k9stUcJU5F17Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fxfgqkjWVfK4DdS1DoYRubo0EtTn0xjnOdNp6WI0lExVpFJhaQ269kDsE963?=
 =?us-ascii?Q?tHFhP0vnJrC/O8Sw9zQmQQXQAuxWLJJt41A3P4zQl05ok+r/LgzIk0Vai7vZ?=
 =?us-ascii?Q?k8qfbLAt77/Y8kMQ3bfYQDVbJUpHdCTDuBD6rzRX/F4EWj1xhWFpJbiLpaOH?=
 =?us-ascii?Q?5rIPxDju39jnj4nwXuJLKzgozaAqeEmNDW37uyiJXSoCcXSVrR9DYqE9+QVC?=
 =?us-ascii?Q?xP1aahZT9Dqknutp5ub7C6PA7hn9BAkFEntxPlKVx1OVDBtKLzq0OwwjZILc?=
 =?us-ascii?Q?2c7gXA3nkM5EjDUQKYom1WUnKCD0AmNgddHJAuykKaHlri/jtnGeA/KN+R0J?=
 =?us-ascii?Q?ax5fISnI6qvHXb5yEwXV/4v5de0XpMrxh3zhr27Gej96nnKFkWY0iG+r3O96?=
 =?us-ascii?Q?4fW3RJ9XWGCBl713jM82Uds1dbT1O4ghwUJ/qmxwWyedUXHJtkiU2V3r45cZ?=
 =?us-ascii?Q?qKPrC+6l/Zqq7FMkhprH3cXHo3x9lVtUdlX5z0U7Uw5qhUHw5VyNc3HXywxI?=
 =?us-ascii?Q?6bRh8+bISYB8hHhcCejjtc3Uy7pQYOQKcR6ga/EZoCvovrQqy3zIHI7vc28v?=
 =?us-ascii?Q?zSluvzi1+SOkWW0gIzi+H9EDPHeYK285/Fyu6GhenKHC3aEGeVa6/iSJownE?=
 =?us-ascii?Q?252fpH3SPhiE2P9ZFfQXeZQwIznb5BTraAPCgPTmbFdCXW3kTdOfqrR/MwL5?=
 =?us-ascii?Q?1K0ngGPbkck45fq76wsGdftFmwqKQBHljLRw3lZhT0wZ5v6ThY49skMS2V5I?=
 =?us-ascii?Q?PmbEmdeAxxDdameFUK07xf9rFYEyZRThxbM9SOcW1aEPyTIk8VTubPC3VxV+?=
 =?us-ascii?Q?aDVZKIZPUZEExgc+gmMhCACxtw7TjSgB+0TazFgKHpRU44Or0DwGUA331sV9?=
 =?us-ascii?Q?E0c9cf1IKpBSjVoxjFFxfqYcL0KT9nZCj6STRsD9uBt560tpH+fSwiCl/lsl?=
 =?us-ascii?Q?QmD35av2TKruhdLy5KXEG05wwaJICaYDGAUkcAFnmpABSLkAU7FOmkSkonAK?=
 =?us-ascii?Q?oWXgwOHW93TxmajuoIjJQiOOPpyUUIYBjDCU9KRI9J1MyX2gUQI007hSmsjL?=
 =?us-ascii?Q?WINOUMF5mNVGyBqHyR+NelsdDClidUATweDNlLsgrwqKlHDPo7Rsgpu14xFY?=
 =?us-ascii?Q?6Cfww6R2fUNaf13wde+Rr7fmxnfw8nnngBqeySX+2qVTJs52AR5BVT4iqRzX?=
 =?us-ascii?Q?R0QRZEnZ+iljiEjWI8tIOl5dwYCbxwL6KZain9hzfjyAXFSJK7smlOwJfZK4?=
 =?us-ascii?Q?vZbYCi/mJr2DiF3yWS9VOvS1GCtqS8xQYusuMr+3ZHXD8TfmFVGuuI/LKCrQ?=
 =?us-ascii?Q?J0dFa2xruxNJ0lLB8HLXZV+nRoUjXFZtHGGJb/1cPUDzHkBoHzqBcvHkF2h6?=
 =?us-ascii?Q?WhDKlVOmSQVxUMRmreXQjgCupYHxvTfaT39D+g7Dn66fSzuRzQ9LdAmVL+JT?=
 =?us-ascii?Q?bJw1pOzMTeMA1sCR8SNQHl4AWxFjxtd/YUxuGRWD3OIscnTNltpNY4NKRCAd?=
 =?us-ascii?Q?7ybaj6FRJHrUqciInlgODR6brCfdBoR1P56mxcKn1EZPEjWgMDb91wLPMFxl?=
 =?us-ascii?Q?xQBRMhGMGwkFL0qjivJxLnIVpiRNlShhuaxG7eAnBDTZcOx3XSss1rEtwxTR?=
 =?us-ascii?Q?5/h0cmze74wsirYafvdhM38=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4910de-5b86-442e-f3fa-08dde00381cc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:22.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6AsHJrr8sDJ9l9BnQFb7oF83eY0+5FpQ0vjd4VewsAObxcLqnRCzVrvilHWQWh59lk9si7aTmsYcluiVmwXAvW7KmMRVvSzOgCYBnGI/DlHDdhyTOA7fv/TIkKhHjMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19866

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 446c645f7fe480a4420072728faa1f261530b984 upstream.

Add a `fifo_empty` function pointer to the `rzg2l_cru_info` structure and
pass it as part of the OF data. On RZ/G3E and RZ/V2H(P) SoCs, checking if
the FIFO is empty requires a different register configuration.

Implement `rzg2l_fifo_empty()` and update the code to use it from the
function pointer.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-16-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  1 +
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  3 +++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 23 +++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index c3da7dbebd8d..1f01b4dbbcb6 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -362,6 +362,7 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.irq_handler =3D rzg2l_cru_irq,
 	.enable_interrupts =3D rzg2l_cru_enable_interrupts,
 	.disable_interrupts =3D rzg2l_cru_disable_interrupts,
+	.fifo_empty =3D rzg2l_fifo_empty,
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 2084766a658e..142c158a40c4 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -88,6 +88,7 @@ struct rzg2l_cru_info {
 	irqreturn_t (*irq_handler)(int irq, void *data);
 	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
 	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
+	bool (*fifo_empty)(struct rzg2l_cru_dev *cru);
 };
=20
 /**
@@ -185,4 +186,6 @@ const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_to=
_fmt(u32 index);
 void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
=20
+bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru);
+
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 54967bf5a850..9b4366ef910c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -290,9 +290,23 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2=
l_cru_dev *cru,
 	return 0;
 }
=20
-void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
+bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru)
 {
 	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
+
+	amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
+
+	amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
+	amnfifopntr_r_y =3D
+		(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
+	if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
+		return true;
+
+	return amnfifopntr_w =3D=3D amnfifopntr_r_y;
+}
+
+void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
+{
 	unsigned int retries =3D 0;
 	unsigned long flags;
 	u32 icnms;
@@ -320,12 +334,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_=
dev *cru)
=20
 	/* Wait until the FIFO becomes empty */
 	for (retries =3D 5; retries > 0; retries--) {
-		amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
-
-		amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
-		amnfifopntr_r_y =3D
-			(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
-		if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
+		if (cru->info->fifo_empty(cru))
 			break;
=20
 		usleep_range(10, 20);
--=20
2.43.0


