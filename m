Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7477CD3427
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:26:01 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42138.1777994753353975915
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 08:25:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vs1/mDzh;
 spf=pass (domain: siemens.com, ip: 40.107.130.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDub9nsE+WA0CMzNiNIahT4S9nW6ZH1Iv9fy0Xh1QVFJS1KW0Nw6vSa1mSWdFbJaXbajdzNQ+SH91Tvxx5vC/Gh1gVQBge5BlU/f203NV5/+W3Kq0x7+ZHbf8dX0uXx9syJ4TBEhmEWT8jofSZX8yUQgeq4mHPV1vrsE9f4F15ducIE9dG59K8MI/DtCIrQXPJ1oS0EaJD7DGDjCY1j0n5cSULoy0X5boaxyvZ09Jp1cOExkf+01+ozK8q9f8Q3yjnRPNltYWz3/r4ZAGXHzb7yF+MrJx83iSprsd4Hs1ZZaX26pZSGon+n+VIuAJRqzOXsd+Kr5kxNQB3lVN1HpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq/2Xdu27BBPhqpuUTUCYN/5TASYVRlDZz2U5SHpWqc=;
 b=jt6dq3lkXcEWNSzdn0MkSR+aZgSXvUu9JaIUfHCZLs2QX3E+4e/eZAdrbUq6w8O4VCFEDS+Lf7C7kFxWfPKpJKKif/W3aa+++Ylw7K/hq9DUmISs7veJuA+GNdkryZ5ERRUPI8yTxDhk20azR797waqA5GGthNR5NTjYGHhD2X1XuEkfuIlNhajM3koHCB3YDf39NkZMgmehpwtEz5ldrAW0/9gw02YGDvDzSSYiIL9vS5j86KxQHPj5KXuk+MIYtVOnoAfYMh1mCi+19TRNz+mubn9HHSjm2vBGc6ZBdzzyOe6NVdGqrbPX7OU/8rHDYTBlw2bzWT9TrEZhZahGng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq/2Xdu27BBPhqpuUTUCYN/5TASYVRlDZz2U5SHpWqc=;
 b=vs1/mDzh0x4/a0RbI3X8zt5cXn5HX8DpSJSjmr191YBF8HUnJ7WuIn/E/VdvKyGX6x/ZpMpSgcmWts/fUly9JeTkjiCSGiZlfRALQFbaf4jcoGtlQ9QdgWRXuu7Z0YByPqdySm8yYd1Tuhv8/Wgb0FFGW0Gcvkpd//h/IhSFrGd54MYOosi1NZPE1iOpaiskOTyuJNZcQqHkI3703pQlnbGPqFc8jnhTpRZu//5CYD4DwOIvAp6bzSS414gcVLtsdSHb+chVNEpFrwJALCPLY978gyVvtrilx9cFAe6UDWOwUYkLUTi+4E9sWIXo6ymdXntQoHx8l3bWQ2qsqZXFmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:25:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:25:48 +0000
Message-ID: <ed433a39-6a20-42d9-9e30-26df78aab0d6@siemens.com>
Date: Tue, 5 May 2026 17:25:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] scripts/submit_lava.sh: Add an
 timeout of 10 seconds to the SQUAD call
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
References: <20260505144249.1325545-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260505144249.1325545-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:10:232::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: b080fa26-07a1-4c18-67cd-08deaaba959d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	df/0Ug2qaLQ0Tdv38gK32dH/vuBTQc8M62fNp80XKioKgXFT8O2zFLgISmMVFaMnjgNyM71ySQP3sT7z6EzsCEs8YCfHLhXr9xL0YlRNsu9Fxf968AbiWxK/yTQsbjuMh4yTTz/yoBm0/w7btuds5lxtM0ny7pqiQFD7RK49yFatUry+/5NyVEYij1xBarZ552cxgR2vwUj6ERLyDXmV6UnKDt3ZbALvwNUhhNyzElTJ7wABEZmwo2pSmZ7ccFfCDo4LrZV1I81FEenTwwhyqh/76akNj4l0h+4iRsk63xXFK526aQ7262q1fxo5KPm3EXBJOKb2M3L4DmNrQZJh5r/YS3/xT57Mq0rGPoIqVwM3CD/yROe0OuKIgjZVTCBcZJSS3QXeGL/pvEVZJiyKHH04L/cEDxykprhJPywcbIdf+jiQXAKTfeY0KjiSeEhR2W5E8esDb2ijMka/oH50+IjaVUk2u/34yyWynHaFfviG3HL5eypQb/xZYbLv7m1lJyL6InaXy4y832yJ/ndix9VkSxjzycj86n09EC5A6diwe7F+1R8k/6o5Br+jhGdFBgA0oOhAp/nWOjw3u2LBYXbdDWVnxzQ72KpeTxkUrpxjK4OGILEsJR072FlxL19xoc+zQuD7PATpBC9Sw2yoYg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVZxVWcrRVk5L0FSbG50Z1U0b0VFS20wczhKczRONmYxV3VYRXFCa0doZ2lr?=
 =?utf-8?B?SlZ1RHpxdXQ5cisxSnJGc2pDN1FxSmFQZ2QzREhjZ29nUXNkbEl3QWU4S0lx?=
 =?utf-8?B?VXBTN1YzN3I0eEhMekdrTTVqdEhPV1hyc1l0Q2xDMXYrWWQxWTFxMlFkL2Uz?=
 =?utf-8?B?allORUU2TWRKOHVraWdNWFFpZmlUUmoyWEFyZlJSeU9jUnIydEQxZW5raTEy?=
 =?utf-8?B?T083WUZvWUtEZTQvZlJ4bkQyTlVTck90L1EvYTFrSjVySWRJMjlRcXN3N3hG?=
 =?utf-8?B?WVlpR2hLdHF6cXp0QkorbHpGWno1ZGxQd056ay9ZTjBYNS9sT2dlbU5hZWxZ?=
 =?utf-8?B?akZrTnpWaFdXUS9obUIyWnBhbkFEMnVBeG1MYjQybzg2MWZUR0IveTB6UlEz?=
 =?utf-8?B?OWlSeWdQMUFUV1g4KzJTd1ZCUjRpQmxiSGptSGxGLzdNZ1piUWN2anNnelB0?=
 =?utf-8?B?QVUyZytnM1lGdHkrbWxYS2dpYUF2TjNEMjdiaWw4bE9US05RWWhaOHdEcTFJ?=
 =?utf-8?B?TGFDZVRsbDRuZEt1bDJXSjAzMTZjTEZXY1RkSUczOTJvaC9nVWJqRUVVRjRY?=
 =?utf-8?B?Nm1iSE9mVWQzRVNMaGRsOWgxVVJ3bmtmMEFsREptdzMrbEl2U0RtdHBURElU?=
 =?utf-8?B?WEVFRk9XWkxWRDNMcEkzc2EvTjR2bEl0VE9ZSmFFN2ExOGFkVk14OVRobmFU?=
 =?utf-8?B?RkwxN3hvVmVWRUxDZU9tZVVObWVFdEw2cmJmSTVNaHJaNlBzRUF2MDA0bllm?=
 =?utf-8?B?WGg1bmJQbEZrS2hBMXNTQWpIUnp0cGYvNlFDcFltaDJFVjkwUE42WTBiTEMw?=
 =?utf-8?B?aTZySnczQTQ4amN1d1dlbHA0dzdpL0FHR0R5amxLRmJCV0lSekdSS2o0emkz?=
 =?utf-8?B?L2tIdy80Vk5VaCtsUWJvMUF3SDhwK05wKzgyRlRYcnV6dXhuV29zWUl3M3dx?=
 =?utf-8?B?dXpXN05TdExUa0tpNk02R0ZEdm04MkRNd1diTCszYW1GYWNBRW1rTDRHY1pl?=
 =?utf-8?B?dUxlTmttVVFWNXV6eUJUQWtPeFkyZENNS1Bsa01QM2Z6MDE4ZjhMTldWVWVo?=
 =?utf-8?B?MGxwcjlvY2pyY2NwMGtabE8rcHJvSmZhQy9Xa2FUY0hWZ042eUNETENCVG41?=
 =?utf-8?B?dWJ6ZnZuQmVGeWNqYW50S1pLazZkbXFNT2ZYeEI3cHJUR0kweTF3c1g5Y0VV?=
 =?utf-8?B?V2xlNElwTVpDaElhRzFZcWZYc0doOTJpbS93Tk5qNkhSWis5aDBia0tIalNx?=
 =?utf-8?B?VjJ3OERYSXNpUG1NdTUvOFRBSEZVVmpWOWg2Ris0L0d3Q01DendBV09ZSWhh?=
 =?utf-8?B?TkMzMDQ2aENYSFFBOEFKQjZyTnNhZ2VndlMydEpLd2I0aXp2ZnpESGRrNGdY?=
 =?utf-8?B?UHluMVJhbkhjTmNTTHRQcjhJNEdvNVZHNWxjemlwZ1A4YkNVL1hDSmpjMDdO?=
 =?utf-8?B?VmhxN0N3dEtNaXp3RGtqdTZPN3Y0ejdYaG1SN1EyV0VPa3lEdG55bzNQeXI5?=
 =?utf-8?B?akN0RlRJOW14R3lNWWM1VXZUd1U5SWNNT2pld0hiMmxUR3dYZXdGL1dyY1RN?=
 =?utf-8?B?cEdqbHR5L2IvR2dYdnhOcTQybHVOSFJLdXRVR3MvNE1YeDJpZnpZenJGZzZt?=
 =?utf-8?B?dGVFcjNKOWdsQmRSRWNoKzFRcGQzQVZ3Qm5RWi82UXM5enZySGZpLzMxSWRj?=
 =?utf-8?B?c0E2Z0RQTUYyeXVyeVlGSmVZbEhNd1lTM1VoQWJXTXpINDNrTXJ0eGxaSU1v?=
 =?utf-8?B?MHI2cDFCMUhORjE4eHFmNTQyaktmZW5sVzc3M3lqOVZzZjd0RVhSbG5xMGI3?=
 =?utf-8?B?cHlabE83dlc3SjlOaGVidUpKWnAvTlJwWU0rK1cxWVdnYzV5S1F1RnN5MTg3?=
 =?utf-8?B?VDBhWW9iTHFMMzJmWWhqVTgydHlnMU5zcHE1cmJ3SGZpNzk2RURBUUFOci9s?=
 =?utf-8?B?aVhWa0oxZjhPWmRnb1owWDVhMGlzTWpnQjROYmNlRE9KOGlKcWZyOVRRVWFj?=
 =?utf-8?B?Yno4OHhMMDc1dklTMHNmRWtpTnRUNTN2QVJ3MFlQVGlqdmF4Zit3MmZFa21x?=
 =?utf-8?B?aG1tVC9EdWlaMjJTRHF0YTFodlk1bmRmUVBYTDNJekhKYTN4TmZ0TE9TVEFZ?=
 =?utf-8?B?U0QrcE50WWw0Y0MxSmU1ajY2SWRQRGQ3QXRmWWpNYWt1NHErdHlpRXpCMEVN?=
 =?utf-8?B?TjBTWk5RODFYajM0MDdyZVZqOEI4N0FqWVBqZzIrUVVMM0tYQi9KcVpLMWY4?=
 =?utf-8?B?c2tPMHdmMUVNUkQrRmZMRWJBem1RSVVYaEpleHZwN3BKVGY0UFdOaTZmZk14?=
 =?utf-8?B?QUlJUFZVdEdEc0dMNkpUb01LUEZMRGlua2hPWDU0U3dtbzVMdkFPNFdiOGxl?=
 =?utf-8?Q?4BJmdBvAPOdU82rM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b080fa26-07a1-4c18-67cd-08deaaba959d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:25:48.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI0BtFX956cTVLyt9hH71hGXl46g1CuEIHNToTTvGYdi7Zhoeqg0LjPVDID6DcBtpbz5qOMgd8yA6s4lla+MZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5432
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 15:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22889

On 05.05.26 16:41, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This should avoid test which wait for ~1h until the SQUAD server
> answers, e.g. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/14202652537#L199.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/submit_lava.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index 9645455..958a4e9 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -258,7 +258,7 @@ submit_squad_watch_job(){
>  
>  	local ENV="${SQUAD_PROJECT}_${TARGET}"
>  	local squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${SQUAD_PROJECT}/${COMMIT_REF}/${ENV}"
> -	ret=$(curl -s \
> +	ret=$(curl --max-time 10 --silent \
>  		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
>  		--form backend="$SQUAD_LAVA_BACKEND" \
>  		--form testjob_id="$1" \

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

