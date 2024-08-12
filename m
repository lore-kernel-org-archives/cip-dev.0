Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12086C3DA7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 08:20:13 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.66])
 by mx.groups.io with SMTP id smtpd.web11.41674.1723450805520822286
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 01:20:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TR5lCaln;
 spf=pass (domain: siemens.com, ip: 40.107.241.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/8Y1mlqZZdvmms5YttYkXqSn/vsHiwux1Zm3COsFZNwvzIHc5/jxXVphot8F219WrRG/lw02c+2BLraRdegXc8S1lNkNE5CaMm77I3vhVBL+Ma9mXuqtE1Ck4iKkDMqn+9DJmGcmw7c9+hUvqSi0zz533PHW1cjlmCWBzzmj1sh/AKJSPT371dW0JAkoOY52tZw74IfCZjBBNcVP9HFHh9eXbmcOxEDUmJqMPkg88yeLXUz71BD8q1zjNxWOYAw+LWpQajMT7HEk2BMh1hT+lLnef/h7U/6YhGSQR0Gfm2x4iAQOYjPKKHHhWlse9KKh+4PnpZ72OAdNu47XCQiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2pTF31E3IM2jOHCTLyh4CwIyTrlJwBSAHvUoFk6Sk4=;
 b=sX/AIqoFswqI5y82QYDgVcM5Bys7As+hBr5FncTHwq/b3CmxKBZLbtaxvPW0+pxL1Bz/WQ0rAlrpgnC/FndasgkRU1L17lttdOxANnGM9nD6mQ9UeOso4GaF0wDe67PFl+TPAyfcJrRjFr9RbTcxv3wDgGsYqTVpiVKFSTvG0z849JdQR0URHHRma95ghaE/+emG5bSWdHsBPDuxRVpiiFFKQHCWi0OfMoPBKEjsF6t0wxs0MpwyH+7heyoqWc2A9tNqrF/4gT/4O/rs6KGMBOVG4QM4OkFgTJvCjCJCWUkJaxTmDPr3JpDasDv2J9g4uRTh8NwGm+8GLWMWY5DpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2pTF31E3IM2jOHCTLyh4CwIyTrlJwBSAHvUoFk6Sk4=;
 b=TR5lCaln3DjI6kIGOCfFXERLhWDClJu3920g2B/6fmk8PATB8ij3ywJS9cFOFJr5pmWEvheUXQkUWFPOJCY/MSj6Ew3ucj/FAXMOP6dznF+RkmoiaYGAEuf1OPHEjhVsIyqveaVVBUAMep1Nfaijy6/aI9TdNXrDFglU5pNJJfIGydBQ2nvm3GnfzHT/pmcEy+yiCilNpxL+W0j+v0EHoDiYPCMuQCKgCMiXLT4MpNfDRrOqfLFG+S3kCx5+AElvoa7n3Yl1YxRfeSYfEAiqnSlRDvXrx79W6yh2EI0cNA9qv36G9kanKLawGogjTWt7jeQwPgIUzp1lV1kaJdVIBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:473::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 08:20:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:20:01 +0000
Message-ID: <4b675efb-9cb9-40b5-8b0d-adcf534578d3@siemens.com>
Date: Mon, 12 Aug 2024 10:19:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 3/3] .gitlab-ci.yml: Update debian-cve-checker
 image reference and runner tag
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240812070303.1206167-4-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240812070303.1206167-4-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d724a7-4e66-4101-9bb1-08dcbaa78fd7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZGx5dFNDMXp3YUVEcitQOGRobFpGQkJON2VRWHJ6cXlWUkRTNytWbkw2WEpq?=
 =?utf-8?B?aTFzQUd2RzJVRmpDVjVhUVNnNE90K3JBb3kvYzg1dHQzcUtSZlE5YnlnOFc4?=
 =?utf-8?B?ek1HUVk4NDhLcVhrcW5zYXZJMGtRUUowRWVNdG4vUHlpdmZ1NTc5d1p2ZkhJ?=
 =?utf-8?B?TmNGMGx1SFduaURxcFRlZmMrVmJKUUFuN2h1TzF1dkxhWXlxN2EvY1hoSjBS?=
 =?utf-8?B?OGkrcW13RUpnTXZxRjQ0WDQ5aXRwV1RYT2VYUUh4eDhWOEdOMjUvZCtOa2lX?=
 =?utf-8?B?WmVVaDZMMUJZNDNYa25aT3RFVW5aRG1RNGFja3hUMFgrVkFwc1JXQU91dCtD?=
 =?utf-8?B?K3dzM1JmT3Nxd252QmVRMU4yQll6VXJ5TXIvYzFUWnZrU1lBdVgzcjd6MXht?=
 =?utf-8?B?Sjl3UHIxTkZKUGEwN2hqdEJmS2lObnNGQXNjVXlpckRRUFU5aWlOcjl6NCty?=
 =?utf-8?B?SWFVaGhYVlNnTCt4ZmFvVklZSGVDYkt5ejdVaS9EOURRNmpJTklYa0FNamF2?=
 =?utf-8?B?SDZWbnk4eVhFLzkvdGZOUkNhZGVIbmVoRTdpNUhZb1pmT3U5TzlPZ0RtTjdP?=
 =?utf-8?B?UUJzSnRacmFZa0lObzk2dEExUnhtNGhYWE9FeGtYRG1sUGpHN25xNlBXQzFO?=
 =?utf-8?B?bDhIU1dGd2EwM2lLdFR0N3Q0Nm9tSGwyejBlbjY2UzdydVNSZ3htR0FIa29D?=
 =?utf-8?B?bnJ3VEdiMG1xdThaMGdCZkNTczJDR1crK0hMd0ZUbDBtVi93MU44d0dwYjQz?=
 =?utf-8?B?dVc2aXdwYVVKZ0h2S0dWYURPNGo4QkIzaVVMNUNrb1FwSzZrak5TZy9SbzBv?=
 =?utf-8?B?MVd4RG1kdnBMUFhEdXZDRld4L25JRi9Dc0h4YkNYR1AzTHdoUnlkWHdMOWsw?=
 =?utf-8?B?aVM4MHFsdE1wdE1FYWpKTEZtb2tNT0tkL3BZclFScTJ4dFZYN1VYZ2RFNVRP?=
 =?utf-8?B?YnpyTVd3L3hGK1BEZjVRK3VuWmk0UFRxSzFaSWFLTWFaWThqY0dGVlNzVG1H?=
 =?utf-8?B?K21YeXBhV3dqWTgwclUzN0pzMXRZNXRzRW5tWTlDMTI3VWhrS3pyVGRLdnA2?=
 =?utf-8?B?UFg1ZzE0ODZKQ3JUaDRUbDFBSjgzSG1Sb2RMbi9MQjYyN0x0U1lmYzd0OGhw?=
 =?utf-8?B?SUdvTzFCc01FS2dhcVFWMG4rQlhDZDdXY0k3TWsvSlY5WTFLUldTUmduNnQ0?=
 =?utf-8?B?aXVFOUEzZXp6SnhYaGV4QnYzd2MzWS9FcXNXc0xYeWJQZ0cxeWIwOVFtN0RF?=
 =?utf-8?B?U1lGSFJkRm03TVV1OEpQRStyTmNzZXpqNWFKTGtLSVJoOUVXbmdnRmQwWUlw?=
 =?utf-8?B?SGdKWWFYN294RFNmTnlGMHJBSXZya3Y5WjlaSG41TFlkU3dNenFXUzZtNzFR?=
 =?utf-8?B?Y3VRVVJ1YXRCbHhpcVpreGwrSk9IVVBubGh5b0VHYWRwdjVaem9BTC9aOGQ5?=
 =?utf-8?B?Qmt0LzM5MEZnN0wwMHNQbXBZOGdyWVBuY0dSS21QRElVZGZ2djByaGNCd3p6?=
 =?utf-8?B?QU8xVVBCQ0s5QnFBZlFBcGNsZDAxQ01WUS92VGlCbFVxRTBrRXlmc0lOVzJv?=
 =?utf-8?B?QjRvT3BBc3RPbXQzZDEzWkE2MGR5Q2hvbElyUkNuTWVMV3BrcmhvQTZKc21R?=
 =?utf-8?B?cWdsdm12MHpqTWhqMEd1ZXBFQ21pdm55K0JZcnpkckllR3B2YythQjNGL2dw?=
 =?utf-8?B?eUJoSndPZHpxbVQvL2Vrci9TSGQzSE0valRLUW95aU9WWlFaTU1rcTh2THZP?=
 =?utf-8?Q?5i6Es8I54JQjE9sdSY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aE5YbWg3NkluWWRaS0hiYk1OWHBoK3FINkdieVhrNzRnNTRZRVJ0blZ4Q2lL?=
 =?utf-8?B?TkZXdTlyTVErRzdIZFFrSC9JUUcyWlZ1cDdLVHdXRk1EdzJJNE1XUW1OVndt?=
 =?utf-8?B?YmRxZDY2UmVpTisrS0J5dklxNjhQeTNva3htZm9RK2phV1FlN3lLU09yQVlE?=
 =?utf-8?B?TXdsTTVUQzhNMHhQb3ZLY1hPZjdHMk1nZWFESHJOOGpBV3Aycnp1Q2xUZmQ5?=
 =?utf-8?B?WWVNdmlQVzh3c3F1MTZXMWZ1WTZYTEU2L3JTczVYYjBiR3B0ZFg2TENnR0Nr?=
 =?utf-8?B?SnNxaW1MOGN0MUdqMVhSWmJiL29oZnhQWXZkSTFUYnRta2N3U29OUkM4Q2ZN?=
 =?utf-8?B?Qnl3SHRTRVhKMTNZdHNTRWhMR29xNi82WXY2dXFvaU4rOTlmQlUwdng3Nzhy?=
 =?utf-8?B?d0U5VUwvekEyWFNHQUhhRm9wMmJ6b1hBWlFvaXpWckxXMFBCU1o0UWxqbWJY?=
 =?utf-8?B?bTU0dVVkMEhSMWhzczY5bDVvUnFEYW5iLzJjWW1YODFnSk5iZUVKVWYrMVRG?=
 =?utf-8?B?eVhkZnpqVW05WHRyMmhUTlNSYjZudDBudFM1aENEcW50MEdxZG0rS2xNbVY1?=
 =?utf-8?B?WHV6cGZPVjVBRi83T052NDBMR0pncFBmTzUvTTYzTGtxbWJOL3lyYmxwNFJF?=
 =?utf-8?B?RU9sNyt5VG4vRlZFdUExaVE5cWJxd3Ric1krN2ZIaHloNXNJTEJPa3pWS0la?=
 =?utf-8?B?Sm5FS3ovMVQ1VFY4eTM3cjE2ZGFuWWFQc3F4VUNmZEJJd0VhU0lITHZsRnJW?=
 =?utf-8?B?ZmVaOG1FQ0UwVWN1TUdiLzZhclF6TjAwWG1pYW5WMGpDZ3lwa0JZQUNXTDl0?=
 =?utf-8?B?RHVtRzJGWnpHUGNZNGhRaE14ajY3SDFnQUtCRWk5N1RMK0VhdENUY3NFa0VQ?=
 =?utf-8?B?ZjhSQ2pXK21yRXVHSElYSEZjNXMxQ0o0cmtsS016cXVjdThrOVlUWks1Z2c3?=
 =?utf-8?B?VXlDOWc0T2Vxd2FDY2VwV3U2UkQrVjRwTDRxY3NpRTNjSjBKSFhHeWVPNnIv?=
 =?utf-8?B?QUdtZGlkUGl2WjU2YWo0WWVHZGloYzgrWXcxRG02eGE5eHRVR1VEYTZUU0RD?=
 =?utf-8?B?WGxGa0ZNRkR1d2JlTHoxRW53UU1Nd1FxTDlwRTg2ZFovcHJ4clZ3R3ExNFNq?=
 =?utf-8?B?bStKUGloUzRZamIzeU85WkUvTXVQRnYrUzdlSkNBcVVMRU1vTGJOa3hwRGRI?=
 =?utf-8?B?L2FYclQ4ZVBzSlFHQkZlUWJwUENPUlo1SVhSSXZxY0JVRWF4Zkg0aXhBWVNj?=
 =?utf-8?B?N3V4dTFCMktEUmFuUzVlUnJCV1NHQXFMZVRZVVlneXVrWENuemx6aVp0QkxS?=
 =?utf-8?B?TjhkS1JlSEJiakpzbWVBa3RKVGJIV3JEU0lUU1NMQWkvNEQrTEpMaHFwMFgx?=
 =?utf-8?B?eE8xYUdVUEJOSVhaRzFlbHFuWmNtREJhV2gvbXFTZy9xM3JtVFQ3WXZlSXJ4?=
 =?utf-8?B?aStuK2xPWTZEQ1IrWitMYkdPdzQ4a1lFR2RpNmZTay9EYWk3R2NrZlk5ZlY3?=
 =?utf-8?B?N0dVbFpiRU1GRHpORitpNWNDN2lGdXA0a2lRdVZmZXN1VTd5UGFqTEtaNnNY?=
 =?utf-8?B?Q3VJVnY0WjRmU3o3NkhIWnVsR0NVZi90TWsyUHRocklpejU3ZHptY04zL0kx?=
 =?utf-8?B?QlR6ZWQvMTc1SW11Qm9KK0syZkNTN290cjNyTS9oamM2blJCTkxjakpHSUFa?=
 =?utf-8?B?ZzB6VjNJZHhEbk5PYTB1d0VsLzFhN04zaytRckE5YVhKb0ZOeWtkeTNBRkds?=
 =?utf-8?B?U1lRUm1QSkdDaDFNdHo3YUhiVlpvb0E2NDBTMG1wTWRKQ0o3UUlrdTEzSGdS?=
 =?utf-8?B?ai84RHRhRGJjUWNKK3I0RWlCcDlNTmNOUGFEZ1pHNmRkVTMwZkRjQjJKR1lu?=
 =?utf-8?B?TG5VdnpUZW5jdHhvRXlYZTQ0SHl5WmRPNHl3eGNCb1Fra2FPUFkvcGUycGhr?=
 =?utf-8?B?M25qMXQ2NHFYNHZ6Ums0dzRKTjNNS1JzcVpjMm1raGVueFdOejU4QVJnMWVh?=
 =?utf-8?B?eTM0dWw1M3I1VWROZGZ3Wit3VDUzVTEyZ2tsQjNDWk04cS9NZThBOXRoajZB?=
 =?utf-8?B?d0pRZWNDcHRwYm1yamFYek9nK1ZOTVR6UXQvWVFlc1Y2NUtLQWlnemE1T0Nw?=
 =?utf-8?Q?KRnZURToyc6J9WkmlpHw5jP3k?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d724a7-4e66-4101-9bb1-08dcbaa78fd7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:20:01.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ihnqVDUsRvEANe0ICgXkr2VQIQYSdFym9h4f8acMxgccZCxTGaQI5ut3pT3X85P+00nsRQgixaAcvhayTAfGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6755
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 08:20:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16774

On 12.08.24 09:03, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This commit updates image reference of debian-cve-checker project.
> 
> The reason to change the runner tag to large is because cve-checks job is
> being stuck in the middle after generating cve-reports for dpkg status files
> of very few targets. This behavior is observed in several attempts.
> After changing th tag to large, the job ran successfully in minimal
> time.

But that is not yet an explanation, just a mitigation. Conceptually, we
don't need a lot of CI power to run this job, do we?

Jan

> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ab1835a..6c92927 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -456,9 +456,9 @@ test:qemu-arm-IEC:
>  cve-checks:
>    stage: cve-check
>    needs: []
> -  image: registry.gitlab.com/cip-playground/debian-cve-checker:latest
> +  image: registry.gitlab.com/cip-project/cip-core/debian-cve-checker:build-latest
>    tags:
> -    - small
> +    - large
>    script:
>      - scripts/run-cve-checks.sh
>    when: manual

-- 
Siemens AG, Technology
Linux Expert Center


