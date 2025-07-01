Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0782C8302F
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 05:59:20 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.35])
 by mx.groups.io with SMTP id smtpd.web11.3445.1751349551896887255
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 22:59:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MEILbjZT;
 spf=pass (domain: siemens.com, ip: 52.101.84.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kscKJnOBRRLVWcQFshaCxAG5cctcQvHA+PLaRVK2LO3QizPbTXYhAHw3PeZY2w/B+IDaqcjPwIl/ioTsC2GNas6nZCQUnuSdF+cQhdT6HyQgWT5JOhdsCz0o+NHmZR5wQHznxMKQF31qUXtZ3HszQq/8Xvz5MYiNUWXhX1NZbqqXkTpoumZKX7+RXY01wyemiYZDCI02UxigTw5opjVV1Pk5uEE7DF5KW47Y2uZTe289i4fLFgyGgAhOgm1+etPfCyz7TNPUX/nBWTYQDVlUDjocDfn/od2UFu++s+3ejUNxTcDSlxnuIeyRWnYE+nP96ZrdoNF2eBZB06B7Er2ClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beNgiMp648KKCrWBSctT3la7bL5vPU0GrhEOTlkemHo=;
 b=oGS2+Hmr9bpLrAgJq/VRfNiVAje6Cs2mctOcEaFgUj1QSKWtX8UGxt8NnfYORc+CxEgc/hMZ0HcXwHU9wxlDJFZwSHUqqjsGbdKmyp9mbB74hDlgNUQ7CuUEyJQVh1/UfrwUC7aBhzcEB27iL1UiRsrms4lM4hwYTC25JTTs9Y5TLxpmILJVo5ez1ZNzVycaAPKYHouvKpYpP4XRFVntx2+Ib9roACwY6SU6MFB/uIzYIkv1dkjIV/TqXwziQ7LiO9vKfmu3bhuRmJKN+eFX/Zm8+bLD0ig8xNSW+dG4K9R7TzjfnxLAeGj+WWmSmf8jr9hx7gAdSHixyeWSWdaJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beNgiMp648KKCrWBSctT3la7bL5vPU0GrhEOTlkemHo=;
 b=MEILbjZTPdpWZjHGlDuro9hbfm+HAbQINIlO0s0GVMGWEf/0kIUv04D/77qbPvUomJOjHgC3G+hCb4A1fFhPHa7jkbdBXBU611orGVO5hbPOSoainYco3nB/u8lU6FJAxVkrXdR0O9BfL15hXtU6Fwkd6VFAOBIU99Mm23llDKDMb/kXzWqpmm/8oR+YvF3kmgy0y01BNR5cg/x9+ABp+eAWEHfFmgzKPW7Q9SymJClZzdaRUfdPpwF+qcmk1WWMMXCewhrMFu+QUbZKqK+xA/fQOEvfKFEEVb1nY/0RDE0a62YVWYXtaDCzUvJ1O9ClfPizKyBxr88RB73IAqBb0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 1 Jul
 2025 05:59:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 05:59:07 +0000
Message-ID: <19dc7474-f963-4e6d-93ca-2cfffa3f8150@siemens.com>
Date: Tue, 1 Jul 2025 07:59:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] initramfs-crypt-hook patch
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
 <4354a786-359a-478e-bf25-fea8e35eaa61@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4354a786-359a-478e-bf25-fea8e35eaa61@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9b32cd-ba8f-40da-b756-08ddb86463de
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OGxIZUx0QUtWR2RFaWNUWkVMZzdwWEc2amhDb0hCVGdiT1RIT2FvbUY0RXhy?=
 =?utf-8?B?S056aTVERWZFKzhwVWMzQllsVkxKWGp5Y3JrSGpuRS9scG4wRFF0U2h2QXFL?=
 =?utf-8?B?anNsWjV0eGpVSE5oMFBsb2p6TDN2bWRIbUxKb1BKdUxzcEpZTnlncXMyRlpH?=
 =?utf-8?B?cXR2YlE5dVRrTE9JazRiOUs4cU1hM1FxNE5NcmJPcVpPSEtsMWNTakVNbUR0?=
 =?utf-8?B?R0tFT0RkYnBuS2tWaEpZQmh6WEtQQUtYa2xNNGpkQnVGdmJaVElJaTczQTlT?=
 =?utf-8?B?eTlSbUFzR2IzZEN4Zk9NQy9namsyVmEydUh1T05SUHkrU1NqSVdNcGErVVFO?=
 =?utf-8?B?cFVlTkpFRFBEK1VRVHNlcmQ5c2d1elN4b0gvMHovQ3duYUxWSVJhUEhYUVl1?=
 =?utf-8?B?T1dwU1VSZVFuQ1YzM3VQL1pUMmY2RWNYbXFQRjFrZjhIR1VPYVFPQWExWSth?=
 =?utf-8?B?b2NDRnMwbmJDWGZBSnV1UlQxWW8yd3RlTnpHOVNMd3VHVnk0YVNkS05HOHI0?=
 =?utf-8?B?ZlJGeGgvTGZrOVN1WFdCYUFoTWY2UFZGTGdwTFJDYldOcWtIamVEa1ZWcjJp?=
 =?utf-8?B?NCtGd1dsdDRZT1BsejVSK3YrdzJxN1dHc21sZ0c3SmxWYkdYRVl2Z3VVT1JO?=
 =?utf-8?B?UFRJUWlSbXVEblJLRUZEWEUvODZ4YlFXUzNMN01pTTBRZ0hQK3lValpKMDkx?=
 =?utf-8?B?Wm8yMFRLRVppSmk4M1k4MnFPNHFHcHZMU09SR3RLRU00SWl2Z2VQVFlvYzVy?=
 =?utf-8?B?V2YrNGEzd3MrMTN2MWlHaXRQa01VVFJsMWVKZitkQ0NWNTZpeXZtUCt1SXVX?=
 =?utf-8?B?Nm9wbmcwZWdlbXpxbmNxWWZQTnl2UEIraHR0ekd4cmY4dEpuaENrTzZUNDli?=
 =?utf-8?B?bUJGWE1PaFNucGUzUGhsRHhzVnRqWG1mY1haV21sandrU0U0UDVwdktNL1FI?=
 =?utf-8?B?ZWFwRWtEQ0s5SE52STZLbFB0NHFnZ3JMeWJnQUpLUXpUWDJhOC92dmc2VTRR?=
 =?utf-8?B?cUFQeDQrZ0ZJTC9yVnVyNGw4Z0ZqWE1RZDQwZkU5aUNQWTRwR0JNWXUwMzhn?=
 =?utf-8?B?d2tjdWFDYjJIV3E5dEF3dE5WWDFiNk9wOWhkYW9UNzlzek9xU0Iva2NrZnF5?=
 =?utf-8?B?MDlPM1F3bXc5TDlEcnMxZjh4Y3k1QTd4NVBtSGV2NVlIV3dNRTRHRWdtWS9J?=
 =?utf-8?B?TE93K2ZCZklpWm5Tc3hFRjk3bEw5eDI5Z3VjbFdJd1BTd1RReStpeTRIcGQx?=
 =?utf-8?B?WkF4MHc0QjhsQzMzUGxlcXA4bThYMzU4VVFZeTZHZnY2SkIvaTRRTkdvRG1h?=
 =?utf-8?B?QmxVT1BTZUpJODBaRy91TGo0dkg3ejBLLzNZU1I2QmtKcU9OcGsxUE9wZlc1?=
 =?utf-8?B?aklVMGVMRzNIYVJFS25ZY1RPdXp5WUVYT2VnSHpxVjVxQ2tlRlNVVFBJNy9U?=
 =?utf-8?B?MGkwbmRDcm1UZjhzN2ZwemVxOXlMSkFWVk9pSkJTRUE2blpWejFnWVNpMStM?=
 =?utf-8?B?TFp2V0hsazhXc3VZQmxlL1c1MDF5RzR6VkV2ODQ5OGFNUXdBN2NyN2hNNWFj?=
 =?utf-8?B?Q1FiaTdXT3EyekwyalN6aHRlcFBPMWFDbXpWTGFBZ0xlSERqaFNqbXJMMDhH?=
 =?utf-8?B?MXlVVVEzQktFOXBSTm8zektoWjAwM0JKRWYxUDNvNXc4b3pDWUJLd1ZGK1Qw?=
 =?utf-8?B?Qjd3d2p3RXRlbkhWNHFiYU9pQUVPazBoYS9OVEVpTHM4U0JDTlRrR2Z4b2dj?=
 =?utf-8?B?RnZHOG5QSmcwRUVyY3J1VWVCR2FJZ3F0czR2eXpxZnh0M3ByajBpWEd5eHZZ?=
 =?utf-8?B?VWxvYThaMDJockJYbUxsY1RvUDcxOHhmblFiWTZzek5iK3lYMlBLRnk1cXhl?=
 =?utf-8?B?a3B4eG9ZMTI5RWtlcU5JbFBDVkt6ZmhpUnNCZXFqMzlLYXFPZytxRU5tTFVF?=
 =?utf-8?Q?d92OeJkm7yM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ak5WQnZwc29EQllyT016N2pPeDcxR0FyUmI4czZ2bVUyZEdpbTFaZE5EWWpu?=
 =?utf-8?B?d0J2WkNDazdQQ3NiNVpta0ZOQXlpWjgrcHIrM3kycU9jNDJNdHA2QjR1TEdp?=
 =?utf-8?B?cGpaVks3WE41S3A2NHBvTXVMV1ZoRzdQS1NxVkFweUQzcU5JQXdlempNY2Iz?=
 =?utf-8?B?cFYvVHIvaE1TbW9HZVB5UXIxS3BUczBGV3UwUlNRc0ViOCtheTlSNWxtLzhX?=
 =?utf-8?B?TXhXMGQ3Y1U2ZWhEdVROV1lOVHlIb1hvV3VBS0ZzQTNxdUR2ZzFBVDJPVDQr?=
 =?utf-8?B?clRQUFlLanJWL0kyUjRaU0gyWGhGQWQ4VkprRUxzdHRjTHBQbkpNUkc0N2Rq?=
 =?utf-8?B?NEFzUCtzdEVZc095WkZZTURLekNUZTF3bFNoYkFZbUY4Q3h5c1BWVmVzeExq?=
 =?utf-8?B?enZyRHhuc0tYSWNIaTZ4RjdYRHZybGpTbU42TVN4UlJEZ1dUa0tpT2xXUzBy?=
 =?utf-8?B?OXJWb3F2YktOeDRFTnVxUkdhV1RHb3VxSTNkZEhOU0RLSy9qZisyVDVxZGlt?=
 =?utf-8?B?dmRadG5kTGNsRXpFT3B0cFhUOUxPcDNNNFVlcjNxUFQvMzlTU0ZMNlcxT2py?=
 =?utf-8?B?Zkl4Y25GLzhXMkpWYjhVcGptWjJSTzk5Z1RKcSttVldlYWIwYSswR0VjK1dR?=
 =?utf-8?B?T1h6NndyZjNINjIrRm5yU2U2ekl2VVhWUDV6Vlk4ZkloMFFWUlRXWkpZa3Ur?=
 =?utf-8?B?TGtINXRuRm5la0krYm9ZZUhjL2pzM3lBTXZLM2k5ZytsdnZTR0JGUVkzMGpV?=
 =?utf-8?B?d1NJRHlGcjg4aWlEYUNVN0hsV0wvUjJ1cHBsNzkzNnRyRmpCalBhekJHeDkv?=
 =?utf-8?B?VUdYNnpXTjdGcHMrRFV4V2RnSkpsTll0R3RhU3Ewb2Y0M2lMNTVUK0J2VzJE?=
 =?utf-8?B?MExyVGFvaTdsYXlzUW5Xc2RULzBpK1lOeTIxQmZaaU5nUFVJSGtFQkxEb0RL?=
 =?utf-8?B?eHFsOFJRREEyZkdFYjVOeW9WSGM1NUpRR0pLN3BpRE9WeWM3ZUhrNENzb3VQ?=
 =?utf-8?B?OGlJK2t6Q1ZPL21PNnd0aWxXWnN5bEk3cXh3MURDcVBVa09wbXA1dlZjNzN5?=
 =?utf-8?B?UTgxOUUrV05wQ3orclJFTjhvODhpM1BqSFRVakhqVk5nSEo4bXU4aithM24y?=
 =?utf-8?B?bzNGZ2l2TkJ5ajllVmN2elJLODlpQXVHbXVLUncyWjV2amY5K1lZYmlsbFZi?=
 =?utf-8?B?VG5ZOTFTcm9tcjVUbHZDRmRGVFRZNnUyWUwrSXN5WEt2azArYjgxOER5Q3V4?=
 =?utf-8?B?L2l1L0RiZE9Cc01DYk1raGNhTWwzMGRUa1J5UFVFNVNuaGdkQ1VNU2Q5YWRs?=
 =?utf-8?B?eGRBRHdHOFE4bVh0NGVzY2ZoTjZxOTZNdmVBMTlkbHl3bEZHTmpSR0tuVC9V?=
 =?utf-8?B?QVBrRFhZQ1hSMTRmZTZVZ3pOZWdsb1VWZjF1TmRLVEhYRUNKa09rMyt6Visx?=
 =?utf-8?B?azI0a0VSUzN3R0hpbzc4QlNBRFJ6dlVZZzhNRnFrckdxU254MFp2VXJGcHFy?=
 =?utf-8?B?QXA1MEtzZUt4bkN3c0V0bEllaHhOMXV4OWU2OXV0eFAydnVxdlRFeGJFcHFJ?=
 =?utf-8?B?WmduSHRkZ0xGYmhiR0pib1VmLzV6RUZ6WnMxbVhyVzgxNHRtTEdoSFVRV0VS?=
 =?utf-8?B?WUZ2aG5xSmIxL3o0eWJES1JqTmh0eDZ4SytmZnFuaFBrUFo3Vlk2bjJ0QUJr?=
 =?utf-8?B?cGNpelVpZTVvcWhhU1VZNFhjcXFrL3JIcGNUZkNnSGtENGtmY1h6S2xMSnVw?=
 =?utf-8?B?dWpDVm9BTG4yVXQyNVNuT3BWNkI4VXN2aHZMYXg0Mkc3R2taNER2NUFheWZL?=
 =?utf-8?B?UkdSUnkzcWtNa1ljVFBhaDF2YXdrQ0hMaXNPWE9WUWpEOGJncElKWlBBM0pR?=
 =?utf-8?B?WHVxampVOEU4NWFZUDNHNGk0amduazVpd1RyRllqTzY1NUlmVjhFK2lIS2I3?=
 =?utf-8?B?dGVGZDZRcmFFRGRwSVpJUW5KWXVmdG0yV3h3U1hkdktQdndxSVBsNmJleE4v?=
 =?utf-8?B?TndhRXBoa2FqSC9HeTg5RnhCQzJlZUFTVm5CbFZaSHVMenk0WG1VZzFXeWVm?=
 =?utf-8?B?RmRKZlBTNkwvZEVxMVJreUt1b2t3ZFNpWVEwaCtYSUZqcU1pdHREZlhORXNl?=
 =?utf-8?B?L3dmUTROaE5UeFJ1MDBPZnc4TDJOSTdQRlR5RHhUWllaSGIybjcyYzFyTVB3?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9b32cd-ba8f-40da-b756-08ddb86463de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 05:59:07.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfJAOAJOn23V4CB4hzCh3gnUd8Rg42tS8UOyjhiwgb4OwknPyTPoBNFAFfjHl5aksc803SolXoa+7hr3tjEq1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7076
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Jul 2025 05:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19269

On 30.06.25 08:18, Jan Kiszka wrote:
> On 26.06.25 11:09, Claudius Heine wrote:
>> Hi,
>>
>> here is v8 of my patchset.
>>
>> Kind regards,
>> Claudius
>>
>> ---
>> Changes in v8:
>> - Rebased on next
>> - Added documentation about the power fail scenarios and the LUKS header
>>   example.
>> - Link to v7: https://lore.kernel.org/r/20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de
>>
>> Changes in v7:
>> - readded tpm2_createpolicy for clevis
>> - Link to v6: https://lore.kernel.org/r/20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de
>>
>> Changes in v6:
>> - luks formatting of format-if-empty will now be redone when if it is a
>>   luks partition without a TPM2 token, this makes it a bit more
>>   power-fail save
>> - Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de
>>
>> Changes in v5:
>> - Switch to use TPM2 protected password instead of static initial
>>   password for encryption
>> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de
>>
>> Changes in v4:
>>  - improve documentation and commit messages
>>  - reorder commits, to put re-encryption recovery up front
>>  - extract static temporary encryption key patch into its own
>>  - switch from lsblk to blkid
>>
>> Changes in v3:
>>  - Rebase on current next
>>  - Extended `noencrypt` documentation
>>  - support clevis tokens for re-encryption recovery
>>
>> Changes in v2:
>>  - Added more descriptive commit message
>>  - Added more descriptive documentation about noencrypt option
>>  - Fixed typos in documentation
>>  - removed unnecessary setting of /conf/param.conf in initramfs-crypt-hook
>>  - added re-encryption recovery patch
>>
>> ---
>> Claudius Heine (4):
>>       initramfs-crypt-hook: store initial encryption key in TPM2
>>       initramfs-crypt-hook: add re-encryption recovery
>>       initramfs-crypt-hook: implement 'noencrypt' option
>>       initramfs-crypt-hook: add 'format-if-empty' feature
>>
>>  doc/README.tpm2.encryption.md                      |  57 +++++++--
>>  .../initramfs-crypt-hook/files/local-top-complete  | 127 +++++++++++++++++++--
>>  ...ypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} |  13 ++-
>>  3 files changed, 171 insertions(+), 26 deletions(-)
>> ---
>> base-commit: cad5026bc860a2eefb828e03a9205ed8803cd958
>> change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
>>
>> Best regards,
> 
> Thanks, applied.
> 

Dropped this again for now until we sorted out the buster conflict.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

