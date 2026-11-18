Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11830.1795006475654257463
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 04:54:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=twEKi0IG;
 spf=pass (domain: siemens.com, ip: 52.101.66.32, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot6RQ18h+GrSwQnsItLZl6isvEtN0O2DFagqDTWGm05IsDyWGhISydFADJZ3Dcao0g6UqXlVlK3Tl8NL7svExXXN+wt/jO9OOceeB3VBFvmomZMJ+figoLTfxtFEWFM3Mi2RhTKQ6ai6JqdoUsLAN/9lgQrELEpn5bDbY60nR2WhPbMgcTv9pk7aWBP3+VySVDymuvjzcoP1FTiinTc5HUzeY8nKCX7Xz8eF8vsdQkQMDqKPrAguf2dpBZytHF85tJ827qr6ewq8Y6/2IzdGkCYSvSItSuqzqbNClk2yUSbHtBXpWSSRiFi6UY+722Blh8zWUAWgfNBC+ae4oT8cGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=astOCrtkFe+7m/Q5FfXMTUCXY3XGv+tlhQrM9o+E0U4=;
 b=avzKfxUwEfJ13NsEb+e+qcAAgr36HuX0wKO0vTGPi9ZIEegYmhxW7UCcEd4N30N9dA5jCzw59TAlFDuXEMnzcadewHc8L/+lVXWX3ix6kAAV8zT377mktuiSefZjATHQtYupuPFJvMwJCRJG7gPv2Y0Sl2x5ui8uaTYpyin73jikfdh7bCBEfXhrWwIJoTlywYINe8EmEgcqdSySYXDULgF4tC2sdWxRwdviwHi+LbH5TFlRygbXyhrDhZQyp2dITN08wazaYdzMuhNQ/l93uApABxRQU6PQP3Ud18Jq54qeSjMTzE1tCbhDCfzLmKXtWNGxuwXN5aNhUYKlynKp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=astOCrtkFe+7m/Q5FfXMTUCXY3XGv+tlhQrM9o+E0U4=;
 b=twEKi0IGp8Y7BoeG0rCaO95f3TPqE4s9xtYFg2N5fpPaVw//OJmYVqDi5f+iSAohiCZZMBKCYbuUw14aCSrbigk/5kcGe8auaTx+jnZL1aaE5uXeIf6J7YdmLDTfo1CJwvdhpPev9PJCZdqhYYypG6pZ7XOjdTaEIh5pVHxpryYVaD30DVaRP37NgJLUr1w3qNRiXxFsW1ufdco44GgihlgezmyxP/Y660CDKyiUBwLek+8/QHyLEchJ05EwKPgU5pBJSXN6Du9D28Gu8xNTZfrtQL5hcyZv676/5rhFbW2ekPkfnWr7zxezmwa87/LThmt+uGiP2NUzQObRngBx9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by PA1PR10MB8839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 12:54:31 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 12:54:31 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: clara.kowalsky@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC 1/1] convert wic plugins to execution-from-host model
Date: Wed, 18 Nov 2026 13:54:12 +0100
Message-ID: <20261118125412.2039363-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
Return-Path: felix.moessbauer@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|PA1PR10MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: fd53626e-d44d-4f30-13dd-08df45731666
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|261026121527099003|10067099003|261022075727099003|261022115727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: tstfFIY7vfEPiFWJJp+Cd2MAIUzfc6dZYLyVArmBTb0+l7Gk60WHa4NDjzgp3FIzrjAYhxakx38f4Dac7vvmtXM9ACrZKkGcAS7e3QelnAHz+AS9jNjNKDuDmKoVcj2ywPaswNcyEz83VMW3WPN3YY8Gxv6l3lrcDlmUiyhl7nHXOtJLJ80u6ivSUu0DQzVYNf8mge2uhiSA9gJ8IOG9tLKVRfFGNlf2GkkIMGM8GXyeTLPxomthhN/DVttCoDLHCLASXvoeadVwY7dfk4wE7Y5M3Ny+hu/7ApT3rAGuZYD6qvISDrgaZClLtHgz6IgbA0fAz9qya+kTznoFwCtqLohzaz9TEroI71PKuzCNwXwT9nuKz8y8BCHXMucqzSJGug832iGPFIZZBkWVKeGmNNRLth6fk1JuMdb5XDVadFXT6UXaC3A9Csgs38AjYq5klMBBjQa9dfdMKyH/vTYaL+HmqHRdr9wsnJaSW3bpn5StKIacUNm+cxTKdvLu7eyQja4YlPS7dG2oMUpmew3EqkcTD6HwkUpYWAZEaM94fOlKG67xX0yQc3Ajs8GNcpo0kwbLbYTofRMlLLuFKM7cIfNzOq8Cr7qfb78VjkdV29MwCDM2Z7gDG7N7/kygVABV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(261026121527099003)(10067099003)(261022075727099003)(261022115727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y4SuYhI3aYSP65raZpNbUVCNSUrAV2BrX4wXwCvFAtlfD3Z+VpeGhW897CdB?=
 =?us-ascii?Q?Oqs6eiKwR2GrSkMdq6d0+QosT9xFNBuA0A2DQIvdmS+fSsNxRVKlU44cbf6x?=
 =?us-ascii?Q?fr33dRBGSRxN/gIU81uD/uyNqC5BFWDt58xUQKhvZ+5aCGkk28S0v/+JXHfS?=
 =?us-ascii?Q?ojKWhrVU4aPWuSkzpNUuN6QEpAFOfX48eMp3v6nyiLXZeLFfcgInOCNzUml/?=
 =?us-ascii?Q?MF4owDcYYfxBEFIwjvorvy51Dw8ThGhTSIBFPjd7mZC57NHGCBR8GJfN6IaJ?=
 =?us-ascii?Q?LtYyC/0PSTL+pMcQBX3tzd0MBcOEat6oFpySIyc+hM+3Ge6o7u4ZZQOC7YCY?=
 =?us-ascii?Q?LK8BIb6VIVFmli3gQTNPKMJ1dviItazHKfMkc7kI3JNzXOQ1ShniA/f8qpQC?=
 =?us-ascii?Q?79jiwUfAFUI4I2wwrTMs+FGfyPBQzSDrWnjC2VtmDV1sSwfQHevEY1qw4o6/?=
 =?us-ascii?Q?tbipYv0r1ATYbJ1JEoxFQsmrBMTSeUpaiWPe5kLLAMqkyRqZTQsS4fa3xSWe?=
 =?us-ascii?Q?lkLsm97MEUVqyE1cI5H9vz+9j3bGHtwp4rmoc9c8xRLsgXnkd5oQcv3RynjY?=
 =?us-ascii?Q?M58hRIkycKgy1nRSpYIXtVW/ZBvLApysyEbL49ywrgSZYxoMxfW15IQEE+pd?=
 =?us-ascii?Q?lk4TZzNfNE7EN53kTybjRdF0HcAniHwufq5bWpbiXiR4ZQ89ipKrAX6ry7Hs?=
 =?us-ascii?Q?ZYbWxrpXXBP8BDTHTkIXIJtqXD82Vbzm5ULwTq74wS1z729TNbMe2NsiPriJ?=
 =?us-ascii?Q?ASwwEccg5rH/Jb4GnN1OvTkfKradjTub77ezAczMJnVHq7k48oIff4Z+JaIh?=
 =?us-ascii?Q?eY51N2jHgVjHttEJWlroGs1E0k5EJI972Lg/5ZdHisurfgUTTkMUTEL2t3az?=
 =?us-ascii?Q?mxaYRDopzBGPTVFyLR0dshmkQaFOPQfXbLHAjdmTDlVMJ70ow+qj+eMZp5bJ?=
 =?us-ascii?Q?BmJFX2S7iW1COE9XMnVECy9t7jNOaw0b1E0meRIwKRT3lHuC4laWugvmD8no?=
 =?us-ascii?Q?+MJuLZK+q5msOrP9NsTqUqIYMbafCrwtpwNC0aJti8JlmSpBmWDuzglxoxRK?=
 =?us-ascii?Q?bCWcSOpytjMgavxhSdQuL5qmMXKk6W/nXrUKhcC55LCOIfEUAzCm63Ey7E5L?=
 =?us-ascii?Q?Sp/M09Ukpl6OOlZWOw77/9+aGNIRZUgj5v5tZVsC2ybByZ7dnJbeLLAkgUou?=
 =?us-ascii?Q?zwL3C6vrcpYJZvwIiykcslftdcGOSWO2+nLuRbbOfXuRepqrc+LtdJKDSNVv?=
 =?us-ascii?Q?HxMBipBHxkX5mEoQ3TKcRdgN++Zwfmdy/P1ODaT2HaaIjShX2a+iww2sZc3Y?=
 =?us-ascii?Q?oUvtVUVNvadBgfMRr5VOlBocMv12Suv2R/5ut3a+/QAfcRHitEzlhBV9LBUI?=
 =?us-ascii?Q?x9P9EFpUK8kQRmwZRS8WmCVHhJq3VmA7NT759rJxZTiAidtxZvXE/4OibgIa?=
 =?us-ascii?Q?IfwKxFNpYnf0yv/HvohVBW983CXLkggc2EEhV78OQQnNdl6leJDSGvu6gSFy?=
 =?us-ascii?Q?7Tq8+p0oKAaQjP8x+N9LGAy9U8tVwf3HJMF/Y0OPtrP7onnPz2p93s0b2eN0?=
 =?us-ascii?Q?p7AY5an0MC2UzSABAf7F4DWl95CwAantpI6ijQd/eCghXghpYenTHR26+dom?=
 =?us-ascii?Q?xDfgqsDlUiuPbHi12uZ2NwcQwAG98SA9aveFdLmkzsYWMz3tWrm1F5AiTUoI?=
 =?us-ascii?Q?drIybbWbavcuLv95WU8VsostUARPkERhrjZ6zMEzwYqJa741EKblydHv7ewt?=
 =?us-ascii?Q?bK84GcN/ow90T/ojodDPgu+zD39aolI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd53626e-d44d-4f30-13dd-08df45731666
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:54:31.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG8Hx2QWd9SWzRDde+1A/yEFMVQvLN7eNryRQSaHDbR8W8rJwktz2D4Tb0TZbDK46fcKmU2qUejLsIhRAP97+kF1xCtDQuIpfiQl8T52qWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8839
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 12:54:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24953
Content-Type: text/plain; charset="utf-8"

We convert the wic plugins so that they support being executed via a
WIC_TOOL_RUNNER. This change has to happen in lockstep with the
corresponding isar update, as it is incompatible with the previous
execution model.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
This patch has to be used on top of isar with
"[PATCH v2 0/6] Update BitBake in Isar" [1].

The _tool_path_exists() method should be moved to wic.misc (in isar) so tha=
t
it can be reused by all wic plugins.

[1] https://groups.google.com/g/isar-users/c/NYmzKbKTqH0/m/BTECiBRVAQAJ

Best regards,
Felix Moessbauer

 .../wic/plugins/source/efibootguard-boot.py   | 46 ++++++++++++-------
 .../wic/plugins/source/efibootguard-efi.py    | 40 ++++++++++------
 2 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index 2eb3bf4..9fb3e42 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -37,7 +37,7 @@ msger =3D logging.getLogger('wic')
=20
 from wic import WicError
 from wic.pluginbase import SourcePlugin
-from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+from wic.misc import exec_native_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
=20
 class EfibootguardBootPlugin(SourcePlugin):
     """
@@ -109,7 +109,8 @@ class EfibootguardBootPlugin(SourcePlugin):
                                                           kernel_image,
                                                           initrd_image,
                                                           dtb_files,
-                                                          source_params)
+                                                          source_params,
+                                                          native_sysroot)
             boot_files.append(boot_image)
         else:
             if dtb_files:
@@ -129,27 +130,27 @@ class EfibootguardBootPlugin(SourcePlugin):
         part_rootfs_dir =3D "%s/disk/%s.%s" % (cr_workdir,
                                              part.label, part.lineno)
         create_dir_cmd =3D "install -d %s" % part_rootfs_dir
-        exec_cmd(create_dir_cmd)
+        exec_native_cmd(create_dir_cmd, native_sysroot)
=20
-        cwd =3D os.getcwd()
-        os.chdir(part_rootfs_dir)
-        config_cmd =3D '/usr/bin/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %=
s' \
+        # Tools run via WIC_TOOL_RUNNER in their own working directory, so
+        # pass the output directory explicitly instead of relying on os.ch=
dir.
+        config_cmd =3D '/usr/bin/bg_setenv -f %s -k "C:%s:%s" %s -r %s -w =
%s' \
             % (
+                part_rootfs_dir,
                 part.label.upper(),
                 boot_image,
                 '-a "%s"' % cmdline if unified_kernel !=3D 'y' else '',
                 source_params.get("revision", 1),
                 wdog_timeout
             )
-        exec_cmd(config_cmd, True)
-        os.chdir(cwd)
+        exec_native_cmd(config_cmd, native_sysroot)
=20
         boot_files =3D list(filter(None, boot_files))
         for boot_file in boot_files:
             if os.path.isfile("%s/%s" % (kernel_dir, kernel_image)):
                 install_cmd =3D "install -m 0644 %s/%s %s/%s" % \
                     (kernel_dir, boot_file, part_rootfs_dir, boot_file)
-                exec_cmd(install_cmd)
+                exec_native_cmd(install_cmd, native_sysroot)
             else:
                 msger.error("file %s not found in directory %s",
                             boot_file, kernel_dir)
@@ -254,7 +255,7 @@ class EfibootguardBootPlugin(SourcePlugin):
         part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
                                   part_rootfs_dir, native_sysroot, None)
         du_cmd =3D "du -Lbks %s" % bootimg
-        bootimg_size =3D int(exec_cmd(du_cmd).split()[0])
+        bootimg_size =3D int(exec_native_cmd(du_cmd, native_sysroot)[1].sp=
lit()[0])
=20
         part.size =3D bootimg_size
         part.source_file =3D bootimg
@@ -262,7 +263,7 @@ class EfibootguardBootPlugin(SourcePlugin):
     @classmethod
     def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
                                      deploy_dir, kernel_image, initrd_imag=
e,
-                                     dtb_files, source_params):
+                                     dtb_files, source_params, native_sysr=
oot):
         efiarch =3D get_bitbake_var("EFI_ARCH")
         if not efiarch:
             msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
@@ -295,23 +296,34 @@ class EfibootguardBootPlugin(SourcePlugin):
                 cmd +=3D ' -d {deploy_dir}/{dtb_file}'.format(
                     deploy_dir=3Ddeploy_dir,
                     dtb_file=3Dos.path.basename(dtb))
-        exec_cmd(cmd, as_shell=3DTrue)
+        exec_native_cmd(cmd, native_sysroot)
=20
-        cls._sign_file(signee=3Duefi_kernel_file, source_params=3Dsource_p=
arams)
+        cls._sign_file(signee=3Duefi_kernel_file, source_params=3Dsource_p=
arams,
+                       native_sysroot=3Dnative_sysroot)
=20
         return uefi_kernel_name
=20
+    @staticmethod
+    def _tool_path_exists(path):
+        # With WIC_TOOL_RUNNER, tools run in the imaging chroot, so resolv=
e
+        # their paths relative to the chroot when checking from the host.
+        tool_sysroot =3D os.environ.get('WIC_TOOL_SYSROOT')
+        if os.environ.get('WIC_TOOL_RUNNER') and tool_sysroot \
+                and os.path.isabs(path):
+            path =3D os.path.join(tool_sysroot, path.lstrip('/'))
+        return os.path.exists(path)
+
     @classmethod
-    def _sign_file(cls, signee, source_params):
+    def _sign_file(cls, signee, source_params, native_sysroot):
         sign_script =3D source_params.get("signwith")
-        if sign_script and os.path.exists(sign_script):
+        if sign_script and cls._tool_path_exists(sign_script):
             msger.info("sign with script %s", sign_script)
             orig_signee =3D signee + ".unsigned"
             os.rename(signee, orig_signee)
             sign_cmd =3D "{sign_script} {orig_signee} {signee}"\
                 .format(sign_script=3Dsign_script, orig_signee=3Dorig_sign=
ee,
                         signee=3Dsignee)
-            exec_cmd(sign_cmd)
-        elif sign_script and not os.path.exists(sign_script):
+            exec_native_cmd(sign_cmd, native_sysroot)
+        elif sign_script and not cls._tool_path_exists(sign_script):
             msger.error("Could not find script %s", sign_script)
             exit(1)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/l=
ib/wic/plugins/source/efibootguard-efi.py
index f84c61a..03cc0aa 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -38,7 +38,7 @@ msger =3D logging.getLogger('wic')
=20
 from wic import WicError
 from wic.pluginbase import SourcePlugin
-from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+from wic.misc import exec_native_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
=20
 class EfibootguardEFIPlugin(SourcePlugin):
     """
@@ -48,7 +48,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
     name =3D 'efibootguard-efi'
=20
     @classmethod
-    def _deploy_additional_boot_files(cls, boot_files, kernel_dir, part_ro=
otfs_dir):
+    def _deploy_additional_boot_files(cls, boot_files, kernel_dir, part_ro=
otfs_dir, native_sysroot):
         # based on bootimg-efi-isar.py to get consistent behavior
         # list of tuples (src_name, dst_name)
         deploy_files =3D []
@@ -90,7 +90,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
                 install_cmd =3D "install -m 0644 -D %s %s" \
                               % (os.path.join(kernel_dir, src_path),
                                  os.path.join(part_rootfs_dir, dst_path))
-                exec_cmd(install_cmd)
+                exec_native_cmd(install_cmd, native_sysroot)
=20
     @classmethod
     def do_prepare_partition(cls, part, source_params, creator, cr_workdir=
,
@@ -130,53 +130,65 @@ class EfibootguardEFIPlugin(SourcePlugin):
                                              part.label,
                                              part.lineno)
         create_dir_cmd =3D "install -d %s/EFI/BOOT" % part_rootfs_dir
-        exec_cmd(create_dir_cmd)
+        exec_native_cmd(create_dir_cmd, native_sysroot)
=20
         name =3D "boot{}.efi".format(efiarch)
=20
         signed_bootloader =3D cls._sign_file(name,
                                            bootloader,
                                            cr_workdir,
-                                           source_params)
+                                           source_params,
+                                           native_sysroot)
         cp_cmd =3D "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
                                               signed_bootloader,
                                               part_rootfs_dir,
                                               name)
-        exec_cmd(cp_cmd, True)
+        exec_native_cmd(cp_cmd, native_sysroot)
=20
         cp_to_deploy_cmd =3D "cp %s/%s %s/%s" % (cr_workdir,
                                                signed_bootloader,
                                                deploy_dir,
                                                name)
-        exec_cmd(cp_to_deploy_cmd, True)
+        exec_native_cmd(cp_to_deploy_cmd, native_sysroot)
=20
         boot_files =3D get_bitbake_var("IMAGE_EFI_BOOT_FILES")
         if boot_files:
-            cls._deploy_additional_boot_files(boot_files, kernel_dir, part=
_rootfs_dir)
+            cls._deploy_additional_boot_files(boot_files, kernel_dir, part=
_rootfs_dir,
+                                              native_sysroot)
=20
         efi_part_image =3D "%s/%s.%s.img" % (cr_workdir, part.label, part.=
lineno)
         part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
                                   part_rootfs_dir, native_sysroot, None)
=20
         du_cmd =3D "du -Lbks %s" % efi_part_image
-        efi_part_image_size =3D int(exec_cmd(du_cmd).split()[0])
+        efi_part_image_size =3D int(exec_native_cmd(du_cmd, native_sysroot=
)[1].split()[0])
=20
         part.size =3D efi_part_image_size
         part.source_file =3D efi_part_image
=20
=20
+    @staticmethod
+    def _tool_path_exists(path):
+        # With WIC_TOOL_RUNNER, tools run in the imaging chroot, so resolv=
e
+        # their paths relative to the chroot when checking from the host.
+        tool_sysroot =3D os.environ.get('WIC_TOOL_SYSROOT')
+        if os.environ.get('WIC_TOOL_RUNNER') and tool_sysroot \
+                and os.path.isabs(path):
+            path =3D os.path.join(tool_sysroot, path.lstrip('/'))
+        return os.path.exists(path)
+
     @classmethod
-    def _sign_file(cls, name, signee, cr_workdir, source_params):
+    def _sign_file(cls, name, signee, cr_workdir, source_params, native_sy=
sroot):
         sign_script =3D source_params.get("signwith")
-        if sign_script and os.path.exists(sign_script):
+        if sign_script and cls._tool_path_exists(sign_script):
             work_name =3D name.replace(".efi", ".signed.efi")
             sign_cmd =3D "{sign_script} {signee} \
             {cr_workdir}/{work_name}".format(sign_script=3Dsign_script,
                                              signee=3Dsignee,
                                              cr_workdir=3Dcr_workdir,
                                              work_name=3Dwork_name)
-            exec_cmd(sign_cmd)
-        elif sign_script and not os.path.exists(sign_script):
+            exec_native_cmd(sign_cmd, native_sysroot)
+        elif sign_script and not cls._tool_path_exists(sign_script):
             msger.error("Could not find script %s", sign_script)
             exit(1)
         else:
@@ -186,5 +198,5 @@ class EfibootguardEFIPlugin(SourcePlugin):
                 signee=3Dsignee,
                 cr_workdir=3Dcr_workdir,
                 work_name=3Dwork_name)
-            exec_cmd(cp_cmd)
+            exec_native_cmd(cp_cmd, native_sysroot)
         return work_name
--=20
2.55.0

