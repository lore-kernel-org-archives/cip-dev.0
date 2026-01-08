Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B187CF6A9E
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:40 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3005.1767864577461928492
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YOE3IAiD;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDu8EXzt94x2zaGgTDLrswKycY8bf9uEixhBveNUN+StCkFnGX5syk5lq2nLcIiDYl16wURxE633kUk0LeaNdVMhpOLGetUFlA4LuBjUXppsCm3ZjJ5SqZAQ13RZFHI5xzfXEfjHYhvIz9eOrqBW65Sm21A9Qb7ONgyyOnJxuRic9yQ+WVgPw6q8ruLrzRSffjgWXE0M7cd+8om9thb4kiQ8dF+fZuB6+Lj4EynYBZwwQcUDi/FRfm5yFuPhpHWO9KRCLjlTIB+XiSkbT1yq02VeRTDV1d3qcTMyK8hx1ra69jUhLv5OWiAw7fPR5rfaEGgA1hUMxtd3MlM+xnHH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=816bcyXGsrowqc4/SYIqHJxc0fX/J/ZPboZ0jbUIoDs=;
 b=pba77MYP6VdawY7pAHk+wrCE6ONo9+LXEDii2YYzbTyPpmK98IRpVjpApd8bo9Oysl3Wy/5k9Tah9zyJwxuDvv5avo1CaVd+td7pGfRsGuF7mid4Sk3z0WI5wb6CtQldjZeZdIrB8Z4BliLJHZypf80TsV6NwW5aHquQcXcptxTfzKjHdHLOHfyw8SbIVwxSqsknz9khXZ2lj0d+zCTpe8AJZuMYmnHZCfTm4ri+MoZE3ie3w4vLvA27TcFLxTjVGvXMxzvFRoY3ucn4Dog5TesMPdsKzBIxXWwMe4gqWj6Oi1hnb5j7lb0b827/edopIL/FePJsAtb2lml0UxQA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=816bcyXGsrowqc4/SYIqHJxc0fX/J/ZPboZ0jbUIoDs=;
 b=YOE3IAiDkL/dwNxU78wqr2CLE6bk6xP/dvGnySyAEu7TSJO+4ETvqe5ml3I+cwDqZILPkqqRfiMamIC1OneM2sQy9LOsJsOxwXq3+JNwq2WtimINrND5MaO+1g8VjOnCsn1KfAv3r1KVxF44s4FikGeOTW5ogp5JghCaGqWgpfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:34 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/22] dt-bindings: hwmon: ti,tmp108: document V+ supply, add short description
Date: Thu,  8 Jan 2026 10:28:17 +0100
Message-ID: <20260108092823.489287-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 019f9e4d-33fe-4ee2-4551-08de4e986ed6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xquHZb8pgz3sDac7d6nk2P3JiZM73REMdTg7mHa0GJHiSLyCnuiQtyQNMTkO?=
 =?us-ascii?Q?876U4zB//qeaQILt1KJUuLAbwoJIJ3q7N5kg4qHZD8+oBtHAeiB6+grl2t8y?=
 =?us-ascii?Q?bcGc2EleH1oiDUgVHYbQSfFue5bW8F98THAte6nLGo25QHW5iTGud9/wFM+Z?=
 =?us-ascii?Q?KW436YdXrMiRdQl8HYkHwe61jomKFdGnE+68kxj15TdquuDR+ohqB+GcaUvn?=
 =?us-ascii?Q?bpiWPop56P3kkAb6x4DHWobVhK2ldE8Mylkf71d7jgrRS4FLOIxayWMPk1FE?=
 =?us-ascii?Q?49Q5106easv+tqaBhTDIEvuVm7HaaehyLq+EbADBs5lQ21gi6wW7DwuCZMM4?=
 =?us-ascii?Q?MO3BQBWrauZnVgQigr4+OPn3OubTOeoT9em3IzEEA7L1UWqIMQYp+/exJ4U0?=
 =?us-ascii?Q?hSwEBzaKY1TnBIK3XY5ekjMShsNgq7314rwj6ObM/g+nT3JnKOqCz1iYiiTH?=
 =?us-ascii?Q?Do//lgbVUmao+2FHH1fVRWtFz8wh2zXecNYsskG3h3ZW0w4aAdlq0xW+i7aQ?=
 =?us-ascii?Q?Jb3ceZ8f8IM0waslReYqypklr23rljRiRCtb+Sxv6kTgrZyEQ4K2aUAuMUIE?=
 =?us-ascii?Q?ptGOvB2ypijd1AusKwYcG5HXpOJAxm39dzcwB7v6ceC38mJJ2J4wLDvvDl1e?=
 =?us-ascii?Q?afmIVdGfgUXBe96S8fUDZTX+wqiLUrKNK8OHa22wBP/x6dVPMqVyt1znVjAM?=
 =?us-ascii?Q?RlKhruQ5J/L0RPCaKglxqIwQJMUNMXouZJ6TFjd/mPR7D9sz+CzlAg9ioD2L?=
 =?us-ascii?Q?MoQ72fFqmr8t8w4wnMQgVnvQyw4HEMEM4qSqGrt8mJq+x7ri3lV5HFSIGs5u?=
 =?us-ascii?Q?2Cqah3RtRAjUsbkUQc75US4b/BFfTHZ51JqfjG24tQHd1uupkiQXwdQLlsUT?=
 =?us-ascii?Q?nGYO2+rEZu7gHd9pfQXaVSaxMxIYBQWOM/trvK3y5+r8/f603txqw173Q8aj?=
 =?us-ascii?Q?LFQlA26SoNBaw17oLGX1w/0hqO9NMa4aj8xWTyn4RXe/mRv3XiuPXgENifPe?=
 =?us-ascii?Q?a+7QXzZCIdV72QKYrNyzLaOKlBjNvoDcPEGUDEYGxR16wbMrofFKxq5j18Of?=
 =?us-ascii?Q?na3R0cefkGBgVr6Y81or2zq29rDNX9fypqoiM83pIXBodAOCd0cd+52HdKIA?=
 =?us-ascii?Q?2vP3z0JgULUWKIpXgAFqpiVmFm8eI7tJLldm1dEho89ZkGwBgVmiejnfSS8y?=
 =?us-ascii?Q?UlO3Fu/Hg9M5uGKIBfFsQLPmQ+nMlFT8oA5ICkkG+iY7LhkdyD2TXr86PCrf?=
 =?us-ascii?Q?wbl6I9Flv/CJuquGw3dFKNtwXz4OAfWn3xRAhgcC/w+u70VgHizN4NfnO+lA?=
 =?us-ascii?Q?/Tgb3b+qyLarWLtyz47GcRGI26ywG+5JPiDz9J3pSVWif4LXUxDBp/ixxPnj?=
 =?us-ascii?Q?WTKt1OHJnV0vG2AC5T6xuk+dkmTl8itLtd1JvfkAWpe0ISUf0npOFbFh4BfP?=
 =?us-ascii?Q?11TsHrVt8T6YhLHviFdF66BMNzxTmAqmEMZvwKMxzejsHeBFurZdoJe2B3dX?=
 =?us-ascii?Q?hf0v5ObeAJtaCQ9RJ0/1Yh0WMkd9o2z3pRC1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/wdpR2P8KpevOIHI0b+2rm7ry/ogv9YEo48TTGLt6ANIOnCR4r1KCfIm0+1D?=
 =?us-ascii?Q?W/NbXoJQjw+NhvsCQGnFIb4VNh/a6mmJynaYDZXhPms8nNkaHhA81UpBOEEK?=
 =?us-ascii?Q?eVJT8o3s3eSDfPvSc/iq4CfyyULrzXOmWHrwtZ+xL56W679n67SODM4kwmPt?=
 =?us-ascii?Q?wPiN1yiC0F149CF8XmsLtQXhuTRic4JnkwHdoiK2jAaPt/vkjEGf9G5sraWF?=
 =?us-ascii?Q?DeKyeAvTShXpTxG1G3YrwWGMlBKk7pL97fFSBakM465E3kcWi1qW2gb3q4Pm?=
 =?us-ascii?Q?IFqPeCq2chS7snt2/wnM+6D6pBMAGmmBwU3QIB5jjpfra37DSs5O0SANuDzc?=
 =?us-ascii?Q?xuHZerY7g4C3wgsWOa+7edUA1LDfUh8XTCykBuRrutDD8NguBl0qwj+UFTLJ?=
 =?us-ascii?Q?7zkuJO6S9W7KEAaPb37qrpHW51IeWU57Hi/UA8WNd3HNfCeQHRBerPhKW7NQ?=
 =?us-ascii?Q?mXVZyI5OQFrbrcLJb6g0uLrRXSnKj6ErkAM1cy7zpSczrXoJRQfV2YJg6LJ/?=
 =?us-ascii?Q?nedlRX/5VgQMl0x6k5USft7/4bOhmet3HFzF+icNvaq0fIAHgpzxV9lZlsn3?=
 =?us-ascii?Q?SzOHmZ1o0aB1PoAt+DbG09KGi7xXY8/bsCRifBxK8/KQyE9LAVbA1USnTlNE?=
 =?us-ascii?Q?5DUQpf/DPa+sVbkuHTIUEa6XSZ8jgXxm0wJ5WbxUDYDqCrGj+v/9RU8FIvN4?=
 =?us-ascii?Q?dmlGmm/oESlwqQ4xHkEVI2AZmE0R+nawQ888ZxXHeTKg3UgDM3a0H7xU54P2?=
 =?us-ascii?Q?hV2NyBeOaVcljkgBeHRmnk/CWKnE0JWFpjZdB1YTQTAB543UtPkFEZNtLybE?=
 =?us-ascii?Q?qpGZWTNLfvPq/wrl95cbf0pZD3q9EDKzg5HMMFA9G3CuooMSVB/uBiRzSdww?=
 =?us-ascii?Q?PqY/4kZKgMU/MqQQHOzkbknS/rm0tHsFH7GLGvK6VlOdl+S2TIzy4TVvMUOj?=
 =?us-ascii?Q?2DzK4queGfnE6v42r+nD8FirbSSnOCP1sd+ZTlA+9l1SHET4Q9leHAru05G2?=
 =?us-ascii?Q?HEWtlu3wnjar+I9689plyGmMWuJPAiS7xB06kqp90RaOS7OQK9l/OBoB+LjD?=
 =?us-ascii?Q?SFoSb3fvobBiFPutFLVhUNmZn7QKzEGUubKOasvwz6iP+O/4nCiHFYW1+oWQ?=
 =?us-ascii?Q?UpjitbQt9edfWD/KkVZpVPxJIwolKpb4+zwImcEMVJ5t0HFZaSAH2e8ZYOuI?=
 =?us-ascii?Q?CHoTw1zKHy9Rkb6jN+SwThbPCjGiepT+ETG9yBqtwPPbTCbIbh/R993bUsyi?=
 =?us-ascii?Q?7nI9quctoQWS1/xfezXmD/UmlGK3+MimD01lOIt/RCPPqlQtV1gwSX64JnHX?=
 =?us-ascii?Q?vTYxByVSD1c21hQbKUSa21Apf1LcWrJ36YkjRPQFUkMibEiAXKx3KvKE3N0I?=
 =?us-ascii?Q?auv1QroXz2UBRxc3oQFPbA2RudwXVOIj+2moP1foOlvatPyH4wcLRaUkaL7v?=
 =?us-ascii?Q?MkVbccqAvyXjcLczMx0mALODIgQCbP6/YOLm1MUGworUsdXg182MGUUb2og4?=
 =?us-ascii?Q?OwwSEpRC6T8tTCSkGMCX4Ttrq5tRmwKQM+rkv/qcuiHNOOo2S7YMX3/qdcZx?=
 =?us-ascii?Q?4gG9Es6e55sF0meEmfOmAhZx4hTIt6yfasv5xYqElPTcQ5iJCMhBCTlA2PkZ?=
 =?us-ascii?Q?KDq5nfOKAPhV/5WrqOQopKk9hbLyYUhg7S761X84kXVveir8qJ7/bHK8L+kh?=
 =?us-ascii?Q?ikdYzfydCKazfYNf3ymP3ANBBWGxx8/LDBAF4myLaRL7kUukecwutjWTUrf4?=
 =?us-ascii?Q?CxoEumgGXau+qCqpayfd1cWCBKD/Wft7eHEaJBLKxfaE55MWotfU?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019f9e4d-33fe-4ee2-4551-08de4e986ed6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:33.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRjqU4Etp5EyKMJ4lzJbewZTAHz7tbLfEaRx0lmPtxVoOkUokZbKTxEWn+UtdKxWDNOyn/jgeI3c94gVOTLQ7PpnsbPzLfTaibzrYEqVav3Ivwkxkj0p23Tsdq+hY0rB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21452

From: Stanislav Jakubek <stano.jakubek@gmail.com>

commit 699383466851e3fb8284e1eefeed78ec30989b3b upstream.

TMP108 is powered by its V+ supply, document it. The property is called
"vcc-supply" since the plus sign (+) is not an expected character.
While at it, add a short description with a link to its datasheets.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/ZnBmDXfnDQXNXz3k@standask-GA-A55M-S2HP
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/hwmon/ti,tmp108.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Docum=
entation/devicetree/bindings/hwmon/ti,tmp108.yaml
index dcbc6fbc3b48..5bbb7aedda3a 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -9,6 +9,14 @@ title: TMP108 temperature sensor
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
=20
+description: |
+  The TMP108 is a digital-output temperature sensor with a
+  dynamically-programmable limit window, and under- and overtemperature
+  alert functions.
+
+  Datasheets:
+    https://www.ti.com/product/TMP108
+
 properties:
   compatible:
     enum:
@@ -24,6 +32,9 @@ properties:
   "#thermal-sensor-cells":
     const: 0
=20
+  vcc-supply:
+    description: phandle to the regulator that provides the V+ supply
+
 required:
   - compatible
   - reg
@@ -45,6 +56,7 @@ examples:
             interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
             pinctrl-names =3D "default";
             pinctrl-0 =3D <&tmp_alrt>;
+            vcc-supply =3D <&supply>;
             #thermal-sensor-cells =3D <0>;
         };
     };
--=20
2.43.0


