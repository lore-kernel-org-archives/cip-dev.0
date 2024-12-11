Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C5E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 10:10:54 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.52])
 by mx.groups.io with SMTP id smtpd.web10.7287.1733911848480574553
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 02:10:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oH9mwKrM;
 spf=pass (domain: siemens.com, ip: 40.107.103.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwxM41YcnBlmHSSpRmo7X1iXAZRlIbDH2JvGF/XwyYQADyeG/gifWSrqTi/vB9nSkxHhHV1Qsuge11nE3zOcuM1pJa/HY3MtcPtVZNHK++TRpspFVhL53I51gFaYLMnnXUsUEfqhex1rBQ1nnk9LSi7rxkPAypFh3QjnCQLJUcts78HXm1GUTVS1Fd0aHrNuxcoX0suL5Zb1zpaoGYbrWxrYZNAhJS0jROkNKGalqtX3GfNrozUWvmEhmvim8tdsxHuKqzbl2fx6TLaPRU8wYbWL8ILhpOxKkoorektZso22UI25bNzRyPEw1ALZAAMWZyb0RL1d5MrJm6wd4yEL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWA1CAEx2WtrWrERsCbB2AtcHzETzfUaP8OkcaM28Xo=;
 b=JsgRfSoglMuxl06FFY+XI/OkTgmPj5XvIRBQ0igLMByoXJrcjgBYETtg0NKyuBmax6aBcEAeemzvilZbCon09YaDQHjZjwijKqSw8VIvsj2V/BDMb8uvrED18MY3gfEMaxFv6il/7E1vzjT6Ev76rtZuu0h7zAi+6HBDWjYhRyUkYlLb94/mlhBf1J5TC5i27aPlmWpDbYQP2D+zON8hXusJp/GepFSywzsMautuv5kOQi7y5sp7JKOTW3cYHZAxo6PioSZ9kHnhvhqcJvEt6ueBbD7Hnk5b0AeraRy0lDkFOSxCYS4eQTFiywRZDolMlo5gAykKsDX0aKUvMzCkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWA1CAEx2WtrWrERsCbB2AtcHzETzfUaP8OkcaM28Xo=;
 b=oH9mwKrMyZmRpp8J2eeVuNi1h18g2MwIfE/LS3XuWx0l1Xkpqb5Pf5td453aMZY5ZUdNhDfiOP1Wfa0bSBZSIwx2HgCiW/YhkN6aFdLvDNTG0AfMwoO2tg8XimmSscgQIPfWjlZKjq2u6UKuG4PyFfgPqBeHN8KiweViinuub/QIqFA2dzL7OS20V0aTPxFWGkhZzE0f9h6yVvDHFnCgTSR+9M3BptkY1L6DOY4u8j0JX4BsurkDvrOFO844CyMsI+5Qe2LCjy0oCnSGH250DyBPcOkpwmDAYXdUtZlYU6+MSrBIofr/UMoTbkd11+2rqjB99P964FA/Yw6wgnApAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Wed, 11 Dec
 2024 10:10:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 10:10:45 +0000
Message-ID: <3b867cf4-fe71-461d-b252-0f7c45e69a8d@siemens.com>
Date: Wed, 11 Dec 2024 11:10:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/3] erofs: ensure only dir prefixes are
 excluded
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241211095456.2735691-1-felix.moessbauer@siemens.com>
 <20241211095456.2735691-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241211095456.2735691-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb1d879-0beb-428a-1362-08dd19cc13a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VWlHY293YllPWmxNQVVOSWNMYWg4UzhxWmNSemlxZGZVQ1hOd3I2TEJnTUxH?=
 =?utf-8?B?WGhhUllkSGUwdDJpYlpCb1RRYVpJUlFKdnBjRnBvMlRaL1NqZDRpSmFSWUhQ?=
 =?utf-8?B?UnN5VTY1MkU1NmFSb1pSWlloeDZteHdGMnNyblQzWmVWRkJpcExaYmhZN0NP?=
 =?utf-8?B?ZXF2MU50enhzSFIzaUFPZDd5OVhIK2lUWk5EMWdQTCsxRDhpdklybDZnZkli?=
 =?utf-8?B?QWkwY2NxVDZUQzFsemVKdnZTSWJzdVdJZ3Vnd1R0MndMdjg0NXQ3aXVzamZa?=
 =?utf-8?B?V0ZBb0o0OTFpRXlmYWxNS2lHZThBQ3B0SE1Na054SFdram5WZjFJT0lBRTdr?=
 =?utf-8?B?KzNpOFFzR3pqWkxVVnlZV1NJODN4NzFCOTRlVVAyNkxxYWRwcHRkc2tNcmVB?=
 =?utf-8?B?YkRjb1hyT0lJcmg1MExabDBlaDRma2dJYTlER3VCeXNPYkhXNjZmTjduUE9W?=
 =?utf-8?B?M3M5V3RCSUpqM3VkczZkdUliMXRnSlc2NjEvMkU1K0VxWE1xR2FIM0wwMzNI?=
 =?utf-8?B?UXN1UlhJbjNXbzBTbzQrTi93WUM3QjRjY090QVlnWnFJWTcxQ3RmZWt6YXZw?=
 =?utf-8?B?NSt0SzNQbStzNTNNckpNbXJIbC9OcFB4Z0U5b2YrR1ZGKzl3U0E4OEZ1c3Ez?=
 =?utf-8?B?cVh6aUg3ZGVGUXRackhteHI4dlhnaWlmRmsxc0pOckY1MDk3aWlUSjhEcXNL?=
 =?utf-8?B?NDVKemE2cEFmV01pUlNOdjB0ZklkUTFMV0NPL1lMVzFGK1ZZYzJTS2RBN1JT?=
 =?utf-8?B?L0JmbXFLWmt1Y1l4UG9YT3NuV1lvaTBJaUNnN3kzQ093SW1HL25sOFI1WU9h?=
 =?utf-8?B?VjBGTVdDK09EODJDbm1jMFBJbXQ1OGtUK3VHZjlLSzJybENLeTlIeDNLeERH?=
 =?utf-8?B?cUJsYlEyc3ZMVVppVFF2OEVYcnVoRzNTSWN1bXVhdWJQMUwxNEE1NzRhRHRx?=
 =?utf-8?B?cXY0a3V6MmF1alVTU1RhRk93WFMxN3BmZzdoYlcvNDhZN2tjZCtWbWdiL084?=
 =?utf-8?B?WTFiaUN0dGphMHVMcjJFU0lHaldqNkQ1aGU1ZlFqc1ltVzVIVFJXWk5PR0VR?=
 =?utf-8?B?dUVPZkZyKzhBNm0rL3V2VG1rTTAzSjFwajI1S1VRYXhhMmRYYXF4d0xhM2k3?=
 =?utf-8?B?ZlJKd1M2UG5EWFFuVVk0RXRLcW1Sa2VPMllpVUF2NDcyR3M0TURYTngxV3Ju?=
 =?utf-8?B?NmF0eGRpbWp5bVlUWlU0Z283RWh1R29zQWt5WmJKbTBxWEFNb0tiZVNTRi9t?=
 =?utf-8?B?RmE1dklkRUJhNmdZblhDVEp5Q0lFN05BRHEvamp5R1RHUktJaUpqb0thTW9Q?=
 =?utf-8?B?RmdtQlVxVklQRlJhRVZrdFN4TE9hdmtQcUxXRW9vbzNxTmxjY1ljZkd4ZkJv?=
 =?utf-8?B?WWpuYlF1cjJmaG14MnE4NmRLNURXdUxSWGJJQ2dqcUxaZ2hXTFQvMnlHZXl3?=
 =?utf-8?B?YkRGeFN6NkF0QUczMGpVNGtFK1NIZ1NBM2dVSzgwTnFTWDNXcGQrNm5RVTRo?=
 =?utf-8?B?ZWpXdzFRQ3g0V2VvSjVFZUFzWTB0SUJXTGdMc2Vrc3VuNTRyRFVwcUFRVTZR?=
 =?utf-8?B?RU9tRHV1SVc4TE9yd21VbGJJUG1DQ21GMElDN2tzS01oTmVDb0dzYmdMNExr?=
 =?utf-8?B?S0dDZHBaRU9xL0xCN3RkVVcrc2N5alFOeW1OODJmSnZ0VWRqQ0w5K3NGTkRv?=
 =?utf-8?B?SUZYU1d1andic2pTVWhoWThGLzZweHFsTFN6NWMvYWZhWTJtM0hOSkc1M2FZ?=
 =?utf-8?B?SFlmcGQrK0lubGVCcFZESFM1ekRJeWY5QXBCY21jZFZyUDRhcW5PaEJqaGZn?=
 =?utf-8?B?bXVIbjN0T3hXY0Y4V3NQZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFdKNS82YlhUNkl1ZmVDZ1BDSFB0RGdJdzgySTJhV3VvWkM2RkNsbHBoZ0M2?=
 =?utf-8?B?MkJwSU93RS9iZGdJNEIrcXF1bSt4Qk52OWpVZW5wYU01QXE4L3ViaFJIUXdW?=
 =?utf-8?B?UmE4Rnh2c0Zia3ROenhPeE5ISkRLUG9iZS9sdERlQ3BwVVU5SGdUdFRMbFhQ?=
 =?utf-8?B?WGwrSjRsbnpmYWprNmNoeVlZdUwyT3JQWjJoK0xrcEtLZHhoam9aU3Q5ME9o?=
 =?utf-8?B?ZTljdWo3YWpXM3hjVEkrMDIvYnJXQVVQYmhFZW5tOWFsSmpQdG5ISHMwbnpt?=
 =?utf-8?B?R2xyQ1poL051ZDliSHFaRUowYjlNWVpKOGdtVFVuejZPZm5IUDA2S25xaERt?=
 =?utf-8?B?TGR3L0gra3BCMEZnMnFxRmNaVmlFRlBIbW03eHl5NElzMjRaMW9SVTRROGxT?=
 =?utf-8?B?cGlNUm03UisrRzBPNXF3Wk5oYm1CSnI0dGU2amxibzRjSGthVzM4QmhLeXE2?=
 =?utf-8?B?TUgzd1h6YUMvZnlVRnpTa2VjVDZtT0I1UDBuRzZqRW1tYWI4VU5sdXJ4cVZP?=
 =?utf-8?B?YWFlOWZjWndta2M1R28xS1FRSk5yWklkM1BUMHVjL1YyRUJ5RUdwNE1iaVd2?=
 =?utf-8?B?SVZTRXBidjN0NUNqTDBZSHNRQ21TZVI1ZzJObG92QmFlakgxMlZKSUh6M2gy?=
 =?utf-8?B?UEZsNEZuY25qTWpsdkk2SUJZVnR2bmtCTm9jVkpGd3Y3OURBa0pxMnhYVjVL?=
 =?utf-8?B?K0JzTjNrWWZpUHJKajB1VmVzR0sxZ3pUR0xPQ2FITkxrSDRBS0FFRDRRZDNM?=
 =?utf-8?B?c0VEV1BkeUlGd0lkVHFXNnl3bngrNkQ3L2cxTlJsSjU2ZW1OQWd1UXN3Wk9i?=
 =?utf-8?B?RGNmMTJKbG1zbHZFUkJ3TERHRnJEK1NmU084NDVIMWQ3d0VlamRIOE1YYm16?=
 =?utf-8?B?SDdwdjgzckRseUVsVERMeXBPTkovcmo5ZkRFeDhrNlV4Q2lBSXFuNFA3QUIy?=
 =?utf-8?B?a2pDaTNINzVQeHNHTXRaZFFGL0VmL2Zwckk2dUtnTEdKd2RtU2ZhdHRLOWFJ?=
 =?utf-8?B?Sko0UlkvNVdPOXh0Tk01alhpM3EzbFhtV0VNd0V1QVhYb1BGcUxXUTFjSnFv?=
 =?utf-8?B?Z2hVU1VkRXhydndjY0tTWnpJUTl1OWdYZjFZRjhLMGNQOG5aTGQ2MlZpMXlB?=
 =?utf-8?B?Q2RQMjhhZnRvbFhnZ2U5QlBuRGJXeUVBeUlLdEdtbzJQVjU0UWpUVFVPanlY?=
 =?utf-8?B?YzB3eGdoOEhXYTBSR2ZOMGRDQ204RWE0eVFRWlhoN2FJSzhYY2NISFhkYi9q?=
 =?utf-8?B?bHpLV3oxZ0lBTU5mTmc0TlAzYllhZHhXTTRxNlNzdXR6STdvOTdmZU9rSzhx?=
 =?utf-8?B?ZVErS0YzSklqYUp5Z09OZnd3bDQyQ2pPbytOUHdsYm9odUNvYzZ4YjIyYlJF?=
 =?utf-8?B?MXBhY21qdWRJMUtnWURpZnhVQnBQRCs5emwxWFJyV21la2NqdFE1cVNLUUJh?=
 =?utf-8?B?bzRYN3NNMDVoZldiNjN0UUZLRWxiZXl3cm5XS2hROFJQSmV1QTFkdElwbmJI?=
 =?utf-8?B?YlY4cWl2dzd6ak95WnNLa1ByQnRyaEJNYzVYaUZOOXA4VUxUeVJabWNqc2pK?=
 =?utf-8?B?M0N1TVNIMFV0dUlhSEhhWmtBOW5aRXB1MkRmMklaTG01RlE2bkZEdTVhUXNl?=
 =?utf-8?B?a1AvUkt4MldxMTFSbUoyczM3Ykg0LzE0QmhyV2NSQWxrSnhES3pYZ2k4Smdl?=
 =?utf-8?B?YVR1LzEvZmJBRUFZc01tYzB4Wjc4Ry9NL1BTOU9DMHVHdHpYazBxZTRkQk5i?=
 =?utf-8?B?emV6Y2ZLZTJmNjRvQkpKYjhsSm9tanlVWU9mc3IzM0ROVzBYMmpRK2tyVVZa?=
 =?utf-8?B?NkxOaDN4ek1tL0JxL3FWblVVU1hKenFTQW1CQ015Wk9RSHdQZFhaSWF5b0F5?=
 =?utf-8?B?Uy8zemVURFFQZWxwNkQzQUYveThoTDhLRUdmZmhCb0hMcmFoWkt4cmkvUVJE?=
 =?utf-8?B?cTZoc1JVZjZ6Y1EzOTA1KzI5aGxMajNaNm95R1d0dk8waFMxekFEUVFqWEx3?=
 =?utf-8?B?Ylp1V0hDQnlUajNpQVFwenpVTXM5L1p0L3N3ekszTjlCSGlydHFGVm56V2g3?=
 =?utf-8?B?UE43U1VlN3diMTNTcEdSOEVEaFBSOUErV1R5UXJ4cjBMaGZKYllVN2tVaUli?=
 =?utf-8?B?Y2VUeUh4anN1MXVwaDgyWUxiMG9LQXc2SHh5UGkyQ1hwZmVyV1FUL1NFODds?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb1d879-0beb-428a-1362-08dd19cc13a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:10:45.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oC+v1nau+B7iHRn2/ooeS1E2osZtIdTlhgfbgzzAVjGdiFXBGoBq93Q4YxucKq5EftVsOLKtawjKv9Ei4nhXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 10:10:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17399

On 11.12.24 10:54, Felix Moessbauer wrote:
> The regex used to implement the path exclusions in erofs needs to be
> "anchored" to only match path prefixes but not arbitrary sections of the
> path. Previously, also paths that contained an excluded part were
> excluded as well. Further, we must single-quote the regex to ensure that
> the '*' is not expanded by bash-globbing.

Good catch. We do not have the same issue with mksquashfs?

> 
> I further considered to use --exclude-path, but this is not an option as
> it excludes the excluded directory as well. In case of /var and /boot
> the directories (not the content) needs to be present as mountpoint.
> These semantics differ from the equally named parameter in squashfs.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/erofs.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
> index 189c1ea..72458bb 100644
> --- a/classes/erofs.bbclass
> +++ b/classes/erofs.bbclass
> @@ -23,7 +23,7 @@ python __anonymous() {
>      # Use regex to exclude only content of the directory.
>      # This allows to use the directory as a mount point.
>      for dir in exclude_directories:
> -        args += " --exclude-regex {dir}/.* ".format(dir=dir)
> +        args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
>      d.appendVar('EROFS_CREATION_ARGS', args)
>  }
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

