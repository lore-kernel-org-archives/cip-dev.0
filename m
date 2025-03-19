Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E2BC3DA4A
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.54])
 by mx.groups.io with SMTP id smtpd.web11.4367.1742379420457296674
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MmndSn7I;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuiZQVFjVmaiQfl0vd1g3rPTg7n4tayisuBBsf/AvSN5W/PbANYggTmgCilvzAYi9P+YyeR4nSuPOwOBjXv5bir5r9iEZZ0/FLRLUoikI5OijNMvMA4XDrTbbW2eos+1HpAVKCDDiJqegz8MYryY95An7Uoq1n1ns1u+iDeT9Kw4GaL7u10TNWc+9gpclXNbmxBdu///AmqAPdncnNCYqmnJVCp9bbt77vBKEjY1t+5KpaoPDWTZfawksSQKJ6ncoOfv09bVgcRPgexayfSFUKvvUew6bMPvw5JWwSaFQalRA8HlQ//Ghqn+Y+PwiQCZ4tEtkfkHwZEvbaoB4MWwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxZDigU3PKX+//8EIwTHiqGEBXywdVrLdQ343zEnXA4=;
 b=RX/j0vfk+lD8xST3mRXTqNFxkGIxTumkDi/wL8hDjwmCklouNtiousX1xphiYg9Y9aa8OXR7wcDlw0INBLfR6E5GAmNgBm+dmSA/Zps9VC3D9YRSh0uxZLCtXBdlk9wjwEztwkYKa/PooIBjv9aN3NcUgYxBLo4+vBTDSlZIurr2AjWCETfNs4E2cS7IrJ+EteSCrJO5JEe7+2KIpOtS9gUM7uToeqUOuamNAEAGl8JHA4muDupIf+RLkiHtai755fQkbidhYG/457JeEs8m/4lWRLuv4BL2v+NGd3Spea4OFqpp/2VBQkQivnC9kcwFI0udGq50Ip76iAe6lkqi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxZDigU3PKX+//8EIwTHiqGEBXywdVrLdQ343zEnXA4=;
 b=MmndSn7INVXtVRHUWrk66mlxjF9+JHtm3c/9B6eAQeveRyjUhnxq2WDHKeNqzkGmd6LdHRtnFeDOemOEfYqmKgwLr7xoGEVsXlLooZEqeJsNXW9rs1tz7vo/XAq2WhbKjFdQhPgHocaN4pbQJ4b0d4m2kXUHDQUqaR36NE+qvtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:16:57 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:16:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 04/12] dt-bindings: serial: Add documentation for Renesas RZ/V2H(P) (R9A09G057) SCIF support
Date: Wed, 19 Mar 2025 11:16:21 +0100
Message-ID: <20250319101629.2407727-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: 0444e307-2855-4bc1-1886-08dd66cf2db0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oHLph3QbAN/ri8Ekt3R55efNQ+cjNtd2sHTcvmfytHU1amHBXrvbUTbwJQLy?=
 =?us-ascii?Q?qTYJo7hrF23b0N8wURhPtg9EiM5R5XYj1WgzOoMnfUQRI6xv9DZnvzFbHrqJ?=
 =?us-ascii?Q?D9QZye2y3oHskai3PezUNH6eFXOmfqxZ8KcGQvDDCBu/QzBZI17UyUYeOoV+?=
 =?us-ascii?Q?iPj20twTjwI0l9Qg3iGAu+43fZTY9VkWuGE1FpdCs+tWWG9vv3LOoIKSLcPj?=
 =?us-ascii?Q?/AcTiKaYPk7fKEw/8PdQX1xUoZakh/yrhCRrO7SlPAhgxfj7cAGIbQayYdeA?=
 =?us-ascii?Q?p2a82CvBESUYuDmtOKrEI5mAi/6t6bTu3Uf/xGJiW3EI09+YvPw3oo+Cp64X?=
 =?us-ascii?Q?M4/B9/yr8BQdQkhOWJYgLSF+toXt3W6Vpv9uSrNuu4nvbxAZerxvrvlHabzT?=
 =?us-ascii?Q?voJypaYIQVo7k4VRLvG8DsQS+sklVEacf2YYYHkFsoLD+kPvvDro88pB3O6E?=
 =?us-ascii?Q?5dT3dsQ4dve4hDGVzLc2a1gxFakvZPQNJxL9seNMv4MoNfdvx8MgRUe6DkB4?=
 =?us-ascii?Q?zdQdPjz+dAI6REQ6YHgm42hkpCiqdMxhQhaapjKxbwBgiUDVw+RIuvl1pTMm?=
 =?us-ascii?Q?4nczHnoD/M6a7bvBREE2BZ+cMV7WnlJ6bgeDT5uue63ohmcZzxmm6Ew5sL70?=
 =?us-ascii?Q?QjtJWR3F8nuHpGtXylYOV/GmJNEIok1f37vZbLQNHZRoQV+79UVbLo/uytIZ?=
 =?us-ascii?Q?nhTLDaPhthL/HUQfnRtFDsLmGN13kF/5vOrvsPuGoCPaTOzygtWdrAA2ggcf?=
 =?us-ascii?Q?7ttBfSnEND2bL5UGcKyChHJMEsxkE83FLHcDSCti0T6sAMYfQyuRPRgS//+7?=
 =?us-ascii?Q?fBfz6uO9V1+H+fN6AV3EWBlPZIc4QGfoSCZfc3fkCdbu5VMC8BKmIxt0+Jgk?=
 =?us-ascii?Q?k+F35TiFgm2KutMkRpuJHigNpyaAQDjMXLzZFLBLP/PpMTuryLTKp9jM4wa/?=
 =?us-ascii?Q?YdeKropiEHd6f5dKqFclfNYMtdvzqNtlbfimFqNg0DF5R2KuN8sdiG8HwzOF?=
 =?us-ascii?Q?KiDko3x6ZyKGEYzZB8IKqkeH5o5hHj8FS87JBJqQOQqqn0rGQrI7GOtVhS9d?=
 =?us-ascii?Q?p2fRPkXtaZgvIK0sK9cz05bDz2TwiZn0vdMiKueqlLliKAHRqyf8QybJcTDq?=
 =?us-ascii?Q?UQQxzBfZ/Im4uyF8Pguh28d3pWiTNCbL6pO7Fb6FOlHZqryuSFagIeOM1tji?=
 =?us-ascii?Q?WgUxc4v9u0X5/BrCi4jMSkEG+4/GITyMUNmN/OzR0PQJX5s9A2XdV2zbHgkn?=
 =?us-ascii?Q?xPwDCy63JmleJQihijMpkfjEul4ZsQWZds4nb3OjzT9NvWaNiya9HjKJ5Mqt?=
 =?us-ascii?Q?ZW5bmWEtHsnyCKTQ9WBAzjq/40EHWsf7uZCuMhSHiH9jpHYWxHboOfMEcwM7?=
 =?us-ascii?Q?E/JfCAIjP7ydoQ9p5uqEiXsa42+YTDdoV+QI93m/395Kz52Z30U+lXYCM4YJ?=
 =?us-ascii?Q?PYXL8aIE9PhMCeSAfUZovJ9mEt80Rpbh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7BbLGdeSqCMMmxR9mlkVxZ2cd7eAV0UP4/bkxlZHJXTg6wCplmX1k9q/NF8M?=
 =?us-ascii?Q?EqnQWQW1luDh/YadTPxVxEtg2QpM1e8QFgl+b+z7tlVuQ7q8THa9bFmd+s6I?=
 =?us-ascii?Q?N/UQtanxoA8GklU0FYzYATgSbMI1cpUQi0OWzfpe+LSxO+XAZMqqoB1qVpyh?=
 =?us-ascii?Q?sqN4vRb1lKftM15Fuz32C+zhLUOa4Wzz9zfhJRfSGVEvG3nwduJRqmZlz93n?=
 =?us-ascii?Q?cIKL6NCjaFCcuwa5HeCQfq4mPkpc74dugorZGQPm7xmv5HybQJVL1RQI75M+?=
 =?us-ascii?Q?NmYAyuJZ9F5yqIFFdf8+PbjtYQvHV6EYZABNuhXUJOKU4meqbmjgIG/97VlK?=
 =?us-ascii?Q?6BG/+CQBZQ4ORBCh1N+jfSJFmlt7Lgx4q+5TZJeX7iDmeSBQrbyinX5jHNUk?=
 =?us-ascii?Q?HIC5HPuqYlY1BvbqcO6TvfpLBhk8gEvpNxWit6K+ds9McSlVkVDt5GU9/Jyz?=
 =?us-ascii?Q?YJ8NB2z5vP9lfe3uIlpFVco63YS1Vnyg3phM7/5I2s3DPZciMnN34U5CHxs3?=
 =?us-ascii?Q?RpzBFFuiTV88Zjufqt0KeRbmKeI7aMzGeGlalqg7vbLKOeZLgBhjBA4IIG0/?=
 =?us-ascii?Q?dJTyzyDEPYqh3+WdMeJL86rg+c4HTMrfWwgZRFZTm5FoxQ/jtelTiEEO+BtG?=
 =?us-ascii?Q?+nPOFA5Rqlum3SJUzKVl6xhfhUwIehGskm9GHHAJYBnMUX1kNC6TuIJrjcBp?=
 =?us-ascii?Q?62R2yqocX9/v9DaSmf8Cvu3xKxtGn7CJRi4z+5gExVA+u+oRHAr8j/5KxffM?=
 =?us-ascii?Q?tZboSzACKlQggKVMThZSy5yuq5s0x/AchJt8fRTvtBVb/GQriBiF0NAofrd+?=
 =?us-ascii?Q?y5OrtCH5lFsooCW0qfyuWu3Xlfd6+Qzbujo40kLIK/xT2SxNUgKSLm3Uv0t1?=
 =?us-ascii?Q?0x5Xh04ZSGVfmwbQeUGuIfA/jA7EAK5EvIGb83YHB3I94AXcMAC0tPykFx5E?=
 =?us-ascii?Q?s7GxFRT9b0soPczk9GIaZdlH3AXyBlFXcDU5/cV5coqHRrmRsbSHQGafytOs?=
 =?us-ascii?Q?qgqgfEHMMctYkYLx2FSlYGPFs6pied7RzrJ9d1Oo32AEBCBqsDCvakte7uJl?=
 =?us-ascii?Q?DA/fPDSZ8XdhRgwfo8F+d7g2r1HwobGZIN+Lzinw+Kebu8Fy2s1A/Y7nrdmP?=
 =?us-ascii?Q?oqwtK8C4aM38O3MU9GwCKmsJ4cw+RyyyTiBGXF66Y08TJ2veP8aZFSYozRFN?=
 =?us-ascii?Q?d0CLWWgIAdc9PhCMfWGyV62ytthzIuFtxgCiczi/CVmf0wT9vxeUGVRHNk1c?=
 =?us-ascii?Q?rZFAIEeFuVQjlEsRAX6U5XvF2vkeMBnf6D3q7pCmtAUFtCJJWMQLAmS6oD+G?=
 =?us-ascii?Q?3Dm4aHcxlK5IS8O3qQ+xum36xgop9T0CYaHpekmZ3poYNIF/iRyyXlVuqG/z?=
 =?us-ascii?Q?ggrg4rnb9tGkK3GK27XLP0jlH5mTX1/8VrfR5ZxLDZ2Jo05OGhMf9pq7Xyps?=
 =?us-ascii?Q?8f9BFes4rVfotyoG/ESM2oabIGY+3+MnjvT/z9Xbr9g+XvjYca3lBnZgE9W9?=
 =?us-ascii?Q?H7oMiti+g2bUaB1RmtEaIdjBPP+xa3floJZIPxzX33ssacobaWC/+txaDIjh?=
 =?us-ascii?Q?iz/yz5n93Vn0FHQScHR/fI+M73PLf5QF8vokAp34e5lx6SF6PlH/GPSCX8WF?=
 =?us-ascii?Q?SDccBdQ/WQD3d99SIG1RvI8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0444e307-2855-4bc1-1886-08dd66cf2db0
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:16:57.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8YBtFg7uEvZ8Akv9kLpty92gOvKVo3pZKSdPybWtKc0Iz8Qui5b0tei8L27eF99Nz5djERKHh87g4gbRyWgHgqeQyqZ3n5kfIS98M8BHOIPDnoKoH0q64DJbOK/ekAS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18265

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 964a80cfbf56f5fa88f09d704c311ed6db0a361f upstream.

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
(R9A07G044) SoC, with the following differences:

- RZ/V2H(P) SoC has three additional interrupts: one for Tx end/Rx ready
  and two for Rx and Tx buffer full, all of which are edge-triggered.
- RZ/V2H(P) supports asynchronous mode, whereas RZ/G2L supports both
  synchronous and asynchronous modes.
- There are differences in the configuration of certain registers such
  as SCSMR, SCFCR, and SCSPTR between the two SoCs.

To handle these differences in the driver, a new SoC-specific compatible
string is added, ensuring proper handling of the unique features and
register configurations of the RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240604170513.522631-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 252c1e6102a9..7b997adec92f 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -78,6 +78,8 @@ properties:
               - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
=20
+      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
+
   reg:
     maxItems: 1
=20
@@ -92,6 +94,9 @@ properties:
           - description: Break interrupt
           - description: Data Ready interrupt
           - description: Transmit End interrupt
+          - description: Transmit End/Data Ready interrupt
+          - description: Receive buffer full interrupt (EDGE trigger)
+          - description: Transmit buffer empty interrupt (EDGE trigger)
         minItems: 4
=20
   interrupt-names:
@@ -103,6 +108,9 @@ properties:
       - const: bri
       - const: dri
       - const: tei
+      - const: tei-dri
+      - const: rxi-edge
+      - const: txi-edge
=20
   clocks:
     minItems: 1
@@ -159,6 +167,7 @@ allOf:
               - renesas,rcar-gen3-scif
               - renesas,rcar-gen4-scif
               - renesas,scif-r9a07g044
+              - renesas,scif-r9a09g057
     then:
       required:
         - resets
@@ -208,9 +217,30 @@ allOf:
       properties:
         interrupts:
           minItems: 6
+          maxItems: 6
=20
         interrupt-names:
           minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,scif-r9a09g057
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+        interrupts:
+          minItems: 9
+
+        interrupt-names:
+          minItems: 9
=20
 unevaluatedProperties: false
=20
--=20
2.43.0


