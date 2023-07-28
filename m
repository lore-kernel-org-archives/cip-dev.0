Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B52CC001DF
	for <webhook@archiver.kernel.org>; Fri, 28 Jul 2023 14:33:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.47])
 by mx.groups.io with SMTP id smtpd.web10.33541.1690554831169870021
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jul 2023 07:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DMNCZwHA;
 spf=pass (domain: siemens.com, ip: 40.107.13.47, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYZvy9vAn1tZPYpxABr56tJHilneTLGe4upqbQf4R9Wzbmb/Dt/YtjJYnOoPl5z67Fe36493rghXZj3Jz2vR6gZ/9ucGHUEcDP7GMS8GePbLo5Ek4mNDwh8mMK/VfmdZvcEmJAkHPU3lnaMTve+ZZo3ZV6yAngndr03Dfa7J9QZh5qZz++8eZxZTehVdermHHBpL2KF0HTZOjFuKjMFTlqJRrTuJmv5jQKKMj7rPZ+1z7em80vtN2Asw33a0vUWuWSPOIVlJecKP44VfnhLd1Bl8DpBCAg6n2j0AB/behM6e3JVkLkqesQip0QSMQwd3TKedSBrJFs2BBsQFDrcsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdMYUzxGQZNvQ+hC5bfVf44/tDwKuwW7sif0LlzmiLg=;
 b=guNVjdiOyUAdy9HiWbaPNnlaWAKgWuKaPtCdyy8p671PGbIGs6pSoogA2RxNavOl5koAqfjsqk6IH/DnCrD+Bf5AsDVZEkn21QS9pKtMR5QbCX5oEFewIDxg9qT0fDHzTAwCLvYEVslFv1cYtEv1wSfrIkNN/xymMhWa1o4u2nMlMdpt7chXSYOtHpLbOrfRDPTP0Cgjed6yucbNL02j2R/OnNjO0RKcWaNO0i+ieSI5ajS3JHBBU5DzqRbtflu+9ED7YdmpbA7xqHfKlCGXDCVlFhNVV05pZzhP+JhZQm+5xWXNY1rhZk73R930tao+OwgLkY+NS18pZXx89YmFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdMYUzxGQZNvQ+hC5bfVf44/tDwKuwW7sif0LlzmiLg=;
 b=DMNCZwHA9yO0/7SR6eQUpOwUqCZKS8r3Tc17KLWSAgCIfSSSBYQgGpPa2esiILEOTP10SgIQUqX9kcymXgckPUjrxQs2mk4eH7l79vM4oWbn9cz/V/w+emkiX112PTT6NX0EcDSRaQ7gadhFYTbaHIZ7xoC1gs/pSjF+HMROXfqFFrJtT/OvOqeGrhZE+aMQhuvwtsJ0ESGPTfZ8u+W/pj904WyB21HAGsD73EtCgieLzCFvwBPnDHIDMzmkKVAP1E1dO1/GxOeDqJ8nQtw2TXp5jPIcDLmfB0M+58JtlGtktMEELRsRqTCPMdP65oz9dVRYnbGZm0ZkN293VB4+Kw==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:33:51 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b214:c3bf:bdd4:fd7a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:33:51 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>,
	"Sudler, Simon" <simon.sudler@siemens.com>, "Koch, Stefan"
	<stefan-koch@siemens.com>
Subject: [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid calling of
 tiny mke2fs from busybox
Thread-Topic: [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid calling
 of tiny mke2fs from busybox
Thread-Index: AQHZwWCHFkOweebVN0+CPtd6o803+Q==
Date: Fri, 28 Jul 2023 14:33:51 +0000
Message-ID: <20230728143320.3891194-4-stefan-koch@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
In-Reply-To: <20230728143320.3891194-1-stefan-koch@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|VI1PR10MB3151:EE_
x-ms-office365-filtering-correlation-id: 3cc43f16-4d87-4f52-866e-08db8f77a9ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ub+PC3MAiNP6+eKvx24dqfDVyHAQcqOBdP6J1xdzNORhthWmBaQPz2h5snnlwx/URBy/qgGyIYMNEiGgJjMrAJSLo4ILA9w5BlDPM4kC0S5X/7Ws29xWH/P7USwfODz4t2AVtySx02/5MwkBFMPFBXgizF2VV1lTuogvOzaGhcIZjjzajNvzk+ttTGMW7tKYOO1npw7Uh5vK//wKsc/vjJogABtoROUhtKoPXIM06g5fYsIrCodQBOmIRSJQy89kvRpnO4PW4DO9ZqawL8ZS1SQljfUlcKhx35h6mlD4f0sii6TJo1sfOeycUfY+sta9oc11L8FGnNMXMhAekfL13zZZmwZe3BZu4JfYX/AyT9v4aVpC2Vt23ES+hPE+3poMdFPiTMs4/WStcYQ4FMQ5d6p19qGmtJ4J+Fnr+EXOciHUP67xlsg6IZjYRA8yFrgEe5KvvBx8nTAo11bv4ZTIShydpr+It05geyEoPksyrp49lgXY6QcXE6DYrazxr1epWHVRZ55A4IkN8CghhkaMQ73l/SjsmBorHtWGuql8ABXObx15uiwAckTnczZyqOLfa15oH3ETX4s2HQjtFffQTbzdux+5W8YVAuqiEw3Onu9uhZ1+goGUol+uFyqutBzl
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1076003)(82960400001)(26005)(6506007)(478600001)(54906003)(186003)(107886003)(71200400001)(122000001)(6486002)(64756008)(66476007)(66446008)(4326008)(6916009)(2616005)(83380400001)(6512007)(38100700002)(66556008)(91956017)(76116006)(66946007)(5660300002)(41300700001)(38070700005)(316002)(2906002)(8936002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?qGGX1TrQjtVIRSomKT29cvYob50SEeTmrFVehumVwyHPLXmGWrv3F3/0dG?=
 =?iso-8859-1?Q?RbR3ZNBMqQ2L9t2OC0hr4fN7xGSqVaIZb/CX8KSxBQ0D+Cid6FtgDQWnDw?=
 =?iso-8859-1?Q?1uzLI5D8D4t6W6+ALxObMOvc4S6ZDqtgyU5IMuvqxNgQ8+uHLJxY17UjZ0?=
 =?iso-8859-1?Q?pafvESBUFo868YtBl3XnblSsZHcDPS5gHt5I5NdkglOlON1D4bPXuBkSgQ?=
 =?iso-8859-1?Q?F9tupSLbYWc7bQj8Xre+D8Iaq9/dJNacJp/ksf2RrINWsqcSAqV/yXxDvS?=
 =?iso-8859-1?Q?rOhFBq6B6U2Zdjtf+YBsgzHOqDTMLjqCzGEAAseixJ3ZbARrX7E7P2za+m?=
 =?iso-8859-1?Q?hD2n66fTJpN6nC+Kbu7fPN5lJJMS6YwlR4L0h9AqeEtluoR6DSy3CJQkg5?=
 =?iso-8859-1?Q?mLfJnCSqmwxayTnHDsAykgVjShhSXqpPgivb3gR6hflDakH0WEjj0v1Zlo?=
 =?iso-8859-1?Q?dzD9knH0yxiyDhV4mHURiPLley904cX94QtNnwx5WWclJlKzhqW+JgtGqD?=
 =?iso-8859-1?Q?NQZkOW8qk4E4eH+GWc07IO+NqItobab09wIGo1VBuPwg1tdd+dgtzl+AXZ?=
 =?iso-8859-1?Q?YbwaBG1Z3PwYvI226oh6cLIhZ05wM/1d2Tz3vfa7C6T8LwaOS1cbME2LGD?=
 =?iso-8859-1?Q?R+h/uOumPB1L5u1gSi4k4zmDlH8gQ0dVJRCLLDhf2HvItgw027WqjYAqvs?=
 =?iso-8859-1?Q?hymiHiN7DOWK267v5PqbaFtUBxhozLjlQ8KVClixB2ACGnfksRrsEZeAN0?=
 =?iso-8859-1?Q?qOcLQevPIR+AVDSt7aeRESX23C4rOZAVRyQAYAzwYxrZx7Y2otsqbkUiEx?=
 =?iso-8859-1?Q?XtXRGE1qPCRraCq1e571PfxXwGKAMX2joD3R896SkSdav348wrTCdMkylh?=
 =?iso-8859-1?Q?vAsT61Hyfsm1vNI6QdOIfvpkHhVSUlZ8BzS6cdJBvR0TRWP4qTvjpErIg3?=
 =?iso-8859-1?Q?dIuBFeh3GGA2lr9TsDJ/BxA6GwmpCJkY+DzkoR8Tz6tRpJ8x6/nRPk5c1V?=
 =?iso-8859-1?Q?BSNXZ+sIpTwYlX90LZ4aVz+FANKaH+HYp+HeZ9BOWM8usv12r9oE0gWF7D?=
 =?iso-8859-1?Q?WwPh4u0QWPhWMIjclv+7wJ35xOPp9XkyY3Os6HEt+diS4/ogHwquOnlyLs?=
 =?iso-8859-1?Q?N0ggJ0dQP6GzmZ8BGbW0VVLxYal0BuVWWrlP2awOQIt7B+Q9q1JUcuhVRF?=
 =?iso-8859-1?Q?qVQTmEu/npr4fSeCfx4Cmclhuiq9rCx4OMhKwSRXQGJT6ZP5guRNGo0mMs?=
 =?iso-8859-1?Q?C6CmgfFfxtdJkc0cgW7rQYiuyYyTyv1OSBJtMAKnvHUFkk0VaG90d91Zua?=
 =?iso-8859-1?Q?KSpf1rRaZBohLKETEdKH3VpR3W6H7yO/ZmbzzdFO54LXyy+pB0k0QiCTN5?=
 =?iso-8859-1?Q?upx6LEliBTbK3hKPLpyWi7z9DSyVJ5ZuW9k1prcG3hWIY0tPw03YlpZDW3?=
 =?iso-8859-1?Q?JmIkeOqAnyooCTyr6Zf4jlg5I/Cpq/9tinjohq0UL7M4HwMEVbCXNHpZq3?=
 =?iso-8859-1?Q?Xkl1aec4svID69ZZyRxTYJRQF/oEpCPd5/Z58jKdbx6wPAa7GJlKDTLFoN?=
 =?iso-8859-1?Q?a7LH7Hg47PpDEEe/FK25tOFOsZWS30CxDx2jQtN7hTs+IAQWa8+pB2u5Eg?=
 =?iso-8859-1?Q?xZcx9WqrKk1pkKM6M+5EmBP2ltWd1i4xe/cBrPNMNung630KAZS/ZmdQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc43f16-4d87-4f52-866e-08db8f77a9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:33:51.7193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EktD3wU5A5TLDlTglTeM4Lb03TD8vSWFX/sDWw0HbDHSnJJO03sNvB4btZsZdp3XYQVjAdDbLEpk81Ttx+grxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jul 2023 14:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12520

The tiny mke2fs does not support the used -t option.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.script | 2 +-
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index b32b2f2..4e04d37 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -42,7 +42,7 @@ partition_sets=3D"$PARTITIONS"
 create_file_system_cmd=3D"$CREATE_FILE_SYSTEM_CMD"
=20
 if [ -z "${create_file_system_cmd}" ]; then
-	create_file_system_cmd=3D"mke2fs -t ext4"
+	create_file_system_cmd=3D"/usr/sbin/mke2fs"
 fi
=20
 service_watchdog() {
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 1c1bf3d..3c3f6bb 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -32,7 +32,7 @@ SRC_URI +=3D "file://encrypt_partition.env.tmpl \
 CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the fi=
lesystem
 # in a newly formatted LUKS Partition
-CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "mke2fs -t ext4"
+CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
--=20
2.39.2

