Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EEACA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:21:58 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.web11.79893.1755534116566045740
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 09:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qURu7upG;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZTSt2icGSQh4QlfK73DUXl9Mjjguavk/IUT9QiMCEJReYqIZ3GPLTN6365JQa5L31MSnXmhQnFS1HlS7gVepH+7KDRss/cAJeGnxK0zBRUWEWoZgZTl4qlBVk5yo3uuLfYWWoUmmgtEw+FLqkuT++bP79FYUSHPI2j9mKyqnQV9y/GP8QywE6waHeefk+BnsWbpv4Ihuw7ux1iCNf420+NV305T6IckkWrYcBLKz+Cfr0THLtLlhBEITvi6Udq33OtNjnOX0aczf36W7InHV8nPT5ipEGv+y48hRpc+HYibfvCVzshVaQ4ggeeLweuIG6tFY9VDbi2PzThor6YR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KRIXmfiF147Sq5XxcAr3mEZ0x2d5zTP8/NkoCqM5lA=;
 b=oZit3pzloABvSHRlSDOaNiD/2VVR47lhd1ftJAMSRcPe700w/M3T3J02hh8ZtELNV1lPT5cLGa+CD/QiZg5EZ/52oO75g8X6vApJnIeb3gKrd+EM3cSzHLuYcOVwncs+Uege2swm3VWtN5xp9U65UNeeBLx45iLWeBCdfXZ+19XUg61OobiHhm/ZOtHn8BOKmmbFPPQfuioCuS8eNhgrs4Z1y49pvNCXHTtmE0/S5k1cMuAsx749vd/a/n25yHEHf7vSSdS+y/74Ox/pCJG2dDBOvi+KkwIsQQ1y4mQ1wnlEiQw640Zv3br4RYLx2QRf4+YoBx0IFhJonVZZKUn5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KRIXmfiF147Sq5XxcAr3mEZ0x2d5zTP8/NkoCqM5lA=;
 b=qURu7upGsQPRL2H+80OjQHJb6acgF3jFA0Ui0IM9VpItPSkJU9+gIpeJtu6efL8DWKhwHOzt4LHddh4/a+HsNQBVO+1f5mcaLm1HPZOhW+rn+KvVqqiQRaRf+pgoFQbOUKr368HXkDg1eF0Nomyw9RxYA2WFECPu57jgSe6GsXKk5tTA7Jk6lDrix4YJVJCAICsf1GN5DqISLGOqgvHN9UHdcW2SlutDvtoZUNaPOVcGOW894/8XkzHJfo1rLrzabN4gXKoIjeLvEzsQCzoWz0xT911RHLs8ySVjKFj0CsTMLjBk2XG2uN8MC2tG2jcnxOjhlt19R7EvOELBdyHUvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 16:21:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:21:53 +0000
Message-ID: <4d1b5d31-b8c6-46e7-bd3f-aca49c8f7272@siemens.com>
Date: Mon, 18 Aug 2025 18:21:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Add doc for update to trixie
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
 <20250813101406.1372766-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250813101406.1372766-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: f23109fb-dff6-4533-1513-08ddde7357c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVdzZkgrWjNRWVU1a1VWQWphRFF5dHRYZlZLZDJLb0ZaV1REL3dVNWhsL2Q4?=
 =?utf-8?B?VXlWNjNmU09VRTExR3lJZUZCUi8xYkR5aC9obEFYNW1PRi9ibDNXbDBucStx?=
 =?utf-8?B?cmdsenlodVp3QkNMd00xSXZCemFuS2hTM2htcStvSGZ1b3lFUktCU2ZzWmFi?=
 =?utf-8?B?elAzK3dLcmV0MXQ3cmhLU3lzbjZpZUkvK0tMaWlmNTJza0FERW1IdUVoekNk?=
 =?utf-8?B?WlNTQTUvM1RYNDBNWDU2bEJ3MVFWYzZUOCtpTDFRMVlHbkdMMVNld2NKSk55?=
 =?utf-8?B?WGZLVURoSkUwZWNaOUV0SncxVVpDSlYwU3lFbEdYTjB2Z1RJVkpXaTlaZnBp?=
 =?utf-8?B?TzJWTzBHUm56TmFuTFNjUk9pN1RxN0JaQ2tndTZKc1RoVEFrU2U4MWV4Z215?=
 =?utf-8?B?WndsVUsxNWJoWWpEckN6THRaeTJnTnFxUDVBZElqa3BVQTlCb2xWeWpZN3FI?=
 =?utf-8?B?NmsxZm5saHZKYnVma1dkYXhlcEU3MVEvendPZENBR0toWjRxb1FDTC8xYWVr?=
 =?utf-8?B?K3FWazNjQkdyenQzSTMzNjNmajJoRWpURjhhT0o4ZmxOZFFKM2JHd3FRZWNa?=
 =?utf-8?B?cENuQ3pNMWpwR3hDcm1tTWczK21LYXNqeU5kMVRGbFZSVzVMVmdQaGMvZEFq?=
 =?utf-8?B?UFJ4MDRHakxZYTI1S3hpYW5COERwbDJNcEZXMTFuU21LMkxSbmNucGEwL3Bw?=
 =?utf-8?B?Wm9aTUY1bEx0VGtXVGFKcVkvNHFMZlhRWTJQVTU3NTlTdVFKdE03RDI4bytL?=
 =?utf-8?B?dk9YbWRmNlhXSzNNNEhTT3lsV00yYWE2a01TTHUyVHJ6TXBGOXdBUW5RYnYr?=
 =?utf-8?B?ZUpRNUl5eEFYa1krWVRLNTJPUHo3Y0swUFFkZWxiTk9vMitNMXp6QlRSS3c5?=
 =?utf-8?B?cGtobTFNWm85YSs2V2VRL1ZxWU9tK09HZ0lxYnhmU1FwMUtCYUhuNmFYTnQ0?=
 =?utf-8?B?OVRiRVdubTRtcUhqRWlSYTdsTElrUTFxRkZ6NHZJNmdsOGFCTjVFTDhzL3p5?=
 =?utf-8?B?YURBcksycjE4b2xDS2NuNHZyb2ZTWUxuS3N2VGdPWG11VzZBcWFoalJ5ZDVV?=
 =?utf-8?B?MUhCZzFmdGRFYmtodGU5YVZpLzhTbVFjaVh2NkdCZ2RHVVgyTzVsTkMwR0FF?=
 =?utf-8?B?aEYzWWtrYVNtTkNFZUZXR29PTnNDY05hc05UbDVkeUp4emdPTE1pSkR0TFYx?=
 =?utf-8?B?aldqSUwvcTlSc3BmOEdqU0ZMcTFZejRuOU5ZT3hkSnhjNEFROHc5azRQaEZw?=
 =?utf-8?B?cEwzcldOckZLenpEL21oWFdqWHlSUTd1WkdvZWhFaUtRa0tGQmx3aXdqbkF0?=
 =?utf-8?B?bmRCaUc0NzZodWQxNUVOSkZXQjFodnRSUFYrdUJLczlzTmJlSjFycmM3Qjdn?=
 =?utf-8?B?YW5sNTF3ZzluWXVRNXgwUEdHRnFWV0NLd2pORHBZUDZWeGNWTUdFNHU0UWdl?=
 =?utf-8?B?K2YzMWNKcFNrVDFoay9tY2M1MVlrQk9zMDF6YWNER0lMdTk1NEYrbFFaVEFV?=
 =?utf-8?B?OS9aQUxvVk1hcDdFbElzanBNSCtmT2gydmhNaEhHM2NQY3dubE0wbXlPS3NQ?=
 =?utf-8?B?MXJVUUFQZU5zcVlSS1hYYnQ5dWJFM0dNUGpCVVJWR1VqNldkSEFad05UYlFD?=
 =?utf-8?B?MWl3OEJTS0lGdzgySzBQWjMyaG8ydE1KelVYbWRlNzlPNFZOT09WNHZsN2JM?=
 =?utf-8?B?QkRMWnpYZFgwbGZKYjdvdHFoblA2cDNBUmRkbGxCdjN4ekhqaTQ0OXg0WUVa?=
 =?utf-8?B?K2d4QUQvcmhFOXkvc1VmMUJxcUx2Z2JvUGdPRGE2YzE0aWxIbXpoZnpjd1Vq?=
 =?utf-8?B?cTkxdWpmMDE4T2t1OFlaUG9KREd1OVRzZzRZVFFFMWhBL3FxRnU3SnRjbXB3?=
 =?utf-8?B?UUExNk1BN1I0WUlDNlpHUHRCbWc2T05QNW5xaW52Y3NGb1UvMkFnUnN4dS9B?=
 =?utf-8?Q?UUz4Z2n3iEA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDV0TnRvaXNPWjE1VU5YS3RSZHBhUk5SOXRtV3ZOTm5wblhTdnBTckNhR0l3?=
 =?utf-8?B?U2lsbXl5TmpwM0dCbTNZT1J0bndWaU9KL1VpZHJIQ1Z5ejJwY1VTVjZGTldk?=
 =?utf-8?B?RzRnUUZ5VEt6QWhkMDZ3TG1kcWQ4WXBOMUpSRzIzY2FyVGVyc3cvUmFDQ3lz?=
 =?utf-8?B?V0IzVXBLY2JMcm5PcjB2RjY3RFhydG92VlQvTDRVTCtHNXJQV2RLQlRRamhF?=
 =?utf-8?B?MmVoTGsyQ0hqQlpRVnRXR0VSaDZRNDlZbDFHZjJ5ZUtPUkFhSGFvUGk5ZE5Q?=
 =?utf-8?B?and0bVpZdGx5MkZKT1UvbGJYZHBsdFRsb2pPZGRVUU5kQWFtTlFnbE9wY1pk?=
 =?utf-8?B?OGdoNWN4RktEbUtYV1l1Qks5S09Ed25QTXAyNFc1OWF0bzcwK0U4cC9qeHli?=
 =?utf-8?B?NTcvV2orM09RNUFuL0p4dWUwNHErc2lNNC9WaWpsak95Y3BpdE8wQy9teG5k?=
 =?utf-8?B?V0t6RlU0Rko1ZDh3RVArV216ZVlUcTF4cklobUxlbmZvaFFxVkt5MlVyQXh4?=
 =?utf-8?B?YzlBZGdHdEFESER2K1pZcC9rR292a25qdzFSSE5hVUN0NW9RWTdBa3FNN0Np?=
 =?utf-8?B?MXAxYks1SmFkbVF3Tmp4VUh2ekhmYWF1UHB6SktwOVl4cm8yU3JmVjRFQVhH?=
 =?utf-8?B?WEVJVGJpcndVaE5yTy9aRTRoNTdNblN3cmhoM1psb3p1dWF5NW1xWWpTZlor?=
 =?utf-8?B?YUlINzZPYWpTRTlYaEpZR2RnWEQzOG5jbTh3ZUtvVWZUaFppdmhLN3h2QzNC?=
 =?utf-8?B?NkdCZkJRNEptdjVXSDIzWlVMaXUwNkhjMGkrK3RwY3JuYlBKK2hRQ00vVmln?=
 =?utf-8?B?eTd0TU5QRCtJU01mTFVBV29xV2JjLzJvYzcwM0JxTHVBVFd6SURUMnNoY1ZW?=
 =?utf-8?B?USt0WW9GWG5rZmxmUWU5S0ZaSTF6U29oSTJBWjFsNmJyT0VkMWEwcEpEUG1P?=
 =?utf-8?B?bktBUVRKUnBWc05tdlRoZCtiSEtybGFJcFc5Wk5xbDM0NUZyS3pSSWZHcTN6?=
 =?utf-8?B?QmUyTWhKK1JLZmx4VVdBYkduVUtWdmxIMno5cmpwZk5hV2pnUjIwSFY3aGh1?=
 =?utf-8?B?RFY0Z2orQmhPTkhiUHd5SEVTckhZb1YvTXA0U3Y2cE5sMmNiRWhDZzJtNHY5?=
 =?utf-8?B?aVdIRWZ2TnhNQm5KWnJJSVhwcTFRbWg2R2c1MmIraU5Mc0NhLzBGa1FUK3Ay?=
 =?utf-8?B?QUM5dHFzdk4vSXhiVzBkVG5XdEVmMXdCMGl2dkhwSDJ0Wjl6dDRhcTJJQlBw?=
 =?utf-8?B?L3ZuRU1HMG1hYmQ5UG1GZlhvbUs0UnJXdFM5eW4xZ0w2ZFY0eXVmaW5zVGZW?=
 =?utf-8?B?TEpocUMrQ2VBcExlMzJaTTBvTkorSG9oZkU2WXlHMEc2NCtISGF4Qk1wSmd6?=
 =?utf-8?B?K1hnV2xJRW5GT0NGU0pJMHE5WmU0dXE4Z3dkc2lvWWMyaXA1Y2RseHJvdzdu?=
 =?utf-8?B?Tk9IU2x5STF1cXM0THJma2VodFFvSEd2RElrWlpXbE5ZbDhmYzBLSlRQM0FI?=
 =?utf-8?B?dVM0SHNUSGdCQmlMTEN4L3QyY1hJVXRQUUhXTnBOM0hYVkhjNUZjNkdSN09K?=
 =?utf-8?B?K3R2Y3NEZXhoNUMvT0U1Y2s1ZUtUTjJqbGxMNW5ENms3Zlg1MVFmaXhmTGFE?=
 =?utf-8?B?YlNwQklGcVVLNnE2ZjQ4WCsrcGlHWithWFJxVkhzRHFoWDRJU0tUZkhnZlY2?=
 =?utf-8?B?Mkd2K3kvYTUraU80MWxmMzBRcXNreTIwUW1ET1V6TTQrZVBDeW5DTExRQ0Fu?=
 =?utf-8?B?ZVl4VC9kdFp6MElFT3NBNkxWQWpXSkpxUEQ5WWdEWHZMakRkVHNmRFFwSUw0?=
 =?utf-8?B?REhIbDhhSUlNWWtINGtHLzB6Q0U5K1JSa21ERFl1V21oUm5tanY5dzB0THgv?=
 =?utf-8?B?VlNIZXJkK1pXS09OalhGR21Wdm1EbGlQZktvRllpeFg5d3VJaFVobXNZMTVo?=
 =?utf-8?B?dC9tcnl5Y3BwUWN4MmxiMWtKL0t1NHV3c1FqcXgrNUVnOUVXOFQvekoxODd1?=
 =?utf-8?B?M2dtRGpuSXpNU0JSaCtjbmdKcUhNNnZUOU03RFpORUdZRUZuZkRhNnAvVERD?=
 =?utf-8?B?WFJpVGxKaDJrRW1YWXZWTklVWU1GdEVKV1dNdkRzVlRtdDQwNlNzNkpTYjdF?=
 =?utf-8?Q?AyWGMo6QqzaVKTo8ZHZM7Ro71?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23109fb-dff6-4533-1513-08ddde7357c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:21:53.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oou7t9uZ7fjcUwv6fWuM/23hEwpSlpGnS+ilfpeDh1aOPb2R8sqL8KHUjKCO7xytxHSllFkow/mun/3WC/ClaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 16:21:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19758

On 13.08.25 12:13, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/update-to-trixie.md | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 doc/update-to-trixie.md
> 
> diff --git a/doc/update-to-trixie.md b/doc/update-to-trixie.md
> new file mode 100644
> index 0000000..64e67ae
> --- /dev/null
> +++ b/doc/update-to-trixie.md
> @@ -0,0 +1,18 @@
> +# Update from Debian bookworm to Debian trixie
> +
> +This document describes the changes necessary to build a Debian trixie image based isar-cip-core.
> +With Debian trixie cip-core will no longer build SWUpdate from source but will use SWUpdate
> +as provided by Debian trixie.
> +
> +Updates from a system without signing to signing enabled on are possible with a signed swu.
> +
> +## SWU signing is now mandatory
> +
> +In isar-cip-core we use the debian snakeoil keys as signing samples. This keys must not be
> +used in production. To generate own keys you can follow the instructions in [README.signing.md](doc/README.signing.md#use-self-signed-certificates).  To enable signing with the
> +debian-snakeoil keys set the variable SWU_SIGNED to "1".
> +```
> +SWU_SIGNED = "1"
> +PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key-snakeoil"
> +PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates-snakeoil"
> +```

And also applied this one. Patch 2 has some open questions.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

