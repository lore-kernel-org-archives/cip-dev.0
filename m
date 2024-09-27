Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3377AC369CB
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:07:14 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web11.67514.1727438826856768319
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Sep 2024 05:07:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dllLqYNo;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVHxQ0FMm11o41EeWUiID6tzoEixOatVSAAfhY3PfGES6EcBUB5Ef/e1o/e4s1g8bMn7ygy503xhHn7lqkZTjaaZvTs9Yz8Dfcv5wmnbi0g1NWN28OPn8n2mjpnCMm9PO91sxjhcZHiEixzxtDhFQJk6UphUpy7Yn8pk/jwiq78NkiSukm/qwG7iVrSTp8IWG/C/J6aXZptHWwWmNfJmMQ+rjQIt0FmMnTOMBxHKemUhIuf0ViY7YBLC9gwf5LnjnVCDj+PW1VcIH5dGGrmBSXju8UJyvudibjKQ/0UBI7Qlw7SwYrdbEp3YI+UdOfJ7DPnd8+OcHyKNvI9HxHdrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnpv2MKNX5NyAvrKiqSRHOWP5a0Ob8Qn2Wd+qk1Z1Rw=;
 b=AX1QEZDTr5BeZjAU3fbH8KByaHmZhNSONxHXt48DQiyi3k624F5PT0XKe68q9Z3rtIo/91zE+BBQrLj0UW1vZf/N9coYrwSCpJkEPKtByA4NVJKw8m5QIKNjrHAU67c2QpO0c2ILFDS0ydX/mgMzkNMulfubxNTF7lVYVHTwqn6LIT56OoPWYn7v8H+VczZWpg46Q4bquzE3aPmvCA1/c2mh4LAp4vvDHl5Fau+9krKLk1uCoZ7ArTgW+CaMFVNxlETqHgOWK1y9+IqvYuqPPiPYKWPWRkbgpXrC2b9PYf+ZbyVkBbi1CjiWcjuAWqSqh1AlKWhzQlfACjQO7qqpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnpv2MKNX5NyAvrKiqSRHOWP5a0Ob8Qn2Wd+qk1Z1Rw=;
 b=dllLqYNoXABqCVCDgJjUFuDEYzs1xQssg27Dwxl5bak57w9/mcqfegRyWmXgfN5AMsqNqtuJxd2Ev8RazgXCGtBMB9a294tJp77ow/nOGGV2onS8rHxNEqE6s/bdyzYN1exnHgZXXQqbag5YStHUiB+ENmthf/ndIdzF9TrDR3PhJgf96O1Taa/ZFiVUflNXJa3stp5FpReSCO/h1EkDDeQsg6yxZvoZfgFibSUhFnf2EUfFVb9JwAgcX/WWYLlZ55wpOGwSHlcMWN2IopkaLCGc8pUiVomN5S9THqp1tIdg0wwcF0uBvvppQFN6MpXw3S8TJB74LIUHOCyS309bkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:404::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 12:07:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 12:07:02 +0000
Message-ID: <1ffb5888-957d-4682-a5f5-565189e9d30e@siemens.com>
Date: Fri, 27 Sep 2024 14:07:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci.yml: Use "large" runner for
 cve-checks job
To: Chris Paterson <chris.paterson2@renesas.com>,
 cip-dev@lists.cip-project.org
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
References: <20240925143447.2232845-1-chris.paterson2@renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240925143447.2232845-1-chris.paterson2@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: c24c6640-482a-428b-8a20-08dcdeece574
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K1dQeEJZUmhIZEJVQUdNZzZTaGtrU1M4V0o2aDNmSWh2TWR0Nzh1SzNOcHR0?=
 =?utf-8?B?aXFndzkyQkRHdk1vUENCK0hkMmZjVTNnQlF6akk3bnEzZXpqY1hFaTAyZTFX?=
 =?utf-8?B?TDBkdnJ3bWg4a0JVajVRa2J2TmJra1V3OEprZmVvTWc4NTNWNk1ZcjVadjU0?=
 =?utf-8?B?RlBPaWN3clJXd3ZnNVEwOXByTUE1ZzNSWlVXL1ZHRWJmMjlJQ0FjUHdZUHRs?=
 =?utf-8?B?OGYrOTZQNllnN25wT05IR1lNdTduU1p6UjlKazJmR0hHNWVzenRhQjlBdlZU?=
 =?utf-8?B?eUhyUXl3TjkwVkJEZXRETVVUQTZvV3F4ck8rdFJEaTlSU1JET29QVzNHSWVp?=
 =?utf-8?B?NFppVmhSMFNnMnpkTnd5UVUzV0NPcm9RN3VTUlBMZDd1RENua3habUlNMEJM?=
 =?utf-8?B?dUVyVVVNSFlJQzZFd2JHRSsrRkJyNnRQY2poRWhDcVQ1cE5LOEZ1ZFliVjFn?=
 =?utf-8?B?c3lHczFvREdZOEs1V1I4dXhZbU9KZVcxNUxRV0x0N3FyejNCZmN2bDByK1FK?=
 =?utf-8?B?NEZYajNhUHFxYUFkcEJyaExmMDR5bmtzMXh4ZDVLaGpnS0t4WmdxankvYUJu?=
 =?utf-8?B?MklnUWRJamRCdUNyY2VQbllDM1FGRFVEeTE2bWsvVXR1d1djNnFTOUpMcWgz?=
 =?utf-8?B?bXh6MGdXTm5YMGIvVlYyUFpDSVgrQU9jTlcvSzBWY0FmcVlZMk9jU0tsTWd6?=
 =?utf-8?B?UzdOZFlLc0hEUFVJWS9JMmZYNkxDTlhiNzNZYVFhbEM2ZUxSbWFDR3hyQlpm?=
 =?utf-8?B?eDAzS2ZyZXJQM25BR0NDa1NMRDg0b0RzN1lUanZudkZsb2srVGFPbUVmaE1q?=
 =?utf-8?B?ZXhPVGJ6V0g2cEtWbkxETjVaMi9XMForZjdlYXVmZHJtZG50aEk3bVBWblp1?=
 =?utf-8?B?TU42cVZlUzdGd2VlcmJNWVdwT2x3bVVwUWdMWExqWnhBSlQxb3dydzYvYTJU?=
 =?utf-8?B?c0VoSlE2ek5ZcVpRdXVHZnpZRXJ6SjUySHZ2Ukp1NG00bzdOeXV3YkZqTlgv?=
 =?utf-8?B?KzN2bTJmSkhZK0pXSlFiN3JSaWtDOE03czJIVHB5VG5FR3ZvWUhBcTJ4c2g3?=
 =?utf-8?B?c1E5N29CQldzQ3l1WDNhVlhQRm1VTi81Q2RScWZZUHVra2dkUkdRbU5ib0V5?=
 =?utf-8?B?T0NpMzhFeWJWMEFtZkI3RlA5NHh6dE5jSDdmUkFXUFVnNC83UFR2VERCVGNZ?=
 =?utf-8?B?VWg5bS94MlpseW1kRXBkYytIMWh2WWFPczJoL2FGVERONUlwa3FXUU5ZeDY1?=
 =?utf-8?B?V1hyMFRPY1RTTi9BTUlhYzVNLzBoUk8xNXZzbzF3YmxMbnJad2RJZlJRR01k?=
 =?utf-8?B?ZWd4ejB5TlVoQndZa2tqejJldUNHYi9aUkkvRW04QnNuSE13Yk5CSTN6aWEv?=
 =?utf-8?B?MFFoRnhYZXVGTUR1OWlXMEt2WWR2Uys5TkNPUHlLSGJmamVLY2o1YnVERXI3?=
 =?utf-8?B?ZTlIVEFoS2VHaHVuZWQxdG1zQTF4Lzh5Q0JLeEtFNUZjSUVDQVNCd0VvaThJ?=
 =?utf-8?B?ZDRFMVpaS1ovTStCU21IbnZlcDB0L2JMSjRCQTMxTzN4eVRSeDJKSUNVUEJ4?=
 =?utf-8?B?TTJzQ2ZKSkw0MW1Pb1ZCTk9PbCtCeGk2MGdQdytsRDdtcXZrZk5EWnJjNDlG?=
 =?utf-8?Q?fDM82xZjstffP4bqnp8xTJjrsOguQ6WVRSFf83b5fraQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUpTWmU5Y0lXQjgzM01KWVFiZ0J3WW0wMnRQZmhvdFRpK25FOHIweEw3SkZp?=
 =?utf-8?B?TXRjTGh6MVFTekFPWUZLbFNGVEk5NkZDNDZPM09VSDBGMktCcCtUUTE4NjE4?=
 =?utf-8?B?WDBDY2xWL1ErQnk2ajBOak1NZXgrOFgzZ1BDRGxjTFFQV2hnOFdzVnZGOEVh?=
 =?utf-8?B?SWNqdEpJb2tVQ1ZGTHY3NERHSERDRGt6SWhGSWc3TmJieExxLzhvQ1gxQmg2?=
 =?utf-8?B?RW5JQzNSUnVHV0EyMmJYbk0vM05vTWNpSDNBeWJCcXJDeDFQdkxSOFVhRTdt?=
 =?utf-8?B?a0xaWERqMlhGbElDakdWOWk2bjRFVmZmRTIyNndBRmhQejJPMXA4aFVoMWxa?=
 =?utf-8?B?VlRaYnh6ZXlBNmhKWXdVTTU1RUphQ2ZqdmV3czBGRzRzY0piMjE0VXQ1SWZO?=
 =?utf-8?B?MUQ0VENPMkx1VEhLVVhMWFdEK1NtcUhRWERpMjRZM2hGN1N2NWEwYzVBK0RC?=
 =?utf-8?B?WlZXNFd0V2xPNFVVUEFmTmNQUUc0c2pjM1FEOVpVU2JZY0x6bHUrdDJjazdj?=
 =?utf-8?B?TUdGb1JucStvdERldXpRcndUd1RzcEZGUTZ0SUZ1NkJiR1N3cjR1M3g4U1Vn?=
 =?utf-8?B?VWxRR042Z3crS1g1cmJ6T3lKTy9IT2taZ3E3N01MbVl0blJINFB6dm85aXdy?=
 =?utf-8?B?UmNIQVdTUXZGOHlmRmpiV0tOdUZLWFR6aUJXQnNVa2ZnWm1xTlNTbWlyMmdj?=
 =?utf-8?B?WlcrTTFrdnFiN3ZaUTN1QnRwRVJBSHhzcmt6b0NkOE5rQkVZVk1ZOTVsaGtU?=
 =?utf-8?B?V3FJQ1NVd3ZNZnBTelFDNlkvbmFZTGRXQ0w4UTUzaDFVTFArUmRuZ2ZBU05n?=
 =?utf-8?B?L1N1TWR0MHNUUk0ycVlwa05IRkhyd0owZEN0ajY4UVdrR1ZQZHE3dlFrYVV3?=
 =?utf-8?B?OGY0RDhsSWlmSUVTbWdwOUJzZUt3eUJXU0NEK1h1bkdqc1BVdG9ya2pmU2ps?=
 =?utf-8?B?UVZ5RHVLV3U1dmt0M3JEUGNEdkV1c0Z0VjgwQmNjaUU2UFFnbWYzaHVpS3NT?=
 =?utf-8?B?bW5ld0lQV3hLMUl3RGxuTXFZT29NTWxvelEvT3ZEVkxIOFhKYW1QWm1zNWZk?=
 =?utf-8?B?SDRIWUhLbnNkTExaWERrVUpQZzN5RzFMUXg3NE1VWlpBcFladjFHN3RYNlRP?=
 =?utf-8?B?U0VqaHY0S1ZueDZwSjVZMHZidXVFR1I2NGYyREhlN1RKK1diSHJuVGsydGZa?=
 =?utf-8?B?Y1p0ZEVOYXFKbnl4VFdLenMySUxhSyswN2NLVmhJWitBSnRMUXdOTHluYTQ1?=
 =?utf-8?B?ajJqa0l3UG1mYlcyTG01MU5Oc1F4WElaYVlBVDhiL1Z4WDNOMUZ1bXg4QWVk?=
 =?utf-8?B?TVJiUnJneUQxYmZpaTFFdzBUZ3J1RUlmWS9IUXQ4d3phWlpkUTdLL2FiT3pN?=
 =?utf-8?B?ZU9EYW9sWHRYM1R2QmpHbk5zNmxEZTNpR3RTQ3hUOGh4azJxVThGVVZVdzIw?=
 =?utf-8?B?blpJQVZPeUN3OHRqYkNISVoxd1R6cmMvTmRxOXZpdnRMdUh5RzlGcWprTmVP?=
 =?utf-8?B?QW91dFpGbG9VRDhSckhDWWdETlhEc2FFZjNKc29IL3Q1SEZMZXJXVFcwSW5h?=
 =?utf-8?B?UGNUdU9zRmR5bnNGc2FPb1JrZHdYM2g0RXZzSE54S2RoRmNJTnhLL2h3TE5O?=
 =?utf-8?B?Rmt1MlVIak5LUVFVaUVVR3pqeTVPemh1ejBNMGI3VTN5ZmthbnZBL24vZ1lC?=
 =?utf-8?B?ZWRuNk03dFpnc3BuMU5nV3dRdkUzQ3RTWGJnY3ZHUzFpamQ0cnJ4Ym4wdzNt?=
 =?utf-8?B?alY5RzJEMWdCZnRrY3hKQ2k3S2pVMWUvVHpGMGR2YzBsWnN6bmo4V2hLNWZH?=
 =?utf-8?B?QmxiNkxLMjNwb0pncjdPOVBwNnc5THhLTHFTd1Z6d3VEcXBxT2JxSURjSmFn?=
 =?utf-8?B?UW1KQXVnOEd1eFo1ZHdndm5wdE5tRGZ4ZGtHYS92bGNFVW5RdzlxZzZuZEJL?=
 =?utf-8?B?QVUvQ09yNkhUOHcxeHdjQlFKRzRESmhxWHIzQjVDbE5TUGEzZmxmVndJUDRW?=
 =?utf-8?B?cEpOZ0FGNURPckZON0Mza3BvUnB4Nit6ZUQrRkVrU0djSDRvcmcyU1liSEs0?=
 =?utf-8?B?RW9RN25QQkVxK2V0eDJxdFdJbkR5Vk5EdmNkWEhDZlFNWHNsMHYwQXpJLytr?=
 =?utf-8?B?MStncHVvSUtKaFpTWnM0Qlo4RHU1SnI2L1dsM3k2YjRaQ2JxQzZiemhyVDQ1?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24c6640-482a-428b-8a20-08dcdeece574
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:07:02.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXUQgYxPP4ZqwDwSWk/yirwjQxLW571/2TFqrEm81JF0ZMiWU6IFz7XxdMvLIMh1wcRus8A0ixicAr2xioPbAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6559
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Sep 2024 12:07:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16927

On 25.09.24 16:34, Chris Paterson wrote:
> We are seeing constant issues when using CIP's "small" GitLab runner for
> the cve-checks job. Switching to the "large" runner seems to be reliable.
> 
> Reported-by: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index bc98ec9634b0..6c92927f567d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -458,7 +458,7 @@ cve-checks:
>    needs: []
>    image: registry.gitlab.com/cip-project/cip-core/debian-cve-checker:build-latest
>    tags:
> -    - small
> +    - large
>    script:
>      - scripts/run-cve-checks.sh
>    when: manual

Taking this for now, but are we also trying to understand what is wrong
with the small runners?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


