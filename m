Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD8CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:23 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.65])
 by mx.groups.io with SMTP id smtpd.web10.980.1755705975111979232
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tTs1TBrh;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6pNMpZBhM1VgK+Q0R6gEPztA4XYF3XOtblw6I25kgM9Ck5WBtCCIco0IVPU+SMTp6nDLCmpbLMErIMtqKAT2YLQpEPupKg05CFTDqlQamZW6ct92fnLC6Ji3ebzUc4AAaywKcQXvW+iN3tdRz4F0jnVdhDRgTei6+FrdVbDH7y5PCldyoMoDKc8lUMmgnKRdtWcrhL1oBIbQgEr6Hq/ixgLYY6VzZG4zXk6DYYDYLt6f0EfOqsyOtO+843BuGDO7DKSIFYXmDuwMCOVXDdOZnNVaLZLM1Kb9/NXYTqudwGQMQMTdJ5mkqL+9uikrEPtK4EgYfvow9CHcHb8vkP2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1thsTp23fL6tscXBIp2S89wSmjicD5LSBLLPNM+Vl8=;
 b=uYYpvlipns13o5tFGCvs3juzK6UXc4aeQ1TbJ8DVfZ2D9npAwfhg7JDiaXF+asinazrlFPJS1gU5vjzusqTLxzTyJ/rLN9qj4UztZg1b+YkSaf0yUQ4jsq+amqQHb77x2FIZJpLP5+r6AUskS2SzRvmtp1I0WyXRvYRa8eC7pKE8J//PXuADFuS+dpumkN+QlpGmKjemTUfKhTTpilsPtQWpLwXZRu+R7hvlDb8+7kdeFPswLccUtFVxKlL7njgyDZ6gXrqb1ZJv2jo4zvQ/W4iVAh6g9Ph84MwE4ZANOcjRWgPdY7hXW2WVozoMaXD8yALE9fVXOMQ2d4WxOiRyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1thsTp23fL6tscXBIp2S89wSmjicD5LSBLLPNM+Vl8=;
 b=tTs1TBrh8f5nLvNm6/qapMogCZjr234rQLsbPziR6qvVZBwvjuiuulPWEZhKOKKf5HWxKbNwKDOgsfqaSYkbAvpqTZC4ZdcueoObasOc4MI45P7VrdbDZ2kcnbSWeYYIPosMNEjjhNIhiEEDkJvIfPwf3hl8bPFBaW0r7XbACp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:06:13 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 37/55] media: rzg2l-cru: Add register mapping support
Date: Wed, 20 Aug 2025 18:03:53 +0200
Message-ID: <20250820160413.801341-38-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c63198b-bbdc-4c47-3bb5-08dde0037c2e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Wep+bk0HBKHrycZDN7udd1zxyipa4tyXd3F5wepPIOC7e5OLoUDQsmmTkrCU?=
 =?us-ascii?Q?57Pn7nPNtaS2xRCMWUriNEgExwAFZgFpR/uttSq4CRf74vyqLQ86SyozUE8T?=
 =?us-ascii?Q?9pGlUJ1wmoc5gYb3nA6I4cYvQJ8c7DlbCEQFiCAc16O0YJxeGZDSamjygtsv?=
 =?us-ascii?Q?rb4cDfBsKt2KexKDUHgEiEgQuwC3eHJ6LRaYG0AlsOgwIxrxutDqYd2adsZW?=
 =?us-ascii?Q?vwKA4BjpkcBFJFWIRobYcd0pMXqm+RfmN6I/JicWZ+8nkdMAdZCh831k9Z1h?=
 =?us-ascii?Q?QwUuxouH2QqXeoUKkMTnCSmYSENqaCUvoKI0AWUQqPHmNJr5MNAECBWuqgK6?=
 =?us-ascii?Q?x+jyZqmFO1fjEyT7caxA3uvEJapU80Px6z+K3sYZ3jp9LjBSwYUqZIEi0ADI?=
 =?us-ascii?Q?YpkzHM4lW16vQPQBNoTgc7nmnirzaGtmebe0kVmZuAYkcdQi7hIp27EAXJGc?=
 =?us-ascii?Q?aRcpaAEYBdMcWBJqXidam8zM505zRwGU9PoLc6rIDAPE2raXEEf4sdS4fM6y?=
 =?us-ascii?Q?rFz80ARNmr6D/FxL7uBciPoCFeNxu2YAJbPwGkGTyXwySKGA+Y0iUMuGrqqY?=
 =?us-ascii?Q?cM1CIEJiW74+r9HBwsDKJxKHEphjkn0UW/bSv/zhKM5PuKlHhW+MnNQMJ3nH?=
 =?us-ascii?Q?B66Jqdhvzbvmp5daEx1lEvUcQ5Djd5MX8fH6D3DsMvdQTR7PtPGilzhoxPmR?=
 =?us-ascii?Q?LQGPBSm5tf5VeK1bq3QS+EbGSsPpGsLoUNfwIVX3KK0zZuWdl3AkzEbvkpLg?=
 =?us-ascii?Q?DexvJpIbSWBMXjkmnJbpXsji3PMt/MHp8PcIitHi4gn3ChKgvv7K72Clxihv?=
 =?us-ascii?Q?cDxVQWi4GIP1YHOho2Ue6heAvvuQrkc0UDOiugplC3G1ofa7JQPscxNOXUaD?=
 =?us-ascii?Q?NMdJo8dK+zVYpfBGGsCLae2w+7KESf7BzawhhdczI0dq+6eBNfOm3/9N1VQA?=
 =?us-ascii?Q?K1Yvl4pcp6ewkRL3Ln86KlHfza1sPtI2nz+GC7IvhjQzlkLB5/xbRXbsjsO/?=
 =?us-ascii?Q?Xz9Yn/I62/adtOnJJJ5GO0TAQgVmfb7p3o0MFR+2ZcVf34etLhqeFc9Kt3vo?=
 =?us-ascii?Q?LapwBR9aTQ5R20b98tRz8myCh6QtgxwIPWO+mTY6ayuNuS68gDn5H7rhzd9a?=
 =?us-ascii?Q?72S7UKGcquKFq5TJTeyhZM6/kbAq4kZRnL7pKyPh357kVErSOoU0ZzV5dyHF?=
 =?us-ascii?Q?E5jgtcUSBt5rVPNf9PItZ1YodhU21FFs8GsVM9Cr3B8YDUPWsgwsC8BRoxR9?=
 =?us-ascii?Q?geGKlbn2e1ZBZDURgUl77YMX7xW5q118diG8s8yfNYDtP/g03B2Z5bq8MYZg?=
 =?us-ascii?Q?PTF8HJ/XGdnr1BFaswZ1q74EUt+uSeiHxWSvDl78SlXwMXN0TurrY+myJOQR?=
 =?us-ascii?Q?OSXMHYP92osGV3fO+8dhr+is+R3KyqZn/Kd2xxVOpWFsr8aQyozrfoU8wmI/?=
 =?us-ascii?Q?GaElkjijB29er5ghuZxvf3aytRx0EFFLcMkqfgpXyOD7lraZYXPfZGvLI8Qx?=
 =?us-ascii?Q?JAVtqx5VJjgp9AA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i4Ptl3i1EaXhrfJgD2OtU+xxHWc51KLbe1r7HVSa4aY6OCRqt1bwjk/oaFtZ?=
 =?us-ascii?Q?f8NrEmHL615bYPBYYm/zxBzd79QEblt2+3wjZgscq5Ptnp7Afb4WrWKbhhgL?=
 =?us-ascii?Q?GxFR1RN66IVlYvbKxGqNIiHgHKUxYl+ZDPAOD3PVLLkHK+RdMNwY8xgIn9Bb?=
 =?us-ascii?Q?Q37P3O6uGdWDBVd3DmQ7XgAcDUDk65YCc+30btMp/iN2bqWF6XkRRiuCQsQN?=
 =?us-ascii?Q?MpXtKwbfliKZran9vu+C/uG5i+Bz+OCIyExn1ELXXONtDCpGBTXnNOPFY3Kt?=
 =?us-ascii?Q?P1soegeWyZZjgxCtUmBLBesdGtQVl7ZHKthJXxv7eBlFHb/DuxQ0DCl1fn7b?=
 =?us-ascii?Q?lhcJAex9kcmoNAhWC3uj/vVUYSJwy7gn/FuYPDg6rpoDR2u7qva00Sb7SLdi?=
 =?us-ascii?Q?Q+sU6RWxfXgO77Wd+oe9h2ytg/g4JTImXBgJxDatOW+1CwEFNVw4gbFQpCTI?=
 =?us-ascii?Q?nXZNEKOEDBj+tmGLv+FmoGX/dqB/R80WaRxUBiXuoVCZntqEgHTxW09xs90+?=
 =?us-ascii?Q?FFKMG4jCwfCtljvmnPrbeDWsq9DTxOovkInnJ338okShOnOU8w94mSwIkjwB?=
 =?us-ascii?Q?CCF558gUnrwaxPJewd6QYgE6O0HFbwDMMA88eL2vg5ycWUd1wym3AE37q7mb?=
 =?us-ascii?Q?TluB9mqFS2YnVHr1+4fw2tb4fa2e7W1PJ4+hI+6VsWiU71xaV4wqKGV2ExZU?=
 =?us-ascii?Q?i6CnuWYXfP/BeV9r/zMuRW8DSDjEPqTJ4+MZYrOxgrtQZV+g6z4c3DoxmoEC?=
 =?us-ascii?Q?GyEHsaC2unezb5TOQn/JNrBIlumue/Xem9u8oslxpV/gD2X/znSPF08Yurd+?=
 =?us-ascii?Q?aUIcs/89VYvFMpus53CjOZrvPXY2R1E4FDW/Wi9ouYItZ+vXnTk8qsNNTjIN?=
 =?us-ascii?Q?meVXQQ1Ht0tewsEGDn2JZj7WEnRuOytK6cBmz4cCHcPYIpoAxVcjvDFRGig8?=
 =?us-ascii?Q?XdpMuxeWfgrrYVKJ1fmYTMuYIE3BuGR2GHG1we1wFK0Vn7Dr3KSh6hHy86uI?=
 =?us-ascii?Q?7XQV7FYqvDPkB+NHt0vT/3f1IRNNQX24jbHpejzoLeGDG4DBRtc8HqYxopCG?=
 =?us-ascii?Q?rBetpMf5l40QnyQ/EsLxf1wiavnTv2ocy+U17TD/96/F67jJb16fy0ExQZ9G?=
 =?us-ascii?Q?AAJw6+3RGnIlbkO3ThCdqGGOuGUbM8gdZAaOaHQJdlmIiM43Gu46T2yAlgSW?=
 =?us-ascii?Q?mLuSA4qpO+JgcEBv35sVC1KfauHyH9/TqOBjd1gp5wTU/m2HGcG4+ZglZgZT?=
 =?us-ascii?Q?r4v4kRjo3zAqLun69dIK5llsRyO2Kgvon9yHMohcX3D1ko6hnmiKdlxyDf28?=
 =?us-ascii?Q?GQFcRKsFxfKpyDsNaCY9KTEcMumLlEMgvGg4ewGucEaRIvdwDi2RAUbMleag?=
 =?us-ascii?Q?jtoXolq73QAtuG6H8UjCFr9oBEQ05DWNFlX+wQin7xeKataYXms3MWlQDJ2t?=
 =?us-ascii?Q?KDqFWoTk3vL71UaUR5F+MbFSmktPqcDTbvTrlie5yn+sCvUgsdk7m9yGrOvQ?=
 =?us-ascii?Q?vJIoYeEt1q6+vRubKWlNZYqLJEXx90zDspdW5iBVUO7bgkb/5kVF2JWiIRt4?=
 =?us-ascii?Q?mTlZswCFR/Fzu+q3wSY9HfLBC72IMIDfxEp/fN7rTaJwNoO03Usk9QgRR+aL?=
 =?us-ascii?Q?c77Y6mEwll1OjpsZW4KSyIk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c63198b-bbdc-4c47-3bb5-08dde0037c2e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:13.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VzDQeKNZZcbIqYRoJD+FTBcdpAKddEO4y5v9dqXHGc/Nt+r/WvSpUJChYV/AdsQUHXt6ZIqaHd7y/wX7wECQEiCcgTrx34wNHas61ObCZiiBPavyHdHoAEldqEh8BYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19862

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d9063dc50255db21b5a5e6ceada1e3a8927e44a1 upstream.

Prepare for adding support for RZ/G3E and RZ/V2HP SoCs, which have a
CRU-IP that is mostly identical to RZ/G2L but with different register
offsets and additional registers. Introduce a flexible register mapping
mechanism to handle these variations.

Define the `rzg2l_cru_info` structure to store register mappings and
pass it as part of the OF match data. Update the read/write functions
to check out-of-bound accesses and use indexed register offsets from
`rzg2l_cru_info`, ensuring compatibility across different SoC variants.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-12-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 43 +++++++++++-
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        | 66 ++++++++++---------
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  4 ++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 58 ++++++++++++++--
 4 files changed, 136 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 1759b9369628..3e71e2939dea 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -23,6 +23,7 @@
 #include <media/v4l2-mc.h>
=20
 #include "rzg2l-cru.h"
+#include "rzg2l-cru-regs.h"
=20
 static inline struct rzg2l_cru_dev *notifier_to_cru(struct v4l2_async_noti=
fier *n)
 {
@@ -320,8 +321,48 @@ static int rzg2l_cru_remove(struct platform_device *pd=
ev)
 	return 0;
 }
=20
+static const u16 rzg2l_cru_regs[] =3D {
+	[CRUnCTRL] =3D 0x0,
+	[CRUnIE] =3D 0x4,
+	[CRUnINTS] =3D 0x8,
+	[CRUnRST] =3D 0xc,
+	[AMnMB1ADDRL] =3D 0x100,
+	[AMnMB1ADDRH] =3D 0x104,
+	[AMnMB2ADDRL] =3D 0x108,
+	[AMnMB2ADDRH] =3D 0x10c,
+	[AMnMB3ADDRL] =3D 0x110,
+	[AMnMB3ADDRH] =3D 0x114,
+	[AMnMB4ADDRL] =3D 0x118,
+	[AMnMB4ADDRH] =3D 0x11c,
+	[AMnMB5ADDRL] =3D 0x120,
+	[AMnMB5ADDRH] =3D 0x124,
+	[AMnMB6ADDRL] =3D 0x128,
+	[AMnMB6ADDRH] =3D 0x12c,
+	[AMnMB7ADDRL] =3D 0x130,
+	[AMnMB7ADDRH] =3D 0x134,
+	[AMnMB8ADDRL] =3D 0x138,
+	[AMnMB8ADDRH] =3D 0x13c,
+	[AMnMBVALID] =3D 0x148,
+	[AMnMBS] =3D 0x14c,
+	[AMnAXIATTR] =3D 0x158,
+	[AMnFIFOPNTR] =3D 0x168,
+	[AMnAXISTP] =3D 0x174,
+	[AMnAXISTPACK] =3D 0x178,
+	[ICnEN] =3D 0x200,
+	[ICnMC] =3D 0x208,
+	[ICnMS] =3D 0x254,
+	[ICnDMR] =3D 0x26c,
+};
+
+static const struct rzg2l_cru_info rzgl2_cru_info =3D {
+	.regs =3D rzg2l_cru_regs,
+};
+
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
-	{ .compatible =3D "renesas,rzg2l-cru", },
+	{
+		.compatible =3D "renesas,rzg2l-cru",
+		.data =3D &rzgl2_cru_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_cru_of_id_table);
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h b/dr=
ivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
index 1c9f22118a5d..fc0fd0c97c86 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
@@ -10,71 +10,77 @@
=20
 /* HW CRU Registers Definition */
=20
-/* CRU Control Register */
-#define CRUnCTRL			0x0
 #define CRUnCTRL_VINSEL(x)		((x) << 0)
=20
-/* CRU Interrupt Enable Register */
-#define CRUnIE				0x4
 #define CRUnIE_EFE			BIT(17)
=20
-/* CRU Interrupt Status Register */
-#define CRUnINTS			0x8
 #define CRUnINTS_SFS			BIT(16)
=20
-/* CRU Reset Register */
-#define CRUnRST				0xc
 #define CRUnRST_VRESETN			BIT(0)
=20
 /* Memory Bank Base Address (Lower) Register for CRU Image Data */
-#define AMnMBxADDRL(x)			(0x100 + ((x) * 8))
+#define AMnMBxADDRL(x)			(AMnMB1ADDRL + (x) * 2)
=20
 /* Memory Bank Base Address (Higher) Register for CRU Image Data */
-#define AMnMBxADDRH(x)			(0x104 + ((x) * 8))
+#define AMnMBxADDRH(x)			(AMnMB1ADDRH + (x) * 2)
=20
-/* Memory Bank Enable Register for CRU Image Data */
-#define AMnMBVALID			0x148
 #define AMnMBVALID_MBVALID(x)		GENMASK(x, 0)
=20
-/* Memory Bank Status Register for CRU Image Data */
-#define AMnMBS				0x14c
 #define AMnMBS_MBSTS			0x7
=20
-/* AXI Master Transfer Setting Register for CRU Image Data */
-#define AMnAXIATTR			0x158
 #define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
 #define AMnAXIATTR_AXILEN		(0xf)
=20
-/* AXI Master FIFO Pointer Register for CRU Image Data */
-#define AMnFIFOPNTR			0x168
 #define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
 #define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
=20
-/* AXI Master Transfer Stop Register for CRU Image Data */
-#define AMnAXISTP			0x174
 #define AMnAXISTP_AXI_STOP		BIT(0)
=20
-/* AXI Master Transfer Stop Status Register for CRU Image Data */
-#define AMnAXISTPACK			0x178
 #define AMnAXISTPACK_AXI_STOP_ACK	BIT(0)
=20
-/* CRU Image Processing Enable Register */
-#define ICnEN				0x200
 #define ICnEN_ICEN			BIT(0)
=20
-/* CRU Image Processing Main Control Register */
-#define ICnMC				0x208
 #define ICnMC_CSCTHR			BIT(5)
 #define ICnMC_INF(x)			((x) << 16)
 #define ICnMC_VCSEL(x)			((x) << 22)
 #define ICnMC_INF_MASK			GENMASK(21, 16)
=20
-/* CRU Module Status Register */
-#define ICnMS				0x254
 #define ICnMS_IA			BIT(2)
=20
-/* CRU Data Output Mode Register */
-#define ICnDMR				0x26c
 #define ICnDMR_YCMODE_UYVY		(1 << 4)
=20
+enum rzg2l_cru_common_regs {
+	CRUnCTRL,	/* CRU Control */
+	CRUnIE,		/* CRU Interrupt Enable */
+	CRUnINTS,	/* CRU Interrupt Status */
+	CRUnRST,	/* CRU Reset */
+	AMnMB1ADDRL,	/* Bank 1 Address (Lower) for CRU Image Data */
+	AMnMB1ADDRH,	/* Bank 1 Address (Higher) for CRU Image Data */
+	AMnMB2ADDRL,    /* Bank 2 Address (Lower) for CRU Image Data */
+	AMnMB2ADDRH,    /* Bank 2 Address (Higher) for CRU Image Data */
+	AMnMB3ADDRL,    /* Bank 3 Address (Lower) for CRU Image Data */
+	AMnMB3ADDRH,    /* Bank 3 Address (Higher) for CRU Image Data */
+	AMnMB4ADDRL,    /* Bank 4 Address (Lower) for CRU Image Data */
+	AMnMB4ADDRH,    /* Bank 4 Address (Higher) for CRU Image Data */
+	AMnMB5ADDRL,    /* Bank 5 Address (Lower) for CRU Image Data */
+	AMnMB5ADDRH,    /* Bank 5 Address (Higher) for CRU Image Data */
+	AMnMB6ADDRL,    /* Bank 6 Address (Lower) for CRU Image Data */
+	AMnMB6ADDRH,    /* Bank 6 Address (Higher) for CRU Image Data */
+	AMnMB7ADDRL,    /* Bank 7 Address (Lower) for CRU Image Data */
+	AMnMB7ADDRH,    /* Bank 7 Address (Higher) for CRU Image Data */
+	AMnMB8ADDRL,    /* Bank 8 Address (Lower) for CRU Image Data */
+	AMnMB8ADDRH,    /* Bank 8 Address (Higher) for CRU Image Data */
+	AMnMBVALID,	/* Memory Bank Enable for CRU Image Data */
+	AMnMBS,		/* Memory Bank Status for CRU Image Data */
+	AMnAXIATTR,	/* AXI Master Transfer Setting Register for CRU Image Data */
+	AMnFIFOPNTR,	/* AXI Master FIFO Pointer for CRU Image Data */
+	AMnAXISTP,	/* AXI Master Transfer Stop for CRU Image Data */
+	AMnAXISTPACK,	/* AXI Master Transfer Stop Status for CRU Image Data */
+	ICnEN,		/* CRU Image Processing Enable */
+	ICnMC,		/* CRU Image Processing Main Control */
+	ICnMS,		/* CRU Module Status */
+	ICnDMR,		/* CRU Data Output Mode */
+	RZG2L_CRU_MAX_REG,
+};
+
 #endif /* __RZG2L_CRU_REGS_H__ */
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index c496a5f2fd1e..497702d350eb 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -80,6 +80,10 @@ struct rzg2l_cru_ip_format {
 	bool yuv;
 };
=20
+struct rzg2l_cru_info {
+	const u16 *regs;
+};
+
 /**
  * struct rzg2l_cru_dev - Renesas CRU device structure
  * @dev:		(OF) device
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 5e1699fe3986..de0a7d984494 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -42,16 +42,66 @@ struct rzg2l_cru_buffer {
 /* -----------------------------------------------------------------------=
------
  * DMA operations
  */
-static void rzg2l_cru_write(struct rzg2l_cru_dev *cru, u32 offset, u32 val=
ue)
+static void __rzg2l_cru_write(struct rzg2l_cru_dev *cru, u32 offset, u32 v=
alue)
 {
-	iowrite32(value, cru->base + offset);
+	const u16 *regs =3D cru->info->regs;
+
+	/*
+	 * CRUnCTRL is a first register on all CRU supported SoCs so validate
+	 * rest of the registers have valid offset being set in cru->info->regs.
+	 */
+	if (WARN_ON(offset >=3D RZG2L_CRU_MAX_REG) ||
+	    WARN_ON(offset !=3D CRUnCTRL && regs[offset] =3D=3D 0))
+		return;
+
+	iowrite32(value, cru->base + regs[offset]);
+}
+
+static u32 __rzg2l_cru_read(struct rzg2l_cru_dev *cru, u32 offset)
+{
+	const u16 *regs =3D cru->info->regs;
+
+	/*
+	 * CRUnCTRL is a first register on all CRU supported SoCs so validate
+	 * rest of the registers have valid offset being set in cru->info->regs.
+	 */
+	if (WARN_ON(offset >=3D RZG2L_CRU_MAX_REG) ||
+	    WARN_ON(offset !=3D CRUnCTRL && regs[offset] =3D=3D 0))
+		return 0;
+
+	return ioread32(cru->base + regs[offset]);
 }
=20
-static u32 rzg2l_cru_read(struct rzg2l_cru_dev *cru, u32 offset)
+static __always_inline void
+__rzg2l_cru_write_constant(struct rzg2l_cru_dev *cru, u32 offset, u32 valu=
e)
 {
-	return ioread32(cru->base + offset);
+	const u16 *regs =3D cru->info->regs;
+
+	BUILD_BUG_ON(offset >=3D RZG2L_CRU_MAX_REG);
+
+	iowrite32(value, cru->base + regs[offset]);
 }
=20
+static __always_inline u32
+__rzg2l_cru_read_constant(struct rzg2l_cru_dev *cru, u32 offset)
+{
+	const u16 *regs =3D cru->info->regs;
+
+	BUILD_BUG_ON(offset >=3D RZG2L_CRU_MAX_REG);
+
+	return ioread32(cru->base + regs[offset]);
+}
+
+#define rzg2l_cru_write(cru, offset, value) \
+	(__builtin_constant_p(offset) ? \
+	 __rzg2l_cru_write_constant(cru, offset, value) : \
+	 __rzg2l_cru_write(cru, offset, value))
+
+#define rzg2l_cru_read(cru, offset) \
+	(__builtin_constant_p(offset) ? \
+	 __rzg2l_cru_read_constant(cru, offset) : \
+	 __rzg2l_cru_read(cru, offset))
+
 /* Need to hold qlock before calling */
 static void return_unused_buffers(struct rzg2l_cru_dev *cru,
 				  enum vb2_buffer_state state)
--=20
2.43.0


