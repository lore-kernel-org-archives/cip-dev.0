Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F907C35FFC
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.48])
 by mx.groups.io with SMTP id smtpd.web10.34495.1741778820913791453
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hXPF4By1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKkQERkvpWcY3n7A8uvdS/FhZ3gOEpXP6j+HsTgamdzp6jEi11tB0E4MT8g3WdnVRJmZIQbcLz65Dqt65EVs+dhg6rzTL88tXu8Kx5SW55ouXFhzFXQEVNlmiKnzVWv2IOKO5g1pb9ImSaIVkQyUEu012boVslOLE0GjkB6oSCWoYs2YrGBRqW1Ys8KCOpnj+xqaBL++sOP4KpA4zqVd0X+X/Mc36AMA3vvHlmpm+GlYbE5c0kynDl8NzUjRlGIorYQCdUCHEHwlsZCMK1Ehg312k0RB1ldmpwhQcUztAcJntXX34XTGIDWtWUL89ipmAO7WWFQ53JDwucnJXIA34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn3EIYslS8Daf/EyHwyt+sFcZ/vS8ECK8aXc/wyqXnw=;
 b=d05SOSXo84RnC4bAGcG1WGPysaWEK9mrXtF4ejCNIe83VQ2X5WM61T1UVxzt4xYCpgD4A6UrfvvHzxaiT7VK5DVe/03D1YHUweQXS/GcuELMNqAh3LF/LyW4QK9mQtFH55rxqjCWsn7nguJ6a3rmQyjn86xybBoDNw+LxHsTaugvvUrl83Bv9KYg9BhOlfmt7xfVXYFsbRQgr+20qRHNXY+NjnCLre+YBLOESlGnIDLoVYQJwGCxm0+fW4/9g+qayPdzNVi5ruuHDmbB/gTojwtk0k2zSleTvdCyzb/cWCJpAvWKx1x/7ARlOLfVSZyycx3u7bxCUIA2NXGr9sqIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn3EIYslS8Daf/EyHwyt+sFcZ/vS8ECK8aXc/wyqXnw=;
 b=hXPF4By1mb5Wu6FMVevcGXxRydq+OUn+F/W2MuFt5lZpBD2A1+DSv9GmKv0x++gCtMXdVqV+IQtOSnql8RF/e8ycn4kn3DrJ5qjJWsAXOrl0TZ3ZhFgcRBNZ6JCbsNjUfFqCc+DbGVvmwZSEQcBieuE9Tdc7gKD1foLiR0r2Ht8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:59 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 69/85] dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
Date: Wed, 12 Mar 2025 12:22:46 +0100
Message-ID: <20250312112302.1605750-70-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d256f3d-7250-40b1-3dbd-08dd6158ccf2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mKPrBXQn1zHGDdG05Y2hYMzEGdUqiT0i8GBLA7IcxJlLmccIzcwSHcGM7ysp?=
 =?us-ascii?Q?qGpumw6ZzFTSm7RAF6HxtqhQb4RcTxQKePRdf5OWRADmOVgKfhKGgYk2eD1P?=
 =?us-ascii?Q?mSVhj7lHirv4USj1IW6ftzpnlHNaOpHe3u3UND2yrziH7mkIj5qxesw7Mw9w?=
 =?us-ascii?Q?uqxKgV0+NDVu/rVxQ3z87cK9xKhKQ93jbBkLa2RLEt77NVc3npgwi57LIRY/?=
 =?us-ascii?Q?SqgRfLzph+4vNH9yVb0kYfFbgbOzLkKadyjopZkLMhdkEM3YCJm24/jJc6bN?=
 =?us-ascii?Q?ItcG7gVWRhG72oLEkHFtWGuBlUIqiJsADpGr6yfpHvyB1sN8eMyyA2oM2+pO?=
 =?us-ascii?Q?lU+oqpO8u3WaZtgviScv9NakhWE7uAFn2IC4+zqglcJl2oWPDsKD3nKhfI4a?=
 =?us-ascii?Q?ihnaWbZLyyJSDa9eeia8BK1AloSxrzcv3z1M4AcNOlRDg2LSFZVcC2kdjJNk?=
 =?us-ascii?Q?3Ws2L/QevkSpIe9mSSPqYrNCsjL4AwD+qb0MCrlUM9qIJaH54ro5nvgKWwV1?=
 =?us-ascii?Q?Cpf+QqQIwdLlqO4u9iCq25HnT2LEmlW6Bb9BLurTiKek5H5jTeZemWAJqK1H?=
 =?us-ascii?Q?AwyEeCdrfqe9MrcME4B/f1QRMstfcebwHR8NGu/u+T4i3AfuNpsZKCDkEjPV?=
 =?us-ascii?Q?69319hpOSdaFL108wAhFi9H+qsym4Cs/SCSwa9l/SVO0iQRozhqwnuoBUXHh?=
 =?us-ascii?Q?ylDDLTSA0htJUsccDaLeZLS6vZWg6V1TmRTw4nJf1BKprYCIW3wWodWu/070?=
 =?us-ascii?Q?s+J/Lgxmr1Rq2ZqiYMbsiiGXUlY2i8gK9xJxbrrKbzxjyI7s0lM3D5MYfFXH?=
 =?us-ascii?Q?FjY1bhdQEtgdpIDHkcoskIyHSdBm1Umhw1tUBZEKykxWZ2yLO8CWJAvJvHso?=
 =?us-ascii?Q?ZuUXplucKfaZvbm0PZDP5Tf6NKGaWfvvr/3OZbCZb9i5fMPtjY4EKzC1u63Q?=
 =?us-ascii?Q?J3AiOSiaunKU8KqZsdv2NiP/t800ftmaFwrtHfYmlqF9VOK89Die+Hxx4FWe?=
 =?us-ascii?Q?AAmxUCrlffD3RU1pm8Mjsa27bFDodRoWQ+LcJCG9F/kGjye2rOR2jU3sRRdc?=
 =?us-ascii?Q?GqvX9o2k65ro+HOBWtnijzfGOuDneTblwkkrvU84aAU8mvxumuts7icFl9wK?=
 =?us-ascii?Q?fMDKiv4fMESX73CPbun3paki2O+POzIhyCxfSRFYhjMz8TfzH0UNqswyzHjn?=
 =?us-ascii?Q?b1jRJpRAJOV+b7LNl7bg7oCslwlrwfpLjvkwHY1xjQJjHchxQZPP5oL/ldFK?=
 =?us-ascii?Q?ANhsdnhTu1m057zN0OrTmIiM5juWMlOBpZdv2hXp7nbRAM2Rc6yn9tbyMGMQ?=
 =?us-ascii?Q?RyPIPVbkfmu0YLxHf0bVrQMPXP175TBCgyl/v49wm8rT0F5PrbhDJe07YOmg?=
 =?us-ascii?Q?ZvrFip9P4l1dgBkgGv4xPJnJBpSSGZ62rYKVyfUyU/94UBEM0uN4z/ZTreGa?=
 =?us-ascii?Q?nBdgfYQvayIMK3fgyEihlQaBHv9Fdog7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mbTw3bvr56s8YDk8BTTT6UH0Po9LlLcJbUM7rpk2/+BJjq4qPB8aiKWZ/qaJ?=
 =?us-ascii?Q?VKpG7rH8V5+zwKqsqkJ24S1m0sZTsHbzoTNKsZdnRac0kUDTYuGubPKjf/Hl?=
 =?us-ascii?Q?u78K5ADMSlCBGGH5G9JdHH1EaT5AoYClvTyujsGEfndxmlRytCSHdW/OjoLW?=
 =?us-ascii?Q?mkeUBWDtm58hkhdTkmpdv1YBSA9I/tiFZiHEF2CF9jnPzxNSpEjUmb9stJEM?=
 =?us-ascii?Q?k+2onTJuCsbNdhwVE2/+4tOufVRAfCO6bo9jocbCAJS2OQ8os2McpnyjbFC/?=
 =?us-ascii?Q?N901ZXTHph636veXVgj185R6WZiaZ2lNo9n3hr2+0Ee+QhOon4gXBLDZu8N0?=
 =?us-ascii?Q?9wZ0K3V0xYZRkBVVhzIDOEwvIHavOZN3XRsk4qUhm32+so11zJE3PMLg218P?=
 =?us-ascii?Q?NpU3aQVKyACalkGJhjv01AUaZyMecjUP/G/dYDdcVEwFjoAqLeIx5SxqM7V+?=
 =?us-ascii?Q?LZuIgL+5s0W5VS38dToLmi27PrTTu/nil4YWSFPTF5m19b0Jqv09RuUTtu1I?=
 =?us-ascii?Q?Z0bJHjF0REr2DtDd8p7Drs3DmKS3a9bzmrat6SZ7ptO3F43nZhZHLpOaXcjM?=
 =?us-ascii?Q?QdQkAKsQ2543HF1tFwvS67TCxiA3LnqmU1etqAFCpx9c4xJjk0oX5Tw4E7AP?=
 =?us-ascii?Q?Sx+KVqPU5KRpuF/j+aMcCkDEIAkcPvi8DH1lwpm2IoalhSA4NVyP+qaEJxyI?=
 =?us-ascii?Q?VZ8gajG/xxwXJnWCqLNJaf58w8q2fO81cZo/TW2c6auFwBfY0vNtLVMFsnvk?=
 =?us-ascii?Q?8A/kD35g/e6dI9gpFuljVSN+9URKMkIvtG2tt52hlwjRe2qyjZdcLpGfz76n?=
 =?us-ascii?Q?GrdQ0smPIsDRp2zUIxaPBeowvcuTry0V+Ry2/kCU94M8/gqVfrt5Uz7iZDXv?=
 =?us-ascii?Q?Yr4d2fP9EtGQXkR86H5GEr5/1/zs6Qy853qg66LFnPCdqcZMfCkV1sS5MLNZ?=
 =?us-ascii?Q?VFmO+kT+yHv+oDUjZ4rlqacEoNrCGRRRBgxEcNcNThhypT7+jtb9DBqfH4Bq?=
 =?us-ascii?Q?2sEI+WNKECCgn+nUenzmb0J6woa1FXCFqgzeNRkklrbnnifOfffRZ12wFVvY?=
 =?us-ascii?Q?Dcq4vTm8588TYo2f2eqPAJv16vXgrNUEBCEWa5RIvCfg7k86Nk8FXymSzmAS?=
 =?us-ascii?Q?9JAeU19KTc+Ihg4mPhP1XmdwPx28ZYcs13kgbO9VL/ZYvaV/RjTIzfhTlPJn?=
 =?us-ascii?Q?nHWSjjxkr45IQMdDVCzxj5j69AzSTQbwgrch8TRhjNp08FSQo84RJd7m69h7?=
 =?us-ascii?Q?8xyHowLt+MpB/ted1tj82hfGU4uhSKDhE8+F5qTNEPuTMoeV4ebd8HYUMBO7?=
 =?us-ascii?Q?14Zu/jsEXZzL6CBdyVqBeO4UHH7p3In+3sBY/aZwJ/VivsCAyo8gltC9Kmlr?=
 =?us-ascii?Q?Z0b3PKlgzKFMNG39JdI8YLhnMO0ovHofjOTzO6Ezk92vhaGLsG7l3e3xH4m7?=
 =?us-ascii?Q?IUwxp1DNg+eywhW5h6HM2EgN9NOKvE2ysKJSA3xdD5sTjWQkmMQhEkKjaWKN?=
 =?us-ascii?Q?uGjVuxaQg2Ytgq0SUyqsm60nLtZP5ZXi90WtQgghl1mSwrtfzO4d/ytytiLg?=
 =?us-ascii?Q?3ZNwX3m0hz2YXtEnNiabWYpW9r6abVP+Grq0hJN7bDb1KcERv0bv0Rm/4upV?=
 =?us-ascii?Q?mFGAWuI3K3jVQC/rwO4HhDk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d256f3d-7250-40b1-3dbd-08dd6158ccf2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:58.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ3bI6AdQYsxbQ8HZWhgEnZM4lt13y6jQCl41O9aaVMyoo/G8anmp0T7gUH8Q2zE4MGuejjL5JxEc4lPIi/f6u5Px0gcKDCJUhndWJJezbb9ZADmWAXLTtfi1zLoYlD/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18161

From: Biju Das <biju.das.jz@bp.renesas.com>

commit d828c6726fe5642d1c71e9edbc4799c959b471cf upstream.

Document scif bindings for the Renesas RZ/G3E (a.k.a r9a09g047) SoC.
SCIF interface in Renesas RZ/G3E is similar to the one available in
RZ/V2H.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20241122124558.149827-2-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 7b997adec92f..8fb7fcc99720 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -80,6 +80,11 @@ properties:
=20
       - const: renesas,scif-r9a09g057       # RZ/V2H(P)
=20
+      - items:
+          - enum:
+              - renesas,scif-r9a09g047      # RZ/G3E
+          - const: renesas,scif-r9a09g057   # RZ/V2H fallback
+
   reg:
     maxItems: 1
=20
--=20
2.43.0


