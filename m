Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE17CCF2DB
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:00 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31403.1792405557545157339
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uogjNk4z;
 spf=pass (domain: siemens.com, ip: 40.107.130.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikz+0KYuQQ6xNAC1KEYf7YwDo9l+vb2U40TAcj43ibEgLMbXGE+kyijmrPKZ7NjBmNnlj/Rq+xqAWm5WloTRrklPah0/KMoAW4D53qg5C4VxWsT4tQvF/LfZyJLpFPYWkS1dTwkAwcuyrbqJvx/m2Wv6hW5nWRlK/Q5FztXvUkdlVT/9wwa9g6fEYCWL5pdnjPuvwkgHZRXh3ioLtw0v2TFsMzDZoWim5k05mAOvVFDGhFCwJuhXlDHBIpNMpDAgtudGm+vXR3fLY79+utvzUXfk4s/7XzOAr47EzJZwY6WS2EtgTCNj3UjgYG1/EjKIR8/hGXCd7sDIQtWsjswMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dVyT+FIPlrw/Q832dD1I750tsz5oUtURcZJOkc0mUU=;
 b=cwR2NLjFGjrsxbGQZ0ZTTK7BjNrJgAws5GWPyiatDjRM7WfOo9KmuddaHnK0dKK64h8k0J3YxDOjiY/1cF2BJWNAEW62jp8ohgAosbi0crVahUDW4OZHVIhwVXmIgnA9orxCUEnwV0f3kle9qDHzV7PrMcIMaEtB/q52B/V5fzXgjAFIiBSNRE1LrvPUpTQsGlvf2Z0KWQvWJ425+pd8Yn7ljrqpEUAlpERg9F/Bu8J855rrxkfpxLAGTPaICLHY6SI+WRAMQnEw4EbdPqYCIj/wrbMyvejYm0tmpLYp/vMSmKIoFghOyg/IkywbeZHOd7i5neWffFcc9xktmLGLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dVyT+FIPlrw/Q832dD1I750tsz5oUtURcZJOkc0mUU=;
 b=uogjNk4zGoPpH1CdM9V8PDbE69NDrzfYjB61oaC+8TtGpiTljNu99LVQn2bA1sOejvX5jQ5LK6woVgEH0qR0aTfiI911/JwLHDsY9JCgPQdYO7vtp3URdrkyHlqYKo2TstHENoYLeNvbUDvYFuIFF1Utr6PtQWB9pojChMt9su8Qv82buDvdB/zr+x/2v322dII0SpynWFdIpmPMau+1PtHPVenF1QXhUj6EgjljgPaDzO2Gty9wXccHCcs2fQq6xTKc+/7sShs19zcD4pbOHn8wwSlhAvc3ifXj+uW0ZvrytzFgFEhGo58zyQkG1M4+lEixAUL/P7x4Al2qIQsF1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:50 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 02/12] efibootguard-boot: emit systemd verity cmdline for dracut
Date: Mon, 19 Oct 2026 12:25:13 +0200
Message-ID: <20261019102541.672620-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d684d7-fcc8-461e-930c-08df2dcb5845
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	6bcl61ZpXBbLEfgsy5dfwOW8vTie8sjcV9b5BDoS6ChqKLDWD6DNmI7yDFe8ZDTbzPzJ5+D9L6q4JOzKoFkX6LmQa6TxdbvpkQ4QMZu+XEXFQCMZOU0Nn/7C0iOvegGerMHqsSqrVsXwa54IttEsZXTfIlTuPn4xXMRpwgSTz+DvBFlYDNHzaI2JnuB8Ck6PGzihPRoSQssfcy24F9GY3k+jyumDocB8S3LpgRI1Oh3MMx9KyiTm9zqPZ6kE+hQPncDeVa24hTXlVVQbqlDPtdKCTgE4ADbKuOZXLijZuwfKXkzOkppfcomEiOWqKSLZ6mS7vUVQezbeCRa7QIAMW4quqF6RCik8jq4enjbQtD1Q5WaFYcwWZpl7nE34Srp69+lUclTUfk9vL2W5avAhEzkjDAJvAikmTV8kPNGlJsgH1Mo33RDh3EozJlOppk8eSUno37cuFxKElGnWOCTn8MNGvRIvv0F0m6N7r16GTnffkxFDZoHgmeUo7owAo548qibyk/BZ66EpSSdX0iGYbDHT09Z+5Z4x6m+VbSKexO+W5OPPrh7b85hsU4HoR0ffhVlcPZ1tGOV9fUSvsTnY2VIf4LMmFboiWOgV6DjCPgyIFDlKjLwdR36XijcgtT1HVjy66EJvm0+xNaQyyX4r3RxyI6wNfUQeOl72Rx+DTsY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+tiQvyqkyqWMN/fTCVtyB35rK5uTsr8HjBOoM0z0OzaMkrS8D3JZ7+pvaQRy?=
 =?us-ascii?Q?MqJbgx9VXTo7Z5rffJjvThcWL/S6QxHmHHokNTAOFfy7yBQfahwCV2N6wlLx?=
 =?us-ascii?Q?LCJsVAkqkG4V5FvaF+PsfcZpdoTDt6M14vSwr1MqGPofMeJAbTj34GTU+jHU?=
 =?us-ascii?Q?2hn3lr7GwQX8Nsj4x8V8fIBKHPlVHbMlxvB8myf2k8rntL1uBp+fLzTQN+eA?=
 =?us-ascii?Q?K4WT42P/kDq/QQKvJ36uONfFy6cdaeKUH2ME950Yb8MzpgEMClID8fBw+DVI?=
 =?us-ascii?Q?OG3BMs+WkolEFr7bvVOFw1lq6R5hWN99bI40Y28mScwXwyF9VVmiYEWTyQ/u?=
 =?us-ascii?Q?KU3jXoCRIoVq+XGv2BHMyyHGjntM4NnBieg16LoPT4Sv2CKqO6/J3xc5w7cH?=
 =?us-ascii?Q?RIcKCeBKel3wL4eFTRvC6iKehu/e2BTbvPETZ09RB2fKpFBt+Mqwb5b8HksS?=
 =?us-ascii?Q?yDChkty22hw1JypYltuwg8FC1WraPu4FkkDCt73XMpzaPzdB5mGUSAtsYQic?=
 =?us-ascii?Q?nHEU4qEdAhgdbqN2mq8N2OuTB3pWjpCoqY7s9NdkPIGmGN1ECWU+1cAO6AZI?=
 =?us-ascii?Q?w6OjQ+i2a6m6Zptoy8Ri8oCj5JpVk/89IYXm1OQ8bNpI/XNSzUjrzaB7zE5F?=
 =?us-ascii?Q?wrscala/Tf3BsCngpBI/XWVCDVlpWRZ2CZdZvQGnqGQPFesWVzHSsPrsS9Iq?=
 =?us-ascii?Q?lUTnNXOxrb1w2S3IQMLoCtGTFp1CwC0XKgilzsUnLQBLOIjMqVb2uFtF1Mad?=
 =?us-ascii?Q?3eB4TWTQ1A8F4ozSi/Uqw1kAQcY+qHmVMib/rjfjf/JY2va6WcB6G3+VIOms?=
 =?us-ascii?Q?muTY0hxn1p6A1UDKDu0/qJXsbYV9wkXaobE13U4LiJggSWtJ8AbiPiPM0J8s?=
 =?us-ascii?Q?tkV7uFGc2Vjb2twTuEi25svhxpu3/JSdHNsMaNsEJaXXmUtnhoJWqWLcXkGD?=
 =?us-ascii?Q?QKQkYeyu7mP6GQU34fKYKEkVE+D1IkqPbktuXcw3iRFi4HJjF2BvIKgiUxid?=
 =?us-ascii?Q?dK16mOmc155ciRES4tF+x+4nOQp/Jxrr6GA5LmhbNMpmFmURBNEAeU0QKpkE?=
 =?us-ascii?Q?6dljthtyzTX7aXPWu6r0PTOJ3uAuFIZVtnRFa7+sa8lvzYZBCe7VicIA8ZIv?=
 =?us-ascii?Q?o5UceyZbKGkpt7MYcVkivGjkpPHXz2S1WkQFhV5OGzk98NCDdDu3GjGcsp+o?=
 =?us-ascii?Q?8BI/bSTVAmMDtrGe+ueBSkNcoMMdQV7QIowX2XVZk3cFaemuynySwysv/F/0?=
 =?us-ascii?Q?bTIgH3T3zPL1I2Hww9eWx2NTrGo4aouYGP71qm77HamXrYQVkhAA1+KubKAc?=
 =?us-ascii?Q?Svdz8jDjoRhg3PsWLYv8I9QUugT93Mc7Pil1kWYK8tQZEFs2CEBv+Ky+np7W?=
 =?us-ascii?Q?kgu7h9VEwPSA59kbCnC9Sl4DEfgQfsZ/4c/bVMac2cw7vWHe7kNXnNdGQ8zh?=
 =?us-ascii?Q?8XvAdspOXofWSGLwf4FA5DC87FKzXy7HlmF8iIOcw7YSekp4zq63JgCaSyGP?=
 =?us-ascii?Q?s8nmHd6ckWyqYXydmD861W1EAJmDuQzWRfznj7MoHDn3c8IJl+CUsS6Alg37?=
 =?us-ascii?Q?aYoQXk358n79gJewJBT3FpbnqB2/BGf53wDsBK7SCkPPjSgT9w65N5p43Xq2?=
 =?us-ascii?Q?rOCjvK9/AQUUPkOZw6T101uVlYYfy6D5fRYSvugu1lStTeTcTOIPejQ/AfDp?=
 =?us-ascii?Q?gaJs357TJsI91X+iAoNyr0dXL12C0BBq4xWyOsjbStPlAn4r0h/ZGox8f9WW?=
 =?us-ascii?Q?RdQnjbxfED5HMKSTIGvlfax4XZIi7Nk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d684d7-fcc8-461e-930c-08df2dcb5845
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:49.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tdn4rZlqfyg+BscxjnXRIXIzurOzMAQMfaD5KqP05IoF0mKeFv1z6VUa3K+Tl2f8mWe9SCbTbhToLnLTsANJx40OklCFVJVhEHnudheoJSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24485

INITRD_CMDLINE_STYLE selects the kernel command line dialect for
verity. The default "initramfs-tools" keeps cip.verity_root_options=3D.
"dracut" emits systemd's native roothash=3D and
systemd.verity_root_options=3D, with the data and hash device resolved at
runtime by the cip-verity dracut module (/dev/cip/verity-data), plus
INITRD_EMERGENCY_CMDLINE (default "rd.shell=3D0 rd.emergency=3Dreboot"), so
that a failed boot reboots and EFI Boot Guard can roll back.

Also drop the LABEL=3Dvar entry from the generated fstab. /var is mounted
by the initramfs (overlay and crypt hooks); the additional fstab entry
makes systemd manage a second var.mount for the same filesystem.

efibootguard-boot: use verity root for dracut without secure boot

The dracut initramfs has no abrootfs support; dm-verity roothash
matching is its only A/B root selection. Without secure boot the
default wic layout (ebg-sysparts.inc) passes abrootfs_root=3Dy, so the
unified kernel image lacked roothash=3D and the image did not boot.

Promote abrootfs_root=3Dy to the verity root cmdline when
INITRD_CMDLINE_STYLE is systemd. The wic .inc files cannot be
parametrized instead, as wic does not expand BitBake variables there.

efibootguard-boot: explain a missing verity env file
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  6 +-
 .../wic/plugins/source/efibootguard-boot.py   | 67 +++++++++++++++++--
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 70152de2..179dcb98 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -17,6 +17,11 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
=20
+INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
+
+INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
+WICVARS +=3D "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE RO_ROOTFS_TYPE=
"
+
 WIC_HOME_PARTITION =3D ""
 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs --ch=
ange-directory=3Dhome --fstype=3Dext4 --label home --align 1024  --size 1G =
--fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0=
f-58904f369524"
=20
@@ -76,7 +81,6 @@ image_configure_fstab() {
     run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
 /dev/root	/		auto		defaults,ro			0	0
-LABEL=3Dvar	/var		auto		defaults			0	0
 proc		/proc		proc		nosuid,noexec,nodev		0	0
 sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
 devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index ca97d7d7..5a5ec1c0 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -36,6 +36,7 @@ import logging
=20
 msger =3D logging.getLogger('wic')
=20
+from wic import WicError
 from wic.pluginbase import SourcePlugin
 from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
=20
@@ -89,11 +90,20 @@ class EfibootguardBootPlugin(SourcePlugin):
         boot_files =3D source_params.get("files", "").split(' ')
         unified_kernel =3D source_params.get("unified-kernel") or 'y'
         cmdline =3D bootloader.append or ''
+        cmdline_style =3D get_bitbake_var("INITRD_CMDLINE_STYLE")
+        root_mode =3D cls._resolve_root_mode(source_params, cmdline_style)
+        if root_mode =3D=3D "verity" and source_params.get("verity_root") =
!=3D 'y':
+            msger.info("efibootguard-boot: abrootfs_root replaced by "
+                       "verity_root, the dracut initramfs has no abrootfs =
"
+                       "support")
         # the verity cmdline format is identical to systemd.verity_root_op=
tions
-        if source_params.get("verity_root") =3D=3D 'y':
-            cmdline +=3D " cip.verity_root_options=3Dpanic-on-corruption,%=
s" \
-                % cls._get_verity_opts()
-        if source_params.get("abrootfs_root") =3D=3D 'y':
+        if root_mode =3D=3D "verity":
+            if cmdline_style =3D=3D "systemd":
+                cmdline +=3D cls._get_verity_cmdline_dracut()
+            else:
+                cmdline +=3D " cip.verity_root_options=3Dpanic-on-corrupti=
on,%s" \
+                    % cls._get_verity_opts()
+        elif root_mode =3D=3D "abrootfs":
             cmdline +=3D " cip.abrootfs_root_options=3D%s" \
                 % cls._get_abrootfs_opts()
         if unified_kernel =3D=3D 'y':
@@ -152,6 +162,21 @@ class EfibootguardBootPlugin(SourcePlugin):
         cls._create_img(part_rootfs_dir, part, cr_workdir,
                         native_sysroot, oe_builddir)
=20
+    @classmethod
+    def _resolve_root_mode(cls, source_params, cmdline_style):
+        """
+        Return the effective root selection: 'verity', 'abrootfs' or None.
+        The dracut initramfs (systemd cmdline style) has no abrootfs
+        support, so abrootfs_root=3Dy is promoted to verity there.
+        """
+        if source_params.get("verity_root") =3D=3D 'y':
+            return "verity"
+        if source_params.get("abrootfs_root") =3D=3D 'y':
+            if cmdline_style =3D=3D "systemd":
+                return "verity"
+            return "abrootfs"
+        return None
+
     @classmethod
     def _generate_kernel_opts_from_file(cls, filename, keys):
         env_file =3D None
@@ -176,8 +201,13 @@ class EfibootguardBootPlugin(SourcePlugin):
         verity_sd_keys =3D ["data-block-size", "hash-block-size", "data-bl=
ocks",
                           "hash-offset", "salt", "uuid", "root-hash"]
         image_basename =3D get_bitbake_var("IMAGE_BASENAME")
-        opts =3D cls._generate_kernel_opts_from_file(f'{image_basename}*.v=
erity.env',
-                                               verity_sd_keys)
+        deploy_dir =3D get_bitbake_var("DEPLOY_DIR_IMAGE")
+        pattern =3D f'{image_basename}*.verity.env'
+        if not fnmatch.filter(os.listdir(deploy_dir), pattern):
+            raise WicError("efibootguard-boot: verity root requested but "
+                           "'%s' not found in %s. Set RO_ROOTFS_VERITY =3D=
 "
+                           "\"1\"." % (pattern, deploy_dir))
+        opts =3D cls._generate_kernel_opts_from_file(pattern, verity_sd_ke=
ys)
         cmdline=3D[]
         # fixup for root-hash to avoid an error in the initramfs search fo=
r the
         # root option in the kernel cmdline
@@ -188,6 +218,31 @@ class EfibootguardBootPlugin(SourcePlugin):
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
+            raise WicError("efibootguard-boot: no root hash found in the "
+                           "verity environment file")
+        rootfstype =3D get_bitbake_var("RO_ROOTFS_TYPE") or "squashfs"
+        emergency =3D get_bitbake_var("INITRD_EMERGENCY_CMDLINE")
+        if emergency is None:
+            emergency =3D "rd.shell=3D0 rd.emergency=3Dreboot"
+        return (" roothash=3D%s"
+                " systemd.verity_root_options=3Dpanic-on-corruption,%s"
+                " systemd.verity_root_data=3D/dev/cip/verity-data"
+                " systemd.verity_root_hash=3D/dev/cip/verity-data"
+                " root=3D/dev/mapper/root rootfstype=3D%s ro %s"
+                % (root_hash, ",".join(rest), rootfstype, emergency))
+
     @classmethod
     def _get_abrootfs_opts(cls):
         abrootfs_sd_keys =3D ["target-image-uuid"]
--=20
2.55.0


