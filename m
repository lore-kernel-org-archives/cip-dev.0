Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791BC9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:22 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5788.1790249778074354651
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZYKT6I9x;
 spf=pass (domain: siemens.com, ip: 40.107.162.2, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcq2OLWMTeS+zgubErL8UU2FqeBFfvvBDQABJaggeWgw++yyuOKBh0cmp3Q89H5q8YSa76+raLzX1/inOOHimEn9z9VcT87zNbhU+Zu6Lmy3F7PFw7BBW5xxmVk7rL4e6qZsr3HqP7mUpeZ0UQ+5WtUcb2esHZTIfjYfNF59m6OTL71yh60GOYeBpZOuDYfN8uAR1ABLwNWUkcMAcd/Drl09RVkYUkBinPNxc9wQIMV/5mpN4D2XXYCjB7WdoTyTMH1pXQed2js/7o3Jg6nOwusahnVCv0cFuxb0BZr4rLRmGt6jBHfVM4/+7wUs2BMKbMF2ny9GNWrMW4yYuwG9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKFoT2KVo3LSlEjPzInawCz5F9gzs+Tqj/Ef8QDUpr8=;
 b=UfTreaU9kcfHN7Dh43nHVkrG78PpMTMfv47py4c5pjLHVXdDp3YqN2yU6Bs0o2w5n/ea7xyVk/2yDF1U2TBGWQG5K4LqMzmOt5k6gkGpY93zruB7JT82dEzGAzo4klbTjZGkVuJp82q1r0aP04v09skcM33HcpwQym1YOIwZJabt5gvpnod2yVE/8Hp5ynJlMJp40AiVwrRu1QKb2sLs184S9DrlS7ckJhf/2cPI8qWQpgqPD8PpXG6jVs4AxDfwZSkOoAkJ70+Zh3ttklXRGr3g9ybBInI/dMgb05iijFZBMTSILbasMRK60cf20LufHxS1Gaijpp5aueQyeXcnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKFoT2KVo3LSlEjPzInawCz5F9gzs+Tqj/Ef8QDUpr8=;
 b=ZYKT6I9xiuOrUQOYLMH66lgIR0gF37iYCxjGGT+DYqM7hUq71sxw9VlDpezaFfUkVESgaQ1S6aIeiIEsIZJuOgdwjEuECl7jKbNMqvO9ZTRgmGzG9hWHUpDvSWvHcAO9Q8bf3qbNZMFYN6EYbTMOWvt1vfZpAV/Yc1ROhYNuOYwaE0Q0h1lI+IffZUMUBnnyxJHuMut0TwSqqrTueqhWDTsNJtlPVNaNLb4pawXnZ7t2fFJNEZA4kih/UZ/wRD4eKI5wVqFfJhcXJ2WOfBTMssyiBLgxGcre9H1GBsHMkCmI1dgZb12a0pXlc55EB+8wKApycWRygGpS3TOi9dMfaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:12 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:12 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 12/13] Add kas file for hardening configuration
Date: Thu, 24 Sep 2026 13:35:12 +0200
Message-ID: <20260924113557.3191996-13-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7cc7c2-521a-4228-38a6-08df1a3007f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	FN8rykwdYFoDqeuevKNA8NCJpsuvAAHGkOZyWIRK8PhqjkUOFeyFSr8vkHlObGHGp7q6SSyoRIx8kO+8pyElrN2lBPKPazMKulHyl89SC7fYCZ78trM4o23A1OM8H1slTHyt74h7XOUqwl+tW2Gt+UQV2Sn1DrEjb0p5+7byXiWh/AjmVRaCCUaFWT+z9fgQkGDtz9RAjwxOMzQYEvY7zSFzgcXrd4Cpkxh4AKa6rhw8/ntB0RHb+OxK+mD7vFAv7t9A1vB6sEUm4zz4h7/B+2JffO5cfBvNVQ0ja1tReJSjjsVxUnp40FiNc/0xkmvQErAu8vOnzFE31rHQgPDj2/opPhaZYrVylFImUJBAEdX8MEPXiWuujra5p4YxetKI9zRwi1iIxjcFGFS1IPiargmnJYDq5J/zAcQ8VJHxNSBImnbieGIFFajn2wY70P8P15dXbr61DCm75GQx1B5IJKzPXvsGeDmk1eFr8a7gbRrBQgaSVCAQdruAGQWIkc2Ez95tx8FPiAsTNmjhXkhWLfHd5DEEauRzadKgrwjLpHAXWKRB6h3B+n9N9UYWVgN8mY1jGsux91q2dfkhHOIms/DuQ18CIi8vxJe8YwWIPzNBPzeylmw5bclpcdAiKoQ6IqXHuYLAK61rEMV99yfYy6iA1vRMevE3RnK2QPp1thw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yS1HfY1sVYY9z3zJXe1LtktF5lxPu7aUq6oDeo5yeflx68eq46TBxM7pvWXH?=
 =?us-ascii?Q?TrfU07vSlduYJPro1RfRJasirZj85TcbcBOaRE76hxpsoxn3cZGp9IsdKS3G?=
 =?us-ascii?Q?AuSBPNJXS500vF743mdu6Fb5aYOQG1KczSxldBklGzxmbZYAvbDaSTuFo+d9?=
 =?us-ascii?Q?t0JUrPHg0vlXcnDN1gYYCPB0rglW4Qo66+wwxm2vqnKErfkoWNHn7JG63gZo?=
 =?us-ascii?Q?jeVlQesuWwxcFr4kmyg0/fJOJsBnHQLc2luSLS1JkT1hVWiMA2l43MAbzWTw?=
 =?us-ascii?Q?LeOAoSRR0/neoLsmbxcqVMGH8bJvLCiHGB43njBcR7PqX5hhY+YUNcKfaFuA?=
 =?us-ascii?Q?gWDHVGrTXt3AsbeWZ/AaEwwTA1e9YYbabkN8gx/4CfBwYLqf+ieANIYivXfC?=
 =?us-ascii?Q?r6TPnRGgvE9sE8tOwLPi+kpo8qkdZSjAyu6Yz8+nQHzxwy9zELr1yMZjjnBp?=
 =?us-ascii?Q?YITA7ApOedhj9ZxiR/ArlQNQKnwcM/YKknnCcqV3OH6yg1RqQ8UUU9+vwwg8?=
 =?us-ascii?Q?jMV+jllSSRnde0l6sE83QBB9qI7QfMvdKD0VKZld9A6e1CQzcQbUWMUWQjg9?=
 =?us-ascii?Q?RJYBCr1wOAvicNxMJWp26i9SD9IX8hA+nc4RmRxIAvxAfzu7YmFApM3qdbEM?=
 =?us-ascii?Q?JplAdiEXdpVlhXynyws/39XKtUkruELlnMAwn8DmczOWYwcM7BBh041UOKSb?=
 =?us-ascii?Q?jXokJT7UgI+hQiTFE+om45hnIwgGcCk0DsyyVHQjKF6Hk2k4b9AXJlx4VH7O?=
 =?us-ascii?Q?eXXkF/oj/6xIjXc/PjSm9wRk8ul1FIozOwWTPjA42VIH2X0XEoiJBZP9mzaw?=
 =?us-ascii?Q?GOB1RNiew2GxiUY6S36YeFO3ijV83nwndfVZqbnmbxjd5WeW6NkQVyB2hoyk?=
 =?us-ascii?Q?dF5c59PgAIwgsV1jiQc6wvOluLvt7rpSbKtrLD3LOkZq+p9qIrZiFcLHCUVV?=
 =?us-ascii?Q?/owK5ZkMhPwqwlVVZb17NQCdtsA4ZM0M0ZDEcHFMsmypvU1rqVCWv1ZGelV7?=
 =?us-ascii?Q?q7DPSM/CCa9ujHdGrs+gUj4B5sCKFfVYA/vhrP7F6F5qsNIaHPpJWakoz1/F?=
 =?us-ascii?Q?FMXRb2mE6dMIyMahD8GNlO6ynAbX9nvMFwZzOyCVl6w3Qp7JFdKB2KB7XPWu?=
 =?us-ascii?Q?oXTUwgWfHWhGE9nBeAosMktWs2Sb6fU0dFBN3ICOwmeqESBdPLxechqPXvu4?=
 =?us-ascii?Q?8+GLTrrryk7NUPzLZILinMKN+m2qqPMg6oM+DiZLdBqqLe9RNjqWmL5DNU6z?=
 =?us-ascii?Q?JMK8CKxDuF7jMJO9EtJnqxUDZsUV1Iu2zYIrmCFTTCe5QYu6veMwGPDhrh2X?=
 =?us-ascii?Q?AgGlCzKshJ90UVjBjtXFoUYut+Tw706MTTq3od6iY8qoLz+KyZTxQyquHpGD?=
 =?us-ascii?Q?tbBplGl+G4NyTsFEpKtecjMx56v/LnRLA5BsmSwZwIBKDi1QlCU01xi/nkT2?=
 =?us-ascii?Q?MPffhggjp8DYS9IThUd1u8RmU0Je+f7eNL6hd3AAvau+9PhCz8gAWknLMmic?=
 =?us-ascii?Q?VQINTHDjyRKUchIcn/aIhSGTKSU+VwWkXg89emMOxhw+1Vg15ON+Q7MbsGX8?=
 =?us-ascii?Q?82XzctgmMHvr2OKEAg0B44EF3pSfota3WIubPuu5CnJq+h7oyh5VV2pDT0rC?=
 =?us-ascii?Q?ggXjI7QDi8nB90+tWpc3b4sRV32QUUnyyx4f8TAh5Q2Q7r9wjBDyVrOy+0oV?=
 =?us-ascii?Q?fgNMQho8PlGVsMs2v+xTx7M7DKNABv0dYKay4jCUNrq9Gr/w/O1sCClUm2mB?=
 =?us-ascii?Q?ERAD+5uK7qWp7A5sFYQ2Gnz+dxPCabM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7cc7c2-521a-4228-38a6-08df1a3007f2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:10.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4hilLyxgPJSfehmzhIsnad8rUPsPHbvmKmG7c7khsrh02oJr9CNmXqIRZMG2fgXn07a9IWyrcPSxAEdnvxnGBo4Wb3XLwZ0dWha9umPsrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24326

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


