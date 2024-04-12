Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A15C00A94
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 14:29:04 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.64])
 by mx.groups.io with SMTP id smtpd.web11.47372.1712930747503253846
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Apr 2024 07:05:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GiIoXEuR;
 spf=pass (domain: siemens.com, ip: 40.107.22.64, mailfrom: nicusor.huhulea@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbmBPzN8g3OyoYCGzwU5Hd3jNECYenoLww349F08faHp/zt8+LT73528BvKQyct3PcXm6ZAicuhMGfVgrVAl8OrHuERHtVf7YOA7HK8r9WdAjrSfxwAuUYwiVn0UddKuDqe1SYj/N9S3Ow2GRmLrWqLgjZSGvLwK6jlhCWQf8qc3bXckcvscphGY4VWeHoIxNzicaxMCChMsYE4H9lNXoNIZLNzQ9d4xzRgftjJ246q4aSLNnhAdLbkadSaN2sceBbwi+Jfknnj4hS7+MLIqXVHN92lCmhD2m+gRYB2pvaU4iwyIoc+UtG2Jy784TGfYOiHRvYkleqNaN3CJbMfUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McPoFajM+z7+WmjBKA1Kpgu8RsPg4pKhK/G9umnNXtA=;
 b=cMa+5DJrpXGsS6VU/cNk5VjKX3ilVszlFY4movYaqwesURBBgVklvMDU3lDixj+FdH/k1tIQkKsHv6+HKzA885VI8Ack/ZxKInmi5aM8gAhaXw3Z1I8iMVRtPlVTCSccelsFXD5hSuzFg0si7/4VPeDvNhclyBn/O6PhWshKsRsqRiW0GzxAJOHHCPMN7qIA4M1+ds6zcvDq1Qj7etL+VW/Dc44P2WzXsdrP4q4ybPlqHjVNEAQps0fH16Tg8KUZClhFNt5iU0++D7fBxUtNV9cLvZyrFnm3EC4nIPiRDDT7bLmFCQpKr7xW71tvTLK/oENowAimsVoaQRF8R5QZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McPoFajM+z7+WmjBKA1Kpgu8RsPg4pKhK/G9umnNXtA=;
 b=GiIoXEuRe4LzXSkZVZdm783NPQY/3V31BsUO+2/C3apNdGf9InoJCRZYZYP5Dj+jOQJ46Tx5V4GSoXbyf5yO6wwJyOyieGyAkYslGz4Qn7LL3PC1n7GdtnsIxBeOISEm2zOoA1FXjiBxrXzyGKeJ2pb+spl7+PYsrYvZQGWsEl2t3CPRUMv186OvxMoFvC4XHoE3cYd3fC25yDFELJ+6706+1LC8YftD0V8fAROWQXE10aFOOjpoIhcghJelaY1iJZ3EpyS4NoWcB8IGL30bhUerhatnkjbHBznngyD+7XER9TOTsV5wBO7luz/t6Y3saonKSNDMpDY8R8gL04SfAw==
Received: from DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:431::21)
 by DU0PR10MB7405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 14:05:44 +0000
Received: from DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::224:f99d:c979:4bf5]) by DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::224:f99d:c979:4bf5%4]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 14:05:43 +0000
From: "nicusor.huhulea@siemens.com" <nicusor.huhulea@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH] efibootguard-boot.py: update dtbs based on their deploydir subdir paths
Thread-Topic: [PATCH] efibootguard-boot.py: update dtbs based on their
 deploydir subdir paths
Thread-Index: AQHagUMrnPneANWZUECFFQWrLgndNrFkwXK8
Date: Fri, 12 Apr 2024 14:05:43 +0000
Message-ID: 
 <DB3PR10MB69084FE3C4AD6F2A100E9E28E6042@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DB3PR10MB69084A558EBBDDE5FB448952E63B2@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <DB3PR10MB69084A558EBBDDE5FB448952E63B2@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-04-12T14:05:44.357Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR10MB6908:EE_|DU0PR10MB7405:EE_
x-ms-office365-filtering-correlation-id: 8b1d9504-6d9f-4280-2d84-08dc5af9a4dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 i38wV8jJbR/pb0Gh3NOzmLYWSE4ozuMMlPyIcWfWAnNw799vMyFYUfltbGF2jsoY2ExLoTDHzxrJd6SgEM8baT6l0mWQWL2DNbG+tciXskrMV0LZSCCXGm6GJeRXudVClYVmu5LJE0UUaHHMlvQ4XHOjkPVnseVyqLLHWL3mLAmu1FBA2Pt2yIjHDAg1Ej76uzXVuEMvfFLYdp3SWxPr0cfZ6JgAI1jFWbUNEAh4MjJtbwZLeRvRlPckHhoLyRjx1IebIlgdMD7JZoqYYe9o8uwyHTHRkmtQTjlRk8ZsKnKIQrakvmxDw3NEqEwvNUCDYLjqRZH+hxJuoZZHI+jP0JSbEkQpuTMX1NqyrlgjDu4OTGZ9KPWQAposDVAvoHSmXs5stG40KGg/ED9NiVCOJhtvBP5sP5kuNqXoma71PVFW0aEAlaDrcPoVXkTSxz6sy6o+F51i8eSehbyGgU+IRVc7488ztBP+LmRJU8ueHk25oDdCuBGOYOdvp/zGhL9mjm6o0I7EiehFNA8TMqUH1wmBP2hmzJOLPg3rCqcuns+jWMSYhWvV2XQg0sxjY8UIPUpT4Gd6TBAYvDWljNE928odDCYXZFy+MZk84DVph2Q8qMfvSva/YfgIMMO2JjhAvGl53x9qMLJ6DcDN+DjyU5d4CgkmDaQ3z4vuI99L8XQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PFXYQgbcTVoR0Y9UJFBAUfrdziY0Zl+8InrHNikt8STHvocUDlSX8s7dyhqx?=
 =?us-ascii?Q?3f6erg3fnSzyjNGeSUUVLijD7ON2B2tav4I8d77Y921Ei1RTsa9idNeB4ZEl?=
 =?us-ascii?Q?0zFRbM3X/q3eHEuwf3j+6ThWo1vtRIRWjvXRipVNkP5mMZo3/bZh1vsGHby0?=
 =?us-ascii?Q?fOwVMjFSzwZ6UcAH1kIkrIKcyPRFIS6KuxBQOvcbnFyRJR+FfKGpqztOVrvo?=
 =?us-ascii?Q?xDIDw8FldBKY3tQFEQpdhFPEavhSXT9Usg4GREFTYFpJN3chez5x3ScE3+Vx?=
 =?us-ascii?Q?VBeNxvlZQha5ejMT1OKX+PGNlUOyaGT5gTbX2Ov6ik5G5pMbsUAeGbHTabQ8?=
 =?us-ascii?Q?n1pcqVSO+S7xxStXORypQ14w498b58QTfdbXevoaWHhI+1+IngWrwIh1OExd?=
 =?us-ascii?Q?N9MaHI3ZmG+UmhVMpQzo3RtvyFlF/bZQreJt5uvyKo6K88jUAp1vvm716vF9?=
 =?us-ascii?Q?AwP/lDfGJHvci5ofBWR+3UY+FkLP9wa0DHP4vjeFThr1ACVebe7sI2SB2CZ8?=
 =?us-ascii?Q?nL9YswTVA7GmneCP0MBrOe2njwQiIQiboNwbqTa/KAn4Tu7QbwU8oGXBxk/b?=
 =?us-ascii?Q?g2x63pCA2SvI64hMjkhk+D9ccqtaVDzK50T9gIcb98CejQm4P9Y0CEpa+Ddb?=
 =?us-ascii?Q?oprBDwyiDG8wZsVXkjwiGO/b75WfJoO9mnDQVa2OXjBCeF5+m9fMnwiRRS7h?=
 =?us-ascii?Q?uTHZdJ/LLE15W4UwVIxAM7bVz4hHTMAWmYYRkh0MhLf8nH5kL/GccbHAqkuo?=
 =?us-ascii?Q?d7+Zm+5Rnqp7eZYmjR1dsFj8dEGuFhNeWL+LNazELd+3CvD1n3RPoLb6RIx5?=
 =?us-ascii?Q?+EmLrTq4wmi7A26Z946DuHpWpGaNQoJiP/AF6X3+NieYn/Fj+UTo5gDlmJH5?=
 =?us-ascii?Q?MwnlascCLn1Q9b0G/WeIrn7WdinzIlsaqiWnjMUejL4KIG4l45y/0w2S28Sk?=
 =?us-ascii?Q?AqsHMIDEyHZdxgCwZV8gFQ9rqX3ieq0abamU6rSJnMvhh+DXlDfcwhC9FY2v?=
 =?us-ascii?Q?7Xnet05/WpCYvCa7oqJ+LHiLgRlzHcoMbnfhrUJoTO9NL/DR72IGdHNXEi+V?=
 =?us-ascii?Q?0EBTyCOTuewmhN7t5WPtQADpjmeh6oVUMta3xopDk8OoW9f3qqA9yn+snQYg?=
 =?us-ascii?Q?rLSwR+h3gGQitIaATrxTPxrKU3VbwNdsXS3O2qnpM9dzfxWrkjsIBdp++tqr?=
 =?us-ascii?Q?SxHkCTaGAUhzom6yWSAd1ZFxLXkhEF43C7eqe0waeEBYUnJhoHahHwGl9u0/?=
 =?us-ascii?Q?+PE6696aAGRyvwWS/a7OAJhK4IrkabdLfWUom9ieUH2IZuZ3lbSk37ZeNxZb?=
 =?us-ascii?Q?4SgymQqpJ30He3Qy6oBLDTkngyvw3s5E8TlhcgHDSL4WSBniSJ8pxmT96++x?=
 =?us-ascii?Q?LRAImN1vzt/tZqiZ4VXatpR0wRC78LBT4DE/wDp5MVU1c19zfEUx/AqiMIy5?=
 =?us-ascii?Q?TiGobhYjPtiyr9U48JJwAopMTbFV/3tfMSt1HX1RlLWWBnWiC/7uq97bLil4?=
 =?us-ascii?Q?ltIjx56jMPfjdfmKgYC+7WeTJT8W1g010UMgtAje91EWp2oPvXqpmVHmAEGp?=
 =?us-ascii?Q?4hBjnKHNT5fZ0oMoVPOhXO74fDTqhHnjwfsgXLf/?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1d9504-6d9f-4280-2d84-08dc5af9a4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 14:05:43.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FeRrUcr9R/3Lvz3P0Jqa4hAaJ5mckKACUQoSn2j2F5EsLTl9U3b7k+3zAGywUg1hBksLbogw0DBavDqLx1UXaeZ10AafMKQTtcDXiL/gF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7405
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Apr 2024 14:29:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15549

pass image_fullname instead of machine as there are cases where this is app=
ended
e.g. kas/opt/test.yml


    Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>

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

________________________________________
From: Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS)
Sent: Thursday, March 28, 2024 9:09 PM
To: cip-dev@lists.cip-project.org
Subject: [PATCH] efibootguard-boot.py: update dtbs based on their deploydir=
 subdir paths

This fixes the build failures detailed in the https://groups.google.com/g/i=
sar-users/c/Va0Ue-ISYeA and
https://groups.google.com/g/isar-users/c/PSGU_AcdPZ8
This is a continuation of the https://groups.google.com/g/isar-users/c/ZMD4=
XY4dKWQ

    Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index 4e3aefb..86e342c 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -181,6 +181,8 @@ class EfibootguardBootPlugin(SourcePlugin):
                                      deploy_dir, kernel_image, initrd_imag=
e,
                                      dtb_files, source_params):
         rootfs_path =3D rootfs_dir.get('ROOTFS_DIR')
+        image_basename =3D get_bitbake_var("IMAGE_BASENAME")
+        machine =3D get_bitbake_var("MACHINE")
         efiarch =3D get_bitbake_var("EFI_ARCH")
         if not efiarch:
             msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
@@ -210,8 +212,10 @@ class EfibootguardBootPlugin(SourcePlugin):
                 uefi_kernel_file=3Duefi_kernel_file)
         if dtb_files:
             for dtb in dtb_files:
-                cmd +=3D ' -d {deploy_dir}/{dtb_file}'.format(
+                cmd +=3D ' -d {deploy_dir}/{image_basename}-{machine}.dtbs=
/{dtb_file}'.format(
                     deploy_dir=3Ddeploy_dir,
+                    image_basename=3Dimage_basename,
+                    machine=3Dmachine,
                     dtb_file=3Dos.path.basename(dtb))
         exec_cmd(cmd, as_shell=3DTrue)

