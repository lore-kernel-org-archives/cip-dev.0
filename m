Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2668CCA5FF0
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 09:49:13 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41718.1791280148743229283
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2026 02:49:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cWkm3X/c;
 spf=pass (domain: siemens.com, ip: 52.101.66.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcJLMDqUPpzIz9DkvIWj9RSPMUgSON5l3gn0yZ0F6qHBK/PDauB1ANUG7ds4P7pdGnheEPyOcskxka/J6Th/kZXAW5GcP54zUNOnkG6vIqV3E1JIfdL3qPtFfeJEhACpiS3oE9pfBmQORoUmtZpmsI0zOJBzrVUT88C0P7ptCegErITPhjwr3qRaIvRZtzrLKPolhX3pjpIKKygYdpLPa+2+yp9G+v+eJ6C0uhe0tXQ+D0ATHsgiwaBl+sHDe9CcwpgdPJQvm6ORtM0aJkxle57AJ1hWynUNHemLVA6DTFHwMZUt9GU3PRwxi98I/dFcvLy8Ll1BGKUMmxOLR7tGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS0I6mbkRVvTwVxWo+RtXMz8rd+K5f+BjJcwGE0+K6I=;
 b=WmIgaCJQ1mNDHGkIhlzTDkByHMxjyUrs8xTDuYgKJ8eIcaux0CBIutBTU2Re0FOhkHA3qemvtf6qLMBUOgFBhPpCZdhpbT2D5YNpsm0lqRHY8ERUvE9qxZ2A7piNxBHBbWw0UDYJvBjLA35vF0OA32N7wVYO2DSBwgoQUNyUaCZKr/lnnirKb6V7rg2kt+uT7yffK2mh9ryQJpImzZozHqZM7YGihkPZ76Hn7HmCpGQhY5usPYeOkHZj9FwhnQoSz/VwP3uriyYJ++toKwCTiXB5COfFaS7Y1sFTBdX21qgroh5p4bbwxhCjj+61yX2Gb/dtx9F6P+5nYjdHcHA/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS0I6mbkRVvTwVxWo+RtXMz8rd+K5f+BjJcwGE0+K6I=;
 b=cWkm3X/cOvReBxUBlUsNQiDRJID/9lBqj7BI0EIAZeWeGxSuc8VmU+QS9lVHOll4heycco4FqF3DoQ9PuJEwX/GLAeuVScTQBcgZP7bYQnuk6gaJdJ+wti1Ll8aE0bgMTKq2hryPIkSNeN/ydmQxQ0ei2sR+mdLs4HdRkCeruSuP9Op1UQD+54fwTXtQGCX44l//V9esnIAcIs9oB1FmAbbzs1yX2sCfYFzngEGYBUoPq0F2d1UK1J1lvEPFBbBhWS06LWiu3Xyu0OP1/7TRQUsIf+i6mw5bgDIDDxh6ut3Kj0TuEYlkv3CuTa3Y2N9/2msOhVX432nl2yXjqaOqOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB7641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:636::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:49:05 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:49:05 +0000
Message-ID: <ecb14250-c5bb-4348-a4a7-2f0524d89e84@siemens.com>
Date: Tue, 6 Oct 2026 11:49:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 03/11] efibootguard-boot: emit systemd verity
 cmdline for dracut
To: "Moessbauer, Felix (FT RPD CPC OES-DE)" <felix.moessbauer@siemens.com>,
 "Kiszka, Jan (FT RPD CPC)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Hombourger, Cedric (FT FDS CES LX)" <cedric.hombourger@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
 <20261002111938.3600786-4-quirin.gylstorff@siemens.com>
 <8541e3fbfd401936ffad06669dd951570253d709.camel@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <8541e3fbfd401936ffad06669dd951570253d709.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIUP296CA0150.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS8PR10MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1e7e4d-0aa8-48a6-2f67-08df238f0eed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|55112099003|22082099003|4143699003|6133799003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 
	195AZ1Ww58Dle1565ZMqwOQJdqHhtsVf3E9245BPnEygcxkt59nAamDxXIs+zS/X9giMrnguKCcRePOne5GsU/urCTnA7u/A2cClHYBCsPvdwGY+9u3jOMP0qVAcip6Us1idR5U+mS5aMR5eMP5u+NasDtK2Tk1rTwD0iCVRhk0RHhIJHfnFAsUHdf8nK39e0DZ0DiYNjMci2VzIMnvpyXM0LFvbYnkRpO/Kn+vkK93mEDKm//C971n30nWJVpMjvcpW0tGDaRo3ZEeOT0wip/Y220rbhot3uVXIFT2okoEaw7b61GErLbrvori+ca9DuYJ53x99LFUcXNcUAOe84i/PjBsg1NoTuzZlagYiVDAPiM1lCfr+7vLbzYY0lglYHBEvJCzzTv/S+47u95CU8OqW3E6u+GLrwSAz5LVXuMXZw7yMp3ouMczddkVlmRuEc4RrvDrCMT+bKkozwbmjTj5Y1iZIyUQPZ5wgbL8cfexeoUuQpkTTJDGLYwWQUtDssPjKIlHCTlR9RNVV0Cyz0BZusXVMcBrwWsG0Y94SDk+GKwTRTGzsf3qYJqBsOp98gKRKeaC8FtXBA+QGmoe7B2BkyMLAassSrFHvO6p/Bf46bwLa0yOrv0/hvAiheNm8aSScHOcIJmEIkoaWhpuWvnQ2K7GId8iTrAyooCuI28A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(55112099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?khZGRPB7EjDaHGKnS6AmBqpR5VQ/gfClEp37OuGxsEVTYfLkK/38hgbEjf8B?=
 =?us-ascii?Q?XjQwC60ziS10Da+U+JBqTKqHWrnYKkGjYB4+dL8t6lHYuAeDVfpqtR10ZyZ2?=
 =?us-ascii?Q?w00r1WICoicxd18c3UZNY6CHZEE4e2dwYHi6rARljbN/V7hZUFi2qBl6DkrZ?=
 =?us-ascii?Q?CPGgEgEWJCxs/azRnPG2bjbotT4wM7eyaOpAyVl0J3h0pd1Gm+/lDlFmRunD?=
 =?us-ascii?Q?ZGgKDzPDQWv6BlezK8MoSY+cZLDsFlRiEsosVVN1bpe+nnXo1vyY9gM040Rg?=
 =?us-ascii?Q?IJTpRAct7zY59keEDOjTU9gmpwpsIM2wgxeR891ZHAx9x8uyhOBZdYT3zh6p?=
 =?us-ascii?Q?qABqYI4poCUH++oVbKTLoo1g/vw+l5AgfL5OiX+nvQC72XAPCOAktM9ZkE1I?=
 =?us-ascii?Q?1U905EnrRrkjQBWzl95oVZhlvFHaTl0oDKBPzOmDeWweSGGs60AL/j0P/Y++?=
 =?us-ascii?Q?v/RyuvFxp+dGZX5Ej+cBJ8FjhEgPa7XiBfrpcabH33TeYFpWUsSUDMskOJg9?=
 =?us-ascii?Q?oG6Oek8vCnFnpTfy1F2OO63AkLSPBYp/RM0HtWyI2x6Qga4dBIFlA25pEEIZ?=
 =?us-ascii?Q?njOQkaO2pxUIlvAA0h3yrtcE91g+kz7YDMkRWsbDqp0E+GKc8b7vGrsDIuDy?=
 =?us-ascii?Q?RKmdU6NTPQ81lnst1ano+FpbBJ81zeHYRZCXa3a4bci3i0rHnyGCEPK9C/2s?=
 =?us-ascii?Q?qy1Ghy2zSwV/XxCXcbZEpJLgV6qISP515qfi2pWmF3tJh2ycT1AIBes2X1lG?=
 =?us-ascii?Q?BbuWVt+jlaQ91Us8T+fGJ5Fqx53wNKK5EM3kAq1+Z/jK42aCDqNNGGWmt4RU?=
 =?us-ascii?Q?wZRSmh4YhbtiSoUSaoaVccmKKnYm44p1uqhTWWdVkvRvCc/8F62JA4YzGa48?=
 =?us-ascii?Q?JPVLSOttyWetZOk3I5R1K2vtQe9BStcrcQjX1HO4z1af7EUM9uFyaRsLtFGI?=
 =?us-ascii?Q?NdcQv87ek7l27ePzsnL0BFmIC9YOQ9uzKM6nJDtiY53vspuHvgEA1Rx1ZioR?=
 =?us-ascii?Q?PA4cqTILMi/GOT5c/db58Pp/9twgJ4Ginm7qNfl9KtzoxCs60LOe9HsuOwTV?=
 =?us-ascii?Q?4dYFnmGrQmmfwuwh7CsbA8rpsS+c7XwvvXqvlV990ipr/FmweWP18zMIYshY?=
 =?us-ascii?Q?IuyaOm1C2+h+VjMfZsyqRoGkLl/ilAyWOFQvxKbDXN5q4qZ0Hq6pT4zhVU3l?=
 =?us-ascii?Q?IWg5s3oLhGXzO69+OFSO7MG6aAUOT8x2ZijkQ14K1UlIArXvgkNyp8nbFU0/?=
 =?us-ascii?Q?4PFUp3g3zWtCmmvG5a1Hcaccn4Cg2sV0lnrc4PLZCY0qF4YpvA1+e9B1Zpl6?=
 =?us-ascii?Q?Ojc1KKWhLWoFwb62QEyR82k7TmAyQn35bCFhWaXD3a6D863hGpIH4zK9o0a9?=
 =?us-ascii?Q?E2pGtNgoXckqD5jMnC5igXi1x7/aOUNs1mEa7V+pV7kfzAUPZu4D4RHZujE+?=
 =?us-ascii?Q?asofky3BsQRCZLXp4KT1+/NOnHeSuz9TM8fu3GG1QArztW3mTTxUaEIRtgEj?=
 =?us-ascii?Q?wAspgSEzAHDOrvCqERz9u+pK/PfRBFRSVCsNUu0Z8lH0xnIQzB5q+0f94LW2?=
 =?us-ascii?Q?Tess8I4biw+lvcsHcYkTLbnrfav9gPM7B6r4RoZdQPEJbnrCeFYyYOOMpiD1?=
 =?us-ascii?Q?x5c55uXkON6oMhn3QxlQW5exCZKC6ZYVDRgVhtRvPIuwMaFwNvP1phfChLLt?=
 =?us-ascii?Q?dqEFctzIHJOtvnDtXWXYQd6TwxFvrhKTpbqSaJSLncfVXElVzjr6UdX5fRqW?=
 =?us-ascii?Q?K/QRkEAI1Gjd+sRh9vFM5TbX3pvmAc8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1e7e4d-0aa8-48a6-2f67-08df238f0eed
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:49:04.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcUxcwSkNIV3+pf1AOmY12B2OttbPHOLXwOOZUoALErHJd66cYdHCXbC5J9zLcz0Ye2ihl+oZ4jM90HTILWnUvkOhjN/h5gmEYKA9nGIttE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7641
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Oct 2026 09:49:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24432



On 10/2/26 5:10 PM, Moessbauer, Felix (FT RPD CPC OES-DE) wrote:
> On Fri, 2026-10-02 at 13:18 +0200, Quirin Gylstorff wrote:
>> INITRD_CMDLINE_STYLE selects the kernel command line dialect for
>> verity. The default "initramfs-tools" keeps cip.verity_root_options=3D.
>> "dracut" emits systemd's native roothash=3D and
>> systemd.verity_root_options=3D, with the data and hash device resolved a=
t
>> runtime by the cip-verity dracut module (/dev/cip/verity-data), plus
>> INITRD_EMERGENCY_CMDLINE (default "rd.shell=3D0 rd.emergency=3Dreboot"),=
 so
>> that a failed boot reboots and EFI Boot Guard can roll back.
>>
>> Also drop the LABEL=3Dvar entry from the generated fstab. /var is mounte=
d
>> by the initramfs (overlay and crypt hooks); the additional fstab entry
>> makes systemd manage a second var.mount for the same filesystem.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0classes-recipe/read-only-rootfs.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++-
>>  =C2=A0.../wic/plugins/source/efibootguard-boot.py=C2=A0=C2=A0 | 33 ++++=
+++++++++++++--
>>  =C2=A02 files changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/re=
ad-only-rootfs.bbclass
>> index 70152de2..179dcb98 100644
>> --- a/classes-recipe/read-only-rootfs.bbclass
>> +++ b/classes-recipe/read-only-rootfs.bbclass
>> @@ -17,6 +17,11 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
>>  =20
>>  =C2=A0do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
>>  =20
>> +INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
>> +
>> +INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
>> +WICVARS +=3D "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE RO_ROOTFS_T=
YPE"
>> +
>>  =C2=A0WIC_HOME_PARTITION =3D ""
>>  =C2=A0WIC_HOME_PARTITION:separate-home-part =3D "part /home --source ro=
otfs --change-directory=3Dhome --fstype=3Dext4 --label home --align 1024=C2=
=A0 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f=
-3448-46dc-9c0f-58904f369524"
>>  =20
>> @@ -76,7 +81,6 @@ image_configure_fstab() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 run_privileged tee '${IMAGE_ROOTFS}/etc/fstab'=
 << EOF
>>  =C2=A0# Begin /etc/fstab
>>  =C2=A0/dev/root	/		auto		defaults,ro			0	0
>> -LABEL=3Dvar	/var		auto		defaults			0	0
>>  =C2=A0proc		/proc		proc		nosuid,noexec,nodev		0	0
>>  =C2=A0sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
>>  =C2=A0devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scrip=
ts/lib/wic/plugins/source/efibootguard-boot.py
>> index ca97d7d7..f6d16310 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -36,6 +36,7 @@ import logging
>>  =20
>>  =C2=A0msger =3D logging.getLogger('wic')
>>  =20
>> +from wic import WicError
>>  =C2=A0from wic.pluginbase import SourcePlugin
>>  =C2=A0from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPAC=
E
>>  =20
>> @@ -91,8 +92,11 @@ class EfibootguardBootPlugin(SourcePlugin):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdline =3D bootloader=
.append or ''
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the verity cmdline f=
ormat is identical to systemd.verity_root_options
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if source_params.get("=
verity_root") =3D=3D 'y':
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdl=
ine +=3D " cip.verity_root_options=3Dpanic-on-corruption,%s" \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 % cls._get_verity_opts()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if g=
et_bitbake_var("INITRD_CMDLINE_STYLE") =3D=3D "systemd":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cmdline +=3D cls._get_verity_cmdline_dracut()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cmdline +=3D " cip.verity_root_options=3Dpanic-on-cor=
ruption,%s" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 % cls._get_verity_opts()
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if source_params.get("=
abrootfs_root") =3D=3D 'y':
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cmdline +=3D " cip.abrootfs_root_options=3D%s" \
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 % cls._get_abrootfs_opts()
>> @@ -188,6 +192,31 @@ class EfibootguardBootPlugin(SourcePlugin):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdline.append(f'{k}=3D{v}')
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ",".join(cmdlin=
e)
>>  =20
>> +=C2=A0=C2=A0=C2=A0 @classmethod
>> +=C2=A0=C2=A0=C2=A0 def _get_verity_cmdline_dracut(cls):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Emit systemd's native ver=
ity arguments."""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opts =3D cls._get_verity_opt=
s().split(',')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root_hash =3D None
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rest =3D []
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for opt in opts:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if o=
pt.startswith('hash=3D'):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 root_hash =3D opt[len('hash=3D'):]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rest.append(opt)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not root_hash:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rais=
e WicError("efibootguard-boot: no root hash found in the "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "verity environment file")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootfstype =3D get_bitbake_v=
ar("RO_ROOTFS_TYPE") or "squashfs"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 emergency =3D get_bitbake_va=
r("INITRD_EMERGENCY_CMDLINE")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if emergency is None:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 emer=
gency =3D "rd.shell=3D0 rd.emergency=3Dreboot"
>=20
> That means in case the variable is set but empty, nothing is added. As
> this is security critical, we should at least issue a warning if these
> values are different (we should also check the parts provided in the
> wic script).

Which is a valid case for debugging so I will add a warning.
Quirin
>=20
> Felix
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (" roothash=3D%s"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 " systemd.verity_root_options=3Dpanic-on-corruption,%=
s"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 " systemd.verity_root_data=3D/dev/cip/verity-data"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 " systemd.verity_root_hash=3D/dev/cip/verity-data"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 " root=3D/dev/mapper/root rootfstype=3D%s ro %s"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 % (root_hash, ",".join(rest), rootfstype, emergency))
>> +
>>  =C2=A0=C2=A0=C2=A0=C2=A0 @classmethod
>>  =C2=A0=C2=A0=C2=A0=C2=A0 def _get_abrootfs_opts(cls):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abrootfs_sd_keys =3D [=
"target-image-uuid"]
>> --
>> 2.55.0


