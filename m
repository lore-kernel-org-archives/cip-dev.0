Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774BDC02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 15:47:14 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.24])
 by mx.groups.io with SMTP id smtpd.web10.39369.1737388032029603727
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 07:47:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=k0QbsioW;
 spf=pass (domain: siemens.com, ip: 40.107.162.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1cwcvdNl7FmvNFMydQW1wLnuwSbRKYrAliVbVV3+f5bgIuuHTy/B38/pOZ2hpwXyHAemhuExx1yMSDpPsEPBPkGKqk1M69WmuBxVH81Ac5rNivvGtgx/1YqfIDrvBMBK5B/hKkgq+wrdSvOqlF1QYIyYeBlrkV9B9Y57OxX0+BRyJ8UvzU9flHlqhFQ3kc6pMhIYmHjzHmiZVMl3iSYHaMjJdb+mgjvSqOFVQkuF13vHMNS5hDHf703VMefp6wgK5kmObEldCRI9u9Su9/AzOJNwV0pgwc7nYkQ0Cu4ZriqrxwpBP/19Mk7b4NR6Whid9fO8WyhAkZRugGPN2cD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dpGBeD5ISim21eKajIWmV9mfTQ6o4k8ITdkHvxOgfU=;
 b=hfRBN+WOho/E1tjnI/Nwl4XBiBIYbdSmvQLl41zFeg49x/MVHkgEPqgwal+CB/qglgjJqJ7x8bANv7cKPsTZ+fzDWHDd4K1rb3xABNVuIeGXGKWuFXDQgzNi6GoWBy+uNvrPF9wgzmEMEMn8R2lXkOHs4CHA+8Dxqsg6Wen57I0mS88lsbcuOjZ14hQpVbkihRzXKEGoopCPQGHLzvXZDyinhG4p399Bvbw1dQ3Ui63cM7nUznuhDNw4PDJZ1h9JGxW9xeuKPPiP8kjHH6RtRre3RSitSpGi0X6szM17PBnctYMBthS43SzLOLicWui0TlgW46WWNklD0YCCEK0A2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dpGBeD5ISim21eKajIWmV9mfTQ6o4k8ITdkHvxOgfU=;
 b=k0QbsioWKmNdQlMIxtYScXFxRI6K2f3Prcmxq/cL2gBWvs+huszH+WASKJ0pOuzTvy4d8FFbQIyi8AvcsAETx6lR4CyKQb+ijBk30L0PVdlq4NZo1hELzVUK2XHnQN7g6oxihpb21NytB1n1ab6AorsAwg41RCImbKFFH1opy+rD/TnsK99Nvl3j7tJc8bN0h9nlLqXgyz7LJ666tVuG9TVRuHduzcPesh5hvYmUar2GaxEbUf5+isAijJFqL5gdYFSZ4k8ScwW9fLebjY/6s9EWmIrB1Om9OqHPka7O8VpPirocCWPjY1JCv5r4ThtNDih5Zhri7BBLqcNNF4dCgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Mon, 20 Jan
 2025 15:47:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 15:47:07 +0000
Message-ID: <9321a0a0-ec04-48d3-a0c6-e70a65035c92@siemens.com>
Date: Mon, 20 Jan 2025 16:47:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250120123425.79292-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b008435-f06d-49c1-54f1-08dd3969b1d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0U3dmFUVWFvMCt0N0Q2SC9qTUc1M0h0eWpNdVp3UEx6YzlZUktqb1Y2N3Bx?=
 =?utf-8?B?YTNxcEZwdXhoaGVrZitUNkt3dWt5aHNNdWRhSE5XQXNLVUViNmNGNFc5d1BH?=
 =?utf-8?B?TlJaL0lNV2dzQk10UXh5RzNMYi8xblIrcFRtcDd6eXhwRDByam5lS1c1K0N6?=
 =?utf-8?B?YncyaDg1VmNqeS9sSGcvZlYzVFFrNnJaSmRsYTh0aEZBTTF1ZU9JbUthNFhW?=
 =?utf-8?B?YTFCZzhVa2xNT0QvMXppT2RzM0hKa1JjVnkvOVdhbGVNeGp6aFNFdkxvQlNU?=
 =?utf-8?B?SWpZaitDVkNRUWR5Ulg4UFBjTlJTaG5tTW9LWGx4WFdYZGdqRzFvMzFwNS9s?=
 =?utf-8?B?aWpYam5UeW03WFZoRGtLa3RPYjBBS3JvYjEyd3M2Q2owMmh4NHVjMkNMSElm?=
 =?utf-8?B?WE9adlpGVUpHM3JWKzUrK0pZTW5FcUkyeDA1NXFYa252bEIwUVBYSTFiUFAx?=
 =?utf-8?B?RVhqYWEvbjM1bUVJOE1mMXd6TWFkY1RFWFNoSHEvcFhJcGphTE11dk9WL3d0?=
 =?utf-8?B?UDcxOUVtM1FxbGRVTGxPeTZNRTJDdlExMUQrd1laeURabEtMc0NoRlNpNHdK?=
 =?utf-8?B?M2gvb3drNHNCTlNhWnlyUmxJK3VOMlRFbnJnZzlGMUlCdER3N2tFelYzKzZP?=
 =?utf-8?B?T0dBeG9ya01tR1U2dDV6YXhzVWNhYy9KUXpIN0lJOWVPTmgwNUo3Ly94OU9B?=
 =?utf-8?B?QWhjUG83enFIRU84T3BHWS9WV1JqZ0l6RjFqdW8yanZRbU1JeUYxNmdlS0xY?=
 =?utf-8?B?cWJ2eXhjV1JsTk9KeW5aeGo3anZVMGJsZCswbmFJY2MydnZIYmJycWFZU3BR?=
 =?utf-8?B?THIzTmFlcDBsZEJlRngyRnRxOHdnTU9IVlVMZ2dseXpWV3VRZlcrb21WTHBC?=
 =?utf-8?B?eGg4cWtiSk1BN3lxa0ZZYmoyZkd2RGpud2w5akNETWEwS2xiQU1aOUVVMTdF?=
 =?utf-8?B?VDd5TWZXb3RQbGJEYldzUkVZTVlOR2VveWtLZ21sY0Z0cTlmS0hVWFp4ZTQx?=
 =?utf-8?B?SW4vM004dTJ1MkNnVEdubHFLVVAvRkZGMGt6ZFZ5ek5lU2NnbGdxV21sQXRI?=
 =?utf-8?B?RlIzZGVHT1FrdmQ0VTlkQ3c0RVh6b1BDWTN2Z1F3WFZHY0lzeDk2b0dFUFdY?=
 =?utf-8?B?QXEzVUxqcjA5bnRZdGxCZmV4RjhPV1B0aXNocHhrOEppNlNLdjdpSC91VUxE?=
 =?utf-8?B?ajhyVlZTb3MyeFQwUm5TUDhuaDB0enhyNU80RmlFUXRHN0I1QWc4eTJhcnNK?=
 =?utf-8?B?QSsvMzhReUxETGY4czVPcmdjWDJUK0pRL1UxRHkrZmVpMC9lRTBmWWcrR0ZU?=
 =?utf-8?B?cFZ5Sm1KSWJhdU5lcFEwZFpQWTVxbDJDVzBEdHRhbFhKUkNFenN3d3R2N0FJ?=
 =?utf-8?B?eDZDSWxYK1B6cFVpRDBEVHI0TEVVbU1zU3dWb2hDd1pHM2ROZzA4YUtNOGI4?=
 =?utf-8?B?NHlGWTZ2L1Q2NmNSbUFJakFPQTBEbmZqdVBNcW1TQkdFeGR1Z0cyVjg1UlRY?=
 =?utf-8?B?ZGpLenhUNW9pNGxLQmtTa2tEMUVkMjVNbkZ1ektYNjA5azBVQ2dtcjdRWDVp?=
 =?utf-8?B?Qk50eUwrUThmWldPNktxb3gzVnZHOVNNSWJEc09mSThoRWg0aDZUWXJXd21i?=
 =?utf-8?B?cGtkN2pPNy9Sbk14SkxpQTZ0RjBIajFoTU1DZHNieWRRd0NoL3NGTURCN2dP?=
 =?utf-8?B?THU2MnFvS3I3aVkyYnk0UVlCSXR1ZzE1K3E1ZVVVM0d2T1RUZUtkSzdZdklK?=
 =?utf-8?B?Z1JnVDBNMWdTWjYyRFd6SEZNV25aNGltVEQzclVNaXp0clhyTGhRS2duY3Jh?=
 =?utf-8?B?NncyMXNRY3BVdmtONVlaM0xPTHJMT2laRTNTSXFRa3JtVzh2U2pXVW1QQ3pC?=
 =?utf-8?Q?a7UfI9SJpiur+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1hzVFBuYjNQellCS3lxTnVpdkNtWVEwU0R1eTBuYVMveGFKWEFjbkJkNTNh?=
 =?utf-8?B?RllqakZRTkRkRkxqOFNzUEdBOUZ0WUd3RTgrd0pJUkhIMEFQUWIwaDVJcGxo?=
 =?utf-8?B?dm5jRnJmcFgvZStOOTlnblZLQ2lpTEpFVHEwTW1EdEhFYUFiL2RZMUxxWVhG?=
 =?utf-8?B?U0RzOHViS2srN0NJckN2U0JPTDhUZG0zR3ZXL3FmQi9Pc01GYXkzaEVrVzJS?=
 =?utf-8?B?VjlOamhOdnhxd0pvdW1oQVFGYWpmWG92NGRCM2NCV3VkMlZnbEVXNGcxci9G?=
 =?utf-8?B?UmNnVGt2OGxKVlkwYitnNEU2TjV1b0dDNG1XQzA2OU8wb1ZqNTg3TGF5Vlhm?=
 =?utf-8?B?RmFOR0s4V2ppR05uTDl1NkNyVHJQcS9qeE5RMUw3SzRPc1UwbEZaeDJra2hC?=
 =?utf-8?B?U0lLNEU5RHlodldSZ2tXN1Z1TzFsbHJJTjk1bStnby9xblBHOFdxQmJSQkQy?=
 =?utf-8?B?dTFIVERyV01jZ1Z3RnJsaGE1aGlDRmxvZnRzOVEyMGJWYllOTDY5anJoZEFW?=
 =?utf-8?B?VEVxVkVuVkRTcjBLSFYrT3JXaXZkdkdkUjQwZmdCT2NPdVc1eW03YmtOSjRN?=
 =?utf-8?B?RTBMWmVvMlpBbjNBeGp0OUFCWkkrcVJPMGlzVE1tZ0tqejlXeDh4UGYvTS9P?=
 =?utf-8?B?cjVmVktlKzJJcG9zdUdhTW1zQ0FRMmc1YnNZb1h0SThrcE9wZG5VclZhVlRP?=
 =?utf-8?B?SWZOV2pkbktmbGorZkk0WHB1VzdZQTBud3VhN3p1YmVJbEpnaHo3bkR3dysx?=
 =?utf-8?B?b3lRaUtTOWcxcWIwekdBTGMyMit6cXJrSWJ4VkJGMUY2UnQxRCs3YVdUckJC?=
 =?utf-8?B?eEgxcWhHUHg2ZndGQ0ZyRDZva3dXSkU4KzdudldLZEpwZU5Yc2pEbUNXK3Nm?=
 =?utf-8?B?ekdmVDg1dFk0SmlvelpRejhYalpQYkhSbCtZenhsaUVaOUYrbDVJZC9WWUFt?=
 =?utf-8?B?Tnh5eDJQdlg5V2ZuRDJCa2ZFc0FrWjFGM3h2UldTMU92bUxPZ2VmOHpIblhU?=
 =?utf-8?B?dUpibzBla1NxYUJUQzJUMGJPQ3k3OGdHaWVJTjl1djRZOWVIK0xTejdlVm15?=
 =?utf-8?B?M2Z0OFRYeW9meEpyTGdhTk0xZGx0c2NnbW92LzhvKytrVEl5NXorbUthOVJV?=
 =?utf-8?B?cm5WZDlYVFhDS2ZwWisrU3VJcW1ONDR5aExVb21odWxWOFBxZzUzbWJvdkgx?=
 =?utf-8?B?ZE5jOTlaSzM0cjI4bmxrYzRTekZCb0M5cllYcE1mVG0veWNwS29YR2RPbS9J?=
 =?utf-8?B?QXJQUW8vcGZZTnFzMytnOERKY25Rd3pkLzYwUldxcE1XSE9KVGJiSFZyTkNW?=
 =?utf-8?B?cjFveVFXcTBkWHp3RWV5NjI3TXMwYUI2NDBSeWhiaUJBQjV0Uk00NWF2bkdy?=
 =?utf-8?B?ZlFxYzJpdWFIckNJVGVJc0hIMGx6LzlnQkthS1NEckNSM1NWSU4wVkdGbXJV?=
 =?utf-8?B?ZURkTC9lVk9uNkpzUXlkNGZVTVFSOGtzdC8wa3o4WnZNYTlPY0VXSGRjc0tP?=
 =?utf-8?B?a2ZjVHhUNTRJUFFkS1BBTUM0MVc5c0x5UkpGWWZyQWtHK3E0NXZMYmozUlRZ?=
 =?utf-8?B?UmM5MHZtdHVweFNhVk1TckVDMUE4ZHhVZ1B3VzIzLzN3dHNtZHh3dERVV2xm?=
 =?utf-8?B?VENNOERQMEh6UTZtZHFYQzJqbHFrSmE4eXRrTEc3ajhHZmRWeWsvV0o2NFRt?=
 =?utf-8?B?a1NLL0FNbnc2WlU2bDdHTWIvT2FERytVaVJCQWZNYmVMMkdMRmY0Q3IvQU1F?=
 =?utf-8?B?V28vTVJFaXB5cyt0ZGpGUWk0am1BcTIxRTRSNTZuWnNhcmFJcFhFQjl5d0h5?=
 =?utf-8?B?aHV4TTlRaTdiYXhzNmVDUDROTHVqY1hXMG9ZODB0dTdMbUZLdjQ1aGk4N0RL?=
 =?utf-8?B?R2ZxUXdLUTg0L1VRZFI0WnpLYWRROVR2bDNwTkNCSXNYaFRwenI0ZHcvNkNI?=
 =?utf-8?B?UndUZG5wYU4zK0NmdHNsa0JmejdNVjUreTJFVGVOMFVCZm8wb2hkcmR1UExJ?=
 =?utf-8?B?R2g4QUVaVEJVSHR0dVZPT1M3K25DNGNuRHJBMXVxUTRtTk4xYlhGcmU1RDFp?=
 =?utf-8?B?aEdic3lVRlNuNGdPazNYRlRYSTBKejY3aUFrNDArVG1lOW1RZDREOUpwREhG?=
 =?utf-8?B?ekcvQ3BvR1ZqNWlnb0NvTW1OMFMzOGY2SXZqaEVBVE9JcXBvUGFDMCszUXp3?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b008435-f06d-49c1-54f1-08dd3969b1d5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:47:07.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmimZbRGrbnw4+sBalbufna552REU+dGqbyud2VTKZqnwahbqxbTG1qNlIqSCYsFLWf8jaBxE9DL5AgZS9etBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 15:47:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17556

On 20.01.25 13:34, alexander.heinisch@siemens.com wrote:
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
>  .../files/local-top-complete                  | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 8adc4e5..c4135c3 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -153,6 +153,35 @@ expand_partition() {
>  	# Inform the kernel about the partitioning change
>  	partx -u "${last_part}"
>  
> +	last_part_device_name=${last_part#\/dev/}
> +
> +	mount_point=$(mktemp -d -p "" "$(basename "$0").XXXXXXXXXX")

New binary (except for clevis) - would have to be listed in
HOOK_COPY_EXECS to ensure its actually available.

But we are working here against a temporary rootfs in RAM, thus could
simply use a static name derived from the hook name as well.

> +
> +	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
> +	cryptsetup resize "$mapping_name"
> +	mount /dev/mapper/"$mapping_name" "${mount_point}"
> +	fs_type=$(findmnt -fno FSTYPE "${mount_point}" )

New binary findmnt. But why not using get_fstype like the rest?

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

rmdir does not exist by default. You could use rm -r instead.

But we don't need that strictly spoken. The initrd rootfs will get
dropped anyway.

> +
>  	log_end_msg
>  }
>  
> @@ -215,10 +244,6 @@ for partition_set in $partition_sets; do
>  		echo "ROOT=$decrypted_part" >/conf/param.conf
>  	fi
>  
> -	if [ "$partition_expand" = "expand" ]; then
> -		expand_partition $part_device
> -	fi
> -
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>  			| grep -q "luks2"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> @@ -259,6 +284,10 @@ for partition_set in $partition_sets; do
>  	esac
>  
>  	finalize_tpm2_encryption "$part_device"
> +
> +	if [ "$partition_expand" = "expand" ]; then
> +		expand_partition $part_device
> +	fi
>  done
>  
>  if [ -n "$watchdog_pid" ]; then

Hehe, I was waiting for something like that from you already. I was too
lazy adding these extra bits without having the pressure myself.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

