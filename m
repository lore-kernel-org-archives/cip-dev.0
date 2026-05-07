Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A6CD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 15:43:15 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15337.1778168585568552437
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 08:43:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kRVxOEmz;
 spf=pass (domain: siemens.com, ip: 52.101.65.5, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVt9XOn61O1HGAQ3mafWg+BGzl4XjeeLLNtBDkwHsMiImyGEFy+Z8uv563NTFv8QlzZJh5Ev7+8oWR7ZjwcP0SJzVn/w4mjE2bBQku/W+XNOdh944h1j+ONEMkWOr4LJh/6ns4HesB11IHxoT/Iyy+itXEsEjA+OEfXTcZAsoGWQZLlfecAICXmydHB9aRNdhl+znTo/TxD44wlxjseBs5932EVC0V1XO7mYfbF+Uhhd7F8wp4RFAWymu6GauG6BJZTFiCjfEp2MAsscnDsfm1Ca2a586HBQFz6HbGjWjqR1ww/fVyjCbgoARMtN+nhdQGXGYpDrfluPWCm3Ybbpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rADmgsoT5sm7TIcJWL8UdODwymd8QC1T9K6eSgulFRI=;
 b=WfLVbWN8H2m33RaAWur2nvkq5V/FXvxxAojT+1IUcvKBBfofIAICIdfzlAisBmEaGwtcNWM32d/OCbB0C+tKUXY1cOXiHKyHznsVWX7wq+gv/pH10XF0K+dcLKcpjE7hBQUjCHs1URSeqrBeffZYHy38UNJf5kh8dVwGzjZpGS9AxKz7gVeZ8eKYGCz98lz2LNNAwaJZB4VDgoQ9BORj198J9VkPEShCf6PNaQKMILfo06PgM2T82RdpHpfhore8+Ew0HDkltH9m5qtOfZpPgUc1Y1fgfMZAAZ4XlXLpgup/QN+k0Z62DHUKC0iHNI/3najbaw6klCGdLTxGrW2Sxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rADmgsoT5sm7TIcJWL8UdODwymd8QC1T9K6eSgulFRI=;
 b=kRVxOEmz82hLFiNgII3bqW6RPgb1OAF/xuRnr8NTWBi7fZVw+Ov9hnN2+OhVnzK/ZECHKvYb5Z3ysXdS2s07oekAZ2vqDHRrtDiE9ExdzAO4CXNTsirDknTVuvc8LzOMiyqbWiejTwmtRKDijC4DRqCXhNk7AIj519Vs8IVdE48D/b2iBQfVOhFPXlBuA90D3tNDX2iIOBaibnnWOQZXj1Il9xDyD0jaxHSmoV5EfCUtpfiGq9VWaONnQU5fwK+/BI0W5Rnx8Z/xihuzUAi6pgvKFoFO8MTaPbcStApSka/mu1z5MdQeTtwGkbWEpj0cXLnYr8sC34vYA2ef7T2nEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:110::12)
 by GV1PR10MB8848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 15:43:01 +0000
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599]) by AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 15:43:01 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] chore(factory-reset): make btrfs support optional
Date: Thu,  7 May 2026 17:42:53 +0200
Message-ID: <20260507154253.2686296-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:110::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2546:EE_|GV1PR10MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc42a9d-6384-4174-4729-08deac4f51d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|3023799003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	yonXfH0pODRj5bhAZofNCeFvglTPZVtUPyNxZOe+C7UMbnzpQ5fHSAMG1NZXSVvLr4MAG1GJfInVgqW9dXryPBLOA8lfVtJAdoL1VQU/X0jp1KF3Euv9bFstR4G/3YHepg+5JsH7aUIuO155fqDK3aPcOvCke2oYaIY+OvasasTwHPxW6wsD1C9q18kH9S/1mTeE2lnTml+qtmH08gzhKoITHE/MX/yqu48tCpC115QESBA7itKJUYxS9LEjR1H4cttVeYb3tKSVDzUlhQ+EZd4IjtCoTQzqaUaUxfBRhjHv5541GhvPjbl3w4SMvEU0aRTDNUJM58K9We+GTi2KGoJFOicwD22j+1p4DhYaiYEgzRhxcjJ51jelW+NTcsm+FdcGc9T+cpni3BYjORXTA7ko+xQhwMg/k30xo7adK2uaBWGCU9n7SDdD0U4JrxV7KuDIKZw663lOZBFnDSfyaWNbto5Mkb77T44rg5KBCaonzB3qIkq5C3Qjxppcm3S6Dx7p+w8Xq//fypODwtmrsAHKWbBE5y+D3j80o8LieI04j4+S8/0OJNTF0HbJsFkNlSqBB6Bj89dYR7GMmlQGeUo0SUbLQycDuIeLVMcLIequ7GD9YPAcNS1Kh0IjKbcwlUQRG7ERsRK2yeINJrGQN4envUxZryTtFuo7e2B/40A5qyB1fCI5R5pk0MyjwjDL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(3023799003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FgapQWS1r+RMzvk63pMKWrZcPyAt+m08brnNFPYhoiy22TmhxjXKo3FsEGdK?=
 =?us-ascii?Q?msXJXtJj2hNIg8JlmP1+3PsrFTW4ZnY4mYiakDeDqz1XdroDofFRZXoPvZqS?=
 =?us-ascii?Q?k74HiovnG7QjUdxP0RsvRdD8JIpsEuGiianr6/gYjlNA4Dn5qcVdY2rPY3Ys?=
 =?us-ascii?Q?MPFcEOfzlI45CTL6tBYmaWstp+ob3r/RkVHGFvDuyBUAllCM3OK3sD0eL5EJ?=
 =?us-ascii?Q?BrVMhXhX5hZKDRBUXEEXE8wcsir7zrCpfVNDCAXPxUzmJldxEVD5Zehnll69?=
 =?us-ascii?Q?CNvueAI1QpMpxxRaG98KvwB7aULicD2aRqIrwsL7VcvOGjdJ6/9IDKVMUzq/?=
 =?us-ascii?Q?Bpty7X8Pbb4gtOgFSlWfuWW9j/H6UEfda+cC+mq7FNilcqtyAvsyAPUyBu1x?=
 =?us-ascii?Q?UMh9KRP/ztrqb9ZojMC+AxYm2vBCX5p+qEXkyghlTfd6v6M+vQgxAhw7sCd2?=
 =?us-ascii?Q?J9quPxaNYn2rKP/AzUeYNIW2+TI5QWd18QgAoftp4dTGCzkFocZsv8UvsjfT?=
 =?us-ascii?Q?UvbxLYWNajuPSiHh9cor478B1dWlwg53yFjl+d7ZV3qFTaLantwLiifvZk08?=
 =?us-ascii?Q?n027yXQp/EXxD/lFL5G9nnyPzwRNoxHAMg/fNhO74FkA+rjrRCRLn33FswIH?=
 =?us-ascii?Q?SpMGO/39aoAdvUSi3/Qqg95AbYE5aMtYKU/LX1EqybKdS5bSi5at1TNKjSTW?=
 =?us-ascii?Q?jneduX6e5/7UtvMqY6gyrsvqJglwmhVI/mf7CcMxhENPKiZDMexlcgPXSMMa?=
 =?us-ascii?Q?KD6ruC0I48Hk6fhY9ATkxc348hnPfzOpmEUlA+NvmfjacyElOLJjr9dpt7Qv?=
 =?us-ascii?Q?xM2mUsFgFSDjmMmC6BrlgElVtrKaVCkyUXh1oo6wq/SiIAg8n7DAn9eEfEJP?=
 =?us-ascii?Q?xpos+rzzl5XR0emoTGd/KABruOftk9t9KHATNgIxQzMNMTTZuS7wISbVdqT6?=
 =?us-ascii?Q?Eoq/LPjPW3x0zZGp4w5sLd+NpLY519gzPbWKCrtxWi0WcE05z1lWdS8SKiwn?=
 =?us-ascii?Q?ePY5/JQtSdBW/uqBZtzIHNVxDk7cIVSxAtKQT9E8xLReBUPd5gkzrU43pzij?=
 =?us-ascii?Q?Nb1PVhGFPSyna+vdv09S7gCA56H6rCB/HEyci3S8v1R7vJFSso1DOdlTxKUv?=
 =?us-ascii?Q?maU3hpMIB9KLNa9/9/iQR2VYFlI4H+tjNiWjSXblgyneIDmpFJWvsXTqYeNe?=
 =?us-ascii?Q?XMeEXFkUB6aRAV4dSqHIOaY1YrSRj9r1N+nyU+JRzt2N4tdhIG7CThTdajgE?=
 =?us-ascii?Q?JX9Z0Xiw75+OG41NMSWfRRnJIOUSnP46DcLY+S7JuLUZTXzH9tZ+WaYutxeE?=
 =?us-ascii?Q?bGpDpG2s/r58JZqiU/b78j6w6RRiByVsxx1Eut3azhpM3YPyJSXz8BqpwKNu?=
 =?us-ascii?Q?qalE10EwM1ySrpNR/XTZH3D68azSt+2GwE5HySXByxdMKmb1dgBfTNcfH6tq?=
 =?us-ascii?Q?jqt/hX4fz8yAA8xBkWEgpYCktsqowfRJL3ImhNddhBf/gGm0sH/9XrblA4wF?=
 =?us-ascii?Q?O45/3+7GdckJPLoYbETWuRL5H/3RDmG/2fw/NC/ZI1hSx0oyCd8sXE6pQMdq?=
 =?us-ascii?Q?IpmB+z/tBAgvanc2n24UhKCYBCv8dZU1n0TNc61QPystXaErK1608ED8FyDO?=
 =?us-ascii?Q?+NdBEbQdD7f3yQe4k02ZR9ojRvmM81WYjUmKEhwm6BEgQFiLu8BI7i5yOtvQ?=
 =?us-ascii?Q?J/SZCl9WkGiauMkBbc/N3rzOuvgRdvJR2MIpIxtemNUaF5HrMRDRCs+iVLb1?=
 =?us-ascii?Q?4Cr2LtwNAWhK+ElxZaH1vfaLPHY/asE/fCWXGnR62CkTuC3t1ktVAC36HS+A?=
X-MS-Exchange-AntiSpam-MessageData-1: YcE0Ywcbt3FmiSSdh5XczfxKsgnSRGHV/+w=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc42a9d-6384-4174-4729-08deac4f51d0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:43:00.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nELrVr3HBSrSTYvEUrqtnYhBH93rQhhaGiGIMKxiLHaBGSI8BZNuEzH5TMP2czJMA9CMXz1NDxLxnPP8W1MqCj8d6aA3lOiUkFrAPrAmkQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8848
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 15:43:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22912

To reduce the footprint and attack surface of our images, we make the
support of btrfs in the factory-reset initramfs hook optional. This is
implemented similar to the initramfs-crypt-hook.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Note regarding testing: I tested the non-btrfs factory reset on the x86_64-=
generic
target in QEMU. As I don't have a target with btrfs, I did not test the btr=
fs part.

Felix

 .../initramfs-factory-reset-hook_0.3.bb             | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-facto=
ry-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initr=
amfs-factory-reset-hook_0.3.bb
index e962a51..9ba3e66 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.3.bb
@@ -20,6 +20,9 @@ INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
 INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
 INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
=20
+# add support for factory reset on btrfs
+INITRAMFS_FACTORY_RESET_BTRFS_SUPPORT ??=3D "0"
+
 SRC_URI +=3D " \
     file://factory-reset-script.tmpl \
     file://reset-env.tmpl \
@@ -35,14 +38,18 @@ TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
 RDEPENDS =3D "factory-reset-helper \
             initramfs-cip-functions"
=20
-DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk,=
 \
+DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, awk, \
                     factory-reset-helper, findutils, initramfs-cip-functio=
ns"
 DEBIAN_DEPENDS:append:encrypt-partitions =3D ", tpm2-tools"
-HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp rmdir basename \
-                   mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
+HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename \
+                   mke2fs awk blkid rm get-factory-reset.sh \
                    chattr grep find"
 HOOK_COPY_EXECS:append:encrypt-partitions =3D " tpm2_clear"
=20
+OVERRIDES .=3D "${@':btrfs-support' if bb.utils.to_boolean(d.getVar('INITR=
AMFS_FACTORY_RESET_BTRFS_SUPPORT')) else ''}"
+DEBIAN_DEPENDS:append:btrfs-support =3D ", btrfs-progs"
+HOOK_COPY_EXECS:append:btrfs-support =3D " mkdir rmdir mkfs.btrfs"
+
 HOOK_ADD_MODULES =3D "efivarfs"
=20
 do_install[cleandirs] +=3D "${D}/usr/share/factory-reset/"
--=20
2.53.0


