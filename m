Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F589CCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 08:23:16 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.5])
 by mx.groups.io with SMTP id smtpd.web11.3597.1761639787517655931
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 01:23:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZxWAgnJd;
 spf=pass (domain: siemens.com, ip: 40.107.162.5, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBvfeSISA4ApTDGIWjqymFMJ0VEhfhoSYd1c7D57a2vbw9fx0/kirNqFEX9umHbIDrvhiKASILhMTM9gjwzEPUhcZehtPejMbeUVz+vwbA2rfxlT0ypTxxJqfv7ZLNhQ+ea9rfiERMGRJ7wdYH7ZLAXaeNH2xTApVqjXWykgANI6TkffzaKR6s7XaZvsybv4NC4zNvkZxE9cZCHGmIOkArY7rFeXKyCliZCAVASk/JerNI2KYP5LhPB3Ml8P1pEfY8072hQZdfP2STPpEJIgIf//vt213oQB+vpOOp9/KFFE9PSB0rbGk1LILZ/0mku9adD4zYAwrWD1tphbwK9D1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv/h5AF8IkKwt0bkfbMEBxu5qJSy1rOXTH6AFwB2BTU=;
 b=vGBsi02pTAtnC2BXkqngQPlsAF+f9Uh/4KmLshZ4MTqrjql0PK82Jjz/gq+XKn7f3RY3Nqohdq97TGXypiA1m9WsfvbjCzSGaGaUY8wdbzzwvH6u8I1G5OpGMvWQssdp4GV2050ktUrULlnZxIWJCXJK5Jtr7f46yYBt+mby1GRtqUWp/GcjmxgM05y0YPE0XmrHIX7gDs7glTaQH/lO5DT6m2W3kiZU2DYfPfIIzHZd/K8bQx1uitWoeRhepcRYCINCA70idtnek3WDfxRx8DouFGNJj+eV7Jy82zzJ5UXX5y+J+xDOtD4Q+v8LxRGulWSU9XINhCzyd6CKrNPtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv/h5AF8IkKwt0bkfbMEBxu5qJSy1rOXTH6AFwB2BTU=;
 b=ZxWAgnJdh7ECWkQRdGTwAsSUqZHhQJFcSOjOyffd5ZtOUc7q/IOgsAz8i9NAXyPsOnIrDSaUbVeERl6r1pfcIPrQehEoHRWRXkREMJjj20sPji4Z8qr0LwAh9jL6KRu3kx0rShh3hkNcGXOVt6WM6dnlNzUG7ZuuCX8DgKgrMb/xoZgJ79LgSzLCGOS6YuFwmcV1aEfGx3sjs74SpkXDYlRNEzCPsrntynqSXdswZbHnt0QACxohEEJabW5tcAt5cbUQbOqFsWoEGzJtBl+RFbYFl2QZq+Rwc36smkgeeEw6lewPzYFQ1TvbVSm6dlzanlhR8+Ji0hcPv8TpPEWuVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by PA1PR10MB9050.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:23:04 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9253.011; Tue, 28 Oct 2025
 08:23:04 +0000
Message-ID: <24a1f7d4-d921-42f3-b429-83cd78e25159@siemens.com>
Date: Tue, 28 Oct 2025 09:23:03 +0100
User-Agent: Mozilla Thunderbird
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
To: Bastian Germann <bage@debian.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: Update Swupdate for trixie to fix
 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::16) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|PA1PR10MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae5b596-236b-4fa1-1846-08de15fb3710
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UmFMdHNNQ1dtYy9zSFd2YktUUXFSTis0YlNaRUZ1WllBa0JmdUlNNE0zRkZ6?=
 =?utf-8?B?WGpRSXVFTU4zM0tnMGVsZ3puZEZxMkY4eGQzVzZadXk5T0tzNzNBLysvdnZV?=
 =?utf-8?B?a2hRRnRDTXZsLzBGTjBIbExiWkVKYjJpSlN1YXVTV29XZ3BJWEZLT2RpUHl6?=
 =?utf-8?B?SC9aaGdHWG01VkhWS3Y5aElnZyt0MGZNVEYvcTZqM2RVVkdobUNRSERPb2ZE?=
 =?utf-8?B?cTlHR05XeGNIUm9yL0YwOTlZckZFTHRldUNqOXVCanR1dkdwbExtQ2JJUG54?=
 =?utf-8?B?ckV5SVp3RmhmdE9NVUc1bTFoVndOK1hOODRMNGtqTEludDlCNlhpN0lrWnVk?=
 =?utf-8?B?VjNveWJLVkZETHFmenNoU2VOSnJWVFZoWHhZYngremVLVTBDWWdlRHh1QWNq?=
 =?utf-8?B?V2Zmamp0S0pYR3NCeHBrcG5YTkVnckVIYUdNQ1ladUJWQThEd3pzQk9CdlFR?=
 =?utf-8?B?Z09FbFRqMkJCcG9oQytvYXpOczBuNW5NbjJTb2pTeWJmQlBRK3BOMUJvcGVr?=
 =?utf-8?B?dkgvSWI3MFNiQmhwMkxqSHNHVGJ1T0dVcjc2ajBHRjR1cE5JZmM3a0tJTHpI?=
 =?utf-8?B?TmZoZ0RVdksyejdTdWJhTzBhb21HaVdmRExoTjU4TGI3YjM4WVVlYmZLTC9q?=
 =?utf-8?B?M1dsQm9raTZqYXZ6aG5HQzhvdzVLV2JaUG5qQ3kyM3U2c0NJa2RNcG5ZZ0cv?=
 =?utf-8?B?RTVvbGZvZHdVUXRWblh3Mjc5VCtlQUtSTHVTVElIMU9EdFhOcFlSMExkZEhY?=
 =?utf-8?B?V2lNd0FEdkh4SGRJMVZBT1Fxck9PMWgrZ1dSR0dmQmo4bE1nQkxFalUvMGp5?=
 =?utf-8?B?cUx4RSs5ejFBckFaa3dSKzkrVW1CZkZwYmJoQ3V5T0t6SHdIWmhoVVA1eHZt?=
 =?utf-8?B?RVlJMXk2MVRTMlFZYXV2eHI1Z0pRQ0pxMm1zWk1rSHB2NnNhOTg4Y0p4SnFV?=
 =?utf-8?B?OEhySzF2a3ovVytOcHlhNFMvTExkSm4zRnlBbFZ3L3FqalpwaWVKbjJKa01V?=
 =?utf-8?B?MkJLOC9YdFVqK0RlYnFLYm54TDZGcEg5TXRMQnZJVjBQZ3JiOUZXM3NtM05y?=
 =?utf-8?B?VkJ5L0pTVnNlb1JHSDQwdnZnd3VsYmVySGJtbDl6ZHk4QUxHVEl1ZzZxaXNW?=
 =?utf-8?B?N3hkcWtIUWtHWnpmaG1oZHQzTTFuT1l4SExaQzNoQTZWZlpjTmFmdUNnUVN4?=
 =?utf-8?B?R01TT2tPNGYzQ1hqVytZZHl5TTl6TkZwM0tYdC9UQzNyUVYybHZxWFk2QU1n?=
 =?utf-8?B?cVZOVWpxOEo1WWNnUjhCK3dKSmJiMmVhNG9Oa1AvZUt2V3F4Z1llV21VdUhr?=
 =?utf-8?B?bjNIUStBbGdPU080MzFOcDMvUmVwdXZUQjB2b2R3eGxXKzlBNlZmb0tXaUkv?=
 =?utf-8?B?eWZHQXFRS0M4L3I1d2Q1ZTJXMDlFWmRCQWoxVFI1emxVbUo3Rkh2SFFkZG5I?=
 =?utf-8?B?RWFlNVhmaHJWN0o3TmdKdmltZE5RRlpMOWFYVFJTdXlaVHFHT1pMekdncTQz?=
 =?utf-8?B?MkpzTEFTWEV3OGdtaDVONXBmYnRxbmlYZVQxRmJ2MFg2d1BzajZ2VHk1M2FC?=
 =?utf-8?B?RG5ob0VvdytKZUlNWVV6bVlCczl1czdvUWNUZEk5a0VhWkdRWFlFRHV2aXlJ?=
 =?utf-8?B?WkxVZ2l1RnU1RlRnUHd2TUJDbUtkZis0STlnNmxPNW16Wkp0UmFRakJrRVpO?=
 =?utf-8?B?UjJOenJrZENWTWxraGlRQnhUMWpPcDlLaWVoU3JQRVZZZzVHU3MxeWllUmdV?=
 =?utf-8?B?alRwZS9uZ1JWckZyam5TajBwMGtoc1U3MmFDTlJXZkJCMDA5SFF4cEhLUnhw?=
 =?utf-8?B?NzkxUmdxRnFTMUlpV0FwMHRVNnVoK1FpUVl5UThGTldjczI4MFhtZGRyUHFy?=
 =?utf-8?B?aXZtZEVNSUtObkNvSnV3YzdCM0U2TU45Z0ZCSjBNSm1BTC9TTDNDVDJGMzAz?=
 =?utf-8?B?dTBOVHhMaFJUTGNXMjQvV3lQNXZsaEhqS2Z2dzVkeGM2K0RvR0pQQ2dsODRp?=
 =?utf-8?B?RWVPMWpvY2lnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1dPNEc0S1QzU0F1T1oxYnppdzlpMkxRNmZrUWtUL0Y5UnVEZjNtNHI5Qm1V?=
 =?utf-8?B?SmwyVjFKcmxEQldseEZzQjJLaWJMYnM2TXRVVElUYis5SzNadGMxMDYzNjlu?=
 =?utf-8?B?Zk9pd29OMGhxK2NCTXJXQ2xqSEJOVThhOGI5bnRYOVBIeE9sOVpnM2c2MUV1?=
 =?utf-8?B?dVQyV0ljcWd1RGhLUUp4dDdmZmZSMWVnNnVBdVltclR6a1J3aDlpNEhLcURa?=
 =?utf-8?B?QkhCN042NG1KS2M4SVVmcnJkZVhuZzlCSThJV280THMrNlVpamxUa0h4MTJ2?=
 =?utf-8?B?Nk9CNDVmS2NRR2p6RURIT3c0YVUvWWdHUW5NWmZ5YUg2WGVST0pEeWtKKzhO?=
 =?utf-8?B?NDlMcG1JR0pqN1cvb3pVdHk1MXQ4NGtsU3FIaTVQNkR6d1k5clhVREh2VGRV?=
 =?utf-8?B?UUpNeTFydndPd0g3cjhPNitUd0M3emQyTk9TYjlRNFcwbnI2djlKZHFvN2lq?=
 =?utf-8?B?WEpjWG93c3VvMTNJL2tRZ0hqNWhBNFNsZjRadE5nMys1ZG15V2xVTkZCQURw?=
 =?utf-8?B?M3YyczJhL0dsUnBMRHVWS05CeFUvWitSSjVOdmdYZHpFd2FNMmY0M0NscTN2?=
 =?utf-8?B?TWkxRzF0YWFaS1ZvYlFaYXA2NlF0c3IrdEVKSWsyUmxFdGh3OGZyQ0RNMHZr?=
 =?utf-8?B?Vk9MZiswQnZWWGNqK0pvN2hNOHErd1BrWFhSOEZVbi9SSHlQWnVaVUpzcUda?=
 =?utf-8?B?c0d3TG5kdVNDSGxPSzA0RzdLb25oamlVRWwzTUo1ek5waXJ0RWNCRkxBRlBh?=
 =?utf-8?B?Nlc1YVdUQlBnSEF1QjBVNWVYZHFoeW1uVFZVWkNjT2FQQ0dCRVNJSmJnTEll?=
 =?utf-8?B?YXg3a0M4SGlyWHVGQjE2WmYwbnJvcWN3VWNiblpjdnhaM2czaFF1U0RwbUlS?=
 =?utf-8?B?dGZVNnhrS2NlbmcvMU9vVlpYM3hmOVJodFZHVWo3K3FUVUpjVitUTlg1enVH?=
 =?utf-8?B?akdxNWMzK2tOOU0yVHVIcU45czdZa2JMYk4xMXBrbExEdEZGdWdBVGhFanFj?=
 =?utf-8?B?VTZ5OHNyYzc4SlAyQ3VleG1Pcm8zUU5RWFNuK0Y3K1lnY0ovT01nRFNlSWJD?=
 =?utf-8?B?N0dLRmx3L1lpdVU0SDVuejZoME8xckxlejlIWEhJMzdaKzc4d04xZUg3eTZq?=
 =?utf-8?B?QnB2Q251bDhuYUVjQ1hTZ1NSTWlNaHVabHhUbGVXUXBJdVBFai85Q3FFNG9S?=
 =?utf-8?B?bTdDZ2c0ckdwaU83enFPN1orZmJSdnpramRrdHdlSEl3QzJMaW82d3pnZlp3?=
 =?utf-8?B?UnhiclFKK2F6bC9UZ0FGQzJvS3YyV0JXZFExelI2UGN3SkZJNk00clE2djYw?=
 =?utf-8?B?dWMzbzN6S0R5RVZ0NVFVM2Q3c1Z0WDJoYVpGUVNqVlhQZW05Y1hBYk94ZURD?=
 =?utf-8?B?dml4OThBQVBHaXpZUVJKY0xyU2s4TlZUbjRSZENuOE9lQnkvWDlxM1ZRNFRk?=
 =?utf-8?B?OG5IdEtWSzRwcjJ6ZmRLdUJlbjVqTWR6ZzNMSG9hRmtYT0MzZWhsSjUybFVG?=
 =?utf-8?B?QTY1NDZRV1FHTEh2UDNqTzFiSDc1M2wyRG5nbFdHRUNRcWtqWXhVbGpYNWRU?=
 =?utf-8?B?TW5DcHBPYWp4SjMrczE4bXY4NDBiU3dJZll0YU9ZeWxrdG9la3hFMGIzS1o3?=
 =?utf-8?B?WjhqNXM4R014NVF1VHdTcHhLbXJaZFB0RVlKcjYyYW5NSnlOTDBQTTlPTVh6?=
 =?utf-8?B?a1dLbjF0SUlqckIySjJ2WVc1Z2VuOEdKY0EwbGhGNUhMeGZnZFgvaW82Misx?=
 =?utf-8?B?dmxiVVNibXdoWHY0b3ZBVm5TMWpWY2d3elM1MXdUVEFLUUd1cEZrU2JLUm0v?=
 =?utf-8?B?RHIrZVp4MGw0ajlsM2w2WDZHYkRINVp2Y2pPQko1MkJLQWZBWW9xaVBlZTh1?=
 =?utf-8?B?UTdKRnU5Y3FHcUw1SXlGREFydHlYbEZpZWtLSmdmaTRpdWE5WXh4OXVONWRk?=
 =?utf-8?B?aDY0VjZMa3k0UjFHamNyRUNqRXZIV2dFVG9QSGZSTFl4dzI4REhsOGl5dEs2?=
 =?utf-8?B?QkV4RmE0Um9BMGxRd0JHaFIxWG9LVEo5MjhMTldNU1dwZkZERkdoY1JVM0c3?=
 =?utf-8?B?YW1wV1ArNEZrY0VnSis0Snhmb0NqRFpRc3V5a3Q2MG9BM20vNWRSQzQwRnVo?=
 =?utf-8?B?S1RDMzdvdmtTV083akdQRU5QSU9jVExjY3lvSkcxRTE5L1NzNGZjRzZIWTZ6?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae5b596-236b-4fa1-1846-08de15fb3710
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:23:04.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTbxw7CNwAfdZ6ORb40YOC5L+DqOfgNDkAYi8WCYUsobCfZqhmGVCD4aWkVyLiXN8fdkWe1w/Is6hONj47UDCeRleEYkwhYhc+ckhsKIP8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9050
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 08:23:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20251

Hi bage,

Can we backport the fix for the SWUpdate bug 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485 to trixie?

I can create a debian/trixie branch merge request in salsa for it.

Best regards,

Quirin


