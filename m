Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037EC2BA18
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 04:38:50 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.71])
 by mx.groups.io with SMTP id smtpd.web11.78363.1718685526830297215
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 21:38:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a92BivSs;
 spf=pass (domain: siemens.com, ip: 40.107.13.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBzumro/ZWB1Ujl8onObgkJhXqz0xBVig6iQmJA0ykYmJCXW4z8S83wPLErfZj/ooJZM4fpsCT1QnZGs3PsO4hw1RiFg09roWhUb7zMe38UufdjHKCSTHHyc+A97y+Rdu9WTOtRWs3bc6oUaJo9tzgQQo+coFWs3Icpyfocq/OSAgXcE+/VJpi86nAz/jTZTHdnCygn7+qApArwTso/ART8oF7/+ut4X6CoPiIikWt8qSEd8WkdkR9CXiJzfm7rcvztm7rNy8lu50juay6YRh9XR+1WXjmU7IkeEhWSlXGPv50ga9/I9r8NO4OLu0odk2S7pPls3KrasTI8sBEXRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGwxFJBxSvuJHokRtNQl285TbZeu2d7CKC8kjsgx5qs=;
 b=TQHQ2j5Yeqbx+Sblnpk5ASUU1zFgzj2INuMiNv4bh/ysckNfZREWprDdfyUd0OOA3wOeLirK2uXud0DOWV9ZCnrzwCaJw+dBbO267vpMaZq49bXOZH/S6+x8W6UHtQgE8gIFPdSCB00kZIcImYAThuppR1039Wn15c1K2cd/3TM+4lGWXmqiVUI458+FGK38wyhUK7QDmWf89KtpAZw/CyFVzshbi76/wp9UGFwBY55qKm2nuRrSzhI32NUHVtKjdtCqtBCFvm92AeI4hW7id5xasqCxz6wwFqkNqyw49PuOxBi9G6qul+rOiCKGkKi/z1QtdQ4X/D8emHv0U0uOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGwxFJBxSvuJHokRtNQl285TbZeu2d7CKC8kjsgx5qs=;
 b=a92BivSsXsPy5GdcHmUGBQ2g93jm8gjHwjrHaWlT8jXy6iiyQeU1nZiXoxQ6hMROYzSmxTPyCQCZ6vzDP/gk53ja1O5GljfW8nIGUXJ9Dq4xnaW6Cnh7JynmoWGc1tqXo1RnYZhKhNo5nu5wYngUkWbJDqkV8Pb6MKrjOvMzmHdw19c6nmQexriFpRXldT+rX0u3fv69D+tfstsEz0/zjlZzv7TsvmMfLt7k5N6dl0vOtfwsRZU4dnlCjOF4lv2V0Ny5FtjHrq0WUSOJzPSMpZKrGMx6kYGVEYM0gmR6uejli2Hul7d582SDtbXSBDay7cyfVLDW5WELseLr23Z7yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6397.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 04:38:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 04:38:43 +0000
Message-ID: <2116c973-6101-4be4-923d-6f143ee6ad7b@siemens.com>
Date: Tue, 18 Jun 2024 06:38:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 1/3] .gitlab-ci.yml: Break current test jobs to
 run one LAVA job per Gitlab job
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240617182147.1724078-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240617182147.1724078-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240617182147.1724078-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd0fcec-526b-4fb9-36e9-08dc8f50888b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OG9pcWpPOERaT2RwZ0IrcU1iaGtFQXRyVFF3VEJ5V0hFdUIwejZTdk4vOFdh?=
 =?utf-8?B?OFBkQnROaG1ldXpyMXBJdGZrUFkxOXllcmxLTmhLZVNqaldDVG9BWjgyQzRw?=
 =?utf-8?B?eFNXUThtVXdOajZWOU8wNUVTQjJKWENQS3gyYU9aMitwUmV1bHdXMlVoSTdU?=
 =?utf-8?B?bGxmWFBDWVFvc1M5a2VpTDJsc3BRdGlZcXlqK3N1UGZpZks1R0FaQ1BuTmZl?=
 =?utf-8?B?MFc3bjhDM1RQTXZXeXhqY2xORko4TENDaHUvSjMrV0RHcFJYK3dFT1Q3Zyty?=
 =?utf-8?B?U3pNLy9hblhneWlaVnh6cnZEdCtzTnJlNWVWR3Zlb1lrV2hvUnBzTy9DTWly?=
 =?utf-8?B?dzFHdjhPUjVic2pxUHVldmM1YjNqR1A5eVlia1VOM3ZIZE5ScTFva3FNWmtk?=
 =?utf-8?B?dXNxMGtTeUNSK2FJSmNQOXN5U0VLVTFQUFVMVkFIWFhkbkJWcEhocENCbC9j?=
 =?utf-8?B?Wmorc3JTS1lUejdwdkJTd0d5VnJvNDVlQm9OS082dXJ3dVV3VlBzZFY2NWJV?=
 =?utf-8?B?U3R2MFhwMXQySGtpVisvTzF2S09SVk5ONDRWVGlRTFVKQzdBVERMQVRzOVk5?=
 =?utf-8?B?c0pMdXB3NXRsNE9VNFgwZHROSmJyeXJLZXZrUXE0UGVWd1dmbjMyZnQ5eTU3?=
 =?utf-8?B?TnQ0YllFdnNVU3B0S0ZqbjRFWHpWK2owU3JKNVlxRlFLL3B6dmVlYWx5VjJC?=
 =?utf-8?B?RlVpYkNwQ3RFc0w3Ry9hRmMyUm9FWWpEelBPUTBGRStSZ29FVnVMRlo0d2l1?=
 =?utf-8?B?SStjczVSckVYWlpKaDl4UHRES3VLdGdteHRQenBDQTlnZmYzTHZ0a0ZFZ0xs?=
 =?utf-8?B?T0UxZDdmQkxVL1RIMys0RDFHMFZQQXZWWnRrdW81bTBrNG4xSTJSNmU1bjUv?=
 =?utf-8?B?UTc1NmlPVEdkclNjZllhZ1FZM3NZR0MxaXoxNjg4RnM0bEpKcU84aVJiUjdq?=
 =?utf-8?B?TjhRNDVvMTUxSGFXVTkwSU54b0IrR0d5MWFUckVKZlI1ZkRsY0VKajNFUXky?=
 =?utf-8?B?WEZWR2JMSGdXcGZJdHQyQWtWcTdKSHdYNVJCRG8xS05XTHE1RVYvN1pCWWht?=
 =?utf-8?B?ZnEvOHBsNnJNTjlWbVQyMmNReTErRWVyblZkYkcrb3c4cHprNVlIZG53UG5Y?=
 =?utf-8?B?SGhPdzEyNU10MUoyVmhlVHp4SStsVytPS2x5NDBMcTl5MXdzNS9vcjJGVXc1?=
 =?utf-8?B?SUhxd09MNzFCOVFjb2ZEdzR5RnNXNUwrWHdvMWg1dHV2akhpbzU4bFhCc1Bj?=
 =?utf-8?B?YU1mUFZkYm8xN2lKYTNFYU5uRmZXT3duUFlWaGJ3eU5XTW5DdVlWMFJTOFpD?=
 =?utf-8?B?Wm8vT1hxd1grTWxDTjFvclBYOTdWa1dOVFUwYjUxTitiSlhjZFQ0YVV0VmVp?=
 =?utf-8?B?V01MQXczUGZ0a3NkS3YvY3dMTGo4bkxxd05yTDkreG1pUm94RnhZWjNCajhj?=
 =?utf-8?B?dGJtd051RDZtN1Mydkg3eHFIZnREbm5oZEVwQkowNGdjZXRJTmRwZDE3d2dw?=
 =?utf-8?B?NWs0WXlqcGNtRit5cS83TkdoelY3dDRKV1doNWtpUjZ0cDVjSWI5UlZaV285?=
 =?utf-8?B?OFd0MGxnREgzQU1qeUF0d1RveFhKYWRiemIwTDhPM01XV1lMYWZ6Y2s0RUM3?=
 =?utf-8?B?S2VTYmF6a2orVG5aNmdFYjRGejdWRWpoWnRuKy9DeE5XNVVlS0tPazBrTDFJ?=
 =?utf-8?B?aUw0ZG1BcFE1MFVsYS92c0ptVklRUEZSZVVYWmppSXl5L2VCR2p6QWNlSitr?=
 =?utf-8?Q?E6W+j/IFImwoYs3ukX8FhMw1FG/6jExPLZcw6qq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzBId0dyMHVodk03eUpKU1lpeE1jdUw5ZmthRjFrZkJvb3FmbUdZVy9Gbnpn?=
 =?utf-8?B?N3BmMjJCMWtibEg0K1hEbGkxT3ZMdXZjUHZUNHV2b1BpbngxMzdnSFRsaVMy?=
 =?utf-8?B?ZUZxZ3BBNXpLVXEwM2Q2YS9YdkNXMU82Z2liZ1FHUHZRWjd1V1d1UWV1ci9m?=
 =?utf-8?B?clZBd05GbG1uUEJjdUlQQTREc0kvZXBNRVlaUlozbHNEaDVaWnh0VG5sOUNi?=
 =?utf-8?B?Y05CdURDSHN2SUFwRGlTeUhHVlpyaGs5NlJsbmcwOWZ2aWcwUTBSQTkwa2xh?=
 =?utf-8?B?Qi9lMHBKUXd1YnlsSUFhRUxqQzF1cXFaMVhEbE9uY3JXcUs0TFdCWURTNE5U?=
 =?utf-8?B?MUZFRGFGTDJiSTBqZkc5N3JnaCtZbkN5akJhb2E1TTA0U0wrNVRIWFBub0ZR?=
 =?utf-8?B?UDVnMFpTdFZNU0F4dkZOMWxKZkxSMFFFWUlNN1djQmMrUVd3TWpvNkhxNXpN?=
 =?utf-8?B?RVJTWGhHbTdjS2lBV0hsOSs5bm5NcGEvV1BMNHlwamlMZytFeGVveHVIUmV4?=
 =?utf-8?B?QlgwWHNOWjdiNHAxOURES0NhY0VZbWNZR0FER0ZBcXFPVHl2aWVtVmNzY0Rr?=
 =?utf-8?B?RGxGMU5rcmtqY2VoRUVhOSs4c3BBaUhRK2NFcnU3cDZKZlVHMnorMDI3cHhF?=
 =?utf-8?B?SjRXdkhzcHZHc0Mwa3haTzhVOVVXSGhyZVZlcnFtdGFEaVZqTWkxU005SDJ2?=
 =?utf-8?B?V2swK2cxdzZma0dwRnhsMzNmcW9kNklXQmJDRlZEN1pMcnFaNWJxNTJaN2t2?=
 =?utf-8?B?NUpDdWMwOFJuMmhkSzRuVmJ1Z1p1NlJCQ2wrN291QjZ5NmJ4QitVeWxKWFV3?=
 =?utf-8?B?MXhDM05DYk9WQXIrY2pvVG5PcTl3WHB1TXZ0TzFMaTBmQk1VdGlDblJKTlpS?=
 =?utf-8?B?NzVsL3Q0ZFdpVmlqYVY1VmpMcHlmVVBNdnJEU2pKNlVWdFVEOXFNZWNNSTI1?=
 =?utf-8?B?Ull2aENhTGRTMUhyN05RZStrbmlkU0k1TUwvVzRxclpwQjhGekRjM0NLeWNB?=
 =?utf-8?B?YlRhOGZNYjRLeGYwVlJBeGwveFk4dEcrQmxwWGVWMC8xQ1BGR1pSRWUwb1FY?=
 =?utf-8?B?SHF1NWNPeHFlQ0FlamY5UjVhTUY0cHlyWGFnNHV0K05FRXJ1U1ZoektqeXRw?=
 =?utf-8?B?TzRFQ1NtN3Iyb2I4Q29WZEZFZ2FjV0IzZU9uLzlQTUg2Y1lZR1dyWURlcWNP?=
 =?utf-8?B?b1lMc3dzK2ZlajRXSXpFeDJDZVpWSmtReGRUbHJ0QUc1U2g2WW9lZzBhQ3hW?=
 =?utf-8?B?OTNQSnNQMytxMk1wSVY2d1NCeS9nRTFZckpEMnlaTjNFWW9na1ZDNmZQMTkz?=
 =?utf-8?B?RzB0ck9LWElpMzU2VFFKelBmcVJOU1dtalRnem5RQ1ZPWGRacW9oOEZ5SmdC?=
 =?utf-8?B?OGpNU3JFZ2tocFVyMTEyaFNLamlHeUNram14THkxTUpuZ1orTDVuMHoxQ3dJ?=
 =?utf-8?B?alpPOVZEQ002czVhdk1oQjVyNjVhRjc5NmwzdiswSUc1aHZBakdkeHZ3aEk4?=
 =?utf-8?B?M1hMN255K0NMc3Z5TWE1NU4vcHpkM1FGL1lEZ25EUFlDQmFUQmdVd1RFclBY?=
 =?utf-8?B?YVp2QW5tRklpblhnMmJESmRsdzdmMGJ2M2NhVWFDQ2lrNHdPVWEwVnJ6cHd3?=
 =?utf-8?B?SEIrNENucjdDY2pnRUorRTcxaVpoejFtVEoyMjFDY3hMaWllbzlZRHZCV2lz?=
 =?utf-8?B?VGpybmdIYVZkZE5TV2tFRVRKak4wMmpMd1RFdCtMZFJPeEtFUUFJbTJwVXlX?=
 =?utf-8?B?c0JZTXpnZ21Kb0U3UmcyWS95d1RxRkxhMC93bkxMSVR0ZERHMDFuejAveEdW?=
 =?utf-8?B?STB4ZDBsWXZraHhzY0Z0QVpLWlNZWWNJQjRFeTZhMDRvcENTN1pncFFXT0RO?=
 =?utf-8?B?UGl1eGlsNHM1aXRyaFJEU2JHTWF3T2hJeEJJaUE2eVBvTEc5ZFlneGtid0cr?=
 =?utf-8?B?dFlUMkpYbmJkZVdnVVYvdjFhdmNwVlBsbHVxS0lZUDF6QVJWWmhaTzdVWGlQ?=
 =?utf-8?B?aW96em5kU0w4UzA1Mkdhcm83TnZJaGViZ3M0dVh0SnlvTFVHcEVHZS8xZzdw?=
 =?utf-8?B?Uko0L0tiU29VSTU4VEl5S3NFRzhQYUoxM0s5eUR1YU02UHNpVUsyMEhiNm5t?=
 =?utf-8?B?MnB2YnNpOWJQTHRURkpkalRWZzVPNEZVd0MzNi9abU1EdThiTExqNjdGR0xh?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd0fcec-526b-4fb9-36e9-08dc8f50888b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 04:38:43.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4iHoKjbGvLafYNgJ3ZckW8QqAmWVmaIpq287edIfDnLft0MmmMxTHQ948U1X47vx0AZg7SjcWZTvzZ+pyFnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6397
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 04:38:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16270

On 17.06.24 20:21, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b3f1fc6..b567556 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -26,6 +26,7 @@ variables:
>    deploy_kernelci: disable
>    build_swu_v2: disable
>    swupdate_version: default
> +  test_function: swupdate
>  
>  stages:
>    - build
> @@ -355,6 +356,8 @@ build:qemu-riscv64:
>    tags:
>      - small
>    allow_failure: true
> +  script:
> +    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
>    artifacts:
>      name: "$CI_JOB_NAME"
>      when: always
> @@ -364,23 +367,82 @@ build:qemu-riscv64:
>      reports:
>        junit: results/results*.xml
>  
> -test-qemu-secure-boot:
> +test:qemu-amd64-secure-boot:
>    extends:
>      - .test-cip-core
> -  script:
> -    - scripts/submit_lava.sh secure-boot ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
> +  variables:
> +    target: qemu-amd64
> +    test_function: secure-boot
>  
> -test-qemu-swupdate:
> +test:qemu-arm64-secure-boot:
>    extends:
>      - .test-cip-core
> -  script:
> -    - scripts/submit_lava.sh swupdate ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
> +  variables:
> +    target: qemu-arm64
> +    test_function: secure-boot
> +
> +test:qemu-arm-secure-boot:
> +  extends:
> +    - .test-cip-core
> +  variables:
> +    target: qemu-arm
> +    test_function: secure-boot
> +
> +test:qemu-amd64-swupdate:
> +  extends:
> +    - .test-cip-core
> +  variables:
> +    target: qemu-amd64
> +    test_function: swupdate
> +
> +test:qemu-arm64-swupdate:
> +  extends:
> +    - .test-cip-core
> +  variables:
> +    target: qemu-arm64
> +    test_function: swupdate
> +
> +test:qemu-arm-swupdate:
> +  extends:
> +    - .test-cip-core
> +  variables:
> +    target: qemu-arm
> +    test_function: swupdate
> +
> +test:qemu-amd64-swupdate-kernel-panic:
> +  extends:
> +    - .test-cip-core
> +  variables:
> +    target: qemu-amd64
> +    test_function: kernel-panic
>  
> -test-qemu-IEC:
> +test:qemu-amd64-swupdate-initramfs-crash:
> +  extends:
> +    - .test-cip-core
> +  variables:
> +    target: qemu-amd64
> +    test_function: initramfs-crash
> +
> +test:qemu-amd64-IEC:
>    extends:
>     - .test-cip-core
> -  script:
> -    - scripts/submit_lava.sh IEC ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
> +  variables:
> +    target: qemu-amd64
> +    test_function: IEC
> +
> +test:qemu-arm64-IEC:
> +  extends:
> +   - .test-cip-core
> +  variables:
> +    target: qemu-arm64
> +    test_function: IEC
> +
> +test:qemu-arm-IEC:
> +  extends:
> +   - .test-cip-core
> +  variables:
> +    target: qemu-arm
> +    test_function: IEC
>  
>  cve-checks:
>    stage: cve-check

Does this work without patch 2? Or should both be folded together?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


