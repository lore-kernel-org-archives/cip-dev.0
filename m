Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5EAC2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 10:08:01 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.70])
 by mx.groups.io with SMTP id smtpd.web10.4498.1720778880746088956
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 03:08:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mf9HiIgn;
 spf=pass (domain: siemens.com, ip: 40.107.249.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTsOA0mLWAyflteH4UkteZg6zE2ruD+zOmkuRtunWKXLEH9epcg8Rh0Rj0mlwRC5R9lPU6bdpf9PSuSYUj88GBjLziEeZr9buenh4mr3hOKQcSEWqnVxDkKnZSUq2CWTpy2G3BxECTXqeTyuP0QDhJMiygO4pREvWeCWEx9XLcMw13WbgJIJ+uk1sLTryY0itjbX2Zl4jBXTZCeKlrFsYCq0Cn996rVgFYfV/iiYuG7TrfG7CyxY5KtozwzajzbM5maRGNRhbuep9vyJ8ku9nthGlT8vgYVZpf4uvX+0bM4HHEVUEOPzgbRCdpyQWTNcjd20poxg+eu+KVIud3iZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bL4lK3aHat8CBRyKYmnJduq7lwOranPfVQF8ZS1NjI=;
 b=NNn2Qlr56c2xYas7k1QdJFPj9wIU1kXTxwUQZfq2T24PwgbPt7JyfqTyLHaJo65IMIObdZoog8bt+OTvAIf4wQiPuwd7dmqawZKDjFDFjc2tMqDteqxBA+k2W4CH/hM9Gf+/k6vcsm5F75JVY6IfhZC6/QfQE/dr8KQoVPOet4i5wddCxlNqinK31THm7LQGa0Ii99ZdfJz4cbrsK8sVjUgKUwxQ2KxzXq2DGErIyOH5JLYejMDGZDFtnFj7rPfbKVKuwX8iPHwdPt4IIoGeBpXhhkgTfNK4Qclzx8D1cjrwqMFgFO22FA0YSO7be0S0OgFOUNDDG/MAToaKqJIOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bL4lK3aHat8CBRyKYmnJduq7lwOranPfVQF8ZS1NjI=;
 b=mf9HiIgngqgNm2GWDIDkEPwzPcyGn7Lzp6tgqKNmKtYCTvv6A2x5KCS15RsOnp4mCUCUAkaHVCnbbAtXDgLKs+0uv+EwbyazspSCkF4OjDDwpZZJ+6o9il92dXk50N0C3YODF4VA9XUJ+t+9lwqz2y1jeIk4fbuRiqKXxXXBVVOaSDk0YxVEogiiXEwoIR06aazIdDJBPn2XA+k4B4VDwuSvHETJ6uU2ZKxEdGcL8MvOHXPrxHXbstFpMlUCSVkEOvK80cjJdHJ8CHIMbVFm6Y3PR2nU6Wd9NJV6ffBbdQdwE62YvjCIToarthhOgE27yW+J2UrncCJMkzHz3eb/4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB8087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Fri, 12 Jul
 2024 10:07:56 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 10:07:56 +0000
Message-ID: <dbcb5097-d3e6-4a9d-ba45-67b9ff908fda@siemens.com>
Date: Fri, 12 Jul 2024 12:07:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] initramfs-crypt-hook: Add missing mountpoint
 executable
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Storm, Christian (T CED OES-DE)" <christian.storm@siemens.com>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "Adler, Michael (T CED OES-DE)" <michael.adler@siemens.com>
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
 <20240712081143.1376952-5-stefan-koch@siemens.com>
 <9e19021b-d2d6-4319-aab4-e9153bead57e@siemens.com>
 <6a3b533913e5f116cc6f402bbdd298457ca00b97.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6a3b533913e5f116cc6f402bbdd298457ca00b97.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 256a9f32-2d7a-46be-3c88-08dca25a7ffe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V3IyeDgvc1ZUaUpkbXRWZTZlRzB5cytIZC8wdE9zMTF1WEgzbDZ0ekNIOEcv?=
 =?utf-8?B?OHRjTno4KzFnTWZJUXVYM3owZ0NaMm1SK2V3NDRuVTlrdmpHYjVZWHNQZ3Qr?=
 =?utf-8?B?VXE3eHJMK3ZCblYxREQrNW9YOWx2UEhqSWF1cjVUNzV3bW4vS2tkblVGdmFQ?=
 =?utf-8?B?c2FReHo5eXFqSUhSRUhNRGZIWit5SGtmODhmYk5Db0d4MFZoTmtaNUVtanNo?=
 =?utf-8?B?UDJLOVgwVWFyN1hBOEZRcmtXdXJsTlArNHEwbGVSbDJnVGZ3WUlOUVA2cEp3?=
 =?utf-8?B?QlFLeUVhNDR0SWcrd0RYQ2RtL2xFRkJGZ0lrRDF3eWlIUGpKV3dudnI2Y0FM?=
 =?utf-8?B?N2o3TTU0RVUwQ0h1MlhTYW1OSlMramowMzRwSkNuUzZlV2NlTVJVbC9zeWpT?=
 =?utf-8?B?bEZLNDlMTlF4TDNzR1BHWDRiVGRGYjVITjlzRE0wU01jSEdHQksxdWNFcU1G?=
 =?utf-8?B?VUEvK0tpcHg2VG9vWjJFZmtjNjhpWEtSZlpaQi9xdUdVS21BdmRNTEZLSlRH?=
 =?utf-8?B?TXNGRXhiQXo0TnAxVFM0aGVLdG9NemZnZzlCcmVCWDBrekVsbWFOcW1rTFVj?=
 =?utf-8?B?c3ErSHg2RVN1anZoVy81TzRDWVFXUHhwMmh2NFBicHkzd2xYT2tsVndtczNs?=
 =?utf-8?B?MEQ1QlloY1VSU3F6VXo3czhoaDlGejBybmY3enlMWW1YQ0JKaTJEcUlNNDZl?=
 =?utf-8?B?QW1YQmczMlhCV21XRXVyYnBMcjVoQjcrOU9BVWkvNWx6bjk1TDlzU2tuYXBT?=
 =?utf-8?B?VEt5QUNtbDF3aWhFVXVtK0NyaHpTQVJBTTJCNUdOdFdnVXZCV2hMNUV1U2Nz?=
 =?utf-8?B?UVZPRi95VCttL094SVh3bkYyZndIc3N6bTkzMm5kUmVWWTltck5ucHRhZFVL?=
 =?utf-8?B?aGN0QXR5UlFpMTlWV2tjNjZxc0lWV3hkKzZjb3kyNG5rd3BlVDYyTEZhVjBO?=
 =?utf-8?B?TU5jbWNmM3VDM3p5b2p0bmtRY0dsbXZiY1JTdnlDanFPMjFFMXZVeFUybWli?=
 =?utf-8?B?NUlzS2VYTU8veFE0R3FrQmtsTEQ3SGs0c1ZQaVlDTlViQmVZdmtPdjlDblJj?=
 =?utf-8?B?b2wxTWNXM051UDR6UTZURXFGczYrbitoSW5qeG0xOGN2YU9WVU9zQkpkM3pE?=
 =?utf-8?B?MVkxaFBJRVRxUTBjYnp1OGFRNUE4M3VIVVQ3aGh6QmduWU14c1dWUTF3KzlF?=
 =?utf-8?B?T0w2aEpUWTlHdVJjRDNHQVB4R1hmdjRGaXdKVmFaMlNLL1B5cGVoQzlTYjB1?=
 =?utf-8?B?ZklSc0MveTlTNFhSZ1BvRzQwM3JOZXRGUHVDZEtHUWhOelNJa21wWHdDcGpK?=
 =?utf-8?B?MmFDS2pQeEpNbWNFQTBCVHNlaCtJRVBFKzRGdzVEaVRYSUZTWHc2b0g4UmRh?=
 =?utf-8?B?Unoxa1V1dU1ualVZYW5pejZMSlMrcmNvUFJ3dWlkc2g4RU0vUG9MdTlVWEVr?=
 =?utf-8?B?dEg3K0EwOFJZSE93U3hLVmRKZTFwSkZGRXJjamU0N09obWlZWXZXRjZKejlL?=
 =?utf-8?B?dnRjRGJRQ3liWGJwcE5zMGZoTFNSd0lGMjdVRWZjSlBTbmhsa0NEU2xTK2Yw?=
 =?utf-8?B?SFQyZXZWb2U1bFBCcGtwQ1YzRm9rY1NVVkJGMXh1OWl0ZXA2WTFOMTMrbEZa?=
 =?utf-8?B?bnhXck1PUlRqV1FObSs4QVhFbVNyYzh0UlRtUXhvYllIUkphajl2Qmhwclhp?=
 =?utf-8?B?Ny9oajN0b2t5c1JKclhkUzYzazZwK0lERjVOWm9mdGdtbTRwWFR3KzBaNlpY?=
 =?utf-8?B?MzU1Mnc0LzROUlp4OEhoTHltbHBKUk9JdXgzSVgvcmNqT2NQOWJDQ0htd29W?=
 =?utf-8?B?eWY4MWsvRkhPWnJKczBtdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjhKQTRVa25TaFBnQlZqK1hIdDJqZVN2RkFMNUh3eTkvWWFiR3ZzSjE3cTJn?=
 =?utf-8?B?R0s0QU5TcEkyL1J0Qmdlc2pCYU9PYTF3cHN1NGVwZG9tS2tJcThReThrdzhh?=
 =?utf-8?B?RUZwaFIzSXcyT2hFVGdKQW45dXBhTzUzeENoMmFJRVozMUMyT0hheklhVWN3?=
 =?utf-8?B?V0ZLWFNmWXRVVzY3UTEvYUxHM05IWXJrUnpmV2pmdVN1NXBkSWZvRHRLZUw3?=
 =?utf-8?B?TnRuelNiWmtSS3RweEF0TU1GV3paV01ObzRaMkNtZFptVWJLTFBaWDkxb3FT?=
 =?utf-8?B?Z1dnWTR5MzBLYnR1RG1BVDR6Z0g4YktQY001aGU4cnp1WEwrTCtkVmp3ODdq?=
 =?utf-8?B?VVZCb2F2aUNKYlZxbS9DdE1PNzUzTVFCZkNpeGg3cU1kWWVrK2R1NGpJcE52?=
 =?utf-8?B?UjcyWXJqQnlQU3VHNUE3c083UjJ0UXgzajFkRzM3ajhxNTJTRytpRlV2cUJ6?=
 =?utf-8?B?TEplVGs3YWNwYWpwT1lPblcyMHB6eXBxekJMbmxwZThFb0pXRHYxMUNZYlRB?=
 =?utf-8?B?OUVSb0VURTVHazYyd1JWQ3J1bFF5UmtWcjkwaEUrZnprb3UrWlc2QkpwcjBW?=
 =?utf-8?B?ek81V0xrV0M4SkNrRk55V0p6eDhqNE1XU0h1TlhZZFIxMWxTR2lnVHI0OFc5?=
 =?utf-8?B?ZmpRNTlBN2F5aGt0SHBmZVhyajB2aWtUQmFRd3lyY1NxMXZtQkZ4RmU0WE9h?=
 =?utf-8?B?bzhxOHl3ZDMxUWtZY3QvQjVLYXpCbzNXRDFwTDhmeVJLTHdQbUlsK1VRVmps?=
 =?utf-8?B?TXoybm1wWS96UTNZZUNTRExCRVh2OXhpWHNSYnRZdnJmOTlrZ0ZWSVVtb2Za?=
 =?utf-8?B?NEZOY0tUeU9xdk54N1k2RTZvamxCRHFib2hSc2FvWC9QWWt2bFNJL0hKQnhI?=
 =?utf-8?B?QnVUZ1RidkxMdTA0bFVGcXFlYmovS1RjT3lhNUZZeWNldkpDUGFiT2ZNclgz?=
 =?utf-8?B?MmMxR2k4K05odmIzbUsrc2ZQRFBqTHVEZ2d1M1ljM1BUSmE2YjIxSXdXT2ZY?=
 =?utf-8?B?TUQ2L01VNkYrM0tMdFM1aHMvRXFvQ2s5a3FJODdmQWM2V1gvbG1wek1ROGov?=
 =?utf-8?B?QmR6NEk2MzYrcit1U3hya3VCdXZKM3BKTVZKVnAvUFJnUUFPb2VPS3I0WCtp?=
 =?utf-8?B?MHNrTUFUWG1URGlNNkF0c0NySktnU2l2VUFzS24vSnc0cTBKL1NYYnBrN1ph?=
 =?utf-8?B?WEdDQWxORjFRMXpublRJMHNSemVKTU5MWkYrRytmYkJNaUVERDVnRUJLT2J2?=
 =?utf-8?B?Q2lBUy94b29CQzgrREpPblJHR0NMMk5JYkNUdnZIYlNGd0d4bzk0WjBiQVAr?=
 =?utf-8?B?NXh5NGJuWFZlOSs4YjFBeXVxcnlhTWdlcmxmZUMwS3hqTXRXZUkrd3I3YTV5?=
 =?utf-8?B?cWJvNTBSOHdwUkxIUVFZd2srMmltTHdCL3BFVm80MHB2ZmExcUJvelE1QVpM?=
 =?utf-8?B?Y2lkaXVnb2ZzN1VDREczVXZDbm12SjhrWVVMZisydVM5dVA1aEdSdFF4QzRP?=
 =?utf-8?B?SnBSamVNK3lnL2x2WDAyYkJVSlMrTTBYSmY5bmVhT2krTnorNUpMQUc2S1FM?=
 =?utf-8?B?NGxXcjNNaGhyaGtlZTBjVStlRGlSbjNJR3hEVVRqdzVEeWV0Nk1QcUFoeGdi?=
 =?utf-8?B?akNTYTZ1Zy8zd05tdXhIRWVzbFQybmV5VnlLZy9ueUZwd0M2c0hVRkJpYm0x?=
 =?utf-8?B?cXlMSlFwMGh3R3hJY2V1L0hRMms2c3QxTktYeVBBbExyb2toblBUbGlneklV?=
 =?utf-8?B?MkdJSDBnV0dMMldVU2wxWnIxWG0raGlpSnI2eWZGVUZJWHd3WG9YYm9IM2NX?=
 =?utf-8?B?Y1pxWVNGdE1JRWVFZUlyUTBOWExmWU1Sa1dLVU5hWnB6c1NwOHprZFNHOUxk?=
 =?utf-8?B?a0tnVVl6M1ZCYVIwZVdxeTUvMVpnUDh6QzBwWEF0SE5VRTczeUx5KzM2c1Mz?=
 =?utf-8?B?VldGdkJaMDJ3dWluUlltNWZmOEFCdW5adjg0aDVvQnhJZjgyMnZhRVp3TTV0?=
 =?utf-8?B?eVF0M09hanFoM3NSMlFjRmovRmcrRlcrd3I5UVlpSXB2dGhucEFZYkJmUlQy?=
 =?utf-8?B?d25sNUdVK0ZJOVJuK0RyRnBtRE13dy9XTmIrdklaZGNGcHlTYjJMZlZpOVVJ?=
 =?utf-8?B?L3hORnRmOGpaL3JRVXBTcGRaazFNQ3BPaExxaVFoaFUvWE9QbDZlUEtaY1FB?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256a9f32-2d7a-46be-3c88-08dca25a7ffe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 10:07:55.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTJBr0HtaogJrjptaV9ddxAz7ouBX9m/jCv7xjFKMz3dkPtWbZJz87z6MKlsOzvhWKsINQ8hJ624fbW9QIVtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 10:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16476

On 12.07.24 12:05, Koch, Stefan (DI PA DCP R&D 3) wrote:
> On Fri, 2024-07-12 at 11:30 +0200, Jan Kiszka wrote:
>> This does not explain what the impact of the missing executable was
>> so
>> far - or why it was not missed? And if it is a real fix, it should
>> come
>> first.
> Ok, too late. It's already fixed by
> 95e952569b59602dd05f4138de9602a5b0398f0a "fix: Add missing mountpoint
> to crypthook"

Err, that was fixed in May - you didn't rebase and test over current
next before sending...?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


