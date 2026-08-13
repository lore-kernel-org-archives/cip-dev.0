Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F0C5DF6E
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:39 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16258.1786617575466080224
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=y5GusKtQ;
 spf=pass (domain: siemens.com, ip: 52.101.83.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXAUBEQrrHFp0oqqrwQwzwS7fhcvTHGaZv4dA0rQjjixv0q8U7KBY8MepvWcUbjY4fhm7DWrTCYQKfvuwcSxn7TaZCk2tmdVzXiDdAPwydqq+o2Jct2zbq462rqeNkTv5VVPibCF/cf6p2G6sQvWEXM17Y2R8SVJRclRuZYge8F28yFMRsGdtqNjHhLUfRKJCZU/Y+nJLEahRAsFTr/67ganOJpZGN9Ax01RFy8qL0Fk/yz+f7fJaRoGvC5sZo/dSX6N1opq20a76hdOicuBru9XmkRi61gBW0OinnxDU+QrjFZwVu3sMik0F8aiwN5QzTRiBmunJbtke3fOcQYAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFN4ZY/4jwbHozfIJmxhWpFO5P+CHVFcwnLEhFH4xD0=;
 b=gN6RONhrG3xAw6GOsfitcONrqeXhBqOrBo82V/SOvR+OZ2J/bnSHwl7s2Iu5Lhd47x/uluE/2kbsF4OV+hG7DDVi5iQK3AVdAU9igsKDOnyeiBejZJvFs9MBbLUunDY7xl2HJke16TF6W2vGD4jJw3qX9s3T+EHEfiBYZkkT5p0nkBY4vTIt4Ny77wo5Chj2etSQbv2upZuKQZPNyHxknmWGQ4w1rk7a00j4S/dD1cRQ8OrUNrbyv4oSjtn8+mCeGKm/mg6a2FTVWhFmvxfQoTNAfm277kxkpX0m/piGkPHHZR9VIsCBbJ6V7b1tCkCvXd0QAwVkUyjFlW+AZPXB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFN4ZY/4jwbHozfIJmxhWpFO5P+CHVFcwnLEhFH4xD0=;
 b=y5GusKtQibUgm7fB7BS2qAD/Z+Vw7OL8KVNROkoyKeO5BPfF2yGCgNA9ffzvRUN5Lu5+6tvlFOXHi1tRBKV/D12B2WpqQJnUKkukDfeWkkBOtJVQqgizLkLPck3apO/fLy27ps/vB9yzSDnIfnLWxn6xOcgGx4kmYXmdYzzKavbrUeDvnrrX75rfndA7s4wAlKKMu+Z/FbpdspXvwbm5yTbZbgnfyZ0VE+OppgT7Z7JLo6njvAnTHMe2xl+YfzrOlFcL8t7zQ59DvHKXf5qjqXDJcUOzNjs5fXypxkwVV2VFppMJ1jbGP/Vfi2LFKNT0qOE6x2aRpxr5ZcTO29Pqjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:33 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:33 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 08/12] Add class cis-hardening for post rootfs generation fixups
Date: Thu, 13 Aug 2026 12:38:58 +0200
Message-ID: <20260813103919.184402-9-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 613b3d10-a71e-46ab-d0d9-08def9272976
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	/7f0hjc9f2oOpyx8M/3goWSywEQ1VAfvXTzCQvdLvY2trJW2mJxdhIMpyZkswKg07woczJoyqYrrVRY15dw1wMwX56BeLA+2MgwKaE0hsAEEZnrh7PhJYNKiYuR/7pcMlgQ+YdCVFv7qi7rBsFRkFhW81O0J+5d/0jz12OtU85KtUEEb6X2nGqChs5vpApz3So8SmH+kmBAoGHLzZjG5Xu9HlEzoaHWnb59KVVW25LeabG55YWkmhgKItG3Shl83MRb/3+hHPYbn0dtlQ09iX6eX/H8w4flXmVMOFkCi3Lm0WSooEdpItpZMFNIbHGX6MQIRMm3UVarsHgTY7ovZmJvRmtooh1zkYmNRLEznctTpsU3tkICZrr1Wfjysa8l2CVWi8JZtufro8z9sIJp/upwUoRqxKsVJG+QqWwdluW1fg1K6Cxf6uA6GL3okwQoGF575tzIivt9Lw+JhzE5EDYZ5gBOt1Vvxq21w0eLb54drml4PnRVQSIh6DPFWGeIqY6bfcyJI+IDjg7yLD3qAiubC07yrSDpktvcQVYSj9dIkgO1GvDnPqBUVly3Fx3Penx1OEdJi27eq9ph/glmVtLEmDhcRd72s4/BxSVrNrf5ISRwb7m/bNqgzP6Aii5yyynbSrg+UT6dfBf8/Zr8rclclcD+W1sIwWbGalGzASWc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YiUKEWZhvwgQB1ZL9WnxlAwm87lnMWhy0oWPMqsgGUBGiHKUh5/APzKW8zy3?=
 =?us-ascii?Q?UMwokTWO9jpLwlzrUNtfGIdXZr/wsDdcdwrVY2OeOZ2GEHoaoywJMvk97LzV?=
 =?us-ascii?Q?Mx8tj62ErNoQ99I7GBTcGuaTSfqOtK5GWHZIHI8SMGDsfoNWkRz93+mHXPjw?=
 =?us-ascii?Q?wRWRONInUsMi3/zbpHmU5lcxYxNKTV9eTvzmAGzkpCQMz3iguKb8zuPfnN4W?=
 =?us-ascii?Q?BZ3Z6vBPXDHtPp3RTZPmII5+Mnm8ahzB3XfLAmriXBmJ8CB9Nc3oYUGs1n2y?=
 =?us-ascii?Q?HhuOVdA/mbe3m55TGYP3D1CTHf+YrCw5Mln6bEPkJI/4HoWawJnrooH9YAe8?=
 =?us-ascii?Q?fA/X19G4N+thW2hahB8LoXUXgdnc/qGiAKlyM1TmSqzR3HRfcWRYuxbwfL83?=
 =?us-ascii?Q?xrNMFsaLEewb25p8x1nYQg7sw0fJ3Aylc9xvEKW0556cK+s7BjnV5QVhnFt2?=
 =?us-ascii?Q?1+A2VjNGU1txquOOra3DAlwir8rwrOu1HZlw5vyMKv02T35L48Zw/S6Uq7sc?=
 =?us-ascii?Q?GdUghBcJzNYbSeIvcErV4il/99Mq6Z/jfZ+q4l6nN2pcqsbNjN8gqfoz/oks?=
 =?us-ascii?Q?+sV8JH3WmBU5QIP4vwd3xC53b3VXPfYPC9Hy41Zz02oLpDjBhessWPWoiAju?=
 =?us-ascii?Q?BZ7Y4oOulqHYb1UZMl18JVYxCwD9JB/Ovo6F/xWMxTWQQj0BccSARJvSTfmG?=
 =?us-ascii?Q?wOMj1MsdDf6kqt4Pdq5eVyvTIMyh1mmjnCYahbA/59SNRYUR1rHqBoRWfA5P?=
 =?us-ascii?Q?q+dDIkKyVJPV07HK5bVeHx/NkR+wSVxCiBqZoJXRb3qyvyRg1YiHLqL0nR/P?=
 =?us-ascii?Q?Nmyw0n/RfOyM4cqZpS96Lsf36ugBH6hhaHd+5CpVhDNqxAgence2a6OdeT8A?=
 =?us-ascii?Q?2Ji0Fdp+xvX86F+xuYBcM534868R6h23QLRrcxNweFJEo1KQ/FHaMcO/bLKF?=
 =?us-ascii?Q?yuA3IDPzqqAeHEZR2fDPgOeNLZG4fiWQ3jZu6w85AzZjh87WUAl2XgdyzUCb?=
 =?us-ascii?Q?FyIbCFsGt3BSOo8APsZmOLKXKFv0RGW0V+LAiGBhr3cdvMzeSUodtPv7gcv8?=
 =?us-ascii?Q?BmmnqRdRioddqasXMQ82lWUzXlqDt6MJZ8aA7LVWlQ1JDYwEaQvGQbodjn1E?=
 =?us-ascii?Q?bFmWNdxas4tdAKaJJp1Feggv8eHgc5F90vSZyeAL1/YFQJNGY4mOumN1BMFp?=
 =?us-ascii?Q?yONkXYqU9GSrrNwRqWdfP/Ip6JWLik6Qq7rmUdqyTo8CPvYBd1Y8clWYrdJ+?=
 =?us-ascii?Q?GPWzKfMnBUgC4SjMYHkbtE8IZWgYH+E8ucvhaWZw0/HPoTpECK0yLsopUKCa?=
 =?us-ascii?Q?FEQnMhG/DZDmjNDtETQsLVs54sXirgNa8Jnb677+o4xLS6ztMXRr+hQlWi5u?=
 =?us-ascii?Q?wZjesiBnjEk3vO71l49mzocQKVIhjYhP42q5724MrdTk4jG/9mJsBwCzPayj?=
 =?us-ascii?Q?peKmUrCVa9TeSUOnbTd15RNn3sr64k3jDwUSf3EMOEc/s1ui0r7mi3PDau1p?=
 =?us-ascii?Q?245rpqoIBgG/o0c3CoEfKM9heRPJnodCwqEmTqNEiAJcK32cMzQVnA6K26N3?=
 =?us-ascii?Q?fjAEfCmSb47U/NfkqWnG7SIy2lJ2yhuJcqINC2uTtkXFJAXkF7T2EbjZQZAk?=
 =?us-ascii?Q?HKkZDpxZpZ6ldn0SDCRarzmt9Qju38r4QsVmNxaoJ/GNr+z6Vi42/RJz/Xlt?=
 =?us-ascii?Q?/8pFiVVNp3XCxpfJwLTqU6k0Q5eiengZSzHCD2N0regMVaftDOBL9aVvTl1+?=
 =?us-ascii?Q?14i3JFIoje6+osrK8vUWD8NhUPnJUr8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b3d10-a71e-46ab-d0d9-08def9272976
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:32.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLiWKawZ6gptnZEV5Gw8FNVRMvNNy8wF7jDOftU+PXdxcHmElTPwJ/9tciJ9mhCccedrsCg6FkP8XOwju6fTNDOSwvBTSGafv1Rvfzzv6DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23923

The kernel hardening can disable squashfs even when we build images that
use it. Add a conflict detection that is conditionally prepended to the
do_image_squashfs function. This makes sure we always catch the fact
that a squashfs image is built and can provide a clear error during
build, instead of not booting later on.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/cis-hardening.bbclass | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 classes-recipe/cis-hardening.bbclass

diff --git a/classes-recipe/cis-hardening.bbclass b/classes-recipe/cis-hard=
ening.bbclass
new file mode 100644
index 00000000..6ede5376
--- /dev/null
+++ b/classes-recipe/cis-hardening.bbclass
@@ -0,0 +1,47 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+# The config file is generated during install, hence
+# change permissions after all installs are settled
+apply_sshd_hardening[weight] =3D "1"
+apply_sshd_hardening() {
+    CIS_SSHD=3D/usr/share/cip-cis-rules/configuration/cis-5.2.1.sh
+    if [ -f "${ROOTFSDIR}/${CIS_SSHD}" ] && [ -f "${ROOTFSDIR}/usr/share/o=
penssh/sshd_config" ]; then
+        sudo chroot "${ROOTFSDIR}" ${CIS_SSHD}
+    fi
+}
+ROOTFS_POSTPROCESS_COMMAND +=3D "apply_sshd_hardening"
+
+def assert_hardening_kernel_option(d, option, state, error):
+    """
+    Fail with the given error if a kernel hardening option is set to the g=
iven
+    state in the hardening config file.
+    """
+    hardening_cfg =3D "{}/{}-hardening.kernel.cfg".format(d.getVar("DEPLOY=
_DIR_IMAGE"), d.getVar("DISTRO"))
+    with open(hardening_cfg) as f:
+        lines =3D {line.strip() for line in f}
+
+    if state =3D=3D "yes":
+        has_option =3D "CONFIG_{}=3Dy".format(option) in lines
+    elif state =3D=3D "not set":
+        has_option =3D "# CONFIG_{} is not set".format(option) in lines
+    else:
+        bb.fatal("Unsupported CIS kernel hardening option state: {}".forma=
t(state))
+
+    if has_option:
+        bb.fatal(error)
+
+python detect_squashfs_conflict() {
+    assert_hardening_kernel_option(d, "SQUASHFS", "not set",
+        "CIS kernel hardening disables squashfs, but squashfs is selected =
as image fs. "
+        "Consider disabling the hardening option for squashfs or using an =
alternative fs.")
+}
+
+do_image_squashfs[prefuncs] +=3D "detect_squashfs_conflict"
--=20
2.55.0


