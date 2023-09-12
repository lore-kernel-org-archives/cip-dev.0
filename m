Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC87CA0ECD
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 03:09:02 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.77])
 by mx.groups.io with SMTP id smtpd.web11.17316.1694488141218709363
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 20:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=muWjDQx4;
 spf=pass (domain: siemens.com, ip: 40.107.21.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g420cwm39b6llVOvwtOnizHoaJn9cSg+CDsAQmBpboz0CEPBBjwrUQWG02/i8C919Z354lljKeJGYZQQ2tAGot4otPTC3Q3LVxeeEM+bzVYXJjt+3O5QfPLU1ZPVenGiNCgz67YmKkiDQMozK82KrrpBqhKulPRqn2+QZ0uY2U9HYOxJfTjWumerCmkI6BNdyJNecw83j2cF/GZwMDzq6nf3KfLTgPUTGIxpY3pTOVpxyjYMuq7514bE/z2M6hmf8Z+PZwEF881n1/Q/kI86fl3Z6nbXbCRI+k+gh1wHhwLrEkhNT/teg8ID/qPc3dFkAW55NZObQ2xG8j6pmmDLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRYZd2yAdtdpSK62agl0Cbp4MP9dRTfijvPvYZby/So=;
 b=XDBDlGw7EM0aF6GFBxRi+CopB9nCRV4ciAxrOHi7aTAOIs5PYuoKoaHcN6hMS+wlDGyZpRAFQ/gM4zSyi+9KhLiIgjjxlE/BQcyQouXoHr4sJ/EdWpXo2j8vK02AHYjCz8VFSLOdRdDteRNqy6+GgDcBu+uL3YPOR46Wn0qhdetNJeWUV0BTZqR+uB6/a0sk1qaQOu/cqQv21+8fXuHufjnla9E90LsSVqW5VSXpSFoQbW03JSGg+lPiS3AxXEreEs6m6akTfltjImkxLSwUo7I6IHAZrrbGUKvaWVB2lZXKbSAUod6ORhs/b0w1FdWoz7gt4A9rJRnpyDyky3dVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRYZd2yAdtdpSK62agl0Cbp4MP9dRTfijvPvYZby/So=;
 b=muWjDQx4M9fbjPyvZZb8yji/FNLMsftli/GmHF/cIRWS4exLbe6qsEUSXUi50vyxcpC8exm9saPdpaYlZzn6IZUVDoDPoyvlewUs3PVSwrXqt9qcTQRyzy/U8sytooZy+MqQCdgdTrP9gQQ4csgFTAMaRML37/Qb9CmZTsuKyodhFlzjN3+lF5Hk7Q74cx/wUDwV86FVYrtfhDT3ZPWbVCoGMKcsDE0RORUM4lTV85Hsbe0lIJU65eKA5G15auheh6Z5i2EpX7WAhRp1EO9LVQ5haBh/nNkUpMGRhRaJ/Peb0VWur9Owpw7HgM8oKh7YA+DbysPy3mPosCJygZdCzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5377.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 03:08:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 03:08:57 +0000
Message-ID: <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
Date: Tue, 12 Sep 2023 08:38:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
 <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d79f01e-efec-4a9a-c7c0-08dbb33d9a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qaPEkwJ2k8onwGqH/I5Nh0qSxiT48wEblXiTuJ9cG7wZB9/8p16nbiDB+wB2GAv7vkCp/GECmImmOHY76OXAnzdUb50lg+OiZ9HP4weZamEYPCAEwJjdkNs+epA9QPJNBAy7L51sSozb4bMPST7zWQGrh5zkHKLhxEdfNpGlIOxbWfP7NQbET2/iza8Dti3dWgpUpr2UbiArD3jeDzrRa4Ljy41RW1oFTB+fFGoTaYE3eM5CcMnb/eKmUQg3yVGoeiYLxOHw17ttRGljbmail2Sj60L9hQhzpxPFNaojW8bh0nzBZyCOhPjIsMTcCsyf+w5ZPp9Qlnh33QjL78LsuTNUn69FhHOXwg4lEjxpjm2qtZ6tz/EZv6DAKDxeLh845e49jh2c+da91IerdEf/DFHnVXoItzwd+VbE02+0VGs3pm0PuHkKIojvuS1JZr1f4yxo213oOVTdbQ9pe+hHralJFzaEVZ+L+i8GUCL8gcZHMbeUrE4RFGme098i3pNHnJ2vyXjoFFH4Dm20mGBkxSwfAU+Kd3Otwh2+p8uZefgxIBN7DoATIUV7IQiYLr9sTXzxZonsxxFWxYdSQCXOq6Cpcu1D+TuccvBbqU/aTeQOcM1knXXoFNGz4hRW80uUdC68K1Gu9eEuhI/NlsbryA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(26005)(2616005)(5660300002)(31686004)(6512007)(44832011)(2906002)(53546011)(31696002)(41300700001)(6486002)(6506007)(66476007)(66946007)(82960400001)(38100700002)(66556008)(6666004)(316002)(478600001)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckg1QVZMR0twK0UyNFdnWU9UMS9DYU1nd296TFRuL0pUZTdGYitvdjZSUjVO?=
 =?utf-8?B?blc5UUZyTGg1MjVOcUlBWFpqbXFZbS9nTFJaVmZlZTNxNDE0NWoyOVB5SXUx?=
 =?utf-8?B?bEVkbHpsb3FHL1BRaTZrM1dGTWpuK04vNFNkMnJySnFXRDBOaFgyNTJXdDR4?=
 =?utf-8?B?clRRMWtJUnlLZlRueW92WjVLREhHVGEzSXd3RVBlU05jWGZWREd3b2s1QmdG?=
 =?utf-8?B?bDc3YXlJVEhweGNHckRSN080TzRkUm9vR0lwZnZnbGZ0cndNakFTRUJsV0I5?=
 =?utf-8?B?YStnUjFLeTJWUkw5akJpNlcyclJPcVdVNytMVzJFUmx4UHlBTktwSEF4V0h5?=
 =?utf-8?B?RUJGWEtnWXE4VWgyeWRFdGpXQzBZZ0lvU0d0KzNpY1J4WTBkK2dnZnFuN29M?=
 =?utf-8?B?M0pWemMwNmxaVjFlNTVpWE80L3NVSVJNbmFoaWFvdC9PVzVWSVcwU3BTYnFE?=
 =?utf-8?B?REhsOG9PYk5qVEM2ZWhNODFQMTErdWRZS1o3SWlQZnFYcFR4T2RPQy9mSko0?=
 =?utf-8?B?a0dHeUx4MXBWWnpBazl0TkRvcmwxc3ZQVVo4TEkveSs1NnlYcXZOY2NMWkVo?=
 =?utf-8?B?Z1hlV3E4OUZtS2xzRjJSeGxzcWhlcys1bk1oQm15TVhwZTV6bGFJeFdlL0l2?=
 =?utf-8?B?WDZ0WWREWFFlaWw2cUw4eVZIeUdzMW9HeWR6Zm4yK0lxT0prK3FFRkZGcEhn?=
 =?utf-8?B?bzJySGJ1RDFBVlJHbU9Cd2pqelNadnk1dkdNL2ZXWmdFQlpiaGJTNCtzeUdv?=
 =?utf-8?B?TGowV0JoelpINllueDdxODZNZUtUZGlzSmQ1blQxMmF5QVZNS3YxTXpZeUx1?=
 =?utf-8?B?RjA2d1B5RXhQOTdQbkJUWU5iRzlhQVNQbDFZVmVGdnVLa0dJa0sxTHpGQlBE?=
 =?utf-8?B?K1pkQ3Z0a0EvTDVrNDJ4NjE1bnF2M1FXajVHbmNCVzcrQnJZMU9FVmhFcW84?=
 =?utf-8?B?R2s4RDg3R2ZFbFZleUJ5OSt6aFdLOG5qekxJSWFqL3hpY2VzTG9jUGxuTHNy?=
 =?utf-8?B?VVNidEhkRnpHUEJUMEJtclZoSStzMlJoVDRZVzRMdHAvcnZVV0lrZ052S1VX?=
 =?utf-8?B?em83TmZSVytIYjJRSzRvT1BDNG9lVWVvdllrUGx6aGE4SjNyd0xuMS8yVUM0?=
 =?utf-8?B?WkVucnY3dHlZVWs2MzZrTFJTWUxMMkNJNWVTd2hDK0dObGhNTDFWVnlyb0RH?=
 =?utf-8?B?RS92T0wvdHVqVXZmU1pCOFkrdjJXWHZHY0pFWDhaa25la0ptNkV0NU1SeE1W?=
 =?utf-8?B?MEdMSnppakpLbEVwa0MzNEZaOWh0OXJTYm1HbUFJM0JOSVlmT1VkSUo5ZFMx?=
 =?utf-8?B?Q0N4SHEvS1JjaE1IUE80Y0FXVUtIeEFSTlBtL0h5ZFdraHlHcmxWVnhHdzQz?=
 =?utf-8?B?VXJ0Q2R1OXVFVDh1QUV2ZTkwZEZjYjlCdXluTjJ1QWMydHFMTU9BWlVncksv?=
 =?utf-8?B?QkYwNlJhTTZSYnc5UFprT0NtdTJhYUdDc1owNjVxTHZhYlk5YU9OVUVBOFRa?=
 =?utf-8?B?cnVtVDRNa0hKTHBFSzRiYlZhTU1Gck82aEJsM3RFb3RjbGpNSkdiU2Z5QmZX?=
 =?utf-8?B?WUV6dW9SM01RRXRvaEhsNlI5UEJaek54bEhaVHFBNkNRNW84N3RWRFR5SXpR?=
 =?utf-8?B?c3IzTkEvUEpqRE1VM2s1OWFlaVJFVStVbVpKbG9pa1RjYzhTelYrMzA0djlw?=
 =?utf-8?B?R2RUaG04eU1INUxnQjQyNjhpaGpjV1JxMFFmdFpjYTB1Z3FQOUFxSG9UbWpp?=
 =?utf-8?B?bDRqUml6OHl0dGY2NUFnRWxEQ0NRUTUwOWVPRmNVMTVKcDZ3ZjJSbEM2dW1y?=
 =?utf-8?B?T0w5a2FPR1l1N1FVZHRlYWlLWHBQRFpaWWp6YjlNNTk4VGJFQXE5QWVndHhV?=
 =?utf-8?B?eE1VbXhzODdNaElnaWNIb2QwZWoxL2RKejFZanhaVnNveTJmL0hiR29YOUdE?=
 =?utf-8?B?WHNUVVBmSnRXOFNrcVdkd1pZMVcveXpjMzFpQm0vei9hSkR0RGtLMzMvSmF5?=
 =?utf-8?B?L2VteGhDZXZJWHRWQzM3eWVrTHYza0JlZHkzaWlha1c0eEpGalJwSFZrMVhJ?=
 =?utf-8?B?c0xEUVR4UlUvWXU0RkxZQ2ovOFBWd0VtYzUwZm5iUms1a0UyNHpEWjZLdzZ5?=
 =?utf-8?B?cWRKSDYxUy9SS3VFNHMyWUVTZUZlMEt4bVN3WHN3Tk9NcHNkRHdWd0NyTzYz?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d79f01e-efec-4a9a-c7c0-08dbb33d9a4c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 03:08:57.1939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUPHRvVztqki2ojLeRr34smJlCFw0IejByjSNyUDhQ+2K+5asl9yhNz4i4QQKv5AHdRmjOnElbBtSbDDYtcSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5377
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 03:09:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13055

On 11.09.23 19:01, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 

Which additional aspects of reproducibility does this target test?

Jan

> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .reproducible-check-ci.yml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
> index dec28e2..6bcc215 100644
> --- a/.reproducible-check-ci.yml
> +++ b/.reproducible-check-ci.yml
> @@ -87,6 +87,13 @@ build:qemu-arm-repro-build:
>    variables:
>      target: qemu-arm
>  
> +build:bbb-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: bbb
> +    extension: "none"
> +
>  # repro build test
>  test:qemu-amd64-repro-test:
>    extends:
> @@ -111,3 +118,12 @@ test:qemu-arm-repro-test:
>      target: qemu-arm
>    dependencies:
>      - build:qemu-arm-repro-build
> +
> +test:bbb-repro-test:
> +  extends:
> +    - .repro-test
> +  variables:
> +    target: bbb
> +    extension: "none"
> +  dependencies:
> +    - build:bbb-repro-build

-- 
Siemens AG, Technology
Linux Expert Center


