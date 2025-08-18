Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62ACA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:21:39 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.8])
 by mx.groups.io with SMTP id smtpd.web11.79880.1755534093312062168
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 09:21:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jtuZKIV5;
 spf=pass (domain: siemens.com, ip: 52.101.83.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqOY6D3P+8H5Y6vAno8IKMpQ+B2I1e2XEdQKrlhWhgBO5lI5tKKkc1WA3Q9MiRRAQC/2Yx2gZgqHnNL5IdZFpq0pNTph61PfuBfKbz0XpeaHQYta4G1YkKtaeYZM7BYZU7kGiGduGtC1hEa7uti9lLP4EsSnHbga/Wt9l3Vp1/wmeOIZ7NfHIDraE5oyo/8iu1PDqD0MBzs1APTKHNVcaV4WHJXI+XagojS9dnSTaLQdrmBxt8Lv4ym1sYsZqKYb8IiMjmquWW9TGE5SsHvXdre8glYCgV6zqIVYDNIGlHxF3ZetOvznLU+RDZxygAnu81hY7OddtmZOb0j8D8l8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDQcIDNmqZzuPltrGecAWXyfiF7/m5h8AfqXxNfWQEI=;
 b=qTMQ6PRtfYlpYhbB4zytpVx/E3vL258aIHnlMoWEbcEbQJasESqMUpcB2J7LeN0dU1krTJArsB1mWy6TOB5JJdwxmsgX+V5SaPNj8+N34IlQQdJqKpk81vLzgm8mBAl1Gd4LkPnhbjNmK8lg4nqSNYKmHo23m5cChA/oJKlinPODaWBnM/kn2Y2W2GSeE9SKNUOoQtTBNNphftZ6Ekz+CxfnwzC+0D8jqUP6PxLUEAlP3fpRWCpaoZzNRNkOeB/HjnysJmH+7ivGlEaeTcOBcPq1GPCXYnn3YXSURDjKIVNemvHATxXOOHhFFkSzINg7R1HKegS9DVtxRo7r4YxXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDQcIDNmqZzuPltrGecAWXyfiF7/m5h8AfqXxNfWQEI=;
 b=jtuZKIV5zFDBKV+3gjXLPxk0U8auDwWxjCO1iLZdWU8Z8s5pHPIjudFBKngn757qvwo9EXKmhoPD0pqXtg/MFK++O7TdDWMP0R3zd7k+p+7aYZcyw6TtYEMrHpX/MEI66LZhlhpfPbc4SmwnM3LMjBgZTl54iuVg5NN/srtZRz2R59T+jI7kUJwq237fBkNePKXkUDDNiAJDFvddAhxntwHTU4KiGT2YPlWGwX6mwMjNiXH0Cm2Zoqex3U52MV6+tIqaSJ0I6bPpTrq9+ocMJjEIWaIy03rOO3uY+MnbrezxyWZcss2dCiPhS9oSHZWE7TkA/AOjBMAMu/M/9L5b3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 16:21:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:21:29 +0000
Message-ID: <0f0da80b-7216-494c-8c7c-b5a1582a2350@siemens.com>
Date: Mon, 18 Aug 2025 18:21:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] README: Add links to the additional documentation
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: 676e8eea-0460-4d7d-be0b-08ddde734960
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dEhKOHo1SFdqTXdRaG1od3I1WTJtTVQrRHVXeWkrRzlBdzArTUQ3Z2ozYy9z?=
 =?utf-8?B?QlZOakdGQ1AyZHBtVlNTY0FOKzIrR05pbks3Ymt2dXNZVnIxNWVoT1VKMWtx?=
 =?utf-8?B?WVhNUnc2OWR5QnA1Ti8wdndWbE5XbXhYUmk0K1dncDRHYkZ0YmlhK2g2YThN?=
 =?utf-8?B?ZlFhMlVmZ3FVTGtyU2JtN2RCUVJFNFd0QS8vNFYzSmg1YXFSWGw3VHUvdUQ4?=
 =?utf-8?B?TkhTRHhPOVFic1F6ZDBLWkE3UjBIbUdPWGtiNWtqZDZ2bnBnOStZbExrb21l?=
 =?utf-8?B?WkdrUGxJRmc0TkRJYk94aGNxaHRGdUFRM3JiVVc0cTZ1a1BRS3gzQUVTV29X?=
 =?utf-8?B?aW03bVlOTFFzWjFUYTAwYi85K3FHT2F0MVEyN0xLc3RBV0UvWHJ3R2ZRc1Rz?=
 =?utf-8?B?VC91V1FSc2lVRk1raWdwYW1jN2U1YWkxajZLVUw5YzdjYytLUlczQ1I0MVR6?=
 =?utf-8?B?d2VJRklpbmdWdVpmZnV4R1d5LzZyL2dPb2JMdityWDdvQVJTbE1HbHR0S3k2?=
 =?utf-8?B?cDhDWk9sVWhxSHdOKzYwRXdINjN4bWxvaHBlYWVDL2FzUEp1cGhtOEpPM0hG?=
 =?utf-8?B?TmJ2UUxCV3U1YUhqQzloaVpOWGQvdXVUQTZzUEdJbndlS0M1SUErS2Z3QW85?=
 =?utf-8?B?RFcxSXp3MkErenFZRTR0eGRDSG9hWDJvaUYvbkZaWmRqMXdnbHpVYkQxYUYy?=
 =?utf-8?B?dUZtY3NEZC96OEhFcjZ2dlVIMkEya0dNcEJhNGE4V1VEVUVjejJOcklNTTlz?=
 =?utf-8?B?UHBucVJ1YUIyMnlnREJKVWZRa0FUTTJwTExRdW5KZVZHNDVIWGJRUXNSbTlT?=
 =?utf-8?B?NlFoSjRobHFtc2xLd2hlOEtrbDlidDkxcDBUTTY3QzViNWNsUDRzOEozd3Fq?=
 =?utf-8?B?U3hRQm1SWTdKcG54RzdWTDdpQWlrZWpHSWpVV2RSTGdjRCtSa2RIaVdPWHVl?=
 =?utf-8?B?T3FXejVOYzdyUVFwTjQ0Z2NULzRjTHVmYjdwNERrUnRaTHNtaGo3RklSYWZS?=
 =?utf-8?B?ci9JNUVMZmRZNDc1Z0NIZGJweXpjMGUwQURKNjk0c2lXTkl2a3I0VGVnM2pP?=
 =?utf-8?B?SWtVcUhqMURybVk5ZFNPMEhML2t2cThnVmdGb0ZTQmNXWGJwNm5VbnN3c2hq?=
 =?utf-8?B?cFYrd3IxQnAvWnZzbnArOXMvK3RQTlV3TXFuWDR2akF3VmhLQ0NKSXZ2WHlw?=
 =?utf-8?B?bWI1bXYwZjkxOHFaNllwa25sUlRKb0tXVXRaYzVXZWMyM0Jqb0V6dE42Z1U5?=
 =?utf-8?B?S1F3dDNqd0ttMkRwRjNpVnJKc1dEZjNmU2N4dS9kd0xCRWNsRFRpOTQwZEVX?=
 =?utf-8?B?Tjc1cVdkc1Q3RjVrTm5BR1RRWUZFNWNjSnNMOXpTS3Y3UW0weDR4ZGVtZVRB?=
 =?utf-8?B?elg1VzAraGJQSXBablJWcC92ckk2Qk1IcXZVYlJlYm1rY0NoVDNiWGIrRy9n?=
 =?utf-8?B?V1E0RDZrMVJIdi9MR0JiRGVHWEFac3VJdTh6eWtRa2pWQ3d1TVVNY1RYcldE?=
 =?utf-8?B?WngzNUMvRUZNNHV1R0U4VnBCcGsyZnVEMURaRVlOdjd6bWhxVjh1Zk0vUUl5?=
 =?utf-8?B?SzUwUTdqcHJleEMxMFh5RGxYaVhWdC9rMVhUemNWb1pYN3JaMGtka08zelEv?=
 =?utf-8?B?b1ltRnVnU0E2UzMxNVFxeWVWVXArUzRlV1MrREN0Q21CZ21qRGZRTno1cys0?=
 =?utf-8?B?azRTY0R1SUNKVE9DenRDUEN4NXI1dCtlUjljMG90dmhxcVByT0FoQWxXYlB3?=
 =?utf-8?B?a0hKOXdqb0Z0dkxwQ2ZSVmVrNUFQYWFvNTRJR2t4b0dSbGppU1RkV0x0UlpE?=
 =?utf-8?B?QkFQRkwwUlI2cnA1YnI4Q0RuTllhK3ZiYlNNV2haSytPd3VpREhlNlBWbGRr?=
 =?utf-8?B?M2huYjRsL2U4V0YyY2YwT3d3QUt3dlkzZWpjem4yU1Mrc3RTNDEzNEhpWVBi?=
 =?utf-8?Q?qCmspGx7SA8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWxiRDNMY2hZeTVjTFZLaEc3NC80MUliVWR5c2x5eFp5SFFPVVJraUcwajZG?=
 =?utf-8?B?RUttY2xGcXpSTGlGVXl1M2RPVDVqZGowOGgzemN2OVl0MFpDcHBvTi9zSmxj?=
 =?utf-8?B?MWhmRmJ0RWx2YkNRM2dDK1c1SEl0dWlaRE11ckdyV3JKWS9TclRYbDRPZkl2?=
 =?utf-8?B?ZVJ1M05PelQ5aTlIVythcDljdFdBdTBlOENvUVhHRURnRThkdndpYVBXSmpJ?=
 =?utf-8?B?djRVQVJLTjRIUTBlaTZFV1VsZEZOSWM1RDM2NytMb2xmM1FsdmhDWVIrVk1t?=
 =?utf-8?B?ZTVYNUowVTIvOE5keDZHRlpOb3hxMlhlKzdVQ2s4bEU5aEJqTzhpaFk1U0RK?=
 =?utf-8?B?S2JIcmVZTFU0dTRIc1htdWRMU1lXUU1PdkVZdU9PdXUyMmhUUnZ1SUZJYloz?=
 =?utf-8?B?VDIyaSt0SS8zWHZJRzVDeFhSMyt3T3lEVXcxM3l2NG9XZWo1aGJTLzQvUnk4?=
 =?utf-8?B?TTR2aEVMZnNuWVQwY3Fhb1RkWTNVTVRLaTMrd0RRVVRqZW10VE0wYnhMTGsv?=
 =?utf-8?B?WEk4bFVMdVFHTU1IMDNQVWJCZjFNUC9OdzFadDMvTmNrR0N1MGhDWmc4L1Rh?=
 =?utf-8?B?NkFzZXRQbVQ3R1czVVBrM2VRWTJoMjBiU25aazFuRlNOaDNiemJFWDlwMGVX?=
 =?utf-8?B?cDVNSkdFL2c3NWE3RGp2MFNmYkRJeE5yWGwzd1VaQnlURjF0ekFoSnN1eUFx?=
 =?utf-8?B?WFZzSlhZVXhUVDZQNldBUzRYR24yeTBWL3BYV1hGRWJvQjlyeGpTNEFieXQr?=
 =?utf-8?B?SlBlWGtpWmNlRjhDTE10V2JkOXo2Y0I0azIzNDdIaU9URGdoU1ZsRm93anNa?=
 =?utf-8?B?NVVsckRLRzVqMUZ1WHdUT1VUUU5EZjdzWEFja1h2ZkhSSkJMZzF6Q09LS0sw?=
 =?utf-8?B?NDVZZnpRV0VEc0tudDBjNEZpT3RSLzkzT25pU2Jxd3Y4M2wwUzlVamw5dnV3?=
 =?utf-8?B?SlJSVGU1d05kVDcvb0NNOWdqU3laOFQ3aWhKNmF1WFhWSE51MThuOHlhNnlI?=
 =?utf-8?B?R09ZMHdDS3Zyank5ZldYS2g3VkJPRnJVU2k1RmRIWXM3TG05U1NyRURhN1g2?=
 =?utf-8?B?OW5rdXVIRUlrVHNmREMvL3YwNnZiMSt3dVNKSm9ZUU8vbGlyN3N1Zlh4NzBF?=
 =?utf-8?B?dDFrVlU2NkljWGMvdG1QTERpVHpsMUt6Q1AzRVJWZEFLZlNzUWs1RVNReUNj?=
 =?utf-8?B?a3ExOG0xNnVPdmZqUmMyeFhRWHAxZi9JVzZxVHF3b2lYSzJSYlpMaThmL0hq?=
 =?utf-8?B?aXpRRE54enVyVSszSE80Z3FaYmxCckprSVhvTTJaNTJvOWdPTTFnSUpLVkJL?=
 =?utf-8?B?cVV3MlVEWnNnanRjVGl0NlpWeUlrS3R1eWU0a1dsU1UzYk1MeHJqY0RuUE9k?=
 =?utf-8?B?MHpEMVVWMWs1L0RxTjdMelcwS0JmMGdqQ0x4N1BLZlZ2ZWNHbzhjQXFUMWsw?=
 =?utf-8?B?dWptNGFYbDMrSEQ4WEFpMHU2bDNtcWJkRlhUdDl1TU16bG0yMmFhTDZ6OXY5?=
 =?utf-8?B?NUszWXhReVlFTVNtUS94QytobWVROHNJcG5tRDIyU0o5ZHpUZkJ5bU90S3pa?=
 =?utf-8?B?TWcrc2xUYVA3VnRZdjJaZGlFbCtFd0J6bVJQaHZnK0Q4b1NjUUNCd3IxTWJC?=
 =?utf-8?B?L1hIbjNQUnRtQWdVOFo3SWRoT3dibmlVc3NZNFhrbFBKTjkrMWxMZm9vYlpm?=
 =?utf-8?B?SXVpUzhMa1dHaHRIMFJGUGlOUE5jRGhCbDEvcm9DWFRnVmVRcnJEYWtDc3U0?=
 =?utf-8?B?RFNJWGU2a3Y1Q2F4YXB4WGlkV1AyZkQ5YmhIdUMyVVExMHlvWTM0eFBWY0pZ?=
 =?utf-8?B?eFdVamNVbHlKOC9PQU1JVENIQVlKVWNiakRSY0Y5VEh0OUUyQUcxV01ZZFVv?=
 =?utf-8?B?b0xTZ1NwbDNkb0svOEozVlZSc0lsRTBKd3hNZ0s4aGRoSzhCL3lOTy84dHNw?=
 =?utf-8?B?Um1hS3lFWVRvUFRBaTZwTlVFU3lpZ0pBSmUyRDNPUHllc2VvOFRUWk45SGtP?=
 =?utf-8?B?QUU2eTlmUkF1MHhweVlhM3FheVNnbzcyR3V2ZVA5aG53ZVA2ODhCL2pvZ0w3?=
 =?utf-8?B?amd5cHNtVXhYemFndXdBcXF5d2lUeUdQenpCbDVla2dzb2VYWVV0L1Mwcm1Y?=
 =?utf-8?B?amFpcTNZb1NLc25LU1FsOGUrWnNYSnlldTQzT3ltMVZWaTZBdEtwdk9PYnQ5?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676e8eea-0460-4d7d-be0b-08ddde734960
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:21:29.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQf80ODKhGFayx1ckzc3e5zC7X2tctubj/52jceJiAslMECRjOAU30F2mkTmEfcddmxIvLA9PzJmHgWyOei5xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 16:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19757

On 13.08.25 12:13, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> We have some important documents in the doc folder.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  README.md | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/README.md b/README.md
> index b2eb9d0..fa1c437 100644
> --- a/README.md
> +++ b/README.md
> @@ -52,6 +52,14 @@ or via bmap-tools
>  
>      bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic /dev/<medium-device>
>  
> +## Documentation
> +
> +The following topics are in a separate READMEs:
> + - [Secureboot](./doc/README.secureboot.md)
> + - [Update process with SWUpdate](./doc/README.swupdate.md)
> + - [Update and Secure boot signing](./doc/README.signing.md)
> + - [Encryption with TPM2](./doc/README.tpm2.encryption.md)
> + - [Release policy](./doc/README_version-release-policy.md)
>  
>  ## Community Resources
>  
> @@ -73,7 +81,7 @@ Continuous integration:
>  
>  Please see [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution process.
>  
> - 
> +
>  ## License
>  
>  Unless otherwise stated in the respective file, files in this layer are

Thanks, applied this one already.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

