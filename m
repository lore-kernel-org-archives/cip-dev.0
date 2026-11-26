Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11364.1795689025514145378
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gRt4pTAv;
 spf=pass (domain: siemens.com, ip: 52.101.66.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhQxCPk1Usrhx5weDRXOAX/zsIfkE+U+jZOUyPrPP4zrJLtRVRPLubs36z6t+3dM56gZmb8JgHybApVEmKR2nnC+yXhADhdol5fFju3/lftXEkKMXuDgIrIurogg2leASKval6RhNzufogKRdpgKv+NLYfUNB9/SUgy/FeXYGphSZV2+GmcJszMPAcJ7yiYmw1ZaYu9p/K7B02EstiQmSTvo9zKf+ZK4fMcu+0g4WJHgKzk4mLBfE8HTjSm55HVCvjJSyfIal/qfl1eRboyGMWujX3Q3UtL/Yx7UGikKwMPvW84mKpF2E9gHP3/ONmEDrrlOyXgbALDU5V5Zd2VguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJzVlExUnV/TBdPer1jkYo3g3KoayQnN58ricnVO2Pw=;
 b=gWskHJCbdqlbLGXdh7ndDmhYo2CeddWildHSTwo9HBSjcBPTfgVlraSoFl/sRc3frGmJXo/qZRNXSjr7pIuVE99ZK7TLmvbWzLtzedYkxKkWNguY/3ikZBwxfZcPT3bEnHMDhIilWR+CChQouzhHtZQoFKXN3yaIYua5DVMUNe9ij9OvxbPIVUVw9XAkX+TUuyZ83clGYCsCXQ26noRkpgYnR4zHxMSvogxbOP2nOvcmdPEaSrE/psycqafqWSh1guu7h41yT27Yz751PAmXRI7pXXOH//gPEfwT64ACf+9tfqzjy3k5e434Ric3adBz6JFNHA9Omz1cJPvQc+2J9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJzVlExUnV/TBdPer1jkYo3g3KoayQnN58ricnVO2Pw=;
 b=gRt4pTAvtodZaMPhLfOgF9YbbOQitq3fKGuxvYV+MSoMgd8XtmLceswOx9iL6INBFfyBcqxJxncXXqAPaQmxro8xFHWV/v5kF5FKG9orr4WUBI+nlOtM32YiExWfPDppAqg4gN3Exb7QVrMI24LRL6O058FkYNVaDK+CfvHDESHcgOBvajfAuiQM4aYcYcngMsuEWhERYfQis7uYrLzAO7Jccs0Zh4fMYgtUEsd6EAqvXq6DHOI2T52bTryqhiRgvGfKZN6ryIRP0sSbAlwz8rdoLK6ANXPTTwdHZ/fIRH2VJbnXXa9ONnbuhsQtOd8Sz93TGQNA6v0zmPZIte0cDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB9591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:61a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 10:30:20 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:20 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 12/21] efibootguard-boot: emit systemd verity cmdline for dracut
Date: Thu, 26 Nov 2026 11:29:58 +0100
Message-ID: <20261126103007.2922985-13-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 04f0d032-d4dd-4724-c442-08df4ba8457c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|55112099003|11063799006|261022115727099003|261022075727099003|56012099006|261102123227099003|261021135927099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7aAYY1kcKnvTRRJ2797zb+NzyBryqgm2tX/Y4X8ejAWE2Lq+xCgRJX3LLx8PKWNKGjBGtVxuPWL7W2FQERvOwYpe+WrdhfUmxml/sSTSLBdycA2RIPoAoRbNYH1lb2q05Z+JdYDZN6+0krV83Y8AKkckj/jUhwNxJ2mmY25d1Co7LQDGBGjwd5XktBs9mXocyy2ut5feNcbbHKL1MFzlyoyfQQGObtkBukYj3Y0+UKL5dgAK/c9QQ4NUBMZPgb6P3H4p0/M3X1HfYFvbaVurr6yAKeaHczpngM947HcLEKYglB2EPZzEWS8jHYbQKBOs5IvTI7pss9ZZGnUMUkOPgInB4yeAZW1c8W3v0CuvEIDt8cBQjrAA6xSSw7gpz6mG5IrS4reFN6Sat/sCsFD8FEg7b7IOVrXIphuQJhvjAzHbXGVDVviQO9aoOmvqm25rwbfht+Z/NgNMAb+1eYFvcKMNDdgbeRdmQm8Qv0PRTjstvZ7hoAAMHxHFFmLpLHpfQaYL5ISgtmcUv8phQn2iud6T7+QGlJ0VwvQrfnb3GZIDCISu9WtXDgizMxEOzB1gKtjpiIqGro/LnXii7RXYBuTVF2yy5HP9CJBy4SAKo0loUozg4DmbyqLKvcU+VF75
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(261022115727099003)(261022075727099003)(56012099006)(261102123227099003)(261021135927099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dx/zKkEcPQR4QNMeZxVE3Fo0Ihq9l4MNtcjaoxTc+laBz/cr6yJEY3VcacOs?=
 =?us-ascii?Q?fQyeya/paPsvRvzM/G/j2DR6uB9LfR0+TreTMZIbG3Q+289MltiUAbpalM0O?=
 =?us-ascii?Q?dIoj3A37t359fDKHYgjd6yz8SvUCh9rnXoyqhjxDVCHcT3QElyUoMaugX/iY?=
 =?us-ascii?Q?nXTD9ODw3hF0mWTMSx7Djms02NyXPYXEuFvOxxUm7XhFEowqVO7BeymuCzQW?=
 =?us-ascii?Q?bb+wWflMQU24yevtStgf+DO8dsc3CyJvgytu5gGcowYGoZZFDD2Ly1qh2TFt?=
 =?us-ascii?Q?B5qKMKnQ+BCYu4IPgQj49/LPMY2C471vhbQVcO9B/RMNM1EfiWoOAsZxXIMQ?=
 =?us-ascii?Q?avZYJME94zAW28zRBKrK6OqFeBxrKevjfn2q0JWUxOs6U9po3JqLN1b/5CkJ?=
 =?us-ascii?Q?ItSbWhFg/iwOfX0zlDRsKaHYpFJWdztp6sff1WtWGANWL3PKjdBl38uFURqd?=
 =?us-ascii?Q?BCnAiP1YvF0lM6mYDWBCr+ZQYCCDOBgQ6rychI9aXo39OqJHmLbwcQRQ83Nk?=
 =?us-ascii?Q?fS/Clt+nKZVz36eS1saI28+Nr3kZXD9azS6uwV8sGGZEPdxe5OfUYrteT6hJ?=
 =?us-ascii?Q?g1n9qah5d3BEUgZzhtdMz7wwIWhCXtQcnC0fnqiF2KVYE3yB+UAFbBMnirlJ?=
 =?us-ascii?Q?WSUlksSOwoPxFbzhhsSVI5xK/KxryY/bvbIfH5JrZt2//ToiNFquLujo7f8Z?=
 =?us-ascii?Q?6WG4sdc60R52o9oeHhoASTpxXnZLlnqpMSmbzwYLElsH7n74Oro72V48RWUk?=
 =?us-ascii?Q?F6ORfUXKa59UU5Y69eYRjJhDF2geR59ookx6R4gKF1crrz/fWtRj2XlrYsgJ?=
 =?us-ascii?Q?LawK5p5aLKNoWUfrPzCsgE/t5jMFxyaF/JfKse5ZmbWNz7nA6ECu2FlXKIdY?=
 =?us-ascii?Q?oXiWJLQa+AfPrEjtK4pyxkDw/W59+DQ72juPh2W0NlB3mQOR3W1GsbhEpG7a?=
 =?us-ascii?Q?kXU279kLD6B5ueGOI4+S1DT7MWByT9kO2RCUtUBqFUTKTZO86AzquHvkl2yd?=
 =?us-ascii?Q?JYPwtsMhEjdXjX34vHpIuloCBYOKe+pgjPvWRIaZ2cJzQ33UJvgMVP/6q+PW?=
 =?us-ascii?Q?ZYEa/GWh2h4yYAhp8ATzmGF4m+R0HlhoWPJndpXOfyxN2+O3nQp2D4woOfPW?=
 =?us-ascii?Q?rto0VmZhQ79MwKu0wAd9nz7MHRe1NpvJ2I7j3gDuyUBk5cNvHXDPhZG2tCKN?=
 =?us-ascii?Q?TeTokbw4pUXWNZNV0+STu4Myo1Q/kQZlJgr3i9Li1mbiEbrgZRD0E4aNQuuE?=
 =?us-ascii?Q?BEyUBXbpNA9p28yOxcNK7DrxR3BCbujihfymfSowc16IGYCJoaTKMwoTw7am?=
 =?us-ascii?Q?grpE0X94PchI9PQ6kF+X5KMzFIp/dOTkaFQjOM9KqMmZ+HciyDfbrAaFO8wD?=
 =?us-ascii?Q?ehIiggs/Zq8nkcKdJCSqrRFHeDmFeXB/NS8yZY9pL5m/LDGlqKalPzHclEth?=
 =?us-ascii?Q?xu/EfmFcyg0DhGYasKiIhbrXgTWeCqQvcCLwSlS6BUYnHtYfoS4JyxgY/X9x?=
 =?us-ascii?Q?/yeH/ZDqeEsMHeFZ+9cYqJopsr+5WWs9c43Iw1W7tFZhePdYznlh8v/hCACv?=
 =?us-ascii?Q?mVgJpy19PXZGpu4mdF3zXbFLiHDS8j4qg71aKl4n8Bz5xcHSa8db+YHli5Md?=
 =?us-ascii?Q?YHnl9v8OsfUDCtn1AV1rLZSvZyjCTNRCRz7jsAsEaVew9RP/xg34xABNvu3u?=
 =?us-ascii?Q?P0chP9Jf5CsOlJUMUZlDzh39QZVoo7/clPJtU6wTl9o+K1vp13q5Pv8oLOlg?=
 =?us-ascii?Q?j/qOBBQ4T3dQkU08++1rxgvruEFgUfY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f0d032-d4dd-4724-c442-08df4ba8457c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:20.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oos8G/EB3gBkMm4IAtNvGKmUjFp3Re/Yw9EKWgeNDjvRkiURJHo472DrYm3IuCqn8jM7cSP3E4lEEvkhJa9cQ0kSiSFJFB0+mCWyq1PBFMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25095
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

A missing root hash, RO_ROOTFS_TYPE or DRACUT_VERITY_DEVICE_LINK raises
a WicError instead of writing "None" into the command line.

[1]: https://uapi-group.org/specifications/specs/discoverable_partitions_sp=
ecification/

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  2 +-
 .../wic/plugins/source/efibootguard-boot.py   | 32 +++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index e9a31dbe..bea339b5 100644
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
index 6067bb53..1259c89d 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -90,11 +90,15 @@ class EfibootguardBootPlugin(SourcePlugin):
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
             # panic-on-corruption needs a reboot afterwards, otherwise the
             # system hangs instead of rolling back to the other rootfs.
             if not re.search(r'(^|\s)panic=3D', cmdline):
@@ -240,6 +244,30 @@ class EfibootguardBootPlugin(SourcePlugin):
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
+        if not root_hash:
+            raise WicError("efibootguard-boot: no root-hash in %s.verity.e=
nv"
+                           % cls._required_var("IMAGE_FULLNAME"))
+        rootfstype =3D cls._required_var("RO_ROOTFS_TYPE")
+        verity_link =3D cls._required_var("DRACUT_VERITY_DEVICE_LINK")
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

