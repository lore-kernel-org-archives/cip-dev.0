Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15681.1794914933922263860
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ONx3DcV0;
 spf=pass (domain: siemens.com, ip: 52.101.84.18, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftABEJ8XJagkKEUOpPR4sHqYEaQTzOPjueujIpTmHTL7LecQtp1HZ1kthi3LJzR3gg6eD0d++s7HtoSBEqaiRJRPoykxLkQgjQaMn05ngdp9N2DLj+Dmcgx01mzwUX4Awvbygsw427JLtPBZjCNJgnw4ewyIIWxi08fTH1m6R2shuw9XyIUlzCb/OjNsMHx3vrL+Ce4mUWEAcOhbTw4Lh6tDU0YFfbwCIEQW+eYgsY+T7PkWvQdbnqEWxzP04v0zgJewzar1WWp4CGK4/wmA7ATwQFm0CNiZVv5Iadb/EqbmE/wDFYnZHjkgOJioZel0EBOf+I6geOEbiKOtnvlckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4u17N4JpcT1asdVMpl4XmURJWpfx9C1HWFm7BVMOU4=;
 b=DSoo0aqxJZeJjkHrV6zOcsao9MAK2qUoJ90Lbd42+p47Tu2nK5ik3BKJMOwoZZeGi9zINVmcB7H+ET1cMkoGBy0FPoFVNEhO+vCE3DDyT3HOmz6ppSopoFWZ3wbMpvS+k1hU6C6PfEfSXS0XZwZKh5f2o5olEHjBX+ZBsXuaWxk16qCGRJJ20ovCkRfQB0uD9KE7aLHKfLQ2Sr+RtveqAEueSY//SYmGNZZ1a4ZDAybs2gH9HgF1vK0zXFHFj5wMMMcwHict9xNGaKlsaWUgqqBngPm21H5y4Sj/HrL7yLi33E55SALFw2Bm1PShSNMaXvBVr9+0FV84XQ0F7fYVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4u17N4JpcT1asdVMpl4XmURJWpfx9C1HWFm7BVMOU4=;
 b=ONx3DcV0yfVC4xkNFr6JAvlffAxhrNcTImxCRNJt7AKO6tP6yzYM/t8Pcr6+TWznPG6ApeSc9yu1HlHvNKuN66OywlEJHpiyPf9y2cC+dFIZcYNFKgCfFBEQDf27g7L9FOweTGsM0p9NsIx8KObY5EX48Qj6bhVbjP319e6o712W7jZz8bUtk2vmM2BA2HNfygTwZo3okuw91HM+sWPN62ayd4ZKOBWO/jfLrZjRxaskAbzbavWAefA5qR0Omr+Q9EQuNn9seIabmIcZQqxqaOaWNQ7HuXWvNd57xScNOiCCptbw1z1jQJ527PDtrR3VGfG8zeEw9jFKTipiu9O3og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:47 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:46 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 09/19] embedded-dracut-modules: add recipe
Date: Tue, 17 Nov 2026 12:28:23 +0100
Message-ID: <20261117112833.316234-10-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: d241edef-39d2-4176-51b7-08df449df0ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261102123227099003|261009223327099003|261009221727099003|261009221227099003|261009223027099003|261009220027099003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: qZxXTxuFWv5fLc1gztcVcY/MusMyGuEb8V3cBcm+0WA7FmjGpAektp9zQ7ane0XzTw7u9Ph7oMeQb3k9Lkvoq83mEQKSQdf2N10f/akzbcDdJvYISeTv+0gU/rLsbv36bXs6vekbnLvjIGeEEg7fjSawKdNIcWKK+vmIK4DwzhDAXkVI+LeOjaj8gRTZZ1RtRD2c4zHZH6YcZ8vmD55svEPiuDH80h1MJRkMBXOqD2ykPUJpuZ2GfKvMVTFmssuDJmLo3Rm/bebjoahKuTd+CODOpiWS6taT7fuwWx/ycgH2ccekhTJ9ixQnqLU5Iy3DQY6yrnqUUlAnkhnSD5/zc0iCdmRhO/QjstqW2JWeOGiKZ8vXWLq7JXQWQZcvxNW/c0DLlv8OkLEmB/b1HtBD3kkLL2fJBaCx7y3oAlxvyY3Vc6Fst+OOCWmf+cs1h1i6BrNRmhQnR27I169BFw8dJjQdpds8TsUuWX+vh5Y1uFwhfxJL/q63otbh/1a4vJ1tNE0CcOku1ybg6t1EaOy6J/gzx5MnqEoB84mGh6AMKIiZZCaIsuybliCyHZguT0jfOBcjb7aPoVv4Umpqluu4AVq2Tn6CJT2KuqURIEa9hgGlbU/C0tWuzhsyOt6y1ONEUXsfDaHYv3v1V83Qq23xDsATYsnNAdnqWxZyUJNusA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009220027099003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gy+b3WkZUjgWIN0N1UPmM6yta9KBbpWfBIwK4nn5mspoj2ljNpM95a7Adz3y?=
 =?us-ascii?Q?8WAJ230eeBpROTjuo+ftFh1j++YRjKv6tsE0SOWl07wRzLZI0Jn8b8Mv43z4?=
 =?us-ascii?Q?SVLWpR0J/LQnbkzLjPxdP2Pw4PTQrcggts/Q/fGowxenetcT0PKtT+k3TvQY?=
 =?us-ascii?Q?S6jWQ/yfZOQOuP0qWE9yWo2Ye2jHruEtptiqAb4AgBT0G2CJNtuH5ulMOgUQ?=
 =?us-ascii?Q?iNXssbdyNpmJLlxbt6432DI2MQhb5TgrKftu3jY26qeS+1EFJmTYGKgYU74l?=
 =?us-ascii?Q?FeYbeoGVNV8/nDpa2JdUr7CkeSZL53NNbrfTayo/9PuY+5tM4oV/6lbb1N0N?=
 =?us-ascii?Q?uCw1ScWSpQyMbtfBMvhtqMR7sPCy48DDw0XJDl5VVIUVhqOGEnduKDIinTNz?=
 =?us-ascii?Q?HkjRMBNtKM8YzJ8xLTAi3d6OVv4C8uC9OimgNG9283W0aOZkLVEUP597osM4?=
 =?us-ascii?Q?lEFPEFAQIfyzrxZMmy7nIdtsUHtrgqm5oASPFBraVViA1lAZ12IR05E6g/wq?=
 =?us-ascii?Q?vV4B0u4O/7OJW40LFHqtW8xWGmW9f5ps2C61O69OuNLobRQqfDrt8lLQ4rGE?=
 =?us-ascii?Q?oULQBkf+qTkKn3y2RWvNRG64qTcEhIToXn9rdkvHWNNOcJQgsIh/pztTkwN6?=
 =?us-ascii?Q?wwCwQjCrGZfRJ7NfzQagmgs31ogGjzs6OuWOwXql+j+cyDNafBAbGF30iAVH?=
 =?us-ascii?Q?pO8Txz8k7Vkg7gBpKP7Wj+xp268BlgOa2zNfiJcesXvcBpORAx6Ntyuotcn+?=
 =?us-ascii?Q?efiCBSuqwMykF6fXpbSEUv3h1ft99kyXaVzh4K8WFTulgiMKnMaUuwDaiFZH?=
 =?us-ascii?Q?e7OypQC3oim43I+v/2TivXzr+ZYuHoEhfinz28wRcgxemrlHw4txvBmu2bUR?=
 =?us-ascii?Q?stvfIcRwWCcIWp4A0PFO04pdoMv4zuyUHASEQEteBz6IH4QhxZJpJFjU8uoo?=
 =?us-ascii?Q?8Yo4j4itAaW7TA0VhtD1n8vYogBXzInftXEUNHu9T/rWlHx3kax7ntbOf/VM?=
 =?us-ascii?Q?qtTurDn7hPdVybREFP8+3cRoByexFG48uMn2AssrcDtk3fTXig8UlbGP1b46?=
 =?us-ascii?Q?VTzfVxPBEhngXSthgWdGUuJ+xyTZO2oMP8ouftwNZQS9TrXZ3Jn2J/sZmTnE?=
 =?us-ascii?Q?B50yLtW4pw6uvuTX2WFdXJOlo3MN9zuM3i7a4IywUi4Bnr5P1XxEIPvNs/53?=
 =?us-ascii?Q?5teUWfqQS2wNHbBa9fttAml7c3RiBCITr6dAD0DLUInMjfBRzZHMToWpijYA?=
 =?us-ascii?Q?J7XRn2rkdNYZM660A8rDGNs87519AmllsqnZv6DNeIcVAfwSrENPtuBM3iPO?=
 =?us-ascii?Q?yG8xg+/aa8vijxoz+VbGMKeHPR30WUvxxyAjxprGgkU779MTWOzph7zKO+++?=
 =?us-ascii?Q?+k+lAb30lk7bc3eJJthuVfus8Y8a/42VIkupLGsgWT3m23EdvwPfqwCe7HOr?=
 =?us-ascii?Q?t7twOAMZcnN4Gs7MOrzpahgtgRQ1JwJKHmh6Wzmr48J+q6RC4eokyQ4itRA8?=
 =?us-ascii?Q?uAEPiK7bZd2aISNSSWJfjPEYVL9jfwA+YLp4ZY8DuAbPdeFLBtjzr02CfFaW?=
 =?us-ascii?Q?E8j7lEVRToX5jS/NFucrwsypEIEOUTm5L4X6O9W4T17AJR0BQdKndXLn5PNp?=
 =?us-ascii?Q?aKMfpYXv9FoXfagHezZ6zZ+i2PbAeb6Cs+5hvlPaUS65Nfc6IUTAdHkmuR/Y?=
 =?us-ascii?Q?2Nmlvp91f+liZkDFsjIQAjn4sTXrXvjCnLfnzD55J9+1KASYyNG8MwNnC8Ug?=
 =?us-ascii?Q?LZ66uPOD/utnJxgzaDi7qMT6/K+F5ys=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d241edef-39d2-4176-51b7-08df449df0ab
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:44.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NON1LT9GZ/Q0qFAqVu4mOsLc3yYM8lRqfNXloeL2iT6A5LCOBYrHD0KmJ1nlTpGCZBdow8gQibkqeB04qcNHlVriHuzRXd+/Ahq8qOWmCqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24833
Content-Type: text/plain; charset="utf-8"

Builds the dracut modules embedded-verity, embedded-overlay,
embedded-crypt, embedded-factory-reset and embedded-watchdog from the
external embedded-dracut-modules Debian source package. The modules
replace initramfs-verity-hook, initramfs-overlay-hook,
initramfs-crypt-hook (systemd backend), initramfs-factory-reset-hook
(EFI variable) and the watchdog handling of the latter two for
dracut-based initrds.

The package is architecture independent.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../embedded-dracut-modules_0.1.bb            | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-drac=
ut-modules_0.1.bb

diff --git a/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb
new file mode 100644
index 00000000..84852c57
--- /dev/null
+++ b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modules_0.1=
.bb
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg
+
+DPKG_ARCH =3D "all"
+
+DESCRIPTION =3D "Embedded dracut modules: embedded-verity, embedded-overla=
y, embedded-crypt, embedded-factory-reset, embedded-watchdog"
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+
+SRC_URI =3D "git://gitlab.com/cip-playground/embedded-dracut-modules.git;p=
rotocol=3Dhttps;branch=3Drfc;destsuffix=3D${P}"
+SRCREV =3D "7dd108990cf30016308415feb0627e586ba29e4d"
+
+PROVIDES +=3D " \
+    dracut-embedded-verity \
+    dracut-embedded-overlay \
+    dracut-embedded-crypt \
+    dracut-embedded-factory-reset \
+    dracut-embedded-watchdog"
--=20
2.47.3

