Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB965C98333
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:12 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=V+83R/o+;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQQLUaPxOsHqnk00fZ8itq0eKbdTcCRNmcxFj5FtYzzzr0Tn2ooq9shO0JT9fvLbNTcssLy6Lf7/le9EvPgAL+Qs58rfveWl+rAN0BdB/KiyU72CbMxd6GJFqtud/6IjXZw9OzLMj+ZRM6VrOp+0U60kazbSdGS+u47Va8zPpcsyEk1cgQllSx7jM6ea+NR+31aJhbZv7a3I6XPhYhDtMIamKeWAB/C+Zm41TTuAQis3kyEgpvOXeTSewFmjEx4eGlonCmVWpT81A4XmF7R6Ip5PtHbxhQESQfGTGC9FA6kLdAUHjmtB8oAvd8306gbfCLhmtHM8nZ1Kc2g+HHeDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BXJwnq0Nd9DDagLYPqMt13+H+oq/3LqNdoIGuUPqy0=;
 b=eXUnleXB6GoglJa9RLhd5DmVTCxf1BQt6S/JGImyXeyDnJ/eA6bd6CqMSyAnMCAwNE3ovmG+pWQ9cHLmQY1VTCY2V7OjD4hghgQQNvkiEpcUrfMhIzhyyy/uBHKcmxoYBeML+uhAA1MooTAlzDqtgEt+eAxMIVTVsyDUhLDaTa7dcgboxBlYXtFMId2MIyW+WjAVE3jgClmlVIUbJTDq+ZpVdJzByh9tAiahESzmjtiofAGlyvzHh7mkqlCU1QSV+JDSbNwoU2f/tOgznGJEFWa8BTunavEjzaOh8dtZCxbHzUj7BtUx8FkkWC+FEdYG1wmfYb46HbKq/ui3D+U2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BXJwnq0Nd9DDagLYPqMt13+H+oq/3LqNdoIGuUPqy0=;
 b=V+83R/o+AnK770Sr2GhzwYh1NJiqlOTr64mMYfkGIPqCyqjUhzPZz5t6BIgITXdJq7PWinN83yhPoP/qM0KqJiU8A1i39vXfNguxl67Qgkv+mHDvfbezFAVKXYc1cC301xUPic53uAfC/QwdbhFCVU04WHjXzbDNNVsvRNTWs5xuCo5h/4/zk7mpIHcrp6WaNnnjpgmYO5GntoArZoxIS8Pzm3x69KmvfLXsgSuVsP+CSkAspSqa4inA8F6qMxFxlwL60urGAijpXqLdL9TTeMsSnaept8y7LraYwb/tINlb/q/QNNDM6Fnl+2o1Sw+uIm/qfd6bTZfWUiC6l1kDbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:02 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:02 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 09/14] Add class cis-hardening for post rootfs generation fixups
Date: Fri, 25 Sep 2026 20:08:35 +0200
Message-ID: <20260925180847.622090-10-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deb9be4-a8cb-429c-f7ff-08df1b301427
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	6P/ZUZUliILL/aqryU+5acrzU4k+vX4D8LMDsz4Xxk225gv1fixhNtgHIHHQfJQQc/ey90rWJRnogZJ1wPoB0DGwWEKMYtG+mkoqjVMn6g8OJ3DV4J31DjdKpl7CrR35ImPiVfRekVL1/o9pvfGrOHrut12zl15PYeWtLeOFYoBnnEO9B7eYSbemN+5TiqNi8yBp94iV701/V0YRCj1ZjACEkg7CfXqcvx/GILE7swHuGm/xtZNgrbG2in3XUfO6emaTLIbj9RYn0JjYC5C4+kEqJhN3kKJIlwwRGXG1NHbaXGm0IJ8EF30eKJ/OW2Gxt1P2IIbdZMH0KxRAmMnaHW3j81dKpvXkZBzx1nt91ATk/3oZq1fJebdRhYwU8p3iYHNKQFvY8Sa0O8H1Oj6TYiQnrYw7jmP9wHg5IsgJBOUY9CmznYpPuFAPpwaJCYBFmWNpC+G0LGVYzmmnOeaf7FRpS/Nc4Ui4xNGjoIqkv2JCkFKIA2hav4z3wsDfYZfG9Mg3/poejGCyLjrEgSzcP4/yqTc7nGLtNWbvj7u4fU8ZvYpsyZqPZ5UFVxjYu6dc4TdCs/0uhTzE2SX+fmLnPZ/cuzaOO46mtV+RrgzrL2x95XhYNNvCPmPtAy6WN5jt3E+H2mMNQ8NJbVX72ei4gEbzpPplNp5Fncur+tq5W2o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o6ca7g8CFNUXOxoNq/vQSnfj36o3Nsk7clNpKdFrYmwZTUdYYpKxIQU4coAi?=
 =?us-ascii?Q?S/lylJF+eAGpzyhO6K533af0ZZ9yE8viIjiEVKkhd1njt0bNCIZzxzwZV/n5?=
 =?us-ascii?Q?XJhoIgd15yeJ5bDxGcGE68S0Nl8WzLWLk4wbKhSZLeLP1eUcI4rXKaE4c3U7?=
 =?us-ascii?Q?DwWtQ1nkm3GTQio6EdKzM64vcjSGmwQCVUI4OJDFV/Ia3yDGfI2vKYGRb5jc?=
 =?us-ascii?Q?vnZf8xyBb8zvQDe5cYQvWFD6RebWZDDCVPQ1lVaIaGq6KtCdU4lMI5klPwEd?=
 =?us-ascii?Q?61HxFyxbscYVfNQJnaCi4rNDiwq/zNLA57p+IKip6tjo8Z2WtUnp59hOa1aV?=
 =?us-ascii?Q?yTYryBeCqHh3vt1++CbhLrsSLrk6tqL9YVCWqam8jZTwlUxnH234bfrXoR9w?=
 =?us-ascii?Q?319+77IoMassrEB66HLYiONYtGmPQITYHm4kmFnYHLl+6yflyQBtkADg5xGP?=
 =?us-ascii?Q?JKkmwDM2ObGbs1vnpOaTxDtk4iHVKtgnwV1JV2hbXrOLRxkNaw+msvGyGlnd?=
 =?us-ascii?Q?4w7AVg++aqiWCWu2jl0yly4Fo7wPWC1jZ5tTGiLOuDwnmViWJRcFNf7zWjB9?=
 =?us-ascii?Q?T99bhcznP+CdFo5Z+p0rn76092hG+oAkdM7gPBhRuwZOBeabgxMp3qBaz95b?=
 =?us-ascii?Q?IOqY5Y9vIHHWI4CEQIVs7x8nNCQty16U0vmK4OIejbNN7H0vi+3ISV/8UlHI?=
 =?us-ascii?Q?dN+LI4EcneN44iHZieAuuiH0Zv4xtsGPPCD7OwKPpSvDEmcL9sXA5Yf8Y9AO?=
 =?us-ascii?Q?AFXxNavjf8pyWeoiiDLX0n88RFu9qZCrf2bze/qED+mmdV5PskGMgOM1QfTO?=
 =?us-ascii?Q?b6qS/xMrooh9vCUU1c8ZRO8FHefk+XZ0Wf4IfpQhSbwZsCQwLedOgPH7nY6j?=
 =?us-ascii?Q?JGy/NapxMem4ooDDxfY0WR+kY9WLSJdYITTyP0AX9OlnDTIUsm9Q8SeaT6uF?=
 =?us-ascii?Q?F8vsnKZnTS3sQBIK5Ed2+ayD+tk2LMfb341w07gNYUVHhwLyORH3NUUxoxt5?=
 =?us-ascii?Q?YRGrqw018boAGHfnhOgU/QbUkN1NfDnV0IAG0tQmxtA2MPVyjV5vPvUIC5m/?=
 =?us-ascii?Q?HAcp6JS3cYsb1xXlT2T2yt/lQfy2XwGq07kPUfvfcqLjrq0pe2hN07oFYrnD?=
 =?us-ascii?Q?ol6ojgGYkbHRqWCmycnU6sQLdSVX6OQnsZbznMkHHucaFWZiE+ASBvIKY7t1?=
 =?us-ascii?Q?sYuerIhAHDUcnSy6IAst5ghAg1rGLOEvaarPxSh1NwKJGv0QDuCHVAetzIpn?=
 =?us-ascii?Q?HmKh18QqAP66hgBCaod/x9OZfWgITW2FGZLCQTq+4F/Lx2HbEVCg7GoRJwWD?=
 =?us-ascii?Q?p/7gUvaEbllC0I29l8Ftrx6QI5n7IVg9z9x2kZu9joDFDcndepyv2Fq+aHkE?=
 =?us-ascii?Q?rl5K4paPLl+3RKiO1Z9QUUNgeNxAEBYOjRYSIuUW6F7UfSMiCgFlNqDSMzjb?=
 =?us-ascii?Q?+fB9PrMcwwuOJn6HOHaH2EmF+Ts1ztsN+efi/aVS1h7p6gILl7Tam9QZHO1e?=
 =?us-ascii?Q?KxqOWIiYc1LHuq8cvkR5A0qb56IpJysDSJsFeWK3fLn+T+vqPhly0paWcnVw?=
 =?us-ascii?Q?YrYhv4TLauGST9cE9kBx5V+D898FI4JWerG5l/6bKqRAmR8hdkh5UI0lwXpi?=
 =?us-ascii?Q?I3ljgHq3kWX3O5COjldPqaioeTeyXpZrkYJSoWs3wv1SJ/fWI9nzCGFMvrDO?=
 =?us-ascii?Q?s3yCW+gEssJLD5ASfyAxKAmRIJ5Aazl5HetlV92qbsC+L1Gidh+l11gJ+jqF?=
 =?us-ascii?Q?8BHfoviCbwp4KnBmGzCPxSjmgvNtKhg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb9be4-a8cb-429c-f7ff-08df1b301427
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:02.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQbbaAEA50Z31HygmKPJE3+beKAsahx2vTFkq8TbseoaRWY+bwsVmPuMljrmjwA+QLmN4dA69WSkwI6NmjFGf0rumpLApWpDp1zvX9sTkpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24362

Apply the CIS sshd hardening in the rootfs if both the hardening
script and the default sshd_config are present.

The kernel hardening can disable squashfs even when we build images that
use it. Add a conflict detection that is conditionally prepended to the
do_image_squashfs function. This makes sure we always catch the fact
that a squashfs image is built and can provide a clear error during
build, instead of not booting later on.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/cis-hardening.bbclass | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 classes-recipe/cis-hardening.bbclass

diff --git a/classes-recipe/cis-hardening.bbclass b/classes-recipe/cis-hard=
ening.bbclass
new file mode 100644
index 00000000..c147e398
--- /dev/null
+++ b/classes-recipe/cis-hardening.bbclass
@@ -0,0 +1,52 @@
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
+    import os
+
+    hardening_cfg =3D "{}/{}".format(d.getVar("DEPLOY_DIR_IMAGE"), d.getVa=
r("CIP_CIS_HARDENING_KCONFIG"))
+    if not os.path.isfile(hardening_cfg):
+        bb.fatal("CIS kernel hardening config {} not found.".format(harden=
ing_cfg))
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
+do_image_squashfs[prefuncs] +=3D " detect_squashfs_conflict "
+do_image_squashfs[depends] +=3D " cip-cis-rules-config:do_deploy_hardening=
 "
--=20
2.55.0


