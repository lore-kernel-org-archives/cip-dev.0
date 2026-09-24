Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA8C98323
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:23 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5834.1790249777502329221
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=PDuSxcO/;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB/BaxW5x6zZKD1MXTUzPZ9cJiC3inmde7WZOYw6Lk0qdb6Pei4Vr43vSw2pxQBfSXUeJ7lTj03Qx/fCRBMbAm3gSjktpA1Q57rPwtHlfmV43la0McF16gbpwWRnOiE0M1cJQDALiY7047iFN8k6Iu4UTsaZuwBHfL/YEO6DroF10uAikyqfBUsD4Vv59p2LCPpbNWZIs6nUbVrFvXgK6Vn+1qTvkc3tsmfpQy3rMZQXXlt5x3SWa99EfFtz+9T7ntxOBMPPWnpAPaJkquPEgsVp4LlFnYyK3eFm+5zBFMxsGxNHQ2N2ACvi5t9NBe2PFjvGE7K8Wqdp1rKA6RUbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=nlL8tLxaIhq8DbgusWf4w2Dki9CPhpVClJLQ4pV1Ii9j7KEXxeRUBVrSjGDdhGx4dlSTezKBeIxL73pefIf7cryCRPmBybc37EA264qFQQLP5W7cWKNaElMXArSFkv4sCypasM3/jnZD1ccrK7S36cq+KpyoFQNySdRPeZNkyBhcH7em5nEVZRCwrFQDpkyFDzbHCirFHZinjYmwo1jFfrtZuPW7FcTTF6G7BpSy3UJO/eAKCYkySMK9S1+iPNPbdg+I62fk/WbH42Y8AGQejmXvpkPMNN40EI50HJv9py4DgSHHR3WwMPCf1GCNVnvikmGpt5SPTIf2jF9BLBDc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=PDuSxcO/wrv7Xzv3R935zM7867W+4yEScbN+vWTv9ThfIdunKhgfcQYBZNjUZtS+vlA5xc/TvCADabawZ3bH+UW69s40gPN/1BkmDwsqXPifXxWj6+ytK9zgy0Fum3XWY7TKBC933Aen3KoRTAtbhf+3AMr2BwmzciKWqAegsLckSf+KekU2gydQmQh2jwUpW6JKH7Mwoxlc6hCGErvc5kn7K5JSgUglZNK+yxnX2vfw86qxY6Pgv2MOLR5864s7VFbMUIDaIo8Doa8yE1eLcu4mcmCHrmQt41C+3I3rP7i81NyzjEYG9qS6SjtmMZHa5mWZ/a9hiTUqJIKmwu4KAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:06 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:06 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 03/13] Add github.com/ovh/debian-cis for the hardening validation
Date: Thu, 24 Sep 2026 13:35:03 +0200
Message-ID: <20260924113557.3191996-4-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a487319-f163-4d54-0a8f-08df1a300584
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|13003099007|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	5UIrtFykG7Yr5mbFEndQrAB8zRGnhADYvvsTY+B47K9mq3BPNuzWJnhYk5TGINLowX+qXWP58rYMvCMp1ZN3tgIad1oAP1CzLowe/hAh4mKRZb8vv0wHd5U47S2YXvCfWOjBWMTs2eVdKZ0VJMVhemUmUZgkBAKbLJiysa7b70YGpUh8zv8UNDACU7IgQW9mwhXCwDT6jXZUIpQf5nDJEdwIzSqHBx7/fL7vs6K63eqb7BzVJ0xutK8jUljX+US05DB+1B18hiLTW6SgC2fDNF5UCm6CtLcYcs/TioVqVUk34pAM4oBs4rN3DLkgdtlU2Y+6xYHIsW/GWRAEFMO3OCKxgcx7p8QYteLarZNrG3rrrIzbBR6Zk32ZrXUM6YbYpGK5wRTtPXUIfMjG26N5ZbLFrBM2UroWeHnwvbuIsTrwTTbcOgVHchhEiW+ifGubp/qbPmJuasioNVoKaYupmY643MwTXvx/BGEfCIxd2ktM7TTJK4NhnjOCNpHwU8bSiRcN/4GmskwUdKKCdsS/GazeC8JhJ20evK/ih+Ts1ZKo/GQSdJ3b6c5JBIS7SUT9x688Q+X7Qjf5l5YbUJVa7nkjMptVDyk00Rm+H4DHXTenMK08Tau7gSIG+JiHDVlh1XxgP2Fm08/vARLfpeUI8FV8SNRTYkHv/XLRbWsoz7A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(13003099007)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VTSf/UUBUgK5y+XZcKN09c8E1mdJzTSCqwcxcVsJJK3bslIr5hJxyP1ZMsEG?=
 =?us-ascii?Q?9SfZsuheCyjm7uuefUcIy4e6AfSXluZAwFa3TvN4KdvTLpcbyi/vP3bH1RlR?=
 =?us-ascii?Q?3ilxfBHcTjpsl+KQWOAIAYGeEkUu86ZWcdwlQxO2SOUcXvbNzBAlKOpMz4ls?=
 =?us-ascii?Q?CI2Ieyjuj/QscFCgouQfzncDVf0H5LTib0U2PyIEBOnFWizilXEy+wk3AtMM?=
 =?us-ascii?Q?Z6mT9/f2YqDcje9C2ZegW5XkHd12zTbrku/5D+in2/gENushnQhOWaFC8mX3?=
 =?us-ascii?Q?BoEGoBzLfawW9UWPMgMsHXYbDrIJqbDqBh9Lifk9eyCrYsbx4CARaoR3wIbp?=
 =?us-ascii?Q?wUBcOhiOOg7x32XJdWNzS9EHvtYdAMLq0BDIIKXoxNiNRbc18CtFLjA/dJAl?=
 =?us-ascii?Q?oMxUJhxMYlkTeB4IX3MiNqYwgWJXy0l9E+Owpm/yJWU0gKXZTfWAMFhfctTl?=
 =?us-ascii?Q?m2QBB2I75hTVEG5WYeVuFoAyR7olQYLosi0O6M6S4XXFLIe3L3U30+nX4k92?=
 =?us-ascii?Q?8wh4peLSu9eLSj8wcZtA8j5zcCMLCTBaxkm1sDBgcf4Ha3cJgw8TT8LWCBep?=
 =?us-ascii?Q?mYyeVcbd/E/defLkUNqbjjND85NBnMOUkb+USWv0vkNv17tdXVtN6T2mvxWe?=
 =?us-ascii?Q?QLJpPncircQsk+ncgmzBDtCvz5R7sCHrOLKwU/Pgd57yV87j3FjSJ0vAm1Hf?=
 =?us-ascii?Q?0bOuzR39Ph6wqu4RwdieQ7RCjckhw0bgYqJnWVrx/IpqHq/5PlUmBhVShHd0?=
 =?us-ascii?Q?CPdG3OC5XTn3RnoUHnzXC29B6wtoj0NiS63LpTdj9bcsv1+boOuMSY6xdDkP?=
 =?us-ascii?Q?48i9nDA3MguZGT68T6TWjfUPjBY2FXAXBAuAPtysMFXJJORDv6Ta0HdERbpS?=
 =?us-ascii?Q?9BOCjK+ckS8rUSbYC7dRrX0K7fBP3/3eD2ksLGz7ncMXhRo99PLyH6wlU1yj?=
 =?us-ascii?Q?SGf7eGKQGHGA8QVRG5Ne+YNk0fdisyRHk2FE2bMd46jLZYHLU/aZXqLeSiG7?=
 =?us-ascii?Q?keAfJ/yiHaUk276KX8ngYKgwLgf1vQcAXglss2KMf2LyjiGShmvEM6p28qQK?=
 =?us-ascii?Q?9mu3C22Yc7OYjYVDGmhFsc4Cg3ZLcbtyAx0+9N/2o81g1fCKhLAZds/o0U8t?=
 =?us-ascii?Q?ZX27+QV397sbCN41f93mf9Ugq7x0g0rS40tVtqmtbxifBYYC/sj4t1fvDCs0?=
 =?us-ascii?Q?qAY/B31waaiAGpWY6NgJ1+vCox/nzVJBzEEEh/kkY1Ni91r6lDUY1eesuGso?=
 =?us-ascii?Q?MLWIov/Z+OXAwwFOT4orfvXfSQpmB/jbDYzpBngjCiKP+D8de5pnytlz/3gg?=
 =?us-ascii?Q?IodD3p57kzN3qCKak8FnjbhzdACVybMpVR8GGjT4lpg/YjQ/ruCDQK0Bmmsg?=
 =?us-ascii?Q?5V7oTqSZmc1OCdQQzKuzFIwQWKXpts1F+417qbtDYg07cGn/EhW8MFq7Ns44?=
 =?us-ascii?Q?E5RSsgzcaJH2xo/yc2ZoQT7h49feDszvRZqQd7qpxztDixgdJgQSoxPCNcmX?=
 =?us-ascii?Q?k4nlQhIkrSBbXiT29kYS/Lj2Op774FPWVJN5t5RZCn8HvSXmCu3iopk34ZPI?=
 =?us-ascii?Q?Uzvs0a3rvrYFvq8BeYb4XCejM9U2jwhMNrMTK+TNPKGg0m5zfUQrP40/213u?=
 =?us-ascii?Q?99l4RUsJLWeZZTFD/2yTG6Ir2tPQuw4JLRV1siUpc3TFUM1j3TC8asFzeW8p?=
 =?us-ascii?Q?0SLZtdne065JHEJgBzcriqsTfW/U/QrsxFF9tG48HOgwhDhcI4Fe9nUqyNmI?=
 =?us-ascii?Q?uqDY3nF9jcMEWjIqx3hE6UegqleIQE4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a487319-f163-4d54-0a8f-08df1a300584
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:06.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGk4fZKOMGdJ7WKbv3glJyWVJQWYfCDSRMNeWmZMf0fW4/FaDdKSIKoeiaU2veqRjU2dwbTxDOIUMIILHrjpFMdTQruP4fGg9xvScSpfpiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24318

This creates a Debian package out of https://github.com/ovh/debian-cis/
to validate the hardening level during runtime.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-hardening/cis-hardening_4.1-6.bb        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb

diff --git a/recipes-security/cis-hardening/cis-hardening_4.1-6.bb b/recipe=
s-security/cis-hardening/cis-hardening_4.1-6.bb
new file mode 100644
index 00000000..4245c45a
--- /dev/null
+++ b/recipes-security/cis-hardening/cis-hardening_4.1-6.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+DPKG_ARCH =3D "all"
+
+SRC_URI =3D "git://github.com/ovh/debian-cis.git;protocol=3Dhttps;destsuff=
ix=3D${P};nobranch=3D1"
+SRCREV =3D "efbd5b35ba32226e8950d52bd3f3444c702bbd84"
--=20
2.55.0


