Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B088FCF6AAC
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3046.1767864688051845858
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sZfGhdVZ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7CbnfTalNnZ1E/mPmOfRYDdwwqxu+7mdHj3TjoMNq6tDEcHWfgg0KmKPEZT4mjhC6PQQIod7mEAcoxY7706akWSJQJ6YPgwOHCGr7IBx6Iux1z6P/myyBaVImiKudbqvRiBHkMwQBq4X71pi9uxDNN9bFLORxTkWr0AgbEfKxY6RwRsnEUyUO0HYfzmzjN+c/U/0UT5S4W73JwBduwEUZ05Z/s6E6d2Gr6kNSBsptBtaZH/ZbS01sUI1IeJ3YlJGawFZDg6aUYDBmBNVlp+fndaUix5+tDRJQ3vyoiffgSPKjfV4N80xqud1g/U+BjziuVvClDx2qMVrBMOvHaZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5yiaX5ff9rsAGMryHUJylU0ppOHpfY8VMpOURhUtEk=;
 b=xbb47C3KWKKXrblwrPwraAkbkYUzhaxGkqVbXDLM4BGblZbepDgwk0aQvE6q1ERcRrDrTWSnGpukFVwUE+US+2EqG+a3JlXRQygH/djkbhCUKFZGan4U/Q2+3IdTxYdv3E/FORep5OOInikrjyZ4RRdo80cyT5Z218mkL2bsTcKznt78/c3xYdBxw/zSNGTHgiv4d8v4tqXTsASZGS6r+cjNxZfPakKP1yurCwkTWervOR6LVcuAxpLr0ZdC1DDlCCpr9mVlkBrUQM08f6ZzUJ6gWdnETf5Vf93AVFIEOVYTR/ch9HS/ih0R50b0HMMs8onGG+dyGRSmOlHXqL54eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5yiaX5ff9rsAGMryHUJylU0ppOHpfY8VMpOURhUtEk=;
 b=sZfGhdVZoy6fzy3IkW2Izkke/V01fNDdx6n2AeK1PBarxwCrOry/5JEkE8+6qFhKJRrcIXaSgETQmBDX8B1+ltio23hJpeYNMSb2DViuYa8Iqh/Pa3XPhw0FdD/RB8nIr4FEW157xabRrtnodAKhEJeFp/dG6ngtApdgWL+GRo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:25 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 14/19] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
Date: Thu,  8 Jan 2026 10:30:18 +0100
Message-ID: <20260108093023.489513-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 725e40fa-69f9-4b6b-4ab0-08de4e98b179
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uO6x9vAdasveYgOhlBwK/9k3q0Aa9nSksgjV6KbuHCQyfBzRugRECnTdVgif?=
 =?us-ascii?Q?RBHnN1wcp1/zahVdk+gW5nyfC8c99O/ig2TDAPEKZYG5WBrRhDuJhwDg5IbA?=
 =?us-ascii?Q?h2WxjP+0f/zw7cLqT5u5/z7wUAI0ujMOiCwjia+fmAdbcI5QZ2vvkN0UMWEW?=
 =?us-ascii?Q?thRAy2Sv48zC07CnX+8/IMu6gSdhubk7DwRaLhusmj75kpuoOD4leGSSjgez?=
 =?us-ascii?Q?ZLWsIA4XLKinV/V6+NDhgDfczsfdKsV5SARhsBdy2miOakLB8HtUDx5H41bY?=
 =?us-ascii?Q?4aWqrovttxitXoAAwCT+TFD2pmc/uP6Nw2m4AtVxUoSeVPpTFdPMksuwgrss?=
 =?us-ascii?Q?cxzvlYWigDUh4Km6SVJYl8udbAIimfiJOBhvdjEYxMI+rsxAZHBe+cxhDNaN?=
 =?us-ascii?Q?h7sckzsCtwKGMZ2UBrz25R/d47E62TM3IdKIeFdigTIp+/6QgWi9iH8+QZHp?=
 =?us-ascii?Q?ZTP9WmQljeHqPnvhjqoHBjkigFqQ91M3FgvrDMScOrIaheIWnfVn153ja3BF?=
 =?us-ascii?Q?mAEzZK/2FqRegXpXb0FzAp3reQEo5bRANBNt0h+paioRgblr+7ON7IZ9pxKS?=
 =?us-ascii?Q?pfSi/SzGEmgF0/W03vx1KiQZmi1b3hwB4h7Yp2+rU7cB5Q7y02Ag+iPs2UmG?=
 =?us-ascii?Q?/ypax+jeYOAmCrFDQ0F0cB07YoGsyi0ChcJlkRWkwzoAYImKCKdGXuPe4wqa?=
 =?us-ascii?Q?M7p1QVFXxnb0dNt35N4OpWj4lk92ILllQU5Ud2UqLuomdW/A7rV2pmLQyKXy?=
 =?us-ascii?Q?m0t9NFJjPKNhhW3yu90du/RSKOYI6ZSib1SkvO0p7c2DURSb0Cl/PvL3EfbE?=
 =?us-ascii?Q?7WNzloYbLBOAJawY4Eum/ztZIF7pzeSAU+2eXPHjSpS/S3N8g1WLhLBnb1uu?=
 =?us-ascii?Q?3gmXk54xV6YGUYHneDZstYKCGIPxNb5rkdJ1+KoffAbNDyPQMg/Qucdk/4r7?=
 =?us-ascii?Q?/GGn9wPWtrxGNbjq8jVhWnVFK19x5G8ley/SjTBPcEictTqVZFyC6b7KoI6a?=
 =?us-ascii?Q?N1JjBtxuP3EOucNNiljFEl6EuQdhzVMNGampfVx5c33gYkVINENH2qXkQm0f?=
 =?us-ascii?Q?UN1s0oGC7j0UY7VFqsa4FM9CDxAVWdHaP/8OkM3YgoCkESGqPZYcqD4s8Gza?=
 =?us-ascii?Q?eFnYqyAhJ0GMRjkYiTKiTCF6whKkWF9laFWm6SlHAP5k8WgFdFP3k1w36C7t?=
 =?us-ascii?Q?cs/ghma8S2cp7K2GA5vXDHGjbz8VPBLTUfG52QQvEMlUaxM+j7YLiObezxTl?=
 =?us-ascii?Q?F59UeQFDcz8FQtdddsYN+vY9Q1SsCYH7+xWppXsXarU+Rp57cUCigdBotJi+?=
 =?us-ascii?Q?dkD3pzOWHEE+Ni8uYFki8rw2mzUmU0Ht/XCYPj6QMR7nCwdwFiiMbtaCARSk?=
 =?us-ascii?Q?4devBdYnyTSXYTtN40bHyFs8ziy+3Z63uli1jwUhB1QkXXqniOlESLB4PTDP?=
 =?us-ascii?Q?wKZ+CWBjBhb955OSO9Q4nAjeRCMEKs2xJaU7Zov9O8/SP3yal1/6/A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mvdV2lkk2wWhbuE4cxMgwXoLwubAOOjv6avRxzXeBrCcWqAFgcvlN1NB5yFQ?=
 =?us-ascii?Q?NjJTRSmIkS8sw6lRRSYAGhhZxMfeAQDu2DVEMGCrMIN2IsxE6rsyh45jqdDm?=
 =?us-ascii?Q?f3BWa96eTVEG0aN8p8zquve29sdz0uXNYD4n2y/EQvvgByb/aGJntOEFNrOO?=
 =?us-ascii?Q?bQXeSTdm5b2Xxu1VLcg7NlW5qsGGsyIf6OyExyF0rcNE9LR885KDh4lXCLHm?=
 =?us-ascii?Q?jeTV4PvSIma+aaVdGdx/7TrF3Yn0aovh1xHiteY+nEIryPkFNV4XSjTZtVlE?=
 =?us-ascii?Q?id1VIrunx2u384YemkWl2wyCvouYP2rGLxqfK9iz5qeu/rbq7xy6QNBLV9bE?=
 =?us-ascii?Q?qq6kKw1+pHRkQVBR8VO/xMLv9pv0ez7FIBPSLQc+asWmjBxjkO3m+Zu2k1x7?=
 =?us-ascii?Q?hboNAI6PpqXgo3zUH9DUF2xV1ybkIz+FEZBTkf5iuHOQLz/p8f81J+BIABp6?=
 =?us-ascii?Q?EZj4aIQk8SPkIVAJrDhRldaeHwzZQO2u2dblIL0ZYXwg+/+o8KHWgclCaPVo?=
 =?us-ascii?Q?0jIFh4bm0KLWtjivi2AiZU8oN0xHe4F7ujo5XOUeeaFPopouXa8rswM+1ROM?=
 =?us-ascii?Q?eDhcPiUm/CfC/8v+n+h85JPdGWmGWcCRQ1hkLkUS69I3dftOx25Ng6jvaCZI?=
 =?us-ascii?Q?EHt2DLfx11ncB4/cimdYmeaQWxv5RAjf7vmBKCb7orkLadnJnhIklQDXeYZI?=
 =?us-ascii?Q?rsUWYBlXPf8fxLNjL3AYaUYj4Z5FMDLI2s7Qe0HSY6kT577ZUsKNfpSYnKBT?=
 =?us-ascii?Q?foSMyI8/b3v9/ElgC/ozH+3SaMFoIMUD5NaBiRIug2+oMHcvAtCZzkI6kCVE?=
 =?us-ascii?Q?n+dwBzGgBN8/sLntuM0fQ2IoIPs2vNBUAeAl8kKn9Z4/WzlujvGr5qLXnrEm?=
 =?us-ascii?Q?8KbHAWybWsAGTa+NNLpaVVrXKjI0ApM/OM7snSEKGJdZKtntudgzd9DiZqs0?=
 =?us-ascii?Q?WSrIOmrp35u/uLc2vwHrmvxVRTdjuhnrlFgiU0vpHCggOREFTnRAssrVgsrr?=
 =?us-ascii?Q?6X7gA021vQqTrrnmJ5K4MgS/i3yimAnpoWn2fMtU6OsB1IOHqvEkkQF+jKG5?=
 =?us-ascii?Q?fCNX8jLvEAalmkQufW0JphdulmrCzR1NgUpFGmzJUJQDsXCcCG7NmK8gZ2sz?=
 =?us-ascii?Q?Iid8W+b6VXwvFj/dv1yE682X7F/LBpZQZXAiHAy01yiTIHBYQ7v5/qMdgL/X?=
 =?us-ascii?Q?Y+ZQ1nwe3MnuGCdecdb1LewdA/edAp17h7OC7cEg+td37gxQnxwwn3U4GsC7?=
 =?us-ascii?Q?mLuRl6usSVl5WOwM/7qwjudroHSUu3y+brmXzHI84ziwbQd1/JxFI1NqzKlq?=
 =?us-ascii?Q?J2hWwOfNuRKVY1y1xwI5QcrmE3XybKZ1HwFLGDujKloZGsjwH4oVGoBNenDF?=
 =?us-ascii?Q?G4+zxf7CbRNFVSjTGFcSjRKH+yCSbNG8HnnuSzNvmWKEbL0eG9JHCfOUmmgK?=
 =?us-ascii?Q?ZVlS/zXVvemk+qyBAHAUCrbXhu7JnXau1dugV1lO0i776i1s2EH5HTlfurRu?=
 =?us-ascii?Q?AK4S4GjKkL9gUczJpV+/o6pXejhuw90ZDVSALo8m545fGmyGGP3WesfbDVWh?=
 =?us-ascii?Q?A2UNV5UW2CAU5GI5hGI+16JrDIcmxbKQTOEexvIm8UtI/Cewu/4dIzaWaQKG?=
 =?us-ascii?Q?udGPEDwq7w+GfdXpuCNhNKAyXn+B8tiHnHx51SufjMB1BX5JTvSOmMMY2hiX?=
 =?us-ascii?Q?X6Ph1KacIsvVsQ5P8mGntKZ9YtDb7PwJIDccFaZSRQpgPg2wz/rD43bY8MYD?=
 =?us-ascii?Q?p3g2nKd0wWXf4UOAXaMZeIcf5J30mlD5/ZkrVXqgOgy/8PbWbcAd?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725e40fa-69f9-4b6b-4ab0-08de4e98b179
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:25.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HOPIbUxpUkk1sfiw1x8z0Wmawh1mlpl2FCmaEwj8eAaezzk9yC4fE3alviH/cSRJMeOaUzht1Y5BPbP1FCLbogU6uO5bYMDRmBMXPcWWdmOdeDO6KdRflSnY1LYL1Wy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21473

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
index 0ad10d43fac0..a6f9319e068d 100644
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
2.43.0


