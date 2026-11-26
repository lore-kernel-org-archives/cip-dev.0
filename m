Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11270.1795689018322784349
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cI1Fcoz+;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRNqghlIcgbbx5tfJJrexTtec5yiEnriQM3yhHClXqBlPv8DUI7jlb3XWj762EgaKxHyCGZVtvblf82TWC9FHiDAQifdRfodwNBEiM82vNXYhiYgPn6bVPTLIhq0lzZqmWAUyeoJjmBT6BSkJHrKK73hULLpHbq8l6HHbtvozUK6LgRFMXkRR0VThrOGxUldxZK3IqvtrnQEJl4bt+6CJBi286ksDmfFas46Gtl3pBhI94LRKwdHJBKsg6HJFO67AXhOk5mqApt7OsFT4XYjxUEOsOicw4N3QNuIzXkWFJ5aXY7GW1+6tUhxMeFYKITwClYIu/+6pI6+/+7B5Mvlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTuzRI/zgWWS37LpPQWBzj4wrMtI3QqrvR3scKWyV1E=;
 b=A8awNvR5lpqSwr+5hjR3279BsqA1abwhkzHNlYLO3rSV+MHkLooSsk9GOft3M7NkGVIXP8pToimXh9wsDSstpMveczavHJrhdtu7lZgSwrRb4i+StqNly4n6O8t4x+WV4IrQY/3q63890lNoKiBRdZTeCjJ+Gx67xxIMVn727L5QIho9E37OWtgB/5YlnFbMCbWJhswm7/Frk7f/+thyi0zF0hxPLXeM4KGOUv5CnP2EAYj98wJgVO2ta/WujbkcjcGJEKYWm9iggBnT6JUFN6MPc8GydVjArsBqgpPS/5sKoXMORE5rtkyOmyA4UTROgf57N8ut3TFB+/+TM97DVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTuzRI/zgWWS37LpPQWBzj4wrMtI3QqrvR3scKWyV1E=;
 b=cI1Fcoz+5YWJ404lsYr2v7kzWjM5atSuffSKXFAoqKOq+2hT8cE9ncPG/8kMPrkegnfLnReB6skDMOaDtStl7FJAc+zcq9yLdaD1vj+JwwcsdXZy5YOUJKMD8DzHo6nl1MlP7ROt7J1Zi3r5gvhd/UqjzcZWcNnsBe9ZKZynjs2td/aChVbLVw03+kvAFPbtJYT8oYywurJH2pTJrFsEQYzYJF/SMbjANzouPUC/9Wy5X1kCfzce2dW8gxhYIBbWw6zBFI08mZXgZ3TWSm0EHMg34MyY7PCZcorrl5NKY9RlBKWgbQhhuqq6v841Il51Z8UuGDfM/nctUx6NHqdfHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:16 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:16 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 05/21] efibootguard-boot: look up verity and uuid env by image name
Date: Thu, 26 Nov 2026 11:29:51 +0100
Message-ID: <20261126103007.2922985-6-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: afa7a01d-1d72-4fce-04ea-08df4ba84337
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261028144727099003|261102130727099003|10067099003|11063799006|261022115727099003|56012099006|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003|261102123227099003|18002099003|6133799003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: tZtwpnnejrvhZ4rvGHnLud2L2/uEVYC5bv0zIAX4SjDjicb8GtvheSt3Ep5qgLKjwjGkUhfBO1omBLklTT8yZATtyCBh6R3khy0JSpFQgMgS2WmoUMwczZs18OG4OL4PTNZJ0f3moAnuwDp7kGBgaAobpDM2yQlGj8ZMPJuwBhcJInoQopMTPNw1mIQGiARhHaRw9Y/4ARFaXTpr55YOIOYyLgbomMNCAAYGnh9DW+1mpi0weLGUQv1lCpNRUUhi0cx1BzQP3TF239K6H5xXV5SVMxcYCdBpSiRSIUNgu/fWhsEGg129IJqrsLpPmP0cB+fkjNciOTzI0ms17pxGUDs2F0u4LGZ00/kOeZBEpQjrpC6xXWtBLkJ03IoYAAcK9nNq9H3Wljc++whzatNsXOGThVcnMQ8IZ3aJ6i0tZKq/Gnt3P1JTOqwToHuL9HYFLq92KXZAbIBaYhrONwssRh6tgSPatajsWw7Pw3cd3A5CsFVMiTcnRxj0nvb9LwJn4qATt98LhkkWe7NBjhwCu9Sc2QnjXlb8mYN41z0sN/EKisDTKF+a30Ik2y9Jq4kYSgJVJEBlfD9WSejKc05tX4iZ7H05Z3SNlLGd/jRLiRFGAy5do5SJEe7a7mUC36qWbJ5BbF2XsdQvtVKOd4HsKvwyUw+4yIrg/w9tqeD1IJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261028144727099003)(261102130727099003)(10067099003)(11063799006)(261022115727099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iA6yHDLyqRI2/PGGTL8v95Ci8UNc416uXlW4lJLt9trRcDQ18FvthTsyc8to?=
 =?us-ascii?Q?Sy0IF97Ygv9L3cCTwkbr+KUwREcMV2i5zMdhUMgqAyReF+xVpkUayUkUIUuv?=
 =?us-ascii?Q?X0e/g1Pukqq5eaNEcB8GroPfs5ABE2qEMpMQsKcECh7FQQc7PEPd4cuOTfSW?=
 =?us-ascii?Q?Oydh/RgIuOipNJ5/ZsYZlO/9AHyDGZ4tbbEoFZPYcay4X4pxbv7oWkhGurWG?=
 =?us-ascii?Q?lpaEav3zF0CeY4XcjenYrQDlAdm58dgHclLNgsth2Xc+vMrLYkJYpY06lzx4?=
 =?us-ascii?Q?jX5gfmUKQGIJLG3hTHlNaCNYaMVxrUsmPKZ5Eypa9LXpkAzqf1cKAAfiaBQ0?=
 =?us-ascii?Q?/X19jHhHa3dnNFYsKQuTLHHYoM5asQSrYuJXZIQ7zHH95Izgfe6AVU3xbHQq?=
 =?us-ascii?Q?wlhXbGJ+j5+t+M+WaBo09JWPHgZ4BrKF67MFEMv29L/DXnKr93XdqVCGphwT?=
 =?us-ascii?Q?3KxfX3poQ3w9ratKo7itKmtumngwUxK8uExow5G7u/5CAdn0G4RZaaaUC6N/?=
 =?us-ascii?Q?5HZBGKaQm58CN8IsSfTtXeeU0B4yO+WOMRREcsq+nxtvws6Rlxq3EjaBh32i?=
 =?us-ascii?Q?EOiCI1DKzj7dZUW8FkFtxQMsflo4sHLqvoVHnSytpjxdU66tK9mEIMwTgsRU?=
 =?us-ascii?Q?MOs/STdcboeY8hH3zRBHgWoDVBEoFxWaSuxJ8noP2wsklLfq4E8giFQ+/t84?=
 =?us-ascii?Q?YTdUnkgDsFzk3VNMzXLGXZtBdzUDWQ7Xu2GSpAzuEvdqoX+2QDFuEogdIQX7?=
 =?us-ascii?Q?8QfrLxSvuaZ31jnzD9e2v4T9L7i9b+lbDBBxqELbGU9s431vALGjD8fscyQy?=
 =?us-ascii?Q?pRglySAMNWFjdwHAJYnc4JWCs8xspZbkJ5Qp7pbwTcijQgBJ/8zh9J+L9Fdl?=
 =?us-ascii?Q?brHC+4a0DzD0UXr/MthNPrtd9L/qCtdva5MNDAYAQC4p+nJfPSpnghfweHIV?=
 =?us-ascii?Q?vae3SRToHMIuUE1ZGZJ1C5MZ/a34n0JuSxx+c2zcqYVYx1atnl947PnmjXqP?=
 =?us-ascii?Q?Fnw5FQ7led/r4svLrueqlzh1ekq5VtZgT6L9o+rZQEaHJYpZoF5e+dYdBkyb?=
 =?us-ascii?Q?GkSghsqFDtzY4DgajeAmzvfVKXeoRSCp2a3ua/TFpeHI+Z5miLlY0Bs/H8kU?=
 =?us-ascii?Q?AHgIfH1WxceFIWbxJ2Kbk19futLalMKUSTQ0gGM8pyLZXbfboXK01y47oEtZ?=
 =?us-ascii?Q?ysGCiBfe50Thv4lxVIzRi3D6xOG4WTM/itKczGR4GP0cB3acW4gI1ioiK5dq?=
 =?us-ascii?Q?E5E8IPDsORzwGSXMKQ+GDq9wl0ATpIc0p3/4PljsJUWVNLTc9TFuOhZF4C/p?=
 =?us-ascii?Q?xLJ+nn1MvsW2liw8RDf5LQ+oQxcrE4e1Rb7y8ao6BZReJxkWCO0LYj/ySeOl?=
 =?us-ascii?Q?qDZi0TtDcF+tJYffnCk6DDmxmD8D1QzyqQ1C36H7p05FuGoD5Ww8wQfqXmtD?=
 =?us-ascii?Q?LXc2kzAkPhLCPndkKsm0SKZMeFgyHFWSgQplbt6RI9duVXwF+a/mOvP45bmw?=
 =?us-ascii?Q?GGW/9z/WP+Qwzy0HSpUyXF+NXl+120dvONg6//1AKuIeRqLbFZAtVbiK7d3c?=
 =?us-ascii?Q?df2KJ5FfB0R2AbKYBmrLqP29IptAiWqopsYwT92l5oW2F/jJCZUcGgsP6KgM?=
 =?us-ascii?Q?VKF07MewN21zNbHE3BBK39T6enKjgCswAOpE8n+yIeN+0cp5heqA4vSHxOMZ?=
 =?us-ascii?Q?aGLizumq1ZVocYLVMfuBz+I+ag1QdZT9LUUsbIf9K5IMV7h7bqETZY+rXps9?=
 =?us-ascii?Q?TEBSrbZJLZ3fsI5Cz3NVp+avvxNDmYI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa7a01d-1d72-4fce-04ea-08df4ba84337
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:16.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcs7aGpYE+2aWa5EzJCH2RyL04ii913UNbK66HumaCyLMyeygrolF8HhA/kpDLcrO3sO3R6/I1VLblreFSmlOzPeUml/Nlcgbs1hUmtgXjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25086
Content-Type: text/plain; charset="utf-8"

The verity and uuid env files were found by globbing IMAGE_BASENAME*,
which can match the env file of a different image in the deploy
directory and pick up the wrong root hash or UUID. The exact name is
known: IMAGE_FULLNAME, which is also what verity.bbclass and
image_uuid.bbclass use to write the files.

Export IMAGE_FULLNAME to wic and look the files up by that exact name
instead of guessing with a glob. A missing file raises a WicError in one
place, with a hint to set ROOTFS_CONTAINER_TYPE =3D "verity" for the
verity env file, instead of exiting the plugin. An unset IMAGE_FULLNAME
raises a WicError instead of looking for "None.verity.env".

A read-only image without a container and without a uuid env file has
no A/B rootfs. It gets no root options, as before when its wks file did
not set abrootfs_root=3Dy, instead of failing on the missing file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  2 +-
 recipes-core/images/swupdate-efibootguard.inc |  2 +-
 .../wic/plugins/source/efibootguard-boot.py   | 50 +++++++++++++------
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 0bf808d2..98d66774 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -14,7 +14,7 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
=20
-WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE"
+WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IMAGE_FULLNAME"
=20
 WIC_HOME_PARTITION =3D ""
 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs --ch=
ange-directory=3Dhome --fstype=3Dext4 --label home --align 1024  --size 1G =
--fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0=
f-58904f369524"
diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/i=
mages/swupdate-efibootguard.inc
index d85e8569..a9be514d 100644
--- a/recipes-core/images/swupdate-efibootguard.inc
+++ b/recipes-core/images/swupdate-efibootguard.inc
@@ -14,7 +14,7 @@ IMAGER_INSTALL:wic:append =3D " efibootguard:${DISTRO_ARC=
H} efibootguard-tools:${D
 IMAGER_BUILD_DEPS:wic:append =3D " efibootguard"
 IMAGER_BOM:wic:append =3D " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?=3D "60"
-WICVARS +=3D "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_A=
RCH EFI_LIB_ARCH UKI_FILENAME"
+WICVARS +=3D "WDOG_TIMEOUT IMAGE_FULLNAME KERNEL_IMAGE INITRD_DEPLOY_FILE =
DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
 IMAGE_TYPEDEP:swu:append =3D " wic"
=20
 def distro_to_efi_arch(d):
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index 22173d6e..6067bb53 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -30,7 +30,6 @@
 # Christian Storm <christian.storm (at] siemens.com>
=20
 import os
-import fnmatch
 import re
 import sys
 import logging
@@ -169,6 +168,9 @@ class EfibootguardBootPlugin(SourcePlugin):
         an explicit sourceparam verity_root=3Dy or abrootfs_root=3Dy must =
match
         the derived mode, otherwise a WicError is raised. Without
         RO_ROOTFS_TYPE the sourceparams of out-of-tree wks files are used.
+        A read-only image without a container and without an
+        IMAGE_FULLNAME.uuid.env (no A/B rootfs) gets no root options, as
+        before without abrootfs_root=3Dy.
         """
         explicit =3D None
         if source_params.get("verity_root") =3D=3D 'y':
@@ -179,6 +181,9 @@ class EfibootguardBootPlugin(SourcePlugin):
             # Empty variables are not exported to wic
             container =3D get_bitbake_var("ROOTFS_CONTAINER_TYPE")
             mode =3D "verity" if container =3D=3D "verity" else "abrootfs"
+            if mode =3D=3D "abrootfs" and not explicit \
+                    and not cls._has_uuid_env():
+                return None
             if explicit and explicit !=3D mode:
                 raise WicError("efibootguard-boot: sourceparam %s_root=3Dy=
 "
                                "conflicts with ROOTFS_CONTAINER_TYPE '%s'"
@@ -187,17 +192,29 @@ class EfibootguardBootPlugin(SourcePlugin):
         return explicit
=20
     @classmethod
-    def _generate_kernel_opts_from_file(cls, filename, keys):
-        env_file =3D None
+    def _has_uuid_env(cls):
+        """True if the image deployed an A/B uuid env (image_uuid.bbclass)=
."""
+        return os.path.exists(os.path.join(
+            get_bitbake_var("DEPLOY_DIR_IMAGE") or "",
+            "%s.uuid.env" % get_bitbake_var("IMAGE_FULLNAME")))
+
+    @classmethod
+    def _required_var(cls, name):
+        """Value of an exported bitbake variable; WicError if it is unset.=
"""
+        value =3D get_bitbake_var(name)
+        if not value:
+            raise WicError("efibootguard-boot: %s is not set or not in "
+                           "WICVARS" % name)
+        return value
+
+    @classmethod
+    def _generate_kernel_opts_from_file(cls, filename, keys, hint=3D""):
         opts =3D {}
         deploy_dir =3D get_bitbake_var("DEPLOY_DIR_IMAGE")
-        for file in os.listdir(deploy_dir):
-            if fnmatch.fnmatch(file, filename):
-                env_file =3D os.path.join(deploy_dir, file)
-                break
-        if not env_file:
-            msger.error("File '%s' not found in directory %s", filename, d=
eploy_dir)
-            exit(1)
+        env_file =3D os.path.join(deploy_dir, filename)
+        if not os.path.exists(env_file):
+            raise WicError("efibootguard-boot: file '%s' not found in "
+                           "directory %s.%s" % (filename, deploy_dir, hint=
))
         with open(env_file, "r") as venv:
             for line in venv:
                 k, v =3D line.strip().split("=3D")
@@ -209,9 +226,10 @@ class EfibootguardBootPlugin(SourcePlugin):
     def _get_verity_opts(cls):
         verity_sd_keys =3D ["data-block-size", "hash-block-size", "data-bl=
ocks",
                           "hash-offset", "salt", "uuid", "root-hash"]
-        image_basename =3D get_bitbake_var("IMAGE_BASENAME")
-        opts =3D cls._generate_kernel_opts_from_file(f'{image_basename}*.v=
erity.env',
-                                               verity_sd_keys)
+        opts =3D cls._generate_kernel_opts_from_file(
+            '%s.verity.env' % cls._required_var("IMAGE_FULLNAME"), verity_=
sd_keys,
+            hint=3D" Verity root requested, set ROOTFS_CONTAINER_TYPE =3D =
"
+                 "\"verity\".")
         cmdline=3D[]
         # fixup for root-hash to avoid an error in the initramfs search fo=
r the
         # root option in the kernel cmdline
@@ -225,9 +243,9 @@ class EfibootguardBootPlugin(SourcePlugin):
     @classmethod
     def _get_abrootfs_opts(cls):
         abrootfs_sd_keys =3D ["target-image-uuid"]
-        image_basename =3D get_bitbake_var("IMAGE_BASENAME")
-        opts =3D cls._generate_kernel_opts_from_file(f'{image_basename}*.u=
uid.env',
-                                                   abrootfs_sd_keys)
+        opts =3D cls._generate_kernel_opts_from_file(
+            '%s.uuid.env' % cls._required_var("IMAGE_FULLNAME"),
+            abrootfs_sd_keys)
         return ",".join(["%s=3D%s" % (k, v) for k, v in opts.items()])
=20
     @classmethod
--=20
2.47.3

