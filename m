Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8D7C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web11.34779.1741778625533897542
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lqKZj1e7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2vXzJzpgfFVd1qvrFlDNcsd333fbBZTgwIVSavaz4+HsGH8aX6E9T/D7dweyGMnfAKFxccXtPbx7YGLFls0+whlmtUk5oDp6yIK+g4616wplGguTi/aNfjpca1HhEyY9dU+TFfL0t1J9guLkx4jDXX24Tw+/ZmxELtbUT0o3X+ha7/BihIP5jm6mVx2GU9ETkeVXT+bW+pxS9Pfnbbgf9NN/08F2fjxcumUaao7ORJ4SYG4aEqw3WnHFHM3hLOuwqPipQoeHcvMb3ykG568E3JQ23A5XLhj+pu+5Z0fchWakJFoKNfQaUWcbDlQwPqrBNiiPTwm8fzw8BX4Q+4AGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0KMMKTEUxtnppiiNes1MpSXiwa5fJY6PfKZjWZoKG4=;
 b=Sf00N3EoAJWxw1cXbNk+sDZk5i+ZmOvxMzeyZcdAOn37EEsEurvED4BKwba5fVPvkgWnzTGyDeDP1Ldm0LPbKd55IB39gorwPIixHvl0eu2Ig7PSfN/hz4Ex3HVzMplySP95rguB8t99Dc7SogrYrbfMdKA4ngKLl//X/UTdJfZCHwJxnySPDULfBZcK8igyx9IMCWYBbksygTPkwGy8rAFPO34Nhw71goE03tR55w8PyvF17PteTABkvcQs9EYj8JjWaBdFm9/T9muEGPzSN1IoIOpSJ573hoeTFDhCvdFQXv2kWh3Wwwh8MZnCU+oK+IKc7YD+n7i2KESxuwC0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0KMMKTEUxtnppiiNes1MpSXiwa5fJY6PfKZjWZoKG4=;
 b=lqKZj1e7u4ah7hfAWSZ2u8euEFCx2LCeuJNZnfVLpK05QagsUy7Haf1xtsjq979Lv7ekDsoW5GILoqF4tybzVhiH1+HJxoD3Z9cBZNbb2of4PdfaCHhaCQaruLulZBXLOKJ/RcWRXQNiUIMtOfsT33Moy2cz00VNZL3vEKv7Kyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB10581.jpnprd01.prod.outlook.com (2603:1096:400:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:23:43 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:23:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/85] dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II EVK
Date: Wed, 12 Mar 2025 12:21:39 +0100
Message-ID: <20250312112302.1605750-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB10581:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bb1ca6-1bfe-4417-048d-08dd615858fe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jSJnUeyIgjJZkhuOPsO17MJF7JjOfznaJyhhJyojrFjYsKRbRCRa3RU+FBo5?=
 =?us-ascii?Q?o9guiwSs4Bs+EqLLJaIi5Sy12nnxF1XjNBwv/bivwloMVKU7lZM2nnSbf+CH?=
 =?us-ascii?Q?SqsrFs/9CQuBQXKlbmsJUi2hmJDdf6YttDgWNKJpUfK7M0JX9XxBdErqcF8i?=
 =?us-ascii?Q?bCrVMSEa3ybFS3CompLbZKNqaxyvHFmUtIXow3ltLiRcPFvX/Gn51UWKlBTD?=
 =?us-ascii?Q?vqSR2lhvFF5AFjhuNX/Rok4xuj9gIhDHngFzje9DeZk83qq86xMFJdgW7uE/?=
 =?us-ascii?Q?CE3CAIKpsnKJeyONIE81pzVV6v+lqscRH5bJxHy1c/quu9095YLslyth1apF?=
 =?us-ascii?Q?5Qx5JLjCJfmKWjSbweRtZj2FSdF/Z8mmkSJ1lx+u6O25uNXsuEqC5Kaoyv46?=
 =?us-ascii?Q?Fx1jbtC+EMenuF03g6s38yYscQTUNEZwpipo3AYnukmzQm1jUsRE26R28v4s?=
 =?us-ascii?Q?jAVixQAd9xXlLJn9jUxV+yL7NiPQ7qQJu8seAmOwF+3mYEPRZe1gnthZiAmp?=
 =?us-ascii?Q?CPa7QvWYtQmuCyv4uxJ3/WVptmPTgldzXTAMEH9VauBRUNGkh7qUxTSsoDTG?=
 =?us-ascii?Q?E4yEy03wIP/bGpweXfqAFqKCvWW4Swsc4vbwHFuvvOY41KEoqDznm0MEZcc3?=
 =?us-ascii?Q?ykFAZoMm+r3fciDxtRa6z+r5qk+cX6y9LybAtwzJjNBxW6s3BIk1nKhwZ60h?=
 =?us-ascii?Q?8bGQB0pqCz7muCRuRMJanJj4QA/OvowV7bcF6ebforoGB21AJkl2w+1y2HkM?=
 =?us-ascii?Q?cpNCb/VbLurcJvMtyV17nSXdowFQ15sSgx1k7cJaFjjgo/PjoaD+Qd5yGCTG?=
 =?us-ascii?Q?lPDWf3SFiszoF70E2aoPWjl1rJVwUXrYe669X7AjOgw3w3xs0TDU5YG9EW/o?=
 =?us-ascii?Q?D02SNSiAmRvd3DD7WwHq3d4wwojVgpfN+woqP/J6mT+ykXgVj5AlJRt2eKcV?=
 =?us-ascii?Q?jetAXGmAhRADjHtpVCTbBQ2CxOAaVYxIZW3XCryCds1mi1HsECVrg8/RFIsH?=
 =?us-ascii?Q?X7hK4G+1Vr32vk7fXDuGwR6jpHEndhmnS8x3JtbGFANJ/ubCALNMZK8n9R8j?=
 =?us-ascii?Q?Y0elb1tFoTeNZ67U2yKGu58Apelz0N8n4w6anKIB6IM0IDAZ2STySbeElubD?=
 =?us-ascii?Q?H3NwVEnqA6VbneikbAVymaM5TGZymBG9e4zyORg6rCBpUbfIisXvVxUg4SI7?=
 =?us-ascii?Q?nNp+/Cx6meLQY1meOGrQiwkFJTjNU20ZEUvc+xUPYcAEyrPgbOeL3+1gWJxG?=
 =?us-ascii?Q?Nzw+h+JNptDyoz9ANPiUKHg/m5VJKLtTYp3Z9kl1I7QcRmWXEzUz2KX1UZCb?=
 =?us-ascii?Q?y9XUwesPuYcDDECAuvM9hclHngc1yjMsqC9RDuEm8TJ0ZlLs6os8AXwqpEUB?=
 =?us-ascii?Q?WzctjqMt99u/pgZv9jujDvwdzpWqmzOMtODgWmHdTOL9XAIRwIQVuknk+R4B?=
 =?us-ascii?Q?7sOzhP8RMubfR+j51J0SILfsX8xxZyzh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nHzW/uSulfALtzqSpJhP4vXlmUzjvjWYQ70mjmSUCdYOVfAnPpddbxqHu0PH?=
 =?us-ascii?Q?5JUHqTQ3Lcp416oopSjTgW073pX+7lXbcXo5G+Wm693LoVCXkvMGcKCKUhQv?=
 =?us-ascii?Q?EY8/DBprZQuyTVOTMHCLrboG4O26XND6y4IVqLuiDmcwts+ODPGGG0h/LUiZ?=
 =?us-ascii?Q?2i0oAUw7pVvrfy/sZ2uSulGc9Slf6hUHdLDKlBp5OBhRJ4O4YPniRf9J02Lh?=
 =?us-ascii?Q?xUkwMsnpme5m7dlmkmsGNFgtmLe357dQME+Fa4U4/P99zm2snrDSI/xECouL?=
 =?us-ascii?Q?K8Q+eKjMwjlJeP6FF1ZdzEN0azeZjb1wXgn9nLH4KxAuhdIzXGAWysQp+bBA?=
 =?us-ascii?Q?W4VQzsCtzodwIg9ge0K3z5Vbk9msufxJ1MGCHScVQnAQLRPDgRACfRPHuUii?=
 =?us-ascii?Q?dk8Rfs3FnHM5Kp76NXkmyxmi12Kmq57sxNpe0iKir3/siqeHEzlMJpg0gbJ+?=
 =?us-ascii?Q?2jyqh6OKomO7rtQfWtDyOkEP266PZsTO165R4thouJE8LncNEfECcX8EtcUG?=
 =?us-ascii?Q?1NXaTQU1b/9O9bUlY/IIjruTCdc0uCWxpVCgBOqWJIs3tbpvJmVeMDo08EMZ?=
 =?us-ascii?Q?6/S2qVjjjBw4q9SupeuAv5XF1FD0RxzjzeNimZ4HZlu/1xLKYgCQv8I4x/HP?=
 =?us-ascii?Q?V4/4Jjmg7ATmEbm0R4rH5GrXPbvlToQF4ian6NKSG3xZzhIoXd78KRWde+EG?=
 =?us-ascii?Q?2RQV8I+nTymQnBQAPvBKoqZH+7KFx7PfZm13WyaPCCf1bvvy5K+qUR2M2FQ2?=
 =?us-ascii?Q?I7aGNDs5GG2UqJuWxNdam/qQF0+WCLEmdk4x3m2QssMikF8NDt7cqSmlngBk?=
 =?us-ascii?Q?GXczfDVYxGwEQZo0sja5d2wOPR2yeP+3S5rUUeb8vn9O8HweZ4pgSL0zPiLs?=
 =?us-ascii?Q?nB05WGU8mzpPcQy9x4wS3DcIPJfALwBzLlv5PF1EsAJCMP8HKZhMV/zWsm+0?=
 =?us-ascii?Q?Y8qJXpHnQEqKZOZuxQj57PKaij7rJfFeuk+HgZKs8ePwqKnvPzQosgxoeX/R?=
 =?us-ascii?Q?0kSENhR6FgaPTUDJAAPQIvzhzL0koHLnvIvLtfnpoDT29pe7Oxklfb2YSCcH?=
 =?us-ascii?Q?5VKagAVisUj80iVEZ/HXkeaXq4WGgDbf/rzAgzNxTpochS/ipzEkRo2ZBf8b?=
 =?us-ascii?Q?muZmO+i2wiaLJIMpq7+PUKH/rMDw8CzG2yTi46h2iREsvQRaY9ejURz00yLU?=
 =?us-ascii?Q?AkSAkraYLdPmkNJhVL4tqL4BW8nxX1HlvqrF4i/FFIu064HGaofzTFqy1ceN?=
 =?us-ascii?Q?CnOlfVKWKq4xvqec5N1Ea3Iq8T5bqzoBFxvP5tmhH3WmHv1AbsOwui0gRyHB?=
 =?us-ascii?Q?FY+gNwA/DI74GH82XeZ0xFHUjHzKGf0e2vf5o76tzyusAI5EWfQE4Fj0ZqF9?=
 =?us-ascii?Q?ITjCYlH+kB4xoyxmDTpSasQe8sApQt/J82AVd0FpDDFtR3HVHeKaYzFxL/kG?=
 =?us-ascii?Q?xGx9o88y0jBotzmxQRvFohnkGKESsKlDDNjlxaOwT/QGUpkhBsFpnqSI52B3?=
 =?us-ascii?Q?veicQNV3aiVjAYVJIm7a81SQoAw6wE0uygrR3vRbbOR5ywaHmzY4CNCwnj7i?=
 =?us-ascii?Q?f0CgZaSeAKxpn2WCWmL+GDBC72qNZA3z8aRB4yETiZ8g8ITj3VZX6/jz36MH?=
 =?us-ascii?Q?8duaIGIVSLF5GhOv1iv0hiA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bb1ca6-1bfe-4417-048d-08dd615858fe
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:23:43.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t90a7Fws4o9O+my5fKHBzBQcgXoB4knn5+VShTAgx5Wj2IHjsBDIDho2COIClHLGtsImhyspI06V9NTxpi638dBo6i3itEAXUgW53X/0ZINzcTBDlhK+rK04l9l5bdu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10581
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18094

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
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documenta=
tion/devicetree/bindings/arm/renesas.yaml
index 8de30b478d18..05a96ac138b8 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -487,6 +487,10 @@ properties:
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


