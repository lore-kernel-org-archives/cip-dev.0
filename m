Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5489CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:04:53 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.web11.863.1755705887237728655
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EypSOG23;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn293QNySa2bcGKNkECy/xWYhx77dnR6OPKcWpVoXu57xEA4apFOOn7Plp06RQ3FPinZ3tTLHWJI4EaoDAFisF0stx2dgCSjWyRBfXXdpcqLqNOD7BvzN558UMfp4dzObNehF6Gp3yUdETmIZMusuZ+o+PqOaB+a2zxmIYo5iU57PTc9lnInHl2m5gIFvbbKX33lqJwtpf4cqSqzVrbmOapOtUGueLd63+DV62tr+L29v7Y41J8ojqUEk/HtbbCnLYEKKs+RYtVwDHkmWQZRhtQUJvDRDhA4uP16NxzIlBFs9p8JSxW8Y1R2QQoKDeB/9LFqHehNPancv+QDMcn7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TpfW2uDtBXyeeMuCo+nLUbs5mMOX0zMuf+mCi1zcdY=;
 b=yjOKDZxP+MrpXkAWn0IzqU/G+XNQvlzyQ62Xa7rKN753rmU4vLNie7LZgt1tu3f+OFW2STP5oRfKyN+2kV0f63KNFT8NYlLX0+euJTUNoVqejOa+CuBcXj7tgapRxeeT3iArBGKR0oKpVDfYZkuONJgLLo57hz3rDePZHredy37IG1f48r0un66odghZfHcF2XG0xnIUEMYEilaHyCJmcce8KrmOe5QT5peCmfhLIef7qWkQVuSUkRNK983P+inw/meFokQFVEgnrK3g+GysRJL18AJmHIC9TGFlFKOcpH1LqgZV7iDSuAOkwl3NGoDppBrH8vCelhS8k/eYJxneOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TpfW2uDtBXyeeMuCo+nLUbs5mMOX0zMuf+mCi1zcdY=;
 b=EypSOG233W3reWiC3BIsY315BAtJeU0cFqX4lKMGIxlqshbyadMEfKM1TDkmPmHKTOne8eUu2Tigk5Z93IYvDfvKm2E8Re9ErLUfxdraKZww8A6Rcg3siDxLxLIEcLeDqI7Ivu03gQw9vpm46jP8bjYNpxReX1VfgcmdBe9Gkp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:46 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/55] media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G3E CSI-2 block
Date: Wed, 20 Aug 2025 18:03:18 +0200
Message-ID: <20250820160413.801341-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a08150-1a6d-4fa5-ddf1-08dde0034857
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eq3FwMmmHUJjJAstAaIRCaMLrtGpbi4RhPMNqb/fbWTKlvP5FyQcEMqhzby+?=
 =?us-ascii?Q?7lo4k/J+PHuEscQIfXyTUxPGBB/2KqZqiKUxAL/BGlHB/178al368O8pNsgq?=
 =?us-ascii?Q?MH8/9UndC44vnEi2F3qGZrAPAAthpRj8JfUkmmBNxmoHVcucGvulbgdbTDzH?=
 =?us-ascii?Q?2x8ZdrmTvw+OnnWbG01R3sXC2fFqQdXaS9fWMTTWVkv6K56dLsX6Z2j6YAo9?=
 =?us-ascii?Q?wGisYVR7iSuN7y1vukaczfHwaGfGj/lT86M5XB/XYXuwlH2kq0QFt/fo4i5b?=
 =?us-ascii?Q?3IE1gz7a0m4KMGIYaUZUNl6lPGCUfbMLFT0EHQruy6irYOBlaLHLMe4MVQ4r?=
 =?us-ascii?Q?wvb4xRxhwCyOT3aCY1E2fqvHHPwZIrA0rinCbh97sviXRGaTsR+isgkLW7Cq?=
 =?us-ascii?Q?9TU3zUiBbADqy2FkKvczvSJajbbCZGvD/EUPVAGB7igiPyTUHi5IXUlMa6f/?=
 =?us-ascii?Q?fgb9j7bbgA+oz7qfsjJ4eh8XFy21v7EVIxDjZnk0q/a0F1bcjQZSLlS53EF3?=
 =?us-ascii?Q?lW0WTOmrVAuAabMc7zHUEVuAlqaYjLQSSBrNnFKbJRrYdLDUM04gf279g9Um?=
 =?us-ascii?Q?042Gwd6s2kFZB9b6SxHcU/0RJd0H7+zJPCUDzCoc14vWiOkyRrkukAE38zqj?=
 =?us-ascii?Q?N9ZwVyJAyVj7zaCQKopCzAdm4hWrCJoDx5mdqAq6eNpbfUbR8GgGD1eRY1gt?=
 =?us-ascii?Q?cBrNlkSUcw1s36Y+g1MnKx+jkbuIX+SyhBiv4VSvbduyn0CgLMMdyBL9fJZq?=
 =?us-ascii?Q?U8py4CwtqKgWhIsLrx75BnOTW/JkJyqENKZC4010fRN/hDunhCzKeEiW0Nw8?=
 =?us-ascii?Q?UZVLd6ZZnR1ItV9apLTAhCqhi0bq9GQ9fnDS5skRin/Cwd5Nn18i4E3YsS/1?=
 =?us-ascii?Q?hY6GCprBEwoR8rV36e91iUlsywOmE7GYLSPPr1icdxMrMn3qvJqUbxxnrJ1r?=
 =?us-ascii?Q?1l5AaTit2zntH55eDVDOqVPtTXaXE7oF/h4Jq3t20fE3g1Ij7TJmntjiqUpC?=
 =?us-ascii?Q?4Kq7ou6Lc62xgs5eyrFNCPopiMqr/G0D4uHYLo2JpzWsVAh3JJllZjwSWmoA?=
 =?us-ascii?Q?IcTv6PxLi1a71QZrK0Gho0LB/tFN753LoqZ25SqTInhtVRou+UKIJKaOrq/i?=
 =?us-ascii?Q?wUzy6QyUxgc80pI/FxZw5yOOrlbsRXhKbpUE+V20+ePHCLX9jkgahHOQsj5B?=
 =?us-ascii?Q?Ode9O7ntJ7ob9e1mLvOW8pqsSYNuOePHwrzkkc87K6VW5+uW86+huz7HHat+?=
 =?us-ascii?Q?wat57upy+6YELRqsnMP+DQ2jc1Mg6CnoLpTw5BxRayNjCLMHKPtMRyBHSJRj?=
 =?us-ascii?Q?C/qoVbQQpFUAZ+eg1vrDl9Am2P1oTkLA1cPCBWCnCEfRCHd2FcF3Vdle4b/Y?=
 =?us-ascii?Q?ChZ9ktDRyWs6aCEnfkILtgoUHeWXZ7uQKnjx9TwQ3BKOASHUTKj8x5N7CaNu?=
 =?us-ascii?Q?EQXo3Rym6vNAt2+z4y5mVNGuQdScF5EniqEAak0fSnDKDNAfnfZdt2TIkLpv?=
 =?us-ascii?Q?2nKkuyFuD8VLFok=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GWdda0NfSrMVvuj88liW4PfR0tloZiUMfSNiZDqo3MgVrUaNaLZA1GnalTGw?=
 =?us-ascii?Q?JFvTzjk9/MYHEo6Li7HiDhPk1j9NDzBz99ksYJKzwtrui9+xK8REOeVLgulv?=
 =?us-ascii?Q?i8I3oxoAkaIXDxqkGl22BzmX5Xg+opJdSYerKdZgu1UcEK7TTWpKP4Xwha2E?=
 =?us-ascii?Q?OF0W4o1bHHEeiaQ0pkMAal7LBhUqrkdHp805dJkIiEyGO4bb8/Sqx2tGD5+n?=
 =?us-ascii?Q?7TYOXDdp8Y8IAsp7nKDS+Eyy562ieAuFoi4pWH4DkI8xUdK5ZyzU35cSHtea?=
 =?us-ascii?Q?Yc2lpwQB9X271b1hDyLPx0JuW7UtpqXU6isSDyagU/HuQp4/4qNEABhAOVsb?=
 =?us-ascii?Q?0tw/qYRXa4C+ggkO9gTSkohKhRL01u+/n/3QXko1f6EqCViWgbxlQId44OrN?=
 =?us-ascii?Q?hZA9trlmc67eVgGqJ3esbcls5lF2hR5sT97nnve6E6rRzo1u5BsuhWxU8W3l?=
 =?us-ascii?Q?kYDNhZ9tjOksCoowD08bx5acXVkqOGnE1R9GOCOX44n+JDRu++B+NcVyzdGZ?=
 =?us-ascii?Q?A+Tinn+0Uc/573vgnV1JWUw89OtR5Siz4U5u1huTQWxhKO9LiMCnK3fsgU8T?=
 =?us-ascii?Q?1ycNvkk/fKK5vWmeS1PRch/wt79+9HR9h3ibJzmDBe0K47m0MzdSNSblxn6I?=
 =?us-ascii?Q?yqYkBEsbxM692hw4G6Zfium8golm01Rjqase1+k4ljJIWQ83LBKpVwVZRntE?=
 =?us-ascii?Q?E4v/jWNUjsu1fQdMbtLLvIkou+Z9w5rl/uDIvUXJtcOVXRBGxnmyP25/+zro?=
 =?us-ascii?Q?6yWYibRLxQYri27PHAbtg4cia3ICXzpxrJOW1zv0Jm/6cb68kk/95mRZRMzm?=
 =?us-ascii?Q?1NjP4z4Iyh/Mo+T3KHL/sbiQwA9QxZBRwMFMp/x+wqeFi0UrFbushIqw/QUb?=
 =?us-ascii?Q?ZEq4vZdYgwtPGfPG7a26ujYY/oLiEcG8X5ewWY4BCUmcyJbvGMMSpvXxWDQ4?=
 =?us-ascii?Q?tf3QzV6oG8FgaSJZsxs83u83D6gvMayUjfeWEej4KRYgiloTmWYN0fgL9En9?=
 =?us-ascii?Q?cCkA/mvYPMSQ1W+INYMShQ7I6Idnp8FMqhlubtvpE7HRVpQNN2LZoV8k1aV/?=
 =?us-ascii?Q?jFXms1Zv6oNMefldS6Jl4rq7ve8FMj+EFjOpaWkGYfHMQBCe7G5bcNEgOqtu?=
 =?us-ascii?Q?oF98ApA2+282ZAFfK+QTws3bUXVCi77dLGAhsDLyuSlGsqLsArzIaaVYyFfX?=
 =?us-ascii?Q?Zv2O30aRpL766ftVqJszlf4VqT6dNS8KPvhRuHVoHmWyUqSEF1/7EggvIUGF?=
 =?us-ascii?Q?gwwe8JfSCw3YK4896UBBJgEc2s/0RJS4oUp1fcoZ+HTwkjVo7TN/L4Cmgr7/?=
 =?us-ascii?Q?k6CzEGEbD8SONDOU0QCea2MnxF1BZNC4F96upy+mntJJptdEToyiBirohXpw?=
 =?us-ascii?Q?Z5W8YodzO3a043bUdCtBaOUUwqSOkt5m6KxKweG26RbS2XoaEflTQrrflbzq?=
 =?us-ascii?Q?hGndcGjuGvc612UBUTURKjwyNqvd+ypuhhJsk5bJ4agYnfsu1vtyhB6z7lGo?=
 =?us-ascii?Q?N5G1Po4TxscZQWzonUTEJSmMXc89C0P+2YMl15lvtpdFcBbdO7A281p4fKEy?=
 =?us-ascii?Q?TRRSY6FcWoKPbnJ2umgYNKquIOWQpwEnplBRadTqo20USV1z1aYsCoOvfCmv?=
 =?us-ascii?Q?rd+xc3O+TkEvOJloHnAhf7A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a08150-1a6d-4fa5-ddf1-08dde0034857
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:46.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv/seMCIqkQATULfXzN4/hXriji8VnzTVyQdVAm841+5HGWlQLvmVPBc2Qc0nzLc8r0sqJaurf9l1WvZfogRxusgTV3nQmnBRHTQIlWyoKINqpcasGnqwJ/MruH91wRL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19827

commit f1c83d2f2841e99f884104e912aa20fcc32b9c2d upstream.

Document the CSI-2 block which is part of CRU found in Renesas RZ/G3E
SoC.

The CSI-2 block on the RZ/G3E SoC is identical to one found on the
RZ/V2H(P) SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-3-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/media/renesas,rzg2l-csi2.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yam=
l b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
index 1f9ee37584b3..c5c511c9f0db 100644
--- a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
@@ -24,6 +24,9 @@ properties:
               - renesas,r9a07g044-csi2 # RZ/G2{L,LC}
               - renesas,r9a07g054-csi2 # RZ/V2L
           - const: renesas,rzg2l-csi2
+      - items:
+          - const: renesas,r9a09g047-csi2 # RZ/G3E
+          - const: renesas,r9a09g057-csi2
       - const: renesas,r9a09g057-csi2 # RZ/V2H(P)
=20
   reg:
--=20
2.43.0


