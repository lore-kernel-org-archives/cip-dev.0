Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C6C00A94
	for <webhook@archiver.kernel.org>; Mon, 15 Apr 2024 13:15:27 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.50])
 by mx.groups.io with SMTP id smtpd.web10.20689.1713186873109320557
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Apr 2024 06:14:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LXJuliz5;
 spf=pass (domain: siemens.com, ip: 40.107.8.50, mailfrom: nicusor.huhulea@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSPOrCBFK2Xy96KLDk7U5kySG9F5Mb53ttwU/o8ZfFjc4S5TYXZ28wuh3rFvuQ+R08GRiyZCUQioUOWdAy7+5zMxl+Ve47mnES2PJR6ZSsUi1myLQhKAvQcIJloTw2V3Uw5duGPWgO1ADYdac2XNFtDWNF/rDb4dxV4wQ52N8JePuuGA+/xNW4ZcPRLZ+TiWErriXaZcINpZNGcoh6gj+EOFbWAbwbttIr8bJGDQ2gUa/D0e9r18b/u7E52pqWU4oZFLiJVIq1EIZy1juBoF71ZzflnUH72mfeZppedgsYTJddKDXxUken3qianzPorbsC5D8gU7pYIXR9ZEZMQjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZFpkAkCKeHy5gAgynKtSjWVLWOHWQs6yzQrnTQWl+s=;
 b=J8ZXLdRV1Ois2AFVnVCqQ+WjxSYqklZoDeAy7yWXSbEk2NPTuUxk1R4MeTndbdX/J2gy8yvLaAKGTjgirjwKUo22r8gdJrq2lCuhAH8NFpxO2uKzTmcQ31UEfA67ZrIKXw6wKyBJDz4aHIUeXdqx+ijdon3v8QKbr8dxyimj483tSdp96kal/Ilds7g37ioGAk2+rJvCXVa4wHNbebLYy4n2QZ9VcbT1rKnQt/XnaHJ5KBUtRG2xdcrCBO47dI+DKrOYNMrwNevlcLqHZLjGf91EuCyjJ72Xs0epehHcCoL2kJa6U2FtCBm4SzTTLvJZ4LIp9BZToWjq36o6MnZu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZFpkAkCKeHy5gAgynKtSjWVLWOHWQs6yzQrnTQWl+s=;
 b=LXJuliz5nhrUxlqBB3f0R8Cygg/QbP5VDNUYMHt1F4b30mqgFZftGwgW0oSPetvm3W3SQLWa9o4NQ0AaDcBtNbcogfTlX9mCfAgvmlCfkM1F5dR/Zavc7IzP63y5gr5OvlJWSUcZog5Y6PriMEiZ2zaTO4J+i3xKFnUkhwcyzw/PYKNVJb0GmQgFZcb4csbQkY6kNb+EoHxZns7TAA6d6tIksE5SHmId2yfyjkJUHYkH1pa+24TkrGNbuoVSRPVFkP5F7IfPZwemXJ5fk43ETwlV+fkMbOKzjeF0NUDJLphuiOklMFLcAzNm4VxrQ9v/rBKNmotkkRPbPCIU1Vmnlg==
Received: from DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:431::21)
 by AS5PR10MB8148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:678::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:14:29 +0000
Received: from DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::224:f99d:c979:4bf5]) by DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::224:f99d:c979:4bf5%4]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 13:14:29 +0000
From: "nicusor.huhulea@siemens.com" <nicusor.huhulea@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [PATCH] efibootguard-boot.py: update dtbs based on their deploydir subdir paths
Thread-Topic: [PATCH] efibootguard-boot.py: update dtbs based on their
 deploydir subdir paths
Thread-Index: AQHagUMrnPneANWZUECFFQWrLgndNrFkwXK8gAFMQICAA1ppYQ==
Date: Mon, 15 Apr 2024 13:14:29 +0000
Message-ID: 
 <DB3PR10MB69085F383DAE201100F503A1E6092@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DB3PR10MB69084A558EBBDDE5FB448952E63B2@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
 <DB3PR10MB69084FE3C4AD6F2A100E9E28E6042@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
 <ebe541bc-8325-4899-97bb-3993c1917a47@siemens.com>
In-Reply-To: <ebe541bc-8325-4899-97bb-3993c1917a47@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-04-15T13:14:29.575Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR10MB6908:EE_|AS5PR10MB8148:EE_
x-ms-office365-filtering-correlation-id: 801d5b61-0874-4edf-6843-08dc5d4dfbc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xQsb7261ul3E06LecNOxSfHqoNDEs6s33dshHB9ZKFgZGQChQ48Mbq1E0PFra2Wk/0SwEGp2xPuajN7XIf2UNPmDZ/uNpzjhaOcbct/Kk3qPypSjpgewwKzWJV/7zDa8siX3ZQpVrdFKWrlJvlwuyL8i1UQNWxZqsCPFr5veGfTSEnh6HfK4uBfvl6meBLjkedumsfwnFfQsWyEF+RQOOmt/LxV395zZ/S4CpJaeDFG4OfhRfkCElpJ40bkjgMh4yXqL8n6zTlO7jh088VHlZP0cma8ftF/lj+vJ2vv+sVswPXu4ZfnvrpjdkZLVu+Z2b5sn0nfYgvxk1ewJrodbgEuz7g0bfgQjs5lYsrP9yseOw0kwsHLIRULKvVxZuVwR8t36Io7MmC/pgmFSzIlnmDnFqt8L3ffH4PpJAsdLYTmfHutpJPLhLD3CPt8QR8cPu0nPDwjY1nqHeGH6QSbiMTi1JUsiJAtKy1qOCiuUBF9yhmeKwjuujPzoB7QGAcU77FNFkvszO/TTauEsR0s2n2eJtkW5OSoymWz3FhaLm61nasYBaqm2HmeUaE3Rk+9CEP9RIBpbWHXw4xIlUpuqxg48VEYT5sbeaaA1lL0LO3gDdVPIgnzcY/kt4mzKbLj8scZjD5qNPSBwZxJ1z26QV5cG71Y649/s+/3Q7CKiU+w=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+rMo/Q29uVAos39kZyxeANdwkv7pCvy/9FR8HlDHnN4fst1SW81Z5I9f8Ggr?=
 =?us-ascii?Q?RZ33+n1335tCWneGjjrxaIY0+Y3hln9bXhKEJeTtkhy7o9mwDlkjJ6GvXYyK?=
 =?us-ascii?Q?CRmmQszL/Is8FPmQ1ZfOXPEW6/AMR2WBIkg2l8T7yfVBl1SOx+E4dEisCj4T?=
 =?us-ascii?Q?fbtppbgt9RaH9PI95x1+BXxO+YAD09D1ykCGPiYhfz7PkkL0/RDr11CyQgHw?=
 =?us-ascii?Q?UNsxieObpcYlERtHgPuNA5wca//H/bcP76SrWDlpB6Il3pg+V9k3sPjrk5kX?=
 =?us-ascii?Q?pXf9L+sR8kqFjd/ruXge44eu19x4VLyGWOVKtkYba4gedePZCGD5EPgoOU1h?=
 =?us-ascii?Q?7xyK/FDjfCovVfc1YRC16MZ0g0S2efIZ/xTHeyv6L2+AVdcnufaOY6dPWHhH?=
 =?us-ascii?Q?5EuB9zNvokaWFqWBOcM0bOiEZ7JyLzZkrODJtIDqKnhK/vi9Gin9lnuQ2Ich?=
 =?us-ascii?Q?KLtGpZowp+kEATjAwrTnfEAa9QRRQkMte3N9OCTGe+gswnZRCrXOsyc+Ce2h?=
 =?us-ascii?Q?gh0Q6eRBRcxcE4WmK8HT/0Z8xk5NKAARiRbeq22jslp1wY1Sh5+k/tAexgCc?=
 =?us-ascii?Q?VeZG0SSSVXLpKp2P1NcU8iofWr9HZcumWhYs3/H9Ven1fAQ3ELADI1VeNQKj?=
 =?us-ascii?Q?WRrsaIm2z0DR2E5K9WLHAs6r5kI7FGfthEz3yOjB6I9E7rCSkAm5mLFAJ2qv?=
 =?us-ascii?Q?Xl91FtE1DnjcaYkrqruaqLBpdXTcmAlXaFR2eORbmwefiNK+6fAe/cJk8cq1?=
 =?us-ascii?Q?bSJhVX+xeunRabh1wR9CkEr+6PQJPw7m8DuawO0qZl4I9SIoa0jQonG6H968?=
 =?us-ascii?Q?zfj1jNP46tFSQNdlnYaw4QIj+SD/zOJjM3x9iZcwRdn67FyUyxajP7Axkvow?=
 =?us-ascii?Q?Sh7DcEyZoS3YZOP+L7O9yXmUgJiAiizrLpDtuZPUAV6DTN5EIj0LF9GkFcBx?=
 =?us-ascii?Q?33tNmI2DcKQgmjfD3ZIg8eI/bnEGu3IAUAfVrnPr3O/R1Xdvi0WvqnjafGID?=
 =?us-ascii?Q?BKPaRfKx8+SNG5QG8Id+5RtA5Zw6Q6b4kB47Li/Y+bugRCAActVoAHUb28zN?=
 =?us-ascii?Q?Pw3rgMq+DwRY2/8iZU3X+gcMwuDhASMmvguBw3RjuSkX8E+1uGVG10JX80f/?=
 =?us-ascii?Q?1BUOwLZ5OnDJMtYHBbtln/eb7W+YphY+TWekeIgJ/hzQQnwREcpGYJXQWizd?=
 =?us-ascii?Q?WK96/h/3YdWnhTUPWMtXab8C5fpAlW7R7cvfG2Km+GVPyhixUrRsY+buaEf0?=
 =?us-ascii?Q?P476GPVJHN902k/PP6ttLh972FXMyloyiRyocRATl4JYIshrH6YqWpu1Ilvg?=
 =?us-ascii?Q?HkmjGkUe35NQOgzRZ72CZrhbKVCG/7m/CcIMLxwz9d3Ks4HuRn04f2zuMzBJ?=
 =?us-ascii?Q?umpaQ19ftw5M24XkBTaU6EvSaijhX8ASnfD01Hb832Yjk0O+GDT2ylb1ErAz?=
 =?us-ascii?Q?OA4HrdfXaUU29xSKq5KIqd/022s5d/IGesbNQ7UBOq4jalHBRP+pi6e4Fo/H?=
 =?us-ascii?Q?4qqK7C6RBQ/i1TCRq44bzhZa6C1E0dVOZIY+lPCevT9vb3cU4n8mXOVPVkDb?=
 =?us-ascii?Q?JZcoWF0p3cyKWQWt+iyRYh/Zst8D4RYO6e/rz+bY?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 801d5b61-0874-4edf-6843-08dc5d4dfbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:14:29.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsubYKxbomS79UOkk7sU0wKFbQsU2sQCcqIdsi3oy8IggMV/Kcw7ul3SCc4rjdaELlVJAuwfGXE8ZRATm+c86vfuk1ywFqgKbkRA9JGtK5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8148
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Apr 2024 13:15:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15562

fix patch formatting and will keep this on hold until the isar changes gets=
 approved.


Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index 4e3aefb..9451f55 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -181,6 +181,7 @@ class EfibootguardBootPlugin(SourcePlugin):
                                      deploy_dir, kernel_image, initrd_imag=
e,
                                      dtb_files, source_params):
         rootfs_path =3D rootfs_dir.get('ROOTFS_DIR')
+        image_fullname =3D get_bitbake_var("IMAGE_FULLNAME")
         efiarch =3D get_bitbake_var("EFI_ARCH")
         if not efiarch:
             msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
@@ -210,8 +211,9 @@ class EfibootguardBootPlugin(SourcePlugin):
                 uefi_kernel_file=3Duefi_kernel_file)
         if dtb_files:
             for dtb in dtb_files:
-                cmd +=3D ' -d {deploy_dir}/{dtb_file}'.format(
+                cmd +=3D ' -d {deploy_dir}/{image_fullname}.dtbs/{dtb_file=
}'.format(
                     deploy_dir=3Ddeploy_dir,
+                    image_fullname=3Dimage_fullname,
                     dtb_file=3Dos.path.basename(dtb))
         exec_cmd(cmd, as_shell=3DTrue)

--
2.39.2

________________________________________
From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
Sent: Saturday, April 13, 2024 12:51 PM
To: Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS); cip-dev@lists.cip-proj=
ect.org
Subject: Re: [PATCH] efibootguard-boot.py: update dtbs based on their deplo=
ydir subdir paths

On 12.04.24 16:05, nicusor.huhulea@siemens.com wrote:
> pass image_fullname instead of machine as there are cases where this is a=
ppended
> e.g. kas/opt/test.yml
>
>
>     Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
>
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/script=
s/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..9451f55 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -181,6 +181,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>                                       deploy_dir, kernel_image, initrd_im=
age,
>                                       dtb_files, source_params):
>          rootfs_path =3D rootfs_dir.get('ROOTFS_DIR')
> +        image_fullname =3D get_bitbake_var("IMAGE_FULLNAME")
>          efiarch =3D get_bitbake_var("EFI_ARCH")
>          if not efiarch:
>              msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n"=
)
> @@ -210,8 +211,9 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  uefi_kernel_file=3Duefi_kernel_file)
>          if dtb_files:
>              for dtb in dtb_files:
> -                cmd +=3D ' -d {deploy_dir}/{dtb_file}'.format(
> +                cmd +=3D ' -d {deploy_dir}/{image_fullname}.dtbs/{dtb_fi=
le}'.format(
>                      deploy_dir=3Ddeploy_dir,
> +                    image_fullname=3Dimage_fullname,
>                      dtb_file=3Dos.path.basename(dtb))
>          exec_cmd(cmd, as_shell=3DTrue)
>
> ________________________________________
> From: Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS)
> Sent: Thursday, March 28, 2024 9:09 PM
> To: cip-dev@lists.cip-project.org
> Subject: [PATCH] efibootguard-boot.py: update dtbs based on their deployd=
ir subdir paths
>
> This fixes the build failures detailed in the https://groups.google.com/g=
/isar-users/c/Va0Ue-ISYeA and
> https://groups.google.com/g/isar-users/c/PSGU_AcdPZ8
> This is a continuation of the https://groups.google.com/g/isar-users/c/ZM=
D4XY4dKWQ
>
>     Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
>
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/script=
s/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..86e342c 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -181,6 +181,8 @@ class EfibootguardBootPlugin(SourcePlugin):
>                                       deploy_dir, kernel_image, initrd_im=
age,
>                                       dtb_files, source_params):
>          rootfs_path =3D rootfs_dir.get('ROOTFS_DIR')
> +        image_basename =3D get_bitbake_var("IMAGE_BASENAME")
> +        machine =3D get_bitbake_var("MACHINE")
>          efiarch =3D get_bitbake_var("EFI_ARCH")
>          if not efiarch:
>              msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n"=
)
> @@ -210,8 +212,10 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  uefi_kernel_file=3Duefi_kernel_file)
>          if dtb_files:
>              for dtb in dtb_files:
> -                cmd +=3D ' -d {deploy_dir}/{dtb_file}'.format(
> +                cmd +=3D ' -d {deploy_dir}/{image_basename}-{machine}.dt=
bs/{dtb_file}'.format(
>                      deploy_dir=3Ddeploy_dir,
> +                    image_basename=3Dimage_basename,
> +                    machine=3Dmachine,
>                      dtb_file=3Dos.path.basename(dtb))
>          exec_cmd(cmd, as_shell=3DTrue)
>

This is not a properly formatted patch, plus it seems to change to a
path that is not in sync with currently selected isar.

Jan

--
Siemens AG, Technology
Linux Expert Center


