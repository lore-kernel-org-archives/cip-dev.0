Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C6C98310
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:13:02 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2967.1790237573835819464
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bqrKazV/;
 spf=pass (domain: siemens.com, ip: 40.107.159.9, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx1nfT8qdbnI7RBGB+v7GCl2AvJnfppWnKxoVQFtaPxD9R5vIhCrR+mWBLrpDQOuWzf5ufq0Z+5ssMs9MjuttgXJqAOG5r5rxY0cfdVcpCqtDmSSByQVblQP36lRHrt73qjbkf7sAFRUiLy9dJ7Nav9nvgNOJ0r+BYu7uop5pKoO9t4Gs6nXPLVwfVA8mjFSNxEizNlnvNu7e2a4sXu7cIHLm/yVshNBRQKvm38c6ol+kNad0MgC++AxO5YADNHQnf1sgeNNlT/f4KX7YAws90fqS6aOf+1orSgXyYjbBXEMJZJG2mXQJxABZAqjOQ8k6TX2Bi2sKf8IU8GWd59m4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKFoT2KVo3LSlEjPzInawCz5F9gzs+Tqj/Ef8QDUpr8=;
 b=b4ZCfGlS/Mvcyvx/c/gqWO0Qy7eQwujrkkWbHrEDZ9kYCGPBhSrgDq0n/c8aIiZEmpE3wdJ8D9CbRBSNWUlf2k3gvDEqPD1YeuHlSupXHHjw7EPlV4OIbDW2eZqJJNNdEfpA5PV+oN6TZ/KE/wojyS1TSlJrtpPlxHyampRcqdh5QiZfxd/nE2Hy/Y5sapQwHf6YXdb1EG51XLPa2bWYL9v++Oasu6YEyr43/r2l9AL6o/WKF7vOv22Ky3dEx5g32hmfzyZxcZMpjF+SOuTjj4HHV5JbT9jo/Elt2NF8w873Wkyd6KcvxCyf8bhcYh/gRQc1kpM1EcWIbEMCCAphQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKFoT2KVo3LSlEjPzInawCz5F9gzs+Tqj/Ef8QDUpr8=;
 b=bqrKazV/SRyaqOhXD2nqEtvSlJ1cvPLmzMg2uLs07KNlMxggkLBjpzjL2L1MuFaufhGfhJ0LknhOYe4dfaZdzNmIDL5ZKhwvsxyhkaK5J7Ohp3UNwRGpuaGeZEkXW8tzmdb006fS5SQpi+WoBXIWN6B24Ot86m0Ef/lvPqXaqDEpv4HKxml002ZiX97xlHbcZ69VvqQyYxCXU0ZKBW5momCfkhWI0A9Qrlv0yNxZl5g6Gq8eokZgR+dMCs0gQl5KVqCtsnovOslv1MrELJYTb7nA0+FPdaF59TZvURd94lcQmkCuEixloRUwHZhIqsOW12DAUfHa4475nvDjrR82ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:12:45 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:44 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 13/14] Add kas file for hardening configuration
Date: Thu, 24 Sep 2026 10:12:22 +0200
Message-ID: <20260924081226.2844456-14-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS5PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c636f0-ba08-47d3-99c8-08df1a139c75
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	E/kSVEjI7zLmNvSmAfnJWxNkN2LFvfTeVpucdCzfc3ZnVpke8JE9F8FARL4o5RTop814M05XApWTvdEuPiH6fs7tGqwZf3VbUvqGsDmbbWk69p964wHm8MhQHzU2DGe3xFm027RI6H/mnFAik994SntIhPEQPHW8OoPxO28iqYkY6IA1YVPw+UwhSvOxZDj81txGPQlz5XUrvh7xhBh1U7zZb0Tf+NEoKwbogmtHWYQBc20VbqA+uAFQFpMDA3r21jdOVsjlJg1dk/tiSHtjhlUvjBoDWsZCLsbnfvOG16HjqxhGLEPMYJFMLYEJ/61b4J1j9p36sq4l59waKU3N/UQhagLXSD0nCdqZJRnlqvZA0x3Fh5S1UvyIc37eFzv1gmbkDYMG0YJ0SV0CQ8AKn62yNgPVBchswTTDTduN89PjnNqCwRk2dFRcW3E2ymgiAzgf4x7Hri5Zj6+uHsuHDdwx8/o2VoSteKYuYCiUP7gOrF12kvyiqZBdp69YxgmoR5AjHxejEJfaJiNyhu9ES6DsIWK8rUiP01mTMi5rvdnUAugoFIx15OLQyow6Fy3GKbVsM5k+gDqO8DYcBhkcEVzyceGxIS10mhBTqpho369kHuu3DGncrX8tPsxqHsZrWGW0efwNFRQsIOArGxSdxadmLtzGwJY7toYW5giE85c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1QQ7PPoas0qMxtnTlVE19h39Rr0IEYLhHE+PdXsilVsU9aiYxZ95ayqM5SfE?=
 =?us-ascii?Q?Ef4od5Vna3CM6upSLjp3wIgHVy7qplyXRU0XQ8AOXgaL8LkQ/ZyrSvGduFZi?=
 =?us-ascii?Q?zlhqPk1RhjSd6V95CmvBAKr7al1uNr8vBLr2lBWQwGd9gW1RgDWgPoQX5k+u?=
 =?us-ascii?Q?Y6un6xZA7z5mQFm3IoOL+O9RLgGN9uECbGChsQvefK65qqiRi7oSEZhJqAjW?=
 =?us-ascii?Q?LHV7Ba1EB8RaDkMl1WhpMgV+vT3Se70JuRtsTSBRufpa7FU15k6tJ2MBHqeU?=
 =?us-ascii?Q?VuLLVN01xnmIL5r2uPXP42P8HYnGlVzosxloAXVu0oFwcfWxuk84jtaTYeJZ?=
 =?us-ascii?Q?bibrUxM5nLaWHfW0DDuS/yjNJR6KleVWni0cGKikZ34z4hlEEcOVKBipWRo5?=
 =?us-ascii?Q?FJ0Tr+/t64u0rniK+BJ7uiY0JqlxhrKLmXigvrtTAQDzl2TlWxjvEzoQ0yYS?=
 =?us-ascii?Q?ByAhyqTMM6+tsM66u8WAAeKLF2aTJHqZT2QkllNXZi4Un59XW8zB9/Oeoo11?=
 =?us-ascii?Q?HT0fm7aqH9wCLknqdQUhyaTwojqcw0UwrJPZ8xdFTYCDEHFHo/VuGbMN3CEL?=
 =?us-ascii?Q?cbfHG+U9L3mK3bIE3n09JEfjqtuGCj4aSDMNMoqq6UC+i+EXGQJBF2NovAk4?=
 =?us-ascii?Q?j0BcKvGbxNLWn3c10TQoxPyrSxiJmjoWgQ4BAB9EePvRHDJtZ1KRrm7SdvJs?=
 =?us-ascii?Q?Or8eI1VamICFny3ihbPWZpzpxMLo0b7EcQDpHcIHneNlbqxvyUbpbaQ114pf?=
 =?us-ascii?Q?96cgIru4WdQc/R1Rq7/GaTNkVajlz89GxGfng2XewzlpCPUlw5DNTmlcIIXt?=
 =?us-ascii?Q?erEzJqbnr21sVZsnvHcrOqxzFmWOfsliQ5Q/BH41SIItozKZLf0JpIpd3sjx?=
 =?us-ascii?Q?KThC3NKvUGLtNezWIH6PTRwPt6wyA9ClbAVU5SSYb7A0sDmPIgjFkutEvzu1?=
 =?us-ascii?Q?mGb5ZNBucd9EpzKJSRqb5UpoOxX5/tXOtbTWcI5+B6nnKKJ7esJ6iqsiw81u?=
 =?us-ascii?Q?sijOZS+paj+cpge+mh7lAqfhE10xCohBtmD3k/nm07qLtHWXLUkIj7U00rds?=
 =?us-ascii?Q?mztNNUxORuxOA6sajZjsjoLiMinhrtCebKTvaY9uoz5VA94kpgQZJtiOjMwK?=
 =?us-ascii?Q?GtmxJcZi1hN4z9xzxqcGyHPM4dKuX2Gu47Ev0VqW0Qhw2q+Fz8HJqTNAO8EN?=
 =?us-ascii?Q?PWNs6OnnjF+B6Lpy5fu8NCcEvPENPm505Za+Phg9dvPN6WPJRQjd2I6L8YOo?=
 =?us-ascii?Q?QtYVMPikQ6N0wTEwcV/TUkZNxoLzk2I0iVLF0sukPbujNfeouqntlmxLqGbU?=
 =?us-ascii?Q?DC+wm4squxDlyK5iDycAeSSPvhMUnJte9iqpJL3HaE9MDcXmjxsuWn2k77xH?=
 =?us-ascii?Q?PoudGQMxBCOKawMNExRDSogse7StHpgXMuwdwIwcNwjhXw5F5ZJjo9L5Pr7h?=
 =?us-ascii?Q?DdObax5dmO6SP6DbXfvSgpb5M2lBsRxUlxNxo7J4iGnS2c7pEYan///O1v5R?=
 =?us-ascii?Q?h7lK9gZLkoMDESKvckCWvSGP6jU4r3U+og+W9LUYysYNAg5Trvk/gN9WzU9n?=
 =?us-ascii?Q?Df5yjhedCBqNa6lW7/6FmN/6ZF82oO57yGtN7jL+TVRcICDu2DP+jLdAfwQK?=
 =?us-ascii?Q?+HY3Tkoh4OHxypPuvg4oaqRD58pzD4fVe4HhKOGw30/tys85MxJoydNHG/O0?=
 =?us-ascii?Q?Ve6BAI+CbbfwfpHDkjjxgLXRBqZC4L+QmZ/BqofyXb+WFz5tejoLlUddefsh?=
 =?us-ascii?Q?Sf8q3kiIQg/dvuSQMFYEZdhmUz1SWi4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c636f0-ba08-47d3-99c8-08df1a139c75
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:44.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhzKzQHIxmEBl+UmNTBQNHwncQ468QULKZ/ichWeD0duCWAarcnNuo/sx00QuVF+8mbBRjPmFG+sUPaUMZ8clzvY8fj0bhWJ5B3MnUYCpnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:13:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24301

From: Clara Kowalsky <clara.kowalsky@siemens.com>

Add kas/opt/cis-hardening.yml which sets CIP_CIS_HARDENING and
CIP_CIS_HARDENING_VALIDATION to enable the CIS hardening of the image
and its validation.

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


