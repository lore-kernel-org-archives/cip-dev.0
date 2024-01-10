Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C5C4707B
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 12:37:58 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.47])
 by mx.groups.io with SMTP id smtpd.web10.10519.1704890252276289009
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jan 2024 04:37:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qjVhW7lR;
 spf=pass (domain: siemens.com, ip: 40.107.22.47, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfGA8vJsIESSQNC/4XT06qTuYMYzfbr+9AV5pqGRNkIW7dQSm5s8w4GvlsBYwKmm2SX/9hnTpRnPfkbIcmWOAMt0R5Pi1JgdhcmS23XHX4paYn6h78f7YPzgZekjimh7vkTU2MAoH76CPRgag3wwF5phDYAnGB4tRPBueluYBS6gydgwSro8fOgrgtDsCha0qqbdwlsOJM1O4q0TefXil6YiwCFh61AbaDE59OnNgBRsQugmo5GOkpeoKf7spupqkebk3vprorpgzjfs6sPWOlJTsFNIYIpt+W4ftgZJ68aI103dC3ic9dIY2Ca9td+Uvkz0PG+UtmMxadICoY5Alg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TB/OdpGOwD131sR71LqRZRFxtygvjnrqmn9MtD+vvIY=;
 b=E01BOMK/6DkS3o6hl2QbsxwyhlYBe1SN5crxOGnpoqmL0Ef0CYmLcyl9vi80XSdfjwLIn1pG+09uQzuJ0zPN1Xs0aiY2SyuJlzFHiuuANFSWushfeEb1g+O56rOwR1cjL/O1OlN0dWZYlurSmcXNsSMYirCcg8Ro+z97KuxbSk5FrPfp7TsweegWVhWhlATOkPpg9W6fuw4Cpgr9eZ4SgZR/OMK8FFfTWyp6R22c1c601I876Diq1oHsRy4v+Wl/Nh+mxdXZ4tn6JEbvjZV0PYy/JOiHYkuQnT96r8pfYLIzzpB6B43HbvQThR97L7ifBX/xbY6ZmLSOELnA3lY15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB/OdpGOwD131sR71LqRZRFxtygvjnrqmn9MtD+vvIY=;
 b=qjVhW7lRlNl2LKAiV7DIgk4qczftx20eiq8lIslAhR19lsiOcsagK2OEZkQdOLyAS1/rZrc96pFpFnJHGH3oylApNSkzALoXpRPVbuXCIgRhQiCqW3X43D8kMxeuX9vRp3bdk3rVFMBir4n1DQG77mOFk/mQWtq7nW1kijhiDRYaHxVNONDFnznZEBFQIZ7cNIwzLESMcGMpuEg2vugoJUJvErEIgsSfctBtHu8e1sWNpchAH7d62ufJjipMbtDaTf+jc5mNTLaM0aoLwcSsSFJt86B6+7p2YMVkcJYM4cmOiCHtsK9e+DE5ZX6G3R1evrnfxnmKeU8R4IieqARb/Q==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by AS2PR10MB6975.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:578::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 12:37:29 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798%3]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 12:37:28 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] initramfs-crypt-hook: Add required kernel modules for upstream kernel
Thread-Topic: [isar-cip-core][PATCH 1/1] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Thread-Index: AdpDwZikWzQ1eMRRQK64lf8gCe5Naw==
Date: Wed, 10 Jan 2024 12:37:28 +0000
Message-ID: 
 <PRAPR10MB5422768B34B02D220449FBE680692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=04f4fdc0-829b-49d7-910d-4bd1589b5579;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-01-10T12:17:15Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|AS2PR10MB6975:EE_
x-ms-office365-filtering-correlation-id: b59eda9a-e433-44cf-cb99-08dc11d8e85c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zIZhlSfrnWjU+s3WjJyAbMrabhgY358TZtpuPER2ttecAa7igNa+xPqdYI0fz2ZwpHtL3/Umq2LOaZ9wAqTQ26bQi2ZDDFOA2cFv8YOUL/VADTb6ZSd/6DIepgrolG29pjsZgd2i+b3K4T/x8mAufGeWH8MkNGieVXbZUGiqOzrQF5nYLBOI98pb9nQ6No9VMIO+VVLUeIgZI2fTzxHxbmemSlcydJx+4ZkgrU0wbGtUk6nk9bCvqBOLhoKSZIhZ3JdxH4I45jlpPVdPe1i1NC70twYscdSG8Ns/k6JkS9SyQ8aKL0sSSFSdaxCgUh6uQzhNv4dGWkAgZBW7Y1iBmthSnTF5MvvSEUiHlNn7oszpOBW/84x5mQH/tjMVtdH/CFNZxToFv++VQSv34rM0rM1l424rnzlCXPgVgXyljPxP0e8n9rqJOUA7rlLET/FgS/1/K4gEOxOyp7dI2uPpkTHEFQDqYfaIA8Je8jpXCbO07AQdBnR4KwJI8piXOytECXHpU6tuaG48zGfLqv8I0XhlxmjaRZ4/Sg5dWIH+lZeN9nbeEMWA6BJsfOkICDYa4I21hTzMHHE7l07429wWjW0f9O6a9hT1pE63K8UOJHbsFIXaW6c+9MIRfQptbusu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(2906002)(33656002)(86362001)(82960400001)(38070700009)(38100700002)(107886003)(83380400001)(71200400001)(6506007)(26005)(478600001)(122000001)(7696005)(8936002)(8676002)(316002)(9686003)(4326008)(52536014)(76116006)(41300700001)(66476007)(6916009)(64756008)(66446008)(66946007)(66556008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sKqB2D1g2WNID8N0TT+xlnxmBLurQIZeuKeDcCJD2ljn5MFZv94BHEZ6ZJI+?=
 =?us-ascii?Q?3wrpe596dyLilcvXO1Fjihm2TNG0mHXEOJBgHjFfw/SoHjZWYwhSuv00N+ZN?=
 =?us-ascii?Q?gWlHLpTTEKctELWZRbIXd1PtOzagasco3eRKqQfDVDGivlkIlGmM04EwaToo?=
 =?us-ascii?Q?fNc05y8aoQjPgF7wejOSkhwUqdR5Q87/DDMVRfm3fQ8hIOxngPAvX3/jMwie?=
 =?us-ascii?Q?5pbc9o2PSvtoFDqqKyObaHiqUhLzBswT3cF9Q1gCmo8k87ipB8Vg0cDYF/fb?=
 =?us-ascii?Q?PUnOFTPrG9AUcPP1H1kgHA6eGkxkGt8RMwYapwGCN/mqjCNsG74Xf1Fh6Gnf?=
 =?us-ascii?Q?Hr7Ml5T5dZ+/svo9o3KkZTZ3rUTfbRDnLFqf5JJG3GVuXZkenBCOm+oZ8iTf?=
 =?us-ascii?Q?pdLbupzzOtE6mQ3wHh/H6omSLruz0aCBEWHmskWms3gQBEl6lqPOxZGLauCK?=
 =?us-ascii?Q?PgauBTeTgYQKChryA43tXEh/WNN7GlXhabBd0Nb3gOchn1uGG3+LI5LZjqyz?=
 =?us-ascii?Q?zclCoSe41sFkFp95cfvVn8p6DXo4SF0EchGW8EtTbgJSWtwor27XqdNZ6yum?=
 =?us-ascii?Q?XleBSfZwjP/ZFRcEXMuYKM9uH95WJXz/njXOlNkyGvHiyXcDVJKDyTEm+WpK?=
 =?us-ascii?Q?L8P9N34KY9XALcF2eR0pVS4or4qmqZ530AWXgQKCUzmnYi6DAhbm8qUcWsxb?=
 =?us-ascii?Q?itE6M6spL6qkz//HpSa2weyEGf6VDjILbEUpDYzzsmT4sHs1SJObEvyh3Xg6?=
 =?us-ascii?Q?md0m4INybX1JE5+ppWFIUO8KPCc9ajj3PuXnT3uduXXYkU5LbZyXNYx5iSHG?=
 =?us-ascii?Q?Vtru6zPuq1k9pgDTaqlV1QlVIRq4XmGT5BECy0ZFr0mFTFoy2f6VAZy/DUK2?=
 =?us-ascii?Q?GIfRriaGLFwrplxfTnzuYQLQdIpRXzyT2ogFxpgHGMC8OsPFSNUI6N1U2D2p?=
 =?us-ascii?Q?TT9g9K85B+iHihRNhhaJTruLR5Klj3Hz0LXgY5Knu7fKa5uyFdyJGDTSuRwp?=
 =?us-ascii?Q?BHjNWlw/mM3CYyCV8oDcTLSuOS0wEwTvaOv3OpivrMNyCupB1gVG71/J1yi1?=
 =?us-ascii?Q?dfvnvKIniYV2OehSUDTIlmuTHjRFz4NbYI6SZlz4J1+VkCh8i/cVKleZZ7b0?=
 =?us-ascii?Q?EO+pvWsuc2rpn2IeBuWkv41pSiD/kHhAlNo4Uqi5dh6xbuaagWGJYKp3Pt+3?=
 =?us-ascii?Q?EGb+OIqnq6TE4uTBgi7YIMfSQ9e+fkPxWrxOccgeyhAEncdzzpQTJ1KHJRxI?=
 =?us-ascii?Q?xpEjPvGs3pxwT3uZL9GTCFtuLokAJbrvrU4BBfQn7bG16OAFiYwrlKMLdjbe?=
 =?us-ascii?Q?kEKcAtvt1mj4vD1YqUMM9DHaPtXWpy8iBYNauzURFNbJYA4/EarZ5HrjCjrG?=
 =?us-ascii?Q?TYl6vYh6pKeaG+ZHMeaJUezbaFy3H49P0mWSgT9VogE3vNhB81YZaAldGNv5?=
 =?us-ascii?Q?ficytVI7qQrXkXCW+9AFujWslhL/pqaxxUXel2vpGSrwEasiJB/cUY9VJaDS?=
 =?us-ascii?Q?oDQiLCjzuzbYA3eW7vFGPzI9CAhYoM//sHcfMCMD4gtjK225fwdkGuo5pZQs?=
 =?us-ascii?Q?8jzS+V48WnmfFLwUcx5L6vnqT9frL1yazswajJyx?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b59eda9a-e433-44cf-cb99-08dc11d8e85c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 12:37:28.8388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAcw/WX8hYUL/1W92VZGlzZ5SgD+O8WTVeAWzZrqcEBVy5SuL7t/5YFBgpObl27KgGJVA92OE770BDtMSgrMOQaUOj9zQHhbiSRnGj3GL6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6975
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 12:37:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14322


This adds necessary crypt modules and loop device that are
not loaded at early boot as default with upstream kernel.

Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
---
 .../files/encrypt_partition.clevis.hook                   | 4 +++-
 .../files/encrypt_partition.clevis.script                 | 8 ++++++++
 .../files/encrypt_partition.systemd.hook                  | 4 +++-
 .../files/encrypt_partition.systemd.script                | 8 ++++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partiti=
on.clevis.hook
index 37b373c..7e69f88 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
@@ -35,7 +35,9 @@ manual_add_modules dm_mod
 manual_add_modules dm_crypt
=20
 # add crypto modules for debian upstream kernel
-manual_add_modules aesni-intel
+manual_add_modules ecb
+manual_add_modules aes_generic
+manual_add_modules xts
=20
 copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
 copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_parti=
tion.clevis.script
index 6d8f209..9be03e9 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
@@ -36,6 +36,14 @@ esac
 modprobe tpm_tis
 modprobe tpm_crb
=20
+modprobe ecb
+modprobe aes_generic
+modprobe xts
+
+# this needs to be probed particularly
+# for reencryption with upstream kernel
+modprobe loop
+
 # fixed tpm device or do we need to find it
 tpm_device=3D/dev/tpmrm0
 partition_sets=3D"$PARTITIONS"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.hook
index 0a39da6..abbe28a 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
@@ -32,7 +32,9 @@ manual_add_modules dm_mod
 manual_add_modules dm_crypt
=20
 # add crypto modules for debian upstream kernel
-manual_add_modules aesni-intel
+manual_add_modules ecb
+manual_add_modules aes_generic
+manual_add_modules xts
=20
 copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
 copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index 2ac8d30..67d56f1 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -36,6 +36,14 @@ esac
 modprobe tpm_tis
 modprobe tpm_crb
=20
+modprobe ecb
+modprobe aes_generic
+modprobe xts
+
+# this needs to be probed particularly
+# for reencryption with upstream kernel
+modprobe loop
+
 # fixed tpm device or do we need to find it
 tpm_device=3D/dev/tpmrm0
 partition_sets=3D"$PARTITIONS"
--=20
2.39.2


