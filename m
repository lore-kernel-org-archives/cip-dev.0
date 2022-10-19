Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE2EC4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 09:23:41 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.59])
 by mx.groups.io with SMTP id smtpd.web09.5856.1666171419636292320
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 02:23:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JoM8S71l;
 spf=pass (domain: siemens.com, ip: 40.107.6.59, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgIca5t76/AT55ETbCjSEAuUQSGJwf6tOAbFbzjBV0AK6cZPekRV6aAVt5QNKo4Olz7EqF4k4up8e8aTEH4JMk0JZsP6jigwfNoXL81j4TQziT9aP6S8k3BEjtusE/D72uZsKareXwl5UGKcxxL833AbP6C+OJ2wIBbmc/N3OivAejvo+YBjfmAqPHmFCYzEqjrDuGPGYNB7jNqDCQ0VmfcwVTXwo3IViUBxt7BCmFd71DoBohiBgFTLiDOal4zBmQxmajBo1S3vQ71OWoxBrc2bLh2jW51+fOYsE0Bjpg/pPwy6S318PaV3H50KnL5JjICttFqW671cq+CRB1ADrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHwVCia27qt1UB7zGmtCD00VwRR+4RHEEVrm7sedoXc=;
 b=TaVWzedkZVRt4QgfXfePNtq2/n8/GEHFNvTzZY26TkXGzs/cZYwaLX7+WJ/xbUgQO9k5h0TliE6v981FPa3o3fHDloXUyIjcsuFDuv4PYrYyfFGqB2yEGOCPkMnqVYbcPWZpbN3VZD6QzmzaJ6RjD1a+AHk2syQs1PBy5vyPx7R9PiYvzqzLlrOaS9AOcHQ2PQBTVASbrHx5vO7w/y4vchfdjYzcbsUCzhT85U+2sIucnXGBRY6QovBpaYCqcL5ChA/irxnNLZtY5Dx4Gj1QpbvLFG1Z6SGpeXGo66v7Ay9Yfnqil4cd19/Wdbx8bEhXyIdtJPvcg4nRXIeviJQJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHwVCia27qt1UB7zGmtCD00VwRR+4RHEEVrm7sedoXc=;
 b=JoM8S71l63zqvH8lPjHiqkAK2zdBoByxbKeuCVrBcG64FHWA6m54s47HdsTzZA6EF7wSwFqnstfXJK5H96DwQbX+p8RvNS3Ekr5dGmGbraSxkc/Qza2EfHcOIJa2Hq9Emjpz4NiBPSlBrCyzoZfJKkPQ+I6TBtcg2Okj0aU7mq52wrXXRvyE5e7zeY8QHerhM7gr7440hOqKNeOWxWrsd/yEIhzvPKmNHwebxNFZHtil1rBLH8eJpVDuZ1p8gXas8S8NNkAgWX5uQXvV9gZtXR7428WmzY9/aOwe3qwWJHgfBLDAHkPObzIRB8y9a9T0y3/Ym/mF6r5LmWVcBOAuvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by AM7PR10MB3510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:138::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 09:23:37 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:23:37 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 7/7] no merge - manually instructions test secure boot
Date: Wed, 19 Oct 2022 11:21:17 +0200
Message-ID: <20221019092117.5291-7-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019092117.5291-1-sven.schultschik@siemens.com>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0638.eurprd06.prod.outlook.com
 (2603:10a6:20b:46f::32) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|AM7PR10MB3510:EE_
X-MS-Office365-Filtering-Correlation-Id: c761993e-895b-4e08-3c9d-08dab1b39a6c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fZyOr5q1qkMEfIX0iL5hvNZbH5Y9Ynd9hla4Wan54q50jWRa86D/xwDjgohWwtCe0mw3bB8f0V2BpPVV8h6mf0R11Ba3fFKMkN7o5TZ6fKj7UudvrL8VBj/DXLYBRDoc+IJPcZYliTUA0G7hmQstAajNc03kTvy1Ev85zWiCdQ6Wfe+ZQ4/Bfme7v1yfnmGTI4gYGRK6HIDE5JR91D2qbhQDS2LBnePwOVxO2VXA5PQyo7H9a1Jhi4RXqK2yHeJ8k+ZIGQiqgL1jNMA29LH1sW/YuDwquI4pS+ksvrm/Qa/Dc0b+SaSgNhkDE+nI8vzxgVUhR8W2EyZ+AcEsPh4twQmmImrff1WrGI+vypEu2TXIHg9QCB3W1bwZE91lixKC6UF0ohnV70DZ2oyhFP8R+FzvUnwD5tGPD16VUX01iu4hdp5B/ixj62RR+3tP/1wKGY9SiwABVtVyEXxUzmtJsN8Ug40/kQ+BoJdvqFJai9O8ECFaPd0TPDqbJ/N9xw2MFsPnal/BdsWW3utWrxxQxzi2+CA8FDmG7ARzpeX32zXrhKxLneqlFzzG5usIKSF90o8CH4Tt8GU5xwmB14E/+OWm+g6sG/zQMy/FLSY2nLBrS4oHQIbnryVp0A6uSNZIMvMVfNwdsv5wN5ZMniwRtRlLhpGOVqMIyjBjRB59+5V3AKQIPHnJe+U51Z1uuje//NZXk4F4MkxU01vt2QfsPw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(26005)(6512007)(9686003)(6506007)(41300700001)(86362001)(83380400001)(36756003)(6916009)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(5660300002)(107886003)(6666004)(316002)(82960400001)(6486002)(38100700002)(2616005)(2906002)(1076003)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3ghg0YyDR1yX1y82e9ZvIflphVTmbN8jV4S2tqmQJA90QlixECqEy0oTnpN4?=
 =?us-ascii?Q?5cPfwqfeKyW7ig8PvjnLJdPkNI0eI8+KVj/qZlE/+ePrzhaWmkO9Ah7g0aVP?=
 =?us-ascii?Q?ltI03ImkNcKPaGYitwbyHbIRbuJnYMdIO+Y/YjBetcrK2Z6rVK+WAWycicvg?=
 =?us-ascii?Q?V+y8369XWMAOYu2/5UpdsbBSk2gUSuVZBIrCDSNxp9NteCMBdrJQ4HDihhUg?=
 =?us-ascii?Q?uE7wW+LXDQXy5+IiSBDNnG/FetsvnF5425gOwOQ10W8dTgD6kCSFOa/w83+C?=
 =?us-ascii?Q?ORum4Y5jLdaLmV1N9Emm160AqjgxZQBgrx3pYSRSZ/ymVhuJxRo/cs67JBuu?=
 =?us-ascii?Q?IqdY9AIrALoRM0OvUtfdf2YcEsu50MMVmX2Dws93qVScMbf1xL1cVF+pORtH?=
 =?us-ascii?Q?Z3zAYzmbE19vuviO+AXyz09MzcLV4+boHhx5AhYqwQuXmXtx0Ifr4JFG4qkL?=
 =?us-ascii?Q?rFgxxhgAVTO+EA9Sp9Cn59qCfIbsKg9gOkL/Z0JcegrhKQMFIN3WZ3FcgmkL?=
 =?us-ascii?Q?3FyhvlgY6G3McKSahTmsMx4fY7a8a0W5Zjaos54npREugqMDniVcEEQdVlEr?=
 =?us-ascii?Q?KXcTmG8JoLJmi6xeTJl2RxUZimW9IjlOLiXsTVwIwEE6uZiDFOrhUk5A6z57?=
 =?us-ascii?Q?88i3A4kibl0VKVH8nkZQpvb9lGFcM3/aVwAeuhYYvNVoxYJkNRwaXtzGJKlj?=
 =?us-ascii?Q?j6UUeTM5aCbbT8q6j5lWGK9qav6bJM4CKOTsrdRTn6agexxKTZHumqNHjoPL?=
 =?us-ascii?Q?v66BGwUdW5Euim9IHt+eetLVvrdpT31QzGFl2mj37pZiE+RBEFtjDNK/i6Me?=
 =?us-ascii?Q?i6OI6KXuZzgngnn//98ESB0bAvd+LPJEW7NghmsDmOWHbtAlQ3wMO6x1CA3N?=
 =?us-ascii?Q?t9h3LN+mPEAAyjBReFzjJ2bhygpbiCcNHrMt6hXd3bphRV/9oBAmXI8CfS8B?=
 =?us-ascii?Q?k4XFd3bVwnVwANqhvIll6XE6hKLFxuMGzIQCZzAivcmYfaI6aPs47mB+5oNy?=
 =?us-ascii?Q?W4B7TPHrnL/LS/aikJbCctnsDxn8seZOoYeWWywrgdAgFMG7Cxffp5YBONP9?=
 =?us-ascii?Q?0gzr61XrHdxoklk8oOfvGg5hKP6a37q5WerGlX4iCPGdUC1D3AkzrnSjSSb5?=
 =?us-ascii?Q?umjx5SjJlxzzqtUGfawVvHUWbgCEhg+dJOz6NWQ7guKnbrWZvp0Pa/bXRtLI?=
 =?us-ascii?Q?SS3hEfllGYojnnGaptpnm2cz+TAhCCk8X21X09VH+sMea1Xm0AoluZOZgTiw?=
 =?us-ascii?Q?96SUVILN7Cz4qgqxAqR+XMeZqsy7BkTYt84eRqudS/2Q93Bilmy1csW7sDg4?=
 =?us-ascii?Q?fD1KVWg6HPWw202wB1GtwqgivorTQQJkn6tBesmKsaHV+rrrL5zJFbc+0by1?=
 =?us-ascii?Q?u3s4AR5iEQJFyirT127efl6Q45YyYTsZTY63nyuClc3BM2ggb3u3JGtIRs1X?=
 =?us-ascii?Q?YT5Kfo0GBQRWAinSAt8socRXkwNpmnHJqBmz5Lkg64+Alp3OuDbdzFrwyuPv?=
 =?us-ascii?Q?AAcFrUReWc7XJLctnuNmPGlESg9L9rU6qplCFJMm13leELC92ObfI3NMi/8/?=
 =?us-ascii?Q?gHW+8S4ZVh8p/Fh6stdKM27nmNls2GG74k6TA6otagXlrxMA/90ldPWqmbNL?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c761993e-895b-4e08-3c9d-08dab1b39a6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 09:23:37.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+AC/a4GTatYFqbsl5sa8EfH9KBP/DuJjbTx2bUjUFBsfVgkIVFr7x8EtZVHWpmtrfvPda/Pi92PFo6riKOuVJmxSgFwk2hSInzxaPZOy1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 09:23:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9781

From: Sven Schultschik <sven.schultschik@siemens.com>

This patch is not ment for merge but shows how to generally test the implem=
entation of the optee and rpmb driven secure boot qemu setup.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 README.md                                     |  65 ++++++++++++++++++
 keys/helloworld.efi                           | Bin 0 -> 4576 bytes
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |   2 +-
 start-qemu.sh                                 |   3 +-
 4 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 keys/helloworld.efi

diff --git a/README.md b/README.md
index e30ff3a63..36f9ebe25 100644
--- a/README.md
+++ b/README.md
@@ -55,6 +55,71 @@ or via bmap-tools
=20
     bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-bust=
er-bbb.wic.img /dev/<medium-device>
=20
+## Running Secure Boot Target Images and test it
+Create a folder named `keys` if not exist and within this folder create th=
e signing keys and db
+
+```bash
+#PK
+openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=3DSIEMENS_TEST_PK/ -k=
eyout PK.key -out PK.crt -nodes -days 365
+cert-to-efi-sig-list -g 11111111-2222-3333-4444-123456789abc PK.crt PK.esl
+sign-efi-sig-list -c PK.crt -k PK.key PK PK.esl PK.auth
+
+# KEK
+openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=3DSIEMENS_TEST_KEK/ -=
keyout KEK.key -out KEK.crt -nodes -days 365
+cert-to-efi-sig-list -g 11111111-2222-3333-4444-123456789abc KEK.crt KEK.e=
sl
+sign-efi-sig-list -c PK.crt -k PK.key KEK KEK.esl KEK.auth
+
+# db
+openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=3DSIEMENS_TEST_db/ -k=
eyout db.key -out db.crt -nodes -days 365
+cert-to-efi-sig-list -g 11111111-2222-3333-4444-123456789abc db.crt db.esl
+sign-efi-sig-list -c KEK.crt -k KEK.key db db.esl db.auth
+```
+
+Put an bootable `.efi` file in it or use the `helloworld.efi` provided and=
 sign it.
+
+```
+sbsign --key db.key --cert db.crt helloworld.efi
+```
+
+The `start-qemu.sh` has additional `-hdb fat:rw:keys` added with this patc=
h to mount the `keys` folder.
+
+Start the qemu with following command
+
+```
+FIRMWARE_BIN=3D./build/tmp/deploy/images/qemu-arm64/flash.bin ./start-qemu=
.sh aarch64
+```
+
+In this test patch there is as well the possibility added to stop in the u=
-boot. So if you see a 5 sec timer ticking press Enter to stop.
+
+Now add the keys to the environment my typing
+
+```
+fatload virtio 1:1 ${fileaddr} PK.auth
+setenv -e -nv -bs -rt -at -i ${fileaddr}:$filesize PK
+fatload virtio 1:1 ${fileaddr} KEK.auth
+setenv -e -nv -bs -rt -at -i ${fileaddr}:$filesize KEK
+fatload virtio 1:1 ${fileaddr} db.auth
+setenv -e -nv -bs -rt -at -i ${fileaddr}:$filesize db
+```
+> The address ${fileaddr}=3D40000000 depends on your DRAM setup. You can c=
heck with `bdinfo`
+
+> $filesize is set by fatload
+
+### Boot signed efi binary
+
+```
+fatload virtio 1:1 ${fileaddr} helloworld.efi.signed
+ =20
+bootefi ${fileaddr} ${fdtcontroladdr}
+```
+
+### Try same binary but unsigned
+This should fail with `Image not authenticated. Loading image failed`
+```
+fatload virtio 1:1 ${fileaddr} helloworld.efi
+=20
+bootefi ${fileaddr} ${fdtcontroladdr}
+```
=20
 ## Community Resources
=20
diff --git a/keys/helloworld.efi b/keys/helloworld.efi
new file mode 100644
index 0000000000000000000000000000000000000000..c021d94ae576271f1f472bd2e5f=
380ed1830a2ff
GIT binary patch
literal 4576
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
F{tfI&1hD`B

literal 0
HcmV?d00001

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-=
boot/files/secure-boot.cfg.tmpl
index 8e6428238..63d73f70a 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -1,5 +1,5 @@
 ### Secure boot config
-CONFIG_BOOTDELAY=3D-2
+CONFIG_BOOTDELAY=3D5
 CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype} ${de=
vnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype}=
 ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi=
; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo=
 'EFI Boot failed!'; sleep 1000; reset"
 CONFIG_EFI_VARIABLES_PRESEED=3Dy
diff --git a/start-qemu.sh b/start-qemu.sh
index 18946a6c9..ac73d8d3b 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -179,7 +179,8 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			${QEMU_PATH}${QEMU} \
 				-drive file=3D${IMAGE_PREFIX}.wic,discard=3Dunmap,if=3Dnone,id=3Ddisk,=
format=3Draw \
 				-bios ${u_boot_bin} \
-				${QEMU_COMMON_OPTIONS} "$@"
+				${QEMU_COMMON_OPTIONS} "$@" \
+				-hdb fat:rw:keys
 			;;
 		*)
 			echo "Unsupported architecture: ${arch}"
--=20
2.30.2


