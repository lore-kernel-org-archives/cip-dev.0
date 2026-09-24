Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24848C9831C
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:22 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5834.1790249777502329221
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=M2xArJZQ;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VS8HVyVCZeDq4UIm+ng+DoJH4AiZUpylwCHP3NrjLgbTLICOXx8DZbSdX65kfVFFhN0/J+vgS8qQv93FlgA0SmSh7DxKfGnfu4qXq5jDA3b2XvaHu/4qOroap5rAXnymrrpb+ItF0hWkJr8o0uQ+QKzMZeS24ndVFRmApH+MCiwb1XekCoZX76xXRs0wF82j+eofff/yMCuBcX+D6w2I9m7nShczSHfYEhMhtP71yqxm8hI5zpHOoMXw6CKo/YkosZb+w9r9R+dSJQmtV4TsTxCHSVR1Qrn1RP5FLFYRHA3adpdrXo7j8BRrQl9v98MYLwxpwZOmQQUcFrsDDMALiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UneE+Kn0LNmOxkfcU5TTYgIayauPNbcOb7TquJr+4vQ=;
 b=dLMfR5/AZfxmFhGmYsrjVnmaMsV798icRR1eTV8W7MAJ/7BXIdgw+AiVj+Etwfh8FY35Zzh/vMYG+NODckoT5Y7hG0spSmza0IIfinD4DwdtY5QMJ9gbvdDDen3ghjEZJmr40NaY7wg/HaevK0U7GURMrvtSfizYFVLP7VvkmQgclF6ij2DHhoBMSwzWrsijQHNfoaQS1w5EYdXX1kXd7xIzUwXSIPHHFnpG9cqcck+a85DlWxK5NMHpx5oy9+o6rGPD2JXl+DcvkHW9N5bldrbJ8f53geuJifXtAn3tOynayhkxKX42hQ5idu1NUCsyZ7tljdd9RgfwqFcm6AQFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UneE+Kn0LNmOxkfcU5TTYgIayauPNbcOb7TquJr+4vQ=;
 b=M2xArJZQhAlLwOoujBJxyMZ+n5VCNI8eBe05t+sj70d3Yenmg5SXQ1+/QveqmxJsN4KqiOeO0wXrOBMRAHjMW7BCZanNWg4jxeU+Ru8LAFugGinAmiS9nEPe/IYn1zPyHinueKBPyCnagoYi5eV2dO6h90w6MOQc99cmCt8Fs0vdEFtBGPMku0VYk/Js7MHrluffJFJd5QprvK7qXNpNoM1ggWHGuMKIrmzcgZjnL0NJrXi71WgfFlVhcpRcK6Z13SaKa5xO0qzuOJrcGCQczB6kPKX8sEqI4j/XjJO3R2mcQP2eMVZgLzw4pY1tP8c35rWHsArHRJZo2hY5uU1P/A==
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
Subject: [cip-dev][isar-cip-core][PATCH v5 06/13] Add cis-validation to validate the hardening based on the CIS rules
Date: Thu, 24 Sep 2026 13:35:06 +0200
Message-ID: <20260924113557.3191996-7-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 966fef61-a24b-4e0d-7fb9-08df1a300662
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	UL6I3EVjqjaazowYhIsPiXM9hUifopzpmsCGWkMf++Vt67kVJNsteNyYOkXLRcTqaqS9sckxQHTEr548HsLVBu0VaqlnuaPmKiFWQ3OTrCIy9sjCDII0PU9knP1JVX+2q0spvDXBIWNhxD5KuWBSfnlOB45EzVqGpT+UKdIgbaf+cM0tDZ1pFhSlxkl9C21E0dtTcG8um+PSkt0CjXXLtHlzg0RLI9QEEyeV5nmlX/WF0Bw+Tn2GMEZkBmNccp/gh2DKAA8RefP4JnRoLF/Sjq13Mub7tRJk8gJwzlScALJIWJEV6I9PaZI8hl/jjXjYdgBbh0cMkgGQSsrPdcBYk0n6p7ftYdgvBJKQMAMgGmOD2NXfGcyZwns1vnIQcGOgWsGRosAbOzACtowQcbR63Qo4s0YPk+YdVbq5Vc17pkLNcnQy+Jd7q2W20vF5zBmQuDxqVW7+79bLImk7XAPVAtZ9VE7bKxgvahif6jJ1w8kpyD+2+OLUbjHsglpgRpuDlD52OTqOxgfjyj+hohDPKV7Elx4BYDBQhNFOVdKu5QonE7ujyV9feCL91QlywcnD7AL4ur0yg+xSg3wz06xMUoJ/RbCxWOf8Yc2+1wv2U1yUKxIsEJO0oa16omIe7evswbrppy1YwXOxWut0pokAmgJg2IdG0GJcUwMinxiMCuw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Nf/7bgHWXvXJp6lhcuki0DkixYupYfSW8CNtARxJJKH0BQxzNoGPcCT+RF8y?=
 =?us-ascii?Q?nW8FLeZf5Bq+hCpPhTJ5b2DviD2eKI8ZP0244uTrsvhvSW7SKBbBOOz++Z8p?=
 =?us-ascii?Q?k2Kjn0Zg8HAPJ81/dK/VO6f2faX0U2t86yXiURJNn1ssQd0OxqLz8zuglIYD?=
 =?us-ascii?Q?VWCNgv41PXUBHvKMiNCaS7YYonBdeP63aITKJaTSGEQL/vd0yMv4eSEMZnOj?=
 =?us-ascii?Q?oxUVgKCd2v//mk3aRjiPyaJqtBa9dQ/d7HDAXKy5/xtDzcj9qOsACzbriHHx?=
 =?us-ascii?Q?hkvmKUa67rti14NtbZn5G4TmAlYmkqPy0sClx6Qs9m0QExwAAL0654lUqoA5?=
 =?us-ascii?Q?eeq3E8j/dX9ksrSb37lZkEXmPeg6ckOg7PLt5fo0YPnB6jU/o5yr0vWh65NJ?=
 =?us-ascii?Q?mwbj0qHCNbWs5pks2GIjYoIGjWRYpOEwLg6FmFp/JtFWRaKFlKBCZ7GJlImc?=
 =?us-ascii?Q?e4YGuT8LVKPUjT9TgUY7oeFOtcELIrWNOV70LUPHYXRnZBSqR6v/juV7njbs?=
 =?us-ascii?Q?Jbhbp9VFLiMiCPI3fFfW6Sv04yEne9xvEtdVMQbLLw5B7R7KAWV9ALfTiBs6?=
 =?us-ascii?Q?b/OJ9ypL6TwPbBurNbVnOsIUH0IlKlGRKv0cu/qhDRQj3Q6rxGwwQDeNc067?=
 =?us-ascii?Q?26RzZ08XvAHHzEQ4i+lJkDto93CM405lhFrTN6+mP7ie5enwwj4G4os5nFJy?=
 =?us-ascii?Q?aaH3xDe2POkqz9HhYED368fW9J29eZtZNG9tl6k5V+9QRj64tDEdjS2WFWWn?=
 =?us-ascii?Q?faUkTgoOJh9B2749bGfSyeAOVF0A6qJPtAuWRw/BELZFinlGEr43dmpliwkH?=
 =?us-ascii?Q?jTTuPpbuUj9QT2o1xLS7uavP+V+2j4MQz/XvAnXqg1F/d0BT8Xyt6371dQuD?=
 =?us-ascii?Q?SSVm6YKrGpRSVqxb0/75UrugUaePbmfGpLwBacybavyhVS0AIIXzMASBKqV6?=
 =?us-ascii?Q?GokR9rgLtgzt7NkOTQptSD6GmLJZf8CC9qg+jRTveLE4ZMVEy4oq3oH/EgoK?=
 =?us-ascii?Q?lZLUumgh92tWS2uk5nmov3t9jKOLUIzvJMYNQyxjjg1zoqfp9K3m+b8LKdtX?=
 =?us-ascii?Q?/j5IAprAw+Ec9VPLs1cbemP+JWE2MV0L88vZJ/+dY7U80Oi+7jtVzcvxXJtO?=
 =?us-ascii?Q?yNhZAJyk0qHDLPFVR/Bh4VtCC5TPgaeI/IPiFXwx4ojqDsoa/YnpKHm0OWsi?=
 =?us-ascii?Q?aPv2tEUyGg/TQY/Tr8UI0hbp+U44XOCcQWev3c0o1awpbQhRFK5idHsRMAFx?=
 =?us-ascii?Q?4fe/BuKOZ6Y5fCVcVIE5GVapB64fl3xpMSiM4ULT0Hts3iGGveu40Up/JyEr?=
 =?us-ascii?Q?egmmjaFaYIE7h/EsiT2pr+wlfqnR1t5BnkN/gRR2PXNYwnRL2RqD/BYAgkzD?=
 =?us-ascii?Q?Jes7Bk5i46RbWueCSC9HZXN6IATi5c4gWEVXnkg1tabbKUrYeXB9o8vfeUl3?=
 =?us-ascii?Q?lH/XFJvwXJMfGb1MQnPg5rcN7HkS8gdvPmtPWnOmeObyc0Ytc7RxPpd9UG/2?=
 =?us-ascii?Q?qNBLbcZ+cpYGminPEV75PjCoL+49PP0lbJ/1nhrT4X9fKLT9Ac102vq+Zrdq?=
 =?us-ascii?Q?ACjhe/tU5cIfgI6CBF9Z0AXUN0k3OgUkK08/IwDrcuJRFtkRQQDNoSF8t7Jz?=
 =?us-ascii?Q?6zp/ZtDNh5uayPjkn9ufOrAZyOS+vG1qi1MZ/KMLoBGdd22YI0Rzr73A4QkY?=
 =?us-ascii?Q?M8pNsz09GbVT9WrQp2pwml5NVnXNZmyJRXUO58CBaiaEbnpl8W1KYX4ggLWL?=
 =?us-ascii?Q?HRKBS+UVf3Ofj3lmDBtF7ypFZhNRSFU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966fef61-a24b-4e0d-7fb9-08df1a300662
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:07.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NLySA0UAbOUYjMEAZVAeR+U3FXSLMxGSp4FjcKufFMLD0t14F12brRqnzi6cc/1H4dUHPcFJWJDR+4A9wCWggyiYi06e4Iwmlfq4KQ6LW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24321

From: Clara Kowalsky <clara.kowalsky@siemens.com>

This adds the new recipe `cis-validation` which uses cis-hardening
to validate the configuration applied by cip-cis-rules.

It uses the hardening configuration deployed by cip-cis-rules-config
to `${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_CONFIG}` to generate the
necessary validation overrides.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-validation/cis-validation_1.0.bb      |  52 +++++++++
 .../files/cis-validation.service              |  11 ++
 .../cis-validation/files/cis-validation.tmpl  |  65 +++++++++++
 .../files/generate-overrides.py               | 103 ++++++++++++++++++
 .../cis-validation/files/postinst             |  52 +++++++++
 5 files changed, 283 insertions(+)
 create mode 100644 recipes-security/cis-validation/cis-validation_1.0.bb
 create mode 100644 recipes-security/cis-validation/files/cis-validation.se=
rvice
 create mode 100644 recipes-security/cis-validation/files/cis-validation.tm=
pl
 create mode 100755 recipes-security/cis-validation/files/generate-override=
s.py
 create mode 100644 recipes-security/cis-validation/files/postinst

diff --git a/recipes-security/cis-validation/cis-validation_1.0.bb b/recipe=
s-security/cis-validation/cis-validation_1.0.bb
new file mode 100644
index 00000000..a7c3b845
--- /dev/null
+++ b/recipes-security/cis-validation/cis-validation_1.0.bb
@@ -0,0 +1,52 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+DESCRIPTION =3D "CIS validation for CIP based images"
+MAINTAINER =3D "Clara Kowalsky <clara.kowalsky@siemens.com>"
+
+inherit dpkg-raw
+
+SRC_URI =3D "file://${BPN}.tmpl \
+           file://${BPN}.service \
+           file://generate-overrides.py \
+           file://postinst \
+           "
+
+RDEPENDS:${PN} +=3D "cis-hardening cip-cis-rules-config-${MACHINE}"
+DEBIAN_DEPENDS +=3D "cis-hardening, cip-cis-rules-config-${MACHINE},"
+
+CIS ?=3D "/opt/cis-hardening"
+TEMPLATE_FILES +=3D "${BPN}.tmpl"
+TEMPLATE_VARS +=3D "CIS"
+
+do_generate_overrides[depends] +=3D "cip-cis-rules-config:do_deploy_harden=
ing"
+do_generate_overrides() {
+    if ! "${WORKDIR}/generate-overrides.py" \
+        --config-json "${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_CONFIG}" \
+        --output "${WORKDIR}/overrides"; then
+        bbfatal "Failed to generate override files."
+    fi
+}
+addtask generate_overrides before do_install after do_unpack
+
+OVERRIDES_DIR ?=3D "/usr/share/${PN}/overrides"
+TEMPLATE_VARS +=3D "OVERRIDES_DIR"
+
+do_install[cleandirs] +=3D "${D}/usr/bin \
+                          ${D}${OVERRIDES_DIR} \
+                         "
+
+do_install() {
+    install -m 755 ${WORKDIR}/${BPN} ${D}/usr/bin
+
+    for cfg in "${WORKDIR}"/overrides/*.cfg; do
+        [ -f "$cfg" ] || continue
+        install -m 644 "$cfg" "${D}${OVERRIDES_DIR}"
+    done
+}
diff --git a/recipes-security/cis-validation/files/cis-validation.service b=
/recipes-security/cis-validation/files/cis-validation.service
new file mode 100644
index 00000000..428fd928
--- /dev/null
+++ b/recipes-security/cis-validation/files/cis-validation.service
@@ -0,0 +1,11 @@
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+[Unit]
+Description=3DCIS validation
+
+[Service]
+Type=3Dexec
+ExecStart=3D/usr/bin/cis-validation
+
+[Install]
+WantedBy=3Dmulti-user.target
diff --git a/recipes-security/cis-validation/files/cis-validation.tmpl b/re=
cipes-security/cis-validation/files/cis-validation.tmpl
new file mode 100644
index 00000000..e4efebb2
--- /dev/null
+++ b/recipes-security/cis-validation/files/cis-validation.tmpl
@@ -0,0 +1,65 @@
+#!/bin/bash
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+
+tmp_root=3D$(mktemp -d) || exit 1
+default_file_mounted=3D0
+tmp_root_mounted=3D0
+
+trap '[ "$default_file_mounted" -eq 1 ] && umount /etc/default/cis-hardeni=
ng; [ "$tmp_root_mounted" -eq 1 ] && umount "$tmp_root"; rm -rf "$tmp_root"=
' EXIT
+
+mount -t tmpfs -o mode=3D700,nodev,nosuid,exec tmpfs "$tmp_root" || exit 1
+tmp_root_mounted=3D1
+
+# Work in a temporary CIS tree
+cp -a "$CIS/etc" "$CIS/versions" "$CIS/bin" "$tmp_root/" || exit 1
+
+# Redirect CIS_CONF_DIR and CIS_VERSIONS_DIR via /etc/default/cis-hardenin=
g
+cp /etc/default/cis-hardening "$tmp_root/cis-hardening" || exit 1
+sed -i \
+    -e "s#^CIS_CONF_DIR=3D.*#CIS_CONF_DIR=3D'$tmp_root/etc'#" \
+    -e "s#^CIS_VERSIONS_DIR=3D.*#CIS_VERSIONS_DIR=3D'$tmp_root/versions'#"=
 \
+    "$tmp_root/cis-hardening" || exit 1
+mount --bind "$tmp_root/cis-hardening" /etc/default/cis-hardening || exit =
1
+default_file_mounted=3D1
+
+conf_dir=3D"$tmp_root/etc/conf.d"
+versions_dir=3D"$tmp_root/versions"
+
+# Create missing rule cfg files in the temporary conf.d.
+"$CIS"/bin/hardening.sh --create-config-files-only --allow-unsupported-dis=
tribution >/dev/null 2>&1 || true
+
+# Apply SSH overrides
+for ov in /usr/share/cis-validation/ssh-overrides/*.cfg; do
+    [ -r "$ov" ] && cat "$ov" >> "$conf_dir/$(basename "$ov")"
+done
+
+# Apply CIS overrides
+for ov in /usr/share/cis-validation/cis-overrides/*.cfg; do
+    [ -r "$ov" ] && install -m 644 "$ov" "$conf_dir/$(basename "$ov")"
+done
+
+# Drop non-CIS rules (99.*)
+find "$versions_dir" -name "99.*.sh" -delete
+
+AUDIT=3D$(
+    if ! "${CIS}"/bin/hardening.sh --audit --batch --allow-unsupported-dis=
tribution 2>&1; then
+        echo "CIS hardening script failed to execute." >&2
+        exit 1
+    fi
+) || exit 1
+
+echo "$AUDIT"
+
+CONFORMITY_PERCENTAGE=3D$(echo "$AUDIT" | grep -oP 'CONFORMITY_PERCENTAGE:=
\K[0-9.]+' | tail -n 1)
+
+if [ -z "$CONFORMITY_PERCENTAGE" ]; then
+    echo "Error: CONFORMITY_PERCENTAGE not found in CIS validation output.=
" >&2
+    exit 1
+elif awk -v p=3D"$CONFORMITY_PERCENTAGE" 'BEGIN {exit !(p =3D=3D 100.00)}'=
; then
+    echo "CIS validation conformity is 100%."
+    exit 0
+else
+    echo "CIS validation conformity is ${CONFORMITY_PERCENTAGE}%, which is=
 less than 100%." >&2
+    exit 1
+fi
diff --git a/recipes-security/cis-validation/files/generate-overrides.py b/=
recipes-security/cis-validation/files/generate-overrides.py
new file mode 100755
index 00000000..e45e2151
--- /dev/null
+++ b/recipes-security/cis-validation/files/generate-overrides.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+#
+# SPDX-FileCopyrightText: 2026 Siemens AG
+# SPDX-License-Identifier: MIT
+#
+# Generate override files for disabled CIS hardening rules
+#
+# Usage:
+#   python3 generate_overrides.py --config-json .config.json --output over=
rides
+#
+
+import argparse
+import json
+import os
+import logging
+
+logging.basicConfig(level=3Dlogging.INFO, format=3D"%(levelname)s: %(messa=
ge)s")
+logger =3D logging.getLogger(__name__)
+
+class OverrideGenerator:
+    def __init__(self, config_json_path, output):
+        self.config_json_path =3D config_json_path
+        self.output =3D output
+        self.rules_data =3D []
+
+    def load_config_json(self):
+        try:
+            with open(self.config_json_path, 'r') as f:
+                self.rules_data =3D json.load(f).get('rules', [])
+        except FileNotFoundError:
+            raise FileNotFoundError(
+                f"Config file not found: '{self.config_json_path}'"
+            )
+        except json.JSONDecodeError as e:
+            raise ValueError(
+                f"Invalid JSON in config file '{self.config_json_path}': {=
e}"
+            )
+        logger.info(f"Successfully loaded configuration from '{self.config=
_json_path}'")
+
+    def generate_files(self):
+        if not self.rules_data:
+            logger.warning("No rules data loaded. Skipping file generation=
.")
+            return
+
+        errors_during_generation =3D []
+        generated_count =3D 0
+
+        for entry in self.rules_data:
+            rule =3D entry.get('rule', {})
+            if not rule.get('apply', True):
+                name =3D rule.get('name')
+                description =3D rule.get('description')
+                if name is None or description is None:
+                    raise ValueError(
+                        f"Rule entry missing required field(s): "
+                        f"name=3D{name!r}, description=3D{description!r}"
+                    )
+                description =3D description.replace(' ', '_')
+                justification =3D rule.get('justification', f"Rule '{name}=
' disabled by user configuration.")
+
+                os.makedirs(self.output, exist_ok=3DTrue)
+                logger.info(f"Ensured output directory exists: '{self.outp=
ut}'")
+                # Sanitize path components so a description/name cannot es=
cape output dir.
+                safe_name =3D os.path.basename(str(name))
+                safe_desc =3D os.path.basename(description)
+                filepath =3D os.path.join(self.output, f"{safe_name}_{safe=
_desc}.cfg")
+                content =3D f"# {justification}\nstatus=3Ddisabled\n"
+
+                try:
+                    with open(filepath, 'w') as f:
+                        f.write(content)
+                    logger.info(f"Generated '{os.path.basename(filepath)}'=
 for disabled rule '{name}'")
+                    generated_count +=3D 1
+                except IOError as e:
+                    errors_during_generation.append(f"Error writing file '=
{filepath}' for rule '{name}': {e}")
+            else:
+                logger.info(f"Rule '{rule.get('name')}' is applied, skippi=
ng override file generation.")
+
+        if errors_during_generation:
+            for err in errors_during_generation:
+                logger.error(err)
+            raise Exception(f"Completed generation with {len(errors_during=
_generation)} errors. Generated {generated_count} files.")
+        else:
+            logger.info(f"Generated {generated_count} override files in '{=
self.output}'")
+
+def main():
+    parser =3D argparse.ArgumentParser(
+        description=3D"Generate override files for disabled CIS hardening =
rules from .config.json"
+    )
+    parser.add_argument("--config-json", help=3D"Path to .config.json", de=
fault=3D".config.json")
+    parser.add_argument("--output", help=3D"Directory for override files",=
 default=3D"overrides")
+    args =3D parser.parse_args()
+
+    generator =3D OverrideGenerator(args.config_json, args.output)
+    generator.load_config_json()
+    generator.generate_files()
+
+if __name__ =3D=3D "__main__":
+    try:
+        main()
+    except Exception as e:
+        logger.error(e)
+        raise
diff --git a/recipes-security/cis-validation/files/postinst b/recipes-secur=
ity/cis-validation/files/postinst
new file mode 100644
index 00000000..a9f706de
--- /dev/null
+++ b/recipes-security/cis-validation/files/postinst
@@ -0,0 +1,52 @@
+#!/bin/sh
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+# Resolve override mappings at package install time
+
+set -e
+
+CIS=3D/opt/cis-hardening
+SSH_OVERRIDES=3D/usr/share/cip-cis-rules/conf.d-overrides
+CIS_OVERRIDES=3D/usr/share/cis-validation/overrides
+SSH_RESOLVED=3D/usr/share/cis-validation/ssh-overrides
+CIS_RESOLVED=3D/usr/share/cis-validation/cis-overrides
+
+mkdir -p "$SSH_RESOLVED" "$CIS_RESOLVED"
+# Remove stale mappings
+rm -f "$SSH_RESOLVED"/*.cfg "$CIS_RESOLVED"/*.cfg
+
+# Map SSH overrides to real cfg targets
+if [ -d "$SSH_OVERRIDES" ]; then
+    for ov in "$SSH_OVERRIDES"/cis-*.cfg; do
+        [ -r "$ov" ] || continue
+        rule_id=3D$(basename "$ov" .cfg | sed -E 's/^cis-([0-9.]+)-.*/\1/'=
)
+        sym=3D$(find -L "$CIS/versions/default" -maxdepth 1 \
+              -name "${rule_id}_*.sh" 2>/dev/null | head -n1)
+        if [ -z "$sym" ]; then
+            echo "cis-validation postinst: no rule for $rule_id, skipping =
$(basename "$ov")" >&2
+            continue
+        fi
+        real_cfg=3D$(basename "$(readlink -f "$sym")" .sh).cfg
+        ln -sf "$ov" "$SSH_RESOLVED/$real_cfg"
+    done
+fi
+
+# Map generated CIS overrides generated by generate-overrides.py to real c=
fg targets
+if [ -d "$CIS_OVERRIDES" ]; then
+    for ov in "$CIS_OVERRIDES"/*.cfg; do
+        [ -r "$ov" ] || continue
+        short=3D$(basename "$ov" .cfg)
+        sym=3D$(find -L "$CIS/versions/default" -maxdepth 1 \
+              -name "${short}.sh" 2>/dev/null | head -n1)
+        if [ -z "$sym" ]; then
+            echo "cis-validation postinst: no rule for $short, skipping" >=
&2
+            continue
+        fi
+        real_cfg=3D$(basename "$(readlink -f "$sym")" .sh).cfg
+        ln -sf "$ov" "$CIS_RESOLVED/$real_cfg"
+    done
+fi
+
+#DEBHELPER#
+
+exit 0
--=20
2.55.0


