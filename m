Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4678.1794226503764129180
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dcGLf6eq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.13, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkkTCUXzBFoQB8pjChwSnOc/vBdpVqepurslIapZCFSq95PicHZIHUBy+KzZJmY3ZBBaeY9hT1pmxfNg0FPzMPTQjIppqPfSNuaO9I5ELvSTcrbsex3QskioAxlvTOSgHr/UutHCi5iTFzSRS2voP5QVYMCdKyDuqUQWg5IxWdPHNmDIiH760EXgyJ2vmuV488S/Fk0iX7rB0L/BZ0P+eFasHlP282xQneCDhDdHhmZbfRQ5MGIFYE6cGNCazikGUbUkCLyeCxBjEmmR1rlVniWL2BdT7v7TwZKhbqRmL8DEcRc4rkKU4NMk9I4dtsZr6dwv5ViN6FfoENj0ScWyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u8Zr5cP2sFUqNshL9CS5XfAEGbxI8dnykUqoH1eDrI=;
 b=o6VnTSwjqXusPHvS5RFeZ/V+vV78lyyIj0nxGK4Xiy2pIpkjyCIDpTYfcEoq/unhoKiQuBL7aGiff9RlgorjtEV/cBh1jd3LTDwz/PCeUaVldYvCuIOZrqRU8ExCfoUBiw5orFhXQ8le8s7QnYK5/9s4C6oBhun5SqEB5NgO+6YyMiND5eoYSXeHMnxAm0aziIAVGaxqXsYp6b9qopqAODxBWxjXL0R3Yc90D3R1QcFz4NiQ9Li51f/HiVXsSlXbUID/4Cu9R+fDss4otMnqd25NRj+8JOVhycOu+fg6dCJGurDB3XLJB4dVGv85pCvl66t4NU5LFpPQSiEcuYdjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u8Zr5cP2sFUqNshL9CS5XfAEGbxI8dnykUqoH1eDrI=;
 b=dcGLf6eqrw0Rj75/ojcfRpXNdBbh6BGYLqx9uQFa0XvgcOwY+HinTZag8E0pIqqwzpW/HjI34ry87U8PI224+TGBg7ndWzg41BG0vjJFacWJQXlWw7/OTaqduG0qPz4/tUKs2PxMwmlm9bK7VoEdK8ir84hpCwczapMQZcstx04=
Received: from TYCP286CA0082.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b3::6)
 by TYRPR01MB14034.jpnprd01.prod.outlook.com (2603:1096:405:21d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 12:14:55 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3:cafe::3a) by TYCP286CA0082.outlook.office365.com
 (2603:1096:400:2b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:14:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:14:55 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 53D80300022D;
	Mon,  9 Nov 2026 21:14:54 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/24] dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL
Date: Mon,  9 Nov 2026 12:14:28 +0000
Message-ID: <20261109121451.6042-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|TYRPR01MB14034:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c39ff28-40ca-4e56-7274-08df3e5b10ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|13003099007|261026140227099003|56012099006|11063799006|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261009223027099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: BwTIXzPxeDtVoDL1Fy9S8lbPM0OpChVgMa43B2tMKIGqrNd+5pcmw8UfPgnzXSFIxuNkNHjGWo+/9NEA5un6EZmTV91YfdCTkjum7aeK4dGn9W5W0fXzgRUHArhSpZZDcu+bs8v8WkYVCVH/I3AUjI7njgxdK/84EtAeVZDSow3UUDyW9qurTSshudTaq91q8ngx2xwuzGqkoFoTwQlZmMxvo/yx91xqWAobY8BC9rOVuren44vGMuTI8ldps6m1KAYBOr9C0/+DRAm+3NMmecUwm1vQdkWq63u0fusTUHNkO3s3jTMD4k9TdKZ2sA5vv0QQs0B4GD7z4gqC+TatZzXMAj0sGLtuBcU50d8AS3gD7YQFrxpdlZfszesLBZ6ogKRqleSXOZRXHxQJE9pjzm8wJHtTR7jx5XN15P7xCutFZNPffTYVoMsK5Pqg9iRE98LrvJKszMR+AVWgQOxcsV/zkkTiFecqsGqlgFCJb57eR5xxl0lBkQFiCMexeiFHmIZepJE1MIYalyzbx/nPjlQTRyY1CYbOBjiVDMNwhzABiMiYLTg1YhJlGLYLekGy7fxfahJxTYkPZRcZDtR0flvj/BCcYkUAzy61OveL9ZDvl30YQeFis5E/OiI7AHjDmq/LBcgOromBievmHQnwQDUeJ4Alebtl5GXpjoXlPuI=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(13003099007)(261026140227099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kMgfkNVxo6W3P03jdmR1yVrZDpIjKyHYOU3uRMgjDAsO9r3Uww7K/x0fgUbZKbKzXYs8NsMIBVsiaCOtgNgwN0usA4we+0Xfsnchfx5p0kry/x6LJn0JlJa2y6u0L3GPan3FV4pYWL6CWOr/xpuxQqU0gkJBduWy9Xo8yLxuEZEpBzNJhTyYZ3kvbQb3556DS4MrB/A3qZUqu3WoCkvihIBtmSw1Auriks8eVsM7mneqK0rII9CIVN7IQ0xUQYjSElJ8apTI17sEHRgkK5f5iQVhEdOX8NoX+Zkxhz3iyCn1IgtvYtdGFn6iXNIY0d2IxqeSsFZddtflYdr/BjpXBEk7qCsmyN0uhZkhicXAp7Yk020Uk/fI7mgZC3JVjCdkEDQhZSRrd4chZGinrEMHkYsMa6YUb8KgVgEFPBiPeDq853oIuPsHsIqTM//fmVWO
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:14:55.6265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c39ff28-40ca-4e56-7274-08df3e5b10ec
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14034
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24706
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit 3a2be32a681764f20601a8d9692d4cd5fed5dcbd upstream.

The RZ/G2UL DU supports only a single port@0 DPI. Explicitly refuse
port@1 in the ports node.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260519160825.4082566-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yam=
l b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 2cc66dcef870a..5add3b832eab0 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -102,6 +102,7 @@ allOf:
           properties:
             port@0:
               description: DPI
+            port@1: false
=20
           required:
             - port@0
--=20
2.43.0

