Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEDFC7EE3A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.17])
 by mx.groups.io with SMTP id smtpd.web11.419.1750690122755615946
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kN5OWQTS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERJzP8xx8RMSMjxBkQ5qXrmEoFoCmHmlNptBPJNdJlzvfPm22L2cUynKy8tlTr0B2C2ZU90YJWqxSgX78wxr9Rsv40O0hS5zN6FKnXPjzm6fNUv9Tkc6uqJnNA9GQD2HzAkc8NjFXe8cNCgMoeTtr4tfV5oz50JFxjML4EJdLIgO6ymptYLTWEqd8Y9CcVBfaPvSlsdwRMo0EaTlQZ2ph+m7oaL3dsdP4TFxRKgsJB5MiPVjpoabb772IF9WDLduGKFrfXD0YfdwNelocEkaHx44BxvMOUyLzMG/MafW9rXBFiRvVb2sIYBHMHTjpK7q4P3NARXZF7/sjMFUShD5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnsZKfCt2r5s5EJU4cpBH43XlrrqnVxKeU01EdFe3/w=;
 b=kRgEpNGVKso0JSOsDkHFPeUMRjLIPBjowbefnAEs8BAfMHTd5P8UxyHDjaibKT2RTY2wRKCsE1jloT62uqxFEaLdy+TWPDjwENkOI2SJlM/btUl/cW29VzPV2Exb+XXfK0CWovGLZgQE/EHj/Wk5DTFLRLQXlnRHBOvdSV6MLI8C4FtUqTyjfvNXyZqonUse4lTutAQNwa+rXVD/n2gzf7tE6beTTDggsyA4M6UIbDFTJEAvQ3SfBEdwn+V4xiN/OokSi7TCZsvQqcFQspZdhg/TKdpYrp21xjQmdMUTpsxmo0spCY6aMwEFNPUO8RA/t++pKVXZkZ4SJFI+5LnPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnsZKfCt2r5s5EJU4cpBH43XlrrqnVxKeU01EdFe3/w=;
 b=kN5OWQTSY91jAleGmscFnz/z1f8CYpwspnliG1nEbM40EwAg7fWyvQv+g2mGuk8roopBHh43lC3tUXo+zQsAAs4Nrx9TUP3jHMeUjC/MRnUrxgx9mVDwuohu8zlD0POKGFWF86Tb7tbQJCDMEEInOrGo7sUcFQVenqfUPSPwA2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:42 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/10] dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
Date: Mon, 23 Jun 2025 16:48:09 +0200
Message-ID: <20250623144817.2119838-3-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 816b046c-e749-4052-5c92-08ddb2650be6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?N3SLRLNFoAf/W/s8gClMrBVlrFg4Ag5p/A6ZZEJYCMCLl3HeunIN9kxGwn2E?=
 =?us-ascii?Q?1UFcO6hkOTqvBxEvI0v2mM99fDJuJlY5Ai2TfVAi0YyjvqIOFHQ/li0jDLAX?=
 =?us-ascii?Q?zj/Dhth4YKjqcUP+v/bGXMSHBVD/HV3gfDndTc1xaw4y+UjSqObg0vEjrpGS?=
 =?us-ascii?Q?iXojMtVkap09lHUDfSdhmEdBMbz+Jljo7nI8aGyxkzgNQEqu6Ma5AJxf4xI4?=
 =?us-ascii?Q?GmUIg6qb8Vl6M+UkHY9QnawWDv5fa35hCq1BB9fXmypuq2aZZ1i9Io/6TjJe?=
 =?us-ascii?Q?/v0QBQFeox08sb3CDTjmKzBK4wSHH7nMwa61M/U40GhzdrFv3gKDJEAwMd8F?=
 =?us-ascii?Q?wlwtgQDCMxv7w5AvFWA3Gi6n4GpjoLyqupaZeZnPByH/CXClOc8lA2QXFZOz?=
 =?us-ascii?Q?8nerN1gdYlnN3IITDgU3COBVr0OuFbJ462XMvll3VOLZPRc+j106f+Ysm5Zp?=
 =?us-ascii?Q?eN8m9cdJTaMKqI3cm4OGSqKriO6Z1g18bOfP+DiXFFeOp1gm1nQPSI4XUi/w?=
 =?us-ascii?Q?1qwbS8QZ/xIabt6z5PEy7lmUdv/UD/xUXTUD2eglYfTB2ANEuEbjt7m50TOM?=
 =?us-ascii?Q?SjxgFHudI+VBlW/mb032NICUKODuVDCLcXp9KcC1FGIl0tmuxbl/rdYIw/Un?=
 =?us-ascii?Q?Nh9W+FFKPn6qpjX3x8gXBfiXai7vDA3594LnoRWIM0U7tT9T8KYaILrh5HR4?=
 =?us-ascii?Q?OicRtc3Z3UKbv9OFGhSqAOv6aAryr0a4Xywm+O/6+ZTYZylhzoBW+FDS77N/?=
 =?us-ascii?Q?DRPztBGA0AvFuXkmJLEGA3N9JVbXpl94sc2vPzIZ61rsxtGa9PtwVzJP189D?=
 =?us-ascii?Q?1UZZWsblUyABTIcOzYEcv0/Y/v3s4Qy6oHR5fXBDbIpdKkBNtKWFa4QvNmu7?=
 =?us-ascii?Q?yRzGtJacQBz7riPAY2EFKV1sdDMIFxxqgrmpAeehOF+FaH2eCp+aWJ14KVky?=
 =?us-ascii?Q?+C/q/0TBMJ22cdpNRK/qJhmWGN7A9+BNP34xu0RXvo3UmAaHI+BB1QCMznNz?=
 =?us-ascii?Q?8R4jSSq8jgPsk3cx1bRV2R7fJHgvs/Sgq+XXaOE1p6Uk714Gc6X/N8u01Ax0?=
 =?us-ascii?Q?gaoInCiUr5aptPfPLNlonaFhO4ZIWxlhFyokvGtbotPudPLpKZoeFIvrXxZi?=
 =?us-ascii?Q?TFb2xVqgjyfFgGVH0AMXWPfrbmYdHXa/IPPTeRjS9lp3fiJnGYk3Ebt0qLJu?=
 =?us-ascii?Q?z3/9S6MtQG0umRLBjv6KwZlVfTo0iX6tjeT3hKGkj07FrYdfQGBjHWZbxp8H?=
 =?us-ascii?Q?tiJbX6cYX/uI1pVxxOi9tmRuM92oyo4WmL2FjAiXVJbU24zSle+lYUps5pQ1?=
 =?us-ascii?Q?X22gkuiv/xekwGO9cp0yHKwlBgQ9vuCblmq77glWv2PpM0rTJoSBw4TU8fPo?=
 =?us-ascii?Q?IR8itcPx+DcZ5+Rhz3daThOEP2vddL4JuMHdrzJbwjxM+aXpzrf4Vn0Z/5px?=
 =?us-ascii?Q?NVZuB/8GdMhi7Gi/btvV+lS+5v2Z481CHibjXSTW1cr7jhi2DxDtJw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?88gdnXCl7VGAWkguZb88H9aHzfLiHcoVWszCF7iD6CmgXuinKgwRfOXdLGct?=
 =?us-ascii?Q?qeTMg+HJRFS036DQpN+wRrZu35HeLg+TaUomjpbr9Duh4s1IaMNBq3O0PXtd?=
 =?us-ascii?Q?tgjZ/GnKQnjJ6S7+mb+dLjJwzxzLIAYaP0X0BhjfBAggOZ6g4tsQaMa5JRSh?=
 =?us-ascii?Q?jRjfbrf2FgMkkSkQ+VYzLH6bjX1IScmbe0GZU3L8Lm2bAoKEAF4i8BdlZVDl?=
 =?us-ascii?Q?gOyWzRQxUe1ZY4RO4T8m53paRsQqiqsYk6IaOLNJlZapVyM60y/TT1TE+vMb?=
 =?us-ascii?Q?9VM23Nz3LNKk8EGHZMSYkfUwXfQNzt0q8ZKHkxy0dSfXSNvV31WDIuwjj1Km?=
 =?us-ascii?Q?4K+1Hz8JYMrOSA6BeCTubrhj80mNf6I9UTTzCLsB05YrFR6IT4H0RaXLn9I1?=
 =?us-ascii?Q?chYCSWFx6VryLi3lKSRMtwuZ77eFFYNiBdYtbLN8USBmilgkJfu7hTIwdCkH?=
 =?us-ascii?Q?U0SIaObmvVRFjD6ETnIl7Tu6wQqE5ITP2YGjWQrLt41NDbZvQMinwr1FlrCf?=
 =?us-ascii?Q?OQroY9WOWYUte46IvbhRcvrfSgwmy8KP8yNNOgL+bLXlZjxLJYfE8D8O/cOT?=
 =?us-ascii?Q?EfuTTIb8Ugx0dGszmqcqT3HUh8o+Z4EpNIPDwEVq1T1HTP4gGShzzKRKkK7c?=
 =?us-ascii?Q?tB/OHqb/gpugKqOLmvOrw2qr+VLTeD/8ywwNjaZM5tzFT7dSnql3J20Eq+9Q?=
 =?us-ascii?Q?hoVkhAZUEs3ubSeqpOErnGONRB4o92AmBbtnRG78RC3iKuN2I1NM8B3H61Cn?=
 =?us-ascii?Q?ZMhaGEJUC8xihB53rqVmoV6THynipQ2uyNpChuGKscjn1TCEaXNp9OqhQ3P6?=
 =?us-ascii?Q?DtSoegJ6PbDXndGQn5jThdX2Zfc7HGgXAZXPmW/apYQKBmD8VuaKMsePjtlt?=
 =?us-ascii?Q?qOdf3duKlVk2cgvTRWstmXDrq2FwOrQZKlg7RaVethrC1XMuoM/JS1Y9SLfr?=
 =?us-ascii?Q?KW80Hi62+ulJgYem9KVcNjDw1jr24cyKG3JU36gE+kLsVSnGTOF0zvYlRei+?=
 =?us-ascii?Q?VFWBfZTpe9XRo/c/qb+SmN9QTqqsERoLxRptNU+KaroUb1UdARPEihTy9FOe?=
 =?us-ascii?Q?1mEwG0DYICCfInNni2i+fHXKmHJlOFuFwDBVMiKXDE+rdpQ/vq6qw9ADQW48?=
 =?us-ascii?Q?53LoVub7dbJHU6vXgymb5oc1YkEaPmmAup8UMpbTXUeYHEXeu5gtrXIFLR53?=
 =?us-ascii?Q?Fqr5Czy4eCgNYhFtGFzkK2y1/nrLBliWEdmvR6DRFZzRdjrTL9gubFYebJtf?=
 =?us-ascii?Q?IyR3ajRBD3qgvG0rrtVwv2Bu8/T4OzR5+oS01O6SyefF9Dqd3Q3YsB9YUph+?=
 =?us-ascii?Q?qXrwAazbquA9mJfxGqNm8VFvWuyJ+Z4kM9MynQ2Bi/47WbqEz4gse5Yb5GoZ?=
 =?us-ascii?Q?ZcdQLFqjGOvGSchBtCYtJ0g3eidynjHVMU6IHYtMAbEvwZ6rp91XPnWEbGxA?=
 =?us-ascii?Q?/UV/tWarnQYLhy0j5YaI0rZ0ZoYuxEZiYfInuQqdpP+Avd6rCQgkMb0yHtRy?=
 =?us-ascii?Q?X0qIJn5HnfhwjUY4usVitJs0NAazrTyj3OpO4+82gIHTnxYqmXG4a41MboGC?=
 =?us-ascii?Q?HuQPYro09ru3WbMjmC2SjEMybmUolspt9ICXvQnJkUq6YflG7KlytaEOZCfe?=
 =?us-ascii?Q?YO0WvbivmUqaVxluE5n9dNU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816b046c-e749-4052-5c92-08ddb2650be6
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:42.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBcLOKl/7GVtwc/DZ2lfZeEtZv6zXshpsGDKWIWNnp1I003s396xMSXVhXyY5Gguc4PxzMTZQGyoIfIoCfP9KAS2ubd4ZFdHSru/QFXOH8YuxtDje5gOypO43LWEoDXP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19207

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 93745285ad9ba11ef68922787e0f46da408ab0b7 upstream.

The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that
of the RZ/V2H, but the SD0 channel has only dedicated pins, so we must
use SD_STATUS register to control voltage and power enable (internal
regulator), for non-fixed voltage (SD) MMC interface. However, it is
optional for fixed voltage MMC interface (eMMC).

For SD1 and SD2 channels, we can either use gpio regulator or internal
regulator (using SD_STATUS register) for voltage switching.

Document RZ/G3E SDHI IP support with optional internal regulator for
both RZ/G3E and RZ/V2H SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250305092958.21865-2-biju.das.jz@bp.renes=
as.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Docu=
mentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index af378b9ff3f4..773baa6c2656 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -68,6 +68,9 @@ properties:
               - renesas,sdhi-r9a08g045 # RZ/G3S
               - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rzg2l-sdhi
+      - items:
+          - const: renesas,sdhi-r9a09g047 # RZ/G3E
+          - const: renesas,sdhi-r9a09g057 # RZ/V2H(P)
=20
   reg:
     maxItems: 1
@@ -211,6 +214,19 @@ allOf:
         sectioned off to be run by a separate second clock source to allow
         the main core clock to be turned off to save power.
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,sdhi-r9a09g057
+    then:
+      properties:
+        vqmmc-regulator:
+          type: object
+          description: VQMMC SD regulator
+          $ref: /schemas/regulator/regulator.yaml#
+          unevaluatedProperties: false
+
 required:
   - compatible
   - reg
--=20
2.43.0


