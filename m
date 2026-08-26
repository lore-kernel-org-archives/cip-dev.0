Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32082C61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 08:44:21 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8013.1787733859177468461
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 01:44:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Hk8fudKn;
 spf=pass (domain: siemens.com, ip: 52.101.72.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWxSUrYUFyM1VJRI01v6bic1B17t/j7j3RtKguA72t6TdLkFk0py9sh2X6bw1F7+YYC6u2ZVlAJqT1P8FdODVf/Fqf5LHkMWCimOgfDHBpP6CxkRQTtiM+IJzTKMVSNqR0RHas3UUFZdmGJu/KZofyzoTjhqRD+0yfgQFZhY0CkdaaLve6AeGFbjelIuBc6ipkpPthwek3tMdHpb4aBF7aJNSRxW8fub3L6kVUX4LTcFzU2UYLrcW60LVT5UddGCmrFirGCG+HtsPGFc9e4jeWE06TMzLVAqoniFNt3CXPLxUXgILUs8dRghb6H9Xr5La901O2Uh+wk+0UB4nbSAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHNLm85a9VwW5+hTJMpkClm8b6SDSlQpfufKPghWV9o=;
 b=wjDLZFoP9RlrPMV6987ZdcR4mQFxS54vG2W8Qqvf0tPfRyDcoH53Ff/sxngiyKRCwJBteEry35ERPIyNhR6ZerYfeXdA2w/229UKBbtafzk5tK+G74Km71kUIHyAqM/U/HPleJcHDwgT+Hi07zoHbhFQgC04rDJX1fcDoydJxBHhho/Y4vIqXiU8UrWALDbJGo2B+jHWepYvwD+vBUBDytzEwRP4QeKxm4vJKxlKxz0upF1M3QuxXAzKx2nFxxfZdYFGaz8Pxrp4ZXH15rpIamW9a7Uaw4Czai9TQaw0pqh9+EQ+Nrv5amrYeo8HMxAKxVw0wZeByw8oz3TUY5iizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHNLm85a9VwW5+hTJMpkClm8b6SDSlQpfufKPghWV9o=;
 b=Hk8fudKnuQW5x13oXuPajr6VzmauU7MnwacwGpKm72WVmt7Q91Oj1fFA/4a6fVZ6Wgqk0HSnEfrje8K7LUkPQCjRgMqi46FSxAbHHME1HCoEF0P8Us3KqBM+sH2Qh8nO0dydU52YLpkyYSeW/AKe9L939vu2azscQLnnoA2VfA8EAT05dL69qFLydpBQ9/Fs+y8mkC7JFVmCwL/Zd73Ho30DIZIQxMr0oQy4kNvCcIpD8I2UR1bJwQvOb/9LiTjTDK0q98HxM2n3chcCAtydbBj656jJyxt37lR5qdzBH8lKcAqvBKx1k8SQ/CXlm+VAkzCePTAxIaUgULUQZdoYGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 08:44:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:44:15 +0000
Message-ID: <9d3170b3-4d7a-4bae-aa1f-a1cefe25f08a@siemens.com>
Date: Wed, 26 Aug 2026 10:44:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/7] secure-boot-efi-keys: Add recipe to
 create EFI keys
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <97dc63827a8f33a225a39b3884afd6e6933c048b.1787722904.git.jan.kiszka@siemens.com>
 <51c1c773-6416-498e-81e6-48294b6cf80a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <51c1c773-6416-498e-81e6-48294b6cf80a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e23873-6547-42a2-e98b-08df034e3568
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	jwXOmK1ZEICDQgFvmgOalIeqkvDlxZ9e1o5OF+6ra2HzfIMBpacJOwAbJHvHqJfhdsY52F1YbF94RM3NQwGeWQfkIlZSyl6ap6jeXN9UFJMWenrrLH3wEiDmBf/W5vJH2VahibJ88MF1ZFw9bNI6NyHERn+2VhcLjNY3uJ34oRT6LlK2ygFUxX6ZLTlMouNld+AG4RXHW3rgVGwhpYdYxj6Wcu3h79mTusrkYdP7nIgI1dLk0CD9AgjfFkMhOQffQdvle4I59L+5MwCouuG0kylTXxQvVBH+xMWiLZTApnVb0XCanHFJ3ahpCjA2Rt57mb9r7v/pdtVLYJ32NZziVL6Z0E5gXNqXSWIARoYQKpTteqVO1kRpGOe9KR4yolIJEaW5mOyP47jDF9nkhW2ceHxfhHya3MTN8EC9jXMCzEc+f5I+K5yarsJNOjF1hbpi4YlqxAmBWuFP4x7RgDVSY4VUPSMvjglT3kvPGgWkomdJ094nDDsLje8K7qIZ5sykVWDWZcXEFlYSGJwo1Ta7SM251CfhyJxl5qb6Iuc/fMTNDQEGmKTkGq8DDMX8YkLViohM8a5iJ2DhuEZVfvqkZdoRGghJ/Wh2AM27JbC7lJyI4LLotHdx8L1wQJBO8k/xcxbmC7C3HoVnB0nuMARpQj8lp7BhTUSeWDTLwfjHhK4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B5DOOANd/OULFjtHAw7U0FdP1GzpfOmdYe5SY+Paez+QQW7jdXZPXv3dhBNT?=
 =?us-ascii?Q?ge6ujq8GbquGJpARWYL9FlMJAVTieiXPh4NosvkV3Z7WMrJ+QAFqeMU14Qhf?=
 =?us-ascii?Q?+2CQODmIG2CCMaJxKiml+mQIQe+elcJZQfNgIgRt73K9fo1U3Z+MEceMkgM4?=
 =?us-ascii?Q?Lsp0JABwazlr6dOrHDs0REl1ZwpzuhtlRTKoWQs7OtprAWjZvjn2Kp1yOP1k?=
 =?us-ascii?Q?6M+iGAafbSwpj5ts/UV5oTbu9xno7xaotMLth8UQE+VGEMa7XHKyDqt/+blK?=
 =?us-ascii?Q?5lRR9udcam4yDEPqJrrX4d3pssYeIglTzg7xZSG/KOMZ8tT/M6V+eO5kXuDf?=
 =?us-ascii?Q?MVtgk0nzb1sI2lmb75fu2+NK6S3vxM/z/dmqz+/ygDjBYh77C2jMn4pfkyt5?=
 =?us-ascii?Q?G3vRqAE3VJEzQMa9XTb4VvUXyGUD6VKnZWK3ElhY/FONa+ZmnrvJ1dWfBr37?=
 =?us-ascii?Q?AkgstvUxcDa3usVpnEnJYB13Nf7l+r/AMODls2YDO0/42k+JoGvhOWj1f9lP?=
 =?us-ascii?Q?eViCjRsiwWNRY63zhP5GY+h5kkhsGGxjJr1s4RwKmL2KG1hMPEiZ3lrbo6YQ?=
 =?us-ascii?Q?nSwbcO5Hph7B6vIpylHNSlOZWaZaZW8wgQBV+JhRmH3lYoZCqlt27CibpVIg?=
 =?us-ascii?Q?MnipDA4ZFptpi2gaVgaWs/Apytu6Jv4BcxVJgCd2jg/8Jj/SomBCXkZJyACc?=
 =?us-ascii?Q?5jhryplRR6tNuAF64VyGcycj+cHn9Ok1sWsOdnJSGSxjs8G4vxgpdbJlogCH?=
 =?us-ascii?Q?enD8bfpzXFapIu60slfA9UdiSHhtRXYahTlS7zQ+lsUa90EFAtWtwymEOnxU?=
 =?us-ascii?Q?COnYQZq26FXcGRrDJC1g+JZsFlQ34qu8CxXrZdSoC5VQWjI1mWsU5njM7Bnh?=
 =?us-ascii?Q?/FL+7kEBlK8t/Xa2ynuFMKB46CPR5G9yenCji71LXdlmMdhM3oA1gCNHOref?=
 =?us-ascii?Q?HU24gByM0HXcUFgdOsRDvfFRTEdW0mkKgGrjYvu8dBddO7BnKIhVyPLeNg8F?=
 =?us-ascii?Q?RoVVFGMM23g/FthW5JK4mqTcwQqcgSRkpgg2upW24guCZCIY7LKpT4ELmWAT?=
 =?us-ascii?Q?IVhw/Wn5ZV1bV92acklo10je3ukIUXhREio1/Ziq4pFwTfQk9NoiwSRfl1aU?=
 =?us-ascii?Q?hI+TZjtmtuLrGZ1uJsG+pEz/EeXMTgosLZLiotW0yKl3REvSy7sdG0TAqsGI?=
 =?us-ascii?Q?NQXVXFBJ0/CpbpkMMQZykyZlG5l031aYypt4wpu/0kqX3+lfIFiGo7X26UfG?=
 =?us-ascii?Q?0WgtTMY1cXKN1QTfM/fk95upSjwhEJ80+vbfr9I2myMHKKFpD72J4G5UTJkD?=
 =?us-ascii?Q?tK76bR/SYUveLEE4QynGQ2IbNNcdhhqpF6Y+6fTdKZwYXF5cueGi46zf7iJD?=
 =?us-ascii?Q?HLO25fel9QfvM7/XmwACAKEW6CueDCBAarZn9spIWwW+HF438KwKSB5hMokz?=
 =?us-ascii?Q?KkpaqTSxRedrcFR6sHOM1KFKAoOG8NO/mPxpnZdkFzae9kPptDNv83rQ8ljy?=
 =?us-ascii?Q?RTNAc4gT/coa/4NIFRQn5Z87WJUsb4ZItbHggFPJ3z2+IbqGKlzHK191LF9b?=
 =?us-ascii?Q?ZYI7fenmhskuuwKAeeCiAIPcDpm9n5KrUAl1CVoT2gDbUy23sjQt4z78Nk9v?=
 =?us-ascii?Q?4Lsb7ieuAVK8stjWNze34qUg4T9eWpeB6Dksw9DYyaF7r/doRh6pln48SJ9B?=
 =?us-ascii?Q?cNmqCshoDUucl7F1SQwOPIg+G3EeTKv84pYkq05+PFRR09dzV83u6+EcNR+v?=
 =?us-ascii?Q?reKhVKBrCw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e23873-6547-42a2-e98b-08df034e3568
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:44:14.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMZDyzomQvRlMqfgfI570Orv18TDwwK335Rvpsa0XL6G/Hst7nQNwkssb2zCAushWYnbE7zz0zqm/4VnB/6TWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7252
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 08:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24019

On 26.08.26 10:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>=20
>=20
> Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This recipe allows to derive the PK, KEK and db values from a single
>> signing key as we are using for demonstration/testing purposes and
>> simple scenarios. The recipe provides abstract "secure-boot-efi-keys"
>> which could also be offered by an alternative recipe/package that picks
>> up differently generated keys and/or a proper key hierarchy.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 .../single-key-to-efi-keys_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++++++++++++++++++
>> =C2=A0 1 file changed, 41 insertions(+)
>> =C2=A0 create mode 100644 recipes-devtools/secure-boot-efi-keys/single-k=
ey-
>> to-efi-keys_0.1.bb
>>
>> diff --git a/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-
>> keys_0.1.bb b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-
>> keys_0.1.bb
>> new file mode 100644
>> index 00000000..cfa48b7f
>> --- /dev/null
>> +++ b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.b=
b
>> @@ -0,0 +1,41 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg
>> +
>> +MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
>> +DESCRIPTION =3D "Generate EFI keys from single secure boot key"
>> +
>> +PROVIDES +=3D "secure-boot-efi-keys"
> The naming confuses actual keys (private portions) with authenticated
> efi signature list) actually holding the secure-boot-certificates - so
> maybe secure-boot-vars-auth, secure-boot-certificates-auth or even
> secure-boot-certificates is more intuitive?
>=20

Agree. How about secure-boot-efi-certs?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

