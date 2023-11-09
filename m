Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C6EC41535
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 11:25:24 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.72])
 by mx.groups.io with SMTP id smtpd.web10.119238.1699529121637884336
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Nov 2023 03:25:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w/yK9P7n;
 spf=pass (domain: siemens.com, ip: 40.107.8.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4plmxJ1b8gjZWuGGH84Y8ynrcx2aJbrwNE5ArwH5P9DubWW8MfuaiD2ZYhQquhrNeHnbrveV/MRxIqoX/t6tUJoOBD8cNDsCYLfTljXMJuhkundwR5LeKIntDvbp+9y5m/+lM+P+haZcf2OfikiQ89t+hRFFFIN3Zo/A1nIMsQ2Qh3mjZeLYjyyPzL7Pwc8a15yoboKVB896TTl3sjwEalUJFr3WUZ0TzwCmAvDqO2dK3Hi17Rwuwt4sNSGmo/NPgSTPqyIxw5Tth4Pn8s2u8VchWJWyKEwi/NJKIoL+g7sZnpqPb0vdWSTbFTgvwR79OMjfQXERhUtAmZISecAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlBZbdBq9PvGqcxkr9GZPYqQU0jijDHWBuDUmi+Y/wk=;
 b=PfAQI+0RFqSlELEIHDpAT1ajW84nOCbJBpZ5lCk7+uJlFX39N+8KBqJ9yEcpn6nJb6bdTGGlYGnEtfHOFarF54Dqh4kWhgTkNnyl+l4zPeOcfzRJYvoZikrMs7EcRNtrHSPj/AoyPmmE6sQAeXrWIHpHOxMSNLYLDqDpvxtCYEFQP60adH2eEmXluK1I3+NKqhlUFKwK+nEGlgTODm7FMX5h5f8MmP+M7NBY+M+4dVZwK5q1hAhLL08l62VsS7zLy3ilpv84SW56EPRqLwkKmPzH1Ol+OxTBMsWyjdXwbKkm6v5L2bm/LNeaf3w9PWdZFSs56fbftQONuOmv8S4XJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlBZbdBq9PvGqcxkr9GZPYqQU0jijDHWBuDUmi+Y/wk=;
 b=w/yK9P7nEO/01qJnuh0IXGnpbQtbeBHSETO852X7GwAT8lyFD1yf7d9cRV82sgoGEfWXHx8AchGZTFKnioLLVYVIj22D27CqH/nhuMX2M8bnLUgoVZLz2yRyN62CWUqKpRiyactCDOEpB/8f5dtL0RlDXdYV1Rzh+In/zKgDqpbPggVzTlvs61qh2VjDWsweURgxDxvkSsAXCJQh1IMqcARj5LoQ5qqgTrgl9HCFx4hXZNevog2BYWKHeQz9bxuJvkGtkJSumRJc3PLpt4A3aSTVu8Gz71jRHzswx+EmXfdLSLajXT8XLuBhQ4lXbnjMcLgOKxjzHlDOMNVcVMWw1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5632.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 11:25:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 11:25:18 +0000
Message-ID: <f04ca240-3ba8-49fd-a50e-54c5e39e296d@siemens.com>
Date: Thu, 9 Nov 2023 12:25:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] .reproducible-check-ci.yml: Stop running in jobs
 all schedules
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231109100557.16431-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231109100557.16431-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f86ae79-c23a-405d-c820-08dbe1168d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dJ46XyF/ypsbxj7lAhLntPddzbRqz5U7GXijls/YWgqilu0AL1iHOAgwE/J8IhzHQG1S8o1sayYbe/5HB0zW1SSKLdDlWE3WauOJkElLaWtarx95lDtdi3AwVySkgTpZE8HeLd6j8PJiQhEn3FPA3sUwifzrGRjwMC69nqeprZfmNfMEKs04m8ejAOqtr6sGwFs5CGv3UHzYgqTDOAjNY8jEsS9Q4BLxoJBTqfIeD7KjiSF0TW0LhY4DiDtZqlLlsIDbcnJcSShNHW1XAYLyfiH7tkWzMxPH54+ymONc2VELgLeJCPqfJrggU24egHB2p8HvXCRCjhE2grzBUFbgddocohq1Av3FgnTKzWVruMBTN5fWokoCGq/2p7EZGBAW7QYQiZlS2zxkagjSZqVtkhXLEyp1z7UV+fW+dYabz3T+fKI6uZJ9L+gXQLzKM/QnbfuIN9wgqzD4ksu06VJvRyFqKMGJehEvburXoA4P/obiJinYzFuFGNopKZ7a4ch79J4PJF4gdWgQx2fZOecKmrDjYY/VFpp7xc480HSzTM7bEq98dVNgJbOz+Cs7X6jus1SXy+1hPPEjFXe1J9o4bybsyO9z4cgzAc+iukOIL60UDP/AsHUfcKD3eElXgc698hwuAI8yoXD4m1LOgYKaug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(5660300002)(38100700002)(86362001)(31696002)(36756003)(2906002)(82960400001)(53546011)(31686004)(83380400001)(8936002)(8676002)(4326008)(6506007)(2616005)(6486002)(6512007)(66476007)(66556008)(66946007)(316002)(26005)(478600001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHpIdnVKamlzeUtuTHR2QWJLekdCZDJPNDJSQ2ZGZXo0OVRrVFVDc2FXb0xu?=
 =?utf-8?B?T3BJV3Fjc2VJTUtZUlpYaHErVHlML3Bsd2NCakVSamFOQ09oWUxvRDRIbmE0?=
 =?utf-8?B?S3BDNlZySkFiek9YU0JXSndHYlFkMWNPRjZSK0ZkcjJrakkwQ2tJRHF1YS85?=
 =?utf-8?B?L2cyTWF0QytkejhFdjk4OEF3OVE4eERacmkwcUs2bGR2aXRrRzYwMlhrMmxQ?=
 =?utf-8?B?RFAvUTdoeFpWQkdWL3JadHh3dUZZcm9kdFdad1dmYXdPZEp5NCtZZjRxYnBR?=
 =?utf-8?B?Z3c4YkljL040ZzRQUDRpRGdqVXFlUnAzbHBLdUVHQWxSSWlNS1lpbEVkVjda?=
 =?utf-8?B?VHE4YU50NVBydGYrcGFKNEw4RS9nRTJiWThKNDYwK1BJSHBucVdjeU1pM2Fr?=
 =?utf-8?B?aktrTTk3emQwWVpYdytVM1NEc3lwREkvd1lhUW4rZkN1UUlnTnVtRUZSVVNN?=
 =?utf-8?B?bnJTcDVkeUxMZ2UrYmkrNnZzS0s4NFY3NGhoZ2JMUkx3QVMzNVkvVVFybHg5?=
 =?utf-8?B?YWVRUXc3MFFmM0tFazY0MXFvYXZQajF5QTB3RDcrUDFJSXdIYTBVaEF0QUxk?=
 =?utf-8?B?T0Z4dnZJYTZSWGxhajZyTFYzUG9BbmNsZ3Z1a0NNdDVrVUhZcmY0V0RISVFS?=
 =?utf-8?B?QmNpYVhEZ0N2U2ZseTk5c1YyTWwrSmdsVXAzOHFyb0xzUkF2dHV0ZU12VFIx?=
 =?utf-8?B?T1pSdnZUV0R4YW9MZ3p2Uyt3N1Rhd2NVV0VweHZZbm90aEZ2VEo2VlJ0Y2Vp?=
 =?utf-8?B?RlNYN3YyQ1Y5S1ZyWHlmUW85eVhGSG1YWmJ2L1RKcHBRRm9Yc2xNWnM5Ny9E?=
 =?utf-8?B?QlRjZ2lrOE9sdDlIUERwZENSd054RlF1ZCtjMkZETlRNdUo4UG45SXNoUzBM?=
 =?utf-8?B?T0ptTnhCM2l1VWgyRFNwcWVheitrclRMUk1HdUFieWs5Z1RJQ0E0UTNKRTRt?=
 =?utf-8?B?d2ExYXgwS2FBZHQrMlFOb1N4VTNNcS9FNmQweStlREIvQThEalcwMU0vdW9L?=
 =?utf-8?B?MTBXYXRpU3JRS0hnSVkvbnpJS0V2QjJ5MEh4VFF3S256NmpCbk9lbkRwK3VB?=
 =?utf-8?B?S0Q2RzBKcnVIT0pTRjFJclNWNGlhbkdaWVlGRStZeWgrb3RBNDBhMEZTYWNM?=
 =?utf-8?B?anB3aFVBYmIxd2IxMklBNTNZV2RtbWRNQjBiVTl2VHlobklMQ2hCUDRUeklv?=
 =?utf-8?B?U09LWkpNU3BCZUNHYnU2MjVWNUpyV2xkR1RCako1bFd6YlloZlJuN0RkUFdr?=
 =?utf-8?B?dTF0UGcxYlBKVnFaU3J3d0NtT2l6eklyRDBrZ0NScWxpQmVrS0dSMllzdGNH?=
 =?utf-8?B?eXZjclgvUlJFQ1VyY0t6R0FQMHZabHZjZi82V0d3THR1aHhFUDIvdElyNVpk?=
 =?utf-8?B?aHd0VTZpRDhHM3JxVzRWNkZ5Rmt0aVAwNmorelFnVE9pZGhNSmdnZUdRVFdQ?=
 =?utf-8?B?MnpLRHJmYzBoWUJhUmNjOWx1RVFROS8wYXpYNGZyUUUyTjlVcXgyY1Z6MERX?=
 =?utf-8?B?a0Y5WWNmQkdOVzFiKysvdXZjdGFJZHE1dWJYZDNhNG1Yak0vb2xPNUo2TUh0?=
 =?utf-8?B?NC9IMjc0cnBzU0VzWCtNa1N2UUM2SzlLeW5hRkVCU0d3eHdvb1dzRXhOV2FZ?=
 =?utf-8?B?U0RUMlo4ZldnWjBjbitIOU10L2JWOWRTS0drQ3ZHdlY3QVpHNkIzdGdVUThj?=
 =?utf-8?B?QVNFcjJmSVExMVg5VnpjeWZqbWtuS1JSVlVJdit1MjBaejA0VVBSRHY5bW05?=
 =?utf-8?B?OUUwamdEMDlaMnFSWk4xNFV4eEtOMWdhazEyUExtdlNqeStOR2ZFNTBsUFc0?=
 =?utf-8?B?TFhRZGJHUFdDVUhFQStxT01zcTB5bUxqYjJCSzE4Z3JscTRudWNSU3RnSEZH?=
 =?utf-8?B?YnMxWGoxY3RDcVZ5U2ZEV3BpbDE2WGtFUFNuTXg3VTd6K0dYOHVLV0FPQlh5?=
 =?utf-8?B?Zlc4SEdGT1UvbEZXY0VIblVUZzNqK3hiRVY5ZURZK1NRV3V3OHJZVWpoNEVB?=
 =?utf-8?B?dmMvQTBSY0VFV0l3YkFnQ1NKeGREMWxtNzg1MysvVnQ4Vno1OVhISkpRcmUv?=
 =?utf-8?B?bzNudHkzSHVkYk1kRXArOUVKVFNoQjJ5NHc2SDBNcGFzZldScTllUnhnRSts?=
 =?utf-8?B?dXJJcDZCMnpOcWhYOENRRTh0bGNFSmpJRi9HNUFkNUs2a2IzakhPRkp4MS9s?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f86ae79-c23a-405d-c820-08dbe1168d6e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:25:18.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWUHD4Gi1bPhnT0uD+qUf1XHzTzmkfq4m0TZFmC8PbVxinfYovWxL8/ldxu5yB7RP/wHvacyXX4FYPC1RBS/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5632
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Nov 2023 11:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13549

On 09.11.23 11:05, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Currently the reproducible build check jobs are running for any type
> of schedule, so created a variable and allowed to run only when the
> variable is set along with the schedule.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .reproducible-check-ci.yml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
> index 1a2b4c8..2bef312 100644
> --- a/.reproducible-check-ci.yml
> +++ b/.reproducible-check-ci.yml
> @@ -25,8 +25,8 @@
>    stage: build
>    tags:
>      - large
> -  only:
> -    - schedules
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
>    script:
>      - if [ -f kas/opt/reproducible.yml ]; then base_yaml="${base_yaml}:kas/opt/reproducible.yml"; fi
>      # Build 1st time
> @@ -55,8 +55,8 @@
>    tags:
>      - large
>    stage: test
> -  only:
> -    - schedules
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
>    variables:
>      GIT_STRATEGY: none
>      release: bookworm

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center


