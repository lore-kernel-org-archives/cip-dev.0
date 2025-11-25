Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BABCFD364
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 07:07:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11905.1764054420142388095
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 23:07:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NgvBNn7K;
 spf=pass (domain: siemens.com, ip: 52.101.70.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1u4QMrQHBKOYWlZ5JIJVtXXfxm7TBit16gMjAc/HBHb00n/8F9G5R7rX3hM6nnKAh5lqxqlOrGIvrLupEQOTxmRVkURHYZts7uyfY8dhybbB56FBysjYOcWY8psjAkUYiDR1B3Te+mkbbWnQtiOIRzViXyh5zCZqjVILMNJbax0JBQmLKfTlVZDE3REdHBHbu5ADu9Aa3a36K9Q6aQ1GLLHEjIANz2ootp3JMceZR0IcA3CAva3Uq6XTe7snUxsoDhUMyIzjMmQo4UCSvDpbTw7CR3Wc1o9dVrgbB5Ofh/W2OD+N3ccGxUC71UzdUsutPhmOyCLXV3BESNKmJxr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mOBZI69cUcSDs1O1zZQGbZTWZsygDtuAbjyGJGfy0U=;
 b=uCqYKjhTw/RwC4hiLi9bQh6fBglK80o60dCixHv649HwURtdSAX96xeVH9rfFUotXu+bfzFgceOwBkStbEmRxh82hn8KFhVvoB8SbQ6ntXF9uqlm0JgwWU3tgDw+I9CXxxZn7J3lsx0LRK2+uDTsvW9qHPjyU7bNzAyXff3L5P0WGXXfF83f4PUkYb0Bc0HskWOv/BfI12F1WYZVWHXAuQkQbRHC6f+4qLkjxv+yyMXqrRzRHYSkx647egZitNnfLzNS0KUmv+aUEjtgcxV9g2ZMBVHNLtWyur3adtqr7BmqCfjBfshPvCAwcQAVTEznsVkbtGVFWVdyuzySA+H7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mOBZI69cUcSDs1O1zZQGbZTWZsygDtuAbjyGJGfy0U=;
 b=NgvBNn7KMX96bckRnuiHcw0IwnM4JOpqNepdlMInDoi6ISOCt6FWxN6sqt6OuNRMBmk8snnzgb5vlid336faKIGObrh67x01xmH25PDzluOF91BGmm0PEUP5nZeiprxCuRkyz19NZsncowxq11bgt6DLrKQv/XCOJQciHeBRvliuJg28H1fmfPUL26abTQfnH1HZU+cJP131aEhlHGLIKKgoIOW7wSJtFYs0ltChaCTmbxwekGeldkJS085TFkSxoGh23/mvYnMyXfsfBfpNRAR5XuqqNoot1Y+tPUmQxz2fnmCcI4SbNqoGtADIC7xS6FcU4iVshIi4ly6bdtgV8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 07:06:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 07:06:56 +0000
Message-ID: <4bf12cf7-4997-487e-97c4-cca5220e1322@siemens.com>
Date: Tue, 25 Nov 2025 08:06:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] Add factory-reset-helper to security
 image as well
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251125040754.1006136-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251125040754.1006136-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: a4040c5b-540f-428a-70e4-08de2bf137f9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cGE2ak9zR21IZjd0ZXVRbStuQ0xndlRja0I4MU90dHUydzg3aHh1SnlyWnNn?=
 =?utf-8?B?SlpEZllaT2F1V3kzL2lSb2ZSWG1WaHkrSFpiUkdUV1R2R3lReFpoL21PNmQy?=
 =?utf-8?B?R2RyenhIdm9jK2V1UkFMb3Q3SjBwaTYyTmxlVXM4cHpNcFBLa3A5NGpLQklZ?=
 =?utf-8?B?MVVrMzA4ZG1ZNkdVNytqVTNIWnFPZlQrSUEyM2QweTBYTGVvZ2k3NDJhVTdP?=
 =?utf-8?B?U3RxUlN6RHlLdkZNTVlWdU9uSmJUamxtL1RlWXErYi9iYmRCQ3cxeFhPdjRC?=
 =?utf-8?B?RTBURWZ1cWN0M0ZGWktFd1VPWTkxV3pmQ0ttWUR5SnFLRDExbFArdVpzWDZC?=
 =?utf-8?B?azYzRnloc2dIRUlTcnRtV3QrMGNQSFBMeWtWSUdOc3dacGFadnNLcXVBRXpD?=
 =?utf-8?B?Ri9HUU1CWEZGMDZxWTU3S1FWbkNPZGVGeTZncjY3SUE4K0hoSmJrSGNyRUZS?=
 =?utf-8?B?RlBlLzFCWXVxZy9pOGo2Mmk5Qy85TEhPa3kyaC82MElsbXVwZlo5ajFuQk1u?=
 =?utf-8?B?UG1ROTJmNml5R2lTS1VBOHhTdXNxaHhMRHRTYUYva2NFMTMvamR4dnd1SW9D?=
 =?utf-8?B?cE5mdTFlcFNmb00vemd1am9ZSzZwM1I4UE5XWGd0cy9jWjdlOHpEZitmdzBR?=
 =?utf-8?B?RmZuN3pEaG9rajM1cVpVWG1HNmk2YVZudWNzcEFZMWlxWkVlTmpON2NvaUxL?=
 =?utf-8?B?aUxxdUxCR2pMMlBSM2pFV20xSS9yTHdqWDJNa2RjaFYzUy9yVjc1K2NtL0JG?=
 =?utf-8?B?ejF1SENWTDhsMTJKTE1XbFE4ekx2ZGlmN3pFZHdBU3gzSkdpMVlpUVpsY2Er?=
 =?utf-8?B?dmVsa3cyanVuVlFpZzNLaHBld3Q0cUpFKy92TW9TUWJXeTIxeFQ4M204c3lJ?=
 =?utf-8?B?REUyUzlPQWUzS2pKaVVRc0tOdmIzenJ0ZUt5UE1Mdk5xSVhzcmtzN0k0Nm02?=
 =?utf-8?B?T2JCdTdhMDRDbzhnUjNhN1ByVDBLZlpBZzlLRXd2NHpQWnpObVAwaWxsU0xN?=
 =?utf-8?B?SkxISTRxcW5pRnpCdEJwYVAvQW8wVVdCTzhVVU9nZFBBMnhyR3ZpU25WVTVS?=
 =?utf-8?B?Yk1TMVNoS3RZTGJZTVNCU011UkZZM1FQUC9sTHFVTTMyUC9HbXFsTFhkdk9B?=
 =?utf-8?B?cnNnVXBpN2JudXNMVWtpNE5aVDcwVkxPYllEc21UYU5qRlFCWGVydS9CNlVt?=
 =?utf-8?B?ejRabVhwSTJhWDc0M1Z3bFh4TUJ0UHFFU0dIL3JwT1pGQkU4WXB5S3VTeEtk?=
 =?utf-8?B?ZUVUN0tHUDJYOEJiMmZGbVlrSlpseGgzVmYvTk16MVhTUGEvbGVtY0o4L3pX?=
 =?utf-8?B?UEZtN0I4Rm00YUExdHlnYitFcWN0OG9pbmVKbndxRlExWVp3bndSK3VxRlF1?=
 =?utf-8?B?T2t1emRiNGR5RUpwT0ZsMDJDTk9abFV2aXJYOUlFckw2OWIzeWlQdGNjL0dw?=
 =?utf-8?B?emRYd3A3WEhXY09HUExIazlOdlAveVkzQjNqVmxDUm1halVTNXRQS2w2bTRt?=
 =?utf-8?B?V3dKWjBtajQrdzl1a1JndGJ1MTI0RFVQZWFESG82cVUvbDNKaVBHZmcyZkJt?=
 =?utf-8?B?Q2lRR3dKMk50eHdtcXkzbHVuZVR2ZmtoUXliSnlMVEFrNzZPcVB5VlBZYnp1?=
 =?utf-8?B?WXBScXJzelBwT3Z0eUVnQWRXTmhjdnJoQzRmeVFqdG8vUUdHOXlXWVNpNjBJ?=
 =?utf-8?B?Z2RPTGp3WkpmbU9UUFNzRzNkc3RsbkVqOEpnZEhPSXJaUXRlU05yRHNSSFBB?=
 =?utf-8?B?RmhFZjRTSXVRVHdKUmV4bUdtb3pmQ2ZxSDdicEtRRkNNa0lCdkJ4M1ZGdmZl?=
 =?utf-8?B?NVExMFFpSllzZmU3aHZYNUNTNm9hRS9qekdaTjI2Vk1PTFlUa3AwaGlXRUd6?=
 =?utf-8?B?MXRQdmdpWG4rd3QxWWlQQUNoQXZaOVBRcEFDZFdPYzV3YnNGZDNUbVhiZFdB?=
 =?utf-8?Q?tvudaEspl58Xcthshw+8JJG6/ErpEpxW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0JuazJMa2t2NythN0N5NUhpRHVSYVRpUUZ2UG4xSWgxZy9VZ2t4NlhQaXpp?=
 =?utf-8?B?TlM2TEJoaEdZTWxzZzBHYjJ6cGE0V21CWEFtc0N4NHRkV2JoalhLMGFaaG94?=
 =?utf-8?B?ek5NTFF5TmhMd1lEU0RLSmFZRVlUbnQ5T3dzM1hCRVQvWnZpcjYzd1dCMC9J?=
 =?utf-8?B?a0xETzgxT2ZpazJGaDBwaC9WMzZGcTVTb2pzRUZwbHpEemIwcng1R08rdDBJ?=
 =?utf-8?B?ZzIzd0N1LzRTdjZJa3NhSWMxY3N1VzA0K3ZtMzlqM1l3c1Y0MHlud1YvSHFD?=
 =?utf-8?B?aFNyQ1VyeWlPemVKVXBpYVdSMzFxZzUrcUp2d0lIUEx4emVWcE5JTTlFeFEz?=
 =?utf-8?B?emcwMlcyNXVJTjdmS3VSaHZJOGsrR0VMRTkzd3FWMDhLOW82VDRwZHNIdkNY?=
 =?utf-8?B?RXQyeGN3K1dCTTY0T28wdi83NXVqL3hDNEd0djU3dG1aZEt1MnpFSXFabVhO?=
 =?utf-8?B?K0xuMTEwaUFBUVpDU2ZaYzRJY1NzOUtpMmxXSWtZR00wSVA0V2tYckJLem1K?=
 =?utf-8?B?SW84ZEhnYWxDNGxVVVNCRlg0MEZFNmVXTkhEL3dZWGlldTlVY01YbjI4eC9t?=
 =?utf-8?B?RDc4bkF6UlZIdWJpMDY0SUhPKzFWRWdjT0pOeXl4aFVsb0s1VlBPK3Y4ODhJ?=
 =?utf-8?B?Z1FFUkt6VjQvTk00MVJuSEx3Q3NLV1FsRGhXWjVSdkZLSHZ6TUdUaEVZTVQw?=
 =?utf-8?B?b1owK2prYXVoV0J0cHFPVzljSURXU2hPdnkxNkhLeTdpUEpTaExGem8vL1Z2?=
 =?utf-8?B?d09RTlVnS2UwRmEwRnJUQzRKcDFoZDN6aGVadmZMR3NjK2dzNVphNC9BSmZu?=
 =?utf-8?B?L3VHR3B2cnhwTGJDd2Y0eGlkb0djWnV6SmJKa2JxZS9CQTlEOW1HSUxrTmMx?=
 =?utf-8?B?NllwM212SVNFbHFEUE1QMVBlby81Q1pVRnNScHQ1QS9NUXA1N1FGNlVLa1Ex?=
 =?utf-8?B?R1VTenpGT0FNYmZyUW1zTFB4RGpRV0YyT05nWWVmTDVGRFJsSUFhd1laV29Y?=
 =?utf-8?B?cDVvZUw5Y2JCZEh0aGRTU09rNUNvdUNYVUpnWFBpcmJXRERBYUthSXVUemFP?=
 =?utf-8?B?QkZFWGUvZy9GTllkWTNjRUZLVVVybTY0QjNuQWJqalNRY0dJMlNMbTN5Lyth?=
 =?utf-8?B?TjlGajRoTFpRczRqalpZNHFyK2FSamNGaUxGS0tCYXk1VWN2RjdFZldjUjF1?=
 =?utf-8?B?V2g2Z3JIdkRpRmJGekoraFJwMWFqaVBHTHd0QUFsMEVTaEV0ZlRKTzN6VkIw?=
 =?utf-8?B?ZXZwb0tTUWpUeTR1RXZIdFpIK1QxT282NU5xY1JaLzJneCtIeUpod3RoZDhD?=
 =?utf-8?B?bHBXa1lMaHdYdjFKSXBjaGtuV1JmRjJpc3NndU5qa1ROYytwSGpMVkMrS1cw?=
 =?utf-8?B?eHZPZk53WWRlbTJDQzcrdWhUUll4YlFicnRXWDZ4MU9tTDd0NVhsS0dhNjV5?=
 =?utf-8?B?QzZodUtmU0pUb1lFbkxDcFJFUjR0L1B3VE5DcDVROEoyWGxEUVJma0ZibnRB?=
 =?utf-8?B?bi9qN3ZEMHpsbUdVQUZRRjlZWFRndk1FVWE0bHN2ekhSY0FCUWRBT1pEZ2Nn?=
 =?utf-8?B?RVR6OHRIZnVqU3lsV2EwVVN1RmoyaDhjSUp5V2RQeHd5SHo3am9OWUZ0bjAr?=
 =?utf-8?B?MkJTaHZjTEhSZWxmZFROSkx0dWJEYTNNTk1pQmNVb2dBNjNGMy85TDFYTkpm?=
 =?utf-8?B?Q0QwUW1xekhhUlZFTHdmT0hRbzZtbnhZeVFoMThQUlc1Z1QzWENCaDh5VDFX?=
 =?utf-8?B?dlZNU3FuMHNoSU5rc3RCK3pZTEd2SnNjZDNpZkJCNEJiU2k1TGxyMXJpOGcw?=
 =?utf-8?B?SWRFdzM4UWRVRXpLcWpFY1h3Z1hTQkZvKzJ1ZFVXREo2MWg4R21xaVcxeHZm?=
 =?utf-8?B?am8zcFdoeU9tK3NyT0xqRHRsaTVzV3RPWmxvcll1RnZjbGJHdWxmZFZ1dlFz?=
 =?utf-8?B?dTM1L0hacWFyNGZpdThXOHJCbER6VmYrbk5rWG5IWFRWSDU2VlpDRFJ1MWh4?=
 =?utf-8?B?VDNzTWM3NkEyaTRYYUZLdDVEK3lxWU5LczBNcWFVbmxmb2ZtaGx4V3VJa1BU?=
 =?utf-8?B?YVJucHVjOUVxczBPcnp3SkVjam1oUzBwR0Z0YnZ1clM3RnloUlcxQXZaVE5y?=
 =?utf-8?B?ZEdlZlVnVSt0cEVnaE9NSXhJWHVsdE5NQ3NxdTd0MFpPaVVocFljODk5Ry85?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4040c5b-540f-428a-70e4-08de2bf137f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:06:56.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vjh9dujAKf7lbtQ2f4SrW30edi+w4LbE6lVMNP8HY/hkD8SwdTTmwwZmSYgvHFodeenjKSFc1TpwtLfMvcfdlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6506
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 07:07:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20722

On 25.11.25 05:07, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Currently, the factory-reset-helper package is conditionally appended to
> IMAGE_INSTALL only in cip-core-image.bb
> 
> But the security image uses cip-core-image-security.bb as the top-level
> image recipe and therefore does not include the factory-reset-helper package.
> 
> Let's move appending factory-reset-helper to IMAGE_INSTALL to a common place
> so that its also available to the security image.
> 

Patch looks fine, but I rephrased it a bit while merging because you
conceptually make this feature available to all images, means kernelci
as well.

> Closes #141
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image.bb  | 2 --
>  recipes-core/images/cip-core-image.inc | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> index 52dd180..4a9cea9 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -15,7 +15,5 @@ DESCRIPTION = "CIP Core image"
>  
>  IMAGE_INSTALL += "customizations"
>  
> -IMAGE_INSTALL:append:factory-reset = "factory-reset-helper"
> -
>  CIP_IMAGE_OPTIONS ?= ""
>  require ${CIP_IMAGE_OPTIONS}
> diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/cip-core-image.inc
> index 7b0f7b0..f6162cd 100644
> --- a/recipes-core/images/cip-core-image.inc
> +++ b/recipes-core/images/cip-core-image.inc
> @@ -11,4 +11,6 @@
>  
>  inherit image
>  
> +IMAGE_INSTALL:append:factory-reset = "factory-reset-helper"
> +
>  ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"

Thanks, applied with tuned message.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

