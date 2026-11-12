Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1524.1794503418306747765
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 09:10:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yJAZR8Gl;
 spf=pass (domain: siemens.com, ip: 52.101.84.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VguUninDyht7hh0FSxV+CWMYRxHih5H58gULIRXXdJc7sfMc4UGt/dU3nfB47x0KTh0JAn7eWNwH7sv/diovDfZPgu0QqcityBd2wBkk2KFRu7aub69otRELeHTKC8MVJYpAd/8HaseVSaTkYPCTYrwAPHkqfbuYtLZ+XS73uzyQMvpusEp5jo6pVglysLBprzopQgrw9d4WOQL086raagfd84NZZ0NrrbbGDxrU6Jya2RofNDfqlb9PpsQKVDQj9b2FgVB3cc8WNuJvAaP2m4nzVEqrWnrvCkJyA+WARBeZ3vmO/hWAwxi61+u5HG/Czqs2nMA8neRcF3vUhBCOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRoKQZfO7pht9Wirg1OMoMcAiI5czf2aQKUUClvakZs=;
 b=PoIzfPJiH6crVS/tBXoPmmOl+PIX3LB0fBFu9H7anEP2QCKAb688JT1ue2AvfAad8YUJXVGCUSUKFbscocZaTZPiQCMq1Jmu9mluDu2bSu2l83woWJzwPt3cyO86KQZXkgqQATFZVmQJVZH5CXXQJ2XZkEICRA+7rdmC7BahnIEROlYsfSsWn5wZSZfzMdkm6yihoON0gqeqR4ynjRh/2S8yW9foB136Y6KbC0DroQS+kfHOTW4dYS5mivHJeMVeDQrx2MqP0fLILVOlqxFtjwi0xV2kGB0sWN7PHww/HN2/ewFAMxjkKhN3sKnbgHfSaLoHkdI9YxMJaX8gOxYWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRoKQZfO7pht9Wirg1OMoMcAiI5czf2aQKUUClvakZs=;
 b=yJAZR8GlxAM2NMJQYWcglcKXmJHXRXhdwHUrJlOb05efZxK9iRl0j/ycpxe+hPNDC9rvEFDy0qWaVmroomETX9u1PUsmbqbUeYRRjuKOcpNTkj36+Lj84dKp/T8Iom1V0pngOntbf9XeKAHQGmCRC7/RGcyQREBQfGWh5ZF/oqKxB1PtHLGpbrcUmWC6Ujy1YHDEULgImNNkBHolrIP4ZCbBDehqvW7icy5z4JL2nV1s7Zk1ayBm9Dk8YFUspitdyuy0Vqw0ZOb8kbn5dyuioIp7y6qzgaq1z2xMRMlf/EKNtE76G96bIzWPkkmTpiGUYPbxUhSj2ku3chiY638TFA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3767.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:167::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 17:10:14 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 17:10:14 +0000
Message-ID: <2441dfaf-ac8f-4dae-87a3-d66e29400fda@siemens.com>
Date: Thu, 12 Nov 2026 18:10:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isa-cip-core][PATCH v3 3/8] dosfstools: Set debian suite to
 which the patch is to be applied
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1794466758-28304-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1794466758-28304-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3767:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdfb869-6aaf-4d5f-ba32-08df40dfd130
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|6133799003|261026121527099003|261009223027099003|261022115727099003|10067099003|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: Uf1ahDy6V6ipohZBN98rDUn/1Ai/PIQ2btSxIrrbFlNHbW+MuQZMqMqK7sZ6CV/ejryGLFb5JSgK+rx4WiWm/J4+vBbdZKzv/rHkYSzYEjjZzxtgh/1ckQD8dPSy+AVPMTViWOCH9y+jh8dzDusx+IWFVhpl4uwyJmlWCzbkOhqOOjPjht26yS0hZA1l0n9WdLnWUpo3JY5281cXF9CuoNPP9jNHgXltyxS3ixy9HaLISDMfVy+B/y4KVr22iQOsm+ViCj2n1qMqdNbKClWjG+65Z7+oZmYVm75BS5R+twR/x5Y+Zyx+6pQ37xRqBt6Z2+WePvoqLOwYtvFI8w2jPkDe688ebRjVqKQV2gZhtRn6DaWIpmMvVkiDsE3loSSVQGczxaXOtqt6P5L8X4Ry+kCm2OcQ0jMVQeZ2e0i9VkPRLpd1GRegQGn/31kLIeGSarhQQM9LljHT3DoklHSNIbtT59qNec6K3I8YYZ81ds+bhjR9NN5e4UXHkt5WeeE7CGjx1WUDicAqiaTWyT19AvNsKgf3YXyQTZBIXpp+czWgxiLLMb3rzvPuosQt3WzYKsak3WkIHfU0Zj0iRO+FT2TBbhL5G2quJ78/c+doBNoe4pVaBrzjOcqGknRnYlessW726PcveIpUqcV+y9rTAzGvyD5CRpobOpsLRrzU6WE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(6133799003)(261026121527099003)(261009223027099003)(261022115727099003)(10067099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2tnQkc5MjNxV2xPMEpLeFNjTGhhdHptcys4VWs3REJkc2psRS9iVm9KUGJY?=
 =?utf-8?B?S2YxUStiak5oOUFPMmZMVzJJdUxOOE4vVDNSTEZiT005ZzFrSTNtcjBYMVVM?=
 =?utf-8?B?a3VnSHZIcTdhT0Q4TExEc2VTOGhHSnBUMDJaaUNGRWx6MUJlT05DTjJQQVNk?=
 =?utf-8?B?d0xGRkVuUGxFZ0xlQjhYTlJkV0pndFNWSlVHUitieGF3RitFQy9sSDdMdU4w?=
 =?utf-8?B?L1FMUTYxL3h2YmtMV0hlazBJVmJjb0hOaTdUY3Z1TVdFSEFaNGdya0EwMTZ3?=
 =?utf-8?B?NkxGS0c1ZkdqQmJjWXhLdDhaTWhxR2FRYkp0RHpDdjVOcWc0ZlVObHRPa1M3?=
 =?utf-8?B?OVhaVFJuM0FLb1N5aENETENiSWZzQVZMb3psTGxqT1Z5MmdLQXdBVUFrVlZs?=
 =?utf-8?B?RGcyQVV3YkRlSlZYNGlNZHFOcnNtWHpQK2xmcUVnRVdSaVQrbkJ0amE5eFgz?=
 =?utf-8?B?c0RhaUp6ZHZoaGJJUk9ZNkdhV3g2MjM4U3BmaGc2SWMvNFQyTGVVR0szcjM0?=
 =?utf-8?B?dTNtcHdVbElIZTdtOXJ5UzlaMDUvSld2VmZPbG1Bc1dGQUdneis5cG5zdWRw?=
 =?utf-8?B?eEVoSXVBcmxteE5QcEN3aVhRdjZRdVoxOU5hdWo5djY4OUQ2bTAxT2haRjZn?=
 =?utf-8?B?VWZxYkdnZUt1RkJWMGlmV0gyRERGTUpOWm5FcDJtb1YybTJsZ0MwZ21hUitY?=
 =?utf-8?B?QmEwVnJqYWVvYUNTdlNIYTM3aEVCVVM0TGlIQ3dKSmZ4d1ZCdWNPMG1haEgw?=
 =?utf-8?B?a0JQVEhLZGtmZHlxN25VamN4S3VNQ3dRZ0x2NVZkdlVUbWpOMW5TUkZFbkho?=
 =?utf-8?B?UzNqOHNvRkNIM1Q2aHd0OC9KbEh2TnpkcU5lTWh6cjlKVlpYQ1hmbjk0TVha?=
 =?utf-8?B?bkEzSUdiR05Ub2xFTU1EVEQ2ajJGa2VJblJmTmVETjljQXZMZTNuaEorMWYy?=
 =?utf-8?B?QW1COHRpRUxwbERFN3BvWGJSMFpFYUxOWDdJRDhzTU9vTmF3ZUtQdVp1ZWVJ?=
 =?utf-8?B?ZGU3eXZvNVl4VkYrREZ3dlRTQzN4T1h4ZUF5NDhtY0hNM0FoaEpSMXo2dUJR?=
 =?utf-8?B?LytPV0FOK2hXM0hFRlh3VFNjZUUzRlcybFd5Q2U5bk5XNnBqa3RTcXB0SmJh?=
 =?utf-8?B?VkppRCtiU3c4OXBYVlhLa1A4TFMzMml5UG8wTGx0ZWVZSU9vV0FpM2hOTzIw?=
 =?utf-8?B?eGxhZkJ5ZVlLMlFudzZRcGVmbFh2aThqQWhHZnoxUk1sdDNDQnYzUTJXRTRR?=
 =?utf-8?B?MGV5TnBBMngyWExOTHphYmVmWGxMdUFiSXJHdjJ2RmoxNlBsSjI5Z0g2TXZu?=
 =?utf-8?B?VkdOUjJWZysyd3JKNVkrZk9pcjlOT1VxYW4vZ2JlY1pXc3Q1cnF4bHpaMmdY?=
 =?utf-8?B?NkRjRVRRSGxaVVI1Sm5KR3hua2dxVDhBd21jcnJ0Q3hzTyt3cVNKUklKY1Ix?=
 =?utf-8?B?TDlYeE9vYXlwZk5kZGNyWmY3b1kwSWZVNHNZeWNpWG12L0dlSWZNQ3k3SnN3?=
 =?utf-8?B?REpPZ3BucDJFK0ZqaDF4WDZacUhPdW9MN01aYzcraXBWR1dYc3EwaUw3R015?=
 =?utf-8?B?YlMzVkJuU0lyL3pHZFR6MHQrSVUxemUySnZwZEwvMGFabWhRK002U3VFRDFB?=
 =?utf-8?B?aUEwT2t5cThldk4wWkJrZE41U3U5NGVjeEY2azZXTUQwWGJXU0Q1dG16Mkhm?=
 =?utf-8?B?YzRCQk1SSnNsVG9ySTM3dEUyQk5HV3dpb0kwM0R0T2U2cXNGdmFCbVhJRkY1?=
 =?utf-8?B?MTFlZ0paUjBwcitQNnJ4bWw1NDUwL3QvOXdidk1ocnM4bnZwNjNrZFJzcVdZ?=
 =?utf-8?B?TDZUTlptaE4zRnFLYk1mNlJwZ2h4RUFMT1h2R1VKOXMzaGs2YjBXQmxuaVc0?=
 =?utf-8?B?b3BiTnFVY1gyZnpyOUpKZ1V2cmc3R1BXVi9JZjlMcjBnWGN2dXllQVNiSHpT?=
 =?utf-8?B?YlBVaFBoWkZQTEpqSjZSTjd2ek5oOU9jSmdXRzNmeFlsdlMvWm1kb0xkTzA1?=
 =?utf-8?B?d1BFVzNPTXpCZ2JKY2h5bStLSkNjWWd5SVFYcHR1Y1pseGpaZEh5M05WUlNm?=
 =?utf-8?B?RHNtdE1EQ1FLVUZvcm5VVGpQMW0yaDZGbHRUZVVmMFM1Skx3VXJ6eEhSYlVE?=
 =?utf-8?B?aEY3dEFYRmJJRWhQUWEwTm16a2FTTkREMWNCNEQ1SUxOaHNWWjZVOWZYRkpr?=
 =?utf-8?B?Y0J4MWdUTzFIeHZFTEFqNzd0SnQ1WUhuQlNiOENCZm9YSVdXblBCbDhGL3hq?=
 =?utf-8?B?bzhpN2w4NWc1YVR6WkdNcXVPeFlzYVBxMzVCUk53Qjdtb1ZhcDJpdXMvaERa?=
 =?utf-8?B?MHdIRnhtTG5FVDhwWFNMYVhLYTVQbUpTTlJyNE16eHRxcmFaOHdXZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdfb869-6aaf-4d5f-ba32-08df40dfd130
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:10:14.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7SLKoAaDOCyoSjRdGcMk30LzZQ7B24kNMsLATRXVmdNytp6ytIyUdnKuNDsB1C8tBV++nmVXkZYzCR8ZxG2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3767
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 17:10:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24787

On 12.11.26 07:59, Nobuhiro Iwamatsu wrote:
> 0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch can be applied only to
> bullseye and bookworm. Therefore, this specifies 'bookworm' and 'bullseye'
> as the suites to which the patch is to be applied.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
> 
> v3:
>   new patch.
> 
>  recipes-devtools/dosfstools/dosfstools_latest.bb | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
> index d0ac128..1c94301 100644
> --- a/recipes-devtools/dosfstools/dosfstools_latest.bb
> +++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
> @@ -16,12 +16,15 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  CHANGELOG_V="<orig-version>+cip"
>  
>  SRC_URI = "apt://${BPN}"
> -SRC_URI += "file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
> +SRC_URI:append:bullseye = " file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
> +SRC_URI:append:bookworm = " file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
>  
>  do_prepare_build() {
>  	deb_add_changelog
>  
>  	cd ${S}
> -	quilt import ${WORKDIR}/*.patch
> -	quilt push -a
> +	if [ -f ${WORKDIR}/*.patch ]; then
> +		quilt import ${WORKDIR}/*.patch
> +		quilt push -a
> +	fi
>  }

Actually, no one should build this recipe for anything that does not 
need the patch. Maybe rather enforce this? Or at least warn when it 
happens because it is a needless decoupling from upstream maintenance.

BTW, what took you here? A real build error? Are we pulling this recipe 
into buster builds? How?

conf/distro/cip-core-common.inc:IMAGER_BUILD_DEPS:append:bullseye = " dosfstools-native"
conf/distro/cip-core-common.inc:IMAGER_BUILD_DEPS:append:bookworm = " dosfstools-native"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
