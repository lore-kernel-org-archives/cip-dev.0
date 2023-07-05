Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF3DEB64DC
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 11:59:59 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.74])
 by mx.groups.io with SMTP id smtpd.web11.19354.1688568033273021990
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 07:40:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XLEW7qIo;
 spf=pass (domain: siemens.com, ip: 40.107.7.74, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar6l9sqGsMpwMe3XpecCNZift/8xJJBM+qP1ywUbPC5AVUIV8R1t61TFwWMFlUTLWNpvcLIkZKR8O97tb8ftyLJM4ko7TKMAJIRb/h2uNf2qeFR4D6WAfuk0AudmOH5QKZlnaGaJoT4PEnFTz44dLDit2KZKZSTWq3SlDyhiCiiqV43N9euZj/AuhjpjRwzzE+edWuf0Qe/FvrEC/mzroKgb0AtqH6yBxxJA3s8OStyySayPPnZw0IeZ+40aYhZROruqbAe3fu1M19qvSMLXS4HfQu8YrKGqnVaCFS+1gyMVA/IXUjsUx3JRx2TIySmCzwMt5/mH5ZVIlbbOuJGUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qilbIu6p7Pbm1yb4GarwftDuTuWwGiIwht/ianQWI/g=;
 b=f6Tj0tZKZ/ZbnClzT7oFK12f1kCYM4FQUM8kqGPoL3BipaQrXZ5cOVPhdnUsSlToFImjnPV562qxN6/r0WGBgk2BSMBIgqRIA5hQapcokPQk/nbRhaJaD/nUUmde0gVayiFCEMDbB/mPLLXjaUWuNAcfh9Oqo++gU88Z8YGB2kv9ofttoUjs4UmscRHmZSSkv8RzazpG8mjMNujz+VjqT1mF6/m00bBM4/aqHVx6XLZ5tP/pX0jISqNtRvbpvLfa+hKqQJuhaqPfckJwXsV2ukPAU7BEGMtDfZwBAn03pMhGaNZv8tRtZDIe0cEZIv0yGrr5LWl2cYnF6+pfSzkysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qilbIu6p7Pbm1yb4GarwftDuTuWwGiIwht/ianQWI/g=;
 b=XLEW7qIoNN5RxHvFlFKZajdpmsQJFXYKbsgENp94VNyUIPM2z1RxYR/py6SfmVqhFtUT/3iRAUceZYOwrg82FAQww/XpZFpE7u2ybv6Q0F4SVQFJTTNxjjquLPtzUtSkPwhTosDp3MswMQLD7wv5oH5ol2cmsewzBPhCA8YrO6SFL2WIhDwb/6ulGGSDiBP9kHjckjQSKkdhbzIWvRLocr3Qn3kgGS6zOkVlMn5QTTkNuR1jhjuyDPSwsX+WjjoTTFIiDtm4nTuCfWosAvX0SIFLCnHDrnie3mXeDhd/2E6c3KR+xkEiDUkRHDa2u/IWo4eP2tFsjRN2LDk9f9+yMA==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by DB8PR10MB3195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 14:40:30 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d951:d0e9:1d13:8409%4]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 14:40:30 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] fixed function names
Thread-Topic: [isar-cip-core][PATCH] fixed function names
Thread-Index: AdmvTo8sYqQ9GZRQRoOYG1yuQFPo+g==
Date: Wed, 5 Jul 2023 14:40:30 +0000
Message-ID: 
 <DU0PR10MB68985C5E76CCAA886F0334B4F02FA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-07-05T14:40:28Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=36c31099-5617-44b5-b85e-ab45259ff751;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|DB8PR10MB3195:EE_
x-ms-office365-filtering-correlation-id: a24942c9-9adc-41fd-316a-08db7d65c7dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2UZYRsSdUNlYw55ZMnUIUSiL6YydLxT1Ze4Jjqlw3ibx+1/4a2wxhWU2FzgnwHKesqF4gq5tPOsWnv/CRvKMenTxLaYrLGBE13kFIQOOsucTOXj84hKeHJLE0GC+U04PHTOJzAVM9yk4syIa4OUZp44te+TE5ThJ4G4kvQj81wj88YH+afPLjAIaJUzvtHPZjXfS1LI67XwpqxaLF/BJsXNbl4lW5QOIx3Dx/I8wZvHFI68Yl7Ib4hykil/Zi4tGfqxzMB9as0Jz0+E8l9uha9LN+9fIZt6HqNmloSO6Bq4DYOa6rcP1fHjaOSqiwE0LppExlDghBxy31uJxIa1I4KPL27dZEkcBPauVmZS8QFJd1mlgB3ZZz0YZZC3OUdwqcRbr7fsr86DbIXzxTID3tcq3/ULmQLLrlMHQcFyEWudoBnQjElzCu/S7Q1EVzMHLj0VgJTIHSCsXcVubN3ZA7Dqb97qQPM5povt+0yzDvvp+doY7vlDoHv3NvbVRW3gZxgQuzCc76PinHBzbc9Uu92WRr60FDGSv+WdI+BcwwQdW/y1mI2Gpr3WKv5NfCmcPjmozbV5YtkBLtUxI4Asi22GM+0geCfg/itc6JGKcmcnf/44YlT7F/0ffVfbJspkc
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(8936002)(8676002)(2906002)(55016003)(76116006)(52536014)(5660300002)(55236004)(6506007)(26005)(186003)(66946007)(41300700001)(122000001)(7696005)(71200400001)(82960400001)(33656002)(66556008)(66476007)(66446008)(64756008)(316002)(83380400001)(6916009)(38070700005)(478600001)(9686003)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UWaundWw+K4G/mkw5eum4e1bz0XCvIyBys/XLDP1ypuRdWAP9cBfMSREWyBc?=
 =?us-ascii?Q?OTha9C/1XgqIHxdnhzyOFO0CpygC+VGlNod88PPiCbNX4Oc6bMqfwdLxmmHW?=
 =?us-ascii?Q?Idxc/6vLV98OvVbENwqunmitWl4JhhlO6RwxWHlwLXGsiW9zE2basIKJot25?=
 =?us-ascii?Q?GpPjiGmr+3L987R0FGVEBFL7KsU99W3QIKA3J6k+nsSm3C6Rjn/aMJYm3H+W?=
 =?us-ascii?Q?S481FYguSmZgwI9blVWlpYMBRz5B/bkdSqvDD6iYHq0A4qn6FWRj1fbEv9MF?=
 =?us-ascii?Q?FWnzOiN9ne06mdQJm0ZVg7rnmwzGBYTkF2yZqn+og6j30Fgy3ukFyVh2BbGU?=
 =?us-ascii?Q?eKvTV/eUiJsWrDj7J3JDYiUBPISsrnyXO0q5UZJ8eEJUKcooBPpmo7kZ7aPO?=
 =?us-ascii?Q?MS0/u/EwIJeP/UT0CwlExAeG9KRtkR/W56suCEylOSbK59EVhyJ0AvtyLxnK?=
 =?us-ascii?Q?AnjflgSh+TS4LYl0UjPKA6G4KNlKFmJWtGmM03ewXbeaInhmtTl65ynY0Fzb?=
 =?us-ascii?Q?KG9tTKGI9CPsD4u55aPd1YZ4ur/mbAk/rKUtuPg85rh+L3DYWQKwjEKvKaGR?=
 =?us-ascii?Q?X1FrcrmdotwQ3xygT1dvJ6mlPe+oRrqU8x+EVXnQjvOKJe9NpSVkEoT3SkdX?=
 =?us-ascii?Q?9Td3r6mFfqSia+yQL4rHC50pgTW/OjbIJJnmahgNng0T/g01fjOHzoopHIoO?=
 =?us-ascii?Q?+k8mBoCwcN8KtoI+fDKXfJyxLLd2f5kp7wj5zZetbJRICS8WZyeGGF4GKLkn?=
 =?us-ascii?Q?z2SKP0m8G8cA07mpOwR5S0t5Ms9rmf3UBXlOdt9V85kYGryN+E+ITF8VT7Ft?=
 =?us-ascii?Q?imEbE12NF2ILV+U1//vEKRCVJF8CFseZopXMwNidUvGhgPHUIhdGtsbP3+kN?=
 =?us-ascii?Q?wElyGtQL5ayECzm10WjRKklitrwpjVsznGmbRbaOJDIWLjzUxXxiNyJ59v8J?=
 =?us-ascii?Q?YWm+TAvc89Ef9/1S2N+xMG35fvnm+pQ/ucGMBQOZafwp/R8ox651YRqxoHyq?=
 =?us-ascii?Q?tTTQXRkJgeH4z9qP9k7IiFmxa1KhFWsHQEjKls454nQSgz2ZiF11RvaUYx6f?=
 =?us-ascii?Q?fAwM3UuXjl0ywbbYbQWrd5vUilTh5c0HJTXkPpUVjd7OiMUrOhqUpwtA3xpg?=
 =?us-ascii?Q?USX+l61baLcH08nv7GCE6KsU40kj385fddtzEpluMCQbTFKKmS+KZQHf7lyD?=
 =?us-ascii?Q?mJHVoStWBTPi7HmO003u7CbrjK2uY+tM9g4rmL+W0pXaBAg0MnInPi5HY+oj?=
 =?us-ascii?Q?DndOf0JrAT1ZbCg6ANLcVAeDrIWN/1lf3mbBihr2s3c53yYSlraJtvaZIne6?=
 =?us-ascii?Q?1R8xkcAMIJT6JMHrXMipTyCBOPiPzb182lPbqogtsOrMIlmqoQ8y3ZIXyQEa?=
 =?us-ascii?Q?FaETcB4YupqBS5y5K4bGxUKDX+Mf2d22WcSPUclG+z1078jVYTnAQnf0Q0HI?=
 =?us-ascii?Q?4Ll2QTn7CxoknZCJyxnJ3hC6sjBUuAAvV9jRiHHdGdy4k43dareGrI7zGJZ8?=
 =?us-ascii?Q?s7ZGMuBuWzpegNzYs1BVCH27dGfNK/8aFRv6/95BMh42N5vfs1V2y/p1q7H0?=
 =?us-ascii?Q?8Iwk4hU/0bJKmUcqjscWkLDH8okDuFG4bz+shBCQ?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a24942c9-9adc-41fd-316a-08db7d65c7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 14:40:30.1069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oaSasKLrCxLzOwPcCa3a9AuMQFZ1w2Aj/TcSunQx0LdYPRtBbff4Hs9xL4fvL+jAAW7Hcp247cflOCh96zKPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3195
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DU0PR10MB68985C5E76CCAA886F0334B4F02FADU0PR10MB6898EURP_"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 11:59:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12261

--_000_DU0PR10MB68985C5E76CCAA886F0334B4F02FADU0PR10MB6898EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fixed typo for the function name open_tpm2_partition, in encrypt_partition.=
clevis.script and encrypt_partition.systemd.script.

Signed-off-by: Sercan Sari
<sari.sercan@siemens.com>
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

--_000_DU0PR10MB68985C5E76CCAA886F0334B4F02FADU0PR10MB6898EURP_
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
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif">open_tpm2_=
partition</span></code>, in
<code><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-=
serif">encrypt_partition.clevis.script</span></code> and
<code><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-=
serif">encrypt_partition.systemd.script.</span></code><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Sercan Sari<o:p></o:p></p>
<p class=3D"MsoNormal">&lt;sari.sercan@siemens.com&gt;<o:p></o:p></p>
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
</div>
</body>
</html>

--_000_DU0PR10MB68985C5E76CCAA886F0334B4F02FADU0PR10MB6898EURP_--

