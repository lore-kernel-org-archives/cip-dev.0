Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F026C36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:48:50 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.39])
 by mx.groups.io with SMTP id smtpd.web10.4024.1742377721047115786
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wDSW2kNe;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3nDS2NwJdmCLpk220UTdOScGZ08aoyp8MueuXwh5x1rMmmXAAg6ePzKXBAOITGX5PVe92NU8/4YX/gK1cTXy2vQzUbhSI5FVjozRsAp4VPCwML2ho9XEYr/aWQp2DD0jtD5TvG5pzkChYNJnPntITmJ0ScEex/3nvaGe07OVwGzKTf8YiFNowvaSwstVpTtrJ0UywgNbzjanr4iVvSK0/lelcJvEvwhiHWBcYShOi3JP5NkYXS3NQXhPECaIHQzs7ZSlVGXsjjOozobYyZaOSRYBjuV9FBqXrHk7LTAiokhCQ/muZFRKYB9wTadcvS1gIxc312ksw8WNId9QYCXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJuwVnYQgzMh2nTfrXvAUTrZCndi7ht3Um/aUnT9myo=;
 b=J1/ncR/O83eldS4N6A2nfpVxtnmP3VEf+xZN50X27Cl6327lP53GAublSB3Xiy5dIWX1ehicsuPL4NWrLggaEPBU3R+AYecHHtWt3wYmCZ+de6dkmi19zE5NHmCM7bKEJhqKbKtRHyG44RNZZjdOiP3T9vz7E6f8mUV2liBs9KdU3sIV7jkmWltqJTLE3OnO3FnYd1xWiQyisF4Ed5NESJPTOAW7qbRIJ/7ggvpLbYDYGc432+XNUkcvoLseGrqmGKbhUnkUjAW21W00Lmp/hb/yM6rMGbL/AYYAnUi/q1YdcKeMSk9vlWN/BAihmw40eHHaLdpkXxj0iLwOJ3t22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJuwVnYQgzMh2nTfrXvAUTrZCndi7ht3Um/aUnT9myo=;
 b=wDSW2kNeexfnN/8AEstfXmLXRskvDf1J8V0plo+W7lFE3I7JRSjBX7nmD4CpIeQsJhJVLFGgti5bk/D0CCPmMLHGeDKN9j/A2OaZxcBYEuyVWHM+EKMzt1iY4A3IqR4QNWSnAWDtztcy97C94kBqh4qBpl1R9hgekHNCQsC/ZHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:39 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/12] dt-bindings: serial: Add documentation for Renesas RZ/V2H(P) (R9A09G057) SCIF support
Date: Wed, 19 Mar 2025 10:47:46 +0100
Message-ID: <20250319094754.2404386-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f7e9d4-d3c6-4809-e06d-08dd66cb3a2e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Kq1q/YBTluYbJE2oQO8GSKET68WAFIbiKzlzgtjYye2mTO9jrssLH4nCrTBI?=
 =?us-ascii?Q?cpMtrPfmukg10iX22SDDGXX3vc3bCk9dvW/1SF10j/RFT5xcoWWfuK9jUtPC?=
 =?us-ascii?Q?j/fa2Ee5GUPvbbmXeWzaZBoU7ZgHZMY84EUsJZhNXYA1eXI1sAdWFViAS8I4?=
 =?us-ascii?Q?trU2jyuBI3Wmazzsmn/l+XiKmZ18kFVYzP9p2GQXQJGLPlFGfNOE73fq/i0G?=
 =?us-ascii?Q?gAj4PJz553sRhHfGVZrEty3rC1etSworjbqYnZZSZ/SUx0IP78wydas6VJiT?=
 =?us-ascii?Q?X7/rHygLLPDxEY7d2dQED23YBva0pPaU/LcuCq0ZD6dsAYyk/dp208IJauZ7?=
 =?us-ascii?Q?fh0ZngLxApyl3N2Ex7UgOgCMZJKhpx/AHpgtTpUIn/+o4Q4wBB3vU9cDJoYR?=
 =?us-ascii?Q?moAUrqZfUiaFCLh/Mvs8bj7xjgdv+JMrQARn4sUKIgAhBVJebumOKDlK84LW?=
 =?us-ascii?Q?dETanT0qbjaYNCxN77oHZ6BTjvcB946tRwvikDW3BoKRWwBY9esFsIUhBx97?=
 =?us-ascii?Q?+M6Ksco9Fulp5D7AOu6ZFN4eum84fIUZ5+3vnXEFYc50dRMWk5tkprtNKa/a?=
 =?us-ascii?Q?CPLI9SOxFdmJcADNLpv1WYV9k7DYYtGce7eT16ZBNVFSuN4H+amtyWSMnSik?=
 =?us-ascii?Q?u1gSPkvqDSq/g2+csmoaJoteAvKgIerJfXNnU9UbORjghq/1k0K8DykPzRva?=
 =?us-ascii?Q?r2zt0tTHhQfx82miHlL2h0llmVLEBaRiXyeZ60bCMT1ieBz1L96YyarI97h+?=
 =?us-ascii?Q?QIrjvvq94vUX7lzcfVVCcrpF+eS4sl2udGVl+tOkjBhCEUaOwfs6z+9UUu1d?=
 =?us-ascii?Q?XLPE4SNyMVcaBS0rATwviKyev35A4U43Xe4zfUWNYSbXv+A48RRYVwNaoirj?=
 =?us-ascii?Q?/scZEzh+nqo3Fn+GsVmD54NHTNuW7WehPxu/FDlOS3O9LOaLbio+Mvg/c/0l?=
 =?us-ascii?Q?l2bUtxKMcd0WIqMUK+8+efp7PJwW4oi6AC0/MDYcHQvH0VvqbUr5Ptycqkvr?=
 =?us-ascii?Q?f//Uk7iNNlwQcNZ05NY5uyi2j0vDr2BQ6RJRGxEytfCvfiGVzlP+fcLX/3fS?=
 =?us-ascii?Q?CXv9Lz9qnf8uGq67bNkXDi4/nspT1dbxK95/d/yeVUor+U7/lnHLhOK63MXx?=
 =?us-ascii?Q?tSuT3UfZKYCr4YUeA+8ocwyNoIXp7/ybUo83BqhqV+tV87lQ8Z08GDjdGfcU?=
 =?us-ascii?Q?yUIxwqSRZ9uwbOhgI0oeTaukbyKxrIIJ8s5Q4V2cCk62/D73g+Vq97+75jk3?=
 =?us-ascii?Q?JAFLcq0bUjCz5xUdUpdScH+3D4AhhUeq050ewi/1VtswWwLBZnC3AWI6dXv4?=
 =?us-ascii?Q?CHDfuAEKIT5bvbgXI/NQG+BEcZwQG64snrtgobiv81TG661Y4P8fvabpyxXj?=
 =?us-ascii?Q?MWfv7FJvZ8ep3LvvgT9moNPvgSptgARp1y2G1cTWNPokaUsyKHrnzs4OclB3?=
 =?us-ascii?Q?hddsh2MY5dMdipqV84E1UwD7vyJ87H5+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U3E6aHlWWyCw97P3OUw5EyoUyZUQwaO0LmkOPwDgacmO8nWgfnrHam1fk3PZ?=
 =?us-ascii?Q?dFjYvrRT2X6IHEfrrbNS5yl8T+H/UROtb0iJwF1o0UGKUWohA6tg2+qYBuSp?=
 =?us-ascii?Q?oxJiRP8NcuNk6ZqwrttUZKx4BmGxSt17HS8AVtAvy/Kz953S/Gck1CwdexaW?=
 =?us-ascii?Q?remGA3vfXpyq0IYVeMQrNZtwtv1A2ERxaTvx9dEeYIiJ5PWjAt6iH0ZYh+wm?=
 =?us-ascii?Q?MlzehUvkV5+A+3KOq215AMTkzesefmJDiat07ox2G/zrioPSxAQe4la6jS5b?=
 =?us-ascii?Q?yZx076DskxfzDEUajKjy19eGA2ga+Somx4R59JwLNpJGo2kLjiXwpEMOT05p?=
 =?us-ascii?Q?6/sNSjYxn/+QiQcwSAAcGNjrZKS3JkbAoXpmeGp+/sL1xEyHdtAkNnTa5LJ/?=
 =?us-ascii?Q?Uw5k/n3w5pS+R5MSwWoefNxlLvR+L1vKHBEPWyadwyVfTXI9J8xM4TdzHsAV?=
 =?us-ascii?Q?oaoZ8KYBhqFjHJT7u9Oq3WKhRWbf1dNTK5AgPF0+X1czCqHP7goiAVoYt1kG?=
 =?us-ascii?Q?aT4R2GfQcOB7RE9POdAsOcOMlmJ+j/NzPuuYhwAzRu3ia5yPj9bhU9PoIGDw?=
 =?us-ascii?Q?B0jVBPd8Mta7nblPafk6g9sNeyQkljcEzQMtbWzIhO+nvujfCogxiWCJM50j?=
 =?us-ascii?Q?YOyItxKXYPL44f/moCvxIwvr63RE+9tGmHHnzdi867T8l8Z5BdKzuPNjvlE9?=
 =?us-ascii?Q?87HdkFgYK4GrGO3Aoo7F0pj8WgJmoq4rq7W0szw8zGxjZJ8vpV5Qs8z6H7tx?=
 =?us-ascii?Q?+3n6UnBI/aDWLMC5qAUMq97BJSs9q+LwU9q8xEv3q+0w/qegPOVTwPfomjnc?=
 =?us-ascii?Q?5Qx68wDvwoXkBPL934Y3QrW2+FW7QOrZPrpNS1vVQIveelSZ/oA8v6gfV4BM?=
 =?us-ascii?Q?gwtGgSa+xPpPdvE1tMy9MYrjvgopkFAI3sVaUo1afqzo5DFVv2CDKQdpc68o?=
 =?us-ascii?Q?77wacpwRwesszj7+ZhdzdZGlaPr+85NlCSzkL7QtLrkiw2I6PDKx7fuDWHwk?=
 =?us-ascii?Q?mGbnignYqAwbcAvK2NOFCg3qcbd/0fHhlNhjIascF5A/ckWWlXNMd6pmEjPp?=
 =?us-ascii?Q?dPw6v9/o4JHa4Aj4YsytFEBQZpOFSv/vAeuYg5wb/a1php4c/k965dsvzpA4?=
 =?us-ascii?Q?qls4EGZC/3giKcnfjak6zbDmPvx7SsyI8B//qhLYkIuwyix8Yk5l0ZtK/V3g?=
 =?us-ascii?Q?tNewNqCVc7c5Rf2dNEIZbc6GecSJyxNAvoTAM1OkPThS8mkE3hqIXP+J3+VD?=
 =?us-ascii?Q?lHf7BJFJELMMh3UZCK1JnmoEDHvJTGJLY9k/sJB3RHYLA4hPUaLpEXvKmU4+?=
 =?us-ascii?Q?J4XGVE4bDAHX0XjPDtFYYi7OBSve7Scpk7UUj1FT/Jvsv4mEcIg0daG4FtTs?=
 =?us-ascii?Q?31Pduvcsz8NZ9tbXO/AormslGAQCN7ErdfMka8fb3XQPB9JTCdYRT+AVWXmn?=
 =?us-ascii?Q?PPoIxqQ2X1Z1W7JrtzDhcpAfVqcbjyZNqtY2B4dHQe1HMOVC9J4xsA+abvTe?=
 =?us-ascii?Q?zL5anC90c8awuHoKGsP4/i0tdhHQVkvVscn1InLXgWctfTC9+iO3iWTUkid8?=
 =?us-ascii?Q?qFgcUNQA4PKdNw4G7wxPUtlKAg6zp/z2UZtBOcIfDdxGkUBKXn0lq+N8yClw?=
 =?us-ascii?Q?8lVUBWqDlabvamz+7NqLtc0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f7e9d4-d3c6-4809-e06d-08dd66cb3a2e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:39.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5EOGkW816DfQsMfifh0lZ3jcHUldwfYDe0F4E1/fBLu2qv+c+KG8GvhItCShe6trtYR1Q3hCYFdBuD25jYopBUPNNBi1SIObIyNBygMB7itLEB88feO9BIxGUQyJ0AF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:48:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18251

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


