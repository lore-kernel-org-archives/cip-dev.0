Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14631.1793287559694957191
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 08:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hSL6b8ut;
 spf=pass (domain: siemens.com, ip: 40.107.130.43, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5IFgbh6aq9EPesQwhB+7aq4q+DBAWuDiY/USpkMlJACrdb9ThSCOUg88Qzu94s8SleG+ErnARp0EO5x0E9KN7vaUmj7v0L8nnPEfPkAZxkg5VphKbPldRtQavJEZigao6t80XK4s03//FnKIwzH/0yYlgXMS1dR8vFFvXikOgWsHaazQ4Vytp8qrQBED2hfsOFPxapgGnAf6o9xQTMPSIxK7nslk75ZxU2nQi7NtamI8I3AlCfWWmDKNk+CcQOyGro6aMUlH/f3/o6JZ4FoFJU1vhXSxtJelBAzd2T/v9cwWcH/2gaBAmmbgA/wL/xtjs3jMf94p/bpMqluVyzjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2YqwwugZQm8NLN4xdm1VgMh66y5sfkEevSpciLBBI8=;
 b=HwiMTulL8YNuxeLQ67CA70kMi/KleO/0NG6Ex3PygWeEp2L/hLj4kxFW6cPx+/mdgJ+2/us1duFx5kwyofh3aOiFUU5poiS839SgGB/3j9IK+49P9PdDx0DY/0Eo/lMmZDoIkGBkGxb2EULFiyEgEuyqIYKf2NoBQ9lp+0bVGFzAdHaGMdTwi3UUcGoXnuHFMTa2c/URumZqItRsg5rRGQ78ehdBADaRFr4PN9Won2RmbkgHXbF307cqk7H1THhquuizlT6qFSpLxl80g+WqHcBRHXFiGl6sbjDAUvrFcSwkltUWg4kWNfx0YZoDtlxbBzxIHZgj2al1p0I/6Cw7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2YqwwugZQm8NLN4xdm1VgMh66y5sfkEevSpciLBBI8=;
 b=hSL6b8utASneUAAfeqKk+06ICI9DmQR8WwlL9xsGFNWjZT2iofIvXf1ivMK4gL95gmDToIb+UFEl/mNqB5qn8dldbn8oRz9XxbOeUIxBhx9hBn1A/id1nzewPsMHJDsEgP0gWFSaJLYYwDYVwM4AcwqjsnJ11GTD3qwYZrbTj0n4o2DdnoG+CGZ0/5dr/ChMhFT6PmtH2uF+zch0JDosXi68wo+02at/ZiKRBYxnKwN5OFXDoMyVNEzINur+tUSiBZnjJvWEi+wdujZmdCpjgt2u1bPIV+me49B9p+4JzaD0t4z76hhwxmlDVDiifYbV08Ryvyy2oLO/8gtRieHpuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by VI0PR10MB8523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:237::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:25:55 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 15:25:54 +0000
Message-ID: <93908048-366b-499e-a3b5-6a181d6694d0@siemens.com>
Date: Thu, 29 Oct 2026 16:25:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] customiziations: use Isar
 hostname-costomization for HOSTNAME
To: quirin.gylstorff@siemens.com, cip-dev@lists.cip-project.org
References: <20261029143637.404080-1-quirin.gylstorff@siemens.com>
 <13222d26-e9e3-4d18-b542-97f5b04e85db@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <13222d26-e9e3-4d18-b542-97f5b04e85db@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIUP296CA0110.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::13) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
Return-Path: alexander.heinisch@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|VI0PR10MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e5626c-a440-4b64-fad4-08df35d0ec84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4022899009|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261026121527099003|261022115727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: KOb8XyFCihQ9b2x6o0JKJSu83IC5SaPmNAIQqhNeBTsAUOnhRM5aAt+VO4ykCJgq2Q6viOkaDDx/vyz+w5OxZE1n13vZTYzzEW12CAphUNiCgaO+WN9l6e/LRzfe5/pq3KqK6j7nHMQ1ya16Z3zCndy3we7uiaQiupE08gi46FBDzy1VFOqXHLmRBPSJ4T9eVi+Pac7nZo02XVfhuviViWw0iq+2RlSzAF1BJVwNHLcdXt8uk+ObdjuswyyqykoAttucCFzt9bT5/yLs5EGKhURsrtyXFkDPxAJlxim57CUxqAnk9znl7D6UiiKP50k6R03MBeYb8ji+eeSXx0xbQ0FLwNcgIqJMUDCylrcAxwZtBxKTrhctVD1mw381KPmb3fgYg4snxQJexcgLDY18pRgDGuu5N+nTBmBy37Sp+wyfYo4dx8kCfWmkNJbBlyZTtkmoqR7uWgtk/HcTwCMsOZdjxEbfnRkZ05d0vN6LdKwrWsIIIWPqiGGc4INpfXyprpuwACDeN3j16EUOdRw+H9dn7GBYmxlKv/SwBQ3SI2hz/VNPlBfSlfZr7rBaZ079HM82gczXSCKwinXTK6PB20e355h00UM3lzBhOEym1fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4022899009)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022115727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EG+HiLgdS+owDrxAvmrLcJ4Asvzeuz1e3Ji0ra4Ly/p0aSwdETXfH4BgCTHk?=
 =?us-ascii?Q?lWRoQezAaHoBFhxWqVBvoAyZstWrodtIl2AicLs4lFcI2xHVuELgZGi2TX5W?=
 =?us-ascii?Q?CvbG4OsAz+6SsWkG8flN6u3/ceuDr75hHbkMbwPIzEEMnYa5h33JI7TqCu24?=
 =?us-ascii?Q?IcuY4G/+AA1BnPIwO7d6CfGzrnCAcTJTqD5a0KV9xknJhlIboJ6U7TDof8Yv?=
 =?us-ascii?Q?T0cSBHRAqeUEmXUe1iCgctjUADS3U7Woa6xFQqbH+36x2tZXN3NgDnga9MAd?=
 =?us-ascii?Q?qq/8DwWdgg0uqQt3J7su/veRHVV4BOCKu2l0ekCpJEruKX2Fx2Qqrk3xKucH?=
 =?us-ascii?Q?TMMi8kdv+ar56I6xqyzqG5RhIbwOuLvu42l88YHOt3ZlNdBecLV7co5x06ek?=
 =?us-ascii?Q?X5aJe0nbu1acKWhWha3XH60Za1iTObGTRnPYEEb/OJDy6RW4m5JMzJrgop3T?=
 =?us-ascii?Q?CDEon68fz/C/SSoT8bzzPYhhM0Q4aT/ZnrMQUJ1E4QC/jjwzAk9Wpnz1xnAN?=
 =?us-ascii?Q?0CoQ5ZzNrwgSyWUpiwYbqzYPk3NiXfoaAMEBe4TjjFkV+b5KMsmZK6I+DO8D?=
 =?us-ascii?Q?laCJX99l4AkYKBQt87Uc7wYPzLTqGgzv1F06+u0ys5Qcnig0C3zfaclod3lZ?=
 =?us-ascii?Q?rPJS38xm/EbQpwK+HEdJLHQBxlPGL1NpiV1W9wlrgbNze2GDdzrGswvKS8y8?=
 =?us-ascii?Q?dXUa8E/SwyZc2KyQLCKclfjpD7Kj+8jvzE5JlY13lV8f1qyInvM+ZAFH3iUf?=
 =?us-ascii?Q?BhSijdFT61xDuMVsZKOiUqWrEsGgkIDPF+3DQ9P3X8po52XBeUI06RS42XPn?=
 =?us-ascii?Q?IqzAUx06MzdSR/UsAWdfi+uOVjSrCxkDcDOaEgvk5Zkx9mQ0LwzSAng2FQkZ?=
 =?us-ascii?Q?/EPUJ1T0xLEtRpabLaMACvfTDq0kijzby9X68WmsAATAlMZJ8BRzWoTEhWf+?=
 =?us-ascii?Q?XwD1xnPnk736B05ssJBUOD6El5CkejU3g09r0Zn2qGsE4L7Nxipp4a98gMG9?=
 =?us-ascii?Q?izGmBWVOCEcWKQ97UBcalkduCdWDOeQCyMXdgkSFKSiWv8y0mO/KXqPQWFnU?=
 =?us-ascii?Q?uvXNlhRByJbERDTCzC7kWbvVHh27bNNzh0+/zXa8GICfc4iKV63Ja/vlddvF?=
 =?us-ascii?Q?hTincixn+QGayt091tb81Qjq4ywSHvQ5ysgbxac5iIxuF8l5y22uQJEMcZcg?=
 =?us-ascii?Q?YqrjkMiLMBRpj4AbM5YrXDkX+sU1rbABGxPSmFvCEh+u85g8IR0fxkN1wC1a?=
 =?us-ascii?Q?gvW8NcsNBPGofcknHpPWdw5AvxXtO1ebubfHkKZu9sG3Zp3UEd5KHrC0aApE?=
 =?us-ascii?Q?8uog1MTSqZimII29xBraHR2qhTibbL+6YC5YN4eMouF7FXXI7Z16H9uzgy/Z?=
 =?us-ascii?Q?JJNmp3lZkXJRSVv/XFBhuVbbnHeqklSppeY7ZKZiTGlA02lJl4GOdb3JW2+J?=
 =?us-ascii?Q?muxnrZ3fjCSHyztiVaDCZ9T58GM9/ChCJCHPsFoZCc1T/ZkHx3F2lVzGgpmr?=
 =?us-ascii?Q?h3D3Y+jQvT6dgr6mEagiiCCrIQJDdG62quDWdVs8OizVPmoSbHQ1/de4vH1c?=
 =?us-ascii?Q?dkbnkxnMlHvYWIeHopdB2gr56K5uVufS2rsfCuQI04YkRkeQuwRXol8V+qvX?=
 =?us-ascii?Q?L2YcAETWk2WFt28CcOLUWMw4k84vtUQ7aej9uHUFLcC2BAYPhq0580eFOPK5?=
 =?us-ascii?Q?WEP8jpmmf0ZayxXbMarZBJC3aaSmjCDvvp0rOGZ/7LPe/7GNVrnJvuMmh2BA?=
 =?us-ascii?Q?ixfo7plfvdKORu5mg8ocDTjTMkCBBNA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e5626c-a440-4b64-fad4-08df35d0ec84
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:25:54.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/efov0vX3eBAnvrzPrHwhoZdqUZIKqHnvji2WprcFJ2HcvGr7bxdvcziJWJmOgi8KorVNVr+CCuLfugc10U/UHnPIBvKQ93GZJhDLiylBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8523
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 15:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24576



Am 29.10.2026 um 15:59 schrieb Quirin Gylstorff via lists.cip-project.org:
>=20
>=20
> On 10/29/26 3:36 PM, Quirin Gylstorff via lists.cip-project.org wrote:
>> This removes the postinst template of the cip-core customizations
>> and also allows to reuse the `recipe-core/customization/common.inc`.
>>
>> Also add `#DEBHELPER#` to postinst to add the by debhelper generated
>> code.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes since v1:
>> =C2=A0 - Use CUSTOMIZATIONS in image instead of Dependency in common.inc
>> =C2=A0 - fix missing space in IMAGE_INSTALL:append:factory-reset
>=20
> After play around with CUSTOMIZATIONS I would not apply that patch. In=20
> my opinion this feature should be removed from ISAR and replaced with=20
> debian packages or IMAGE_FEATURES and the HOSTNAME should be set in=20
> IMAGE_POSTPROCESSING.

d'accord,



... that way HOSTNAME set in image recipe actually has effect :-)

To be continued on ISAR mailinglist...

>=20
> Quirin>
>> =C2=A0 recipes-core/customizations/common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ----
>> =C2=A0 recipes-core/customizations/customizations.bb=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
1 +
>> =C2=A0 .../customizations/files/{postinst.tmpl =3D> postinst}=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 +---
>> =C2=A0 recipes-core/images/cip-core-image.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 ++++-
>> =C2=A0 4 files changed, 6 insertions(+), 8 deletions(-)
>> =C2=A0 rename recipes-core/customizations/files/{postinst.tmpl =3D> post=
inst}=20
>> (70%)
>>
>> diff --git a/recipes-core/customizations/common.inc b/recipes-core/=20
>> customizations/common.inc
>> index 0fd3d4f8..60bc5245 100644
>> --- a/recipes-core/customizations/common.inc
>> +++ b/recipes-core/customizations/common.inc
>> @@ -16,17 +16,13 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-=20
>> project.org>"
>> =C2=A0 FILESPATH:append :=3D ":${FILE_DIRNAME}/files"
>> =C2=A0 SRC_URI =3D " \
>> -=C2=A0=C2=A0=C2=A0 file://postinst.tmpl \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://ethernet \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-silent-printk.conf \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-watchdog.conf"
>> -CUSTOM_HOSTNAME ??=3D "demo"
>> =C2=A0 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
>> =C2=A0 INSTALL_WIRELESS_TOOLS ??=3D "0"
>> -TEMPLATE_FILES +=3D "postinst.tmpl"
>> -TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
>> =C2=A0 DEPENDS +=3D "sshd-regen-keys change-root-homedir"
>> diff --git a/recipes-core/customizations/customizations.bb b/recipes-=20
>> core/customizations/customizations.bb
>> index bf6e7175..3f931b8c 100644
>> --- a/recipes-core/customizations/customizations.bb
>> +++ b/recipes-core/customizations/customizations.bb
>> @@ -13,6 +13,7 @@ require common.inc
>> =C2=A0 SRC_URI +=3D "file://ssh-permit-root.conf"
>> =C2=A0 SRC_URI:remove:security =3D "file://ssh-permit-root.conf"
>> +SRC_URI +=3D "file://postinst"
>> =C2=A0 DEBIAN_DEPENDS:append:secureboot =3D ", efitools"
>> diff --git a/recipes-core/customizations/files/postinst.tmpl b/=20
>> recipes-core/customizations/files/postinst
>> similarity index 70%
>> rename from recipes-core/customizations/files/postinst.tmpl
>> rename to recipes-core/customizations/files/postinst
>> index 62e9a1a2..c65e2d36 100644
>> --- a/recipes-core/customizations/files/postinst.tmpl
>> +++ b/recipes-core/customizations/files/postinst
>> @@ -14,6 +14,4 @@ set -e
>> =C2=A0 echo "CIP Core Demo & Test Image (login: root/root)" > /etc/issue
>> -HOSTNAME=3D"${CUSTOM_HOSTNAME}"
>> -echo "$HOSTNAME" > /etc/hostname
>> -echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
>> +#DEBHELPER#
>> diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/=20
>> images/cip-core-image.inc
>> index f6162cd7..ba942a0b 100644
>> --- a/recipes-core/images/cip-core-image.inc
>> +++ b/recipes-core/images/cip-core-image.inc
>> @@ -11,6 +11,9 @@
>> =C2=A0 inherit image
>> -IMAGE_INSTALL:append:factory-reset =3D "factory-reset-helper"
>> +IMAGE_INSTALL:append:factory-reset =3D " factory-reset-helper"
>> =C2=A0 ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags=
 --=20
>> dirty --always --match 'v[0-9].[0-9]*'"
>> +
>> +CUSTOMIZATIONS +=3D "hostname"
>> +HOSTNAME ??=3D "demo"
>>
>>
>>
>>
>>
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24575): https://lists.cip-project.org/g/cip-dev/messa=
ge/24575
> Mute This Topic: https://lists.cip-project.org/mt/121994979/8886423
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [alexander.hei=
nisch@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

