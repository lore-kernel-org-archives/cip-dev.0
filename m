Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D0D3C538
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 12:31:02 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14540.1765369852398307260
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 04:30:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=xPYx1DkS;
 spf=pass (domain: siemens.com, ip: 40.107.162.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU7eEHoqwZS6PvAybDDb2aqgWaomGUBUEFfr5q49w0yXiO9EyezltpyjrU9F5Zfm8J0Eib30FbJ6KKzqbmCdwT73wU+cSmzxH+kioW2EYPDKWQMEdqvxe/iyy6xAFwf0/N7isf1lQ0yFdXf8tbLfcI46w6yePy+sPC2wa2MMZa/sNSOZHZ5x990fmENCIU0aTHAJVVzrCy/ocrF66CkTgka8Xsm8fHM2xYzjh309Dcfu71LoxOAxIzFq+Bn7w+CKS+5DS+aMci9J5Xvt3PxtM1EDf+A3teNr2hqzJZYBB2LAPYMu8jAvt2O51yLvLMz/0hrJbr1oWw0e2/hNLlQHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7uGhBSGXreZ0BmiFysqUQYmHy6A7NoSylLmAV/wnL0=;
 b=snMfgAOQB1bWrI5sqGlAJZHy9yv/kgQxcvySmB01p3CL0fRkIF/D/NWrAAzgUv7nTaB/guhGdkG5NHGnYP9N0bA937Itj2GD9MIVpaTt0myVQTBMX5cF75VByIVx3T3y4g54zqd57D+ufNmrCbBjUKjRLkJmBlDnGXT8PzKFU0ecEDp1XVKIqlEifX/hd06/3APIdQwHDzgQKr2d5UBlSvDuihfXe17/qVHVFGxQhzzGNFKWaY6G/Shzwxo7m+AP8YCOYCWv2u5RkX6+dgvtg1cl+3AcjEAjArNRmpk3C/kCPfSic1v8kzcmiboKzuBWcS5B5NFsSONXcglAghb3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7uGhBSGXreZ0BmiFysqUQYmHy6A7NoSylLmAV/wnL0=;
 b=xPYx1DkSooDkUzn9t6tFA5bvKjNI9puCDyAeLMx+8iDtOmrE+Lx+ho4EiRa0indD9ISIskZ7uQaQ7nr8S3ewdyDlmC8MrmPSEdxeTnJA69LQrYnxPhTOh/EXDu319w3UvMxvvVoL4flYs87sGPZYBEl2ogTrcQ5eg3ex36CQqBhlr261TwUlElNmTgddUCu0N9BT3fxtGjZ35yDg5p/fq1w7lGERluUPFdiZL60PuoYOxHzYPIaMgK1QNHZZeuhUC8zmhDIKnMWU/2wMrFfTiTol6logpk4Y6uct0kki2QLxfA+Kc2ZIz58vC2jcNmIXsC9pDo2+FOjXQm00hzchZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 12:30:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 12:30:48 +0000
Message-ID: <b7adc39a-67b5-4189-a36d-cade887a6a02@siemens.com>
Date: Wed, 10 Dec 2025 13:30:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
To: Shivanand.Kunijadar@toshiba-tsip.com, quirin.gylstorff@siemens.com,
 cip-dev@lists.cip-project.org
CC: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
 <0ff460aa-35ad-46f4-b7f6-f643a89d7b78@siemens.com>
 <TY3PR01MB11075341DA1CE1C0E9A379919C7A0A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075341DA1CE1C0E9A379919C7A0A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 159b9e62-1cbd-4b64-f78f-08de37e7f26d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XeSkS/T2ENebUm5/dTFrraNEnJ2wTYCC4DQxwBAENHknVaf/Gdh+xwQBajPY?=
 =?us-ascii?Q?up+OHFrk+0p+XPxQKJZcML80bUuoGZm6oHKl3aDgcemsvOzyeQDOAfoa/1jR?=
 =?us-ascii?Q?DDlTpaphwYDjrZ9SA7Ir924BuFBViTvpBSMs7fdVLHmUhGQk8g3H9tDBq851?=
 =?us-ascii?Q?D8x2SlBJW2DesbJUc0vn3HNdc8nKuM+YSimf69BxHyRuvt437E4UkAo6ilUT?=
 =?us-ascii?Q?1AyDlOfluPPGpsuAGinng1DQ375uICmZ1e6V1qc9elK3ljY5svbF3uX8BONU?=
 =?us-ascii?Q?NrAZB42K48GRkU5iIpz45B54yS8zrgDckwAIwPGkCgJ2hW+nKlIT7nE2jl96?=
 =?us-ascii?Q?bw5A92i+MBT7LrhNoZ4zlQ7vGlaRSCmlC6St3RY99Ba/0iE3VomUZsfU1U6W?=
 =?us-ascii?Q?0VFn0a6697ZVBkaZozRUhV1ZopeH35mwT7sl20mP5wBww2Fr9p/f8lGBME20?=
 =?us-ascii?Q?TEnRJmYBavnsRJksRR1ZBDJuKxLi/eAC4Wfby4Hz+rzriwXLRm7YJdKtTD45?=
 =?us-ascii?Q?YtcyoaVz8vIk1kK+4a1PKSymztgi5UrcooXbJbX8EH+QLjBbpEiOEcrKCOus?=
 =?us-ascii?Q?k/37t8Em+Sdpy6icKaZGxlT5QIMurZqHCTJtJveuGLvxrhQ4ORU3Y73LjWpd?=
 =?us-ascii?Q?cuXsTqzmJiS89egmgmBbnX70SDFZkWFJnPm7wi4mZ9rty6IwlVSP5FTDZoNE?=
 =?us-ascii?Q?LaeytpFMtC+mMYRxXYchZKZz+nY9bkgl7HqEFwe3c7VKmY5icA5f++KmGS3K?=
 =?us-ascii?Q?2Bzm56mpTOAPRUh7zdBi9EfzcL+JrnQd/hCpLh1yqTmx7ewxA5Wp8S9JlfKj?=
 =?us-ascii?Q?0Z7kw7iDYsEKKzTiFfhAuJPcDhKUiTD9nGvD6oEy5JWXCVepHnKZLxg+yUfj?=
 =?us-ascii?Q?WQE8Ea2FrMgCw9Y3/EO4WO7TysNZkHev1gpfnl18sQ2j8JS9ExVSXyFUOV8C?=
 =?us-ascii?Q?boeUPsvh5wUBGYuCgqvYcMRFi0p8z7jz27uLyW1qaABwcA7yhLMc+SauQGs+?=
 =?us-ascii?Q?7ItNvKUKtg5+Ibyjhl7ETZz5PFg3POACS9Wgx2Bb9R5xqxjf9heaWd0cl1OV?=
 =?us-ascii?Q?qg/8yQ2OFwnhHhvE9wqVI3SYBAfTTWn9oF+xpptVIrg7jFKqEzYBc1JGs4IS?=
 =?us-ascii?Q?11xtvKeCou5JwtOetFUPkgaXehcHelHjirHQMG3NEMFnPGShYr93E8gs9InP?=
 =?us-ascii?Q?nKsfc9gmSAddjNMvT5tCvePMSn2Frs+k+hN5SPR6V84W362yQDJPciwz3gTE?=
 =?us-ascii?Q?BVQlkWvDa4Rn5bIioOIfh63iLzjoWQkwDMcSQJymU1ZjEjzANb1sFIdFXQdp?=
 =?us-ascii?Q?aOpy40hV6CBFID3mPPWjsML3f0IuxbTjt0WBKCNLOst1kKTP91YoRBfhDHv9?=
 =?us-ascii?Q?G0uJGRr4QQk7HkiYOy49hO5JstZfoixAdZP6OR2PQt1LdQXZ1EEojoNDy69P?=
 =?us-ascii?Q?F5m+NfadK2LOYP6THyAULYGsy1djwto4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?69/O/7TOa4bGtZpCWUG49vIhYs38/JwIp/6r/AiLDM8/V6SPVcEgonZ5gMvm?=
 =?us-ascii?Q?ys+7+YHlPgv+RF1Q8ILPzsc9KRWdLsUti3Z2tQq4npU8OekCqSD6anWc0gnC?=
 =?us-ascii?Q?blG+i9pVG1i7gqxN9b8kMrf4uloObjVRDrzEbkKs+CG7da7YRUfDT8eq0+Oy?=
 =?us-ascii?Q?Ok5mmryGNqfrMiL9h5Uk3di/r5WzZEdY94qp0U/zh8Y3eet1GXNTo0gHhnnG?=
 =?us-ascii?Q?h6v6NbpQIofjV/2gr0wkcXrbv1fNIB+2AQo9pFuko1rP26GC4alcIvpv43/4?=
 =?us-ascii?Q?Tk1+ej611oseuEBRmph4ersSN8NadJ1zF40wMXigJzpcIltHPZRAsizWygOh?=
 =?us-ascii?Q?fL6hcJEy+XVXaCdlOb6O9lPnHhjaI9B/IeK8o3jXpiRotwpWN6CUpwsHcx7N?=
 =?us-ascii?Q?FSDsBLoq5ZBo52dgPtr7QoEdm7pz5bhn8U5EmP/urQ6fVm6T11QXgCVK4iAD?=
 =?us-ascii?Q?b/ihhvnWXBt75cv9NpzPeJ5xQcM7Uj6GXOc8MldUsyL8hq7aIemdg2TUD166?=
 =?us-ascii?Q?U9Dlj/j8gKXDi9Bx01tQznktNZa4f4FmgSaRA7TJW5gbKkq+vRIH85kZ/3t0?=
 =?us-ascii?Q?arJSEpgMkmB8pQkyi89K4+dQW9z11x00ooi/tQvemn3Cd62ug20pb0g65X4f?=
 =?us-ascii?Q?1LcpP71egof9i/QtNW5JhHEA+CAgRM6Jih1fFO7l/Vor4tQYz69Wut0uuZIF?=
 =?us-ascii?Q?gEHrm2srlo3qR8urtwSE62z9umg5mQZ9Uq5d3b8uypOdKF8eGWBdX4Ldnh6D?=
 =?us-ascii?Q?f2Yxme8KiPKrKBvloN78MpDA2G4UKrYGuQ5usPmWEgbfppa9qvd7g7fzfbLz?=
 =?us-ascii?Q?wI5xi+XPdiCHWvrB+zEbJEePCc1W+9bZf4aTULHMjPphz0uLyTS2i/GWQiC7?=
 =?us-ascii?Q?upsq3xD1qL2k8RD0B93ANy3YYRqXwDGyGuklan98XwP58QvZgM9RyVkcpKAo?=
 =?us-ascii?Q?jryRKiENlKOU0dLCTMyvLyRWb/8Jng8LkHbDzWlk50wZZA261jC+sR9uXJR+?=
 =?us-ascii?Q?//frG+nH48JWx8UpEY6cuNt1NcMZd5lfpKA5xVK7TE2HPf+6nb5ZqrXhjZ7E?=
 =?us-ascii?Q?EMJZdKoTFowEJIkqq9pYkWJLQhnxFZ7ZOCiTOD3gRmwlZMrt3vNBikAHUnD9?=
 =?us-ascii?Q?NpqCB8uiY5PQLPYMFuHWyBrlCuZllcP0o5pFcB65Tkklb6wf8XoK/obMAkdF?=
 =?us-ascii?Q?60ggjESAJH4j21p3jumjhmLipNRBTF2YmZmw9qPFHcVrVaDSpllZJH3PdEN+?=
 =?us-ascii?Q?2wofFFywXsNLkmkB8se1+CctXU5mR4Atn/RMPGXYU6xVhFOQZu/Poi4tJn/+?=
 =?us-ascii?Q?Mgxl3mMwMvIMGa/vSAAvYcilyvLme5BnFxo3t+KfmpfKNqpZYI/5dA9uDhBT?=
 =?us-ascii?Q?ytiuMt58QKFEsTMLP+5kHn9pLvdxyxJ2on0t7ivYgWD+4NnI+B07Z7sK1aAg?=
 =?us-ascii?Q?D/bXpf6woQkAfkrN81b8C0YLbDNbdnYQnrVASFenFM0bsJmA6uUEyB8a8rvv?=
 =?us-ascii?Q?Wm6eNUnhK76zzuqlBeYLZ0H0hOHL0j2dwE6e5PgrjJiXROk1GFqqGG4QGcXL?=
 =?us-ascii?Q?nDV6UcqV9YPeZs+aqLjT02ZLigZdD0m1rDq7bHnp+xIMXZjEoYz5BKYtyaD0?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159b9e62-1cbd-4b64-f78f-08de37e7f26d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 12:30:47.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfxQNBUl8RM7egEYPGLKo3rSjR6m6ZkfsuPnThVyQoh/zkSjhwKiZLD0pa928DpjyCZ1KgWTYiovXHM//S5rXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 12:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20960

On 10.12.25 11:25, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Quirin,=20
>=20
> if I remember correctly, the same license information was being used in t=
he m-com health check jobs and even now also it is used[1]. =20
> The m-com job template is derived from health check job definition, so th=
e license information is inherited here.   =20

What is the exact external (non-CIP) template file we inherited from
here? Maybe we can resolve this differently.

While this is just a test file which will never (under normal
circumstances) end in a production device image, we should still try to
avoid license inflation unless really needed. It will make life of our
users simpler.

Jan

>=20
> [1] https://lava.ciplatform.org/scheduler/job/1238088/definition
>=20
> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Quirin Gylstorff via lists.cip-project.org
> Sent: 10 December 2025 15:05
> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
> Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>; dinesh kumar(=
=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-ts=
ip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=
=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.=
hayashi.f74@mail.toshiba>
> Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add templa=
te files required to generate M-COM job defintions
>=20
> Hi,
>=20
> On 2/7/25 16:04, sai.sathujoda via lists.cip-project.org wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>   tests/templates/M-COM-x86.yml                 | 52 +++++++++++++++++++
>>   .../templates/swupdate-test-action-M-COM.yml  | 18 +++++++
>>   2 files changed, 70 insertions(+)
>>   create mode 100644 tests/templates/M-COM-x86.yml
>>   create mode 100644 tests/templates/swupdate-test-action-M-COM.yml
>>
>> diff --git a/tests/templates/M-COM-x86.yml=20
>> b/tests/templates/M-COM-x86.yml new file mode 100644 index=20
>> 0000000..4716225
>> --- /dev/null
>> +++ b/tests/templates/M-COM-x86.yml
>> @@ -0,0 +1,52 @@
>> +# Copyright (c) 2025, Siemens AG, Quirin Gylstorff <quirin.gylstorff@si=
emens.com>
>> +# SPDX-License-Identifier:      AGPL-3.0
> I had some request about the license of this file as it is the only one i=
n CIP with an AGPL.
>=20
> Was this license intentionally?
>=20
> Quirin
>=20
>> +# This program is free software: you can redistribute it and/or modify =
it under the terms of the GNU Affero General Public License as published by=
 the Free Software Foundation, version 3.
>> +# This program is distributed in the hope that it will be useful, but W=
ITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE.
>> +job_name: mtda-mcom-#test_function#
>> +device_type: mcom-mtda
>> +timeouts:
>> +  job:
>> +    minutes: 180
>> +  action:
>> +    minutes: 95
>> +  connection:
>> +    minutes: 25
>> +priority: medium
>> +visibility: public
>> +context:
>> +  lava_test_results_dir: /home/lava/%s
>> +notify:
>> +  criteria:
>> +    status: finished
>> +  recipients:
>> +  - to:
>> +     method: email
>> +     email: cip-testing-results@lists.cip-project.org
>> +
>> +# ACTION_BLOCK
>> +actions:
>> +- deploy:
>> +    timeout:
>> +      minutes: 60
>> +    to: flasher
>> +    images:
>> +      image:
>> +        url:=20
>> +#project_url#/#branch#/x86-uefi/cip-core-image-security-cip-core-#dis
>> +tribution#-x86-uefi.wic.xz
>> +
>> +# BOOT BLOCK
>> +- boot:
>> +    method: minimal
>> +    timeout:
>> +      minutes: 30
>> +    reset: true
>> +    failure_retry: 1
>> +    prompts: ["root@demo:~#"]
>> +    auto_login:
>> +      login_prompt: "demo login:"
>> +      username: "root"
>> +      password_prompt: "Password:"
>> +      password: "CIPsecurity@123"
>> +    transfer_overlay:
>> +      transfer_method: http
>> +      download_command: "curl -H 'Connection: close' -v --trace-time --=
output overlay-1.1.1.4.tar.gz"
>> +      unpack_command: rm -rf /home/lava; mkdir /home/lava; tar -C=20
>> +/home/lava/ -xf
>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml=20
>> b/tests/templates/swupdate-test-action-M-COM.yml
>> new file mode 100644
>> index 0000000..02b0b03
>> --- /dev/null
>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>> @@ -0,0 +1,18 @@
>> +# TEST BLOCK 1
>> +# Fail the job if software update application failed
>> +- test:
>> +    timeout:
>> +      minutes: 15
>> +    definitions:
>> +    - repository:
>> +        metadata:
>> +          format: Lava-Test Test Definition 1.0
>> +          name: sample-test
>> +          description: "Test software update"
>> +        run:
>> +          steps:
>> +            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA=
_JOB_ID/downloads/common/cip-core-image-security-cip-core-bookworm-x86-uefi=
.swu --output test.swu
>> +            - if swupdate -i test.swu; then echo software update is suc=
cessful!!; else lava-test-raise "Fail job"; fi
>> +      from: inline
>> +      name: sample-test-1
>> +      path: inline/sample-test.yaml
>>
>>
>>
>>
>>
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

