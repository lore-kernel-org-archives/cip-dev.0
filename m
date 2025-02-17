Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766FC021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 09:05:28 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.26])
 by mx.groups.io with SMTP id smtpd.web10.47369.1739783125200271748
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Feb 2025 01:05:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lZC9pY92;
 spf=pass (domain: siemens.com, ip: 52.101.66.26, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwTDq/wOj7cQOkIUkdGAkUHmZGG6FQ4JjF7vgRaxYMtKwelf0o0++pFclWGLDf7nuVOeCjWEzi140KhLrEMa0UBRGW9K3Tc/JBFLIgtvnRFLuaazm7jeqR4qb5w6vd6sSbaE65/8nHT43fsGCb7Q1sWcQpum6M5PzUM/HNnssMxDwltHk5yoALrSto9arHDvXAFGwKbLh3z1oduyakI2/yXI8+anmth32YDFtxnKEoaxiyvP/srNSSzOBoufrT6Ow71n0or4wdOqhkJc0eYzEluHwsAcTX1NjUd7snqYtpRc3mRmMfN6jKK4VnDocroYhDx/mQD8kl68J/gxHPAhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZi/pkaqW6IHvcmqFYkW0J1ZzVJManyQpoQW6qWo7d8=;
 b=A0JE9Ge/z2a2+KMAeGIUqsNYa/jphzgESC6yrAgAvut9UztlFb5xHScGUWIui6EmZoOtdOiwdEGzqWUx3+sfImDHVjFXqaBtptZPjD06Zwqg+GV1DCOuoc8twkkk6gO3RwzFbO7nwddg7cam9RQ8e54xqAhriwRIrDDL7DeCQCp0/87ALy3zW83pwCvJOYgZM8XKTXgm/jxWXbtycQk3M3MCbPjhaZf/UsBhSa39PiwJY1aheUz4CbRTrYxrT+S3gMTL+4SDaEuTEYzvIohN05SK5Hw2/TkRgh+BkwJDjcsSERcQ9b/ZxrHd27n5Le6OtefmRulHr+MfO8jY7aKnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZi/pkaqW6IHvcmqFYkW0J1ZzVJManyQpoQW6qWo7d8=;
 b=lZC9pY92Nl64/bzrbjQIcWiQ9rTxzEg5OwF7PVVXQqCbPnEIKmo8T1tdFwIWjZPsi8MxCY+H0EOs/Hj8e8CuexLTjGJzSP6hmM2zDH1XOiSjZqaVfTcCh/wWeXFpCsJBdxLDcHUWY+nXA8XqKx1SOSmcTBflSonpTslLS5tcjIQIy+R0blwa0YlHpCNWKB2J4QzZGChz4ZRvNa8IOTDct8IgrxKs9ZQ5EMTdq6Wct+H+wCxzVLKMaScbH9vhJzyOWWvG4JreuxrD326vWCejT1+59UZ9b0pucxKRm8OXNwkTpS/2jryy7hlqQBkSm7Z++zKw42+M5Ti7bGrZ4L6nsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS5PR10MB8294.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:653::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Mon, 17 Feb
 2025 09:05:21 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8466.009; Mon, 17 Feb 2025
 09:05:21 +0000
Message-ID: <70321418-f36b-4dd3-a6fa-ddda267c1a14@siemens.com>
Date: Mon, 17 Feb 2025 10:05:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest
 version
To: "Arjunan, Srinu (FT FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
 <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
 <PUZPR06MB574734D2FC5651C2195AD6FA88FB2@PUZPR06MB5747.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <PUZPR06MB574734D2FC5651C2195AD6FA88FB2@PUZPR06MB5747.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS5PR10MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2dfa4d-e9a6-4bb1-68b5-08dd4f3234fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZWtDZ3FVSXA2V3gvb2FPYVFCenRuaUQ0VEZxeFZuRVU5SkVjYlBOeTUzWFZJ?=
 =?utf-8?B?Wm0rZmNGWkZLSWNMejNSZVZKZUFJdy9rZ1hvQTlVNmlaTFppcS83NGZqbDR5?=
 =?utf-8?B?blpDb0JEQW9Qc3ZCM1JHMnQ3RGQrcldJV3B2cjI4Sk52UVVRVEdBV0Vuc2ho?=
 =?utf-8?B?eEtObnl1ZGp4anNuQU9pS2VyWVA2N2R0Zmc2RGp3TjNPcThiZWxad2YvTXJH?=
 =?utf-8?B?NU1LamdvM3pQaUVKN0l4ZTlGVG1DbG5PYXRpNUZDLzdIWnplNGJWd2phR2pS?=
 =?utf-8?B?aW1CWFUvQUVRUXQyc3UzSDNmNHpxc0hXVGtkTkc3TEpUVGE1akYrY2JhZU9C?=
 =?utf-8?B?MEtLRXRvNzRrVlAyZjBBN1BibGlEeVRCZXdHMlN0b2pWTm5OSWlHSlFvTUJZ?=
 =?utf-8?B?NnFOUWNiWGV6enVCT1Mwa1B6bkk0SWpGZmF5bjRZeGpJOUJIK0ZhS3ovZ2pq?=
 =?utf-8?B?d21mUXNkaUtiaHo3amlXamFTVkM3N1l4U0NESERTZGNockxwQXhyNFhoR2tj?=
 =?utf-8?B?bnl4RHdseDZsVFltT3liajkyYTBDUVR6STNwQWpqTHFWdGI0VXdyVjVLNEVw?=
 =?utf-8?B?eUdCMzF2L1Fxck5ZdWRNaWpYUTlWRUd2WWQ1UzNCR0hCNDFXOHdpdXRMekxQ?=
 =?utf-8?B?Z3FTVmpRaXlwQTJWcEF1K09uL0VyOEw4SDVENnpLd29GMUlwR3hrMFM0UnJi?=
 =?utf-8?B?UTJ2ZDFIWUlrcGMxYXViYWV0NTBXeWUzT0hRbEJOUENjczJpSFB1YTUraGZj?=
 =?utf-8?B?SUViOVkxNlBrWXdpMUFkVWhWTHVSSXJnc1BZVVkrZ3ZDZjM5UkpuT1h4T3Jk?=
 =?utf-8?B?RWM0MnRkM1hVSEpHOFVPMU5pSWJ4eVIrTlZ5a2tRek8vWXU4Y0g2bEFpYWFl?=
 =?utf-8?B?bHoyZ0U5ZnFRdE9SU3pGNDBaTit6U1dvVFJvYWdHLzFQaHkwT1dJTngrU2hi?=
 =?utf-8?B?QmRYNWMyQUJydjJsTGZCTE5uSHpWNy9rREc3VXFHRmtmUHozK3NIcHd6RzJ0?=
 =?utf-8?B?ekN6VUFaNWRRWE1LUi9MNDZwY2YxcUIzUFIrUnRUeTR0Q0R5a3FkUDZCVURL?=
 =?utf-8?B?Z2JVcCs2Y3dIb0w5MzQxTWhqdXROUkx3OW9EYXgvOGx2TithQ2FCczNQWjFM?=
 =?utf-8?B?bkJPNC9kTEs3aGNmVlJUQXlHcmNrV2xUbnQwY0VlR1VDRkhCSytiaU5SYWZ1?=
 =?utf-8?B?bnJxWGNWOEsrTHpTQTZXcHJjRnYwc2MvZ0JQcU9TWGdmdnRyUXhuY0xvci9o?=
 =?utf-8?B?aG9uSVh0SUdvdHlMZ21rL2pGRmlMU1F4SDRyZFVGYjdGL0RlTjVpd1pSR1FT?=
 =?utf-8?B?SGpoUWx0MzA5SW9maEFyWU1MRENnblQvRVVJMDRNRmlxR0t1WFFrRkpQTUIv?=
 =?utf-8?B?TlRPQjFJVkx1Y1RNTGhZTFE1YkdLNXZvTHVlT0hRVHpLbFFIRDJlMTVXb2Q0?=
 =?utf-8?B?eUM3a016MHpnQWVXQXovOXA2Y1ZTZHExZW1VekJjclJ3YlhPcFlmOGJxbnht?=
 =?utf-8?B?cTlGc3RLLzU0Ris4VU5CVFBKc0luUUV5RnZscTJxR1NCdnJNVVFJLytNbThx?=
 =?utf-8?B?bDFpRmtydHluN3hHNUs5MHZLeEY3MkJFU09YRDFLMUpDek1hb2hDR2UvT1Vy?=
 =?utf-8?B?cFB5Wmw1LzRuelZ0cmJvcGdGZmtrL3ZGbm1kWXAxTjlET2lUQjVKbUVITjNP?=
 =?utf-8?B?K3pSQllMK2ZUZGRGWXlva09WcHRYQnQ3ekwySEVyYStHYlZtOTRJeGxoYmR5?=
 =?utf-8?B?a21oanY3aE1ic0tvajVIdHBodDVQQTJUOXZFOWhhWXp3WWFIdmQ0VXl0NlBD?=
 =?utf-8?B?RTU2TUtERzFldlhOMEM0dDBEZVRMQjJqd0QxS3Z2UkNKZ0prcUFzWmpLUW90?=
 =?utf-8?Q?ZnAyji9MlXrGi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVJacXBYMXhUZmJPblcrU2ZvTCtDRm9zenRSblQ1TllHRUZ2VC9tSkJMYU0x?=
 =?utf-8?B?d3ByZ2pGMUhLL2VBQjlSbWNaVEc3K2xpQ2VHc2ZWcUhNb0VGaWVpeHZORzBT?=
 =?utf-8?B?a2xwTGd3cGo0Z3VWZVBvVGtWVk15TDJhQjBSM1VldlZrZVVuNy9YSnlZNWp3?=
 =?utf-8?B?L29XMm9sV2gxeGd4V3crOHZVNVJPL2lQNGppaC9HVUU5NEtMRHA3Y1RWV3I0?=
 =?utf-8?B?MktOYXc5UnIwRE9xTnpXei9aV0w1TXpMcEVMV2l1eGhnaFJjcmxzTmVsWXJF?=
 =?utf-8?B?NW9td0hjN1dJeTkrZklNaUtGcmNhTHVwTFFkZkw0bGNzejlLajN4VzFjQjdH?=
 =?utf-8?B?VXcvQ2tsblVkdWhqeFpmaEJDbkk1MHFBRmFjc3BONDRkTXN4R09DVDd2SnBI?=
 =?utf-8?B?VjM4TTFGaUJrYTBiaWZXS0RNL2t4SjEvRHY4clVKNWZoZXpxL1VobjY3QmpJ?=
 =?utf-8?B?R2dMNEJOb09MUkZrQ1RZMTY3VG9maVRJRm80RlZRd01LNzVrcjRkNnRad09G?=
 =?utf-8?B?WjFobTVNK09RcXZvUmg2RFRKajNVYUs5SHM4WC9DbVZNMDBLSWU1Q2pOSmhw?=
 =?utf-8?B?eHBpMWl6eDVFRHFWb3pUYytrS1l2Y2NRbXB3OXZWd25aVGxIeVZTNHBpeWNx?=
 =?utf-8?B?TWlJOFRFb2pZQnByT0VkM3JSV0tHYVdVWFR3UjdLUVRFYUc5NnRZV3p4c0ZZ?=
 =?utf-8?B?SU1RSjZERjBWanZQWXJJOHR6MklLdjdac01MV29wZzBDa0UxNkNHek93NTV0?=
 =?utf-8?B?MjhEOHVEVG1mUE4yejBkVnMyNVQ1M1MyeDUwM2hCZ1Q2WVA2Nmw1ZytVVDM3?=
 =?utf-8?B?bkc3R0VWa2tiN1YvWGFsTGxUVmlKN0YwTThlLzZYZjVzZ0VmT09pZ0REMGVr?=
 =?utf-8?B?b01rQXR3QzBNRkxZZkJsRWRMWCtUNElReURIN0MvZitTaEdVT3lOenUxZVVq?=
 =?utf-8?B?T25wQnhsNExsdHRBcW1VZEt6YWM4M2NRZi80aXFjaVJZNXpxNEZVMTZlbjcw?=
 =?utf-8?B?QklUMXo3bTFuNVRvMW51MC9CT3U2NFFva0t5UW5GczIyNTF6SS9CYllKeFBm?=
 =?utf-8?B?VkpMZk9CcjBOOVhiSkpGY1BScmRKM2p6MVJ4Zk56RnJqT3VzSGliOHh1MURw?=
 =?utf-8?B?c2toQnlxU2g4bEJMeXNzY2ZnS1ZFUjlzdnluWDJqMmd6blZaa2NseHBDL1hF?=
 =?utf-8?B?TmZTdDRDNzBTVUV5SWUvVXlmbnBoODd4ZU81VTdwMFpVd2l6bCt5YXQ3S3pL?=
 =?utf-8?B?SDRWSU45bjBXSCt6ZUlhNU84NDE3bWF0R2R4TVZTd28raXJQdE9CTkQyMTlp?=
 =?utf-8?B?R2V4OXM3SGZ2bVNKOHZ0ZFdNN0VNM0M2dkZyQUQwdjNXbjNLaUlvdUxtWnhq?=
 =?utf-8?B?MDNRRVMxZmh2RkZWUVA4MFVZWWFvS2dlZUYwbVZzdVZlWStuNmUvRkhCZkkz?=
 =?utf-8?B?amFUeExSV2RENURDTXphMk5SU3BkZW90Zk9PYkJPUTNBSE5uTE4zTHlFZ1cr?=
 =?utf-8?B?U2JqNTE0RksxcXk1alE0dVpQTzY5T0l4bEpOVlV1b1A3UWtuYk1JT3pXaHk2?=
 =?utf-8?B?UzR3VVZLcXFRY25jWE9LSTBWeGtmMnhwdWNYT3V0cEtQU21uTTJwZ08wa1lS?=
 =?utf-8?B?UTNUTmhGVHU3eW9BdjBJWXNjSU92M1l3bTdpZmlwM1J2T01obFpWd05CaEJj?=
 =?utf-8?B?dm1IdEJ2aXdYT2JuTGpvRXVHNkFrZkE2RFlsWFZNZnVPMVk3TnVIa2FlcDVk?=
 =?utf-8?B?ZnlxbWhSR2FsV2JuT3V5SkNjRm5FSjBzdGRNWnhoOGZFSkVZeVdaTTBqZUgw?=
 =?utf-8?B?dWhIaTRmTDlzeFFMNmpZazE0OXhsTzdXZDd5NFlZUmFBYkMvakUrbkkzZWRF?=
 =?utf-8?B?NU1Kc3g3R2JiV2xhTCtWeXBhUk1nZS9zejVJYnhHNFJFSlJ4T2l4NVhJZ2Z4?=
 =?utf-8?B?aVZndlRZaDZrNXUzM3I1bUxZTnJPd3p4dlNOQlRhOVROWmIyMHJFdnp3NUdT?=
 =?utf-8?B?U1hsWXppdUdUdEd6YW5WaVk1MEZ6OHptQ2hvL1FLeUR2MCtLRUdmUzI4bEZ4?=
 =?utf-8?B?MExFTGhrVi8xNmI2cXVUenNwd0FCOFZGNjlmOEJPRTgwckJTYXdQa2h1azBX?=
 =?utf-8?B?VThtblhQbnNYSlhOQzZSWnQ4UVZhL3RydTdLSU9HYjhzWEJHZ0lNN2h4VVlj?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2dfa4d-e9a6-4bb1-68b5-08dd4f3234fe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:05:21.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FX9y6IQm6B9SBF1LOlRakTD5o6Y1Hj6icJN2GU1WgNVVzSYbVgaLdc15pFjtF3S8SbIJDrsWaqEszl6Gsg3gOqRwjrQmpxTD+1QHACfGe+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 09:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17852



On 2/17/25 06:37, Arjunan, Srinu (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
> 
>                You meant this cip_merged_defconfig is generated one?, in that case, is this sufficient to enable the required configuration in siemens_ipc227e_defconfig to use the mokutil in IPC targets?, Please provide your thoughts.
>
Normally you would adapt siemens_ipc227e_defconfig and then regenerate 
all cip_merged_configs.

Also if you adapt 6.1.y-cip you should also adapt the version after that 
also(6.6 ... 6.13 at time of writing).

Quirin


> Many thanks,
> Srinu
> 
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: 14 February 2025 13:47
> To: Arjunan, Srinu (FT FDS CES LX PBU 2) <srinuvasan.a@siemens.com>; cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Gylstorff, Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>
> Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest version
> 
> On 14.02.25 06:31, srinuvasan.a@siemens.com wrote:
>> From: srinuvasan <srinuvasan.a@siemens.com>
>>
>> This revision brings the CONFIG_EFIVAR_FS to read the EFI (Extensible
>> Firmware Interface) variable information via sysfs.
>>
>> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
>> ---
>>   recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-kernel/linux/cip-kernel-config.inc
>> b/recipes-kernel/linux/cip-kernel-config.inc
>> index 53bee8f..e761957 100644
>> --- a/recipes-kernel/linux/cip-kernel-config.inc
>> +++ b/recipes-kernel/linux/cip-kernel-config.inc
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2022-2024
>> +# Copyright (c) Siemens AG, 2022-2025
>>   #
>>   # Authors:
>>   #  Jan Kiszka <jan.kiszka@siemens.com> @@ -14,7 +14,7 @@
>> SRC_URI:append = " ${@ \
>>       if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>>       }"
>>   
>> -SRCREV_cip-kernel-config ?= "e486c93a916cb6f78b4917b7345e8818f96069f9"
>> +SRCREV_cip-kernel-config ?= "6b5db480b7a43e0217b1fa58f487f0bb997743c7"
>>   
>>   do_fetch[vardeps] += "SRCREV_cip-kernel-config"
>>   
> 
> Argh, the commit to cip-kernel-config is broken: We must not patch the merged configs only anymore, they are generated.
> 
> Quirin, I suspect that plathome_obsvx2_defconfig's disabling of that switch causes the merged config to turn it off again. I though that was fixed?

There are two configs which disable in 6.1.y the EFI_VARS_FS:
- cip_container_defconfig and obsvx2_defconfig.

As we take all config into account this will deactivate EFI_VARS_FS.

At a other note we should look into automatic the config generation.

Quirin

> 
> Jan
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


