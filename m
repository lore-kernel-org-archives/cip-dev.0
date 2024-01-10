Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D0C4707C
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 15:14:59 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.44])
 by mx.groups.io with SMTP id smtpd.web11.13924.1704899622514633950
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jan 2024 07:13:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yDflNKIA;
 spf=pass (domain: siemens.com, ip: 40.107.13.44, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp/VZ+yt5at0kMoTh3DEXQLL+dteeGY/Ke9YrkS5blqII1BQb3BR1sprW2m96hx8eJL1DrMti9HsS2BXJBxWg3jwIiMoYrk64PhGGraWXSXE4YzYXo762A7ugAFhaub2gfUMIyAcHr77IYaj3kvJeIvP38wSPVrA/6g+S3HqDXRJISB+aCMXwJm+9+WjSRQ1tvNKsclkLMuJuhXHGVcqvuxZpQwXhV2M9+U+/ccayFZncRQ0cmS2U2uAXF27Utwt0Xplya5NuEKBCzg4edmvJv78MeavfBWu3V7uRXQnhbmqSeJMFRBUo63lcpY+m7XOc654bjp89mJSbxIUyuQD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+iR6UsrndJoomiOMcyT0YPm9QHT6wI1L6TsU/pVd4A=;
 b=EOKu9WP5/XCiC2PpD3DeQx4VKw+yKYxQ8vY5/9sSKzZogrEsuhMAyzMXXw5aDBlAsxTBXbZWxZwunbfylPtRyLI6XXiaIW9N1aLJF1zLwQcFGKxOa2CbAL5b1RpqcPYehjqiskc8TLNtOHOr/ZO/pUubFwvyzuuQhhybFgiK1DN4IWAAL2lIzT/mDkGFCORA3zEhSm2h7k+AFeeaT1Pr5VtrCxbCcU/uZHhCN1TAr4euCGCqhEEu9qGhzgCWtgd7RWZfDsyMuQqhMMiLb1RYbRm/dhsx2O2lVpvcTLTkZpljzGjs4vknT2mkFEn7d+wkOrZwqOsS0W1rqU6D5Yv/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+iR6UsrndJoomiOMcyT0YPm9QHT6wI1L6TsU/pVd4A=;
 b=yDflNKIAiLWSly3UG7VqaRKWrSApTXQRXe19wvtcAayHl1W2SJJ/4dhKBYj4l74qZtHttrtY7jPXIWR9F3uiqll9GKPF4IsYNUyl5TEPUFBD6eOEO8Dl+xGBC7Q7dCYVfOBeLAwnZ7b9lJXx4HEX81FvdLbHwX5vhn5RT6MuMttVNNcMbWrC2Jl/WYBeHzTxTUe+Hekp3oebZ89KakjPn2zccZsyBSf4rdj0RY8sAmYoCP7uO5ejP/w4M5gOltvuTprGI6ztGPAh8Ke5/3NQjqjsc1wCJX3/z4SfqgBF90mTBYaE7/DUfQpoi8K1pSja+fUI0zip+hHZy/hD5bFP4g==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by GVXPR10MB8003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 15:13:38 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798%3]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 15:13:37 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Cetin,
 Gokhan" <gokhan.cetin@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Add required kernel modules for upstream kernel
Thread-Topic: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Thread-Index: AdpD10I5brgI2MPbReKS7nA0qt3gow==
Date: Wed, 10 Jan 2024 15:13:37 +0000
Message-ID: 
 <PRAPR10MB542260589618B60AAA1B6B1E80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=c6b99e4a-bb80-4d2d-8142-0733a7985493;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-01-10T15:10:36Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|GVXPR10MB8003:EE_
x-ms-office365-filtering-correlation-id: 931b272f-a12b-47da-898f-08dc11eeb8c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PBdWLNdM9471X1M3Go9wM1z1p1WHJvR9YQQgqaWojK3hCkm8Cezvpw+E+NDdgMJwKhd1poohDpOLaOz5lNZT5HGz9FKWQsTYuBEfZXqYalpFUwRgzHQrbD8ausGNhctTQCfi4ZYSUMM8rPJq380PUyygu56s7Xj9FVyk57nPb2bJY/326bxAMZlDakD9/l2sfASLSk1qK/8zkAX68LPI0pXXK/2JE675F+tO+RhMAmGlzF+VUB9qFtClV7CJivFJuol3mjXFw+lFKUE2/cM1sXGBb0XcqLs+cRsIwlFmTxEkLL/CImu8g+nqxOjg+stcW+dBALVC7AKwC3EaWQC5B3rPsQ9OxY+Z5CmVB/aK0pS67pch3hEnrXdYYsH8ns9delVZkiyfBxAZ9bEZz4MJ6S8Wu5CWOOXf6bL2vPj/tkJ2oTFz319o52vQqnCeamWqJfrFjWe7inhplDPeXH+zYs9xeCznOoKCJErdLnJ6u1CYsNghS2UjXxr+OqLe6yB57n/yVRGEYEPMVytsQsXwMvkkXAe1SggmgSzaxj35EpDLU3falVuhmQDWHZtFxdWjzgPrlbvQZyJ2wBFGSKiKMmQwVYv8Ue//x+UpTuQbPLCAnoaJfSFIa+SIIawfLxOF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6916009)(64756008)(54906003)(66476007)(66556008)(66946007)(76116006)(66446008)(26005)(316002)(71200400001)(82960400001)(8936002)(8676002)(52536014)(107886003)(4326008)(83380400001)(55016003)(7696005)(6506007)(9686003)(2906002)(5660300002)(478600001)(122000001)(38100700002)(86362001)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2nF3dJPFWjSUe50cdCwl6Rp01QaOcfSpOYVFLtl/l2eA/2r74kZ4WFlJ9NRP?=
 =?us-ascii?Q?+SOnHAEbbA4rR25oq0yP+MsG6mydxuIV667C64c9FWs9CTV/lDk/GxHgVK1Z?=
 =?us-ascii?Q?ten/gtFCC9btNktH9ta/If+b9KBMVdbsLlAMf1YuPB1qo7z02oY1LbLxhuwK?=
 =?us-ascii?Q?LHtaHqWkB5coDKzJz24yJLa4CoWgdo1VrmoUvhcOf8E4uRL2X/LAmAFe8pJD?=
 =?us-ascii?Q?4FOUGdTLnYP+ev/9HoRNyRBPeVnxgm3YNDaRBbQGWw9LmVblKWVW5A5s+D0R?=
 =?us-ascii?Q?HYQ35RiP4c4wvA9D9Zs6pV/fHxTHrknJ86zu0PYk2TlSQvkxyy7L0qLQ/wYN?=
 =?us-ascii?Q?6BTeg6Ad4RkC1NK2QgZkvwBzDjXy27mh8UGBsF0tjQtMV94IxpyloNfPn2Cu?=
 =?us-ascii?Q?mkLA45QEcMEbyCTg19ivlBM8yRKrk16/Ht9cT2ZoM7CgQb6OoAUqPEXFAiUC?=
 =?us-ascii?Q?50SSxSNrBa5DHOyGwUsD7sxP0F3X40GlCobOrKGXH/M5GMFEMu9F1RHGWg4i?=
 =?us-ascii?Q?sz0xNY4nYIMSf8979M72RpCHaXBg6lyxAQTz/b9EEvpjcYWXwaQl11ChEPW/?=
 =?us-ascii?Q?PI9jh2paHAJuUmNClnMziHbQlEJnmbSUHhsudQNtZ49UityvNxA2Ojfdf3fp?=
 =?us-ascii?Q?Iqcr/ffBSXh6PAydGvsuF5HxhHJqxEAZC/vhNQJx/l7GT/nWN1fepB3kfBh/?=
 =?us-ascii?Q?AGdHTCSvOrB/u7ExWUuQIu7yZ3LtTT5zqoKFAiGgpsHuKNJa1WP3hkPWSqyK?=
 =?us-ascii?Q?9JAitG4iWt5W1gDEbIs6fXJwzTY+PD4ppCStw/a43UAT05J8B049fMkHfZz+?=
 =?us-ascii?Q?+VLOcGBhOwrl92/1fFbnBnAFXj95HCDPfHA58RyaYBXgiCmKqmRjmHgglHhn?=
 =?us-ascii?Q?2K1KlQRAoBKCTE8G+h0l/D8dA6raNvV6kh+Bm879FWfibNjdCR9f/QDbG3bC?=
 =?us-ascii?Q?l7TEkZ/Y4fmZ8QvGnqHe+a2xwrqD3urtBZysPEc+W7O605xbVj8Y8dkbrCJp?=
 =?us-ascii?Q?P4zKvtNhNce6ikqW48wwSoGpBQfmDei+AIkaI/T2m2Np17VN/lIfRB7W2GJV?=
 =?us-ascii?Q?3+9Hv8D+zvlZiQ7QUyZ39sNiWC3qKZwJsYWk4QgtcQb1uFPvRZmGf7hksd7I?=
 =?us-ascii?Q?fgA3L0gsdvuzPPZu1JMlQzqrHsWWGOmYJhpj/ZJ6alSE3M2yeILaKrUwvm5l?=
 =?us-ascii?Q?BM7K81cqSWIr+25CF7F90yGqLyKEo27zzC5M9EF318qGNBc4CENMct/41Z6a?=
 =?us-ascii?Q?5vpLBzQgtlaX2n1EJ2/ozMXjPr61/cT7uyeddUK+v1Mva0SzjBp4MZ9mqBrT?=
 =?us-ascii?Q?ploJ7V4b7fYVmOavgWZOuEUQiDMUBPZYnn5zkXW/kgkhlFRbsUwIR+qPW8xy?=
 =?us-ascii?Q?D7EHTS1B6zR7RdBqcplvzv9Ag6DaOBd1eIaibD06yM6e3Qcc0NLNbs5zSWgS?=
 =?us-ascii?Q?af1RK0iMGl2icYsQ6zSAv/kgWBkVlb9XBRXHVSfGLjiz7Oigd/5K8sHQF7pI?=
 =?us-ascii?Q?vLL2ZII83zHSMEokLDYaZc/1Ckr4B+hl5C67RPYJY2iaOxaARVHHvbBxOxox?=
 =?us-ascii?Q?Z+z1HB97oHItlv9S/1kkDGUxVUnQVlROuNAzSben?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 931b272f-a12b-47da-898f-08dc11eeb8c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 15:13:37.9277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8BxdFLNusxksufS61Au7XmbiYYSkj6JvwV0sR2vopaXBPjQVaoPrNGt+51g5u3qhU60HOOHYb5utplzoUGnnIWItvRhJt1vuYv1lUT+ePQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8003
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 15:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14324


This adds necessary crypt modules and loop device in case they are
not loaded at early boot as default.

Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
---
 .../files/encrypt_partition.clevis.hook                    | 5 +++--
 .../files/encrypt_partition.clevis.script                  | 7 +++++++
 .../files/encrypt_partition.systemd.hook                   | 7 +++++--
 .../files/encrypt_partition.systemd.script                 | 7 +++++++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partiti=
on.clevis.hook
index 37b373c..bcfe885 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.hook
@@ -34,8 +34,9 @@ manual_add_modules tpm_crb
 manual_add_modules dm_mod
 manual_add_modules dm_crypt
=20
-# add crypto modules for debian upstream kernel
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

