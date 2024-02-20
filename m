Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5EC48BC3
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 17:21:57 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.68])
 by mx.groups.io with SMTP id smtpd.web11.19063.1708449708514491431
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Feb 2024 09:21:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T4x4eQ4a;
 spf=pass (domain: siemens.com, ip: 40.107.241.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3Su5gaOuHNeLPv9pPhz1/9DQZ0P0BUrwRnCwPCAsWwyUfAjktQxlpKHHwISbJWqP5RGNyaVQYzvbLCdntyvCe/EXkc2SC4zQ/7CakHuNGxsieIrKr2Zw1EAynb/r2kJV0IxbGWb1LBpw7y90fjDGMX7Ups7Ha1peht0Rg6zgBOyjttOpaRqjy/U0DqMfbTc2i2D6FQT33EiLDo6LjpTrjmN2QKtdzcJBildCzRQNECFbPLeQPv+dRIUOSUBpt8FMGA2hX0qyT4DIpD/56R+/00hC8fpCL8hC8xCx50EeU1ma85bCBB5dVQXw+/Smnhq956UvqKoHV83GvTMT+S80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HdinwsVhUQnMyD/hCqGpTZXXrwy31lM7O4j9JMis5c=;
 b=OVT0HGjPjgt+rAoxVgrRCSDsOVCRddRbmkDWkXQyAuBbizJ7zTi3lxJ07MEIy9UsYzUhgzlt7JNWj2tj1b1w6UkdhCJBHUFPT4Fhs4ByNPqsyGc5e/VdUEnDPXZ1oBaI9xwuTcgCPPecq7P4vOXVhBMrBsKQO4LME9DI4WZKjXsMNA53F3Jy8Y39p2+y+gZbhGHRV78dqxKnlx40cF725fajt0So3XIOcZ2DrQMWF5aT+8+R/ShttP6EJke/IaKMbkaXpneQLkFF7NVH8FJ3K/rbOUOe4i33QIUGy6feqWUn7rMTi11sDzOhWwjKG+egeshCXGiqpZ1AjtOk2X65lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HdinwsVhUQnMyD/hCqGpTZXXrwy31lM7O4j9JMis5c=;
 b=T4x4eQ4aOn4mGvsRMbu4rbJl8V9O3Tq/FttmhSpKkES+gg1o9Dfzo7yFsJwelizbc8Sz/N+r31IWJayAw/tXh3ynVNVto/CMT+vK77n17TMDwUk4B5kY2y+dCT9OpiEZhSqdP2IBluXc0v8eX6jyGGMMei3N4Hpt/7xgmNr/D0N7S6DqukyG85CA/id6oRlbDg5LSQAkMwv/oPJkHod95u94uVaijsMvGr05rNbryTK5qZaCC1fwubmTSnWe0wTG6IMqvfADB0wEqxGboswmYOF237yL7dy8R72sXE8eJJKU9/mgqDgKCVpmgXOc8G+LwAw5Y9eLS5HsTWyQHa7cTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 17:21:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 17:21:44 +0000
Message-ID: <190d471d-12cb-496b-9527-70b069fe7cc3@siemens.com>
Date: Tue, 20 Feb 2024 18:21:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v4 1/3] update ISAR to latest next for
 dh-compat improvements
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, shivanand.kunijadar@toshiba-tsip.com
References: <20240219132850.68686-1-felix.moessbauer@siemens.com>
 <20240219132850.68686-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240219132850.68686-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3bcf23-ab0b-441e-9060-08dc32386967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kg06D7m4ag/Iyq11cN3sCD4IUxcpVrGK4wQih3DwMXB152RxzLizj+miqHNAVYfVgY5PwDsIW1dF0pj4dAscHto37XZVYYgYrf+I0OgrVsVjF7QUdcEbcxQF1z9DvzdyylY1Uvr3tAViSIAou8QxbAXpB47wRdx34wqrmvN5HG559Mrb8qQjYjqyuZIsN7zc/BJlAj50/Vq6VltSnRJ9kZAasuNQ2eibmxR9wKCiApXYR32gAqcGpuh/35890YWD6X0N47kSZitrd2YNzVtwSfUNBQGPe90EIuB7fcrfaStShqCnz78xqv0Y12UFjQvh4lUK4WplIgNT3AZ9lsjmzbekp/N6h2uBm5lVyU7M6IJKeAODnCuiT7XA4nVpU7GYPIc2b2EHhIuw8IznBrnNLt05kuemS1y9fSDaiiKdWk7uxzFFBJ3OPDLLXj8aLGzujEEZe31d5ojzgMEtvH5ZhNc2718K9zzglTDVUW058g1SNQnX22JEgOqRfC4Tb6vQwg2hrMCG7kpHKbjaPw5/Aw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUlBQlFZcENhZFVFbHZxWTlaMnVEMjI0SzBtQ3RXeGhrRUx2UG1UVnQwWldN?=
 =?utf-8?B?T1lqdm9tdTNUdStlMURsV1JHVUZFbG5yVkR2Yms3SVgva0dKdVhSV2NBSzdI?=
 =?utf-8?B?RUVBajkwaTNlclZZYTNPcHd1WGpLOFpmZzBhc0dWQXFSVi9hUU1JOC9YNUdo?=
 =?utf-8?B?UzI1Y3FsY0txZzhFQVlYemIvd3JvTk8zOWtyY3psNndxK0lCQ000aHVhbmlU?=
 =?utf-8?B?OEt4VzlIS2JEYisvUDdZK3NqTFV1NzBSQXIwMzlHZTZ6NEhnTDRuaDRHQnZy?=
 =?utf-8?B?ckJsR1ArbWFPVXBCbWd6RGVCV3JIbjFsS2szWHdwYW03RnBZSkxLajFhTC8r?=
 =?utf-8?B?eCtzYVRJbmxYSEEvR2VqUC9OeW0xWXVPclhCZHA1Z2ZjeHpmQ2F3dUJvRnZ4?=
 =?utf-8?B?UW5Lc296enpHSWRTbVJmZ1MxbG52OTlkMHRnNVg1MkJ2T0p5QTFWNUZBck53?=
 =?utf-8?B?Y0hIc1RpMFpqTEFPSGlSOVhiRDJJcW02eHA0cGlRNm5GSDZNQTE4RUU0N296?=
 =?utf-8?B?QXRvZ0lpOU5kK3gxeEdBM0FHZlhpYVBucDZBNURCR1V1THdDVFNLRDNkWUhw?=
 =?utf-8?B?OGw5U0ZFM3E2cFVuQ0R0NjNjdmdaQUVXZS9kcFZEOGFPZS9YbnI0SnZtZlhE?=
 =?utf-8?B?ODBvK0ZIOWVOV0RyVkxTZ084M1JJaHQ3VVNnMWJUQldSNUxRMmErWlpwY1A3?=
 =?utf-8?B?dUVxZWVnOEJwVTVhb01PZDFMb2EzNVJBb1BUUnFJTGl4bEVPenV2ZEZQYlJm?=
 =?utf-8?B?NnNFOEJodFFvczIxZEVrWTRkN0VmRkJZTkdCUGRZTW43Mjhyc2IxUXNSRGYw?=
 =?utf-8?B?RU8zSzRmaGJ2aWNnZkpIenV5aXNlUkExRXJkYUExaEd6QlR0VE8yVDc3UWMy?=
 =?utf-8?B?dHphTG5KM1pnemkwbEJZUkYxTjdDc2NOU3Njc3RtUmtmc1d0UlZOS0FyWFhr?=
 =?utf-8?B?N3Qzc2ZaV0F5SDBDeUkrcnVXaE1ONm5Eb201TVhnNjgwNVJ6dHVaS2FwSGkr?=
 =?utf-8?B?cUFIdVZmRmt5d1ovT3hVa0hKbU9MajFNc3lzekdMVFdEMlVkaHB5OHNkaHZj?=
 =?utf-8?B?SEl4WW9tdHhxRVAyRE43SUJvdEpsOFdzb3hSZndLSUFIcUdJKy9wUTNXNWRa?=
 =?utf-8?B?QWdYNXkwVDc5RkVJVU9aY3QwOU40RnZKVnFzVFAxb1lCeDdFZW90ZFpoMVcz?=
 =?utf-8?B?M29HM0VFQks4M3ppMFZiY08wNUlqUTNPL2ZEZldDOXFQS1lzTzVEMzczRFpL?=
 =?utf-8?B?bCtJaUNic2Y1M1RCaERIMk5UOFBIY2w0NGZvU0JvSnZKZVlIVEJkUnc4aFpB?=
 =?utf-8?B?eFlyOWZ0aGcxT3BlUTJKYnFIakNIMUFUWUZmeGxlWTZQNWQ3Z0RaclZPbzVs?=
 =?utf-8?B?UDN3c2FhWmxmdE0vcTBaeG1Ld084VkJjM1pISW0waWtuS1NtYmVOcFFqc3pr?=
 =?utf-8?B?R2tCQmFaem51VEpTVWlDNEJMVlFTbCsxTTRwMXY5eGEzQnlnYkFlQnJFdGdt?=
 =?utf-8?B?RkdlQkZCREhaOUhGdHE0a0RuZmNkMFVDWW5TdmZKd0hCN3V6R3o4ajFxenNL?=
 =?utf-8?B?ZWZSNlJMZmxLVWR5NWJjZ3BNd3R5YjFDUzRWUWlUbWZ3Slo4K0wyNFlxYnBy?=
 =?utf-8?B?NThmdW5PeklPSi9hd2J1Z25Vd3R0Z202SytkYjBGRE0vZWRVZjEyNzhWOUpE?=
 =?utf-8?B?UUROelJkM2pTUW1ydjBocFQ5b0xMSENtd0czYjIxTHJTUmg2UTlDaEJkYlkz?=
 =?utf-8?B?VEJnckhudkQ0UENHckppUDJoVy9pMStIRkQ4RzVncjhHVU5ScXNOWTBEdmUx?=
 =?utf-8?B?OXJCNFZTdUo1OXFxVUhNTFZjME5UWnFmQTVQZXF1VU4yN1N5RUdLaUdZTEZa?=
 =?utf-8?B?Y2tkQVlSckNPMk5FT1VScmZHTnE1QWJMak9hTExjTjVmNWZ1amlPN1d1alQ2?=
 =?utf-8?B?Q2ZCb3FHdExaaFJsaExUVlB5TUlTWCtYNEhqSXMyY3pqdGlubnFyV0NuNkFZ?=
 =?utf-8?B?VUZMWmI5cFEvQ0N6UFZPd2xqN2wwN0R0aXhkSWY3UjEwSjl6cmhKU1FKQkhK?=
 =?utf-8?B?RzBhbCtRZjhmZG8yYVVQSUxmN3dEUkQ1VWIycysxcHZGTW1vN3JhZ0dqYVgy?=
 =?utf-8?B?MHYrcVBUTTgvQmF6UVFGcTFFcGI5VXlxMGJrelROT3dUN2JGYk5RODhiM2ZY?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3bcf23-ab0b-441e-9060-08dc32386967
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:21:44.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5lroEC+LGvSYc36bsIMgRKcipK4aFkX7b5YNlOcONxG0RwpzknhcxyUkR15TSVv+5cAB8eIx1fwtvkyzlj+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7319
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Feb 2024 17:21:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15042

On 19.02.24 14:28, Felix Moessbauer wrote:
> This patch updates ISAR to the latest version on next which includes
> enhanced support for debhelper-compat. While doing so, we switch from
> ISAR/master to next and also add this branch to the kas file for easier
> tracking.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas-cip.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index b255c97..6130ac2 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,8 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 30471bb3f787fb0aa822d15e141ecce2f3b99860
> +    branch: next

Thanks, all three patches applied, but I dropped this branch reference
as I don't see a value for how isar-cip-core is used and updated (just
one dependency here, no lockfile usage at this level in sight).

Jan

> +    commit: 07573d7a6030b8b381518387867b6406b1441f09
>      layers:
>        meta:
>  

-- 
Siemens AG, Technology
Linux Expert Center


