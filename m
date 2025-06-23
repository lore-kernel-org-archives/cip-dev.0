Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501DC7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:49:12 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.55])
 by mx.groups.io with SMTP id smtpd.web10.434.1750690141780351673
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:49:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Mj8fFxRj;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.55, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b86X2Yrq3rnFX4V39L41gdRW6kRq4CPjdrAWBSYYdWAIKuBKHBVlZ+oCSUJAbyGgb7sQesQq4c3C/xltdKkmZmbIF76GIepjai70lx+bRfn1ynLtPBoXNTkki2pDW9S1pb92LWpAJjz5JEC5CM8F24CVQVSQaHPRsE8ZJYiNuNxDHcmZMo6orICryZmOaZejMuM5pTbRG/O70RvdJJTn5VOh3kuMG7WCtH2IdScbrOLoUr6DCF69KU5o5ccUvGBkDpVwlGw1pkDSkPIL+JxiH0WEAYmHeHco1ik0baoqr1q05zzwUuYcCRMEhYnBmjLHAgY9hnjf07R4LCWGCBDkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asx9eyL6wmOeNXkFOYwjFUDLfLQU5Ku+Gju8IefX1Ow=;
 b=dlvmTyxkkYy3p4WQCYp7KyO5ZBhlRtGkA3Mqhi+nHXBio+edKyJ0sgZG/qAg3YdhZWlTtfjyXeZS8uLaWRQyIoqUOi95fvzL+MHKXfPeCs7ECyX8d7OYWonkvRfK9r7vhVCphGkJ2NUUMkUR+kV9Gpm3Rhhk1YwtGUuL3fnWCBZozX9vOhFODExzspDLmTWeeaVPFsRtlD/SVTMe48m1NmTSk2+UQzMLgLomt3VD3QWv7j42Bm3TcuBjLwjq5Jb8VJXfCq7lWheutngLIa0DtrIknuEaoIx0uW1/rNBkK5Lr+VXfPDhzoZGqVAiPJ6DWCXTri5CeDoql2o7h0RGfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asx9eyL6wmOeNXkFOYwjFUDLfLQU5Ku+Gju8IefX1Ow=;
 b=Mj8fFxRjSrrr4vovRyxNdjA6ldv/OGVhfoiKroPVYVpThCTBSozSAdxNsL6V+q7Mf/KDhPuY3Cb8xPHwzswl1I3rtfVlWfQZAS6ItfOh5GSkSiKjVhUNrRmt28YNKk6Vusix1ik5om8xTRqic5RqWyPEzXyZOFoxqdxFXCBJs14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:49:01 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:49:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/10] arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on SDHI0
Date: Mon, 23 Jun 2025 16:48:16 +0200
Message-ID: <20250623144817.2119838-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: f593e385-978e-4d86-8373-08ddb2651781
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?//4dybpOfbSmbNm6o9FICkhGVoTKg/KlPYZ/0byRek22t9Sdjib8l3pTxQfP?=
 =?us-ascii?Q?wVwAVrzHnqtKiNx9nDRo2peaMoNhfbm6u0dFHU1tgiUMcso6m2ZQgXJY5PS2?=
 =?us-ascii?Q?iT6dC2K5c1x50QcyQe+Q9POGeG5+S60VNkCTDQmkywi9TxHp7Uu1y6hYC3q4?=
 =?us-ascii?Q?awqndJyo78wEPoCYWIyUJ4CClGK/PJC2F//LpbmqeUUSonqB0pR8oqNDxaVx?=
 =?us-ascii?Q?dO/MTy6EFKI7X1YbsBf406XxsJUfvBfIq1CMqJu8ELX600vidHnNFWjONPVF?=
 =?us-ascii?Q?udtsSGnLkEdz7soMINkMA72QNT7sxRs2geDfwa9qGDkQjxFg8SlxS+rsmO4Z?=
 =?us-ascii?Q?VAa1O3bvksfq4mlozhK7IquwThLv4NO01lYZbXipuPZ4MFauvxYMhU3yaeC5?=
 =?us-ascii?Q?xklKb5mvywYD8/EagUJpKDakC8nJQHbIadODlD+S8YvzuYkW7Qq4pK59zZDw?=
 =?us-ascii?Q?axzapYsGagDDHoj2SYsQx3eYmEo1YGYTCM5f6jkT1+vhI4GIe8vHV0YU72yU?=
 =?us-ascii?Q?G5g98wmiQ/odKMq05P3XjnKSuk5l2kbkMVBCYsWyTRwqTZSEwRnQSVzLntA4?=
 =?us-ascii?Q?JxUVnT6dMHYdb43uP2aBUwojyr+ntJQrWbjmBzHfPs6IuxVojw8ycS2/kwUU?=
 =?us-ascii?Q?dRZNIiO/olzGSu1HmRGIQ5jjGPC9LMygy2QZ3A08ClUSklbmFr6UNzO5270w?=
 =?us-ascii?Q?6QuTG2wYUgI2OqHr22oQPIbu6C1nWZYiY4CWWfvaVSSLsf5WSYStRLNOZ9Uu?=
 =?us-ascii?Q?gWv4oImsM9Rh4CN5QsZNXJfNxepnpzPK+hcp3nUZk5ZcVxS0ruTCVVkXJEVg?=
 =?us-ascii?Q?jS2dFu/Ewt8aa0w209sGXR1DMG1cFr8LgugZTs8HBX5W3kVS3ymNV2I/KDfz?=
 =?us-ascii?Q?hlVgqv5kODZeZPzFOo7tdv2Gpt93bOHNEAEsPR5FP+OxXeH8y1W9nVRh/BKu?=
 =?us-ascii?Q?LYE3LFqk2oDlGHTif/tJtdaGCNWaWjFA9nE/MLbcPP34sKtlMHNbEMX55l/G?=
 =?us-ascii?Q?UXwV7sIGqmrxfpX72NjU9l5OyRecwlVdQy0aZ3VV8AbRK5O/3X7V+yJ4syFE?=
 =?us-ascii?Q?kH3P/wzD0Fstyv9QqZqovHNxjCzhYsyJEB9QhPsbKkevhtN16lKr1f9hguiU?=
 =?us-ascii?Q?yanRTnVoWbtemFa7sMcsQuHR1c2kxgoTIKI6PtWm7CQ1JGxo9s1An1/yYYle?=
 =?us-ascii?Q?qySdMVjTBjLrPt8E7EqhIe06EUaIFCPNxAoStVCGci0cqXNnVUbO36IB/SET?=
 =?us-ascii?Q?iI6d+g3SFHbChTk8F2jUSvWieCossm6OsKHJUUxjCe7+BlnhaxRewznFkKCz?=
 =?us-ascii?Q?z25WD7m8qBtKVWtdWu61KSPRNebLrJ1agmRouPz0lg+q0eIFAqtaxcnSGghR?=
 =?us-ascii?Q?2/QwqghtCdeIrXa/dyQhHfQ/yb6dLpBxqNN0Ndl3hWiDhzu9tMYGtZkt7iVu?=
 =?us-ascii?Q?we0wyo164IsCGvjdxlgv4PJInkvKpecpHjuZVRKhmbxFKAkAQRIJKm/YmRiZ?=
 =?us-ascii?Q?Hg7iBU3MGXo10Xo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4LUB2+iJYcg2NPdIGVyNvgFt5q6ZdlKxzwzdYebKTZNb9rQpDIrN7jwqn30a?=
 =?us-ascii?Q?xgEz10w0TJqmOXsQ/LqYLaGYjCzOQ0upSU0v/dnAZNhYLimXxSzheD7qJ7gm?=
 =?us-ascii?Q?kagH33ODgXUXNnUbdzuPr/3Zn+OSrLcG3YwF52jYcwS8Na01LSxlrvZPweR9?=
 =?us-ascii?Q?k5yVzEElvW/4hnjJKjo5P5OhC7NzXQxYLZcjXRzWfmugE5yzZIrsJDNIzKR5?=
 =?us-ascii?Q?K+8jzob4FBLhnpLeL4KQ3L3GwpQ0NvSa0uuYjJ0e+jI4wRLEVFJdW5Ho2Tkf?=
 =?us-ascii?Q?OjiOCD+/QoubM+bPk8MaOCERtSex+jfOdKVCnJQPx84zIx35Rj7/ezyzRkAt?=
 =?us-ascii?Q?YMGdjRVF0HyCoiCSKjw0F6YiiKwZCm0EmZbJS7Mh2mfw4fShYjheJvOhY67t?=
 =?us-ascii?Q?Q14RmurWSw6BcqNSGgKDV6xnZZ8eqUobF2IOAcXDg2fz9kpmQquUgkzPFPB0?=
 =?us-ascii?Q?NpSWEW97fjiCJBA1bRGMr+5ZG9m91uyWwE+BRRMyqs99uswJvN90kGtfLOxt?=
 =?us-ascii?Q?r1we2opu00YuhLrGa8d7+nC6nrmionNUZ5mkabDxHvcu1AcyVjdlKs7wme5e?=
 =?us-ascii?Q?GiFJoP+tde1jeXfYmrkBxeZE6PPKzhlw589ohhPqcT9/J/YCJHBqp5abSFp6?=
 =?us-ascii?Q?IVetyDjJbstka+ECdTZjhZlYwJmnNgb5bRYy6nIw9tdmk5PbAQ8gnIcCNH43?=
 =?us-ascii?Q?St6aoRfCD1MH1xDfmMwd66dDSJniysqDpHwBrDQUPErcSgrx/PrwyoaqYGWI?=
 =?us-ascii?Q?hYVnpFUSY8H1jnvADWqCwl7SDYQPrx5t0S6Yl62fLL0X/ey02YnBLGvtfPpm?=
 =?us-ascii?Q?NjPWb+jKRvvTiUnBynqvZd1z0Q4AJv7gLIuJanBnQIpfl3VaQ7KPiQD1JTO2?=
 =?us-ascii?Q?r5bNEKuJWZaJp1pBPyFMFYl0KXfZ6Py03QV6dDKgEGiOvmAbLO3h1c86EoRC?=
 =?us-ascii?Q?C5GpZecsiHmTsTpEilrpbbJ4U4PKvY7ugXW2Tba7Ea54AQ1vMbW9HOCXMXmN?=
 =?us-ascii?Q?zMqBJvJWF8GVVPxuEjPxnVZJEznzctjAfGr3+Mv1RzVwgGbIx+EnfhIBkCQ9?=
 =?us-ascii?Q?21vM49hDwJ8Pe1542PSt+q3rRjFBiFEXK3gCGW4GCPC4M9id8SpNm3N3UtUL?=
 =?us-ascii?Q?hEjBX1ooqQ412ULcn5mBVWWPHX988soQxDo566Zzp3rAWeG6gLSZqxXxRvYC?=
 =?us-ascii?Q?0Drz+Rcn7T/Uo6p0ggJ4jz5zkupiSm1MMNXk4514rjRAaylM8FSWF46QSfvm?=
 =?us-ascii?Q?CadxD/qHemq7mjLgphNhwYMxKjUO1uA2yWM8bjZwMB10srN3GYArUfoHHk+W?=
 =?us-ascii?Q?2OrGigAVOT06p5gn6SunAnpvEdIjfs1pn4ZpFFRliShpFBiN9g60nVtJMa17?=
 =?us-ascii?Q?blnaTzmYaPfv1qxFmHueDZyTcOGolHmnvJ2jno9f9ZecEqb9QSL7PHFyqwTq?=
 =?us-ascii?Q?BNFrEQAajihqfrT1CgHhnjY+IHAv8CqFTp2D7C/614fa4f9345aKFZd5zp1e?=
 =?us-ascii?Q?MM8Gqucw946O326wWFmDcfDfwuDNkkkOYto8KyeRJCJ1RkqnWLpOfR18xo8O?=
 =?us-ascii?Q?okQGju8IUKVGtKO6ZY6XLd3A3VmE7TBE/AJn5t8RpCX1uQMqdPE8U/gHVCSJ?=
 =?us-ascii?Q?I0AH/wxvloq+uAG3vc8MtT0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f593e385-978e-4d86-8373-08ddb2651781
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:49:01.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOiryky6iR6mMqk8dCNKS5/ynf9XMr2yBh1i/GVl/TH+NNi0BEoBw7HvhCqtOMUyPP23E9XpJ66MPCOdX+nBF6cVKxCwWx0FELukX1mKigX94Yd1vjgBhhhyVB+7xTBz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19214

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 4c85281bed1732693f2f2e32cf60e0e30722d06e upstream.

Add support for enabling SD on SDHI0 on RZ/G3E SMARC SoM. It is enabled
by setting the macro SW_SD0_DEV_SEL to 1 in board DTS and setting the
switch SYS.1 to ON position on the SoM.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250206134047.67866-8-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  3 ++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 54 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index c063d47e2952..152a00aa354b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -7,6 +7,9 @@
=20
 /dts-v1/;
=20
+/* Switch selection settings */
+#define SW_SD0_DEV_SEL		0
+
 #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include "r9a09g047e57.dtsi"
 #include "rzg3e-smarc-som.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index fcbabe2cb003..72b42a81bcf3 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -5,6 +5,15 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
=20
+/*
+ * Please set the switch position SYS.1 on the SoM and the corresponding m=
acro
+ * SW_SD0_DEV_SEL on the board DTS:
+ *
+ * SW_SD0_DEV_SEL:
+ *      0 - SD0 is connected to eMMC (default)
+ *      1 - SD0 is connected to uSD0 card
+ */
+
 / {
 	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
=20
@@ -61,6 +70,32 @@ sd0-rst {
 		};
 	};
=20
+	sdhi0_usd_pins: sd0-usd {
+		sd0-cd {
+			pinmux =3D <RZG3E_PORT_PINMUX(5, 0, 8)>;
+		};
+
+		sd0-ctrl {
+			pins =3D "SD0CLK", "SD0CMD";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-data {
+			pins =3D "SD0DAT0", "SD0DAT1", "SD0DAT2", "SD0DAT3";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-iovs {
+			pins =3D "SD0IOVS";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-pwen {
+			pins =3D "SD0PWEN";
+			renesas,output-impedance =3D <3>;
+		};
+	};
+
 	sdhi2_pins: sd2 {
 		sd2-cd {
 			pinmux =3D <RZG3E_PORT_PINMUX(K, 0, 1)>; /* SD2CD */
@@ -96,6 +131,24 @@ &rtxin_clk {
 	clock-frequency =3D <32768>;
 };
=20
+#if (SW_SD0_DEV_SEL)
+&sdhi0 {
+	pinctrl-0 =3D <&sdhi0_usd_pins>;
+	pinctrl-1 =3D <&sdhi0_usd_pins>;
+	pinctrl-names =3D "default", "state_uhs";
+
+	vmmc-supply =3D <&reg_3p3v>;
+	vqmmc-supply =3D <&sdhi0_vqmmc>;
+	bus-width =3D <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status =3D "okay";
+};
+
+&sdhi0_vqmmc {
+	status =3D "okay";
+};
+#else
 &sdhi0 {
 	pinctrl-0 =3D <&sdhi0_emmc_pins>;
 	pinctrl-1 =3D <&sdhi0_emmc_pins>;
@@ -109,6 +162,7 @@ &sdhi0 {
 	fixed-emmc-driver-type =3D <1>;
 	status =3D "okay";
 };
+#endif
=20
 &sdhi2 {
 	pinctrl-0 =3D <&sdhi2_pins>;
--=20
2.43.0


