Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9609C61DBE
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13124.1787564859150375495
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wVrh5W2z;
 spf=pass (domain: siemens.com, ip: 52.101.65.26, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFuHobePtKyEJibdtkzPz3YcA9VjU+Oi7zfevNeUMYrmVOMWAjdUcr8KSWTXLfM1L42/t7Wm2f3/D9rSSYkUHxafVl20Q9Bk4wa2F01Z+UvSaSAksEP25T02LFMwfZtoPSbjw8Daqc4EvzXUX+2CJxXEcwhp8mBG0BKt5fvL81DGhY1r0Ke0FbEjxGTYOoq0XIkP809Xo2dITgRfgiP1dEdui1T4YJmTo0OdSWBCr5L0Xm9fdXEcw2kDY2xoWGTORUOwszMR7ErBrMvNs/OI0zATZ9bS2JLTs9l61wXrsqKt2sZZkUSwOyS48F//fmxkd9I9wJYH/l5TfZPJ2hSfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFN4ZY/4jwbHozfIJmxhWpFO5P+CHVFcwnLEhFH4xD0=;
 b=r08jTxvmCW+f9sRxyprS6p5OH6LsZSjiKJisnCxuG3VXrZchifwf1kBhWISwxRy7DYd1S1U7xhazE8bVr/mB+NENKt9w3Ca9GMcVHMiRPezpcbA6tD1ykTtcOsUqA7g0DsuRYdHL28HNTqvhdoLYNq4syBoNkt5MKAp9XQkzQRRDfFpSrImd1XREXp9NpSp69ohEDtzJo3FAWO0YGA7UMLbyML4i6vdGnCMKZvwWgL9yG5Z9FDK4ogrDyL/j+fY10u45ixjhTELqylJMFK6GKL9anILCIuL3/ukwCHx2AbmjCMqIsMRU00A+ZnkDqgVJeGeLsbJuIKQD0jn0tBurPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFN4ZY/4jwbHozfIJmxhWpFO5P+CHVFcwnLEhFH4xD0=;
 b=wVrh5W2zklJmS+YiK5DtrFRQIYOYheSJMqRG0v2xNSfcBQDbvZwHzrZXjl2DPKSIMkBMz0APNESO0YL3c4mjLoIKi7YwyjgOivA+UusGxaYHXAzx19OXysWTn3s6LM2t/lDYuMKjthw6hE9Hf4zoW3oJWybQAOuvBTUJjUa0aVl+3rypFUGLXPbMT9MuV3wFObOt2DlCMOC4NQmZGKVtn2X0jdzV8Ls5dhaTc5zxEdCqWGZbspBEQTvbtCQkgQmUvVd3hKJzP15RIylP6jThx92SF3pj0gPFuqBv1isvoXHED9iiFI3NXC5a5Fs2oMjGiJkaa05sxe0E6qJToovC0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB8PR10MB3738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:36 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:36 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 08/12] Add class cis-hardening for post rootfs generation fixups
Date: Mon, 24 Aug 2026 11:46:45 +0200
Message-ID: <20260824094721.2636375-9-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB8PR10MB3738:EE_
X-MS-Office365-Filtering-Correlation-Id: d30fa703-8637-41ac-7135-08df01c4ba5e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|6133799003|55112099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ZURI9WHE7YtWQ663yNbIqW2ThvQ4sSC//pu5GaPWXq6B35hV+rU2zZFEuBqsmPup0Z7idKWsViw3u0Elah2gDKqxi3z4C0HkJgBjZx8yrZDsSKurX1DdsX/7hcdG0Q3crlTywXSv4DeaWbFWR6blxxWV0xg07VZ3jpJ28CsHzSCKgqiprWHFkYIPoRPKE87r4Mq7NnE3KMpmKXuvq3mRNFqzM5vs7hz88UtXs5zEdEgv74jv2yYjW3rup6JPne6OJFBpFG+auWQnb+3iDHfz4yr0Nb4becDv+IHHDONQmvR2t1YHf942JaVFnMncn6P4f4oRiFt19INXU+VNGpEtYoGr0AxqitSSUCwXuu29LymYUMU9KIDzOIRcJWqV0jeaFf+ifs1io779wg2jHC3RYl24YxouyKcM9hVl/8ctjE7GeaV1NAp4kYRB5k1RCtk/7KcrN7Qa8xAvObBGaVsYMCc5tCVc9buQ25vRQsOA6XzM4M03xEZYi8NIn7R/0syxYIl3Zu1XZgwovB0XP8wj0bPjCcdi32dMW6Nah2eRKCRqW38IXGmWu8TEqBzYsk2OOvBIqlqR4RomkJlh4PV6Z1VtrMv02qCy784Xo2TB+kdGHbRSYfPaXqAayO20XKSV6lDm1E7E8/DYhV/0S4ySNTPN5lLvp6viulFJhc5tgqw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(55112099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XeAyNrC1JQM4Hb/DkFdux84b3GDx1wfa+eJVzZUUGWIXv6XKf/OOq3k5dH9B?=
 =?us-ascii?Q?LM9lAKnyjVC8IBMaliHBnZZy+9aqau3Ft56U9nB46b+vKl75oAMXElJrUogh?=
 =?us-ascii?Q?HjCtnKhlRcUxwHXZw4aroljjy0lCA09ujmlEdHcKW7r+VC+qWeLUHyt0J+IZ?=
 =?us-ascii?Q?dyn9yMTsv+p4OSi5iPtKTEh3vUq2OHcb2UYixHDCZfcUyqjuYAk+AKx+J0pB?=
 =?us-ascii?Q?DrPJu1wpiUUVIbUBZsY5chrq5vNE1DtfiYaVWF7/Rk9U6Fmce0rG6HW7+CU2?=
 =?us-ascii?Q?XEp2yz72bLnnhbu+fnlc8S9ezaoAdhSCcaMBK3/eB6ApcaXyhW2yIfhlBoVc?=
 =?us-ascii?Q?ICxpGjXjrN4A7I2zGMHfzP1wQQadITBycyWIquvfYfMWO1kokD3nPZBBfUTa?=
 =?us-ascii?Q?YbgFuXfgd9LQqXHN3nex7W11S70lBoBMk30XCGv/tuHSdlK4z2xgJdSVTgBZ?=
 =?us-ascii?Q?evaR7BijFCEC2pzSYlF2tG7oXl733rpv++Lafh5jsveDc9lvoP7tXpQEQ8mN?=
 =?us-ascii?Q?SYyrpUJ5Mlez/1EvypubXwRTLJoy8TUWKP8tJmy/xHx7x4bSuoZddx+g/5y0?=
 =?us-ascii?Q?t/dXYrMrzHZjTn1bICUkw2gpT/5nB2HpgAQMXIc6tf+Dzwa4V+Jxo4Zl1EHQ?=
 =?us-ascii?Q?OwmZH5tW+O3cE3pXuQaK9gc6eif0mNIlySG23AhroabPsPcufgf/fG88HOtC?=
 =?us-ascii?Q?LLNZKlU/OtcrI2I7AKc12Zd2+LjZWs5Qos8dF9Hi8Yk9hXiRD8YeOWubTnT1?=
 =?us-ascii?Q?VJ3cXvOzHf4ue998e2FAAxuZZ0XN98cl0iS9sNAYYdp2pAuVUdrxDviZOWAK?=
 =?us-ascii?Q?s+RZ7w7LZArBDfPe6WRn96klzBDFtar4ffvCW78FRPSJh9QK9PF1pjds7Ava?=
 =?us-ascii?Q?edlMzbFVL/djC+FnqfkkfR3ln6X3sdde6OenSqlNAtFOS18ToiLSvyw3j3Zo?=
 =?us-ascii?Q?OIqZJP87/PgI9/JpfCJErvSUsVxSOTtKiuORVHY36mCR7tgNSsY8uakSkcsF?=
 =?us-ascii?Q?wJ9CBep+ygdsFLPrepVrpF6toHGf7FgDjyzn7np1TO9DFWoV3iC30JnoAqsO?=
 =?us-ascii?Q?Kby0iU/WguTcAcJY11F04DY1OrQniLksCwjcSr7wzAJzJoYVaUsJU3h/j7kw?=
 =?us-ascii?Q?jselY+187HW/BAaoCNPZyZNbCRQrsOsZNMCL21djLoDjdgh11TedAWE/QQKn?=
 =?us-ascii?Q?eMVDnq31QOhOxnCryycU2+3DEqPvfybunezh92OdICQ+izPD6aceHKQzum3O?=
 =?us-ascii?Q?Xt33XqFX0FwxPrApTuvQqA7UQ+9fcpxV9iTfyBCBgOoQ5HFCC1gxv57xHuGi?=
 =?us-ascii?Q?g22kX1HhV38l+FcgXDuGOOEa+8ebWt8+v+rzkBMtEyqiJp1BEcozwpy5zEsu?=
 =?us-ascii?Q?iIZ/ok1dc9BXjxpuJweVRqTmKnL6fwwRzBLmMS9OIzB/XOCCk67YJXQC4wIp?=
 =?us-ascii?Q?SPyP1DfhbRHgHJ5bjPZHUU0+KLAdAuxql6YcDAzwPoXvTfhAs84m9n5EhRpD?=
 =?us-ascii?Q?L2dkzVDpPKzcMq5l1Pj4QGSI04kMdtIN4Lisq3E8FjTcVq2jGP9H6iCjZwP1?=
 =?us-ascii?Q?Ryacjsi8oQS7NHztV3IaHmxiKAZJ1+zhka8yLwCNyk2Fv/K7uhs1+Lke/ire?=
 =?us-ascii?Q?ObTuPeYQaO5bderv3KgGEcHtA4vc+E5tskRakaxoxqVqZ8Is30Zef/oFt1H0?=
 =?us-ascii?Q?TLgkJY+PsqAKCX+DlmydPjCghmTIPgrElTaX01yzhcgYBaOZxcVgAa/bfzDu?=
 =?us-ascii?Q?50fOalYDhjjOzeOdqFrjmC+KGw5LhiQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30fa703-8637-41ac-7135-08df01c4ba5e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:36.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1InkX3oQDDtsMBlydML26kUsTe90y5QCa+NulSKVqXabwTQ5Gn1U57U9s94gsysTbYgUvbthczhj4yKEAjQxvlJ3ukeC/9BNtYkAJE+hzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23989

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


