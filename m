Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8541C35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:52 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.web11.67706.1742914600947369189
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fBXllIX2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE+YCXFb0jIJA4DTHvss7NX3RQDSF3lhZ3JjR94Qoo70BH9fVknxLwC4u7fMOef+2GzRdEifm4pFkv4S2tKX0puqPamu61TsqLd9Lectpm+1kwxR4hokyANY00o7DB1mn9rbrUeQUGVWVEAh7O5QQTvenLVEv0Fk7/Cy1kSnSNkd+A2NNz48cnTV3cjHIRksjAMJbAbDc23cdMAfVKEDbhLPHftJRTs598yJivGF5GtoTfD1Kcj/oOHsg4tBt09DjlFGr699sQFltHs0ZY3bZo/U4XzcgKNpxkFsiy2mSueUn807pVNg/phQ2y8LuF9kn/2aRbKbZj55XXaXGJQcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9HZJPGmefVxV3vtphoEAQAA5LOonB80d33iFifZ+4s=;
 b=d0uWfAZkhqez4IWOVfJ08MiEAXu0j6gZkttWZKlEbfHi5Y7ZA1bIAESDahzQYsHiL7HW/+sAq2jU9xMDObXXBa6rPk+NV7Lc13HESkcR7IphFos+0Fd/JAxAPq/calyJkPyFrRls6K8M04+qigUvIfEtpqFfJpjj/rknoBEzkjiP0Ec/n2V5ITAr+S6rP+33Zt379XhCasRw7etEnTs+7KcfCkXmXrjAb+C4ORabhOEP9nRo3Zrkolm/6K/wm3K1DYFso8Zq9dqa9HY4gioU1TJvD/m/aPnkvreQrGZwu1we8PYfJsOrd9axZ5oj6ExMqwNMFMIMkgbfqOhdKGzihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9HZJPGmefVxV3vtphoEAQAA5LOonB80d33iFifZ+4s=;
 b=fBXllIX29eVe1gS7YuN59R3WsItb0jdc/p7WSkeCYdIJdu4S9A52mMA6ygC/x1tvdpKPAAfnkpX8WMPuOmUAjJEs/dLvp3XaC51gJ3xHiSC+ccq179fvyCKwOlGS6TPAa6Yvu8w7VeFnK4lTI0BDJHtsSXDD/VIcC66+ue4ciN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:38 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/16] dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II EVK
Date: Tue, 25 Mar 2025 15:55:56 +0100
Message-ID: <20250325145611.3595454-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: 926aa196-d2e6-498c-4892-08dd6bad3f03
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4XEd8kfiTck7aWDhUOEz1zcDHz0Jl5OqnPA5GGkD7VsDBw0XmZ4yWwk13C8a?=
 =?us-ascii?Q?JuqEs0kWpRgomMoKo0p3I59/T80rYgwjRexRb5ZNM4wB0NHnlsiw5vQk8htc?=
 =?us-ascii?Q?cTbUituqdI/MXAA2V9snY8yvwdmhSoqDXhy/ZLczSLzsRa4XLD1PY1l0FXUB?=
 =?us-ascii?Q?3PHb8ovEi4o7ws1mDvOT7vaiCNif3Wv3dSe7+icQQXanRqWZtz70SSz4qDOc?=
 =?us-ascii?Q?iNP7OgZ4Kj3l+EepE1E2bfmlGxIWHhztSLiUYenzNQMjM8OgRIEUWi3ALnhF?=
 =?us-ascii?Q?XxyZBQdLHfz13ucZ4LnuAcO4Adp5UAQcTjmOpAux1JvwihS1KeeXuXlkveFH?=
 =?us-ascii?Q?5DB4sGCAYhs3QblYf1B5HZMke0OHSL2UtPHEb4O/MrRcyAZ1nuVexlN+4Mzh?=
 =?us-ascii?Q?4SgtMnCOKB6gAQ9fuR7RhBdyBK1TVnle1PyyBfK5A2z3FYPooS6sB8Cz8Y0N?=
 =?us-ascii?Q?PKfJARzCd8k8dL2LBLw1v+2p3Dgp+ZwXgbfO9M4+KRd0WgX9WcMmTqJiH3S/?=
 =?us-ascii?Q?GBmuuDI2IkS4d27hcWMiWpyhq0WHOX2zgdhtX0pIhxjiGU2AW6u7S6OuHoN6?=
 =?us-ascii?Q?mywt0fZkwiOK5/ai1q0RmneSQyOPyGMernxUl8qeD0yA0HzkQ5BVTBPfDLx+?=
 =?us-ascii?Q?tKD5Hv6nbmOuWm1QXMG4mBMT9whU/zgga4exIaUZF1EmBEwXpGvkkGkDG/pv?=
 =?us-ascii?Q?oG1VEfE/lmmlYwdExRPfCLUue4W+ElBjbGyNqCWk/8u6gPOOjGLmFuXD4UgW?=
 =?us-ascii?Q?8tv8rHazYpFwI3aoUDmi3DM1QK+DNRmU2pqxweAOioiCKUTPp9e9B/YlmtXl?=
 =?us-ascii?Q?bCEqzSgHLAiYNWb76deMQup26555jMo6pgwRt1TUxtTm8LFXAQUBDrfTddf1?=
 =?us-ascii?Q?uwDukqkiEdb8nUJUNpTb0Uxv51CFYUQKp/tnDmeGnfMzbC4pIZSk7PlFlw76?=
 =?us-ascii?Q?CEC9vFUbY24R/ecggHr2JZbBPCEVFmbtxQcpfKnSB7wtV/fuHo/D8F96qKoo?=
 =?us-ascii?Q?cYF76elxEvBkxlM2BMcKNPQUlyElpxx9ohK2x5TNh4NBDs1DfS6flz7ydoD0?=
 =?us-ascii?Q?81dFDf+1Wrx50Og9mNflTt6AubjZlcYcis8Z1VYqkEWZb7AaS3xzXq1kUKg6?=
 =?us-ascii?Q?WO9fLjTr53qm4I3sNRv5DigUgOZZijdLhfz9nGuWUpE38EY7/daEhj3f3NUZ?=
 =?us-ascii?Q?gn4XfLomAsvY2rFutLkXM0KEl+hF+jlhgo2SKx/JSwbcLg4Kfj+Y8WhRexsB?=
 =?us-ascii?Q?D1jB0+neHA6QF4sORx4Y2V0B3Nzy1o9al/MtTs/xONSArn6SkiYcsea8+l7g?=
 =?us-ascii?Q?eZeNkv7uKqsjWGBWvFaJ6ngockFHG5Td5K8A+YPTNnSDlkA7wg4voe+wIMxT?=
 =?us-ascii?Q?n8IEwPt8n9MFuVDXEm3+I30epoFD8Qp8GY/1BQjWeT2I4UOgtpE6uEBMO9cv?=
 =?us-ascii?Q?6PnkFLAVQjxJ0egzVngEU0qLEMn8MX7Y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PnH+RgcgzHLFWIEBjoYjjja4rsJqSJnqd1dGlJUQ0tOVRxgy9PaywcVr77cA?=
 =?us-ascii?Q?JiUD0waDmNKiBXvsgUErIn+8nbjGTZE6UgcY4MPIzjZ7aCbhuNEY4BcqUmal?=
 =?us-ascii?Q?loPzNoGmLTnYZTuGXkRLTbnY5fNb+7Bgu5gFbb3HttQBz0y8vHil+hMJid5X?=
 =?us-ascii?Q?7fPigxSmfqNfGoSbHIM46V3kTFkl53GJbavZalyH7eI++mY5gzK+3uoKSJ/2?=
 =?us-ascii?Q?dDOQ8+izq4TiMUdXU0vuICnh1vcoqTn13a9+OZ0RBO5zC2WV60kaa5nLahSc?=
 =?us-ascii?Q?dog4xb72NPHKyo88w9wmfLKJjwHfVWcKCJgfSag3w2svZtNz0b7e7pBUtjlh?=
 =?us-ascii?Q?hHasqo34k6aBjbgWYgKnefQqsIpwk8iKfCPuKo4b839brj2jSDrpgLCAfV3s?=
 =?us-ascii?Q?zYlXQYPwVc4qX4Jydo+yI3md2CRInMGXTgDvB93n24L8bMobNj0eTgQBAoMT?=
 =?us-ascii?Q?DUy7tMzuIL7LpT7Ci74xP1JoLpy3znq9k13p2uZBax89wQgtxCohOfC7urpN?=
 =?us-ascii?Q?TmOZiCdc8mVzDOqf1u8zkuREUniqYIzoCIx7xTfGnDZYSBJOkMd7kPXBKwvk?=
 =?us-ascii?Q?YjAaP9TcFrLe/rMbtea+GK4mBPEs4Gy6ObKXeSurCJQ2a4hv7Kpc6FXyDa5Y?=
 =?us-ascii?Q?HhlM3iRjC386NHlRHmW1f7pe9PZQKlhJYeWcLFmSlYUe4vJShaJrr0M6PPDv?=
 =?us-ascii?Q?DgprwKqVt2ZvoClP11YLXPG94jKllYi7AnuNFSKAkfVte+dI+6PiL40UkqNq?=
 =?us-ascii?Q?09uv0OXG4SzWenSS0lINTU5ICD5m6q8qtDO18bTbLa/TxFferV+b6JU48d8e?=
 =?us-ascii?Q?QPvrtysCeEdDZ293ZQF0U/BEXMFFaKmQdjZxGivBjwYy/IOx476hZ154twlh?=
 =?us-ascii?Q?QzGlJxkSmlwdxE2grjend8P+HZ5uRYqMyUikOeeSDjUAzVIdlOdPsh4LMYj9?=
 =?us-ascii?Q?K7wfnhQSnxr/oXSAyid/I07yDuKF8EJJWJaWX8UEo3yt87CSCOGrBtJF9MnX?=
 =?us-ascii?Q?xAqzYJ9cwSOR4dGI88+7/JVeyMGZ+JxZvFXmspKMUJzGkSZLDuJDPboBEqOZ?=
 =?us-ascii?Q?PPzFDSrcEhlH8AyebFGwAKmcB4KxKPBgnvd/O+xwMWzxbf8XWRLSD4gFYuoQ?=
 =?us-ascii?Q?8gugD0/h/xVwOqGLrWTTXfkj4QA6hhAHGLVvHqL4r8gG9x9GWUMLNnjf4C/Z?=
 =?us-ascii?Q?sZpaMBObi0ZqDwDc2wRO5nXNWZWvy3PqXr5SebMdZ7Pk7RtNFYynR12/mSbP?=
 =?us-ascii?Q?gmqbqq/agx5GhKNop3UEVwcA81RDjAOyOwwhZHhSj2ij6iY4tYOl+rA2r0K1?=
 =?us-ascii?Q?f3ZdOT5XrqVD9Ux39yRGgDiXVu7xUN3Oy0c404JrZ6h3KT5GBAOEhfXTgPey?=
 =?us-ascii?Q?UvjVZF+w18B+jteQq854WneI3Hm2LwQYpnTxuWBehIhdWxmUTtfh8qwT8dP0?=
 =?us-ascii?Q?PdhX0q8BU1wh3Nv2MjhVMLORqdHP0TLrsgFGe+7K04zN2pcklO6PIUQft3PO?=
 =?us-ascii?Q?9ScWJbGKWtBerDDagXv8ldFTdnXtAXjY+liWhNVetLkkp6Ho/LyV16vvdisA?=
 =?us-ascii?Q?1+1OsSWbj9BEMGbWTMmRFRit/kTr9V+JyvZ+wISIlvUDvcxce3Rp+E+HzSOq?=
 =?us-ascii?Q?jXXz7FlB1BAgBmj5sPRd36w=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926aa196-d2e6-498c-4892-08dd6bad3f03
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:38.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0/h/9A4zj7aDr6iUqj1ka2BWizDqmJNVXrMyncfP5Y/RFfXn5f260Zp5Noe75XNhD9VKoUI6rlbTZHcdjjz8RA9iinHPrzRHYZVar6y+ST9aP5txb5JLBm8hN96cBCh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:56:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18352

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 2bf1a3ca1df7ed93e5ac82ff672753a4edbb6e80 upstream.

Document the Renesas RZ/G3E SMARC Carrier-II EVK board which is based
on the Renesas RZ/G3E SMARC SoM. The RZ/G3E SMARC Carrier-II EVK
consists of an RZ/G3E SoM module and a SMARC Carrier-II carrier board.
The SoM module sits on top of the carrier board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/D=
ocumentation/devicetree/bindings/soc/renesas/renesas.yaml
index 984718402d662..8e47f36bf4fd6 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -537,6 +537,10 @@ properties:
=20
       - description: RZ/G3E (R9A09G047)
         items:
+          - enum:
+              - renesas,smarc2-evk # RZ SMARC Carrier-II EVK
+          - enum:
+              - renesas,rzg3e-smarcm # RZ/G3E SMARC Module (SoM)
           - enum:
               - renesas,r9a09g047e27 # Dual Cortex-A55 + Cortex-M33 (15mm =
BGA)
               - renesas,r9a09g047e28 # Dual Cortex-A55 + Cortex-M33 (21mm =
BGA)
--=20
2.43.0


