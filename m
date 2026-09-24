Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C22BC98318
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 16:50:08 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3004.1790268602493509381
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 09:50:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EPAVJyIs;
 spf=pass (domain: siemens.com, ip: 52.101.72.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNm30wtkRR4TwvidrawC2nrJt/1wvga9XczilPdOoo33NNmiiJhkI0SddzFnQX+fqsD7zkBLn1f91ZsysaWXkzoocaTZ5F7vNOQ6+0Cy1kwu7qxZTUPMpZEHJGv2J8M68BOvOSSc4fJEYo94wwdGCfZgEVsmciPTgwqhxj9g+zHPWr0fkCTegOASGHD5j1mFZ4FoGQyZUCzzgYqiSd8ZsOvVmneIHGjfBWHPJsIRJL4+2E3jBihrdPfzPr6CuoU+vwJpi2Ub+YQ91WbDIwzmwt5VVTG8a67o2Eeg/buZhNEXYcGH2V0DAqvHoGn6IiSznNwh440pli7F3MJSnZRSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgeGIiuN/+vS32lsgWS3/6Z9qLzWrbzrIQn6BrayOoQ=;
 b=wieG8pPNmXiAOis4/0519fqCcNhJ6PNNz8UeOpgTLl+Fq5cd7C3ut0CKszb7loQoTBtBNEcgtsWYjMgdAtjkUpEeW/Ss2zl14J7pbGajeuvQV7NhCPfbmSouoAMIGiexJoitlPGeoG1jVzKbt9FwGCSR8tXgv5aJN7iB3icFEODOl5swHvSca35huHM5gbxaA3IldNkSPSWw+sopTXFxt9rCLAOmr5bar5vgW+udJIXhefLS/iKO9V4LWUuzxNvxn9iQG3UwnzwEWpyZaH1/Uvy3HJpzDds6ui7KtZV1UJmAjE8k0zgVnpK3fsBHv5Jp7Z9lDlZ7Upg81+Cul6zR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgeGIiuN/+vS32lsgWS3/6Z9qLzWrbzrIQn6BrayOoQ=;
 b=EPAVJyIsR6ZO3PIRZMBMlgp6iAlFuqhFHAKIfEdRUZfM/Z2tSc01ejXmo92ETUaI1rdgXpuCHgLHFXFXKalgBmaaAoaPEMK2vm/9PBLsfQ4sI6yphE4LpycPuA6ePto4RDwj6gHRW3S/frTyvf47fy6OdKkEWVwVOUHwnab3FDdytPZabToMsbTkuY+65jcCnXphDRo1COhGeu8NNjDSUOO/EoEMJu2UDm+UcvpGqSw8P6TL0KwfVW6TGwD4bViktLpB8EhalVX8Ek64hebjox4GffsO/oqanquEM6EHnK0uqVgc4ITXWxR6LLU3GhYs+iUAFNfiROcN6SeuM9u0Aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 16:49:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 16:49:57 +0000
Message-ID: <37ef9677-98c1-4e48-84de-cc172588250a@siemens.com>
Date: Thu, 24 Sep 2026 18:49:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 0/2] Add support for Renesas rzt2h-evk
 platform
To: Hung Tran <hung.tran.jy@renesas.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20260924114529.962-1-hung.tran.jy@renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260924114529.962-1-hung.tran.jy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 489c2af2-f051-4943-7570-08df1a5bddcd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	MBbl2hNsAm9Y1N8k0JZ3JQkEEDSko03vB7bgERyQ1a3lj6X7bRwJSKHMw/q6wShm3wNgcGdcsiVUZyKZgsJ/TVY/vk50Q0+1HM55bVlSjCIgKJ56BzJWtxXKyz0jSMsgCkxQ1ojrueQfOv7U1+J9iPyuepsx9feGVwpNTbShBN10ojhtRF4mcMGLmj7wwoQyTH9tbzeW4gGWOA1pJ+K+JPVp77/Xu4GBgA22pAgrvTdv8hlDY8Zz8QNFTLW0NhmtvrXoyrObI3cvGHe/Tmsx45JT6OZQtkKS28g0H1Qzc4yoJRFvnf+z8WvtnjOGi/4tkZKmZVuy+cXNWvJK/iFxRWI8n2mqbMoQdHOhAX/UrS80L++uPAuyVS8OvUT5K7p8T/yKmXdB97mlZ+2IeJCHAvrjBeXQTeEwNKsye0me5wGO/2y4UulT99l2CPj/3ykUfSSl5Hne1ST4RXFzvw09u9mVL/69T518uzduYlAiljaF4WCPF55aXlhNUdwTj4wyIaSqrAKoG2QNVecjSO8nUplfLCWhGeMpbCQBWdEp2LW9Kh2PjPs/4+5NbkdYxdBo/1ySLjmcuTwIdiivKXL6dnDMOiLJkJdH7tb9FNKN9Qt28Ck8ZN/0kaL3/Lc87CGBkiF2XmptzQWqf9H7EyjNNtNxq+UUpHtVL4ZjMXgEc8c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0Jva1hsRWllb0gxYVhKWmFaZnJHcldObmpXRzFMSkV4djR0WDBMR0tjd1l1?=
 =?utf-8?B?OGxhYjFHcThjOUszR1BPcnZzckxTWDViMHNyRVVXdXVoMzJ2MDRWcEdKRWNr?=
 =?utf-8?B?WStVRU1DeFdNR0lBMlA2K3VrZjhVRG9OaEM0Mlhzd1dnZTZzL0VKems0RzRm?=
 =?utf-8?B?QzgrUm45STVBVG5SQkg1UTVoRFdGSitzazhGSVhINHp3bWgrQm4ydjE1alNq?=
 =?utf-8?B?ZEE5VjdKUjNMcmVjOUdJeWJqbFFzRUljNCsvQitPU1g2d084b3pPNDlkWVQw?=
 =?utf-8?B?d0NGeWtLQ2tvbVFCaEtLUXBlTUd0MFlhNzVJcy94OFFzczJyNEFlRG84UFQ4?=
 =?utf-8?B?L1hUcjB2SnREUTBoekx3WHJVOFJ2RkRSY1F6SUJUL2UwWHo1dEwwOHI3U29Y?=
 =?utf-8?B?WWpIdlh5UWpIYlZ2QWlZV1F5elBjQ2ppWWNuVFltdnZXQXA1UFVlc095Uy9G?=
 =?utf-8?B?Zm1DaENzQ2lUeXZ1V2NmVWVCU0VGck1qYS9La0ZvT0JWbjdRM1pyV1RCS0RT?=
 =?utf-8?B?OVl2N1h2MkhYUjdJME15TDdEY1VZNmxyUVc4aWlvUlZwQ3NBWXZ4NmEzR0lk?=
 =?utf-8?B?b1FlVVVqcUhmeStvMkZwcXRzcVRBT3MyUUFnYjNTU1kxdzIxcjNSd3dmYkJG?=
 =?utf-8?B?U2JvZW9tRFVDMWNtdEhrT3YrRlBmdDF6V3IyQUtEMmJBN0hCODNrWVU4cGlt?=
 =?utf-8?B?STF2UnlXUTduUnRJaExFQjRwN3pTN3o5L0xCS0VlOEhYZHpiTXZqWUxleXJV?=
 =?utf-8?B?TFpGL1BuR3Y5T3NXeEhEeXhVMnhaMFQxSnIwNCtsZUFDQ0RRTFNMc200eFU1?=
 =?utf-8?B?amIzM3lmVFA0dnEzUjdGVFg5T2h4SXpwMW1FRVdid1JJMmhab2JpRkh5LytL?=
 =?utf-8?B?dmJkckYyZWRGUmVKSDh4NWdyMjVqUXgzbmNkNEVSSEhyK3EyVnFKbWFWL1N2?=
 =?utf-8?B?djF5d2dPbFA4MHlyaUJObTVQOE92Vmc0NGlZdU9NcWU2bU9vc0cxak9rWDBI?=
 =?utf-8?B?NUI0bTRSclJzVWtKMTlNYVRYTWRpcjBKc0k0WHIwSjljSUx1RmExM0ZoeUlt?=
 =?utf-8?B?NVlwM2E2V2RCY2piMGtjTVcrd0VEUVpzODZlMHNSS2JlTEtkd3dnRExvNFBN?=
 =?utf-8?B?WEpVMkEwSnFWVkIxUStXTmZkUVR3MW9aUVN0SktTcVBiVHFFY3Nld0tENGFi?=
 =?utf-8?B?dWtZTDlUUmtabVBTbDBqSFpHODJvOTQyNGpYL3cwK1FKd1RJMEkxbWgxUWxW?=
 =?utf-8?B?VGZ6K1VaSTY3YmRSRUJEdmR4MmpFRXJsTm5wcTdGWnAxNm51UmJTeFNRVlZS?=
 =?utf-8?B?RU1ieXlVT2hzZEhydzg3Tkprb3BMVDFMVmJIU216bVpraTVDK0RqZ3U1OXdV?=
 =?utf-8?B?a0pKSVRGV1dUeVdaNmFMNk1aL1dkbjlieCtWVVkvV3pKdUJmVVhuWUhCWXM2?=
 =?utf-8?B?RUI4WTc1QlB4cmk3bUg2SllrTjYzM0JlNUNwUkFmNHhFdkVDeXpnSVhFTGgw?=
 =?utf-8?B?SStOWDV0MUNXT20vdk5GS0toQmJQMGM5YXF6VFlwMEoxQXNqSkhlTmpwbURM?=
 =?utf-8?B?Lzdvem5zcDE4N0lLU25qbFdMNHdiK0h1emZHZXQxcUV6N3RmQS9SUmFwbHdT?=
 =?utf-8?B?NzFHNGM1U21zNnZycmdlMTduWFNMT1hNTWp4b2RNWTJBR1JQWEdtcEJPekFx?=
 =?utf-8?B?dHhLV2hicVVHNkc2Y21sd2dEMW9kRXhzS2RqZTVlY3V6Qlc0WFNTY3pyaWxB?=
 =?utf-8?B?QVB4ZkZzLzFnb2w0M1dDdGNwdkQxSlJOSnJHVi90QU5zWWtISVdWRXRiV1ZK?=
 =?utf-8?B?SThPU29URUllNjJmRng1UG1UdUtTNE5rWnE1dkE1a0pBdUI3U29tMGx1U1dk?=
 =?utf-8?B?ZjBQQ0NINGpBcVU0Ulh5STVXbkFyQzVLOU91cytzS1diYmVsQWdtR1k4eCs2?=
 =?utf-8?B?VFozWmRJTm9GUmpoclNVMHN5L0xKLzBmdkFBVzROUmFheTVmZVk5R3VLbWVF?=
 =?utf-8?B?YlBwMGkvbWpreHFQUzJMbTJWVVdpTmZLTk5GRW4vVDVScEVEZ0ZidGRvYk1p?=
 =?utf-8?B?UmJOSCtWQVF6Q3k5V0dZZmwwWVFLRHJ3b013RVhnQTF6QlF5REFRVjBQYlNS?=
 =?utf-8?B?bjdSU0UxaFdUT2VvMktadU9EOTB0aXJnWmoreG12ajBCeVpGcDZYbTdpTlBs?=
 =?utf-8?B?bDdUV3BkOWJZWGZvaDBnaE9GVEliMmkxSWRjZFpMbXNxejYzSGplTmthM211?=
 =?utf-8?B?QngzWW13YWVLUi9zT2poUWFEZUtrcnFQZ3hKNUJwYitvWUV2cDNTWXZtck5H?=
 =?utf-8?B?VVU2TENNSUF1Z0MvZlc2eEl6U2tFdmYzbzJ1cHNRUGVSNExzYW5TQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489c2af2-f051-4943-7570-08df1a5bddcd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:49:57.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+4hMeRMp20U/5sLPXZjwBd/E5PjEcwgoUYaqF4WjpcdVMD7lfW9tbR04V4Gv3wbNXv2xs6cca3CtGTO3zi3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8475
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 16:50:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24338

On 24.09.26 13:45, Hung Tran wrote:
> From: Hung Tran <hung.tran.jy@renesas.com>
> 
> Add support for Renesas RZ/T2H EVK, which is the new reference platform for CIP project.
> 
> Changes v2:
> - Remove unnecessary exclusion with 4.4 kernel
> - Add CI
> 
> Change v3:
> - Remove CI build for older releases, only keep the latest (trixie)
> 
> Change v4:
> - Update commit description
> 
> Hung Tran (2):
>   Add support for Renesas rzt2h-evk platform
>   ci: Add rzt2h-evk build target
> 
>  .gitlab-ci.yml                    | 15 +++++++++++++++
>  Kconfig                           | 12 +++++++++---
>  conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
>  kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
>  wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
>  wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
>  6 files changed, 88 insertions(+), 3 deletions(-)
>  create mode 100644 conf/machine/rzt2h-evk.conf
>  create mode 100644 kas/board/rzt2h-evk.yml
>  create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
>  create mode 100644 wic/rzt2h-evk.wks
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

