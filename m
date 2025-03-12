Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2957FC35FF1
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.26])
 by mx.groups.io with SMTP id smtpd.web10.34509.1741778846032839331
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=jayiXOMW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzyVEb4Nedx4FI/NrEKfHI178ar4QeNlgMAE9QqcwrfG1JW/aINIw2NjcSFSdOslamEIdhsyUcYJ6YeZdURm+vIxpy6SGClrxXajZduaLK+lstUwnnjvCEOtFkkE2du6wWZTTf/M2jEUPzwDxrHEQ7fpZmKGDVYZi5el2jt1YE+TDXYjF2zMYzK0PUFFpsThJmG2i/n2wiB2W/ugxW8hv73ZP7PX9t5Wh30XE9xr+iqo9KJ1Y9HVVX0Ga2IKPB1bHiJNxXm6kpWFY1mu/D3PYzBk7pk5yrS1Eo4d55XMV+4FYU50xAIwm1eqs0C4wJBXcuGftsK8btqTTEEOniD17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tzP8kLjKes2UayjOSiibPqOQq2BymzEy6fn+U97oug=;
 b=yNcCnMTjh9mTO1pfQo3Mu3VWoWl+C2R+4HPzbORfi3iFtrqs3x0W2z2nnxRvYzSC0sVBLCxfO+QwhSotFIyjI/h4ShhjZraWoR061MeY7SD+o1jACth7OTXTkpUA7ksUqUWBItPh+kay8Hyf0xzlI+mJ8D4kYNUNmkiS+HMBC8Ra41JsLtXvLgs1abLrIu+A3Gd4c5w0No41QXiQjY5huZWaRe6W+/xBDN9kIcfZRk5vcCX6xgV7hSv8Sh7ym8hAcWwcKLKqaq5K+ULWJcJrw41viYtwV9I5BNPTVQ7sQq0upT1xzyRMpRe0ejB3R7OfqUUsXSAw6QsH4M7xgidwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tzP8kLjKes2UayjOSiibPqOQq2BymzEy6fn+U97oug=;
 b=jayiXOMW14ct1YwpvQ0lmCi/qnbF6MuPFrIwBxuu/GaTf3LuQmPlgtFydhpr3/D6f8AmhQPVF/nDDcF0T7IIwA2E3uEyIFZ+pk03fNxcQVjWML6C6Md3oJLDL+BPYdVpWGkbu774bQB55vsHHdDjiqd4Wxrrm022I3UFgPa4icc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:24 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 78/85] dt-bindings: i2c: renesas,riic: Document RZ/Five SoC
Date: Wed, 12 Mar 2025 12:22:55 +0100
Message-ID: <20250312112302.1605750-79-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: 983564fc-c5fc-4423-267f-08dd6158dc88
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y0lK7XONjd8F+ThgaGRws01654J7x96Rm+gZksbMRDcg4sLi3WVqDlOOit7l?=
 =?us-ascii?Q?EEzbH+TIiVztg+7LSHEGISI5YCLEThX7cd5eA3Mte5zZHc8h3CQv+506aO/8?=
 =?us-ascii?Q?wjJPWL78SPdU1hiNlgZdJzTZc68CJCApHMt0r7R9dEVYtL6jJxYRyZ1MTfw8?=
 =?us-ascii?Q?vtmB6Np69aspbZJq4Y6c5dFCCkCsVbqbO9agTPKpAky6eBBUXZ+RMi7mREWQ?=
 =?us-ascii?Q?oOakiZlA/Ou+k9W1Mv30YI3unigDTVar6sN3E/Fipz02ONf3o6vF7tLl3Uw2?=
 =?us-ascii?Q?mKO/39Z5MPNYuJS5DllvZQx2dPEr+R1n9OErQue+rVcE6+gzWdRzg0kzs0hW?=
 =?us-ascii?Q?qkwQqXPiRu2UF4w6y3mQKHm5DoRtny7SH5xoT9PB5jlO/zYDyv8Hw57LqzlO?=
 =?us-ascii?Q?ZjjBygDajbWixuL+pDwB6Q7Sqnz3NhcMQEn6P3Z9W+O+9JHMQ0PsB/XM30L0?=
 =?us-ascii?Q?akrPRzzt2R7WNiqt3HF8iroiGBk28JHSYzjTJyhojvIiLEMJl/r9Qqi5qa7b?=
 =?us-ascii?Q?m+MazKxAQfQWEo9gvwc9IkbO8QYzi4H4PVooLzsnrR5e12jcPAtlgWKzdmJW?=
 =?us-ascii?Q?uwD3NaL4Pv/qHq5LgiR+n09Hkk6mis7wj1KwBXmAEBuA49LRBhVdDYK5kwPa?=
 =?us-ascii?Q?GmRpnOPQcdMdWTDSxSD24qoO5TGD0TmW2Z+qDIDE4pfEwVT2w9R30jBy9Qj7?=
 =?us-ascii?Q?w9fvnUuNpg7gQGq5vdC/841IybA/5anITa/dqKkNUlBXRFMcoFfqKki54WIb?=
 =?us-ascii?Q?uZYCrW+Potzo0VPo2jXclsYC6eI/bUws5Z8Mjwv+m5xX9I3b6sVjd131VovG?=
 =?us-ascii?Q?ULLG04M4dVg3UInqNGoPllhPKdPuRd+5pkU1SVQeRaGRzyvbuOGmZvueNVeU?=
 =?us-ascii?Q?XhBzWyU4G9uK9H1ztH0mW4eG0jm00KSdeeppkQUpeQt1AeyosiSptdBJwaNB?=
 =?us-ascii?Q?ZZmcPhDa1k8GYtWhYEi3wjX7YOCHs5c+NCA7f7XxlueH30aULe6UXOGKaa7z?=
 =?us-ascii?Q?f1ufr68fkE2QerrD/S4/syZq+6DKLWMU+lMU7lDK2hDy6nwcNe//8E6cGVXz?=
 =?us-ascii?Q?ZIiizlE6WS2fWIeQhPfMDgph0a9NicCxh5CEDv8LorPGIZ4LJ9dk3BHnUun0?=
 =?us-ascii?Q?Kgu8a7USNOrIMXR6zzoOdKZIahvJvHxY+tuVre/gma99187OSoAC1k+soVQQ?=
 =?us-ascii?Q?OwORPZqaa06vUGHlmU4OnYceJRYNjnQsf+guiC48H8G/76/9PA25ktnKhMzh?=
 =?us-ascii?Q?FkaanKGUPVCInErG9uQYTzYyeSpRrT3xntj54SsocwOmy72BesW9qgx+sf8U?=
 =?us-ascii?Q?m4HDde895HbILdhTEQlN3jG4LLuzxg+36CHkpMWienYLMc3LuN1lTFAFIaZD?=
 =?us-ascii?Q?Uyf7+1HkidNrQEk79vDFYGu/O060Phi2ZjC412Jb3XxcDDg3sXApgTysr16B?=
 =?us-ascii?Q?nZf0o9fFRcC4PQb4ZP67jH6eFH90Bp5g?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CYNKY2sbo7VDD6N0O4chJXw5NQWFPvhP9t+EOpEHEA20tl0aQdggGdfICBQY?=
 =?us-ascii?Q?UuMXrVOygl0fK+6nYMHr67fU/+7KBONKbInlnZ58wuWcqlt09GTCQ/YdYvu5?=
 =?us-ascii?Q?rbBX0ZYaRvR4xjBk3IQGLlNx6y+lQCw8YWz5vtcng8lZSiQkuWYMizMN2ftj?=
 =?us-ascii?Q?7HeQUuPE/MFOUTamslbs+2VActDe9aXQYszPp/w1R3sutZyb3kLMtYT60ens?=
 =?us-ascii?Q?ABAFky1+U+8oworbfNMQN3RSYqZHjVUqOBdgkhxxNPbCcXJiwtBqpSZM91qR?=
 =?us-ascii?Q?YJ6ZfQY//h8FbBU4pZXYIZNGeNpFlDwQertHxqi/hh/ajkWVtHEHcIpz3V+u?=
 =?us-ascii?Q?XaT6yEKdF1l4zJemOe6zVIDZGE7UpYMP2TcwoTSQOj1E1uNGOWfc2yGXY7w4?=
 =?us-ascii?Q?MAJb9zZvPgXGjVavy630MYUhFmY7VbfH8N86BMI+Ui7M4RkG+bvWMRyNoifS?=
 =?us-ascii?Q?4FPSRDLimCWK3Ur2XrRyp5PGQ/Ye91LC3eQc1gED3K4r8LmfluYUjtYcpGjM?=
 =?us-ascii?Q?0X3N1UP7+Lp1DA+iDHQQlsevHxuGp7X88/HLT07KfmK2p0JrlDfhSWv5k3mB?=
 =?us-ascii?Q?0baJbEY+/kcaZmP8N6msmJ9f0i7FJSpQADGTxNHrfFC5mHsHMs8+ZHpIzBK4?=
 =?us-ascii?Q?09nE9cLrv+7lGrxeqOY6UqvzubkcSwi48Fa9d9O09uDvp9kZcEUthZ0nrJtl?=
 =?us-ascii?Q?zhpWqFbSjrJWfi3tLRjQViyz/2+WAYV0YbH6/bDrOYHTgvkDXbIxOD2WMh7m?=
 =?us-ascii?Q?sO56UhIXqzTX5FoXGhKdrPMEntCfzodFubFryJxTgonSoTvH3SiClEux2KPh?=
 =?us-ascii?Q?GGl0mnJHxKqNvosaHuu7acqnSRjJ8WG7y7vZArImaKDperqROLJCVlsQsG6R?=
 =?us-ascii?Q?SFgc8rHDeqPATs4HBG7C/3jfUqzR2+4IYvH9qT6x2NF85fUEG5yXDe7YdIIa?=
 =?us-ascii?Q?IOtIrXbcn2pAxERGDuAMHvGT4FPGJvTw3OodGmntKvRHgKEgQMZuIe7OH84b?=
 =?us-ascii?Q?y64FGqvT3NcZhOuWknKJ7r/De3zW2X1UYM+REU9I6NqlzzxvSa/AmR3EZjO9?=
 =?us-ascii?Q?Dt7eA2gOyaqhU+H56X6sZyigePVMZBGTWb/s3oktDD+MxQDI68iNW6PWaAfJ?=
 =?us-ascii?Q?pNGJwEgiCcdesxvO3mp02H4Utd1Pj9pqzAYHJD9J2q6YuNafjnELQ/KtP9MU?=
 =?us-ascii?Q?kylF+fxUQ/DytLzASI2XwdcG0ay+L/FWTJn4Eq42a4J/UM7/WgB6/yQDYjnb?=
 =?us-ascii?Q?VEOIi6c3v6uR9gcQ+CkdK7++BXMrxm8I/5Pn3Axow/jRx4bcK+uFAHFbXu8F?=
 =?us-ascii?Q?bOOgkfma23r80KjOJ90bLdoYwfqNK16aoGigZceWMrrTw6Cg8jghnCT+Q+nL?=
 =?us-ascii?Q?vX04EfodSmTQxFbWOtOWQNDnqN651WCrVBrztiNdwKSmxecZRWUe5TNw2Wrv?=
 =?us-ascii?Q?ESJUdlSbdbGtW8vsSA8qpEzJvmy4IVDnKRH59HOm+XmaJM1b6NGz/ezJJZ0S?=
 =?us-ascii?Q?6uqP7aLw8Nbeq4/3+koVxT9Si+BdmM6GpI1WBd3E/TwBKHee1CNyMfvC+vIf?=
 =?us-ascii?Q?Ys/nslv0Vo4mvq3gvKwy+hNtkYIhPsstKOoeb+xS7kWMwC43XdBZw/tcPH7n?=
 =?us-ascii?Q?HcLKTeRScCfon6gqPiif2Ns=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983564fc-c5fc-4423-267f-08dd6158dc88
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:24.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU3K/iu5f7a6S2d0DO/zZYX/78gp4LaSzsmgDFHYZL1gBnAO8ZOl6v4DFJaeJfWmwJCzquuE66Y/yzUeEvmzYVM198Jhl7AekiKgOQBGEJM9euQ8dmEeFNEUFfiYc8jt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18170

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit de917701da5d5ccb31825dca850ac49399e0f289 upstream.

The RIIC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,riic-r9a07g043" compatible string will be used on the
RZ/Five SoC so to make this clear, update the comment to include RZ/Five
SoC.

No driver changes are required as generic compatible string
"renesas,riic-rz" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index d3c0d5c427ac..2291a7cd619b 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -19,7 +19,7 @@ properties:
       - enum:
           - renesas,riic-r7s72100   # RZ/A1H
           - renesas,riic-r7s9210    # RZ/A2M
-          - renesas,riic-r9a07g043  # RZ/G2UL
+          - renesas,riic-r9a07g043  # RZ/G2UL and RZ/Five
           - renesas,riic-r9a07g044  # RZ/G2{L,LC}
           - renesas,riic-r9a07g054  # RZ/V2L
       - const: renesas,riic-rz      # RZ/A or RZ/G2L
--=20
2.43.0


