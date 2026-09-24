Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F9BC98318
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2975.1790237567831070922
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QxusSwnQ;
 spf=pass (domain: siemens.com, ip: 52.101.65.37, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlzo1RXljNashLPmhm+QPfgLUY7GIQCNJPhYr3KUXKII9ixCWt/9pWSTlG3yeaEGFKtBgfAG9VfNwL4bOY8G4Bo1xYhuiTK6S+f0dfFioG537EBL+5F2H3UZImeCbBs3gcAR+Z598VolcBN7RRYs89XyXfihfygo+aHbl+7CXSSSz75Y9eXecsuv/62hlXL6YbgVWKcYHtO1iu7l7+YTFh7Oid1EPQSDgbf/vx5jQSqO0pT3l6QKzfEfiAkluhwdRQxPSOFlHXYpTXXJgAmB+K8iACb9u9FHoBSYDDZdVt0yPOar21CTTrTS8krUl6KyH4lPQ2YQ43eRR1/oGb+Fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYoWc9RjmE+eh3wxrC05hYIEq1nxJBZ5lAai/0g0mAI=;
 b=HceInu+O3wHnVcs9IA+tufjLrkosuf0t/nFngv3DQObBmLXTy6dGDq4norWyQeL2vTqZpCI7zoyADQjDVNSrMzlQLfoLUw6cZTt8apAeXFYL438IsRv4hcVRbXHmQMM8DljAVz32vQu9JDQjZW9Qfr5kYvNXrFF//zCs/7rKFOuOIKhI0OOoKMYaeQEET2/TD2IF15/G4MBOODm7MV9iyRtlYKYEdH9BWBXAeou4bGKcPHyJYoEJA7jvUE5UzXUtt19HGakdQxTkBdt1AVpmiVbTjMUJ75qrd45W/+eGoNaKD91dkCnq2ki450SA/yb7uttSCk3iltuZFwqYPklq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYoWc9RjmE+eh3wxrC05hYIEq1nxJBZ5lAai/0g0mAI=;
 b=QxusSwnQqCPbGLapKbvQT/YphOoUZZKr/z3DMVBqW4Y94nI1QgOjR4ai9ovvrx0yzrICKceXXQotmu1TPTmPZz7/C4w7JcyAXvLHqamnEF0REalcU4d7fBz7Xu2pIF5Bi6oazSeEg1OIkXBnO14fJ/tPXX6SrjeBPzwPypt7PZVnVbi/PpVdsq+UXLWQ42dxI7MVurclyXiCX80akanV/L2g2Ir+Oe3xI0FPQP0xAYj1J575fshmXhkXxqelCxo3gKuCxR3GQPP5JWAlQ01yUHFtDX+BQBUxQvfG/FWVVEiixz4G8s1ZPegOR9maHTTwZZzwM2t08RFe0aLN23z2jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:12:44 +0000
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
Subject: [cip-dev][isar-cip-core][PATCH v4 10/14] Add class cis-hardening for post rootfs generation fixups
Date: Thu, 24 Sep 2026 10:12:19 +0200
Message-ID: <20260924081226.2844456-11-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25fae3c2-5fba-45f5-2d0e-08df1a139b62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	O/qt/m5vPtKWHXw/8i6cdu9vC66YevtBDk6IZ9qVRfmnscdLX+sY6wP15kzOWvFRlBijDagGwxT7PHEh60E3lqByxsTEssl9KYaRZAq/8b2gACGUlcOBFL8ugmA8s+e9nsHJ3VTT9mElR0o6OiCjt3abGv7XO1cM+OnxKw7NNY44C3gAGcs3BT2KLkS9++y9BQxoNxsMZrP7ILHLqTU03WwSjlzhtKsabE1jO9vBr//j2hMUNu26lPasDsIp4wJFyK6NkmarKFO32ft6uz8yvo/YMWUdoCUvD8d9ewMQiE5cAteUquyVb8RTZqCjpY2rm64pl3R7tFDRgJx+0iph6uJhMxGilfsnuaos3znnkG6XR383L4WVS7tqRpLEazz6mMUx3/+NVayjyLv9wjLChit+emFXG4Ljl3Gyj3Y1U7fX6Dak2ESNrEGOx73MxpXP9oc9QJKFTw1ms9HON178PF6dNWfzv8y24UydFd9nlP2YEwAVfeJ7bvHTd6fhvfot0FVCNZCkIB9bK5M9xvqOXxoYjNXzTFNYZn1VTDCXbPSHeC600CsJdcLEMKO7dK835AmgbZb5rGSKTgZyvF+sp76Lb93q0zpNHuKuab7rONRst+6SwuN0RKxtQXsumpHNf2DwQof74gMLD3wqx7viJijNctwpY15CnjQ72sjrn28=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p/pAg7BHbEMVQJR47i3Hybo572zpjCmwwq4TFkzACsdvyBJJYdUb2TcJ1FDR?=
 =?us-ascii?Q?M781ep/7m5YflCbAt4jKqUiZ+xRbhrfiMeiK4tcsFFebDrIfqunWieAjqakN?=
 =?us-ascii?Q?E1SWzrcx0lzqH33vpoH/Jepd9e7YMRfWetVCoBee04XxXLx6N8vcaIgQ6tml?=
 =?us-ascii?Q?mKO4+EgkBn6I67LWgaDldj8R/DI+Ld9NGA2hahGLLMIlp/eMdaeLClaB7NP6?=
 =?us-ascii?Q?34e/P5K777L+/Pch+oIjN6W7wVUhg8gpHkva1TW3K3FMILD7Vg6pQNKIuE8t?=
 =?us-ascii?Q?t68NJmzWEQpzDGRvmcErHcGE/nRzS7e+8QVJoV0KEpM1ha+JQsR8/FWWN2ow?=
 =?us-ascii?Q?QhTIgg9YofdiVV0ynLloS8OmbSmpvKE0LA4RLLjKODhIKhkdplBUmF5lRbNw?=
 =?us-ascii?Q?aAwIFjARUXDbDSEofg/NJM5ufLxnVVF8vtdOgxH+i1UfRn3aFRJeXTkdq2IO?=
 =?us-ascii?Q?Vs0QesJxEndwjKjD9Ea+Myu6+/jfMXMhDki7OO5tG+sdai7AH4Q6d7A5Cbav?=
 =?us-ascii?Q?+l8utVmIX2RoyBpf0DSsvlw4JzCgxh1I/37Yav3lqtZN+esDhN8UIju8esn+?=
 =?us-ascii?Q?yE0/25RAFNiy+JMwIwYIFP53SMTEIEJFkhr/rfGccOj9Roe0R2gRmcuTmOUb?=
 =?us-ascii?Q?qiRgQHz0jyaSs1EdalJJiUt+ca5GS7NcBezMJ4LcqKoJ8fL0yiWtIcOnhwND?=
 =?us-ascii?Q?APJWblQK4jBP516xu07zcsu7p7+5nKdMKkL46EA3u6r/kwKDuDWD52jryR0I?=
 =?us-ascii?Q?jJb3zufJ9PYBrffmBiULQq0B2zytG1H+pZZf40Mpp1Q5FNAnTCSOPMMP/YOR?=
 =?us-ascii?Q?Y2/9TPRwyxz3bSZ6t/NVWTkHuMhtCwnGeTF3le5dJG/5d2Nniz+HbRZLrcGm?=
 =?us-ascii?Q?Edx7e30Y/AeE4x7zBDDyHentU7gBdrBIRScq7xuvdroZcL45zPbnOfy1c9c/?=
 =?us-ascii?Q?jS1o3Us7SIUOL65VL7ELjx1JuxAMT/jfcPFVCjbrnqDalzP06gCCLdnsn2E8?=
 =?us-ascii?Q?wiBFSrEkVpZyTecvObnRVmIFas28kwWFNV/1N1MQG0wGekkfYM9hWpE0DHOT?=
 =?us-ascii?Q?D06Nr5zlT5yLEsFxxwV80vuDZMqxwM1ZKSFm7wDyNxg5zDxoV4V+g3XV2ASV?=
 =?us-ascii?Q?X4z4c8fVdWvAOOaUBS8mSQm1xdmhtYP2hFtKYWNC85LtmhFtk5vTtzbfLSCh?=
 =?us-ascii?Q?oQgUaTHLdQAjo758TUOj+i+3Q5EwSBMAZEUwfaYVrtNJ91puaDNYyP/zUiFz?=
 =?us-ascii?Q?hkHqDq6oyuQBIJoRJRKLj1IQntpj96oljlpNP2hq1/N36s59XH8veHKHn/+G?=
 =?us-ascii?Q?viWGRGzemfEArYjg7wHvMX1lnu5wCfZy+3D0uP26IdoTlsSndh5v+zE/Vb83?=
 =?us-ascii?Q?xwiOuJBxsRi1m1R2PafUlh9w33/S11d0A25hsZ3R9GXirLFghcyzB6BmWn2t?=
 =?us-ascii?Q?KcqfriGwbHRvFuss4Q1tLPYOfvUkGOU2+PEdiCi7soUutC/Je4tHglHmSC37?=
 =?us-ascii?Q?52rxCq65Q0IIYR1ba72f9cCnzPupS0L3n+Ptw0W8Iok1t/usavSQoNteD9CL?=
 =?us-ascii?Q?Axp6b5aX0h63B06h0/2f7Dqyaxbr21xNdew5GyTM9diY+bqG2ypJiHMCFWzJ?=
 =?us-ascii?Q?bJfwx2WBBM1vVw1BZ6GRicm2gu4PF7QEbHs55L0MvxjLhkbwLaKkV+WQ3z/5?=
 =?us-ascii?Q?a8Zu/zogSkiVd7NOJw7Qoq3GVTKoiCoUk7cpMVRQGv2KBB5w+DnEDUBeNf7O?=
 =?us-ascii?Q?nL4XZkBzaafie9YTPRS9sFQUAcdgGNU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fae3c2-5fba-45f5-2d0e-08df1a139b62
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:42.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPlr5KcYVObMCWUoRK1HKEXUNqRgeOVYS9HBDQHV+5h+Qrhn2b0KOdTBv6o7A3go0l4ZrzivHE5GnDeE+cC1jDSlmQF+y9ojPBEeuF0Pu6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24294

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


