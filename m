Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA774C4332F
	for <webhook@archiver.kernel.org>; Mon, 21 Nov 2022 10:40:36 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.57])
 by mx.groups.io with SMTP id smtpd.web10.35345.1669027227621269214
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Nov 2022 02:40:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BEDFIbQt;
 spf=pass (domain: siemens.com, ip: 40.107.21.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6q5fwGa4N8vq14BExJINENrWA2juJVehkCHBJjdhu/dpwICpiOxyRFxzYlPJSZkpsbaCTRKtIWyQfex2pIlY/4bxTPD8piS+xNm5ERHPJDpicf5gap/E0dylj3ynr8EoLf3bH3f3uiMSHFt91e/8qPwlFa7Cvey7a8RZ1YMwL8XZz1Pe0Lo5W6JPoy8C0dYR2q6qdg8TdX2h8cNKJyTn5SJx5zwOl8Tiqht/gkud83w4YsJUcfzRvVXwyCKsPSmJ1TWWqcGI4Vn6h4Gwx7KRTX93dc824HDtKKvSytgoD1XapUxxsONmBSDF70yFI8e3qSVXg4DeXl7Mq2ByWt6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ixX6DCTHYX+9PoN6+LX5zZSkPosFB6izHdLepaN7w8=;
 b=hcq/ZoX59p9WOrDKtLsOX3tjJywbouX97aPdskNxsCRjEP9OMh8s1kM9w8OaXfK5OMATgmcb1vA++cpW0C6FS/ONRzMDIXcU2+pnhaXyHPFroiiUR6bw8he5kkLn8KaHBCkDqKaF3Ni3TS/9oYU2Eeg6/uPxwiVQ3uPajegjTwU3Ktf3fAkFBSdejEdpUYXmCW1EcZlyYu3euNV4kYxOp5crOYZ2nRFhOpotU4gY+G9LjZ0R+61Dv5g/8PZa4efHquMy/xIZnoZEzDjSerpg7kZZgOt15mjPbb6dezlLIjxBtMTXSiGWa3C0kr/FcqQlRKJUgahTkQGXMdL1gtXKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ixX6DCTHYX+9PoN6+LX5zZSkPosFB6izHdLepaN7w8=;
 b=BEDFIbQtxs01Hwv4fs7jOenq+FUdXnfaEvZPHdJaQ4qZA1N37ntmNMCH6P464mBUQEVsktjQDwYoucblvZhvdu1iOUCzgQ5sfJqZ/6N3FbHe268TCklrx4DLyUX9dAFvZ7BYJy4mwPs5O8B4uhBK4CdV/Ed+0UZZtparDBqFvZBMaYtTs5QWuJ0ACXSd8+2Oz5y8O2lY5rsz52oSUIY00Cql8e0r+8arnWqqMLfpc4ytVQ35sdYnBSrCh6vQgqEhLvJmeHoZtxrs4+wyOxcDNqE+7vzSQU1CqIJMbZ8VIl8ziwk8f0too4wqacTHawHcA9WRqweZivmO0ZtwCnHdmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 10:40:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 10:40:24 +0000
Message-ID: <3512a1f1-a15a-22bf-3b08-2cc6a85e668e@siemens.com>
Date: Mon, 21 Nov 2022 11:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [isar-cip-core][PATCH 6/8] change ebg sb signer and secrets to pk
 kek db
Content-Language: en-US
To: sven.schultschik@siemens.com, cip-dev@lists.cip-project.org
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
 <20221120204711.5826-7-sven.schultschik@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221120204711.5826-7-sven.schultschik@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df866d3-ddd0-46ff-d199-08dacbaccc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9f20wYc6eXEBuTJXihhm4R1T+onap7foj9nOP6lPOMyTsycdEWjMfzia6M5u1p99Qmwu0uGu3bT/etF0haPgezkHOwGEntBUwjex2zR3GdmH3Bw/Afwv5huLcGgbz8GJyFArK0hyK2mP/zBVHDW1p0f1MaaZL8mxOfm6wX5fVm6Mu9PiPOdNviRbSIdhvCTPmxB9S4+ZgyZUOSW8XQL1TheAx/oCMpxFppeOr/Kau06CLJF1PpW34Pu/yJKnwWflwW6GKMwZMhOFsHoA81bJGp6208U0apgD25w0XR03OmRhjxbm5uNEdhjaZzji1qxkChChNdwzjRLYKtLS2pVMg3Woag5WeAcvPfjnoq3slEuX2bVgKYL1y49ePon8MSgU/PE7v1fUYBXgupQCM+B7pjLg0v+zox7ZkN0W/0uLuH5Bp1S++Rtb+02Ubbu8nrDbIE60MH8fW+w8qLRQDfd3INookpjxseBJyjodyvZC87EZceWQ2RlSF55QSTH5E+nCDRWjyk+QpQJEKS6iPNnQwxyXgPgE/siAoqC9zp7iLRLHfrOYKa9yzwmix5ExHAxk3L0IMBz+Nh/L/7vNUmxu9i/NmXqEJL0MAEzOeSwd7bS2Mo7oSPo4kU8pl+QNcbSI7jyW5jPaVnUjWVDyXTIDMHj500FAuQleHu8LU74O3ppKmI8dCmqN7G+5tpDartXxhiNw9zA4Tvn66V2h6tMg6UCVylH9ZLtHx9zxARL533fVmMwIMhSObr7wNlXu9BIG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(41300700001)(4744005)(36756003)(44832011)(8936002)(5660300002)(186003)(2906002)(83380400001)(31696002)(86362001)(82960400001)(38100700002)(2616005)(6486002)(316002)(53546011)(6666004)(6506007)(31686004)(478600001)(66556008)(66946007)(66476007)(8676002)(26005)(6512007)(14743001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0ZyUW9XNTZvZTlNemFVN3B1WFhmaTlDcEs2WC9LSFl0NlZZMXMxNHo5eTBx?=
 =?utf-8?B?NW9mVTlZTkJxVDk1eS9NUld3b2QrVlJmd3FBSS9qZjZGQ3JMak1CUGptbERI?=
 =?utf-8?B?bUthVWs3cEl6Q3BZbGxhbzFqU0c4L285TDA2MkJvMDFHdTZQSi84Y21lZjI1?=
 =?utf-8?B?dnBNbFV0L01wZVVzNndqQnNldm1xcnpLRDRCalVZdVNlL3hDb3A2M2Z1L1ZI?=
 =?utf-8?B?cXo3dU1BRURQQWtRczJRQ29TUklHcUUvZ0lvM21zbGJVanNCYUZZSU1Nd1pj?=
 =?utf-8?B?UnpNS1RjdnZCMWRyeEFnV29xVW9kL3VXdzduS3lRZEF1MDk1RXJ4N3BrdlVp?=
 =?utf-8?B?WFl5cnRESTFhd1RVQTBQYUtSQWxoVUhZNzIvOFdaK292eXA3V3I5aVFxaVlw?=
 =?utf-8?B?eVp2R21CN1dYTmVIT2ZuOHhFSVM4RmFERHAybWhIQnkvb0xSOWRJWGkwU21z?=
 =?utf-8?B?VG1pMjU5dTM4dERPVzY4UzNyWHNZemt3ZzdRaFRBejJjN0ZhcC9LOGdtckRi?=
 =?utf-8?B?ZGs4dFp1KzlpWjc1d2V5eW1qMDRSWXFTMmVNa1VleHcyWnZKTEFFaSsxWnFE?=
 =?utf-8?B?ZzBwZDRhOXQ4UDFRN1Z1YW9WWXBmL1o1NzlRVXFSUHBBL28zTVNuOWV1YlVh?=
 =?utf-8?B?KzZDRTk3eStlUVpaT3Z2Vk10cjZMMVRaa2syMHluamVJckcwcWpISzdOc2dD?=
 =?utf-8?B?U2w5WXVVcUtxTTV4Z0RDMDY3TnRaTW1raitERy9WTE1SbXlXWDF0aU5McmVK?=
 =?utf-8?B?SDNHUXhQRjh6a2MwRTlWMVZEZWsxRXI5QVlZNGt6cExhVmVtcWNnZ2NTQzlU?=
 =?utf-8?B?WDZSZjVwcS93NVBqNlZNMTdrL2trMytJdDd0aHNyRUFLelBQbUFBeWN2ZXgz?=
 =?utf-8?B?QXFOeHhkb3ZOTU9qVHVsZVdFN1FyUUJwVTRLRnhQRUpQMFdPN2VHc21rZ1RV?=
 =?utf-8?B?UjRKMThHOGc3NzR2ekFVVm9Fb1luQXJvSXByVzdQWm02Sll2NjJ4MEFwUW5w?=
 =?utf-8?B?NlB6VUthcnpvdmVFanJWL2djdEt0dWs0ZUZMWXE3V1FnMjJ2QlVlY1F6V1ZQ?=
 =?utf-8?B?dWN2ai9wWlcxaDZNRlJJVm1HUVJGODh3eTlWaXhxNksrVXo0dEcyUnp5d2N4?=
 =?utf-8?B?em1WNVhsRkUxL2RjcndJeXJhWnVIT1B5c2l3MnZ6Wm9yTTREd1ZWOXNJc1ho?=
 =?utf-8?B?eHZmamNqeWZaWmx2aXg1RUVDblZMc0YxcmZDY21vcmg1QVc4WTkzcjlxOW9j?=
 =?utf-8?B?SEFKdTNCOXY4dXVueDBPeVFwNWVKcVVicjlMdFdLYUVzdGFySEtvQ1dFaFBw?=
 =?utf-8?B?ZkNQNVNOcndSRCtoaUN3YTQ0dXBsc29oUWdDa3dYbUF5ZzFpTk54REhaWnFB?=
 =?utf-8?B?aTFyWjJiMHJhbG9HT2c4RXoyNHRCQ0NHc3lIaVMxbnNVOGpqRENMcWlpQit5?=
 =?utf-8?B?cFNEYjRjWkZ4NkhEczBZNDdHdmtzYmVYNnIwalJIV2pFVVRnUWt4UWxMRm9h?=
 =?utf-8?B?WE4wRDFraGZDSzlXWWFIalhiNFhHTWtZSk93WlU3UVZyL1N1NUhuSzgvd3Z4?=
 =?utf-8?B?emhnejZ1bDVyQ0k3SXlldzJIMjAxNGdmYjVMRUo0ODFXNm5wZzRQL0hRL21l?=
 =?utf-8?B?KzZsbzRXbi9FSWlOc1FhYXdnOUFac1FHKy9wQU9COGlGWlJPdCtqZXB0TDhy?=
 =?utf-8?B?ZXpSZVJBdmN2cTZ1L2dPbU1YMWtWcjEzQ2hHb1NnMVpVenU4bkZpQW0wZlF3?=
 =?utf-8?B?RzN2SmVGTDBpRWVwV1ZIWEk1TXhzcGJuQWpHWFFRWFNoeHRGM0xpRTRpMmRM?=
 =?utf-8?B?S3ZQb1dUQWpCUUdteG5UN2hOa21ZTy9CdW9xczhPR1AzKy94dkRObnF6MEFP?=
 =?utf-8?B?TkRhTlJrem9yaHFXNVBHQlhmQ3VtTmFCQkM5clQvUHRsT01FZHN5TytMai9Z?=
 =?utf-8?B?eWRPZFArTmZaK3BrcENNRm1jMHhhZkFrdDJHQVJld1BQem9zb2RyeUFJRjlP?=
 =?utf-8?B?aW1qMnF4RVJWQVV5cDQ5UEVQcjhhd3dEdXdLMHlESVYrekR4VzlKQjFwdUhv?=
 =?utf-8?B?Z2pzdDJJWHRQMitUU1VwOTNOdjFKMVltaUEvdURIaGlRRVhjVVlEaFZGQWdu?=
 =?utf-8?B?MUN3RElJaGVJNnRuQW5LVGpEWGZOWXhJWmh3V3BtZEowUUVuTzNHMlUxRTd1?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df866d3-ddd0-46ff-d199-08dacbaccc1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 10:40:24.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXZjYZ5EWLbdzjRwyBK39PybCKQNueGIiQfEMmXbMyJqKqiVvkup1pVbQb0I4vt8gE+ABhRcg6KguPSGfnbDGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7366
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Nov 2022 10:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10062

On 20.11.22 21:47, sven.schultschik@siemens.com wrote:
> From: Sven Schultschik <sven.schultschik@siemens.com>
> 
> The secure boot setup with OP-TEE, u-boot and EFI works with a platform key (pk), key exchange key (kek) and signature database (db). isar-cip-core should only provide one secure boot solution and so the key structure and setup needed to be adjusted.
> 

I don't understand the purpose yet, specifically as the touched keys and
the signing structure was already use for UEFI secure boot, on x86 and
ARM[64]. It rather looks to me like you are committing a lot of stuff
that can be easily generated, given the secure boot key pair.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


