Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25E4CD11DD
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 19:10:21 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.139])
 by mx.groups.io with SMTP id smtpd.web10.593.1711652985718531928
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Mar 2024 12:09:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZEwpT6Qr;
 spf=pass (domain: siemens.com, ip: 40.107.20.139, mailfrom: nicusor.huhulea@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXXM42PAQCSMpALehjJT/pn5aJNCbkuxxiahgVVDL7z+irQVbQjMxUSIZomGU2JVtOiZKum9htKpQ4dceG0rbHHUHOh52rb1IHlgGivGGDHMcLzc7RiXnkDFt860dzsBIdZW3WUYdydenBtU5DekWdR9OGlrEQat4i5hSL7riY+/CmIM5FRyq+WOmqKContg/3dphKFcOAupycY4TmzZyy31mo5zmiHAM3ZvK8hCTU3OoJGxDowkONohFtXEc+KO7af1piPUq3q96WQ6hWOpkBQpZqMaG9TEmfPqtjpFkY3dvn+8s9aNJlCnpZTIPyap+97dBEjN8iPGvUkkEJEYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuJNMC/qijMY+0eXm/Tf8G0wdc5erXH+hmjPmaRLYAc=;
 b=be0w7bZ3MiBnkLDhJ13SRp1cYwCHkNGMJ5yJ+CO3AkMZxjoHihLuA1fZEjpyIqmBkbjeUNopLucRKYW+8b8mmEkFGX3iVnEyLGjW+rCvTqPGeO6H2PGUVUKsw+rRHYcJ197LKMP+/+5tCPeks3zVPTiYiq4FOKqTesn5TUfxW2wl8uKKTqR6zgh+He1gaKkP6cXHq0LOreYqELXsPAlByNECCLzhn8lxELKBk+bdfYZ4OTFpCe1jeq1pjxrn7kFqTlulQASoKeCJ6b0Dygsa19jK2cQJLg9wr4sQuXBFN4dBlGw0HugFQUrGv858flXHlyYfmq3GCaEUGBB4xT/NSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuJNMC/qijMY+0eXm/Tf8G0wdc5erXH+hmjPmaRLYAc=;
 b=ZEwpT6QrRJDXS5Dl+2wKuKJTax0zvAj3PXXkfQQ+RIWxZ6TKhzmnOX85L9OD5Fs3ZIhqdhb7OhMMVRcfEKN1BD8/vIRsuLJc3tIsj671Ud4Vxkv76mchU/0rMLC8L1PgpxqoYSstHYcpoX+aw0h1quPUWmtty7TZdVk1+K0lWRUqc691Nnb8oPR/MFQAfRQYyObkwW3RMozQqeR97t8XOeTSTQBdLM+jDKalbSvVMRSD0VTY230nnE9ymcnM56PFf2ejo4B86aUsMyDMgf5yGXabi1VoBYDT+RHsRtLehwhrwoUpqzOPUYpjLZD1SO4gnb/LlWaJhdN9vRd/w83h/Q==
Received: from DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:431::21)
 by AS5PR10MB8203.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:652::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:09:42 +0000
Received: from DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::224:f99d:c979:4bf5]) by DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::224:f99d:c979:4bf5%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 19:09:42 +0000
From: "nicusor.huhulea@siemens.com" <nicusor.huhulea@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [PATCH] efibootguard-boot.py: update dtbs based on their deploydir subdir paths
Thread-Topic: [PATCH] efibootguard-boot.py: update dtbs based on their
 deploydir subdir paths
Thread-Index: AQHagUMrnPneANWZUECFFQWrLgndNg==
Date: Thu, 28 Mar 2024 19:09:42 +0000
Message-ID: 
 <DB3PR10MB69084A558EBBDDE5FB448952E63B2@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-03-28T19:09:42.339Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR10MB6908:EE_|AS5PR10MB8203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zgBdQDZvGXj79Lc3RdHROo1PM6bzfzpJ1CltPUU8VQ7JCTf1VG042cilLK4ZyDy9zSj4+9wTTFQcIUHk4itChMDKJxv8wkWtsEL25JgmIYlUZSOlPZVzmX+7zEjk2eOIAItTlnJ1sA87ewIzxkprshm7uvBxKwL8YyvLZHXfrJ2Mty8PcnwSgK3FWdgC11rJr/DnUwr+y916EAkWn7s99jNKW6sYFvYK50NfpSjZ4OGTedtfYInWh5OH7jzJXNdfx65RyvcNYFVXd5A7vwRUwGOXlkB9xCiSWn+FIe/kReBZTvZaTPbo9hE3Z2jJ1m/0JOY7eOF91+3MeCnd10gGlAOSsG3NHllNKxaMVJzZfmFNvj/x20oRipqDfn69p6e0QW+NbVlxnccPCUDGUUcMbtCWNto3qijSELVh+bVJFhjlnQI70zEyZrkORDsNKitb/jCP0tHRgtGlWymxYdbcMNM7eqiRP9iSNkXIOMQwrOZ6siyGe4WjjsazA1/dKs/1zWv20M25sHccTumkUDNJJHdj3mOlOArzYhmpzWK4zefdXrEe7+QeUJt5PQtWR1ZIaueUy7KylWr7qNHKtgAOXn4DwhUbsgdAqZ4ZJgWthmY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?JSuH+s7fqq5Hq9vN34lFTi+Hyp4vegQMev0187phyh/VLRtylvpWKLM182?=
 =?iso-8859-1?Q?jU3UUMtB7eK8H+XCpP6D9GrEodqNfbrGGVSys44ABxzY9+9PFcYQBQOzci?=
 =?iso-8859-1?Q?G46NcWd8yg6cVYHZ9JYmqBwEjXTaDteroL4pUap8c1/pqNS0Ux56JmRWb0?=
 =?iso-8859-1?Q?M1yY5w69/tHunvRnSq/cf0VROdP8sS3U2x3wy0UovGgnHvgdGl5Y92k90O?=
 =?iso-8859-1?Q?7xDZUbgrNqWhabmTvAus/cyr3deByH92AhoWZxyWEF9p1sTjJOjCBCBkuS?=
 =?iso-8859-1?Q?UaXgKin1YMabLyJIuhWbpwpzB/ZPSNy+m4w02BKD5N90wMEQQMbq5beE0Z?=
 =?iso-8859-1?Q?yDtbxxV/TA+y5jr0FXel2RUZmbqMi0/12aOxQGE7VMwONxrUsJYTSNCxNA?=
 =?iso-8859-1?Q?tmDFSKSJ3uV4b99kplkVJ6d6rNFSns1nTy83mqgoooh8++hZc7CaWMfKts?=
 =?iso-8859-1?Q?LrPgGJL1H+ZdVcI57YpXeSpPaffJ7E2qQ47aXaRIbBghtnrGHghgBCx4NO?=
 =?iso-8859-1?Q?6Cskyt/1l8H0YRlhx1nzR9IdZxTYtP5JZjKKUnXu+8V1sfwfZjaqPOphe3?=
 =?iso-8859-1?Q?roYHwQ9vnyxJY8KvEg0xHaFOquvsp4HACzraW5r81iqmKQ7PzAx5a6lcSn?=
 =?iso-8859-1?Q?Prrz6fWA2RbDdSl3x4Ta4WwprU4qyX1ir7SeD/1yuX9TAe44XosdCpBKzT?=
 =?iso-8859-1?Q?hdqFS1paAs7FiUWg3D2NfR5tksDKgY0EG3zGfL23ib1Wtv5bsKkkyUZUQH?=
 =?iso-8859-1?Q?AXcLb6AXLY0wtFSyWojTW5zRiEgBtlBcZ0DW0JXWZb3wALjW2WzEqJtFdv?=
 =?iso-8859-1?Q?F46DcAZR2zLRL0HJcWkAx3VAK651FZIW5WyCuDXE7gfxzark52ruRQEVqK?=
 =?iso-8859-1?Q?sl2FX4SvhfEY0roeglHz+BM0H+4zmbKe0nUVPM4TufOQBtGIFUAZVijISe?=
 =?iso-8859-1?Q?xezCwUnhRcRvIoboXED/rFhu7IXDo7qouoO0eFpZq7eeuxXO82GsGvozpw?=
 =?iso-8859-1?Q?CbWw4T+UgPLCCWAH/WiVcZr83M5YA/UOGnLQw0HMvxA5EF5HrZqAP4pGzw?=
 =?iso-8859-1?Q?szLD0pXXH6IAqL6GsjDul2x2MHYUzL1EUtqVPrlpR3NTsXZp6FysKHU00y?=
 =?iso-8859-1?Q?vC2knoY3xsWUxMdkPnm3UM1j4gnP0o5l3fSDkK21mnq8x+cDCYENP6ckst?=
 =?iso-8859-1?Q?LbO6neRjbbPLkC8B0FiLLBM1wTSNh8mb+hrECyhM3zLxAYM5F6mEc5lpqw?=
 =?iso-8859-1?Q?CZ8Q1fL8gfxg3mhl8zT6mOtTPGn0ccix8Eo0U41UwM53K3+cuMWYA8rBjd?=
 =?iso-8859-1?Q?SWV9HkBmsJjDirlofhFIONBco9BchgR76umygyOfm/hhlKoWdQ+Kj70dkY?=
 =?iso-8859-1?Q?FMUPJpVq2Dz0qGkxG0pICfH7KvMr6r+dBP8hgxoxpFLEODTk/JGX4jextd?=
 =?iso-8859-1?Q?55ijuvD8B8fp3MTnKegtuPo/tFHyB+GJbxUQ8YBuETxmWt+4G9c8f1NHMP?=
 =?iso-8859-1?Q?z1tEl0f/lsCSm4spaa4I6k4Umv/7rW1UCTZhFkyIPuMUzsnsS+xiNhFEji?=
 =?iso-8859-1?Q?yJpRobixmzmym+MUVvD9NrZXf3qZ5j6ulFxo3em+slrJRFufO/JoUlpcWu?=
 =?iso-8859-1?Q?4LLPXPuBos8nO2SyLigUZGOxWqe7ww6x9l?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e6fb1e-244c-473b-0d92-08dc4f5a9faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 19:09:42.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M14eozZ83bezoriTH1Zo9pP91s3twvRr/D8FVEUbSNzeffOdT+G21OGsq3BuP7gTKv9B+Hv263G66gXR3OydhVvMr0tIKxpVGA8Acm+y9FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8203
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Mar 2024 19:10:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15479

This fixes the build failures detailed in the https://groups.google.com/g/i=
sar-users/c/Va0Ue-ISYeA and=0A=
https://groups.google.com/g/isar-users/c/PSGU_AcdPZ8=0A=
This is a continuation of the https://groups.google.com/g/isar-users/c/ZMD4=
XY4dKWQ=0A=
=0A=
    Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>=0A=
=0A=
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py=0A=
index 4e3aefb..86e342c 100644=0A=
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py=0A=
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py=0A=
@@ -181,6 +181,8 @@ class EfibootguardBootPlugin(SourcePlugin):=0A=
                                      deploy_dir, kernel_image, initrd_imag=
e,=0A=
                                      dtb_files, source_params):=0A=
         rootfs_path =3D rootfs_dir.get('ROOTFS_DIR')=0A=
+        image_basename =3D get_bitbake_var("IMAGE_BASENAME")=0A=
+        machine =3D get_bitbake_var("MACHINE")=0A=
         efiarch =3D get_bitbake_var("EFI_ARCH")=0A=
         if not efiarch:=0A=
             msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")=
=0A=
@@ -210,8 +212,10 @@ class EfibootguardBootPlugin(SourcePlugin):=0A=
                 uefi_kernel_file=3Duefi_kernel_file)=0A=
         if dtb_files:=0A=
             for dtb in dtb_files:=0A=
-                cmd +=3D ' -d {deploy_dir}/{dtb_file}'.format(=0A=
+                cmd +=3D ' -d {deploy_dir}/{image_basename}-{machine}.dtbs=
/{dtb_file}'.format(=0A=
                     deploy_dir=3Ddeploy_dir,=0A=
+                    image_basename=3Dimage_basename,=0A=
+                    machine=3Dmachine,=0A=
                     dtb_file=3Dos.path.basename(dtb))=0A=
         exec_cmd(cmd, as_shell=3DTrue)=

