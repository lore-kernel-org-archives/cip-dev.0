Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA7C02195
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:02:08 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.56])
 by mx.groups.io with SMTP id smtpd.web10.11685.1738227722117545703
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:02:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QZKc5Oh9;
 spf=pass (domain: siemens.com, ip: 40.107.22.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+YfvE8n6xlfn1qCoIadRM/AKHY27RIx3GCkvlXxQlV7xUDFubHoUc9rpgi9AEmH31ZPcbRoqiRmWkl8vtIPNXAJSYuqaGQDgcMg/G9XX6EWOX0PBjkFXhz2w8IoLTZZ4M7euW2E9egjj3BAKkHJwnqJ7uD3wjSw+mBXu5Su+i65zjRzCci9c8+f1A3P9yekQQm0CqsklJH39Fawzj63q8NxDIDkgQDTH7L/KGgt5Bk1ZpMFksKfdlspgt7U4kLIa+MmLcOJsVl7DSyXCmej0xEXBShKiMQowNVGZofMX0zWVgJL/RUzwDaY/riI78ABLyCxQ4j7FSBk/Dp8MSC6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJfjhBQF2X/hZq765SXgtqZQOEjDUt2RTyk9ZvykpBc=;
 b=SbD2b4jhXW1T7uV24XCUkKCAriclgUcpOZILpsh/H3BogxtjA5t22haNQc/1HwuDVx6AHJiD3iYP02zlsGDoRYCDAtGmsryXdKqz0BWscF+SyNb0Q35emaYB5O8bUgN3jPN25feXo5yY0YEAghbDz0CY3taI1OvsrbxSyDp6SLPDTCpBIdZWhMf2mbgFU2zBx6vkNKtSRjGaSBrH0kuGFPjhHAArzU5NCpfBR71F/cBscM8GvvusQCQkVoSEVZCMnm1k+FvZQ8Qfl852OmW13kOdVGrjJaX0NJLSOcHSW+vvk9FioRLi2nZcpxNbchjL2+61BcLrejfCgI+7HjLBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJfjhBQF2X/hZq765SXgtqZQOEjDUt2RTyk9ZvykpBc=;
 b=QZKc5Oh9AsbFbuPylbHoOcjkA7STLaOgdG5xCa1h186nt59i5l97WnZPvG+cHIbcVE2AJGTD6Nr05FgerjnzuiTgw9eZWAfvF5VrB/WffXJuYEWqvmTRLnsNf66KNq64DRENsW1v9sOqX6+eohduSqPgfApYK/AxNXAPVOFdtFbLZ2YPdnCqtPUNFbA3Uvr/U/qGNZsR+Q/bgqFvFEuvB1RseHpyq9uS5LTfkLCbFjbWiaAcMSQSm6MQ4odG+zb6+qc8zmJrj06pHmqn3QmlFE743zAdaOGS0OACBVsfEA3pczZSta2Wid0RXA/9MASDHyvw5Si/cUU/nD3huSo3Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI0PR10MB8906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:01:58 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 09:01:58 +0000
Message-ID: <dc53e50c-3901-4051-9414-1a1c9067c519@siemens.com>
Date: Thu, 30 Jan 2025 10:01:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with secure
 boot
To: Sai.Sathujoda@toshiba-tsip.com, jan.kiszka@siemens.com,
 cip-dev@lists.cip-project.org
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-2-Quirin.Gylstorff@siemens.com>
 <38e3b2ea-9dad-4f14-8e73-9dc8f4c05f9d@siemens.com>
 <a57c6f8f-47ce-4202-9fb8-fab2c33fbe7c@siemens.com>
 <OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <OS3PR01MB61030247E8AE7BCFBDA4ECDBC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI0PR10MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee68905-9f94-4fff-6d11-08dd410cc0c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9y/PmPfL1767nrYJ63oaz68EK7Bg/ENYpqYdNVx2nsHgYUuhIsYAi//2UhlT?=
 =?us-ascii?Q?zFoOrBp0TlDfB+U1Ctay7y+dA7GNTDGNz24Wz2z0oXKafaVCO5pqPBfqnjno?=
 =?us-ascii?Q?Wt+ZNe9VbvujYBNEyHyYeAfACCwi5G5Efhr3kCJOMecp7U55rmZ+VqdAncb9?=
 =?us-ascii?Q?lzswodOXf7KXI98+nIh7wlo4eZ4jMxq//LYIEeuEO61zEZaCXgbZlOvzDB9S?=
 =?us-ascii?Q?ybLgPYPy7TLptZvXOPSoVbyD4MS2GOhQtUDLsM454HdzdilYLdF7H+XKTysh?=
 =?us-ascii?Q?BU2tMMIxjYdGyJtx8ZzPayK34mjAqpN0lVSqSs9uRgkuTHARX93Rp7ArSpOX?=
 =?us-ascii?Q?T6ouIQf8edszosLcToV2xzJvU39c5sxrCCIlP8UT3i5XdH6fOprTwKo2Y61N?=
 =?us-ascii?Q?Yg4tN1AVJsP9ZykoXqFskA9efNsy6mOAwtxCIF5CqUOizoVvg+UsDI2N+OvS?=
 =?us-ascii?Q?yFa8yG8+WtW2BtT/O1sqMyoVn7RAR0TXqFf3aF9tzdYyCJpaHpbjFppa8XDB?=
 =?us-ascii?Q?q6TnwlS8uUEoGOi8FUbPRGPB7lHQ4AvLnh7iZsh8nSRDjRMBzTgGcashf1lj?=
 =?us-ascii?Q?4+YBSiIENpRoN87XNAKMeZiofk4lLE/ff6wqdGU845Vsp5u65CaLYXKr2lGt?=
 =?us-ascii?Q?U/O0kI7GPYOw6S0bmVQbZtcOxNK+KpC+JrtE8PRX6XQ4Aveaal/fugyRW7Rg?=
 =?us-ascii?Q?1tkua137LS7Q0paOOvu0OBiwon8/6tOjwIp10H/9Ef9WMsdhs4g3zra0WwVQ?=
 =?us-ascii?Q?2RwH6fqoG0q0zpb2OivYJ1V0/GVxVogD4b+tZJRoKS0KqnKmqB1q3qjBn/Ls?=
 =?us-ascii?Q?cI+aXtLlaHspIKoiQFc12Cl+DhgsooxwVxwglKMwQaLGsRwuxotPtu2ab0VG?=
 =?us-ascii?Q?ikTbn8YAJJJIhUgZfoIGRRN3NrIH8uCqIj5yWYAQqKKFmAO/p7qHtsklWfOJ?=
 =?us-ascii?Q?iyTV+DBCJmISkTYgi7SEQrI8mH6J0k0DmGgyNIC8Ms4oLJhuWfYfVCMFHOv8?=
 =?us-ascii?Q?nn1ZBu0X1Nu5ecDoiUTyX30eAIGxdAn85F5I7Yg9GxuSur2lS7mlE4rg7iMF?=
 =?us-ascii?Q?5ldxl+X48Q2odF4Ac5P+fkHiGZxL9knTimd5EQzvUO4wXMqfFUPLQ6f4K1Au?=
 =?us-ascii?Q?quJmDTG58YAgxU1mh3B/mcjZxd4txWGrgJE6YAM/U0VIhmEaV9AdsgmqVLQE?=
 =?us-ascii?Q?Gj/WD7xf1eaInEIYyD2v/BjtDdRSsnmc5l7y30Nt0v2YLAMqpOs9ESajHPRd?=
 =?us-ascii?Q?LMeTyT3wqd2bkmQ1xM0Luk52DUqfHtEt+JIz6BY2+3mbn+r+sJXjWehLE1y0?=
 =?us-ascii?Q?NCvxhD7aRETX0qC8uengJ9/kgXVTe+SibCjn3djRCGrSaYH466lK08Gsek1U?=
 =?us-ascii?Q?rCpGNKFNJWUGujUcxjt/btvYPAEB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NrPo0gkxtuAARn0KT4gnJPf/NTUUGcukDBPn/gRcRnAMMyHb35vjy1fppBCy?=
 =?us-ascii?Q?WQjzvInojndquMTYtof6AnVU3THlvMiRLzD0c7bBdhJrSMqOXhpJBMKii/HT?=
 =?us-ascii?Q?TZaPeT9c381HV8p+tzC/VQUhgBXWYGHrvLEwL/G9hYqWWxzc+ivkONaEnlbH?=
 =?us-ascii?Q?wa3MznV+CZSK8TITaLdG99EZ5elInF5+hKerOk4EmpYdY88vBcTzu567pAGc?=
 =?us-ascii?Q?wvocF90ibSTeyz3wXf7ZNKZkDQW+WnZc5P2yFP+Za517lQiPNU0KLpp/jSs7?=
 =?us-ascii?Q?Mb4WLhtBkq2EloNwCqmnNkwvfWKzfr0MZpZXUw8fzYpuLPFllWv32vdHIBRe?=
 =?us-ascii?Q?pFKqbLWftfvO4+5kdbg4ASCvtzUn7Ai2EDd3z7701nXC8ge2zMzKwpnILKpF?=
 =?us-ascii?Q?BwLJhmrQg2odut+2kVrkaEtZbsEVv2pNEDoq6C+fSJHWLayEgy22VIEUlCwG?=
 =?us-ascii?Q?vrqTX6d5cG+vPD+ewdWOs9sp9J1OQki1xOF6ahqc4Si5cSet8jiXxHosW2mn?=
 =?us-ascii?Q?/Sls9nwzWBtHiCrKsutKMb9dRjmNn+mHXAB3bOO+zBKElN6UOMhMwghUeGLM?=
 =?us-ascii?Q?kpYPPMx46joXMDPP9JS6rpd7jbLp/63ehq+6g3w9jPDP6aVL8h1VgHoroE2i?=
 =?us-ascii?Q?tTpVViv+La6ip47QdNUmOYqVrd0P1j4Q4aBkV4mo3pU18YFMDTrmh/90Mvjo?=
 =?us-ascii?Q?+MHLIYqsu2rZe6zrLwcKhtrYOrRXAxaTZvc+xWCLSy8GN3d1Oei+wyz5R7JD?=
 =?us-ascii?Q?/rMy3/nEex3RCJmrjqdnCi2TAXix+oi5oAT8dTW/T6pFk6IY9yVH4dNfp5kS?=
 =?us-ascii?Q?xrYS76+fZHgMCTSTS4bRUuhYL7Kh4RNz7HLDlWO4loNDQMtShfW8gao/9IuV?=
 =?us-ascii?Q?zZk+ZlqBdy9gVlVJVHHadsdXMtFd9KcpdFEIx0vdDK5wmlEOdA5wPdmUXR4h?=
 =?us-ascii?Q?llNYNuwYI3lG8muL29Qf/NkSwRVJVQO0rAT0HbBwbHeAngS2t34VpO5Qg5J9?=
 =?us-ascii?Q?kdHQGr0jjGysaSoO8AmkKMiQekZ8+suRIUkkKcuJ695Rwb7f4rhrCQ+9KmmB?=
 =?us-ascii?Q?ABsZf9TZfHN0zYn1Ea8Eo4sME7cVwACPe7Td3KMqaxAj9sZIDE32Zy/k2+6s?=
 =?us-ascii?Q?CG3j51J0HLO5Y9DCemo4JtmmS3s5+QxoTKjwFW00knPWAtswHFwBO4H9SdO7?=
 =?us-ascii?Q?vV8vTWTuurasMxXVcGrHVPCmdizLGZBHZmzPfUIFxyw+0iZ9Sc4ztbcGtei7?=
 =?us-ascii?Q?uyiqgIzxIz4jASbEVDdskKrOXMwBpoLMbmHWmaujoCaY1q7UhqPdUzErnaDK?=
 =?us-ascii?Q?ivGdgRg3DNpNzGrwEoU9gh4JdQr5aAkjPyaxOwvDV2jodpnfV79KaMZTCRYt?=
 =?us-ascii?Q?/5jxKfVbK+fTtmjBg/qVtb3Df3T1RnVIaOCGvY3M2GLgH7brycPEj/RlkYcz?=
 =?us-ascii?Q?jRLiaBR0T1szsJYoXXyadtDCHfkrf+D9w7MjqnN/lyvgxwwYrbRlBBgEFXZ4?=
 =?us-ascii?Q?y1o8YwEn5ZSPDdp5s4OGOa0eCnOO2ebTMXyA2FHQS0rw80j4eDuApIgOv9iB?=
 =?us-ascii?Q?w3GLUaOr0QpzX+aHHUIgcznQ3hUCtjvhlHElszZ0TaOHzwk0QWA7woSElFno?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee68905-9f94-4fff-6d11-08dd410cc0c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:01:58.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7Fxl0LJzLhbitk1PUc2f/b+p3ESKXF+HKOw/LnqcD6yDS2az1RvZ21tZh5GhemCd9eTuoXWZ0CWMnlsNYaAT3FJgkzgAQtYg/3Sho+kb1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:02:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17692



On 1/30/25 09:45, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hello Quirin,
>=20
> I believe we can drop qemu-amd64-secure-boot-encrypt, as we are not testi=
ng that image in LAVA.
>=20
> The target being tested in build:qemu-amd64-base, is very similar to the =
prior one. The only difference is build:qemu-amd64-base additionally has se=
curity packages.

Then we can drop

- build:qemu-amd64-secure-boot:
- build:qemu-amd64-secure-boot-encrypt:
- build:qemu-arm64-secure-boot:
- build:qemu-arm-secure-boot:

because the all use the qemu-<arch>-base which enables secureboot and=20
encryption.

Best regards
Quirin
>=20
> Thanks and regards,
> Sai Ashrith
>=20
> ________________________________
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> Sent: Thursday, January 30, 2025 12:53 PM
> To: Jan Kiszka <jan.kiszka@siemens.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; cip-dev@lists.cip-pro=
ject.org <cip-dev@lists.cip-project.org>
> Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with s=
ecure boot
>=20
>=20
>=20
> On 1/30/25 06:29, Jan Kiszka wrote:
>> On 24.01.25 14:22, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>    .gitlab-ci.yml | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index d4bd283..42e247d 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -241,6 +241,16 @@ build:qemu-amd64-secure-boot-encrypt:
>>>        deploy: disable
>>>        encrypt: enable
>>>
>>> +build:x86-uefi-secure-boot:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target: x86-uefi
>>> +    extension: security
>>> +    use_rt: disable
>>> +    targz: disable
>>> +    encrypt: disable
>>
>> Why without encryption? And can't we replace
>> qemu-amd64-secure-boot-encrypt with this physical target? I'm looking
>> for ways to avoid building more variants.
>=20
> Last time I look the qemu target was also tested.
> @Sai can we drop the qemu-amd64-secure-boot-encrypt ?
>=20
>>
>> BTW, you are dropping "encrypt: disable" in patch 3 again - it's the
>> default anyway.
> That was a copy paste from the build:qemu-amd64-secure-boot-encrypt:
>    target.
>=20
> Quirin
>=20
>>
>> Jan
>>
>=20


