Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E1C2BBCA
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 11:01:45 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.65])
 by mx.groups.io with SMTP id smtpd.web10.14541.1719572503245828754
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 04:01:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P1Y4u1Gs;
 spf=pass (domain: siemens.com, ip: 40.107.103.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpQgbFm502ODo9+nOwzxC4SR7oP+qyJFdSUrNFEInITz3A2+D9Jd/vzv/EItHKac+/HJ9nBzrR6PNiGFfCUd2b84FTbeFdoSyJtuYSIyubL+YG0XGipSMqoJQv6IBdaAdn2J0lj2421E5/jPY1wg1xJBEbttKzfwuq0wAdjhUne/hAVZBFAmxbqHPOzLs4nqbHDs37P91ejrblDlz+R2nvaXEqYj4VOYbuV9dTBG6xyJ6IzVM+cTCke4GekpbOfWvlJ9ryDWc/fSRpGAiJoSE82BrV/aN+lBjRjylKdRkCyaus229VJtGLtJDyqKneeixuhxgd+PvH8ohw83cSgW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l51dVE8K1sX8S0ocByKp9DCIxPsrViDne6autj6iHZI=;
 b=Zh5Ev3C2Xit7hNTwB1vAgPjYOakCP8qNE02ZH59R4/fAtiKNWdNNcEOiTxDcSN4A/fad0H9ZveEmV/fk4q70Oe3ZdnzFAsul3FSHq9OV4b4x0CRpixzMWDgyHk4ha/S+vaa1eBryCrfLKPe19pTIAVx6yngYtzd0nDwToyf+Wq9ehTQBAVn1VizwUY/2NYT1R8xjeg1xoSw2Wlv9afeRmsifIe1aT1XmjWPNxc5uAEqUdNF4dKcgg0TU24hQ2wburFKF1+X1fhwuszGZ1hAUZl94Q5D5iS9Mbqqskehx2c7cgxQAXt3JKmBpEAYgmgvbKZb+91lmLtUse4sdTRi40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l51dVE8K1sX8S0ocByKp9DCIxPsrViDne6autj6iHZI=;
 b=P1Y4u1GsIahLG5H9/6mVFUFc59l07DKy/OF4MP55CQ0b5QaH2xnDzC3H70BzZMtm7wa3DAJaQ9euIMYfTYRrPR9LdJ2QyhJhVNJZ7qvhQK+ir276KsMh3hdYzybHuaEZWvjLADxTIlPAKv5iC8KR/VCjg5SPpGqmwGachPz1bbFNJVujdamICdhaKeySfP5sJr0PY8nqb8VKD094gA+cR4LK92rMjIwrH6b5zLhbe5rxZXx7/xZgP0A2pRG1FicYXqWxmntw+/q3Ksy9iIAmvOIAAtsauh49k8nJHnbUlGCzR3FQPe7uQ8IAOuoHIgzCZGAuY8kJVr8ej3Wbyxo1QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 11:01:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 11:01:37 +0000
Message-ID: <67e51940-7188-4713-bb14-b20858da9750@siemens.com>
Date: Fri, 28 Jun 2024 13:01:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] submit_lava.sh: Rectify condition to push results
 to relevant projects in SQUAD.
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240628043827.3608797-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240628043827.3608797-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: de6b34b4-77ac-4783-990b-08dc9761ae91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmJVcUVqVXRlSHZkVE9mZER1VktsWXhBQXBETWk3SkMxNUdQRWxpWjhiNU1x?=
 =?utf-8?B?ZWdVWkFFbXlhTWRLLyszUisvZWErMjdya2dLdnFJTDYxUmtpOUZrWlpxZ0dH?=
 =?utf-8?B?NVkybzllYm45aWE5b0MvdkhLME5WcVFUemkxQ1BnRTJheUJXTHZ3bEN1UTF2?=
 =?utf-8?B?eVI4dUhHNHRjNyt1VEkwZDc0SVI1S0o2ekc5ZDhndlZXaTkwcVhuL05nS0Ju?=
 =?utf-8?B?MTh4RVJKVGlPaWZkR0xEdFk0OHBkVGZodmg4QUhjOUJPM0trUDRBMGM4Umx4?=
 =?utf-8?B?VEZ4STRGaFF4T25vdlMzaTFzSGpLWHpSTGxOeThFcEhtSGI2V04vZWZBbWll?=
 =?utf-8?B?bUltKzkzRjg5QS8rZWhQdjVwMzdNczVOZUpqMGhuNGRVQ3owTWQ4RWNoL3RH?=
 =?utf-8?B?eWNRQUREdlBsOU43L2x5ckNLUVg1dlNoRDZCbTNSb0d0b2dFVmhIS1ZZd3A4?=
 =?utf-8?B?VTNyTURKcGxNcWhNdy9pOG5GNEtobU81RndJbElWMHJKeFg5YlNYY0NiWEsw?=
 =?utf-8?B?a1AvYnVENTRHRkNTakNkcFkzTUhTTWRTUDE3SS9EUXJMNGVoQlBzNU84Tmtu?=
 =?utf-8?B?OFZXTzZlT1NBOGFTUkJ5a25NU05iZVFmcWxzUkI4VUlZK0FNYXpuKzZDZ2dG?=
 =?utf-8?B?QzJwNXc1VnNHU3o3VnprSHE4aHhxbmtOM05uTVRXV3RpV3VTZEIrZnlZdXNr?=
 =?utf-8?B?NHNBRFJKQWhwS01MTmNmV3p5REZBcFFZR1Bsb0NKaGJxWm5Xcm5xQVowY3VM?=
 =?utf-8?B?UWpJOGRYZng3NVlGbjVhWHM0dDl5MGc4dXhuM212emZ4dWdBR1gwa0w3UU9h?=
 =?utf-8?B?d2MvNUM0L2g3Q2QzVTlZK3ZLU3pGWEtLOEQxYUFOT0JaVWplR3l5NWRmeDQx?=
 =?utf-8?B?YnRybjBsVGorTWdWRnJUR04zQXNOalYvSTRsV2VmOEZ2Mjk1SGRlYnJneFBH?=
 =?utf-8?B?UHdsdFNFSHdVWWlJeUUyNlY3L3dkVnN3UEd1dW84aXhvOTVoTndtb21EemRX?=
 =?utf-8?B?eFJCcUVBaWJpODAxNW14SlBxWk9JelpOZXI4T3AycWsvTE56SjVTMjBZbG1u?=
 =?utf-8?B?QytCajF3b2gvaG1KNVI3cE8wQ2hHRGpMTE84bHpacnJKeDhBR2JEbXRhMG1t?=
 =?utf-8?B?aGdoZTM5c3lhK2NnWWdUZWpwbWdPQi9lYm40VjZIcGdTOU9pWFB6UE40TjRm?=
 =?utf-8?B?NTJEZ29RbHNNUlpaOEJuYng0V1JxMW1HcnJ3dDFKc0JwY0VlY00rUnlRZEtK?=
 =?utf-8?B?ODUyTFBuOUlWMlk1SXh2WHI3blh0RHVGcDJQMGp4aTFsMXJsY0p5ZGJlR29V?=
 =?utf-8?B?eU5ZZlpEWjhaVWo5VmdoNTQwbU9nbk96b0JNOVl6U1JNQUdYVytBcEVhd0hL?=
 =?utf-8?B?Y3BDYk5YUkdXQW8vNHBSa2l5YXlyVmM1SWpCc2FmVGsyM2kzSDRiZGx2M3p3?=
 =?utf-8?B?ZSs3MHNBUmRsTU5BczZJTTgzcGpDMStYbkhOQWl5VUVtS0pQZDh3TmRmeFN0?=
 =?utf-8?B?YlZGK29DSzR2MU93ZHVSYW5CWFUzTm1qVUhlYWlQR0VPZ2ZWY25qN0ViR25Z?=
 =?utf-8?B?aXFxZjlZYktBSGUzUjgrQmRzeFA1ckg2cUpKSjdybzliOEdpT2ZsNkJBS0NL?=
 =?utf-8?B?RXJmbWU3clhBUGpLV3MxalpTY204R2hPZ2xKaHR6Q3JRT1cvZU93Ky9VNkZU?=
 =?utf-8?B?bU51RDEvL2JOSldwYWRzLzd2N0RHWXBLM1I2N2txTytmck5BclVpaVE5YkVQ?=
 =?utf-8?B?K3FsODQ4eEttTTdCTmNNTnZzSWtSN1RFaXRac1JpeSt3Si9JZk1zODQxL0ZG?=
 =?utf-8?B?dmtBanJuZlNoY2dubFRHUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGx0aXlaMHhaUVV2bExQTXMrZEJSTUwvRGxqeDNURVN6V3R4QitwcVRQcjNm?=
 =?utf-8?B?QzluRHEwaUIwMHRsZGRENk5GM2cxY2hEUWZuR3J5czI0b3RyZkdKR2ZYaXQy?=
 =?utf-8?B?MmMvV3E1djBDMEFzQllpVHgvODhlTXdCcXQ4Zk1rR3JvSFRMTjlOZG5oRFIv?=
 =?utf-8?B?dFNCTXdVdG9NV3JOOGFoTHhlYlIxWGFVYUJaYUg2Y1l0czhTbGZwK1h0NnJN?=
 =?utf-8?B?RDZmUEZPK0JOQnZpaXVzTmd4NTZOMWdwTkVMVGlERWpoaVVxUXdMSzF1dTA1?=
 =?utf-8?B?dXpUMnYxeCtEUWNCeDdGTzR5ZlFLeEc2dCt6VVF2VlA4bFNVTmZRd2gzSnNG?=
 =?utf-8?B?ZGY3dVByb1JPUUt0WnAvOGtrK0lab0xBWkhHWGtMcUw3TXU0ZjBtY1I3SElh?=
 =?utf-8?B?b2phV0hXUUFqOXcrNjJhVm9JdHN0TWh2bVhNVHZ3cjZIU3dWNFJWZURsRDE0?=
 =?utf-8?B?SHd5YVZ2Qk9KUS8xVnhuYjY5d0pwK0c3ZkN3d0xncWtTU1BPTWxsOHRldVVl?=
 =?utf-8?B?eHZzd1R0T0tWcVVMblplMHA5RlZ6NEoxcGluNisvZ1FidEx6R0VTSlBYdEhl?=
 =?utf-8?B?MFd1dWZtbmdmeWsyRVdoR1dmZXNCc1B5Z0dWT3BCZ2dXNkpYMFdXNEo2b284?=
 =?utf-8?B?eUhwYTgzUUJjVmV5S1A2d1Z4NWNmckI1OVhjWWRQNHR6ckxLSTJNanhDd21h?=
 =?utf-8?B?VzgyQkx4M2F0ZS9XR0pueFZuNE1GbG05Yi9YOVNvSlM0NVk1b1hrNnN3Y1Uw?=
 =?utf-8?B?WEVWdjQxcmpBd3ZobkIxay9zVkt5OVdjT0Y1QXdYUGdNbkJ3VEtqcEh1SDVu?=
 =?utf-8?B?amNKVzNZN0tDVUR2d3hmcGw1U2NMQlAydzJod2k4TC81MWxtbUo4b3NVckU5?=
 =?utf-8?B?VUVJUFVPRlhoNEc4NUtSWXp3dlFjOTA1VEZJVnJoVFIvN1RlTlFEU0twYkc3?=
 =?utf-8?B?YVVVS0ViRUVKYzZYTlJBSHBMdUx2ZEJLeUVjRnV3bzdCL3QrUjVmenM2WXFM?=
 =?utf-8?B?ZjIwVVdwRUJBcnVKTDhoSXhCZTlGdE1oV3c3OFgwNnZuaDhRUmRDMERFd1Jy?=
 =?utf-8?B?aERrdU1FWml1ZTI4aytRa1MzbW9OQnZORklNdElIVG9GVmdXbHFIZkRnVkJU?=
 =?utf-8?B?bW9RV3JVWTI5MkdXbmxwMG1yUzhBZ0dCVmtNT0lqZ0pTQW9nbDVRTitYOG5z?=
 =?utf-8?B?RFFGMHI3YUoxU0ZWY3Y4ZDBxQWMxSzQ2UDE4NHl0ZkVvb2dCVkJIdjJyd0ZW?=
 =?utf-8?B?OEJJeWNlb3M5bVJtM3VRQlByaHBHekE3R2JaQW9TNEg5NW1qb2JaT3JwUGZj?=
 =?utf-8?B?aUxVY25qY0pFb3JUR0tvWlhwMWRIRlF0SzV2aEVlcmdZYkNObjdWUkptU2th?=
 =?utf-8?B?WjlaV0dwZi9IaUptSEt4SG1qZ2xUNll4TXBLQ1puMFVETEdIODg5UXdKWlFr?=
 =?utf-8?B?TjhxTzF1bUxrWGxsc1dWencrVnhHNlB2Nk9uUGNyRit0dS8vbU1YVGhsbCtW?=
 =?utf-8?B?aDBuQnludUN2MDJPTkkwUE9xOEFWb1JjY1NLV2FseURrR1BlVk9OcXRhajQ2?=
 =?utf-8?B?MlU2M2dQY3pIcVJHUkFYSFpiSk53UG9SVExlNXRwZFl0NFIyRnV1SkhzaTFp?=
 =?utf-8?B?TjJaNGV2ZmNjcFRDaWdjdmVVbzBVdGo1SkRqalRPN2VHNWxFQ3FHbkRLKzN2?=
 =?utf-8?B?RUdVSnZXTFhpYnM5L1R0TDJnNkRLRWZRV29OWE9SRGluYy8wMnJIV2tsTHVT?=
 =?utf-8?B?aDgwWVQraTJkQkNNTnk1M2JsN1lIR21PL2FKMkozbXNHZk5TVk5jSTBhZ013?=
 =?utf-8?B?WkV3aTZ2N3p5eVpCVTdQdzF2aUkyUSt4aFlZWjVCOUd1ajBoRmh0UGRaeCtL?=
 =?utf-8?B?WCtybWZoT2NFeWxzUURsdDJiQWJsclFITVQyL2Rnazl0NmpnaWplOGdINXhX?=
 =?utf-8?B?dUlvcGV0T0ZsMk0rVHlCaXNjUktBbjNndjVoaXFzNXpIbjFpVnpsZ1h0RzJO?=
 =?utf-8?B?RXdGVFkyVG5Qc3FVbkxGS0d6RFRrQkFuYkxNanNkckpST3NhSGs3NXVIQ293?=
 =?utf-8?B?UVVZZ1BMTWkvTlVzS2Vzci8xdW1QZElRRGxlWGJ5OTdwYjN1TEtDYVlhck12?=
 =?utf-8?B?VS90RmhqNVA5dHRpcFhZSmNsR3JlSWJ0N0NyR0NKTGM4ZkM3OXFSbnVJTlpK?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6b34b4-77ac-4783-990b-08dc9761ae91
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 11:01:37.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuScRLepwnDYOxgGnpGH0gjN+GjCENputWgBqewDdio3b1uUCgyqAo1Vl1dbnG7Xfy1+Y5/lxPd2XGGdaLdXCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8386
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jun 2024 11:01:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16342

On 28.06.24 06:38, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This commit makes kernel-panic, initramfs-crash rollback test results available
> under swupdate project in CIP SQUAD.
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  scripts/submit_lava.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index ee8dd37..4b1b671 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -103,12 +103,15 @@ submit_squad_watch_job(){
>  		return 0
>  	fi
>  
> -	if [ "$TEST" = "swupdate" ]; then
> +	if [ "$TEST" = "swupdate" ] || [ "$TEST" = "kernel-panic" ] || [ "$TEST" = "initramfs-crash" ]; then
>  		squad_project="swupdate-testing"
>  	elif [ "$TEST" = "secure-boot" ]; then
>  		squad_project="secure-boot-testing"
> -	else
> +	elif [ "$TEST" = "IEC" ]; then
>  		squad_project="iec-layer-testing"
> +	else
> +		echo "Unable to host results in available CIP Core SQUAD projects"
> +		return 1
>  	fi
>  
>  	local DEVICE=$2

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


