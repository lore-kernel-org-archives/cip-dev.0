Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15681.1794914933922263860
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=MBDUvvWO;
 spf=pass (domain: siemens.com, ip: 52.101.84.18, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJyXF8Qlo5AkqgyhpB+7DlyibWtGZhI7yyU+pihHaaXDeRTOeIEDzCBWqNRyeREYvxNXboKH3Xh0mjgE09uqqjustUK3zXBWk+ldJbCn6wkiwdRLObIh3rqapnkHYigI/WH2/2KEfuBBZP4J/hBu2gHsXxZUpIjM5ZRXz7j2Tv4RNGDtGJvSydfOz9FpH/orNwi0LVahrWseQ/IHFcTYcSIbKJXj8u8PL6mQn7GJ5mquPJsg2ESRJkthbktShuZmzzxrpsLj6J8oIFxOEIglmGsqrGZcXYL+LBOiT84ySEfV45k2zzFiPWlCqBoelCulm/e5NUkcWIu+CamiaMpqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O6Tp29Cf4gWF6aQXOPK/3WudUkSWa+lAFqb9kGw8j8=;
 b=ayG/oA/H5ON/A2cTsLeDa8YVegtPsQKjuNpnQMkMVdONUko5IUmwabAoLEos3330drNPlbk8lQ/PFmyLzPTU+hxV6Fem+UjL7aIW6f0IWSSOI11aErkGDY+58BJwRMzkRPXIhETZwt0RfDgTvWg3oxAA/TBQ3cpJUtFnMBJNZQgIW2CDyjAsGRcoJS8alxs4uIWGgCsAf4foVc6Xe6hFOYLTfMqVmj6X/NGiBbVPWVCRIlNAoqBiYQMqLH0hBPzglXXDwR9nExbhPPVLIfIjzNDX1DpnuKNh3jL1Xojahq6irKb0LABhx9I/baKoKMzu96pXBsgRn2pcagWuhNFYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O6Tp29Cf4gWF6aQXOPK/3WudUkSWa+lAFqb9kGw8j8=;
 b=MBDUvvWOk64hIAGuGZyAQvZiffZc+qNck/Gghi9e3qB2r1cHMmEKmZIT8rszYEYLm4eit3HnywoiloCWwkrO8DxqK2X3wglMgDOWT4OSWvaUxI7Vp3bHEsrag0FQkjt6G/oZULk64N0wQ50AYKqIxtKbnD0ZUoLkYF1d2tzYSBKgSzBOLE5/ES5aQkleiGrLQrw9sFL32JGWTMFcbIFXyIy43ZmgPPJq7oxAHtCOTjNXmLyodlGvyER/wR8rtBAgdzKY56bTge7KCr3ECUYYTHG/3OUIDreK4r29dBzKGOcW2c9VON6pTRPPbq2aU3AGWj81DduKB+WKezXCKG2U2Q==
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
 11:28:47 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 10/19] dracut-config-cip-*: add build configuration packages
Date: Tue, 17 Nov 2026 12:28:24 +0100
Message-ID: <20261117112833.316234-11-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8ae8554-8a7e-4695-b57a-08df449df0f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: /m/9pGU4ODkZyN2VrpYM4Gz3RXUk54Bi5MFNc4/A0+C/EquD3Ai6O5jgrNGB69Dkw50XBfscimaC79aMYDiWo6bGkmC0W3i6hgzzyeWD3fVucjbKdSxaxpnBKlz+TlUh2hDnW/4g1qfymrMsyRuD0nzCBX84KFxzdy8AFG8CDDEsiCvsuDIKvsKkWJPDHX2TPJT2AAzW7GTOQonkLe3wCxprysPHYtbDdVvUjEPWRhSS6NybqBlxEtkSjnZ7awIZVxE0Eyz/Dirb+qZBr3lCnoQvpOeTOLSa5gyJTceDhaSn9cS9zKw2j17xgDTbn0JegnYvG4EqJf0fqMqf+ZoY0xXK0YmkaQGMsnFRWtm6p8JE98syMWuwzci3w2gDU+l69QLOjrHU1XV6Z2m2EzlVhQq1P4jIvKVVp8C6oQDWIQTKqvaaMHEBA3ryBYRIH9P2E0FCLk7lPS2N1mUG8Zfvlnxh/c3lmr/bQ64lh4Soc/ZoMdJK0atYvHW7LlisUypyGK/eHuBCUHAeGoEwQVDjdvMAf4gCZTZHMwyAerknkPKqSM4TM1fxF6Qqkd2aXeFchFDNFHDuytl378pJxxPzCpyFVGkyv+sjWwV/Ezgsk2MtDJPIH3vHB4RHEYrVn1Kdtp1YVZcD6Nm7woRmzBhrlXIEnZ2wxqEvByNf2IzXr1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lVc04HSqP5nQ5XD3BOFm0vx57LpWmxHaN3MjL1oyvc2l/fQzwtf9tMPX2VkA?=
 =?us-ascii?Q?2WNtdqNpy2czzQr4qFa0Bx95qFYoGBiG0sBd5uha3CsWT+gHF1/kVnmI3imX?=
 =?us-ascii?Q?Iwx4zEeLlwD4uhkhkMHz+KxY3RdFTh5DFIJG9dpXUl54gtMF1W2oYtdbXua0?=
 =?us-ascii?Q?AQbPZUz7TRP65VjR466Zl6AY8UtZ6sHIIlEbOzXIG4okWM86jCr8Nmw+2VPO?=
 =?us-ascii?Q?6QNkQq/pkxQEsaJOPHK3qOD7Kl378iX1GPX3Tkfwz0xQ/vmdT6kYVz5GScdR?=
 =?us-ascii?Q?G3ospG5OAhSa/gzx6DJFsXNaugeMYaWUfcoHJRFUq7fi+bzBcuJKwXpm/ECm?=
 =?us-ascii?Q?Kcv4L6BmhAT+JUqybY9gbFmLbkfGf/mIFDogeZCeE7QJxlvASJGzNYfs6a0k?=
 =?us-ascii?Q?UwH0DdhF+NCO8/tbrr2n756kZob/BWRofsk9wBm+Nw2/k5XG61ibHgxPJEwm?=
 =?us-ascii?Q?6saei/gO9N9HIkyU39c5Wq9zWA1kT6EfEFBJsVyJIJKI9neMj7M8SCMKsJbq?=
 =?us-ascii?Q?5GoOOpEgIQpYiCEyF4BRs/aqr8T8nA7i1021s15nAB9S9HkeBpw9ZU+jPzPc?=
 =?us-ascii?Q?eKitJPpl3AKSmerhxNYSnklOuHiWR9M5M+lqdpoYeCcoDfpd84BN6nbDE8hX?=
 =?us-ascii?Q?Fwd9LP0JABO5s9Vhrwm41KXuPV+rmtXGFUBnGj7dr8ZUhepN9c1aM8NUzK2i?=
 =?us-ascii?Q?6d+FmTEI7ocras13ONWeUAj6pYxWRj9YtHHKL/nF63QiVa5woIKYcGCJ2q90?=
 =?us-ascii?Q?E2eB+okrVj2GRi2CuN6JXPdnukb6WzuYa2ya8WLguIa/n+JFDYgddfNgzbtD?=
 =?us-ascii?Q?o+NxqBzBHjhkzBriSQQElyhwtXTk1dX+dnM6CpYjLYflMq7uU0MLOcTx1rSJ?=
 =?us-ascii?Q?L+Z0l5jUoq3cWY4+FO1pL7tjXlJNgbVozee4F7N4uII8z7V914m7FPNHiMxn?=
 =?us-ascii?Q?0F21Y92RpGy6zoUYd9oQrJcLNAUIpLSmKGB5aP73NEIAc3O6wFq7B2PyfB3E?=
 =?us-ascii?Q?BAU3etDZFOpLwMqFBzW7FshOS0kFCuPztzORs3Hbdw37jrSJQtm4EgXrzWYZ?=
 =?us-ascii?Q?0dp4WqLQfrP6c7xnWP4ft1C+EGbE1/5rGS4lCNPictw1GYYMJA0GWFVUOnGJ?=
 =?us-ascii?Q?UOyu1SpcRTXE5Mxgdkb8iRRJybOq7F69z2xU0FEeD1cnyxcbWBoSuxpj831k?=
 =?us-ascii?Q?w3rtwRCMxadKcDCFNGSJOPFuwxhK+3v7nkceyg3w/kY3MkAfpCJLmAiikjXr?=
 =?us-ascii?Q?CsjFSZYPOLIeTMFLQSb6BSLWRGG193b1MH7iXGZDfDTMgtj9YFzVt7I/b45h?=
 =?us-ascii?Q?0tuCMdG3FYoPNxWanjqr/EpTn1EjWnSvnqf2YYv602krmmc15nHszjFn8BE7?=
 =?us-ascii?Q?movKY0sFbOdxaG/gXPFvi9jCOA/pZq2wu8tVQ38F8fMu/8WJLxai6BOF4GRQ?=
 =?us-ascii?Q?GIA4dt3t8WxeyV7V6CG/fgRTiABChzn5IdmMQyMyDk0fhlrLbwFFoq5AWrdt?=
 =?us-ascii?Q?qdfMvebfUHMWC4/oPCLYqGE2geZIGJYc+pTRCaMiSRWf4A82Z7bP+NVYVl92?=
 =?us-ascii?Q?E6RDfvs47+xaDMnggFj4A0HNRDQVhlhALm4UsGT80JHxklit9zWpxoCsvO9S?=
 =?us-ascii?Q?X1DChBtrC53ZxYydPW4f/IqsJlYwvt4rD6+8kVXy512UpAZszUpzEV/1dV1R?=
 =?us-ascii?Q?7vGL4xpJzsoFEKjKaad8WCXK2vOmIa2zaWqDcwixk0Hwr43aVPUhrC8Wpq9g?=
 =?us-ascii?Q?NPAeBuD/AgwpgufGi/LsU1tdoWYHOXw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ae8554-8a7e-4695-b57a-08df449df0f2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:45.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lORSCSHLxBt6A1MsAJywvGkXqe51i5n5c+BtzMQLNOvhkxQjRcUI2VX/wyWmYJMT7wuAEsz3tbMegaEUDfnWzQz1WUHZHgUMUuoRlPrM8Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24831
Content-Type: text/plain; charset="utf-8"

One package per dracut module writes the existing BitBake configuration
(INITRAMFS_OVERLAY_*, CRYPT_*, INITRAMFS_FACTORY_RESET_*,
DRACUT_VERITY_DEVICE_TIMEOUT, DRACUT_VERITY_DEVICE_LINK) to
/etc/dracut-embedded/embedded-<module>.conf and depends on the matching
module package. The configuration of each package is a fixed file in the
recipe, files/embedded-<module>.conf.tmpl, which Isar renders with the
BitBake values and the recipe installs unchanged, so what ends up on the
target can be read from the recipe. The values are not checked, as the
initramfs-tools hooks do not check them either.

dracut-config-cip-crypt also generates the crypttab for
CRYPT_PARTITIONS and installs it as /etc/crypttab from its postinst,
as cryptsetup already creates that file.

The postinst installs the crypttab on the first installation, or when
/etc/crypttab has no entries yet, but does not overwrite an edited one on
an upgrade. An upper-case UUID in CRYPT_PARTITIONS is rejected, as the
embedded-crypt module does not accept it.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/cip-crypt-root.bbclass         | 37 +++++++++
 .../dracut-config-cip-crypt_0.1.bb            | 82 +++++++++++++++++++
 .../files/embedded-crypt.conf.tmpl            | 10 +++
 .../dracut-config-cip-crypt/files/postinst    | 16 ++++
 .../dracut-config-cip-factory-reset_0.1.bb    | 36 ++++++++
 .../files/embedded-factory-reset.conf.tmpl    |  4 +
 .../dracut-config-cip-overlay_0.1.bb          | 40 +++++++++
 .../files/embedded-overlay.conf.tmpl          |  5 ++
 .../dracut-config-cip-verity_0.1.bb           | 30 +++++++
 .../files/embedded-verity.conf.tmpl           |  3 +
 .../dracut-config-cip-watchdog_0.1.bb         | 29 +++++++
 .../files/embedded-watchdog.conf.tmpl         |  2 +
 12 files changed, 294 insertions(+)
 create mode 100644 classes-recipe/cip-crypt-root.bbclass
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config=
-cip-crypt_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/embedde=
d-crypt.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postins=
t
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracu=
t-config-cip-factory-reset_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/files=
/embedded-factory-reset.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-conf=
ig-cip-overlay_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/files/embed=
ded-overlay.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-confi=
g-cip-verity_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/files/embedd=
ed-verity.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-con=
fig-cip-watchdog_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/files/embe=
dded-watchdog.conf.tmpl

diff --git a/classes-recipe/cip-crypt-root.bbclass b/classes-recipe/cip-cry=
pt-root.bbclass
new file mode 100644
index 00000000..7a21b31e
--- /dev/null
+++ b/classes-recipe/cip-crypt-root.bbclass
@@ -0,0 +1,37 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+# Shared helper for dracut config recipes.
+
+# Return the space-separated subset of ABROOTFS_PART_UUID_A/_B that is the
+# first field of a non-noencrypt entry in CRYPT_PARTITIONS (empty if none)=
.
+def cip_crypt_root_partitions(d):
+    encrypted =3D set()
+    for entry in (d.getVar('CRYPT_PARTITIONS') or '').split():
+        fields =3D entry.split(':')
+        if len(fields) > 2 and fields[2] =3D=3D 'noencrypt':
+            continue
+        encrypted.add(fields[0])
+    uuids =3D [d.getVar('ABROOTFS_PART_UUID_A'), d.getVar('ABROOTFS_PART_U=
UID_B')]
+    return ' '.join(u for u in uuids if u and u in encrypted)
+
+# Shared default; both dracut config recipes inherit this class so they ag=
ree.
+CRYPT_SETUP_TIMEOUT ??=3D "600"
+
+# Seconds the verity device wait must last: with an encrypted rootfs the f=
irst
+# boot encryption (CRYPT_SETUP_TIMEOUT, N, Ns or Nmin) runs before verity.
+def cip_verity_device_timeout(d):
+    import re
+    base =3D 30
+    if not cip_crypt_root_partitions(d):
+        return str(base)
+    value =3D (d.getVar('CRYPT_SETUP_TIMEOUT') or '').strip()
+    m =3D re.fullmatch(r'([0-9]+)(s|min)?', value)
+    if not m:
+        bb.fatal("CRYPT_SETUP_TIMEOUT '%s' must match [0-9]+(s|min)?" % va=
lue)
+    secs =3D int(m.group(1)) * (60 if m.group(2) =3D=3D 'min' else 1)
+    return str(secs + base)
diff --git a/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb
new file mode 100644
index 00000000..4fc629a0
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-crypt_0.1=
.bb
@@ -0,0 +1,82 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw cip-crypt-root
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration and /etc/crypttab for the embedded-cr=
ypt dracut module"
+DEBIAN_DEPENDS =3D "dracut-embedded-crypt"
+
+# CRYPT_PARTITIONS elements are <partition-label|uuid|/path>:<mountpoint>:=
<reencrypt|format|noencrypt|format-if-empty>[:expand]
+CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
+CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
+# CRYPT_SETUP_TIMEOUT default is set in cip-crypt-root.bbclass
+CRYPT_HASH_TYPE ??=3D "sha256"
+CRYPT_KEY_ALGORITHM ??=3D "ecc"
+CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
+CRYPT_BTRFS_SUPPORT ??=3D "0"
+CRYPT_BACKEND ??=3D "systemd"
+CRYPT_ROOT_PARTITIONS ??=3D "${@cip_crypt_root_partitions(d)}"
+INITRAMFS_CRYPT_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+
+OVERRIDES .=3D "${@':expand-on-crypt' if ':expand' in (d.getVar('CRYPT_PAR=
TITIONS') or '') else ''}"
+DEBIAN_DEPENDS:append:expand-on-crypt =3D ", cloud-guest-utils, fdisk"
+
+CIP_CRYPT_UUID_RE =3D "^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$"
+
+# /etc/crypttab is created by cryptsetup's postinst; shipping it as a
+# conffile would trigger a dpkg prompt. postinst installs it instead.
+SRC_URI =3D "file://embedded-crypt.conf.tmpl \
+           file://postinst"
+
+TEMPLATE_FILES =3D "embedded-crypt.conf.tmpl"
+TEMPLATE_VARS +=3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD CRYPT_SE=
TUP_TIMEOUT \
+    CRYPT_HASH_TYPE CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL \
+    CRYPT_BTRFS_SUPPORT CRYPT_BACKEND INITRAMFS_CRYPT_MOUNT_OPTIONS \
+    CRYPT_ROOT_PARTITIONS"
+
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    # one crypttab line per partition that is encrypted
+    : > ${WORKDIR}/crypttab
+    for entry in ${CRYPT_PARTITIONS}; do
+        label=3D$(echo "$entry" | cut -d: -f1)
+        mode=3D$(echo "$entry" | awk -F: '{print $3}')
+        if echo "$label" | grep -Eiq '${CIP_CRYPT_UUID_RE}' && \
+           ! echo "$label" | grep -Eq '${CIP_CRYPT_UUID_RE}'; then
+            bbfatal "embedded-crypt: UUID '$label' in CRYPT_PARTITIONS mus=
t be lower-case"
+        fi
+        if [ "$mode" =3D noencrypt ]; then
+            continue
+        fi
+        case "$label" in
+        /*)
+            device=3D$label
+            name=3D${label##*/}
+            ;;
+        *)
+            if echo "$label" | grep -Eq '${CIP_CRYPT_UUID_RE}'; then
+                device=3D/dev/disk/by-partuuid/$label
+                name=3D$label
+            else
+                device=3D/dev/disk/by-partlabel/$label
+                name=3Dencrypted_$label
+            fi
+            ;;
+        esac
+        echo "$name $device - tpm2-device=3Dauto,tpm2-pcrs=3D7,x-initrd.at=
tach,nofail" \
+            >> ${WORKDIR}/crypttab
+    done
+
+    install -D -m 0644 ${WORKDIR}/embedded-crypt.conf \
+        ${D}/etc/dracut-embedded/embedded-crypt.conf
+    if [ -s ${WORKDIR}/crypttab ]; then
+        install -D -m 0644 ${WORKDIR}/crypttab ${D}/usr/share/dracut-embed=
ded/crypttab
+    fi
+}
diff --git a/recipes-initramfs/dracut-config-cip-crypt/files/embedded-crypt=
.conf.tmpl b/recipes-initramfs/dracut-config-cip-crypt/files/embedded-crypt=
.conf.tmpl
new file mode 100644
index 00000000..4287b2c3
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/files/embedded-crypt.conf.t=
mpl
@@ -0,0 +1,10 @@
+CRYPT_PARTITIONS=3D'${CRYPT_PARTITIONS}'
+CRYPT_CREATE_FILE_SYSTEM_CMD=3D'${CRYPT_CREATE_FILE_SYSTEM_CMD}'
+CRYPT_SETUP_TIMEOUT=3D'${CRYPT_SETUP_TIMEOUT}'
+CRYPT_HASH_TYPE=3D'${CRYPT_HASH_TYPE}'
+CRYPT_KEY_ALGORITHM=3D'${CRYPT_KEY_ALGORITHM}'
+CRYPT_ENCRYPTION_OPTIONAL=3D'${CRYPT_ENCRYPTION_OPTIONAL}'
+CRYPT_BTRFS_SUPPORT=3D'${CRYPT_BTRFS_SUPPORT}'
+CRYPT_BACKEND=3D'${CRYPT_BACKEND}'
+INITRAMFS_CRYPT_MOUNT_OPTIONS=3D'${INITRAMFS_CRYPT_MOUNT_OPTIONS}'
+CRYPT_ROOT_PARTITIONS=3D'${CRYPT_ROOT_PARTITIONS}'
diff --git a/recipes-initramfs/dracut-config-cip-crypt/files/postinst b/rec=
ipes-initramfs/dracut-config-cip-crypt/files/postinst
new file mode 100644
index 00000000..ad2177de
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/files/postinst
@@ -0,0 +1,16 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+# Install the crypttab when the package is installed for the first time, o=
r
+# if /etc/crypttab has no entries yet (cryptsetup ships it with comments o=
nly).
+# Do not overwrite a crypttab that was edited after that on an upgrade.
+if [ "$1" =3D configure ] && [ -f /usr/share/dracut-embedded/crypttab ] &&
+   ! cmp -s /usr/share/dracut-embedded/crypttab /etc/crypttab; then
+    if [ -z "$2" ] || ! grep -qsv '^[[:space:]]*\(#\|$\)' /etc/crypttab; t=
hen
+        install -m 0644 /usr/share/dracut-embedded/crypttab /etc/crypttab
+    fi
+fi
diff --git a/recipes-initramfs/dracut-config-cip-factory-reset/dracut-confi=
g-cip-factory-reset_0.1.bb b/recipes-initramfs/dracut-config-cip-factory-re=
set/dracut-config-cip-factory-reset_0.1.bb
new file mode 100644
index 00000000..65a2c94d
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-factory-reset/dracut-config-cip-f=
actory-reset_0.1.bb
@@ -0,0 +1,36 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-factory-reset dracut=
 module"
+DEBIAN_DEPENDS =3D "dracut-embedded-factory-reset"
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
+SRC_URI =3D "file://embedded-factory-reset.conf.tmpl"
+TEMPLATE_FILES =3D "embedded-factory-reset.conf.tmpl"
+TEMPLATE_VARS +=3D "INITRAMFS_FACTORY_RESET_DEVICES \
+    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE INITRAMFS_FACTORY_RESET_CLEAR=
_TPM \
+    INITRAMFS_FACTORY_RESET_TIMEOUT"
+
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-factory-reset.conf \
+        ${D}/etc/dracut-embedded/embedded-factory-reset.conf
+}
diff --git a/recipes-initramfs/dracut-config-cip-factory-reset/files/embedd=
ed-factory-reset.conf.tmpl b/recipes-initramfs/dracut-config-cip-factory-re=
set/files/embedded-factory-reset.conf.tmpl
new file mode 100644
index 00000000..5a05c4f3
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-factory-reset/files/embedded-fact=
ory-reset.conf.tmpl
@@ -0,0 +1,4 @@
+INITRAMFS_FACTORY_RESET_DEVICES=3D'${INITRAMFS_FACTORY_RESET_DEVICES}'
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE=3D'${INITRAMFS_FACTORY_RESET_LUKS=
_FORMAT_TYPE}'
+INITRAMFS_FACTORY_RESET_CLEAR_TPM=3D'${INITRAMFS_FACTORY_RESET_CLEAR_TPM}'
+INITRAMFS_FACTORY_RESET_TIMEOUT=3D'${INITRAMFS_FACTORY_RESET_TIMEOUT}'
diff --git a/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-=
overlay_0.1.bb b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-=
cip-overlay_0.1.bb
new file mode 100644
index 00000000..f409aa8c
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-overlay=
_0.1.bb
@@ -0,0 +1,40 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-overlay dracut modul=
e"
+DEBIAN_DEPENDS =3D "dracut-embedded-overlay"
+
+INITRAMFS_OVERLAY_PATHS ??=3D "/etc"
+INITRAMFS_OVERLAY_STORAGE_PATH ??=3D "/var/local"
+INITRAMFS_OVERLAY_STORAGE_DEVICE ??=3D "/dev/disk/by-label/var"
+INITRAMFS_OVERLAY_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+# File name in FILESPATH; empty uses the script shipped with the module.
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D ""
+
+DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH =3D "${@ '/usr/share/dracut-embedded/o=
verlay_recovery_action.script' if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRI=
PT') else ''}"
+
+SRC_URI =3D "file://embedded-overlay.conf.tmpl"
+SRC_URI +=3D "${@ 'file://' + d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT'=
) if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT') else ''}"
+TEMPLATE_FILES =3D "embedded-overlay.conf.tmpl"
+TEMPLATE_VARS +=3D "INITRAMFS_OVERLAY_PATHS INITRAMFS_OVERLAY_STORAGE_PATH=
 \
+    INITRAMFS_OVERLAY_STORAGE_DEVICE INITRAMFS_OVERLAY_MOUNT_OPTIONS \
+    DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH"
+
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-overlay.conf \
+        ${D}/etc/dracut-embedded/embedded-overlay.conf
+    if [ -n "${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" ]; then
+        install -D -m 0755 ${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}=
 \
+            ${D}${DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH}
+    fi
+}
diff --git a/recipes-initramfs/dracut-config-cip-overlay/files/embedded-ove=
rlay.conf.tmpl b/recipes-initramfs/dracut-config-cip-overlay/files/embedded=
-overlay.conf.tmpl
new file mode 100644
index 00000000..159c7f2d
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-overlay/files/embedded-overlay.co=
nf.tmpl
@@ -0,0 +1,5 @@
+INITRAMFS_OVERLAY_PATHS=3D'${INITRAMFS_OVERLAY_PATHS}'
+INITRAMFS_OVERLAY_STORAGE_PATH=3D'${INITRAMFS_OVERLAY_STORAGE_PATH}'
+INITRAMFS_OVERLAY_STORAGE_DEVICE=3D'${INITRAMFS_OVERLAY_STORAGE_DEVICE}'
+INITRAMFS_OVERLAY_MOUNT_OPTIONS=3D'${INITRAMFS_OVERLAY_MOUNT_OPTIONS}'
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT=3D'${DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH=
}'
diff --git a/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-v=
erity_0.1.bb b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip=
-verity_0.1.bb
new file mode 100644
index 00000000..af1f1906
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-verity_0=
.1.bb
@@ -0,0 +1,30 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw cip-crypt-root
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-verity dracut module=
"
+DEBIAN_DEPENDS =3D "dracut-embedded-verity"
+
+# With an encrypted rootfs: CRYPT_SETUP_TIMEOUT + 30s, as the first boot
+# encryption runs before verity. Link only on the dm-crypt mapping then.
+DRACUT_VERITY_REQUIRE_CRYPT ?=3D "${@'1' if cip_crypt_root_partitions(d) e=
lse '0'}"
+DRACUT_VERITY_DEVICE_TIMEOUT ?=3D "${@cip_verity_device_timeout(d)}"
+DRACUT_VERITY_DEVICE_LINK ?=3D "dracut-embedded-verity"
+
+# The configuration of the module is the rendered embedded-verity.conf.tmp=
l.
+SRC_URI =3D "file://embedded-verity.conf.tmpl"
+TEMPLATE_FILES =3D "embedded-verity.conf.tmpl"
+TEMPLATE_VARS +=3D "DRACUT_VERITY_DEVICE_TIMEOUT DRACUT_VERITY_DEVICE_LINK=
 DRACUT_VERITY_REQUIRE_CRYPT"
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-verity.conf \
+        ${D}/etc/dracut-embedded/embedded-verity.conf
+}
diff --git a/recipes-initramfs/dracut-config-cip-verity/files/embedded-veri=
ty.conf.tmpl b/recipes-initramfs/dracut-config-cip-verity/files/embedded-ve=
rity.conf.tmpl
new file mode 100644
index 00000000..a30cfda3
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-verity/files/embedded-verity.conf=
.tmpl
@@ -0,0 +1,3 @@
+DRACUT_VERITY_DEVICE_TIMEOUT=3D'${DRACUT_VERITY_DEVICE_TIMEOUT}'
+DRACUT_VERITY_DEVICE_LINK=3D'${DRACUT_VERITY_DEVICE_LINK}'
+DRACUT_VERITY_REQUIRE_CRYPT=3D'${DRACUT_VERITY_REQUIRE_CRYPT}'
diff --git a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip=
-watchdog_0.1.bb b/recipes-initramfs/dracut-config-cip-watchdog/dracut-conf=
ig-cip-watchdog_0.1.bb
new file mode 100644
index 00000000..22b8d5e1
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchd=
og_0.1.bb
@@ -0,0 +1,29 @@
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
+inherit dpkg-raw
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-watchdog dracut modu=
le"
+DEBIAN_DEPENDS =3D "dracut-embedded-watchdog"
+
+INITRAMFS_WATCHDOG_DEVICE ??=3D ""
+INITRAMFS_WATCHDOG_SEC ??=3D "${WDOG_TIMEOUT}"
+
+SRC_URI =3D "file://embedded-watchdog.conf.tmpl"
+TEMPLATE_FILES =3D "embedded-watchdog.conf.tmpl"
+TEMPLATE_VARS +=3D "INITRAMFS_WATCHDOG_DEVICE INITRAMFS_WATCHDOG_SEC"
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-watchdog.conf \
+        ${D}/etc/dracut-embedded/embedded-watchdog.conf
+}
diff --git a/recipes-initramfs/dracut-config-cip-watchdog/files/embedded-wa=
tchdog.conf.tmpl b/recipes-initramfs/dracut-config-cip-watchdog/files/embed=
ded-watchdog.conf.tmpl
new file mode 100644
index 00000000..989a78d2
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-watchdog/files/embedded-watchdog.=
conf.tmpl
@@ -0,0 +1,2 @@
+INITRAMFS_WATCHDOG_DEVICE=3D'${INITRAMFS_WATCHDOG_DEVICE}'
+INITRAMFS_WATCHDOG_SEC=3D'${INITRAMFS_WATCHDOG_SEC}'
--=20
2.47.3

