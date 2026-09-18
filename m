Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5BFC88E75
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 07:40:39 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6139.1789717230994171675
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 00:40:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XWw23wkw;
 spf=pass (domain: siemens.com, ip: 40.107.162.28, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8MldtYqUwxaR6G4JyfsFJSw/7B8Vnm4ZAzPQ6/CtYRu4UOQ4f9SAcz2tA73IHz3irPgZYH3bpJF1CtLLkGbR/RAo6ur8dgPc1IANqh/5Ll4HqruIaoyK6XeKUHjRdLls9zCiAfi8TAHmLYMIHjr/hTB99jLnEV/Rya20T4zM2JwZtKhL4lhBlznKOcDWNlSST1qhamW1CSr3ugJOXdZGVoUQI7eq9erB9UGdQ8gxS5kce87hjGgyjhhga7v/pHhDcHqfS7i8EeRgeFqS10u/HhK4zJm9N+iOOvZcfrKrRZg1ma2mqWax2nZnMiRd72s97JM3WUguSiasFk7flUVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwymAnBVB2hwV9/79QbGRsuL8UkKOkNPVI3j+f9rxr4=;
 b=dSz8q52otxtkTvGJQ6DinZyKpidxp6sxyoA4qUalcmiOs4QO6rrEo2rIRaI9dGwVW63nuSl/GbEeFcfrucSp/kJ7f1YMkz76LxeUuzyq7ghHSsoR1D8tIKWJpcVCluy35WwvB5AX6Epp4Ia0zA5xfCWJ+yFxk2WpzZKfO/VJQO/p+paKnilV7HuYKLi72/TH3aplztO1dKfm1fjg0vTvo5ETvgYKviAye8VMg3WT5eiOKRLxsI6EYSoMoChDvfTeo/9QeiapJfTAPREA2lcdJTOpE2fp2nnXFcLZjGTeLdjKeh8TwC+FVlhAUU8xVm/r1I8RlLbs4uT6+r4Jf+5qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwymAnBVB2hwV9/79QbGRsuL8UkKOkNPVI3j+f9rxr4=;
 b=XWw23wkwpGPpJ9ubUI9RqdDx+Kq5bN8ga02RNSnulKARcY1BLyxKoxwionjiUJvzuEuxJ5SscsP/8OBht3KEOlUTWQjRqaZJa3BshoFlLAsO5fBwUPzdQn4wDCnXBHEHK9SllW7CEs7AoGOEVoJwvrMHGc1uOTqiT8S5XFfp/44lcCQ1wvnJZbfk/hHfbK59YK2diKW43r9JO3ijsnPqKWUkVimVdj153Ex7E8unt4y6nmdo50JI1ueIjgi4j8mzismUkr/uZCsQQmRa4O8feLihT6Dy9tlg75xVy2EcZcgZtlDd4JhdHWy8vjy2BqL8MTCegxrhd8TjL2xTGaj9oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by BESPR10MB9223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 07:40:27 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:40:27 +0000
Message-ID: <fd80eb75-c6d1-4485-8e14-6950d95d0b11@siemens.com>
Date: Fri, 18 Sep 2026 09:40:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/2] initramfs-factory-reset: Add
 option to clear partition before new fs
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
 <20260825143802.3764929-3-quirin.gylstorff@siemens.com>
 <65a1f330-1941-4d09-97ed-fc29421b35c2@siemens.com>
 <658067cd-ff46-4ea7-b61d-f65aadaf76b8@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <658067cd-ff46-4ea7-b61d-f65aadaf76b8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|BESPR10MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f2b450-b3eb-4833-4dac-08df15581ab9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|55112099003|22082099003|18002099003|6133799003|3023799007|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	1dZGSb3A0i42iF3JmM2iNUEZK5VieEPAitTfMbTPHptluNir1LXUV9YstJVUufU4UedRdkj8Qx37HLnt0u8VBFW2NN2sxTgRltBXhDDxbEShEPv8n2P8pm/qYcJHiSmbH/Umtwvi2qKhe0cKT9f4wpZ7Rx5mghIDSL92QRqs+MYIJVjj6eWW9ErFuPGRdl1gcHFqiEe66ViE2kuC2QKRRMlaiXvwT74blxZyIEBF2Qh5EwfepM5OvZp0gIwe2tflTTGFLLRF7xKWzzabiqNiQtosS6Ba0yDhwkjzJN3KIYDGi0H/sVqrqQHq+2NeVVn/alVDF0wIvy4/d7xToal1ikc1pQsIT+Y9qXmkGPs51jDwZv4lBPK0HicrHwW2YeGUuJLjSstK5LzXKxC88MjQp8nLYE3BgnV9HFHx8RG3iVOqy1uPkdODCpaEwCmiF8cJeZZjZVAlOVHWT1cgd409OBYIBQ8tQaQJME1BlXnxdSOYGJkIAdqjrFGbh4NtHMIMu7JQLsbvVozynQ7ObzjEGg0WpQZGrNF0ejLh8IxbIwwBGQU73Zmr4GIcQ0tsM+d+E7H1KeUYKL5dMeRPpS4z1UXTSfVBW+u0o7C4BiXOnlzPWCeqqXjQOr5FJ0YlYX4o4vh/iZfkXvNKFkur6Rb6y2NiiYeTnUIs4Rr8/FSMuto=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eUmmTrmaeJlNAyFwNrXMoW0syUgxvdBuqluRq3XnVvT0sX/jbgn4HWka4mZF?=
 =?us-ascii?Q?axLiC12xbKVeqhqZFzczsG9WPiAKjI89isfq+3ludnq5EtikAjSx3kqDaMO3?=
 =?us-ascii?Q?tZAL/cr7s4wiBivyMK1bIXdUPmQjn83BA5kTvCpwpDJybJK8g8bg7MMLWDIN?=
 =?us-ascii?Q?/xGJGgnllVHjoLXiDn5jhi1DpY0a2ywReYcR1NAhEB8OkXm84XrO2E0pvFO8?=
 =?us-ascii?Q?B+KTngxQm0pEk+v3vAtbaLPeo1G6+cw3dWSyfvIJGKwmu3DBo1+yKXAdLbSn?=
 =?us-ascii?Q?vm5pYYYTuvmo//1EWTFj8wuWzXtQRuxoKO3DJtUoNWyRjnZa4/mU3Bj5oHZc?=
 =?us-ascii?Q?ksq3p+RNTlqi1IogwOH0FlCecKOUJIJJKAYHPkEtMmTN3HSbwaVNFoRyiuk4?=
 =?us-ascii?Q?zbvP9Rz494cVkO+j0RT3/j73wkVjyzquNfwy0MaZQK+dHjbikZl2Xo/Kntxl?=
 =?us-ascii?Q?zek4wuYA/OK4wCXRbAcsfmppw2a5LuS1/UgwQ8m7FiL4xREHVsAnGTlwfEkW?=
 =?us-ascii?Q?RPw9m+bm6r8EKAG9mIZlelDMDzW0kyXrcn83JPTrrCI2JpWVLEIigOq8z0Mb?=
 =?us-ascii?Q?vW5+gZSW+jh2xsHDeEUdAhwD/HNqlVSbVcnGSuqyCWlpBgz+yiyel5xUfLec?=
 =?us-ascii?Q?T+TYk9eBJvbq3YpxjLfTR0JAZvwHn1fAC//dFLSp95pIWaA9JkLFymunF7OU?=
 =?us-ascii?Q?E+lC85kUaMaIJYbURacZbIGz1bRnhPdLq/xdH97W1EBzBMdHztVM4Ac0xJ6A?=
 =?us-ascii?Q?qjf+tgrAVgUioGD5lDgxEA0p/giHMlfRr7R0CtLYcEtetbL2S7Z89NlO5v+J?=
 =?us-ascii?Q?JxeVL+kVOrdu6HI1VpXrJO9RGQcksj+Oqox0k9ImZFFwaiigr7YYiNZP7tCa?=
 =?us-ascii?Q?CV1KMZPYb0KvSc7KuJGQ0IPC1Ts916NCoG08do3RRCJiKil+Jo8fE6ucFdx/?=
 =?us-ascii?Q?jpN/DR5TXCLbNioovmoeTqXuXSPd/LfHe3nxjEHzrtMb2woGVfgVaQe79Ulh?=
 =?us-ascii?Q?cPNcvY+UUSahnQRrvfLtNLbIcvZ+IWKzYUwvJx7LfZijrfUa/9GjSgARxzqn?=
 =?us-ascii?Q?uOUT+FuJvJcqLtBJ7/Bnn9JLN8zdQIlMGVrnnMnHK6EX02tMJoVIPEssd3UM?=
 =?us-ascii?Q?9FCMKkq315nT8EGQ+BaJxOmlxFfBiswfzlKtTB4AkiA8EhK8WOKxv0YHD0wC?=
 =?us-ascii?Q?B7Lxmc5FRy3Cp2Od85ATfWh4AKTUBlqE1Iq9WuxNPdzJR27XFlDPakt9vnCc?=
 =?us-ascii?Q?uNo7ukQyjl2QmSJuk8UgJ1MN10GJLuJWCq75jpKM4d5uuoKvxhKjhv2ewzgt?=
 =?us-ascii?Q?3EDlG/JghOUZou3wP05JOM/X+4q9awZj/v/2qfPFAg5U8xHJ1oc0cBbln9yz?=
 =?us-ascii?Q?JE8ak7RuXbFhfogeIRfCOP4By3hvLb52PxvpAuL7/XvpO/GJ5hmRS8LdDJPV?=
 =?us-ascii?Q?GIIcWT9XyohyXTWPJgua1Ip/gZgxOIVv2yVpLC7me1PTjuEGnUtzEnOFWz9k?=
 =?us-ascii?Q?/OIuVMEee9PqTRarNhaKhpL+bbDEI3ZaTX+yUHWgufsI+j+BCrBuq1PWfYn0?=
 =?us-ascii?Q?JeDA4Aa/ojckeMELULsOL30AE0nyEuVF/ueNBoAC30fKwC4tyq2W72H2Yia1?=
 =?us-ascii?Q?iyO+Sqxf8ztPyA1DUHRw/nESG53Z8e0FbrMzj1MHJLQy1068SKqJqLasMzwU?=
 =?us-ascii?Q?BY/SFk+P2YiFHXiibXpUAZ7x8LOLjmCBGAbKkQ/tVVMLfHZ/r7+p8rnqKe02?=
 =?us-ascii?Q?EWAtZaAxnbNpNsjh0S55mVoIdV893I8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f2b450-b3eb-4833-4dac-08df15581ab9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:40:26.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ay1Go6j7w6h3HzNjM76TXlg8FgI51lZ1PKrEQ4ldcFHW223PMuAt3qMQhDew86GAzf1UgfAVrY9eLCioQwF8yFAQW09UdKhBl6RShsNuGiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9223
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 07:40:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24237



On 8/28/26 9:35 AM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>=20
>=20
> Am 25.08.2026 um 16:57 schrieb Jan Kiszka:
>> On 25.08.26 16:37, Quirin Gylstorff wrote:
>>> This ensures that the data cannot be accessed after a factory reset.
>>> To clear a device, attach `:clear` to the device string in the variable
>>> `INITRAMFS_FACTORY_RESET_DEVICES`, for example:
>>>
>>> ```
>>> INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var:clear=
"
>>> ```
>>
>> Why this extra control? Why not clear automatically when there is no
>> encryption or there is no TPM clearing?
>=20
> Second, that!
>=20
>>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../files/factory-reset-script.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 69 +++++++++++++++----
>>> =C2=A0 .../files/reset-env.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +
>>> =C2=A0 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 21 +++---
>>> =C2=A0 3 files changed, 69 insertions(+), 23 deletions(-)
>>> =C2=A0 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs=
-=20
>>> factory-reset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (73=
%)
>>>
>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/=20
>>> factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-=20
>>> reset-hook/files/factory-reset-script.tmpl
>>> index 94b5f8b0..8f95d780 100644
>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-=20
>>> reset-script.tmpl
>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-=20
>>> reset-script.tmpl
>>> @@ -2,7 +2,7 @@
>>> =C2=A0 #
>>> =C2=A0 # CIP Core, generic profile
>>> =C2=A0 #
>>> -# Copyright (c) Siemens AG, 2025
>>> +# Copyright (c) Siemens AG, 2025 - 2026
>>> =C2=A0 #
>>> =C2=A0 # Authors:
>>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> @@ -13,11 +13,27 @@
>>> =C2=A0 . /scripts/cip-initramfs-functions
>>> +# entries of INITRAMFS_FACTORY_RESET_DEVICES have the form
>>> +# <device>[:clear] - return the device part
>>> +target_device_of()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 echo "${1%%:*}"
>>> +}
>>> +
>>> +# return the option part of an INITRAMFS_FACTORY_RESET_DEVICES entry
>>> +target_option_of()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 case "$1" in
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *:*) echo "${1#*:}" ;;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *) echo "" ;;
>>> +=C2=A0=C2=A0=C2=A0 esac
>>> +}
>>> +
>>> =C2=A0 check_partitions()
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found=3D0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for partition in ${INITRAMFS_FACTORY_RES=
ET_DEVICES}; do
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if blkid | grep -q "$(basen=
ame $partition)"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if blkid | grep -q "$(basen=
ame "$(target_device_of=20
>>> "$partition")")"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 found=3D$((found + 1))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> @@ -30,23 +46,34 @@ check_partitions()
>>> =C2=A0 target_devices=3D"${INITRAMFS_FACTORY_RESET_DEVICES}"
>>> =C2=A0 wait_30sec_for_condition check_partitions
>>> -
>>
>> Keep this.
>>
>>> =C2=A0 if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-=20
>>> reset"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_begin_msg "Factory Reset"
>>> +=C2=A0=C2=A0=C2=A0 # service watchdog in the background during lengthy=
 re-encryption
>>> +=C2=A0=C2=A0=C2=A0 start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for target in ${target_devices}; do
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_begin_msg "Reset device=
: $target"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${t=
arget}")
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "$target" in
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_device=3D$(target_de=
vice_of "$target")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_option=3D$(target_op=
tion_of "$target")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "${target_option}" in
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ""|=
clear) ;;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Unknown option '${target_option}'=20
>>> for target '$target_device' - ignored"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target_option=3D""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ;;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_begin_msg "Reset device=
: $target_device"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${t=
arget_device}")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "$target_device" in
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *by-partlabel*)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D"$(basename "${target}" )"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D"$(basename "${target_device}" )"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D$(blkid --match-tag LABEL "$target" | awk -F=
=3D=20
>>> '{gsub(/"/,"");print $2}' )
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D$(blkid --match-tag LABEL "$target_device" |=
=20
>>> awk -F=3D '{gsub(/"/,"");print $2}' )
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -z "${label}" ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Could not fi=
nd any label=C2=A0 for=20
>>> target '$target'"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Could not fi=
nd any label for=20
>>> target '$target_device'"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$fs_type" =
=3D "luks" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # after this the data on the encrypted pa=
rtition
>>> @@ -56,23 +83,35 @@ if /usr/sbin/get-factory-reset.sh --delete | grep=20
>>> -q "factory-reset"; th
>=20
> tpm2_clear is omitted from the diff output here. But wasn't it more=20
> robust to put it at the very end (outside the target_devices loop)

That I would  solve outside of the patchset.

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # use a variable from the reset-env to se=
t it
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_type=3D"$INITRAMFS_FACTORY_RESET_LUKS_=
FORMAT_TYPE"
>=20
> Can we derive this from the actual device. Setup up a temp device-mapper=
=20
> to resolve the actual fs_type of the device. That way multiple different=
=20
> file systems for encrypted partitions are supported as well.

No we cannot as we need to open the device.

>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target=3D$(find /dev/mapper -iname "*$label")
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${target}")
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 echo "luks device detected use $target"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target_device=3D$(find /dev/mapper -iname "*$label")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${target_device}")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 echo "luks device detected use $target_device"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "${target_option}" =3D=
 "clear" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log=
_begin_msg "Clear device $target_device"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev=
ice_size=3D$(blockdev --getsz "${target_device}")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
! dd if=3D/dev/zero of=3D"${target_device}" bs=3D512 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count=3D"${device_size}" conv=
=3Dfsync; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Could not clear partition=20
>>> $target_device"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log=
_end_msg "Finished clearing device $target_device"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ${fs_type} =
in
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ext*)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mke2fs -L "${label}" -F -t ext4=20
>>> "${target_device}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mkfs.btrfs -L "${label}" --force "${target}"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mkfs.btrfs -L "${label}" --force=20
>>> "${target_device}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Unrecognized filesystem =
type=20
>>> ${fs_type} - could not format"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_end_msg "Reset device: =
$target"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_end_msg "Reset device: =
$target_device"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_end_msg "Factory Reset"
>>> =C2=A0 fi
>>> +stop_watchdog
>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/=20
>>> reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/=20
>>> files/reset-env.tmpl
>>> index 07e2376a..663b0af0 100644
>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-=20
>>> env.tmpl
>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-=20
>>> env.tmpl
>>> @@ -2,5 +2,7 @@
>>> =C2=A0 #
>>> =C2=A0 # SPDX-License-Identifier: MIT
>>> =C2=A0 #
>>> +WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
>>> +SETUP_TIMEOUT=3D"${INITRAMFS_SETUP_TIMEOUT}"
>>> =C2=A0 INITRAMFS_FACTORY_RESET_DEVICES=3D"${INITRAMFS_FACTORY_RESET_DEV=
ICES}"
>>>  =20
>>> INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE=3D"${INITRAMFS_FACTORY_RESET_L=
UKS_FORMAT_TYPE}"
>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/=20
>>> initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-=20
>>> factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
>>> similarity index 73%
>>> rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-=20
>>> factory-reset-hook_0.3.bb
>>> rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-=20
>>> factory-reset-hook_0.4.bb
>>> index 670725b7..c192c38c 100644
>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-=20
>>> factory-reset-hook_0.3.bb
>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-=20
>>> factory-reset-hook_0.4.bb
>>> @@ -1,7 +1,7 @@
>>> =C2=A0 #
>>> =C2=A0 # CIP Core, generic profile
>>> =C2=A0 #
>>> -# Copyright (c) Siemens AG, 2025
>>> +# Copyright (c) Siemens AG, 2025 - 2026
>>> =C2=A0 #
>>> =C2=A0 # Authors:
>>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> @@ -15,13 +15,15 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-=20
>>> project.org>"
>>> =C2=A0 DESCRIPTION =3D "Delete the content of the given Devices"
>>> =C2=A0 # list of partitions by label
>>> -INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var"
>>> +INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var:clea=
r"
>>> =C2=A0 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
>>> -INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
>>> -INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
>>> +INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D "0"
>>> +INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D "1"
>>> +INITRAMFS_SETUP_TIMEOUT ?=3D "600"
>=20
> Timeout of disc encryption vs. full disk wipe differ.
>=20
> Why not allow an individual factory reset override of the watchdog timeou=
t?

Why? The watchdog needs to be driven the whole initrd period. so one=20
timeout is enough.


>=20
> e.g.:
> ```
> INITRAMFS_SETUP_TIMEOUT ??=3D "600"
> INITRAMFS_FACTORY_RESET_TIMEOUT ?=3D "${INITRAMFS_SETUP_TIMEOUT}"
> ```
>=20
> Same applies to first patch wrt. `INITRAMFS_CRYPT_SETUP_TIMEOUT`
>

Quirin

>>> =C2=A0 # to support factory reset on btrfs, add 'btrfs'
>>> =C2=A0 INITRAMFS_FACTORY_RESET_FSTYPES =3D=20
>>> "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
>>> +INITRAMFS_WATCHDOG_DEVICE ??=3D "${@'/dev/watchdog' if=20
>>> int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
>>> =C2=A0 SRC_URI +=3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://factory-reset-script.tmpl \
>>> @@ -33,17 +35,20 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if=20
>>> bb.utils.to_boolean(d.getVar('IN
>>> =C2=A0 TEMPLATE_FILES +=3D "reset-env.tmpl factory-reset-script.tmpl"
>>> =C2=A0 TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_FACTORY_RESET=
_LUKS_FORMAT_TYPE \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_FACTORY_RESET_CLEAR_TPM"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_FACTORY_RESET_CLEAR_TPM \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_WATCHDOG_DEVICE \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_SETUP_TIMEOUT "
>>> =C2=A0 RDEPENDS =3D "factory-reset-helper \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 initramfs-cip-functions"
>>> =C2=A0 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, awk, \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 factory-reset-helper, finduti=
ls, initramfs-cip-=20
>>> functions"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 factory-reset-helper, finduti=
ls, initramfs-cip-=20
>>> functions, \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psmisc"
>>> =C2=A0 DEBIAN_DEPENDS:append:encrypt-partitions =3D ", tpm2-tools"
>>> -HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename \
>>> +HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename dd \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mke2fs awk blkid rm get=
-factory-reset.sh \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chattr grep find"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chattr grep find blockdev seq fuser=
"
>>
>> fuser: see patch 1.
>>
>>> =C2=A0 HOOK_COPY_EXECS:append:encrypt-partitions =3D " tpm2_clear"
>>> =C2=A0 OVERRIDES .=3D "${@':btrfs-support' if 'btrfs' in=20
>>> d.getVar('INITRAMFS_FACTORY_RESET_FSTYPES') else ''}"
>>
>> Jan
>>
>=20
> BR Alexander


