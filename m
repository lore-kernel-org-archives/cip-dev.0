Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D860C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 08:26:59 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.86])
 by mx.groups.io with SMTP id smtpd.web10.6568.1737620818301043483
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 00:26:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jeMhOnOH;
 spf=pass (domain: siemens.com, ip: 40.107.249.86, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa6dQBXhzVPAazySj8moVMOiYCDUMrLcjwKQcYn+hc9lzYjZjTMEzkVkotdbDqvYcde8y+OP8ssyZ85uQSKoxNlMHgjW5LPY9X/lb0/I4PMTblBVXGJ+NPbFLSztseV+GaRZZ0Na2ltRWwTi5dPTcs1COAQj8NZyYaJspGAgaEP+9M9sYBoYIPNFAkt+OWk3CcU2bYyNWhOr8bDeZPvFjH93Wa6sp7NA43qJ//lbIWxcC909yPw4gm6Y6hqVC/5UxHzFJ2O7qnsEmxWyt3RUnSFtoepe5hhhRuCO4tWmQpRoKZ9bGEvXoqX6nw0RfB8b/KA0dHWQxz7nBt+VijjCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2jvlxZxyVix+0iq/gS1hKBqQwIMY2qBW0vioIk6Y3s=;
 b=dwEQL9HnZNORBGr9ssCavKNtiy2CqHomthFMQlukChmT4hVWYq5ewr/wFgeqpNQcN40YihI0zevW5Nqfy7j2xiBewyFDSRMGImTilrteBr+HGGFkUjPr1dlliBJQpWKi3DF4C6YyL45roUT1Of637NMeEOl67W7ApxJdpXvdZXo8oL7oRWkVRI802gmJFovQuijzPhxpy53y/d7zyXeb55ywN8hsfSUcjG1LSjQxnDnolMX8nmWB19l+bMHpExwaWNdMle1lAPL7XcKfUytdEgvsuemLjT7GVuFx7m09hA9CCyZtPy7yylnenDIG5JQyIdniE9mWWDSXBNrwOPyc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2jvlxZxyVix+0iq/gS1hKBqQwIMY2qBW0vioIk6Y3s=;
 b=jeMhOnOHM9slDuNz7k3ZFISYhOUuYObgV+l3uslVCs4UWxz6SL5NdiDoZdCtN7mEd9OmQ8XxxoxWv6cKHWNWTn/rXnZE7cIawy/VZ94NAyrC3uDQvPK9N+aPWxOSlwYIkaM67UF9oQOM9y1p7FnkMIHI+s83ra315unspldtNuDSl9tUvZDq9RXCoPELys9vsgYleeMqr3tfvpRIA+VmKUh8MWj/S68AUlWT92F4OGWMBD9iumEsAwisddmpckfxwMTF9JRROcwWEw2zJrZwzcjqk0A4BXSpUPXXLi8AFukrTiZMisdsgnuw1fE5yXxNeOUS8f+22ukjyMWYITO4Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by DB9PR10MB6619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Thu, 23 Jan
 2025 08:26:54 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 08:26:54 +0000
Message-ID: <305c5d01-8f9d-4bb3-b23e-330c6322eebd@siemens.com>
Date: Thu, 23 Jan 2025 09:26:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize
 disk encryption in combination with expansion of last partition
To: cip-dev@lists.cip-project.org
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <20250120123425.79292-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:672::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8173:EE_|DB9PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b86d86-cdf8-49c6-5bf8-08dd3b87b1b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bm4xcXR2YTRHbnYvUmVDVHJTV1N0ZVJ4Uy8xeUtjUUpuUTR0N0pUZHNKaXpQ?=
 =?utf-8?B?SlFLdjN0eHVXeDhpVmZoL3YxeXFOQWxPbkVsM1hLUXh0ckI4ZG14OE1xS0VW?=
 =?utf-8?B?aTBZOE1sYVN6VnJVR1F3NlBiR0NNS1hRQUpuZm1WUVBTTGlUOThlK1ZSUWVt?=
 =?utf-8?B?NlJuQUtzamlINXNkdUowbUR1L2J3bVJXMlVoR1B2UVpIejlJOUJLTElEaGIy?=
 =?utf-8?B?YnV6V0dwWjVnei90dFdRTTZZQU1YNGp2ZWdFRUsvUXozSzd6OXZzZSszTUpI?=
 =?utf-8?B?RFZlMDJXZnl2ZVFiM01SOWxHVU5vaVg3cFJlekVpdit1bGQvcmFlWTY2aE93?=
 =?utf-8?B?QUdNbXl2OEJzb0hJc3JIS0FRb0h0MzYzMlYwUEZkUGM0WUJnbU9EVEhwc3pO?=
 =?utf-8?B?QUFtWGp6UjY3aDVEcWV1cmtXK2c0OGtUeDBUSERoMzA1YzZ1WWcrclVIYW9q?=
 =?utf-8?B?WW9FN3IxZm8rdngvalJNY2JuOXo1RzdRR01QazcxMXpSajVGOS9VZHQ5cjNE?=
 =?utf-8?B?Znl5YnV6aWtCSkc1dlR2Z1U0NDM5bVdJSDg2LzQ2cEt0K3JxYmJXYnErUWFv?=
 =?utf-8?B?aTMrdGpxM3d6Vko4Q01oQXF5Y085Q2JzOWhPSDJIODUzSnZpM2M4U2NuRFFV?=
 =?utf-8?B?bVBEb0V6eFhvRkJBMllQdjM3TloyY3RBSGNVSHFjV211Tjk3SkVjam1MUWtv?=
 =?utf-8?B?S1RnZStFdUFaVnNSYjlGOEVYcFM2c3hMYlNKanlTUVVQeHphaGk0c1JOL1pl?=
 =?utf-8?B?Unl6c2Q3Z2dxZTg0VEY4MzhzK0ZWcnM0aUZzU3k4d1dNSnVTaDVQeXJYRTlN?=
 =?utf-8?B?dUZ0RGNHeHhYa1l0ZURhUlJqNmUwcDBCSlhha2ZwVjd4cVF2RStuMlNKZ3VF?=
 =?utf-8?B?UXlLeldDbExsc3dkY0RUWTJ2RkNIZk5COFdWK0NFb2xOU0pLZS9mbEpsQjVZ?=
 =?utf-8?B?Q01sb2EybGJBai9DSUxnYmZYNDJ2RysxdmF0T3JJL3lRUUdPc1lZVXdKckx3?=
 =?utf-8?B?OFRNRHl4SmpzaHFsYTRhR2VyTmQ0ZXdOT0w0SWZRYzZGSHV0akNHWUtpdzJs?=
 =?utf-8?B?QzRQa3pXUVJ1VzZjK2lzTHNaWHdWeGhEcmlDRStVYzI1Y0V4VmxqZXQyaWZQ?=
 =?utf-8?B?a3ZwZGZMS2QvOGxZN2pjaU9mdnI3NkZkNERXdHBZcXhubnVCN2NmQktPeHhD?=
 =?utf-8?B?c1VGRHI5ZTF0L2Y1SFJDZXVGaWoyTHdVM0w5Z3lUVkRPaDRIOG8vMkVjQUY2?=
 =?utf-8?B?YkJ1Tk5WVUlVZGhBbFNGOFZ5TGhTSVpPZ1FpdW5LS3VER3R5aDVkVDJjY1Vh?=
 =?utf-8?B?TU1IblJoajU5ZlNLcldyZGc2c0xDVVo0akhhQXNwcXdQbElWWFVJaEZEdVp6?=
 =?utf-8?B?VlhaTktqeXpaY3M4MldPYTR3SjgxSlN3Um5tbitnYWdqZFRydWQ3UjJONG4r?=
 =?utf-8?B?OWR4OEUwM2RLYXFCcDJGYmtzNlU0U0FrVTRRa2poOXB0YWppK09wU21lai9m?=
 =?utf-8?B?cTB0d1luSW9CZDRUaUZyak9KQjU0bHl4dWVxZjFDbVk3TVI5blBiRG9TbTBl?=
 =?utf-8?B?S0wvSlplN0pxQ2V3M29OWEgxenpXZTlBb21GUEVzczNVb0tJZE52WmlsVVhI?=
 =?utf-8?B?RWo1NzQ4VTgrWk9BRWhUVjhSYnZmWEp4YWJKUTUyUnhPcmFkZFdLNFFmN3lr?=
 =?utf-8?B?ak1ySWRZYk5wZ3ZxQU9jSklsZVZRQ2NVa2paQXZsRHNFZllURHRaYXJieGIy?=
 =?utf-8?B?bEdERzYrM2tpdkcwYmVYcFdxSUF4WC9MQkZoK3QvcWRkRDUyY0R3Q2ZLOFgw?=
 =?utf-8?B?VjFtalJ3U2haam1SeFpsQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enJZWHJxV29USzcxUm9oMStIOEIzcG5SOG5QaTB4aStWQklxbGZobUdDeFBj?=
 =?utf-8?B?d0g3RllvR0RjMWIxSVlnY3BhLzhTSGRtQzBURWQ4SUl1clJ5b3JTcmRSTDNG?=
 =?utf-8?B?aTdOc0ljRmxGN3VjVzI2SjFvUkdIZXp4aW9MU2swa0N3MGVnNDQ3Sm5lcGNC?=
 =?utf-8?B?L1N3QVNXR1I1dm1QekNRUDJqdFZjY3M3YnBrSlBvMU55R01ia2FoMDNjdXR3?=
 =?utf-8?B?QmJjMFZ0SmZWcHJ1b1lnWWk3eDlvNnM3RU10YW1OZkpxYzhTMWhlaW0rblR3?=
 =?utf-8?B?UnRUaFEweURvN284a2I2SVpvalRmMWlvYW1MTSt4T0ZUUWcyWG5YWWFZS09u?=
 =?utf-8?B?blIwOVJUUEdHL2k1SFJyMFBRUkJGcDNidmFNSFJhSVp0Y2tKc1cxeEh6OUtI?=
 =?utf-8?B?WnJrWFI5UG5xVmdqcVpza2dDU0tuRDIvbmxZWTMxM3dwbU5YTEtPdllEemMr?=
 =?utf-8?B?eHp3cjJjbVVENmp3K3M0aUJvQjcwbjJlWEIwQUltTHJ0cW5KRXJETE83NEh6?=
 =?utf-8?B?ZmRiN0N3NHJUdlVoZmFWU2QvQ2VnMGkzU3N1L01adjBmL0dlRlltS3B1MExt?=
 =?utf-8?B?aTRadEVtTUltSXg0WW5KN1lkM0RPUkNJQmFrZDBVbTV1bEVYd2Iybm53RjNK?=
 =?utf-8?B?QldpZHlWRExDYXhFaXkyMmJENm5oN0Rtb3lTaUVUV2p3K2RzZUxINDJuRjBF?=
 =?utf-8?B?QWZ6d2pqU0s5UDY3OG8xTnFDZlAxRmJQV1UxV2wvL0pvbTBuVXJGYUZBRU5o?=
 =?utf-8?B?SXpoYXFVeWNJeFBrckZOMzRobFdoMllZRFNxSjFqR3lxZ2JUdUVhT2ltQk1I?=
 =?utf-8?B?aXRnZXlkRW82UWRGUkE5ZGtFeFdHRms3anBQS1lRTGppamRqbGxId1hHQ3B5?=
 =?utf-8?B?dzN2SnZDcDBCUmdwZTFnTmpvM3dXSTZCUlhqV2ZKbkM5aU5VRlVVOXhJVlIw?=
 =?utf-8?B?dDRsWWYzR0thZE1xUTFwTk5UTG8xTTNLcGxVOHJEbGdXanBKcEhYd3BROHZv?=
 =?utf-8?B?d0FJM3NBQmlTL0dCanJGT1F6QVVBNkpCTEIwd0ptUzIzSXBhUDkwOENjSGNR?=
 =?utf-8?B?dnN1dmE5ZS9WNWZ0cVMvNjlBbzJHMnJBNFA4bEFId2RIWGg4bmlUZjIzcWdu?=
 =?utf-8?B?M1l0S0ZlNzduYTY1eEpPMFBtNVBXUWNVNzJyVEk0cnhpQ2dKcGw0aWVjTEZX?=
 =?utf-8?B?bm9KbTJPdUFYbm9wNlIyN1FXc2p1L1dWQS9RekVxdWh5MkRZMWxMSFNvMDZ0?=
 =?utf-8?B?VW85eDEyTWFMbysrdVIrajI4aS9wdkgvRGdWY2VpT0pXL20yQm41QVY4NlV4?=
 =?utf-8?B?VlpGb2VTbnhDTWpNaThLSjN1eDl1T2h4MHJDY084djNIUVRjaTJnQ1l5QzNt?=
 =?utf-8?B?TEpJUFdLK3I3UXluMFRMRFdCcUJMS0hsWGxEUUZobjRpYlF6S3o1Yy9GYXNt?=
 =?utf-8?B?N2o5c3ZoNi9vOW9GWVdJZm1pRkpWbXdOcFhZVENuSUZLUmFjMVdWV0Roc3U5?=
 =?utf-8?B?aDhDRWJ3V1IzdnRodGpqNndsTkNEZUxoM3pscUtES1RzQmE0TFNFTTR4eXg4?=
 =?utf-8?B?Q250NElkNTlGb1ZCVUNUZU1VSEZMbkJMVjNMT2YreUszbm13MFlUYWtVdDlR?=
 =?utf-8?B?aFVmbXhiU3VORC9WcVNTblVFTHErcTB2SkZLazFtYTZ6Qlc0a3luM0pRZElT?=
 =?utf-8?B?SWZ4Qy9tblhpbnV1V2c4YURtV2o0ZVFkdkxNbExuWU1kS2tuL292ZG1RNkdn?=
 =?utf-8?B?MmoyVHo0VmxVbzNpQW5CZGYrTE9hMXBlL1Q5ODBVeE92Yk9FWjRSVFloQ1Ry?=
 =?utf-8?B?THdVQTRLRjNSQWtJS3Bzc1l4NHpmdWdUd21HOFJvU0xQNXRCZXpEN0l6TVE3?=
 =?utf-8?B?b2JSdDAyRk8yMFNvQ0pZWU5vR3ZkOWtLQjZCdWN3VzBtQkN6eDJLZE9Fd2hD?=
 =?utf-8?B?NFhrNU9odmNScGFPQkhQYnVFcUJCcFIzaTlUR0tnY3EvZHlhZStxYjFSK0Nn?=
 =?utf-8?B?WG55ME5TVjZjUm5BTkt4L0s1Q3IwK0JtWWd2ZXE5ZFF1aGVBRmpSaDZwdXpC?=
 =?utf-8?B?U1FIZWQzUkJhQ2ZOTm1NUHQzNUF4VnhMLzRmbnUrM0pJVlJsamVJSXdQamZa?=
 =?utf-8?B?Y3ZQZEc3MjlQcmp3alhQVndERDlybGh6clhTbWc5cjVwKytsQ0tVU1dMWnZO?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b86d86-cdf8-49c6-5bf8-08dd3b87b1b1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:26:54.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgE5x5NFY+gDozsGOXU0l7CqBPpWvsql9syCHmnQCk6Tvfv6pSoxptOLe/ZAkAr0jYcmuH8iFuyk0FLgvmbFqH1BrWLJktwOteffFcPXI7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6619
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 08:26:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17606



On 20.01.25 13:34, Heinisch, Alexander via lists.cip-project.org wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> In the current implementation (since: 284175c3) disk expansion logic
> is done before the actual disk encryption.
> 
> This results in reencrypting the full expanded size of the disk, instead
> of only reencrypting the sections containing the actual data. This results
> in a drastic increase of time (approx 20x on our systems ) needed for reencryption!
> 
> Since relevant disk contents are only available in the sections of the disk
> available before the expansion, it is sufficient to reencrypt them only.
> 
> This patch changes order of encryption and disk expansion resulting in
> faster encryption (since only the necessary parts are encrypted).
> The resize operation does not reencrypt the added disk parts but just
> extends the LUKS container (cryptsetup resize) to reflect the maximum
> available disk space.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>   .../files/local-top-complete                  | 37 +++++++++++++++++--
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 8adc4e5..c4135c3 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -153,6 +153,35 @@ expand_partition() {
>   	# Inform the kernel about the partitioning change
>   	partx -u "${last_part}"
>   
> +	last_part_device_name=${last_part#\/dev/}
> +
> +	mount_point=$(mktemp -d -p "" "$(basename "$0").XXXXXXXXXX")
> +
> +	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
> +	cryptsetup resize "$mapping_name"

I tried out your patch and cryptsetup is here asking for a passphrase. 
As the passphrase is stored in tmp_key, I think we need to hand it over via:
cryptsetup resize --key-file="$tmp_key" "$mapping_name"

> +	mount /dev/mapper/"$mapping_name" "${mount_point}"
> +	fs_type=$(findmnt -fno FSTYPE "${mount_point}" )
> +	last_part=/dev/mapper/"$mapping_name"
> +
> +	case ${fs_type} in
> +	ext*)
> +
> +		# Do not fail resize2fs if no mtab entry is found, e.g.,
> +		# when using systemd mount units.
> +		export EXT2FS_NO_MTAB_OK=1
> +		resize2fs "${last_part}"
> +		;;
> +	btrfs)
> +		btrfs filesystem resize max "${mount_point}"
> +		;;
> +	*)
> +		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"
> +		;;
> +	esac
> +
> +	umount "${mount_point}"
> +	rmdir "${mount_point}"
> +
>   	log_end_msg
>   }
>   
> @@ -215,10 +244,6 @@ for partition_set in $partition_sets; do
>   		echo "ROOT=$decrypted_part" >/conf/param.conf
>   	fi
>   
> -	if [ "$partition_expand" = "expand" ]; then
> -		expand_partition $part_device
> -	fi
> -
>   	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>   			| grep -q "luks2"; then
>   		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> @@ -259,6 +284,10 @@ for partition_set in $partition_sets; do
>   	esac
>   
>   	finalize_tpm2_encryption "$part_device"
> +
> +	if [ "$partition_expand" = "expand" ]; then
> +		expand_partition $part_device
> +	fi
>   done
>   
>   if [ -n "$watchdog_pid" ]; then
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17548): https://lists.cip-project.org/g/cip-dev/message/17548
> Mute This Topic: https://lists.cip-project.org/mt/110713429/8340681
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13391150/8340681/947370571/xyzzy [clara.kowalsky@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


