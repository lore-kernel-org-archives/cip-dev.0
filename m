Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11364.1795689025514145378
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ybuY6PkZ;
 spf=pass (domain: siemens.com, ip: 52.101.66.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx/G2BWA5rZjBliBMfNZ3i/XOP0O8Fduxo5ZXavdzqGG/4MK8NtgTUZ1+BsdQrcgq8nGBkZdtPoLKcqGn+i3WE9PGIPshU6iYtpvoj3mX/n1iiPgS0L3gepRqSJYiwTELOvZgg/ggcF1yCPksJkqQOBljvVEXpGwk1vEuolYV5pwA3aoE/B0b1DNiCwhSseU29eDRokvC3fYkaOvw1ZYQZO0eIIHAh01dSQrYQ2d6fx3/mixZbL/Z78TVCAREOkPwskjpk9b4xkA+oE+vySTbso7XifOjMVCkHInm4nOWhFQjfyVpd/RsBRM2YYU2r86hWdnPifesgwEpUOAKKo46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pO00/Ay0FQE/ePMankQFaKcC3qhN+oA9hSI7VoHoGU=;
 b=YkBf/LVgjNGAm/kihp1R181nmeG5iv1zfStYpeVSu9eRNaLsdozwoVQdY0TNPgPcS3JAztNzgsoeEMdqDDaNdFsp0phAhuAF7SksnBxV2OKwewhzlP9c6P3sC+3lCHykgHNhc7n4tHCXaf4LqEz38wbqpBnSj94Ku9x3yU50Vwf/mmZckKOXK7NZ6QItCzdVBjN5o7cXl5E8+hm6vNU3NwDhNsHfs6mU/g6r9DNsG6Dx6x3HHeElkH94ALFnsA35OmVtX3eD5sPPdc2qTxPCpQqTsXkhJsJGtXqKxCjiNI9ugRX+PYeO2PgjtttwPLG+2t0s4fB9M6e1t70F/q+X3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pO00/Ay0FQE/ePMankQFaKcC3qhN+oA9hSI7VoHoGU=;
 b=ybuY6PkZXZlAwV9vlnKm0l+mqLJgK+MFMWRwoh+wgcOTGGml0U6gXkUZGelOE9pwUjFe+UL3CU2TSLLIxVguRcRT0JXOqYyQSXafOwF2H2bHmZxtv9T/eW44zlEJ+8fx8gJW0UCoKA8Rn+OLX4GoVt6YpmlDEjgeQ24+zGcSOKDAXnQdpj52dWcH5cq+fkyv73vbX07tZkxlPdT2IX1LnENvzu58UGIu6/GCuXCtljUAzAQAfXh9xEKXrrQNpC91SVpW58mobrUTyLCGt4cAmBWp7vwFhAs8fu+O951Cl7OFMycitTGnYFUrdf83z06TXp7TO6MHj0VMyUwToVk9zA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB9591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:61a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 10:30:21 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:21 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 13/21] efibootguard-boot: disable the dracut emergency shell
Date: Thu, 26 Nov 2026 11:29:59 +0100
Message-ID: <20261126103007.2922985-14-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU4PR10MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 135b6a94-7900-4901-1595-08df4ba845c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|55112099003|3023799007|11063799006|261022115727099003|261022075727099003|56012099006|261102123227099003|261021135927099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261102130727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: W2qILQCqyyvOZe5axI5nQm3yZDwNa9R2XNdJ6Lfva8mK1hSeQC1gCNMFbEeirE2IthBNBEBoLWPXIAS2m93h+OnLMAltZ0dpx1lyXrgMRnccW6t1nsDemSSOoilBBjWVZlvl90kjAQ8N/sTL6g/qDprSytvxVGYzbACfSBmiG9/aJddiwQ9OKDf+9hbNX4AtezTOOlyhg0xuLFYV0dRrUw7S/SUaJu0I5cFQa1sx19bI/GZY+F/1TfBqqEuG8NCdw6nHno7HMiXdR+kYN7Q6mqY+t9SQk1Zi3857pJ5aLJXx7F5Kqa3m57Ww+eEoJVMm20EZKVb+zdQRWTBV4Ua8VK0Od1FgHAr8WB8ukDIC0W+AqM01Qzj4BI+LUnX7jUPJJZe02OhBXVvJWbdq5rQ4Lfq5chMLuvaV3IBhYKE8u7gR04q455UUZx5ixGoEJqm92MslFkU6mE957EANz3By8zLZKS1prhZtcG/1gCboVA/iZfeX03d/KNBsK1gzwhwLn+f/zp4OJ7OGmDRNPUDwU24qbiCrFixZHwZTtfguS9a2SHgyw645TSvdK6S+NM3Ji2Rl4t/NYnGDWU5LgVP9uXmy98yAWkIArZObNDxjJLf8uuMtAWBMa/wN4OrTAHFWUgtTyealCuvERV2i7RSIobXEjheVzeAoXOx+AIWpYUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(3023799007)(11063799006)(261022115727099003)(261022075727099003)(56012099006)(261102123227099003)(261021135927099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102130727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jr8naacA7kGgo/JNW0QUUvPMoj2RkVUNhuLxQ36hxVVrTALsexOf5e/P5rDx?=
 =?us-ascii?Q?zLaTyxIg0Ox/PbVbF3v9M/hSmA8ZBWr5mbrgK+H+xtdtaTxcAzl3ISeiUxnV?=
 =?us-ascii?Q?0Dglf95mihHeyQtoSDe4+Zw1UCH2Y/AZ/JJemmQ0fD2AeChi636R+a6aFZyX?=
 =?us-ascii?Q?EvHRWnPjSKr09nG51NRBP/64LdvN3a7K1QepCo6JAaoLMgt9sVxZ0hEQOzLT?=
 =?us-ascii?Q?tKu5+Ul1weoWD/NjwE83JXcpDxV2EpJyKQ+F7p3Isqe2aRkKmajWHAQaA8oI?=
 =?us-ascii?Q?biLH1FNUvFgC1LAqMKnKeQ6kJutErDL1gY+1dO6C9sLLuVqhgTImfAPqh5J9?=
 =?us-ascii?Q?XE4hdkBJb+y/9Zl1Lz4BvopcenW23UUQhtgQQWS1btrovdFwUGFIYHsSGrJ8?=
 =?us-ascii?Q?nIhshk6F2+VFqgo4EkUZMFC4I6RTShoY2s7XtfejCFjZ3GvQRHtUB7wqltCA?=
 =?us-ascii?Q?GubS6bYCe+0G1uM0an6xemiMi6y5vvBcvMejRVoOfSpNsG2bfpu0UT5JZ7PQ?=
 =?us-ascii?Q?zBLQFYROm0cuttS81MkcTcvivmIK89GgT1nHl9dBA9PR1+6fjFg4KgtmHJYU?=
 =?us-ascii?Q?xdmugY4S2qlHrNCjT4hH3U2IamMa1Sln5D9OjmA0TiKJYBKDHKHsjfgNa5HO?=
 =?us-ascii?Q?bdJKr4FZVF6y3T5/5MfSazv0dU6ng4ltHJQJcG54G1IgAHSCwbaK3HfR+BeD?=
 =?us-ascii?Q?xVSnP4Dcv477ymPenMLdOnI+CMG5yg1zC07gdY6pxTwMzGzpy/Q788xdWUF1?=
 =?us-ascii?Q?BWqN253reBkj4xGB1hZLWBihV88m1aVtdla/lWIHKLjbfnwnOV4Q/u3FrPJX?=
 =?us-ascii?Q?MEJgoJ49z9SFDdANC52QDRHtXLJjp4I8G6gnaj1NgJIpPLJS2NE/BaTYofO+?=
 =?us-ascii?Q?KmYRFgVcX+PqQlSwDS9MFsWUJ5TZ/vsTKzNZ5l9Hi7+fyKeRsU1b1swHKmkF?=
 =?us-ascii?Q?tnvmRcpEWk/ghAIthkWzhmwH36/4KwUkkRM/pAdCm5QafVAOuzcBGom5Vlge?=
 =?us-ascii?Q?rc0a6vMP1eBzmNDBMyZs4xdJP/UlHXccKNrJQDZR6CQ2/SQsbrpyCpj15BQ5?=
 =?us-ascii?Q?FumWGIPgdyqeOuwUR9mjfY6pWMYufFir2llqvbnkiwXVc4j4JVqn9MZd+Ebf?=
 =?us-ascii?Q?I/7QzCHobyCuUrd8m3XAbOVPA54AFWp3Dt1MHxPFcbleqDWEW4+Z3kxiz1w4?=
 =?us-ascii?Q?ZhoIrECbZWmomBw6GWTyWneP83ME8904VJl+E6d5zp/E4iVUdRu7BSKIj5jR?=
 =?us-ascii?Q?FlX/sn78/5YkkYY5OK4WeCoFXYWjHtovvul5/4QKUQ6G+wVUotzRgK/k8K5h?=
 =?us-ascii?Q?WeGnBOQkLt/HtAHgpGqdOiw0XWbxUYc5isYtT1F1NMCKAaY7XFriYbKjC7bm?=
 =?us-ascii?Q?XpGyUjj8dtpbRPds9uboRiWUgWm8i2SCuycraNJFs+HHjHk0xUoaoWEMtJTI?=
 =?us-ascii?Q?s6VbiLSMtxlriX+z38oGkM4BJgZ6ZGYFt6q8F/NX3cbZ3GQJsTpU+UKtyp5p?=
 =?us-ascii?Q?/0sGOW0F1/8+aX3EDSGxVR+67zJq/yp3j/UgpjH7YscHhxu7voOR5oeyJZPH?=
 =?us-ascii?Q?VX/u8zIYt/V6LFj4yTpO68X6RvHqwOQeYOEDBQF3Zra70fGOW1WpzO4+PyVd?=
 =?us-ascii?Q?CCBXj7XJoqBph95aJTvULS4kOYoYQb/FAcG2ZFyAcCIigpg/YsWV8wP2ZnFC?=
 =?us-ascii?Q?rwRxualgLubIEu6wa1sHNA3tUrOkvJwTw8lhWVijMyR7RLsOfyDvpeFTWDN+?=
 =?us-ascii?Q?5PQ7XiwbZvR3Nc6IgXW0l+Wodo5qKUc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135b6a94-7900-4901-1595-08df4ba845c7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:20.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3BVhO0bKQyQxlK98FOzA7i1OkuE3nl8Te9hM1SgPoZbnjnLj+g+VXIKOkmi5bEof4FQxBCqRmywTDD0EwjXJu+2mMdurRXxymyr1nxgmC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25093
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
index bea339b5..0c30f131 100644
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
index 1259c89d..e87b8610 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -259,14 +259,16 @@ class EfibootguardBootPlugin(SourcePlugin):
             raise WicError("efibootguard-boot: no root-hash in %s.verity.e=
nv"
                            % cls._required_var("IMAGE_FULLNAME"))
         rootfstype =3D cls._required_var("RO_ROOTFS_TYPE")
+        # An empty variable is not exported to wic, it is unset here: no a=
rguments
+        emergency =3D get_bitbake_var("INITRD_EMERGENCY_CMDLINE") or ""
         verity_link =3D cls._required_var("DRACUT_VERITY_DEVICE_LINK")
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

