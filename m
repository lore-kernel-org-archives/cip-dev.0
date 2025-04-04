Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F44C369A1
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:01 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.60])
 by mx.groups.io with SMTP id smtpd.web10.6098.1743752336007445269
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:38:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=it4pZZxB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiJZKB9tmcMqmiwhCTsrSO9REOWQlJS7hEooniNDOjlb2ujTem/bTkMpetTMQAtBsXXjPrgbzgW+Bhnj/VRvGij3xrYJ8F5tdrrt6PrQ49pnjzInlLxgVTX5keNwt9QCqv/Acph6s5iWK1jQR78JNITMAqAwFnbdPbhsTi1Y6bx333Akc7NJf/n06A/kw7/MqIFPcgg7n85b3oxkz70rJ4Rq0J+W359+5Ds+4g7J9hGUh7SJN98jOEiDB0x+N34AIu6GGWJNzldvQkFPAXH/awUkXfBQFLXQwGVbXHBlnTZ9V/GaQoaFC9ZgNO3lu36V3j0Eawx6OLBGS2MEq3wP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f9MQdQlcX74KWCsGDrEvPe5Co3xbVw2/4QxMyzheHk=;
 b=vLcTGm27hxn7LVDhw4aKsZUrvTZRowzrtZ/ZTOvduz2vF4ElwCyyP4ezDSRKcIZ51YiAuYJ8IiPDcULhLNoTIQMuEIDjqH7T5Ah78ocjLEcFobdYqJxxN3EOGXk0J9Jjgu0wtnZTdJDKS6ojnAkjc/YoIaRrqix6gIle+WzCsFholFvdy3ed991pYpO+cvPC7u11PbL47UjYF96OP1DAGcZoPJowjK2hdyMxdjzMOvmMGox+pirRfsR5cwWxYs3eK0e+KGhiFA5V8qm9LHwFb8zTxLb4otOdXftdYfBe2gFDCqQH6C6nM4E3RXeOPowQxXD/6nAFH1DodozztUzR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f9MQdQlcX74KWCsGDrEvPe5Co3xbVw2/4QxMyzheHk=;
 b=it4pZZxBBd8gJ//QdbExPc4o3rGdhcKTph1SKiAYfDDv8z8ROoO6QARQE3FNV9icAXPRbCdtibfslMCEPATsBFq6taLy0qesfBWzHMw+tj/v7MHZ8noDReO0rqvTe6nBcJFdd/qdUyZoO7EEn/DHPivIP9RntP3q/R+eG2WunXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:38:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:38:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 2/9] dt-bindings: i2c: renesas,riic: Document RZ/Five SoC
Date: Fri,  4 Apr 2025 09:38:12 +0200
Message-ID: <20250404073819.173272-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: 49228803-3586-4ea3-f6f5-08dd734bbd72
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?N/oLi1mPjRSMHW1IUjt+vjU09fAj8FF1VO4oo7uFlsL9/OSpXGShpZiOKoYl?=
 =?us-ascii?Q?uScvnuLYcwCt4+hPYLcNw/2den3VCUN1jGG8+6+2Xq7a4mgowc+yXxNAKft8?=
 =?us-ascii?Q?mm1M0JE1WiHEqQjK/mryejWx131dgYi0p7W38+sR7Hckkvvf4CBd1adY34Pt?=
 =?us-ascii?Q?iptWD/qruHQrT1e7lMLwRe8kAcWikGaKlOZgCbGqSXPearKEBq/LZTmHshzd?=
 =?us-ascii?Q?VyKgTfULFBAeM9Ieeo4ls149BDOxHYUJHU8d44tKwvB9k5jjbysqHYPzw1LW?=
 =?us-ascii?Q?Pw7pxp6vFulF+cc5dTYcXKnhwju53lW+bMSuFKvREetkJkG0eNRyL4vwsunV?=
 =?us-ascii?Q?9R28uDK8Kw6JmN++qt6/VkzvvP9qnzlYm0tVy8l+4S55YOWUsJgLm5nNVx0+?=
 =?us-ascii?Q?99cxzhN0m0IRqoZyGSgjx9PqceF6YFpal8MjVbeal/70TGDaAdEg0NfL0v9l?=
 =?us-ascii?Q?4SKKMGEjp5/UWqv1x9hwNbldrj5lOspJb06vUMRE+c8OIU5DDzDmNkQ/HDIh?=
 =?us-ascii?Q?htn7Bshr7CV6zH+Iyk51oEOO9Ki/vBlTykwb8efWeUHJYZ7LKH1H6G8m6iYr?=
 =?us-ascii?Q?63vt5NnE+NkWV4jpFAluRcTdIpozlr1zgmFKc8+6o3oofgBQBPRdmuOUzgbH?=
 =?us-ascii?Q?1ckJfmIagyksIQDsnNrgwIcTAs8e8KNjioIKoeU054UqVuosOGtNKMQNYdLK?=
 =?us-ascii?Q?QZSHe8v992us/4IqGpb+5A+TDHkbeR1A0go+XLT8/grhnrPh4kSiYKZCSPHN?=
 =?us-ascii?Q?PiUng3Pwckpyn/6jun3Xb0PdpebxHI7S/eM+PM5HiNl/f4lugLcWvxbzaw6/?=
 =?us-ascii?Q?irZNnUrAE+GleJ0p7FIbs2oWlBDxdEo64d9Z/7c+0hsJTZATPqeeYCDIRQ1a?=
 =?us-ascii?Q?Ak3+Tr3ccgWeD3dJEeBVTMosxbPK3XP31nCeyPpYcujZyQHdXRyRQh8bvJ0o?=
 =?us-ascii?Q?lPt6Jf+D7Zzm386uVYS2UDoGvxWFXnrtHivjRK4hd8yJSXpyO/meuCRIXkZx?=
 =?us-ascii?Q?zISSuZIadUYu51SIb72o4QIePfX2cfbHifWzteOrIr69+6Y9EbFNi3vsjdvo?=
 =?us-ascii?Q?Qyq9sxIxDtzvUh6YiYW+OLiYkLcH+EkFN7qbHCiD1WLJVqQTgbInCP0Dfr2X?=
 =?us-ascii?Q?MaPpYZAIIY7wcb6LnY4N/ZkqVkBraIlx6igTmFeBBIRiP07BPjwlLsqNpb4/?=
 =?us-ascii?Q?h7P+KEOncs1e6a7bUUGs+sYGPZ02QcYLI2vbqNglMaxRic7jR27A5P2fDmFl?=
 =?us-ascii?Q?bYX6W8GKXON4sQF0a2Efsal4yo9Cd4LqAlzZiU7TYMoVTGtolJcrngUKgZCT?=
 =?us-ascii?Q?N8ljueUR4ePF4pWX0jKVa/SPn9AiLZPGjBkHHik8Bb+Fxgj6yDJPc8E7SSUV?=
 =?us-ascii?Q?5iadJ3+XcxnIOBU47Dq/qzkBfItEx1n83ZIhSunnKNFVXUXvM0WGq5t8IP/k?=
 =?us-ascii?Q?/Q87+HqXxBNwgV0F5hrcPE+zz9ExPYrg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DOesgzJxmX32yJXl4CcXVEwZffnZz7qiys2o6Yelt7gG67gOSdt0AAM7fwRP?=
 =?us-ascii?Q?z8SMcm+RsIfKpniO2LBzDCDHrwJdenM6yRSBYj4qrAkbYObBVyvOHAJrrWau?=
 =?us-ascii?Q?fulAMljY7WbHptGpTQUDny/h6UlWqXgFDr4d02pCqL8qw3r5aNAoyCLJLih6?=
 =?us-ascii?Q?5d1v8lu85uQPROGvRN/6FNKwrFkSK+n/luIR4MCdYLWqKNtilMRm4mBWvI8i?=
 =?us-ascii?Q?wUzzCsVMfBuHope0RWameOpSLahzun6xfJ0xhCpyropaJMH1nDTgQbidHsDT?=
 =?us-ascii?Q?sMuYExGS7IhfI1nIv/DjxmdiHRNxUbCRhbVtWZJJ4fUe7ha6JRkiYDeWovxv?=
 =?us-ascii?Q?3t7hXbm4JoIEPa0NaD0J+b+YUXnr8r5kDu7lQ/KoQRdo2zcvXvc98gsvosPE?=
 =?us-ascii?Q?J2SMvEho4U3GOMHbT3C1b+M/O8EA7LSLjtjiHgduRCOzLI8/NY1vCm7W0jgB?=
 =?us-ascii?Q?vditDCUx1LbpeTYvP2TSBV0uSnM+H3lkXK3ugc/4SuN7CfrWDkQ+B9tQsQUM?=
 =?us-ascii?Q?YNueTvgnbUwe0ilMe9vqIoLalNzSVX+KXI+F+Up0yuhbb+fNeLGaeKR48n0N?=
 =?us-ascii?Q?wK9tpuiL/wNGoK4rsXgLEKN20Us8HT5VpBjJCUmHmBwSM58rHC0t782PRBDO?=
 =?us-ascii?Q?HLidJlXsY4yxbn4+pxcNf3H4tXDsVeTcLuhKIM5vxvSqOganskG3A8eIuQgv?=
 =?us-ascii?Q?aMlJZWprgivD2mkLjDgCcN9tqRpaPzZs8E80ak+sWFGXXtS7glWpcgSGFG2W?=
 =?us-ascii?Q?w+u61IHVDYZc/01NcE5rAJ4oera4KkeP/xZR5l4l2ZvIWrih8FW+hwY9M3Mj?=
 =?us-ascii?Q?Y/AgUbPAKJqIbWwZdBAgL0j0NvMPWj6vDT1S/rgpi3tYRm7iZlCW/oPQWH0y?=
 =?us-ascii?Q?YbtOx3utZGZr4qlERcSWqEKIAXoISxyJgfAOzg2K6PB8/YMJjJk20O4/+P4Y?=
 =?us-ascii?Q?oeE6R00BNPsK1qohLaAxhQuLjA/aKa0PK6rxwqfDL71eZ2b6Jpe6x1URCyro?=
 =?us-ascii?Q?x88C77ooLWAiVpthY/FurlruWru6q0gUttdE/EfHTo4JNEY0UD9W3Pplwu0x?=
 =?us-ascii?Q?G40Qe3Zqk2qCS+5fNND1yChRpHEqHR3H3mtohZxSeUfIiApXVgd8+UlONlaq?=
 =?us-ascii?Q?VPbFI86Hr3xGA4LB7p65IfXZDLhIIYKEtqvFtZ634HJXnPDbF/0Se61hIZ/V?=
 =?us-ascii?Q?ZPZTi4AELU6k++KQwA8SUniaxkVzyD6fZy3LlHtg3rD+xyS4nnKp9VLVfxgZ?=
 =?us-ascii?Q?VRAb8MiJB8m8WO9LkFnbAUsPOOTeET09VVuEeIbSAjd53b9yiKx1E9eXa+ez?=
 =?us-ascii?Q?Vmzm4+BjfFrTWQ3cjgUjPSMtX8e5kHHyNigjttJY/LcQ7v1mnPaJIlkZSQtA?=
 =?us-ascii?Q?3fuyefq/Z1CP+nkebkctyDiERmgRC3gwAsALmKZVtK4V1/RyZ3V7GxNDRtaz?=
 =?us-ascii?Q?WFaPzYqhuzz5JXjU4+DFq7pmiDo93JmvpEQ/wxJHUZBJAlapuXX4wXU4rv0I?=
 =?us-ascii?Q?EViJ1w1ItluqK02GvwejfboLmwkA7QuMo3Gh18NFGv61P7chIKm/mjA9PlCj?=
 =?us-ascii?Q?TnpiUhYmKF9HC5wLLp5tIy3zc6TPNL2yvNnXWi3sggvfLmWCzX2m4wjHeZX7?=
 =?us-ascii?Q?k2ZTFem1Mv+yXEJ+he14OVM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49228803-3586-4ea3-f6f5-08dd734bbd72
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:38:49.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMGYB1/LsiTV1H7Sj72PI071c8YQGuxQqjppyK6/CPr07mql2mBhPw0INijPx/71dPkFx1tqoX7ZPPsXL+147CWa3x3mwBuuXcBdGch1M/20MRr/BC86kEoy4ZFqReVP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18466

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index d3c0d5c427acb..2291a7cd619be 100644
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


