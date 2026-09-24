Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9240C9831F
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:22 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5834.1790249777502329221
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XlKBj5SK;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/M/C6fdtcin+AZFsZaqZD3yVfldhKkWCH+Gc1FtQhMAAL7MsjyIcNgtvtI42uTuvk6PZU2DYNH76PGbO/x3NsQFVmTirHP8m2oG26ZhtUnfVp07dtavQVpShAbE0AVwkhhGLobjX64lR5btiIaxjTl1s4yb5XjKIz/aqq5HY6Eeb3xU2ziu7SvrB9HSsUr2pBlXvrBrKYV8D/pq0e4D48kw+SabwWA/hULrxJ7INaSJYOIsjra4c0KoHUy1U0QYl2CNuC0vr/rKNWKf0ByPGN+4DqlzK255UOJv+ECh+1S4I4O7Zcjai0QuS7Y6lFRuJgklc8MR1JL4pgZKcNDNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYoWc9RjmE+eh3wxrC05hYIEq1nxJBZ5lAai/0g0mAI=;
 b=SAjObleH8W/w3+HE37ap0vhaU49q5/7mYcsdt8+w0lDtYVmLFAdktLOsDKp3UKv2xRHaPT60pEXJIApbPhuVWR+ZTHZ1dPVSzdMZDQJfHT8zdgcvXK4604l1xfEsiQpimMNfYMV3PnPncm67qBGOLWZ3+xD6MMR6o+byKyw6rCKqO3Er6wMuhrVAZyfkFF7yYT+EADfIvAaVypEM4zKz3U9/uofBumvd9kCwxkC9Ji/8P1lLgsohQx9KW4Rza+8f8zPXGndevuj45kPquvQ9mQ8eIYZ/Ah4W9NVCKNtzlNjB14iV4W3zMNBYQI3kh/+GdhKQ5wsQ4vHHKfyU//78yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYoWc9RjmE+eh3wxrC05hYIEq1nxJBZ5lAai/0g0mAI=;
 b=XlKBj5SKJnqSTrH8SU/3OdI3HsLqdS9zxl6w2xhhJgpsQgXRKkzfQqEpJBd4tJUcjcimrOJSZeXyV+Se3HvqU1ZY98ZXnyHAhj+WgXkLNlSlEzkPAYpSDd/OCfofflvn1R6MYsol/3DyyrfihnsOe8A8Ns9dhT2ythiUoyAzJltpWMXduiRTLwYrv7seGu0nJ+8WNy03w8dXtW8ZvNtwxkNl80XH19oKCfUgX1xN2gJ9DD4VY67hpQ5+QyJ9Mbs0kvq+g3mwiKvbsX6Jkvcfi+X5N2b7IngmcWA4R3QPMInSbZ/7UXaXMP5imtTXmdehVs4Zg6+Ae18Ic7DRMRGGIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:10 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:10 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 09/13] Add class cis-hardening for post rootfs generation fixups
Date: Thu, 24 Sep 2026 13:35:09 +0200
Message-ID: <20260924113557.3191996-10-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5da10933-5a1e-46d9-4458-08df1a300731
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	VrSRVW2B+99lOwrp+gxbE3tYvPIGg7pyZjOx8g3vDNJNpZVNteF2MnGmjMrpWDBd+7xgjKktWn+yisQkEhzTGelBWRwpUBt6jkA2+OUphWt3N//KWi475jX58sSw4TXCTZhLzX+AudPO7eWwn+eGRfCYI0cR2RiInW1wlB7BY266WBXcPWcE0l3knFVdHV/5QmIUd9lnG43iWVupHwF8mDjn/MS5f6msDCbmU1o11c+zK35peGyTHSU2lKPmFLfXFFdonYghy6F50rA9VYVHiBN7u359LCOK6xOGOMzg1OaOcs6qBao0dpM8oPIpNw1Bq/Saq1ws7OpwyZsPLGziASW9kSkrW+NMRlDPwNHGMAPsgpE/mBMSAVygs2W2p2/jPjOLuwKSwG+ns514G+wcTkY1y+ek/RFacxSyONFnLsq83+WYAMNhL+nxpAA/m0RM5bDdXDFg7zFTueTNslvXLKDPJ79U721zMnBxn8K2GArSjjEL2isbbyYydCnPU1eBZZfazZX0ysMerfU8kblOWC5UUluL3X+Cu47c6Obt76ijGE4fiD5LUsDOIupIOvEQFOFNVdXQiUnpGcXl5P73C2e+VW9ObysvRVopZKN8YVxdYZ5Rww68coC8qLreDXWbUWQIkEYp4G3/PFkw3q0odxMThJADE4n/qXo3UGUSUeU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WP/cViXte+K7gH1VIsc0ojnlyhWUz8nPYAByJqX4y3jiR0RHklJGAvvVTspZ?=
 =?us-ascii?Q?q34jiWEXG3jcF7Khkkb2zD9+YqHMdwVjMQ5jJqmkzroc+dzx1WUxhSMGU3Z6?=
 =?us-ascii?Q?ujwPc5JEFAeOKhT4YCC3OhVv0O0dK7W9fN8EwhIrfLEQLpbaJpps8+QNFtMW?=
 =?us-ascii?Q?4GNi+Ck4AMRQBfPA1nBt5MJHVN8YxrVYkncU8Gre4POynNsLwY1o5rUTKEPo?=
 =?us-ascii?Q?NWyeBX3mCGwG8XDOZcYvfX9/ojLKkUkKAkSPFlDFviRjUTdd6M/os4Hann+B?=
 =?us-ascii?Q?FEN+Aw7QxAIWyNY6fJxvHpNHOsPAwOxitjWuQrbWfxmnfoCLcw8W9hNC7Wnk?=
 =?us-ascii?Q?S9Fu3LHhCrCrB6ippmQSGX8j5/K8YvKoX/XhTC2ZpaxTr2OBHwFO22m4cC2i?=
 =?us-ascii?Q?/m32W+YIcp1mpgx1fnSA5qGL3Y1uEr8Q8PotV0/4izKYGMWmGTZAQvRNEg+g?=
 =?us-ascii?Q?UOkGJhQUBUdepDXt3kzTYNzuJffNfZcCNYgFn88xfGYD6swZF/XzRt7Qc8d6?=
 =?us-ascii?Q?sW+Ka1SObPoCO8LBPoQNCpVoOZ7TMcm7uoqdiU+7hQpgsJNxOfoh1CinCqmF?=
 =?us-ascii?Q?4Q9zUDIi2dUedkS/PlfZCn+csQsxp43btjnUAAZ0PB5VZXXrFCsm8tQ2y3G/?=
 =?us-ascii?Q?8x5rViH9XkJp5Dq1HbYVt3c0crQE2rPfLRufjp3RlMERNXpKoGKqAO7VlKdf?=
 =?us-ascii?Q?+cWINqlyNV+E1VbkqBDG9oWfT1J/71TvgD//Nh+hmgoPtbvt8UJX3/rlnyTK?=
 =?us-ascii?Q?+j9qpbqwR4kL43ngFuwO+xg9M2sWcwu1TUW7rMh+AEXoH/2dG+foqcF7upE4?=
 =?us-ascii?Q?+uQLKz89g0sKfMJBs16UmeQpCf9e5jF0pswQtCILS+OfUIBvNiCmYQYXGv1F?=
 =?us-ascii?Q?Q8CtTebf7y1coc89hL/XkxiTMDk62cUoDd3w8zxixejFBW0OhLk3J2l/ULa3?=
 =?us-ascii?Q?Dch6ta3s4gWysnYlXQc8l5zQ8Aae4ZVKLMPui7Za+aEZW0pmMAJwdPUFY4hW?=
 =?us-ascii?Q?Bk/xYU5xVldUWOtWSdrq2UPbIpnwmcinv+8GY8EfoWUAgYZgBDFidrEvHjXa?=
 =?us-ascii?Q?rT7hpmfL5vq678MoXr+TmVFvYcEmAqSNQgyMfsyIpkrbqQ9HQ2wxzZmLYCew?=
 =?us-ascii?Q?IExIg13Wbq5JGWVFzgTjQv9sBre5PnxfGn9AyaPCZ6kiYXCYStRy4ZoeKQOD?=
 =?us-ascii?Q?dd3rt9TnKcFvgee6MvQZ79Mkk0QVCdOOfxeLVe+FI8Sm/x8mS1aHypkRBcOx?=
 =?us-ascii?Q?szJKsAi6tmzJ8pEJUBGmEh+DsL3/Lozn1wJypwBYeShZKTQ9cmjOvq6xayVt?=
 =?us-ascii?Q?nB56R4zV3IxuciiG8P3ddw3b66mbwYD0NoQDZZ7PVQBThXRbJE42i9i7Rxfs?=
 =?us-ascii?Q?TEKQ5ZniG2EoQcY0fnlKusbcSRL527Iq76f7qJrEibEl6GmuHs/cmF5SKhoO?=
 =?us-ascii?Q?5Lsdjw0JtVs3MTwJwJdOD+vNh0hLTdvix9c5jymrzGKCDuZME4OQ26yNc8Mw?=
 =?us-ascii?Q?5BB9C/1D2nfas2mJkos5IO2uF5kqOOfQnKoPdxN+FjX2BeZK3S/pPXzT2eAU?=
 =?us-ascii?Q?d9rZc0j3KUYi1K3AKgOAXaiXChzTano8+yPxSvDNO7bFroTkqBL7Moeir9X6?=
 =?us-ascii?Q?lDTpsSahhPdgsEj5CKUryW5vbuqbV87aJ7hMFuANkJPVSlwJ/FpVFnCE8Pyh?=
 =?us-ascii?Q?ExgyJTT73h6DYIofagDXj3NGNwmPAYWM1XtRCCYAVMi9xqUoGWDZurn/WDs6?=
 =?us-ascii?Q?OACjUHRI5dOB/xSbid8OB5u3cxVr+/E=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da10933-5a1e-46d9-4458-08df1a300731
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:09.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUqWgPfSRAeyswFl8fjcVkhYC5RrRSTukOQxrzYbi6xhyBmyrksi/wJKodvCEafmCdosXauwLjTmD5hnlDcLDn8ddFOH7nSBR1UdtB+PLn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24323

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
index 00000000..ce3be386
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
+do_image_squashfs[prefuncs] +=3D "detect_squashfs_conflict"
+do_image_squashfs[depends] +=3D "cip-cis-rules-config:do_deploy_hardening"
--=20
2.55.0


