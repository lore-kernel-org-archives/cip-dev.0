Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F6EB64DC
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 11:59:40 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.75])
 by mx.groups.io with SMTP id smtpd.web11.16515.1688629005202135194
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 00:36:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ASfN4HRi;
 spf=pass (domain: siemens.com, ip: 40.107.13.75, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZUwCIecm4A4dNIkBCjcLW8vpPkj74WxNWsQAeCE7/wIZrp9ywJrtY8RdybeMUD2glNKMiYDQufVE6862h/pvWX+SI1LGUcAqAKDD5zhMD55LhjALeGyIdMYgXnC85qeVHJbpScnI8yLU0GiKf30akBYAZIf3HDnSqiBDR6iXQkRGonSxpkp9CVy9CkRqX1AuSC1DeiRrJQUUsJnJD4jzVg0dBUwrF4xoL+7L4L6BhDBr0QbZEDyd9PZm5vG4I9bsq+EPCvMN0xwpgGzH2AMDB1SLfytvsITONK0KS2bHqq+OZkXGeBoBDlYsayckL1Cb/loHYvNJHUQgvmor4vAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K+zjfvYzazfw9mCylKVIu8hdELEvK5TIqWU3dIVVSA=;
 b=jylsKmmcxQ6K+C9mjlR61JYptneDzT/aFHmdxfap2YwmyZlEo9pIIjKl5KcOI0JrsXGy6PopjcEiowhGZwmKQZmQxG8K506MbGcT83Rh6XBQtwfdybeZvCewo63tWTvSdXS6vO7dx8FOUS24mdgf1XPascdGqiNTOwwQZah8qqP/ncJ27oZSquL16c4s/MKgNjQp95djPB3B1ewn9YeaBuFjCx/oHLEYwKO9poHMcVJfyk/KOXpuRyxWnYDj5LCMitXwuoaoml7Er77/zXCL1PlD/FEP0BUUICm+PWuJiTYraEplHUv6gmxRJUpLyyUrapdRnU6chZlpljikoAkJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K+zjfvYzazfw9mCylKVIu8hdELEvK5TIqWU3dIVVSA=;
 b=ASfN4HRiFKiDtTTWVVNLnj578SmDbc8XI3ssfyF4XoTyLOxXy55nIuA+aiAKZdn08DKdzaiYKiqJG/ilZ06hAsovqZoYx7wYaswBy76BZ1la4Z2CuGldLclkiYBVIN947gXtYHUvNgGsnVhFD5Xh7OoKqcfqwHeAqrqCJuReYMeFkEG9xMnKZBgMDMncvMmmrad3W2IjIoa6yy8A9uhwcSgruLzqqC1o08S6nPr/DwL/Nn/dsQ48mNyszEUYtWdDqoRrmskz+o2tvk/8zTPuj9662xxo16swE21SW8gKeI7rb5Jjdft8W/GWbTILpZyMUUoEyWPi91GPstMuyV9qWQ==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by GV1PR10MB6290.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 07:36:41 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:36:41 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Sari, Sercan"
	<sari.sercan@siemens.com>
Subject: [isar-cip-core][PATCH] fixed function names
Thread-Topic: [isar-cip-core][PATCH] fixed function names
Thread-Index: Admv3Gzyy9lEAFMSQPS86T5Sadj6gA==
Date: Thu, 6 Jul 2023 07:36:41 +0000
Message-ID: 
 <DU0PR10MB6898F7D41CCAC462227AE2F7F02CA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-07-06T07:36:40Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=5dc1b2ed-2460-4b63-91e8-42d345b14113;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|GV1PR10MB6290:EE_
x-ms-office365-filtering-correlation-id: 3293f365-4261-4e17-b9b2-08db7df3bd6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4RlX+zZ47fBdiYQRHM0XIYiKnr2BrukM92IzSp+P5DbLh3Kss3AMirfrRMVDdFIUqULUHDY5qvgWYPPpYj2phW7PPZ5NGSLXOXnEBOWX2QcZQO327ZpwlalfJskQnhUY8puJGyjs3vkIOm23B+FPWl5W2ZClp2qCuyYSyXZ/vMddMbBEDkzvokBafVxluGS6BzR19duQzWfUvISe3cusmH2G3Qo4BOUx/cLecOSMzA7BaeWqpPti9S+AqvWpoGfYjWytm3feuldQI3w3KkjVmANE8jTZhDj1Lzc0za95VLCViG590uksSfNMrnchpkIjnWZYYDBqyTXZP4oKzJX8xh9lO42puJabE9Q4daVdtfe5USEJx+yfpcNBCw605tAHvsnvDN0GTVSCDOF91id5R1/Fl879KUsHw8t9qvygwxkzufYMGoMZfhLkmeD2c0zg/p3tq2IWHzx3qmTV7UY0iVxxRgmRWMZmKUhhQlrAMMyIuA16UWrYWeaKvNTis7Gv4k/iq2fgeVQWvnndbb6ok8UVKxlkUVVRX7hnehd5fSXnfD9r/4e0+utYLWVjz4EcaG2RHmDr5tnNx1LKvV7WcEsnOLX1SNLG/z3A/shzEHWPWqcO+ypHZjZG3nQ9yJcZ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(83380400001)(26005)(86362001)(82960400001)(38070700005)(71200400001)(186003)(6506007)(107886003)(9686003)(33656002)(122000001)(38100700002)(316002)(7696005)(8676002)(52536014)(54906003)(8936002)(478600001)(55016003)(5660300002)(41300700001)(2906002)(66476007)(6916009)(66556008)(66446008)(66946007)(64756008)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BdVGShVROAyk8CO7ztDyHYNk6SDRRLSLEkBNVhAErO9kf4/obR0m4EzRwKw0?=
 =?us-ascii?Q?w4gJBJpjsKI+2gdup3Sm2c0GDt1v6rVeFWY9CduPDq4Cl/AFR/P2xoUQPVHc?=
 =?us-ascii?Q?4bcreX71dFAspa/yUlOmEryBLRcL6x6rmHI0zC9npw+ZhiOk1dAdr1s0q+Su?=
 =?us-ascii?Q?dbjZ0ACP+dmgkgnvUEVZ3X+Rl2vpIwP4wQlTh/53rh8PDWX+DnA16u5dP7t/?=
 =?us-ascii?Q?u5MZM2TzEbuqRj96NLoXCw51DFviiU4Fcr90KK1sXqHeNocqXf66ZVRrba4m?=
 =?us-ascii?Q?kjspoNMpNoLuKAMGvQw6ZnOgEJiQ6O3j+5rjZdyH9upxosGU+2uPyeyzsl2S?=
 =?us-ascii?Q?JXI9pFhy+iAzY8QVBlaDXgkXeUxlEM+4UOJm4ZE0T7rnC6TrnbR67Mpgh5kL?=
 =?us-ascii?Q?SgB1KvOFhMEESWRXaSY+hj+Tcc4wg0sJe8dcfpr285zCsmg2Q65heh8g6Fn0?=
 =?us-ascii?Q?YnnI4eFLG3xgt3mrB+XdCKRdTFTjoEdf5Ziuj0vuppSD5sbCZMXP71KmYYDE?=
 =?us-ascii?Q?YCLjk56ewHH/ybRmpmTrx9pPOZx5ifKePAKfntwQCBz+D+DGpHYR1IEPmfy6?=
 =?us-ascii?Q?0utOrfoWzvuYfwkLYRV7bDTO5KPsgAWfIWWGz2tWYf9xFadZ0QMMui6eAcH3?=
 =?us-ascii?Q?sT3xpvkQ00tPtdU/aFFY65Y345d0nebU9seXn/ii2L2cvB8wAWFDBIX6c+Mu?=
 =?us-ascii?Q?iQwgP4diVRxF4XKqe5OHQj6Mtylr2MBBRXJ47yg0oupORHxBI0aZizsdjIMY?=
 =?us-ascii?Q?DL1wG0OPPWL1VOjjUdfgi5jqogt90TQp6GKCMz3yJQ/k8RIzt7rALnZN8MdU?=
 =?us-ascii?Q?8XJem6NexsmDoJCgv7PQ0zLmioXpOSCazM/dqkcNU8mwmZ5tpstKcoZz2i+x?=
 =?us-ascii?Q?QgXFIaFrIJ/pEONYWCGQBpguhCEhq/2RTy8hZcnhs41dTRi69O/AHUpYqQZb?=
 =?us-ascii?Q?AsjywcYHM0BzcuCHQ0xxCJqHGO3D4qI5TzGTIxD7gwGt1muUH0jndgk++alZ?=
 =?us-ascii?Q?Qw3rMGExsogECOLnfQB5HY3GkttsUAdxnVC5VbkP6spnZ5uNCIDfRfUdtDPJ?=
 =?us-ascii?Q?FoR209HsMBnr3IYk5AvKDhKO2K5YpRsW2QyfjjPq6UDW5Dk550kyOTGU4Pkk?=
 =?us-ascii?Q?dj1Zal+xTB37nv8whgmh9vGmmTvYIcHppsdEw38xAaboSqO7w3JbsHibEye7?=
 =?us-ascii?Q?J7ej8jGMUvqSpsBk+DNY0aSK3j2tMhw/r3C5Fy34ZB2qTI9mVU04NK8/9n+x?=
 =?us-ascii?Q?gWSbdwz98WNBt2F3HmAijUDZXQ1A9qxQTIZHeCY+TKwfzK942+dw6kH8eUIk?=
 =?us-ascii?Q?s3Hk78PN4lfaTHCCPZ6zX6CZk8kpxa0tX0Il2aFzBdo0Sp8i4XT7oDDwQCg2?=
 =?us-ascii?Q?sZsL/iXW6i8s3cZpwdQZxoL2GSBSSjK1nSFeGV+Pp2rdcG5vggKozC9eMtMK?=
 =?us-ascii?Q?8gpTWA6ChaEt/VnX6Pjr4IOVQl1pyiwz9JR07K5Ei0RV5GmMwinCDFKe53AU?=
 =?us-ascii?Q?ydF3pRTQYVENrW8ifxhrPVClW6YN5N5kZOkuBRTJaxJU/xl1hsKfSxkJqgZg?=
 =?us-ascii?Q?gQeZRc9i1azfsVwQAfy3omr3ry+m2tRRhbw+AjVr?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3293f365-4261-4e17-b9b2-08db7df3bd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 07:36:41.1473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WBJVfj+nw9NE66BkA+4uhUf2+qaENcg40b1DhSAOyet08haCmdhFli56IwRYBUrZqCQKHSOypd4if3ADjVUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6290
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DU0PR10MB6898F7D41CCAC462227AE2F7F02CADU0PR10MB6898EURP_"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 11:59:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12258

--_000_DU0PR10MB6898F7D41CCAC462227AE2F7F02CADU0PR10MB6898EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fixed typo for the function name open_tpm2_partition, in encrypt_partition.=
clevis.script and encrypt_partition.systemd.script.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com<mailto:sari.sercan@siem=
ens.com>>
---
.../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2 +-
.../initramfs-crypt-hook/files/encrypt_partition.systemd.script | 2 +-
2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_parti=
tion.clevis.script
index bcb5a04..5d7124d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
@@ -120,7 +120,7 @@ for partition_set in $partition_sets; do
                                           /usr/sbin/cryptsetup luksFormat =
--batch-mode \
                                                           --type luks2 "$p=
artition" < "$tmp_key"
                                           enroll_tpm2_token "$part_device"=
 "$tmp_key"
-                                           open_tpm2_partition_tpm2_partit=
ion "$part_device"
+                                          open_tpm2_partition "$part_devic=
e"
                                           eval "${create_file_system_cmd} =
${decrypted_part}"
                             ;;
                             *)
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index 927184c..75e3272 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -126,7 +126,7 @@ for partition_set in $partition_sets; do
                                           /usr/sbin/cryptsetup luksFormat =
--batch-mode \
                                                           --type luks2 "$p=
artition" < "$tmp_key"
                                           enroll_tpm2_token "$partition" "=
$tmp_key"
-                                           open_tpm2_partition_tpm2_partit=
ion "$partition"
+                                          open_tpm2_partition "$partition"
                                           eval "${create_file_system_cmd} =
${decrypted_part}"
                             ;;
                             *)
--
2.25.1


--_000_DU0PR10MB6898F7D41CCAC462227AE2F7F02CADU0PR10MB6898EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"TR" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Fixed typo for the function name <code><span style=
=3D"font-family:&quot;Calibri&quot;,sans-serif">open_tpm2_partition</span><=
/code>, in
<code><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">encrypt_pa=
rtition.clevis.script</span></code> and
<code><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">encrypt_pa=
rtition.systemd.script.</span></code><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Sercan Sari &lt;<a href=3D"mailto:sar=
i.sercan@siemens.com">sari.sercan@siemens.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.../initramfs-crypt-hook/files/encrypt_partition.cle=
vis.script&nbsp; | 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">.../initramfs-crypt-hook/files/encrypt_partition.sys=
temd.script | 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 2 insertions(+), 2 deletions(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/recipes-initramfs/initramfs-crypt-hook/=
files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-h=
ook/files/encrypt_partition.clevis.script<o:p></o:p></p>
<p class=3D"MsoNormal">index bcb5a04..5d7124d 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/recipes-initramfs/initramfs-crypt-hook/files/e=
ncrypt_partition.clevis.script<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/recipes-initramfs/initramfs-crypt-hook/files/e=
ncrypt_partition.clevis.script<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -120,7 +120,7 @@ for partition_set in $partition_=
sets; do<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/sbin/cryptsetup luk=
sFormat --batch-mode \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;--t=
ype luks2 &quot;$partition&quot; &lt; &quot;$tmp_key&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enroll_tpm2_token &quot;=
$part_device&quot; &quot;$tmp_key&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open_tpm2_partition_tpm2_par=
tition &quot;$part_device&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open_tpm2_partition &quot;$pa=
rt_device&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eval &quot;${create_file=
_system_cmd} ${decrypted_part}&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *)<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/recipes-initramfs/initramfs-crypt-hook/=
files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-=
hook/files/encrypt_partition.systemd.script<o:p></o:p></p>
<p class=3D"MsoNormal">index 927184c..75e3272 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/recipes-initramfs/initramfs-crypt-hook/files/e=
ncrypt_partition.systemd.script<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/recipes-initramfs/initramfs-crypt-hook/files/e=
ncrypt_partition.systemd.script<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -126,7 +126,7 @@ for partition_set in $partition_=
sets; do<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/sbin/cryptsetup luk=
sFormat --batch-mode \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;--t=
ype luks2 &quot;$partition&quot; &lt; &quot;$tmp_key&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enroll_tpm2_token &quot;=
$partition&quot; &quot;$tmp_key&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open_tpm2_partition_tpm=
2_partition &quot;$partition&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open_tpm2_partition &quot;$pa=
rtition&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eval &quot;${create_file=
_system_cmd} ${decrypted_part}&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *)<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.25.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DU0PR10MB6898F7D41CCAC462227AE2F7F02CADU0PR10MB6898EURP_--

