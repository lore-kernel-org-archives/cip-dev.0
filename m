Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15529.1794914926563983602
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WPuMohEa;
 spf=pass (domain: siemens.com, ip: 52.101.83.21, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USUUpsPvUzkfq8U8hwUhPrE+iyFfPPNJvXgH4kfTbAlntrdc22yLlS6upVZx0SVYmIqp3lR1PSAegMwBKtK3qhCP+cwtySgZEPnyTzSe2Dbx1un/6+soDcJWZRAkpx42tvlEjL/UNKKCARVvrFsyrfMvj3muph6bSD1spQeqSyIyXWj8CBn3zy+nvWa6aV6PgD973w5fD8vQWTOgXE6AQLD0HT6CgX1oEUrGeVU1PdVqAuCP3GItPCUfFH+Jwa+lIUqKXZosjWe0Bs1QFFAaxXfrkVPYA6s17hGRSq2gJCvMl0cS9I2w/dqPAW5GKmpwtlZkOSExgQhdHG8FnlcJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCcouR3RAgOps21x72whfFOrnVLK7vrOXzPFEcPIr2Q=;
 b=G8WlqlJ65A9u1+/sGAhQcQKyhJ1CPQXQj/vR5raiAq6nVq2jxLKWRR3BnjotTkpIB8svV+DGXlIISol6Q31oXLQCuzRWYl0txRtPmkArQo7WHJz9brpmFKoqSu6pUnU53CPX85F9pahEy7fP+zoa3Ny5bhboKiTHa2QdthQmkDDv8fHEvR5YZvJyWMgyu4UPEErlCp1qFhFO/+VPORnQ3TeX8pxY1odIMtovd4KGMilwtC03ds7M3nTdJ/Zc4TsCjQK7DSDOJJMDUJV5p4PdOTchiiaPPDGABkTHqt6e1C9KdJVVk5KPRpet3m6EwdiCBl4YfYDl0zkXJh7p4xAz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCcouR3RAgOps21x72whfFOrnVLK7vrOXzPFEcPIr2Q=;
 b=WPuMohEaGp6AX7BvkTQWED5hQ3ZnDN1wmhuvgG3Drgw2cKkZZ769/nfiYLCOIM7qeqr6C0mCfTgVvNfb4Pk5RUbN/UWqTySEMnsH5ku5QGC8qxt8A5Y70vly3BTsE/M4q/EBn/w5OoEy1CZrvMC4baUqYGaHgPj30Bv+nwzlzaSX2cowzDEMQBQ2zn4BQ7MmLSa7EFDMZZxJfx+ttJmEaR7prXi/vsiD6uf64LCo1AuPm2fNF8Bix71a/4UWebpSshWHogDvmWkDNXtyMJJDIi3piKMlRPhIDdxo7jO7qPE+9Tas9NgW9Map04PqQGNxei/PYoJe6NgTdq/ip7Rm0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:28:43 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:43 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 05/19] efibootguard-boot: look up verity and uuid env by image name
Date: Tue, 17 Nov 2026 12:28:19 +0100
Message-ID: <20261117112833.316234-6-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 073d7672-ba6e-4309-06ab-08df449def7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022115727099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261102130727099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: oyhHhsyydG561gjFgqBDKa+g9VkmSv3YHhN9F79sZ4SHCyT6ir89IerXfFKXg7EeEgrrNwfOwmz10NTSZZMLqwM8dbZO3uqhTwA23vbWpeppDQfLBvkZwd6G97RvrCGNxG/idoM7quJnY3ZJ9JOvLy5/6J+4fGX1p5w30DQps8UuQRnq5GAXpEDzzsTPIV/9pPSDoB9eIKkt53TpS4EBaLl7Qav342meJK25pV844XY9VTpYntUe69hB6dYo6IKulruvcrEAfEe84r7GKvPJHGue3FgQfNYd5SyXW1UzCIs5xalhvvBgC4sxmn+wVoUuFw2+9Mmv/NtdvWSO6ocQjbHxitIolDzo5cFEHTaQedbCS6jcNsnUrhka4uuNjhlxyIo3TZGk/AYF2ck5G8CYGz2G8eEylgByOoiZskLuPFtdRVtnBFIFUxHSCqGw1GlFwIUij6G1Q8MPB1rOQpQVWIWcUdZmqlcQodvCLqVk+EL0mqqhfHULDFahcNEaCcd20NhchhckC1n+EM5H0YVJSWGq4fxGXJu3ZgiBalKt9h5BkQE4XbaZlU/arFOFZDzw1fCZKX+nlY7FwFBzuANXkrMkS5MEAxngVrjpFMKAAIuBHlfgH2YbAMFm8DzSFx0cs8usPWcF7gdsiQ4ivgKXiJjPSW62rsKWAY4QaaDFtWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261102130727099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FI2CrtDzZP3bB9L39cpJce5YaXhWhDAiIqok7BEET8ooJVbfVNwIqX7izoC?=
 =?us-ascii?Q?+wHFMK2poIscjV49g5rZFLdrAn9x3nGmeGK7ylahGaW3i84AeQc6x9w03bLO?=
 =?us-ascii?Q?vIMgHUZ+56q01gfPbMDZSQDRfo6pnESi4XdVAjDz48nk1lcvtzjjN5YOSNfr?=
 =?us-ascii?Q?jn7VaeOTh6i8gEJLV1ID1uRg0BV1Due9QXak1/ST6/F5wRpJwMITGTKcv+C7?=
 =?us-ascii?Q?xADE/KZ5ijzgg8J2K1lnSVAUCGCKMQ1FCqKC+d8giz9BcpfhG5Bbq12toslM?=
 =?us-ascii?Q?NodRxLOGXzVp4HNsEcAND3T/rXGPXt7G9gtb2P23yvFiINVwqgXGSIaX9mXL?=
 =?us-ascii?Q?LZBUd2eLIj25wUF7YgKrhy4XsPmo722b3jrsBtDDHfwSUe2zN8LWaRsE/uic?=
 =?us-ascii?Q?nGRHcXpqHtuapJP+FrxGVrXoRqqUKB6NGZLOPJTpdQrYJIfqZ3WoHre20rM7?=
 =?us-ascii?Q?KC4mulI8A7GOCGpnhX4hsy9fHgyE7477WYZzginGVMZpj374iLqRhCbhuWfR?=
 =?us-ascii?Q?mT+vMzEuE+/nsBpljNm7kmNOEdCEzCPFkAUKJhb2Rr7k5JN5n1Nl2HUkkW3p?=
 =?us-ascii?Q?EAd9Vn7ZpHlgqJr6x6qmN2o70AyC6QM/EUaRtQNYRZoEGl6aryZlgn0ITeBx?=
 =?us-ascii?Q?A22LiAH1rnXE8R9cb1+18UM/QDNxoZYTw0HHz++wtO/4Kw1fGQsx6t2BqjqQ?=
 =?us-ascii?Q?TPB2YDZf9pMA0ngOhWRzbk32bs5OAw7ug5QnaCel0tUWD8THFUm+ZmvoAk5H?=
 =?us-ascii?Q?8XMvu8pMaYXSf+LNc+du6nv4m21hEf5WWm0/for/Q0Ve+9TipnZrxENLIU+N?=
 =?us-ascii?Q?H6ri5P4HMXS5C6Blr+QSXofmosKy6izU5CDY+/PpH0YeaoSHGGIbKOM6GO1F?=
 =?us-ascii?Q?tIUci17CJgAq6mk+yNoHacnZnj6XnE2203gX6ONd07zmf8F6GwOXoXpg4EZ9?=
 =?us-ascii?Q?T08AuUSzOurHHOZL9Xv6suVvZmveDg9q+/lRDvvy+KGVVVVexkmA41fIE17j?=
 =?us-ascii?Q?fumcTZiKCr7KYpKt99Ma796m3HAV4yWtvO52vpSMh5Ofs/4zaZpFqT/GH7kx?=
 =?us-ascii?Q?DA4h1SzF70wC9B4PZBCxjiqW/YHwFZVZ0WBQ8zovmlj5ARe7UdTTQmi3+ICp?=
 =?us-ascii?Q?bMdkS4w8++/Yzn3YBOpb+SXybWZQFmIGWFZu/3Wosm1LxgJIQn3kh2owhet2?=
 =?us-ascii?Q?b5AaUoj5aCzEuhaOoR9vcUnB/HCzDV62CQ6B9qyyYJALrzm5kMj1DlRURUnC?=
 =?us-ascii?Q?X9/2HGTNonyrIvKyzqMPWSvKiYiZs7kqdHdJVQ5AuQVQGwzF0NTFw8m4ndMY?=
 =?us-ascii?Q?fdB9vDetl5GE7rbvmi3YNTr4rCNxSZc/oio9sf3XC36R5KhRgg6GW5g2kGhn?=
 =?us-ascii?Q?cgMXpDyK2jeDLUy2GANEV+45igY8rpX5o5X4yYV8xQNyfpkrmise0rcIJDmb?=
 =?us-ascii?Q?Qonjfa5JUdyfxo61SLinGLnERODWLR5nzwRrvC8SwprQuu+WW7VO72Dzg4Ji?=
 =?us-ascii?Q?wSL6+ygNwKckvKLmGScorJTJXTbuA/ZaJpqwqenwnnAOdO+0spyGY77YM3V6?=
 =?us-ascii?Q?fcUUmaNpm7wdj/ICxwNKhtpah0NvVfEWFOS+sOSbHCcZzPp0pADcrjWnRaJz?=
 =?us-ascii?Q?5KN6i28iVOQKPbMfQ6n7AcL/KnFuk9XAcOahjpXCYUYwCEPjf43IWyHsfla0?=
 =?us-ascii?Q?FaIKlbIuoZTcxcqCcaLQ1l8Jwui4YbvWWg6VxsMZHKi4eN7oNRQUZ4K6lfI8?=
 =?us-ascii?Q?K7xiap5poaIGtmJghgkMUUeMXyU1b/o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073d7672-ba6e-4309-06ab-08df449def7c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:42.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX8gpMbKOkj6i3xnp8QLw09FtLjNXunoRSom0QyGh6kApkSuOKtl7gyoM/ODNwJR3nxUBHVgIVZSnwDfi0Nz91A7QhX5VbWZ8i9TMHk455Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24827
Content-Type: text/plain; charset="utf-8"

The verity and uuid env files were found by globbing IMAGE_BASENAME*,
which can match the env file of a different image in the deploy
directory and pick up the wrong root hash or UUID. The exact name is
known: IMAGE_FULLNAME, which is also what verity.bbclass and
image_uuid.bbclass use to write the files.

Export IMAGE_FULLNAME to wic and look the files up by that exact name
instead of guessing with a glob. A missing file raises a WicError in one
place, with a hint to set ROOTFS_CONTAINER_TYPE =3D "verity" for the
verity env file, instead of exiting the plugin.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  2 +-
 .../wic/plugins/source/efibootguard-boot.py   | 28 ++++++++-----------
 2 files changed, 13 insertions(+), 17 deletions(-)

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
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index da695e9d..43fb4d8e 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -30,7 +30,6 @@
 # Christian Storm <christian.storm (at] siemens.com>
=20
 import os
-import fnmatch
 import sys
 import logging
=20
@@ -176,17 +175,13 @@ class EfibootguardBootPlugin(SourcePlugin):
         return None
=20
     @classmethod
-    def _generate_kernel_opts_from_file(cls, filename, keys):
-        env_file =3D None
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
@@ -198,9 +193,10 @@ class EfibootguardBootPlugin(SourcePlugin):
     def _get_verity_opts(cls):
         verity_sd_keys =3D ["data-block-size", "hash-block-size", "data-bl=
ocks",
                           "hash-offset", "salt", "uuid", "root-hash"]
-        image_basename =3D get_bitbake_var("IMAGE_BASENAME")
-        opts =3D cls._generate_kernel_opts_from_file(f'{image_basename}*.v=
erity.env',
-                                               verity_sd_keys)
+        opts =3D cls._generate_kernel_opts_from_file(
+            f'{get_bitbake_var('IMAGE_FULLNAME')}.verity.env', verity_sd_k=
eys,
+            hint=3D" Verity root requested, set ROOTFS_CONTAINER_TYPE =3D =
"
+                 "\"verity\".")
         cmdline=3D[]
         # fixup for root-hash to avoid an error in the initramfs search fo=
r the
         # root option in the kernel cmdline
@@ -214,9 +210,9 @@ class EfibootguardBootPlugin(SourcePlugin):
     @classmethod
     def _get_abrootfs_opts(cls):
         abrootfs_sd_keys =3D ["target-image-uuid"]
-        image_basename =3D get_bitbake_var("IMAGE_BASENAME")
-        opts =3D cls._generate_kernel_opts_from_file(f'{image_basename}*.u=
uid.env',
-                                                   abrootfs_sd_keys)
+        opts =3D cls._generate_kernel_opts_from_file(
+            f'{get_bitbake_var('IMAGE_FULLNAME')}.uuid.env',
+            abrootfs_sd_keys)
         return ",".join(["%s=3D%s" % (k, v) for k, v in opts.items()])
=20
     @classmethod
--=20
2.47.3

