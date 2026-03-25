Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA33103A9A4
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 10:54:29 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19706.1774436066287247991
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 03:54:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MRRfn6mc;
 spf=pass (domain: siemens.com, ip: 52.101.72.23, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwI7uxyIvDFPV8c/EEQx2NCQRRhwcNT4z2FslX9XbUdU6Q8SvdFYaDmagTq4kJbAGyj5Br+0MhTUiE98KE2x66bzBN+kn8BoIl9/ZV5PdztpYS/bnIEXM6J7l3hWzP7/FVDo6QgzMo1KWMdZxO59gNVhcTgA+aZjcw7xwRZb2WrG2SfmaadThWXwNTLCW/rSL0pT3UAv/NzqUau2faY7EB94m+/XU9KQMLWjLr1pfor5yTt3wqm2/z1a50qUXVfGEGUcrfCMCyezYbt7VE3qTjUD+ojPGG5jt5iSFb535fijS5k+AP/mHgiq9rVfT2i+r6gjzjSofy/1dt22s1Rw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM9OiFpqFJjX4lJk5EoVkA/MOLkQoQr8f962ou3G/0Y=;
 b=tJN7/Z8hb4b+XzbpXkTyMBUsXeRU0+SOP8hqlpWqx286CsSQ4r2Fo1VjVNNLHZZPBPlsjiecITAt7CnFVvnCf9Irv0CGvWcdPr3DvsYBFBsb53YeWbTAqYAGf0jRMJ4dEOhC0uMvNBLTy9SSMEOQg4UlUtInxr+GoiGSelUC2VxhzI3lfj4aUISMrEeCFZFDKFOCF/bkLpiPeV+nTBRnNusptJkAMUqi/p7SIrWmxz9sZMUuGGX8vkF84zU8RfM3kKThF9jjG9i2qgzIVjJzXNzwy1uVAqk3xN5r7PtmpeOnoRak/TYQloceudpCvNDGrkiMhVIVOHkhCrHKofj/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM9OiFpqFJjX4lJk5EoVkA/MOLkQoQr8f962ou3G/0Y=;
 b=MRRfn6mcWeVezVpID+1MWQN+F09fDl4kyxRwQmFjSmXFvR4LWbTbE3cUBjrlpFknI8pqHW4e/M4baf0+uqa/6c87o/9GOeRLPIa9cvxNWADCJOHbjNKe+cAhM6ElZm4TlznjvcABXaETOzA5U2lpNYSR4O05a5Zv1kdOz9qs8VKlDJ6rpuhOceo3KuHJrSVMScRHPb+3vfWk/6GAkzXCN6lmmSbP7mqJH5b4L6rylWWJH9gVK8U7WxKv3Q3a88BB9SHO3c39Oo60icHT6ulh4Q9pSO5Z+UXf5SAtLEbtnEFBEbqNbKUjQWvhiwTutSuJGt1PtZEGfArV5YYsu5D4MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA2PR10MB9037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:54:22 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.20.9723.022; Wed, 25 Mar 2026
 10:54:22 +0000
Message-ID: <a3c2849a-4102-49ca-9a8f-4213cb5ac936@siemens.com>
Date: Wed, 25 Mar 2026 11:54:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] chore: Add maintainer to all
 package recipes
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
References: <20260324123028.3459200-1-Quirin.Gylstorff@siemens.com>
 <d924c1e45eab6ab1ad9cd5a2d194c1a4ca8ff028.camel@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <d924c1e45eab6ab1ad9cd5a2d194c1a4ca8ff028.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA2PR10MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: e2590eb1-0006-4cb8-c159-08de8a5cdef7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	XfigF+7mrK4DVMtnf6y+3i5h3HxC6q93jKN/ZwndCjHQp1taQIQfLCwIdaiNfQZ9bk/eG+8cIpTWfB7OTvrEsTuECtBO/X14nphYwzFYN37bPEb2MGDPgRqMy51TRNHGEVaDTS68/sl4xrGYz46ClAOBJI9MVV20oR5nSpXg1Q2NVviAxWbhCX/cjAdHBnV/hm0rD8JrlAX7tyBIlwaa5xVn4c0RzoHbt+RpsUdpGG+YtezMFR7o5bENiibyvs5SYoa+00mdVvnq7YtR34DCV7jSxySQc/Y+fETNtIFqUS2e9HYArRBaJTW5ZiobkuuM62/giAXaiGgqfacxKPXBFfzeFVm2FIzIucTfVCFc5NyjZuLstU7iJ2dd6PVGRGZET1eeRj2EivfqlYZ+t4ivQLsf+53HPXuZxIl9Lo6f7o7p4VUqmfi+oG8KbcrbYqWez7PoGI/M51uaSqYloG62Kl5q8gFVRjyVcADwev9HzqH8dN8Xm6BkQpkSc5Wau3KKR1qv4uNjPIOL5OhSdj67KmEfYkTlwwtsKnyGD8P8T+LVWKeXFcc4XkVMv7jpD4FvHwzbrhQli1kq9ojkthBhQ3zYvRwdqkZfu4RrEOjYCrjgCJ0d7uOczKJOzwa5+bruKYYDM/kt74fKAcla4wMPBLgrESUi9Dth+3eNgaJeyHnDuXLzpK2z/Q5btZQrk/VJAforcZMhG6HmxUnIr74DrA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVAxNFY0Q0xyb1ovMnU3cTg0YU51T05mbnFTSU9kMUF3bDBxTHVmcHlvTXFS?=
 =?utf-8?B?V2Rmbk1XaHpxeTVKYllLbitabXhiMEhIMGhVcjdTODJ4VVNMNXBiSktmT2Vo?=
 =?utf-8?B?VGtCUzdxSmVjWTdZRkorcFhPbHAvS2hBdnJvbkU2WVUvWnNKN3h1NjhXdU9k?=
 =?utf-8?B?QnNFYXhkT2MzdmphNjY1WTNOYzduTDhMMVRjcTBEaVBRZVltSlJDNllXUnR0?=
 =?utf-8?B?M1dPQW9KejNYS0RDT3ZyelBhSWgwMjhNUjFrekpxR09mZno1TjM5cUYrbGEr?=
 =?utf-8?B?c0lOMWIvclY0Y0dqblBablBVeGgycDJqYkJNS2M1bGhtYzhhQVF2d2w5MXJa?=
 =?utf-8?B?WDdoRzd3czAxMll3V2FxeEFHMy96RFJxZmloaEhNRUFhYWxGVDI1aHJxVmd4?=
 =?utf-8?B?QndPdVYzOXlpeHhoc09lRnRTK2pNR1dSS0NHcnVsVEFUdHExalZNcGFUeTYr?=
 =?utf-8?B?K09GM0RRNEFRUDVGRXI3ZUJoTkZZdEdQbVdacXBnY1ErNzJ1NUZDdEVKbmFl?=
 =?utf-8?B?WTRpYlBseDAwVXBNNWozOGJiR01SOHBvZnlub2RYK1cvOVE5QzJ5SlVZVkVj?=
 =?utf-8?B?NldOQjNNc1pqLzZaNURiVG0rY1cwQlNTMXN5WU1XbU5RYUIwbHA5a1Y5QkhP?=
 =?utf-8?B?VU1Bcnp6Q3FJbEx3emw3dGo3dmZsK0lGRUZhR1VEZ0NOQ3JkU0NrelNTRHdJ?=
 =?utf-8?B?OVV6ekNLcURyNiszSGkrT0VOaENEVTNGanVWWEZCZ3J2YzdwTld4YmYvL2tD?=
 =?utf-8?B?RlZwcjFzbVJEd3lFYzZwa1llVEJiUitBdkdjNzIrdHBONzJ5MUd1SXc4TWZK?=
 =?utf-8?B?Rnk3WkpTWlhETFhPelNnTmVWSWlUTHZIV3pCLy94b2pkbElBVGVXWVpEMUU2?=
 =?utf-8?B?YmROQlRxYmRFTGwrRXBHeEY4c1A5WVJoUHJ4Q0JFc1QzdHdicDBJaGt5YnlU?=
 =?utf-8?B?OHVhaUkrSi8rbGVNUWR2UERva2lUcVlRbWNxeFIzUUpXNlRmWEVyOTJmL25v?=
 =?utf-8?B?a2pab0JhUDdqQ29KbGczMlZxV3VVdEdBMUxySzhXV3doTVVYM1NkWTNCa2ov?=
 =?utf-8?B?ZEpOK2FvWCtweVBwaEdKSGRhOWhEU1RMT1ZML2F5NXZtc01pdlRjcEpLaVgx?=
 =?utf-8?B?NHZGQnNoMnFVR0R2MHU1N0tTWDVKemw4VWh6eXlLQlAxVXd6MkY5R0RISEFB?=
 =?utf-8?B?M001UW1ZOTMyblRWbmorLzVJK3hSdm5iZlRCMXoveUFLN0tJVWZZNnBtU08r?=
 =?utf-8?B?TDlITlNQbjdGUEtUQVhtTWluYU5sT3dCWGQ4K0JwVTB2WHI4dHArSXRONzFT?=
 =?utf-8?B?KzFlc0MvZzNwSGIzL1RsaFVqV3g1eldpWGplV2IyWHpYdThiZFlyZGdVb29v?=
 =?utf-8?B?a2V5UEU1MUdoelBHY3A3bno4RU9BNWVmZ2Y5ZnVuOWtrZE50MEtUa1JKNEZr?=
 =?utf-8?B?Mk9VSGFHcmJOWHpJb1lJcjRseEt6UkZ4Q2U2U0xQeGMrU3BqSkMreENnd283?=
 =?utf-8?B?c3k2V29XQW5nUmk0d3lHUDdxMyt3SnRrdGx3dFdkSTIvOG80Z1JURWExVk9p?=
 =?utf-8?B?WmJqbktkUENGZFhmTjQ5amdNZDNxeVZFWTZWNEdPSEZUWXZhZk8xT2k4OG9B?=
 =?utf-8?B?dWpZdGVCTFBOQlVzc05NNy91UTE2K1ViSXFoUWIrK2tTSHZDS0xCMS9BTTN1?=
 =?utf-8?B?dkNxSzBWRFYrakIrcDIya1VYL0kzcXRqekRqbmJrNExZTzE2clNSK3FlQXcy?=
 =?utf-8?B?dFlseExhcGVjZGdvQVdzOWx1MjArWUkyZHpkL3gxdCt2emF5YzFkQnJ6Y2Nq?=
 =?utf-8?B?c1UyUS92YmFFQjZoc09rNUpFVTMvTFFvWU4ya21mQXJjVkhuaWZwOGx4QmpX?=
 =?utf-8?B?UkNrNlZpMXhMcklGQVo2N0hIaDVqNE9TbXBvZ2x6TFhOOCsrRWxDendCWC9O?=
 =?utf-8?B?U1oyZ01zcitOc0NOYTBrR3F1NDVsd0xaYWgvanFYdlNWSUlKZkJxYnNYWTZ5?=
 =?utf-8?B?Qmk0NTlSeStrUzQwcjBBZFpmWXYrdVNySHVPamsydDh1QWRCNkxBWnhVM1Jl?=
 =?utf-8?B?MitPWGpobGRlOVZManQvL3ZuT1FULzRYS0dRdGd0Smx1d3FwU0VsVUQ3RnM4?=
 =?utf-8?B?ZWhIRHpwTy8zOGlwNHQ1c3EzQ2hNOU9FdXlOd0hOT0VHMytZRlU3V21sSERI?=
 =?utf-8?B?QTE1T2pwTWxRcjhHK3VXU0p4L2pOZDJqZmVyeDZkRU9oejhHNE44S2pDTVV0?=
 =?utf-8?B?amV6SmptZm52Mm1qejNFdEJMWDVoL09UWENXR0tiRSsyc2VTanEzRlhjUUZP?=
 =?utf-8?B?WS9OZXcwWlo3ZU8veEZEd3AxYTF5V2J6VHVsZlhMR0lwUWVJVmk0N0xhZndL?=
 =?utf-8?Q?3GzqghaPxv8qJbZI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2590eb1-0006-4cb8-c159-08de8a5cdef7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:54:22.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maxI9brrFJq77dVVxRv5LNN+cNcSPUmFp2gYe+TbMizIlNaOrZNp7Mf6DKXiqRxuRI+rQuayMs9M/3k4UAvUWCZz7L8u4YwCkaTzH0vEC58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9037
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 10:54:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22563



On 3/24/26 1:47 PM, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Tue, 2026-03-24 at 13:29 +0100, Quirin Gylstorff via lists.cip-
> project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This avoids the warning introduced with https://github.com/ilbers/isar/commit/712a62478d0ad34b7364f2892f485b7a014610c9
>> ```
>> WARNING:  do_prepare_build: MAINTAINER contains '@example.com'. Please set a valid maintainer.
> 
> Thanks!
> 
> While we are at it: I noticed that we also have many packages with a
> default DESCRIPTION ("must not be empty"). Can you please fix these as
> well.
> 
> To easily find them, generate the SBOM and check the "summary" for the
> string "must not be empty".

I will sent that in seperate patch.

Quirin
> 
> Felix
> 
>> ```
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../hss-payload-generator/hss-payload-generator_2025.07.bb      | 2 ++
>>   recipes-core/change-root-homedir/change-root-homedir_0.2.bb     | 2 ++
>>   recipes-core/customizations/common.inc                          | 2 ++
>>   recipes-core/home-fs/home-fs_0.1.bb                             | 2 ++
>>   recipes-core/journald-config/journald-config_0.1.bb             | 2 ++
>>   recipes-core/kernel-panic/kernel-panic.bb                       | 2 ++
>>   recipes-core/ltp/ltp.inc                                        | 2 ++
>>   recipes-core/move-homedir-var/move-homedir-var_0.1.bb           | 2 ++
>>   recipes-core/security-customizations/security-customizations.bb | 2 ++
>>   recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb     | 2 ++
>>   recipes-core/swupdate-config/swupdate-config_0.2.bb             | 2 ++
>>   .../swupdate-handler-roundrobin_0.1.bb                          | 2 ++
>>   recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb          | 2 ++
>>   recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb            | 2 ++
>>   recipes-core/swupdate/swupdate_2023.12.bb                       | 2 ++
>>   recipes-core/tmp-fs/tmp-fs_0.2.bb                               | 2 ++
>>   recipes-devtools/dosfstools/dosfstools_latest.bb                | 2 ++
>>   .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb        | 2 ++
>>   recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc    | 2 ++
>>   .../swupdate-certificates/swupdate-certificates-key.inc         | 2 ++
>>   .../swupdate-certificates/swupdate-certificates.inc             | 2 ++
>>   recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb     | 2 ++
>>   recipes-devtools/swupdate-signer/swupdate-signer-empty.bb       | 2 ++
>>   .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb      | 2 ++
>>   .../initramfs-cip-functions/initramfs-cip-functions_0.1.bb      | 2 ++
>>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb           | 2 ++
>>   .../initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb            | 2 ++
>>   .../initramfs-factory-reset-hook_0.3.bb                         | 2 ++
>>   .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb        | 2 ++
>>   .../initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb      | 2 ++
>>   .../initramfs-verity-hook/initramfs-verity-hook_0.3.bb          | 2 ++
>>   recipes-python/shtab/python-shtab_1.5.5-4.bb                    | 2 ++
>>   recipes-security/fail2ban-config/fail2ban-config.bb             | 2 ++
>>   recipes-support/factory-reset-helper/factory-reset-helper.inc   | 2 ++
>>   34 files changed, 68 insertions(+)
>>
>> diff --git a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
>> index fa86094..cfb821f 100644
>> --- a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
>> +++ b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   SRC_URI = " \
>>       https://github.com/polarfire-soc/hart-software-services/archive/refs/tags/v${PV}.tar.gz;downloadfilename=hart-software-services-v${PV}.tar.gz \
>>       file://rules"
>> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>> index a0725c1..702e518 100644
>> --- a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>>   
>>   SRC_URI = "file://postinst"
>> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
>> index c4d201f..81a36ed 100644
>> --- a/recipes-core/customizations/common.inc
>> +++ b/recipes-core/customizations/common.inc
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   FILESPATH:append := ":${FILE_DIRNAME}/files"
>>   
>>   SRC_URI = " \
>> diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/home-fs_0.1.bb
>> index fb9e351..fd88f21 100644
>> --- a/recipes-core/home-fs/home-fs_0.1.bb
>> +++ b/recipes-core/home-fs/home-fs_0.1.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   SRC_URI = "file://postinst \
>>              file://home.mount"
>>   
>> diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-core/journald-config/journald-config_0.1.bb
>> index 00dbfce..62fc0c7 100644
>> --- a/recipes-core/journald-config/journald-config_0.1.bb
>> +++ b/recipes-core/journald-config/journald-config_0.1.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   SRC_URI = "file://persistent-journal.conf"
>>   
>>   do_install[cleandirs] = "${D}/usr/lib/systemd/journald.conf.d/"
>> diff --git a/recipes-core/kernel-panic/kernel-panic.bb b/recipes-core/kernel-panic/kernel-panic.bb
>> index 511febb..22a4dde 100644
>> --- a/recipes-core/kernel-panic/kernel-panic.bb
>> +++ b/recipes-core/kernel-panic/kernel-panic.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "Systemd service file to cause kernel panic"
>>   
>>   SRC_URI = " \
>> diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
>> index 27e26a0..4d524f1 100644
>> --- a/recipes-core/ltp/ltp.inc
>> +++ b/recipes-core/ltp/ltp.inc
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "Linux Test project for CIP"
>>   
>>   SRC_URI = " \
>> diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
>> index 608bb69..54e807a 100644
>> --- a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
>> +++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DEBIAN_CONFLICTS = "home-fs"
>>   SRC_URI = "file://${BPN}.tmpfiles.tmpl"
>>   
>> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
>> index d8fa22b..382f0c8 100644
>> --- a/recipes-core/security-customizations/security-customizations.bb
>> +++ b/recipes-core/security-customizations/security-customizations.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "CIP Security configuration for IEC62443-4-2 evaluation"
>>   
>>   SRC_URI = "file://postinst \
>> diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
>> index 3569888..c800c84 100644
>> --- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
>> +++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   PROVIDES := "${PN}"
>>   DEBIAN_PROVIDES := "${PN}"
>>   
>> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
>> index 63fa320..cdfd8b9 100644
>> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
>> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   PROVIDES := "${PN}"
>>   DEBIAN_PROVIDES := "${PN}"
>>   
>> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> index 59ac49e..2ba192c 100644
>> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   PROVIDES = "swupdate-handlers"
>>   
>>   SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> index 035887e..1ab14c4 100644
>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-gbp
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   require swupdate.inc
>>   
>>   DEB_BUILD_PROFILES += "nodoc"
>> diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>> index 3a73c89..6193027 100644
>> --- a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>> +++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   require swupdate.inc
>>   
>>   DEPENDS += "libebgenv-dev"
>> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
>> index 6822153..5dd7c27 100644
>> --- a/recipes-core/swupdate/swupdate_2023.12.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   require swupdate.inc
>>   
>>   DEPENDS += "libebgenv-dev"
>> diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs_0.2.bb
>> index bb5fcce..f2b7976 100644
>> --- a/recipes-core/tmp-fs/tmp-fs_0.2.bb
>> +++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   SRC_URI = "file://postinst"
>>   
>>   do_install() {
>> diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
>> index 37a8f42..d0ac128 100644
>> --- a/recipes-devtools/dosfstools/dosfstools_latest.bb
>> +++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   CHANGELOG_V="<orig-version>+cip"
>>   
>>   SRC_URI = "apt://${BPN}"
>> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
>> index 57ad1be..6963d09 100644
>> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
>> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
>> @@ -12,6 +12,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "Signing script for EFI Boot Guard setups"
>>   
>>   DEPENDS = "secure-boot-secrets"
>> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>> index 5277d9b..38b57ee 100644
>> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   PROVIDES += "secure-boot-secrets"
>>   DEBIAN_PROVIDES = "secure-boot-secrets"
>>   
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> index 2abb963..4124b31 100644
>> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>>   
>>   PROVIDES += "swupdate-certificates-key"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> index 344775d..3c59887 100644
>> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>>   
>>   PROVIDES += "swupdate-certificates"
>> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
>> index 44bbd0a..ee8d172 100644
>> --- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
>> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   PROVIDES = "swupdate-signer"
>>   DEBIAN_PROVIDES = "swupdate-signer"
>>   
>> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
>> index fde9cb4..af9de76 100644
>> --- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
>> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   PROVIDES = "swupdate-signer"
>>   DEBIAN_PROVIDES = "swupdate-signer"
>>   
>> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
>> index 3538bcf..48f6458 100644
>> --- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
>> +++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit initramfs-hook
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   RDEPENDS += "initramfs-cip-functions"
>>   DEBIAN_DEPENDS .= ", util-linux, initramfs-cip-functions"
>>   DEBIAN_CONFLICTS = "initramfs-verity-hook"
>> diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
>> index d497aa4..73ee68d 100644
>> --- a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
>> +++ b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "helper functions for cip initramfs-tools extensions"
>>   
>>   SRC_URI += "file://cip-initramfs-functions"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> index e132b9e..18a10a8 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit initramfs-hook
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   RDEPENDS += "initramfs-cip-functions"
>>   
>>   DEBIAN_DEPENDS .= ", \
>> diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
>> index e423248..2015503 100644
>> --- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
>> +++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
>> @@ -11,4 +11,6 @@
>>   
>>   inherit initramfs-hook
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   HOOK_ADD_MODULES = "erofs"
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> index 7dc04eb..e962a51 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
>> @@ -10,6 +10,8 @@
>>   
>>   inherit initramfs-hook
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "Delete the content of the given Devices"
>>   
>>   # list of partitions by label
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
>> index 4ec382c..57b26ec 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
>> @@ -12,6 +12,8 @@
>>   
>>   inherit initramfs-hook
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
>>   
>>   SRC_URI += " \
>> diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
>> index 1f5decc..9ff4cbf 100644
>> --- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
>> +++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
>> @@ -11,4 +11,6 @@
>>   
>>   inherit initramfs-hook
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   HOOK_ADD_MODULES = "squashfs"
>> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
>> index a0ee803..b2fb704 100644
>> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
>> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit initramfs-hook
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   SRC_URI += " \
>>       file://hook \
>>       file://local-top-complete.tmpl \
>> diff --git a/recipes-python/shtab/python-shtab_1.5.5-4.bb b/recipes-python/shtab/python-shtab_1.5.5-4.bb
>> index 7a5cfd2..8ccef35 100644
>> --- a/recipes-python/shtab/python-shtab_1.5.5-4.bb
>> +++ b/recipes-python/shtab/python-shtab_1.5.5-4.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit dpkg-gbp
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   SRC_URI += " \
>>       git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=https;branch=main \
>>       "
>> diff --git a/recipes-security/fail2ban-config/fail2ban-config.bb b/recipes-security/fail2ban-config/fail2ban-config.bb
>> index 87d1497..4900069 100644
>> --- a/recipes-security/fail2ban-config/fail2ban-config.bb
>> +++ b/recipes-security/fail2ban-config/fail2ban-config.bb
>> @@ -12,6 +12,8 @@ DESCRIPTION = "Basic fail2ban config with systemd as backend"
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   SRC_URI += "file://systemd-defaults.conf"
>>   
>>   DEBIAN_DEPENDS += "fail2ban, python3-systemd, python3-pyinotify"
>> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper.inc b/recipes-support/factory-reset-helper/factory-reset-helper.inc
>> index 56ac5b4..9e17daa 100644
>> --- a/recipes-support/factory-reset-helper/factory-reset-helper.inc
>> +++ b/recipes-support/factory-reset-helper/factory-reset-helper.inc
>> @@ -10,6 +10,8 @@
>>   
>>   inherit dpkg-raw
>>   
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>>   DESCRIPTION = "helper script to execute a factory reset"
>>   
>>   PROVIDES = "factory-reset-helper"
>> -- 
>> 2.53.0
> 


