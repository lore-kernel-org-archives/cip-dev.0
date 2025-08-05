Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99AFC87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 09:16:44 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.52])
 by mx.groups.io with SMTP id smtpd.web11.17437.1754385403312690480
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 02:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lzXTR4ff;
 spf=pass (domain: siemens.com, ip: 52.101.83.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWPURcyOJerdNMlphjHwAyKP/2YM1QcrW37b9ptndoLnLMSDLWDO9K0z+4NAUFFoKnMAnM2q7EspOd5PHK1Z5Wq2sLxHlG0xu8HB3t2SFsk6fuO1sMpKGY1yU3x3sykUvG4N61T3hnnbYh20QzOvRFGMp3/jl9ltJly+4jZuuKJ524OguuEg+I0x/naGlHZ9cw5a6L4w+gWQKYRMeMh7/olyHjTyoaflcurl4ffr/KdR6XsH0ElDBnnvBlbdqTm4isXee4iGTsLqB5xQ3X4otbYMWPSyPWVs6ymPM6Yh0OPqEmcV+zGx2uLzHaPjJT/2ctLNBYue5tlfLI5pLn31YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZKWvtrl1Fs61BerMhpk1+4UND4OEJYmsPOq0cWjiqE=;
 b=tUUENOPmucO8RnsEDDUIrj4zpnx6AevLeFqYJZd8G8QgR8qNjL7TqKQ6kwizEyGLM8Kvwf/khFP13/pfBlqLtK9ritgIDeyhCm1n86i7kTrYZLphuATPWd3ZTvkMcieQOr1sG7OYUZDbrVMPfbAZdQpqnMBZyJO1BovGoYI2nrkGy1XLKiP9jBhJZKqHmPfRsnlsJ/YWka0XVdSN4ET3tuSwopY6BmslcaL9Zxbvr02VLREUIpJMV8JgIZxtHyQq+de+WZwr5yN96NGCya7kJO/4l6yBy25W3XQ+shrqvc1+C02FRcU9xMUlb+byivcMTJxVixY9imoTJOqkiNDbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZKWvtrl1Fs61BerMhpk1+4UND4OEJYmsPOq0cWjiqE=;
 b=lzXTR4ffi0ClypjEjJ/861wp3ecPZJXKjRHJE25CyQLZP8N88kKpml1go2d7dR8n+2336iJiOmAO7s3j5ViFBSAH/DOv9SPGo3McX0lahfq+G1CKDDLHiaxe9A0uSnz6yByc8X7cBVYq0b18nCKcqxpA/eTnid7t7CAOyZ0378xYp4uS7KTUZXo8O/gg0Wh5NGFQpZXqll/JoZU5OBFrBvJuhTKiq7yMQ650yHgQLn8H5Allaskk8Rpfdp2QjBKJIwTOGioTPtaDtU8Dqeqj46FPADfDwcJjjGdbLGkY3XRSaUHC5PGBM7Rx8w7vzsAPpTbi0WbP/dmZEgnc7uacwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3751.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:16:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:16:39 +0000
Message-ID: <caf3732b-c31d-4cd0-b479-7a55d56973ef@siemens.com>
Date: Tue, 5 Aug 2025 11:16:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Bump to 202505 and
 refresh crypto dependencies
To: huaqian.li@siemens.com, cip-dev@lists.cip-project.org
Cc: baocheng.su@siemens.com
References: <20250804022819.136786-1-huaqian.li@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250804022819.136786-1-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:610:50::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3751:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b7c28d-ae8c-4f48-3158-08ddd400c8d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WDFWZm9wT0JlYnM3b0lIVFdtcXlMelowVXZacHU2NUkvR2NEMWl4MW9JQzBZ?=
 =?utf-8?B?eWtOYktDWFFCRzBsZ3Vpa2tqdHAwaHBNalBhUXVEcFdvOXVMQ2dUWXBTM0c3?=
 =?utf-8?B?WGhLR2gxSmo4UGRSWllrYzdpMHh0Y2hjMWlkd05JVnMySFkwZ3ZGa3dzNEZZ?=
 =?utf-8?B?a1Q4SS9lZjd5TUh0ZFpYWmZCZEpIMjFXNW4yc2F4b3hoOHNvQ3JWTGRRVW5k?=
 =?utf-8?B?NlJZQThqZkVRSXZTVDlxWGUyamQ5dUhRTWxFY2RlNmswdGhvNGtObDRLZ3VU?=
 =?utf-8?B?aGhaQ1lsb1ZMZGRuYnphRURGNSswQW1TWXpyMjBZTEpENXgrNjVKdXFxazZR?=
 =?utf-8?B?STJDcHZOV01xMno0MldDdXpFQ0FuWkRBNHNqK2ZHZmUwalRCQTVHRUZsWnEr?=
 =?utf-8?B?bTFkQzg5bFIyOFYwOE93L1UrWE9xSThBN1Y3WWUxNnFudnkwUXE3TlNQSmRB?=
 =?utf-8?B?dVo4N3lTaXIrUjBqRkJNN3JHdTBlRW80QURxWVZzbEFMRmZ1QWxQcFpJZzFF?=
 =?utf-8?B?ZTk3MFNsSXNWVTZmVS90U0J3ODVrVkszcFdaLytsb2h3eWZUaGYwQWFiZDNN?=
 =?utf-8?B?UlNmK1RtVDlLdVg2M1UzUWdENC81TjB4VzdWR2JBWkRsZ2FyZGo2MlArVXcr?=
 =?utf-8?B?dXIvODV2VjVZT3hkWXdmMktqOTBVVy9mNjVIUFRucHg5RnhQVGZYYzRsaGRn?=
 =?utf-8?B?d1l0VzAyVVB4UmtrYk9tK2FYdDRYSm1nb0phS0xSVmtiRVJFSGhpck11QVBB?=
 =?utf-8?B?bVA1VXRTU05Db05sN3czVnN3OEpBRW0xNVFnMm9ONHN4M2VkYVViWlZTL2ow?=
 =?utf-8?B?TDJ6MHdnYU4zSXllbzV5N0owQzR2S01Gd2ZWWlp3TTJ2a0IxSVpxYmt6Q0pN?=
 =?utf-8?B?T0I1RXB1QnN1c05qSTdWdExTR1h0M3Z6Vng2YkNNNWw2VTdRamg1TmhodE1u?=
 =?utf-8?B?eHdHOUc0UjFwOXpvdS9IMkN2OVVZTzJRcjV0V2RFOTFwdk1XSWw2VzlLZmYz?=
 =?utf-8?B?RXBYOGpzYnRaNzNTV1VCcGxEeFRQQ2t0dGJIeEpncGxrTkdCY2NwN3RNaW5Y?=
 =?utf-8?B?bG1iWGdxdHM4cDFzdm5RMGFUZUtMRUFhZGhraitQUXpMRnQwSjhRNXpOUVgz?=
 =?utf-8?B?M2ZXc2R1NU5JNWlBNEIwcTdLV1lNTm50SGlWRUI1a0lOMDN0N3NneTB0emxT?=
 =?utf-8?B?YU50Y2NHbHE5SHBnVlAzS0lVaDNndVptY0NsSFNEZWJneUw0VHVDMVpoZ2p4?=
 =?utf-8?B?MnY2M0k0WEJieUtYeXBzR1BOMTdsUkQzaDJKdmRkTU1sZ3BjbTE0Q0g3aWEy?=
 =?utf-8?B?WjUrOGhuWHB3NlpFaldDY2YrL2o1aEJNTDk1VHVka3NLcThxODZ4YnhjcWxY?=
 =?utf-8?B?STVPNjg0K3dlQ0JEUjZNYktsMWJyWmN0R0J0QTVUTjJNRndlMVE5WlNKdHhW?=
 =?utf-8?B?eFQwS0NNQXZjTEptRzVHdkMwT2F5UkJHNlNMYTdCMVhUVU9NbHFOTytYNkFZ?=
 =?utf-8?B?TVRRQklZVG9relJFRW5lVGhmaTNZRmxsK1dJc2JQaXB4V3FqNFNVcU90NENY?=
 =?utf-8?B?Q3BGOXZobG84ekpRMzVqalpOSFVPWGZEcE1zeVFrSU5udU5xOWt2RWhuUXNG?=
 =?utf-8?B?VVJJb1AyMHBjSXVYOEtUa21UWFpVckc2TytvYmpXS01IUnl4U0haYjZrejl5?=
 =?utf-8?B?elJrcExpdTFGdDI4MHpYcmQvRGlIelVock9OTzhCU3Zjc2I5OExRbTBSc0hn?=
 =?utf-8?B?UjY4cjQ3L0J1c09CK1I5c0hQRG50ME9lT3ZvSU9POXVaMmx2OFJoekVycDgv?=
 =?utf-8?B?RFpMcis3WFc1TFZBRlpGNklTWmdkU3Y4cm8wK1l6ZWVTRUU1dlZJY3ZWcHRI?=
 =?utf-8?B?YThGMG5JWjBWOXlyKy9sbEtVREV2WTFobjhNVkpmdFdtNm1RTHBBTDBDWENP?=
 =?utf-8?Q?nI8DjI7EBp8emFIgwh3KPu6eF/Kkq2jP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3k1dCtQZkdna2hxYldxYk9hTnlnNDdCOE1rOVJDY2plL0wzemd4YTFVQm5a?=
 =?utf-8?B?R1ZCKzA4L1pIRjN0ZXg4UmYrTDJtWG9iTDV3a3grR2Q4V25BSFpBcjlmWmlZ?=
 =?utf-8?B?c3dUK0RIRzZQbUIzUkpUVVdkdVZIbDViN1BaNUhPK0lsdVhaejg5Qmxrc1pI?=
 =?utf-8?B?QkJIQ1VQQnFjVVd0dW5QRmZMQXBPSEgwNE5xUVZiL0lkTlBCKytGSzlXY1lp?=
 =?utf-8?B?WHkxWEQ3WlY1WDZZcGdheWNLNXpGL1JEUTVnN2U1dWRjZHlTRjJZcUZ6QzU1?=
 =?utf-8?B?a2h1VXNWVVF0THJkcDVSRjNDMCthQWJvemF3bUVlcWNLYXdPd21JMFJ6VTNG?=
 =?utf-8?B?SG1WSkN5dTZvVUVXV3NGRzRCSjBLanFvbEthMGRCc1NOM2xMRDBZTTkwSEZ0?=
 =?utf-8?B?UlRRUUVxNGhuMnpNQTY0L0JLWlNLNk9DQ2NLQUUydDVLZ20zOGdvclJLUVRZ?=
 =?utf-8?B?M2NoQUthckxzWU8ycEI2N0JzNFoxTGwxczVKUldVL2RyT0lTWExZNnhwZ0dV?=
 =?utf-8?B?Rmt0TWo1R1QvTnZab1NzY0Z6M3RWWVZzblRVZHIzZW5PekoxaGZSc1Vpck9Q?=
 =?utf-8?B?OXNaVUthT1E1YVNrMTgzWTZnbVk0cHJUMm82cm53bzliMkwvWGgzZ1liTVBG?=
 =?utf-8?B?STNsRk1EUUJEWlBWeHNEVS9NdHdUeUh5blhhK2hOOFUwUHpEOW5LbjhncG1t?=
 =?utf-8?B?ZTZGNHNPb3F5OHV2bkFWV0NSL1FzdFdkYlcwWnR0MlBuQjRpbEZGQWMxanpi?=
 =?utf-8?B?bGY2TzhOTlYzT2ZYNUlwc3FuSmlXOS8rY3hIMGxlUG15SVAwSGpRdkJJYTBx?=
 =?utf-8?B?bm9hYS9rNUF3VEpWVWY4M09HMlJEdW1ObTZHUjBWUmluZWF3Vi9IMzkrTS9M?=
 =?utf-8?B?YVdQc3krUTNNMmV1eXNRQXhqZmZFVXN5U1ZTazVaTmQzazdmLzZ1ZG82Y0Vl?=
 =?utf-8?B?SnRNbTVOU1hpRFduL2ZZRytFaUlrYmVHaEM2d2RVem9sVnFJS3Z5VERqQlg3?=
 =?utf-8?B?K0RxaE4wTXlOVHZiTFNBNHg0UEdpbW9qYmRKMUZWbkNYUU1sM0tKVUQrNDI4?=
 =?utf-8?B?ODJyY0NsWDdaa1JRNmI5SnpHZHdvdWg0VHJNWUNBMkZHcmgrSFFaTXF3ZUZr?=
 =?utf-8?B?S0xCYmkzdHpSZUkxY3JobU8zOWtYOExwRkpCQm8ydmtLN043SWVPcTRpcS9u?=
 =?utf-8?B?Sjg5T1hMbTV1QWErQkwyNEFGaGRKWEY1a1VYVVlzdXdBekx6VjF4eTExTXBi?=
 =?utf-8?B?WVEvZTlNa3QwQ090RkFiSmRQbGNwTDNXa293RFE3NGdtSTEwT0Z5bVVqbU5p?=
 =?utf-8?B?SXRpa2YvL2czREhnRlRYMHQwekJ3Z2hROHJCZmRPUEZ3ZGswVXE0Sno2M0RR?=
 =?utf-8?B?Z0ZtMDRjdnJxQlo2WnVxamxPYjM2QWtEd0tSZFAzZURJQjIvMnhQc00wNFdk?=
 =?utf-8?B?UG1kMFlFSExiTHBOVVlNSmZQYVl6aXA0bjhaTUFDTUJMbnYzMUU0Qm42VEsw?=
 =?utf-8?B?K2RDbkYrNlRiK2tMUVJITVNnWS9XY1krdnVrbERBb3hWNTlibzgvYitDYzlO?=
 =?utf-8?B?NGlzSVhreC9vT3l2N0VGRk9TQXFoaSt1YUtOK25Cb2Z1dkI0azVZM3ArR1Qv?=
 =?utf-8?B?cldOdHNHVDI0ZFhFd29yVDVCNnBPemVqc2d4Smg1WkxIZG11VFFCeDB6Smlr?=
 =?utf-8?B?d1lLMlNVNUN0YUc5WDBwaWlhUkh4SlpBOVM0ZkZSL1hXd3pRNEEyNjVKbEVq?=
 =?utf-8?B?dnVDUXJDdURxa3VKODBXSUlFTzljeUZ5Y0RKSTRBRVowMStjejhESi85Tmdi?=
 =?utf-8?B?T3ZlWlZaQ2RjY2libFF2bDVkbW1taHd1ZmREWks3T1Q5b2JMR2pZTENYZXZW?=
 =?utf-8?B?TGFqWDBRaFprYXgzaWMwdjFKVE9WditrL29YSEZMcjJoRXRmWVpmOUVKdVB1?=
 =?utf-8?B?V1FpNzBoMitER1pPMWltSHpHck5jSDJFK2xEM2xrOTdiWmp3c2IyODRud21u?=
 =?utf-8?B?Zk1iWTVaUkxuVys1TUtJUy9iai9LWU56Skd0OWpWaWtmdk5hQzlBWEloT2x3?=
 =?utf-8?B?c3MrL3VDVFVQR2xUYzRud0JRNnBKWUpzZlVpZjlTWHUwVnFTNFpOVFJMZTdY?=
 =?utf-8?B?bnJPTW9SNnFTQmd1UDJyeVV4dTdJb1d1VCtnUlNJN1FLc1FxSnZvVlg0YW16?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b7c28d-ae8c-4f48-3158-08ddd400c8d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:16:39.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpqY4WTr80xasxQseGe3nO02SgdUKJJE6ALbNdQYn2F0DL4Sw5fYJuZ9nEYec8u59jYZ7DjYl/MNy35xR6zKcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3751
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 09:16:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19668

On 04.08.25 04:28, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> Sync with latest upstream, requiring OpenSSL 3.4.1, MbedTLS 3.3.0, and
> libspdm 3.6.0 per EDK2/edk2-platforms dependencies. Also pick the latest
> brotli release with edk2 submodules.

Can I assume that this was successfully tested on AM65 / IOT2050, and
that you confirmed that persistent data on RPMB still worked after
upgrading STMM?

We are unfortunately still lacking some in-tree tests in isar-cip-core,
though there is hope that this may arrive soon(ish) via AM62.

Jan

> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  ...05.bb => edk2-standalonemm-rpmb_202505.bb} | 30 ++++++++++++++-----
>  1 file changed, 22 insertions(+), 8 deletions(-)
>  rename recipes-bsp/edk2/{edk2-standalonemm-rpmb_202305.bb => edk2-standalonemm-rpmb_202505.bb} (62%)
> 
> diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
> similarity index 62%
> rename from recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
> rename to recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
> index 01dcbf9..4f80cc7 100644
> --- a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
> +++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
> @@ -1,11 +1,12 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022-2023
> +# Copyright (c) Siemens AG, 2022-2025
>  #
>  # Authors:
>  #  Sven Schultschik <sven.schultschik@siemens.com>
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Li Hua Qian <huaqian.li@siemens.com>
>  #
>  # SPDX-License-Identifier: MIT
>  #
> @@ -21,22 +22,29 @@ SRC_URI = " \
>      https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;subdir=${S} \
>      https://github.com/MIPI-Alliance/public-mipi-sys-t/archive/${SRCREV-mipisyst}.tar.gz;name=mipisyst;subdir=${S} \
>      https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S} \
> +    https://github.com/Mbed-TLS/mbedtls/archive/${PV-mbedtls}.tar.gz;name=mbedtls;subdir=${S} \
> +    https://github.com/DMTF/libspdm/archive/refs/tags/${PV-libspdm}.tar.gz;name=libspdm;subdir=${S} \
>      file://rules \
>      "
> -SRC_URI[sha256sum] = "5f6c18cf1068089d669fbe81dab2325f8bf7b1298b192c276490b65e2edbbd94"
> -SRC_URI[edk2-platforms.sha256sum] = "31257160ac51a4a5f63db92d26482d6a005286ed040dafe89d01f0ee906b111e"
> -SRC_URI[brotli.sha256sum] = "6d6cacce05086b7debe75127415ff9c3661849f564fe2f5f3b0383d48aa4ed77"
> +SRC_URI[sha256sum] = "5f2b5e3a267230f82e4566592fd0bfac5e205ad90520b2c9bf80f575293b7015"
> +SRC_URI[edk2-platforms.sha256sum] = "0a266a61732d8dbb95bd2a4c0bf64a91965728b9fcd567af6af0894f23da0f97"
> +SRC_URI[brotli.sha256sum] = "aaa739962a45b508b2e783b915e6b2b57ed3b12bd4b0feac73acfb144dffa54f"
>  SRC_URI[mipisyst.sha256sum] = "9fda3b9a78343ab2be6f06ce6396536e7e065abac29b47c8eb2e42cbb4c4f00b"
> -SRC_URI[openssl.sha256sum] = "b1270f044e36452e15d1f2e18b702691a240b0445080282f2c7daaea8704ec5e"
> +SRC_URI[openssl.sha256sum] = "d4b22527a645acf76b53e44487a8db687c6eed621d7246891d025e38ba8c9651"
> +SRC_URI[mbedtls.sha256sum] = "a22ff38512697b9cd8472faa2ea2d35e320657f6d268def3a64765548b81c3ec"
> +SRC_URI[libspdm.sha256sum] = "dfadf501d23c26041c921974971953a1d4a250ed6cd2679facb781471a5f944c"
>  
>  # according to edk2 submodules
> -SRCREV-brotli = "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
> +SRCREV-brotli = "ed738e842d2fbdf2d6459e39267a633c4a9b2f5d"
>  SRCREV-mipisyst = "370b5944c046bab043dd8b133727b2135af7747a"
>  
>  # revision closest to edk2 release
> -SRCREV-edk2-platforms = "b71f2bda9e4fc183068eef5d1d90a631181a2506"
> +SRCREV-edk2-platforms = "cf63a7257a0a12044b4530904835427813855f4f"
> +
> +PV-openssl = "openssl-3.4.1"
> +PV-mbedtls = "mbedtls-3.3.0"
> +PV-libspdm = "3.6.0"
>  
> -PV-openssl = "OpenSSL_1_1_1t"
>  
>  DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-dev:native"
>  
> @@ -61,6 +69,12 @@ do_prepare_build() {
>      rm -rf ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
>      ln -s ../../../../openssl-${PV-openssl} ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
>  
> +    rm -rf ${S}/edk2/CryptoPkg/Library/MbedTlsLib/mbedtls
> +    ln -s ../../../../mbedtls-${PV-mbedtls} ${S}/edk2/CryptoPkg/Library/MbedTlsLib/mbedtls
> +
> +    rm -rf ${S}/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm
> +    ln -s ../../../../libspdm-${PV-libspdm} ${S}/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm
> +
>      echo "Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd /usr/lib/edk2/" > \
>          ${S}/debian/edk2-standalonemm-rpmb.install
>  }


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

