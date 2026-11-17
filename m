Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15531.1794914931770418210
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HLXYHAry;
 spf=pass (domain: siemens.com, ip: 52.101.72.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlpouAzjEAgaY/zF1muJT2e7RguchrQkKsCah1QJpHrpXtkDhEhbmY4oNxN8Mcwkb8lSc661zb9jk4BrjLb7ra82uzYryxsDq+Tzg0iEGmlKJfl/rSlL7//UGjvnmvQAJRoIJjiSOb4MX0IGbW39qhUQEvpxuhT371qO/xMCrg8/gIsC4K8gsT3ArIhFokJBDhi0/BwzcSbI6gN6VXgMRu5KijRa7V0BOijpA6TdTyEZPYPjeZx4yC1pZplroY5evgLbfgX4l8scmoeOjJcv5BZ4Md0+mbzoDJwwDRAt884fsTfsmmRTjmfkEbxxbNacArL7uJXo7CIhcBoFYZk62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc+rlhUvUhUlB9Ek+DBZ4nhL0drWip5jUrR2ApipbrU=;
 b=oBnWYZRs2uEwm5bOKdxbdiYadI0a8WGZtsv/equQd6cerdvUYj/ackyI1SHb9kNRWewphqQ3KdHbfR65omvwUHGfGz9kNsT8VZfMh8Z62YQvC/oN7jmo/4BNq1F6C2g3wLgSlLtIbuBwSI1OUXaVESK1Q/FgOzE9WvIauGJK2RKIhq8xCT/64I7mIfm0i0l9QVnzd6LFNJRi9xxryLM9DqCFrV1iN4HvE9vavvJq5WINmg9eXoBi+O+4tlqXlYslyzhd/XjAS8aCKYv88/o2O1jRemy8bAIcoHOP7n/z12YfmDMc0LyqP3i0rcBCHOBuGJ79CGeNrdqH3CG8Fp0Akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc+rlhUvUhUlB9Ek+DBZ4nhL0drWip5jUrR2ApipbrU=;
 b=HLXYHAryNF8AHBzWb0zSghYNv641DWs7d55y6D7TXBMQwm7fU1a00viDfBu0/WIfmk5va+dQzpnTis32uIirOcIDCvoWT66KOMVPwVKlvtA9ydVbDsCkPXBy++6CgdCUX7PLBaOQA0zCNF5niFgkpABeZgRbvSUVYGOrOMDNF1H0FLSDXtZzMFZSV8xeRJ7bUmeZAzVQJbBNw/t9+6F7ZThBwp0u5Sw917hGTK3u+DIFdkJay0stz++HbQNgH6XIv+w0xATbf59FrRZ27cbsOTznn5WZHYY0QjeRubzlSCmk6AvAkwVxP8XUQgXCnV8r/Ni6kT6IcdFnXW/2lPqamQ==
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
Subject: [isar-cip-core][PATCH v3 12/19] efibootguard-boot: emit systemd verity cmdline for dracut
Date: Tue, 17 Nov 2026 12:28:26 +0100
Message-ID: <20261117112833.316234-13-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a4aac50-9025-4cfb-2981-08df449df184
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261022115727099003|261021123027099003|261021135927099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BFvH3gUL8Vw56Powx5+efo3V7CRp56+CANz4Dw2V+0oZxk2NhnsITUpcXZQ+dSo9IcCxNtmsGz8RKyrZKdC7/OtyQKcQBo5/VBg79WPPmK8qL3nIPlVTtH154rrm5k92i1OfDJqCEirtRbfmiFCNjvvu9FV6mH7BcwHVk4ZCxSTicz6IT1JKhbowHpu67V+V37VBt5JqaQYZf1OiVfx3MRlXnOHgLZhxBDTb9ogZA4wH7ZfVGElSSMMz15TEu0c30EVYm94bqxK6C+HF9Ek2mQ7nakaS/xiyVh0utcSLNrxng7bWtatNEXaxLXjVSciMIm9c2kU4TznnPX9yY0RgjV3zL6tazE6pZKJvNEkNNyklXYTBnKgRieN4zft5UljlIEfckZfr2Bm1TH0tRfln6cRQymuft/iJ8VKFbe2+F3cdA+nPekgfe9npqN3mC0nY+71S7AADs/Q1fV6Y71+11DP+rhv2/JpBLFQFxAdQ5rkpDOVp6gulmZUZQ42o3VNtW3xIjupCWLMlkpq8yO9h/V3Bb7KiA+Wv4sFNLOA8sM1KO+8e6w+Yw/aiLDJJmPWfi808x0LLu9ptz3Pgq1ZZJnuXKjcft2VRBUOrp7AUZ4bAcpNMy1Vv0YjCt+RrLNkX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022115727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/JVpZCmPGKxiwO9H4DkkEd72EGcSsY51E7B8QrVlfiLiqnHtJx4jDs1r2EeM?=
 =?us-ascii?Q?1Yxq/RmyamfFKodVXD+WjsIYKF4u28i0rePJT6lKXjjw9pLinQrPxxux1Shv?=
 =?us-ascii?Q?T6ceiwzU1mjhtWTr66fdgP28GpDDl23G++OUqpjI4dMVFViXEcbEuenFFzXw?=
 =?us-ascii?Q?5Kx/X0pXN1sM/5d/02y7C3zCouOp+t0i01ArgMKyGLVmNwxZSU7I9syiGgtX?=
 =?us-ascii?Q?CO4gjy1mYf03xNpNrkZQBzNB3CDcqzQK1DiiuVKzYQaKTl9oqnWURVzsKb0p?=
 =?us-ascii?Q?pA/riJkek43U4qwmFoAz7IAnVUcHfL1ZfnD8vOlhxR0hM8NuM10a/wM18NCq?=
 =?us-ascii?Q?HC0aZY0+00BTjv8pdietd5Gl3pCJw3GIDdobptwJeW1A52NP8+yJpsO+t9N4?=
 =?us-ascii?Q?BUZHwKcqo3VLGv+bNXn5p73IibVhG12QQMQpqI/2z4qZV6R7/TSWm6vAgWSm?=
 =?us-ascii?Q?KllYjsBzh4gRgEI92aF0HegNDAJTrM2T4101Tljb88wTjb3bIxS2RYXFPpgM?=
 =?us-ascii?Q?FB0D7GgkDdn/CMOwVnciMvCEBf5PxG2xYutNDm/hjEvZEO1Tc3PNbfFAuNIm?=
 =?us-ascii?Q?SiWJFahLo2iZPnGbHhhZI2HciZEQoQFJD2sG3lE+HPmJVnGqXGqTr0sMgd8P?=
 =?us-ascii?Q?pInH8g0BOMZzdux13VruWaNYJiDX78I6EsIUvaaZwETSHY9JOjOIzhT7VRr2?=
 =?us-ascii?Q?O2z3dRQoSuPgtMLTQtN29aw9qsQ5rSSR0wDakqh1tkiHLYNoIafy6BtvvTcg?=
 =?us-ascii?Q?Q5BAUJkOq0uX3dfWnCFGaxLEVIAsg3/aBYO6KZw1FiPWTQ9nEb5yrl+bJdkl?=
 =?us-ascii?Q?PhPvYYhH7SWRb3I5iJ+w6+tiEwmwi+qXbmccT3zQ7Vi4obxHX1HBqZiRcmpn?=
 =?us-ascii?Q?q8wcWFUEShDS7MvAwkzvHeuiEOoSgiGWnIt9sGzr/uKvs1Zl0WufeQhmqI+z?=
 =?us-ascii?Q?Za53F+2v/E/9VwHs/+rY0AIWtiLkB7KAcJvvlXUINZmsZYxIdfNaBPV997UI?=
 =?us-ascii?Q?dd3zRQ6r8/93TuuGiJptNjM/OM8WZ1ZZUZ1OnmIjjXjHl46MTvXnvmnvfhfO?=
 =?us-ascii?Q?cTEQ3011SIibdAs3ZISc9KfZ6rqATblIiTEOeuqrhJGqfpr+QO1AYJwKhCEl?=
 =?us-ascii?Q?tvMGzWCreZFf1RbrguV7oLTrRb9kZx0C6JO938Trk9GWB62WaOFOrmvb6N+v?=
 =?us-ascii?Q?mlUdO1UOZdqi/6msk69DdV5uueHx1RNcsCfZAH2+IABNCW1vs3uP7a6t3dxw?=
 =?us-ascii?Q?ZeSenMjMnKa5grBqe08CDafzCFnorAErVwXaWvhYsBRIMFbYembri4SzNF7X?=
 =?us-ascii?Q?8D97b/FRJO3DoW7Os4MJDbt6aedJP9GzLtGUzTYe0l9T2LEHLbzXVgm/Gt4L?=
 =?us-ascii?Q?KKVVimX2N+keBHK3zNl2xj7ymjcezfsSAApdJsLMu80/GiR4NCForY/25zg9?=
 =?us-ascii?Q?SgIwab5TR+DZ58DrIV+tezYG9bFw+4V/qxkWHQ1Hg3qFRq6d+B4LnxmWocbf?=
 =?us-ascii?Q?EhWXuL4Yzx/jp7iNBBOn1GZlWL4wxGnj5BHQWITvg2zR1C3Qnsz9okmsklhI?=
 =?us-ascii?Q?3kurbsefPY6uZAyt32vjce07e2aqeEzQwKnV+cnMJbKrLhI6YHLZ6Bi82zIm?=
 =?us-ascii?Q?66mbghVv33W83SXuCM+hLpitnwF0r8JRnSY2zpZ8uKgCqNqd5oB2HiuLWCFx?=
 =?us-ascii?Q?fbYCW5g12/Dksz6UPPgnbudI6hv1rROH8dZg6UoX2QAoqomHLVy/zzIZ5UZZ?=
 =?us-ascii?Q?CrGlv3OFHAXyA3ralJXYvZkzuSUW178=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4aac50-9025-4cfb-2981-08df449df184
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:46.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIZfiiAhKwog/8bBz5d+akn0YtID/PqIId2fnP8i7Oomw0Aast0l54Nsr4JYUmfEDORmtlHG51oqAytzGLdIp8ViRoXHb0JUX2UqNB2id/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24832
Content-Type: text/plain; charset="utf-8"

The dracut initramfs has no abrootfs support; dm-verity roothash
matching is its only A/B root selection, done by systemd-veritysetup.
systemd does not parse the cip.verity_root_options=3D format of
cip-core-initramfs, so the dracut image did not find its root.

For INITRD_CMDLINE_STYLE systemd, emit systemd's native verity
arguments instead. ROOTFS_CONTAINER_TYPE is verity with the dracut
initramfs, so the verity root is selected without further configuration.

systemd requires for automatic detection that the verity data is stored
in a separate partition with a fixed Partition UUID[1]. As this is
currently not supported, the device link published by the
embedded-verity dracut module, /dev/${DRACUT_VERITY_DEVICE_LINK}, is
used in the kernel command line.

[1]: https://uapi-group.org/specifications/specs/discoverable_partitions_sp=
ecification/

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  2 +-
 .../wic/plugins/source/efibootguard-boot.py   | 29 +++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 613fe6ef..a13c3a7c 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -14,7 +14,7 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
=20
-WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IMAGE_FULLNAME"
+WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IMAGE_FULLNAME INITRD_C=
MDLINE_STYLE DRACUT_VERITY_DEVICE_LINK"
=20
 python () {
     if d.getVar('RO_ROOTFS_TYPE') =3D=3D 'verity':
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index 43fb4d8e..0b277d68 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -89,11 +89,15 @@ class EfibootguardBootPlugin(SourcePlugin):
         boot_files =3D source_params.get("files", "").split(' ')
         unified_kernel =3D source_params.get("unified-kernel") or 'y'
         cmdline =3D bootloader.append or ''
+        cmdline_style =3D get_bitbake_var("INITRD_CMDLINE_STYLE")
         root_mode =3D cls._resolve_root_mode(source_params)
         # the verity cmdline format is identical to systemd.verity_root_op=
tions
         if root_mode =3D=3D "verity":
-            cmdline +=3D " cip.verity_root_options=3Dpanic-on-corruption,%=
s" \
-                % cls._get_verity_opts()
+            if cmdline_style =3D=3D "systemd":
+                cmdline +=3D cls._get_verity_cmdline_dracut()
+            else:
+                cmdline +=3D " cip.verity_root_options=3Dpanic-on-corrupti=
on,%s" \
+                    % cls._get_verity_opts()
         elif root_mode =3D=3D "abrootfs":
             cmdline +=3D " cip.abrootfs_root_options=3D%s" \
                 % cls._get_abrootfs_opts()
@@ -207,6 +211,27 @@ class EfibootguardBootPlugin(SourcePlugin):
                 cmdline.append(f'{k}=3D{v}')
         return ",".join(cmdline)
=20
+    @classmethod
+    def _get_verity_cmdline_dracut(cls):
+        """Emit systemd's native verity arguments."""
+        opts =3D cls._get_verity_opts().split(',')
+        root_hash =3D None
+        rest =3D []
+        for opt in opts:
+            if opt.startswith('hash=3D'):
+                root_hash =3D opt[len('hash=3D'):]
+            else:
+                rest.append(opt)
+        rootfstype =3D get_bitbake_var("RO_ROOTFS_TYPE")
+        verity_link =3D get_bitbake_var("DRACUT_VERITY_DEVICE_LINK")
+        return (" roothash=3D%s"
+                " systemd.verity_root_options=3Dpanic-on-corruption,%s"
+                " systemd.verity_root_data=3D/dev/%s"
+                " systemd.verity_root_hash=3D/dev/%s"
+                " root=3D/dev/mapper/root rootfstype=3D%s ro"
+                % (root_hash, ",".join(rest), verity_link, verity_link,
+                   rootfstype))
+
     @classmethod
     def _get_abrootfs_opts(cls):
         abrootfs_sd_keys =3D ["target-image-uuid"]
--=20
2.47.3

