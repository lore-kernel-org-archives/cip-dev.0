Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD61C61DA4
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 11:05:39 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.85])
 by mx.groups.io with SMTP id smtpd.web10.7990.1675422335484175259
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 03:05:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qiQ2kUkF;
 spf=pass (domain: siemens.com, ip: 40.107.14.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBLyJK1u06X4c7JKjGaKOL1h4mPsyEzYJIqoLN7vhUvSH893Va2Wa7WWkILY3KvYVwYSHdWfGW0554MW4tfC33oZI7wUaf79VuuvcrNX3mRm6x58F4WgAbTKbBshzsKr4Do80C9jMRs6PzNQ+jcifdZKtvtKOxgB43SENGGGStDZBj0snSZtcDZ2GRbCWVVziNlXJEWY30tCECxa269ZqAtUofs2cZJhPII00PrqZiZzztHLGtTC9+/tSdSvfp2BjYhhhNEdVw5GUs5VWkMOEgxJNVc0QumaYl+vL7CgNTBvk7nUBL+C5+DWt9fSSGHYFaV7viVQvxbX06g04oOieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvQDH/Nv2KFMEM6w4vXad5XDGXsNc9JziFD6j9NYjJU=;
 b=FhpQcwQl1mzlyNstzxYbYAVGvHtKM5KWCKkx8JAIC590mx7yEFYrMdA6YKbFGuoBWJlroqvRKiLO6Hj7CjWYTKsdaafp60aSC5rfLwZ42Nhgi7YBFNdF9vD5nY3F28Ejx+oMWIyJbS+zf1bUr/eo+OW8AjMvyHthmAAdGF4eI+kpjoPA4gtzrGtCf3t4QM+fhTY2w73M1d9j1RnUhjVCLV6VCd3jUbxMvGUYwpWfN5/i+K3p7w7+/OB7BGG2R9ddOdKQH9X3aOeqN/UhrIGhU1F6avqEgFnetQLTyZIWgXJilX/uoYs8IsOow7x67AingklwuMRRqIZiGCuvl5InPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvQDH/Nv2KFMEM6w4vXad5XDGXsNc9JziFD6j9NYjJU=;
 b=qiQ2kUkF7sprJoPaQpeGK8g2XXnNDmiMs8jxL9Z+3vNakGM3DeKNRFOI1WDyvuTaBCHcmcirFhU5o5sAsLL9cG3I2hwfl/XnlyM3Pvb4nROpgnALohheDm4pqdS0W88GFl1iKkEuSlyJIXKBLwxWy2oN8fISUSSx4c/ndX8XnB/6QOUMpg4+zMr1AADx3bHxvAq2RE8gmoaAL827y8qErd0A7tfW4+KvMz7nRYu2ymhRqcVKCSvBhZWnwIhqtbnm5Qmvfcib0BIObuu8nG+LELZWgB40xPq8YCcJBG5bvdaccdtUbjAC391Iomem4RGVrVy30BtQNQ5axs+82f1fXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6633.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 11:05:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Fri, 3 Feb 2023
 11:05:32 +0000
Message-ID: <cf0d1b16-fb3d-454b-5fd6-fa6f33a7ddeb@siemens.com>
Date: Fri, 3 Feb 2023 12:05:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 2/2] conf/distro: Delete
 debian-sid.list
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230203105142.367778-1-Quirin.Gylstorff@siemens.com>
 <20230203105142.367778-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230203105142.367778-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: d28fb892-29c8-4913-9c29-08db05d69103
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TKASfpjJvjOREtJEHQ5+X2UVurlo15vsD+CwM6CKHaiM//ey44Plx+az/gdiRH2P9xaxkE5HJHdd8lunq0i+ODB9qy9jq47waBvyG/8NAwx+uiY4EySwif2f2F0C6IYLnwiJ0bI32+UhPnwbOWQlwgkTu2gskH8kkNsUaM+fSh22KJMjsy02LdAMs4jUN6XQi9doWDF3LVJe+nO9160PRwgAehY2eMLqKM9PIvGxGM7eE5uuwxhkO0ltG3hTIjKDVlEcAeQEL0XGKOlLfR5rscKqsn7DVePQWf8YzjdhiS+M9t0+9cGqCVpLAWa4zKp8vk6H7B8ACWikpN2017lj3vuuMMO0yHpBrnNXTcWppTaJDKxkRrmQVtsUpNi487EsHF/pxySBQxwJub85CsIzWjmvR6heSOUxO753Z/gUMR5Aw7XUQrDsRh5WviYBKHcst29PhN9s1antRxwVSCWEHGlZbWRKOS1cp0iP9jBXw4LEFMZwEzAxrO5pkkGZ5AxOYQJVhF9OxPUZWpCVeskBr/4Mc6SXI0O48VSqnGjRt/wAQiCxX59Ae/VDhidJ7wDWriwbZAuTDCN05lqD1g/4nBfRZVuxWeVp5uBKHWbyDvWSy2hUGpWB9uCgSmrNShRxmfry/mRcFynHoaFzNkswRsTJcdU21mzgYB/XJF5WWNOW3Li14HD1nrZBpTDuMCM+VxgD5gXIBhB2pqXzjol+WmkEYK8NtxY+GipvSfEvjsYLqLM2Pbk8dH8fbZ6wFt51tV/UjQk57RPDP+0X5DCfbQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(31686004)(2906002)(38100700002)(44832011)(4744005)(82960400001)(8936002)(5660300002)(31696002)(41300700001)(8676002)(83380400001)(36756003)(2616005)(66476007)(66556008)(66946007)(86362001)(316002)(186003)(26005)(6666004)(53546011)(966005)(6486002)(6506007)(478600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFZYUjZLN241QUJFN25VUlFPYmJzd1Q4ZFZyMllhK3gwR0lIRGQyNlREYnk2?=
 =?utf-8?B?M2JuRWxUTFJJT3EwcWRCNjRWTEVMb2tpMlVVVHJWQVcxcklpbDQxUmdrcFNo?=
 =?utf-8?B?NHdMSUlRVloyK2dmOHQxdFp4MkZJMCtBRklUaE1JSEhqaER1YUNVMlhQbzBN?=
 =?utf-8?B?OGpNMzRhT05xTm4yYUFNdnJOUnUvUkxXZEtHRkJlaGs5bGRCNW1Ua0h6NjJu?=
 =?utf-8?B?bTFHNWxqeVVxOHlHYlJORTVBbFh3elNSRUg3bGpHNUdRdnIzVVdaZ0NIR2hL?=
 =?utf-8?B?aHlCQTA2Q1BicDVKNGoyUW1NVUZDTE93QjlYSFVWMG9GWWc5a2lTQURwYTFa?=
 =?utf-8?B?STNhLzJVQlgyQkNHTWpuMmRwdFJDZzNwME1COUR5V2hYb1Y0WUJncy9UVS9J?=
 =?utf-8?B?NnoyNjQyeEpVdXhDWmEzWnV3eFR6blE4TU5NNTg4OWdXNzdvNDd0UDBaa0Rq?=
 =?utf-8?B?QUt1cWszbEYwcVJIVFZyQkRXNExMKzZhdXdlSktuSnVtM29lRlZ2T0I3Zlkr?=
 =?utf-8?B?T2dTR2xkbjIvMTBWaVpIaG02RWVoZjRoVllsVXcyZVQwVHhuUTc0SVNQUlRr?=
 =?utf-8?B?MFR0YkJTVy9XUVFZZmdGM2ZwOGJhMmphOXNNQmtiR1Z0UHl4Sm1pUmQ5dVR5?=
 =?utf-8?B?UzV6SVpEUXYvUXdPUndLWXZpNUwwd1VxT1FScFFZdjRheCt3aGMveFhua1NJ?=
 =?utf-8?B?WUpLWWNGcjlySmpBTjFsVDJBdWcxOG41b25VYU1zYTlQYWxTR3lHellweWl1?=
 =?utf-8?B?UXBpZzl0UXAvT2c2eUpZbTRablFRcmIrMmdVY3RyanRjOHkzYVBCZHNSRmFw?=
 =?utf-8?B?SVZ3VHNXKzdrWHZYM3U1VUhxc3ZaOVZZNkN6Mk9pendKaE1ERXNLNlR3aFV5?=
 =?utf-8?B?Y01HRTNrTUx2bkRZZ0ROQ01hVWpJZ0xLNVNWT0JYcnlmQXV0N2kxdVloeUhC?=
 =?utf-8?B?UUlVQythRGZEYkJPUng0eWkvaUNEZmk0M09vTGlITGxjMVhWampNSXl5MlB5?=
 =?utf-8?B?dUFvcWR6VDNnUVVOb2gvMWI4Y1AxeFk0d0tlNWpyZ3Z3TlMwYXpNZUNua3Rj?=
 =?utf-8?B?UlpzZTJZMjZWKzZQdi94RzhGaWROaUZ2TW1Sa1FIYTMwaHZrK3dXWHdDeUhT?=
 =?utf-8?B?ZjlyR1pqQWJnSWhVRW9jZjVucEJXSi9QY1FUYVZ4RHZxa0hEK3d5ZE1nQXpX?=
 =?utf-8?B?UDBGekNFTnBPN3NwU2lVRklvb0paVW5RN1FBWWFzR0FxR2ZXTE1YeDNEVnQ5?=
 =?utf-8?B?Y2ZuT2dRb01BU3BoMFE3cmcwWnBOVFlheUcwcWNOUFRSWlVoaXNuamM5Q1p6?=
 =?utf-8?B?QTRFRjNTbmxyVmxMVkFpMTdLYmo4ck5WcVZmc1NwUmdXMG4xTHU4TzVrNERK?=
 =?utf-8?B?NjhMMVZtalNlamNsY2gzSkRIZG1KcnpuSUNVcHFrVjlsNTRFaUIwbEo2ckFQ?=
 =?utf-8?B?ZmtDNEdNTnJBNUM3a3puOXROWDhqQXc3YTluWFVBY2V6WlJ5ZWF5SUR0cEFo?=
 =?utf-8?B?VTJlTUlXYmhxTDlsNzlqbG1rZWhjVE16SDFxZ053RzZnaHorMUJ3S0JidWIr?=
 =?utf-8?B?dEVqZVFkakdIbmt3TzRVSlVWM3NWcjJPVjZTUS81U3QwNkhIN2R1M2RKd3V5?=
 =?utf-8?B?eDIyM281Q0p4bzZUb1k4V2NiY2NSSzdoekhseG8xREdDOEtSbDJCZnlGdk1m?=
 =?utf-8?B?QmowbDBHR0d3eG9NdUNYSFhCODZBQkRHNmNLOXQzajdHVDBTdUZqOXpMVUsw?=
 =?utf-8?B?aUZuak5KeFJMT0hEM1R1WmYxWFNyc1lqc05aTEpaa1lnc0w4ZGZaUmhCaTBR?=
 =?utf-8?B?M0d3SFdINDhOMGp4ZmFrUHVlZUVtUUozUnVQSGZGOUhEY1J4U2Rma3NLYWts?=
 =?utf-8?B?L3I0WHlEVWswNWRzZ2RJRFVQYjdjRHhWRlJPbjNoVm1YZUhvaEw3UW1jb3VT?=
 =?utf-8?B?OWFFWjRaMVRvbU9mV3pQUTMzWmFlem9MY1hWU0tGeFk4TUJ3dnNUUUFJVDFz?=
 =?utf-8?B?MXFFWXVSTW5xeE1NMnRuRlFkdmlUbDlNYmpETjMwRXFwVE9uY3d3U1NicFBV?=
 =?utf-8?B?OVFoL2plWEVsVTArNE16RWNTMXZiQlVvMVl1NzJtNnhBelpXSkRkbFBWTkRi?=
 =?utf-8?B?VjdHVnZHak9oaW5pVCtTQ1RHajZMbHJqRGU2K2Rsd2xvc1hybjZkZXkxeG5H?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28fb892-29c8-4913-9c29-08db05d69103
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 11:05:31.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9njBc10YgNprJk0v7V9+mL59dW/yMY7xc89JV584F9wEAxbdEy86oFj6ojF6lo5xXjWL7kCAdEwCZzRSx7aMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6633
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 11:05:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10587

On 03.02.23 11:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> As the file is not used delete.
> 
> This is done to avoid infecting other layers with the snapshot version.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/debian-sid.list | 2 --
>  1 file changed, 2 deletions(-)
>  delete mode 100644 conf/distro/debian-sid.list
> 
> diff --git a/conf/distro/debian-sid.list b/conf/distro/debian-sid.list
> deleted file mode 100644
> index 46d34d7..0000000
> --- a/conf/distro/debian-sid.list
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
> -deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main

This is wrong. v2 renamed it but forgot to adjust the user of it. That
was what my question should have suggested.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


