Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B37EC369D9
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 05:11:18 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.49])
 by mx.groups.io with SMTP id smtpd.web10.10010.1745989876009220156
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 22:11:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RVToktwg;
 spf=pass (domain: siemens.com, ip: 40.107.105.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj4HsuoIJ9PPHMMKCdmcSSgOjpaKpNLzKmVnrJV1xsz28Ynd4/ce5RMdY2FXKXeWlzHne4Slg5ALiN9h6xbwy2fPo3oMyfm6YlCYcTQXVf24d5kppYXVK92iNbO0grR7oAUpfJREFlMHS2nXwa0BbUj3y+/U+pMiUByFG3BcKxT7MkJ4iwv8nwoZHxxOG6JGUAhl3WjiBDdAyHoeUcBUxlPdt0Iq6f6D4boO7qpxeuSZUqzEgUVgvXGVIjMax2wweKnY4lz8bdcMJBjveZG9fymHZB+/qV8ukRe0OIyxjokCh3Bt+iuvH7KlFxgL/0eJTQAdHCgbX1acxcNELIEnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzQQ7TYxIbS0OSmB02ubczOOBcpEpITjITpn4iitd78=;
 b=vnUCCVNiYREhGSebOhq5hZCjLVxS5CN1j7I8dHQibUWoUu10O8XRb3mRqqz8hXWXff0AseqX8cimG0Z8dDOq+UKYop9JsiHCelL7145+Hw4ZQXtGkBHdgjCU4H4h0Vk9DXVBSH4SgQXlbG0PiCLyK7WfAi18FRbZ/yFJ4i8Nd5CgmOSYYHuwrcKNLCROuNjMOjBgahTWmYAvBciStJIQGKTMUwVZahrHeXmMhbjM3KYR3H/wF9hr7On2fqBFZ+a09FWRSDhqCQ3QuH+FSewj6whghohCYDT8UPb9N4oQqmig6Y6oxvwSfH4eu/w/WRbGQq7AnibeRrvbM5BS5rx9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzQQ7TYxIbS0OSmB02ubczOOBcpEpITjITpn4iitd78=;
 b=RVToktwgjQ909/zX6b2OBilU29wnTOht6J6ZT5n9WhbIIxqhEZDYzIgatXLzQHoGGDgiSYAbXqSWvhYDV6u7+a73T+n3CljoFPeVU+2mR5jirEQYXlKz27Pxn0H9xs6qumahIFj1ZH/v6ik/jc6vLpIg0r8Tbn9YQJktzl2ukvqoUrGwVFlE1R8lCMGzOZZ3wF2KmijycoCC+vlf0PuUkyGZw78BYzLGccQfz3ryZo0W6SuOoro/SvBJAZpF7KhbXu14c2aVweHJvCgdrspCfs7DNzmqJwLONICjapzZ96BSROb6sqj6wGFm/5qUDCCqViBWpTlDFYGjOmHGPiidqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 05:11:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 05:11:12 +0000
Message-ID: <85f2d38b-dabc-4074-a171-13584fb91581@siemens.com>
Date: Wed, 30 Apr 2025 07:11:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] initramfs: add hook for data-reset
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
 <20250424092302.2066773-2-Quirin.Gylstorff@siemens.com>
 <79b2bf60-e5f3-42b6-9542-e91ba0bed677@siemens.com>
 <d8e87b5b-0869-4805-b087-f7bdcbc9185e@siemens.com>
 <3d45d258-6aba-415a-b894-dae3594844ff@siemens.com>
 <5c1f69a4-cb66-4c33-9ba9-57cb5d200a6b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5c1f69a4-cb66-4c33-9ba9-57cb5d200a6b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d12072-bc8b-4c2c-adac-08dd87a56cdd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MQMSj4yC5+x3Tvw2yat3a+aCsWhiC6kxmsrmajVWte90JgPUqtesOyNBBcoL?=
 =?us-ascii?Q?rF1PB42fiuUdewEsiC0grqV+wqygRtOWLRC1k+mVdJHewZCnarK55DBplV5s?=
 =?us-ascii?Q?BPxKsmOHJUdX2TodpurkEVE1SV0kyxdLDYpHDZKwgqojDgXFknbWPKN4FJUc?=
 =?us-ascii?Q?8yMorQ2BAJHn1ZR+XhQCc3kyX9aywmoeaWwrpdabMgGobTNzQb8iGuN4pSE9?=
 =?us-ascii?Q?cU277SS8cOSgZ4Q/oAKwOppETKgOsGr7c6NbAIxWgsdJYt1rFx+ey+79GX6C?=
 =?us-ascii?Q?oDIYps4p16jHSKHkZ+V2aBrGz07tNT+3uDmQjh2DB7FtwPP17734DJ0lO0Md?=
 =?us-ascii?Q?ARE3O4Rqy0lN9L9et5ImnidpGtr4KcKMTiccXbgntxov2jqdiayp7PrIYyMi?=
 =?us-ascii?Q?9LyzRGgmhwSDXE63J9wt7kvEFlN0r3Ils4COxaYgJFZgtnxRQlz38CoxWpfG?=
 =?us-ascii?Q?aBcAra8K0YG3qqcsqkvw/wwxAdST30RjzaQPoXLwWvNqkMVKwiSCkf1kbEMS?=
 =?us-ascii?Q?GcPlwAXQcOTm7FJL7F9B29jnGNCvmsFwH9+13OhcydCVaAbq07Uvufbfg0ko?=
 =?us-ascii?Q?klx8XV4Z0qYxbtEEvFSVSv85x0jfvQxF/WNKWrTapANongUobIqE6XgIyN49?=
 =?us-ascii?Q?kOiAAeTym9nFIpsVTg9cjDDhbrrYEqooj302PkmEqdZNEykLiyN9Iqs+LncL?=
 =?us-ascii?Q?ZvYNT3ngN9T2M1l5ZsMy5b5AGEICO8XiGRPqUW2LcaTWokLTZpWKB5nZpUXi?=
 =?us-ascii?Q?lyP+ILN5fteriYHRhU27sYUDXM7e6uzdMLnZWQo8C7MASrXhnGvx09ItX+VG?=
 =?us-ascii?Q?u4Lx9f4ru7S7OFjbWc6DeB0XU7Qy2zGPZUGIBXy84RFTEOusYMHbIGIyZ5gL?=
 =?us-ascii?Q?KzJht3V+602Tsa/U2Fw95o8/YoA2DHa92dXPqFlt6Nsy6Y8oNSooeb4iJ3hh?=
 =?us-ascii?Q?p9AwaRyWVhwVP+1AJqd3nTXr+PAeTCrcGj6UXDGZs8bgLSixurPHCSKtucBs?=
 =?us-ascii?Q?sDfnyuexpVLUhqQiGu5nSOdQF9sbebp5T66N8rvoqyQ9GUKUjFYkv4fsslXv?=
 =?us-ascii?Q?Agv7mu/4B0OjUdtqm2oBkDRWE/PGQGiGTSEjEs+HSJAMuJN5nhf3eHO0t/LV?=
 =?us-ascii?Q?4QH+PJJDxMsaunQ1SAM2QPmiSt+GUn5JSlflBQ/bPxMyQd62SNYd1mcZ8mi8?=
 =?us-ascii?Q?h2d1gJovHIGQCVqLPR6LyG5DF2JQDH26CUuvI5al8aokWHmfeAKJ3Y+S1mQl?=
 =?us-ascii?Q?Xg60IgX09lHz/KHeB7dIpwz16mJOVU9LxVs4igWO3GGvYgG/iQw0wtbPu5Cq?=
 =?us-ascii?Q?rKAo2u+8dIXWBTBgVwc3Vs8rg+PZJ/tfLhn8ZqTpyIgJB2mr1Vl4CqI3ujyq?=
 =?us-ascii?Q?i/mSjKAmQGqf25w9VIys0CxYkz9D/jnZBauEHI7660ZDLzJVuxERF7ZMKlSc?=
 =?us-ascii?Q?tOy6lKa1vvU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hKvEFtfNjF6HrVxSZOvtwK4DJWNbQIzaK8CPT31PDfyBZVNq3jdLsfvTlTed?=
 =?us-ascii?Q?jaIYRGLJGYTGAc2UIaooYeAdBRDjZaCt5I2UvcGecrcnS4WxKmg+7cOUlOGp?=
 =?us-ascii?Q?VT2qB+wkkkqisvUMQ5XaPAvH4526yPKCBg9my6nnkYCIpSZmuTK58/v3jSV7?=
 =?us-ascii?Q?ZSuvbf4eiw5NFM/FqmY2qwCf5hgfhPkkJ3S52A4L/EuLkiz0uAVXY39oF6cg?=
 =?us-ascii?Q?kip8+58gxEu3rb1W76Vkepi+CbkslF6aBy32BSXf1Ux3KifzVcOqFLN4TMEz?=
 =?us-ascii?Q?VPs4IOCXVcxvLwNO0u1xY1KZLylhybWSbLfYWx609UwGo9cfQWCeA3SRUms0?=
 =?us-ascii?Q?4hcScYxInm/zgKLdx86Nv/ArSJkF2RKPzeISNgzUXqF4CyemwQK5yqLsAEjW?=
 =?us-ascii?Q?LJNGxylHGPNyRTlCWHPNUs1qLe/H7VP3aoBMwMYeriM+IQw0OWQvQBElDYd5?=
 =?us-ascii?Q?vnwYuwlmxddl9+/VfEgAiojGZSZ/BR9woX1HOLqxHmQvgrN1aXDYV0ck988H?=
 =?us-ascii?Q?DupXaO2YCMH1notfDdu7Tvl9Ij3aGSsbUha6yGwBKO9VR77BIXWWrkvmLBXA?=
 =?us-ascii?Q?HQ7t3hCAjBHtYyH0EskYaXmymCca87Z/x/CALCxZOL7O9MHfcfdCNlOQE3KP?=
 =?us-ascii?Q?4/vY7mC3QBXvjJw4GOuW7vriDsKsSnOmVoI/M3TGXiQLHjsXfxu5X/rgs4d+?=
 =?us-ascii?Q?NDqhzbqBzIcDxFOB3d01ucQoYe+oMCXTePolXhO6/c5TI+/zNmbGh59nnIcQ?=
 =?us-ascii?Q?JpZRvan4+ZEgrQF04zZPJ4nX4ogrB69wKwbECMcqIsf/bNlBbX4CcZZHvpsI?=
 =?us-ascii?Q?qFICCvrBAlib0QCo4x661WtCtBR/DwyDhCbr3i6pffXMbDBl5tGoFrA9bpgm?=
 =?us-ascii?Q?YT4/iE0CgsnhrORpWhCZwMTuC9fgfKm0vClzkaQ2kenvSj+h1REznLxnB8ft?=
 =?us-ascii?Q?W7yoOqMg0HDLyH0GvYAQl8YNe0P+dQ3sbHFhNxe6K4xWCFUxw7nqMW+dDkcY?=
 =?us-ascii?Q?nhUyNc38JMqKDs00Dvk31/jenP+0ACbVvnahtvIdOjWvSRgU8rtRcMaWdNwR?=
 =?us-ascii?Q?05/4tXMIcSyKBelDqVAahvzBSeM8DPA+FzZLmO6ZfKBQC+kkSuLLrLoU4pIX?=
 =?us-ascii?Q?U9gBZOLqYnEC5ezq1LrMjFdGCzh2twtTYi3QxfSMK+Vj91/EU2sF9C2uPvDI?=
 =?us-ascii?Q?qLTkffpVzOLNWzjv4dUpm2pBsNudvtYxt7VDTy4Z/3iU3vAiBrViywhcXMBo?=
 =?us-ascii?Q?LKYUJ7mUtMAaghfLZHOSJcd3WvU3b6cmIJbNL8YxnmeOnuKnlstYrypX2SwM?=
 =?us-ascii?Q?O/HJ8yf/ALpPJv+ikRHNwmlq956Ob0xuloIamipALqsY50Yn+Y0MEi7YcZf3?=
 =?us-ascii?Q?MreBb/y6JGrSQ4up07dn7xpdK+amAzyQ27vJA8NqHYRTfp9TQ6LSPjq00t9d?=
 =?us-ascii?Q?NoB43ov4q0ftGECmBFbgbBnAoW4X9k6X3YYvL1sejisJ8qurY/tjcA/hucYX?=
 =?us-ascii?Q?XtSqXVnRPD+6Wx5X/z8On/DLTgJm/5CUIkKco1Yd9sYffhra2OO3KxbVeExP?=
 =?us-ascii?Q?45YdbMxgQNavRqwJEQV/GkUYJipgufAL0eoldQ56?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d12072-bc8b-4c2c-adac-08dd87a56cdd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 05:11:12.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPdvP/J5rFNjnOEhV+OSvnEY9mypiJCDSL2Ep6Pz9Y5U0Y2xp9fEJY3nSMBwWdOSxWlHBcN92WbAmpVc7jAJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5249
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Apr 2025 05:11:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18740

On 29.04.25 14:30, Quirin Gylstorff wrote:
>=20
>=20
> On 4/28/25 11:03, Jan Kiszka wrote:
>> On 28.04.25 10:23, Quirin Gylstorff wrote:
>>>
>>>
>>> On 4/28/25 08:35, Jan Kiszka wrote:
>>>> On 24.04.25 11:22, Quirin Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> This allows to reset the device data by deleting
>>>>> all files in the persistent partitions.
>>>>>
>>>>> The reset occurs if a file defined by the variable
>>>>> INITRAMFS_DATA_RESET_MARKER
>>>>> exists in the device INITRAMFS_DATA_RESET_MARKER_DEVICE.
>>>>>
>>>>> This feature allows to add device specific trigger to restore
>>>>> the persistent file system to the first-boot state.
>>>>>
>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 .../files/local-bottom-complete.tmpl=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 76 +++++++++++++
>>>>> ++++++
>>>>> =C2=A0=C2=A0 .../initramfs-data-reset-hook_0.1.bb=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++
>>>>> =C2=A0=C2=A0 2 files changed, 112 insertions(+)
>>>>> =C2=A0=C2=A0 create mode 100644 recipes-initramfs/initramfs-factory-r=
eset-hook/
>>>>> files/local-bottom-complete.tmpl
>>>>> =C2=A0=C2=A0 create mode 100644 recipes-initramfs/initramfs-factory-r=
eset-hook/
>>>>> initramfs-data-reset-hook_0.1.bb
>>>>>
>>>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/
>>>>> local-bottom-complete.tmpl b/recipes-initramfs/initramfs-factory-
>>>>> reset-hook/files/local-bottom-complete.tmpl
>>>>> new file mode 100644
>>>>> index 0000000..f02f95c
>>>>> --- /dev/null
>>>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-
>>>>> bottom-complete.tmpl
>>>>> @@ -0,0 +1,76 @@
>>>>> +#!/bin/sh
>>>>> +#
>>>>> +# CIP Core, generic profile
>>>>> +#
>>>>> +# Copyright (c) Siemens AG, 2025
>>>>> +#
>>>>> +# Authors:
>>>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> +#
>>>>> +prereqs()
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 # Make sure that this script is run last in local=
-top
>>>>
>>>> But it is called "local-bottom-complete"...
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 # but before overlay
>>>>> +=C2=A0=C2=A0=C2=A0 local req
>>>>> +=C2=A0=C2=A0=C2=A0 for req in "${0%/*}"/*; do
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script=3D"${req##*/}"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$script" !=3D "${0#=
#*/}" ] &&
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=
 "$script" !=3D "overlay" ] ; then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintf '%s\n' "$script"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>>
>>>> Will create undefined dependencies between this and the crypt hook.
>>>> Please sort that out.
>>>
>>> I will move this before the crypt hook for now.
>>
>> Don't you need crypt to run first to unlock the data partition?
> This hook runs in local-bottom, unlock runs in local-top. So the
> partitions are already unlocked as the trigger is stored in the `/var/`
> partition. If we move the trigger file to a boot partition or the efi
> partition we could to the factory reset also for encrypted partition
> and then move it to local-top.

The crypt hook has both types of scripts. Unlocking indeed happens in
local-top, but you still need to sync its local-bottom with this one here.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

