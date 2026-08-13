Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2792DC5CFEB
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 07:07:51 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13675.1786604861171931448
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 00:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WvdpxN1G;
 spf=pass (domain: siemens.com, ip: 40.107.130.7, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ1KBqkOOK7E8V50Isj10XSBL6HH4VuIe8Z5+5BELTT1ezCmviUx5oRVJYkLwg0l3t+oouZC7gombfQNnpwzZh4Mzw/eXYVZItXmEs3FIQ9K3S0rdDGGwuk2i3nDYtn1aqJgeMvb0IVjbVnq4C+3KGT+LaULP4cEntMHo4FXURMyY970gvDZ30rauTVgGtpnT65bqDtzGzl6UjdRX33REICEERR4P3H8+q/t1Nysakgs1Z6HGcWcU9FAoyhDbSHxPlmGSfJ7N5cXnFSseqcPUvUX2yuvWTqyla53eV52selfZ6v7lKBKiFfL+09fpHGiyvhGWy4ga8fRmXSxz5NBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8ayxmZw1zwOhFIQhpPHhGR0v93osyZYvfDm5HYSUk0=;
 b=CXTolFNVFM6y/uqIKJ3oezuxjO68pC4o5Qv4boxbxItV9lyUaSSux0YeAQtZ17XQu3lM2YRWzvTOSKmwCtdpPlFNETCg18K5lzLmuaNAiMNUja3+h8I4J/g0oj+UO1lguBjmebNySuRWdRd3k7o1Bsxf7zBA9PwND7tCKtKqbQBduzd+gGQQXUfas4I1qWPliQdtHZTqCAE6LFAQ38own7sCIU0fIBDxfUghNSoU9SCRAMOulKPNVvRUDBWKpLWBNr8P76RyAe5DZsxcFJNokUNzPtimjr1zsYfuy0NfnNeeNN3NUq+498ubLbUd9bfl6p+q2uoCKaVxp39uYQwNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8ayxmZw1zwOhFIQhpPHhGR0v93osyZYvfDm5HYSUk0=;
 b=WvdpxN1Ge8PXN2znD1k0S+oUC9oI+yLsloMN41zzgA1QTNZxRXbF9jaV3jKm5cW/3oZzybyS5gRVrRkvABMfrwR6mGtS2YqHzrxntxRXtbrsuk5H+zBbNFwZA1wQ0ScBSPNh0MslaXQ6D2wxDJtCXBNjdVVNLfiXfPe5SmjVWdwLXP8aL94ECsGQqnNDOMB4ILDuQhrW4wnOY0d+YLpKR9N8448n0tszXwTsbo1qgfGzoDSLU723adFZV1T7aH2k0CDaxcMoojy2nf2mgLSMgbmOMC3viWeLz5OdEsdL8XAeIOMvStc1Xk8+hSJSBSiMugJJOpNXbwI7ngtIe6axhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by PA2PR10MB8340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:07:35 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:07:35 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH] Update Isar revision
Date: Thu, 13 Aug 2026 09:07:28 +0200
Message-ID: <20260813070728.102577-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|PA2PR10MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: b412c2b3-0833-48a0-debe-08def9098d4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10070799003|55112099003|56012099006|18002099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	4mscPwEXLcX+rDlLLDyMFmMOmvzO1LhhkXdftoz0k1A4F+0lWDvBXEAZni/Ol/rN0tbd1BhRl7stZpcSGj3GDqZE3v+usXiDUhh03Ox0SiJYEoAbfiD8HaYsBnlE89xrn/Q4Q5L8g4U9jsqWsS6iF1QGPv5QDT+k9yBZC1Mdw4YHb9FfReq9tUpUfNH/HWE9AG8Vrh1OmjvV8500YmV/gvDZi2vZu3HReOaV8SNN4ZJwB8t4ozBNgQqX8sbovvaMf7sUbKdtZJtUxcRluT+evNLacQYSbodDW5UtpR5D8aQ3XO2J7x+UbBp2HWmyNL07O0e1Lk7nVfBmPYt0BxDvoRvPjcjr2pVWic64sMNDMq15g+fNG9QYzKCau8rsqCqB7XPqimMFUGH0AXBNOZ61MnLGG0PeVmAER5NUSrEiRRPc3wf9+DjFYBu7+kH1igDmj5nXXXlEjsWWoIv26/6NDxGVRLJwUFdVP/8gWmi4xVm/LNEghRzvRoKV0DiPuF/lDIp/ck9MvWXupndNtvNh1b/VLXlfoBfcCEXHgs5FKA+6JKvcSknoouedziSXQq/Q9uWEpM8mMeLS6sgO6zO2Hp2lXofb5eoNZWy1+9SpikbUK1zl+oZm0MsL+7nDOaSL/XRC2M9yHA7YjxeX9Sr+3UXOccrl/U2IDH4Qca3lsV0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(55112099003)(56012099006)(18002099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AlcJjzFVRZ59cWqIlfuyBvlrSx1OMsQUZDzmH6lCPETDeild10LxyUA0toKY?=
 =?us-ascii?Q?e3C3/WDpVW8fRATc8bAQjUwJA/gH8HTrpxho2zzD4qaSOrjwR3LKy+VUMGZw?=
 =?us-ascii?Q?slWgVgh+ZZlFzYy8RgpvVmAmrdxPE4+t0VSJ/fif8/ENgm3DPfrX7iF7oCeI?=
 =?us-ascii?Q?sWsMdD4ca1OyVbTRiesref2CNGncEX55m+1MmK4APiqOYf3VuVIqE+PakARn?=
 =?us-ascii?Q?y+s5A3P+2Hd2LZ8PDp3hG++S712pR7s8/Wpm22SbS+7f6ilIHCyNANBAaeqx?=
 =?us-ascii?Q?zAXefEQ/X9fuLePTjZTvuGTswLB1WGHUlw2ib1w564Bt0qb0jSUjfX5wPjRk?=
 =?us-ascii?Q?PLT2frzN2MZRF+r01UtjvJyAisiTsX6oSOrbtOvXQXl3YZ3PzWvXOk9Kdi3y?=
 =?us-ascii?Q?mTdv4j3KGaeHs77jFA8MtgROltBvwOOsP+QOF8D0Xum9unmPCDtoy/X2I2fE?=
 =?us-ascii?Q?9eug/ngslsYFMrJ9Rj5H9ujk/fPPTo856jcsX4XopyqR0xMqNZMdxGzHNyMI?=
 =?us-ascii?Q?zEYG7brerwugC/SDY8Q0OVVdL0w/TSsS8pMXh100lrx5HDnT14u9oy+70gRp?=
 =?us-ascii?Q?jj4ClS1ULv9tv+x9r74q8cJiw/ys7PoFpa6ss6rxBGhMl5qJ87JV6ebpTwJD?=
 =?us-ascii?Q?koEBgZVty7Wee3T5NO11A8WL4AEyYA/PWJjPnfRdgkYiPUd0R8ZP6717JPqg?=
 =?us-ascii?Q?aOwTiu70D9VGbLU4xUu3SRXUhvbOKy1B5ZcfF0gY4lAk7WCESzWodfnspd6e?=
 =?us-ascii?Q?wxr2jVGoSYfM+boAUIisLMoBWRS82nWgOlWoouzDBlHdjvam+FibjqKZ9NEb?=
 =?us-ascii?Q?dSBWK4Sgdopn5VyrXQbiNHQwebQ3SJTU526OrYu1BCZSPeE9A5Es/FSYrnTH?=
 =?us-ascii?Q?QvEmMPd7UWBCZv1hnEDX9YS4xyKUONeyQO4Wzwfz9vjL7nvQwAV0XqbUUMNM?=
 =?us-ascii?Q?xQvrjhqDQ5PmyPWOzM3yC/5OXqOCzb3WNwXNRsv9qkjhQILBp3V6REY6d6iD?=
 =?us-ascii?Q?KaVnE9vn+DfCB0niyT5VAEbH25ljWopwrxYVOcBI+4MA6AgfKhhmbiH7c7ru?=
 =?us-ascii?Q?nCycDouYpZ8T45DELseSIdcxaQWOEYPXlbkZI06xRhwSyyLO9MDREUt46eN+?=
 =?us-ascii?Q?tJK0F5IdE0AdZdt360fcCOd+8K9Kwe7TVuKyvm9kcqnjJ+3IjhbFZaM926w9?=
 =?us-ascii?Q?n58gQsiJ17jO+sX5m/7Gjo5ibH8NbmVjq3iH9aJr8ViIwN5Hu5kMoi2KaOpM?=
 =?us-ascii?Q?KYCvz2Th273tfFgbFj6DKA1Q3sjieyfPtgtghUtUmltU9Izhc5QyedlTn+8/?=
 =?us-ascii?Q?2twMf1u295XCtUDeWIVTvEFwjc/QQoRlyNtXHTTloJlPK/JvSRKqCy+12T+U?=
 =?us-ascii?Q?clUtHoKQbYZRu3p5u43CMPkUHQOdIA1MM3NICebznwkaBLeM20Y4b2h1kRRz?=
 =?us-ascii?Q?4ekuNCzu/qPGSAsFnlvRBkCBcECE86zeZyXHYHhgUvaN/hhWBrTa65pooTx2?=
 =?us-ascii?Q?2EZnhDunkit6lWi5FBBbT9bIYpGnaoRTeMz1YHkwhvNVR1lP+JX5321N+XhO?=
 =?us-ascii?Q?TBYZJ1vWBp8Xtic1+AF05Xbl0MRfoAfRkSH8pUFLCX7gN3IRGyriWinXMOdG?=
 =?us-ascii?Q?JznXJMK2u8b8fw5JGqxPmuVJ7+lLVUBeHWG0hjM6sqho/p+gIOhDR3oFmfyu?=
 =?us-ascii?Q?oKPEWARMfSlfi2wiFVmJBPqFa/cEjQagLN9Nvh+Ovze7+mocEKHwO9vyHV3E?=
 =?us-ascii?Q?uxmp5PjD7jTNN7JkL8sQ8meUkXyTQcST1Bb1WzhGdS0q2sDOebtr120yz4NG?=
X-MS-Exchange-AntiSpam-MessageData-1: h9Oa6wR38PHwBV+Aak8IpOPu1wvVMECOcO4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b412c2b3-0833-48a0-debe-08def9098d4a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:07:35.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/IAJZmZcs0lxMgjbbr1zYJG3STef/+gzQiMzbeJ8kwA9AIckgRW1kcukp2HTP6pFPUQ5R1TZ3S/3Njcruz1YBCgscFyo4o7IfBEL4m8IaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8340
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 07:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23910

By that, we also need to update the firmware deployment again, as the
previous interface was incompatible with sstate in combination with
hash equivalence.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas-cip.yml                                                   | 2 +-
 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb               | 2 +-
 .../trusted-firmware-a-qemu-arm64_2.13.0.bb                   | 4 ++--
 recipes-bsp/u-boot/u-boot-qemu-common.inc                     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 5ed7ad2..4fcdec6 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
=20
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 481db3b2e8949336576e50a78aaf5d101f52c8d2
+    commit: 86c761e45e446c01874c0a36394f8be1f7d938d3
     layers:
       meta:
=20
diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb b/recipes-bsp/=
opensbi/opensbi-qemu-riscv64_1.7.bb
index 9c2bece..3f51dc4 100644
--- a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
+++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
@@ -14,7 +14,7 @@ OPENSBI_BIN =3D "fw_payload.bin"
 OPENSBI_EXTRA_BUILDARGS =3D "FW_PAYLOAD_PATH=3D/usr/lib/u-boot/qemu-riscv6=
4/u-boot.bin"
=20
 do_deploy_firmware() {
-    dpkg --fsys-tarfile "${DEPLOYDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/${PN}_${PV}_${DISTRO_ARCH}.deb"=
 | \
         tar xOf - "./usr/lib/opensbi/${MACHINE}/${OPENSBI_BIN}" \
         > "${DEPLOYDIR_FIRMWARE}/${OPENSBI_BIN}"
 }
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2=
.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.1=
3.0.bb
index 7fcd144..e07342d 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.b=
b
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.b=
b
@@ -32,10 +32,10 @@ TF_A_EXTRA_BUILDARGS =3D " \
 TF_A_BINARIES =3D "release/bl1.bin release/fip.bin"
=20
 do_deploy_firmware() {
-    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV=
}_${DISTRO_ARCH}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/trusted-firmware-a-${TF_A_NAME}=
_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/bl1.bin" \
         > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
-    dpkg --fsys-tarfile "${DEPLOYDIR}/trusted-firmware-a-${TF_A_NAME}_${PV=
}_${DISTRO_ARCH}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/trusted-firmware-a-${TF_A_NAME}=
_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/fip.bin" | \
         dd of=3D"${DEPLOYDIR_FIRMWARE}/firmware.bin" seek=3D64 bs=3D4096 c=
onv=3Dnotrunc
 }
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot=
/u-boot-qemu-common.inc
index 18f871b..c20787a 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -26,7 +26,7 @@ python() {
 }
=20
 do_deploy_firmware() {
-    dpkg --fsys-tarfile "${DEPLOYDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARC=
H}.deb" | \
+    dpkg --fsys-tarfile "${DEPLOY_DIR_DEB}/u-boot-${MACHINE}_${PV}_${DISTR=
O_ARCH}.deb" | \
         tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
         > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
 }
--=20
2.55.0


