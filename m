Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11270.1795689018322784349
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gS6DWc9L;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWbw7DLvKFESCiuZCd1MXdTQSWTlsOK5wI4ip0aAebzUEFqsldTMFaJU+CzDgYpIbP3L3NoAcsso74xjtyyRdZcH0tt0qGXT4+sHlhQFHbobFO0uBTLZPVobtSKAm4ZMzCeTe/Ghflq4pQgfIr8bJf0YvsHVWVOsWhcUsuHErrgKwq3F7QRNWLGbUm0GX35Cz9jCPiJSFbP8jvfT8VpQ3VdAUaLU0bsYl+Ie4grT4Fr9TmrSVzozaqsJZRaBZJnS8Yzb8Xt4mCpXb8zZ81iTlmZXcy+jDiXxvIY3wv26f1YGhc/RH/99vcxDIEzStFxGYPxcAJwMvoaBWpu5/ObwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKFQFcoQ49bcw3OEzNmpgfdxhWM8OAW1aHfdjZs6OX8=;
 b=rfi8fP+/R6coA+cqJ0qU0cMuPIzBYB73w65/XW9xYWhPdFJzTsr6z8Zjg7IFjxAh2wQ66ozbMVWsJ1d7iozs2ziB3XC8+eo7SACymvxGixMXy4DTChBBxr27WAWw87nsHVQBU6kEazI9f2xxaD6jOgaWa0s40RhdF5Z1vUfykiEUr5JNMbbe4qQRkFuyqgn6gEJ5W1MNQOR9w7OAbmelsH4DQOyrkwdYni/Ep6aTh6TwQpdw/18pGulAuwn3fxKUOLLZU65dBMmE67SNMEI+hIrLHYKAHJ5cYbi7EnW5D66vDca75FYCPUnDoQtG+RZP0gdWws2piRx/9ATvS+vYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKFQFcoQ49bcw3OEzNmpgfdxhWM8OAW1aHfdjZs6OX8=;
 b=gS6DWc9LpDzvhvgkOSo3erssAjdE2m+kY07TxeJ9SkvUjq0zjKvcoPdD8cEi/be45cgICwvQoqfTor9z7on+aXfuhMQinPWHSjkjzT6rUKiKxMcG3ezlLU4kaOJwQWyjzG5objwGdYtePryJIqmrtKjCLMCvVWgHp4LdyMeRKJytABIK52ro/aYOm9Axq1SY0yxgUHgI473yFMSR5dhzFbU2ir0r59o5VycknsFjlzA7XTnJuSASQIFTb8Y+w3BbIXRSotvGXvDZBt8+OSJ8IdjqCS/gvyWqskKdp/Xx8FJIUMGSzrfjbJSJkjwT1k9hbBV+88Gr+3Jrppil5MxBZQ==
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
Subject: [isar-cip-core][PATCH v4 04/21] efibootguard-boot: derive root mode from ROOTFS_CONTAINER_TYPE
Date: Thu, 26 Nov 2026 11:29:50 +0100
Message-ID: <20261126103007.2922985-5-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 155a806b-ac9d-4311-1ad6-08df4ba842e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261028144727099003|261102130727099003|10067099003|11063799006|261022115727099003|261021135927099003|56012099006|260925022911599003|260925021311599003|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003|261102123227099003|18002099003|6133799003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: +raTP14K1xD5D3/dGfGEnX8biRkNQxyEKkJN48TwVOPTdia98n9N59eAg5MK22V6v9k1+AmDu7JZs9qvUrvGPwa0xDv9vOOz67wRtpjStyp4eajhAEhzEUFB+7UzTXaAj1wlx6JGub8LBvNfWK3rFL3VgMBo4caHeC/3Au8pIQugpWZDrLbCNszZxaQ8MhesWX51TSuuBLZyTjW+bUC9Tp8S6bMtEKyHBc8//4cQYDtoDS9OlkDAr6Qdwo9X9NrFWGk3Lu0KaXoPclMe5eBw7DbHsJ5T3KeVVHPaCcpzGW9uZ4sBlByieNVKH1M/1wXPvP/HfPBsNZ+g6jQQ+L6xaGNA/604hsDDs8JmUOpjYgLN7u6rg+iMyIRTYaB9Q9gQBg2oC8RDx7DoLXKGsGAi1d7Un4fIlRhkNJhgYls/3T+zaR/H+lPggheaOXi0//O4Oos65Ycn5mO5edeH09P0O4rBBGY3lmS/mPG0V2dXT5ZLeP2TB++XVd5usM2ndui0C6yyISbmLxm/e06gX8LptoQo5/3V6t37MxR8I+eMhpoICTdXukWj0AxdAa9/N8nKDZoGas3/8RZpzaJAOcTM9mAcj7thEUUXRQ0H3gvX02bKfyOJZiXdNf9wH7SskxdgHPg4sIn8ygs9CZ2ZfjexP0bi3/024Zk0HWvsBLi3Wa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261028144727099003)(261102130727099003)(10067099003)(11063799006)(261022115727099003)(261021135927099003)(56012099006)(260925022911599003)(260925021311599003)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0zdhpJwOWAaJds3JlVQdGbkhjhOpADrpLXmIMUAiAjtvmpwDSYjRoDGM1sY?=
 =?us-ascii?Q?SqmTAmc/QDBgFhx1dO8Fwa2mV44oKMYX+YT/Ejs823aGMQU86RYxUGqW8XDG?=
 =?us-ascii?Q?botRYpUF0KVNUaDyw1NMeqT/YFSwrAspoAmw2RaBLDC7JI16c8ZBga/oFOqM?=
 =?us-ascii?Q?j2nLSO7eKMcIOyHzJUvkEL17LQeTxD6JTjjHopjNqRR8NOCb3VKcKO7yuC/D?=
 =?us-ascii?Q?Srr+xC1Khys2+1I1JvAflO31gEM9IRrtGKTyK+N6l4viXc8mtimB+FXGM0ZL?=
 =?us-ascii?Q?pVF4l0T92bl6e+e/8tGhiyLDPE7hLxqGwJk50zRQGU9598KKKF2SUfINFhNZ?=
 =?us-ascii?Q?iU843whN5SfHxkFT+mUmkeIbpgmzW3Uk/tUkf+p+CNBiRb/wYYyrMEgKeA+u?=
 =?us-ascii?Q?k9kqcsZll9CBqJFYH8unCjnzjXcjDZBMKqf+aoIcgMgW2TTyLQ9EicUnGV/u?=
 =?us-ascii?Q?v7wN+56u7AiCwYC45RoFvFEG08dt06lMREWdTGL9rbRoYwLZSAbu+ke0ZoVT?=
 =?us-ascii?Q?/MoKAdn2S0pb1Hambx1k6VI/lWp/NK+wyzkXqnkb22NzgfUT+a65KnOdNBty?=
 =?us-ascii?Q?HiWbB89Vt943/InvalgHDA3Oe2EKTY8aeGqWVIhh2AeZ1VRB26GNjnhCKm24?=
 =?us-ascii?Q?Yk+rcXsVhDS7HYcw3dBEPI/jjmBDzXjhiU7QveYj4ryZZHFX4Ruhb7v6Kbi+?=
 =?us-ascii?Q?Nk89FuxrC1e2vtyhN/t2SKofDbgFKm8N0Y5FK4GDD/GIJR4CuTlA4CfgPUra?=
 =?us-ascii?Q?b4EJ4bSJLM2UQtJYOt2ITrcEEc4DwcU2ISpKbMlUG5R4lzBpNw31VEn/mPh7?=
 =?us-ascii?Q?WsQxKrzTbiCtpuj76Ppegvdum5odFwtpbZXGKGkxyvowW1AFjTHaxzELDY11?=
 =?us-ascii?Q?UiOn0jWcPi4BfQMhUKLObUpS7o5zG/dZUs6jZmY0+jorKniMUt+IMnEhL9nI?=
 =?us-ascii?Q?ziIsbMNk4R+ptshDxnNU30mwFT1dpTiHeVx/+jxJdztGrX2lM4uENS1ODEYZ?=
 =?us-ascii?Q?6MzN0JcWDqQKkApAa/losUKVc24MdU9zIS+1bErmxXt/N4gxoZqU0wtODMg4?=
 =?us-ascii?Q?ZCZsudzdqJOsgEGCIcL167SVJ//xOzdVKRfufxgw8So6D0wcM3QZg/1Sh3E4?=
 =?us-ascii?Q?Srjzx/diIaWbGs8gxbCzXoLy9YP2P7BmQ29UdYjViZGLH+2Yix6GmQHjaPiB?=
 =?us-ascii?Q?lMT6IqEBUQABi1K2M7oJcTAJn92oBj3nRRy/e+VkXSg4fd48ilk8hg6RN7Zf?=
 =?us-ascii?Q?WP821IIf8/iBqZvDi9rKmmiE9a7kUftYwgzHeMKdW2Ma2PBRZeiFCVkRB3GE?=
 =?us-ascii?Q?+OLqUSwqmfjKp2W7AqYh7g2uXu4VmrY7v+lyEKb9+IpVr79btK9XNtR3ptaO?=
 =?us-ascii?Q?mYvNZp53vTUhYUMgUZF/KJ27Qrrc++4RTG4zxtXC0AYL2uV/rjIF6LNqLxkh?=
 =?us-ascii?Q?n2TE/u8U7bJ590V793c0MPptxRRDGJ4m0YZwrmcTZkoGiFZpRrqgKh2M4F/n?=
 =?us-ascii?Q?Y/q0A71LeRegaGRPE4aAz+Zf3M5tqflY8b1QBNyv1BBbJlVKwfbiVqArhU//?=
 =?us-ascii?Q?6rAa1mrF9TgclJzRAmJ3aOWJCscxuax2z9SD8mX3TeyYfIlxJ1ax9WoP1KgM?=
 =?us-ascii?Q?AwgR6DPsHDslWcYVmgA5StUVVqc7yM1D9etpfZzHGC9SC8qP3jIue62LDMvi?=
 =?us-ascii?Q?qHRfhuxws+ZEF1zx4mWZQR36kiKQIMARd181DLc/V4/3lzwI0VyGiWZLJUFj?=
 =?us-ascii?Q?PP2W/mOUEYi3MMEWViSRN7hBtPOC2jg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155a806b-ac9d-4311-1ad6-08df4ba842e1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:15.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBfnjz+XJbDGUzPVEkOSQDw5c9frwRklwoHAejChvBWSccWl1S8er7EboUuAbHoxzuy/PACrugdyeaFb34Sg2aNUOdV3FNKR9rH5bLJ+Olc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25085
Content-Type: text/plain; charset="utf-8"

Whether a partition boots an A/B root (abrootfs) or a dm-verity root is
decided per image by ROOTFS_CONTAINER_TYPE, but the wic layout repeated
that decision in the wks sourceparams abrootfs_root=3Dy and verity_root=3Dy=
.
Two switches for the same thing can disagree, and wic .inc files cannot
be parametrized as wic does not expand BitBake variables there.

Export RO_ROOTFS_TYPE and ROOTFS_CONTAINER_TYPE to wic via WICVARS and
select the root mode from them: the "verity" container emits a verity
root, no container uses abrootfs. Remove the
sourceparams from ebg-sysparts.inc and ebg-signed-sysparts.inc.

Empty variables are not exported to wic, so an empty container is seen as
unset. RO_ROOTFS_TYPE is never empty and tells the plugin that the image
exports the root settings, as opposed to an out-of-tree wks file of an
image that does not.

This also fixes images without secure boot and a verity container, which
used to get an abrootfs cmdline although the initramfs has no abrootfs
hook in that case. The signed layout now follows ROOTFS_CONTAINER_TYPE as
well instead of always selecting verity.

The sourceparams verity_root=3Dy and abrootfs_root=3Dy are only used for
out-of-tree wks files of images that do not export the root settings. If
the image exports them, an explicit sourceparam that conflicts with the
mode derived from ROOTFS_CONTAINER_TYPE fails with a WicError instead of
being ignored.

With the root mode following the container, dm-verity can be used without
secure boot too, by adding kas/opt/verity.yml or selecting it in the kas
menu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                                       | 12 ++++++
 classes-recipe/read-only-rootfs.bbclass       |  2 +
 doc/README.secureboot.md                      | 12 ++++++
 doc/README.swupdate.md                        |  2 +-
 kas/opt/verity.yml                            | 18 +++++++++
 .../wic/plugins/source/efibootguard-boot.py   | 38 ++++++++++++++++++-
 wic/ebg-signed-sysparts.inc                   |  4 +-
 wic/ebg-sysparts.inc                          |  4 +-
 8 files changed, 85 insertions(+), 7 deletions(-)
 create mode 100644 kas/opt/verity.yml

diff --git a/Kconfig b/Kconfig
index 163813b9..929373d9 100644
--- a/Kconfig
+++ b/Kconfig
@@ -338,6 +338,18 @@ config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
 	depends on HAS_SECURE_BOOT
=20
+config IMAGE_ROOTFS_CONTAINER_VERITY
+	bool "Protect the read-only rootfs with dm-verity"
+	depends on !IMAGE_SECURE_BOOT
+	help
+	  Wrap the read-only rootfs in a dm-verity container. Without secure
+	  boot, dm-verity detects corruption of the rootfs, but the root hash is
+	  not authenticated. Secure boot always enables dm-verity.
+
+config KAS_INCLUDE_ROOTFS_CONTAINER_VERITY
+	string
+	default "kas/opt/verity.yml" if IMAGE_ROOTFS_CONTAINER_VERITY
+
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 1c35d8c6..0bf808d2 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -14,6 +14,8 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
=20
+WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE"
+
 WIC_HOME_PARTITION =3D ""
 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs --ch=
ange-directory=3Dhome --fstype=3Dext4 --label home --align 1024  --size 1G =
--fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0=
f-58904f369524"
=20
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 1b908483..23e23c3f 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -17,6 +17,18 @@ select the root file system generates a uuid and stores =
the id in /etc/os-releas
 During boot the initramfs compares its own uuid with the uuid stored in /e=
tc/os-release of each rootfs.
 If a match is found the rootfs is used for the boot.
=20
+### Root file system protection
+
+The read-only root file system is described by two stacked settings:
+`RO_ROOTFS_TYPE` selects the file system (`squashfs` or `erofs`) and
+`ROOTFS_CONTAINER_TYPE` the container around it. With secure boot the
+container defaults to `verity`, so the root file system is protected with
+dm-verity and its root hash is part of the signed unified kernel image.
+
+dm-verity can also be used without secure boot, by adding `kas/opt/verity.=
yml`
+or setting `ROOTFS_CONTAINER_TYPE =3D "verity"`. As the root hash is not s=
igned
+then, verity only detects accidental corruption and the build warns about =
it.
+
 ## Adaptation for Images
=20
 ### WIC
diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index c1428a7a..83aca236 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -409,7 +409,7 @@ The image is built with the RT kernel just so that ther=
e are some differences be
=20
 **Note**: Only `rdiff` supports delta kernel binary update using `rdiff_fi=
le` handler.
=20
-Creating an delta update file for rdiff_image (rootfs) and rdiff_file (ker=
nel)  handlers requires a reference artifacts (against which the delta is c=
omputed). In this case, the image and kernel built in the previous section =
can be used as the reference artifacts. By default the `DELTA_UPDATE_TYPE` =
is set to `rdiff`, `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULL=
NAME}.squashfs` (or ${IMAGE_FULLNAME}.verity in the case of Secure boot ena=
bled image) and `DELTA_RDIFF_REF_KERNEL_IMAGE` is set to the name `linux.ef=
i`. The values of `DELTA_UPDATE_TYPE`, `DELTA_RDIFF_REF_IMAGE` and `DELTA_R=
DIFF_REF_KERNEL_IMAGE` can be changed in the `delta-update.yml` file.
+Creating a delta update file for rdiff_image (rootfs) and rdiff_file (kern=
el) handlers requires reference artifacts (against which the delta is compu=
ted). In this case, the image and kernel built in the previous section can =
be used as the reference artifacts. By default the `DELTA_UPDATE_TYPE` is s=
et to `rdiff`, `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULLNAME=
}.squashfs` (or `${IMAGE_FULLNAME}.verity` if `ROOTFS_CONTAINER_TYPE` is `v=
erity`, as for secure boot images) and `DELTA_RDIFF_REF_KERNEL_IMAGE` is se=
t to the name `linux.efi`. The values of `DELTA_UPDATE_TYPE`, `DELTA_RDIFF_=
REF_IMAGE` and `DELTA_RDIFF_REF_KERNEL_IMAGE` can be changed in the `delta-=
update.yml` file.
=20
 The build system looks for the reference artifact in a directory named `pr=
evious-image` in the build directory used for the build process.
=20
diff --git a/kas/opt/verity.yml b/kas/opt/verity.yml
new file mode 100644
index 00000000..3de74f36
--- /dev/null
+++ b/kas/opt/verity.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+header:
+  version: 23
+  includes:
+    - kas/opt/ebg-swu.yml
+
+local_conf_header:
+  verity: |
+    ROOTFS_CONTAINER_TYPE =3D "verity"
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index ca97d7d7..22173d6e 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -31,11 +31,13 @@
=20
 import os
 import fnmatch
+import re
 import sys
 import logging
=20
 msger =3D logging.getLogger('wic')
=20
+from wic import WicError
 from wic.pluginbase import SourcePlugin
 from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
=20
@@ -89,11 +91,16 @@ class EfibootguardBootPlugin(SourcePlugin):
         boot_files =3D source_params.get("files", "").split(' ')
         unified_kernel =3D source_params.get("unified-kernel") or 'y'
         cmdline =3D bootloader.append or ''
+        root_mode =3D cls._resolve_root_mode(source_params)
         # the verity cmdline format is identical to systemd.verity_root_op=
tions
-        if source_params.get("verity_root") =3D=3D 'y':
+        if root_mode =3D=3D "verity":
             cmdline +=3D " cip.verity_root_options=3Dpanic-on-corruption,%=
s" \
                 % cls._get_verity_opts()
-        if source_params.get("abrootfs_root") =3D=3D 'y':
+            # panic-on-corruption needs a reboot afterwards, otherwise the
+            # system hangs instead of rolling back to the other rootfs.
+            if not re.search(r'(^|\s)panic=3D', cmdline):
+                cmdline +=3D " panic=3D5"
+        elif root_mode =3D=3D "abrootfs":
             cmdline +=3D " cip.abrootfs_root_options=3D%s" \
                 % cls._get_abrootfs_opts()
         if unified_kernel =3D=3D 'y':
@@ -152,6 +159,33 @@ class EfibootguardBootPlugin(SourcePlugin):
         cls._create_img(part_rootfs_dir, part, cr_workdir,
                         native_sysroot, oe_builddir)
=20
+    @classmethod
+    def _resolve_root_mode(cls, source_params):
+        """
+        Return the root selection: 'verity', 'abrootfs' or None.
+        The mode is derived from ROOTFS_CONTAINER_TYPE: "verity" selects a
+        verity root, no container an A/B root. RO_ROOTFS_TYPE is never emp=
ty
+        and tells whether the image exports the root settings. If it does,
+        an explicit sourceparam verity_root=3Dy or abrootfs_root=3Dy must =
match
+        the derived mode, otherwise a WicError is raised. Without
+        RO_ROOTFS_TYPE the sourceparams of out-of-tree wks files are used.
+        """
+        explicit =3D None
+        if source_params.get("verity_root") =3D=3D 'y':
+            explicit =3D "verity"
+        elif source_params.get("abrootfs_root") =3D=3D 'y':
+            explicit =3D "abrootfs"
+        if get_bitbake_var("RO_ROOTFS_TYPE"):
+            # Empty variables are not exported to wic
+            container =3D get_bitbake_var("ROOTFS_CONTAINER_TYPE")
+            mode =3D "verity" if container =3D=3D "verity" else "abrootfs"
+            if explicit and explicit !=3D mode:
+                raise WicError("efibootguard-boot: sourceparam %s_root=3Dy=
 "
+                               "conflicts with ROOTFS_CONTAINER_TYPE '%s'"
+                               % (explicit, container or ""))
+            return mode
+        return explicit
+
     @classmethod
     def _generate_kernel_opts_from_file(cls, filename, keys):
         env_file =3D None
diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index 8210598d..01f6c486 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -7,5 +7,5 @@
 part --source efibootguard-efi  --size 16M --label efi   --align 1024 --pa=
rt-type=3DEF00 --active --sourceparams "signwith=3D/usr/bin/sign_secure_ima=
ge.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
=20
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2,signwith=3D/usr/bin/sign=
_secure_image.sh,verity_root=3Dy" --fsuuid 0x4321dcbb --uuid f870258b-706f-=
4a66-8d58-b5a75ce61b8b
-part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1,signwith=3D/usr/bin/sign=
_secure_image.sh,verity_root=3Dy" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-=
403f-8637-b111e4482ee9
+part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2,signwith=3D/usr/bin/sign=
_secure_image.sh" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75c=
e61b8b
+part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1,signwith=3D/usr/bin/sign=
_secure_image.sh" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4=
482ee9
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index b7f1afa6..199c89a5 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -7,5 +7,5 @@
 part --source efibootguard-efi  --fixed-size 16M --label efi   --align 102=
4 --part-type=3DEF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6=
-b43d-2fc18d2a8d03
=20
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2,abrootfs_root=3Dy" --fsu=
uid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
-part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1,abrootfs_root=3Dy" --fsu=
uid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
+part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D2" --fsuuid 0x4321dcbb --u=
uid e8567692-2dfa-459a-be15-f6e5ddcc8f49
+part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 10=
24 --part-type=3D0700 --sourceparams "revision=3D1" --fsuuid 0x4321dcbc --u=
uid 94b2174d-c792-4e8e-8a34-b506e2927937
--=20
2.47.3

