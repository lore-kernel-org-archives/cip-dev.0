Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA3CFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 07:19:37 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2593.1764659969167049249
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 23:19:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=AxKLZeoT;
 spf=pass (domain: siemens.com, ip: 52.101.84.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDQAVHfB3ytP0QMni1oez4M55VYjRErcQscWlBaBG9x/2InwifiJAscZ4eqva0LQ9R+iDD23vJY6pvoyxfbB4qZKUs2WuNOH9OptFPdczqSfICATfJTTYGXzUO0RdnhD5vtoA0WcDvnCMITHC93/JTjvz2V2mXXpg84zlph/UdoopVDlZOH/yU4hZONegIdrc0TX5JA7AH7W6zBHdC2Xgz/h5uuhsDNcN1VyKEASNtZA5+WGlYDA8mURHSL31BcvSxa6Aw6uGIeiK4oiGtQOhh76L+hfsMy7DQTc4L/tWObirK81MqCaiHrLoZMMzwYbGlpTFCKL2lN8XWUc5ppbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc4YQGxGeiueVtAxxGAYdYxkqsz85M/xumrE8sSjmXg=;
 b=YGLThmqHixD2ceAywVK5x+/p1z1nUVDAmVcze5vOFHG59pq62QDXYkdzLyiH6oCIrZm7kaX1c3Goeai5xk4REn8o+/6Fgla4GklgQD79Bx+116pdk/PW5zsYUyXPvNApn00EdOrALHqxXa26nauE1nW/0vwd7YmFDEiBhGM0DzXx1A7wg0hvF+ltjvxf9tCQRC358Xjn1p4ZBmwXgae+CK92XuU2208BnMLiAt9nQfobfR1rHkc6tmFe1Z70LKuSIEsTkmHXcVXxgf1ntm5boXQX5yNxAI99V+79BNsua2doEQ9X7SBh19DM+gLA/UK7EOH9fl6OKOfn8ZMWTFH23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc4YQGxGeiueVtAxxGAYdYxkqsz85M/xumrE8sSjmXg=;
 b=AxKLZeoTqtO80DfXIzVPdzPjc0YAH86YwVSNFb5C4uymOTqOaZ0m/Ob8KXA7tGYkUFHDEuCkAbYvi2AHu25imza41YA0273zo4d119Ci2S3m9bcqxxS1YQn258MehIocyW9iYlq8SiGqPu5QQJu1QdLZP3shd20Cz3qTGtef9Xi1Pnes1qIUbmdvM8BPp016CMqFy+DTBd31XuumI5De7fhpirHBo+bezcTDDKDk1NDyWz69YgB6bihIfVxkeBrJiPhDbIRm/DHqKwg/PDzaCK64X3CIhLPqVDQdenmVJfwfXLZdAqUEw8uW/bXRblyRkNi3aLM6GBM0t2d5qoDU1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:19:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:19:25 +0000
Message-ID: <1927513b-3bd7-40b4-be94-28ae00a7f023@siemens.com>
Date: Tue, 2 Dec 2025 08:19:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
 <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
 <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
 <1883153f-6108-4351-87b3-835c88d32de0@ti.com>
 <f842cf21-f6a5-4e0e-97b0-00f3e6761ae3@siemens.com>
 <b6cd2368-e868-4667-ad0e-321a468dbcb0@ti.com>
 <d1f88d49-e317-4782-9ac9-fce1bf21bd7b@siemens.com>
 <b12ef53f-532a-4fdc-b0f4-1484e13ec22c@siemens.com>
 <695bab04-a355-4333-a6f6-1850a42253e6@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <695bab04-a355-4333-a6f6-1850a42253e6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 085fa13d-1413-4e7c-2812-08de31731f48
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?R2QOT3xfXYZr/emW3phoB+UcRmVJV1rQwFczGdrD2/ekqyOnpAVjnOuYExS1?=
 =?us-ascii?Q?NmdO8mDPjuqlksQdK92qmp859XqmvCc9vAL0ckq3POqmDbhJ0NRYmfsdSTkq?=
 =?us-ascii?Q?yRG8ucU+jdK+S69Y7iAq2G9PenQ5cOG/BcA4mpFyrP1G9cqH8E7O4eL7UNEY?=
 =?us-ascii?Q?B/6KaPS5C8FmJuVBGMBwb7uQDsGj213jmm955NviX8vILWwBxlZP4kJIPY8L?=
 =?us-ascii?Q?RVNlDlqcFJxwQwcCJpb2xNByKqhSraLxbkfrf2zAWUB7PbXLA0Fnhkj0Fdhn?=
 =?us-ascii?Q?RefPaUoUnYbCRfBtQ08qrzNJn0c6np3bsHDorf/zrTMGgGrpSqnHwYCE7a3f?=
 =?us-ascii?Q?EHqQ+Dhjf+uvO+uCRmIGZLF9Vv2qi+jWMGWFzJg6H+GYJv2bb/D0M6AAjOSA?=
 =?us-ascii?Q?WyzYk8JnL0E/ciV/3Gwubj6m3+P2y5PCzdMDGf4l3rNobbfRBsWE0AI8SLxM?=
 =?us-ascii?Q?tFVNpyN9SPWEegN/v3h7ex5lAjW6/GMmI/gG6tg8+BSJOzpoy6VbWQbjLVGK?=
 =?us-ascii?Q?aFSI25X3+mhcDTSQ1FlXdhdrKobLXT5ELwygaXFPm/71pUcfgVvYFyBU2Sdd?=
 =?us-ascii?Q?Uv3txjt4Qgo/xXoPKY7cQW4XzxeZpUrLzgkgbtJqejMupQo2ju1AuAITN/bU?=
 =?us-ascii?Q?lMj2xQwlUd5P9PyGRbj99HzjJD7j7PQPYLKYR6SrSv8OexST5l0SDwwc7ybn?=
 =?us-ascii?Q?d6C5ytAhmVcxLMoN5d1KdHt7uI5T412aKQGIPoYALGjAobLwxiBIkGC/ElhM?=
 =?us-ascii?Q?CN9TOFdREYDB0mGLy1/E0ze33CtCik4nLqW89swShiNAE6Cb2s5CC9JXvBfF?=
 =?us-ascii?Q?vf/WlK/hXq3smXpq1EF2J9Ouc1RAItJ+fMpP5/v82e+ysENp6MFjc0S86Xv1?=
 =?us-ascii?Q?Z5pAPE438xcWzTA4S0QupfVedK2Hq4DStXeiFI/ROZSwkyMbJfNn2XKl5b/Z?=
 =?us-ascii?Q?PFJpu+CLQNSg8EM9XKKVg2U7h1e8UvXvVrwuLl0E3YQ4UbQVfO3LltFC3qqu?=
 =?us-ascii?Q?7nRJCcN8/JeLeLXVy+oVS7vaou2pCkom/ssr1lGzt6jwKCJvuHIOQrxeDIGC?=
 =?us-ascii?Q?T/O8OK+Fyuvubhm3gJXWT+fqOKXMR0abN1ps9tiUgIgSvTz2MarDhZ7Pa+88?=
 =?us-ascii?Q?hvEHVWb0LpFWNOm80Uxaz/DuRkr11OwPdN8MwDbAJeLkhsqeKpHRTt1Ini22?=
 =?us-ascii?Q?7IppKs+GNuncyfRWF7iK7mutnRlL/cpB9AGlR1Qm7pJcYS9sus7Y67zw4MaB?=
 =?us-ascii?Q?ucSt8AybKF7hH67j2/X52WT7m8+1Pw0QUNDnUONjik3Y1XW7hNXPVU+hHJf+?=
 =?us-ascii?Q?uJdL1KNQCeKbYS0hkdArmXD0kktCe+V4vuuCBjRYFm/u61JLevBpcAtwwBP2?=
 =?us-ascii?Q?BULXgdBshaWGTs/tRZTbXcA5mMzKw7oTMGkverCa/RxOqOaTzg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iLqSN7R/FThu/42qfHfECag3HPk7uoqt3sPPEbtVZxGb0Nhy+onzfAzzXwlZ?=
 =?us-ascii?Q?VySKDy+8pSC1gh41UG9s5Rj9TP9V1O0/F1WSrHS5l/R69dB8KQpOfb+G0ycS?=
 =?us-ascii?Q?RQWy7mygd88QVl8UBwfjpNDmQ2SO0rvqCdeXPFi/JW2khOlpQ0uH9fSSuhGF?=
 =?us-ascii?Q?Tg4yjbV1v9nMyDnTR59E1Kx+SRMIhRKwaZHrRPQUovaFN8ACldFMdjpUl86M?=
 =?us-ascii?Q?2zoiLXl0+c9ESD4BGX6ZdgaG7aDCH8168P2zdEhET9lCk3XSYu1QnF2r742Q?=
 =?us-ascii?Q?EWTnbwAvXzCE/6+rT0hzOvCB8YVvSSGP95QwTsqQqTvQmY6IofwDmWSgE5hL?=
 =?us-ascii?Q?MqtKUvLPt+KlFtzGkGWEndBBxqxvYBPLTspHJ3hDXVtkOWhbBcwOXYGk7foZ?=
 =?us-ascii?Q?C0gzbc3ixrjB0L21huD2gpl8tVzIBQKr/t4ZMQW8Nl/11Lc0EUQYflpI/CAv?=
 =?us-ascii?Q?8S719IjvTFZnv36RRFyx8oIja/a7jgjjR/w/7Oc5/yHvKq4EQyM0FsvT9Bfg?=
 =?us-ascii?Q?VoR5/ebs9X1lUp69iXeXKU3uvTao8queaBRDsm10ndWiKrcZQA3klUFdVUKz?=
 =?us-ascii?Q?lwoHxnCC9iCbYdvCIe9cDEKk0eKymtZsXLzzLP1cMWKSBwEafoK/Lmdzh318?=
 =?us-ascii?Q?yDzzdkTgrndKmRxmah77g8UrXwtjPIzRE+qYjt64/MVS0T3z/7DCS8ernPHt?=
 =?us-ascii?Q?jcjCCV5ppd72fEc/JYdhQs6Ii/2kE/5ODDTfbafmNrxAmsgNw0ILp4swlUr4?=
 =?us-ascii?Q?gYYYhGcyCuAgqkEVDST8w4Bt6dTNRz9AzvOoVGtpX6jwmetLyQwFR/bCbHLl?=
 =?us-ascii?Q?tMkz1IKoIw1EdFkjxSbWeEz0AQuz8uXFm/sDaqyHhoFBPFp51jVHq1NAd623?=
 =?us-ascii?Q?mzzLWXOw0dU3f38JgJ4cjBSzpAtNnvHI/4shxAQBr6YIG/nGQj2sCvLeHLqQ?=
 =?us-ascii?Q?AQFlgTvIQ/PP0p54m0rT0qzoa9z626S2RQ6HSTROk2Yhql/75zzUxqYuHgEx?=
 =?us-ascii?Q?GmM1IzB3/AqkrSEu//WuhK/+2De7TIWAewDj974FvQ9WTBbULXWxdH2K7Q6s?=
 =?us-ascii?Q?402HpTD+j/NJxCaB3JWOKj9DsR0jKqPpkxbzxA9yy91Aq204DzucRADsoTpx?=
 =?us-ascii?Q?SQbJUFaOSHex+630Zfr9Ss2OGSBFsrymX41AYlYRyg9U59a5r6DJ+y6P5hdd?=
 =?us-ascii?Q?6cLc6iEukX11LJfXXJf5GCml73GSIV35I3T8yQ2o95q+X2fzMUb7xtkEp0ed?=
 =?us-ascii?Q?yc+1VyEdpWzhqDM6lwptApy/pzKjsAXomMx/m7NfoQCtRH4zx+ZM10P6l61V?=
 =?us-ascii?Q?03g6yyT2Lmd3Vn2L0lp0+mjGZx84qf1UJtQeF93aDgYbrTjFvdowRnjSTml6?=
 =?us-ascii?Q?oTpvAC3uiuGLgpcoPJnwcIksoMZWQ6Kv6sTZlZ8+TlpHlxbZRgYK7CwcXt60?=
 =?us-ascii?Q?7zCVW4VxL209mjRFaXA3XTDHhWnRrJinur64zdJB6SI/gFdks/jCZPYri+3w?=
 =?us-ascii?Q?ac6qiS4R1cqCcXytoIHOHg5/WeqUmLCmVSCuXAdeKYh/+YeoVdCKPyouvLCZ?=
 =?us-ascii?Q?HOgV4yavRvskryBMabEAIFKeq10EEVPXWPZS6x/q2rH81sT9zRMmO0X5XDsh?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085fa13d-1413-4e7c-2812-08de31731f48
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:19:25.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHsCKtLYWR5kwbytRyDrxiy6OJXMrslizdUOxhWfavZfyh092tfI0TewHTUZeTxyHfEldhMubCWW5hqfWsF25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9121
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 07:19:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20785

On 02.12.25 07:58, Sai Sree Kartheek Adivi wrote:
>=20
> On 27/11/25 20:05, Jan Kiszka wrote:
>> On 27.11.25 14:37, Jan Kiszka wrote:
>>> On 26.11.25 11:25, Sai Sree Kartheek Adivi wrote:
>>>>
>>>> On 11/24/25 16:35, Jan Kiszka wrote:
>>>>> On 24.11.25 11:36, Sai Sree Kartheek Adivi wrote:
>>>>>>
>>>>>> On 11/24/25 15:27, Jan Kiszka wrote:
>>>>>>> On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>>>>>>>>
>>>>>>>> On 11/17/25 22:45, Jan Kiszka wrote:
>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>
>>>>>>>>> Allows to use the same kernel for all arm64 targets.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>> ---
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 2 files changed, 3 insertions(+), 3 dele=
tions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope=
-
>>>>>>>>> rzg2m.conf
>>>>>>>>> index 0b3acf49..485683b2 100644
>>>>>>>>> --- a/conf/machine/hihope-rzg2m.conf
>>>>>>>>> +++ b/conf/machine/hihope-rzg2m.conf
>>>>>>>>> @@ -1,7 +1,7 @@
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 #
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 # CIP Core, generic profile
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 #
>>>>>>>>> -# Copyright (c) Siemens AG, 2019
>>>>>>>>> +# Copyright (c) Siemens AG, 2019-2025
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 #
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 # Authors:
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstor=
ff@siemens.com>
>>>>>>>>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config=
/
>>>>>>>>> ${KERNEL_DEFCONFIG_VERSION}/
>>>>>>>>> arm64/renesas_defconfig"
>>>>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/
>>>>>>>>> ${KERNEL_DEFCONFIG_VERSION}/
>>>>>>>>> arm64/cip_merged_defconfig"
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.=
dtb"
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${=
DTB_FILES}"
>>>>>>>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-
>>>>>>>>> am62px-
>>>>>>>>> sk.conf
>>>>>>>>> index 589f071e..bf3cf9ab 100644
>>>>>>>>> --- a/conf/machine/ti-am62px-sk.conf
>>>>>>>>> +++ b/conf/machine/ti-am62px-sk.conf
>>>>>>>>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/=
${MACHINE}/tiboot3-am62px-hs-fs-
>>>>>>>>> evm.bin;tiboot3.bin"
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>>>>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/
>>>>>>>>> ${KERNEL_DEFCONFIG_VERSION}/
>>>>>>>>> arm64/ti_defconfig"
>>>>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/
>>>>>>>>> ${KERNEL_DEFCONFIG_VERSION}/
>>>>>>>>> arm64/cip_merged_defconfig"
>>>>>>>> Jan, I'm seeing a boot issue after this change. The boot stops at
>>>>>>>> initramfs with the following log
>>>>>>>>
>>>>>>>> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' -
>>>>>>>> cannot
>>>>>>>> create a encrypted device!
>>>>>>>>
>>>>>>>> But the tpm2 device is available and the `tpm2 getcap algorithms`
>>>>>>>> command confirms that the device supports sha256 and ecc.
>>>>>>>>
>>>>>>>> It's working with ti_defconfig. So looks like there is some timing
>>>>>>>> issue / race condition when the tpm support is built as inbuilt
>>>>>>>> instead
>>>>>>>> of module.
>>>>>>> And there is no other module missing in the initramfs that might be
>>>>>>> built-in with your config? If you re-run the encryption hook
>>>>>>> manually
>>>>>>> from the initramfs later, that will work then?
>>>>>> yes. Once after the boot stops at initramfs with above error, runnin=
g
>>>>>> `/scripts/local-top/crypt` manually starts encryption without any
>>>>>> issues.
>>>>>>
>>>>>>>> I'll run some more tests to properly identify the issue and post
>>>>>>>> a fix
>>>>>>>> in here or cip-kernel-config repo.
>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>>>>>>> Thanks for reporting. Finding the root cause will be important to
>>>>>>> avoid
>>>>>>> that other users will run into similar issues later on.
>>>>>> Yup, actively working on it.
>>>>>>
>>>>> Is initramfs-tee-ftpm-hook included in the build? That is supposed to
>>>>> wait for the ftpm to appear.
>>>> Just found out that it's not included in the build. The recipe
>>>> itself is
>>>> built but the local-top is not added to the SRC_URI.
>>>>
>>>> There are 2 issues.
>>>> 1. TEE_SUPPLICANT_IN_USERLAND is not set.
>>>> 2. the initramfs-tee-ftpm-hook recipe has an issue. There is a
>>>> missing :
>>>> while adding supp-user to the OVERRIDES.
>>>>
>>>> I'll send a patch fixing [1] in sometime. I've sent a PATCH on isar-
>>>> users for [2] but I don't see it on the list. Will try to repost in
>>>> sometime if I still don't find it.
>>> I had a look at the config diff again but still didn't spot anything
>>> that could explain the different behavior. Fact is that the userland
>>> supplicant should no longer be used - pulling it in is likely only
>>> papering over the underlying synchronization issue we may still have.
>>>
>>> Did you also try with just the initramfs-tee-ftpm-hook of isar fixed
>>> while keeping TEE_SUPPLICANT_IN_USERLAND =3D "0"? If that still causes
>>> issues on your board, maybe you could add "set -x" to
>>> isar/meta/recipes-initramfs/initramfs-tee-ftpm-hook/files/local-top and
>>> also to recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> and share a boot log. I hope that this will tell us more about what is
>>> going on.
>>>
>> Now I recall:
>>
>> https://github.com/ilbers/isar/commit/
>> a1893507e495710297a2749efa3b2cb05e4f2881
>>
>> There is no waiting for some tpm device anymore. I was assuming that
>> this device node appears magically in time when the in-kernel supplicant
>> is used. But I was likely misguided by the timing I saw inside qemu.
>>
>> If you roll this isar commit back, then things should work with in-
>> kernel supplicant as well. Please confirm, then I will provide some
>> upstream patch which also updates the comments in the local-top file.
>>
>> Well, this kind makes sense because we also need just polling loops when
>> waiting on partitions to appear before decrypting or mounting them -
>> same reason, I guess: The storage device has to be probed first. And the
>> RPMB is attached to the same device, so it does not matter if we are
>> waiting for an in-kernel or a userland supplicant, both also need to
>> wait for the eMMC.
>=20
> [1] on isar worked. Thanks for the patch Jan.
>=20
> [1] - https://groups.google.com/g/isar-users/c/sVJxkjDm6Uc
>=20

Thanks for confirming! It's all in isar-cip-core next as well now.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

