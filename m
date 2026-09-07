Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69FC79F9E
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 09:27:34 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31087.1788773247752313236
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Sep 2026 02:27:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yTuMFh1J;
 spf=pass (domain: siemens.com, ip: 52.101.66.33, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxK0q1+iGVeS0zFKz3F76ng642hAIyIfRR/GwLD0sOzDYhY3A0hD/hATcSD+ZML906E7u1TXlkzebZWJ/00OvTdsP2dsXkX9a4Ze18pUCHRn9r/M7MZi9gMZfPO4Gxd6P6C8VqH7FcgxMbFvVVM+5CyMIsN3VkEwr2q5J/AgVaIK0lbuoGPHJyqKBXg0xb86maFtYRsbkyMU5ajOFhDCxiEhts0t/Uypb9Nm9NWidftSY9bQbBNUaIHnRNXqeKojrDwXar5l57iwGn/1ZFDzn7yeJsiY4cdKIc8mH+K2tirDYYKbV1L3C77ZY8WZwGoFYFHpguNEjPVzpbKV1vhVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyNDekz9E1K28E1fBdZH9+THhi1+8HBsgSU+02ueoCU=;
 b=pe6Q1Mu1GOg55fTtKQ1wNgfep3T6yzMv2KZxPl3P744qtr0JfL6VLh+/Q4Gq6SpU/3N5/KIyujjtuJa0aEqgdpa9MeNXsStSFwBM/N4aazKKkGA9RJTIqz9m9epNkFKtnperT1Qamvk53ivlUjLrmS4hFrqKKuYp0Bk1L67m0m4U9yjMR6xms9RnQ+Ff83FcU0jAjR0NnPaQbzLEH7g7beFNUVqF9k/sixKGjdFgMaP8ZEXruX6HbfZ8oZVXEQ5yPcNiBXLnmkX0dmRvyGwuRUihFY3v+1J17gaSWl5CxbLh7duN3z+n13NN/k2vlMWsDpByNV4PmXf83fph8PxXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyNDekz9E1K28E1fBdZH9+THhi1+8HBsgSU+02ueoCU=;
 b=yTuMFh1JHUGgF3IHLO6zEX9byDVbkH+8Tv7iV/L0iIiTN9WvTTEYiW7+p0B0BgKb0T2K1IoBmbHGJP0QELBFlfIVH9bUcAUaTRcTrkwgviiclo2usTbN9J6PKMlQ2KHQ8qU4TLuw3EW52bRYCwmFV7XpCfzVIvHMBRW/A5OoSJDjz2DWn9X1aTxZPVTPzMIjwP5goQzJ03CdnRicLDB1tU5L77odGBYY+M3PyyJvmmmKK0yiErcL5g+mgqTbX5lhdy+D6XF35ebETsZIIWd4f+lW5PVo+0CYYgx/6D3rn/31qiS1W0luIQ9Fq4hp27VAXeiIBm6aOkXfNbhmG/NCsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by AS5PR10MB8272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:653::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:27:22 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 09:27:22 +0000
Message-ID: <26493107-913c-40ca-9078-2c2e01ea10b2@siemens.com>
Date: Mon, 7 Sep 2026 11:27:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/2] initramfs-factory-reset: Add
 option to clear partition before new fs
To: cip-dev@lists.cip-project.org
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
 <20260825143802.3764929-3-quirin.gylstorff@siemens.com>
 <65a1f330-1941-4d09-97ed-fc29421b35c2@siemens.com>
 <18CFE7E3E3E87BA5.3592100@lists.cip-project.org>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <18CFE7E3E3E87BA5.3592100@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0297.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::14) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|AS5PR10MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 654719ac-8af9-42bf-d1a0-08df0cc2387d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4022899009|11063799006|6133799003|56012099006|4143699003|3023799007|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	pcwkMSr27LAxYWkl+WfQT3dnFcTfTiZLX7GQAc2fQM8ug59sGNzFT4O/J2rfh4vopBZJH2i7GxodlR2Pp/5GQtQkmfw2uYCaukMK+CW1mktJd26D/xPhy6C/zgy/0kMKYLKt45gKo1p+SfXqmRIgG4ugpyTIDlY7BAeLcnfcwY0ZkuKYDv1W4aKOHYiwtWovLeuzDF3lYfn9bQwzgwRv5nMPjNdOVUkOAtVKfN0bb0baXOY/ysE7tBOnpcOCboQETMoNNX9z8e8r2ejr8JT3zHVT+l/TD/y9OuDYXOSxDORod+HFxoDJ1rvqdw6jwEw9FLXR0eDrYV4muKVnki4tjNPLDHk42WvW/NpFK2iyPfH0TItZXkShwWo3F/pW0f7ym9yHJxRs6faBLMQTsHBfwItbek2yh7KsPc/ZmX0z4RFpcrmg0xnpOwoJ8LV7cu27lyb91Jh1SyuZ1/E5r96GkDt/OTfpxlDi6s2CFAKs1pD6rwWu5MFW/fgjYORXON8RRAvWESxgivAKfI3uoO7bK2yvJJ853AsIL+6cdl16udDK1upsXU+ZNvV8kSxh+xexjkBlwndYrbijKBVtbZhIpClUaGFpI6T9eSTaWLyVxTw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4022899009)(11063799006)(6133799003)(56012099006)(4143699003)(3023799007)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KEge56FJOEoJjNv7Pzhi7Ws45IGJirbAdltlQHskhfvmdpFPRXCw07FaHeXU?=
 =?us-ascii?Q?oLswnFxpCVsMFMblF+2xuWFDwonHPiPhtAp0WLpQM5ss/vIz0CkAaIaLnHFE?=
 =?us-ascii?Q?aY2MlGFW0MbfRahp0tWxVFgrNsWSIdIuFICMswV8IIHqU09xn7SXlLejOMN7?=
 =?us-ascii?Q?XDHMmx9Zp74gMz8d/WBwl114n+TFU2dbDNUZHM9myBeQjHsEoO0RDM4zquDq?=
 =?us-ascii?Q?AmYNPEuTtmd5GoXJjZtT0YrRxC5rHBbg+dx2VlutkN6NLpzmNUU2VHyj00W7?=
 =?us-ascii?Q?4wF1VDzI+gtHAw/u0gPsZ92ly4KaLa+ll23G0i4W01rYWJlSEVU/lK445fUr?=
 =?us-ascii?Q?4iX6hSAjv/LmrdrEcr1XtHvsHNiSocmjTnTa53ocG7HJWdAeU7VS2+JmsWWP?=
 =?us-ascii?Q?i/HaWP2CP/295hia0d9j8W3mhs+SolKtw20lzBQoE4GAicmEtIL+oY1MZCk7?=
 =?us-ascii?Q?ZOcr9HzXh4pZasRmLLIEJxLOqJmoq5kuopor0dHkVwzNGqf/KeTZLJvWDgqr?=
 =?us-ascii?Q?jjS4+l7AaDXWJKTKH2IHkBnJra5uGxxL7uAwlX8GF+Z5vIoummMQhHvfbSQ8?=
 =?us-ascii?Q?NMQJDLd7S6a45pSG8z5ZLxkzlwCtHx+c1XEQhQ5A+4sprkxu3Ca2eWq29fGc?=
 =?us-ascii?Q?/0t3RttN1VUVHJZUJh/JJHivHCZTJcnEEe+9qL08UvGe6Jrh5EbTQEsN1pjL?=
 =?us-ascii?Q?PPgoojQys40tdha/XC6iQD4oYXAHbg5PG9P+eiZUvkLIp7ofYa1VGjLLbMQ+?=
 =?us-ascii?Q?yxK82KDPXLMuIXhRohX17wyMMMfo6QNu83jdULdtTpz6OQWlwedMCuIapXnP?=
 =?us-ascii?Q?gQTqOYT2LQ9YBDskJrl4jKa6YmzU94XaJ/A40BMBCMGeS486UC8dvGhFYsLO?=
 =?us-ascii?Q?MNVn132Qgj8BWvy+qvbDww4WgGZzY30cNfcMsnU9dIKp+qEiStr3UFb3Sj45?=
 =?us-ascii?Q?sGRe7mjwT3oYXk21DMstxZle9Jq3TJRpkKiMZ0WyaKzVryHQ2ikyroVflhdP?=
 =?us-ascii?Q?EARCYqleBkXqllzikGCVx95knAZZ6SBcOtdzWlIScitWmfekZpWcWBQDylLr?=
 =?us-ascii?Q?7a9uhUlzaWuosp8iPyRL86pjamBD4atFQSbnktFqcWNa22IEUCJJZHN/KUfo?=
 =?us-ascii?Q?Wu7sngftyjm/0aLyYtxfw3yB8JioV3NlFSsXH61gaLkG15WOdpS0DGgsXSqs?=
 =?us-ascii?Q?tipHThJifrIiQ5NQyuwORmJrQW5ya781kKpgFiag6pIAml9Vu5k1A12jAMpY?=
 =?us-ascii?Q?ggyObKx74rSY3sMP4i/ayFvS1VLt426tv9ZmouoSu5/9oP0RJXDvjVxLIwdx?=
 =?us-ascii?Q?qqoW0rOPxysw1D7KjnkYYiouyzkjlheibOnw8ToaDwGsAHnBPPDGJwFdoX5W?=
 =?us-ascii?Q?R7tB+x9mWNWUodsriivk6zQxyKKc4Rm+8OM4EnuEgJYpldgoeYNSOmhCwyKm?=
 =?us-ascii?Q?jvnpGTnDacwDJple1bIVNO4AyEgFpx6MZHdqSUBs1YP2DqVPCBCCbkBR91i8?=
 =?us-ascii?Q?XdaI2YWaaINKFFgIqmo7Q9D6ZdhHK99Xprky+x4TnmDc+e3XLJkDS7kBB6ve?=
 =?us-ascii?Q?YlvWOYD4DTsMUlufyUGqR0X+QLmt8bp2nAiZV6X70IFXdRpXiVUZhGg7HIf8?=
 =?us-ascii?Q?cH7UGTnfKeTVuka259vPSjclrytJ3cA0hMKUMPPmRJA7S6sKxjXXAFZ1H8Cw?=
 =?us-ascii?Q?iEN1TwboKeCGpyszX8F9KzQdJdqdRWCEtPO0qaaBxpr2W/HDSOOnPuswqYyM?=
 =?us-ascii?Q?AVAuqLayaoERzwvBIUCSBqvmFG8Q3lM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654719ac-8af9-42bf-d1a0-08df0cc2387d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:27:22.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ao3wwLpYaQzfPCfgEEuyuqLLa2GyaFq9CwMuUO8Z6dqQl62vmE2Msjl3F/fcTIt2/+drFwmUJLrJ/Zw2GjCJrzjRiE2biNjDB47XWREldtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8272
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Sep 2026 09:27:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24098



Am 28.08.2026 um 09:35 schrieb Heinisch, Alexander via=20
lists.cip-project.org:
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

This check does not work according to the documentation:

Specifically the documentation states:
"
The removal of the TPM keys can be deactivated by setting the variable=20
`INITRAMFS_FACTORY_RESET_CLEAR_TPM` to `0`.
"

But only empty INITRAMFS_FACTORY_RESET_CLEAR_TPM=3D"" will prevent tpm=20
clearing.

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # after this the data on the encrypted pa=
rtition
>>> @@ -56,23 +83,35 @@ if /usr/sbin/get-factory-reset.sh --delete | grep=20
>>> -q "factory-reset"; then
>=20
> tpm2_clear is omitted from the diff output here. But wasn't it more=20
> robust to put it at the very end (outside the target_devices loop)
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
>=20
> e.g.:
> ```
> INITRAMFS_SETUP_TIMEOUT ??=3D "600"
> INITRAMFS_FACTORY_RESET_TIMEOUT ?=3D "${INITRAMFS_SETUP_TIMEOUT}"
> ```
>=20
> Same applies to first patch wrt. `INITRAMFS_CRYPT_SETUP_TIMEOUT`
>=20
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
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24045): https://lists.cip-project.org/g/cip-dev/messa=
ge/24045
> Mute This Topic: https://lists.cip-project.org/mt/120921188/8886423
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [alexander.hei=
nisch@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


