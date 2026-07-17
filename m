Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D92C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:29 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13129.1784294002543212176
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mLY25hLm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFbGUaazd/YTTs9eERpAeI19de4wXza8Q03J1QDJKEEicHd9k9s8Yn7X66M4MndQZygS6Qe93GOw3DNfG0Ss0k9h/i+Of3Qp4Cwnvw9pHiHfEJXbpIS2wNY7E+CzJGiHtNAnS0dIZ+AusqGkqocz6zsmelMp7fJNEVAeq0VXMmBerm0L5/zr86Ggz0sFX/2+tSGp4O1sei7TxCMpSDVjqKfdwtqMgTz0V3ZTJKRX0eAk0MkysAi/jw1h7fj1U7NuCwAEmAG0Fuybunt4ZDKEyqoy2/5VjhGXeF2BMzx4hujrvjFW7qza8NKH8rLrXq6Vqg6SFAAg/ZZu6FegyMwijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnH2p1yGuQzqHZ7MV0jINUItgd6ekuD3Ph2wsIMemaU=;
 b=Y+sN/v4DJOuI+jYlEI7lbXmjsOvtbk8iIJZAoSFajZlYWVmfftRv/13T1/xNNPi5y6EZr10mIUwC7LXJjnjPG6nyczsfIg8sRs/OWpL4yw/V/wlkN3aqxa5QxvuoBdRorDrzq4tTsPkZWlvxwbmAxRIUDcHnNTOz+ckR5LUyoA57yZdc2NFik2y0t/jvMgX8db2ste/Uy7vhlLqa2C+/gjEY2WJzcew1wyzOZfofqUPN7/mLwCP5CEMl3hN7yZyCvHqOKiXpQitUy0Vvn1i4iPNJb+izpEbOSL71jM20hCQVdU1QtpF9HDhz7dgLfZILb8RBtRbCc+5Sx7LAdPiCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnH2p1yGuQzqHZ7MV0jINUItgd6ekuD3Ph2wsIMemaU=;
 b=mLY25hLmaRcbmJID5I+rF+NQyGKiJEQzIGJM0uatbYA65BEuyD2mdjWZXQfrBZTF+xT3T3bZDFNeV3aP0KFUDIzXRQ9l5Qi7taMKM2uYu4AZq8bSmDzqO84taxv3fkt5VhvlWh/OHvv1ioBEx+9GQSzjSo9pqwOLWUVc1DMVyaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:17 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/23] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
Date: Fri, 17 Jul 2026 15:12:20 +0200
Message-ID: <20260717131241.2233788-3-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e04ab65-32f2-4398-ad1a-08dee4052ab3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|6133799003|11063799006|56012099006|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	MLf/WgBz2Eby4bmAluAKdTbxjv724XFuFBIyLNNYpifSxf5c0hD7MM62Cf8AdBLxfphWU175WPaeA8cLdanynV+M7YDkHCsJuwCvcvv026SIItjGOG0TIdSu258mpQSN1qnjHcYudXpvuaqXzUmNYnvpGXdwYSNCeNfMzynmswkCi5cKNyekuTCzsGPeFHjzEI6JMRWHs1nzmcXOjwicQ0K7DDeM+kR6G4gaVnQB3/ZTa++Y7x1rF4BRkPBXBxGaAMd8XyvRvIXtRAE9GkpVd0E9OYDdQBtx/hLyC8GYQYCIFKyfZY8gR7IkMTnejCo2x/aLDGylF8ccZV5xnsQ9cqWfVNnyKo8uiGK14e6cqcEg90q/X3Nbu1Bq+MNoTN7PUMArpSbhDpqh/AV0ndvTh7YivVxm+L7lGBAusX4doyRMwrE/wyVVpvrhrNy7JrR0q/DVGANpiJ7wqnLI1bdIiFeviCrlvZ/RiacSgEk/X/5gyB1cKK/bwnLsfDZ+iU1M+UfNexBmlPl5M8n4flkww2K1mqnCY5LevmnfOQ7RV3HnJR5qTZz/FpSTRVaL62dUmpNNiUteK4e9ov5CD2nQ3pvsUK0A79Mu4JQH887t7bZqwZBqvpz5EgW76Xt/D8qrDGJU2D+wJIHkDCvN3tzLpiOrF94H4sDe09c1VC+bp9E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(6133799003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dws0PIvINKTrOQywTCusYpX8HC5hBcRN38xGyxGVCNqZhEJUSpvsRkhmq8Yu?=
 =?us-ascii?Q?dKu7JdkJHAf8HdCpm5EI5akfUBE0b6C8i2VuMX6panQMNwQk2miGTHVNz8ZP?=
 =?us-ascii?Q?/SRCUKzeOfiViaM+FBz+CrQdNXjBB3SVw/AO5WuXccOZdw0YTyp1clgV2zUQ?=
 =?us-ascii?Q?q9qC+0Kef4EW0laSBBfi4WUBd7n1pMkXTPTCDuFAfhIsekvDI/8IoZiERD+i?=
 =?us-ascii?Q?eqE0HmxisCfzNxlsPazEEzr5PvZBwiZ+RqTx1G4ivYvGeJ6LswyTlfXpZGbO?=
 =?us-ascii?Q?WMZUstTUCLhUL0fxTc5QIGE9WD9SvOwTosvLLK4Sn/1Vu30NWg6X6TqsRZow?=
 =?us-ascii?Q?nfnF99o0yBYeTAhPCv/gEo9ZH8qc3uSpGuOQOFVMGHzexEsltOgVmSTKdbaL?=
 =?us-ascii?Q?wstCA1ftSNcne3cvj7kES8XMmrSEPs4w2KuBRX762yPwg2JeirVBeu/IcfxY?=
 =?us-ascii?Q?k1TePjHCW8QeGjyMnpQpH5y5rMYThx7OioIxTlyUBux4Y503SQKT6sW3xWs1?=
 =?us-ascii?Q?jJmlpa7+U4HUjJh7+qW2Tz2pZ2bDCoI+cO3H+nIZWeeEqqsB0o/sM+iRZ5SX?=
 =?us-ascii?Q?whNYVzAAe2/6eBJJyeIwJf/Z1xMZ2wtHO/rFNCbl/2rmBCU9gt9VLlhI+mYW?=
 =?us-ascii?Q?nK1xtyZrEsI0d+3SeZPAL0Idpl9ZvNZtbYpF3Uf333gq8zlPCI6Pn9Let3G3?=
 =?us-ascii?Q?HFTFHdyA+woT0pe5J3CSh6f1DAU+p1oGRqmCQIg5uYhbmNjJOhnFHjsO5vmG?=
 =?us-ascii?Q?gvhHPglTDQ+3UxcFmRZzMYYfLjpmnnmf0fZo+o/32X+irDJAWCSJYeax9NWi?=
 =?us-ascii?Q?PYSdyr1JdCZwxxLb1gWGtMbf/N4v7oHvRpVAWwOS7/ANWRM1RWczee70e8F2?=
 =?us-ascii?Q?FF5jtBc4S0B3tzLGv7VfostWSVUWqPccNtTznzVEOCCwVwWDNPckLbfbop6Z?=
 =?us-ascii?Q?3sXyZLaJUw+uZ4K+VgC2yDlv6IHwWvwa2FAB5rKmCsV+izsFsRyeGIVSCRR1?=
 =?us-ascii?Q?Q/fkBpniEpCK3U0UWNwYTusfgwi+D3lNmsSOz59nD9l5rUypn61ZasVR/bmm?=
 =?us-ascii?Q?exNtYDtLceIkEtbLjWZoJmgh/zwWs24Crm2zMNiQWljcIOg05pB06cAE+hIu?=
 =?us-ascii?Q?W6juzSwM6aEjan6webAHL/PKzMRqKHEEtJeLzLDUbR5M6U3+5kvc8ktPTuBH?=
 =?us-ascii?Q?TqAxG0e5eO+JD2YTedez9Gq2I12bPFSiRiYqxTt5gYUOVSSkNW68Q8IfUYSJ?=
 =?us-ascii?Q?uj/7oGn9NeiGPoFKtllFVQ7DzfcZ28OhY3Wn0hLjUMnar55bzTT4k3ygBZvv?=
 =?us-ascii?Q?6sULzJYrYYFsJ4UIMeVEOC5sYAb3XNFbSsrTG4ixwgK3feaQAlY2Nyvr+Xq3?=
 =?us-ascii?Q?hACGovPQVCmsowoZ6Q3FPvcj69+LoaAQhiTXukHAvpo/Q/o++vmgHH6JjeRz?=
 =?us-ascii?Q?vT26DeKU+oBa5uKZtOYksAZZnmPqbC4dm+6CiRRt8DH0/OA32m3+KwlSmfNv?=
 =?us-ascii?Q?OHJQKC+CBbBTwX2nHIalByBAzsCvLVy1VRauk9ivsArxpW2Fdd67/CXyrZEy?=
 =?us-ascii?Q?D3760s/FdcJt+oTomuLBX5wXUee9SrSeAVS9kRUV9cJcV03LiCc+tP7yJCCs?=
 =?us-ascii?Q?TpOS/PCYCTI6D9eWm6uuMXw5B1oAvD5Tm0pG0/diBlBKDuaOkpNFK2qa2cQc?=
 =?us-ascii?Q?VuUQHBfz999yZG4vMFWEnaYbu3Pb1sQY8VF5QtjJxJyVWXSmMZRCSwQvPJ2i?=
 =?us-ascii?Q?2FV2brcBFS1xQZ7SYOUmEVcTY11f9POs7GzWYMwaiRxBrqoqEHau?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e04ab65-32f2-4398-ad1a-08dee4052ab3
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:17.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t7V0dzE3j1EwTAbNkxWwTtyvMd9hWDpCrcz63oOoXT/15EczjjBL3EQd9appyEhpW2iJ8AiB5udD7prO8j+DFRI596n9FBrTi82xEo/aavLDN00ftdrkZHjK9IFjv09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23630

From: Frank Li <Frank.Li@nxp.com>

commit 4585580781d69d8627e15f027873e46282ea3787 upstream.

The register layout of P3T1085 is the same as ti,tmp108. Add compatible
string nxp,p3t1085 for it. The difference of P3T1085 is support I3C.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241111-p3t1085-v3-1-bff511550aad@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Docum=
entation/devicetree/bindings/hwmon/ti,tmp108.yaml
index 5bbb7aedda3a..1f8af3a0048b 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -4,22 +4,26 @@
 $id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: TMP108 temperature sensor
+title: TMP108/P3T1085(NXP) temperature sensor
=20
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
=20
 description: |
-  The TMP108 is a digital-output temperature sensor with a
+  The TMP108/P3T1085(NXP) is a digital-output temperature sensor with a
   dynamically-programmable limit window, and under- and overtemperature
   alert functions.
=20
+  P3T1085(NXP) support I3C.
+
   Datasheets:
     https://www.ti.com/product/TMP108
+    https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
=20
 properties:
   compatible:
     enum:
+      - nxp,p3t1085
       - ti,tmp108
=20
   interrupts:
--=20
2.54.0


