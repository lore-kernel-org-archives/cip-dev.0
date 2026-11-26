Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11271.1795689023333075748
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=z6YIMFHC;
 spf=pass (domain: siemens.com, ip: 40.107.130.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqH/750QNomKegOWymqrAr7zCkZJ/577Mb4ZW/F2ZbjfjNlZhlYf3JH/nIL+tlqSA18vl8EEDk8UgDMMog+U6e80qKcg9iKQGhMncLj7mGY+v3yIYjIRtocnr0y1VB9LIlGd+VdM/ZpKBnPOiL29YgNxbBZaBwyMECvUKcemrOI0DC46jpK8nItJohO0SeuAw1bhSdQubOf0J933rSaBqVd3oEUBNEPzDpEjLI/5XMBXCHjzSYC6R3b+YfoGMkau4jYg4hhUUZBilg6zBYdHbC6Mdp3RquHCAU5k1V7n3YgPqKvMU9aRnt8HLwgD9EuCReA7nR4PX//YgmmZZaKlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2pTwAsZXHpXDpwpgBlxnvYZsWOnQdrfC83YzJ68MD4=;
 b=ebBh5juyKCeaPn9RN+UWLSs3YHPq8j/7g7XeZrFqAniNvnRRC3HcGwyoTHgIDJCi5w9VUbIYAqLsl9r/wk+4rlNjbmPMi5x4YMPPlaPJgJArtjXMe/FcsfFk8FdrfhRxdaGRgMWzGCbfP8AX0yra+8/WrrfHq0fsZR6+vhI50/EE4aiTsXfki719mf0cBpjCp+lSH9mz1TpW1P9nPyWFrt2rcg8czfxoLH2s+/ILWhFqKNDoYifmufthuXQz394Osqt64gdMOJZ28YiGDNShnV0RT4ninF6+TbEliaF6Or/wCpjvajGX2DybQTe4yIXBcP1n1d2VcWaerOCo0QD61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2pTwAsZXHpXDpwpgBlxnvYZsWOnQdrfC83YzJ68MD4=;
 b=z6YIMFHCQxXOfm1EKTBcRSC34943Vc25/yD960nvKsXAbeO3MO1kP97E0QyGiwSx1mavMUQ9OQ8O6Tn/61NllkLJJn1EbZrSOqLdhcQmLPuhEQVzzs9KPXD8QBocXrcuYeZMloGPxf2uGrFas0s1G/DuEbQhHSoIxz1BP80dk6H7NIMMpNkDyh3iGkXrOQEImesmejmt1Kl2Ifu6m1tjn3CsAeA7xQ1AnkxE0zlaGr4r7giFQ8b5CM78SINyaw4UPLKZDVXoeiXAEKMhXBeP5gMjCLTU1wS4AlhjYeqNdeBFGSHZRDRY/4erHCvHjHiit9DwZkw1iOsY+0W7BnTtDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by MI7PR10MB209735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:30:19 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:19 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 11/21] factory-reset-helper-efi: use systemd FactoryReset variable with dracut
Date: Thu, 26 Nov 2026 11:29:57 +0100
Message-ID: <20261126103007.2922985-12-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|MI7PR10MB209735:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b144d7f-0037-4339-7cd8-08df4ba8451b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|261022075727099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: lTKUWguJPm8Fd2MsKcUCUw1d04FfwO/h2X282TJdUF3WK2ugraHFMY6Lnwm5MqbBbrMMMoBTwmyvzHprfBMGtUju1nGZYQ2iXcfbcURAQ41Bou/zTesl+jZJvm45LJHiq8a4HgVgOOtUFaEEHZ0m1djxalLfbm7dh5uwcy+7Ptd4eTUxf5uy7Kpw+gKQayJYX9g7oDnIt8HcQ7H3qMl4UKJrHlQC0dLoqfaRsqMfeLuwgZQELz5MV36efod4pDCDwJElf5BsflWJ5c9vCEOSA/l7m/BCiwViKQziGKiDBpCQQUuDK8nPYEsgOOQdA2+OnJteOTI762ebKJdKlywhM1UcG/rEXzU/4e2lWjjH9nXAXilYfWItfuyHo5/GTFzcEIdsK4gtRVCiIm2fxvNw3yWyIxfeGt91W1YlsSPwbrjml+cB7PGifc27TA4NxXM7KnRMUNbXtK/GLHf3As9Opz8hbavaeOmfl/69HOkdjW36ReyMwSURjc1I0Fyy4CRA2dQ/t/9Aj+QdjYmDaz8SErbX92dlxmW86fG6k0VnA7dA0C2lM2R+gHnZ4ON8UNcfuZdByPtcIkFSEaxNdky1/TRJRo28JLsegNY4zxe7Pg2Da1UKdkPxNv9RZa00xykHHrWAT3hL2alAPVq7WyFdsdcQ5IPgTQa0dQxRU9MXbRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIB0J+wtaO+G7wTzoiY7zMANxeFNJF8MPS3RG7GR5DDTmMU+kfkueBhUCY+R?=
 =?us-ascii?Q?eEXoTIeNDgWsyLoYrK4mHlmyZO6TZ+zVjoQ2ZGFVrrCki2cntPJLdFctbncL?=
 =?us-ascii?Q?an23iD+WnMjQWky7DzSooZYBhh4p9Cj9b0hjMeq17hjLWVzhNuTeOA9HPMNh?=
 =?us-ascii?Q?WM1tskEieyF9teHzCZCbnSlav997EFXgDs+gYn0SiAGmcHTWmQp5I7PnDh4E?=
 =?us-ascii?Q?fowYTOUJXG4gdHtg92CHJTSuxh0zspmSE0Nrrtpu0PZN7HIKYt6Pc8w/SCm7?=
 =?us-ascii?Q?o8yTQyiFwDvcRFPf56OW73r0SpWUgO/PEERp7GfJGTpAwsxKmyrtTmo40OPq?=
 =?us-ascii?Q?kBh/yKv1TTxvP5GPiQYDfJNUzs+D7kf03VePkZ1q5O4kmEP8vktU6QBmKadd?=
 =?us-ascii?Q?ZcNG0K7+IcwedbzMaAPjeyoAnryiUDgitS0ZOg2aIpBSIKt3qWLTQ6aimnUZ?=
 =?us-ascii?Q?6yR9X24ZUMCK3P7b2QIdzERBs4uRneYJxGbtyHL18QJyG+pIVpyzNhpQ65k0?=
 =?us-ascii?Q?pHjn8enbYAfG3GJmDZCfPwWb/6DZg27ERabhax1Bw14sf/4QjNNXAz+9ay9i?=
 =?us-ascii?Q?8rtn0MM2snI+cGYsmp1BYsaJJMgc1zMO5x56Mm48lKTSoFX3TH2KmccPA2NK?=
 =?us-ascii?Q?Ig8pb6PpzoSJdXyoQYoPqmTHVF1t2xYpC68l3wk0yiPVCpcMipKa0SMY+v67?=
 =?us-ascii?Q?B8WrbC9jX+p27we+SrBxRhr/M2QjhOc/L7MsIwRlz1mV8Pkdb1DbUVEdkHaL?=
 =?us-ascii?Q?vURedQEppVW1N74AjNbdL/OGDmaUdZVewYQhe5B/D1mlpRIvFhs5EQ/jZ5Sy?=
 =?us-ascii?Q?Cj0Li4hlpq5Nv8Mht4Ahy6cfkPRMod+ilRaOkVcUg8jNOuML3CYe6pQCvTDg?=
 =?us-ascii?Q?FkN6qjIAJcs8Fx9qDyTJ9Ult2GQnGksmUTR0oawdCxPTV3A10pNqHmsHLHaq?=
 =?us-ascii?Q?Wq2OsapUwecam0vwOSvK616FmKBthqHVeQ1lCf4DClSE0uAnd4G0gokBb4XH?=
 =?us-ascii?Q?ZeQ84D4jdQYTXtgrLgwbPJr2MRNnuJYoQN3+QWBLxYzzVHY+RSjfy8Acbu/X?=
 =?us-ascii?Q?LZszwkUxsREKTNsRVfrPNahoHo8fVDH1AqQpikf6XE9xhATaFXr9kVmolmuv?=
 =?us-ascii?Q?cvJduM4OiwMB27lsfAJtwReL2ipcCX2oo8EcGxuwhGRk9C2zGCPcPSQ93S4r?=
 =?us-ascii?Q?u6PTkq1XpycOBBzD7QZ8PkCoa/LPgDNnLAmh3P3y8JTIliAY57ahKZccyokC?=
 =?us-ascii?Q?FoboPROiJE9ioV+8kLNnJV2JYSDUQySxRuO0yZRFiHuJkSD6s594OZxluxuI?=
 =?us-ascii?Q?pAyeLJBNyTFpm5rTnszNTjswSGznIEuXalFRs9VbIzDyNzKWhyzHP5IdMJKn?=
 =?us-ascii?Q?5IdQHcWtvNbVTqZ5+d0u6IpRaRL4t1gOL7x2uHsfOmCsKJ1KvorEfYdc66Xu?=
 =?us-ascii?Q?nv/W3hBPgPRmR0LD/cIrB7RUyHFKfTLiHXXroj+7apMxtaOvyM14H+kdnA/j?=
 =?us-ascii?Q?xR/0px+oCK8RSoTPa5ZxMPYTPaCBzrR32XhEiJa5vEUU5y7pH+vTWHfZZqTN?=
 =?us-ascii?Q?d236aNj44o/rjHk2Sswd6PzEaTp9bZs9UkwhZ1WouZ0sJl3RkJAtAevnTJ6P?=
 =?us-ascii?Q?Y8b8+AbhqiBhjlKOF7vjIRstw6css2akHjaZpIEzHnDzyU7dCqHAtgEhhVuA?=
 =?us-ascii?Q?TcAZPSnyhss7bCF6n+qq9Yyv26hCq9EFoeZd3XlZ8igxImZ+NjQ5H3Uv3rpt?=
 =?us-ascii?Q?0OFe8kOnxCLbnLk6Y7XR0KbCGs2t98c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b144d7f-0037-4339-7cd8-08df4ba8451b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:19.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPUWvU2wfEZkYAB0M7YluWsRZPGcqG0VBowSPDYP+wNDzSgByv/hIMJ22hHEKv+JGkDOQ8caWCcw4YjpKg55bHnbTZnMiogu6CPVg5FZZzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR10MB209735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25094
Content-Type: text/plain; charset="utf-8"

The embedded-factory-reset dracut module reacts to systemd's
FactoryReset EFI variable. Keep the CIP vendor variable for
initramfs-tools.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-common.inc                                | 2 ++
 .../factory-reset-helper/factory-reset-helper-efi_0.1.bb       | 3 +++
 .../factory-reset-helper/factory-reset-helper-file_0.1.bb      | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index d2fcb7da..9f407a80 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -31,6 +31,8 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
=20
 PREFERRED_PROVIDER_factory-reset-helper ?=3D "factory-reset-helper-file"
 PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "factory-reset-helpe=
r-efi"
+# The dracut factory reset module is only triggered by an EFI variable.
+PREFERRED_PROVIDER_factory-reset-helper:dracut =3D "factory-reset-helper-e=
fi"
=20
 # The read-only rootfs is described by two stacked settings:
 # - RO_ROOTFS_TYPE: filesystem of the rootfs (squashfs, erofs)
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-efi_=
0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.=
bb
index 071b1ddb..76bed253 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
@@ -18,6 +18,9 @@ DEBIAN_CONFLICTS =3D "factory-reset-helper-file"
 FACTORY_RESET_MARKER ?=3D "FactoryResetRequest"
 # Use a new vendor id instead of the one from systemd
 FACTORY_RESET_EFIVARS_GUID ?=3D "abc688c9-fee3-41f7-87d3-1076e4a29e8f"
+# the embedded-factory-reset dracut module uses systemd's variable
+FACTORY_RESET_MARKER:dracut ?=3D "FactoryReset"
+FACTORY_RESET_EFIVARS_GUID:dracut ?=3D "8cf2644b-4b0b-428f-9387-6d876050dc=
67"
 FACTORY_RESET_TYPE =3D "efivar"
=20
 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, bsdextrautils, ef=
ivar"
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file=
_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.=
1.bb
index ec292621..08aa96cf 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
@@ -21,5 +21,8 @@ DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, =
bsdextrautils"
 python do_check_compatibility() {
     if "encrypt-partitions" in d.getVar('OVERRIDES'):
         bb.error("This recipe is incompatible with encrypt-partitions")
+    if "dracut" in d.getVar('OVERRIDES').split(':'):
+        bb.error("This recipe is incompatible with the dracut initramfs, "
+                 "use factory-reset-helper-efi")
 }
 addtask check_compatibility after do_fetch before do_install
--=20
2.47.3

