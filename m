Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C91C35FF8
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.35])
 by mx.groups.io with SMTP id smtpd.web11.34867.1741778817106319739
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ByRz1eWs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz2ndvUShczAmMnRyOSWglTZLRImC6eAA/PWOOytwbMYbawne+k+z3RhU6iyxODWk+/hOz8ii6KTUG7PyPd1H9YQ3ZDO1JLEKcKveIwD+rm7FLBMyAE/jKBoLoW/0DxpGMuJAmAvgz5BrLklXsrGXdPI7altNzzVAoK3zOuBRZjE84G2CmWzpO9Q/dvcLTmpQ2DbEmmIjEjekmsoJMhg4IUmt8DDyLdu1N7sHxQWhDsz2WdT9ykQAYPbC32bj7qnHh3s1kVHf6JTFv85FOiYJWHMrPz7h8niy0gZtQscyA0v6SkWliTQHfdbUxv1g2H8wTc+U38xEcTVQS+4JuchJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJuwVnYQgzMh2nTfrXvAUTrZCndi7ht3Um/aUnT9myo=;
 b=puZStycSFoIsm+ekMchirC0XYJRwAQTmU791ShnYqcrQrXaMuAVO8IO8fpZUlY2jnikuiVgN6at42R6KBxfZVeJp8myoY+aapwNISEhy93RJTON/Z3n7wAdUxRcYnDO+qSydut0wcHzBVfTtOlfG2UiUOdSY2bXSQerEb+AKHsStTg8cBjZgkvx8UQ5cFxs+d81DY5CFvy98dXkBBEy8iJNzY8/zabqH0Jq14aRpGavxqxjNeNW0MDpDRoDjxHs5Y+qtGr3chOGepxkl7gtYrJeMv7CBL3cltWx6EWPuRE+bxYPXvTZkZvVnnWsy4m7nkLbfogvITpWTFstJ4pb+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJuwVnYQgzMh2nTfrXvAUTrZCndi7ht3Um/aUnT9myo=;
 b=ByRz1eWsX4ukQa4uO+ggKMd3XAB03rxCSyaVHljbZdYm6YzcL3SYuteiB4gzS2Dz+EXf4Ol4r3pq/75D5UCEs218n7WXPAwMiuXXNxfwezrwchDOygux8+To+xgDqVxyUXvvEFv9RH9WmqdFlzTTupVWVAIz6AC2c/hGNZdjzuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 68/85] dt-bindings: serial: Add documentation for Renesas RZ/V2H(P) (R9A09G057) SCIF support
Date: Wed, 12 Mar 2025 12:22:45 +0100
Message-ID: <20250312112302.1605750-69-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 645d4057-844a-4a89-7329-08dd6158cb4e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Cc+2bl0Dv7ZxPLC+yoJLB6qopPh79P9h840f+PrETy3IOPVsOas7n4enOz7X?=
 =?us-ascii?Q?M+HMfUdN9WSIRoenpfQutDvAJsTHbwjaiSFefqDHoiUYZn9Y0Y4C/n4JivRV?=
 =?us-ascii?Q?xerptN5KNtBUCk48Icmm3772oBVarF8ZLHN8q0hmaBZJVIqRd4J0NwZtLkEZ?=
 =?us-ascii?Q?aSb9e3WGLIpWl+9IGwql1s0cWZea1pfUnXEBr6skUiJVF66ciFfDofBUBb0R?=
 =?us-ascii?Q?barfSuxAJjcCa7rlwXNWNnZ67KPDXbbiNrDai9VuT7//oaDxCMWLAgB4/L/E?=
 =?us-ascii?Q?PwndARksS45OKZtrlSAtYAdze+Xo6igC68eJyHBqGNfsCN1R02vOYa3ZTpd6?=
 =?us-ascii?Q?aB3n4hQ14dVAdhzTo2frc6myBc/pk4UAfusNE+xhjiNpodCm1IndGEYMTpdn?=
 =?us-ascii?Q?vF0q6kYBTQUdexK0gm+6xeyuuXZO1IUa84vAkt9E+dqSJ+1lEEAIxZbcqulT?=
 =?us-ascii?Q?6twnEVSo1/3L6Ovzq8/0VOWgYTut0nNtrDM17q2dYljyacHGLRD4Jw6NGk0c?=
 =?us-ascii?Q?6gzAsE22dJXYioM6VpCHLl2IQMJYlvd2DlznNQQ9g6y2oXU32Y0NeDGLvNlS?=
 =?us-ascii?Q?zuCTCG5nY5OLZVN7kvAHGBB2U9rd8RLl1FVmDPqXsZ9qFaDJxPSCDpMaPR2m?=
 =?us-ascii?Q?mUmkb0AldjWN+kMsStR9voVdEuvav+ENKf1J0GIhjUgP0/QZBVDKSSdqTnp8?=
 =?us-ascii?Q?9eCFTBa4GrBleqHd6JekdwopQp5QkMXxsuf4pn2/bieNPUoXbBJ3BkTxk9PT?=
 =?us-ascii?Q?t/jlsrvU72+R/rXRoZYnPnr1m+dgkJlmNeidzM08phH3MfD47yWPbk8DYYKu?=
 =?us-ascii?Q?UfR4RWmmjXqgCY7TVkF4QQuq+2//0/jXY5NKBf397qLMghF8F+vKFPHB+vjh?=
 =?us-ascii?Q?x6xCdbpL9gH1qwfwx85fc2gtzmsBjaedUhrSa+pmN7/N5C4ydPFxiDGHZYqF?=
 =?us-ascii?Q?aqfcLC0AHsnV0DY+igYKWn2aICCQRCYja1H0UvUCE1te5jm5px7LDhCxD9zx?=
 =?us-ascii?Q?TXMf2zs2WNUD3HpttX6OYonvxbU3F6wlTcvW/K/+P80rhpdPVTXckMdHPxgD?=
 =?us-ascii?Q?hzlaGxWOjPqiCW/y5w+URsn/chALSTzu97JI+my4jpQT0AnSPJTbc1B7QayF?=
 =?us-ascii?Q?1Eejq0uOSUFIBB+7XodPWpSzBX/cGGe7GkdDo8oczNN/WzzDZqBwI7KI0M4Y?=
 =?us-ascii?Q?gTHlc+P81NDLqeIHDLBFUkqDpCmEzEYW/o3taL3CahK+91jRpRBhbu5lr+o9?=
 =?us-ascii?Q?VESyFo+5dAGKgWt3S7BCiREsplttf026VaWpvhQOd+gRoWDNmmpZq8tzdBIh?=
 =?us-ascii?Q?FvrPw8XREg/BbB78TiPYkQAOktXTcNVzjHGD+atHxPzXfhoipKgvezCZ9fDA?=
 =?us-ascii?Q?e8BN289Nqa6jhMPXNTXaAegk3pdkXkpPnKcXWS1LA5eUXkc/qEcTRQ3qPDYC?=
 =?us-ascii?Q?a/A4f0FbzPwtPaqVgo0rd4fWqdgSZnLV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tlhjQk8goSNVeMBhJxaZVX5OzGNrmMspljgOiOUAwhSlg9jfcnvMa0jOvUI1?=
 =?us-ascii?Q?4Sk4r2bORL3eN+B0SbNIVU1Y4wYrhxfa1lo5ERHn7bLKDzfiblzrtFRlWD7F?=
 =?us-ascii?Q?2Uxlwczgpe5PbiNN0VJMrLV2atMxNPUYIpwITehRxurtfq/Ia/aGtmqalt4l?=
 =?us-ascii?Q?KoBBozG91JJlD+v7iYEe39eOalzZrzMrCqzXIOGDkrZ9TiIXuZZ3LS19P5mw?=
 =?us-ascii?Q?iRh88uMQYsbDGPnAPEh4sEL074T9RPw1jSA76MQLtt/lKtR4dNgcHJRJ5hOn?=
 =?us-ascii?Q?2X78Jz0UffcRliFdP9bfqxF1dl80f1H3oqPN6+tlyE8G3dZ3enT66Ewan5xf?=
 =?us-ascii?Q?LuRYZZeYMeMFKCxri/sDg7h2ZvBCzwzfJd2cgpPUTNVnmrNui2WIjbyw/aoW?=
 =?us-ascii?Q?1O9qCDBJNJcrKwAVvrH2h0oaFAmX0qKBKMumiIW0sPRYD1NS7E7+6IcRI3NY?=
 =?us-ascii?Q?lhzs5d/TtdjPLMwnHomxgZXvFz9Et+CuzC2TpCTApikDTCrcyzOlEFN0DrCl?=
 =?us-ascii?Q?wOxi1N0hJk+NhlkRplPI+fPXFVo14sEQXCKN4plOOlobVjVXNCE/IkM3f0eH?=
 =?us-ascii?Q?qUzWfbeBNiURYUZws0y6Y2v1JkZdW7KDmYua2Og1RgpKvB4/kUBiaXmC0aoc?=
 =?us-ascii?Q?d0q7DHsERtDx/+IYNGhnihJ5db7QIAs7InLZUfqUMm9Uj8c/s4E9BcZB790m?=
 =?us-ascii?Q?WLEKlBa2ZFduwywl6tZOKFHXhxS2QcnmsSAZ58eeV9Xy7BWYRvM2af9G9t7Z?=
 =?us-ascii?Q?IM8S0XBm7aolgzJeFFpMGQfcuOhwA0siz2RdKcycgFllWYAeCeNei/VxSmUH?=
 =?us-ascii?Q?7hDVD2eigerWWwolLRuC6NpwszcUzhtd6R5dZIprIrRV74ijauKKo6WDK8kC?=
 =?us-ascii?Q?uzKs46NHA1oryBegGe0H71mmGobACQeBwyplQ7zNBVJyBWi1t5lB6WesTToz?=
 =?us-ascii?Q?12y6EB/9Fdn5Mf2oU2AfkvAuO1Ef6BQILbA3FY/ufImfPP4efOOQMRdShE73?=
 =?us-ascii?Q?psbuJFmBwCKMRde/qjayAIHjbk7f1O2vhw0booyRD0bsyTX96y6+b3XdvZwk?=
 =?us-ascii?Q?JNzx5o4dI4PFzrNQamepb5tKJ9mjwMAMTapJcdcH74x6iNDhMM9gNZrBc2op?=
 =?us-ascii?Q?F5XSD2xcek1I65vRlsNwQ+8FUqUzIraYrqOtiNQ3nHyqDZzqYM6gNwl07SN2?=
 =?us-ascii?Q?oJRvd9iNW9AD7lOBul3yR09RTzPFOGzAtlN+DbWomWJ4uZvOjWF1lP1Zf9IC?=
 =?us-ascii?Q?refKOeF6k8TiJcL6kOi2U46554l1C9UEDRxJpCyOPBr8ZKIqnOA7koPFO+MG?=
 =?us-ascii?Q?aTda3f85ftzOxYvTZMRVTRaGZ3/iu4XAwJ0VyiA4Y3E5J8bgswngW81NB5Wa?=
 =?us-ascii?Q?kwOATl8Ilxb4fUiL17pLxyH5STNj13EHh4YVhLNOP2kTvf2D8H76j0//VDNz?=
 =?us-ascii?Q?ZSHx9jeqIwGoTK/ScslMaZlRAFookt2faWhPc3b9VVGfsJPXVXI+p81WX0IU?=
 =?us-ascii?Q?1J4CinhtKA2NXSbCAgCn2nVl2sc59yDQTX3NMqmUi7zPjArdCYJwdqomJRkR?=
 =?us-ascii?Q?Cj7Zosp8tDe8ZQWx76zCQsEtVHCgf2DgAxYyKygwraPWr6xFdLZx4oki4m8P?=
 =?us-ascii?Q?JCROjzs2luEfBaqFdfas2U0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645d4057-844a-4a89-7329-08dd6158cb4e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:55.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DXm18Xti6ZX6cbLbb4O84dHpCyMqWYtNYVLzaQG4cUrLADPg/umEUe01z0HctugDNJbgTDDGXZqSkh/yCaVQ1KT4Zj8yQxmGqAUzswQ44pxjmQ9Zmp4gfPMDi4LtgWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18160

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
---
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


