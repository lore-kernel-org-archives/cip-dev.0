Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA410987A5
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 16:25:25 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17200.1774023917472659985
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2026 09:25:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aqmRKR6k;
 spf=pass (domain: siemens.com, ip: 52.101.83.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7nU1f5DsquoSTueXri+kCN8q+aqNj+WxAssOFMFpyA08WZuZHUvh1kshJw4mZR07sP6El3cxy0EX3J5rdE1dG2UxZTfxsQ9vEkYdK1V6SFDUylGE+UM0yTpibxVTgyGGHd3m1JQesz75q7lzC968ZJRjWf1t8VHvliqoUGerXv44Gtqb6mIPRqsrPXlXItpYxzlUBFevJOXjWpjxWcc48AmXjcQKkmdSqqVKhrlqcaG6f972K7XFMD5RQzNjQiwpIIxRULmeGu8qWS2FpYx5Ss06GrxOHvxq/hFP6REHIXm/dGG+/aTEBbtO2SUmtngXlrQ9H8IcHkvK4wOrFowCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VErF53oLKVPrOr46s6mtGQy9Px7cTIKSkaDqw0FNV0=;
 b=yYPG044psQVLycI7z0dXINROgFsdDkT4wD9nZicclN6tu4ySZGTOGv2I3BoR03avGr5/FUczmze8zB8JbDDLql4A+GJCtQQedGt0gQl2PPqj1JzKJUQXokDZNEN+Pb1WUS2G7esYMMorjwzv2uOT37R/w9ZFGUhCFGT6ADo4lYw3MdUl8002+aKcEKR43WkLZZabSTNZA7Gc4rVM/3jpY0xRC+WknMK6DW4JglsDtDNijOv09my8/zsokckfLL4C5L8XizrC2EGtP40Y1E2rK6Tq2arKgKbRauZhVdIxgEy+Wm+sA3+WsU9DUUxxBYOIy52whW7AwZ91wTs2a+NCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VErF53oLKVPrOr46s6mtGQy9Px7cTIKSkaDqw0FNV0=;
 b=aqmRKR6kTOV8fPfJ2cDT+8mibqSGfCWouoHMw8vbFupKldE6pRC1lEUBvHBZqjwi/fsF5VUcawxSVK13n/QdHQYBtXGrS/i6fUx9DVql9pKsX2GCCUOo2r0ORfOfk4sNPyfvCnD0tEoaBb/Mt60KcpbjDEW7gsHyIcD7mw7pHSoUDNbm6zMEMDRMWbhYVFG5EB9RBshQERpHjVokML/tRkA8ix78c21a74d9CGVhc25mVjXWkPzEWgXNd47BefBzURs3pJI5DiNp8bw8hI7/0vNoFByLtj/7aIif5gZBBIPM5V93DlX5Pn1GwkzxLvtFRMVkb/SPCRIycfFA6Mf/7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 16:25:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 16:25:12 +0000
Message-ID: <ef4fc025-72f9-44ad-b358-f7e707d7452c@siemens.com>
Date: Fri, 20 Mar 2026 17:25:10 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.11-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1b7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: a680c1e7-4fbf-4692-8ca3-08de869d42af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Zh42+nlaHLpYLmIjHmQ0/tfiSx7VT5pmWgW1KojiPjocQtfOv9tMk6ims0L9wC3m0YfvQs2tPyMyAcuHLbUbMwvv5ou8/I0bxXxBR7jQFZVUbMN3kfdu3UMNUvTTsIeCSezx9M5+ohXm7GbXDoaezEkyd2DEpjR/96yI4mPUqQIgRxCdDBprcggpL2x9NU20VCraWitMkVAQJXNBDaA0m9OvInVNcnxfOCfjHRHkG0uiVPZp+AKkRlAIALymT1ewwAR+s5JlPU8bff9LlLF1AMRQQ7A9uf7oYiGlOTIE7wjVdF+Ot2Bf7hbNRikxDSczHI/tsvHkgMP7gG7m0U1ubNfYmipV3z2L+lka0hHpl/oQlOCUjC3nrAGBpMG/8OqEHeXMTHwtNB9dRf81MY+fXrp2sH6oOyl92kq+3Nojvzy1Ykgrm+LFy7PEEi1f0GC47YgAmg270YmuSAio4ZuCKX6eTs1zWiVEy/+yOjT4t1RAhYtB8X6eVEFUI/LEZk/gBOwzfnLbR/thE2RvVvAya+9h1uYpTVn540QHxNqnpYvXsNIzd8fe3E4T0R2klnCyBJRqvGRA8ipQAUYFPqOuUdWnGzI/CY4AO8iR22kRKPvHFLLcctLa2TmN/HF/7BmoKX4sF5TmT6rvS1sUATPvY5j1URj0iLAHfJJMQgT5YlA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHNTcW1mNE9tRVhudWlLQmgxdnhoN2xKSDk2bWtRMVo5UlIwclhOVUhSR1lU?=
 =?utf-8?B?QmFlbHlsVElUWXdFTjRnaGVHNjB2cGVSMHUzZksxbS9zOFlQeW10dnNxSUoy?=
 =?utf-8?B?MDFDRXh3a3pJVFpZQWFFdm8vdVJYY1c3NFZHT0tDUWVkcS94RkljZ3MxNXQr?=
 =?utf-8?B?c1FEOHlxNzRSdytPM2VNS0hYQVprdzhBK1NhV1RVdm1idzc2R2FjTHlyOGFW?=
 =?utf-8?B?TGZENjVCdGNKaXhqWkZ6OXk2TmZuSER6Y0QvOXdaN0dmRXhpUGJvdE8xT1pM?=
 =?utf-8?B?TUpKZkJ3WkxzSFRlS1c5WlgwVVlaLytPQ014RlZuWFFrS1A1NXZxTFZOSjFr?=
 =?utf-8?B?YXYwWmxzMmYrMVI2RGpHR2NUaG52aWZDc0tUdEVGTEgzSnZqNEhFcmlYUUhp?=
 =?utf-8?B?clZQWmUyRjBNVEVIbTJuc0NHMHBCNWFIK0wyOFlvaTVlK1lxYzVvRThlYm9K?=
 =?utf-8?B?NWtpY044MGJONXVnTkhuRXUrZmdZMDVyWmQ0WERIeHdFLzM0T0hzRDlVemtH?=
 =?utf-8?B?RGpCR3o3MW95QnBHcWZZWmF4eTZIbk5YRCt4TGRCYUtvRjllNXdDbEJiOE9F?=
 =?utf-8?B?N05kSm5WNitYeEh3UGx0MDVjSDFKLy9rNGVsV0RwYXlEUTBQZ3BzWXBWL0Z1?=
 =?utf-8?B?QWxIYm1jalhDaWtHOFpKMDZNbXAvNHZCaForQkR1TGFtOFJlNzh6YlAya2ph?=
 =?utf-8?B?YjJHNFdyajN6R1B6R1NKWFJoVHdBQm0ydkJWNGloSks3bTNONEliQWJGY0JT?=
 =?utf-8?B?aTRzWTZZa2oyY1A5UTFvdTlqUUw2alk2WWFVTEthZU5oNzlvd2JDcXM5c1J2?=
 =?utf-8?B?T2NQVHBVTXFLTU1scnN3dDFsVTI4Q29SRjVYcFp6R3hWUmtvOUo0bjBnWVFK?=
 =?utf-8?B?RVc2c0czZlZPS25IM0NjNGE4OVQ0OTFBZXNwRFV5c0Zsb3lnWGlqRE1PcW41?=
 =?utf-8?B?L2lIdWY5TG0yN1lYazJsNmltd3BxTEovbXptZ0xiZWNLckljOVByTktldnFj?=
 =?utf-8?B?RTVnMGttbTZ4aDBVQytEQ2N5RXF6QWs0TVdkL2l1bnVxUjVIU2xBaTUxSWtF?=
 =?utf-8?B?ZlVYczc1RjB4RFNJeC9BYXZ3d0ZSejF4dk1iOTRqZkJBZlQ3SmFEK09FbkJo?=
 =?utf-8?B?Mi9EYUtCKzVXc3ZqZlQ3WEJLT0dUT3hYcGI4TzArRlZGalNtdExDZEQ4V1RX?=
 =?utf-8?B?S0hWaEpiWnNvY3Q3L3owM2NpWVBNZjJiOHJydFEwTTZXNHRTMzhObzlnSkgx?=
 =?utf-8?B?WlJCb1RZNGM5WVpsTnUxK0Q5V1dqMkZyUmpzcW5EcmNVUkNUdG51VDRGVjRt?=
 =?utf-8?B?TWJ2bTRHUFc4azViVzNySjNzdGFEUFcwS2V5bTBhTHJXTTNaK3FNQVhxQVc1?=
 =?utf-8?B?SWphR2VRdmdEMStyZmxzQ1FSa2lBRk8xM2hOcUJYUlJHL2llNzMzRkpzR1I4?=
 =?utf-8?B?L0ZMaGJ2b1BXN0p4WGJFRDBaeXAzQzRXZ1NiWERPR3VTZVVmYTlxYlova0Vx?=
 =?utf-8?B?ZStYQ0cvQnVCTVFIV0FsaS9yZHNMSFRBcVJVV0VqNU1Ta0N4U08vRXZmNlg1?=
 =?utf-8?B?ZjdFSGdzYzhWeUY0NlFTT0tMSy9rWlpZV3hDbEdhb21IZm5PbGh6SzkyNDNq?=
 =?utf-8?B?dkN6TnJLQy80SU13L29CTzg4c1NDeTlVRTF6QkdLZ3FLdWd2SDFVT3FlVkgv?=
 =?utf-8?B?ZmdHNWlZRjF0NTI1cENhUWFWMkc1VTJPK2toeGhlY2N1clZUZmdURXdsV3lZ?=
 =?utf-8?B?MjJYZXZ3QklCT2ExRXYwMkZCcmtQQk5jZXNhcUpucC9ZTHpyY1ZjeFloNlg4?=
 =?utf-8?B?SUdaaWYxQWNQa2dRazkyUkJ0UWs3V2pNTXlXYktGQmEya1JjbFJUdjF1anBo?=
 =?utf-8?B?Qm9zbzlPWkQ1MXFpeGhhZVBXaEFoUFNRVittZUJORkhjUXFHS2cxdnVaTmVQ?=
 =?utf-8?B?RFhzd1VFblRNblBIQWoyVGJueEpCN0V2cmZxV2x4TTFxUlkxSmdlZUNHRVh0?=
 =?utf-8?B?VUxmb2hyTDA5WTFXVnM3Zk1aT3FzSU5YSVhGMDlZV0swZFIvdmFDNVNGdjJq?=
 =?utf-8?B?MGV2Q0ovQ0JjblZHQ3R3RDJoYWxGbzFaMW9MZlVxME1qaEJ0MTlVT1hiNHNj?=
 =?utf-8?B?T1g4S1ZmbEtwTWtoZXhIWW9tVGl3eWk1SzFpa1RUVkdpZVgzRFZSR2ZqZTBl?=
 =?utf-8?B?SjAyRFhwMGhQbk5Yc0JxYWptVjVDTlV2cFlBQXB6eGlyN2pJNEgwZW5BWkRP?=
 =?utf-8?B?R0R5eGhwczE5SlpYcUUxVzlRV2NlRmJSUmI1b2ErSURpKzBSeUNmMk9FNGRt?=
 =?utf-8?B?U0YrSzJwYVg3eis4SWZYN2tuNEpGZzg3Z0dWTmNINWdpd01pNHJBZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a680c1e7-4fbf-4692-8ca3-08de869d42af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:25:12.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clWZ+v7SZG1yeBdQW44uGlR1fc/+5uf8e+WEuPuQXpeVz7QUVSsACddDYr11BDCgTAxE88IXaqfDzws4NArA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2026 16:25:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22518

Hi all,

here comes rc1 for the next isar-cip-core release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.11-rc1/isar-cip-core-v1.11-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.11-rc1?ref_type=tags

Please test now. The plan is to tag final v1.11 by the end of next week 
if no blockers are found.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

