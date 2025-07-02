Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71BCC7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:38:03 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.26])
 by mx.groups.io with SMTP id smtpd.web11.20596.1751452677253861313
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nxQ4NXps;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlxBdtcPNuQRpma21qhLWIdX7hEy1re+krMziWiFEsvjU/8i8HTgnhikbwc3JyB+aH/2YNvA4fqdNaw5aZ7Yc6jtR5t5iPSTUZ7PqrOa+lxcZVYTWBY6Y69ByYAW0D7a/meSceH6q/VY2Z3B8mDyPq7E9vvGnLRegf1I0gDiV/xH3/r4DRNtHcFzhc9hZLxf0Y4bbJ2eDYSEhI/Pm/dpkWrL7QYwMfXWCmluV8YcQrqyt3ZQiUfVzHq3fShCM3XKIpX9tIJXhivNjEuesP6vVf0aVChfURHABVnec6lkeEfdLpurJBD1CJ6GsS1RrlD/tP5fINKBbVSoQkbewnhLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW4RJaveBS+8BisCTJZprXzKZNhNc9HlWMidD5eZoVI=;
 b=ljDQbcBLfT6t/A/D2//6yoAkMll95HzdusB/msvhAJ0/p6GtYBXAmU13CSBPAxccKEtE08LLMBlhrjo7BHGRRJXgPMYIw1rFSUtzFDfsB1SgZPdnkBjeV/CuX0Qsy1bCJP+V/JteghRC2MzBbp40B5ZpY47lXHEraKIesX5DVwWev9+L/ErNI0SapVa0Zz9xcv1GThU2L2v4VmcSs1aApshGQP8xaFoTO1cGCDru/KOXn469Jiiykw0u0p4Ga3fhW5PPo0V4MoaGIb8Wg3K2rJBfuDbyx3+hXK10sOauBOCa4DbCfD/Pj8k8C3PqQrA4i63ToKqOkObkVV+ltz+l1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW4RJaveBS+8BisCTJZprXzKZNhNc9HlWMidD5eZoVI=;
 b=nxQ4NXpsp9JmBfSC0Otqq+Ht3vk/YkyX/PBidjt/uqANS5nrV8IMcYiioLuE+yjf4U8ciqLJ08PtbSKaEGArx7ywteXMlLWeD2MhZ2pT7COK+hEBJdYv+TySuBFwve73TenCPF92/oxiWOpcuU01Zr0RPbBjFaYd4hLdKfvy67M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:37:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/12] dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC
Date: Wed,  2 Jul 2025 12:37:07 +0200
Message-ID: <20250702103710.117760-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd99d38-9749-406f-869f-08ddb9548106
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/msnSmR6vjjXrbu4jk3T7hM6zjMbrA49egR3uuXzYXW1K1IR0LHCrxkqtzlj?=
 =?us-ascii?Q?+yHfWIbzEp8oUsu0UEz29Nmv/BGA7+JS/Eg3tR6+QacRFkJRmKmVq2ox5G4g?=
 =?us-ascii?Q?bpG/2gIeFKPL9ErjquSAdWymTpVNP9rHItHRaXVnviIAO/P4k2bDuP+Khfsi?=
 =?us-ascii?Q?0eWbYLUt5PAgm/eCbHhxU2zU+A4wTB7Hc/uyhuCkhyqW/Iywp05xgp6wqiZo?=
 =?us-ascii?Q?m9ICYBEUKso/tjcy6X0yRhXCm1zVXTEQg4ajfHFS02XZDSEWmWK2ErzsACRw?=
 =?us-ascii?Q?/5QyGAbb9gs8ebuWf/4hEnVktMjqD0gtr55qfUoIJOy00AZs4Eam618bdjSQ?=
 =?us-ascii?Q?JhNd5aZskDWFy168Lv7elIXX4/31TKJ8jV8EVzHcbrSyyXfvVFpWATKCyQ9U?=
 =?us-ascii?Q?IyPEWOo6NwqMfXj5fgdMz1ybndNLOJ8iaK+aYm+CLwb2ViavqfOtQfH2ybRl?=
 =?us-ascii?Q?dHhti4jekmbM1YNV9LiZl4sbNC/AfBI40mAo+1GqgITcrfGqsJ3V95Nn+tQl?=
 =?us-ascii?Q?HfLO6X5TyB7EK5/gV4p/bl8V2Esk+0Qy6SDnyWsYiN4b4fzYpO4vzxNzuJDm?=
 =?us-ascii?Q?E73MSyF8xHo1g7jpZF/hcbjhh/oX5O/BbBcmc4fhossslwLYwu5tLLUzzvSE?=
 =?us-ascii?Q?8jon3BR7jVJoxwvdiISs8NGnuKuBPxfEA6idIKZppYzlssRel5INJxKFYS3A?=
 =?us-ascii?Q?4k/vTNOsOFmQcyHuFdiYmD3fNu4HJxq7P1T6DW018kKb9shge3qQpq+11Oej?=
 =?us-ascii?Q?77du8ENoLdNwWqnPBKtpwHtCFq35U/PnxA5d+gLlUfzGH+y7fAsqPZDCX7+A?=
 =?us-ascii?Q?JO6wysZniORCIKSH/agxZwyC8cQr04pm9y9jxrurtj7siJE6b/5c4qk6gy7S?=
 =?us-ascii?Q?3xCcirzg2r8sPgdf06QaYD63vA0W7OzM6dhNmJgHEs4Ujmmd6E0LO+MlEcag?=
 =?us-ascii?Q?QCBruT4KB9UBR+/AXkjhNf1EwdcgvVNW36XzvgeCkyz/5AI6Q4j5WIj0Jjlp?=
 =?us-ascii?Q?/cjAzhDICsnItgFnx3nNihvy97FTVflKVcAADeUBIF9DZfNXiv6b24gW4Xhj?=
 =?us-ascii?Q?ui6LGJsU9PNLDDhCytez+YBCdhS2K/BejWiXIKhlkyOj52sUfpNRPcXuaoJU?=
 =?us-ascii?Q?AxRWsJcOzsUlixHoikesAqF5b0c+scqPbbZ1EjMampAW5qMes2rmo3QqTcUt?=
 =?us-ascii?Q?QZ5tmeMj+Xw1pyvaAdGYeQoNznvdhiW/h0ZlUSekpoF4XW5vyNOWRqmuj0+V?=
 =?us-ascii?Q?aXDPhtwiW5vKMTXOFQOity9mPYiLQFBnkRAhXDdBrqA3mMYtdTlkukW6VIQ1?=
 =?us-ascii?Q?ZMLqXBPBGZ59hLND/ErXM5tQ0OILtyMTxjA/hM28oNS4HGcZPaDLzW4xWXF9?=
 =?us-ascii?Q?XOL6JlIsAhLrtyNOQa8/OosKPu40T6v7r9HosOaLu0EL1RZtPC0ptSpenrJ9?=
 =?us-ascii?Q?Co/OHyAniW0G4dgGGxZ0Z2l6w+AhB9GD/bkgH/HzBo6fc1CVIr2aoVBH+Jkw?=
 =?us-ascii?Q?FZAOKxky5bfmNwQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?igyTHBKK25GdZ5RpUIEXyqYvaPXYOAWRjy6Bc33qIFsAxO5n6GkLRNC2xa6n?=
 =?us-ascii?Q?k3ow1YNKsQj/lSzzYkEJ8vXe+RHfiG2evbR1oad2hRzRdGcR0hFxk2XEiP/7?=
 =?us-ascii?Q?zezFlYOJVwhnpVJGSuMlhn4DFg0bHEMf6Bsk7vQJYXoYc3WGgX4dmy8YmjIA?=
 =?us-ascii?Q?tNUFAVp9TAk6jLEQHemoMIY4tNINWbeoF354Kg8S+wst6ui3nwo3c61UZ7S4?=
 =?us-ascii?Q?fofw6UuQyD2PRneDkHnpIU7WExwaBP1KgZV2VaQaW+0gzFm2LHUP95z6MxPV?=
 =?us-ascii?Q?KoBv0GIf7NgzHvic9q3Rnmi7Zakyr5lmxdqDtxK/mEnwu0NpBnksdFgp2Uie?=
 =?us-ascii?Q?v44uuOIO/CBNW5y/wyVMaosH6BK02owMpYoSTNYb1xtjGnDqlEU3zsJPZVNv?=
 =?us-ascii?Q?lVTsN2XwS86cNhZnVOK2P2jvSfe/9JjgWRUW/+uCWPgX+OkspPVgxFD3RiNo?=
 =?us-ascii?Q?d67H9j1IuZdxiLmhXXA0Ol/uX3Q8nH+j9iWPw+wXRhcYGCuZ+1LTFZgvM8OQ?=
 =?us-ascii?Q?OYSf8+e+VBSOAp4EB3W/Ey8DnIL6ZbqFQteV97rd5BGzq8ORqHFXmV3hd1Hq?=
 =?us-ascii?Q?l2/Xa7TZbGn01U6/RPlm7eQvdmhvJWoSTPke9SgVP4tbFCLJ5iTzss16rPn2?=
 =?us-ascii?Q?buk22wHEyj9/4MtPKd/0bAAZu276/NvTO9XlwsyGu3U7HDcHoEWhTFAyQU0/?=
 =?us-ascii?Q?JZzdGNu+DML2JNf0bdj8sCXgcTpFpds/DC4nO7vYazAnKaNIyXevEiMc4/+c?=
 =?us-ascii?Q?KeOZI2QuauTIOsoHpc/7MVx6xIByhiRTFPI2Q5IpmwEcTB6v9c0GBQ9v0gMT?=
 =?us-ascii?Q?AEPoKixdY4u++A7dTGMIQJhBNi3czhKuoHnC2MsYwOvNGezfazroiN41VXo1?=
 =?us-ascii?Q?SganzG0Gr8rkUZjU4ZzfsZtBPbuKXMn1zm6otmGBPzogPXb2r+FW/HqMhNDA?=
 =?us-ascii?Q?BjAOIVDOGBQ6iO17uuXGYdtkMxrI1NvA6dj3sjg2CtA3XaA6lX9iAuhoZJMj?=
 =?us-ascii?Q?nQh2QC88lhXuEXf57Jh3b8AiRs46XSpRtZL9UVaSHyOaiviIoms8fmrmcHNc?=
 =?us-ascii?Q?pJtcdUXkn8eRfhvwWheOXehLmdsrF67SGr2jIFwwJD9AEOTcT7ZT24RQeIVF?=
 =?us-ascii?Q?esB0bGuszIwBJxhVEFl91dXwGw9oHnG2oa8lY0iFi09mXVvAtflvGtHkTzKD?=
 =?us-ascii?Q?QxAtAfsW75jL4vQ5iBmEd+B8G4CZ9PT8ch6EuTVf1i+sQU7X1XNFqWga1N69?=
 =?us-ascii?Q?V7845VD5y1S7rxu5KHIS1Gpk6MZKJqU2iDM/uIpjs1CSGeQ9qKvfYfcVY1Xv?=
 =?us-ascii?Q?hY4FIsea8sQVZfH7KIco96NSFYp1kostxBAf8A2mihpAa2Q2RP7GVkqgAVA4?=
 =?us-ascii?Q?166gXLftKsVxXmBlvZxKZ/jKL98FGnFWlbYI1zEuYnNJbEz7BwYuuwGNx3ow?=
 =?us-ascii?Q?03ec+HGQAe5iP5K3Cu7++XA1AHb8/o++GtYL6biGBgUiimHjgnRjCquZxU+c?=
 =?us-ascii?Q?mGWwZdFvMnvB+5CH7VPegPUfKgKosK0+T6eDlTw1XPqWtCyUuXJ8FoxMbrcV?=
 =?us-ascii?Q?4LIDS8QG48AvnnCoz08yhLkAT7lj6p0KUphNm1Vk0xZHjbdOwXTru15U7sqs?=
 =?us-ascii?Q?NAzSeGRrjOk+txCemAqLPcw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd99d38-9749-406f-869f-08ddb9548106
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:55.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3xMCsY5XDPyZ8ub7olSwsRPzkom7TZSRHIvnFROA+Hs5fa0EG+g/v1Zf5R8kt9rj5VRo/ikfU005lWqhEXgUw7+yxOtt9+VdTod7NUYIsQjn/FHZUPDeQiHS5XG0IB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:38:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19307

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
index 278399adc550..d03e5c61e4dd 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -24,6 +24,7 @@ properties:
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g057-mali
               - rockchip,px30-mali
               - rockchip,rk3568-mali
           - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is f=
ully discoverable
@@ -141,6 +142,7 @@ allOf:
             enum:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g057-mali
     then:
       properties:
         interrupts:
--=20
2.43.0


