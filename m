Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45DCC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 11:29:00 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.74])
 by mx.groups.io with SMTP id smtpd.web11.44423.1744025337439845293
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 04:28:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qDFTe/Pp;
 spf=pass (domain: siemens.com, ip: 40.107.249.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlkxC0KjccYS3TBocLRZRRacntaWzNOqUrBsOxiAJucoNJ6hK7+nviQQugJiv3Zxkce+/+A2tCMHWgDLUzChDR/fiQ/wGwV4qXflwp+AqKsA4WBIfOtW+w2wGbpPTY8Vdl5LFbbIRulQbBy6VKglJhbzLVnXNojp57HvDRRSHodJz+zXoGIutQPvR/ksB9rt/6mxN73mgbJFJ3jsizs6POpC2Dw1HsQbhDgTKGwMEUpoTKlElpeEZYggrfW/n74BgECVtZZP9hLFROfVZwwQz8S36RRpxhKT6jDbmg1BkH9mh+JzhHApWFfzu2eAPDYuz3ULE2L2J0DCuI74a5OGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbRNGcrv5yaMTQwFGyA/tX/3BSGqIE7rIhBBZIwTiB4=;
 b=TTCBf7xoTKh06YV5ei851MN9QoNqoiVE3ok9e7j+IH3iFs78iS/zZr720WTLW6DQn8UzWh1WHU62NDJy8q1gUwxBTZCT519tqL40q8FYBnKaWndUt0frq6rzB9CO+Y3mg46GGRxG2IXGzxan3fF+wiT6wQKNM+zz66RzJ+SqjT0WHwjDVKXRX6++xjv7/bR5G4xyEzJ6vEhZ+39aM2SoLozNDMNxhP3OuUkGMlk+tPdM3r/+mw0UzpedZwqE135922Dl1w9x3VoisBYU5k5/AAWjc2JaHVIkEMKBoNSoUGjdz2l9A4mX4JISYXoCn+3UgvHvgipPPNVa2L2pMENmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbRNGcrv5yaMTQwFGyA/tX/3BSGqIE7rIhBBZIwTiB4=;
 b=qDFTe/Pp22o17CNfoLiDutRHXMw5HmrB/uF9PKBC3nlu+elgsWIxjwdXhpUz0HUkQPTWJpAq7DGfUGq1W/tipbmNmoU3ybSSaYtZ0GOgE2ytOPcv9wrbnU/lAHDPq8oDHkrBXVyGVVCacVwfnxeXIrmmpCdeTQGPRbujsG5sLNY3rSWKxBQtxkNSiZGjVkWttGxum+65HByMsx4lUBa5WnU9Hr2suhmjfUXdZ+lzqxUGDes6CvdAtAzAIaSPtBk6Et9t/U3zUx5eF5NQWgON9U7kTlXEpB30auQ5l8mvNa3c1g5GHLf8aGBCSigdJ107hW7lwhSnNbi/fOkfr/XlDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 11:28:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:28:54 +0000
Message-ID: <91056512-749b-462b-89a8-b42d7a97c752@siemens.com>
Date: Mon, 7 Apr 2025 13:28:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] swupdate: add vardep on SWU_HW_COMPAT
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250404080122.855379-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250404080122.855379-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9b934f-9016-48ef-2f9b-08dd75c760fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dlBWMGx1OEpvVkFZcEI2dmN0cU5CMUM0ZkZJczh3ZkV0UmdrTnJWNTVzbWY3?=
 =?utf-8?B?RjBxdlhmazRMaVROZGVRZVNMQlIzcWtSVVZGb1dTS0Z2TVUxRzQyYTdGQjBB?=
 =?utf-8?B?YTNUKzVQaFd6SE43eHQ0MFVkdkdzcGxrUlhpU3diMDNhaGVyMG9WVzR2U09H?=
 =?utf-8?B?aS9sUitHaG80V3JYaFU2dzRrWVhhLzZvc3VYNEJhMlFzZGdCRmNJU205STRh?=
 =?utf-8?B?YVdSSm04amMxWlg2RGZMV2tSeUt4WFlxZElQYjJ5TTFLU1I0MXpjUnpFYmxR?=
 =?utf-8?B?QVRNN3Y4dEYwNVBtUjlLdW1sVVNBOVNiT2dLbnQwb3lCdkxaQXI4SU9VU2Ju?=
 =?utf-8?B?Y1ZvWTlmR3hLNVR2dFdwcUlyVnd6RWY5VXd0Mm9URnk2UEZPL2JZdWhLMmNx?=
 =?utf-8?B?UTFJUm9oRWJDdnlxclA4MFZ6K2psU2JlZ29GMk1xcnFXWGk0N3kzUFREazFm?=
 =?utf-8?B?M054T1I3dHpkOFhqUUlueEtRZmtQOTVYNWF0cU51OFRSWXA2OWk5UVh1dFd3?=
 =?utf-8?B?elVhbjRmL3VLYVczUXdObFNlMFIweFFjb0VPcHVpTzJPbW9OSENvd1RvdnRP?=
 =?utf-8?B?U2VZTUVtZUxhcHFIN0k1YW1OUDl2a3pZOU1XaGNmRFc3VXZDeWw2YkNMNWxP?=
 =?utf-8?B?d29SdG5NRVdKQmMrL0NuSWg1ajNCYVMzMk5lYnJ6V21EMGIvRTVnaVFBeXk2?=
 =?utf-8?B?TVNSb1NhazNQL3orZzJKaXVBTmxGWU1ZSHhXMmhsWW1SUUtuMTVSUjhFcW8y?=
 =?utf-8?B?UTlITnVnYnc3alBSSWxWZFErSnpHQTRQY0hHdEcrT1EzejJXTWs2ZUxmU3p4?=
 =?utf-8?B?NEJiQXdEOXF1MWVUdTBpbnE1TWRBOWdJWXV1QVRUbHBjeE0waG9GOEJpc2Jl?=
 =?utf-8?B?RldSL0JNUTJyN3JHQnhGU2ZiSEE5TVBiTFBlRjRjM2c1VmpFa08zcWU4SnRx?=
 =?utf-8?B?VTgvSGI0cC84dG9aWVpVQ0EzMGN5ZHVhMFpqN0xjTXg5bnNUUWkrNThlTVUw?=
 =?utf-8?B?N01PYXMvUUhiaVA2L2hiL25xUWY5UzNSeDlodTljL1I1VC8xaXFkTHVTN1p4?=
 =?utf-8?B?eFBpVldaMHNUUWNUL3diSENNN2I4QzEvY05wK3QwR0VDVnFld3JER0lsRURq?=
 =?utf-8?B?Ykp1MWdUWU5wcXc4MWR0dDl5TTdEYjR4RDBxcm5yQTNablllWjE1eDg5bnZX?=
 =?utf-8?B?TW5mNndkN1BYVGdueXRkV2xlNUFHaE1DNGVyMUFLbnpMWTVEcm9Ia3pTRWc3?=
 =?utf-8?B?Q1ZvQ1U2MnpieGtXVmRuRjVWNng0d25tQ2twTnlTR0VEV0x2VVA4c0pnajNw?=
 =?utf-8?B?c1lqV1hpd0JJTEd4K0JlZG4vOVBvWTZndkxwZFk5SG94ZFFHR2xCZ3RLakVU?=
 =?utf-8?B?aVBpMjZIUFNOZ0F3OSs4b2hEY2VWNFFhc2M0eEtkVldUWkx6UDRTT25oWWpD?=
 =?utf-8?B?blpiaVMra1NjUlloSXNsNFREeFA0UTdXazZDM0lJaXc2K3Y2UnQ4bHZnVE4r?=
 =?utf-8?B?VXBhWUk3dEE1VzhiS3VkdXNjYThOcWcvWTlXeHczeHQwNkdnV3VidUF3ZDRK?=
 =?utf-8?B?bU5jRmdXRmh2STgwSVlKNEFGNGZIMkxDUXRtQ0JDZ3lXQ0ZzclZkSjlZN21y?=
 =?utf-8?B?bmNVQkZDcE9LVmZZR3docGNMdkxYczNPRFdLajMwWUpaNmNsUm1ya2FvYWhQ?=
 =?utf-8?B?bjdJaEZFd1NEaHZJVEp0UmczaTVTM1Y2NVBVNExxMElZRk1oSEd3Z0xRYjgy?=
 =?utf-8?B?dmljSXZsNXdzVXY2cEtTdXlwTG1nMlBrL2Rjbm9GMm5sKysxVkxNTlhkOWdG?=
 =?utf-8?B?ekEwLzNNSzdSYmFIRUQra09BQlducG1sS2V2ZWVDSmQ4YzBjVzg0akpjaTAv?=
 =?utf-8?Q?GPyppBZygMvO1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RENMeld0OU5yVndrN0xQUUVQVmY1SlI1Yk5NUnpsdWgrQVB6MTVBbXJUdDlr?=
 =?utf-8?B?Qjk5dzN0NXlFTmtqM3UrdjgxWkZPd2VIemFlWkp6RUNsSGVFdnl5RFlEUHdR?=
 =?utf-8?B?enBZM3ZtYzU2N2s5cjBOeWxjVzZhOERHZFEvQjU4a3hmbDgrWXBiQm55Z3FM?=
 =?utf-8?B?bFFUUFpvQWRLQWJpdnhjTVFpU3Z1Wk1kVWpRTVVlWjhSaUlqdk5vTFkyWDJz?=
 =?utf-8?B?V0Q0Q3RMN3BMbjJxVnJFTXJ6VlYrYy9wZTB1cUxBLzhYUU5hQzV0RzIvbDJ4?=
 =?utf-8?B?TXdhVk4rU1kwMEV6em5UTkJKSStiQjllQnJISEtSWGJmRmVNR3hRVEhRVzZ2?=
 =?utf-8?B?M0U3ek9peDZXL1l3bS9acUZKVlVsMlA1WlpnR3picVNmSHVxNklrbjJWMTVn?=
 =?utf-8?B?OW1FUDlHcEFwbE5vVThkT3FNQ0Z0SklNQkVzVENBODNlWXZORWVGMHlmRGtV?=
 =?utf-8?B?enNzdUZNVTJReHFLc0VISkpkUy9NMDBpN3NIYTJQc3ZodHJtUGpBTk5hZG1X?=
 =?utf-8?B?amlLeHczRk1aUVhJMURxeGZCRXRmc3pPYUtaNFhDQ3NZR1F5MUIyalZqb096?=
 =?utf-8?B?NG9jL0xGNmxmZVVrdW42TzNxOGR3TkVtME0rejZSSEtsY3lxbGpVdFRZSzlT?=
 =?utf-8?B?VHlxbGZwUE9MZzZuclhFMXFBN2lNWllvVEcranZyMlA2QkJYd2dsRy9xQTI3?=
 =?utf-8?B?T2RHUmh4U3RwNnNLdnM0QnE0cWdMNWtjUjFXcDVwRlJsSVhKQmZjdmpZOG5G?=
 =?utf-8?B?QUx3dGpEZWxJMVFqaUZBUmJyVGpPeXdoVWVmdHBvWlRtWWxJVTlQT0VrYjZj?=
 =?utf-8?B?b3FTR1ZHbFNyOXNlY2xLbkNWN1pWZXdRalRrdENUUDVnd2dLamJWcjBsc3p0?=
 =?utf-8?B?YXZkYzNia2FPYUVTa3FCNENlbFpUTWplbFNBWHhnR2w0em5QQ3RVSHNrWGMy?=
 =?utf-8?B?VmFueG1ZM1YrWlRzZ2U0eXdWUm5rMDA4R2t5WWJyZEttVXhLOFhTOURUV0dM?=
 =?utf-8?B?QmJFZmJ0MmJ5UmdrS09lRlozeWNDeTVNRWJqTGFFRXo4eEkwdFdjbmJWR1Zv?=
 =?utf-8?B?UVROS2g2QUFMc2k1K3JFa2lNMVdzVHljQ0ovQmpQQkFGZmVOUFN2VUJINmJp?=
 =?utf-8?B?R21KVjF0M3NOOXQyQmRBOW1tMmkrRVpzNDFnNGJUQU1rVTh6aEpGTEFodjV4?=
 =?utf-8?B?RGlGcll2aFY5bE5JUXhKZjVueDJrdlpMS2VXOFZ3VE8zejY0eThOZzVtb1ZP?=
 =?utf-8?B?NDRsSzRRZ2ZUSFBtWWk1VUpaYUgvR2xxc0hQdThvQ3FHaExJTDgrdldGMlBS?=
 =?utf-8?B?QjJVRi9iY1ZlTWZoeWFiZVhZZjNQS3lkaEJJMm5SZEdOcmxpUDRaMm50WjVD?=
 =?utf-8?B?TnA4NEhTUC9oeE4rdmVYUENCR2o1U0lPNjlzQ2NZMW9ZdlVaTlJINVBXVTY0?=
 =?utf-8?B?dm94YzlISkY4aTF6Q0hYRVhtU1BXZ2tINDYwM2NLU2FVMW42dWhEOEtMNkRL?=
 =?utf-8?B?ZWxCTUMvdEJsdmF4YmZjOHNDNWNMd05tRndJTzZJNTB3aUh6bktkNzRJMGR4?=
 =?utf-8?B?ZEhCRDVpZlJrdko5ZG5GbzIvQjZTSWRRZDVwTWptOEJaNnA3SVNFYWJDRE5E?=
 =?utf-8?B?cG9CYjE1SnEwKzE0a1dURDF5OHRuQjRsYUN5Z2kxUktXYkpMVklGaU9GVklk?=
 =?utf-8?B?Q0JlMEZjSElxQjRsa2VuYUZJWkhCblFUMHgxNktPaDhmL1pZRzNUK2FBTkha?=
 =?utf-8?B?UElMeXpEczdYeDFseUFPb3E3UU9tMUNaMmRidXB1OXRKSmdSd0s2c3lHeTkx?=
 =?utf-8?B?TWgxOE0xZG9GT05NNnRpYzFkWlRweHVxaloyQzdxdTQ0TE1XOXFrNHNGWjEx?=
 =?utf-8?B?YTIvT3d3Q3J0N25HOWNDbEp1TVd2WC9sVVp2algzZEZOd3Y4ZlhIT2FSZjNT?=
 =?utf-8?B?VG5qRXd0VmJEcUdkTndlSmpFRFVZTVdtc0dIVnZYSnEzOHpTTEY5SWkwQk50?=
 =?utf-8?B?Y0dXVnNsb2ZhZTVZNHErZG1USmFaWld5aW1vQVUveDgzVWc1bUFTNWRXNzEv?=
 =?utf-8?B?akMzdUQyVHBLVUhNOXcwbVdtV3Uwd2hacHI0aXBVL0h6dEx4ZWlQb1NPK2Zo?=
 =?utf-8?B?YWUzYk9teVllTmk1b3RpRERVOVNrbHFwa0FzMURpUVU0K1RycXo0Rm1XMTk4?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9b934f-9016-48ef-2f9b-08dd75c760fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:28:54.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLT0QayQE5qFzP+6fRRcVg59ckJzubV42OzWWbd30VuIgXdIVpzR1gv8J8bCDS91QaQArP9HRTtjcsr3TFLBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7264
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 11:29:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18485

On 04.04.25 10:01, Felix Moessbauer wrote:
> The generation of the sw-description file depends on this variable, but
> as it is read in a python function, the dependency to its value cannot
> be detected by bitbake. We now explicitly add it to the vardeps of the
> prefunc, as the transitively called function cannot have vardeps.
> 
> Fixes: ad089e6 ("make name, version and hw-compat available via bb")
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/swupdate.bbclass | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 05291ee..61e4fe1 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -74,6 +74,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
>  addtask transform_template after do_generate_image_uuid
>  
> +do_extend_sw_description[vardeps] += "SWU_HW_COMPAT"
>  python do_extend_sw_description() {
>      cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
>      if cmds is None or not cmds.strip():

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

