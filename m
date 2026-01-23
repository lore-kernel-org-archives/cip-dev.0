Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5828CD7788E
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 17:08:49 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.265.1769188123725032781
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jan 2026 09:08:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tAUa+EBb;
 spf=pass (domain: siemens.com, ip: 52.101.72.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6i9taZfhZpgYOnotQFWwJKJCEHKkgAQ88xRmqFIxQiW6D4NlfnkelMAn8o6hhwBma4kxzfcukECKYwRjNwNg8qmj7DLDNTW7XmEx0UFver+FLf8iVzaSQ33lKqvhs1lU5RL/aPgVLG9abcN/Pq1Ic9aJV6sdeKCCikhIsJG1Rd2zUnfPN8+m7yV95VKyDl9KKwRtOVPfCBhKXJUWj3P1Txuqrhn/3cgXuBg7cPAQRULwh8TTzvzEzkC91lXtL7TJ4ayvFX3zUycqfJ273le9YRR+u5voCVDHw0pkFlwLaq4bCL55VBDCfg30mcLxOs4+bev8TyqEUd8jU3OVsFGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxWQ5Ip4zhbRNzwV51gXVsbHFcXstKQmGrcgHd68woU=;
 b=Rjckr5UlklPLRbyzbfXDdW2yUE7hMzVzYKypqrK7UsyGF7uJ3GxMKaD6NNOIP1PcZfT5bnOUebrmWgnEsxJg2EB+3gaNV8VC13oXtzVV13QU1r9smPDTkD0PaMrIX8UzM7nNwn+/l6FZZJc8dFVMbEAY6CkwIjUWZENz795+Jx8cPtNuEGJRwsFsCr129s69bxH6YhX4tvLuLjxwffVEmrriIOln/HNpS8H1BRp5u8SQKB1UVqJMacE6bS5hVPMWhzbuf2Pz5QwvxRpIfKqNQw2r2fzbYsrWyo5umGSVQqUwpU+m+7OxEDofLUFAKOQdFlXMKqhMCob98j0+3P8X+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxWQ5Ip4zhbRNzwV51gXVsbHFcXstKQmGrcgHd68woU=;
 b=tAUa+EBb7m/bR7/dt51aBGewitvDhpD4qLI4mSZnVM0GvDnJBRKhHVLNNKt2fDvUHbjtuxAt2GguP27tpUqd2nPLa0pO6a9ZZ8um0nMnygLyRFu6qK3T7U3pMgJD1k7h1oIECF+eYxDsDCPQwKgzbY2cBAVTt8hfWEepZkw0RM47x904Ow3tkDTzUXz+BApGEL6Mf0YbY3O4gu+TsBACXC3C9PzKmPlBsoJnil+lfSwXRr0QMTfl24AZqnJG1Tb2dNexj1zfsoMkT3yWsHsrGIpfuRUUrNy3EyanflcgSJ5yk0qlpcZN5PpoYT8jMZbYXAJZq2KB5XHF3VwFubVslw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9505.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:08:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:08:39 +0000
Message-ID: <41053053-649b-4563-be1b-8dd28a0fcb46@siemens.com>
Date: Fri, 23 Jan 2026 18:08:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v6 0/4] Enable support for wfx backend
 based software updates
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 akunuri.sahithi@toshiba-tsip.com,
 Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
References: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 007a1696-6de6-4e5f-fa75-08de5aa20da7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aklMbjBuUDlodkMrMWRrajhkRW1JczlGazVqWXlNZFNYR2g4cGp5cExDRUNL?=
 =?utf-8?B?STF0K3NhajhiWVgxaGxqK1YrMVlyM055aXhSVVAva1EvNjVYckZGT1FlclM1?=
 =?utf-8?B?UThjNFk5L2EzbHZjcXR4b0ZEQ2Q0eWYwL3lNSVhsMGRTS3Y1bHVHT2xoSllw?=
 =?utf-8?B?ZUdIdVJKSFBVV1VFOVNVVkJBcnFBNEJnUXdwdmlEM3RwRjlTcnNoV2hreVBj?=
 =?utf-8?B?RU9kc0liUDdWR3E1d1R2M2pWc0p2TnpWVGIzSnZkbTJoZ054bFM0UndGR3U2?=
 =?utf-8?B?VE52Q1VNOEo2b3dNSFFZZDJBTWxzRGdYbzh5YjJHK0tGT1lVL0ZGR3VBR1dW?=
 =?utf-8?B?RU9wSmJQckhPaVFocmkyNndpR2NxeC9kZFkxWThyYWtCUTZFUTl5bG1NYXpK?=
 =?utf-8?B?d1ppM0s3QjRBTkVBSXd1ZU92cnVwOC90bEl3blAxZFhzT2NiQVplVXFaRTlK?=
 =?utf-8?B?cXN0YXRSSlN2S2JseVpEYkQ5U0tiQUpuVDFTLzVnOU9rZTM1eVhEZXNqcVpN?=
 =?utf-8?B?clRQajZaeGIwYzc1RERiNUMrODd2b0VyMUgrNUgxSyt4T0hKcW1BTHYrUWFz?=
 =?utf-8?B?OGtFTU1WVHBTUURJNnp3SWlDL0J0QUhNa2p1Z2hIN04zLytCSXdVM2lkZzJv?=
 =?utf-8?B?R0JwaTlYVldiRmhUS0Z3VWp0QktDT25hUjg4aFFzeHdHWklEbDZibnpqUmNp?=
 =?utf-8?B?R1lVc3R6c3BLVkhBQ2o1YnpuSkorTEk4VXJZSUZOMnZWQndvTUVlTEFMUTAz?=
 =?utf-8?B?SVBDUEVvREd1NCs2WGZCdkVtVGJ3SnpCbk51aUlTYk00NnBvSWxuMlh0Mzlp?=
 =?utf-8?B?bkNoNGtCM0VabE1YTlFHNitTOEMxTTY2RE1EVVJwdjVUN1pnTWJOK2EwTFd4?=
 =?utf-8?B?RmQ3c0doRjcwbElCRGRqdUU5MjJCelJoZEEzVXA1T3hZL1A2STg3OGx4djBT?=
 =?utf-8?B?eWltVHBySWlIQTUvR0xwZnBrOWcvQVZkWmZ2alQyQThkeVcrSW5pbEp0Znp0?=
 =?utf-8?B?QzBIVzBFVlNYejB4aXN6c0lHKzFaVXozTWZZMk9YdHdSQ1k1aisvWmMyenJY?=
 =?utf-8?B?M29Ob3FSUWtkQUhWckQrbTEvWHA5bnFRWGoyYTBTWDNqVHcxQ2RIYmh0dnZt?=
 =?utf-8?B?anRSMGZvb0FvelBSTUVYM21yN2dwMm5Md25GOUhpZzVyK2c3YXlDY2tJYkFp?=
 =?utf-8?B?ekFEaUVSQU80QlBoeExOWVl4WUNkVW9LbmhmZVVPbjFnYm44bzJjRWhEZmpV?=
 =?utf-8?B?MzA4NzQxb0VwMlVQRHhpRHN6WmlqZURqNnRPbFRhT0NyMUJYYkFtdHJaajl1?=
 =?utf-8?B?dERRK1l6VUJqcGlUT3NpUXUrNlNmdjNubFJ2QWZLbkE3SCs3YkppcWdvNlV4?=
 =?utf-8?B?SmcybGhFeXpzanJ4REJtYkQwNDlFRHpRdFQ0SndWbWhaalAwKzJlKzRXYW5N?=
 =?utf-8?B?cUZabnhmb0ZUckV3YlQweU9MS2VuQWJYaHFsZUtZODRXcjR5M3ZPdkxJZDJX?=
 =?utf-8?B?SEdrUmQ2ZCt3YktaWHFLM0g3a0sxS0pXZE5Vamx2d1lkTGIvcGVmWGRjdVB5?=
 =?utf-8?B?QWxjUGlUNDJYYTR0cDJ6RzhaWXpodkx6allzSUFPTlFzOVBjaVNjcWZicFdI?=
 =?utf-8?B?UXBqSHV4emNlNzh3Y3ZVeGxQUkM5MVkvVFlvcGQ4bmwyYmlNS3o1STMwR0Ur?=
 =?utf-8?B?ZjZyclIrRkxJWXZtcG1CSDJVdEdhdUtsaVFQTnV6SU5wWW0xM0pNQVFkTjVV?=
 =?utf-8?B?SlkrQVEvdmdtUmdBUi9IazM3RkFQZkhpYXhRUnVMT2lBdURKMEFySEJnd1NX?=
 =?utf-8?B?Mk1QbEFJSFUwemx1M2dzNTZXeHgzcGZkMjcxVm1Zc1A2bGFadktqZllMcitJ?=
 =?utf-8?B?M2FtM0lnVFVCK3VoYnhpNGs1cU9meGdCemxFQzUyOVA4RzVRc28xUGlZekhv?=
 =?utf-8?B?Z1NYUlIyT1JIVUJTcHpHL2J5bjV2SXI0Vlhkc2IyUGpiQ0F4YXFqd0VOWktx?=
 =?utf-8?B?MVBQMklCdEpuTy9WUDlvVUxVSlpMQThyWjBJUkJJUUI3dDBwQ0FDNEw5cWZH?=
 =?utf-8?Q?Q4fzry?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDI3U2lFekFjSjJkSlppZXBKMk5RWi9iNHVkMi8yamgvSEp6cHRBMHRWTWVl?=
 =?utf-8?B?TFFNc3pQRVluNjJiK1BBK1VrcW5zUUNTNE9iS2VXcENlZmhubG5kTEdFNWQ2?=
 =?utf-8?B?d01ZbllMb0NQN0N6S2laZlVnd1lPRlA1S2RDWGlIQ0NpU25adGNSM0lyaHBR?=
 =?utf-8?B?Y1BSK3FDWExmaUVlczdlazlWZEUrRW9rV2tYaWVDTWhTcDUvUFN5YkVPZTR5?=
 =?utf-8?B?K2x4bjBad0ZKcG8xTXQ5Sng5bDNMYkhpRjF5N2lVN1ZMY3NvOURxNG5OWHZ4?=
 =?utf-8?B?MWxnRytMZUErWTVnbFNTeTlNbXNlRlNtM2I4ZkVjYlFxVGhGbFNVNUlhcjhH?=
 =?utf-8?B?aGZuOVZDRjdPbGlGb3ZJN21Xbjh1bmYxQ1BHZUhub05TMTdEanQrVURldEJa?=
 =?utf-8?B?M1FwWW5WTjlYT1Y4SnErUGRnUkFVVnFHdHZLTTVsR1VBU2ZNblZJVDNiL0hh?=
 =?utf-8?B?WUdHUzBvQjdGdUdnNG96OTZZdVhndlBlWTZ5RU5QMG15eXNETWtUcFVwZUd3?=
 =?utf-8?B?bXJhWFEyWVBtVEpKUzMrLzRFbjN4OURnMzBIaEpSYzhKRVRSVlI3QVcwNGZH?=
 =?utf-8?B?OUk5KzU3T0lmMmpScS9GMkxBbVIrS1h6ckNnUURsMFlIT1JERytsL1lCeFlG?=
 =?utf-8?B?QzBzV0twTUx0YlpvdDdUMUxnNnJtc01FUWxpbTNNbDNnanFjTk12cUNlb0Vp?=
 =?utf-8?B?bkhQakNvUzRrK1lvQzlLcGtPb3JPa25Md25lK2VSVXZ4aFV1TjQ2amJyTkpu?=
 =?utf-8?B?WjdmMHVVNUNZbnY4bHYxcUtGcC9JbHN0RlFadkFadk4vZXRHc1pWSUYrbGJB?=
 =?utf-8?B?TGF1UjNzU0M4MCtwT1dHTUVSbW9VdDJrdUZBSmlCd0N3UC9DRFR4ZVNzMzlz?=
 =?utf-8?B?Vyt4OERzZURpbVc1bndnallab3NmQ3RwQXQzZ0VwZ3BteTFWOURsR3BUYlp1?=
 =?utf-8?B?RG9lTXhTOUJtU2pHU2VONFUxenB5VDNMMDBaWTJSTFM5djhTN00raVpQMWIw?=
 =?utf-8?B?UkZlQXRXc2N4dDVabFoxWFVNYVRjMkdpano4MDg3WHI4Y3FwS2ZORktFdUZk?=
 =?utf-8?B?U2I5Z0M5UGk3SnpUcFNJQW5nSTlhcGhMdlo2WXBLL2UwQUs2Q1Z1ZkVOSy9B?=
 =?utf-8?B?ME85RkI2K3M1YWFJN2tKT3dTVEQvdm5SaTdZYkJjYlArZUg0WmsxT0JXakNo?=
 =?utf-8?B?STVQZE9hSEZMb0VpM2V3bGNOQllFZHd1K3ovTkJBcGZtOEJJNnFubldRZTg1?=
 =?utf-8?B?Zkl3ZFRsaTNwLzI2cnZscmdiaTJEcll0d1JjWlcvOFNlWWkrRGJPck9wbXpv?=
 =?utf-8?B?eTY0S0RMK3Y0aTJya1A3WTJhTG1qTnRsZjY5QXk3ZmhGUFZRVGxBRUlOL1Vx?=
 =?utf-8?B?UWFTaFFNekw2Zm9kUXRhalhEM0laaWsyRTE2dDFINXQ3c1dsTlZJSHRnSWF5?=
 =?utf-8?B?cDFwNVFDWG0rSnNzMXEyL3p0RENsVVRUN0hMdUNHZmV5dTNPZWRleGd3dEtH?=
 =?utf-8?B?Y3hjdWVUSitkTXp3dXNYWmlENm5MT1dyT0R0a0dqbHpFSWUybVdpUkhIYyta?=
 =?utf-8?B?Nys1ZkY1WFErbXN0OG05cDFuOTZYNjlZMUhOVlFKSVMzTEhyQmp5RVZDSWhY?=
 =?utf-8?B?cnJMcFBjRzlvVXZPY3B1TklRdEtNMUZVbWFoZTJLRVhtYXV0cHkyZzFrZ20x?=
 =?utf-8?B?QzhHTTBRdkdhZkxhQXdwYmtEMk5NZ2ZwSWVibFA1K1FJbkFFcWhuM242VTNo?=
 =?utf-8?B?R25rRitESGpXaFZXVHZUTERSdzg4cTdtN1ZmZDVIQlhBd0cxNmxxK2R4U3hO?=
 =?utf-8?B?RlJ5MzNzQk15S1M5RGx2eG1uRXJ6Vmg0bnU4Y3UzVmtVdEFvZ3UwWm8vVC9v?=
 =?utf-8?B?ZFlKelBOeTdDY3dORmVyZGlTbE4vZ01lWjA2Vmd1NVVZWk1ic3Q0T3lTdExm?=
 =?utf-8?B?UGpOU09TQ283VnFxRUpkbi9vcTFrM1pvYTdYamxIUHo2cGg3eC9hTjhxV1U5?=
 =?utf-8?B?NXVlQXFwNC91amJEV0FCOGFRNDIxRGd4ZnNrNXZtT1hoTE9LbU1hOUtPb3dH?=
 =?utf-8?B?a2V1ZVhyVk5QSjlrTmF5ejkrZ05sSUdWWTJ1b2YxVmVCU1JjZm5SeWl5STFk?=
 =?utf-8?B?aTc5bldsNloyeHI2aFZlM1M5YlYwbFhGKy9TUFBTZjMrME14anZub0ZESUZ4?=
 =?utf-8?B?SERMVUZiMWlxUHpNRkVDWENlZjdhNGF0Tm9BbXVjL3hxQThIdUViOGpjZU00?=
 =?utf-8?B?QmFhM3Rsejk1V1hDejZXeFZnejExdEdYUWRFOU0wVUFzaVVjOGRyS0VSanhT?=
 =?utf-8?B?dElPUEIzQ01ib2VXdThxb2ZjMEtTWjQ5NG9YaTVpdVRPUDhJQ2ZJZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007a1696-6de6-4e5f-fa75-08de5aa20da7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:08:39.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJ6EtkUKO4u5RiDhTIkzDFVOU9oKWatP1hZFxuW0TrMiv/p7LA2menJuEkEQ4DhTwZkiuO4//JBH4AjzvCCxOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9505
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jan 2026 17:08:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21708

On 23.01.26 16:44, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> SWUpdate has supported software updates with wfx[1] backend for a while now. But using this requires a few configurations in the image (swupdate.cfg or via command line options). 
> These series of patches enables/sets the necessary configurations required to use wfx for software updates.
> 
> A couple notes about the implementation:
> - Provides using wfx as the update backend as an option (not forced).
> - wfx url can be set through Kconfig.
> - wfx requires a clientId per device in order to target devices (create jobs for devices). So start
> SWUpdate in suricatta daemon mode at service startup with the required suricatta command line args.
> - The above point could be made more practical with something like an onboarding function (See [2],
> This is still not officially part of the CIP project yet).
> 
> [1] https://sbabic.github.io/swupdate/suricatta.html#support-for-wfx
> [2] https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin
> 
> Changes since v5:
> - Use IMAGE_INSTALL:append to install swupdate-config-wfx without any
>   override creation
> - Weak default value for WFX_URL
> - Minor tweaks to README
> 
> Changes since v4:
> - Minor updates to documentation
> 
> Changes since v3:
> - Drop self-built SWUpdate package and use debian's (required fix is backported to stable now)
> - Use suricatta command line arguments to pass wfx url and client-id
> - Include Kconfig option to set wfx url
> - Enable wfx support if an url is set via the Kconfig
> 
> Changes since v2:
> - Fix appending suricatta section in swupdate.cfg when wfx based update is not enabled at build time
> 
> Changes since v1:
> - Rebase to current next
> - Drop carrying the patch to fix swupdate issue as its backported to
>   debian
> - Fix appending suricatta section in swupdate.cfg only if wfx is
>   requested at build time
> - Use /etc/machine-id as is for client-id in suricatta
> 
> Adithya Balakumar (4):
>   swupdate-config-wfx: Recipe to set configs for wfx backend based
>     updates
>   Kconfig: Add option to set WFX_URL
>   swupdate.inc: Enable wfx based updates if WFX_URL is set
>   doc/README.swupdate.md: Add section for software update with wfx
> 
>  Kconfig                                       |   7 +
>  doc/README.swupdate.md                        | 131 ++++++++++++++++++
>  recipes-core/images/swupdate.inc              |   4 +
>  .../files/suricatta_wfx.conf.tmpl             |   1 +
>  .../swupdate-config-wfx_0.1.bb                |  27 ++++
>  5 files changed, 170 insertions(+)
>  create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>  create mode 100644 recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

