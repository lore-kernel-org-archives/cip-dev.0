Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F02C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 13:38:54 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.49])
 by mx.groups.io with SMTP id smtpd.web11.2230.1705043027564141561
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 23:03:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zFGLE5c1;
 spf=pass (domain: siemens.com, ip: 40.107.241.49, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+v+BwKOVDmnWfqAIrwOYnRQsNxtCzRzQiah/pnSz55d3cPDMQpPK0Uz5xBryRX99kXhrL93hADRMBucsyG6YQSvO1S8804BIeE5M7GCMG7ZPXScUjVUPpRQPgCUrn/ZxlXoX/gve//Yt6phJFAqzEyG5pUd4quJnFLS3iftNeStm16U8fECXz3rX5eUaZb1/k3ghOPNCKVx2ftUYH8RnX6nWpLNRv/NxMkoy8vy2N9/Ieehr74eqnDYRDnHMvCGbwCWXKLbmPbaLe14rMyq40ee+TkGYNlJwyJ/u95WinSJ7zDpqo39aAwFO3Wdm61b03ctki7xBHOd3wQgyUVr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni8wniJa6Cp1Q5Vm3QKbf3J2TwBz7m7kSI6WNyAkkCg=;
 b=aC0kLCNmVKEBP0qFrt+PGx8WZRo1AajGbBV7jzfCgfHbP0BwRPATjv6mv+PcjXAz4R666Cjbt6Tn+EKh5x2/nDZe5e+q+E66mJNGS80kIWMPU5ZgYxCKf7b3K1+T/Z5Rueo7+emglU/USBl1N4hJcpxMauFL3yd0w4nmPP9744M0wWwAFvuKIzr/pvGf6d5s45ZI8bN2jptiAp9WG2uTr0z4Kl34GkNtFDW+pXdJP6bsWS8ppnjealLgVU6Rg0ckB24yqdI7jnLPWe6eWBMaUVyORsMv16uWVWHFBFR7UJ5YMn0ZF50V1cKLhmmURUe5kFvmZAW+EC0Cs5s14WLLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni8wniJa6Cp1Q5Vm3QKbf3J2TwBz7m7kSI6WNyAkkCg=;
 b=zFGLE5c1T3UFW5GAR3CYbRatWvs1Ojs1jq2rA76hVfn/62aXYVli2N7PHf7EJ1lBWy/KaYMVPVztAM+5JUoJ2+IXNc9rqidVv0HjX/deJLY3K6l0swMcpgpYWcLoex6jy08rQsZ9k2d8GZylh80VWApQQ4KAqmhlezxNt6DbQ7Nupdc/J5YoCAdm6qdmmt1LXDbfMihh37R/WNRu+8G88SXnq+L5vNnI3boS2Bz/xdXObGGBLU46gUOxz1wDX2VpcHzVem8JnQ62fUuFH127igeowWl68IH/om8Yt/oo/2lyquzldoduDXK+zkWD2KNhQDtgCABCAlq+TUMZQO68hg==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by GV2PR10MB6359.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 07:03:42 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798%3]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 07:03:42 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Add required kernel modules for upstream kernel
Thread-Topic: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Thread-Index: AdpFJUUYeWzdFs60RDaB8uBN9lO/yQ==
Date: Fri, 12 Jan 2024 07:03:42 +0000
Message-ID: 
 <PRAPR10MB542285F67BAE6BF88C132356806F2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=0585d558-3c7c-44fd-b19b-6bdc98aca7d9;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-01-12T07:01:54Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|GV2PR10MB6359:EE_
x-ms-office365-filtering-correlation-id: e4630e45-72d6-4107-1fe6-08dc133c9c98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nkd3EAZ7VIA57yNr8OnpmWPMww4CJi3Z6XWPcibU4i23ocm8Z8TvdNLcLfDl8VHJZI3acMyDcv6pXWrxS6Hx9avjH7nikh8QrnvftSb/Br7Cr3lmd0VLsN0ZxhVzmJWSyyUlw9cHp48VX0tbLsJ9c5rx64juRnvRrlVqBE80+pHwQQsvDbsII/Y+lZUWpXaQpSnc2Qzyr/2dFm3P/4Tvw0+/ctt7p61ZYgB2zvT1apFY/rZ452IHHzevmdCqz+GgPYfpappZEFN8CVJ5VPvbwO8SLPJL3mnJalDMeUSTZOFaZ0tEa5iPc5Ei/kSrzQ7tS/hnQ6Rarl5vnNyKjOwDhtg6k2Ctm4ZMePQuUkv4cw83mawKwrsoas2yzDuHQ3N5ntGAtHdur3TFCf2HxRzec6Z71YvtKfmqX/RhjsM4patiV87SKQq9HUvijbo87rvCwa5FvDuV25LflImQNeAQnzzWhMIc5tl2ca9hbPcYNrML9vhLThrVbA7BHAoZ1GUym6eNLY0o4wqIbdqkVSoUg5IyNXF5xAGf0wjAOCgEJPX6rFWpRmVZmRw7gPH+JsRMSxyTEmnspO6nrHEyNq7Rc09C0YagDAeRXTtb8zxYlEL/DhST+0xrbQDCMZ7zXOXy
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(122000001)(38100700002)(33656002)(38070700009)(86362001)(41300700001)(107886003)(82960400001)(4326008)(8936002)(8676002)(52536014)(71200400001)(6916009)(66556008)(316002)(76116006)(66446008)(64756008)(66946007)(7696005)(26005)(66476007)(54906003)(6506007)(9686003)(5660300002)(478600001)(2906002)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?p6Q7AcehyVov62TAqWA80+C2oXcw5BV9otLI6tjhTUNyast1zreP7BymePz0?=
 =?us-ascii?Q?wQqV4IuENbMpkpnm8tkzwXlrfBoctBuA8D62pb+mzDO+QiRzG1a9RuitxchI?=
 =?us-ascii?Q?a5rLGIKDQVORNGl+Zq9xQ95BKuzKvn8eLrMDPSTxCfisuiVmpyEK31xXogh7?=
 =?us-ascii?Q?REpQTKiyEf1eUgMjvOHXhNAFQkZM9bp7lGLfrs7oZDhs1zy+yOunYzX6r1iT?=
 =?us-ascii?Q?yPF+g4f3oPvaU3dkG3VoPCrHD7fopbQLuILbM8ez8aYN8ySHgJE+cLeDS2BJ?=
 =?us-ascii?Q?JrBvs/oOmd/tjnxc4plwPmY+uW132qCnHFVw4dYYGXnhyUXbx3CLc0LEsP0P?=
 =?us-ascii?Q?qei3IQtILCdQkWb45AUOyymJ98ZFqAJ0f+q2dkXTLgsKPkB6w4lin/1d0osC?=
 =?us-ascii?Q?hg/rBDbmqk72CRchS3vBz6DWT4IQKn/jSxE0GC19HRQdOdCrYbpGcjsmOXWB?=
 =?us-ascii?Q?tQxG3yxh9GeMxh516Z0HIKhJykVAI+b/Sz+/xKEjs8FyjW1jtkOCWlLxQUD3?=
 =?us-ascii?Q?WpKwhcz1tf1N8MPb+DWSuZCv/1rGtCjyhQjbTDrFQI38Et/7VK/XoklOdIwG?=
 =?us-ascii?Q?3FOFnCRGNwX6IKGzZhDDtdQ9wcZzgmX07soGlBqqORi7rq0aHy4R7BzsHLUC?=
 =?us-ascii?Q?w4ULkuBwk9DEtGU5NDGmXxGfUKkId6jNF4nGfvB+8Rod/JyZLSwfQvrG+lli?=
 =?us-ascii?Q?keCJogr2z7y3K51v9oAR48decgh2vhCT9UFl2vRRqyhoUC8/LR77eCI9nzsa?=
 =?us-ascii?Q?mvNAQm77lPUifVKLyP38CNFkXDl6buqQ6lOuM0JsJsACP8kTsFIhHtxfrRtR?=
 =?us-ascii?Q?L6eIkeVK6n4qnKq6mHaY75ZLpEqDko7xni9va1C1bsssSGeSMyA5ZZ1dT7hR?=
 =?us-ascii?Q?8GXKrR8tkZX7MlVyXlsKK1k7PcD0VSsgyyyqXeIaMf3clEM8yxWeVHzyf6cH?=
 =?us-ascii?Q?x/3CBJ7YnhStmSNlC5K6gvRjxXgUfWSMvae0jao/NSzHPdAm9bfFoapbyy4b?=
 =?us-ascii?Q?6MWUgRJnAMa02vCOIkuHxSNseqWqiZPwRibkT4ors2ktCOCX10sABgedQyK5?=
 =?us-ascii?Q?PLYwobTyCFLkop+SGodoSPUuoy8rf0YDZ1aOhESrcTTOgu2ZNHpipl2HhnX+?=
 =?us-ascii?Q?GyrpXW0t5v9WrjWn12MHjqRcUKbw1pwIUeRQn22OTY3ZkoWvt752ReeUVNKR?=
 =?us-ascii?Q?G08ZAQ6UckXye0n3vJEZxdCiJQ6MEQ9AOUsi7glcRGdHvMTyD460NhnEDQux?=
 =?us-ascii?Q?2ptlRGVlpFm91XQRloM8eZyZOYgMCs9zAZCdmjVdKbUyx8NNuvL/uJUhzmKG?=
 =?us-ascii?Q?iEkjgLa2pU/Lob43sUSK3iWCcxQMGfj4RonqgTbQhFiR4WeBM5Z9IyTtKa0V?=
 =?us-ascii?Q?el5OU9uk21DxKalxOeBNb0Skj+wTQEW6cHqeVYWvKHeymJX04G/uP2pznKW2?=
 =?us-ascii?Q?M/aC/A4/eqI/0IO5CFQ7GKyhkZUB9P2NAHW1QSjVq7HgcJWATX7iroQqr4ss?=
 =?us-ascii?Q?OaPYqwz3xaGkoDNdqcyqYPfThgNZBrx6E0avdLZLly0MC9GAlCEdeUWG9jqS?=
 =?us-ascii?Q?phu324gdANxStRotQ00G6/v2/riG15E8QMOIvHCb?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4630e45-72d6-4107-1fe6-08dc133c9c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 07:03:42.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQNOGrDnqhdtGZWadhqZcuyzrr5dVur1b2BvDMK6Ul03Tau8SjL51e8akq558pzURGWfhd4W9zvEbNvBCtJMe67JFkeRP/DwJFvW6MktHhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6359
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jan 2024 13:38:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14350


This adds necessary crypt modules and loop device in case they are
not loaded at early boot as default.

aesni-intel is dropped as it's not needed directly but its dependency
aes_generic is the required module.

Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
---
 .../files/encrypt_partition.clevis.hook                    | 7 +++++--
 .../files/encrypt_partition.clevis.script                  | 7 +++++++
 .../files/encrypt_partition.systemd.hook                   | 7 +++++--
 .../files/encrypt_partition.systemd.script                 | 7 +++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partiti=
on.clevis.hook
index 37b373c..d08594c 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
@@ -34,8 +34,11 @@ manual_add_modules tpm_crb
 manual_add_modules dm_mod
 manual_add_modules dm_crypt
=20
-# add crypto modules for debian upstream kernel
-manual_add_modules aesni-intel
+# add required crypto modules in case
+# the kernel does not have them as default
+manual_add_modules ecb
+manual_add_modules aes_generic
+manual_add_modules xts
=20
 copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
 copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_parti=
tion.clevis.script
index 6d8f209..0318966 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
@@ -36,6 +36,13 @@ esac
 modprobe tpm_tis
 modprobe tpm_crb
=20
+modprobe ecb
+modprobe aes_generic
+modprobe xts
+
+# this needs to be probed particularly for re-encryption
+modprobe loop
+
 # fixed tpm device or do we need to find it
 tpm_device=3D/dev/tpmrm0
 partition_sets=3D"$PARTITIONS"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.hook
index 0a39da6..c3b31d6 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
@@ -31,8 +31,11 @@ manual_add_modules tpm_crb
 manual_add_modules dm_mod
 manual_add_modules dm_crypt
=20
-# add crypto modules for debian upstream kernel
-manual_add_modules aesni-intel
+# add required crypto modules in case
+# the kernel does not have them as default
+manual_add_modules ecb
+manual_add_modules aes_generic
+manual_add_modules xts
=20
 copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
 copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index 2ac8d30..eeeb55a 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -36,6 +36,13 @@ esac
 modprobe tpm_tis
 modprobe tpm_crb
=20
+modprobe ecb
+modprobe aes_generic
+modprobe xts
+
+# this needs to be probed particularly for re-encryption
+modprobe loop
+
 # fixed tpm device or do we need to find it
 tpm_device=3D/dev/tpmrm0
 partition_sets=3D"$PARTITIONS"
--=20
2.39.2


