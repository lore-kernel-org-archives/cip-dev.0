Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BCC43217
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 12:20:07 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.70])
 by mx.groups.io with SMTP id smtpd.web09.9203.1666354805595388953
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Oct 2022 05:20:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QrzaRVKg;
 spf=pass (domain: siemens.com, ip: 40.107.103.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C75iOcaxnzYeXROrs37kX8YLktiOzZ2AtNPe5l458YJ6se/IQCzLYOe7RF0qcM8atoy5WYAfY3P0hGxXz9Saa4j+ikxmPo64EYkrmQaiZR790fmphZrV6m0QxPgDXvCIiEJEL9wClGw70JAqp+Sxs4wje+fElVkyzmfbS9kUgGNfJ7O/CZz9Vw6+9jEqH3MrYbzFj8m9viowdM5ZT2mqaDreUE7GVUiCABmktxdn8HMiwfasqgqSDQIe4WvKNeDIM+QlYbqqaevHP064DNizBgWx/Y853GlW7kKThR4FdRVQDAVbKtdLzX3r8N0Ar3vUFA/NA+eF/y3pjjnkwy95DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+iawQqbp8nhVeOZPS9Mrlv7rsD7c68F0A/X/yxgv9g=;
 b=l2q/PqlumrQqLmcOBvvUrmyJzqcEL1agZ6nabIiI366q9SV2bk1xdlUnUZesXSLhncQJxWMljSskSD0Nug8/9/lWQscHyOWIpUT6Joej+JU/m4SOUmILIcMKAGfhB09RjvBzzhjWn8e0NVOBnrxDXTdzxCTuBaZIbUbywuPzHkGBwZu3B9ibU5MEqWKRcQpX4/DB9NmDK6NirRLXwOAxskS62uwoCtGk8X3yL9uOffyDoiXRrE+6+Up8Z0ytcNTiaJUzwExW5CR3aKQCV7i7PPCSfqlHHJMfqRgjiukAYdqCuMYoesshNTfjGlyNGn7odVubwpy47a6YcUEDfTUP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+iawQqbp8nhVeOZPS9Mrlv7rsD7c68F0A/X/yxgv9g=;
 b=QrzaRVKgQYhruDDPOmXC4NiycArHfQVUTVTFMXRi2PoQQdZ5daGWDYH5zT3ukwY0ZAqSVyoyT+opEjfz7IOqgjH6ie47B4960fIebyxhV+5v3rK0pIP8s7LiD06SbL7telbihVTHXKLsleaJ2zBeERhyB/zI3hFLzEXXw0wwQpYFjMWFrTIBjjCGRz9DNp+aEErvTRWxIsz+LL1Lb/C8g/yRDNoNoX0enpB+6CwvosM4nV5jTkBC+NbErWo70qYmwiutfeD3Szh/F6sIGE5h9nU6GCu1cjIMYuZhYkbn2kDSEgtHdbkf6Y5aS1JDCQe9c+UC/UPEGtdSCuIQ2eLjqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 12:20:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 12:20:01 +0000
Message-ID: <9b58ec50-3a8c-62d1-aa61-3661ab6b3ca8@siemens.com>
Date: Fri, 21 Oct 2022 14:19:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core] doc/README.secureboot.md : Add method to check
 secure boot status in arm arch.
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20221021111641.27627-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221021111641.27627-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:610:77::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: a67235cd-35e0-4d02-dca2-08dab35e93bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LX0GJCb0tDbqg+tFHQoSOCHhbW4mS90Is1Gz0/fD1blmxNrB3kygaJNVXpbYh93iBE7PoCPHWShgJ3YsqGj0uxg0Sh9FLgXqgWAyL6dQmtQqMoe8IxGyMa//Y6p5sBp+Rm3cHa/uic7QiVCUalB/wXkPR7XnWmnS2r+Ai1PpijrTZy40aMyb0cTt1EouFzmSbVU4WKA1743eVXAK+aOK1D8aFUrfJgr+6yxNgxn2v9uttfqNIpL9jpQ0+QBoH+ks12MHUWROCvbyoX37xY37yn9wb/dS33deeAy+/J5RjGNjGxP5hH8yDz5SOupGNq3Ug4+nN9Pvp07BLHb5/IUhfFARkwICqve8t+ZQIQiSj0XG3HOfp5IyslExjr8Y7KPz+Q6gO/RkADCmSgInHtLbiF49fnKbu/OQaIJczWds5lB/B7QsVkF3OxcdNeYHliETzPcwS4Uv/k8CPsgZxQ0IBjji3PuE/94lsGfVwUuNExeI4LS/20uO6Fh1Eyk2UPnZvqOdLrKs8oEomlTThyKopswMQauwa/BJF9katA2EUwRAxGDpDWSkFbnSgFXTa7pcS+B+k1o70tWgHGkbokPZCGwYiiWEZDJu/ut8YEJauizH4baNtGVWpw8q7zm2vtYnAojXVlJa7B9UZ4Tb5r2eoAno+LY1cMcySxwGrxAFrl+Z6s5yEDcj0OnyijZZGduhertDQlH1K0zeZyHDRWLT8dcyLeo+JtScTvfxn1UdGJOtzov506GpgtEGcayh5U8Py9EbRO7HyiKFUNspcVY/ky3wv3Kz8iA55O8m2xate0k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(186003)(2906002)(83380400001)(38100700002)(31686004)(36756003)(86362001)(31696002)(6486002)(44832011)(6506007)(82960400001)(8936002)(316002)(2616005)(478600001)(66476007)(66556008)(5660300002)(26005)(66946007)(41300700001)(8676002)(6666004)(4744005)(6512007)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUNrWTFJWHV3MzNyeWhXNUU5Z09tR05KWERCbDkya2dTeEZzeHNGT3JCN0NF?=
 =?utf-8?B?NExqa2JLbkdRRXJjMWFuNlh6anJXK3VCVUsrRHcxeHFCSnFYTWlwbDBIVDl4?=
 =?utf-8?B?dEtlSHZ3aEYyanFlanROZ1EyMDdWNUV5bW5KVDkrS0xadGd3WE1PSjFJMUNY?=
 =?utf-8?B?VjJ0RmM1UTFrTnVNYUErZDdGdk5wTUpieHUyUzR3QUR6NC9sRXE5ZVFYemFh?=
 =?utf-8?B?Mm94bHk1eWZSTkFsaGhMTlVjdEdnalVOQnlaMHVFd3c3TU1oMjhxME5ET2ZI?=
 =?utf-8?B?SHNCOWx0aXNiMnF0aHg0czJmcSt0dzZWWTBTd3c0M1d6VitJVUFsYVN3SWtk?=
 =?utf-8?B?bzcydU5UNDVDMUYxRHR1R0FBUDVIYlVNWUdZTlYza0lsNWV3dFVDaVNpL21J?=
 =?utf-8?B?b29xWWovbENRVURNdFRPbndtK1RJWWxhaGRWRmhVSWtsTHRFUFVhbDZ5MlVn?=
 =?utf-8?B?SU5sMWNnUTFSdFdvemJWNGVmUzJQa2Z1K2I5NkwyOVhEVGZrMngzbCtocUh4?=
 =?utf-8?B?RURwc045ck1BV3ZBdUNsVitMUy9HOFlRQjY4c1VsN205a09PdmYzV1NiZHNS?=
 =?utf-8?B?WUIzdCthTjQ1V0hHMGphRXEvRDdLK1ZhUVgyeldlZWJBTy9xS1VNY2FCYXox?=
 =?utf-8?B?VWR5SkUvbFBvSWRsQlhmbXZyclZZZjdjRk91Q3pvOTJPM2dLSmcwdDRUbVdY?=
 =?utf-8?B?dUdrNWZGY2M3cEF4TTlnMzd4djYxL2RIeXZZV0kyaE16MTQ2dFU2bTZTZFA0?=
 =?utf-8?B?Z1pDTVFLS3RKeXFVYVp5TjZENnN1aUJFOXZaUklkQ3Q5Vy9iTDF2QVpBQXow?=
 =?utf-8?B?YkFZdmkwQXRrd0Y4TC8vcFdWS090cjRhcnFxYytvVnE4L3JmcTl2dlRiVGFi?=
 =?utf-8?B?NmVBYTRpRFBMejJoUElrYnZ4OUZQbXM3bDE1WWJVaU1VeFdPRXlFK0treDdB?=
 =?utf-8?B?ZmFUa0llaEFodHJIbGNES3V6cy85WTdCbWZDTGhzd0RETUdRNUtWM1RtWE5w?=
 =?utf-8?B?UDNGRWlhbnNoVDVHOSszQVdkdlUvVlVWaHRRQnpvSWdxUWVWaUY5dnlWNW4z?=
 =?utf-8?B?YnlrQUdESUF0Nm0vQU1kOWwrQjdEZ2FhT3BldkhUUTV0TDZqSkZxcTU2Z1E5?=
 =?utf-8?B?ZndXaFlxT1pQMm56ZnJkamxQYUxXQW9PTU4xek9Ea2JrWDZrQ1FpdVVMcUdR?=
 =?utf-8?B?dFZaZ09UakdkcldlNUdiREZlUTA1SzRqeURZamE3MzB6S3YyKzB6c294em5x?=
 =?utf-8?B?Z0dmM2QzVDNCalA1NlF6Tjd0aEVtN2JPS1BVcDdCSStmaTZCOUpoWmRXeG5T?=
 =?utf-8?B?bU9YWFRWYXBNUFBISkR4SFFQd0xqRXJTR1dwUks1L2hpRFI5SGZhZjZpSHdu?=
 =?utf-8?B?ZmF4Sm53SGNlOWNZNVdmVG9kK3U2L2VHd1Y2dHlPeE5mb05PNWNoakk2S0p5?=
 =?utf-8?B?RUh0QlN6by95UVFSZTNXSWdsLzFGeTc4N1RUWW5YR2NLQVA2bEZyMkZrSUFT?=
 =?utf-8?B?bVM4WXppQktOSFd5OWh6dUFBazZseGdKNHRVTWNocUNhRjkyWVdFNnlCQTJa?=
 =?utf-8?B?cGxna1dlenVyVlhmNGVjdjlybnArWkFuajFoMUpnREhLVzJ3ZmdoMlo5cmh1?=
 =?utf-8?B?dTJpanBITWxMVDJtU1pZeXgrQkZwNUNPTTFvK21KUWtEa0x1YmtueUNXTWx3?=
 =?utf-8?B?MS9pMGEzNm9lZ0dIV0UyWVkzSSsrR3dpY1E3L1BOSkRFWGNMQUhSd2tGa2F3?=
 =?utf-8?B?QTRLWlZabkdRQkErdWpJV0U3dmw0SVFLc1RkUVM4bHhBa1NBSkNVMHNCNDkx?=
 =?utf-8?B?UlRIdWwrY1NaWnU5dEZqNHAwbDNjMVFYNVhUcmc4RUNyMEVaUHgzNkszTlor?=
 =?utf-8?B?aWdEeVY3SjdXQWsraGdzU1lESG9NSkxQZFNFSUxmUENoQ3BPVUl2dEdwVzRa?=
 =?utf-8?B?STFxd09KMUtsU1BQNXNocGk1SHc3ZEovcXVZOTYxa3d5UUhhbnliVFF3aktI?=
 =?utf-8?B?TGpDVStoMFlKRGhqOXJyQ0h5aHpLenhhV3hOU1laNG90NTVHR0NvNmlWeklt?=
 =?utf-8?B?eVpOOTBWQ3dXVTZ1cC9mVEdhVnJ6WndPK2tIT282WUxFNlA3b3RPdzNaU0V1?=
 =?utf-8?B?RnBISlVBUGVmVHNrNXZOZFA5OHUramZ3c3diRFR6VHR0WWFONlFXTGdjTXNz?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67235cd-35e0-4d02-dca2-08dab35e93bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 12:20:01.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hMl43UepnIzIe1vg+YsGT5u31z1toPrENcR+FDZ2khdEDNvT7tDBPhbyc46XtaUvNIHsfaRQrWBhAIzpUnq6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5320
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Oct 2022 12:20:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9803

On 21.10.22 13:16, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> The dmesg will not show secure boot status for arm64 or armhf
> architectures.
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README.secureboot.md | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 26d8c87..714331f 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -217,6 +217,10 @@ After boot check the dmesg for secure boot status like below:
>  root@demo:~# dmesg | grep Secure
>  [    0.008368] Secure boot enabled
>  ```
> +In case of arm64 or armhf architectures, the secure boot status can be found in bootloader logs like below:
> +```
> +EFI stub: UEFI Secure Boot is enabled.
> +```
>  ## Example: Update the image
>  
>  For updating the image, the following steps are necessary:

Indeed - thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


