Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E0F8D761
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 16:03:19 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18249.1776355394060377405
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 09:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yntq7xNb;
 spf=pass (domain: siemens.com, ip: 52.101.69.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og27Km5O4AC2A/gZXZvCPyje6HnvcznpwKFPHpU7ZRWzx/teJGrUO/vGQXA9aOWfwQntv+fMSg439ex9sJ9Mdu52NAmC75dvO8MBRhp7XogS63Z5A/Y6hO52uCkX55Zhl5zO0rrXNkQaeXv65ITTZE01ko+QYka9Wd+RMR/kbAN/vq92mkXLPMP1uatvNH255RfuXX80lDsyFVx0Pst0LllEx5SFKQgNul2onZrh1o8zA6Xm0nZdFcrN0J2gGtD3JutwVc0KNP+ZtCmAs1N9RGRmXqCFW7L+huBe7iFCOPYZAj3K9pm1NnVoIyrrIgeoCbqGCxCkaFDSUqO1/E6iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNsJN8rrABGuBbgYLY8TZERHjk+65+0G/jKuc+GMx0U=;
 b=SvSQRQKmqIlmsHhW6DlR17YnhyH7d31Yi9ZLGHySfvs0tIBZ3vHh4YcKve0nyqyxiCi7MZQNepqNZQ6fEabpZChsDMe3tTfEDzw8gP8YDwuqCvr7GdkqSTwzHwx/hZDbagoCEVGWRJgv8HT/GRW5So0J/ngb6MK1TWZWuVS0Xwg/kWvhgD1rueqzr4FPdsJ+iAgs/chVuX4We53kbD8VeSdBYz3xwbb3hqcCHCpaTyfNRlbeSi/KSenoHRYzYo9tISKwXKjiMDcYxwGmygE6QH5QYiqaIJKg+jyDcsdJ4q5DmqVTQhE97XHb1nZ4oVk4NyQgeCDndY/dlYSFA1Lh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNsJN8rrABGuBbgYLY8TZERHjk+65+0G/jKuc+GMx0U=;
 b=yntq7xNbImD+EY0E0hmNpuV3ha4Kl8jHAadKP9ZpzjoyEIb7hDIvY48n5UsDr/VTR+BsgtbEGx/GxQXAoij3l1kQdQ+VwpsNXbYfuqusHjsrb/2C7OnqWhNlTfqkkVGU7vfVZwZNp0j4Wvo9BHTQOVRMijuJuDw9MJxtiEqxMJfKYoXOyvbz9NhupKE8cVfeEcSLFucoyb7YqK7Q2RWriM9SOHlmhcVSDlyv+65ffrgcBFr7vCBjGXK0J3l8FW2aCjyB8qRGlm5jKCT68a8g2V38/BLE73giYUtif/uQzM4PZJrxv/cP1eMpxyiF1HVxcAbcyHJDTjgfVYmYWWQ52A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 16:03:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 16:03:10 +0000
Message-ID: <5166ed66-d402-4786-9b1e-bb8f7ecb13a1@siemens.com>
Date: Thu, 16 Apr 2026 18:03:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] encrypt_partition: evict stale systemd SRK
 handle before enrollment
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Sari, Sercan" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DB9PR10MB6643CE84D750B5014B3606DCF05DA@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
 <9171aea6-f54d-401f-8fcd-92a902b3ec16@siemens.com>
 <a4b214d7-4ffa-4bad-ae11-3793a1ea7a2c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a4b214d7-4ffa-4bad-ae11-3793a1ea7a2c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: f20d48c2-9ba5-488f-ba28-08de9bd1a7db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	36DD1L+rG7qfFGizD5aDjFZzGwOcQcrBrQALYOkqG85bS4uk3elJWWmYDiGTbwVGUNvSuub6b9lFW9YJt8RXuSFC4VIjzWolOYdV0hnpHk8V2viPqn5/aLOwkSJXLEdtGvqYpeEuFE2fe5wVo1AkBd6EFinl3ebvEyC20DnzjTHNaV2QvIcZ54DP0R/zN3lOmxXzAiNUZ/+H3Ve52Ivfx5uSJpkM1XFgKMsQV8cJu73+Vof2zvT1Y1v6x+tMk8kmvQNV+gFfq6jPKWOB9O53K0sg+Wc+cg2hDYfFzIuEjpKK3t29V3w1wirmBPvmlJMSMYFyv8ypVygH1TMFWR+psYptXosXAIOu2twfycSBjVlq9qeRATkEtIbI0c7fwDw5Y0KuQ4KrjzGY8XvXLc6KOhuybXS1sO2sB6wlfOobLF9KldIP9M4FYXB4V/fNKdr6OaBllGRuJ/YJVt/RUZZ5ZktEW6lG6e1o2X0qWNCv9ssO2S76kNgN8mYwyNSwp0oSSr77m8AA4h0kNIi3m2QnOaHWdE/mUDx0kWyubDHLJ1RwyH0CCfIV+Lu5JuV2mQjixoeNTPZZ7iQZSlF0HmyliHXi0dsUAtqhgpCZaGXPsnEN9tfbSyp8qZGgRzLgomaGoNf0s+gaeLicAbqAO2bUb9oz6ET04RlI2O73yTdEj49qni+XpVDORd/iT9wgoXlb7/V/Ig+t+khUfCbMdkZfUh1l/xb6mLmach0jglMi0mM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rk8ycnlldWVveFU2QmpVRmpSYzNZbUxkSXRJaTBETlBuS1dZTUswUk9lM0VH?=
 =?utf-8?B?dlBMY2JkaWQzWXZsVUJXM2RlN1RDNU44VW92blRLUzlyRHJxMFBIekxrNFBm?=
 =?utf-8?B?TnlBdzdrbVhRaVdYWHJTeTJrYWxxNEJBRlhmZld6WGtSMTI5QVI3Qnp1SmJq?=
 =?utf-8?B?ZzgzZnkwbXJSZVdYQzBEU01XUUR1Ykd1WG9iMFRxSUNMc205UEdkdmp2dGpT?=
 =?utf-8?B?YWVJd3lSYWdYejhRb1RQY0xaakRCSEc2SDUxQks3UWNxRXAxSDUyQzNoTUFy?=
 =?utf-8?B?SnpqKzhVVlEySTBVbWJQZ1JTZEsxY0NKY24yVlVGaENETUNtQWFPM3RDdzhO?=
 =?utf-8?B?UVVLYmk5TlY3T0RlWE9aZHUwZVZSVEJ5Ym15STRjK3JzaW1OQjlvOVVERE0x?=
 =?utf-8?B?RDlRQnhoRHlISHV6V05IVlhiUHIzSmkrMlVtS3VuZ2JON1dwOEI1NW5mRkNu?=
 =?utf-8?B?U3lXbDlMUGFXMWNYMVNrNDMzcDMwTm9QYUhxYWVnNm1HN0dRenF3NWd2eXN2?=
 =?utf-8?B?SVZNZGQ2RUJoMGlZUGJ2cjhHb3R0VFM2YTh2OWIwTmJkZGtGRW0vV0RXVWtp?=
 =?utf-8?B?azhGTEJyMDNUNFY3bnhuWEt4YTlCWnBxL1BrVlFEMXVkZGZnS3FKK2NFTE5q?=
 =?utf-8?B?YnozWC9HM29ObHQ3MjNBNTRKWms4bEdKUm1rdG5EbGpKNkMwM2dEVUxuYk1I?=
 =?utf-8?B?NElwODdHMEdDNGR0STA4M1FWS1VHUVkyK0E1ckxkR28rQ3JhdVFZQmdTYlR4?=
 =?utf-8?B?eitVVVZMaHdtSXRoU1dGNUlENEUwUFFSUDY0L1MreE4vOW9odzJ1UFZ0WUJo?=
 =?utf-8?B?MjNuTzFSWG1uSzE3bW42VUk1ZithM3RmcGZja3hoNFFaQlltWDZSaERqRnZ4?=
 =?utf-8?B?VTYwZ0xWWDR2ZFdma24wYWI2OHRDTm9BZ3Zibk5iZCtEUHlMSm8ySGxINlA3?=
 =?utf-8?B?cFZDNjhoM0JWZHJpa0ZjT2tHQWZnaGZXbkNXQXdhRHl3RGxTNksvWDV4NXZh?=
 =?utf-8?B?YzM2QjVHcUZIamRQd01tTUtZSEpjcHVwZnBBYSswK2pvMFJDS1ozdXVGNzRr?=
 =?utf-8?B?bDlGZVJzVFQxdWc4Vm1HK290V1BUN2N4REY4VHpMRDBhWDlLWXFkSEllQ2dP?=
 =?utf-8?B?enRBeFczZEhNWGpSbG13V0ZBYXNNY21zcnBlTEYxTEN1UkFaaXlWSlJUZkhw?=
 =?utf-8?B?MG9GUW9TMkRKNXEwTjdlb3dXRko4a1lIWkV4b0xwODRFNFp5VEhBNERqZURW?=
 =?utf-8?B?MFBQTDY5cDdwakg3M0ZsalZzMWY4S253TTYxY0svai9tdFFRZFI0Q01zZ0Mr?=
 =?utf-8?B?UFRBcHV4YnlyKzdWUWw5RU1CMXFJRi81SFFqRjgzWUVQMnhIdythVWdTTkNX?=
 =?utf-8?B?Y25wbllqdTA3aFRpeUZ5Ti95bStpckgzSldZdEszc2FPNFVacXA0RDM2clhj?=
 =?utf-8?B?SU54YUV6azJ6Y2lnN050ZXF5WCtJb2RKVE45WXdDVGtSSkRVcXR0c2F1Rlp6?=
 =?utf-8?B?RlI5VHpOQWJvZzZhVmhGTzFKckZacHB4M1ZtcU5MSlJXTnJGQ0J1WWR3VTNr?=
 =?utf-8?B?N0dkVXhDUGJ5MDdZU2gxcmNYaEpyamk4TUtpc2l0UUViNzY5RTNvNk84QXU5?=
 =?utf-8?B?VVAwNktQYjdsWlBUelNwYWQrSGk3Mi9TQUIxR1RjeHpvUDBDRTBqa250aWRi?=
 =?utf-8?B?d0dnRFlLZm92VE83cjBlYkdjd21aazFJQkNFQ0E4OVNqSE9vRUtmYmdzbmVk?=
 =?utf-8?B?Ulcxa2NKaHMvbDhFZENpcnpBdnUwek5qVXlpOUZuT3hoT3NBeUErS2J3L1JR?=
 =?utf-8?B?R29FdWt2OVB0eXovUkVFbGJwdWZtb1VTZjI3UlV6bmtVZE53a2kxK0szbk5E?=
 =?utf-8?B?bDF5bWp5TnNFTUZHeWN1NHpOUHJlTHhLd09Vc2FSVkxRWlB5VUszckF0VEgv?=
 =?utf-8?B?bkJrSy9ldU5veU5oK3NoUU1OWmI5QWVCRmgxUHFzektrQ1ZSbUVld0RZQVBq?=
 =?utf-8?B?WVByTkFPNGNzYWZkT1psN3dnWEErcGY0NjJQdmsvbHVsVkwvSm9MKzdwaUh0?=
 =?utf-8?B?U0l0NjBkN1N3aW5EN2Q1Tm1sZWVtMzJHcU54dnhjYVVNM0wvM1Z0TTBsU2J1?=
 =?utf-8?B?VjYraDRzYXpIa1JWS2pZT1F6eVdvekVmcDdFcGFBckRMRmdhbklhL2hwSEtW?=
 =?utf-8?B?Wkg1M2Z1dmlBYXM4azNoNXphTXAzSmRwV1Rndk0yWUFjVmRLZ21UNDhXUDBQ?=
 =?utf-8?B?V0JaeFFvU0d1OHZmS2ZNNUl1SllZenU2T0U1SVRPTTNZOC9BdCs4OUhLZElv?=
 =?utf-8?B?QVdxNmdHTENYUzNyQnBCVUMxbTFFSVRObUNZOHZRRlJwaGpjUnZyUmZjKzNI?=
 =?utf-8?Q?9gM07Omb1EnyWIPU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d48c2-9ba5-488f-ba28-08de9bd1a7db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:03:10.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSDUJ354y7JyXawHDPkbHDozJq53xy9S2BiEUoIQQe1MnpgsrIA1tvRF3UIuyDUtm6duRYeadArQ5afdzp+qPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8233
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 16:03:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22749

On 16.04.26 16:56, Quirin Gylstorff wrote:
> 
> 
> On 4/16/26 4:30 PM, Jan Kiszka wrote:
>> On 06.04.26 15:39, Sari, Sercan wrote:
>>> systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
>>
>> Is that handle number officially documented? Or was it retrieved from
>> the code?
>>
>>> evict any stale handle before enrollment to avoid
>>> "Failed to seal to TPM2: State not recoverable".
> 
> Could you also write when this error occurs.
> 

But then we would parse an error string and re-run the cryptenroll -
does not sound very appealing this way.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

