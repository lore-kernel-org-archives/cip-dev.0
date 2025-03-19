Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3379CC35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:48:50 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.39])
 by mx.groups.io with SMTP id smtpd.web10.4024.1742377721047115786
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=CD2BYfNV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZpUWMWPSnPn2PRU1staVnkNW/mcoj3RH8SuFpXfuBwNGVnEkDV5j3mUXEkrbNy6GQWwRw2EZGnSo3Jd6CoH46VriYZ+NKm6rSpTwwG5UJeVCNvv3BP9uPNl+F+VQdMOq9vfnr0+gcHamVbWyRFnkqYBbLALTgfBsugLzzf7dh5FxgXxML8p7qZ1edmDDhm/9uzmmujAjKNQekaezUwGheC9iaXWmGFUdGez8fO59otIbFXsW3LxICbAvLlIctajQcJu9p3DrAFVL9MrIuYaGtuU0q93w+CAAC2gLXLGTX4GNeqgx7dvml1yADoeLCjQvac0QWNR0+XJtowiQJDXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhWE05paqSoroCW7spMzwjkXeqVfsCKGcmLbOdJyQQI=;
 b=u6hi+RvdyXrl2Y9Gv4nKISVaNvLlF9WDmCxGfNzD027WUrrvCbv3WhX/wdB1ATIkwvPE4OdogNJlmJI9HdlJio3Rjx8+mkXlsqgmg2zrAIrBeanVMrPVk4Vk2Nb9IUM6RyJUA+XnxXkKGCAXFXAlT01aJLjNcRrgCqPvCB/30kJuZve+sNoP3j7Lb0Vz2jJX5NSVjf0SsbURIzWv1D3GDfkhpGVTDeuNRgm325muOr41PKU2b4vNfndqdS3pLcE+WhZ+OIGsBeu4siy+nzlgjNVrpAPPN3kRFc1KtjeRbhK6nnMULDLXkNWbMCnB/pw+cPj6gmol+qNz7kk4XMIwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhWE05paqSoroCW7spMzwjkXeqVfsCKGcmLbOdJyQQI=;
 b=CD2BYfNVmaH/yFXF5FR3T6S4sHi4T4xSv+fqzWTi1FuUApa+me8El2J9af7RzRSRkuw0+zUVvkjT67QaUgb/3RabuxOcmR3Wyu+XSLISh1NXD4ZJzC+WysuT8CX2nONWVqHBcgRfbrbs4KkpHkltKIdCE7K91FaSZMadrm5bNTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:37 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/12] dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as required
Date: Wed, 19 Mar 2025 10:47:45 +0100
Message-ID: <20250319094754.2404386-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7d5473a-4e22-433d-604f-08dd66cb385f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6+9OF0IWhb9wD/ZQpomFc1g8X98GVhjFda+khFYVZ4w1KcDNAyc9Zr4mBw/l?=
 =?us-ascii?Q?6eqoh2Y8zNc5G2AAEJM7wThjg4BZAcpV81zFUo1NZnGM/Suojaw+w5LdhzL8?=
 =?us-ascii?Q?iFMdQ3s2t6B2bofGpOwgKIUaAmfFRH5oFMSGnEi80uHO0ca8Vq3qhIk9f5xY?=
 =?us-ascii?Q?IQJTAqDgtn94smswmvKhbrJW/iN2BQOBIRv+vLHBX1G6NZXZLfVC244DTjj+?=
 =?us-ascii?Q?VIt+61T+z7Ualel9J2w/MyNqyRrsDpjtLuLRikcOqQeiJD/nAFTVChcY6wJm?=
 =?us-ascii?Q?qDoxrRp+8sL0klg9jrEH7YTZ/4MX3yldfjQxicdnk4DZGrg11FY/IMLqOKhC?=
 =?us-ascii?Q?+8ygksC0Qt13AL/2qUvf5cODP5Y9p8KLWF+1jd8R5MWPGPTmqv2YLDj6Zt84?=
 =?us-ascii?Q?wNb4dYKDgsaML34SF5mS643JoGBUm5C6IpcOH4x3A02KsmjLMrBgXKCMMH1b?=
 =?us-ascii?Q?ofxfEAjrBhdpf5gFQl0FUdgNynIkjpR1YDEMiJ5lqsz/ny6WGLnoBoOCb9YX?=
 =?us-ascii?Q?iMFNaIzqMEbYQ5F47zCUopM6mJxoZCrzeqq43lUMTbidG3K0vX+jUmo2Tzht?=
 =?us-ascii?Q?qawOBVj7ZGZJepj92tLyryGgCCQrrVi/SUtsH8jw/vk8keZazMqUSA6/OUTL?=
 =?us-ascii?Q?P7YPzPBV8ct9RAVXkENlBu7d60hevwII/2CSJTztrCq5IsJZMDPtPaCATgiC?=
 =?us-ascii?Q?QE0nN8hoPnOQUHW0PUi2f4lLGRKfZFnmYgkcQ1ihMH6fjGTZq41IKSNzWgM4?=
 =?us-ascii?Q?gp9G20RGVCFm0Da9kKWXzArbsEdZrAMPrADLvkgMKhzKTewYLt8TWKEySzV4?=
 =?us-ascii?Q?aMvLUbK8G0DFxLK+NwCEvmCLr4zoegFqOdgODH7D4doXP9gpgBRjKogUv5BX?=
 =?us-ascii?Q?BsxwQbLJ8BIUQOEXATIpyfw72tCU2Zc4DmcdsOX3EU5yd3DMJjCmp/d0UCOJ?=
 =?us-ascii?Q?x+VbThok3C2yDk9C6tp69xQf0SrbRpv87jFwjrEFnBe6UdT2hrqH4SEUL3x8?=
 =?us-ascii?Q?+t2m6zQWl5qNUZ6igzc4QSjJAp4FZQnqhryoouoD7Vp0Ux3gmRnssxk7ln+j?=
 =?us-ascii?Q?vBaEBZWfM6PUtTljhfDLa4/l2Odz5PfnFMhaEuMuLy+3UI+H8Ajs7El1Yadg?=
 =?us-ascii?Q?EgSHQGyJZX7SBTRuZvlzjnfIZ6v9uAhWnPwTwL9PWY4/1AHyqL4rpNBfsfug?=
 =?us-ascii?Q?WGnbzQjSfzCsPKthkj89k0nWuVQa+kRk1HY/R67weyJ+EMSpwTsr/87xYJ5d?=
 =?us-ascii?Q?baX3jgDoEcQIAC2kRnN6249WppjQwX4+1xfV7ZaCITMJ/YJppMdPvzIfQJPm?=
 =?us-ascii?Q?FsPqyndck21rBfdWGRKt9i36wrY/qXhJDmZ7LZnzvGeekJME//iaIDuTiZNE?=
 =?us-ascii?Q?SAeciCgiXMBNwgxlFFSDuOKov7HLhSnhzXTuTXx5R0CAhVHSwN+jDllxVHeg?=
 =?us-ascii?Q?tx8hcn9+6xYGy1JQHY9U3CPK+cn2h1Ja?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NY8bnKfAJzSH7BNvZImTC6wje/gZAv8AY1J92dR9y2LpRniaPrXkkjXnr+UN?=
 =?us-ascii?Q?9iOYXCiDh/Vbjqz21Q0gePid18J7JoRpYQj2IwNOtfq+wABPmtIaxgJB9ngo?=
 =?us-ascii?Q?5L72jH+M/r4wbflI3nrJyif6TBPCe3DWxcHQZRvvbDMbFP4onxtV6v3AW/uG?=
 =?us-ascii?Q?YDFUa+mO41eow1YL25NaPiSvzeK9M8yfx8hHEScWAyg9Bl4mmhxQL2y/3p2j?=
 =?us-ascii?Q?LXtVISnJ2uBcnMG0zQmcWH+ERgEp0T5nQwOhNU9ryiubJPRMmehpRR7bpALn?=
 =?us-ascii?Q?a3fxqH0O2dNBYRMQvJbGtQofVnosy/G2PI5VqbPnpKf2sWworsXjkrVQgCQm?=
 =?us-ascii?Q?B0i7AGNW+WW1HQrMkBAtGslc1sEL/Yk154WewPXY+Rb0t9XQvcsrnGFIYeoM?=
 =?us-ascii?Q?/t2tbYmItdFj6jytuqK2gfMBVr3knkovNkbkTVpZI4F9RIpeCZ2dAeY+pKPY?=
 =?us-ascii?Q?B49y6B1Gr83osqWfOULSJr7/4aERYetF7axRFPOv1lSFWuXjGKPQp9fvNASC?=
 =?us-ascii?Q?4O/t/cyl+xEOPEOtv9oc0HCfCcM53EXMk1XrHFmGt4x+mIXmqff8UjrMol3t?=
 =?us-ascii?Q?oCND4LrVnp6OuCzHb9vybHAXl6ypzk4bqyfQVMcH6Khj/zUDNRimv0IOGgzQ?=
 =?us-ascii?Q?7m4soATs3s2TeIZFCubHd1jzOfnEad80rZTF+p6iOr+x7zpY66ednJGJNG/2?=
 =?us-ascii?Q?Jh3kggc4vuMhAz6nK9RR5ztj0qJhna9XPejdHyCk9N4OMqs5V1fRW1Y/Wb8o?=
 =?us-ascii?Q?/rkWZ2W18raWZScC/LCOJkwv8l0Pi9QqLvTTvKOVUWZyCi1GVSveNoMB39fB?=
 =?us-ascii?Q?SrAg6yj3Mx6qfXYV50idhfu+vs41JyV2WkXZoVyjGzteat39mEG2rieGziVa?=
 =?us-ascii?Q?QadAzLguiLTB31FGH8MnyQLWZRhct/1sySQURDoeF/sYVjQz+1WrQUTmZ17h?=
 =?us-ascii?Q?4P1P6lmZapzmrZXk0BQVsimUZqhExLBNvSn4nTFOFJ5sXXPad5zEnGa6iZxe?=
 =?us-ascii?Q?/dHUW9wL31PYJOijmNA92oBFbJ4maasyzfpfz8B9y+xOF4w8SeTX9Ez7kOXg?=
 =?us-ascii?Q?mciJqtVdJHAd+R1EsF9qW6easJestitCOCVFVd80+0HsT6hBXcy4fU2Yk2Gs?=
 =?us-ascii?Q?nov7wBfuutFe5OBzRVdLYg9A50NTJ3+vqB12nosNP5dcOvUVcebqdRaSNJp4?=
 =?us-ascii?Q?U7h1BpEp3PhrwYhmK5N0aM1gzOpsF0kO1kwDIWgDbCCIBS+OVhO5xcXhxwzT?=
 =?us-ascii?Q?gMWw0vkZ+tkeejLUWMjIug0PQ5VFW97C7bD7YlDuKvrXcefreXvDH6cELJbi?=
 =?us-ascii?Q?bBMwqgR6RVjnhujZMBGVk6BomQw+SQtzAuL6UArB9u4iImjTouIveG7K/BG1?=
 =?us-ascii?Q?HM3HqYHRDofJrJnwlI/DGbf1AtCBnXBYNRn7rmwPQ3k7+bdVOeV6BSuxaf+G?=
 =?us-ascii?Q?wP+3/Z+I55EJQJPgF7ZTDmVBPjsSL4tdpgLUU4PberesRV/I/AVZcDLd09sU?=
 =?us-ascii?Q?W8MewzH7MyaNMM5BMNWisD3unozWljuUuexzAxnHtFHjdwdlkvSn6FlyEUbN?=
 =?us-ascii?Q?ama+/CUwWPrnZcLEACBbIvmS578rMfPAeE4GvPrentEliF75lTebF1bRHOTl?=
 =?us-ascii?Q?c+l0hcS/LqlhnuzWctJa7+s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d5473a-4e22-433d-604f-08dd66cb385f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:37.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +voMYKI1YeO/qEBciqv1Srtli7wkCBuOYs70O/DxFBFcosHNh0QzsEngdkZfBelloX/vCtMvaTEuuZ3nzHal986o3pHC7He7uVULqeh6wELcV7tEoGV+6B8u7nwJjzMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:48:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18250

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 034e4422ddb5ec9075d550f4668be0a3e85e6a3e upstream.

As all the SoCs having multiple interrupts have 'interrupt-names' property
in their respective DTSIs, make 'interrupt-names' property as required
so that we can validate them using dtbs_check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240604170513.522631-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 20132a3202fd..252c1e6102a9 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -178,6 +178,9 @@ allOf:
           maxItems: 1
=20
         interrupt-names: false
+    else:
+      required:
+        - interrupt-names
=20
   - if:
       properties:
--=20
2.43.0


