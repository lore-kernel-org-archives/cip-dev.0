Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D15BC5DF67
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:49 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16258.1786617575466080224
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZgKtJmDo;
 spf=pass (domain: siemens.com, ip: 52.101.83.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4MBfRvBxJw843GJYbs1yeBPFuVDqGvO7PrzZrC47WRibOJZguc/osta8pRbwIX5btXvqE1G6YvhjF/WF5pJDfK4zWb8aqc2Aj8HJBg/7LKpVsM0xARQ8yJ7VIczjffdCP8N/Jdqm3Ujb2vO39d4FpLqF5fhfiOrI4WK5HOmtO4lcWh/YRnBjhquWReuj9v7u3zznZ5GsPl49Dic6/mWh12LlrMzPnDV8HziPVRlxIZisL0SCADVvtdsPSfaWjB98+v8QnrSy9HdG+/FYZC1MzBZ/auo2d/Ye0ydvN6oT9FpB/V7IJpB/94GqpZXZ1VJVwed0IbOJyQx7uYz39AUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+MkcKN05lLgIPa8CER/M6UVcURSlASZfM5btvC+txM=;
 b=Ghwz0VzIJyfIzfDDiYsgEp2TtuatRD8ltf69YII8lkecWti7m58zc6uV0KQpOWCRRmG4kNh6SswsNkWEOXSm8heVFuoEry9p6RTpsogJVp4czwGue0cu8q9OcMdBr1wjiM/VqHOTjaKJRCi63DmKYg6hAK2iwaTy1AxMHY66sm/XwEDsvmATFfqsrHpmNVceE+8mreoL926JXs/4zfyDdFw22jQIE9lCtrgwayw+iwEdkvVB3+S47aPXAappz38NUPLrQyiW7Hd0GoKBAFFyrmB+p5ttufH0vGXzy7poRn7WSpqOgPkegTKVCyWsnc63811eYnSZ5wXdJRDqeHo0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+MkcKN05lLgIPa8CER/M6UVcURSlASZfM5btvC+txM=;
 b=ZgKtJmDovq+/68TWIQvfHkjn3nSH3AY/YFpcBRY9WqbXGfBpwnT3udxwCTM1bmt7beXRyKEHjiNRwRMzuCOlyzS2ni/stRsPwazaV+7KT14qne2PaH4m1gjt9/ycNJ/5f0inEJhbZJURBABwbYX6GCnYVWJwoj3+ys0TFC6hgF8GuKgyeXyzfSJ6ghEYyOVIAGgUUxhbmw1h/7JrBTVdo7+JQvNS/ND62SbOsyZ/HBy37RkLoQzwvDPsSnEHZN/y6IIhOwuZ+KiIChIUDYogZJq7usFiSn6OjvRxNOyNXLKb83WYX/Ol4rNRBT+dQcdtKzXBz1Q4Ka5WHpho+o32zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:35 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:35 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 11/12] Add kas file for hardening configuration
Date: Thu, 13 Aug 2026 12:39:01 +0200
Message-ID: <20260813103919.184402-12-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7a986a-9ca0-4ba8-9073-08def9272aca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	6GmhHIxnoZdcJkYo0CMpE5Rvgl2fEsuszdFHY3ytUBnTVaFzBxwZjrQcn0fU1CFayKbEbYnnRMGcgJFJ7+iPMZICDLucncetK+xsGg/tubdULkW7rQxrXMAm2mvtKc95kFzbecBctIqarOahYTO2gaICilCbeXd1KaOuKYKPnnw9QUkmr+VMFeBgHAE/iCxDCEGi9JN1exUxqWuqmZcYA34iyrgXXf3ZaBOrmVuZTK1WW89w0JFzVEZiDJUMmbsdV1ngzq32K9d/tx4Ed/lSFUpHYHgqGPRf6Ed3nBE94ZIkuV/jdn+83KyuLBAgUQXlpiDaUgy+WK2uK8J0rVn7ra7e742tWQj1EnFvICCJwcS6rWJHE2TPkymEE9bhWz3ZbBdNGQLlvEkD1DE1ilBM8ehmavMEvL5FgLz6/6+qyZ+fUJwLM34q9YXwnPLCXHjn89BAVYkMOn3meXesKX0mY0DiweqO1bMLLL8KvGkNLWBgUkGLZ4KcCL9suuCyBe+hjmbNoGjE8484KOiswnMIdCDcaebPJGKvTwEYu2YEynGeg3WhffVY71AD8C9j88QD3kBQ0xL1h8Y5gRqMQBvfwedXVm+MfynXG2l9p3faht+Lbjb/P86OmW/lRRzDy3flTG4TwatTBgk6xUA9caD6SfZFu52Kt3TO5z7434MIjK8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q5r5neeUy8XQO8OqZKDQqMaFzF573/WbHGFlkkuOBkEBHKnKzFajeHutvGt2?=
 =?us-ascii?Q?Q+SC0GVaw+OGoNxBkscnUNvG8/NnmPNK75asV1SwGPRd/BtDEcQ7w3GAAtq4?=
 =?us-ascii?Q?9RXNEtijuJfeM6/iebuPGRvhZvL4d9MDa3an83Vym7F0v3MaKjwF7AeEjiwm?=
 =?us-ascii?Q?/YVKEfL3jkv57/ekklnZn4wjyLwR1vkulrmZWME6Z4so+TnOFErxzbk7jSD+?=
 =?us-ascii?Q?wFA9Olx97npddm/vDaGT0tN/9gTM79K7HwgFD1LIS6o7wMM3iijodNvADOg+?=
 =?us-ascii?Q?a+euUz3RqTM3TgBnyI/b92QzeajtxhVhRXzt+PyuI7ZjbeI53Uo2X/VY227c?=
 =?us-ascii?Q?nvFTiBG5hqkBWKdO0/cMExNlVvcNCiaBbLrJEgB231JbkI/p1PbHikrbP+8X?=
 =?us-ascii?Q?v35DBwbZiHpPRfrLsZA+A48ALppHr09xCKSgWz43JUtLWrRIcqM/ToHLsOSN?=
 =?us-ascii?Q?sHKP8FO3tTNNQQwgafeiDkJSI4vWWtWfsdt3p/Zhmf1xRV2l2tL0V1hEBp6s?=
 =?us-ascii?Q?wx3zmhCxcGLG2ZmB0+2575mcuVJIz71kUv6wP/Q15qopxqxZ2whKkeEjykSy?=
 =?us-ascii?Q?sBGmDeWraQTR/rYM4hV/G2R8SNk4APH3h0o00k1s6tMf6NwI1UjEB1zOl5IV?=
 =?us-ascii?Q?OeUWMqp0Bry7t4Z33HobJ93duGrz+VD7aevn+my/Yb8Aihti4lF0MLIa5MDI?=
 =?us-ascii?Q?XpG1RfrP/bZQWOLHApxvUjJNRFEdnPnOAUTv1XLbHrjwlBnolVpatHT+WveI?=
 =?us-ascii?Q?XfwWvVwLb83ea+GHjkK+zTausJwnxm/vBG7IGciU4RgaGVY66GweL5VMZDVC?=
 =?us-ascii?Q?/0OAKE2wQKoON0mRoi0A9FbhWCbhOvnoO9d/7y3WGCfhSUbAmTP40pkCi9Xk?=
 =?us-ascii?Q?Lm1p2rhy2fAFDHTF5ht2bj+OVx1lNaqhpsKQXsu5t/qszGfhb3NWoMUpwdZ9?=
 =?us-ascii?Q?tWAsM2FyJ7UCA9Fyrb9Teul85XimoqAsXltvAckbthsqBY9yF1ssG1KB99gf?=
 =?us-ascii?Q?r09LctE3Nau1VECIudyhgqBHGZvye0hzRKMJ39G5cqzffMdWQrQp8I/B8tH/?=
 =?us-ascii?Q?5XRvScERgs/ZeEH2kDb6v9z4ti2o60LUc4ll6WgZNndYrQ2sngNocYaiCtaT?=
 =?us-ascii?Q?tb8f5kcK7l+Et0YzOyQ6hn3J7WZDAG5A/iuK+X/w4UqYCoFRJkHOKDxT5pto?=
 =?us-ascii?Q?hOHxTua5Q1cy0ILmJr6msF7eyYwBGUvPU0UwsZHm+D8VbO1M7uC07uCbVoxH?=
 =?us-ascii?Q?RGW3a0BbTPDqtm1jZLLhKvOwmS+wVUEcG8ES3glld1EqzUjqfE2czvnuVTUI?=
 =?us-ascii?Q?GeeQtgYE+3TWaH1XIr79vQMYv+ZViuUUy2sNqepG4754RMzDcbCWsRFAkF8B?=
 =?us-ascii?Q?qtFkQ+h4814QbluJqZ+jg4SScrgd41SZIJWvBsOjPS4+bHP7ljM0xKOCAIUp?=
 =?us-ascii?Q?eVIvWemd4CHEXQs59Ew3KCGiNi2++SENmFeIh57F1TmU4UNVjST4OocOed6m?=
 =?us-ascii?Q?0yIxEyz4X0TJ4741xs4Oogau4rZTdvEhC7frUnRRe+ktRFR7pdIYnkYk/d7W?=
 =?us-ascii?Q?hyCE2tHSlJxUOqnmIdTueHW4laS3cSR6LhEepu1iN1LXfN+M0If8lI7AGkqU?=
 =?us-ascii?Q?dBHF23dLpCDjj4mMk0yS9UKeYIAFSg/CaoRegEFCgYLnxOTSpyOMTfhrS2Mt?=
 =?us-ascii?Q?/uAcISPCW8L5NeEh2/T0HuqJJaRyOfaUTjqatUSNMSb7cYNNrsn9qbqsBd0J?=
 =?us-ascii?Q?Kdd037MKRW/Kw1Gk478cZEhmKVUE7oE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7a986a-9ca0-4ba8-9073-08def9272aca
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:35.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uvt+6wwUkTaUu4F0T9zu6dSdCey/VhR533noRHPhlTAgM92er/ylZopypPW5Vu3xMjsXP7QdhsDmCF4ftwpn8K7f2TqpRFEMHJi8/ZcpL/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23927

From: Clara Kowalsky <clara.kowalsky@siemens.com>

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/cis-hardening.yml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 kas/opt/cis-hardening.yml

diff --git a/kas/opt/cis-hardening.yml b/kas/opt/cis-hardening.yml
new file mode 100644
index 00000000..0f157470
--- /dev/null
+++ b/kas/opt/cis-hardening.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  enable-hardening: |
+    CIP_CIS_HARDENING =3D "1"
+  enable-validation: |
+    CIP_CIS_HARDENING_VALIDATION =3D "1"
--=20
2.55.0


