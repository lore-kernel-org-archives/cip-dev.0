Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C72BEC047A
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:37 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14395.1772529810163723216
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bEtsmOf+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM4gNtOgR6A3eqEH2LhCPG/FRoGWsrpw6k2qLwDV+qBljroRwKOiJmmAyj2EkMGhMzeQU6h6PCJhs6JDE2IM76Bo+uDh7iO2itkKVwVsFxwv4Z3fBMrbBMizf3GMVjc1razNni70+h12lx14K/qU6Ioj6dK2a75ED3+1rYZWbkqq3E2O1HYlpmDxycZ4pZGOAdaXRV2tDSd8B9bYejh3yEf2Z/Eoku7tmix9z0mHIwRNX57tTzfLMV4lLOTLzZfV6Xy/xu5jFTsgBm4DokR5q1lUczla82rKYQCgOWLsBnTrSd4DWJsRd7Qz2itjxdWHiQoLeJcjOwaHABaA/pQMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZdWn95kSQwpGeMPMciudXPJkm6EdV90VtgRzLJCHiI=;
 b=QbQFGhJZOvhCjdiMFX1rM5+2zD2R6sQZJtR0RA9YViXUdOhccrrDU8XQV9Vqcuqw5DcdsqPtb8qG5PhFZoNEJQk6pVyKTPcJAnt3w9uw1nDlWqZB4wYwz3z43uuB1JHdzfqhWPgVsx10DigWA8JUKi88CO1FoWmFwXmuZAbJyamiQSxeMl2+bu0A9PnjL99dbk3zZzY7rGnwW7PUDClqXPo0iRuXXn8J35fwQ0gS+YOYCH9SAC6xxnbbmmlbyvk1CtAy7VGONQriBvHxwjCN9CCh7L/6T7mOf6knb/91oQkoGmgdq2/J9pQTKaYEPF7+E0s3u3My7/FQ+kpOBE9SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZdWn95kSQwpGeMPMciudXPJkm6EdV90VtgRzLJCHiI=;
 b=bEtsmOf+nAwsPIvoDNry2Nnm/ySA9ge+UlLExuG0eiD4ueCZ0KEDamnVhsik+cSvWqYCwPk/ApzCj1Gf5OlhvoOgjtJtMw4IEympa+G4fBFVaJWlTi+GW5yFV9L1SjqwZE0nvDcHv52zpB1F/3KIf+m6Ge3pZVV3HdbCbZajFuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:27 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 1/7] arm64: dts: renesas: rzg3e-smarc-som: Enable I3C support
Date: Tue,  3 Mar 2026 10:22:53 +0100
Message-ID: <20260303092259.13301-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5ba852-1f92-4ddf-148f-08de790686de
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	KPg147hV0rAG1m2ieakeYgLCyF7zZXcNkTulqn8AhTGya5e7OEOHe6+gRW1z/2Wq3M/h2HbH6A/+hH175jhxwIno4TqX1YxRESIaxv68WJZL/1PyfUgm4v2+BBiXIXNabcErlEU8vEWcKOeV8zt+FoDA6a//qpR7TCx0fDnw+yFc9CFLps66GJ+s90SPCtg0qqH10d260zWy+8dWpmd9ymlcnofMxv8qAt4E4G3EqB9ahq1sJ9IfwOiRxFUcaoeDiyV7OLnSYT/il32UT6mqUypKOm3AbdtScj+1faWYN8M+tT6SIdijVNKMxdLUFBC8yFeXWOv3rRwV5DpR+mEjeNOVQFkqWA5S4EPP4/AR2FXYZH1x4PVYfdUZS7E1SvR57+O9uGETt7aw/KbHt4FsNI/OxcMHuSChAaufgKEeHXqlnWy4slg1mxOnFR/ya/rnO1i6kKd82Ys+2WgA3FQODEQf1YVEEYe0SF9GJKAPLS/Egp8S16tWFe70C5VJREwkSbJ11VXkpSO7vbwfEG+tq6RxQO0J8ROY+eQ9icWWQFjmUHnS1cCf/tgjuBWWpMzLxiMECwHCA8nFJN/ae/Bhs33V6ZKUY9W55a+kRIUL20na1aYF+PREUyoOBsX9OI1H5cKWd9wgGoUXPcQuZkjgKzt5qr1ax/PbW1aGpl/UAYzsEIZaxS3rT+MY+3ZiJlPft4WkoJBKm9HA6Tp/0/bYMMZ5VsffbTYco3U2Ia5hKV+ZQbtia8pV3zPI9oG9AMAT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IS2knaaVcSkh4MidWRrsgRHVAXiAkLpMXdx2etTzMXe2O7JyWS2nHlVBvsf6?=
 =?us-ascii?Q?234YvloUt1Uqu2rnPPO5JI0M//01otCnyoUunbtDW3nhNghbSmkFDJPDliyA?=
 =?us-ascii?Q?eFQV2HnLq18PCUfJqwc6ya6pU6+eR4AXR4NE1ZJLeqMn0iSlr2uJUZRnd3iF?=
 =?us-ascii?Q?bpNbmPIMp5xys6PLkclS6dtjEJy3UNAitbI8sfdN9srKa969tNK7IU6eYGfR?=
 =?us-ascii?Q?NwF2BJY7xerLy4Sz6Ky8bN63xwRK7d/I7qbSCFUJo6jwFRv6OJi1HUBXb7FK?=
 =?us-ascii?Q?0jELV9sTY3EChXv7g27JxOAc047TqxbOkYneyzig2VXRC8yX5TgLgEiKjGeV?=
 =?us-ascii?Q?lD9BEBt2F8mGRL72n2aYQE9ZOSiR2m81tU4NgdfZp8eILS/xqgQEPV4XADZl?=
 =?us-ascii?Q?vbNryzoH7apAI2hCXgAdmQvB43Bjx2vcdCLvcFrkEsmAq25dbB+UX5aaJTUe?=
 =?us-ascii?Q?6uZShhAqlWlWLOikE6xbbgeSUfAsiod5FH0Rt2fkqIce5l9tqKGls9LAXXvC?=
 =?us-ascii?Q?dG7v5KMdUa4OfzuHjY+E/wCfL8YKkoL0uq4qjEFFiMYQshizuNwd5YOf9EwH?=
 =?us-ascii?Q?+lxOkijdMYmANFkxMUCfSWfP3faZ2FtjMJ4GVPYXZ5HeC4bFI5eiIgSthhNp?=
 =?us-ascii?Q?pkXBmw1aLsawcW05lgh2Ed9DncU9nMUBO3k+huAg6UzJAqZGLXJNMiyNWn4k?=
 =?us-ascii?Q?z5n5p0KZrwn9q4r5ePox6RpKBa/krZon4J3kIrO5lQsaFtq74XUQYI/AbkJ5?=
 =?us-ascii?Q?bfniqLbcimB7ssKIT01y6CndOAe84IsAYNHIfFO4leer2FXMPqvUrYryO0DZ?=
 =?us-ascii?Q?LO8D21w7rlinyabvS6BO5NimLvaSCqZ6FJL84Yvzx9FMjFQ0q5HcNCPldG0Y?=
 =?us-ascii?Q?4uQo8ivxLEjPkObH7qS6qC+An2WqSLi6Ai1AMIaZKwp2jqQYKz8txwbObNPB?=
 =?us-ascii?Q?0DaCW4iRw1drhpOS80CR2JJNkdcLBaGMEA60H3+Qd6UVt8zAtK/8NerxzlxP?=
 =?us-ascii?Q?vq1OP5BuBQROKesNmf3V/epdp7I1SXqYF1THKWfWJcK023X38HnNYrkXWgYN?=
 =?us-ascii?Q?B5BpUpezWpuuxefI18ruXSvoAQtxJr62p4jvpQHgRzaLRaqtPpE2jM0L7eIm?=
 =?us-ascii?Q?fvg0a09a7cxBQZSlTZpiH9pZBo5wZI1oke+H950+VxsVy7F88dlTs4SXjdaC?=
 =?us-ascii?Q?s+vGpHSPzHvxxRvBtNIaeVgSFLZOpWs+4HQAcrMQMv/6w+izOJ+dcsDIeMmO?=
 =?us-ascii?Q?Zi9K+MkHiaRa9zMfJOyFvPzawReyIKSxuOPwaCjMTSzLaeAXODngUOnggvH2?=
 =?us-ascii?Q?8zmwbxOt77KLGouq6heHDChOAdclc6+rPDgGrBNzETLGzvYruys3NztMqgS8?=
 =?us-ascii?Q?yI3lIZ2svyNEhifWGbAIsXjSEoWYmyT+m3Km+QollHt0xQrn61otL5uGNwbx?=
 =?us-ascii?Q?fE4r2as29yk09590GQGcRBX7d4XqVWeSERnltIwJod6xZwbvJPmFDnEbKfLj?=
 =?us-ascii?Q?AYsWV9i+a90Smrb+ZGg2EfH2XPcpfSJj+rTufW5KaxLoqvJr9sJnaT9O3f8V?=
 =?us-ascii?Q?JeJkEWmm/YJpORfuzyX18LSXYRAzh2PAPnH43W5Q5pADe/Pb3YQ/7AsnviWn?=
 =?us-ascii?Q?DHtEOnwtP85oz+287ip6QaWjKpG2DAyZjAGtNScdzzuaftxJ94qh4z4Vb8Ph?=
 =?us-ascii?Q?WGVNGgwP5DBbFZVVVHomAB1ipQnJX12wIJVrCiRW+RiuYb8Ck7gdmkvtsEWp?=
 =?us-ascii?Q?7tElrRV3Q243/sdP+kWHaF2tEcnV/ev49dNNj0GfQ7uqx9OmUedo?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5ba852-1f92-4ddf-148f-08de790686de
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:27.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONOFmLb8MOR2xG+XjLfwowgIFBuG2eSVHwEk9vi0G6VaT48liqs1eXE5F/xk0236N2+aswSjRbZhWWQLkA8xHJEDCiBTnaDdNTq3NMp8XbsniXkzumLRiY0hP+1wXQOx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22052

commit 4ef81dcac8f6e08b29c359ab147dd87a488d178c upstream.

Enable I3C on RZ/G3E SMARC SoM.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/9d1cf2cdb1c11f24378404142e4c8aff680c6961.176=
3638659.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 7faa44510d98..f05b9fec05f0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -122,6 +122,14 @@ raa215300: pmic@12 {
 	};
 };
=20
+&i3c {
+	pinctrl-0 =3D <&i3c_pins>;
+	pinctrl-names =3D "default";
+	i2c-scl-hz =3D <400000>;
+	i3c-scl-hz =3D <12500000>;
+	status =3D "okay";
+};
+
 &mdio0 {
 	phy0: ethernet-phy@7 {
 		compatible =3D "ethernet-phy-id0022.1640",
@@ -219,6 +227,12 @@ i2c2_pins: i2c {
 			 <RZG3E_PORT_PINMUX(3, 5, 1)>; /* SDA2 */
 	};
=20
+	i3c_pins: i3c {
+		pinmux =3D <RZG3E_PORT_PINMUX(2, 0, 2)>, /* I3C0_SCL */
+			 <RZG3E_PORT_PINMUX(2, 1, 2)>; /* I3C0_SDA */
+		drive-push-pull;
+	};
+
 	rtc_irq_pin: rtc-irq {
 		pins =3D "PS1";
 		bias-pull-up;
--=20
2.43.0


