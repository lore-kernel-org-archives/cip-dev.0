Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076BCD1292
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 17:27:23 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.102])
 by mx.groups.io with SMTP id smtpd.web10.113219.1712597233146429729
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 10:27:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I1drk80j;
 spf=pass (domain: siemens.com, ip: 40.107.8.102, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7L3I0qP/vBU/UMF1ULCDvC4ljYfabf/SlQn1D+9Qnr/N74IF4DP0uoySkdvXFSc0eSwoBO9i1M6qTF3OWSkAV5YJmgmdsU59OcCAjHdHBf1L6lRwFF7BzBoJmmH+xCEWny27m+xRgTkloWbmkDtU3x6jaH5ua1PQoWshdyEVPrkKN3WzsRDrofZLoqPX+Q6MzpaRNu0nKubkmynWDrsP7TnNc/sB6L2xkeEGk6mMaHMbK2sJaRItiLBk0/lG8mwAT9kM2icxr+W4BhUP8Fky4iH/fgXj+KFWHxmf2vAqr/MSXyxdqTxFyXwLhpXf6kJpJjxVL0U78uXn2w3bbJiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U/wcVlRTxcpwyArl6hsuj43jrrXINjtrQA/ZsILt2g=;
 b=l8HRqbnk7jzrilF3Sray3plUsG7MySEfnb5e/8M0uLGsa/6ikOl5IdUdWxVUlP8e4rehOSIcu7uPRwDa3khsR8ZpkrIMBvsVfnR1D5vk/gGscttHaxCQBSY+UuOHk5s1zCTIvOcsYIKua0tj6UFUtFfuJs/USY3UWThrdnvrAIUw3gitb+Jn+yvj5EWxMJOuj1WbYnnYnxY46lDLOm9lFbiN3gUFRhFeD5EW72sPJ39uzzUp+rs/tdIHED6r2JZ/DR+eHjwYq6ZhFY/1giRzzUQV54aY4nSGwbwRwPxyUsTj2EZ7mQF7LYPHi3TDwm+k6I3cAsg3ZIHcvrhkmEO8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U/wcVlRTxcpwyArl6hsuj43jrrXINjtrQA/ZsILt2g=;
 b=I1drk80jBinLVm35moIVhKu6w9+kVcFvweEL78+bkIWyUWD/cBIucFz44fbmHMr5AEzoLFMC1iWL7fER6bwL7wVB/1fc9Dfge31qFZPIi+ka65lOV1s5zhlNf83RtMEehBelzdHOIZLh9HNAXPWxtaV2yG2CM65RRMclvaIlXRf/h+EcK0vVzamdkQFt53Zr1HX4JgLy0wLONgPuTQKe6PNSSP0u+3Aya8wbsRmiNA2dcD+Oz6CVte1XBpYzSpdQuVqv4HCuK1LUw6yg6EMGa7Lv6NcFXFBWpVrwGBCSVMcj7SnosxGPy1T7Fap64giQ/qpIqx6yUvu2PPDEbF0VfQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:451::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 17:27:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 17:27:09 +0000
Message-ID: <3aabcc73-f77e-488e-a4e7-26d32dae9065@siemens.com>
Date: Mon, 8 Apr 2024 19:27:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] layer.conf: Move SOURCE_EPOCH to
 kas-cip.yml
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240408124535.300693-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240408124535.300693-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:4e::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7172:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zudy0ClcQ76QEqs5CnQsNSepA296WDtTXV6slaKMIThga1r4bnRGUJJvZ34hR3WU5ZJTTZ+9w8kWLYbDdzzeaETW5MkbD4A0EmvqqzJIu+XKvQi8YcduQCpAVFXkB72QPlbl9ewBFeser5nZAgryoGzxQi+rDvF5eWqGpUI1fLq1MfK1igcIad5yMzrBpa2FLiHnPhDhW1WM71Go5J0QqM+5c2u0EtAfctdumKA8psAbt+ZrSjYNyuIcDIkNz7qGbgyHFju+zDrmdPSzJx3b3pOUMjVp06b7q7GpFpv2OjHO5gpx9hO4jFz95GkW4cBHE3rM24JYDi9qYFDR+Pj0KmX/nTEU1qoalZgH4EaKQyR6h5ylVXFlzN0uftXlLTUYpKPx4NXqkvjlpbU7XedCFtrZHDI5ayZAVlJUdxOwUzAdfX3IMa3fWkNm5oQm4n2/+YdK4Z9/FtQROQ0ol3ng8Hy2GLhWZkXqigqGJ9amohxIFpFnocCYrotdhjoyoZIoOqF1xve2V7C+r1N+ey95D4axiCvIPpKjcsKW0Sl+JaO7vT0TUDC2ySlNC3XpDlZGMWREjSjqlL09ReybRKXxZllfPxZF/bqxBYkrmHRW46XnJxG8mUH2mfD5VnHz7uWBoodEZAgfCjeMcgY/I3ZLoOAY9UYlhmAO0GhN0XcvNEI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmRkMXBMZlJ5Z0JDaWYyb2oyZkhmNzdNbTB6dHkweVg3Y0Q3RE02OHZTNUxK?=
 =?utf-8?B?UGVHUTFPblRCWjFGY3FPTzM1OHU0Qm0rY0VhZVA4cjBNa1hFMkZWUk9lV3JJ?=
 =?utf-8?B?V25DOEJLMm1NOHpJQktUQStCNEtVaW54V2FEREZqc3ZYbzUvQytlaDVlbDV6?=
 =?utf-8?B?ZGhKV1ZyanhYWDVxbjR2RGVWYm1GMmh2VU5remNXN3oyZUZiSDU1RkhMR2Fi?=
 =?utf-8?B?alp6cjhkTGkrTTNvTmtBOFNVVndnZS9ySzVZMXkrVk9tWnExUlB3R2xCWEpL?=
 =?utf-8?B?VTM0Z0pZZVFGZlNjMHhERTZGYjIrVUxLWVMvdE53WWd2NUQ5S00vcDY0SGtn?=
 =?utf-8?B?NHFVdVQ5TzR3RXlaZXhWMld6ejJWSnpUUEdXdkQ3WFhDMlFwNy92K3p4Zy82?=
 =?utf-8?B?TlhBRXVRL0U2TDZjQjM3dVo3NzlwUlFqdWRaWFFZT2tSVTh3V1lvSDRTVUZY?=
 =?utf-8?B?UGpCcFpTZ2VaM2J1L2xmaGZ2cTRseFBlYkt2K2xzYnNJb3UrVk5CSC9EMHlC?=
 =?utf-8?B?K1lkUUM4TENsd204OFZ3VkF0UWtSaFNUQno1RS9qclBWOGRLYzIvMndPcDQw?=
 =?utf-8?B?dzRIbktUQjd6V2pTMEZRYzJqQjliZVJwRndVR2RRMUNGa0xJb2lMKzh3azI0?=
 =?utf-8?B?RVNKd0FaZ0VaR1hna1o5dlppNk1aREZPS3lkN3dPUk1OVW5uTzllZzZIM3ls?=
 =?utf-8?B?M05pUFlybGhRMXJXcHRXSzRSdG5MbVFpWHo1Z09qM1UvZ1k1V1MrVFBrZzlp?=
 =?utf-8?B?bGt3aisrRW91bDVpYXhTNklTU3RMYXBISUNiMEloVXA2NDFPVUsxL3RIOGU0?=
 =?utf-8?B?NlJWc3JtU3FmamVCb2hOd1RWZEpvc0doQmFiVG9MRWhRdi9WbWtpMEZnOWlh?=
 =?utf-8?B?S21aV0F1SDdJMkJGQ0xGY0wxL2xIdzUyQzVDUVpYckRnNCtnUTZUTkVSclk1?=
 =?utf-8?B?TkFHdXptRElLOXhTVDN0WnFJVTRsU3VGWU9UeC9HWTRHZnNVdWtvd05nSTdB?=
 =?utf-8?B?MEZyMFpJcmNHUzdXUnRHOStJVnNoWkZPK01Mdk0rMUJUam9GZFpHWHU4emt6?=
 =?utf-8?B?NlR6QmZlK2RRUjZ6R2VmNzFlU1RjM1FURjVaeG1ScXlPTE14dmhSd0lFZHln?=
 =?utf-8?B?K0Q1ci8rQzZwVGZSNFVaRFZYTDdlOHppc0RMVWlPZ2xXQXdQMGhaYnZmemJK?=
 =?utf-8?B?MFl6cGtYc1FVRDZkK09jWEs3SVZRZ0RrdHMySXMzcmY2L2RWRDh4eTJGaG9u?=
 =?utf-8?B?aHlFbUx1MS9ES1ZqVVBVVXFPeFZSQzVJVXVRSFg3WWk5aktoNS8ybnVzbHVX?=
 =?utf-8?B?clVkbXFscGpQRnhOSnpxTExydDREdktvTzhNS0JOUENKSUppakNnem03dWJ6?=
 =?utf-8?B?WW1kMUo3NEZWWXJnSGJhQlVZeXlFNjZzK0pmYVJwd2U0WlkrNzNNN1NiaEFx?=
 =?utf-8?B?bUZvZlhRZFVpNFlwNmkvalJzUm5rcHRtcHdLRlZjYm5OaVlHQndNUmhZeHB6?=
 =?utf-8?B?MFNTMy8zUUlPcnZNUm1DdFhvNDhOUWNzaTZDT3VNcExiYTQ2d09PUmxITHo0?=
 =?utf-8?B?cVNNSFlWMk1FaWFjUVU5MDkxUmxQOXRrQzQzKzBOMzVOTC9YVm05VUpKN2ox?=
 =?utf-8?B?V1ArUmR0N2hEbHRvcUpZMHE5VTJjS3FkdFZLbjhqQjNMcUxybUQxeHhaOWVv?=
 =?utf-8?B?RXY1dUxZd0lFdmd5cko5MFhiWm5KWTZ5SkVOdk5ieDk5TWV6a2ZsenYrUE53?=
 =?utf-8?B?L2RmS3V5eFB4ZjlLa3c5OW9DWmVESkQ5V0hpaHNQNHFGUGh2MVlDaVJIZlVt?=
 =?utf-8?B?Skpadk9pblF3UC9YdWx3OXFmYmMrRWh5TkNTZCtUallMR1ZPN1FrVG9Xbi9j?=
 =?utf-8?B?Ni9hY28yMmNPNTFKdGZ6aU54MFhjVWFvOWFOV3VNd0oyb0lHWk5IVE80YjlP?=
 =?utf-8?B?S1I2Nkt0c3BvYjBXblRJdXFva0J4WmptOFUvbkFaYk94bjVweW4rOVcyWHo5?=
 =?utf-8?B?RDBoZzZSWjFvWUx2am5IV2NrVThkZ0VWVWhlWWR1by8xcHpkUkNJMkhQRWcz?=
 =?utf-8?B?N0I1QTUxcG9LSXMrcUg3S1p2My9IZTBleFRodU9udXMwMGN5VjZMM1NrVVdP?=
 =?utf-8?B?RHRiem42WkdxV09wQVVDdmRuYld3cGtIT0NlL3MxQnl2VTYvdWpocUQ0RmFW?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b00edc-06f3-416b-b3c2-08dc57f11ec4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:27:09.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIaA4fP1GW3nEcb5f+F2D3iD42TcUoHTT0OzkEeycqCqwGpskaYnaTqri4VHOta0/lpT8cOZg2G5m0a1RLEumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 17:27:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15506

On 08.04.24 14:44, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows downstream layers to overwrite the SOURCE_DATE_EPOCH with
> there own implementation.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Was there an reason for the 'Immediate variable expansion' `:=`?
> In the shell the variable is expanded correctly.
> 
>  conf/layer.conf | 1 -
>  kas-cip.yml     | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 82b4084..6198e1b 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -25,4 +25,3 @@ LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>  
>  IMAGE_CLASSES += "squashfs verity swupdate"
>  
> -SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
> diff --git a/kas-cip.yml b/kas-cip.yml
> index d10161f..737cfa0 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -41,6 +41,8 @@ local_conf_header:
>      USERS += "root"
>      USER_root[password] = "root"
>      USER_root[flags] = "clear-text-password"
> +  source_epoch: |
> +    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
>  
>  env:
>    DISTRO_APT_PREMIRRORS: ""

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


