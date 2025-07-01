Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E09C7EE30
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 10:45:32 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.8])
 by mx.groups.io with SMTP id smtpd.web11.7649.1751366726019281968
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Jul 2025 03:45:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=NPY7X0r0;
 spf=pass (domain: siemens.com, ip: 52.101.69.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq/HCE5fbEahyYPlRCwHnWOVPyKX7r5y4SH3jLH+/xSHgF/RK22IrSL/c0pmQ0v61QptBNilNsHgW+niMWDQde22NftzwJfBU7vxjZ/zFlH9Cz1Em4TrAH7B3ETx5fVysHmMmM+Xm9hT4eEkTA44D61zGFiWSRBmSbPpy06giIv3ZI/WxumyxAeAXX/dVU0O5L2bQdz3qKnFmmZ7LGFqxvM6GjpRMHaSNbI+0QpG7HxYG6HGgVuixG0Yyntck0IQQfmGHdtG3LSPjYArfqgtenL1jj5MoLRRWPD67vwwOktth/I0+hf0YJO7aVzCC5FkRhjZC5rFws4bfLBYtcQ+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu+JTTflaTtP7J+xmBW/tRcqEjHi4xdbL6o07oD+eaM=;
 b=zI7DZVQ2d4Yrd0VFHdwKRVUlseP7kebFjucG8a/BGdke1k7t1WGZx2nMu872L15aja54iMSQe2e749xluCLSDdVjLUwzmwTefBkuK26tYfYmTpM3HS5htouHAAnwpWi1yhmpQGZHy/3PdxlXV67rbVgfn9PX4cOE8ZXSDxe45wGSQ9P+9chbwOkc5rsBWTgLgdmzd3g1ciTAasNmfavvA/R6dsdSlKWCM0goVGYAwIvy9kYUtZRQnYrLa7OjKghTTgy1Gd+CzaP0qOmHnx8ngl6pDs9n9A8UCCdXWWSPQLKT89PQ7CRLlfOr1JmiCTLi4dKBDf5wnbN8gpfysDWn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu+JTTflaTtP7J+xmBW/tRcqEjHi4xdbL6o07oD+eaM=;
 b=NPY7X0r0Ueen4aI8XbzBk9oGQunxQFh52oxykrfshKJgdpoRKedW0CpiT9tF03piNwwgNhOBLNBh2aEdQrT+IO0ljt4JETdwFzUEGSqKhmmn2T0qJ0T1iJkNPqGIfcCB6nRyYwBkxBh/7Yd4xwlq6hxy4uyv6c3/gVFCWjn6fcUHIMd+GfctbbiHsZmCTzoZtxDCo5sIXN/NiRjf+vz6JjJPcf6yRxTmWodDC8y33QimbeLtvkbrdBXZANdOC2Xuk/nFtZoYa3aGgqayVjc3vQT6Z8lD1QVeCqHSTE1defGZfIINk1H5fT7gFpO2ZhuiHVH+IA7/KMXVRYVw4J0J+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5599.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Tue, 1 Jul
 2025 10:45:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 10:45:22 +0000
Message-ID: <9a4b9986-37c1-48ec-a8cf-5ca5dd196b36@siemens.com>
Date: Tue, 1 Jul 2025 12:45:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] initramfs-overlay-hook: Add support for
 handling links as lower dirs
Content-Language: en-US
CC: =?UTF-8?Q?Enes_=C3=87olpan?= <enes.colpan@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4890f6-9e18-42aa-9ef9-08ddb88c6103
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?c7r9EGHE77DfmuL8BPMF2RANtidn6YadKyQQOPmfV3cse2wdiRNnI1zNN3gh?=
 =?us-ascii?Q?oZJ7liKlQmWpAniAlJC/jPP5ku2L5i3iL0fCX+HKG0jeV95go2tct9Uly5kt?=
 =?us-ascii?Q?R58XWlQeP907ICYQBkJfnFVwPeQoRDgWMtwbZlJBewH09/1tnXHZTKxuSs1p?=
 =?us-ascii?Q?m8M31X31KSMsAVQMWvh6TtxxCnsYSb5NARIOY+XCkx2cnzzuVQji9OxrNDHa?=
 =?us-ascii?Q?8UEpSDcdHUf/uV23ePtH37IAmHIgO4ML7LF/lH7zsspGFowJmGWQq551/8O6?=
 =?us-ascii?Q?bRP4mMuucQZFN/q7LfJ96kDGYpP9iAyceku02unJaUVibQRA36wYeaEpZU46?=
 =?us-ascii?Q?gW9ZZCiwiZ9a+2kEH7BqLHcZM02i2UrXp6/XsfYMG8jaFAtY2FrVRONwk4kJ?=
 =?us-ascii?Q?8NI1Xpf3a8ZyhvkTISC27RCy76e3tckqxtmFmff5JkYi/N2/59CzPzpYKcIb?=
 =?us-ascii?Q?3wT29ae+cxVY4YuBUClH7pbtnezXoBgDcIIDonzoNLxF9Dp8H89YcZCNmhRh?=
 =?us-ascii?Q?V8he4G5pDJMwDO8Vy/WXof03Folu5fM0sOrTa4stGkuOuDroWW3lKzU4+MEZ?=
 =?us-ascii?Q?Ih3S0KCUxiZl4wkm3K9Cv6nNaY14RepfuZYn2BVjogeIjAuRlLn0iY9gqalU?=
 =?us-ascii?Q?odYOy056SUjSVkgJMXntiyWaA1OvVXg2rUMk71X9ZneueTXvx7xWB31Zm+na?=
 =?us-ascii?Q?8Wuh3MTJkkKunFJm8Hynv7oWILDHBPA+rOhWujq7osVB1FsVtfzOrlwfJa6t?=
 =?us-ascii?Q?KrxZ/Tz8BBz15no1PU3Q6qNIwvy2E0yoNjDGiY5JG34k5nGWS+hcGU/La0qn?=
 =?us-ascii?Q?OStPaOEcxg3hOiTeTbP/+Ts5GrKVv2mOPo1j1t/rOZWoKrmcZrtwzzbHgXHz?=
 =?us-ascii?Q?SneMDLlCgwA8otLKSt8/VmFz3kxcQftaM3383S6JBT/AkY7CeNHKmcLDXubZ?=
 =?us-ascii?Q?o/ULly2qPbPrWd3aDPIN/SYCGptFJA2Vj3eN+222k2oZc81Drm9W3Xuas0TE?=
 =?us-ascii?Q?4SDC++hDqeUo4r+LEoaGwOy+32d6K1psSn7BHeeKsoQv8O9eZNWTbLCCY0Eq?=
 =?us-ascii?Q?xmElfBbu1JVvVOb5S9ZJeOKJi5zLPxPGD0eiIM4fLIfJUkwWh3iwagIKEjkw?=
 =?us-ascii?Q?25BxN1/52rFEsyYLptSwn2ebJG/RH3BEcdXuf9V6LfBCVFNPb79a3Coxcesi?=
 =?us-ascii?Q?wg+PJiFwa8XUcXshsvgfHF56UtACk7wnVS0Wwfps3hwcsHs9k4bI+LYEZgA1?=
 =?us-ascii?Q?GA5Kju14I5oW65GSYakXYbnkps2GcIrl5bn7Y2fgtLnsz/kQ3fzMHPdckNY5?=
 =?us-ascii?Q?6cbDA/u2ix30hfLkmRSozVaU2JCagxTYBkDYRD1cgzo1mu6g//vY4BG/Sswk?=
 =?us-ascii?Q?Px2LN1IFMb13wGCLfy6ZVefM9s+SBSrPH5GHf2uD9tNGHZsWB16B2syC5vFr?=
 =?us-ascii?Q?cj6Rar4v6Zs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IyG/wShD8vzVH5Y0h2Isc8qIfU00Gmt/HAYm5ttQxRj1D7Rv5y7gjIwZWFoY?=
 =?us-ascii?Q?QWycst0PTm8UrxqmGQ4XtKa3O2tE30OjA2XEpERIH4eUTlEFCG5cZ86s8CDD?=
 =?us-ascii?Q?4oB5w9VuRDSHDNKSYVScsQboMh5/y9BuP5dHT1MQP8cVB+rpmuQXjbkUyz9K?=
 =?us-ascii?Q?ezSsbjgEtGXlnLlY72GDJV3olRBtdAz63ydgkbJ5wvDL3Nb84Fxj776IUp0g?=
 =?us-ascii?Q?fT3GzXN7RnCr9GZQ0n8yQm/XN5rnpahzoUBxpyuKlCFvGB73IE2SMUPeUxbj?=
 =?us-ascii?Q?oTwmtCfC8ozR38PeDHRaMY5kQQ4wYIDTk9hJu9ntiac6I7wr0XPERCapFlMY?=
 =?us-ascii?Q?UQGH+U9F7NJdjngL1f+ItV7R/0kj5c8AMwAKaX5na8jgrS701klQlI6Wtktd?=
 =?us-ascii?Q?vOkd2GcYaNVg+PzHpTdqTDriVAMOD2TL1kHN9NPUyduE776BEPNOAS26/X46?=
 =?us-ascii?Q?gthwXIrXsNrRmBxoN14ESbwQEoyP12VJHdaJAB/fBbXLAWEPsFR0LhdlDBsB?=
 =?us-ascii?Q?oslGCQ2hb5Ukt95B1FNYehZoEp2pLd8vfY2eLJafryUtJ7XzqY7igBz/MSlT?=
 =?us-ascii?Q?7CL/Z9G43eglV2hxEtO1TM1VtLDlXjgGw8FTBBVME9LrEn3VP7nwnWwa9TyV?=
 =?us-ascii?Q?YotB1k+C0fYn+puNWgIF79gBQrY2+NaQ4H3X9eRPyTi+P1FrCzymowUrpSoB?=
 =?us-ascii?Q?jh+7xuRwYgQAi/y4vxPSFEIqDRErEg680Q7xcQMxRcvtCjwbBpp0capi5uIo?=
 =?us-ascii?Q?k/su5O+n1iBpePBpKfcfcD6580TaictzJyFjGdoP4R4GPf/T3EClBFkp5kGo?=
 =?us-ascii?Q?dDCzgBS2OTnsBtxXq60QSfO/sY4LvS11QZoOXkg7CUcOPjMpRcAG6dRRUx4P?=
 =?us-ascii?Q?cMy8oWdqaryEA9hu5AspIYpvq8rP7LKMWF4HS/1GZYou0cvBKrdMkUAw07QW?=
 =?us-ascii?Q?BCbdww4wlC2xDfeQnwO+Tz/a0c5JZ6lU3c2m5MehsyLZVRpyrYjeN0LxbR63?=
 =?us-ascii?Q?wz8Mf7XcILy2UcKsGC8/yibtz/PJptKCuAN7ZuWcBRa20l2gafVpgAau0Bxo?=
 =?us-ascii?Q?VM0VHYo27wpeAz9ckmZ3gfZDqRJhQZliPhKFeppIvmr58vk5geaaao/EbUMA?=
 =?us-ascii?Q?KewIBKsJ9OgumBltAl1W2e1KXMywo/527sXoyI7T6z3dx7nqDiR1S21b+ydZ?=
 =?us-ascii?Q?DRy/e+vLsr0OibK3EJtCeliEFhrXCiWywQgJxKFiBPIaRA0IWQF156OzX5Lu?=
 =?us-ascii?Q?IQAxln65I2T1PT2wkNF2xA8pGpVSAAe2WxRm1Wp5JLu9j/yK7OPCwU9FHJ9I?=
 =?us-ascii?Q?xPw5TO6HhRykIRBuy5AIT8mX3rTom+n1hMg03+dAkpx2lB4PYLNdyxHrOim+?=
 =?us-ascii?Q?5XbmJFNUJ+PKJ00aLv0Mj5QnLFrRehS0brfyRGsSnPgwBbQ0d3kiReBUgZgL?=
 =?us-ascii?Q?DPrX5nXA1o/g6aIicyliaYD2KgPfL09CIFsn2R09TA0vvIZceah/4MNwZqzb?=
 =?us-ascii?Q?ojCkeBlZ24xm8t5nkUhSGzNok0y0Xe5fAjFzE+tcxnX58Vex3QO6BgnfnY+B?=
 =?us-ascii?Q?U1uDemxhRSBBjPGoPF2uayXAd5XjZPdSl3Q9voiGWdr7sID9Q846BrhQfuxC?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4890f6-9e18-42aa-9ef9-08ddb88c6103
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:45:22.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXn3Cxve09MOQugoIxS+cZo0BPNarcwHx1unw3Wjepd7wR9YM76PkUjIOvVjjJPrv4tuQJycVMdxwZlOMKX9wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5599
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Jul 2025 10:45:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19270

From: Jan Kiszka <jan.kiszka@siemens.com>

If the specified directory that should be overlayed is an absolute link,
e.g. /root -> /home/root, mount it fails as we try to find it inside the
initramfs rootfs, not upcoming one. Address that be resolving the link
relative to rootmnt first.

Reported-by: Enes =C3=87olpan <enes.colpan@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - make sure realpath is part of the initramfs

 .../initramfs-overlay-hook/files/local-bottom.tmpl              | 2 +-
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tm=
pl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index 71cc63c5..bc5f0ea3 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -47,7 +47,7 @@ for ovl_lower_dir in ${ovl_lower_dirs}; do
 	work_dir_name=3D$(awk -v var=3D$ovl_lower_dir \
 		'BEGIN{subvar=3Dsubstr(var,2);gsub("/","_",subvar);print subvar}')
=20
-	lower_dir=3D${rootmnt}${ovl_lower_dir}
+	lower_dir=3D${rootmnt}/$(realpath --relative-base "${rootmnt}" "${rootmnt=
}${ovl_lower_dir}")
 	upper_dir=3D${root_mount_storage}${ovl_lower_dir}
 	work_dir=3D${root_mount_storage}/.${work_dir_name}-atomic
=20
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hoo=
k_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_=
0.3.bb
index a5b39d9a..a50a213c 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.b=
b
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.b=
b
@@ -45,7 +45,7 @@ TEMPLATE_VARS +=3D " INITRAMFS_OVERLAY_STORAGE_PATH \
 DEBIAN_DEPENDS .=3D ", awk, coreutils, util-linux, e2fsprogs"
=20
 HOOK_ADD_MODULES =3D "overlay"
-HOOK_COPY_EXECS =3D "mountpoint awk e2fsck mke2fs"
+HOOK_COPY_EXECS =3D "mountpoint awk e2fsck mke2fs realpath"
=20
 SCRIPT_PREREQ=3D"crypt"
=20
--=20
2.43.0

