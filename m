Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11362.1795689021983219042
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=AmbM+x15;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ng/fq2p8Qw4dHAONJPaNrSacW2ev0/FMaQWxKE0AweHVCIr4LvM0m4E6L+lcfgJf4+awrl3wb0IxfybgfTaj2G5YELqSOPFY1P8WLVMBz5z7ekHta0MiZOOakOQdKxroLkj4UsDpqEipZFU8ZEewdoLILHS5Cm0Ni9jQiZdT07Ou/JelihHciSMk0dM5DKxz4yCZJy/d3vteLKQ1oDPDsphIU8NO1tNztw+ZFQO0wEcu4HTyM1Ji+wbQaSfiA0HCC17jUHxSjgi1xbbdwiK0ajI+IdpajE30beNdiFIujnJcNj/B0HZ0dm/L4wyIrT+nCsDO1u6M5OuepR4xGFRoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0CHCXfpycU7LggXZdtkkPPxsh4Ohd5GVIGWmzb4v+Q=;
 b=QdHfjYc/TDjXp2JpX1yHjTc3VJjUtf23XXP0rFqpC8B5vzGX2VR4NstMzQdS9J8Fbd2l5GoDEiY/Y7nhKJTlXo8jp+fZOXxGv6HEDznV1b65QK+ptCIlzTWFpsTyDueisv0T0IKNYG2IzAXMoJ2lLQnvnbJijUfAobe/7cSpaeYL/ViAVGbHg2jMHrs5q5A3272JKSIoy/fvxsAi2t0v9kzeEySqH21jxkRq6bGcy7+gYrTGvhYr3UJBvpY9mCa7/Li+a+nYVAyCX1hje5pLr+DCj5HBAybkdRFpEYuEK2be3TRlRm6FbsODym0footLOhlTVIl+3XC6Evsn6cxXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0CHCXfpycU7LggXZdtkkPPxsh4Ohd5GVIGWmzb4v+Q=;
 b=AmbM+x15sGrJRVF47el+LJtZMvPT5CApR+lRMjMQ1DAfjDtJXFxZ17cZkPJCBgYKkoDBa2eRpFfXQGdhSIVRvKzg2fGCi4y4oSW8tguj5C4ohiePAC1LXYYvUEui6/tfMGYpzGzR38n0zpUYhLunkw54jjGan5X0pUCV1rqL2snHNnpfRWdj/4b+GaxkB4NB9flZfa0tQ+zyldufSfFD+MorBIjBrq7pwIVSb+YJC9hYMXYM0dAn4NC7NKdAcNVx4aTATbe66rnNtstXPwtOrsZ5DrcKyc25UZv4B4eQYZzAP62wpzWolEONakJ3D8y7C8lGuLkiBwxmCUs6m0kRkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:15 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:15 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 01/21] initramfs-crypt-hook: treat mountpoint / as rootfs marker for A/B
Date: Thu, 26 Nov 2026 11:29:47 +0100
Message-ID: <20261126103007.2922985-2-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: ba467433-64dc-494d-300d-08df4ba841e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261028144727099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003|261102123227099003|18002099003|6133799003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: c1EAu0WsHNuC4u65YiQ9GFd2PhnkcLn9pRKJxa5ZJgsnSiUqaynA38Zh5cIqoHy/iIcrF6T/VJV93eeEcZgBVpOHCYCGOF8/xvV/TN2ZrHsvPfK2exYDwkPNlQ53ZyFBL8Ux5zWWQcm1wA9iQLVewC4SDrH3THbJoSGUsvwCA7Ga78IG2w+JSCArntBxl+XTojv/wKf1lLju2nQjr06Mo8oWCY4vAlHK6UAGWi9i+9Qf2nJX5xnsLMPh7squitW639bM+NEHEOkp40mem6Jjz80ybQqpQLj7YdnsgLFpHq1xC2I+RxyL+ZR5SJ1NlhO5hJVMRzYRzmjdqxaukcCGM2WLpLRaHUa5ewgogVb0q0RtX3pWIhDCcClLuMUWogkghLyt4cbijG8xzuYVMeBUf3vYxvr9HWaG3FR6lDhCEkQkX86r60wYk9vtzeKVN6txK/LhUF5mMZ9tzAQHJVB22+tf02ohVv2J5YgNWFoew4mpy7cJ7Y4MauCIcMzCz5BytWIhKZ92x54Yf4SkKsQSglItDWd14HkBLTUNMyTAyOpSus/YgLO7wnLriv2XDMgMeIoV2ceZGXG9XwnJlBW/a2klkX7DuNC9VjvnxMVdbxbffb2CZq5IEjl8ctmfMEGMk4udf31sYEi8ehMlVtzY8AKiz4WLdDSU2+xWIZrYSEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261028144727099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXcf2QkSO4ER/La1rmxqirhI+o1cliEG+rj5OF7jkQnbQNqnvn7R900KY8ll?=
 =?us-ascii?Q?E6Zop3OPEVG1ldEwA6OUfDmDXm5wb/4AMm+wcPeSXC7t4jT4IDEXjwxWxrVi?=
 =?us-ascii?Q?VTl9kpkPHRHFtKnoQ06+QqIdp2Slb3ut5eT4xH1AkTxWoAGRVld7Ta5QTBrD?=
 =?us-ascii?Q?8ZX7+YOF+ElPPRXDaKRa0nXt1HIKpj1bp2vJlx/a0EzPMOLkHBFWUMORRZOt?=
 =?us-ascii?Q?KbWz4dJ97EQhDifHHaxFGoJ+GpdTewV7DhHL/fi8lbcAUUNFzVZ/JH8BW38F?=
 =?us-ascii?Q?4Xf8n4QUaYpctPV1aFHQU9DaT0eIrW5UGWrSBm/XmnIGVOBLwLlAu4dXZ67a?=
 =?us-ascii?Q?x+gciVaLdM2I+xJfA5oTXwnB8UfC1wkPsavbVL60KuDMoqgQjVqbM5LK6mjO?=
 =?us-ascii?Q?T301h9vfrDeCk4F8BDdJf3Gp6Dsb+8mMZ9jOzMpIG+YrAQp2fbVpH2cSD28P?=
 =?us-ascii?Q?W1aT+XvL3B62IJYrhw/6R2I7xT7aK6QSWV+OhHt354ig0qeU9FdIb5NECKX6?=
 =?us-ascii?Q?6uzfIlGTfNtApD0081waDmhM9Kz4JHPghpZzxJhFFXDKqorGXMDDtc7OlbRs?=
 =?us-ascii?Q?c/VBBn9xj3n6W9gE1W2boXF81LJgadMhEjIz4ye+Bve2017/4UImgHgGFrin?=
 =?us-ascii?Q?dR/e75zFHjwAEEnd/iAfSMER+jNeLb2CG7vLW5PZJSWrhtANYuPb0HOlcJm7?=
 =?us-ascii?Q?qNy5bNNZtM5COL9gdomLSxs/Kj1HEOsCV5nnIdUip+Bi4h9FK4ISm8jXQPiB?=
 =?us-ascii?Q?//3I83yQ2JJjL50GDduUJPRxgmyTBEN9410QgzwnhUefrDVTOOXkpH24svsA?=
 =?us-ascii?Q?MP721xiGmRzoDX3AqgSEcaCZK6OoRnAJFgvDy38liVSRXDMU9b5UpJHCbOtO?=
 =?us-ascii?Q?AzzEfmwzX8C+M+wv61zhTxjQR+AJFSdt1sLq5SsuNcJKKSDJxje7v0oM5/rP?=
 =?us-ascii?Q?uP/+K/xQWLTORQwgXZNI/jQyFnr2k9zbdhrqA7uK/WBPhyWytPk5TrHiDLK0?=
 =?us-ascii?Q?w/1rLkG5Lln3hhJ+AlrmhwBnEWuc+cd7eGez13P5uH6Ddn++bSnrWaKCWyjZ?=
 =?us-ascii?Q?FerH6qq/k6EYQjdjdK1Vc3smV9zquu6QpIdubUqlcxQCIjpFVT0Owrla5vLl?=
 =?us-ascii?Q?qeI4no75iweNEGuEh+smEQkVwCo9BafJriw3MLCoNFePJNl4RYspv+x6oU8A?=
 =?us-ascii?Q?KDavehXAF764sJJ83jCPTygPx49WN2R5JNOM8jhCP6xvJO6foeKBAga/Blhg?=
 =?us-ascii?Q?GTm4V+aAOCFHyeSzMlsF2imxv2sPdr7DfmTSb4MaEgALSFrfzPEaoZyeTCmg?=
 =?us-ascii?Q?ngFZkuzFMWrW0gcK7Tzs71tMR64Sj9iVDq+WMcMV2xboPe5S8+921IKUP66E?=
 =?us-ascii?Q?osd8zfISLGm+2ZHRZmyjaZFe9b/1coo9ZXjpcTWH9+6GBeX7yuuFTQ9xYKQz?=
 =?us-ascii?Q?kDKSmZNNH+VMhMuQ5Acckul6ClQHa0xrwQ4QOy2Oz9xwujflXWAetbBdMmK7?=
 =?us-ascii?Q?eUPuwxx0JS1C8rWOWYuiazz9RY62+NOci2HKo5s0mqDVyRaSUQQrAfBK09te?=
 =?us-ascii?Q?gBwbUniYsUsD0YEZnzi6u42FKcbvwx74c4XxUD3mA0a6B2HGqDDzE1twKKsC?=
 =?us-ascii?Q?Os3GDMmKTi+/IQYmjoe9+zG5jevTHPudo2IIKTaIri4NwZzVFA/qyMS2IDAB?=
 =?us-ascii?Q?N2lyyd6KXsd3VyqOrRITCXz9OAZNgMVLK/5oNzNoOqBQFZPwySniDtTLmCgg?=
 =?us-ascii?Q?vTNF1OsAcnalgXtM9uMpSU4f8bb3ozI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba467433-64dc-494d-300d-08df4ba841e6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:14.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0csdfkjLkEhDRFmbaMvNoLzj44QgQ31aSnVBvsfemi/EKBP04KCfkAHErEdzJB8dLmt+Z52InzVkGTbemvUKMPaUTa62UbWD1zp+zObcD+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25088
Content-Type: text/plain; charset="utf-8"

An entry with mountpoint / marks the partition holding the root
filesystem. Do not mount it in local-bottom and only point ROOT at its
decrypted device if it is the only such entry and neither abrootfs nor
verity selects the root device. Existing configurations with an empty
mountpoint keep their behavior.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md                 | 19 +++++++++++++----
 .../files/local-bottom-complete               |  7 ++++---
 .../files/local-top-complete                  | 21 +++++++++++++++++--
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 209b750a..09004736 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -62,12 +62,23 @@ Power failure safety: Changes to the partition structur=
e or file system super bl
 To encrypt the root file system the variable `CRYPT_PARTITIONS` needs to b=
e set to:
=20
 ```
-CRYPT_PARTITIONS =3D "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_U=
UID_B}::reencrypt"
+CRYPT_PARTITIONS =3D "${ABROOTFS_PART_UUID_A}:/:reencrypt ${ABROOTFS_PART_=
UUID_B}:/:reencrypt"
 ```
=20
-The mountpoint is empty as the root partition is mounted by a seperate ini=
tramfs hook.
-Both partitions are encrypted during first boot. The initramfs hook opens =
`${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
-during boot.
+The mountpoint `/` marks the partitions holding the root file system. They=
 are
+not mounted by the crypt hook; the root file system is mounted by a separa=
te
+initramfs hook (abrootfs or verity). Both partitions are encrypted during =
first
+boot. The crypt hook opens `${ABROOTFS_PART_UUID_A}` and
+`${ABROOTFS_PART_UUID_B}` during boot.
+
+The crypt hook points the kernel `ROOT` parameter at the decrypted device
+only if there is exactly one `/` entry and neither the abrootfs nor the ve=
rity hook
+is part of the initramfs. In all other cases the `/` entry is only a marke=
r.
+
+The previous notation with an empty mountpoint
+(`${ABROOTFS_PART_UUID_A}::reencrypt`) behaves the same as `/` with the
+initramfs-tools-based hook and keeps working. With dracut, use `/`; an emp=
ty
+mountpoint marks a data partition (see [README.dracut.md](README.dracut.md=
)).
=20
 #### Encrypting the shared partition via an update
=20
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-comp=
lete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
index e1d2f7fc..648500cf 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -71,9 +71,10 @@ for partition_set in $partition_sets; do
 			;;
 	esac
 	decrypted_part=3D/dev/mapper/"$crypt_mount_name"
-	if [ -z "$partition_mountpoint" ]; then
-		continue
-	fi
+	# Empty: not mounted. "/": the root filesystem, mounted by the initramfs.
+	case "$partition_mountpoint" in
+	""|/) continue ;;
+	esac
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" 2>/dev/null =
\
 			| grep -q "luks2"; then
 		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index f5b1c8f1..d26ab8fa 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -233,6 +233,23 @@ prepare_for_encryption
=20
 wait_30sec_for_condition check_partitions
=20
+# An entry with mountpoint "/" holds the root filesystem. Only point ROOT =
at
+# its decrypted device if it is the only one and no later local-top script
+# (abrootfs, verity) selects the root device itself; those only accept
+# ROOT=3DPART* or an empty ROOT. Otherwise "/" is just a marker.
+set_root_param=3Dn
+root_entries=3D0
+for partition_set in $partition_sets; do
+	if [ "$(awk -v var=3D"$partition_set" 'BEGIN{split(var,a,":"); print a[2]=
}')" =3D "/" ]; then
+		root_entries=3D$((root_entries + 1))
+	fi
+done
+if [ "$root_entries" -eq 1 ] &&
+   [ ! -e /scripts/local-top/abrootfs ] &&
+   [ ! -e /scripts/local-top/verity ]; then
+	set_root_param=3Dy
+fi
+
 for partition_set in $partition_sets; do
 	partition=3D"$(awk -v var=3D"$partition_set" 'BEGIN{split(var,a,":"); pri=
nt a[1]}')"
 	partition_mountpoint=3D"$(awk -v var=3D"$partition_set" 'BEGIN{split(var,=
a,":"); print a[2]}')"
@@ -264,7 +281,7 @@ for partition_set in $partition_sets; do
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
=20
 		# check if we are trying to mount root, set ROOT to decrypted partition:
-		if [ "$partition_mountpoint" =3D "/" ]; then
+		if [ "$partition_mountpoint" =3D "/" ] && [ "$set_root_param" =3D y ]; t=
hen
 			echo "ROOT=3D$decrypted_part" >/conf/param.conf
 		fi
=20
@@ -288,7 +305,7 @@ for partition_set in $partition_sets; do
 	fi
=20
 	# check if we are trying to mount root, set ROOT to decrypted partition:
-	if [ "$partition_mountpoint" =3D "/" ]; then
+	if [ "$partition_mountpoint" =3D "/" ] && [ "$set_root_param" =3D y ]; th=
en
 		echo "ROOT=3D$decrypted_part" >/conf/param.conf
 	fi
=20
--=20
2.47.3

