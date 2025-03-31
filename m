Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C42C36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.57])
 by mx.groups.io with SMTP id smtpd.web11.49164.1743419245820480194
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DOxsg3B7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7l5tMjRtIEM0pkIlxwKtFnL/vQnnpWCBuL32y24rx9FoZvNKwdZ/AJGH5YIAURX58wtmssvryBLchmL23w4Y46a9FLWQASmLNuuZ5nxLVHCX4UfhR6F22eLDVTRGLrvBYI/G1t84tNo6eH9eUPs0WWXP+CLdNm3gyjXj9DbYjTR5AlbojxEfB6RgTQPgETl4llR+AMAX7qXG0oyIAAK28/aQRx2uNfKoJIyVqBv8WvrW2eGI/IP6n+Klar/jsQJsNDXfuahMWBbi2g2EnrTlENRSKmluJ0y808P3q5HM+OoBDm6Uv+GzbCR11WeVRoDZT13lfWRd4MZ4NIBnpucZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxHWdbHZE4dIMkhOG1bTj8tY2Xycq1+ZxkHLDkuV/Uk=;
 b=nkowulCWZ37NoBG+t/AizkpITja4qPfyRpbzaZK5jBOwd4Z0pCZ0aaSqRqVFGUoYsNCynxNHAiNCCwpQO1A0dZS/GnE39XfQl4RBYBgMPYjxa4zc/sIvd8Yvk5Y66dINMmgzbO/76gJUJStW8I2PDMe29Dfd15Uh8HAVVRUGugS/tCsOFr/40GF7fLRb/WgoOauw6bXFYXd7EjEMAmt4vJ/32o8U4mnSmDLTQizjSqMmxWU33xwam+okZWmGzZlvYZOt0xvRdKxUHVa+4vIgiYIQ4GgJqzVZX+2vaLkAEFVF/XYHmdSjA9EGnu3LsryIZi7hdr/sQTvbAUZjFEN/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxHWdbHZE4dIMkhOG1bTj8tY2Xycq1+ZxkHLDkuV/Uk=;
 b=DOxsg3B7yI6X+GFGVL0giFVIZqk44k1Rr05GiEbx+voZTNhzQSQ6tUcXG5MhL0nPOkSqTt/SJtokvDbLNXsSj/dEqI5QpZ++yY9d5qL3bYsh+nL7gi4FCb1xST9YXhH/a7POMsH2OPSbHQcIeGQfxA/1EXr7DhYC64krYXlNdyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:23 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/13] dt-bindings: pinctrl: renesas: Add alpha-numerical port support for RZ/V2H
Date: Mon, 31 Mar 2025 13:06:47 +0200
Message-ID: <20250331110659.252237-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: b23c8fa6-918c-4407-7f9e-08dd70443673
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Hp4OaJ++ztY88jjPwEHPyWFxVjgG6LCHESDc5w41wVqcgOzq4aU+ivP4x1wJ?=
 =?us-ascii?Q?bkiGRNuTdc0vtuncSpjh51/c6WE1zm2H2/FpxsDT/M48f+4UEsiiD8MyO/sg?=
 =?us-ascii?Q?4Owfa7mVlH4Pn6Fb+OlN5cBgoUUl+GgAwL+DYUtxfgkMJ7qjeyZSDwqrZjpi?=
 =?us-ascii?Q?Tlz10LKkT4Euts3mdDtKRBVjvoI2iAsdmhFaVjzGY+yPVUwmbd+JJ5+zB6Hi?=
 =?us-ascii?Q?K9mJILThf4j0EJw7A/2KLWWgKyxCeruasbp2BwgoToEbG/sBPchERL7EWm+M?=
 =?us-ascii?Q?XQp0Y/CnHrn/i17IhpsEGOyy+TjEUDJGtfywoDfaIoiSObrs359hiifDv8nG?=
 =?us-ascii?Q?MCDZy1LHllABEDwRRC9GZ9C2ZBorCcdWxde9ot68xmynA0xYPKvVewyvvRXW?=
 =?us-ascii?Q?k7/jBR51Ez0Nr8cYyqeSQgSgYlAvx4Qy+PmxeOkWtza0aFyKYOFPX3dIlOw8?=
 =?us-ascii?Q?V8hZLaGp4tvb6I2z+awhDv3RDoHKoUYTGGPgCWx/V6gvLtEWKTiDra9AI2Op?=
 =?us-ascii?Q?tgJm/xmP3hFpBe/5GqfRTn5C2JK+pE/782vNND7onqqCiu1DqxT3pLvnaF90?=
 =?us-ascii?Q?jiswbw91D/pNs+8ic1EXLMA/30UZEvsg8VuMYZ6l49zxQdY8UELdCa5pZGvM?=
 =?us-ascii?Q?b/hFmDdJvCCdWYvMHlEnq4BfAeSiVoydjZi2P884vguFvFxCdw6BDtXFWhGu?=
 =?us-ascii?Q?vKibv5BhLVYA9yRubv7Bl8kpnWEejbUHKWD3Pp0bRNk7Xr0ekkI5iwCqd1ap?=
 =?us-ascii?Q?eocSTYpeMXLV4DOILYs6ml2Gy3kMRMWNyYmIo9HiiqNMEVZxogyBlCYXF7be?=
 =?us-ascii?Q?0SzrOiiNGG6ZUZ8lEaTpUlBZS3RuXvFpD2asizSUlynISEhHKVWyCyaRNwvm?=
 =?us-ascii?Q?Qh8gw8sYLGoVI8zRAT7biSgGz3IDl39Pmz0Jlqgna+BmEdWQbA5pKSbedKbU?=
 =?us-ascii?Q?2EaU6T5a0DRMoV5oe839yiYa9dcGwz35NPi+7XfugaJf+9dOymn13cBYEZSu?=
 =?us-ascii?Q?B3/jvpunX2KMd0zpOQaP7czZmttWnr0sOTtWrALqA5mx9pDjob3w0J8xtpHu?=
 =?us-ascii?Q?7MW4p3Cyywz8l4SZkVw4NSLgGNscysjrKaNZ4qSQRRczPoTLsDiYByoiW9vU?=
 =?us-ascii?Q?RymsgWCrj1IEEJaHZZRZKGoQbWknM9XiebogDV/LDFEF/RfR40gzcGf59fIj?=
 =?us-ascii?Q?CKIL0Ga/HuYkqLr037G3vIHxeno83Vlx+V6x1N33RatLKEjvvb91OpyDbuV2?=
 =?us-ascii?Q?g60Afwye+zcaG6Jxqtc25XeexFe96nUEfb/abq21eJIReEh9fRn5Y3FVcZa5?=
 =?us-ascii?Q?Gi8E3mUGvIBPEhAJXtSL9110Xy0q/4MldgBmMNW5I42huuIyGon40RQluveN?=
 =?us-ascii?Q?G3psf/P/SWvb0FCtWH9a9XF+cSYSe0utoN40cTrQZLc6HK88ffwP29J/sNdz?=
 =?us-ascii?Q?+5DXucFX0IGdW+CbtiA8/PID5DcOEOPB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ctioP1/ICGYr95ikGLR4sttLhKRd0Oc7I8pWdMJtNCazrMi/nY4g6lkCJsTn?=
 =?us-ascii?Q?TdUZlvuiRZr1k00PpQwZ+kciO1ADf3QAogRikj/nrC2O5xtwi7rk1Rk3qQL7?=
 =?us-ascii?Q?vXv0t/6WqN9pfJkrArEuAmBEXH5gjtBEWKzpDv+yLQ6Z96Xbk2RFiuwMfKsn?=
 =?us-ascii?Q?qg3PTrXc5Qj+29oipiAbqhau4bTPaADoC8L1GOQzy9LT6Uy1vcSig+phhikg?=
 =?us-ascii?Q?NiaXZbi1132uSVvcMcVcqezqNeOcAi5o4SWkyy2SGHnFgnWs2B0rjlzhh/lL?=
 =?us-ascii?Q?caKCjG6+Nwbc2MCMQjxrYTvHAGTzDl2eOyfZSdRMF9V3wzQbctIWi1CCsgQi?=
 =?us-ascii?Q?rZnZ3UztVeTPAzqeUuNNpHZ39n0htfNBsJfoEUZWbf6u45l9WLLgzaXove1o?=
 =?us-ascii?Q?tJCumd58YDPzLIGVnrAlvBeKf/H66BI2KwOLmP6B7nhvCJbS8zC9H4KseRmd?=
 =?us-ascii?Q?eR8laxiMR5hJ4k9zLQXO1dwpG6mL8HaI1f7Vmn2X1KXRFf593n1XdkH3ERrB?=
 =?us-ascii?Q?+oGgdo503iQ2Lidt7yjvjJy3h+EfcsAfobQNExbgE2uITFNEXOfVj4wyD3em?=
 =?us-ascii?Q?LG16zztgF3kNlJULJUKaQd8wP+XVfo21vcLz9pvgq6oThB9OSzvXxVyu0JLC?=
 =?us-ascii?Q?V/1jYWvip1TQUl7FGp05KnpjfRKMUtqtttrDhD5GX/2ajRkjG7bUPM7BL0TL?=
 =?us-ascii?Q?s/GdWOw1QFol4fuDOVrd82/WfNcu6ke4zq4TzIyX0pFHgqGvmmHz+7aAZY+a?=
 =?us-ascii?Q?EoHdOTyMmzTa8F+p6jq/7o85y0XkVxy6Kwf5anwLy3WXqG++329tlFUnXdHE?=
 =?us-ascii?Q?M3FviDCtYH05T5jFPNXb65EoLECK67HroRy7+J8yKQJ8MDO/BsMgodTWgas6?=
 =?us-ascii?Q?AWUYf0HWWmTE9/9C3ewFM+RBMo9T7bSl5UklIcNwMlBnyhtMt2/5pc5mk646?=
 =?us-ascii?Q?Xgvel2/uLROeezyxAVluNtyQkub1+419jnFuDNINJai/ILpUzIWyb6vEsrmW?=
 =?us-ascii?Q?Emx0fycJNa85EPWBnOdTrE9fWy/3G0/FXfp952yqn/vyagaWXvxJfMbvkxcq?=
 =?us-ascii?Q?z/CpIb3YpINvR7e2SNL69UNTlhhn368ULircaYIdvtCyrVTp5bcyUpwU/EQC?=
 =?us-ascii?Q?7HvyyUy+iK/aDZJwis92EsXoWJVBcrT4a0/ppTmMwKZH6hYGBrBcu/zz5WsE?=
 =?us-ascii?Q?SUGkmXOBzHw7M/02ZGzrKFKv+vZDrhJN/5EEdTB8sfuS+J1dYDWo0qhoTq5V?=
 =?us-ascii?Q?c0wE9Fx8ypPtogsE3hNVQ61DR0nyNrHs8atjxPmLzk/xGmGtPKSBq5iVLFLn?=
 =?us-ascii?Q?3NyWrXNwBmqy+Fr2rSF6iFkBfI2Xdl7Cn94b9Ix60jypk4OFI0LzCCQVOEbT?=
 =?us-ascii?Q?MWC9C0xL4eyqX0YEUa12euIQwuNjcnR+oiaYDIdJK0DcYdw3NPrRwAb+kiK1?=
 =?us-ascii?Q?mX8eyBi9e+SWMl0ZmcJGJS47QF6UEmd1tqxRYWQrEB8BxswprzUlkffoK2Rt?=
 =?us-ascii?Q?efZ4NGUi64Csc6QwNsx+Yi7OTzAAe4HXIPVee6ObcIZUu5YdPzx2ioMBUjF/?=
 =?us-ascii?Q?K2bS+ykNg68zQkuA4vNg2/yg044o9/Ky4sSQpXYI0XTn1zvfCg0qF714pLSz?=
 =?us-ascii?Q?7rvorOS/E2dBvABN8yuZKvM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23c8fa6-918c-4407-7f9e-08dd70443673
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:23.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXXqI30VIj+bG1SKHUskISnwIGr5sPf1icItW+i4+4mMM18OEuQafwMKojECTLoP9nApEtmIYsKyknLSrgzPChxWlQCq0lQmTvhVteuIVpXSlSwVYPaf6s5pianSUPRp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18433

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3e4863d24818a41db42b4f2680715f204657839e upstream.

RZ/V2H has ports P0-P9 and PA-PB. Add support for defining alpha-numerical
ports in DT using RZV2H_* macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-2-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../pinctrl/renesas,r9a09g057-pinctrl.h       | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h

diff --git a/include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h b/incl=
ude/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h
new file mode 100644
index 0000000000000..2e83bf43160b9
--- /dev/null
+++ b/include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/V2H family pinctrl bindin=
gs.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__
+#define __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/* RZV2H_Px =3D Offset address of PFC_P_mn  - 0x20 */
+#define RZV2H_P0	0
+#define RZV2H_P1	1
+#define RZV2H_P2	2
+#define RZV2H_P3	3
+#define RZV2H_P4	4
+#define RZV2H_P5	5
+#define RZV2H_P6	6
+#define RZV2H_P7	7
+#define RZV2H_P8	8
+#define RZV2H_P9	9
+#define RZV2H_PA	10
+#define RZV2H_PB	11
+
+#define RZV2H_PORT_PINMUX(b, p, f)	RZG2L_PORT_PINMUX(RZV2H_P##b, p, f)
+#define RZV2H_GPIO(port, pin)		RZG2L_GPIO(RZV2H_P##port, pin)
+
+#endif /* __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__ */
--=20
2.43.0


