Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2110.1795163166724666808
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=miBakNlk;
 spf=pass (domain: siemens.com, ip: 52.101.83.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYQY3FVzuVUtKFpjhBzJWR+0jIiLNsQHZWg+yvwwZSxSp9uGbS0dTh1Z+AbeatCjC6DgYlhJzK6kpDeAXi/nRO3mXTNEnBuAAekxmPf7nMNJJQAfSUidmSbV0FnhrQ7gOkFSgyCnN1cG1dKE62CYGzR7oiGvAJi8mjQQBPaPSbEM/9vhzgGR0o7j9LNIhbIeIlwcKURehN6AEDxgAoRtIDqhQRuu1DYtyPZn8uHYG/rbyZL0z2GKkhxOaHxhB8ih2yGy68xOj1U9E2eC2lN9hjVjd1eu+nXMLqhGXa0EvHrmv7smg5D6cD7z1r8Rp2mlogxyV/08yWEFdkJMi0poeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Osbk7b2fEDvbhjEEJWtnm/BFwn2EL2lsOFOLRO/bjOI=;
 b=cmsLI2nIpga7B6jDKBGrGZgd/m/tqvYoRnP4wiu7RD3uRKqrbYyzdvyEmTgKhG/XTsQBdBwwj0X/dQ0zZMSwYgHE2+5Yqu6ZDsebHJd9TZbneUFljnt3PmDmEipPdQ9yH1veDeJhVs7RQZiHRP9/0icCNGlkiuAV145FTQMNXEPUYp3ZrDQCNgZ6XYkovfZTcAzDX9E3Ex3ze7Pyh1VKei2RSMJhQhtm61s+Aj/gSAAgIumAUPOJBXKTLM1TwiW8t4V3IQ8/EVNtI2xhv5K41dk2TQWI5wg4O8sR1zCw10RMXR7VhX25RzHI1kpbniAMFl6goEN2WodmiCKUy1WKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Osbk7b2fEDvbhjEEJWtnm/BFwn2EL2lsOFOLRO/bjOI=;
 b=miBakNlk+mr8MiQoaQMhg1ZxIgARGASQgKB3bBcexTMVWiFKijalge36VkqFBqlyKFV6h8S2sPJlXI67KHzxN4UApTBuogryfsdnXp8bhbAUjEf/rGCvXgy2uCEpz8n8DqWh69+l7Q0N8cXGHilAAq+T8zVIbyfA7B4whD7PIQaw6sEbwVzJkSAh71hLikFWFDsEJHpXGouuXoPaOtA0MoNI4qWWEB1xaXb3f7rRhMLQdP1qtTbIc9+iyJcwamUMVewfVz0/UMc1OwOsZ5iLntBoG+s5jN+dVE/F62L0ZU26l0qgIXjDGDCOnbT9M9dY8xEhsN16k0DNscS6DqnNIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PR3PR10MB4077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:26:03 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:03 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 3/8] ci: deploy zstd compressed wic images
Date: Fri, 20 Nov 2026 09:25:49 +0100
Message-ID: <20261120082554.375548-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PR3PR10MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 756466a7-9c0d-4b00-5daa-08df46dfea50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021130227099003|261021123027099003|261022105027099003|261021133027099003|261102123227099003|261021135927099003|261026121527099003|261026135527099003|261028144727099003|261026130827099003|261026140227099003|261022113327099003|55112099003|20052099010|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YDI0ZP71eGDI8PcfYNqQ6Sjvp7NmUNT5nMjMED9azm/FwNhjg3Vj6RkgBuXL+7aFlihoeMx5WkB2bStAr90ehoiVhsG5JLRGGLkwA6LoINgC5gnhQYigbWHHsVDxT9Z30pD1foXIEofUwlOOaWMZDpK8Jt7DVvk0PqqDYWNiP+MKa7PNw3UO581G0RKcoQNfMbFq2+G71+zfbYNGWU96YLR3q6E5mYV7QIvA1adQjYDNaUL1bfgNwQ/D2ChMS+NFKM/iEbDH3X8p7d1uNjSMmjmVSTtvm8b1Bu4+aM5kHxBOEjsuKYo/s/HLOLLvFf4Thokug3MmbFOWS9rubCSowRarC8WcfBFmQbD1dYFj1/YpI6Ur079C3uU+EMV8sOpmj+PlsOsGdZxYtsFj/YTjfK9CsJX5p3QZkjA5QJHsCgrOgvqYbvJHsdN5rqYf8VYbUN+uS8w15hcxinF6o+VNyEnDbLYZB1N6/fstkPr14UBBG+zovKriY/vhsPCo9NRHQ0muw5+1eFH9NJ2+lKloKsMZGOv3cZUnDj0PDDYyo+YPCdIOVFw1WG9rvEWMSKLriVTrElJgRn0Vhxxa0M1xKm1R0X0FjiZ4WWmBgOwjw1WVXo+VqKjP+uUp2JzYit37FAWIE4X9INTgrkm3cBSM2BOnrXAREJRXOBkt8/zAuhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021130227099003)(261021123027099003)(261022105027099003)(261021133027099003)(261102123227099003)(261021135927099003)(261026121527099003)(261026135527099003)(261028144727099003)(261026130827099003)(261026140227099003)(261022113327099003)(55112099003)(20052099010)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uL0ElzSIKaKgSDHWIV7zKarQ4Gb7YQ9AFF8td8aFXqE18j3fboiRUc1BzcJ8?=
 =?us-ascii?Q?dNWONwNLkuKhyxdQ73iHm/sjoU78n83d1/AzS9izUlr0NNzv0fQYiJrX03eG?=
 =?us-ascii?Q?5tTOMVkeDsBOZ2l5WaU6Y2I60mXpQPhz0hVB9TP3Ui2kqGprxhdIm3+ON328?=
 =?us-ascii?Q?tyxodiwe1CAVQ6M8/ldGTjj1Yc3rXRt7AxH+jOsS0ZAMvTw9hNuOAu52S4iS?=
 =?us-ascii?Q?f4x0EuvHFdEG8Je3fjB5XaYQ2x1mILn22ZDhs0+gpQionVCWMCz2R9pyagAC?=
 =?us-ascii?Q?ubxXediqKDQab5wLaFlQl6u7+v8mXYbrpoP2v4QqU+K4GnDiDJthodafNXnT?=
 =?us-ascii?Q?z9DboKvWILEvhfTEqMvZW0I3s9XFYRRHR7I0JyTFTPHBXyqPhN5klB7nINWQ?=
 =?us-ascii?Q?c7kS5yvHHaW6uwCanTcxSgEL4Sq8dYhpvOnnM8uMmRPJKyaQPIOpTUOkOv+B?=
 =?us-ascii?Q?zhHBeeXK1G8oPlG0KU80MezCpSRoK0NJCy7YnJO5os0g1k8m66UmiTHgcPrt?=
 =?us-ascii?Q?PFs4T+iaS2032+xZg6dkDc4hxfKwIiyRlR8Z3dIBr6OPo0g8IE3pg7uT1Okv?=
 =?us-ascii?Q?cbb78p7/2uuVSFVGMfWc65dje4C+FCqwK/oI4s6VJeH5KWSyBWDmAAS/Yb3U?=
 =?us-ascii?Q?hFZPfW4qlzWsBT1xgpsr5AnI5QCBiQt+0upI+wS6QTsT9dWz7UVJjUSArwie?=
 =?us-ascii?Q?joIMfpzE0z2dp3aFkTJeQY/IjX2QcjG/dpvQISNbtyUjLeUyFyxUp5Ui/id/?=
 =?us-ascii?Q?ilS+d5FmjBekJNOW7fn/DBlgDlRwgN73Tiwy1GUZbgAtZNPuU8sylnrCe/ur?=
 =?us-ascii?Q?zchI3XtKvvH4rjtL5l2Y27ktjzvWuAo1XhqiFTRiyM0K6Mojd6gBt1V53LBP?=
 =?us-ascii?Q?3lUOV6x3eUpgD43moL9a5RhjiiUySTeFaY9pK+OJxFLyuD3xxpeVaydCQC07?=
 =?us-ascii?Q?aBSYhy9g+h6TuA5BQTecWNpO89S1zMmjrpkI/evyZlAZ1Y50YlbstPrd0Lic?=
 =?us-ascii?Q?udUuPs3I9n585Cr0K5l4dCW9PA7RkcmXg5oYzEPNZ4uTKaz/2M/xpy5ORo++?=
 =?us-ascii?Q?vz/eMXmxP7jX1Av/JSHpJAel+7yY6u999UAw/piPRkeORzawwsv7T+uJZqUi?=
 =?us-ascii?Q?P7FKY039uzBMuGWOWkaE2EwqSUgLhDm3QK4C1bTKTsueSO+ZBjPntKd5oawV?=
 =?us-ascii?Q?ifWTeF+YDoyMW/8He7zjDPrNl+hNHpfNuST/A+tewHGzhmtA6jZDN1Wx/rbH?=
 =?us-ascii?Q?hlpmUJY3CUMnUMc0fiPvgUNI9x4kEs36i921gkG/Q+gh+Te2ji1eaISTnait?=
 =?us-ascii?Q?Qn627crzEHA8Ve3CnXijDGjuDzC5w9dQ/tpTB+MUpyIrTRjYe43yGJdPao9s?=
 =?us-ascii?Q?08bS+dHfGUevB0t12vs98z5tjBuIjk2ZyvVXHUUrRvyapZJjKbTRqFTg0/wv?=
 =?us-ascii?Q?khuNybaNwnr7CAZzi+atikSkdGxm4TCd3meKLeDb40rzFDhuAYPU+NLYj5hc?=
 =?us-ascii?Q?3fSX9oHSf5Zokx9zwZpHEm1xiFAUditTjp57kdQH0HpMRf/3hyoGk+FRTmBE?=
 =?us-ascii?Q?wT+vkCFif4AxgtV1J3lcOfDfYFemWeTRp0AGtz+PwSRwCAXdrynz9uBJP7HP?=
 =?us-ascii?Q?f5UxO7FpIQGjMASmrY3KERxMj04xGufcw7eSr5AIGyQtzZdRNT3czDQfXkV8?=
 =?us-ascii?Q?hskV5RzgHE6pnTlpiI+pnYJe20+gz7YDKFlQcaZZylbF54PjBaOe2dd5WlHI?=
 =?us-ascii?Q?GNYIpF175uIzKiqCDRrfd8lVo/IhVv8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756466a7-9c0d-4b00-5daa-08df46dfea50
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:03.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwI36xLvTtgFZRHUlqfGknrVCxPBO2Yc0Dw6mTe9qpww5/5A4O+5DOaI9V7dfAIwO2Lh1+/GnLTne45aUyO4l37ACTolZYgXVhDmN4M30cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25030
Content-Type: text/plain; charset="utf-8"

The wic images were compressed with xz -9 in deploy-cip-core.sh after
the build, and the LAVA jobs decompress the image for every test run.

Let Isar produce wic.zst images (IMAGE_FSTYPES) and deploy those
instead. The deploy step no longer compresses, and decompression is
about 4.5 times faster (qemu-arm: 2.2-2.8 s with xz, 0.5 s with zstd)
for almost the same size (qemu-amd64 +0.7 %, qemu-arm +0.5 %,
qemu-arm64 +7 %). Switch the wic-partitions archive, the reproducible
build check and the LAVA templates to zstd accordingly.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .reproducible-check-ci.yml                   | 10 +++++-----
 conf/machine/bbb.conf                        |  2 +-
 conf/machine/beaglev-fire.conf               |  3 +--
 conf/machine/de0-nano-soc.conf               |  2 +-
 conf/machine/hihope-rzg2m.conf               |  2 +-
 conf/machine/iwg20m.conf                     |  2 +-
 conf/machine/rzt2h-evk.conf                  |  2 +-
 conf/machine/ti-am62px-sk.conf               |  2 +-
 conf/machine/x86-uefi.conf                   |  2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml         |  2 +-
 scripts/deploy-cip-core.sh                   | 10 ++++------
 tests/templates/IEC_template.yml             |  4 ++--
 tests/templates/M-COM-x86.yml                |  2 +-
 tests/templates/secureboot_negative_test.yml |  4 ++--
 tests/templates/secureboot_template.yml      |  4 ++--
 tests/templates/swupdate_negative_test.yml   |  4 ++--
 tests/templates/swupdate_template.yml        |  4 ++--
 17 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 72089685..a156efdc 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -76,12 +76,12 @@
         local base_url=3D"${BASE_S3_URL}/${CI_COMMIT_REF_SLUG}/${target}/r=
b/build${build_num}";
=20
         mkdir -p "$dir";
-        wget "${base_url}/${image_base}-${release}-${target}.wic.xz";
-        xz -d ${image_base}-${release}-${target}.wic.xz && mv ${image_base=
}-${release}-${target}.wic "$dir";
+        wget "${base_url}/${image_base}-${release}-${target}.wic.zst";
+        zstd -d ${image_base}-${release}-${target}.wic.zst && mv ${image_b=
ase}-${release}-${target}.wic "$dir";
=20
-        wget "${base_url}/${image_base}-${release}-${target}-wic-partition=
s.tar.xz";
-        tar -xJf ${image_base}-${release}-${target}-wic-partitions.tar.xz =
-C "$dir";
-        rm -f ${image_base}-${release}-${target}-wic-partitions.tar.xz;
+        wget "${base_url}/${image_base}-${release}-${target}-wic-partition=
s.tar.zst";
+        tar -xf ${image_base}-${release}-${target}-wic-partitions.tar.zst =
-C "$dir";
+        rm -f ${image_base}-${release}-${target}-wic-partitions.tar.zst;
=20
         if [ "${extension}" !=3D "none" ]; then
           wget "${base_url}/${image_base}-${release}-${target}.swu" && mv =
${image_base}-${release}-${target}.swu "$dir";
diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 40af2dc0..cba60a6f 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -9,7 +9,7 @@
 DISTRO_ARCH =3D "armhf"
 DTB_FILES =3D "am335x-boneblack.dtb"
=20
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic.zst"
 IMAGER_INSTALL:wic +=3D "u-boot-bbb ${SYSTEMD_BOOTLOADER_INSTALL}"
 IMAGER_BUILD_DEPS +=3D "u-boot-bbb"
=20
diff --git a/conf/machine/beaglev-fire.conf b/conf/machine/beaglev-fire.con=
f
index 585c7803..c8539d2e 100644
--- a/conf/machine/beaglev-fire.conf
+++ b/conf/machine/beaglev-fire.conf
@@ -10,8 +10,7 @@
 #
=20
 DISTRO_ARCH =3D "riscv64"
-
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic wic.zst"
=20
 IMAGER_INSTALL:wic +=3D "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-beaglev-fire=
"
 IMAGER_BUILD_DEPS +=3D "u-boot-beaglev-fire"
diff --git a/conf/machine/de0-nano-soc.conf b/conf/machine/de0-nano-soc.con=
f
index e4669b5a..963b704e 100644
--- a/conf/machine/de0-nano-soc.conf
+++ b/conf/machine/de0-nano-soc.conf
@@ -9,7 +9,7 @@
 DISTRO_ARCH =3D "armhf"
 DTB_FILES =3D "socfpga_cyclone5_de0_nano_soc.dtb"
=20
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic wic.zst"
 IMAGER_INSTALL:wic +=3D "u-boot-de0-nano-soc ${SYSTEMD_BOOTLOADER_INSTALL}=
"
 IMAGER_BUILD_DEPS +=3D "u-boot-de0-nano-soc"
=20
diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.con=
f
index a09e4a71..d09f21c9 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -11,7 +11,7 @@
=20
 DISTRO_ARCH =3D "arm64"
=20
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic wic.zst"
=20
 USE_CIP_KERNEL_CONFIG =3D "1"
 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index ace7b9ac..e4d68327 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -8,7 +8,7 @@
 DISTRO_ARCH =3D "armhf"
=20
 # see wic/iwg20m.wks
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic wic.zst"
=20
 # sets serial login getty
 MACHINE_SERIAL =3D "ttySC0"
diff --git a/conf/machine/rzt2h-evk.conf b/conf/machine/rzt2h-evk.conf
index 5cfbfa5e..ff641091 100644
--- a/conf/machine/rzt2h-evk.conf
+++ b/conf/machine/rzt2h-evk.conf
@@ -11,7 +11,7 @@
=20
 DISTRO_ARCH =3D "arm64"
=20
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic wic.zst"
=20
 USE_CIP_KERNEL_CONFIG =3D "1"
 DTB_FILES =3D "r9a09g077m44-rzt2h-evk.dtb"
diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.con=
f
index beabac9e..2f0d2d37 100644
--- a/conf/machine/ti-am62px-sk.conf
+++ b/conf/machine/ti-am62px-sk.conf
@@ -10,7 +10,7 @@
 DISTRO_ARCH =3D "arm64"
 DTB_FILES =3D "k3-am62p5-sk.dtb"
=20
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic wic.zst"
=20
 IMAGER_INSTALL:wic +=3D "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk=
"
 IMAGER_BUILD_DEPS +=3D "u-boot-ti-am62px-sk"
diff --git a/conf/machine/x86-uefi.conf b/conf/machine/x86-uefi.conf
index 84cf8bbe..13afb72e 100644
--- a/conf/machine/x86-uefi.conf
+++ b/conf/machine/x86-uefi.conf
@@ -8,7 +8,7 @@
=20
 DISTRO_ARCH =3D "amd64"
=20
-IMAGE_FSTYPES ?=3D "wic"
+IMAGE_FSTYPES ?=3D "wic wic.zst"
 WKS_FILE ?=3D "x86_64-generic.wks"
 IMAGER_INSTALL:wic +=3D "${SYSTEMD_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG =3D "1"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index 569d2a5f..870d775f 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -16,7 +16,7 @@ header:
=20
 local_conf_header:
   secure-boot-image: |
-    IMAGE_FSTYPES =3D "wic"
+    IMAGE_FSTYPES =3D "wic wic.zst"
     IMAGE_TYPEDEP:wic +=3D "verity"
     SWU_ROOTFS_TYPE =3D "verity"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index fe3ffb77..b2d87824 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -48,7 +48,7 @@ if [ "${NO_KERNEL}" =3D "enable" ]; then
 	BASE_PATH=3D"${BASE_PATH}-nokernel"
 fi
=20
-if [ -f "${BASE_PATH}.wic" ]; then
+if [ -f "${BASE_PATH}.wic.zst" ]; then
 	echo "Uploading artifacts..."
 	if [ "$DEPLOY" =3D "swus" ]; then
 		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGE=
T}"
@@ -58,13 +58,11 @@ if [ -f "${BASE_PATH}.wic" ]; then
 	elif [ "$DEPLOY" =3D "wic-partitions" ]; then
 		# deploy individual wic partitions, helpful for RB tests
 		cd build/tmp/deploy/images/"$TARGET"
-		tar --ignore-failed-read -cJf "${BASE_FILENAME}-wic-partitions.tar.xz" "=
${BASE_FILENAME}".wic.p*
-		aws s3 cp --no-progress --acl public-read "${BASE_FILENAME}-wic-partitio=
ns.tar.xz" "${S3_TARGET}"
+		tar --ignore-failed-read --zst -cf "${BASE_FILENAME}-wic-partitions.tar.=
zst" "${BASE_FILENAME}".wic.p*
+		aws s3 cp --no-progress --acl public-read "${BASE_FILENAME}-wic-partitio=
ns.tar.zst" "${S3_TARGET}"
 		cd -
 	else
-		echo "Compressing $BASE_FILENAME.wic..."
-		xz -9 -k -T0 "${BASE_PATH}.wic"
-		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TA=
RGET}"
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.zst" "${S3_T=
ARGET}"
 		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.bmap" "${S3_=
TARGET}"
=20
 		if [ -f "build/tmp/deploy/images/$TARGET/firmware.bin" ]; then
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_templat=
e.yml
index dd02bb75..bf7279e1 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -40,8 +40,8 @@ actions:
         image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.xz
-        compression: xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
+        compression: zstd
=20
       #Firmware#
         #Firmware_args#
diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
index 107243d0..01adee94 100644
--- a/tests/templates/M-COM-x86.yml
+++ b/tests/templates/M-COM-x86.yml
@@ -31,7 +31,7 @@ actions:
     to: flasher
     images:
       image:
-        url: #project_url#/#branch#/x86-uefi/cip-core-image-security-cip-c=
ore-#distribution#-x86-uefi.wic.xz
+        url: #project_url#/#branch#/x86-uefi/cip-core-image-security-cip-c=
ore-#distribution#-x86-uefi.wic.zst
=20
 # BOOT BLOCK
 - boot:
diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates=
/secureboot_negative_test.yml
index a8e42268..0814b868 100644
--- a/tests/templates/secureboot_negative_test.yml
+++ b/tests/templates/secureboot_negative_test.yml
@@ -37,8 +37,8 @@ actions:
       minutes: 30
     images:
       system:
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.xz
-        compression: xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
+        compression: zstd
     postprocess:
       docker:
         image: debian:bookworm
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secu=
reboot_template.yml
index 723adb34..2a150b8f 100644
--- a/tests/templates/secureboot_template.yml
+++ b/tests/templates/secureboot_template.yml
@@ -40,8 +40,8 @@ actions:
         image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.xz
-        compression: xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
+        compression: zstd
=20
       #Firmware#
         #Firmware_args#
diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/s=
wupdate_negative_test.yml
index 70d4d770..950368f1 100644
--- a/tests/templates/swupdate_negative_test.yml
+++ b/tests/templates/swupdate_negative_test.yml
@@ -48,8 +48,8 @@ actions:
         image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.xz
-        compression: xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
+        compression: zstd
=20
       #Firmware#
         #Firmware_args#
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupda=
te_template.yml
index 63b3b10c..cd1c98cb 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -40,8 +40,8 @@ actions:
         image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.xz
-        compression: xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
+        compression: zstd
=20
       #Firmware#
         #Firmware_args#
--=20
2.47.3

