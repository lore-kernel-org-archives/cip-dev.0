Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D43C36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:48:40 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.2])
 by mx.groups.io with SMTP id smtpd.web10.4019.1742377714365169766
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MMAbd57d;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmyBuNMBvJZI7Dxr1pnNdzo/yEtxIVth/epBUkyOUvtQU3OwwVhByWEev/l84fKCzV2xFYDnPvB/Ee0fiMwORn6OmtzXnqN5Ta/+WSc1K7M4kxcgKCwqK/yCSBgUmLHeTz4/ZIalDkjs/Milk2FZ6ED2iXHXHg8qQnJDzM4L44ePgfMjURCggibnh8SDN4vTl8u1mSBsuUfiGrCLPQFWpVa0BF7bIF2o+uSBv/z2zZRIGh6z6XzGdu8aycQ1ZHbDD5//adjSE9RSHwELmyP2H03YmylrcuFpl2ZsROuFpKNBUDfwPeeUZCBT/BdQG/wqkP2SIJ2ItLgGGaiy4Ys3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH0Fnv9nMLVVRtgt6DAW6fxpEit3etTSgxoE7zxbBv0=;
 b=lPMFkGl/OFJFki4NL5j/8yWR3wxgUFjCLxZRmXQ/xuIT5NwqtHsP5aBx5WEV2GlLGHe3NYWK7Cf4W2FRhxMXlMCuG54OONzfmOanzsy/wTUMNs28htJzeUncWU6hfCbmVyJlvVazV0iDXCw+YI5k68gZ+vvLhQO+5EjdFIspYdUPrlYqQad8q9RtKQ3vqq6gZeg8YeWHQWqFIqHZntLqph5hgxgcYZDgZQKO+o4pbIgOzK+SGNjqUpD38srzT5EAgqhy/9kN721QZhqLJoxV8wl/nv/KOBmT7QIa9l0tZ7jdx/PIb49P3URGbT8osAfKVpk6+4eiTjYgZz90QB346g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH0Fnv9nMLVVRtgt6DAW6fxpEit3etTSgxoE7zxbBv0=;
 b=MMAbd57d+ORFuQxjjpvH79ey83RoJsFZCiRIXH3l+bg5SyJxetq8jtBaZL/XSeQLZs7dZTtXoAYLu+TtJIXsSj+dUQ69HmpUmlkLx+iLS5X4ALGn1W7YfW2cCp/A9NGKOHv2sNLdVqrj7xJtLIp/S3TyacB4Ctrzq8pBrpdaWcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/12] dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
Date: Wed, 19 Mar 2025 10:47:43 +0100
Message-ID: <20250319094754.2404386-2-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c1da234-a2cd-459f-51c2-08dd66cb34cb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZVmxCDUKcU24urEz7CWvfW8vPPejNfjr5upyJZcJtVNDVciPXbX3IpsPS8tx?=
 =?us-ascii?Q?42mm4Q9gHOBXQh/0X8K3tWlphuAK1goo4qcmyjLp+7hP3jyLr3rx2OpiHEow?=
 =?us-ascii?Q?tgx1gVcjHjA0E/BH6tHkYSE0BvMb6zNSLPyAQgUiyEUvsHEzbIvu6wZI8QOl?=
 =?us-ascii?Q?64Ii0yHwDL6GNWazXAmaJgrcEqDFyV2DORlfDDSvK01AcP5TTXBLM23uCb83?=
 =?us-ascii?Q?+XwzIjf194rGIne4+UPtsOYeKv52MGw/wtaWPbZNiqHz1xj2mIfiA14IR1yA?=
 =?us-ascii?Q?f1h6iYLACuuCy6TDbNN+oVc8E8SQzFosoNSYQBbb1B6+KsTlart13SvDBZBg?=
 =?us-ascii?Q?yAp9GOfyHMda8Pgj0SCQLSf5A0+zsUkzDIiSECoqUt5HASmfYA49wqhIhud1?=
 =?us-ascii?Q?7eGSh444LNoFml3BRft6pQp/60Jr4lXEI+sJa/CyCR5QFFitUzWWaRDhzJ30?=
 =?us-ascii?Q?TSXQUK0OVtDODTyMgOudVigL+V1FSETT7h3jBa/ju+RVcVT7LB80TlvX6nqT?=
 =?us-ascii?Q?gr3Y3UAdPmAof1MV1s5eK45s9HDAeMoB1rsUP23zBC5jdI+0adX6SShhJL58?=
 =?us-ascii?Q?YLmktbF1NJci9mOj3gzYicMuXmG/X+vuzhHwcblf2+lTNoqJxpXfBgwdbEIJ?=
 =?us-ascii?Q?N7TOB3OA5CKuR5tKr4982T5IIA+2I0Svez+PLztxiQzY2myiyDNVg8oH3XWv?=
 =?us-ascii?Q?XZwOKreynMLHGYBne3rCIy05Cz7dZuWoTf2MlLQOToKt57pK43tia7vc0pCM?=
 =?us-ascii?Q?eQZgofgVXCsP2sHBv+vfk1md2FNSk+ikTLX5Gl9x++UvK8cgK+64GTKx7TH1?=
 =?us-ascii?Q?PaEmVoSJwXp5+jc1tzp9sBTZR6IbjDZ0EZDB4P244lKD0rTmMSUTLvCzkBa1?=
 =?us-ascii?Q?BxiHfPAX5g4QpGRpXruxW5CohX+UhzdlmTCsUmd+p3gePje4ASAZbisjNhtj?=
 =?us-ascii?Q?9FG62UdrjunpeLSSkipwprKf/Z2VmQwl3IQg3BFX28wbgIOBXxvYkH1q3eUu?=
 =?us-ascii?Q?nvqxAmoPaiZtwNnqKxhsOF6blT3IDezUf05Q+1SFbMT9buKcXnhuNd+piuGB?=
 =?us-ascii?Q?xnJs3qI9lUpKUkXAG7I/nkqqkkzIUN6VedLNaSnKW+Flr+cqTZk6LfYUiE6d?=
 =?us-ascii?Q?HLqTcI1ECaU8b0NRbWpZRalCB/wLLrYcW3wBQrwvAl7FB2DyJxvF7L29gPHi?=
 =?us-ascii?Q?RiipEcR9Fc6tIGP8P7Rb5YpF7PGWXErjBIwly974ggXEPIyq4gQ9hwAQIhOF?=
 =?us-ascii?Q?RBb7yyNo114vJDq+z2hB1QuwhTkNKmza3gGwD6peF3QysXD+u0eH1g3l7SHN?=
 =?us-ascii?Q?599bbVCsJiZ9I58uU4xjia/EKpadMFop20RM2fktNNi9VJLxSvmEcucJSMp2?=
 =?us-ascii?Q?0zIyx4Ht/f3qQiALSriev+QhyHXfNMKSPnc1PZxAR4BiZ39NrplmH6YVdCdr?=
 =?us-ascii?Q?fcUzdx43h2IyTm9ZA1V1GMAJ7w/CiAT5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DrFkN/9taIut000Ywtpltvhw9lVr/HYyXmZN1BYHP20KRDcGBD41xXXjOMmY?=
 =?us-ascii?Q?Idgb5svSQ51Lkpmzd18I4wVFySOd8X3tCuBa5Wgb7OgMx6R1RZyP2HZOaDXD?=
 =?us-ascii?Q?fA6b5S0krmeXXBozTXc7n69xK4yage3zIJ+2BdszTIMbfCgdSDYSXEzytMc+?=
 =?us-ascii?Q?iUDFScLcyj5As/s78QM/RUlzLbca3bF/IkO1UzxgvoNjlAfKJuHlkNU3xess?=
 =?us-ascii?Q?TTX+thBAZB5jmNTU5+9aGAMk6blv9DWrRINV/nXGLtbIvK5mxQbB/WxrOHk2?=
 =?us-ascii?Q?YHrfUA2dFt1TYGPPtUgQaOQW4x8Omu0jJq73vKJO0mAhbT4Ip/G2v+u8n3IZ?=
 =?us-ascii?Q?oazMseUZC7dJyKvJDNq0NWQk+7aGfsh93SLlAaSUnqm7N/dp8AcxqbjdK3Xf?=
 =?us-ascii?Q?iAk1aU/hlQxzk++PvRfklbMkr8dKTd9uTijUlwnYB45siN4G+wNQZnbp0yZA?=
 =?us-ascii?Q?bTLjHY+RvIHjrk/ayJTxvPmFiZBdtqDnFBI19dA90BDq+oMJQFB35fLeKRVI?=
 =?us-ascii?Q?adG6begblZoGc9nwGaxs4iS3V4bRIgzDax/guZutyVIJAh5IQwS3H7Y2Bdls?=
 =?us-ascii?Q?llF0kqGkLaJSy9Ge3qFaINdLcjsMbjVmGhFaeRjh3jqL7lq2JVVNAWaUBPDF?=
 =?us-ascii?Q?qqn49a4brusqBx9NVPBnaSv6V2Veb72CuBRSqb5CcOc46XU8BXl42BSeGN9V?=
 =?us-ascii?Q?vS/20YQP30p4MYJBIS9puAsGvrjIgrs/pgCgPPIExb6z+a5aOqjEvBWvAW+X?=
 =?us-ascii?Q?E+b29NEBVMNC+/Myx7WsSqKMIdts9OwnShGgEiWWARBPLRy4JmwOti8inS1I?=
 =?us-ascii?Q?gCTcoRov75kasbat+58/bLnonCx9mZYJvlrtc0nNFn33D/hMbAfHvTMUWvrX?=
 =?us-ascii?Q?sO8rc8xxIIlU4ROFsd9cf1ZmTxxUufEZ0KkGAp2uS25173vkCrgQC5BkyfXI?=
 =?us-ascii?Q?l66ErGmz3u9ijUshff+l3vejaIaaBWvdBnNQpOi8b41zLB2v4fxSpiQw5FpG?=
 =?us-ascii?Q?Kn5/pTF0Sf56ZOFdT8nfFEoXENLFN5W3miFS10Bq5Cm+AvMroBIHtxjm3rqP?=
 =?us-ascii?Q?2W4QQlhpHlmt0kTkCgvYD6tIDKDNt6v65jtGxKRD6krs4duEQiva3Z7VerSt?=
 =?us-ascii?Q?u9CnaH3ZS1tMIjRdrrm7rk8M2YzHMyV5XaXCAMS24LoNN+l5SmGA/VFImd9+?=
 =?us-ascii?Q?uHEO3HB/r9Rt10F/bpdAId4y1pBn/IE16AAdu1KOY3ByVHEH7tsmkPwMD7YF?=
 =?us-ascii?Q?EEymFc7AImy6SyRp5pWj13QD5eC+BTroD4qWxQ/cHzgJYImUIEhV5rGUlbwl?=
 =?us-ascii?Q?XYxu8jehNUEBA7kv3EAv1RFRCoU2N2+wpulEBH4XSiX9+UdQW9tIqYWcZVuB?=
 =?us-ascii?Q?JprfY/apJhtgJchvEncIAO7nF4Q9CTZK1FF7Ec2mqtggw0Q9YoywYvgwfWM0?=
 =?us-ascii?Q?IJIZJwTfBQvCiTfgVpkdZ4DNSU3mcLTJWpTY1qOeP0Q+z9k0VYRrZ5hRuEzq?=
 =?us-ascii?Q?sCJiTaTafCFHGBEQsYbOC7fy4Y4FbdF1QhPgmvReU0rcdQWDauX4fqHCwWo8?=
 =?us-ascii?Q?s1QKWtNrDjLFhIdgjvWgIt2Irn3adGUYeW+rZ7U/uEHgYj7jJYtTeFSZZ307?=
 =?us-ascii?Q?scJ6IsjTtPEvE7s4PrOdSxk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1da234-a2cd-459f-51c2-08dd66cb34cb
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:31.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOMNDlCRJbx8UixF8wZlywj+N91AFtnbltIUS8Z2GFd44MAePZKtHBM2XYuczco2xS4oJhimROF1a3HLcxGZ+XIpWvUVTjFs/lcqNzfC+mJFA/TfNfPZN7PB55+Pn29K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18248

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 220fb8ff6d326d91fed8a0a44e3ac0a2f34d3f9c upstream.

In preparation for adding more validation checks move the ref for
'serial.yaml' to the end and also move reset check in 'allOf' block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240604170513.522631-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 1b5b6ce6de0d..77587b0c8642 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -9,9 +9,6 @@ title: Renesas Serial Communication Interface with FIFO (SC=
IF)
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
=20
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -159,18 +156,21 @@ required:
   - clock-names
   - power-domains
=20
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rcar-gen2-scif
-          - renesas,rcar-gen3-scif
-          - renesas,rcar-gen4-scif
-          - renesas,scif-r9a07g044
-then:
-  required:
-    - resets
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+              - renesas,scif-r9a07g044
+    then:
+      required:
+        - resets
=20
 unevaluatedProperties: false
=20
--=20
2.43.0


