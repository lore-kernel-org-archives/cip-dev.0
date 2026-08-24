Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2FBC61DB4
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:51 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13174.1787564857848105859
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kjHzSODJ;
 spf=pass (domain: siemens.com, ip: 52.101.69.10, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpos/mfBbpO5GK4YfnAMKmJOtCyqJAzCxoYDPMFZf3GY4YMb6ye9GV0FBNjgKcVyv/Ff9SLt1yB5lvy4H9FEHx7Sg0hn3/Y5hk2AZ5oyCJ65RlSY88Iq2Ux7kiAAIVhkJxRQspaiMkpJpUK2pMwc+ZxU4naVlu6/A5ucbxpSTwo9ETY+pxI/GNWPKAlDpeQDOr5HJi1O3SerxpyxZComh1kWtQEubtlloTHQiam+9E2CBf8eicnAGCZLqEzHbbRbAV/lJNjEP00pEBxW5lBfZsGJ23PCX56BUZJC2mHl0YdxmYySXloQBRkPvfnb/61Qo6BforMxq8XWRWaBxyBFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVtU0H75/7+9udEDPJbtCnAG8r9FOVsoi8fPr2VS0+A=;
 b=pLBQqEZ+G5wvLr9FlV/m5vWFL3c4fa5oE76xSvZPB7rsj5sEUfpTwjjceOl55NS7miinHHU1rOnJP952UacrseAAyhANOWXqg0yOA2dC3/j1DbrpH4PuORUfufV/xCTaEQgRoiTNUGAWL/7mRlDnrRgRkC10Q/3rbUJiaC3aLLS25sdJpMCbrWKoIDD264Ew4gHaR+ilEAm8/Z5Ep0KlVdY5RX+tudUkCegJikRlSf1y9Aj0BFEYOcOM5JFEDFkFHZApoLuwPDJZft+1ZsJhmWwo59UAzmU/E4pLqJhk2Rk+/u139Zi52cDQK50uWLBzkJa30ioNi28t0e0hPtd9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVtU0H75/7+9udEDPJbtCnAG8r9FOVsoi8fPr2VS0+A=;
 b=kjHzSODJrW/hOOvR+UxQNhL0WF/Kb7P2Mc9Bnz1UoFXAsocUQ7/rck/23UI7MEUkV78NUKk7xWgnbIpYqVNrIGqrI1j/+c5IHkAxugwETI6/v0MFm7VTdmgZ+aMMmNZSC1IDgXjmqvqKZMisKidNkpmpcP822pF0JwzqFs+XbXNfWk5pnkNpZsP+zwyx3nkTMOQZlK+dTrMcHfIGhVumJ3yFJhia3DLT0uDjdWhzwZlV2Sm+31NI1EsdRyCJO5SSo3JFnrixWWWgyYQqmTlgfAseflnjV8D7y4BacuoXcVUIFTmqx26ncFT/Opt0E9yRopBwoRafVd9yUB6p6KF6NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:34 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:33 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 05/12] Add cis-validation to validate the hardening based on the CIS rules
Date: Mon, 24 Aug 2026 11:46:42 +0200
Message-ID: <20260824094721.2636375-6-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d78374e-02d3-42c1-5bed-08df01c4b8dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Szu4fVfyZpHzVX2lwT/8jIsCbaAukG5sULm48ErBtlU0ta9vfQkTt9LMxuVCNoBT9BHgNlF3T8UiW9JrrsV6uKH5Z65B/cZ/hwQ49Ux8SuoKmsRB/8SJzG09EGblPRlr8V5/rd9FVT5Z3dZs85Hxdp4Mie6nCdYo4RSVm+kO2oPfnddKQdFNin3KZhOC3vdIgN1AI87OPD+V3dhXHvFdNHQrpZ/Gp1NufDsMq8d9+fhF2CrqugBqxd/B9BzFZybyJA1iB9SsUnxDYOERjum8jsSeoaEQIm369xpybsYzzXPAJLy2Tjv9IJ2q61qp7DCVRPluUk6xvYEwRoQG4uiTN9Whn6s8gog8Du9CZU0vF8QF2sxVTSORpDVekRJEUSHRd2gHrPuRldxjA9CzG3x6RRuxOYWV2RATtFejh1zAvtME5iSOQs+BiQfDFv3ZaSzCiaksNmHW6bEVpFx5dx/3axSqqMJuCqfKIeitm2xkw2tAvxDRo3CR1EuMg7K8Hg/S7OQZnJz1n87H0321WAeumFtIdaLnWSlWr8WpG/VN/5DXjxQUls9tgVi5BMCAkWlE5Vk4cF5OnWvToAOg+O/369JKxVW3CE8gz1ID9cMT/8O+tIl4AI5dA/tOLdQRSt2AcZ7K+KDQyJiWtuOOH2zNCQhDkva+9CpODwPD7S2IinY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xby7bR9vq8tsUPF7jmtTTySqZb75KO2aXEOjs+07iQpJidJjanVdDF+gn84g?=
 =?us-ascii?Q?0GV2eVBB3owphLkCIJ7H3+KN3Tn5+/XvArf9eDViA/HzhKp/ZiG+5cZYTm47?=
 =?us-ascii?Q?iFNyufOARKYzGjAs6guECgX03cexdzYEbkJX5ZL/qNP7gN9hWzTrwzqHPX6G?=
 =?us-ascii?Q?Oy4kLAua9Pb5zvxwOpKgYXkMVvll9+DgX/D3HhqCiqNzn+MhHFALbw+aKvMH?=
 =?us-ascii?Q?/tanmNLtxP4iZLkVgEHvpYM+MJG3KWb/Wj1WrVOkhWL+XVfvmEGqZB8h39c+?=
 =?us-ascii?Q?PasmmTN+dfEf9zBTK/V5KaiXFOGn1zBSmhRxdaUODikeNr9sWSlxXuSum2mG?=
 =?us-ascii?Q?EP1YdvU/8PWpss+sR3GvvjHgurwIWJyqAJiH1+Q65XF4IeM3i/32+RonWw/C?=
 =?us-ascii?Q?cJIt66tnOC/DrDjk9WERgNJP3MeZ4GQRRsJrqELKxQgicYUkpCuIPY8vmUdr?=
 =?us-ascii?Q?Bf5iByoGk1FPkQnT3RkWyW9U0K3fu8vjbrq8lNam5VsZcD/XBJeaRzxF8040?=
 =?us-ascii?Q?5BAcZwgnjDamgW5p6NDmnOHBb8gbt3dmPCBL8xAc7JV7B/JF9btNryFz3wDy?=
 =?us-ascii?Q?lCexOyMZEMLf1KwiuLMC7ZdTAhjj0IoBoaclXv4KBm0rKVC13tFaO8J8A4ex?=
 =?us-ascii?Q?E6/b/htnXgMAGlvkxk4FNf0C32e4jUVODlljfrAgl8SBUN6RHvxpWMv8ZkNR?=
 =?us-ascii?Q?1E/+wiE4KrJtlJYUi7Wrr+blwC85xyeLNwA01ar62BgVUyRvzCAS8Uk65757?=
 =?us-ascii?Q?7oG2CNnc94Tv2bt8QwMW0cV6YcHEa5JU9EPS9xhDG4C6g4qUVuLPVVI/sg+4?=
 =?us-ascii?Q?oh+pvnND96ns4CIa+S9DVx3LlD3tzmpeCnCRyYtoAzbuH85fZHepZxMh8yt1?=
 =?us-ascii?Q?0iLR9EUCWdOsOB0h9YSnPxl0mauu3RMFsXdqt/z5BuwqZwUT8x2AttA2kBM3?=
 =?us-ascii?Q?a3AOZq6GYuTqWgeTOMmhXwNwv7aXupiDdNySoseiQ92Tkpvw9LD0QgFuXWYD?=
 =?us-ascii?Q?VSAZV53y4GyX0YzHA2bmusyCar4U05a3+UNliMFXyLA4txOLDUtRA8uo7kzM?=
 =?us-ascii?Q?ESfJDnG/wOgZibvEvRMsh71QifaWNdCJ8BbCGc5yFdcogcWiTdlppSIUmH5s?=
 =?us-ascii?Q?tK+uJLvCrTtxsCMZu8lSA0oaOZnqsp0SZuciCEE23PLv9/oM3SO/CARrunBi?=
 =?us-ascii?Q?RCBFp/ZxlADNfRvud9h5v3Am3rrU5+tVDn7sZ78jUjTS6VB1CYrJUvraLszi?=
 =?us-ascii?Q?EKUQnrS65RvoqF332C7S52Fqg/jZrGfcOhZQuPDjUTP2Fbsmcq9aWs3cTowg?=
 =?us-ascii?Q?9UcbUFQEP9/NlCWQOtMCd2dK/L6GNVjvqVROi71/daIVupYZ7YztXKTH8Oss?=
 =?us-ascii?Q?GutXKGZLuQOYzSdXXvtLBMwtKqBbA2E1oFeOif/OdNodnsdigF97awqS/iBl?=
 =?us-ascii?Q?IfpBMZx+LZVlPYLIOWkmK0LWaci63nRbuvrLg1FtdakugK/X0bUbIRU42J/Z?=
 =?us-ascii?Q?M6rj0dhmKl+q88sRZVXzE5YgBBt5xXyEFvH77DFcn9LwBw/5Ky1ReJPWvu8l?=
 =?us-ascii?Q?LKpkcFDW+EwdMN4gtUS2ophTfOy2KHCteGY6t0GkOLLMI6XwFBcALwdFQQjY?=
 =?us-ascii?Q?ZL9HIxi5or2e1aAvdAKz01H95lRhW1VXDACX7kInoyFxo3z4ue8rqinWsjQZ?=
 =?us-ascii?Q?uvOyVyGSjSylk12pcaGxR+eMB7bwhucVpmZLDsO2rpQn6LIMRbiSAiLlg9m8?=
 =?us-ascii?Q?J1ruSj4nVCQw9jPy2m+4mogxPhbgD9s=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d78374e-02d3-42c1-5bed-08df01c4b8dc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:33.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSxNHPPQWtFX6m+lrLzuVBXqWTbAGvU4qOjkU6Y+Oah2t/rSWd1/gaVm2sPvUWwGTJPTMTKHJd58TVEdKQC4sHIvzKoQEnqiwacBJodnhEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8521
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23985

From: Clara Kowalsky <clara.kowalsky@siemens.com>

This adds the new recipe `cis-validation` which uses cis-hardening
to validate the configuration applied by cip-cis-rules.

It uses the configuration from the recipe cip-cis-rules,
stored in HARDENING_DEPLOY_DIR to generate the necessary validation
scripts.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-validation/cis-validation_1.0.bb      |  51 +++++++++
 .../files/cis-validation.service              |  13 +++
 .../cis-validation/files/cis-validation.tmpl  |  65 +++++++++++
 .../files/generate-overrides.py               | 103 ++++++++++++++++++
 .../cis-validation/files/postinst             |  52 +++++++++
 5 files changed, 284 insertions(+)
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
index 00000000..1cff3485
--- /dev/null
+++ b/recipes-security/cis-validation/cis-validation_1.0.bb
@@ -0,0 +1,51 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
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
+        bberror "Failed to generate override files."
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
+    if [ -d "${WORKDIR}/overrides" ]; then
+        install -m 644 "${WORKDIR}"/overrides/*.cfg "${D}${OVERRIDES_DIR}"
+    fi
+}
diff --git a/recipes-security/cis-validation/files/cis-validation.service b=
/recipes-security/cis-validation/files/cis-validation.service
new file mode 100644
index 00000000..21286be0
--- /dev/null
+++ b/recipes-security/cis-validation/files/cis-validation.service
@@ -0,0 +1,13 @@
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+[Unit]
+Description=3DCIS validation
+After=3Dnetwork-online.target
+Wants=3Dnetwork-online.target
+
+[Service]
+Type=3Doneshot
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


