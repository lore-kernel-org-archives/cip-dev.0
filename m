Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37052C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 10:32:30 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.44])
 by mx.groups.io with SMTP id smtpd.web10.12257.1721298740012609024
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 03:32:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gQI/3Unu;
 spf=pass (domain: siemens.com, ip: 40.107.249.44, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPTgl1HXjNieAFYC/6d5TUojMuL9pVNXYN0qh8v7LWssWiYtQvcNjWK5YHK73v+9d57wGT0jKHlspI9Nj7oCyNMEgPFrUBHLeqLfumS3e1XO2faEO+kSreWIrG+RqyPWcLs0BKr0eWN3TIfhWeFZPCfMGdomat44LtrWUrc0zaCIf0e9BuEc4wg42sk7hpI9FHLGrUcSvptnloS4LMlXLXlsSigWU1Ds/hUUg7U69R6GohSI7TBxN2NhQPIPdxBD0CtNr1dEgnJxQWkFlggVVWADA66/BD8cAKAXyf9HCG5I+PlzYOwdCl30C9jGMXbfzvBNZnrmsxmwzNDpxe5LMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjivbEIPHjFk3iSGC1mE2FctmjjY1UM9Hiquzd29eYY=;
 b=bk4TkyFToUmCbM0dgKN+xgiWZvIbu3mryxMW9xGhalf3fbU/LdS/21QOGvoP8vs7BqTPMTIo8ySrI6Mrrq+7IZy99ZtwpPCQk1eH5cCK9joVJ2pXdRQc/tOjE1ilPn/iweKReSR19Fpk0BGtH4iDn60w1r1D4CkEK60KImxdFzEgEGEQo5HTtBq3sykiiP39H06/TxlWA/11SlL1qfqQxUm9UJxxtYQPDu/rBsmmxzzj2qdUg0IAcrKVECT75KoWezD6BYy/53cJ9/PWKXF+auFRApatF7hpNJR/aRu3k5V0RS2von/u+C6tU66QcoLa+6Urj7XyxU02iz2SNdv5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjivbEIPHjFk3iSGC1mE2FctmjjY1UM9Hiquzd29eYY=;
 b=gQI/3UnuZYnDkLYZp5cCIxX6I7f0uGjx6wZ32TBsqiUl3RQMV0PgshGZFEfb7SAkm5sSdWTgf7YToHJsuBCpfJYyUbzFv4io17MFc1N0Jo6F6u7jYEpYVWHYn1+P4BPQZheE4jwM4DTuhI2Nx+oCvwy8PZhodT7BYOI7TF5jIm5OkpIZAhk+k6wINDMfXyGHcwwe6Y3tSBNzRTHY8bX9rfEcpnydge2y13LPuBtr3+fLn5N579nxmsLjY4H+xefXa6jgD56IBHdKVYWhS2l7uULQnn2hTJXhPbyrTFkXcDT2x09sTjHS/ELNKmr7p0a9Q6eLzoNENcCh8OHoC7WynA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by PA1PR10MB8389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Thu, 18 Jul
 2024 10:32:19 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 10:32:19 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 2/4] initramfs-crypt-hook: Provide full losetup executable
Date: Thu, 18 Jul 2024 12:32:12 +0200
Message-ID: <20240718103214.1583403-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718103214.1583403-1-stefan-koch@siemens.com>
References: <20240718103214.1583403-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|PA1PR10MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b05091-2294-40bc-37e2-08dca714e6e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5xGjgI6J1K20+psYd0/xBIKsLD7O690ljp3FizggzXcx1qNClVZrgsvqmHj+?=
 =?us-ascii?Q?vVuplOmpGioCq3SOljA5H7zZ2+KGYzsMxluMFkZNFi3l5TM+zIQ82IVAzMAA?=
 =?us-ascii?Q?QMtmd+Yf/GntGgyjujubfDGqVtWIQuLT56jMBcmH5JeqqICjrb1qbuqqlZ86?=
 =?us-ascii?Q?4qkuKSVDjWceBzYT8CeQ4IFknb190NSpdIOdbzlDVnWZtI6qeCj6+ENzEHDd?=
 =?us-ascii?Q?XGB4Wf9H3a5+/LD8J+/7eMDrBXA5u4wHCD90V8ItXqQ0MT0eBAmQYYv5aoJi?=
 =?us-ascii?Q?pCtJkc3HhpyHryJ5N27Py+w53aU0tR769hThxmDxlZAnEhiOZyYXv6XmQ/9x?=
 =?us-ascii?Q?+3yk0DfWmEaoBOrR+54pbkf7wJA/zx0HDA4xrNqDfeKIsx1KJp+EZ20m3XM8?=
 =?us-ascii?Q?8TASemlz7hgpH60lU93ybtJXn4BovoCmgL0KZ0nBnEpgarELAHjDBoYawVGc?=
 =?us-ascii?Q?ojvQCC+pb1G0TuYelO9R3V5BsAQnbHwXjOUYgWsc0Og4WlpfXVEkCLJ/b8/n?=
 =?us-ascii?Q?t6IBN52axLeLuxcdsILtqlQJMEOP80Jn6AV++r8uTEdzxlyayP9iw+r/Z+7e?=
 =?us-ascii?Q?edNJNipdRZWCD4l4FwlwfqGwq1TcOAvuk3BVHrjGRz5n3pQ7xteSb3RebbIN?=
 =?us-ascii?Q?rL1X+qEALHSzreqIXGTlCdgzKa5QnAJcNtKU6Drxr/PCmRtCJXxy/lCLD4yq?=
 =?us-ascii?Q?zTYmFq6QTb6pvUt+gHlDpG+yZLuXHgJ+coGWR22ubxrbuSGNZcAEB/lTDLNL?=
 =?us-ascii?Q?8rVuUclJsZJYTvEiLc8zVViEDZLuiG7tzRjY25Rebq4SgdzkHBG77jRYVVG3?=
 =?us-ascii?Q?5BaPZ6bSIKjKYFpusuYb5LS6kz0QyA6lZY9C2SAfda+pdAkVrJ1PQ0/oSFfb?=
 =?us-ascii?Q?bS7SkM1m3Tyw7p3++lYYbIAXwjYkpzQReUIZ7YlaBgEsFLr4ecbw7r+NIDnf?=
 =?us-ascii?Q?caF/NG19kuPEtZTxiMgkz/PQRU1xGRYlSFk1vGgSHoXDIwncXJzRoxymlt+F?=
 =?us-ascii?Q?bDqMU3K+wW64htUhNeuOIuzyvLsxk6P9y/X0oE/4x8Bw1/V/1Z85zIQd7tL6?=
 =?us-ascii?Q?cEYp4KDmx5JmkPwBfPB+ArDx+pRTAXKS412xBfqnC1YUJxnIra9XttjrvBfL?=
 =?us-ascii?Q?Swtr/3fAGVVWVAAwlQs/gJq5prYo/uW5v35K2QCtdmAtOlOqJnV91Dxx/GVG?=
 =?us-ascii?Q?8M+yqxAXaS9DgujS+/Uq7eCGLWM84zF56hjRO894ScAajoUxpi1UJwo6Nuh6?=
 =?us-ascii?Q?PzySLJmlun5S+gfIIraeBtYefrqmTvWnYf6vl1394jrXDrh5CMbEKpC6bDWO?=
 =?us-ascii?Q?uKzTatOJR0SwWVS29eIw/7/OXZixGUU0S6NHosqn75WBRA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w3YAF/DEVRuyrV1s+rqtPuhz1fnxXnTUNZsJ/nE5t7mqmrF44D7wRBEq6KsW?=
 =?us-ascii?Q?duk/2gvCfLJOY6KqhSuD3GBFyhuhVb95dTHYgqh9xZHH0S9oXFt00kSChziW?=
 =?us-ascii?Q?zL6urhpfxoIEeipswd1mUUw7S33ZeRp93OnDL0it3d+Foxw7rJ1wR/tldWWp?=
 =?us-ascii?Q?8dU8ztj3rnOny8Tng7iGa3sLRpL0ev18AYhJ7A8A3Oh8iTWKRjniu93cQeyz?=
 =?us-ascii?Q?PXkNiyfznRP/9jf1fe967rKFAocgMP+8aAhrKO2KOWt8fu1W8p1hPzjKzZGW?=
 =?us-ascii?Q?RDjwVjgVpSttUkNZ9p9QkL/jJ5DijjekqFFYr4P7utWbBNsyg/IxiWSK31jn?=
 =?us-ascii?Q?vRl62xnBGvfKvH/eUYI0S/bEm9EvJc3Z4LuZ62Q95sxASa2NlE9o2Qw0UrUz?=
 =?us-ascii?Q?IDqiXQ3DZ9lGS52cUqiNy89t5ZvmM+xct3Zjv4i5ruZTmBy2InACZoVft6sK?=
 =?us-ascii?Q?zOpdgKUlSwguN6RYO0P9aWf2ITfzpw0OVTnB4udVdPoQ8MRue+6jGDU5mC10?=
 =?us-ascii?Q?aVrarz6Y7/M9J4g3YlK9eS8UOL/q976rLiz2r3lX7zk3BNo51XvVD+rcZ3Ew?=
 =?us-ascii?Q?9BmSkFaPrtM9ed8T9VQ/7fPQztb45N/XdrzIWFnkDW6NZZi2D3SAvBsq7MWL?=
 =?us-ascii?Q?+xcHO4jf8yXx7I96BCkSiWberXpvB4lcIRTbi0U8Go06X1gp2zrk+GpjnYrx?=
 =?us-ascii?Q?JGiTY6ocU367PRrn2rdKrQAqcXM8H2I9xGOxRtOgcUBdqreAx3Mg2fgw/8xe?=
 =?us-ascii?Q?JExwyiYWn/Yl/NObh3cpgIUw7vGmnZOGQr4btRtROy7vFBVvR+6ej9lXIBp1?=
 =?us-ascii?Q?EMpBM+SyyaVg+R8Ied7E1C8SSpdnA0mtQxslhdR0HgVv7WIUF8l7wvklBPXC?=
 =?us-ascii?Q?XfiV7jgsUCfam7p2eKvZJ+Bbuf8nsV871qj+Zle4nP7OfpKbKenD4TEiIKNP?=
 =?us-ascii?Q?bLmC0KuMVimwJexag4l2L5baAnaC9AVg98Qz0bRekhD8KeJTdBZ0v+iNvNAa?=
 =?us-ascii?Q?CNU+/snwv2Ayv3fz1/St8mwsqPpdhk7Zw6xAJkvMxynfL//FMleHMxkzjM/6?=
 =?us-ascii?Q?U4HEYMaYVsmsqi9W3I956ldSPteT42tR1EftU0s/LVQ3H5I9i/Xk3VURRiRu?=
 =?us-ascii?Q?iR5ff2MJTPD1k2bdu3Id7MLkXwjBc55AsoAdhc/A/lg1Xf1vsOsK8moOOj45?=
 =?us-ascii?Q?o6ft/ZravnckHaZaHrVOXHUfXTHz57/WqbYyJVtVNz3/6hxcqR1s3/4Fu7q6?=
 =?us-ascii?Q?xQATQUFxGgAo49VFFV9mSiCCQRzhq6y5hBHHEzlEjHAjFZ9EnMQXAzCpf4jW?=
 =?us-ascii?Q?oj80pKveaimqeS+tLdftTg+8So4VFkwtSf4IFjPNjlXK2W261mtmBnmbURBk?=
 =?us-ascii?Q?gEYkb0XBLegWBs2MO210Rkvbb8zBfrwfMqsmS1Udp3lZxAGeSNas9T0Srjyf?=
 =?us-ascii?Q?HRFCl6X5X/goz14/oiS1MGSKUN2/aaDERwnoupSYguzuiNbBdYGPNkdMyp8U?=
 =?us-ascii?Q?WL4s/HrqfsKzChVJQZPyR4bdQWYoahzkYa0fwXiLFqVceNwP4/9pNv/2HzMl?=
 =?us-ascii?Q?YIIfM5qV4aiETlhEiY6i0vMWZQYVj2TNttzQ7VUpkI5JltBrppocoAYyiK7I?=
 =?us-ascii?Q?W2WD9yMcc3AtO6poWdfp3J+tRHcUOw0LF03pmYv1c6mM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b05091-2294-40bc-37e2-08dca714e6e3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 10:32:19.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tsv9TY4tTVoKznP26PVGJ4TXNMuwjJdFBnQ80+LApZSvwmicACfLAe4EGJzQJLd1jGPwb//ZrmaMufEg2pX/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8389
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 10:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16580

- Avoids using a busybox losetup executable that
  doesn't support the "--sizelimit" parameter
- The "--sizelimit" parameter is needed for introducing
  speed-up of disk reencryption with the following commit

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook    | 1 +
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb            | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partiti=
on.clevis.hook
index 4e62ef7..4fbf830 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
@@ -74,6 +74,7 @@ copy_exec /usr/bin/file || hook_error "Unable to copy /us=
r/bin/file "
 copy_exec /usr/lib/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/=
*/libgcc_s.so.1 "
 copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidpa=
rse"
 copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mount=
point"
+copy_exec /usr/sbin/losetup || hook_error "/usr/sbin/losetup not found"
=20
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.hook
index be8c117..b331a58 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
@@ -54,6 +54,7 @@ copy_exec /usr/bin/tpm2_testparms || hook_error "Unable t=
o copy /usr/bin/tpm2_te
 copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basenam=
e"
 copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidpa=
rse"
 copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mount=
point"
+copy_exec /usr/sbin/losetup || hook_error "/usr/sbin/losetup not found"
=20
 copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hoo=
k_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not foun=
d"
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 72de5b6..3497d95 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
=20
 inherit dpkg-raw
-DEBIAN_DEPENDS =3D "initramfs-tools, cryptsetup, \
+DEBIAN_DEPENDS =3D "initramfs-tools, mount, cryptsetup, \
     awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
     libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
     e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
--=20
2.39.2


