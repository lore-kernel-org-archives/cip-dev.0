Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6F6EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 11:59:40 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.41])
 by mx.groups.io with SMTP id smtpd.web11.16611.1688629673062493988
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 00:47:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EeoUW9wN;
 spf=pass (domain: siemens.com, ip: 40.107.104.41, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrsLQyUcrfaEMoDHZ1V0MBwRZfcaHqsuiF21v3l/Ff0Wq8sJKXeFDrA8q0UlsN2u3Gujm3nbyMIkP+B5MqHRLqeupqw3aGhhnsENDHHV9dkf3WYXL3EvTjMPX+So6yRhDqW77YOpZPfIIJd/hBvKCWx3ykzNgsa5exUpFOExsx8ffTtLbyyLHqsdOmNQHogxjow4moVXkTShIxgIZVSX7A42LC3bJYqZULt5t/NLIPXzqSXeBw+8p2lG1gY1EZCebApuutvVKU0k24TiqMxKzSTHq8AfoYLRRoTJC3Zeb3gShKro/6auxLVHrNZXS1GIFyblWelJOi/56c2RHGrFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH7xwuKKrOoN2RyAFfJk43wUJd3TPGboiXg92ExzNtc=;
 b=DSDctLJhXq1b3XZWPbZIy449U9ZoLjhFo4MfApfWeMrBn8JrstBio9b9IRgbrByyOG4oI4n9peKNqmDQC4bTwi2jEHOfqPCjKBi/v2Pa0C1ndSpjeMgxS86xEZositW4fDKObZXjinb9cNXnC5YoTV8p+RseBD2z7dhQ+effzxFAC3go6hWXCFVyl1ARwSCZtHj2mltc8hKiiNLMACvlivOYQ4rt4NwaNDBqsuz72n30AWnHP03buzSDNuWVHw1QI3f4y1qlP6R3IQxq8Hbh6fdkvUO2AX7kYJXppUwiEnX0Fzc75awxe5y3JqkriAfAAHGeDZznkZWypW3hXa9c1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH7xwuKKrOoN2RyAFfJk43wUJd3TPGboiXg92ExzNtc=;
 b=EeoUW9wNoLHvUHyylgzKIF5QNRft3T6RILsWKiRVZaAXDoay6aMCvLOgIBUO3twBQJSQ/mMvE61yLgiFAAK+Dfxe4zNEubycgfdZSLASFCqJSr58kuE4PF/8FBbxxwFYpvnq7VdNBKkP06qrBNGU93Ze8ylW3YJclDDxXSKoQm6IB8H4S0C0R/fv05Dh0PKgPVdGmH6SHGZ7Bua6b9ocjVu+yNFt9vvwZWLS3LroRLpTLGgRrituOBlpSi1yWhBM/g1vzbYp5NOzon7LMO2uBfKFhPyy/ERTh/3Bxv0vfzCbB1d+fYs0eq9Lm8XZTCnXOZCz6HhRDaJPNA0sZAHJHQ==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by DU0PR10MB6058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:47:50 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:47:50 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Sari, Sercan"
	<sari.sercan@siemens.com>
Subject: [isar-cip-core][PATCH] fixed function names (fixed format)
Thread-Topic: [isar-cip-core][PATCH] fixed function names (fixed format)
Thread-Index: Admv3ijl3omY6dj7TVaKirZ8PQTosQ==
Date: Thu, 6 Jul 2023 07:47:49 +0000
Message-ID: 
 <DU0PR10MB68985B1AAF51F2886DC0E3FDF02CA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-07-06T07:47:48Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=150ee133-452d-4600-8763-01593fa18ffb;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|DU0PR10MB6058:EE_
x-ms-office365-filtering-correlation-id: 9a491973-3699-4989-5db2-08db7df54c15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BA2uDj9+8aIkEK+Af0EX4hDtMG4obDdeLT6M3QgtvkCRmarSR/xHIBSBJ5hjaF9P4xjqDuKjHb21RMsSMi12S4NvG4Agx1kdCzaAtt8+BfqDqoILmDOmYRp+K2unA64DKzxbbcO2tsGX9l3sNW8Y6GBCJWaRO5w8lweEfmVclfigLjhopKupKiazpZI1xUvUIgVdCj2o1OJOvYAFqH5uUKAcBYCqgw+p+Jg7YfmYeQ5AQqfVMlzQTUC8uZyzJL6igWgo0YxZMj8rsMCh63uNPj3HA40bESd4KGjq/roN1NvmA/ijX9BG3ym620qUEoyMO38fZhXR7fs8RzDypt2lGb9o4wi2XqcN+bTBTX8blkSqCDJA5re2TI7lUK3zpOdNXhSOND66kCeVmD1N1vk8QMn4WHtSNI5TDmBE0wxlx+0NNjf4hk0a4xu1eH5OWTZDqnyme+vgt8fXlLHLWTHyioClEGp6o6Ulmp4qZoyCRl7eOsG8E4NR7zXDXU5YdrVQUMX7dd48pCbHYi6f9bzQQFEwLrtSCAUh3uyKlXTDK1UjtGdgFc3n/oLDJqDYf/1n6uZoFihzrHaGjBKm9pFKjov9J99oo2cd9toeBv1TY3q58ppUM8pj+Qv06l56BPfw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(41300700001)(9686003)(7696005)(107886003)(71200400001)(38100700002)(122000001)(83380400001)(186003)(6506007)(82960400001)(26005)(55016003)(54906003)(38070700005)(86362001)(478600001)(316002)(2906002)(66446008)(66476007)(4326008)(66946007)(66556008)(76116006)(33656002)(6916009)(64756008)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?k5/5yotl3hYK5TqoJDYHRMh4PfW+ZyNV/3OiiStnX1bmMD9CC1WKTbMhuVmO?=
 =?us-ascii?Q?H6SiE1XzzKI9UphtFq2jxOFfH42ZcjIih+YOZKKI3THOPteOgtyqfcr4M5Px?=
 =?us-ascii?Q?IwYnXRKCifv07FFBfca882y4cwLjSRSX5WNGfYR1xpYzWpL8sXqFBeUUC/Y3?=
 =?us-ascii?Q?P4N63Xg/QPeszSVLOqHdM7wz8eh9th9fUvjzWB4D5tkI7TKsS3rirjRwpYQA?=
 =?us-ascii?Q?Kl2bVrF/Kli8mASXuG+cw4qcB6J/gxn4Lx/o7ucEe7BgYHHaeMyG++iZv5+N?=
 =?us-ascii?Q?ER1eEvpPdyPP3A6gKACYFZ+JYU/vI6zkztPlRGY+pkelaMB1mONPoWG10LQO?=
 =?us-ascii?Q?aCz5D2E99FxEsYhyk4ZCV1l9kkJKnoeUEUsFeIWzibWc8/UNwOk47Mi02wA9?=
 =?us-ascii?Q?wykAJb2/K3FblmEuWLGP4VZrR4v1osj+WlKBwr0tc+zhcKK+7vsUby7OxnQA?=
 =?us-ascii?Q?xJiEbCuMfnZhn1TwjgrVT+4aI9fgw5Clt5OOjBsAMRisJjW2LXMStU/DhpmC?=
 =?us-ascii?Q?VxdhCx+kMBB1EPLG9l78UaossDUx6jh++hge1OLGQcUP+PU1PADakDARc5VR?=
 =?us-ascii?Q?kNdi9YJsTPDrLan55beHgXlu6qAGAakLsGGFcsxhpapA6Lp/ty1wB7Xd3jlE?=
 =?us-ascii?Q?4SY/OgaVFl6opDI7z4r2TjsFJN6mDoDlr4MU3d5DAtO+Wzw/u/YuOYuSyF35?=
 =?us-ascii?Q?Y5SqCRU5NVv2ngFAqYfyFb3BOJm8zQo5pkDDly2SRrJ2tyZqgalrvdJx5JRi?=
 =?us-ascii?Q?l6yK0hW3qSFDrH1BPYKgyxcERPjJKQdE5TfX8TcUQein5/7QbnKxMtTYwNfl?=
 =?us-ascii?Q?E1YA/lnQadYkg2cLQG8PaIe0uAVPgjBcj2uw09P/Ba3tTmFl4E6sBQ1AtSRr?=
 =?us-ascii?Q?BaXSZjsq2/fq8v1DxKbnkTHdJTHlxd5J68xRxLevi87TwykTF7W2Te+XF868?=
 =?us-ascii?Q?GKaEJIibMZQRtywXUK9QRmwgkh7OBgyYwJqa05BJishzMr7gc+PCgoW1Wm1i?=
 =?us-ascii?Q?VAF/APPe2/qIGRP4t4UWUhZPwEGnjsDWpfI4z9XD0O1QTkWSBkraBTOBf/Tm?=
 =?us-ascii?Q?j5L6Fci0BDha1FylrcjTw8GaBrJSRhHzloM9i49jwWBGXRsVhUNcgt0vt/Ap?=
 =?us-ascii?Q?/TDkBjtlxzfKeM5q7tQyKYH+TvC1IujkirNGjVLk1LWsWnlRKcbN4JkTh7Q6?=
 =?us-ascii?Q?cjZkRCTz+8L2ILodULfhboMXWpP9buRW/z0n7P9d/g4Bg4E9Dk3QTxrAeyjb?=
 =?us-ascii?Q?imTpu4SAUbLk0nmdu9TafEb32HhGZXcCr5cLGYYhz4qXqgLEZethbzwwa3gR?=
 =?us-ascii?Q?EnVyG3BxKzl4BJ35/jUYjxhW3nt9WQzFqWQclODQDyTAA2MuGdcorUOnTVYE?=
 =?us-ascii?Q?MMFB47H7mzoMAnGnbDPdDdJRN0VcWIxQKhuS6B2nuKHvl5fCYYJt68ZjC9By?=
 =?us-ascii?Q?J0Dl76ZpVRl40/vcOiAAhZqO7lb9/vXwYerMNiFVO7dL/WFELUk/6bAaIl3X?=
 =?us-ascii?Q?tFpGAP4ltwSrqSI62TVx3tLzBjDyvlGj2j+W/qzV6zPln6LB8tyaIzqO7ieZ?=
 =?us-ascii?Q?j5A/3FP4iZbblngDSJKO7D5WzQ108jQObnAoYPAO?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a491973-3699-4989-5db2-08db7df54c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 07:47:49.9975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VijIUkBI5T3CLAHc6rPR1nDKcVnq0MgG4q7R640tYFP9Sth486e7rLM9XhT5BTCgA1Ie8YyJTiJXFonCvYbc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6058
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DU0PR10MB68985B1AAF51F2886DC0E3FDF02CADU0PR10MB6898EURP_"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 11:59:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12259

--_000_DU0PR10MB68985B1AAF51F2886DC0E3FDF02CADU0PR10MB6898EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fixed typo for the function name open_tpm2_partition, in encrypt_partition.=
clevis.script and encrypt_partition.systemd.script.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
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

--_000_DU0PR10MB68985B1AAF51F2886DC0E3FDF02CADU0PR10MB6898EURP_
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
<p class=3D"MsoNormal">Fixed typo for the function name open_tpm2_partition=
, in encrypt_partition.clevis.script and encrypt_partition.systemd.script.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Sercan Sari &lt;sari.sercan@siemens.c=
om&gt;<o:p></o:p></p>
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open_tpm2_partition_tpm=
2_partition &quot;$part_device&quot;<o:p></o:p></p>
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
</div>
</body>
</html>

--_000_DU0PR10MB68985B1AAF51F2886DC0E3FDF02CADU0PR10MB6898EURP_--

