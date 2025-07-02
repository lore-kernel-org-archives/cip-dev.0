Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D2C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.16])
 by mx.groups.io with SMTP id smtpd.web10.20510.1751452574691991287
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Hbd9hNUr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rq3HSkz9HSksBlByFFHBCm7mGXX/w7qra6TSqVDBjT1Lqpsdz3YeXy3fWN23aGCD9iR6OOuWKPqNeHfByXPE/pYPIgQwpP6AFvsFZFrDbVqSATkkiboJ4kmi2UD0Un9URGWUaCDQg20mkrUmtJxyIuzo15/kE6iFv25FKZrlFq5jbODGXkHsTucuSxswsOI0hwz+rklY44zhvKH1b6eROEJ8RRY0cQMiKGAksF+o7agbBFZHa9X9LGw5tkrJ9IbgBd4HbxCkphplkrsIYA6tXEwe9lj8MRGhzXjJEPsxldU00lyaNOk9zzo3gOc4QC63seGr9jSxDHmi/0Nc90A9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXIvo2+7lEuAlvqARhzPDOTBo5UBIqxzX48MQ0BvsP4=;
 b=hXhsVRUjeODBMju/uvMByRbc8jD04Dkq51s66XOlT6N+MIBPWSlvfmhqTaWpfgusXnyX8Sm8TV70U2NKylYIjMAgq/yJMOler/o9BPvVw4BBEz+RAFza/bFLV6AlfZqJnI8lMT1wLKnh1DW1+6i0ppmNaVNA6vZNMgeOC1IoFFSf/iztpC/1kXqwvDxnQ5X6S1WFAoKKr7xvPEybSHO8D311+aEuJFdJqKzWQQsGse9xvZI01vtxSt0CGU0T0WudDc+hFRWRIWH9bUZvHa6dOAOpE1K3kk22ySj/xdB1leuqhh1mFgjvQSFKQ399FBBz/uxpQyspzdPZW5Ho2HNAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXIvo2+7lEuAlvqARhzPDOTBo5UBIqxzX48MQ0BvsP4=;
 b=Hbd9hNUrB6BMz/eoPWNDpACDXatX7Q1+OV3ihw0j3UCP40ua9iWEe4YuxouvSXcPsHl+VWCABXC9Mfc8Jwsv4MD6q5x9OK4/Jvx/r8piRkDZ+bSVVbrU6vktjARSUQMiclLNj6RYkBO69RVF/eT29sCPZTQ3XJhiyaKBAGvene8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/12] dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC
Date: Wed,  2 Jul 2025 12:35:22 +0200
Message-ID: <20250702103525.117166-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5f45a4-1e09-4ec1-e849-08ddb95444a5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0R+sWcSmI9jEWNzIlNV7kx4FWgWruoNDvzkDCn+ZiePEKKfbPzrp2odBYMDF?=
 =?us-ascii?Q?/eg4JsSAMQBpALKLHKs/8WPDPTxVHrkIE986C7orDeGofEUdnGb/D6N6ISRU?=
 =?us-ascii?Q?9ZJt4VNss/Hqv3yH+GXQ0b0NiFUKz0KRpPLsXpHAY0/dnS9NJtdJ33wl1/Gs?=
 =?us-ascii?Q?iNg79tIb+ZH2SVqpR+rwfOj020TeA1F5qzTkfPefJ1ktzCEvgx2EM4n5LlEY?=
 =?us-ascii?Q?lCGPojEOp/ha+Gs1mxumkEk1I5WshscyeffqTHa67dO+CdLb7178y6N0QyxG?=
 =?us-ascii?Q?cc1SokwZaIyjOki/pl4mcF73Hk6yloRX/Vf2DWXiPLw/To/GJG6eJR/VIFYJ?=
 =?us-ascii?Q?dDrHnQunClm3nqyXh4YHW9FDn/XTm5zhewDnCpIXRIFNgtgi7wB2DPK+kf29?=
 =?us-ascii?Q?PWB+VLhHJeCC+1YcXalNnEDoR4aq3apIKIXy4C3biypARmA5tO0XP8EbxKic?=
 =?us-ascii?Q?nx1/n742u+Pfv/x/tC3wEI31i1Mk09OJLc0468PRJhRNxJutECBf2dsoBgxf?=
 =?us-ascii?Q?/neC/y7Gvv3wymkI9DEUqZ7NS45LepJPMqqEQbZoiCSTSc5KZD0pmwZLRb1W?=
 =?us-ascii?Q?IpPrbs6Grehi1pzpNZA+Fjx2WNmEgsKNBP2Swifi6pmFdfBAoL7HqVPaukqH?=
 =?us-ascii?Q?Nu7TN+4GNY1qk2EghmPlZDqtdxCh9KgeHAmZEywsFpx47L0uuqRemTo8C3CV?=
 =?us-ascii?Q?hzAmZif0eb0D8EIT+6rIaHFwksb/T+W9oo0lllNqkmMH0l+o6p3KWaHjviet?=
 =?us-ascii?Q?/eqcHLw8wUZH+xdOfX+r5NBCPAzeCoSQ6pNNwoLynFKu+n2T2x+vK6j3bn7n?=
 =?us-ascii?Q?HxzSS8+nITba8asdMC/GMsqciEH0W1pZ3F1Jsyzam/nbUPUasBJE5isNozLm?=
 =?us-ascii?Q?6PikKLUvBEK72pfk/jfq9kDcU8hfMlTS8c1rXoLtZZyOhiM7DhD4JdkqQ6lR?=
 =?us-ascii?Q?N6/gBWZ/gF+GiEmJ7dUAyKV6ewQUNqOjnoMRd05Nfew7SK1jVCw+Z8gQlo5i?=
 =?us-ascii?Q?A+Fqu0K+XFTPcJH1XncrYlo/tmd8GOd8m/0dLsk2IqoN+6liYl1+VzoOzsh8?=
 =?us-ascii?Q?ixb7+/wRzEyptoiGUOEYrLRvLHmT4AoVm7BkGWUoDMRNciVXbWwf098Ef/q3?=
 =?us-ascii?Q?1iy5btrdRI+VVbvLvy19RnWC+5yEWi26TVJFAQv8+hYZMY/GkpLkK6ogkK1z?=
 =?us-ascii?Q?u1UNOyM1IG1NgvzebkgGAurLXoZlrXV5scMGiBT10xCgPoFsTLnkA6gEw6QH?=
 =?us-ascii?Q?qPvG70XdmmV0ep4rSvSjD88/n3GZUYPt7Rpg4H/DaIG9S/UFXChcjmXvjVB6?=
 =?us-ascii?Q?cBFagiHeef6+fm02UjS2X2/r1ngI6+S6uWgsd+f7VmN9LyLBkeLKmyzh7PFk?=
 =?us-ascii?Q?jhtkPpOw08j9iBa37PSZWzcNHLsSR0z8Y1ZKDvrRnG1fRUsKhSsxyvhTBRrP?=
 =?us-ascii?Q?fOZR5rP9rtAbscSq1KHeTxNZ7CrmqeEsTUmxXYgjnCrV67ZzGl3bRMuoGjsS?=
 =?us-ascii?Q?XqlmYfmALJK6mqM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DDIpxa9rR4VIqjwj34DHoPLMNeA1Qv6t/B15fbWoPRoE3Y+xR6V7/grCu2IY?=
 =?us-ascii?Q?Pee7Wek/KiqLnafz6WYWnLPJ8RcNP2G4UJa3vNS6QIH1JJrY8+Uun3scOLvf?=
 =?us-ascii?Q?l579n9cU9vaAUFaDFFZ3pMl3pj08kQx+x/mbBGVH/U/HOZWNBNAMLB09/Fzm?=
 =?us-ascii?Q?MSHyyqOe1jJylS1cG2VNr3vX1VMtsF1Mlxxo5W3joLg5GyUGh6g0oGEfgHHI?=
 =?us-ascii?Q?J9mVP0SyuEUgn3DtYwJ3iFnPtImFB2MnxdSHaGVHsl3SZPz89DU6/7sFQLLQ?=
 =?us-ascii?Q?plQO+VJ9kGUEeYOkHi0F4fYoub7HZ5nlxoxk6PPKadQHb7Sql5ygppdd7uSZ?=
 =?us-ascii?Q?yzR1w7RXvJn9PCBIlf+3YN51qFMUgi+fEon6EpONv9tvDrZ2ltrs7jDztatq?=
 =?us-ascii?Q?oLodne+QZi8KEnBUxa2krebZZ/QDxwnLMlCUleBiIkamrKfa/2N09rxUAgiL?=
 =?us-ascii?Q?nxeZrGD2usmdlkoRHokiWgiKV8/++pOz5HzmIZgo9BVvWVh7J4qBXTvlkzVg?=
 =?us-ascii?Q?gkef9g5lTQszbHSItuoRro783xFLQDfc3TIocEqHA08a/+v4CvrFrUIE3BgR?=
 =?us-ascii?Q?Eoa8FTBHDyQy4z5UqFa/lkyiQFNd+UU7tYI3Lv1XWaxU9PaH4g0GduN68EDN?=
 =?us-ascii?Q?UcSOSMqNfomdA+sOGAmo/ibtX2wveVUTS2mc81vAatVaeo4FKl9Dk+TnU4tw?=
 =?us-ascii?Q?axYIShl5udbUSRIR3QQXgeECAYA9pciaTSJaW0FJuskLmQeevcVNfM3Jz3Lc?=
 =?us-ascii?Q?53j6+HFQH8jhJgnoqsQttXg1GbgGXAJoYL8t83u4bA5cBuxTdfdVL5r6QogG?=
 =?us-ascii?Q?RWEQ44hT6kOzt3AFuMOd9dxs+ewpq/RJABawFON+xXXCqqVjd5RUxf+KDxSz?=
 =?us-ascii?Q?oxWrcKI1cVrObqdRJUIoWjAlvMpf5IIXoLkGw5kLD5AKvGR+ZLy8B7ArKkk4?=
 =?us-ascii?Q?mqGtyh0hXIIPTCkzzmA+xq6reSo+rQUYT6n66e8VMhXU1GknlN9boX8utykk?=
 =?us-ascii?Q?4CuQxxJQjzXC8nln4egscyKn/SKTs638IRlWAf76ho8mQtQw59Mc4dceb9Ou?=
 =?us-ascii?Q?jEiNnSlfjAGE3rFTe2dB/QbM/WKnG4b9OeHRJI1LJmQZA65RK9YA1+5vIoUz?=
 =?us-ascii?Q?degTo2VYZM14amGghyE0HhsGIBbpIP+SDGT7Va7OoszrYIOX5pOHoirxZLtz?=
 =?us-ascii?Q?C0KQ1NAoC4hIFAG6hnDoDyIfAU3vPuw0sO+1JFBSBukMmkONmkVlYQQTEeqK?=
 =?us-ascii?Q?lxh34o7pSdf8+7RRMomLybbt6ySwVzLTHzoUgjlG9ToT9lY+CTOYEnSU5CE1?=
 =?us-ascii?Q?KnQhSqG2pbfUhSAoVsuOCDcLG4yf0GLPGFRNyOGPzMpYNyqyjAdNjTMWpLmh?=
 =?us-ascii?Q?VMaJWoqca9eQSTOUKGDBT7EHx54vsgoieSijfPswRQ3T1JiTGlOfEq6WWoXB?=
 =?us-ascii?Q?BQ2Ge/MfIDkbd4NgKtJeLM5RsswZRUdd9iO0nqBLdxWflb64swzByuEoC9Ij?=
 =?us-ascii?Q?BvP/Osrqn5QbzFkAApbne1K83XBy5N7zZ3jiJQh+f4TQGRsBimBK3YHeqzII?=
 =?us-ascii?Q?I8cc9UiTZoje9KbM3bjaspC5t8ENE3cMLnXf75gS7Xpa8UiyZIfdzzPxTrla?=
 =?us-ascii?Q?VBsKN3HT6dPkpIJFWh56dPQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5f45a4-1e09-4ec1-e849-08ddb95444a5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:13.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adX0YGlg6TVNqy7AeijMPWYog3NwPjTDIqaVy8beeURWdnXrewFJRsvIq+BgEiHavl5jpuB9Hznngfgepa/r5tXODrHT1fuKFXi0KDHf8YsVis5tDrNcn6fsS6kLFC4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19294

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c29ebef507a62b7a01fb61b7117065022552946f upstream.

Add a compatible string for the Renesas RZ/V2H(P) SoC variants that
include a Mali-G31 GPU. These variants share the same restrictions on
interrupts, clocks, and power domains as the RZ/G2L SoC, so extend
the existing schema validation accordingly.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250218115922.407816-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/=
Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 78964c140b46..2198f97da516 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -22,6 +22,7 @@ properties:
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g057-mali
               - rockchip,px30-mali
               - rockchip,rk3568-mali
           - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is f=
ully discoverable
@@ -118,6 +119,7 @@ allOf:
             enum:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g057-mali
     then:
       properties:
         interrupts:
--=20
2.43.0


