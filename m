Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7BEC27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 09:06:28 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.73])
 by mx.groups.io with SMTP id smtpd.web10.37355.1717751182026689184
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 02:06:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qcJfsJom;
 spf=pass (domain: siemens.com, ip: 40.107.21.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIkPoGi4+CfSsCq/Y8w6roPs4rTFRiQcmnvKrsdO/byNjSOJTfBymC6HkhAg19S5HMGnyO8+W3Mis+pDqLhhtpsLrNBBVN51OE0r5BOePukqa01X8qVQyYnkSO+8T6FC6ZXZGiJU2IQys2pfBAMXD+stioC6/XKDyb5lx886tZUsFPnn6o2p4AdaUsW8RukQZYKhcgS0adot/4eV/NIuuv6oVtyHRlqxN+45amprXZ6/lOlPPY/JhwqM3tewCqCIF15vNGtvnQWnEt+Qrgrk/aGDGEEQwn+CW3colxNtt6MAinqGefzaVcIaO0o0LXvtCzhYCsnJt/Oooy8zWzYSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hgwl8Jno4MtK94plY8SHjSVu04n0HogoXTswac9GZUE=;
 b=QaFvARYZzH6vTc8gwKNs6vTU5LVw16E2ylyWdMAC1k8x02EJtflWnjTzVQ8M5WbMGQ0HWUgAeUS8mkvyYQvq21Rha6+fG9W5rxwxeEWcF3S6/hI/wqPBZNTNXAmSnzIWn1KMHkt4R46yLBTTyCzFljXXi6dTZLnAu2uhGsIcnjtLGS4F5O0ZYtlkPrL0kBe2Mh5Xr1Mr9qebj2FZkj/Jk53AzhaNKrmkStjXicJ4XuTncqB1uACnvY2ugtBThE656B322mHBlbyDmXeHCKzRg9GmXYxnILcjvXYSUlN9+EP/5oMj4N+MUkBQK7zhoCG3YeMQSNN49Gn7pyb8L0WhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgwl8Jno4MtK94plY8SHjSVu04n0HogoXTswac9GZUE=;
 b=qcJfsJomfqAz3MMzKrpdIQd4NYpCpLz1qk/u/+J3DRgQJSRC2WPqbrz1m3deuQV19+jTn9LZuJY1CZTbGLa6Uw3gtdK7jcA3DIJh+45ok/nFfXUO7vYkqIPYm0G5EWggoo0Zn8oHSgHi62dVc7pG1OKj8wRjsXjzkyBs6L9iHVfeE1/dyuTk86w37Og9S9amLSBHuqdgccKsW5ODbSaqx2+/7BdvL9hGpErRGdgruaUX4VI/OYBfrtG9Tmu1TGAsKS96a4R+mKXiTLjTUzFZwDVkJ6Xi9O6Z5qaaRPPPFpW191jVIwULSlxs9m/oKmckfjklvsyqDxzcEhBEvUfcCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 09:06:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 09:06:17 +0000
Message-ID: <4d88c255-cf87-43c7-bb18-74d84420fcf7@siemens.com>
Date: Fri, 7 Jun 2024 11:06:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 2/4] submit_lava.sh: Add script to submit the
 jobs prepared from templates
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240605154010.3446832-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240605154010.3446832-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240605154010.3446832-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: f181fe35-081c-4815-f3bc-08dc86d1171a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SEZCVzMycHp5Rk83Um1RTVExNWhYSzNSZDBKMG9LTG51YWRsUUFnR3ZPTmkx?=
 =?utf-8?B?bzZaRlhydmtic3J1YVJCVEIrV0pneit4VjZxblEwVS9pZkxObndJQnFrRjBo?=
 =?utf-8?B?eTRtYnlVdThJZGtjWHBQNVNjM3BBWkxMRDVmMi8vUGZFbTZTRWRpMm9HMm9Z?=
 =?utf-8?B?eWMxL25MOGRHbmtkVjhkMXRzQnUrTUY2WDdyZXgvYXJJczZRdTFPeXBNS0Fw?=
 =?utf-8?B?UUEzQjZmRkRxNlNrMWRhdDAwejlNcHhQczh0dlN3WkcxRjRGMkErUDZNYUhP?=
 =?utf-8?B?eHkvY0dSeEI0ejhSOVgzU3g0cDNFZUtLZWg3WFRHRXpqZDJCNmh3R1ltRU5r?=
 =?utf-8?B?akoyVzBrM2RBOEd4N0o1NG9EVGJpaG9JVGN2ZTBNbURaeFgvMW5uZFFFanVF?=
 =?utf-8?B?cDh2V1l1eklqYWJFOUhrblpCSGhVVTlpYzlPYnBTVTU1NEVDOEM2MzkrNS9Y?=
 =?utf-8?B?TnNFQlBMSjBHRHNLUzVaQjAwM3RVb2wxS2F5VEx5dEk1N1NDeVFsdUxEakxz?=
 =?utf-8?B?MHNoZlhmU0s0QjAxa3MvRS9veUoyRUlHU2RQNHVsY3F4M0pMNi9mYXFGK2Ux?=
 =?utf-8?B?OTFwei9PbVhEa0xCcC9WRXZOaXRVRDZ5ZUZXN1JNVC9jM1BOcnBpVXVKL1pk?=
 =?utf-8?B?Y0F6dnBydmhNeHRzY2l5MkZWQ290Z3h1U3FoNExZbkpWM1NvTno5aUJsTTZ5?=
 =?utf-8?B?WFNYSG1BNTN0RnMwTWUycG9Va3RPUEhaTU51NUt0aE5wSEtVZlU4QWZFWGo4?=
 =?utf-8?B?UHhMekRtWXNwb3QxRVBwZU53QU91V2VDbCtqYzVabjFQazVpbFJTZHNyZ0xJ?=
 =?utf-8?B?VkNtei9LSkVoTWh4UVFUUTRMcVlFMDdlaEFGVi9zZXdDamRlcE9tUm1hZjY3?=
 =?utf-8?B?N0lMa0szWXgwd2N3U3Vic0NmY3pBYXhYclhCYzJ3anAwbjRWYituM0F4eWdL?=
 =?utf-8?B?WStuY2swMlF5Rk9sY1R3Y09qZTd1eGFQSkR0aEpTK3NKeVdjWWhZZzhIQjkv?=
 =?utf-8?B?d3ZkYU85TXAycnJiMXR5R0hMbk5ON3VYbFNpdXc4RUloK2hRU2k0ZU1yOEJQ?=
 =?utf-8?B?aHNLQmo5VmhRdWp1aURDN3FTS0pneTBmYS9rU0JzMGU4bUZjNVlLQnpQdWhZ?=
 =?utf-8?B?Wi9QT3pIRGVaQjNxNFREcXRHNzZubnZoTElhM3RBc2RHeHJyZG5zWDg5OTNn?=
 =?utf-8?B?eGtBVTlYMS9QeEk3SXJ5ZTNJcjhUeVNaNlNCYys1bzlRQ2tlWUgvVElWNldR?=
 =?utf-8?B?NENlRXV2MXBGZ3RjRDhiSWNrYjJqQUNsTktZd0NmM3JyRzVEbGYrcFRneVNP?=
 =?utf-8?B?WXFvb3FKdG5jR0ZlZCtkVWF1b0JkVjg4WVRLa2k0OTQxTENqUFE2eVhzRmRZ?=
 =?utf-8?B?Wk9SNDBoRm1yMlhoeTQ5N2NnOHA2Q0FOMUt5U29NVkFHRVNlZDUzcWtsS1E2?=
 =?utf-8?B?aWZ6RHZyNmJrVFBrOHBSMVZHVXpzUjA3M1I2YmhUVURXdDFMejYvWitLK2lG?=
 =?utf-8?B?WmlaRkwrN2NRN0dVRlM3aFJlVlViSG82QWpsUnFjV01Sb2EwY3hvaFVkSUlm?=
 =?utf-8?B?S0h1OVVFcEVPY1RndUNDajRaMS9jVzdyZDVrVmVia1FaSFNpL0FkbGh0dEFi?=
 =?utf-8?B?YzBkOGxTTC80SUs4MFpuU0FKMWxEcDdNVG1aVk9qaFhDNXVsVUJKSW1Hb1ha?=
 =?utf-8?Q?gSO3rM9M0xLq+kIP8+mg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDU0WHJ1UThERXoyYWtPbVU3VFdsSHRrMWlTWWlYTGNQTFRKOU16amFyQWgv?=
 =?utf-8?B?bU5DcTJ0Z29DNjRMNzV5T2RzalMwZ2FLSWR4dDg0YnVzOWtZNWlmRVlsQlNC?=
 =?utf-8?B?emlyb2tFYXEwcHlsNkRUZ3RhQ2V3MllRNVAxV01SSTZ6SjEreUpQQUlXeXRI?=
 =?utf-8?B?bmNMei9kV0FVTTUyRC9USzhseUxHVHFPdkJaTTc3NlBlR1NSdWR3bkkraEVX?=
 =?utf-8?B?VldnemdnaDhQRW5BWjBvUHpUTERabG13bXlpUDR1WjgvdEpQZ0crcjJ4UnJQ?=
 =?utf-8?B?eXM2RGVlOUlPK1VvYWNHM1AzWklaL2NZN1c2Q1RsYUd3YUluV3JHM2tCM3kx?=
 =?utf-8?B?MW4wdVpUaU9lcGFwTGFhaUlIeEZkQURndktWYXhDWFhoSkZGQVlQbEdyMWR3?=
 =?utf-8?B?azBUeWROcjZrT0lEbWVlTDRHTWtmaVp2a0E2RzgyZmpla0VRcW1BNi9lenNI?=
 =?utf-8?B?U1YyeVhKc2c3TWtyajQwNFU4NnVHdzVLN0ZsQUl3dUVlZkVCSHpXMnErTU02?=
 =?utf-8?B?aCsvZ3V2a0Jkak84cmxsVFh5WDFyU25hNUMrQlNCd3VybWNzSTRWMGloa1Jr?=
 =?utf-8?B?T2tMd2NFQ1o1YWsyL2FlZG15SEFudlJWUGdaanRVYXZiUlhZM1ZNTTU3cVpH?=
 =?utf-8?B?OGx0WFlLU2QrNVF1WWRyWU9qRFd3K3dEcThmRzdnN3hoenpLWVFKZHpmMDEr?=
 =?utf-8?B?UW1XS2dOaGZ3NjZ6d2MveDdQTUZDbmRmd2J0Y0Y4NjJ1Y2FoL2s2cjFjcFZn?=
 =?utf-8?B?WVBEbUJJcWhVKzhhSXg2MGJXTUgrOVVPckVLUCtPb1lRZkh5WFR2NWswZDZP?=
 =?utf-8?B?ODVJYU9uSzMrZ1VxczJNSVIyZEpSMEVRbEVIUUZoMVJ3UXpXejl5cGtOUkp6?=
 =?utf-8?B?YSs2bkdUeDlNMzdmR0luSk4zT1N4bUEzSmJncmhiQkRUS1R3MXVDbU02R21Q?=
 =?utf-8?B?MXlaTzhnRG1UVldWWVBtNDFUMUFJMUg3RTNRUk1Yaiswc3BFd01yUXh1ZHhl?=
 =?utf-8?B?RWxQMVh2VDlFWVNocUViNWtnY0pzNzRXNVphREJmeEt1UG9aaUU0MVBvMDZE?=
 =?utf-8?B?WXFWMHlSRlQwQjRvVEViYitZMnZTL1hnSFIxRGtFeDRCSE9hV2RMTTVHUTdV?=
 =?utf-8?B?V1FrTlUrU3M1L0J0SnUrY1craXU5ZTZGYzNmYUxZL3U4VGdndkxRalZDUWZa?=
 =?utf-8?B?RnEvVk45SFE3UU5OOUhOMTNzdDhKSjdvRk9YOGd4NTNTZGwvdnFxMEk0eTF5?=
 =?utf-8?B?QVo3VFducGQ1MS84WllmUWtOV0FPWFRWQjBCTzNkekM5UzhBM1BiS2xUYll1?=
 =?utf-8?B?cyttRHdxNnJVV2pyYVU5eDcvQUpsbTdhMSsvWkVvKzNmREJlVzJmTzVyVzBL?=
 =?utf-8?B?TFVkeUNQOVJYOVVoYXdzK2tFTWdiWXVrY3k4clU5RGxWaGhxUHNaRjcweTFU?=
 =?utf-8?B?K2ZpTzZKalMyRVlzNXczdWMvNWpQcUhJaEh5K1k2aU5KVStUNEkwN24vNUJu?=
 =?utf-8?B?R1c1WHRSdEMvc0lyQnU0bGRteitOTkpNd29qMXJ2ejVQNWwvbFRkTFNheXYw?=
 =?utf-8?B?Ymg5OVVrNmVEa2JIZCtJZWx5WllYRzc5RmZseFNmSDh4dFhUZnEyUXZRNFFW?=
 =?utf-8?B?RWtXcHJqNDlkdXZEQzBJclFUVXlnVWFBTWwwVnQ2RWFZTUc3cjBRNUJ1VVZy?=
 =?utf-8?B?RkJ3cUdxY0NQSlFFZkljVUQ4MnZiZG5qY3RnNWtQdFB2Q3p1TE1xc3NsaE1u?=
 =?utf-8?B?dFRlazBJeFk3V0NRSkswaHNyWElHTzlvemp5NEd5SkNMeXJ6TVZURWN5T0Np?=
 =?utf-8?B?VURoL0EyYkhtVElONW9HNjhJc1NSd3Z0QnRoUExQenk5aE1kMkdKYlJEYUR2?=
 =?utf-8?B?NVVoQVRIZ0lhcERsK2h1VE8rL2N6NWMzaW9YOGRyUzBkcmE5VVlkUnFKRlYv?=
 =?utf-8?B?c2VyNVZvNWdqOURDa09xRTJXRkxOWFp4a1hQZGkvRmRBdXU0ZlVMWG41VGJl?=
 =?utf-8?B?SXluMG1TMHR0T2oxdmQrMk1obmpid0FBYkNMcHh5OXQ4TE9HRCs2dmxReDlR?=
 =?utf-8?B?bzhLNCtSTzdXSEhsNVFZblRhOUdaU0lPSE8rU3pBR1VWT2s2SlF0SnFmMHRv?=
 =?utf-8?Q?lmjToEST3Z75TCcceGQGJTj0O?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f181fe35-081c-4815-f3bc-08dc86d1171a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 09:06:17.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkoTDf5eiRYqX1hBx9pm1SIyfd+rSDrDQZ/e/KGl4wMvq8h8Wuk9A/7f0ALMjtlFLeVxYSMfK98I+URaUbewCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8422
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 09:06:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16133

On 05.06.24 17:40, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This script creates job definitions from the template files included in
> the test directory and shall submit these jobs to CIP LAVA platform. This
> script will wait until all the results of all the submitted jobs are obtained.
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  scripts/submit_lava.sh | 464 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 464 insertions(+)
>  create mode 100755 scripts/submit_lava.sh
> 
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> new file mode 100755
> index 0000000..e9d89dc
> --- /dev/null
> +++ b/scripts/submit_lava.sh
> @@ -0,0 +1,464 @@

Something is fishy here: This claims to provide 464 new lines of code...

> +#!/bin/bash
> +# Copyright (C) 2024, Renesas Electronics Europe GmbH
> +# Chris Paterson <chris.paterson2@renesas.com>
> +# Sai Ashrith <sai.sathujoda@toshiba-tsip.com>
> +################################################################################
> +
> +set -e
> +
> +################################################################################
> +LAVA_TEMPLATES="tests/templates"
> +LAVA_JOBS_URL="https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/scheduler/job"
> +LAVA_API_URL="https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/api/v0.2"
> +LAVACLI_ARGS="--uri https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/RPC2"
> +SQUAD_GROUP="cip-core"
> +SQUAD_WATCH_JOBS_URL="${CIP_SQUAD_URL}/api/watchjob"
> +SQUAD_LAVA_BACKEND="${CIP_SQUAD_LAVA_BACKEND:-cip}"
> +PROJECT_URL="https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core"
> +WORK_DIR=$(pwd)
> +RESULTS_DIR="$WORK_DIR/results"
> +ERROR=false
> +TEST=$1
> +COMMIT_REF=$2
> +RELEASE=$3
> +COMMIT_BRANCH=$4
> +
> +if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
> +
> +# Create a dictionary to handle image arguments based on architecture
> +declare -A image_args
> +image_args[amd64]="-cpu qemu64 -machine q35,accel=tcg  -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
> +image_args[arm64]="-cpu cortex-a57 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
> +image_args[arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
> +
> +set_up (){
> +	echo "Installing dependencies to run this script..."
> +	sudo apt update && sudo apt install -y --no-install-recommends lavacli curl
> +	job_dir="$(mktemp -d)"
> +}
> +
> +clean_up () {
> +	rm -rf "$job_dir"
> +}
> +
> +# This method is called only for arm64 and arm targets while building job definitions
> +add_firmware_artifacts () {
> +	sed -i "s@#Firmware#@firmware:@g" "$2"
> +	sed -i "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" "$2"
> +	sed -i "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/qemu-${1}/firmware.bin@g" "$2"
> +}
> +
> +# This method creates LAVA job definitions for QEMU amd64, arm64 and armhf
> +# The created job definitions test SWUpdate, Secureboot and IEC layer
> +create_jobs () {
> +	if [ "$1" = "IEC_Layer_test" ]; then
> +		for arch in amd64 arm64 arm
> +		do
> +			cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}"/IEC_${arch}.yml
> +
> +			if [ $arch != amd64 ]; then
> +				add_firmware_artifacts $arch "${job_dir}"/IEC_${arch}.yml
> +			fi
> +		done
> +
> +	elif [ "$1" = "software_update_test" ]; then
> +		if [ -z "$2" ]; then
> +			for arch in amd64 arm64 arm
> +			do
> +				cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/swupdate_${arch}.yml
> +
> +				if [ $arch != amd64 ]; then
> +					add_firmware_artifacts $arch "${job_dir}"/swupdate_${arch}.yml
> +				fi
> +			done
> +		else
> +			cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/"${2}"_amd64.yml
> +			sed -i "s@software update testing@${2}@g" "${job_dir}"/"${2}"_amd64.yml
> +			sed -i "s@) = 2@) = 0@g" "${job_dir}"/"${2}"_amd64.yml
> +			if [ "$2" = "kernel_panic" ]; then
> +				sed -i "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" "${job_dir}"/"${2}"_amd64.yml
> +			else
> +				sed -i "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" "${job_dir}"/"${2}"_amd64.yml
> +				sed -i "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" "${job_dir}"/"${2}"_amd64.yml
> +			fi
> +		fi
> +	else
> +		for arch in amd64 arm64 arm
> +		do
> +			cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}"/secureboot_${arch}.yml
> +
> +			if [ $arch != amd64 ]; then
> +				add_firmware_artifacts $arch "${job_dir}"/secureboot_${arch}.yml
> +			fi
> +		done
> +	fi
> +
> +	if [ "$2" = "kernel_panic" ]; then
> +		sed -i "s@#branch#@maintain-lava-artifact@g" "${job_dir}"/"${2}"_amd64.yml
> +	elif [ "$2" = "kernel_panic" ]; then
> +		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/"${2}"_amd64.yml
> +	else
> +		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/*.yml
> +	fi
> +	sed -i "s@#distribution#@${release}@g" "${job_dir}"/*.yml
> +	sed -i "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
> +
> +	for arch in amd64 arm64 arm
> +	do
> +		sed -i "s@#architecture#@${arch}@g" "${job_dir}"/*${arch}.yml
> +		sed -i "s@#imageargs#@${image_args[$arch]}@g" "${job_dir}"/*${arch}.yml
> +	done
> +}
> +
> +create_cip_core_jobs () {
> +	if [ "$TEST" = "IEC" ]; then
> +		create_jobs IEC_Layer_test
> +	elif [ "$TEST" = "swupdate" ]; then
> +		create_jobs software_update_test
> +		create_jobs software_update_test kernel_panic
> +		create_jobs software_update_test initramfs_crash
> +	else
> +		create_jobs secure_boot_test
> +	fi
> +}
> +
> +# This method attaches SQUAD watch job to the submitted LAVA job
> +# $1: LAVA Job ID
> +submit_squad_watch_job(){
> +# SQUAD watch job submission
> +	local ret
> +	if [ -z ${CIP_SQUAD_LAB_TOKEN+x} ]; then
> +		echo "SQUAD_LAB_TOKEN not found, omitting SQUAD results reporting!"
> +		return 0
> +	fi
> +
> +	if [ "$TEST" = "swupdate" ]; then
> +		squad_project="swupdate-testing"
> +	elif [ "$TEST" = "secure-boot" ]; then
> +		squad_project="secure-boot-testing"
> +	else
> +		squad_project="iec-layer-testing"
> +	fi
> +
> +	local DEVICE=$2
> +	local ENV="${DEVICE}_${squad_project}"
> +	local squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${squad_project}/${COMMIT_REF}/${ENV}"
> +	ret=$(curl -s \
> +		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
> +		--form backend="$SQUAD_LAVA_BACKEND" \
> +		--form testjob_id="$1" \
> +		--form metadata='{"device": "'${DEVICE}'", "CI pipeline": "'${CI_PIPELINE_URL}'", "CI job": "'${CI_JOB_URL}'"}' \
> +		"$squad_url")
> +
> +	if [[ $ret != [0-9]* ]]
> +	then
> +		echo "Something went wrong with SQUAD watch job submission. SQUAD returned:"
> +		echo "${ret}"
> +		echo "SQUAD URL: ${squad_url}"
> +		echo "SQUAD Backend: ${SQUAD_LAVA_BACKEND}"
> +		echo "LAVA Job Id: $1"
> +	else
> +		echo "SQUAD watch job submitted successfully as #${ret}."
> +	fi
> +}
> +
> +# $1: Job definition file
> +submit_job() {
> +        # Make sure yaml file exists
> +	if [ -f "$1" ]; then
> +		echo "Submitting $1 to LAVA master..."
> +		# Catch error that occurs if invalid yaml file is submitted
> +		local ret=$(lavacli $LAVACLI_ARGS jobs submit "$1") || error=true
> +
> +		if [[ $ret != [0-9]* ]]
> +		then
> +			echo "Something went wrong with job submission. LAVA returned:"
> +			echo "${ret}"
> +		else
> +			echo "Job submitted successfully as #${ret}."
> +
> +			local lavacli_output=${job_dir}/lavacli_output
> +			lavacli $LAVACLI_ARGS jobs show "${ret}" \
> +				> "$lavacli_output"
> +
> +			local status=$(cat "$lavacli_output" \
> +				| grep "state" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			STATUS[${ret}]=$status
> +
> +			local health=$(cat "$lavacli_output" \
> +				| grep "Health" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			HEALTH[${ret}]=$health
> +
> +			local device_type=$(cat "$lavacli_output" \
> +				| grep "device-type" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			DEVICE_TYPE[${ret}]=$device_type
> +
> +			local device=$(cat "$lavacli_output" \
> +				| grep "device      :" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			DEVICE[${ret}]=$device
> +
> +			local test=$(cat "$lavacli_output" \
> +				| grep "description" \
> +				| rev | cut -d "_" -f 1 | rev)
> +			TEST[${ret}]=$test
> +
> +			submit_squad_watch_job "${ret}" "${device}"
> +
> +			JOBS+=("${ret}")
> +
> +		fi
> +	fi
> +}
> +
> +# $1: Device-type to search for
> +is_device_online () {
> +	local lavacli_output=${job_dir}/lavacli_output
> +
> +	# Get list of all devices
> +	lavacli $LAVACLI_ARGS devices list > "$lavacli_output"
> +
> +	# Count the number of online devices
> +	local count=$(grep "(${1})" "$lavacli_output" | grep -c "Good")
> +	echo "There are currently $count \"${1}\" devices online."
> +
> +	if [ "$count" -gt 0 ]; then
> +		return 0
> +	fi
> +	return 1
> +}
> +
> +submit_jobs () {
> +	local ret=0
> +	for JOB in "${job_dir}"/*.yml; do
> +		local device=$(grep device_type "$JOB" | cut -d ":" -f 2 | awk '{$1=$1};1')
> +		if is_device_online "$device"; then
> +			submit_job "$JOB"
> +		else
> +			echo "Refusing to submit test job as there are no suitable devices available."
> +			ret=1
> +		fi
> +	done
> +	return $ret
> +}
> +
> +# This method is added with the intention to check if all the jobs are valid before submit
> +# If even a single definition is found to be invalid, then no job shall be submitted until
> +# it is fixed by the maintainer
> +validate_jobs () {
> +	local ret=0
> +	for JOB in "${job_dir}"/*.yml; do
> +		if lavacli $LAVACLI_ARGS jobs validate "$JOB"; then
> +			echo "$JOB is a valid definition"
> +		else
> +			echo "$JOB is not a valid definition"
> +			ret=1
> +		fi
> +	done
> +	return $ret
> +}
> +
> +check_if_all_finished () {
> +	for i in "${JOBS[@]}"; do
> +		if [ "${STATUS[$i]}" != "Finished" ]; then
> +			return 1
> +		fi
> +	done
> +	return 0
> +}
> +
> +check_for_test_error () {
> +	for i in "${JOBS[@]}"; do
> +		if [ "${HEALTH[$i]}" != "Complete" ]; then
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
> +# $1: LAVA job ID to show results for
> +get_test_result () {
> +	if [ -n "${1}" ]; then
> +		lavacli "$LAVACLI_ARGS" results "${1}"
> +	fi
> +}
> +
> +get_junit_test_results () {
> +	mkdir -p "${RESULTS_DIR}"
> +	for i in "${JOBS[@]}"; do
> +		curl -s -o "${RESULTS_DIR}"/results_"$i".xml "${LAVA_API_URL}"/jobs/"$i"/junit/
> +	done
> +}
> +
> +# $1: Test to print before job summaries
> +# $2: Set to true to print results for each job
> +print_status () {
> +	if [ -z "${1}" ]; then
> +	# Set default text
> +		local message="Current job status:"
> +	else
> +		local message="${1}"
> +	fi
> +
> +	echo "------------------------------"
> +	echo "${message}"
> +	echo "------------------------------"
> +	for i in "${JOBS[@]}"; do
> +		echo "Job #$i: ${STATUS[$i]}"
> +		echo "Health: ${HEALTH[$i]}"
> +		echo "Device Type: ${DEVICE_TYPE[$i]}"
> +		echo "Device: ${DEVICE[$i]}"
> +		echo "Test: ${TEST[$i]}"
> +		echo "URL: ${LAVA_JOBS_URL}/$i"
> +		if [ -n "${2}" ]; then
> +			get_test_result "$i"
> +		fi
> +		echo " "
> +	done
> +}
> +
> +print_summary () {
> +	echo "------------------------------"
> +	echo "Job Summary"
> +	echo "------------------------------"
> +	for i in "${JOBS[@]}"
> +	do
> +		echo "Job #${i} ${STATUS[$i]}. Job health: ${HEALTH[$i]}. URL: ${LAVA_JOBS_URL}/${i}"
> +	done
> +}
> +
> +check_status () {
> +	if [ -n "$TEST_TIMEOUT" ]; then
> +		# Current time + timeout time
> +		local end_time=$(date +%s -d "+ $TEST_TIMEOUT min")
> +	fi
> +
> +	local error=false
> +
> +	if [ ${#JOBS[@]} -ne 0 ]
> +	then
> +
> +		print_status "Current job status:"
> +		while true
> +		do
> +			# Get latest status
> +			for i in "${JOBS[@]}"
> +			do
> +				if [ "${STATUS[$i]}" != "Finished" ]
> +				then
> +					local lavacli_output=${job_dir}/lavacli_output
> +					lavacli $LAVACLI_ARGS jobs show "$i" \
> +						> "$lavacli_output"
> +
> +					local status=$(cat "$lavacli_output" \
> +						| grep "state" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +
> +					local health=$(cat "$lavacli_output" \
> +						| grep "Health" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +					HEALTH[$i]=$health
> +
> +					local device_type=$(cat "$lavacli_output" \
> +						| grep "device-type" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +					DEVICE_TYPE[$i]=$device_type
> +
> +					local device=$(cat "$lavacli_output" \
> +						| grep "device      :" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +					DEVICE[$i]=$device
> +
> +					if [ "${STATUS[$i]}" != "$status" ]; then
> +						STATUS[$i]=$status
> +
> +						# Something has changed
> +						print_status "Current job status:"
> +					else
> +						STATUS[$i]=$status
> +					fi
> +				fi
> +			done
> +
> +			if check_if_all_finished; then
> +				break
> +			fi
> +
> +			if [ -n "$TEST_TIMEOUT" ]; then
> +				# Check timeout
> +				local now=$(date +%s)
> +				if [ "$now" -ge "$end_time" ]; then
> +					echo "Timed out waiting for test jobs to complete"
> +					error=true
> +					break
> +				fi
> +			fi
> +
> +			# Wait to avoid spamming the server too hard
> +			sleep 60
> +		done
> +
> +		if check_if_all_finished; then
> +			# Print job outcome
> +			print_status "Final job status:" true
> +
> +			if check_for_test_error; then
> +				error=true
> +			fi
> +		fi
> +	fi
> +
> +	if $error; then
> +		echo "---------------------"
> +		echo "Errors during testing"
> +		echo "---------------------"
> +		print_summary
> +		clean_up
> +		return 1
> +	fi
> +
> +	echo "-----------------------------------"
> +	echo "All submitted tests were successful"
> +	echo "-----------------------------------"
> +	print_summary
> +	return 0
> +}
> +
> +set_up
> +create_cip_core_jobs
> +
> +if ! validate_jobs; then
> +	clean_up
> +	exit 1
> +fi
> +
> +if ! submit_jobs; then
> +        clean_up
> +        exit 1
> +fi
> +
> +if ! $SUBMIT_ONLY; then
> +	if ! check_status; then
> +		ERROR=true
> +	fi
> +
> +	get_junit_test_results
> +fi
> +
> +clean_up
> +
> +if $ERROR; then
> +	exit 1
> +fi

...but the code ends at 463. Are we missing a line in the middle
(critical) or just something irrelevant here at the end? Please check.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


