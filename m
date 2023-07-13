Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DF6C0015E
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 17:33:32 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.61])
 by mx.groups.io with SMTP id smtpd.web11.3117.1689269608544158745
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 10:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IWsoifwh;
 spf=pass (domain: siemens.com, ip: 40.107.249.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxnyLtEUnsvg4m0trQpjvpE8qOH9yPhnGyiTdcC5QZe4mokie85J2j2v0UtwwzlLf4WHhbv+XEK2Y5SpdwfyPA95IoXwmoATIVa9SKKGH+lEzwyyW94CVWbBADA0J6WYCdEE2WqbM680CNlw4R/HHA9Omf2Xq5PxP2r7dcetCsZHUh5dotRAjeOZxAIKHNOq19V2W87YRNO3d8KC5rgmkAjhWKWS4qbz2PhgZLogTZuyOOr2xMa5fvjtrcp5q6EMCSrObSKxZepzTCDCgC6Yy+QsJ5ZSFmpHyJ5yDW2ELSgTx/BRLMSqO28XNlPPACTnk+A5luOhPQos4Rb5aY4wcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0W3Aaz9712S3U4P2MfNUMRtamFKfXhDHTxs0302qdw=;
 b=izcgj9ejiZN2tzv36m275ij9zAHHgfJaDabITpz/a+GCv/iSsi2IYufESfPsmUMZSRiyE5qXmpV+TwzA59wXK3bpFGQCW3lWO05TM4hoSi8tEfgz8zL295iq1LZeeRzpi3mvWT3ujMysg/OaBr/Q6Ma+msNe51dn/9bo/yHEm/HDVZBNSPfmqOJBYp+CJkDDoQeqnJLSjfxuX/g9iYyM89PWgu53HgPpQUf5q+ovskEtNxCFDZsb+x9UOehiXtPivE+QAyToFFJImwXoRXX6yyzvNryLphbRa5zSpZKN4WZulDCIVxFrk2zA/yzqqeYQsFr3b1KGw36agYFTalAptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0W3Aaz9712S3U4P2MfNUMRtamFKfXhDHTxs0302qdw=;
 b=IWsoifwhthotwSbT6MzCwcCy2BUXlYaIfv1q+eYYhoqULe2XGZl8umDvYV8NgW11OrEdYZVe4FKtagfby6K1zwz2C7AdiB6xt7B0wU6aYhTCsoquKJCARr9l550tKMEEUfhphZedDYxuTI276ekyo7diZhxn9EAVj2jd1z+k0wEmsZmTlljlDGRNMh+2vbpTy45yHTNvJOE+kQx+J+9k4uYXJDjaSkpSQzqaGtEoAr4ayIOyKg4oadyT/JFfHUWwZSXwuH0mP2SSHAt9ON4z5FcmbKdCXm+VFDhKvv5i/CFSMG9YIBC27UBXvbIUbccoLJe2Z8/C5PEr7jLGEzWwXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 17:33:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 17:32:40 +0000
Message-ID: <5b400f7b-4039-2fc8-5f84-2fe647ff8a3d@siemens.com>
Date: Thu, 13 Jul 2023 19:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core] security.yml: Add additional features to security
 image
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b7c9a9-9ace-45aa-5088-08db83c72833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JfejeJAjLUDgkiN00WceVaWImjZZRcB5g5Cxpdumv7x8J67GwzZqo85erP0T37vu4Piu33rSTOPy3ozFGWjwKzpKgJetQvBFePm9sARSoHHDejQ55sBllUZ0LpLk4boL8jqd4+IFuMfK7Ud1nyAx+MvdTGnTnhvdQSfw7yaEjdKPCxnz3Mcy4AAKgKcKNCblhPl23IxzUDlQ68fitn2UkJ3iQWeyTuqxZXsWcXUS0S8hLzLnMGxYdeoK4tKzPMjuCRuxjgCaFawXBBvkM45MQpmZXOlsdUEdHpW6r3qOwaT4NDLJlwaS4HGIvNQhH0n4dLo5DXdTA795iH3P34+ZsCGnQS1h83osetF4vLkhHdstY1xv2P0dqn/tMdO7V62isddryHwDDwcrU/XXMRgmphEMurFc0yJg1IzDph9hzaDPlLSIlTYQM975Ve5zMdc/RdftGBY2HRxY8T4mpKiucZz6TCDwyVHOMMSR/3UI56Qxqnc2xfPMYrYq66bDSuk35TVD02opDT9J6IJxnAVRfmfTvIGAHpcWmjh0jC32qc4HItQxb/wWdqipejqSaZca/3VET/wLuYb9SCxu1QcDFT4zGBJ3j/8+USlLikSRbGtlu7o2y5jB8VZ7HNY0DxuNXN0Un9Q1Y5f7VqIxGoRo8Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(316002)(6666004)(186003)(31686004)(41300700001)(478600001)(4326008)(6486002)(66946007)(66556008)(66476007)(6512007)(8936002)(8676002)(53546011)(31696002)(6506007)(44832011)(5660300002)(15650500001)(83380400001)(86362001)(2616005)(2906002)(36756003)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXAyS3QzOFVuaDZteHNqVFNGZS9MRGYrSTRRVXRmV3ZzNmI3Mk96K3ZUOCtR?=
 =?utf-8?B?Mm1PT3YxcmZrU3FmUjRXMVNiYWNvTVFsT3FCNm4yVERwOHBtdGF1Qk5hYVk0?=
 =?utf-8?B?Mi9oZHFLSWx6ME9KcUdBRjlxcnQvaEg1VlFLejVVMll3WkpOZEZuMlVZNDM4?=
 =?utf-8?B?dCtWQ2V5TEo3NGx0MyswVmlFV2ROMmRWak1oL2l6NzhHSjRLT0k4aVdPY2t5?=
 =?utf-8?B?anJjOUF0OFFMM1dRb2RHNnNaZlk3dGllZGprdFVwTlAxWDBLTjV1d2dXOFI0?=
 =?utf-8?B?ZUkrRDRHOE5MRUNkR1B5U1NFbFZOcnpFNVRJRTNReWhHelNscGZ5dkR3ZHFL?=
 =?utf-8?B?NHpwWW00K3FNMmQ2N3lwQzRNUkIrY3kwbDhrbzZSbmRLVVVpc0c4WVZvUmg1?=
 =?utf-8?B?WThEL3NTb3k2end0eisxR2liUSsrbjVuSkZsRUU3RVE0SkVNVlVNUmNpcGkv?=
 =?utf-8?B?WU1TcWpUK1NEbG1VTjk2OFlPeWNhU3E2WHVrVEh5eUIvY3hWR2pWdnhqemJS?=
 =?utf-8?B?NTlLeXlOdGM5NzlaZ09tYkphMkc4Y2NPRnFnYjB1OHduNUx0UC9USUpGL3d6?=
 =?utf-8?B?d3dlL2x0cHF0TVZIMHZUa01TaFptZnFZT0tTelJhYXR3cnpPRlBpUUFwWi85?=
 =?utf-8?B?SGIzWC9PZWhSaENZTW50WXZTbHJsOWNtMnNpR2FyaXhJYUxOYmZOSVp4ZWNa?=
 =?utf-8?B?ZTFIQTF3TER1WWJ2cUdIOWthUWd5bzQ3dDRpY3h4TGRWWUZFT2hnb3V5aGw5?=
 =?utf-8?B?SEJmZ2d3ZWJaZkliMC9zWlk0QTNkZDNoeDFJZnY2RDl3Q0VFWlFkUzluZU5H?=
 =?utf-8?B?NkxCRlMrSzJFOFUvZ1hNZklrT1NYbjdWNHllazR2N0NUU2tsWnlTbXorV0Vu?=
 =?utf-8?B?cHBSbHgwMGZkbnZXVGhjeHFuaGNaK044M3hOZmM1a3NpNDBUY2FnZlhORjdW?=
 =?utf-8?B?bTZ5QmF2YjlnZU1jVjhLMUI2bld6NjVoV3g4Y2JOZ2E3azJna085NUJhYWgw?=
 =?utf-8?B?R0JMM2RvY3VTRFE2N1duUENvbmYyY1g5Y05wVUtISXc5K0lIaVpZeW5BZ1Yv?=
 =?utf-8?B?UDVYV2Q1TysxajJEMCtoTDFPc3FLZk90YWc2blNZWmx1cHFjek1NUUVsaDJo?=
 =?utf-8?B?R215Q1dSUTF2aUR4WDlSS0VrN1BERzZNN2NXaytqaUV6eXRWV1AzSG85QzNR?=
 =?utf-8?B?Y29vMXRJUFkreEpIOUpENTNseWFpakF0MXdyU0JLQWxwaXVOdkdGUG5HNWZh?=
 =?utf-8?B?bXlNZThNdU5GTHJhVkJvQm9UVW90YXlIanhCUGJwSFM3a2drMHYzT0xkQ1Vj?=
 =?utf-8?B?ZUhKOTYwTVJ2ZkhMUXF5b3FpZXlWdE1RSnF5UmprRkFyTnBDUzVxVjBiSndh?=
 =?utf-8?B?ZkxuS2sxSWNxSU9FVDdhOGdTRW9WdEdvZ084bnZ1cW93N3g5WTdIeDkwWHIw?=
 =?utf-8?B?OGlZUWF3L3JieWMwb2MzS0FTVDl2elFYTFNIOEVGMFlDWkxDR0tUMW96Rkps?=
 =?utf-8?B?aTcwNDFYelFHMHBtcnlJNDBvTEJHQi81TElxZ0szTlA0cGhSNklhSWpENnN4?=
 =?utf-8?B?MmE3d3RIbHVCWWZLcUYrWUVjV1V3V041a2kzbGdsb2l2V3JlRGs0ZWxONUVq?=
 =?utf-8?B?eG9MWElaVnhHZ0tOcHZydGQyNjRVZnREYkt0V0lkckVPbTdOb2QyRVd3Z243?=
 =?utf-8?B?WmJsTnlMZ2M5Z3RVUFI1ZzBtUnQwUkVnWWFxOFRWcXdqVFdUM2srQmxlOVk3?=
 =?utf-8?B?bmovcjlycG8zbW5xYUYzYTlJQzJ4a215UnA4YmoxSG80dEFIWlJ6ZnZVYlNY?=
 =?utf-8?B?Q0dONC83UkoxU2J5OHRDdC9MbTg1K281Zi9KNHdvcmxPZy9JY1FiM01wM3Yv?=
 =?utf-8?B?Y0lWKzBrQitJSjZWNmxNZHFXa0hoMjJKV2l3RXdJQ0svcExONlBrMFcyWFI3?=
 =?utf-8?B?YjBxTjNWaGJ5aGJmUVFXYXBEc0hGSnZ1V3V2RUtJZ3pwbzcwYkJweUxlWHh2?=
 =?utf-8?B?dXRyYnV6MjhWeFJJMWJBd0cvS1dGTXVMd2p6RDBhcEtNY3FqbzdlY205blZh?=
 =?utf-8?B?NEFxR3JHUGlSdU9GclVKVkNKNlJPZEdRdzA5bS9iUW9hNjNmL29tTmk4MEc0?=
 =?utf-8?B?c205UW1nYXpOcXUvQ25RTE02T3ZtZGJBZ0JlSXJvVmZUZGExUVhpTDAxRnRF?=
 =?utf-8?B?RGxBQldyZDR4dm0yQUlRZ2dRV05PTy9Sdy9RaTN5MlQzUDc3UTBndkIxT0Qv?=
 =?utf-8?B?MWxiU0I2aDVta2ZhZm4xaThPTWVRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b7c9a9-9ace-45aa-5088-08db83c72833
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 17:32:40.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmz1hx1wDkWJs4PalXkuk5s04ClRk8+h3dkHKN/qFBHWryErCPisMxFlCzYSlg0nTH/BVxM5Qx7On7SVnBH74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 17:33:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12340

On 12.07.23 13:31, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> From IEC certification perspective, a security image is needed which has the below features along with security customizations.
> 1. Data encryption (CR4.1)
> 2. Secure boot (EDR 3.14)
> 3. SWupdate (NDR 3.10)
> 
> The config.yaml will not have the extra enabled features as true. Hence they
> should be passed in the image run command.
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README.security-testing.md | 2 +-
>  kas/opt/security.yml           | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
> index c9540be..97000da 100644
> --- a/doc/README.security-testing.md
> +++ b/doc/README.security-testing.md
> @@ -33,7 +33,7 @@ Save & Build
>  ```
>  # Boot the Linux image
>  ```
> -host$ ./start-qemu.sh x86
> +host$ SECURE_BOOT="true" TPM2_ENCRYPTION="true" ./start-qemu.sh x86
>  ```
>  
>  # Copy security tests in to the Linux image
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index 1f3745b..b21f330 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -10,6 +10,9 @@
>  #
>  header:
>    version: 12
> +  includes:
> +    - kas/opt/encrypt-partitions.yml
> +    - kas/opt/ebg-secure-boot-snakeoil.yml
>  
>  target: cip-core-image-security
>  

Thanks, still applied for the release.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


