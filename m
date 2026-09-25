Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097BC98328
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:10 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=My4B0rO7;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0q3ak6luaqae6roKAPrzkJ6aPdR3KwpA9K5K5HVGbAZyfCXhr7Dv6cfjv0mWG/2ZWtMRxlF1F8BqbZWJ+PVynyYHdEVF2wHW++0LqkJbBX7hurHwus5iKgiqhpbtgu4aCuhgd1X3Uhvxpklz9MXvmgXaNI76l6hC3G9hMmJeURd7scc0DXlzFMNAjlOnAqln3gqfMzZEBKAG/cGhYuvzHSNsFup9r24MDuVYcBdVq7p68NAfXNEJFOPwadihIUYkRbhpF8+smxjnJymBZHeFDOVDABNYJkjITVhKl5+WGJDFcLIQLuYw/Z4EFj1rNO6ARD5E/mK+uJ/Q/WFP5PGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UneE+Kn0LNmOxkfcU5TTYgIayauPNbcOb7TquJr+4vQ=;
 b=O44J7C3+pbb1zfIuGJfWiMqwlyj9v4hUzGQMH+5aYoCvLRQoEaIj2ZMy9vjmGbWf+ElKzhS6nvFz0z4td0+q8S3y9uOW5izYFO+THoJ+/dKRghmHC6OoTvLxav/DfAl7tOxBRd/N0Xx+yh9fFSa/5vrT250qkB3DZEX0wOM/L/bpWOEH5qtSCuNWZWAhD8Md+THbdw+bI5qBYaMl/gx0oYC0K/FybnDy1j9EnrIivgiO6/+aBHVJqbrs3/9c8/K8eXt87lazqgBg59QPxvf3bFFc4412wq8JgV/UAGGyQj5tgOCYZF4gg9CB/K4BFSAKGn5Ow0xdIh0qQA4Fx2hR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UneE+Kn0LNmOxkfcU5TTYgIayauPNbcOb7TquJr+4vQ=;
 b=My4B0rO7k8YPgMRh0gT9cuuXmle9FOJxfT3S+a8Jwi7Xr22KqXbtGirOrZ7lMhq7iZDaJIQWFbq3psiUrpxWilwRAlCLNEcclw96kubmeWNwNzkgexxQ0NDb2gYw/SMiS7J4zQRaXut0EbAywqPweNzVTtgLj83GR79kGy/Ud71UbmbenGN5CLEBa0TkHJ2pMMqZSSH86FxFc3FZdC3Al4K5umRwUZiPXpzGvJtcePU4jaJXFYnDBafAn6DIWbXPk5dQeSc5R+Cq+yzDK06RCwcQLP79zS8HvqIt3oYG3CnP7ywdvDJ5zSgmUGTiRRomLs5duoMvVBLZD4lDUdXf4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:08:59 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:08:59 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 06/14] Add cis-validation to validate the hardening based on the CIS rules
Date: Fri, 25 Sep 2026 20:08:32 +0200
Message-ID: <20260925180847.622090-7-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 744913f3-787a-4d3f-5a66-08df1b3012bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	1CER53fRxxsrY+ljpCjF06PdJ86tZfVXhrguRxvyOmQ7MnLfdXtN5LII3PSOb2LQteW2QZiAHrhfah1URbN2YG4B1Ogo0pBNZpG20G4up0RfbixQrs7PIidJKJSxCRkAGLBQcqRJJwnSgJxM4w0BUMDvkSQfzHrau2p7wOq0UH/vdZcEAfkNl9uBDFKF5CPOmdtVhcO/o57C2TWvthS7JednNrZzOeEe7s+eDA696v28+2if2hIHQkglhBcPhuOEuJnnDhtbLdG7uBC/Txhf62exH+HmQHI+fnv6atffAyIx2Cs17f17bB/W1lN0OOhVzqu99Gw95b6C2TzszriS8vMUrWfA1w2HXD+gymjk3kDb/9EpHCfWldlzidW0u5aDZQ4x89+VB8MWl8u0fwLijaQlo+EGg3hFRM2iqCQvgV4pinEHqlVzPogAdynfBD3HrGBpy+rOYGv90OiezT/9JDM1IacboJu07dkAbJeC13t7R7KKJEoK+3TQE/7IUjnSXlHqkgyLMeGp4mq2W0LSFFyztBWwa3BWqoxLh7qPNQ52adBwO5qn2Sz05BzWzGQ7i2tsTcRmhItGb1FKqSaFM+tu3MlwkSt1A99Im6AwLrYDEMa5rvvsoQfyRtHJOTgG52+3vr1YCABZJyQ2ZQq1Yy1LcZwxPPuZ9+1FYUi5bTU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p0LdT3daHLaqFx2qf11o4OU7TlVF/+fkpBV3b0iy1TyAmOUt0PrQS7Bp17bV?=
 =?us-ascii?Q?ht/h2G1JcjRRtCYe1R7KIdI7dDifBynv33zv+PIkP1FcOgurWmCEKWKUhaGs?=
 =?us-ascii?Q?p689g0GnkhpkkicB2+azgHUoU4y6soGjlj30KRqO/OAH7inRBOAprnRO2/RD?=
 =?us-ascii?Q?0tA0VEtLmUw+WvojSmB027kxtgj72vGwP/SrmAMjGH1QJYuP2ZaYH/ZQmbQx?=
 =?us-ascii?Q?ggF4RrRU0ic7E/tTouUP6P6Jy5KLpvniVuZ134NtxbugOZyzsisaPgx3SUMR?=
 =?us-ascii?Q?rCgNdumBFDgSF3+VJskU07QNyAH2En2bs6S/4fcODR32Q26oPqZdAW63ihjP?=
 =?us-ascii?Q?ICBhHRLzr7jKDau8Nc3IfrbNu75EV+wuKemNNL7GpaEsad2I3ng4xSlfrDex?=
 =?us-ascii?Q?HwrTigk0F6+Il9ptLLZqMW/tWv3fWZcM7+Oa1UeIEDuPVJ/3ZfXcFr05hUoG?=
 =?us-ascii?Q?gYX9lLCJHI8Pm8o9dNS0WMyMh8mW8a15Xdf486kYehxce0L3qYag1q7O6bR+?=
 =?us-ascii?Q?Ga4/ZJoJWIimYXmJ6b+2cRwYm2j8TpywQhjrZP0qHFSQsTdx6WmqLQXg+5Mc?=
 =?us-ascii?Q?asff0vqIAK4XLVBpu2EQ+2oVRBoxDAzO28BANOK8n4q6r0qghngbLWZ3Jxux?=
 =?us-ascii?Q?AV7jc69cNTHS+vksCVGS0iCDa3z1vN0BG1yqIzUVIO1ynsNSj072jYSLIWUP?=
 =?us-ascii?Q?hY+9imHTmMQHvAFDPOZiScZrr/DX2pKSpBDKYx0oPUlFxx8ztT4R0aMPrGfP?=
 =?us-ascii?Q?4eYyACUxYl4e0wf8Iszv+9rBn6xvpKI+he+qsoV/oTccXtaft2moTylBe2Ca?=
 =?us-ascii?Q?Oy0dj0pX9WPwRmo5Y1uiCQDLi0MX1ZllOiWbHNmVzf2Sb0TUzzf7JoSl0N/L?=
 =?us-ascii?Q?GrdOjQ853Y/eYVLn4oziqo+Yf2d8Tn+GQm/+Ssxl0ikNIFAU3IMxCfoyptLY?=
 =?us-ascii?Q?LQmbo4BNAw17ILD8uxVm8j+LDZ+Jpkr+t2XN12QNf3tjeDFZh159Lisa/y22?=
 =?us-ascii?Q?T3VvgKU14f7tITzO7kdg1LNNL1znWvIW5e/Rwsb+yZUk+YCSWUYPiCcZDlqm?=
 =?us-ascii?Q?VNonDiKyhBQ7BbjKBnwllA0ity1BJeYMMqCt5DJjALQiDaOm55SZMDWpOoB1?=
 =?us-ascii?Q?pCnEdjCe+mwiGZjuh7k/7Zk6D4wgALwUA5Ud7ghA4dAaUksyWr4DqLlJe5he?=
 =?us-ascii?Q?BbyeGCFhc36bF9IVa5YFHKizKJAgTuqGejU+pQxkiprO0Pgwwih4MBfb8YYu?=
 =?us-ascii?Q?9TGgKaeqrRd/cKrIQaCGKQoTBXF28WdZnFLiWQf4fN3mnp/jYt2A50O+SURt?=
 =?us-ascii?Q?cs2Z7Za0CgTbDB+DUd25gQDNQ5qcSuazBkEQ1h2Ymov22tDhRyfxge/OVdy0?=
 =?us-ascii?Q?U3ayNAryUtMey+8W7GMcBUMxNeyUHTGD0SjReuGhNzNbC/lDc100Upb6Oi20?=
 =?us-ascii?Q?95cHUKuf+43rGm0ExkCkraFd3AoFz471NIAD7Ki5DnWiPgzb2hb4NWNzpjnU?=
 =?us-ascii?Q?WzaFhtnfLz+FY3D0clGDR0NPYEACeHMVCqkzROSjVzcdgX/Clyp7YA/9BvVI?=
 =?us-ascii?Q?q0pQIRpsNO+OS2XRKj6gRBt1OIgJHHtcdLO6sbzX38wbi5SgsaCLuJO+EiAg?=
 =?us-ascii?Q?o83SU5SUKMrge7tBR/XMBaTx/V4NXg2fprx5RSRskO1d2nYegdNZtZjPyAPD?=
 =?us-ascii?Q?QoS6hXNg3X3cKveZovGNMITkZqgb5DXnebsX96P8FE8nu3cVsW6BxYzU/AU9?=
 =?us-ascii?Q?GQ6I+ls6+LCxgjTTjbFzrUkumLoRmUI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744913f3-787a-4d3f-5a66-08df1b3012bd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:08:59.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULwY18rYmXoKZBORD67iX5eucbM1PGQz9a0UA6ou/8lm9IeVHLV4HKD9HJhoKdHZzKO6l3q+8GsaeUdRKd7YqH0GvSUXX44UsArH7aS2uYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24357

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


