Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEA7D17129
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 19:12:49 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.52])
 by mx.groups.io with SMTP id smtpd.web11.824.1729537960731995149
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 12:12:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pL45dItC;
 spf=pass (domain: siemens.com, ip: 40.107.105.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AafhLzKCLb2TPqTWCxh2zq4I18bLp5/lREKMHVXDyCdZw/N6QkwdrCOXnZb6wAIrZR1N4CsIyp/O6nyHXnf32RNgguVqyQLjcVxm5pb525n0VKO6+28HX0rzQ4u095l/St2BXa7nGyYxf9EL53RwWRC7KVvHvBRN+ePYMQcsNeGipftQMKESEiImf1tMxCzzFarjeSbOXOgllX4hzSYnmPBdqTY7Bf4pEYBTDiqd7hpn9z4iwdVjdzHF6oMh+EGW3wfpGvFMKj6ZHlRZznnAUtZieZlVrN05tyVZqcTE/6nruy829c2gZnlE+CdKqj3qibjVJ+zGJRidBtIowtFdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5MvRhPerR0YQYtkVLhEwyk11S8WFa2G9JlI/b0TI2E=;
 b=Ab+JhmibVUuM7RmeJPCiDK2kNi1XHxVYZFkKMSArjhE1oyZf6Y4RWTqxjIfkVzCaAMg+2ZPtBWaj/L0uLYLoynZ7htPeHmp0+iJFv80oCSzCHnDjNNoy2seNqdduNuHahgrPOtX0yZYi/qBAMR4EogDfHPuwui/0QbjwKx/mkd9N1u36D1mbjqtJtNF0zvO7PIDGSwVeQfVn/oSmIlN7oiPId9JLcyEKS6YRhKCTwNEwkzDXiBv/BoZN7TkEmqj7oAQXGcj02oxTH34W0Smyr2Q7kjXNZ59/bPXVFbXj7G6+9YOfdsTfJgWpzMVGaL0ltVmQUBJZrcYXTO5qLRdzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5MvRhPerR0YQYtkVLhEwyk11S8WFa2G9JlI/b0TI2E=;
 b=pL45dItCfuDZ4NjKu79ZBWCTxCpWpIH7gcf3i60bUjzYXzI0ImX8foh0fDaosjqumFCSbIvYe2JpS+rRH3czKMIZpnLe3i+sSaWDxQYsnZ3JK2RSvi+hvbrPKkkrxVynKwdXJGKU4xzem0nYV5UWBrMDpD8fq4sOjczZJ1snczMqhodaXIbfUzCcq+gGBqhVDzuXfDZ/ca+DpE1fcKIHfmjV2IIuLZlgdIbDsP1uBAIx2X1mH+4UVahDdC0AnNfVhANoD5V+v9eitXjUEcatH9Ichk1Gr0wWmgHN6UabBdk9M0oRYRg1QYieTw63U+uXQSfB5NBKQ3bL/y2en/8uqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 19:12:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 19:12:37 +0000
Message-ID: <e7894ebd-390c-42ec-9499-4771f8a8e5ce@siemens.com>
Date: Mon, 21 Oct 2024 21:12:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241021185359.927395-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: d988fa4c-7d48-44c5-97c3-08dcf204538e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cjVLeTkzSnFpSG93MGxxbXVNb3pQYnhVbEE4cElEbEl0dzdUemgvVUhuYXgv?=
 =?utf-8?B?SXZTQkx1VFhwZC9WcGFnRDVJT1BkRmRLbUgxVFZZell5azlhU0MxZzkzdlFQ?=
 =?utf-8?B?aFdmbGpabzUxSnlsQnQ1RVRRdU0rV1hkZEcxTVM1OXhUNCtoUmVDSWVNdlI0?=
 =?utf-8?B?Rm40NVJFVUZtdHpmaVV1QVN1Y0M2Ty9XQjdKOVFXbDRoUHQxRklSTyt4Tmtv?=
 =?utf-8?B?K25tZ3FFMDBnVkg3SC9vUWE5VGxoOUNxNGZMV0dIdWdUeFI2ellmTGJEWjdt?=
 =?utf-8?B?NjlpSnV0cmlITzJKMW44UXBhSU1pRGZSSjZxN2R0WnZZcGQxZE9DZnpEVy9a?=
 =?utf-8?B?aGdTa3lHMEM0SFpoRmwrQWlWMGYyRzFtQlJ4dEtKRUg3ZVJUK0pIeFFBb3JZ?=
 =?utf-8?B?VWl3bTVaRmxGTG9CTmxNZktwNmw3VlBhZG52T05NaTlJN3pjSmxyVER2T1Fa?=
 =?utf-8?B?REFLUVN5VXhYcE5SU29MakFyeUtGWTErL0g5UzhJaG5OT25wQ2ZXMWMzcldV?=
 =?utf-8?B?cVNzSVY2YVRtbk5VQ1NzNzdyazBUT2dWdm5KMW8rVUlWdTJPdlFCRUlmYk00?=
 =?utf-8?B?RE5leVA1b2RPRkY3V1hhd3FrOGpLMm1kaGxQbXBTUk5qMzArVUJ1dnBqSFQz?=
 =?utf-8?B?QXB5YlNxRUFiRkFRUWhad1R6a1c5OW9teVFQY3RjUE1PaDFJSHRmbmZVT1o2?=
 =?utf-8?B?TXl0bVhBQmtRc0g4Smg3RStOQ3N5WitHZ2pyZGZ0RXppaHlYK0U3STQ1Vkt6?=
 =?utf-8?B?YVpDYnlycEcrSkJBaURVUkNzTFlRaXNGNnJsMEh3ZmJ2N0ZrRzh0bERVRjJj?=
 =?utf-8?B?czNzeTUwdU1zNEp4d01rSkFLNWRCVEFxM0ZlcG1LMlhBM0hPODloMEh4c01u?=
 =?utf-8?B?L2NmL28wNWxFZzRvem5BZ2VJNUdCa0FuQm1qK2g4RVdmT3BIMndkVStoR1lZ?=
 =?utf-8?B?NmNIYjVSYWVZUUxyR0d5RlBoRmpyeG1NR3ZRUHhRMFBkZEFKQkMrMGZvUnpZ?=
 =?utf-8?B?SWgzOVlwS2ZqQTNjQmJnKzQyeUlYcGlsZzhHcXhJTXJGOGplTno2UUdPc1Y5?=
 =?utf-8?B?WHIrSzdNMDhQMkFjZzl0VDBmeGxKbDdvR1NieHd6NFdFanUyQklRTUxxWjAz?=
 =?utf-8?B?dTZwZzJubFFwK1UwVWhCemNTQmZ1NSsvdjcybi9pWEtsNFlrVmNJYTJaNmov?=
 =?utf-8?B?RTZKdkQzaTlQdnFGbkVWUk1VK3huUmJhTTdteEVNN0V5MTRIc3U0U3lUa1oz?=
 =?utf-8?B?ZlYxYVJYbUcrS2ZVcGVlalVCK3RYK1pHNjJwSjF4UUJrbkE0bjdDMk10NXFn?=
 =?utf-8?B?aXYraU5CUWVRdVJGem9Nd2I2dVVyTDkzL09hWTY5QUZoWmhoaFVySEtFY2Vt?=
 =?utf-8?B?UG1PMytGcEE4WEV5Ui9ESFJ1RDdUa0ZiTW85aDZQa1N4T0JlZFNBdEUrS3JD?=
 =?utf-8?B?MFEraGlsRVZkd0c4cmIrdDdSaUMyRmtBcmZ3SHpXV0R2Q0NROGtqR0ZaR2J6?=
 =?utf-8?B?MFF5Sk93MWY4M2plUFN3b3NuWG1qN1Y3MDdWcUN4YXhtMVB5TFNJNVNZSTRn?=
 =?utf-8?B?bXVTdXR0bWFGYU9mcnBNbHdXemFyOStUbWVjU2c5WmVhdHJxaUdiZ0YrbUVw?=
 =?utf-8?B?eVBuT0RRWXZENGluc3ZJTHJLajVHZklYWDNCUTU5RUNaWWxQNVQxb1NFTWNa?=
 =?utf-8?Q?DzwCzzT2UrUByAFpvziX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDNyZzZXMDAweU15U0N6ZmVzTnZuOUVxZCtvT05PbWhsRVlERkRXZHE1by9Y?=
 =?utf-8?B?dTBiVTI5d2JZRk9iVEd2aERZZHI0Qnp5V1NSMWROZC85bDVrRkJPQkdubEZr?=
 =?utf-8?B?eFZRK0V5MFd1UCtldnVGUHJ3ZHZDMHk0NklmblQ2ZFVMRTlUK2VZSjlONTZB?=
 =?utf-8?B?elJnZXdOVHZYQ0Vrc1hEcVR5Y3FkY2pFRjBJOTRzRHh6dlhubUpEc1phT24x?=
 =?utf-8?B?SVJKSnNRRHM0cllzL0x4WDFMQ1ZsZ0Y2MlNRa1JPMys4Z1BUSUdSL0dOcC9x?=
 =?utf-8?B?Znp3SXdpdEhLaGJ1R2xaQkExM29POHFPMWkzZTBaanhrd1N4Q0x0bXNKMk10?=
 =?utf-8?B?K1NTeGVKS1RKMXJ1djlMZGVvZzBMa05DMTh6MkxEamMrM2RnR1QzOUM4eldQ?=
 =?utf-8?B?MFpoaUIwSzZrQVRaTnZpOXRUUzhTb28zWVg4dFIrWUMzK1QrQkp3QzNiQmp5?=
 =?utf-8?B?N012aXNaRytLOGk4VjZTSzVyMHlVUkIzMjFpcXZMNEtXRi8rZUxmK3BkM1Jt?=
 =?utf-8?B?Vnp4RTFsb25BdUhTTzZWVC91NVRZL0lZUVBja1hXV08rZERLUkhpdWQ4WEd4?=
 =?utf-8?B?bllsL2xUU3V1ZGtyRkNDYTRQTWhRNXIzM3YrSitCNVFUbXZFQjRUSk95ZStD?=
 =?utf-8?B?b1lGdlcxamFwN21RM21OSHhOUmx0TGJiY3lQaktncm56OU1iUTVsUU1PTVcw?=
 =?utf-8?B?OWJRdHc0UVhueDhYWjNXVXIvQWorWG1RQjRESGRTbEthSW1DckF2NCtrL0tX?=
 =?utf-8?B?UDZSZFM3ZUxqSU9CU1paRU5vYUlNL0xaOXJ0STJXNVFCVm5SUUxVaG1zWDRS?=
 =?utf-8?B?b0J1YjNsSlBGUW5qa0pyK0s1NWp1Ky8zRE5ERXJEcWZqeEZWS2loNHc1Y2lp?=
 =?utf-8?B?WVpUTEFnQi9kN05FdWZXNEpUTTV5NFV2OUtnbVR1VHI0MjlkRUExY2NhMGRZ?=
 =?utf-8?B?QWRaYkRSYk5MSW80RVcrWWRwSlBkYlNXaG1hc0RhNExBSlpTaVhjRGZlT2JQ?=
 =?utf-8?B?UTdGMjJIUUlEL3dBeHV3YTFjOVpxV3l3VXhiM28vWlAvMHAyWVNmcEdYQ2Zn?=
 =?utf-8?B?QUJ6TUtmWVZHbFdza01zNDJ1cEZKYWlQN3lFaGN3akxvS0xnVXlRTm5FNzc5?=
 =?utf-8?B?eWJkMDY4eSs3eWtGKzNwNTIwbHJhWDN1VXhnMll6Um12S056Z3Z1THZaampI?=
 =?utf-8?B?T0xHU1N5VW9RVDBMMU9JTW9hUnAyWE04OGZmT3lwWTN6VUhGNVAwa25aVGcx?=
 =?utf-8?B?NTZzREhGem9uTUVXRHA1V3BZYlFXMjlOZVp0Tmg4ZVZYTXd5WUtqOGJ0ZFM5?=
 =?utf-8?B?TExPWFo3SkdTS0dNQlFGTm9zRFdTVWZ4Yk9rSGhhQzdRZFVjRlBHenQrbnNw?=
 =?utf-8?B?ZDVPQVlIbWtpWlhpUUJDYTVlSE9vWG9MUS9ieGEwZ0RjQlJiMm53TW1MeXVH?=
 =?utf-8?B?VGQweEZqVGJXVlZVMVVwWlNWNmFCbWpJRkl6U0IzZGplUzhicVg5bHVBRE5X?=
 =?utf-8?B?R1NiQWtVVjhrL211cjUxamIxSkloK2ZPYk1Xby9kNlg5YnhsRnBwZ1BJYzRN?=
 =?utf-8?B?OVBnMW9kcFd2ZWo5MnNWdUpORWdIcGVjQi9jaFBlUkhIMXVJdFdvMXVFNVp0?=
 =?utf-8?B?QVV6aVRlUGRteG5FMzhETDdIVFpEWjVuckZicmowRGVIWVNrQkxtbWxzREx6?=
 =?utf-8?B?T3ZwWlJpNlNUejBzRjNyTVpUSTlPbDlXcmVpc2drOGozWDBxR1UzY01Od2xF?=
 =?utf-8?B?SEVWQU8wdUQrZTVFSFYwUVA5OVYrSDBSWkJBYjNzTTgrTDdtNFlBSUpEUitD?=
 =?utf-8?B?TW5NQXRSSVo2bHRsR3FQbWcwdHVMVEgzTXNTQUtLMnZoTHIwSDRqTzVIZEVQ?=
 =?utf-8?B?TW1ZeXlFVURKZ0ZMRHJXWGFlS2JuTkZ2T3M3czJoekF5SFVzVWdoWmlMZGhH?=
 =?utf-8?B?MmU0bkdwR3RVMXNiRXdHRENjbC81aXliOTFqRHU2Wk9yMHBHVkJ6dWc1T2JX?=
 =?utf-8?B?YW02akdzNU5FWm5vcWZGeEppemE3WlBweDF4SEZrMFgrVVlZd0pVUVVLaGpR?=
 =?utf-8?B?QWFraFNYcXFaa29JS2QzRlUyUU9WMDAvY0NwRmE5ZE9yRlZ0akhCVXpFb2Vp?=
 =?utf-8?B?azlVVzRPcktDQXMzMTUveUd0dGhtQ0tDRS9BNVEyUXdrVHZVLzI2Z3pCSm1J?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d988fa4c-7d48-44c5-97c3-08dcf204538e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:12:37.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7szwbhWZvMkk4fxSbnvM/Lr0rA0R+TYBq5BtbzJU02M1U2pD9DSfQgbGgH0z1SOXMDNyDcHiwZAyafT4uwX1Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 19:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17063

On 21.10.24 20:53, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> To fix the dependencies between `expand-on-first-boot` and the `initramfs-crypt-hook`
> we introduced a new variable `ADDITIONAL_DISK_ENCRYPTION_PACKAGES` to extend the 
> dependencies of package expand-on-first-boot_%.bb. 
> 
> See: https://groups.google.com/g/isar-users/c/0mc0AGyP3yY
> 
> The patch got applied to next on the upstream repo and the isar-cip-core next branch already contains that fix (https://github.com/ilbers/isar/commit/8b30a4f86cb3ea3369bff3884141872c3a7d9979).
> 
> This patch series adds definitions for `ADDITIONAL_DISK_ENCRYPTION_PACKAGES` and reuses it in the crypt hook.
> 
> This patch series got tested on bookworm based builds.
> Unfortunately, for disks encrypted using clevis (bullseye and buster), I'm afraid, there won't be an improvement!
> 

Given that this now comes fairly late for our release cycle and also
given that open issue, I would postpone this series to post release and
possible post further discussion or even solution proposals.

Thanks,
Jan

> Alexander Heinisch (2):
>   Fixing dependency of package expand-on-first-boot on cryptsetup and
>     tss2 (tpm2) libraries when building with disk encryption enabled.
>     (for bookworm)
>   Reuse var ADDITIONAL_DISK_ENCRYPTION_PACKAGES in package
>     initramfs-crypt-hook.
> 
>  conf/distro/cip-core-common.inc                    | 13 +++++++++++++
>  .../initramfs-crypt-hook_0.2.bb                    | 14 ++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 


-- 
Siemens AG, Technology
Linux Expert Center

