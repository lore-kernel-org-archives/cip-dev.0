Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54881.1795443788174869518
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 06:23:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WXF1WlRh;
 spf=pass (domain: siemens.com, ip: 52.101.84.45, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpnsupwgnRvrP+KfMVkC/CkVEHaTlYAhcLr8L/G7I2xzH279nsIP2Qsk/fNiSup9yBI5PsqSc4rdTPxMik+49p3hBqU/KmL8gq+EIPB3Fa+2/wHPSIDgg4decgljQt/VuzA7L09ihrSak3Vrg82eaAGxGD01Jwp+TK9lpU8Kdh9kBxdcD30d00r9SoQ/1bl7/BPTiNGvH4xStfCaPw6fpKoBBIERhjgCm6/xywsQ8YMKq9ckDHraSsNqmWZJKw30HTqoctq0XTKtPkvkJEXHTgrecd/fTSrpgMAvftDFVBLkbtIx+Ln0IA9VhlpITcgqTuTLVGmpNDrpRqzmgl+Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAIpQKPOcfHj/8xPS/ys4FJXOeBVMkHE/j2lbtCdMbM=;
 b=muF/OrOBNdZruhgaDne5sO5rJ4cW9EJcjTXU5HNARzcZ9wtuqXgV4BBm09sYSUaeZgbSU1LC9IwRpURzw3rY9TbnLuT1EF9y4edt5VDIScOtHKFyva1ibn+3GnAAvL/5nFN0G3zfDaefeDujXOCdz0qt6ca9INxMvayCdzASWhbHfkp2pPpNU2oiT7EXUKEiimrDsjtvEPgaZYu9AsGgj+nHYiiZ73TkOqP4oK02PIfOKPrqa4eUhYZNeHj9jp/dKAin+BogCPyyCTp+V8+qHVapr9mZtIQgDdC7zQWrtVHqpShs+2vwmIlm67AWr38fvBBqbRS8PxRV0u3CF7nP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAIpQKPOcfHj/8xPS/ys4FJXOeBVMkHE/j2lbtCdMbM=;
 b=WXF1WlRhD/LeJhEXpCL1Zp9IjwgXkbb4YBa8nroTy937La+uAHnf8/tAUsyhJzrKCHHEof7rSnQbu/T0vslU5Sz15kNI8ER5H4hH+XgNKjnoaUlHs5XkJrlmd9kwHRckkJUtEJyfl7/YAeWioCZX/gFuRKncKxUK+42m8GGgNUDzUSEtWmDPF1Qf5bMujSsCTcx2Nh30ymm1n581SVVT4aGUmalXY3CXnP3MatCf/lQenbINUmrNf4Pi0TqvPoMyqhkSzTMCMsFjH6zGKqIA6XG6lcxZdSOzpd/p9GJ0Bb1PLleIrt+vq8tamihbs+pEW5xOXYsEf0mBHmv6M972Dw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by PAXSPRMB0044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:287::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Mon, 23 Nov
 2026 14:23:03 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%6]) with mapi id 15.21.0662.001; Mon, 23 Nov 2026
 14:23:03 +0000
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH] wic: check EFI Boot Guard signers through the tool runner
Date: Mon, 23 Nov 2026 15:22:42 +0100
Message-ID: <20261123142242.1753173-1-clara.kowalsky@siemens.com>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Return-Path: clara.kowalsky@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|PAXSPRMB0044:EE_
X-MS-Office365-Filtering-Correlation-Id: b66fb190-9a71-4a00-4fd1-08df496d4909
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|5023799004|56012099006|261021121427099003|261021123027099003|261022115727099003|261009223027099003|261026140227099003|261022105027099003|261026121527099003|261102123227099003|261028144727099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: arGnCfrj6v5fYKOBoNQfdTRlVoOKSFMD0N0vXY6TIv82/cr7J7vc0cZzEJQC/g++9/liAkTaoaB6NSStt4Bek66VuFNfDECt/Us/7xuz/zktU9a3zAVVQmOV+NRuyIPS4AdXwEo7gS0HnjfMU5e2LGr6KmzBndgKbOT68BAzQYth9B9NIcWbQbHYkb6zEmFcD1I5PpzJzWcMWHwuMsVNBGZ5dfWwF+mEktkjYgdBlOlAXZZ+9CkR0nR3z3B1j3sd/oN+TDgXkpWEqU+GQWA1icvONkT9xZsrIEd1D9YW585vK/lfS5HcVwhDVEfc4DiAbd3q578TV659vJUMAvaPiBjdI1eGA3fJ/KW9P3x4AHCL/VGICcG9UAgbG/sbrHgNMI67ATsRHjPFJQp7BT1Lf5yngu9kM9a7Q2TTnt94rsV9gzdd3a9wn7idwgtbeu1/IMyzjfr7bo0Pxz3YV8wdE3L0k/IZjGeNmIbJf9KzrmnRNr0NNhDFagElW4aC4pPwzGjX0PZx+n/EG7srFefAjftQ4/smd13+rMkZOEreXUvhMPnCMtjMFlj7xUYw47FDLNVrhwXuaBQpCYlTLFZd9TdjGcHpqAQnqts0jrTCRNOIWNC8wMYyDI6PzcWxH3/K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261009223027099003)(261026140227099003)(261022105027099003)(261026121527099003)(261102123227099003)(261028144727099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgxYlgIgv8tmlyLEoaoPrAAuCpsBgulKfDvXtPD3rXYuuPfNkfMRwyRUODK4?=
 =?us-ascii?Q?hvpNSZ/M1eEl5i2o4SsXoxb059dMsFaIdz3dPo598jE+H155CJJnfKyXR5dX?=
 =?us-ascii?Q?3pMGLPfRbvF87ztX1l5NAa9mwK8OcKRXPUW11ntUb84p4NiJ6zQKvhud0uGu?=
 =?us-ascii?Q?9zyPXbOA5IsN6+8ZUtDkj/HNYEMw5tFPvtzQx8elQHtu197gROppFyraprMr?=
 =?us-ascii?Q?OMZjzC2cgtXLCiQe0baMpAaQmCuZ+0clHeX+R2GDVOIQo/FkyEJ0xHcxGVui?=
 =?us-ascii?Q?h5m4hsueEuZ/D9KkKfidhu6bMiV+KO6TT34a1NH9iO66j7jgT6FfJszdJKIh?=
 =?us-ascii?Q?r92n0kceHcu6SQMeTv8mMPPDbRRLcX1q2JgY3gkLY6SSxvMA6Vx9ndOLNJZc?=
 =?us-ascii?Q?3wvaQwY3HgkKFbsEqhj9NdUeacy3upOxLoORcgPLYRhqSIOcd07OKnJMG02T?=
 =?us-ascii?Q?oIH013K0LhpY79xPWsW8jrr8GHXyumGYZYDLHtqaCIZQSqvxKLnVIsI3dcB7?=
 =?us-ascii?Q?VM9gbw/38KHZJ/jLPozsfkuQdrUWC2tU8YC5waB2t8Le9vJeBvmrDC1VY2MM?=
 =?us-ascii?Q?kvLpTdAni359udMoqfzzscJe8MYDQ1NY3/9iIxtyaG8NEAbh05RF5NPc/gPt?=
 =?us-ascii?Q?5IVux+SWXOeI1dmgg+x+2lpwLmaZ2FD7o30lLX0jy2Knxn4Kv2EGvknJ2Zti?=
 =?us-ascii?Q?fRaSRJEHAcvNZKCbYBeOqD5KtZZuYOFkxCve0oCV8szI5Xsuf3tIFVR5CE4j?=
 =?us-ascii?Q?W8/3JRZmRM0FCpHW8rx2+nv1kx0OW0Q7Vq8P46pX92GZViJu5K+GmUFpdqtr?=
 =?us-ascii?Q?9DkhxQNk4vQ0vAhZwGBRKPUx+OUOoniUzxatZLX989zvBtreYiB2SD7f0BEd?=
 =?us-ascii?Q?2moo1zSNBTGHl7wY6yBa++PaKXjIO922ezUsd3yTR5H5W2N5TGlcBzG1Ujrr?=
 =?us-ascii?Q?N+Il2B1esPES38/Y/zo6GEY1asQOtWNAZbxLctJsXvV29ry23Ffv/10SrSQs?=
 =?us-ascii?Q?aMkBD2tdo+fnksQ+qipOFwMPs+vACrn3CMycBxiTdMpQv13rQNuU38sQnD7U?=
 =?us-ascii?Q?CqelONcgqBHu72YbqyCrSeVTxf7SKR99y8HqR5H57Otm31jMFQGfi33ClJkg?=
 =?us-ascii?Q?uqTcKRbbmnlp9n5niQuYqW3nR8hDpHUlEDBDAaJ91v3ANSCBc5g7H3iniln+?=
 =?us-ascii?Q?6mdTbHIYC6en9ZmZBu5dDwkbaz1v8+c1iKEA0BE+xVGuMCVmT1u9AAGXRcyr?=
 =?us-ascii?Q?CSCbH9SxEWX0Dz0w5RzsjQa2kX5IYZSTjzVMxoDQfYdXPeFUgvcyqbgz+mjn?=
 =?us-ascii?Q?a0Xn/KlK+A04EeSrGJH4hbgLQb95aYpNj3yeLcygjeX4dd4OBnA2jhOfzZBY?=
 =?us-ascii?Q?uRcVXedt3+KwzFiieZ4ZLutX2qHvODp+0QlsSOSVKxKvJB/lIiV+YocyOM+0?=
 =?us-ascii?Q?XYEe3Sy4V6wJpgC3p7eH8CZiWjsqsuylWQ5tbdA7uSoPvVP4d4eTPDxnOOTO?=
 =?us-ascii?Q?ublsAA4c5pQL5PDyAoe+HKEacH6kJOfw4/QJF7EkXWrj7P9arDQQPENiuol9?=
 =?us-ascii?Q?GU5qBZCVwKkoiOUP9nc79NvUUU3bHZGTgsVLYhXJKp/5i9YJ7wX7LFMxznbm?=
 =?us-ascii?Q?KL/t2wC7rTfndl2oI1jNHj+p4r7Rak6VlYItwBBIbEfMnOOsTn/OMPr20z/a?=
 =?us-ascii?Q?mpff7cvYZQVsSxswTstv6Ef4iIns1MPn1RMwrwerev9a1DJROkXEWJFQLAjY?=
 =?us-ascii?Q?nQYtws7vBzSSJez4GbgRFMWmy87B+UM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66fb190-9a71-4a00-4fd1-08df496d4909
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:23:03.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rghhNAhH4ymUQcm4XNOuik7VEL2GPi/84+Ztibr+45SkuQvbEb21oD3TNw1j1ktxRHvza539FF3G3MraPTUb1zEfW0UnEE8Bsb7dbl63yTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0044
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 23 Nov 2026 14:23:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25047
Content-Type: text/plain; charset="utf-8"

This change has to happen in lockstep with the BitBake update in isar,
where WIC's Python driver is moved to the build host.

The EFI Boot Guard plugins execute signing scripts inside the imaging
chroot. A host-side os.path.exists() check can therefore report a
chroot-only signer as missing. Fix this by using tool_path_exists()
before renaming the unsigned file, preserving the existing fail-fast
behavior when the signer is absent.

This was tested with:
kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-secure-=
boot-snakeoil.yml

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
This patch has to be used on top of isar with
"[PATCH v3 0/7] Update BitBake in Isar" [1].

[1] https://groups.google.com/g/isar-users/c/NYmzKbKTqH0/m/la9-tg36AgAJ
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 10 +++++-----
 scripts/lib/wic/plugins/source/efibootguard-efi.py  | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index ca97d7d..d8b9212 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -37,7 +37,7 @@ import logging
 msger =3D logging.getLogger('wic')
=20
 from wic.pluginbase import SourcePlugin
-from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+from wic.misc import exec_cmd, get_bitbake_var, tool_path_exists, BOOTDD_E=
XTRA_SPACE
=20
 class EfibootguardBootPlugin(SourcePlugin):
     """
@@ -258,7 +258,10 @@ class EfibootguardBootPlugin(SourcePlugin):
     @classmethod
     def _sign_file(cls, signee, source_params):
         sign_script =3D source_params.get("signwith")
-        if sign_script and os.path.exists(sign_script):
+        if sign_script and not tool_path_exists(sign_script):
+            msger.error("Could not find script %s", sign_script)
+            exit(1)
+        if sign_script:
             msger.info("sign with script %s", sign_script)
             orig_signee =3D signee + ".unsigned"
             os.rename(signee, orig_signee)
@@ -266,6 +269,3 @@ class EfibootguardBootPlugin(SourcePlugin):
                 .format(sign_script=3Dsign_script, orig_signee=3Dorig_sign=
ee,
                         signee=3Dsignee)
             exec_cmd(sign_cmd)
-        elif sign_script and not os.path.exists(sign_script):
-            msger.error("Could not find script %s", sign_script)
-            exit(1)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/l=
ib/wic/plugins/source/efibootguard-efi.py
index f84c61a..504164e 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -38,7 +38,7 @@ msger =3D logging.getLogger('wic')
=20
 from wic import WicError
 from wic.pluginbase import SourcePlugin
-from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+from wic.misc import exec_cmd, get_bitbake_var, tool_path_exists, BOOTDD_E=
XTRA_SPACE
=20
 class EfibootguardEFIPlugin(SourcePlugin):
     """
@@ -168,7 +168,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
     @classmethod
     def _sign_file(cls, name, signee, cr_workdir, source_params):
         sign_script =3D source_params.get("signwith")
-        if sign_script and os.path.exists(sign_script):
+        if sign_script and not tool_path_exists(sign_script):
+            msger.error("Could not find script %s", sign_script)
+            exit(1)
+        if sign_script:
             work_name =3D name.replace(".efi", ".signed.efi")
             sign_cmd =3D "{sign_script} {signee} \
             {cr_workdir}/{work_name}".format(sign_script=3Dsign_script,
@@ -176,9 +179,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
                                              cr_workdir=3Dcr_workdir,
                                              work_name=3Dwork_name)
             exec_cmd(sign_cmd)
-        elif sign_script and not os.path.exists(sign_script):
-            msger.error("Could not find script %s", sign_script)
-            exit(1)
         else:
             # if we do nothing copy the signee to the work directory
             work_name =3D name
--=20
2.56.1

