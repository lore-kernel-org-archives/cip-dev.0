Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8A2CCF2E0
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:11 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31403.1792405557545157339
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fbobBDAq;
 spf=pass (domain: siemens.com, ip: 40.107.130.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go4A8+9KKjJFSVBtlEj/29OrAsInO4IADbOuVCBtUAYpeh16Ph5tIQLXGCa490NkGsDVRaChqrxWSvWafTOKYMmf1RYOmuUEEL7fTrcaFhfJAm4CIBhBbi/rVKVNqrLEMzi18YleHvYQgcnFdPskNaYiYYV2M9wya+UyRJwLoSQrDSwiTnIiP68yqYT9xVqtiPgYd2M7zF4R3YWG4DUZ/tCkQ9BtJjTfys0DWp+AUEEGMTgBQdq44vDMV4iOA0U+YVmXjaJib2+Ks+7QE0gXp7shyrosP6vaHvjBr3tgb1+P+t+oOshdOay7e45daZ3NC4GdoKAzXXaibz6C+fctLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b+j1wn4iLGbHT6ha7PMtwygCU4K1bQlPpkMJt18PqQ=;
 b=dFmHsllrXEXHFYqXBQs7oBvgeY/V/LUmKp0nECYlXD1In4RocRaLbcv9iXkL23Fv7t7W36NUXIHjZ/DUBtX8TeyMjx4YRM4/cy1G908gTe/5RI87fhLpGrAld7mDwEdy4UK0/tAesfdgt77/vTW69GGGgj0fSQ78vHaX5eYFecf3sQKaUJIurcO1HmSIFiyrLdbXX5R6Rqy2B5NAFFJZB8W9fEfaCCCOQ0n+aPbGBwxQi9E4TTcq/fi3BL055z7DUXb7ByedVBOm5qMNpFwgE7UBpVUJUhtZR+2dokquJSxAVmaqb9WUAob4zTp7YEosqBRr+ZQ4N1q3Adai8QYy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b+j1wn4iLGbHT6ha7PMtwygCU4K1bQlPpkMJt18PqQ=;
 b=fbobBDAqw/Warq63iX/2Ysspd6i47G4HCMOzILwfqRuU2adnTo8wGrBJr80DniYROKZd6I+kAkNkIL4xpaCSN0xAWIIsZFdaHb8vlkQpvazTgOGJOF0yVQe1G+4etO31MkfvzVYtIVqv2I97Hx3l1Uc4ehlrt1YohDukpBa1ZM2R+Dpq1mY4iu6TBleAgdizprh04RdW1NH5LQtRf/rXPyKclNe2TBnhUYE+qQeU8brk90WaG59tszkXMfHkOXQkPH87V0Xi4zzzuNFvufRGKYbf2xVN+xGf0caEFT1J0cUE3he+X0/cI1dqhfqk65cj/NlSj/iHmYVoD57VKw9MJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:52 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:52 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 05/12] dracut-config-cip-*: add build configuration packages
Date: Mon, 19 Oct 2026 12:25:16 +0200
Message-ID: <20261019102541.672620-6-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3d293b-0671-40e7-a5b8-08df2dcb593c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|3023799007|261009223027099003|261009221227099003|261009223327099003|261009221727099003|261009220027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	MsUBm8dtNkobmX3TW8jI0VfPdrriO3Ukslwc2o7EKBtyTPA8eMAw8iBFmltEEqNX6F9/1k9tY0yby9xuzQDjV7+fyRuvPhFhxVDzcRXyPJkWNsY0rAarnfU1sEqLYXLL7w1JmSyXc16m1z7qbBkgcAP5N92pywXgE4tj7RZA94wh6KBDqh6uVyoZwd48GjA8hVCYf5f7A/1kOSJ+3mjqd9UaXDHksuodOcfdQG4fRfUZB8yB2duaV8gY+FcDVi/UOkUXkrmqDx8xnXIC7176emh93fW57/qA1icpvWiWolKNu7jIHvPEFZQPtm0kjT3cvzao+18rBTIzPZXhzRDA357hG1W8QpeQLPTK594KZyz9mo7AwQk/3UJrqOX5NuMbWOR3529azT3VHJiKpmzSWv7xWZyZGGrvrs8r5gWxzUCZ5DIPZSA2RI2RnV1EWjl0EGtvPeG9td7FCnZSO1tHW5ucOM/cZLnbM+zCHah+rY20sF7WGPef85x9kGnPW3kkna8g7PowsrLlzKjDSqJ1PMxOKr5/oRrA050x1UFL//DS7n9AWeIMe1cOKrKW/qVi7El7LPynLakYVsYNVKBsPBPcL6es0YLo11sd8Q0xv7MhK+KVDlMFwFE6X6QUMrStiXaytfQcLhiggvhJV9taI3TDxQpXgeVLEIbBRDU1aoU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009220027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G9YfsX5UQolMlKZq3LXxeqTSE8m3Kr9/s92XDZRxOdeFzB19s0m1yaQCpyzg?=
 =?us-ascii?Q?Hv36KgwzfTPLawLmSEUNlT0/W/yWU85X+wZUEmwIk0W/LtZ+bkc4PRw0/MUW?=
 =?us-ascii?Q?y+wWgx73zAr61S5qnpJ4C4CgE3xwyXUMyTRR2v4hkpgQu+eoGjNQQfd6PpCG?=
 =?us-ascii?Q?99OQi3LQTa7nm/h+650/8+8JzN7eWD1XR6sV54Ta8uqo+OApTwt4RXanUG6n?=
 =?us-ascii?Q?GZvN9CwZpohYLw7FTMKbi0t9XPwZ+zA8C6i6+F4mWNypAqzWPhispd3qd/hb?=
 =?us-ascii?Q?YcMBONCe2hvsE1FgefK3LyeLv7METPh6uICF0PLHoSRBNuVcnPcp2j+01E/M?=
 =?us-ascii?Q?Uycp9lif0UIT3mwQq7dH3ptiBKNI5cwh4ergKYFVCsDoByKqycbf2Mf/KTVU?=
 =?us-ascii?Q?IQ74weIB0ffQ6QnDQY1TJGa7I1EIKWJqd68iuzfTQX/N3AgPGkQST/Nf/35y?=
 =?us-ascii?Q?wv9CTDCdblAlG3bCWwW6VM8HZ2JFFH1kkhipv4C0xSzScS7LQW7v02j2Ajw5?=
 =?us-ascii?Q?YxbjOUWwiX6BtIPiBjZnC74XLuuk6T0S6ibDtpvukuPSr3s3nKF54KozoxfP?=
 =?us-ascii?Q?rjcLkPXwd11uMkOnj0/g6W7lpS8QAkJotRNm5+TpUGolY7TD5MSZu1onlRC5?=
 =?us-ascii?Q?XRwXPboZlsRcrDPNUqd6xnN4HrGgqDkKtPzmWEc8j2YDVCHXn+n75gSUBXEE?=
 =?us-ascii?Q?iacIx2FL2dIB0ENgcXmqS0tT/FSpJNZ3f/bxn+whJN5vxfNDBL7ulVVXmK5B?=
 =?us-ascii?Q?/F/tyDGhdWPpqbGfqM1QM/YNyEBuz6tItrkpRkz4gP6W0N8XNBbkw5JGuubS?=
 =?us-ascii?Q?vFw7PtiIueo7M5BnbKx2LxY9TBmKNsCycGQzie+w5iToSVEAsS57k260qpVg?=
 =?us-ascii?Q?Z4qbw75PuqcBLTd3xnD4nosoH+iZke+F+kURdvILebgNY9elOKUfy8BSjmwJ?=
 =?us-ascii?Q?9lAVXEWRkjD+205IvkqZO7jDwpB04n00XERUl4fdyzkpgeIsR5lYUsVP/bOt?=
 =?us-ascii?Q?Ht4tikssiQYw+0GpKS7q49kOeH8rEADx4P5v09ZT58CYOBTtVsq343JSPr2t?=
 =?us-ascii?Q?D2eU7aIAVWkonV/ndlxwoyGi3Pem8LWPKAGoe9a4v4QT6QlMY2O2oNrYWkl0?=
 =?us-ascii?Q?0pWiUt0b+i0NM9NV+v6R+T+owcL/eOykq9fEsEDvOpan6auxOrmchkntWKbq?=
 =?us-ascii?Q?2oW7970rgCwCzLt2/d4H3BwQBzNKZcQvWybXN3TRNM1OmqYskQWeuqvGgehb?=
 =?us-ascii?Q?CiEwt6C+5rKy0ahk3Q0h3FSqOhhD7lDwhmrZGTdhr3LMO3U1Y7Dlpd6n/t6L?=
 =?us-ascii?Q?UvYzJGT0bHwo+EL47JR4GHTEe8uDYht+Ki9I1VmSav2OKUY7NKf0jjB44xJq?=
 =?us-ascii?Q?nDJFMml70CSUV9nVmY/BnaTVtK4if8oFvMGi3UlIHRx+EudYqxsKa5cLF1zI?=
 =?us-ascii?Q?n/rxKmDBlUxgy9B9BDRuJCiFe9a8HRnS6u96rkKtpilR8qSh50YlJXhbXJ7N?=
 =?us-ascii?Q?1XH7T2Ak9CQm5/4hZ00pCU6/xu9RM6v4nJL1KUMJhqE3fX9A94DLOvl2RIIe?=
 =?us-ascii?Q?g8X3EuoGTxHYyKevO5k7mC5mB6SvASaoWvaTYgYcrEbtrZFuvT4y7OqA6B/0?=
 =?us-ascii?Q?REpOyf3+jx24Jd265MwXq2BxJoANgCVyaLrDTiWK03bQOXj3OGLHwAKjYBfc?=
 =?us-ascii?Q?ConqKvC4hfUXD6gVmgB1KN79drIpg4h6kRPpcY4ylwQiBtIuGtwgaOPwdYCp?=
 =?us-ascii?Q?TUiKfd0PfvXjqtRT/lJqLOMvU8c5dAk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3d293b-0671-40e7-a5b8-08df2dcb593c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:51.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAaNxYGKQLj+/680GKjwL8WqDcbKQMua6Ku/lTnb/nJThTf1Kzg2l52ZWwWEkCogkaew0vPl8dAuFL5jGJKyCJ1Hh0NMfsoJWqfeuTFWm2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24493

One package per dracut module writes the existing BitBake configuration
(INITRAMFS_OVERLAY_*, CRYPT_*, INITRAMFS_FACTORY_RESET_*,
DRACUT_VERITY_DEVICE_TIMEOUT) to /etc/dracut-cip/cip-<module>.conf and
depends on the matching module package. Values are validated at build
time, not at parse time, so other configurations are not affected.

dracut-config-cip-crypt also generates the crypttab for
CRYPT_PARTITIONS and installs it as /etc/crypttab from its postinst,
as cryptsetup already creates that file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/dracut-cip-config.bbclass      | 54 ++++++++++++
 .../dracut-config-cip-crypt_0.1.bb            | 86 +++++++++++++++++++
 .../dracut-config-cip-crypt/files/postinst    | 10 +++
 .../dracut-config-cip-factory-reset_0.1.bb    | 49 +++++++++++
 .../dracut-config-cip-overlay_0.1.bb          | 44 ++++++++++
 .../dracut-config-cip-verity_0.1.bb           | 23 +++++
 .../dracut-config-cip-watchdog_0.1.bb         | 30 +++++++
 7 files changed, 296 insertions(+)
 create mode 100644 classes-recipe/dracut-cip-config.bbclass
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config=
-cip-crypt_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postins=
t
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracu=
t-config-cip-factory-reset_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-conf=
ig-cip-overlay_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-confi=
g-cip-verity_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-con=
fig-cip-watchdog_0.1.bb

diff --git a/classes-recipe/dracut-cip-config.bbclass b/classes-recipe/drac=
ut-cip-config.bbclass
new file mode 100644
index 00000000..2714243e
--- /dev/null
+++ b/classes-recipe/dracut-cip-config.bbclass
@@ -0,0 +1,54 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+# Writes CFG_VARS as KEY=3D'value' to /etc/dracut-cip/${CONF_NAME}.
+# CFG_VAR_SRC[KEY] =3D "VAR" takes the value of KEY from VAR instead.
+# Recipes validate values in dracut_cip_validate and extend do_install
+# with :append.
+
+inherit dpkg-raw
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+
+DEPENDS +=3D "embedded-dracut-modules"
+
+CONF_NAME ?=3D ""
+CFG_VARS ?=3D ""
+
+def dracut_cip_cfg_srcs(d):
+    return ' '.join(d.getVarFlag('CFG_VAR_SRC', v) or v
+                    for v in (d.getVar('CFG_VARS') or '').split())
+
+python dracut_cip_validate() {
+    pass
+}
+
+python do_validate_dracut_config() {
+    if not d.getVar('CONF_NAME'):
+        bb.fatal("CONF_NAME must be set")
+    for v in d.getVar('CFG_VARS').split():
+        val =3D d.getVar(d.getVarFlag('CFG_VAR_SRC', v) or v) or ''
+        if "'" in val or '\n' in val:
+            bb.fatal("%s must not contain a single quote or newline: %s" %=
 (v, val))
+    bb.build.exec_func('dracut_cip_validate', d)
+}
+do_validate_dracut_config[vardeps] +=3D "dracut_cip_validate ${@dracut_cip=
_cfg_srcs(d)}"
+addtask validate_dracut_config before do_install after do_patch
+
+python do_write_dracut_conf() {
+    path =3D os.path.join(d.getVar('WORKDIR'), d.getVar('CONF_NAME'))
+    with open(path, 'w') as f:
+        for v in d.getVar('CFG_VARS').split():
+            val =3D d.getVar(d.getVarFlag('CFG_VAR_SRC', v) or v) or ''
+            f.write("%s=3D'%s'\n" % (v, val))
+}
+do_write_dracut_conf[vardeps] +=3D "CFG_VAR_SRC ${@dracut_cip_cfg_srcs(d)}=
"
+addtask write_dracut_conf before do_install after do_validate_dracut_confi=
g
+
+do_install() {
+    install -D -m 0644 ${WORKDIR}/${CONF_NAME} ${D}/etc/dracut-cip/${CONF_=
NAME}
+}
diff --git a/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb
new file mode 100644
index 00000000..981c1ff7
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-crypt_0.1=
.bb
@@ -0,0 +1,86 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration and /etc/crypttab for the cip-crypt d=
racut module"
+DEBIAN_DEPENDS =3D "dracut-cip-crypt"
+
+# CRYPT_PARTITIONS elements are <partition-label|uuid|/path>:<mountpoint>:=
<reencrypt|format|noencrypt|format-if-empty>[:expand]
+CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
+CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
+CRYPT_SETUP_TIMEOUT ??=3D "600"
+CRYPT_HASH_TYPE ??=3D "sha256"
+CRYPT_KEY_ALGORITHM ??=3D "ecc"
+CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
+CRYPT_BTRFS_SUPPORT ??=3D "0"
+CRYPT_BACKEND ??=3D "systemd"
+INITRAMFS_CRYPT_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+
+OVERRIDES .=3D "${@':expand-on-crypt' if ':expand' in (d.getVar('CRYPT_PAR=
TITIONS') or '') else ''}"
+DEBIAN_DEPENDS:append:expand-on-crypt =3D ", cloud-guest-utils, fdisk"
+
+CONF_NAME =3D "cip-crypt.conf"
+CFG_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD CRYPT_SETUP_TI=
MEOUT \
+    CRYPT_HASH_TYPE CRYPT_KEY_ALGORITHM \
+    CRYPT_ENCRYPTION_OPTIONAL CRYPT_BTRFS_SUPPORT CRYPT_BACKEND \
+    INITRAMFS_CRYPT_MOUNT_OPTIONS"
+
+CIP_CRYPT_UUID_RE =3D "^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$"
+
+python dracut_cip_validate() {
+    import re
+    if d.getVar('CRYPT_BACKEND') !=3D 'systemd':
+        bb.fatal("cip-crypt: only CRYPT_BACKEND=3Dsystemd is supported (go=
t '%s'). "
+                 "Use initramfs-crypt-hook for clevis." % d.getVar('CRYPT_=
BACKEND'))
+    if bb.utils.to_boolean(d.getVar('CRYPT_BTRFS_SUPPORT')):
+        bb.fatal("cip-crypt: CRYPT_BTRFS_SUPPORT is not supported")
+    if not re.fullmatch(r'[0-9]+(s|min)?', d.getVar('CRYPT_SETUP_TIMEOUT')=
 or ''):
+        bb.fatal("cip-crypt: invalid CRYPT_SETUP_TIMEOUT '%s'" % d.getVar(=
'CRYPT_SETUP_TIMEOUT'))
+    uuid_re =3D d.getVar('CIP_CRYPT_UUID_RE')
+    for entry in (d.getVar('CRYPT_PARTITIONS') or '').split():
+        label =3D entry.split(':')[0]
+        if re.search(uuid_re, label, re.IGNORECASE) and not re.search(uuid=
_re, label):
+            bb.fatal("cip-crypt: UUID '%s' in CRYPT_PARTITIONS must be low=
er-case" % label)
+}
+
+python do_generate_crypttab() {
+    import re
+    uuid_re =3D d.getVar('CIP_CRYPT_UUID_RE')
+    lines =3D []
+    for entry in (d.getVar('CRYPT_PARTITIONS') or '').split():
+        fields =3D entry.split(':')
+        label =3D fields[0]
+        mode =3D fields[2] if len(fields) > 2 else ''
+        if mode =3D=3D 'noencrypt':
+            continue
+        if label.startswith('/'):
+            device =3D label
+            name =3D label.rsplit('/', 1)[-1]
+        elif re.search(uuid_re, label):
+            device =3D '/dev/disk/by-partuuid/%s' % label
+            name =3D label
+        else:
+            device =3D '/dev/disk/by-partlabel/%s' % label
+            name =3D 'encrypted_%s' % label
+        lines.append('%s %s - tpm2-device=3Dauto,tpm2-pcrs=3D7,x-initrd.at=
tach,nofail\n'
+                     % (name, device))
+    with open(os.path.join(d.getVar('WORKDIR'), 'crypttab'), 'w') as f:
+        f.writelines(lines)
+}
+do_generate_crypttab[vardeps] +=3D "CRYPT_PARTITIONS"
+addtask generate_crypttab before do_install after do_validate_dracut_confi=
g
+
+# /etc/crypttab is created by cryptsetup's postinst; shipping it as a
+# conffile would trigger a dpkg prompt. postinst installs it instead.
+SRC_URI +=3D "file://postinst"
+
+do_install:append() {
+    if [ -s ${WORKDIR}/crypttab ]; then
+        install -D -m 0644 ${WORKDIR}/crypttab ${D}/usr/share/dracut-cip/c=
rypttab
+    fi
+}
diff --git a/recipes-initramfs/dracut-config-cip-crypt/files/postinst b/rec=
ipes-initramfs/dracut-config-cip-crypt/files/postinst
new file mode 100644
index 00000000..24c38121
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/files/postinst
@@ -0,0 +1,10 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+if [ "$1" =3D configure ] && [ -f /usr/share/dracut-cip/crypttab ]; then
+    install -m 0644 /usr/share/dracut-cip/crypttab /etc/crypttab
+fi
diff --git a/recipes-initramfs/dracut-config-cip-factory-reset/dracut-confi=
g-cip-factory-reset_0.1.bb b/recipes-initramfs/dracut-config-cip-factory-re=
set/dracut-config-cip-factory-reset_0.1.bb
new file mode 100644
index 00000000..84eec1f6
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-factory-reset/dracut-config-cip-f=
actory-reset_0.1.bb
@@ -0,0 +1,49 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-factory-reset dracut modu=
le"
+DEBIAN_DEPENDS =3D "dracut-cip-factory-reset"
+DEBIAN_DEPENDS:append:encrypt-partitions =3D ", cryptsetup-bin, tpm2-tools=
, dracut-config-cip-crypt"
+
+INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
+INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D "0"
+INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D "1"
+INITRAMFS_FACTORY_RESET_TIMEOUT ?=3D "${@ d.getVar('INITRAMFS_SETUP_TIMEOU=
T') or 600}"
+
+OVERRIDES .=3D "${@':btrfs-support' if d.getVar('INITRAMFS_FACTORY_RESET_L=
UKS_FORMAT_TYPE') =3D=3D 'btrfs' else ''}"
+DEBIAN_DEPENDS:append:btrfs-support =3D ", btrfs-progs"
+
+CONF_NAME =3D "cip-factory-reset.conf"
+CFG_VARS =3D "INITRAMFS_FACTORY_RESET_DEVICES INITRAMFS_FACTORY_RESET_LUKS=
_FORMAT_TYPE \
+    INITRAMFS_FACTORY_RESET_CLEAR_TPM INITRAMFS_FACTORY_RESET_TIMEOUT"
+
+python dracut_cip_validate() {
+    import re
+    for dev in (d.getVar('INITRAMFS_FACTORY_RESET_DEVICES') or '').split()=
:
+        if not dev.startswith('/'):
+            bb.fatal("cip-factory-reset: device '%s' must be an absolute p=
ath" % dev)
+    fstype =3D d.getVar('INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE') or ''
+    if fstype not in ('ext4', 'btrfs'):
+        bb.fatal("cip-factory-reset: LUKS_FORMAT_TYPE must be ext4 or btrf=
s, got '%s'" % fstype)
+    timeout =3D d.getVar('INITRAMFS_FACTORY_RESET_TIMEOUT') or ''
+    if not re.fullmatch(r'[0-9]+(s|min)?', timeout):
+        bb.fatal("cip-factory-reset: invalid TIMEOUT '%s'" % timeout)
+}
+
+python () {
+    overrides =3D (d.getVar('OVERRIDES') or '').split(':')
+    if 'factory-reset' not in overrides or d.getVar('INITRD_CMDLINE_STYLE'=
) !=3D 'systemd':
+        return
+    provider =3D d.getVar('PREFERRED_PROVIDER_factory-reset-helper') or ''
+    if provider !=3D 'factory-reset-helper-efi':
+        bb.fatal("dracut-config-cip-factory-reset requires EFI variables: =
set "
+                 "PREFERRED_PROVIDER_factory-reset-helper =3D "
+                 "'factory-reset-helper-efi' (got '%s')." % provider)
+}
diff --git a/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-=
overlay_0.1.bb b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-=
cip-overlay_0.1.bb
new file mode 100644
index 00000000..a8bf1d37
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-overlay=
_0.1.bb
@@ -0,0 +1,44 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-overlay dracut module"
+DEBIAN_DEPENDS =3D "dracut-cip-overlay"
+
+INITRAMFS_OVERLAY_PATHS ??=3D "/etc"
+INITRAMFS_OVERLAY_STORAGE_PATH ??=3D "/var/local"
+INITRAMFS_OVERLAY_STORAGE_DEVICE ??=3D "/dev/disk/by-label/var"
+INITRAMFS_OVERLAY_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+# File name in FILESPATH; empty uses the script shipped with the module.
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D ""
+
+DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH =3D "${@ '/usr/share/dracut-cip/overla=
y_recovery_action.script' if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT') =
else ''}"
+
+SRC_URI +=3D "${@ 'file://' + d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT'=
) if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT') else ''}"
+
+CONF_NAME =3D "cip-overlay.conf"
+CFG_VARS =3D "INITRAMFS_OVERLAY_PATHS INITRAMFS_OVERLAY_STORAGE_PATH \
+    INITRAMFS_OVERLAY_STORAGE_DEVICE INITRAMFS_OVERLAY_MOUNT_OPTIONS \
+    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
+CFG_VAR_SRC[INITRAMFS_OVERLAY_RECOVERY_SCRIPT] =3D "DRACUT_OVERLAY_RECOVER=
Y_SCRIPT_PATH"
+
+do_install:append() {
+    if [ -n "${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" ]; then
+        install -D -m 0755 ${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}=
 \
+            ${D}${DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH}
+    fi
+}
+
+python dracut_cip_validate() {
+    paths =3D (d.getVar('INITRAMFS_OVERLAY_PATHS') or '').split()
+    for v in ['INITRAMFS_OVERLAY_STORAGE_PATH', 'INITRAMFS_OVERLAY_STORAGE=
_DEVICE']:
+        paths.append(d.getVar(v) or '')
+    for p in paths:
+        if not p.startswith('/'):
+            bb.fatal("cip-overlay: path must be absolute, got '%s'" % p)
+}
diff --git a/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-v=
erity_0.1.bb b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip=
-verity_0.1.bb
new file mode 100644
index 00000000..4c90bcea
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-verity_0=
.1.bb
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-verity dracut module"
+DEBIAN_DEPENDS =3D "dracut-cip-verity"
+
+DRACUT_VERITY_DEVICE_TIMEOUT ?=3D "30"
+
+CONF_NAME =3D "cip-verity.conf"
+CFG_VARS =3D "DRACUT_VERITY_DEVICE_TIMEOUT"
+
+python dracut_cip_validate() {
+    import re
+    t =3D d.getVar('DRACUT_VERITY_DEVICE_TIMEOUT') or ''
+    if not re.fullmatch(r'[0-9]+(s|min)?', t):
+        bb.fatal("cip-verity: invalid DRACUT_VERITY_DEVICE_TIMEOUT '%s'" %=
 t)
+}
diff --git a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip=
-watchdog_0.1.bb b/recipes-initramfs/dracut-config-cip-watchdog/dracut-conf=
ig-cip-watchdog_0.1.bb
new file mode 100644
index 00000000..1fd1a87e
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchd=
og_0.1.bb
@@ -0,0 +1,30 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-watchdog dracut module"
+DEBIAN_DEPENDS =3D "dracut-cip-watchdog"
+
+INITRAMFS_WATCHDOG_DEVICE ??=3D ""
+INITRAMFS_WATCHDOG_SEC ??=3D "${@ int(d.getVar('WDOG_TIMEOUT') or 0) or 60=
}"
+
+CONF_NAME =3D "cip-watchdog.conf"
+CFG_VARS =3D "INITRAMFS_WATCHDOG_DEVICE INITRAMFS_WATCHDOG_SEC"
+
+python dracut_cip_validate() {
+    import re
+    dev =3D d.getVar('INITRAMFS_WATCHDOG_DEVICE') or ''
+    if dev and not dev.startswith('/'):
+        bb.fatal("cip-watchdog: device '%s' must be an absolute path" % de=
v)
+    sec =3D d.getVar('INITRAMFS_WATCHDOG_SEC') or ''
+    if dev and not re.fullmatch(r'[1-9][0-9]*', sec):
+        bb.fatal("cip-watchdog: invalid INITRAMFS_WATCHDOG_SEC '%s'" % sec=
)
+}
--=20
2.55.0


