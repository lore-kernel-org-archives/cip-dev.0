Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356B1C30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 21:44:23 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.52])
 by mx.groups.io with SMTP id smtpd.web11.5496.1720129461368670590
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 14:44:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=or3PMb5E;
 spf=pass (domain: siemens.com, ip: 40.107.247.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3DBc1ZO2jCn4yp+ps3N0cEIlpiowCGkK7uMhhDIQOdRKQV5NCD6Jc2wcnlq5lJL9mj11kQPQhoFLv6SgD0sBLdXrdS5EKZBx4OSGloX/BmhhnHeqdOK8uEW45GMvL2rA1Fj3KWKv1wqO/0E/qoVFS0TCiGEccPz3rli64gi/ytsi/oc5o+S/5znQjEyzsAgLFZnXU0mWPEG82VoTUJoHW5+QQBs6AR7JAPvvB1HqPAkUa/6+vsO0kchPGWjxK/3LXL9qPke2Na9MtVoqAXhAJpCOCHGqePTMzABdVBgWAlQ9Vhss8c4oADQX7iJKBBiRTMYBKCgkleNGSm1m+FsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fglA52I4b86voe+S+A/mbUkMmR/Um9h4juKHtE68Gu4=;
 b=hVtU4CgNYievf/cKpYu/mo2XjqGfaDpUscX/b07Y1t2c8WDiG6nuPDz1gLjEU9de1WoeUHWtKAtkUggG28t7YyRnnyicATDOCur0zsJn6vML29YfuinSDDyldEm22eLCIKXgLwUPZ2RMT5MZriJX80AOqFGr1vGc19NrDUqWd7+HkRIqp0h7CYgyA6PXydSJFT3mmhj86jUF/5ScPplKQoI3rB9EnKr705FgdevdD/ulPMXy0Ko3iGPf4KhBtuTuAXQ/odFQAA2rOgO4WDYn5IG7dlAqb+/I6FocZvDxZp4gxP9EF2UzZzYde5nQlSXhORuOKz3eXFoiQArEJ6MvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fglA52I4b86voe+S+A/mbUkMmR/Um9h4juKHtE68Gu4=;
 b=or3PMb5EBeLeX337wxtGxDqbhExF3TDtncFLcJjaLD9piabg82LGGFyz+VLnhCCEHqySrXv+oYSLe7pCHQyPPQMNNjEZLB5ZbDXgp3oHCJdSwHotMSX1vvnyEz9VCfRPUd0PxXL+fVvb38T2JEGm9mEUxIhyQTeWZLdbsFR8IHO1QaSTwxtq9BYSnw0VLBiotOB2uU0+zmmkGBQkjn0w5ZmH9ipCWJF0y3/t9gglsPUJZidDHVobxmC8uuzKZw45F3YtxxLCG4OPwnyQGTNUxl7eAO45MsexAjO7EiGPexzgyZuchPgPuXAdaX+0Uz9Ceg8spyiXW/n8WDDdXUnLTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 21:44:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 21:44:17 +0000
Message-ID: <434ca8c8-b1c6-4fee-8838-ee052666221b@siemens.com>
Date: Thu, 4 Jul 2024 23:44:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
 <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: eafaac13-52fd-4477-5009-08dc9c7274af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WmpPaVNmNHovK2RSY2FzQ1M4UU9GMVBpNkNmUHZVaHZ2L0xJMU9XZ1NZMGkr?=
 =?utf-8?B?RXptOW5YMWsxQzBGNWhXaDM4M0MwVUVTUExaZFpnQmRjZlRPZHdoazBPa0ZO?=
 =?utf-8?B?bi9xTzJ5S3ZWTEVhSlRGMGxaNDJ1b0Vuc2pCcFV2aUprRzVPZ05Bd2dBeTlL?=
 =?utf-8?B?WXp4cWNGc2RzMjFlK21oTlJKaU51aHZVdm5TWVFVNzlsVU5yeWFITmhTdEFP?=
 =?utf-8?B?VzlVU0U4Z05YUkpEWk41a0JrMWU2Y0tXRFFjNFJDU0tTcW56SmVhSEVDeEZm?=
 =?utf-8?B?dXZ4SFV1QnluOUo2Y1RMLy9GZG5rc3plcVR0Qy91cDlqbzJxc08wTllkUHRV?=
 =?utf-8?B?SHkvV2g1RnY1K3JJU1NuQjZ6cVpZM3BXK0pZVGtJS3NUcjVQN21Cb25RT0J2?=
 =?utf-8?B?K1MwazFtNXRka0RCUGR5RVM3SHJ1MEV6OEZQNElTa2s2a0Q0TkFQMmZlZGhQ?=
 =?utf-8?B?K1pIMi9aeUdOV1hoMXlidUlUeXdyU3dta2lFd2xlZnlDaWJ6b3IwOHRRM0hZ?=
 =?utf-8?B?RTdFczBMbHN3YVJFYU9wTEVqVGFLVTdtT1JNclpHL295VUYyNUlnYXF0cnhB?=
 =?utf-8?B?QmhOMFhzRmxJcTlsR012Z1JRQThZL2pLN1lhVU1BdjdCY1FRaXQxTUFMMSs1?=
 =?utf-8?B?STAxY2dZNEdwRnFDdUlJMlBCSjMrY3NjcnRxZkVHMzBRNmx0ODQ4SzRza3Fn?=
 =?utf-8?B?aWc3S2c0MXdITStpb3ppd3BQUm9oVE41ZmlPb01PSGJ4cVppN01oL2FmK0h2?=
 =?utf-8?B?MWxRWjZiaEwrMzZXd1ZZU3pTYU5XSVhTbXhLTUo4V0tDL3l3Z05YemtvRzFT?=
 =?utf-8?B?NGZkMmpuZnJsQTY4aE5XTHpEeW5XODBna3FhZlMzN2NrZGFWR0t2L2VQbDVS?=
 =?utf-8?B?L3ArNlVxRnFnL3JVRXFDUGhXdk00aWtnMi93Q05tQnFxT3c1WnJsc0x1ZFBS?=
 =?utf-8?B?QTJFU2JLcDdBWGFpTTUyOWlteXNvbDRDQTdkOTQ5T2pGeGNiNHA5VXNDdTZY?=
 =?utf-8?B?TXFoZFJ4N3JvbzFIVjJwV2M2d2hyTVFVaXJ2eXRzZlp1eEUwL0JWQzl4bXJY?=
 =?utf-8?B?MzRYc2JsSWRZVmJFelFpb3lNSU81MzdCeUZjem9YMk9vd0VCWEk0TFNHVHNa?=
 =?utf-8?B?M1BqWXFrWlNMU0Zxd2xZbXdnRDgyeGpoNlJyUmhMZTZERWNxeFEyZ1ByVTRT?=
 =?utf-8?B?RHpCcERsSnlEYzV6MEJHQ2ZqcnNkRzlBamRCV042UytkMkY1UE9ieW9iNm94?=
 =?utf-8?B?NCs1eG9pRk1nYUN6dS84UFZrSlNmVVJPQ2xncmN4MWhmQlZiSHJ2U1lLV2RV?=
 =?utf-8?B?YWMwR1F6NWxEbVJDTSs0bXBBa0lIcllkUlpMcUFMdVlTWlJZMExaRFJVR09t?=
 =?utf-8?B?dGZKNWNpbHRHcUI2VkNwVTVlb1gzSko0Mk1GbXFIV2VZaFhyd0FIVGtPNWlJ?=
 =?utf-8?B?VU1YcTNXSUYyd1VjMnpGeVp3Y01sVDZ4dlVBYnhHM3RYKzRaWHp3VGhIRWYy?=
 =?utf-8?B?K05ncnlXTXgxbFErS0dGblNTOENhTXZ0UlA1ZTY3OFYxbjlXUG9NVnpQMUVa?=
 =?utf-8?B?SFFzZVZGK1oxSFBqb0cwTXk2Nmg0QnZLb1JWVEdyNUg4bFlZY2FmUC9hWDNI?=
 =?utf-8?B?eFN5VkNMYWp1UHFuendST2lCOCt3Z3FMVGNMbURSWnhnOFNQK2g1M2tOM2wz?=
 =?utf-8?B?Q1N6V0JNakdWalRMUHZRQmkyUnhWR2pHM1pSQmdCUUZHTDc3TWN3bGtmbFpm?=
 =?utf-8?B?SEpRSmkyalJSaU9ORlVvVHRyckExTUF4V3p3ZkRzSjhncytGclMvWjY1alpu?=
 =?utf-8?B?RHpMeWxLTmltZ3ZVTlJHZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDViWUNMQlhZZnJUQkhkaTBaY1VQNjhlSkF0YTF4SkEwR3ZGcU1CcnU0U2JL?=
 =?utf-8?B?TnZyZXN1bmdIb1JDZGIrdVFrQVFzUndiVEk0MXlXMWROWG4xTFA2SUhFK1FU?=
 =?utf-8?B?VUo3eDJOM0Z3MXlJR0MwYUNLWXZRL3E0VFphVWtXMUg2ZkNWbUszeUl6SGZS?=
 =?utf-8?B?a2RDZVhmZ0UrdlpEbDQyVGZZMTJRdldhRXYvRGVnU3hiYUh5RDIvWGlydG53?=
 =?utf-8?B?Y2dMdDIyL0IyVGtkeC82M0NnSENLVHB0ckVsRkgydVB1UjZQdCtsNkoyeXZD?=
 =?utf-8?B?NmlkSTlHakxiK2Vzd0NKbXpnUVRFWDdyU3NnRyttQklST1ZyMWY1TjREcmV3?=
 =?utf-8?B?YlgrekRneTdtOVViUGFOYjVkT0lUWEJVZ1V1R3dCVnk5ZVJPd3FmZkpGNXJ6?=
 =?utf-8?B?YTBEd2pSSENseGVRSlo0UFRCRXhrNUpqaGZQRlRKeHZxbkxkRjNJaEFaWklh?=
 =?utf-8?B?a2NHbEhOYlEyM2hWRnY3M3FSQ2NFVHhWb0JDRHNRa2tjenVXMCtUTTRXSUJx?=
 =?utf-8?B?aTZKNkF0b2tEUHpmejR0MHl3Tkt1Rm5MY0ZhSlIwYjRuSlYvREhBVmJwMjhi?=
 =?utf-8?B?MlhJdTBXdk4vRjIvOGpHWHBBUWMrUnFxZ3cxUG5VdGRINDNxa1lWT3NVbE00?=
 =?utf-8?B?dXJwSXRybFIrNW1pM1pPT1FQZVg5L09HT3R6VkV0QXp0dmhmeEJtUDlwUGV2?=
 =?utf-8?B?OXNwTEtiMzRwVmEzWmR5RFlEaVNLUEpMOTZRalFPTllRTi9qRTRlbGZyRzB0?=
 =?utf-8?B?SUU0RjVsWjE2NWpEUWhxWmEvUkQ0MHJ3NExtdkdJYTZibm45MHNQTklaTC9T?=
 =?utf-8?B?MXFXemkySHhRQ3Z5SE43NDk5RlRxSDJoWFl2eWtvTjhjcU9jRDNHZW8xRCs2?=
 =?utf-8?B?elJUNXFlMEJqWmRUMURmajZoNVl2dlhvYi9rdXI2UmxhRXphYWcrbldFQ1Ra?=
 =?utf-8?B?dWw3MklyMTMvUWZmdmh2dXNOQ0RiYzdFV0JSQ1ZLSlNubFBudWN4aUgvSlJv?=
 =?utf-8?B?c3RwOGhYVXluamdOSnZQUTFLNEhSRGM4dDR5c1QzODdENmhJRU55Y3RVK1Y0?=
 =?utf-8?B?cS9NSVV2cnB0OVJBaU5LSGJJUlVrNzFTRGhTcHR4Wkw3VU1UQUJKUGN6RW0y?=
 =?utf-8?B?aXhlYWl1NjFVZnZBSEM0MHNNZGRlZkU1SjdCSE1ieUU3REdQZm5WRTd6Q3Zt?=
 =?utf-8?B?WDRzQVpEUWpWMVZDZ01mU21KNERabXppNllPS3oyNUZobHJJTlZOWE9DamtE?=
 =?utf-8?B?cTYvOTh5RWxvVHh4UVZydWh2cis4UWF5ZHZCL3hFZC9Ib0pIQjVubG5RQ05h?=
 =?utf-8?B?MUZhRTNaSGR6elpwd2pTUDg1ZEFzb0FSUytOUkIyYnhZR0F6aWtoWEd0a2hH?=
 =?utf-8?B?WFJmRmZUOUcxMmZwMHpBaFgwdFFGNnM3aTZvS0lGV3NyL2g5NEQvakZkZXh0?=
 =?utf-8?B?UGo5NUlid0d0TEhxcHBmSC9oWFg3b21nZ3UxQ3VvVkx1YTZVbk9VNkF4Sm1w?=
 =?utf-8?B?LzZyMkVLVmRtQkRjQkR4WjJlK0lYWVVYQzdrd2pqMlczUHVmOFc1S2k2ektl?=
 =?utf-8?B?NGxlT3F3cUxDV3BHdTFOaVpReUNtckVaLzhWQ25lQ1U4NFJmTGRSazFrY1Rn?=
 =?utf-8?B?dnBhSGlRS3lvQUtmL1dNUWIzNjZyTUxRY2o0L1paY0V5cG1WbG85ZlYxMWpG?=
 =?utf-8?B?YUFGUkpCR3hWK2toaXEvMnZBQXJxTlkwc0hXTmdnb0FldXJSaFVzRzBvb0Mv?=
 =?utf-8?B?K3FYRC9OTC9BMVZudXZYZTdWRUpndHM0UDZFa1h0NGZyQlVQWDhza0JRemQ0?=
 =?utf-8?B?NExHenBGQTkyTnVkQTVFNERFVHN4QmZDVzVwNFBYZkVhMXpQNVk3WHNndGdo?=
 =?utf-8?B?TzkyK2tnU0JHTEViaFp0ckNvalI2SHlJV1R6bmJzb2hiMXZTTlByUW83SlI4?=
 =?utf-8?B?T1ZRa0VlYUY3ZmYvNDFlVkRnU09EMGpBUUdVQkJYdFk5YmNuREx5WHNKVm1l?=
 =?utf-8?B?V0EzRVNBR1poUWlvKy9oZWkxLzUwalBXcjA4VUNTKzdoUms1V0lTdmlFVEJw?=
 =?utf-8?B?K004RHJkVCtRTzRRQzR1cTlRUjhaSDBiUzVZRTVwZUVVZ3BxWnVvUUhOWFVp?=
 =?utf-8?Q?S+bPcYlRgANdvJRmQDB/3i5WX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafaac13-52fd-4477-5009-08dc9c7274af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 21:44:17.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fYI90fJIx6kYuhi2pCfOFXlRA8F+miTJHDXxhPdk+mVK8g5JUEQH8leAV1b6HphVnTFkiAi1lmlyP6psIKCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 21:44:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16376

On 04.07.24 13:37, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
> Let me explain the reason behind this patch. 
> 
> My understanding is that the security image should include SWUpdate and Secure boot features by default. 
> Re. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/b95e256a5b05f87aab48b7bf3e7e4d8d45566ad3 
> 
> I found there are some minor issues as below, 
> 
> 1. In the current menu when security extensions is selected, SWUpdate is enabled by default and secure boot is disabled. 
> If I build with security extensions option, the build system is creating the image with secure boot enabled along with SWUpdate. The reason is security.yml internally includes "kas/opt/ebg-secure-boot-snakeoil.yml" kas option file. It is creating the wrong impression that the secure boot is disabled in the menu but in the final image it is enabled. 
> So that is the reason, the secure boot is also enabled by default for security image now. 

I still don't get what we need more than the select below to enforce
secure boot for the security image. When adding that change, it is
clearly visible what the security extensions imply.

>> IMAGE_SECURITY
>>  	bool "Security extensions"
>>  	select IMAGE_SWUPDATE
>> +	select IMAGE_SECURE_BOOT
> 
> 2. In the current menu, there is no provision to select secure boot option without security extensions. It will show only when security extensions is selected.   

This is not correct, check again.

> 
> The patch changes will help to fix these issues. 
> 
> On top of my changes I confirmed things like,
> - SWUpdate and Secure boot options are visible along with security extensions option in the menu. 
> - User can select SWUpdate alone and  SWUpdate + secure boot features 
> - SWUpdate and Secure boot features are enabled by default for security image    
> 
>> -config KAS_INCLUDE_SWUPDATE_SECBOOT
>> -	string
>> -	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
>> -	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
> 
> While testing locally it was adding same .yml file multiple times to the final .config file which is not necessary, so I removed this structure to fix it.    
> 

I can't follow. Please share the .config.yaml that was wrongly created
for you using current 'next'. It will both document which options you
selected and show the duplicate includes (if any).

Jan

-- 
Siemens AG, Technology
Linux Expert Center


