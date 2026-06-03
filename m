Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DDDCD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 14:52:10 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21999.1780498321861553062
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2026 07:52:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FIPyJybR;
 spf=pass (domain: siemens.com, ip: 52.101.70.4, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVO2KSCUmjykkgoMawWRiyDU1jUst1YcjX8eSTMYKVn9j+TxINnNvHA01XNhlTNmGicMPZ1vNSr0hzFQv1XNFzVoIUvKlm0l/EN7QHHcMNN1NTwMMQfpTnkPQ23evtlRYaujLQVWCoOjR2inCQXWbX0gLhHDegW6LZ4TtIwQH5rloproNeYQSuPElJkSL3TFDHY+rQzVkNQBzKFR7UUSZIT7+I9UTwRh2KpOzMaDd8o1CyqpG0fWaz0hVumWfJmWHKB4lD11DDDCqdlYseHkw+TEkwNGJuVoclxGhNdJHDtazJdDRIzVdn4K+DSy7uuCmRZ8T1VGdvXTAkxeG5TqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UIYxOdaTamr1NFNnEz660Nciu6D4yTzBtDQr4q/+qQ=;
 b=Mz6SPgo+bXjopPSkzDpua0WS826wuM3FAiWB+000vd+o4CxtvuE7DCroWjR6Q5jbvxVC9PAvLbOfW8Fej7rhHcPCrBJ3HFkPDhJZyK0qAqSgk+zH/3eEFlqRUracweDxSwtP0ikaZY5l7MuTYbRsQtKQxM3kYTazhE6KIQ77geRBpEWGXmyIYJew5Uj5xVxti6vRQGZNJ/KpvUlHYCGb0f0BmHZdwy7XcHLBpZdXKkkS3CWwsmW9gpTAAgqSjZk+/C+6tJgRqGt4VMUOrV2BpOx0jJmDXTo6amNIJ1cEdz0ThFaS0DFMI6dFL6Kr03Fbv65nZyjpsG/9Ik7mawi3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UIYxOdaTamr1NFNnEz660Nciu6D4yTzBtDQr4q/+qQ=;
 b=FIPyJybRGDB9G0fg/FYCri2eIksqFAAUYZb8wHMujKTbg4bCukkf0htaZ6ga/fe0s5S73IarYuAVOEoFA36T2eGLjvDYmv5Gx0DjNRPB6G8cuKRe0MnQEmGykgGFFj78X6F/3FWSwnqw6cX+KZ/sSxD3pzeEcXQ8DTXgKqH5cctA4hx9chp6Ed+vIvjOncuwWwC5AEi6j3B5mNiJSoBTgfnUAtMexFmx1d5mW77XCNXnxm1njGDAF0gYGhhn77xpPXv0vU7F9kTOF/bKxlRQ++fWoC+Dnsq+gH2QiWFTsA0xf4DdZNcWRKQzEj+3CPYgafP49JiiZ5zBXchmz/3e2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:619::6)
 by AS2PR10MB6925.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:51:57 +0000
Received: from AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c0c1:ae4a:a803:8b8a]) by AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c0c1:ae4a:a803:8b8a%7]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:51:57 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH] add descriptions for dpkg-raw and initramfs-hook recipes
Date: Wed,  3 Jun 2026 16:51:43 +0200
Message-ID: <20260603145143.75868-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::11) To AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:619::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7254:EE_|AS2PR10MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: a162a5f2-fb56-47a1-3fc0-08dec17fa8cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|55112099003|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	NNHxKOAI7GJt9+6/HIC8Oei5OdUE2wJ44V89FC1+SOB/X/kTQYRMZQvAFeKqW6FC849iG2SM2v8D47BogQf1UsfIIPnQCL8U3V+RrH8k3mQ/ENrH+yXWIvU+bAIrqLkpko31LwwT3xuJ931Pb4S9/wqSvXHwGWN1+8t0ozWDKfKr+M0prPiHqr8nokv3MhHssCYHgkUoQWAQkAOKMM00kCvAwAsr6howwulPZZNf4jHGnyr4PrqKl6CFCvOjTXDJSbStSpQphkZO+ajS8NddF5Ds4XF3a3X4QwGX9G4kUBt4cXPSdZmZCedQhBvMMCOlyzWHR3IzJfzSuvZooaO8w/p07F94vLI0DjN243390zljLhZjim1IWxArItKDuRreRSEZucIeNFde/PzR/yiZCNg2oH6kB0drOCxfnCS3LjJ40naqoyLEwSlKFPLbgmKIuBNg5QOfHgvpQv7jSvYWDbI5ZPmUGxlaICtmwXKD3yQKJArVz3MY3261MFfVSd7TatyzTaPgfXIonF3gnM835Y1tw3KR2IEwhscXWwS7dRMf9Uwe088O6AGrFsIA5FFJN73dmAmJlGAgEPB+KdE+sBfKi3eZbjp1JCgeZeWUC76S3R1qz5ZUcsl7sN7Y1ZEQ5oyum4Wf0czOdwijII9YYxT7JXrHv7tSyF4L9P11KOCpZbnsgUYt26NMZKQgFDyH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(55112099003)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ualDjkrPWeBhwJoRV1A9Xs1RG31VX0csMpGxocQ1YkV82y5deXKGq1gn0VWb?=
 =?us-ascii?Q?kDVq7JWE+M2qWlCp8pWzbDEf6AWi7tZ/6rtxL13UQwrP8sh7m0DBDyfc5Cw7?=
 =?us-ascii?Q?7eIseA4x51qWWTLP0Ud0qnKqcUAlohz+MRlj3OTMYXhAM2ffJW3x1bQi4JS2?=
 =?us-ascii?Q?t74NVicZcCJm2XJF7tRPZl2SpjB4xSX2g260uMkoOghfAZel/BoOplGuFo7d?=
 =?us-ascii?Q?psOjRStdlJ8jyZEgyLtsxrPwsjRDXu9UhSdsEBHyRX6TrfjPfBMaNpPEck/s?=
 =?us-ascii?Q?gHnYfLVH5svvMKu5F6Rge/iRSvQIwaIuZ9sePcy93Otb4Ly2Hf1lJsrHLSBU?=
 =?us-ascii?Q?jWyNgzFyQ+SxFlKqRs1ayZe/GH+d231OH3WNIZXN2X/wwttBnRA5MXpozplN?=
 =?us-ascii?Q?r98IJRMpYn1ufE8wB5OOiQhYU/51NjL0P8VjNYztQfn1MvMVLzjNTlXXLjqa?=
 =?us-ascii?Q?9jBH38tyFVb3r50q1LDnycRJjHJVL9kHPIO/I+4uzkQXubZ2jyCLKc2PFH6J?=
 =?us-ascii?Q?1FPQ2tucFVWHQ7QSEn4FVnlK+IwLXugcfaMBRywWFMRXJH7o78pC+P9RleuE?=
 =?us-ascii?Q?DO75Vi04bMA/XBUIrFwFHHRTkjBsk+Zp7dRCnT1lv6bQI+JNSMzZHuYJBNea?=
 =?us-ascii?Q?nU0eAUFkRNjoldy52BVjUGK3Q7oiAsXqhdJE+YGLCrOkum5tNLfywOaHEbCQ?=
 =?us-ascii?Q?aNYBPG7uWEiX0RLbS/reteD6ySYCb/0HPXypIrChxCOsMBryHOCdxpdkIdvt?=
 =?us-ascii?Q?txkggFqcjEEz+qaOUuQhcWV/I0smBmck6dkLT29ui1XcAuLYG5voLMHBvl62?=
 =?us-ascii?Q?3sUyH+w74HEXfqz5VVwnyKopyG33yFeZtBvAW8y9paTMcR4zdCIArxFh3r/f?=
 =?us-ascii?Q?gKJbYhJGRIDoYCBD6CepR5+sjhjEL7PsAN969k47cDbT1JpWajpeYpz6iplm?=
 =?us-ascii?Q?Jb8Q9pRIFIWDTynVXkgPwXPJVYX20i8UjzIw1ysoGwTzwFw4AnplTh2mN/iu?=
 =?us-ascii?Q?k9SwE79JFsR3/D9T5lQcU0R7ZCNDU1P/EfTXUMlKSyRJjPgSDPsljsDu7LOL?=
 =?us-ascii?Q?Rtxy6U5Nlzd0Hb9Jv5QOtNYFSXaoMCK2LOnrpkxh4Z3qAKTc2Q76xRARH31C?=
 =?us-ascii?Q?KF6chMjXfikPMzP69Iu+yTdxWEhpXR3MS7ZOBQGn/vYbiN1CbHUPcXEGsgjU?=
 =?us-ascii?Q?Xxq0/IsbC7DwKDy4bg53aHrY7pt6Xkv9vxk8vAms5+FWbaHaujnRe/EpRgnZ?=
 =?us-ascii?Q?J6SiflOW8SxMCLVtU2mb35kk3SSnvbrF3L/Jn7NlzFzTfwEWVfUS+PyStNto?=
 =?us-ascii?Q?AnnMCx65pCzanxJnBuxEgTiR4HrvLUcV5xUg6XnRD0eXFEa7/iAIxyOaU9ES?=
 =?us-ascii?Q?cUMaBENqGlgvKgDcm0ZmFTdmYh9SUpxaoKqdjCHfUuayN+JPhmweGbJ9u3R0?=
 =?us-ascii?Q?SpRYmw6NvS/WCS/mTt5ysoZmnnpWwKcf3JMyyP6ytFUN5ULWtaFU3368iSiN?=
 =?us-ascii?Q?zdKhRUGJNQt9HSLFoH82Ny4G3ZM9ANNwq+SDjFxCOkjQnZiSKZEyhbsuOueV?=
 =?us-ascii?Q?mDCIFd93ZWMtJzyx3NpP0RjQCivXEpJQTEsM7mCVKr5I3mGjsajSl0hkuqgk?=
 =?us-ascii?Q?bildtfw3g5qBdOo2DbjXDUi0V8gy2g04v5pdJtcD14rX8LUOXgfiFMFaEWDv?=
 =?us-ascii?Q?LNwqWuztYG8CVKziW9ERMBqvFZAb/38mmwZpLsnhgyYpY3pYqRiNEbNgD8pC?=
 =?us-ascii?Q?2Qf9KWQSjYfmVCkARUHPscxYT48k1WdRA6x/YNhBmte/ZFKRFgZ6y8T4H5i6?=
X-MS-Exchange-AntiSpam-MessageData-1: dvdUuGFzu/Xt23/tjNCLV4Y1zF71qTgZ7LM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a162a5f2-fb56-47a1-3fc0-08dec17fa8cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:51:57.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ca+xpmLONyAbTvY3Jcuhm2lXQa1yCRjctaA/JfKBAkndQd8UV7jJZZb4vnakElkc0awITMm7ZbfwFD2BqbiQEQHL/tUpBJpjgxl+zojQlH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6925
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2026 14:52:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23039

The description must not be empty (isar requirement), and it ends
up in the SBOM. For that, we add meaningfull descriptions to the
packages we generate.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Note, that the missing descriptions where discovered on an MTDA image build=
.

 recipes-core/home-fs/home-fs_0.1.bb                              | 1 +
 recipes-core/journald-config/journald-config_0.1.bb              | 1 +
 recipes-core/move-homedir-var/move-homedir-var_0.1.bb            | 1 +
 recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb      | 1 +
 recipes-core/swupdate-config/swupdate-config_0.2.bb              | 1 +
 .../swupdate-handler-roundrobin_0.1.bb                           | 1 +
 recipes-core/tmp-fs/tmp-fs_0.2.bb                                | 1 +
 recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb      | 1 +
 recipes-devtools/swupdate-signer/swupdate-signer-empty.bb        | 1 +
 .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb       | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb            | 1 +
 .../initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb             | 1 +
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb         | 1 +
 .../initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb       | 1 +
 .../initramfs-verity-hook/initramfs-verity-hook_0.3.bb           | 1 +
 15 files changed, 15 insertions(+)

diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/hom=
e-fs_0.1.bb
index fd88f21..c99c32a 100644
--- a/recipes-core/home-fs/home-fs_0.1.bb
+++ b/recipes-core/home-fs/home-fs_0.1.bb
@@ -11,6 +11,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Systemd unit to mount a dedicated /home filesystem"
=20
 SRC_URI =3D "file://postinst \
            file://home.mount"
diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-=
core/journald-config/journald-config_0.1.bb
index 62fc0c7..62b569c 100644
--- a/recipes-core/journald-config/journald-config_0.1.bb
+++ b/recipes-core/journald-config/journald-config_0.1.bb
@@ -11,6 +11,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Systemd journald drop-in configuration for persistent jou=
rnal storage"
=20
 SRC_URI =3D "file://persistent-journal.conf"
=20
diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipe=
s-core/move-homedir-var/move-homedir-var_0.1.bb
index 54e807a..a8d1318 100644
--- a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
+++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
@@ -11,6 +11,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Relocate home directory data to /var"
=20
 DEBIAN_CONFLICTS =3D "home-fs"
 SRC_URI =3D "file://${BPN}.tmpfiles.tmpl"
diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb b/=
recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
index 70a2eb6..16abd5d 100644
--- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
+++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
@@ -12,6 +12,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "SWUpdate Suricatta WFX client configuration"
=20
 PROVIDES :=3D "${PN}"
 DEBIAN_PROVIDES :=3D "${PN}"
diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-=
core/swupdate-config/swupdate-config_0.2.bb
index cdfd8b9..b48e3d1 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -12,6 +12,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "SWUpdate base configuration"
=20
 PROVIDES :=3D "${PN}"
 DEBIAN_PROVIDES :=3D "${PN}"
diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roun=
drobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-r=
oundrobin_0.1.bb
index 2ba192c..d4d0f8d 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_=
0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_=
0.1.bb
@@ -11,6 +11,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Lua round-robin SWUpdate handler"
=20
 PROVIDES =3D "swupdate-handlers"
=20
diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs=
_0.2.bb
index f2b7976..a361005 100644
--- a/recipes-core/tmp-fs/tmp-fs_0.2.bb
+++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
@@ -11,6 +11,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "systemd unit to mount /tmp as tmpfs"
=20
 SRC_URI =3D "file://postinst"
=20
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/=
recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
index ee8d172..845bb9a 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
@@ -11,6 +11,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "SWUpdate signer script to sign with deployed signing cert=
ificates"
=20
 PROVIDES =3D "swupdate-signer"
 DEBIAN_PROVIDES =3D "swupdate-signer"
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/re=
cipes-devtools/swupdate-signer/swupdate-signer-empty.bb
index af9de76..c6f624e 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
@@ -11,6 +11,7 @@
 inherit dpkg-raw
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Placeholder SWUpdate signer that creates a dummy signatur=
e"
=20
 PROVIDES =3D "swupdate-signer"
 DEBIAN_PROVIDES =3D "swupdate-signer"
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-h=
ook_0.3.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-h=
ook_0.3.bb
index 48f6458..95331ba 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3=
.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3=
.bb
@@ -12,6 +12,7 @@
 inherit initramfs-hook
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Initramfs hook for selecting and mounting the active A/B =
root filesystem"
=20
 RDEPENDS +=3D "initramfs-cip-functions"
 DEBIAN_DEPENDS .=3D ", util-linux, initramfs-cip-functions"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 3cb0520..87d455d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -12,6 +12,7 @@
 inherit initramfs-hook
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Initramfs hook for TPM-backed encrypted partition setup a=
nd unlock"
=20
 RDEPENDS +=3D "initramfs-cip-functions"
=20
diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.=
2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
index 2015503..6a3af29 100644
--- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
@@ -12,5 +12,6 @@
 inherit initramfs-hook
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Initramfs hook that adds EROFS filesystem support during =
early boot"
=20
 HOOK_ADD_MODULES =3D "erofs"
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hoo=
k_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_=
0.4.bb
index 57b26ec..e201277 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.b=
b
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.b=
b
@@ -13,6 +13,7 @@
 inherit initramfs-hook
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Initramfs hook for mounting writable overlays on top of i=
mmutable paths"
=20
 INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D "overlay_recovery_action.script"
=20
diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-h=
ook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-h=
ook_0.2.bb
index 9ff4cbf..fccba26 100644
--- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2=
.bb
+++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2=
.bb
@@ -12,5 +12,6 @@
 inherit initramfs-hook
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Initramfs hook that adds SquashFS filesystem support duri=
ng early boot"
=20
 HOOK_ADD_MODULES =3D "squashfs"
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_=
0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.=
bb
index b2fb704..e67ae7c 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
@@ -12,6 +12,7 @@
 inherit initramfs-hook
=20
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION =3D "Initramfs hook for mounting dm-verity protected root file=
systems"
=20
 SRC_URI +=3D " \
     file://hook \
--=20
2.53.0


