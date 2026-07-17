Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DD3C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:19 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13233.1784293996904857854
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TUDXawf0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmsTSmKUnho7KdrPXbEvqU7Sscon6id6eqR+3jQror2MvIuAtZaWjKh/0mohVuFycVm0yU/Drk0BH5ip2xst+ngPeALtyNgQFR8VSIbF/laNvqV7xMDP9rzi3hN6E0gswvJ2AXVIL/TSZ8D/G7IWJ/9vFBiXiCeeGZGSJKzjdqrCiRqMv0gc/2X4V4xiAmdj8kneU5hUbi4H2qF9NEo1gzh9zkhnxcTF9D5L69nnNYzwLYgEQDKT3/xnDzK4uq66di6Q0R8tJ+DC2XISUuYvWKcKhtRh5XpIaxQDGBH5AvCF4Ls5fJI5uUIG9ZyynlpxgoiONVuTn00CHBIteSIRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TswI1vH8YXljj6wYgIz127GKawwd7UwSjdRrwVUGYeU=;
 b=QyBl7njN8rZFrPGwHkrUhZbPRUJdDv9ZBoMW4FQVh9gN/b5k3ci8Q++NV4VGwAT/DOb489MKRr+Df8GpfsSV6ThFF2InAjT1ohYPxCNLiLpGrVJHOx9GkH9eHSzWmRNDDMVlT6GNL/RFaVhp3YTvLh1gYfHOmWXEsmaXzrpcxBdXzNCj2Qt1oTIQubZRQtPykmbPlwJZxESTDAJCjrVqD8wibkNvVwRxv7Gm8i84ItIIXowENSmLcm4wFMS6CueH/wgFyPerMyqiRReq0sj3eWkcmjLVAGbZEfstBi4y5szO9CCzo8c+VTl0bfb7AVYwCJCeaYWnN+OOT1VVz25CZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TswI1vH8YXljj6wYgIz127GKawwd7UwSjdRrwVUGYeU=;
 b=TUDXawf0es/v4GE1XwJiRqAAl7I40MzXfRt6uN6+4lNYj38iOMKXbfJAaBBPFB1wuasAOfMRcGlgDMnjoFpf+3nj44IHHQspcC6+48ZULp70/2sMDg52xfigkDhmrzOjl4Zr0Q2j/Bus8P7SqjKY4fpcq2Nyzw1xcf5X5Ldyqn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:15 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/23] dt-bindings: hwmon: ti,tmp108: document V+ supply, add short description
Date: Fri, 17 Jul 2026 15:12:19 +0200
Message-ID: <20260717131241.2233788-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bbf96a-0bd8-4797-e1f8-08dee4052904
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|6133799003|11063799006|56012099006|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	9SSQUG8HswVHYwYOgupUV/AHVX/DJRjVygpT2B1iTmTjihEeOMrnfPwhDCEUy9Oe9fCdiddPwXuDytN+k8+BqwmtAcsA//1T2AqZ0oZsAR66DYiLOxnrOpSj6IuE/j+2gTxn+4jKU8E8zcefLohdpbqbdMrwXBSENTqJIFtXru8HRa/XAvIg75T3CO4OXVJY2NrmiVtHI80C6B8x/YyLlmxJfHfRFMxp6vVYPL4SB6e3bQWADPvSN/OfBKxT70XQoGxLFvGKKcQLlwS/MdHUUym7kQz+YQg2rgUCcXEst9q88n1c95OVRVE3B2m7rvyOYjHHoLLmaaW3Sskwrs+L0PZAKQ8i3gccH/3IICcd1PCNlUvIJRijqnlIM/Sjixy2sp2g4TuyFeWaXGoQPJE8oikksFYUdZRtAGFRdWMkl1HTC6QSpbN9B+BOoCC2AM4joYK+Gm+DuMpn4DnTLbSKhDKmT8s3iXV2rnm6Jd5Z3h9KqvbueZd1GgzvPMP1/rKsMmFNUKxsH2KHzcNOWF/wRChf1Ya93WFUBbrrvZ4Z8h4MWmXg71p38HljNBjIrTcxueRtRM1DNXaS7v0NlAVJfqkb+H/gcPEB66GlebHKA3W0v5xvPJ9A00IDAPwLr/nQzSXRcYIwb3phWiBvQ+EZc3UmRrts2jK4n8FizDPTJUfEBe6ORQu63PbLPddzZGq8r8o0Dmw4NNxj4O5U9xFiHj4P/awSOXmwlsyrIH6qep4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(6133799003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ed/syuO+i+RzRpYGolf1R4GR1ghmUYhEShnjq2G0n+GiUfzRbZEJNYYYYK79?=
 =?us-ascii?Q?qz+h0If4biSkporano1gnIumt6f183TjCLjy0Uundb1hi/KG0lysgyqsClih?=
 =?us-ascii?Q?9vDl/ptqysXPPDlrfcQweo4qpE71qyXFaY+4fHbUYmmPvp10dwDMyEpTkkEi?=
 =?us-ascii?Q?onQUPjPpFIrMCj29/+ZZBkphbma5HknBGJxdiOs7Z9qr8YBQybEDOqD3UfvA?=
 =?us-ascii?Q?Q/XFuVL+bpfzWPdIdzOrkpfsHOlr80Bij3ymu1q9IIfAv4/llSVsEEC4bEXZ?=
 =?us-ascii?Q?SCVoZIUcq5mU61qUjKutF54I0ZFUle0KkTCv93ASTQ9K1fMy4tnBCf6gAdUr?=
 =?us-ascii?Q?uxfNfkGnrU3qJLQSPbUuLeDkejUoMKXx+T9BiNb6PaE8uMcd3NJCF3swgfkJ?=
 =?us-ascii?Q?xIKsO3sQRVqY9E58wbuztnE0o41D5rvv7yGVMBO2QnZ/tfp/D9N+eKPpDQ3n?=
 =?us-ascii?Q?PdG6hQp8N58T/qJfs0zU+H50r87I/F5PnCu+Uss61+oHjdhSqt8AtG2lfV4j?=
 =?us-ascii?Q?JYQkdJ6IN6iZ/+tJPhM6XUgzWAAc20zspiPKuYhJCy7D4lpJXDl1zTSYMfjG?=
 =?us-ascii?Q?k5Ir1tJQxZ93v1dkRozRlsu6NfKVBhkcN5KIYMpSh2z2IfBEhLNSUdopi0qL?=
 =?us-ascii?Q?P7aiXQBrYyzBUF8PoV8AmugUUJgsWE7Gw0sSSzVkTi008V2oYj9hfdC6Lwr8?=
 =?us-ascii?Q?tFFUOCAgPFCyThvocYz36u0CAyfB5Dbksjgn40n8ewUERYO+wALWcIWb/AKQ?=
 =?us-ascii?Q?CPfYqKXea39x04ZJyd8xCcrElzqrFIqId4Z9DI21pkYZJp0XowkPuuuAerj6?=
 =?us-ascii?Q?eDW+X+5U3RShrVRVH3MJkaWhwsW3KZYO5c376bZ/id9x1hwahKn1ZoJtQY5I?=
 =?us-ascii?Q?Vk5mwW+PHoOzYhwhS6LwhfcVqTYlrjdS5XtREsgcrI7TuRhQgLhHuLOIw97W?=
 =?us-ascii?Q?ABvQiCxDIb7VE/MsbGJ0QV52yLQtVLmgxj5aGgX5DVwBq0Owqqg9QYtAmUxi?=
 =?us-ascii?Q?jgbNAYcj0G7TYKTQOEEj6RQ3y0PPQpfaZ0uLPExz2h275aU5cbbRAXp5ZmhI?=
 =?us-ascii?Q?6pQrpuNIvXDYKXJztxuA/Lwj1gopBvM12PH2xePd6BSX5yWsvS50vifdb6ml?=
 =?us-ascii?Q?qf4j+xQ6aaZxK1bLfJrMTCMYm9ym19fedNF1EPRyVt4SpOoSKIdE8QOqlFDY?=
 =?us-ascii?Q?FP6MT53ARw/OC7AH3tqVVR+MlaxG4R39u2OlPZqkKb9KFynsMQsPLdrmVRY5?=
 =?us-ascii?Q?D3legYuXGMzrk1setsFDCtKxWr2peRrKvOAT+j+1bkUKrlJdGyyhXRuLYwWU?=
 =?us-ascii?Q?QgV9lnRqeGUT4fK7HPBSqFo9MdXK1coZcMw3McRrGsukgRRyes1vfVn/qzTE?=
 =?us-ascii?Q?5ak3lWMIvc2zqkNmnt6u/Z+WvO+BewuTIKbs32EWvbHOr9Mpu0GZ0gxPH6as?=
 =?us-ascii?Q?IxZFM+43488CsgwLDscJi5f04/Kft5Njkh5C9tKSwAvvj7o11vvj0+MDdFAd?=
 =?us-ascii?Q?Y22nfQAg4shqPFUfOH86eUor/m8PgtW3a1z2NzvSRcaycHOVndKkQhqYzPmJ?=
 =?us-ascii?Q?QrSo2+3ullLcA1sdNZn8WyVZrcsY+2idfMaCq6Ow6bGo6ZUUNeIYKSIQPbCz?=
 =?us-ascii?Q?s0pGAAQyjiJUhZ9wpq/P2SlapqGudAok/bL+JGtUPqxxHzo5ixflSgBq7xhY?=
 =?us-ascii?Q?NssyzzuatPqqQZbW3gfNJ9hOgEk2hxfy/bZNfhNOd+LYMqMaKSTuIuiqlhYk?=
 =?us-ascii?Q?zjJAyehXXeALVHONzb6YBbiseNE/ONUbcdtS89BCWSa4Q6Xj+eQd?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bbf96a-0bd8-4797-e1f8-08dee4052904
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:14.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A8wG4lcbl9tSvNHg2Fyti1BeqgrPC4db/GaxCsHXy3742l8KTv0yHPtJHjyJkWlk8yDhLPIdSNkVBdFjYjkgfk94r4WIKGOqWGRbSNxkbkCmo08YOwd0AtzMENXCKYf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23629

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
2.54.0


