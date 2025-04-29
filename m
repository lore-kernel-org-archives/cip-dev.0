Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E574C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 12:30:47 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.38])
 by mx.groups.io with SMTP id smtpd.web10.18572.1745929839804665060
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 05:30:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=0AXBsrNr;
 spf=pass (domain: siemens.com, ip: 52.101.69.38, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTMfDZddUuvaog2iyB0HDt7S7cRAkiZYjalg9FGKIWUjpafQiyWOw7AV5RVx12936e2Xuu6iUbZvOFRI2//MMfmOZq1dIbhRxTHw8xdo243wTOjEDpD2xmkmKN6p1Ui4gsSYOpatZQr8u50ZiiavLm6zoe55Ppzl+tBZstoTbs7Cmps+2yjY2OQdEesojRK6SOVp5MdVspHrXjmLAq6EImEZpuUtNbEwU/j9amjta66VATI9eoRSuFk+LZfHMgadHa0XGtMuJlBmSOzD1IhyVk35hfY5nT8iM5adVOwSzmiwOsTkmbbRNJe3ge3yRNVXuZFOxdMQ3xS3gjHnwTvi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssBbWuB4hUHallLvyxFvI+tqG37I0eL0vi6G53kNYjw=;
 b=GvrhTG5qqyC/nGccIi8/j08AD1Dd8ByqrUEMrEqmV7wgvJR3lCILcjHofgP/fW8o2frdV7uHnVNmIKcX1kw/+yAFoNC010c+Biu8H7dBdPC1uNdKxtbEqTl0ZyUYlqEBEkrhdQ3a3dcVp9g4KA9VIcEOeud8o4IIVgRJNMxMjUyfSL5muRHHnLlPZNZbFCiilQXmUy5XJQuh2gCb3ClYjk5A77xBdkiyHyml9C8whNsX7dr5XqQZD7H/67Cqbgx6IhAeJmRF8yNCB+D9bh2XWRcw0Ttw7oC5pBsm1t9IylSbIYJfqfsImeH6NTiuDFRZE3XB4av8Dshb+99NsHk9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssBbWuB4hUHallLvyxFvI+tqG37I0eL0vi6G53kNYjw=;
 b=0AXBsrNrhQz+KDN/uAeNOzDOe6nZKFFbTSsLCVUwQKIu9SduCEoyWqzpqzGzwYq4wLH+0e1PKupmViD743H4KP3hdcYQW1T/1NEV5HP7eNivQirZw8IdL5uky+OtZLhSJevx7yzQp7IyojQ4SnsCK+f2Z4TX3Ggl3bJ8MFCRXbSkCsN6x/ZfowfBFFV1bBZiRQ+XP/LeL8bR+aelox9R9FIfN1TYHIrFAuR3w1gaEPEBbbgpo4AfuYpa1ThKHfA4S6BW/Czg0oslL+p06WfZuyKuAlUYBXWKqK/DCf1Evf21crqe4Y019AVCOhNZwV1qjDIzT2aB++eHuIJBMxHZKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PR3PR10MB4143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 12:30:36 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 12:30:36 +0000
Message-ID: <5c1f69a4-cb66-4c33-9ba9-57cb5d200a6b@siemens.com>
Date: Tue, 29 Apr 2025 14:30:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] initramfs: add hook for data-reset
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
 <20250424092302.2066773-2-Quirin.Gylstorff@siemens.com>
 <79b2bf60-e5f3-42b6-9542-e91ba0bed677@siemens.com>
 <d8e87b5b-0869-4805-b087-f7bdcbc9185e@siemens.com>
 <3d45d258-6aba-415a-b894-dae3594844ff@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <3d45d258-6aba-415a-b894-dae3594844ff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PR3PR10MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ab60ee-a99b-4b5e-3055-08dd8719a46d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0bxtSLbhf2QOhD85gCMnUCcAymFRW0DyY06m4iBxUJm1XQz0hXN8HMo5o9tT?=
 =?us-ascii?Q?wkapPxuLeseT+oRhXIWPF/hz5ZTy0OyOJDuEdunb276k4CVB3afOXTdSEnTk?=
 =?us-ascii?Q?sw6yv5gPn6xE7ZJ7CYGSowtRq+2bkWCHJAQeoEhI0CAFwA17t1u/Oxpe6J6V?=
 =?us-ascii?Q?DnzTfm6CEbTt77eD0a/1Yc0ugnUAqC9w74YoQ67nDJ+vqZwkUWHNelZf4Mgp?=
 =?us-ascii?Q?zj3daXQdES0PremsttYJjHzEzVUX6YADxGf399UmxSMLqUTv3vtvXvKpziCe?=
 =?us-ascii?Q?k9Wwtt7fvwTLRz/CLEo1jzxlOsnlLaCh167A8fQUR7nR/kHFze6nUKhfdt7o?=
 =?us-ascii?Q?d3r3lwXbAt3XnBxkJnFTsxVmNXMssuVxL+8w8vceEvDV4Z+kkg9evAAyNjfs?=
 =?us-ascii?Q?3dzzbI1dzSn9GgtgUkBYk8kH0YIZt68o2wENxlcEiH1t6MzAE2IDEjqtqEJV?=
 =?us-ascii?Q?hPmTcgCH2A7qTV5hW8paClnIO9iYuYOgS7gjkqa+DTlTlQTb4D4xb8i7k8k9?=
 =?us-ascii?Q?d075eSHvA7w6NYyyYOwvhL5OwuEAJPGh/vUCxaozc0qISPhjna6kwGMrjSqv?=
 =?us-ascii?Q?o+KDR86Y0JO84A0RB0Ug6CJeVvmv5hAxzvfnbUnitaQCLXIVNyjZeqFD81Va?=
 =?us-ascii?Q?WLSY6APAtg/Sef0bE2h0gvso8zRfKgTI0CAGnLQZ35Q76dnk/C5RRHxf71iV?=
 =?us-ascii?Q?F8aKTP2ppjOzBQ5eL1HBOy0q6csUWWMswkJklVfTndX8xTqOewW5OFd43nOC?=
 =?us-ascii?Q?jvPwVuCJgzxpj81V9r0HrQYAsoYeLvkkFsHnM7CC6123l6dq9SFhH0u3cpk+?=
 =?us-ascii?Q?SLUtrDMueLbSxuarYX2M7GSDVx3n2zInpbU6vfK+0E1LnJA1Jqprqd46oSEs?=
 =?us-ascii?Q?Mx7I0f6HhEbqkay+DFdaBZPjCqUqFf4ysiseHrufP/p/9R9vpKO/NxyAe5h8?=
 =?us-ascii?Q?9KOkLN+hKhKngxvIPAJLrB6KTBa45bbluOnVv7rarHfQnEuoSA0eK1UO32yB?=
 =?us-ascii?Q?uaUhz1SAr97ACkHaFoQ1bQeq6mClwH0s+muceOJePBSFFjYqYWTKWMJete8k?=
 =?us-ascii?Q?t0oxRA1UIKWiOWKpvZwubbgoTaVIFmiyvxVcmQ+85k72IGn6cHQXNcqhBvfz?=
 =?us-ascii?Q?TmR3mDai73CCveP6dinZBfPFn4RQan/9Bh6TReS2p7X+6NXMo/Hg2/h1E6Mg?=
 =?us-ascii?Q?bcnUOGqMyll6QjK/Lmqv4/JEmxv33S6pTYUdmo5hyDCIpGfQwCMFsWad3ubG?=
 =?us-ascii?Q?0HTrqxHbZt5AjggTI5TMfuC/EOd91xlyKaIzNxRRse+nFkXUGH7v/xNsbaGh?=
 =?us-ascii?Q?IJDtyE/jcGZSHgtqxlvnMOS0jO+v5ScTCpYZVdfibH01A5jtPjorOqMaOqag?=
 =?us-ascii?Q?cZYIG1NgWTvZxvTf+z8NaiKN9nh/GPVFcmzPRkcyafMH088q7b84htGvI8Bv?=
 =?us-ascii?Q?rC/qClh0WW8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wLs7eOU5BSryN9QFNLESw/uwPjmJaRxIqldaFaX6nt2z+RjaRRoUOCh1KD7X?=
 =?us-ascii?Q?BYrnJcX1ouid1jCE98PbXqzrk7hm2/83NDH7II+w5GqTz7rGrCuTfm62wMKg?=
 =?us-ascii?Q?eA0f3WqnNR5/Vl31rH0rC1MphxxxG0iLgCPuLJ5Hwa3by7vivL3AnRCCIBPn?=
 =?us-ascii?Q?JNt9BWKbDkINwr1b4HIqz5Gb/rIEEnqFU9FJ40Q2I/fgKrqEQNKrl4p3xm4Z?=
 =?us-ascii?Q?2X/KrPO6k8CknLn1v8hiyNZD0Vfl2x/DWTwLEwedDh4If7e9b4TMOafVtL6B?=
 =?us-ascii?Q?kRuMWfJn+NPj047A0TjbcQWDjDtBAVB9TilPx/EYV5nlnNLVRCY9kH1f6tLc?=
 =?us-ascii?Q?9w9rRtUQRw01eR6GtgFEZZvR3QjI1Q49AJEH1A+HAhHnwA3kfT7pampwyKh3?=
 =?us-ascii?Q?pGqfKGZ/nOQGkGf0tWnpgn9wRCtOivNq9RxinqezZFSN/deMudk4c1/0eoid?=
 =?us-ascii?Q?QrdndOQ7kYtP/dK1eC19P6ITXtoBWtYtbLImGgM/JNkIiCb9l1eBsqz9QkHl?=
 =?us-ascii?Q?V8v32Fm2Ew7n8TO9y+2rlVUpucEXEfd4xQKZS0QSpm1T+L1BspFvcC295+DI?=
 =?us-ascii?Q?U+vrk0XmUKw1B81lhexfrMTzRCY8igZlYKSlNiHnHCa/0f5CYo05s5UxXM1K?=
 =?us-ascii?Q?ojgXmw9QvQwdWhDA6yYlWBUDq1em4NvkaK42BbmAEo6k8MVOZddwYSAdrOBP?=
 =?us-ascii?Q?jxp4SRdkMEXCDsoFphbPqfcswvGzbZ9e2MPpoV8YEBd81xlvrx/KebRLeYrw?=
 =?us-ascii?Q?den1utIa0nwHmrYVVQi6yl3ZvtrkJfn3/ISjDHVlTWBRMU5NC6HGO6HRVNRA?=
 =?us-ascii?Q?v6dJYbi61GQHL/nGqARIYKYtVSxvApv1RQU6/6OeDhqxRylFADuBbHRlyTGx?=
 =?us-ascii?Q?hpCvgFgZiyZL3MyLFlVQiyiGDRcU74ezpu8gf062RbHME954jHuQibHlhQEx?=
 =?us-ascii?Q?aocJO+7xTdm9s/Igsxr9wszdDZPQvuaVk257Ri/xCnX++xV3jpcg9Azo1CWc?=
 =?us-ascii?Q?t0xrpdIh5I4MuzWPwwxVViVN+kqxPAPtVkqeRw8KPjeFuQGrRiHErzuFAj2d?=
 =?us-ascii?Q?9KLy4JgZ/nHFyQJpoJloADkJfnJPEtG/IO1WxXihvCfQfJCKemgrNZphHf/A?=
 =?us-ascii?Q?OL4l2F5evhkxQPPqlQxofhWaKSvOa2IwGT0nmJZi0PLnoIGIFQVGvv3fQSLO?=
 =?us-ascii?Q?xouK97VXYhNBF0yttgqrglZhnyRYLFNQo/NanEoYZglroIJJ3pDmIkZBcxYS?=
 =?us-ascii?Q?CuUsjSq9fnYIh1GZwVdgd6DsHXABGvMpPbb7+jjBTG5Is5OV3RSdZMCVaurk?=
 =?us-ascii?Q?/WWyponLOGktJT6tbb9h2XPo31tzCWyJUmydzVc2wkAAuXsf9nDZkOTbYWWu?=
 =?us-ascii?Q?pCOJ5YVv3S5y6ekMYGimtAsPvDdgDvBPGaDWvoykOFYWvt0HRadt3gZ3LjQj?=
 =?us-ascii?Q?2VGNOno4wDYfY7UCSZzK3DGFmTcx1OYy2LS0SxrGN1uf95n5PWp593hVGAeC?=
 =?us-ascii?Q?2z5tjoH388IwIJ2Eecvkom74RWQZAEKC3JnzswYlY44ElTmxlnoZB1pMctiP?=
 =?us-ascii?Q?tkEzvKLD2DMK2YFk777Py0vPI5CYp/zJ+GKosUEg4cJpPf1s0WxPh4/aktPF?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ab60ee-a99b-4b5e-3055-08dd8719a46d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 12:30:36.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/5pztH+mYFIJYNIrNa8EgNAsenERGP2xfAbF+UuO7c2+t7UMtiSgft8I7hCHhxFkBFbahRqbKJvXkDTNQasGluJBwfu2py/zB2FAQfA9cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4143
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 12:30:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18712



On 4/28/25 11:03, Jan Kiszka wrote:
> On 28.04.25 10:23, Quirin Gylstorff wrote:
>>
>>
>> On 4/28/25 08:35, Jan Kiszka wrote:
>>> On 24.04.25 11:22, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This allows to reset the device data by deleting
>>>> all files in the persistent partitions.
>>>>
>>>> The reset occurs if a file defined by the variable
>>>> INITRAMFS_DATA_RESET_MARKER
>>>> exists in the device INITRAMFS_DATA_RESET_MARKER_DEVICE.
>>>>
>>>> This feature allows to add device specific trigger to restore
>>>> the persistent file system to the first-boot state.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>  =C2=A0 .../files/local-bottom-complete.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 76 +++++++++++++++++++
>>>>  =C2=A0 .../initramfs-data-reset-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++
>>>>  =C2=A0 2 files changed, 112 insertions(+)
>>>>  =C2=A0 create mode 100644 recipes-initramfs/initramfs-factory-reset-h=
ook/
>>>> files/local-bottom-complete.tmpl
>>>>  =C2=A0 create mode 100644 recipes-initramfs/initramfs-factory-reset-h=
ook/
>>>> initramfs-data-reset-hook_0.1.bb
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/
>>>> local-bottom-complete.tmpl b/recipes-initramfs/initramfs-factory-
>>>> reset-hook/files/local-bottom-complete.tmpl
>>>> new file mode 100644
>>>> index 0000000..f02f95c
>>>> --- /dev/null
>>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-
>>>> bottom-complete.tmpl
>>>> @@ -0,0 +1,76 @@
>>>> +#!/bin/sh
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2025
>>>> +#
>>>> +# Authors:
>>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +#
>>>> +prereqs()
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 # Make sure that this script is run last in local-=
top
>>>
>>> But it is called "local-bottom-complete"...
>>>
>>>> +=C2=A0=C2=A0=C2=A0 # but before overlay
>>>> +=C2=A0=C2=A0=C2=A0 local req
>>>> +=C2=A0=C2=A0=C2=A0 for req in "${0%/*}"/*; do
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script=3D"${req##*/}"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$script" !=3D "${0##=
*/}" ] &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ =
"$script" !=3D "overlay" ] ; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf '%s\n' "$script"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>
>>> Will create undefined dependencies between this and the crypt hook.
>>> Please sort that out.
>>
>> I will move this before the crypt hook for now.
>=20
> Don't you need crypt to run first to unlock the data partition?
This hook runs in local-bottom, unlock runs in local-top. So the=20
partitions are already unlocked as the trigger is stored in the `/var/`=20
partition. If we move the trigger file to a boot partition or the efi=20
partition we could to the factory reset also for encrypted partition
and then move it to local-top.

Quirin
>=20
>>  =C2=A0>> +=C2=A0=C2=A0=C2=A0 done
>>>> +}
>>>> +case $1 in
>>>> +prereqs)
>>>> +=C2=A0=C2=A0=C2=A0 prereqs
>>>> +=C2=A0=C2=A0=C2=A0 exit 0
>>>> +=C2=A0=C2=A0=C2=A0 ;;
>>>> +esac
>>>> +
>>>> +. /scripts/functions
>>>> +
>>>> +marker=3D"${INITRAMFS_DATA_RESET_MARKER}"
>>>> +marker_storage_device=3D"${INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE=
}"
>>>> +target_devices=3D"${INITRAMFS_DATA_RESET_DEVICES}"
>>>> +
>>>> +storage_mnt=3D"$(findmnt "${marker_storage_device}")"
>>>> +factory_reset=3Dfalse
>>>
>>> I thought you didn't want to call it "factory reset"?
>> As the hook does not to a complete factory reset ( the disk encryption
>> stays) I used data reset for now. If we add formatting a throw a way
>>  =C2=A0the disk keys I can rename it.
>>
>>
>>>
>>>> +tmp_mount=3D$(mktemp -d)
>>>> +# check for marker
>>>> +if [ -z "${storage_mnt}" ]; then
>>>> +=C2=A0=C2=A0=C2=A0 if ! mount -t "$(get_fstype "${marker_storage_devi=
ce}")" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${marker_storage_de=
vice}" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${tmp_mount}"; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Can't mount ${marke=
r_storage_device}!"
>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>> +=C2=A0=C2=A0=C2=A0 storage_mnt=3D"$tmp_mount"
>>>> +fi
>>>> +if [ -e "${storage_mnt}${marker}" ]; then
>>>> +=C2=A0=C2=A0=C2=A0 factory_reset=3Dtrue
>>>> +fi
>>>> +if mountpoint -q "$tmp_mount"; then
>>>> +=C2=A0=C2=A0=C2=A0 umount "$tmp_mount"
>>>> +fi
>>>> +if [ "${factory_reset}" =3D "true" ]; then
>>>> +=C2=A0=C2=A0=C2=A0 log_begin_msg "Factory Reset"
>>>> +=C2=A0=C2=A0=C2=A0 for target in ${target_devices}; do
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_mnt=3D"$(findmnt "$=
{target}")"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -z "$target_mnt" ]; t=
hen
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 ! mount -t "$(get_fstype "${target}")" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${marker_storage_device}" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${tmp_mount}"; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 panic "Can't mount ${target}!"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ta=
rget_mnt=3D"$tmp_mount"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # delete all files in the =
target mount point
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find "${target_mnt}" ! -wh=
olename "${target_mnt}" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ! =
-name "lost+found" -exec rm -rf {} +
>>>
>>> rm --one-file-system
>>>
>>> But wouldn't reformatting be simpler?
>>>
>> That is the question - My first thought was reformatting but then we
>> lose the information from snapshot based file systems (e.g. btrfs).
>>
>=20
> Which information? Aren't snapshot considered data here as well - which
> we want to reset?
>=20
> For a future solution that uses a/b btrfs plus some factory reset
> snapshot state, this logic here will surely need adjustments. Or we
> won't use the hook but rather embed related logic into some a/b data
> partition hook.

Currently I would like to have the factory-reset related logic in one place=
.

Quirin

>=20
> Jan
>=20


