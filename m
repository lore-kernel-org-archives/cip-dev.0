Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15531.1794914931770418210
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Pr3LiCt3;
 spf=pass (domain: siemens.com, ip: 52.101.72.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUW9I6VJGxFyGDbnQ3Oa4GOE7XS+S9jUAX2zBeWflkyg+bZ+4FJ2EQL9cI14uXdsCdDJoGCUS2gqD/JohxoBDDnNZd+P4I6uJ/zm+wqrmvsdOMhdw6Xsr78gp8WSvuGoapiEIccxZ4dV341L24bzL8MFP8jY8yCDUREIq3cholEg5cTGhF8K0Q0MMGUD7NeP6VOBJQfrDkKD2uLTRaSB11nnbS/WO4i1J3eEvGghA8pgsdOZosKyIMqwAFeKCvBpwy7y4Diy/jVOsn2B1ILRPP93GV5x/mZ/lkvFAel8ZPYsdduu2Lz1umSPJFjH2nPjADuuZ1HR6qrworVCK9F32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//uMIhFfkmOZMyAcwvY/+czo2z4MVK3jsP+8yDL6/9c=;
 b=BB92tgspLwyX8fuSs6o09m1CUV0Jc0S0F2Um2+8WrXMmw9gI9lA67InsIhzOT02xKbzVMgCkvhJyoTP9mqX91hSAx6zTt5PVhEFpKr0zYn+4dyV69MdFB7G/aaJpPszlvzKIX/T9n2yStm11xQ4VosoNzfkyC/Ce9hr+7OquNQTNWybqaKyXed9l+BJHOO3fM8RnsLq8sEaqhWR1qszfJPGr6CDT7YGuhsR69QOUI93jpV7Q+3dscltsRR85bG63+rBR/V6TXhgUIvq/SdM4MbSp+bIvFgWF+cZiwkNr9Va3GeAOFBwdsblRZIlhrJwlX2192arJyuoxaP0D4KJs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//uMIhFfkmOZMyAcwvY/+czo2z4MVK3jsP+8yDL6/9c=;
 b=Pr3LiCt3xGMEIo46FEs9c+Blv1m3x/23Dyc5DDSOspOfCbHEhCWOd9aItmeu4cWKQbSisBgi+xEDpN28wZ1OQz4w0UnnHD+FDTYb97RqUTGmv0JiCgIUiHAToQZABGsyUrZwPKfWTHBlF8tCgGQt6X2BU+mVOKKfkbDVRUiDgigpxG5wTArYylgBKJZekAabhCKNihaRzAYdjng4hf9+t/bRahEoCVx/ajMC1ZSV9ssfLdYKnrCiLTQrEF+WueK5p6yyC+TIfAsL3cOssIsso14vja64JpgotWWIYEkrKeXgyEIQtnbKbvXf0/VkeHIDMs7ybYvkTvCv72l2y2DRDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:48 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 13/19] efibootguard-boot: disable the dracut emergency shell
Date: Tue, 17 Nov 2026 12:28:27 +0100
Message-ID: <20261117112833.316234-14-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90eb3f50-7a75-45bc-8eac-08df449df1e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261022115727099003|261021123027099003|261021135927099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: SaMXBVeYCQ4L0frAWt8jBWMOwqr1HyAyEjFOOQglkr2GEIZA7KnFjk2+xX16ZtI3eWTFWedZYEtRTc/jaZ2ym5AjYonzsrimCj9zM6H1lvJRROVsqu8w6z2y7rweCSHo4HdPo47Q3ZRwQrB/7XF0aMeP/hyZeFPdWT2Pw4PZOGATdCrrTpE3OUQiZ/R7cAby98v0u2bVhaj94oulSJvRjqsGth2rOoQq3grrEp32UDju8CA1Mbe/JEhyk25XIg0Zpn+Yi+D97zrezWYolRk4DmjrfmWmVRTkdp21kEV2ILiLXT4I9JM8VEHsSn/Lm3050sGdCUUeoLL3ZftCJuqr78pQgkqFsEPbxYUXWfQtq4IwBZi7dxOsBC26yBlWWCrb6+amkv71sz89icAe+rT9FIWd8RrwT5gb2rgTH9dBLARTkURUvgsAvMId0nJLEDY6TqOPQTKN5qEDul5CEIrUG7r4s1STiddPduVwYx09Y1w5ZQTcyR2nEcO2RzrYP4FNvVd5ChhB/n1IeCzku1dAW5d6++CsMXvmQkrFqyd96+hzvA6vQaGHWBd6cg3+fh8OHePQpvQtX0AWe0/hsMbHR6Q7ip+C65gPYfj5xWe9kXpSdbbWgRyKI1Jsm/Geo5TEQ7Kfx50NNGNrmmfzfErDcw/kkEdFQ3XoAo5vx/JOPC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022115727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14NJuneFDjH0iGtaMSAZd3sav90jypKj23X87sQ/ZEepzfUtci6L0G+SYXFn?=
 =?us-ascii?Q?1b6wCMPpF14ixN7sW02xkLaawqoNCPr9PpIO+E/x8I57Ah4iNvP0B813v4De?=
 =?us-ascii?Q?9nlhvoqpkKGsA2ASNDsI9quCE1/88OL2BktmDRGS61DRQb5/1GbP2d7YoRKA?=
 =?us-ascii?Q?Fa1Srwp0u0hKef9mkI219Wu/P2tYJkWfuwvaoxdLKbDZgkHdmIhPN9RsgKTP?=
 =?us-ascii?Q?5VL7MbhiG5TE61vVqhJP02WrzLjjDHkOAWC4AS0D1vRNMTeRPxTF/2OAHrq5?=
 =?us-ascii?Q?vjUWKzIfI/JXlyXleDGlvGdrS/QcpFE3bBv5voRpIIW+GJpsu1zmRkmWpTgo?=
 =?us-ascii?Q?Ulj1OqxjvWCW8fs+d5pHn3k9tJfpF+J3d2rxiRzPTMbewaEFUEZbxXNJUvfP?=
 =?us-ascii?Q?riG7eO6L5uup+PYILZSMwwVTvervape00qd2yufd+fBjllBZC7rDd5nWGFQO?=
 =?us-ascii?Q?TaQAxx1t6F3EckzfQCArRdV32fYG0O9PbTd7E8I3HPYM1BZzbi3zkw1WBman?=
 =?us-ascii?Q?aLcKDONtI6wKS1wsSyIfEy8Mr7nx5+AmJmG/ecqe1fT8W7ErjOdD6oEkLZMZ?=
 =?us-ascii?Q?CuVju/nI5oZjsTM23iUzECyY3sXw/aTtFHVhcgebUNNjOxQiHoGeCAfG8d4s?=
 =?us-ascii?Q?muS2KGtmdsQhnLa7ymFC2+nQqDV/hGqbkrFlnbM9LvYWB+ulJcZHYm8U/tla?=
 =?us-ascii?Q?ZwAeG2LYYXggjY8887Y8xXhbt1ZGSfYBdMD9ZrKnw40zLwLZ5PtaM7GIn9Mf?=
 =?us-ascii?Q?JaWaTZIPP2LryMJ3PWhJKPShJszLKDrbt5j900MA4SppZ/HL1qXPJiTrv5bv?=
 =?us-ascii?Q?0q2ejwkUPRLxt3hvyRcEjL61CF1wfd6ZoC8DwEkwztABOiD7pK+xnXcOfpSD?=
 =?us-ascii?Q?VLmcYZtUGzN4ZaTOsqLjPCSklbxpIyppFU2DbqnzC7NM4BrXLfpqZgFcwZfZ?=
 =?us-ascii?Q?ewR/niRRkg67pib4YAWkqZngyh1jSD8gDwM97ZfbEJcJidpga5Cy06wV8VjD?=
 =?us-ascii?Q?YBqNYyM/aQgrh0HaSb0osuM0OntM7LtE80u13soyJNDES17XixlqQCd7drpz?=
 =?us-ascii?Q?WlRTPqq6xd3AJIH9ptGL9hoccOkH9LXJiwmmYsHRaIRIXNvp+XgS34+LssF+?=
 =?us-ascii?Q?0HfOXTPGM2FoQi5CNW4GoZuTcgnPW980d39Dy+kyTpQyQXYUYN4INwufbaWx?=
 =?us-ascii?Q?OR5xWAB6YpIiZ/AhJA8F/Nt+Dd7qd4GS9bEChtE/JADwaMYnt/GlPAn/1JmE?=
 =?us-ascii?Q?qIJCwSOvIe1hL5SNucJGHJLTbB4mBW9bmkRKxok7SnMb08g1pTdbe8xqfaQe?=
 =?us-ascii?Q?wKSThpGFhC/B/NAwiYTOjiELDFIkqscyINjh3bWtYnVIL7FixZpi90/7MlFE?=
 =?us-ascii?Q?L7SUxDR6/HaPySOc22mYKZ7I5gbIGhKHLd03mSiU7FsvItO7vtYYvj6luQej?=
 =?us-ascii?Q?uHw81LiAIU/qu7ww0AfrvKWIj3tz1QWWS/lOqwYgwfCwVp4IMfSFpmamTRXe?=
 =?us-ascii?Q?6crBZ4he68rInsChhkRchtkAKwepSwbZMmnmBb13+vnNFYd/zjcRer2eceSD?=
 =?us-ascii?Q?kgjP89xsuF7KeOipXxODKk/ose0wiogMczY5G3IF8F5EjGJ+weskpcHyKUV/?=
 =?us-ascii?Q?GV7owJ8pRmobaKQXgFKwnJGrwew57gDLUSW+N15YumaLUNECBCAckx74ojj2?=
 =?us-ascii?Q?J5GsfYIz//Iav6sQXo1VvMg7CSBENHDC2uYjZcNMDt7T3LT2a2IBol+HX9Bx?=
 =?us-ascii?Q?roPpsCnfL5qxOG2zdZ9EEH6DooTClDg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eb3f50-7a75-45bc-8eac-08df449df1e3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:47.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swjgMb2+UDohW9gecxwE2rPqIuK4d+7f3OedKHFElqaqhT/xVbvjYBCL89JAckHOooV6uG2I2dp+oyb3c1Ov7+XFPTAPCL1GGnizhyI7Uz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24834
Content-Type: text/plain; charset="utf-8"

When the dracut initramfs fails, for example because the verity root
cannot be found or fails verification, it drops into an emergency
shell by default. On a field device this gives an unauthenticated root
shell before the verified rootfs is mounted, which circumvents secure
boot and dm-verity.

Add rd.shell=3D0 rd.emergency=3Dreboot to the dracut kernel command line
so that a failing initramfs reboots instead. With efibootguard, the
reboot lets the boot counter expire so that the other partition set is
tried.

The options are taken from INITRD_EMERGENCY_CMDLINE, so a development
image can override them, for example with rd.shell=3D1. The default is
defined once, in read-only-rootfs.bbclass. An empty
INITRD_EMERGENCY_CMDLINE emits no arguments: wic does not receive empty
variables, so the plugin takes an unset variable as empty and has no
default of its own.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass             | 5 ++++-
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index a13c3a7c..b40b7d55 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -14,7 +14,10 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
=20
-WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IMAGE_FULLNAME INITRD_C=
MDLINE_STYLE DRACUT_VERITY_DEVICE_LINK"
+# Kernel command line arguments that keep the dracut initrd from stopping =
in an
+# emergency shell. Set it to an empty string to emit none of them.
+INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
+WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IMAGE_FULLNAME INITRD_C=
MDLINE_STYLE INITRD_EMERGENCY_CMDLINE DRACUT_VERITY_DEVICE_LINK"
=20
 python () {
     if d.getVar('RO_ROOTFS_TYPE') =3D=3D 'verity':
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index 0b277d68..2eb3bf4b 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -223,14 +223,16 @@ class EfibootguardBootPlugin(SourcePlugin):
             else:
                 rest.append(opt)
         rootfstype =3D get_bitbake_var("RO_ROOTFS_TYPE")
+        # An empty variable is not exported to wic, it is unset here: no a=
rguments
+        emergency =3D get_bitbake_var("INITRD_EMERGENCY_CMDLINE") or ""
         verity_link =3D get_bitbake_var("DRACUT_VERITY_DEVICE_LINK")
         return (" roothash=3D%s"
                 " systemd.verity_root_options=3Dpanic-on-corruption,%s"
                 " systemd.verity_root_data=3D/dev/%s"
                 " systemd.verity_root_hash=3D/dev/%s"
-                " root=3D/dev/mapper/root rootfstype=3D%s ro"
+                " root=3D/dev/mapper/root rootfstype=3D%s ro%s"
                 % (root_hash, ",".join(rest), verity_link, verity_link,
-                   rootfstype))
+                   rootfstype, " " + emergency if emergency else ""))
=20
     @classmethod
     def _get_abrootfs_opts(cls):
--=20
2.47.3

