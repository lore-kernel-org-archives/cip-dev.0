Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5199BD2CE17
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 08:32:11 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10972.1765355529239327639
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 00:32:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z1Gpl3Ax;
 spf=pass (domain: siemens.com, ip: 40.107.162.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD7QXb3wioxBQGJgXDbDO1lnC1vB1HQS8aD+XO/O3xCq2rxLJfftL0B35XqFtdSV6aJ5EVXMCr3/S5XvUlSLL4goV68wLvnJ1GOM5Yy3v1WI2RBPLnceycL25IEphwp37wLFgvdBfqrsc4Hez6BxSrolY4VMWxuo1NUisdtjAF0byRtXYGy63qvkWpOXB8aGDBBGx4qFCWTmu1IQ2GCNU01cGD/dVbCCgqGIH9vGaZQRvaQsDtJsrPRXo+ONDl2D+38+cScxX3BJoR5dYMwUFOnRvdJEilUjQmNEEgP2ivmY1Br0SvVdKicPQomdzj5Z7nMtLaF2qIsi3oGuONB5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbKNliltsoycDA9g029rHevTUtqZyixoJukUqflYmNk=;
 b=LVp4O5OTgv0Jw+8vAct5ikECyzOiK1n6bYm0oBdhvPnQI1k69aIRB34AbROAjnTKgVnfNsnFboio3/Ttzbfrhgfehe+k+WO5OTZsK7/OST2G8dPhvQIVW64mn1hJFQYuEy+isg8c+ED4cw63Zb3JD6czCmiiFLOtxy28v2ao3ZInn28KTHx05Ype8XMouxgc01MAvB/6bJU8Ty3WfGUwcWGF3YB86kcEKnpOZe0UNWlIk5cV6DDszzr+Q2JWhfdp3I2E+wNtNr5D5eiZWLAYzYFucHF1yatNsIp2x3jPJpC2O0eZr7q3I7g9zACbiKYE+j3dlrZQUcshrtMJq5TXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbKNliltsoycDA9g029rHevTUtqZyixoJukUqflYmNk=;
 b=Z1Gpl3Ax9X2cGhrX7D+XTOHdaRPijX6Zj7ly1gNChXcsJf8/YaHsTSOluYV33jEiLoD4FiY0n2HcFUE1wkfWYNX49dsQ0/GECWIxN680/ZCXhzBYY0HskoVxeEC7AHgW+jGlvJPZcfVUzozI5OYxP78rKBQ0MSIeZA2Gar2oKtsaz2SVqWwHzdRALG4o0K7EQ4OyEw3igtbhFoyC3hN2IUICQBlIdEtE+26U6D06IuG+l2B/hoL6dfb6PShlvdk+SXzsWmR2Sq2+k/ZOTlaGHBSoPOt48tseJW/dll9Y4tQTK8dSwnHwoN5GkO02IU2Agx9qpZU2+IH9ZHeZuvDz9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3599.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 08:32:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 08:32:03 +0000
Message-ID: <144ed054-f15e-463c-9518-feaf9dcbe55d@siemens.com>
Date: Wed, 10 Dec 2025 09:32:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] .gitlab-ci.yml: Enable deployment for
 qemu-amd64-bookworm
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251208045141.4092733-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251208045141.4092733-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3599:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef865c8-f988-4cd2-5b6d-08de37c698ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2NxN3YxMzVyN25ZZHo2cmhtWHdrdzRiNW5RMTJPYnpaaWJ6YTRSeXQyb2Ux?=
 =?utf-8?B?UlJzTmd3RWJGWDZRaTVjVnhWc29nMkQ1Qkd4S3dIRVZjVUtmanU2Yy9PeHN3?=
 =?utf-8?B?OVNyblZtTTNNT2htMzZCV1Y4eEg0dDB5S1I0Q0NDNnZZbVNjQVRJdlRDOFBm?=
 =?utf-8?B?b3NiaW9QeHVVeE9aMHhmT2duMzhZdThROHUxUnBXcUtyVHBzdjh6QXpUT0pa?=
 =?utf-8?B?Y0JKYjkzWEdZVjF6elhMRVNkN0FOdnc1ZGgxOWpFWk0vZUNWNS8rMjNOR1NT?=
 =?utf-8?B?WGtEUC9JYnlRYXowZHB5aiszL0laUnpNSCtFY3BpQkt3cGlRWXVkcTl2c3I1?=
 =?utf-8?B?RVg1SWVDZDFoTVJEaFN4b0RtdXlzK1BOYTgyNVd1NUhaT1NaZEZBTndrbnhn?=
 =?utf-8?B?ZFp5QVRrbFJ3SytTQXdSNUpxUXliS2J1c2FVdmdScmdaZW9OQkdSSG1wQkgx?=
 =?utf-8?B?M1RuNVNhRzVZcUliVUdacnJ2RXpYMmZ0Qm5iRVJpL2JMQ2VLUFRtOVdiSVgv?=
 =?utf-8?B?U0dOaWxJQjd6VmZmT3RRVlkxdlBSWmtKV2MzRk01TzVYbEpEdDhXTUdiMnhn?=
 =?utf-8?B?dHM4NkZBK09zbnU4NzU1R2k0dE92bkE1cndBWCtKWVFIQlhneE5zazZIa0lC?=
 =?utf-8?B?Yk9BWGVNRkpRUHplYjI5WEh0cFh5WVNLZGd4RTl2MUtUMFY2K05IK1VJckxt?=
 =?utf-8?B?Rmtrajd0WjVKUVlhODhKRjVQakpEa2tIL0V5Z1diVG5XNjV6OVRSN3g1aHNL?=
 =?utf-8?B?Y3VJS3pJS0Z4akJ1dnNHOGFaMzY5dE54c3ZEUnZBVjZuYVVpRU9DQmdPL2Fw?=
 =?utf-8?B?VTZJQmpXWkNEa2k1bE4zcncwZG9LdDFhMW8zcFU5aEtnK3NvbXNqVzhrZnNS?=
 =?utf-8?B?ZmNodmlKeTZXMy8zeUdvK1FVTnpGc3dNcWMwNkx3QVB5b3VhakhwY3hkK2Ir?=
 =?utf-8?B?QUxoSVkxVU9idjV5UmlYUHVacnJhbnY1K1RNdTNtZGNKZWxGTEpzUHpxTEV6?=
 =?utf-8?B?Yi81RE1QSFVvN2sxQXYybnpZYXJTUEg2OGdPdGFjTklHUzRCVzdnbU9RazEv?=
 =?utf-8?B?MHdBTUprQ2xCS2cxaEtIbmFtTFlSa3dsT0d1OUxnYTFhejdpdE1PTjd1TzhX?=
 =?utf-8?B?UVoxOVdsdnFBV3hVcmJFZkFCc09kc1ZDWGlzVitVcWtPOFV4NWNmTklwUEsx?=
 =?utf-8?B?OG9WTEtJYlQ5b2Fvd2V4c3M2bmtUcHlsWFJnUGZwdytCczZoSlhpSWlpR0FH?=
 =?utf-8?B?K2JkR0pGS2dXUTZCVS81QjRNVHFYTEpWQ3cwV3Brbi9QZmxDaGp2c3lmUmQ3?=
 =?utf-8?B?bUdaVXV5eFpobURZbTRtT0RLdkVFNTh0bHJJWEd3dnlTRHdyZk45bmpyeTgz?=
 =?utf-8?B?bmFHZzNCVmJtZVVBM1U4OUwvQ3VtZDFLRXNCa2xEVFkzdmhPTWt5Z0tRQUIy?=
 =?utf-8?B?UHpNemZZMkQ2OEJ5WDN5cDBNSWdvTUs1T0tRZm9CVEpLNm9kYlZXK0dBTXl4?=
 =?utf-8?B?SUFxUUsvTlRYZk93TnBKVy9VRnJKK3ovbjk3S1M1YTNRZWlTK0hGQlhUMXgv?=
 =?utf-8?B?L0pJa0JLRGc0M3d5N0RDZmVvelFYN0VJWXlsNS9DNk9XYTZTQjlsVDRnT1Q3?=
 =?utf-8?B?L3RyaVluTThYVG44TUsrcjNzTEtpUDJScFN3UDkwL1JxNkUzWXdUOXBKSDVK?=
 =?utf-8?B?ZnMwNVJiS05XNkM2QWQ2SUFSNXhaaDVkWE5BajhLb3dEOFZvaTBpUE42Lyt3?=
 =?utf-8?B?THQyV1RHY2dVMWhIRG84WjJXUDRwcTRNTkU2b1QyQ2tTMjIwbEg0QjlIdnBp?=
 =?utf-8?B?SHNzUTk0Z2lXb2s5RmRHeERlL3ByUVRmblY4Q0hHeDJVWEhBbko3MXRFUDdx?=
 =?utf-8?B?cHFMVWRSSU1LWDRGYjRhdWIyTVJpQWpDc1UzcVlCajFTL0R0c3ZXWStGQ3ZH?=
 =?utf-8?Q?O5I5m7q8ZbRlKQE+M1+O5hk6q4TWRXmt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1RSb3dWUzNHRkhJcTgwanhwblErQ0hlY3VSc2ZhcWF4a2QycjRtaWk5c2ZX?=
 =?utf-8?B?dXNGTkRCbG1UMVVsdVFodlpZVU5LL2NHVDNuWE1BbEdqM1Bha0lTNmJZNG1x?=
 =?utf-8?B?Si83OEtJa0poSmx4S1Eyd0l3LzRDd2tOME4vVjdvVHhjYTVzeDYwTVBqaURv?=
 =?utf-8?B?bk4wQkZqUS9vbHRDWGErZGZjckZhVW1Ic3AzSUptOS9aanZmak8vM3R0OFFs?=
 =?utf-8?B?dnFNcGI3MUhmKzdkREZ5RnhxT2VpVmpUVUpGeHFJSERldmczWWF3Y2F2NVF6?=
 =?utf-8?B?MXE4Vm03SjU5b0lJR1VGeXRKQlQrVDhaSE4xa1ZSMmNrR0d1VXBJVlJpWC9B?=
 =?utf-8?B?aUxzd2VNWlBHMVV3ZWlSMDNpdHoyd1VCNVhaeFpLaUIwczlwVWZNNnVvakRt?=
 =?utf-8?B?bHo4Uk9wZFJBVkxMWHZyUkV2Q2gwdGtSNnppVVdEMWZFeEhNc1BXV0ZiUnF0?=
 =?utf-8?B?WWZ4WnBnOGFjd2VaNlBzREhyUDBXL3RpUGRjRnFtcU5qZzdtdFlldHR2SUV4?=
 =?utf-8?B?bnFZQm1wUDFJWS9BMDViZGVubGF5ZHVCTU1kYkdtNEpLY2x0dEtHUXE1Nmlx?=
 =?utf-8?B?MnJTZkVUeTh1Mi9iWUxRNUcyWmx1VkRvNVJnLzhMNDJZdVo4QzFDYlJaVEJK?=
 =?utf-8?B?bEZ5b29kYTVTbkM1R1lhOGMwS1U2dVlzdzVHdkZaTUNFRXV3bUJCQ0xkdUJG?=
 =?utf-8?B?d1lCRU1ZMnBTM0xoMnF2TnpIcGtmTGdJNVZzTFZSSUJkTnE3R3BRSUl0RElX?=
 =?utf-8?B?R0Y0SzZEZm1CczFnaDhCeG9kLzM5RnVia09WVXYzRTFuL3NUaTdtWXVyVkZx?=
 =?utf-8?B?Z2tKOUZaUHFBblpPbHlzelRRZnlKNGZrR1VqdzZTNWUrckc2U3NiVHY1dm80?=
 =?utf-8?B?MHEvSjlIKzdBUjhZeWt0VzN1bjZLRGhoeVFQVERHRGp6S0t6TkhoZWwyUWlV?=
 =?utf-8?B?VEFNTncxYUVVWWtJbHpFRDRrMnE4K1VkSlhLMjlCS2IrdnZSYjliLzdPVjZQ?=
 =?utf-8?B?U2tUYmFEY2JYWm0zYmJIZVVQSEl0cnNkRnViT04veFFINnUydmJLc0h1S3lz?=
 =?utf-8?B?N25WN1FQWW10M2NrbUs5a1AxUVlweUhBdVd1aHdPZnJxeXk2UXJoNGc3S2hv?=
 =?utf-8?B?UVRxVHI3cjNHMHBBTys0QjArTjY5R0ZRRlVVME9wWFd5MXFjbHpnQkc1N004?=
 =?utf-8?B?d2hNMTlEci9wQ0NEOGJ6dzA0MDhDNU9LQjFFRGZuR2hOcWhkOStwZ1hKalQ2?=
 =?utf-8?B?QTNBaWJTQXZyTDR5aURCMVZJS3RzMGpacFpQbE9kU1kzQVRmTVRDSEJIWGNZ?=
 =?utf-8?B?ZE14b21VdWd5VmVVQk9iWVlKSnJZd09kbUZYM1pWT3FaR1hxeEVVNS9DWnFq?=
 =?utf-8?B?cGE3UFdtUW1uak1iS3lXTHB3dC9KUmREMTNQQU9zMGIxQTZudy9VVm14REpI?=
 =?utf-8?B?NEY5SVRmWi9OS1BKSGc2ZWRnVDNLL082TTRyaVVjR0VLRWN0UnhmcENlNjE5?=
 =?utf-8?B?UnR1NWFvdmFIS0tMTHIrOXBWUkZTSnZxZWhweUt5aUQwM0wrSTJoRnJCSFZD?=
 =?utf-8?B?Q0ZoN0NwZ0NiZVRLTys5TEI1MzhRaVVqcm5aZ25RdExHeElEdmlHaU4zOGZv?=
 =?utf-8?B?Unl5cnhGbWdhT0FLT0FvTEt1M1o4emxaek5qTFpicURxaUdGTXYxbTFpTUFo?=
 =?utf-8?B?YjErOGxuclNJai90TlRSTzNTZ2Z0bE05RnByZlFwRGp4SFZsYTdYd3lKQ0hL?=
 =?utf-8?B?bVhtR1hDbVdOQndWa3Y2aHI4dTJiQkRZM2VBTXZGRndYOGlvOFdIeVlBajNq?=
 =?utf-8?B?UncwSm9FQmlMa1dOdnFDa01GMHJpUUpwaVN2K09KcWlJdSswcUJkZ0c4clBC?=
 =?utf-8?B?dUliVEp4VWRJTisxaFpyZzdYNzZVejIwNVg5cFpMOTR1b3VvbUQ3QzU1aVpX?=
 =?utf-8?B?SnJ5UGZRdDZubkprVmFXMFdaZDV4NEVXZmlRS1NicE9pUHhpVndtSG5zNHJU?=
 =?utf-8?B?dGN6eWh2dkZiU1NsUXdGT3NabkhOTzBCajJVQ3NUUmpkVm9oUFB1L2dMQ0Yz?=
 =?utf-8?B?UFRWTUFla0pWYUhoU2Fmend2MlBNanZhOHN6bk9HZWpOc0lSVW56VU41T3N2?=
 =?utf-8?B?SXludHBEcFpIUFpVZmZvMWZhSVJ4dHpZUXY1dXdSSmpBQkpBaERtYi9IaGZk?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef865c8-f988-4cd2-5b6d-08de37c698ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 08:32:03.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5/52gLvQVYiWLeUIiWQkc+Wl783BVURVHH9i6csFD1aC5YU7wb/VESwsoyGcynTXH/tHrsn7nMXbH3d5ADLUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3599
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 08:32:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20956

On 08.12.25 05:51, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Commit 7dc56da3 introduced a qemu-amd64-bookworm target for running
> IEC tests but failed to enable deployment for the target.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index fa372e0..2714a37 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -294,6 +294,7 @@ build:qemu-amd64-bookworm:
>      security_test: enable
>      use_rt: disable
>      release: bookworm
> +    deploy: enable
>  
>  build:iwg20m-bookworm-test:
>    extends:

Oops, seems like we were living from previous deployments.

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

