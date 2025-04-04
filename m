Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2464BC369A0
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:01 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.60])
 by mx.groups.io with SMTP id smtpd.web10.6098.1743752336007445269
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:38:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cBQ0FVxP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmXu9WEOyAGiOqt6CW9EYpAwuxnib72BIXsiIrCHdpRe07fZrhVJ2+WUzbbUrqsQeL3oE71+KiPFBuyMMWeFSXSJ6oFX8JbBJsaakMGSDULCXhYVDvzVyZce8ZFO5qOLsFF6d0Q4ymPQsPJz0i//ImW9U2YrRULXAnucUnV8t4iqeea6MZTKvhg4ccwWtJXSG4Zx8CsuZ5PwONvo4Bd7/Jk/QJJgEJV4d+oOj5R12ijxttWLpaCV9Oxuv5SXtQtl6//VhupPyqhaNmKdDyztpYyUNMJoLI4Z4YvHUb+zjEjNYVD/pMf/wKKqWAxwedS6NmjRRkRlkKNbeNdJgJ5ZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc8s0nR95D5XdxzI24GRbC3zy8SAGsONIT9PcyN4Sio=;
 b=WiADAri7bDeJzRlVhlmKW1E4YKWkC+L8Ra10wavLv0UjcgLtBxSNAhNeZ+MgiBFMkqn6sREVgiOpt47abelM0lTuKRgoecSl2FpEAMs5QI3TZtMrBbhfcpA7jd1KNklBhAGGMDCRHvaGxK3KXN2Jl/jIuoZT7giyEz/DslgOsP5EI9bDQSU+wzv21alCkLH/x2M/j46z7xvPqjH/p6+6ZxDy2FeviyocmKoL2SjqAZZObbuX7Mbu3CrppFoJqbP/khtI/qJIaL9EcwI96UhbPU+zp4pAYuYZomMWPNoU30VRZeCEoCgVyaTJAkkfS8IJNFSFqliv8zGCsbjXMfagRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc8s0nR95D5XdxzI24GRbC3zy8SAGsONIT9PcyN4Sio=;
 b=cBQ0FVxPIb5COgdv8aqhvOR6KGp2uxMo4waViXXXUB1qmPFP1Hv4X40RYRbYqn5W8Fmj7jGT2deyDTFmVPqSq4Ef16aV+6t85gNsrfdWGeLU5ougI439QyC1pjn24OR+0Ih+JbaRuJ6RkPKnutRWbB0or5tFmNo/sVQJxETq22g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:38:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:38:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 3/9] dt-bindings: i2c: renesas,riic: Document R9A09G057 support
Date: Fri,  4 Apr 2025 09:38:13 +0200
Message-ID: <20250404073819.173272-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7907ca1f-bea1-4da0-5f79-08dd734bbf23
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rnOh06HOFykPyU5Jnx2lI1x5/1VVZQSlrcn/fMRBm7sjSp1xcrCGmrK/jMfG?=
 =?us-ascii?Q?QBUpyXFZ4aUVTKFOxdgqQBH87UWuWErF6/vFaqy0k/zQEsmsaUGJHyseMW07?=
 =?us-ascii?Q?8D2kNQdc6cMj0k0OhHQ2jOmB4VD/1LwpiudFoJUtQXGi8ZUW3+iw7cjIDh30?=
 =?us-ascii?Q?dXbTqJvdkyiOglla9xxUws0w7EmYtODNb2EaRmkfNWBBz1zeyhE31WJLFSb3?=
 =?us-ascii?Q?TxQqZt0NCLaKOv2Nse1P3yVUhKLqdLBKnd14uC/RKsuj3vXBk58jQMwvNTco?=
 =?us-ascii?Q?WwCE+AK/E2DDjfScSsRSwo2RKmpMgdUs7g9c+QBwL90UvvDDAAcH6+CcYiqV?=
 =?us-ascii?Q?AqnchqI0Xk/uct+/YJgRKLb5fonLj7e1kFgSivmyKk+Nzh/OebL6K86BoSXh?=
 =?us-ascii?Q?nmurMart9EGrTpgVHi463W/bxuSwLrfGcySCQwxewscACVdnOY40foCzD079?=
 =?us-ascii?Q?a9HChLnO7fdEvlKVFQya1HLWxqBB1zALbbNsnWV2LBAtLngVaQ0ADl3Yvi0/?=
 =?us-ascii?Q?38BQKs3YvBnLvRfggPG0zAn7ZIQCsJBCR+c6sOs2u+Cf9KXwmX1f5YzUfIfw?=
 =?us-ascii?Q?CIa2mlP3X4Axia/AqSeELB7HXqQf9RG4KZCF6Y2l6vjrV8CE1+yH8q6Vqmkt?=
 =?us-ascii?Q?oFidsqslH7+WDkrm/jncgQ6suXTlnxF9D8SFvvVXuKlR++h3kGIKQw19eJBH?=
 =?us-ascii?Q?23VHjIC5P3KXqQUnQaN8tf/ccdyVY/WtJ5bGwa8ikpKgTvgZKhv8wtcz8U2x?=
 =?us-ascii?Q?3tFA6B01+10SFYwOKNd03pkURXv0SJWZLMZGbSEebSjc4G8LWb5a8UjkBDFY?=
 =?us-ascii?Q?fNPSV1IaWNiGyZXF/oorOuecmbfW9Knr74cmx7fT8hpBOB1T0wpD5Rvvk9hr?=
 =?us-ascii?Q?XZKNjutyysPCitQxt4Rx6gLt7QMN6qX5iPYgmE94YvvypaCRjgCW0UXI/aHa?=
 =?us-ascii?Q?tQpXTWlXCY4JcvBKR+L16zIVtzy1F6uNYyu6HBrd/69pLQ5cx9lp4lHp1y37?=
 =?us-ascii?Q?Ey9napeNmumV98blaJ6FYMFE7MSFrXxQJ5pyGtTpXtT53miI1JkiSNraKN6p?=
 =?us-ascii?Q?0MsHS75YrjUhiIO/+iOpbG0sIicKQyVzMxfb83wW0VZNvkUVam/TFWYaZey4?=
 =?us-ascii?Q?RqOZuk9YzOgKmJez+lJJKJ3bY6bEu7FSGZloT/kNOnf3oeven52DivvPpiAo?=
 =?us-ascii?Q?Zndc3l2lg62WmowuMGAypUWBCCx94E9tU1/nFuOxtUp+JITzdOGm7Iou5m2p?=
 =?us-ascii?Q?jiBzFYuGewMKxhPfxyLKmCDJgWamezakoFlLOEpU0cPwgqbvmhWq8LiXB0kP?=
 =?us-ascii?Q?qEzLGVfNSHJWTUBDZ41upIFLJZebWdI2CJ9eXgJWL2d9nRBwmOk4NFlbBJDA?=
 =?us-ascii?Q?4P+fBx8DIqX3EKctMGGvp8zyeii0PyqI56kESFiutYsP+wOSitRa7Mnfva/0?=
 =?us-ascii?Q?vNpnsP5guaWImdlzkbrqX7FEcutOLsig?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t4y+CnSXhWuvzi5qHBwytqnVzB8rvd8y7sC7scihxF7KXU8Q61REx9SjqCTo?=
 =?us-ascii?Q?3tgFfbwIKlv8zwgpzPpT2T+fMiSt5+4clXuRkdGKQf6YuvIwNMZsUdjc6e7r?=
 =?us-ascii?Q?FisQckwnDTjPFqUFY1v03ICc8jYketJZAIsrUrl5D3e/Qszs7MNrs4mYMIg6?=
 =?us-ascii?Q?Sz6F9tmiKL+eJtG8LNF5UHe/zFG1ksX+b8TWsbwxZk+bNCKCsdzq7rrewI/u?=
 =?us-ascii?Q?S+hc0R2Tk8U8kzzTKXppJIbc2xZ2Fuoly78gggnMW2Hie4F8IAlrNFuBT//m?=
 =?us-ascii?Q?218MHP66XwJKlv0jAvCrH1RLqP3buSgDfOIKW1xc7wcPAuVNHUgowlEIK98x?=
 =?us-ascii?Q?WA8rCis/D8AhPeeoNgmRiuX83KznqQaOa5udks2818Rhgd+wfwR3oZFA3Nyp?=
 =?us-ascii?Q?cqjhhWVkxmMInQPIAHIqaYyQ727TOUoVQsVXx5rhFNkhDS1UxXbXgErXJbBp?=
 =?us-ascii?Q?yXLYBmV/CCHctlWGiqAT0WILu65acqPfQT1g62VBNZl8Ek+T3bracMyfTQO0?=
 =?us-ascii?Q?XYh5mkYMFtIOkFCODYycIsOJfbpI7iuc0LuEx/qtMv5obPhc0qJi5cj7v8LG?=
 =?us-ascii?Q?jaaCGDVfkhLU33hnlT+0FQAkGcJ5nZb17IK6LSZKtwfBf+P+mrSEHIan1n+g?=
 =?us-ascii?Q?N7ipaKVVRtL/whhQpRE4Gy+j7qOrrjWvrSZsVYci9PhoPYUHOt+MLM869AzS?=
 =?us-ascii?Q?MKB+8bo6OvD3ohzqBqJRQXUmcJox1MHetcBtaHxKS9WqL1NVJu7qXPhTuL10?=
 =?us-ascii?Q?yQOb1CsAL1ghXLIlP00PqJck7Taw6DZiK28VGCobCwykTAR3YidR7PvZgUEw?=
 =?us-ascii?Q?uXZQvNVxC8N993H6wCnc/1MFuDTl8HG/ZiJyIuFOJX/Q5N3iYPKgvlJ1Eikk?=
 =?us-ascii?Q?1B+xnGSd2T65dqYMgUr9EyJbvahVCFuyFJJwm14SEmkpD0J0OlXWZk9+Wizh?=
 =?us-ascii?Q?porZGMbbkS3egkyXb9NHRF1pcvLUbdaT9iT1FgSomEPO2BbaGyScSk6JZWgW?=
 =?us-ascii?Q?5yfFqyxoPL9eA7WNs7uNJ2SbjR0IbVUKZIoELpGmHfAp++gullnB3uQpWqam?=
 =?us-ascii?Q?rMVMdyl2Zx7G0rarPSZf0MejQUm/pV5MyxLjaDrp9IMXYNFgxmVN0/YeQFH7?=
 =?us-ascii?Q?xXfemYfmlbKXCSu//IdnvVmUDoMa06hUxZAb3sdLbgL0BUyztN5H5E49MYFh?=
 =?us-ascii?Q?erMYpvbRaTzrqAdvlQsPQZ09HanOoSQqu+FW6wGUo6eu4YVkAD8zb+Mrdg3s?=
 =?us-ascii?Q?ILj6Rve8tA7xsYjEBc4hOmuqXyZMHc4DRF+c7M0a+GmHV5cOHxC9p9N1/8hQ?=
 =?us-ascii?Q?BOq4af1kzs6SkCyoz83OEitOYb3pwNzb5xxsQr+OZGPxWu6PH3m6nwYPeESe?=
 =?us-ascii?Q?Ryg8LRoU6gcvxbTBY1Q/4+IRXNLmQEtcIRunEAwB+jTFNKVlREAdK0t2rbYL?=
 =?us-ascii?Q?w5cEyFbq9ch/Nq97m/ikgmM0XWeb7X7zVKgY8YQaRW7L+KLnNmK+lts/6PkV?=
 =?us-ascii?Q?8i9uE9ZvOTnebmL5mK4zmTNLo/b4iCYwEs7tbnGeOvYfEjZ3kSY1+uLPTvbv?=
 =?us-ascii?Q?aDbb/T1lfqWDz8Tpqp34cKXJZTbJEi3sLB48izAHvlyDk1udRAJr/9cwJwhs?=
 =?us-ascii?Q?V/W8xJ9L/u98JmH6+knrUqM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7907ca1f-bea1-4da0-5f79-08dd734bbf23
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:38:52.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6gDUXwj6tqEsnOwU4PF8vqSYxhkWJoLygMm27RYjJ4ZZEiGLE4eCSIT+zj6nM2ObhauoBK4nGYVaKHcmMlPxiondpxVhQ7kIBZ6k7xOTzj6LS1XtFOtQE4TfTDFhA5f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18467

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c1f39c62eb09fa2e692a9377295ecbd0740c0914 upstream.

Document support for the I2C Bus Interface (RIIC) available in the
Renesas RZ/V2H(P) (R9A09G057) SoC.

The RIIC interface in the Renesas RZ/V2H(P) differs from RZ/A in a
couple of ways:
- Register offsets for the RZ/V2H(P) SoC differ from those of the
  RZ/A SoC.
- RZ/V2H register access is limited to 8-bit, whereas RZ/A supports
  8/16/32-bit.
- RZ/V2H has bit differences in the slave address register.

To accommodate these differences, a new compatible string
"renesas,riic-r9a09g057" is added.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/i2c/renesas,riic.yaml | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index 2291a7cd619be..91ecf17b7a81a 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -15,14 +15,17 @@ allOf:
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,riic-r7s72100   # RZ/A1H
-          - renesas,riic-r7s9210    # RZ/A2M
-          - renesas,riic-r9a07g043  # RZ/G2UL and RZ/Five
-          - renesas,riic-r9a07g044  # RZ/G2{L,LC}
-          - renesas,riic-r9a07g054  # RZ/V2L
-      - const: renesas,riic-rz      # RZ/A or RZ/G2L
+    oneOf:
+      - items:
+          - enum:
+              - renesas,riic-r7s72100   # RZ/A1H
+              - renesas,riic-r7s9210    # RZ/A2M
+              - renesas,riic-r9a07g043  # RZ/G2UL and RZ/Five
+              - renesas,riic-r9a07g044  # RZ/G2{L,LC}
+              - renesas,riic-r9a07g054  # RZ/V2L
+          - const: renesas,riic-rz      # RZ/A or RZ/G2L
+
+      - const: renesas,riic-r9a09g057   # RZ/V2H(P)
=20
   reg:
     maxItems: 1
--=20
2.43.0


