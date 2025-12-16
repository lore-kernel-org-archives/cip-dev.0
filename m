Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25012D5E37D
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 14:36:26 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23968.1765895783579157807
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 06:36:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QFMVWq/X;
 spf=pass (domain: siemens.com, ip: 52.101.66.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrMmT9M2yXL+s76Me2iNp99omutLYOhY4ov7gcm1diemBcKdEuIZ+mTCYxI7230WJOR1mSXn1M2bHRmIo3DqHwPgUEqvIhAF47x9Oa98A+Blqv0JDSqzDLVHySO4mAUgTtdiPH33+quUpoYa4Fd+aGCNeZ5EgvytgUW7mn62MzsBx+TP3OmLlbBshSLBsD2jecESguOYdneo6wkofQJ1IUgaTE38jYO1/EPmxL3HGk/vMb+EsKZUEbYRWBfyz7w0VttY3fEgjV905GBFGUYymKD1Wa5+JyPXhS/TWbQNpM64HQi0/Ku0yxOgdoGZngaUapZALGtWcZiNmj/bYF1meA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4wHuVPiBwSbPXCFm9+HqVSNRelPg7qA2B763Ka3OGM=;
 b=Jgv9Tr7GAn3XU9/eVPOafq0VTFoqWgcL8OXx9APDvbk49ueS1DevnqE70QzQBSC9maBNyfWest7sxiQIqlplEMBNot90UrfX+AiE253kzDWLgJry3CrxBsaLQ6iWzr5E/4zNYri5Xg3dEdgC9UWQ9oGEmBIcgAI89n4mQtm1ZrLypC119taV4quR10s5YhOrTdgKrPqXIeysSQyhrGXqVlmsFYRlVeHSTM+w1GEZlj12XwZKy6vWYuhkvS/e7blo/YF9L43WcfEItOCp5BvpeVtgwnwwi+tXURc1SlapCLvvVGKIydGO4sqfo14/cQiAOi0INoXqW3Rf0wYWAs1zvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4wHuVPiBwSbPXCFm9+HqVSNRelPg7qA2B763Ka3OGM=;
 b=QFMVWq/XCZLQyiFAwMr5nXPOxw9bQccyZOpVVcRKvm8795RQ9Lymg4yV/44IPVZ1dbdpjq0GUXRYgIsRbBQe+XVATi9mPjlksu7D1+zFd4wIvhxPCquFB0z54pkHYNtfihskBF3uVFJ8/fOO2tUTe72KucxwQJ6X1GrgT2z0qSiNIKIMLngjVRPMdAQfA+fnLFROk5OosSEkmP2I/qkEcU80xHwqvXaeg/rxwJs9o/iVjF7BaFJUb8gqWcuaPz+kO6N2WXTH3OyhRcHjOSNxLTtRTk9X5eKe2+SQ5HTFdgyNQywQhBBXaL5uTbMqKCSdE4pFsyDY2dlMipf/ieO2Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 14:36:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 14:36:19 +0000
Message-ID: <9497bbbd-e541-4595-88a1-39379d5d18f9@siemens.com>
Date: Tue, 16 Dec 2025 15:36:18 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.10-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3608:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ef84c0-478d-44f6-e62d-08de3cb07a2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WCtjaGNQWFNrQ2lTV2lUZ1gweVRlNHdvbFpNdCtSSGx2L1pDeTdETWNDYTdF?=
 =?utf-8?B?YUtMeHNjNFQ2R3NpSjBwVVhLRDJzTEkxMlkyMzl2YStCNmdIenB3WjV6akZC?=
 =?utf-8?B?eXZTYXhQdEdmWUgxY3lua1VaSTcydWNiWE9mYUxwZEg2ckJWZ1M2ODhrR3Ja?=
 =?utf-8?B?aDhEamdZSDVjMVN6cytZa0kxZ0FXbExwZzFGWmoxa3FSMmdySURtcVNuTytN?=
 =?utf-8?B?d2lmTGx3QWgvZUxVNGlrZkZHL0w0Y3NyS25SdElYak1WNmtlMHdqd3ZNVFFB?=
 =?utf-8?B?RVZwM3kwWE1OUG03RkNZM2tFb3pqQWdObm1vNEdLVjNQa0QySzVYV1Q3azJt?=
 =?utf-8?B?OTRYd21CTTZMb2RSWGNvbVNaWW13ZlFkbU8xTDlSWk5LMEwzb2k2TE9GN2tF?=
 =?utf-8?B?Q2Urbk8xZUFBQTlGcStIVVMxeFRBRUo0WUJrTlZ5MGpKejdHdFBNeWJJaEFP?=
 =?utf-8?B?MFdwM0NDLyt2VE5FQWhTOXB3RzkzcHQ3QnN5anRZSXlQMzU1dHc2U3gyTFMr?=
 =?utf-8?B?cDNZVGRHQjdmb01JbEQzV2t3czFCMExNSlZQZlp4UndjMnlYOFRWMlZpS2JO?=
 =?utf-8?B?L3pFV1FuV2t3SERUTjNhYzVYVTFNM0UzSTB0clNQTEZLRHhkV3M5Y05wK1Jt?=
 =?utf-8?B?aUtDVW1LVkt3b3l5MkV6YTB4S1lMMFYvOHVWQktqWEI1bU84U2YxV29BK2ox?=
 =?utf-8?B?cDMvUm11cFBQZGp2dGp1N3BhZGEwUEpsNHNNczlPeVJKYnBnMGpOOGNmNnBI?=
 =?utf-8?B?eTJ1cVN1Yit4c0pFbXBjRFBmVHZwV2pBNm1oTjBTVk5EbFlydlpaRjFuNWg4?=
 =?utf-8?B?WGNPbDhzbjRneDh4Um41MFJsVGdENVR1QUYvWXAxM1EwSVEwTWxuV2dscTFj?=
 =?utf-8?B?RUtCMHp3S1JBVkp4WWNRblB0LzdYQmNTSVZpUFR0NytkOFZxa3doUFBwZ0VS?=
 =?utf-8?B?QlNOTnhqbzNrS1ZjTlEwanZSaWZyelR6RWNGaHBDa0psMnpkRmVKVjNoMEZu?=
 =?utf-8?B?UW9pYUlJQllRV01OSDNFbG5oSERUcFZHd1ZvV0o5Z0FaQkdHcmxqdjdSRjVy?=
 =?utf-8?B?VS9tSnNvQUh6WEZXSU01b0VJcXVyOVN5L1VyUVVvYktxRjNsSFZ4VFFuQmt2?=
 =?utf-8?B?TDBmTGQxaGVJTkNyQWtJZ0QyZTkzTmxMcHFHcmptMjBqSFlCcU1QVVdmUlEy?=
 =?utf-8?B?QlVmbXRaTkV1TmlqU2xseVJINVRUZnYybGh1c2c4ZE1oYnRybWVoYzZOWEFE?=
 =?utf-8?B?ZUlUdllTaVI1QVo0NmNicEoyMERYYlJPcFVDbzdNMlBsd1o3anhPVTZTV2k5?=
 =?utf-8?B?UHYyMFdOTVhtalhIT2o4K21pcjFQNjArYlo2Kzg3TDN1bEhCMWpGOXR0c2FO?=
 =?utf-8?B?ZlBxbHNVdHM1VGN2TWw3OFNrbjdtbVpoR1dubDBLS0VWQzY4TE9ROHN3bld1?=
 =?utf-8?B?d0VCMkFTUnpocWtHK0dtd1ZrTmk3UEprbGEvNlJQUjl2UzlpZUlLYURtb3F2?=
 =?utf-8?B?dmhoR3paa1ZxaXNLenBldUk3OWJwV0FmNGRkU3ZndlVJTVVISWtaOFJ1VHpS?=
 =?utf-8?B?S3NNTnorK2w2VVhIYjZtdTNUNG1CNzV6bmhqL0o2MlRxWldjZVZjWTRtYlZO?=
 =?utf-8?B?SFJCQmhMeDJpTUxjV0dpZHFGb1dYL3lyZ29rcWkzQ2ZUVzd5ZU1VUXB4a1F4?=
 =?utf-8?B?MUMveW5VWEJQSnpMVEdSeTE4bkR2L2NyMWVZbDdSRjRjUGdMSm9WOS9yZ3Zt?=
 =?utf-8?B?dEdzODQwOFYrTXNSQ2tDUEYwTncvelEySnltYjZHZVZvRDZWMFpYSUFNWXI2?=
 =?utf-8?B?OCsxdkJuU0I0emlnR3Z5ZlgwVlVLT2VoY2JYd0xuZENGblRsTnZDS1RKV0to?=
 =?utf-8?B?QytNNkZNc1IvZktPOCtzeU5UUXlJVm14Yk9MUmhQN0RKc0pmTllRSzJZdUxS?=
 =?utf-8?Q?1hTjJimeC/+EugXx1PDIerCPwX2Jhqda?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bi81eHYvSS9rNDJsR2M0MVdLUTlFQ3lzMVJrWU04QlFhRm1IN0RWVlRRQ0dz?=
 =?utf-8?B?Z1BZVWV5WDBuWHIwbjlyMitlNm1SdUxkQSt0NTZJSVphdTB4ZkY1QXBSb2tO?=
 =?utf-8?B?MytTc0wwWlBnbk9rN3hDekRRcCtINSszblVrSzdxK041dE9lQ2RjKzcyelU5?=
 =?utf-8?B?STFpVHVOaFkrUzNCMTBXQnU3bDFobW03OENBakdjYktaMkl0bDkwODhDZzVW?=
 =?utf-8?B?VHVvOFRwVlFVMXlSNjZxeGJDcitLSFJYdXY4K3k1ZTZhNGxEWmNpUGJEeG83?=
 =?utf-8?B?elBzdmhtYjlQUmVIWURWeDJKOElRd3IrODg3akxyZkk0d2U5bjREbmkzZ00x?=
 =?utf-8?B?a3ZkUW9mWEg5cE0wRVF4M1NzZC96T3dkK3E3NmU5TGduMmtpelptVEFuUjVH?=
 =?utf-8?B?Y1hpTTdaZTlZS0dqTmVhNjRWMWMvVlZyYUg1dDFMUW5CUXhFaGF0aHNsTm1S?=
 =?utf-8?B?MGJ0OXVHOHlvMkRzUy9IMktsNGIvbE5aVDlVdzBaUFNoWlBSNWdRcFJNWXQx?=
 =?utf-8?B?K3dKN3JLV3VQdGh5VHgwY2N2K0p3VURsQnRxWGZocVM2byt4M1JUVk5TVFVy?=
 =?utf-8?B?OHE5VXEyZUFUQW9namtadlBuNFBpN1duUWxGcXljN1puT0pFSm9Jc2ZDZmFP?=
 =?utf-8?B?Y0ZLSmJsZkV6N0k1OExYMGtGeExrRFZaN2hzVXlZY0RyNk43anhScUpjaE1p?=
 =?utf-8?B?TlF3TGVQK0ZIQWJrQzdJMjFxTmJnRGszVzhiNi9laEp2RG1XRXNsYU9jS0h5?=
 =?utf-8?B?SEdnK2IzK2FGQUpNcjdRalRZL3FXVWpGcnp3MXdVd0IwYVY4Vno4KzVEcUZi?=
 =?utf-8?B?TDFxMHBNZlk3dWdiTC9NZjEyV1lTTElXdGRIZyt2dm53djRDNmdpV21oMTAy?=
 =?utf-8?B?SnZFLzFvMnpSWit4WEV6ZjYxbk96aVZRNkM3WVVMZ3dBUzgwNjZBVUR5RG9S?=
 =?utf-8?B?bnVqNmkzZ3huZGpjNDRkY2wraWxLK3JMRTRMVVlnMVZ2N2dJQ253OW5aMlNL?=
 =?utf-8?B?Y2NQTzZ0bzluTU5SOEtVQ0JuZ3RqVEtic1VQRjlZN0V2NkZ3ejE0NzE5VDRw?=
 =?utf-8?B?OFd2c2NHYlFTa0laUDJMMHZKTmZJbzRPWXh5czdGWWZRdUovQjlMZjAvKzRP?=
 =?utf-8?B?RlNPK2ZHUVVVNzZLS1pqY2hxckxJQ085OTNMWjNvd0htZ0szN0hwWE1mMEND?=
 =?utf-8?B?ckplU0VZV0E0eElkN0RTS0hjK2FwRGc4SHRwbWZsU2JRbWtPZEw5U0JDRVdj?=
 =?utf-8?B?SmlDOVJteW01ZE5vUHcrZkNnNXhjbkw3NkpXa3JYajZ0M1MyeGU2L3BpRXRE?=
 =?utf-8?B?NlJpUmlYWkFibmpzUGZoZ1c2LzBpanF0UTFjMGNKaUJkWmFUT0JBZk53V2Rs?=
 =?utf-8?B?YUxJcjk3ZDdMRkZPcEg4U0tqbW9mTllnVTZXdXAxelhtQnVIWlo2WkFva3hl?=
 =?utf-8?B?bWNxV0VrOWpMVXlyUGtxaDJZUE5VUS9lNFFnSXFGMDk1bkp0VkNRbkVjNEJk?=
 =?utf-8?B?cW9GckFkOGRtd1RRQXRFaVlPUDJFWkd4dDhsUzJyUVhTaXMwaXNpQ1BRb0hn?=
 =?utf-8?B?Z0tFOGpjN0pwV2haSFpYY2lURjRXVEdYMVo5aVhHREEwTVlNNG9yZHlubHZu?=
 =?utf-8?B?aittSnl6aFBFcmxleXhNMmRCdWZGeUpRWGJDM2IzSVplRkhCSDFHZ0hHVGcr?=
 =?utf-8?B?eVBPOXhsa1FYbERmNVhUak9WMzcwMVlXcWI3ZlZSNStQM1BUMkZpZUoxYkNm?=
 =?utf-8?B?Y1ZoYWt6Vnc3RHREQzYvK3RwQnFYMnFaMEZicFhNZHlLUmRHOEtSYWo4dy8z?=
 =?utf-8?B?aHRyMW1SeEhxQnZha09qKzBjRWRuL2dCb2N0V0lHdENobm56NUUrcDhBOGJB?=
 =?utf-8?B?MUQxMnozQmljUWxmb3Q1b1VZN3AxUmxVdmxTeUw5VHZwcnZ4Ni84TXFIb3Vq?=
 =?utf-8?B?V1RxWVkzK1VFMFhGTGhRTm9RZjBtVTBTQUR4V2hTWGN1QngzOXZERCtvYWlo?=
 =?utf-8?B?aGdiRnkxbXRaSC9WN3pCb0VKN29jeFl6MXJPbUNWdkFUbUJRWjZuSFJjZURp?=
 =?utf-8?B?Q2hMMlk0cktoYkkrTDRQSTc4SFBIQnhydjVHdUFrck9ybHNxdGZ3VUE2YTBC?=
 =?utf-8?B?S25TWUtVRjMxOGtBNlVoMngwcWtFR2YzdVFLWU9NclhzNFFaeGVMdCtWZnUz?=
 =?utf-8?B?K1MyaTBvMVJyUmRVZU85eWYvaXdYV3lYamgrOWxwMjlXVHVVWHFzeGg1Y1pZ?=
 =?utf-8?B?bU0wdUVwOVk1RVU1U1RNZXB4UzJRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ef84c0-478d-44f6-e62d-08de3cb07a2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:36:19.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTzd02uUP5jdzMFeebzeJ5n5iPNpfue11YpAe8Uf8iFfSOYpYbIVDg2ivaN39iRfx0m+Y/rRrfbdzWWfozIvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3608
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 14:36:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21087

Hi all,

here comes rc1 for the next isar-cip-core release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.10-rc1/isar-cip-core-v1.10-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.10-rc1?ref_type=tags

As usual, test carefully, but also test NOW. Ideally, we have enough 
confidence to release by the end of the week so that many of us can run 
away into vacation right after that :D.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

