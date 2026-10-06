Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2ACA5FED
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 10:00:33 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41896.1791280826616796782
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2026 03:00:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jQgkYbfH;
 spf=pass (domain: siemens.com, ip: 52.101.70.54, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk2yWskCK8ACgew02TZ4nGT2Xw4FfJ69tZ7TQTxhbPEzFERIE2/b+2867xdk0XHL4JI9jKzzcLRbm5Kab1zqRGFPUl0rN8VOe9GZ4xKJFz2Kkp90/anjoA8+QgJ0wUycaDsdWysf2oJ1UlsNmNjIQj2kGChc91NB9kLe6qvYnIxwv/kUUUsllvtIkr2aBj7OEj3L12qzO6qClR86Q9RMkA7zL3h7O+N3C+3YMUKootd6vDMTqrx1ab2y4xjvLmI3Gphnzr5CI2iEXpiSKxuILZOI97ISR6zgzqe0dGGJGrUQbyz1ohwd+nztVbJ5vPyvRFGtbFa4CkhR1C/J5mP1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt0IbSyt8JRCSYHGxjiNSFjCR50RCH6PwQuM8C7yrw0=;
 b=cekEfoasNPwrE3eOZ2SYhG+HjCee79FRhQB9FIIeACaN/4WmGsqg4kK8e+kXY9Rky9kiYEzQ3/8cg8f9vUy46j6CDeybaosLlEiIyI8xxg4mrfySX4FXwFZ1yuxkqTyKWg0c6X5kfRyOgkhKncjxqph6CTM0AEan1usvMESBrdMr2gc3+lic2V/s8AXjuSPETv0IYLZC3VYHiCJyOXYzCTZA5GdfLgYgX/vSh4Ovox3UnzYdfyDHczDti9S08Afq7YHwe5OiHxTn+atSeKvINKgzr1fiqwuQyYKRPsBh/Yw033SP+fZPr+TH8Ic7rep2WCsEy4UcowT5ajkv2sOx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt0IbSyt8JRCSYHGxjiNSFjCR50RCH6PwQuM8C7yrw0=;
 b=jQgkYbfH0ptbHHX9coKJuKYB1oLO5sOmqUQmhQvNJzBGWTktAX9c2rDMpvqT1bQDvrlVFfCC9w4Inu4x2izDPX3kXYnBFmWEi8tcCBxaHjos6/SlMW2bKE30kQH5nAA/UTmYGNIrf/Zalx1zOPCw1yb07NnaPTDVIeKKVe37cyVkxXx9lr3NctMXfnFdHFbujNwg429yKBFF+qytbP3xJdGl1jgwENUMMInazEwSyzQuOs8adX+D652FDYjKb1lo9gQK6jqFhvN656zW8MQZeJ2AfdNuJjrVtTRzDGnu1BFmO/UvN8WNC4ZaGiGGf2u3ZXwV9oUkAW8OyCbWDh88vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3334.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 10:00:18 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 10:00:18 +0000
Message-ID: <1f91793f-d41d-4113-8bba-54c53741df47@siemens.com>
Date: Tue, 6 Oct 2026 12:00:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 09/11] watchdog: use the rootfs systemd
 watchdog timeout in the dracut initrd
To: "Moessbauer, Felix (FT RPD CPC OES-DE)" <felix.moessbauer@siemens.com>,
 "Kiszka, Jan (FT RPD CPC)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Hombourger, Cedric (FT FDS CES LX)" <cedric.hombourger@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
 <20261002111938.3600786-10-quirin.gylstorff@siemens.com>
 <dada54a5507157cbb8971fbea78257ff3de1dfce.camel@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <dada54a5507157cbb8971fbea78257ff3de1dfce.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0065.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3334:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc21173-1a35-4164-b582-08df2390a00a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|4143699003|3023799007|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	0RXktqIIXmkuy69oEb37R4eoJMxAlJs8iKROVmbotS8bl9FBiOHTgFzFBnVNWYJ7TKZSjs3P0Y8mSApbCIEbb7NPO+p1QrY5n6GoBPYIUp/PVIMLJSEq+9Ax8q1Ig4PqXHxOXkxHqYlHZD4627Og7wEkxxr9pC6O+npDcVTKGp8gGy525w2u/8KQ+hVvEDexjgje3GqjcVlAvSYllhTzKChjxkR3PZd5PJPYnsx/tEKl70Vf3H2WBX0a2M5srDKGotM8129kylteEqkHs7Pj/vS9FPHkOu/YAPei7XNu8nQzqwjcdJVeVJI/d9/33sHDY1nYrO9wKkqM/S3/MWeParffBLoLwDAa2E1NrfGQCzBbW8Sd1E8h2VqUoDJj3ffFspFFUuXKDLVxnNonOSZYl6AzBnstaHALBSK4dIeA0J/5SPjD7LOoVpvWlGnOd7Kyh5o6jbyTbTyv4M6Fyvh1bHndKVPvIxTTAmGGN+aVbnc17zavyUEbcIv2RuJPwtAQwYGzehJeD16uu4uFHr005yhZX+c9iCk735AF5ivlN3oIzKs2F/aA+UYqQEuE5Fb1ceaaY8R6HSG+H6AAZ730GZu3FeWSiVszljb12KYKFWolklV5X+gDV/4xZtbdbXkscjW8s9a4mfgayRAhep6rgMp/VGk2Pi+mZ1FkwdEx450=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PgfGnjtcQg4yNftIggE/hbzLq1blrR53RGrbxyCkz2dvXZ/4cnM3TgZltSCy?=
 =?us-ascii?Q?s8xDR0miGAAOF+ErI+UWlhfNzCJXrIQ4dPP50zsk1sGTqwGoX3T6B1dxC1A7?=
 =?us-ascii?Q?5//xGGZm5n9pa1gsg4a2X57KfTthsnovzm/GSJiNBF1W7zbA7yavEJAr0bLR?=
 =?us-ascii?Q?iDP9i3HoKAQdOJ51k7bPZmCThKTKxTzaxq6Ul4QIe0sgucp6KbBQROSGsocf?=
 =?us-ascii?Q?CXZP/ggOqIB15J4VGmuqY3Mmd2ybCyFpgxhBNwrGoFqL16JbC0+GijhPdg+D?=
 =?us-ascii?Q?1FRu/sfI9ib04WciNI7Dj2dn0cp2eHHtG9Rnufn5WiXN9xZKL1EmGUWP2YMQ?=
 =?us-ascii?Q?6HvRUePZKSCjgdCKLInjv5UN+8Mtot4Wr1l7Y3iI3IozE9LgU2Xz8Fa9OHfP?=
 =?us-ascii?Q?UeH7w3KJJhcoqstR70kx7pTtoDJKFmMgL4Kmio8RWXORNJEYWDHI9sAr5N17?=
 =?us-ascii?Q?zvrPjJHT4k0pk2NK3S6TaXmCOvUGAVvWBSATUQRWwVGq9or2tDAZwTriJjBR?=
 =?us-ascii?Q?KsvBLUQIlvovgf8iBe9FGYJQ3jIlfT/wtVBSLi0LG61mVm7XIhL1yhmdkoPf?=
 =?us-ascii?Q?zLOtbFdVJ/cgqqOHAp+HCMIEDBtCjjc1K/1+2RsWQ0zEn5ZX7HcgTNY8j3lG?=
 =?us-ascii?Q?TE+gA127pwB2qY53drGF1huquqHZw01SBmmMAjtK+CQPeH4GPsZX5WZ04H2b?=
 =?us-ascii?Q?FGxQMMMuh3m2P+k7K3b2rQKfy0lx5Q2q93a4G5lDNP8gZVFQw45T1OxljSo5?=
 =?us-ascii?Q?LlcHwDc3YB19jnHax1mA85b500xiQ8toYegYgrijVBlJwaJ5XuM7htlSuKVw?=
 =?us-ascii?Q?QcXFkT+B3iHYZMuFcY0vL0sfNBea2B20UH4jbwBy5Lf0Br9wF2XqcP0yffF4?=
 =?us-ascii?Q?ke6rWRjjGASWIvszGwCshHJwgzbMksnadoQKjpOxcVZEM7mIvXYeGkFQwulX?=
 =?us-ascii?Q?BiV5pdEpalwXqb0g6dt2RdYmRx/qYwNz15KuvE0BV4o6H2qZL2SAvEwTXqUf?=
 =?us-ascii?Q?Dyxw1bZZJ6n1HkZHqa4mAQgIUJaCOcBSinPDLSYXbVkyPwEzLUgjhnVA2tRU?=
 =?us-ascii?Q?AT0GhqnjzLWIHDQUMk0u9p36MBlkYou4hlGl6cHMAhI0PkP5LhehwzDcPTWn?=
 =?us-ascii?Q?SixLsddhOudvt0AogKFJ2aypLE7urwwXkOkOf0sPa1YJHA/sShLWbalxCzPg?=
 =?us-ascii?Q?yNdY2bmYTKiPIeRPM8FJDy8DGQ9AYo/5JnKUTctCEGhtlzbyeNUUwFTl0UFf?=
 =?us-ascii?Q?oRRN8sccKSE55EJt6knEGk3wopT47TF0xNoMzGwJuoWlYEuv9F9s6AxUh1o2?=
 =?us-ascii?Q?Z481gant76xX7EBy4I8+xUsW5835sMRdtsxe5ywIoEPkbJffgGsOEy7a6Q8U?=
 =?us-ascii?Q?KsXlmZ5iWfEg2XMDcaa7vLV5l3YSM1nLVQI3BljwrzQwvQNYv2QGiO0sD5dw?=
 =?us-ascii?Q?m6jqECLFpPtNjUojo2MbYmbALJpHcjMnwRh+Lj8ek1dqCEqO6f8Zrbi0ufVR?=
 =?us-ascii?Q?rj26G8nDE4qgci1ZUM8bvgPQz/TjS60j99ZNYbb4BvMrcspv4pXRE0kuOTQN?=
 =?us-ascii?Q?7MDxKG5vYDKNSeilp4MeqS2/nopjaXaMQbZ1lTf8jM5qRxCtPv2x5fDVtR6t?=
 =?us-ascii?Q?Bm1Eu2bKsUYXxLKKrW4d2RBt0gAgzy8oNqgYqOAsgwyyJ1jORnQHaquWG5Px?=
 =?us-ascii?Q?MqmvVB48TDwqaZKj8xQEQKYxdM1jQnFA+72XcrgbyxjeUHITsO31czGbuwWV?=
 =?us-ascii?Q?m0aFiVpSCKKLD3M/bvaqtYFtdQs7z4o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc21173-1a35-4164-b582-08df2390a00a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:00:17.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju9Qmo4/cCuKtYDm4XbvHFusRLr6ryPb9XHy2Z4HYrP3AFUnLd/scIbA6QFYTQD+v/1f72drCu+5ti98hAz5rsAaWpLW99Y1fDg1RUNgid4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3334
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Oct 2026 10:00:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24434



On 10/2/26 5:22 PM, Moessbauer, Felix (FT RPD CPC OES-DE) wrote:
> On Fri, 2026-10-02 at 13:18 +0200, Quirin Gylstorff wrote:
>> Introduce SYSTEMD_WATCHDOG_SEC for the rootfs systemd watchdog and use i=
t
>> as default for the cip-watchdog dracut module, so initrd and rootfs
>> service the hardware watchdog with the same timeout.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0conf/distro/cip-core-common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
>>  =C2=A0recipes-core/customizations/common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 7 ++++---
>>  =C2=A0recipes-core/customizations/files/99-watchdog.conf=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ------
>>  =C2=A0recipes-core/customizations/files/99-watchdog.conf.tmpl=C2=A0=C2=
=A0=C2=A0 | 6 ++++++
>>  =C2=A0.../dracut-config-cip-watchdog_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>  =C2=A05 files changed, 14 insertions(+), 10 deletions(-)
>>  =C2=A0delete mode 100644 recipes-core/customizations/files/99-watchdog.=
conf
>>  =C2=A0create mode 100644 recipes-core/customizations/files/99-watchdog.=
conf.tmpl
>>
>> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-comm=
on.inc
>> index bbcea1da..db3fe1de 100644
>> --- a/conf/distro/cip-core-common.inc
>> +++ b/conf/distro/cip-core-common.inc
>> @@ -37,6 +37,9 @@ INITRD_CMDLINE_STYLE ?=3D "${@'systemd' if d.getVar('I=
NITRAMFS_RECIPE') =3D=3D 'cip-co
>>  =C2=A0RO_ROOTFS_VERITY ?=3D "${@'1' if d.getVar('INITRAMFS_RECIPE') =3D=
=3D 'cip-core-initramfs-dracut' else '0'}"
>>  =C2=A0OVERRIDES .=3D "${@':ro-rootfs-verity' if bb.utils.to_boolean(d.g=
etVar('RO_ROOTFS_VERITY')) else ''}"
>>  =20
>> +# Runtime watchdog timeout of systemd, in the rootfs and the dracut ini=
trd.
>> +SYSTEMD_WATCHDOG_SEC ?=3D "60"
>=20
> The actual watchdog timeout should be set on the kernel cmdline by the
> ebg plugin (based on the WDOG_TIMEOUT value).

We can do that as an alternative for setting it via the plugins.



>=20
>> +
>>  =C2=A0# Watchdog to service by initramfs hooks during lengthy operation=
s like
>>  =C2=A0# partition encryption or factory reset. In our integration, enab=
ling
>>  =C2=A0# fTPM/StMM implies a U-Boot-based firmware which may enable a wa=
tchdog early.
>> diff --git a/recipes-core/customizations/common.inc b/recipes-core/custo=
mizations/common.inc
>> index 0fd3d4f8..09f4c744 100644
>> --- a/recipes-core/customizations/common.inc
>> +++ b/recipes-core/customizations/common.inc
>> @@ -19,14 +19,15 @@ SRC_URI =3D " \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 file://postinst.tmpl=C2=A0\
>>  =C2=A0=C2=A0=C2=A0=C2=A0 file://ethernet=C2=A0\
>>  =C2=A0=C2=A0=C2=A0=C2=A0 file://99-silent-printk.conf=C2=A0\
>> -=C2=A0=C2=A0=C2=A0 file://99-watchdog.conf"
>> +=C2=A0=C2=A0=C2=A0 file://99-watchdog.conf.tmpl"
>>  =20
>>  =C2=A0CUSTOM_HOSTNAME ??=3D "demo"
>> +SYSTEMD_WATCHDOG_SEC ??=3D "60"
>>  =C2=A0WIRELESS_FIRMWARE_PACKAGE ?=3D ""
>>  =C2=A0INSTALL_WIRELESS_TOOLS ??=3D "0"
>>  =20
>> -TEMPLATE_FILES +=3D "postinst.tmpl"
>> -TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
>> +TEMPLATE_FILES +=3D "postinst.tmpl 99-watchdog.conf.tmpl"
>> +TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME SYSTEMD_WATCHDOG_SEC"
>>  =20
>>  =C2=A0DEPENDS +=3D "sshd-regen-keys change-root-homedir"
>>  =20
>> diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipe=
s-core/customizations/files/99-watchdog.conf
>> deleted file mode 100644
>> index 1f38c559..00000000
>> --- a/recipes-core/customizations/files/99-watchdog.conf
>> +++ /dev/null
>> @@ -1,6 +0,0 @@
>> -#
>> -# SPDX-License-Identifier: MIT
>> -#
>> -[Manager]
>> -RuntimeWatchdogSec=3D60s
>> -ShutdownWatchdogSec=3D60s
>> diff --git a/recipes-core/customizations/files/99-watchdog.conf.tmpl b/r=
ecipes-core/customizations/files/99-watchdog.conf.tmpl
>> new file mode 100644
>> index 00000000..3d75192f
>> --- /dev/null
>> +++ b/recipes-core/customizations/files/99-watchdog.conf.tmpl
>> @@ -0,0 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +[Manager]
>> +RuntimeWatchdogSec=3D${SYSTEMD_WATCHDOG_SEC}s
>> +ShutdownWatchdogSec=3D${SYSTEMD_WATCHDOG_SEC}s
>> diff --git a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-=
cip-watchdog_0.1.bb b/recipes-initramfs/dracut-config-cip-watchdog/dracut-c=
onfig-cip-watchdog_0.1.bb
>> index 1fd1a87e..fdad94ee 100644
>> --- a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-wat=
chdog_0.1.bb
>> +++ b/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-wat=
chdog_0.1.bb
>> @@ -14,7 +14,7 @@ DESCRIPTION =3D "Build configuration for the cip-watch=
dog dracut module"
>>  =C2=A0DEBIAN_DEPENDS =3D "dracut-cip-watchdog"
>>  =20
>>  =C2=A0INITRAMFS_WATCHDOG_DEVICE ??=3D ""
>> -INITRAMFS_WATCHDOG_SEC ??=3D "${@ int(d.getVar('WDOG_TIMEOUT') or 0) or=
 60}"
>> +INITRAMFS_WATCHDOG_SEC ??=3D "${SYSTEMD_WATCHDOG_SEC}"
>=20
> Why template this at all? Doesn't systemd.watchdog_sec=3D30 on the kernel
> cmdline overwrite these settings globally?

I tried to have the same interface as used for the initramfs recipe for=20
compatibility with old builds.
Quirin

>=20
> Felix
>=20
>>  =20
>>  =C2=A0CONF_NAME =3D "cip-watchdog.conf"
>>  =C2=A0CFG_VARS =3D "INITRAMFS_WATCHDOG_DEVICE INITRAMFS_WATCHDOG_SEC"
>> --
>> 2.55.0


