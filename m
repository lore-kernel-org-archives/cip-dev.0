Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B99C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 12:48:09 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.82])
 by mx.groups.io with SMTP id smtpd.web11.9695.1740660481756822874
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 04:48:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VwnUNwmw;
 spf=pass (domain: siemens.com, ip: 40.107.21.82, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3YMZwngy+AYRwdRJfssEbKsmG/oAUwc8OIz9onxZCV5/tJdckdNqYg1+fNZXinf/KDJSWu8hlHM6BuIftfkUoG+3VvAwnNWOEHsyKfirqDUIY4DpS3/qbqLVkWPbUbbaJSWXVErbHeNRXEd/j/aaLBz8fZcCxLyta5+Sn3HEi7KKu8IvP3+MBg2BHBDHAOAQkRfTtwi4LdiGplLAqpgz9bjwsNd/Xk6xTDAXIivXUGxBL0UiKgX0++w3FJMh5RLuQpxUrye8bRZ0nbg/1SRFXYoVt1eJIEVBDDNha4c0l/PFKLsK1G/DMO0D2Fb07jpI9MrhxAc7HNM4J+jOfmJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0eyaK9MYduI1JrLgVmtFr+NfFgq+6qx6abBZ492KyU=;
 b=hKZC/9XlkvrLiAGj7yIAConnN3z1af29nbbcurfSkhv31xcE5xXz73qrzyqHvF327LGz/VA6xVPkHsenIJjSeUG1WjMpkWn7HUkS6k6Rl+BZdHNXV3Jxvq8s3wuJUlDqCbXIJdMUCUNksRhkK08wdjjiPfLfqytrXNtfhCiihMohQWNP75YEQxvJ+p1qtPhbHTuB+j8t6wIBleREAyYkx317Dn7DeO5jjcmNSazRUpOUMWfGlMSnPG/Wm5vjlwnVwY7T8Id2UdkQXvIB3OFHKJqLAxzgbMNLHEdTl2gMEAR2GuVNLPCSBaG+3tbiaDvrTo4LRT6UxmsmNBPofpaGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0eyaK9MYduI1JrLgVmtFr+NfFgq+6qx6abBZ492KyU=;
 b=VwnUNwmwc0FJk2ZZn+dKnnAxj4AU/2REyop+UjH98oVRMuQUObQVXfd8uckNVZZy0DFZE7ULh4TKHqrohdTfN28W1Emomue8IljrokCQ85YZxccm5AUFwgg6TKrBFtVQkMBgw10MduQVG8gruE6qBP7XrR1VA06hjpG582sFErWKK7BI8G8RK6lvjQF1EugDJWDQzmCREjlMhzK2fo9fRJsC2jqJvjszfiQ7klvkymUYAdx6FhM5GSNrpU89wshxj7Zg+oGpDmo0N2PCjHtXgZAY8JO4KAhektaQ8f8sSNg4UGPyzriD+AzprrXQNRTCgNhIeg+0DdTgJA4h/QJWtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB5410.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 12:47:58 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 12:47:58 +0000
Message-ID: <6a9c322c-cd7e-4cad-84b8-ecc91f2910d2@siemens.com>
Date: Thu, 27 Feb 2025 13:47:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] initramfs-crypt-hook: use real device path in
 luksFormat case
To: Jan Kiszka <jan.kiszka@siemens.com>, Claudius Heine <ch@denx.de>,
 cip-dev@lists.cip-project.org
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-4-ch@denx.de>
 <bbedfad1-fb7e-4664-a42d-c37f4f6b35be@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <bbedfad1-fb7e-4664-a42d-c37f4f6b35be@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb7fc5d-9a6c-4525-4cde-08dd572cf666
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cFdaN20wRjZFZi9DSDV4bTBIK053VEdiMHd4S2E1M0MrUzY1QjBiU0J5WjNI?=
 =?utf-8?B?R2dNWUpvUm0yQWhRSWFEQTRSaUJJNXUwd0tZUzhXbUFpaXFuVDFaWGFzRG9J?=
 =?utf-8?B?WGJDUjlydE9mWVFlak9Wc2RpRWg0Yk5BWENOdy9vcDA3Um5LaUYzT1I5eFdr?=
 =?utf-8?B?R2dLelU4K2p0dXNpSVRKNWxzMkJ6OVdFWFdsZnBpSUF6UlBzZjRVc05PNThJ?=
 =?utf-8?B?bjd6d05weWQ4cTlFYkJhdkE1SkFFZmZld0t0N29nL3d5cm1KWlVMUURJaC9m?=
 =?utf-8?B?VzB6QWFDTmQ1ZmpjQklxYlZkbmNpVWdhS1E5ckJ1VlplZktWS2Y4Tmk3Y2s2?=
 =?utf-8?B?NWJOTUNWWlMyRlBibzlXQVczQkhNWk43QVJqSDB1cGpqem1rQnVFUVpvdnor?=
 =?utf-8?B?QUZtZmJiWXI4eXRwWmNnOC81VzB2dEc3T09TcDIxa2dKS3BxS2tVaTl3KzNv?=
 =?utf-8?B?ekdYeGViOFFnM1FLckpxNm1sQytOcUs2YTFoMWMvZ0s1MC9yZ0RUOUpQaTYx?=
 =?utf-8?B?MzB1OVRIWWJ5Z3htTFhnVGp6OFZwQlQ2b3hmMzNrbTlUYUxFYmdCUkRoRDZn?=
 =?utf-8?B?NUhPRmNMbzIxRnU0NDYzRm42M2srRkszNzJ6V0JyTE1aWmZhVFEySWZCaHpj?=
 =?utf-8?B?VGVLRFVhZi9Zazgvb1VnUVBZQlBOcU8raGNHRE9PVW1nS1owOUtuemM1TnVK?=
 =?utf-8?B?SU9HaWp0bjhKR1o4RWoyVHNCZWlNcEtrT1orYU1uZHhOYTdHNUdOSnRTQXVQ?=
 =?utf-8?B?Mi9wd3hkeEU4ZGZoVU8vS3NrMzhub2hITEJrZHdMRmU3eXdGVGJ3RUdnUWVH?=
 =?utf-8?B?WlAzNmRnRDFXaU55UEZwYllpN0FzbkFXQ0graUF3N041bzM3UEpTcXBBRkx0?=
 =?utf-8?B?UEgxVTRZMVBUQ2tQNm5MV0xEbWVvdlFJWXJRdGhFQ09ITlRSL21vK0F3a1BQ?=
 =?utf-8?B?cDBwVTgxVC9WNzdSQ2dLTkE2ZFlpMzhFbm04cnk3UUE5T1FMQk5DMlJSUjQv?=
 =?utf-8?B?ZlY2a2E3OW1NYlhUTlR5UDJaWUZUUTlXZThkUk81RWdMdndqZytNQS9BV2JW?=
 =?utf-8?B?a1BBQWlUaStYWmFQcG91ZVh6QWxJeElPR0lhU21JODVaVGFlV1BadUFmVW1W?=
 =?utf-8?B?TVFpQmt2Rkh2SzZzOWxXanozNEwwTVk4Mi9heVo3YU83WXZJcitDQVV6Y2NF?=
 =?utf-8?B?SHlURzRKMThtQ0I3MWV6TEM3RTN5V1FKNHZzczRjSHdKMHF3b04rZnJhQTZy?=
 =?utf-8?B?WjNjVUMzbk1CVFNxUm82Q2tLOVpVcmRVaUNVNTgzR0VmWWZTTnNmMzlyRXZz?=
 =?utf-8?B?TXdWbURTRzlzZUMySE1HQnpuRWlha3BjY2JlVWU2dTZnUlR6OE1aUVpzRFRt?=
 =?utf-8?B?ZC9QMjRMcGhUZitLbWpNSTF4WmhpT2xJUTJtbXAzNmI5dk5qZm5NWitKQWlo?=
 =?utf-8?B?aG1RZ0xXQS91WXhEcHNhTDlNRWg0aDNuNG1FTmJTWXA2SXovMk1RVFdtWVlI?=
 =?utf-8?B?d3kvYWx2VmJUR21XQXNzZGRVaTJ1azZRVUtGVkg5RUlMb09ySGYyZm14Z2E1?=
 =?utf-8?B?bTlFOEM3bVRUYk9WQytPMlZNejgxZThEUGk1WFRHUzNEWkJUNllSQTB0dnNy?=
 =?utf-8?B?b0h1Mm9uR2NsOS9HdTg3ZjVRM1QyTFcrYXJWR2p5Q1VGbG9Yc2ROZnB3QTRH?=
 =?utf-8?B?b3puZUVhY0xSZEtqcDI1TVhGcFJxdWZ1d2NZaHpEb1JwQ0xqTDFjVUxpQUk1?=
 =?utf-8?B?ZHFCa095dG4xUnQ4VFNmdUtWekhuZ1BlOWQ2VXNmQWcra1dtVXY4T1BBYVdx?=
 =?utf-8?B?bXZpZTNTdTg0amdtZ0FzN0I1NGN5ZzN6a0RxbUJ1Um0xbThHdG5ybVdFTlVR?=
 =?utf-8?Q?cGvoaQtSazQK+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3JlTzQwQUpuQ2NLenh1SkJPOENrMEYrY1F4ZFRsOTFTc3VrS3UrN1E1R0R1?=
 =?utf-8?B?eGNwRlE4WWN3NnpZcktMMHVoVU5Nc1JsL25BTkk0eGt0d2J3L1VvWFg2cjZ4?=
 =?utf-8?B?STRwS0ZGc21Ta0xvWERsRWU3T3JmS0taSWhoN1l6aU5lamlqVjlxMG1sa2FK?=
 =?utf-8?B?QWVnWXZOOGlvVFpaVWgvOXAvbXZnSUpGa0JFQlpYTGtmTFNLWUNVMG5wUHAx?=
 =?utf-8?B?bHlUZW81eGFVUUsyRXljdUY0VWkwcU42WFcxc3hCVkNscDl3Uk5acGFmZEh2?=
 =?utf-8?B?VW9QeGFpeUFnUHlSMGxDKzNBaE9hMktHOWRiV3JXa2V2NGVoVTFCaHNqL3BN?=
 =?utf-8?B?SXVyUmRsRnYzNElNQXF5ZGVWOXEzQzY4dnJ1SzBHTUFuSSsybVE3dGcvZnky?=
 =?utf-8?B?YVFGTlpzUitqR3B0emRDMXpBMFFoeU5RYWY3TTcvSnZFcEl1SmZqbUtQRnlK?=
 =?utf-8?B?ZDc1WEZoc3F0d284UnNISCtwQU8ya0p2eTRPQU1mUVN3OW1UWGJUYTF4cW5W?=
 =?utf-8?B?VmZGVzhvMVNBZ2Z3Wm95RDlVSFkvVmxVLzgrTWY0bE1ZVS83NE56bWZ4S2lj?=
 =?utf-8?B?STR2dC9ncXR1ZXdDNlF2SGVvUVhuZXoxQjZ0c3hmcmUrbVhkM1ljYzJvbVB6?=
 =?utf-8?B?d09uQ3B4a1hDdkRuS21hRW1Hd05UZHVhS1dQbGpIRHhBUmR4NVhDYTJhcFFV?=
 =?utf-8?B?ZzVtbG44ckd3UjBlSW9NK01NMFZtM1VQR3JZVVVQQSt1TVd4TzN4WXNnejlS?=
 =?utf-8?B?Sm8yZVgxYVNCek5xaHdhZm1KMi9NWURZcEIxQ0RVYnJVdHIzOGp4OGZhM2do?=
 =?utf-8?B?K3FJaGZoeExHZjNRcEhxb29ZYzJ6OWM3WTBFTDE0WnJubVFkSkdaRGNueGdl?=
 =?utf-8?B?TzYvY0FIM1VheEFZQ0FSZ3lERU9WNnUyK0V4N1NsSjZBVFI3MmJzNDFsbGpY?=
 =?utf-8?B?KzdJS05URjNUQmZYNEdoVU94ZEovWUd6ZE16YXRycGkyS3UyVktvS2JHQy9m?=
 =?utf-8?B?ZXY0RmlGc254LytXeHVxMXR3ZjZ4TzByS3VWSm9yQXdnTVBmd3Y4U0VSdzB1?=
 =?utf-8?B?TzJJSlVGdzFiRUhycXBPSHF3Wk03N3FZa0QxSFRoOEFwbHAyakNzaVI2QXd2?=
 =?utf-8?B?NG1EaUNQbklWVngvRG9JTXJsSW5obWVvY2xPS25oNlJ2SVAvSlo3RDNlZjRY?=
 =?utf-8?B?TDJRZ1h1VTNSenVqVmRkZGxBcFIzZVN0TlBEdHordTZucGg1VE03TUV3OWZG?=
 =?utf-8?B?d2NYU0Q1bm9ISm1UK2VkeHZCRE5rM1dBWUt1amljcEEyeXVnU2pkTjhTaHhP?=
 =?utf-8?B?OG1sckhkRUZHVGNTeEVxdW1rSHBFN0dsSEtERmJCMnNhL0VJTzN0NlBKMGVZ?=
 =?utf-8?B?U3ZUTGlCRnZqb2hlalFONnNmUThXbjNUbXlCSmJvUmV5Rk0wUEpKQjhPMVc3?=
 =?utf-8?B?bDQ3V1daUGFzL1NxT3BhK2VGb1BWMW1mVHF0bmFrOE1VWk1SOVFab1FrQ1Rm?=
 =?utf-8?B?ZTNndXFOTmZIa3NqQUJmVi8wcG1jS01CdWFYdm9vWEhEaTI3REhEc21iMkhj?=
 =?utf-8?B?MTZBbG9GWDk4ZHFHV1RuS3hFYXJpaTY1dzJWOXQydmEyQ0pRSTNJQXpWNWpp?=
 =?utf-8?B?bmhFaElubXRhZFZnNzZRVGpTaWo5RW5lWi9tK3grNklhb2ZMT1ZKTy9Ndm5w?=
 =?utf-8?B?WUtYR0hjR2ZWVDlmdG9RU2h2RjdVSnJsK2ZpWnJ4a1BRS3FVQm1iMURwYmd5?=
 =?utf-8?B?eTlrS0lwRWhxVUI3MGdjMForTkdHTi9RdVZqVCtOZ3NweUloczg4RmdRMDNl?=
 =?utf-8?B?Umczdzk4TW14Umlycm0rSXd2aDBoMDNXeENGTlEwZXczYUpxZy9Nc3JmeGJa?=
 =?utf-8?B?Y2UzWlFIcStOcGhXK2tKZ3V2eVcxMy9Cbi8vY0dSMFMrL0R6YzhOalRGRkZR?=
 =?utf-8?B?Z2g4MlNsM3VRWTNzOGhkdG5tU3J2c2xYeldKT0RTbFNPck9zSk04NklGR0xE?=
 =?utf-8?B?Y2piallvb25wVjJpK1djVi93MENpMVRIMldYdTBHdjRwRTBudUpwYnZjWVJP?=
 =?utf-8?B?Z1RxcnhudWxwaS91a0ZZQk9kc2RBQkxoQS8rdWcxU3N3WG13WjRoMm1SQUs1?=
 =?utf-8?B?RHNqRlF1ZnNWTzFRU1lMZnhPR0xibjdUMFg5U01lTTdsQ2E0YTFTOHRjN1Yx?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb7fc5d-9a6c-4525-4cde-08dd572cf666
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:47:58.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EObDUbJnw67dPI9TDFmJF1mpeagbJ4jzCwT7u+tazvHNcIirN+6T/QC8vi5McMJe6JJGnLZG/CY+5BkcLALg/skG7ur1CNcaKXSiyf+PPOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5410
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 12:48:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17936



On 2/27/25 10:16, Jan Kiszka wrote:
> On 26.02.25 10:59, Claudius Heine wrote:
>> In the 'format' case the `$partition` variable is used instead of
>> `$part_device`, which is likely an error, because all other cases use
>> `$part_device`.
>>
>> `$part_device` is the real path to the block device, while `$partition`
>> is the 'name' of the partition in the `$PARITIONS` variable, as defined
>> in the recipe.
>>
>> This fixes an inconsistency, it shouldn't be a bug here, but could
>> result in bugs when this script is adapted in product layers, etc.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>>   recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index f1aa0d7..b907ea7 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -254,7 +254,7 @@ for partition_set in $partition_sets; do
>>   		"format")
>>   			log_begin_msg "Encryption of ${part_device}"
>>   			/usr/sbin/cryptsetup luksFormat --batch-mode \
>> -				 --type luks2 "$partition" < "$tmp_key"
>> +				 --type luks2 "$part_device" < "$tmp_key"
>>   			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>>   			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>>   			eval "${create_file_system_cmd} ${decrypted_part}"
> 
> This goes back to commit 98974a68ab9b, and there it is stated:
> 
> +       # clevis does not work with links in /dev/disk*
> +       part_device=$(readlink -f "$partition")
> 
> So this really looks like a pure consistency cleanup (but a valid one).
> Right, Quirin?
Yes.

Quirin
> 
> Jan
> 


