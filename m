Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B5CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:21:54 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7785.1762932107744931383
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:21:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HKqXWFNU;
 spf=pass (domain: siemens.com, ip: 40.107.162.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGCYLKPBoizG6rd6F1tC93Toux9bMsYEOiiL5OiLPnu9WVUIBMkMo0O65tqH4iD8wmhyz/gqrmxppyz7fOp5dG+ZksubxUP8bdiqGrFIkYTnSDVv4Hv/YwuQybiwMuYnglvz7wlCbBQ6kVh3eTG8BM55cW7FcRMMQ+8RzzUEofa6sZOfsOFApu1IMjRsmaiwpLMpydsYY+wqhiSBjVIcrstWfFOW5IxUYuXRS36OvPiVcUy39o4pMueX3iNpusIq8AH86Dky8htYUkvOk6i9Cf/y4WTz+I74spQrzG1Vuo+iH7MMV7TfTVd675ShduAxaJ8443j4w5SHWXP4HunWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCk3e+IpJZt4aNLeB8Sv+Wy9zs9Mo6L4Zi0VxlrowVo=;
 b=e6e3rnmF27/9QK7+BDHPpHf0L39lh2XC1t6JyynypaC0rZzo4vmcBpaJxdIqrFuyp9C8MgKaMYQqVTSgrgcnTNn21hqYWwr+BEB3xlQWWvpblMglcZbzuml0mhGVRv1j6Uz257PNKmp2dj3sVelAk1366ot0KdY45/ZwM+6MIYcIndkqt2920NPsdtHEmQYeDdBpRtsHFIr1A5fqcP0V7z/w5GFJTQ8A52TtyGP3eGdRwc8yCH21etowsDvEBXrIS8TrBaNEyAWUdFZ3gq5A6hNSl25b9VrZwjyFuFc9qlkAs1R0oD7C+j4yz2ZJo5QY1hLHicIgjjWnkxgksu5hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCk3e+IpJZt4aNLeB8Sv+Wy9zs9Mo6L4Zi0VxlrowVo=;
 b=HKqXWFNUMLpeUdent+KFdA0aJyEOcJC4Qwk4t53zWWflpiJY61AD5c80m8HFVGQzfLseq3N6GIePfS1uukZE/6sO1qrBm3bD0AmsK8p8uPdZj1/Gcu/Wkx8kc6E4rFbx2gz+VVA4EOsX4wLsldWC0wRu8sD3TlzfNQZg5XDKr4CkseYtUY+6U45x9xoqEb1n70WizZ89D6ederGGQ5P6cKgYjNXLuVy2miqJESKP1LZULhgnifogsvnmdVrdL6u18zyVzwKgMbM2p7YbIKIblsQ3vZNnOQ6hPLe8i9fFA2IISJlNQVrCPkvjfkXeAEMcXyZAUKSdIwmxb2T2iLTuog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:21:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:21:44 +0000
Message-ID: <0e889535-0845-4f2d-910e-7da838d26577@siemens.com>
Date: Wed, 12 Nov 2025 08:21:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/5] Add support for TI AM62Px
 SK platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251111164508.1707234-1-s-adivi@ti.com>
 <20251111164508.1707234-2-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251111164508.1707234-2-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3815:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2486e2-8796-4342-f93f-08de21bc21d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TEhYcEpvNEVxbWw2eHd0SlVWd2lqZGFMaW5RTkcvVTAxR1lxUFZxM3J6OFRl?=
 =?utf-8?B?OUZ1aGJGRFBvK2QzMWFPalR5OElBMEtCaG5ZdWlYY0lkTlhaTG1sazVpbVlz?=
 =?utf-8?B?cEMxRUt6K1RBa2xXWlZJTVFnQUpVb2wrUElPeUhxcWdVeXcxQkZHQm56NGdV?=
 =?utf-8?B?dzF3bmc4d0FZWU1URzJITzVBN3o3eTFtczM3RkxheVhwa21CU2d0MnpEeEFz?=
 =?utf-8?B?d2hnYU1lSll4QzRpMlFTTmpEZHU2dks0TUUxMWJ2U0c4N0YzSGU3cU5iNUl2?=
 =?utf-8?B?Ukw3VjdXZkI1VmZ5aGFjbjBoeUhPb2phQm5rVUZwd1hIWlRNNlVkOXpiTURi?=
 =?utf-8?B?LzdRbUpHQmp2c1Q3MGR4bjJQV0hJbDkxT3BVYzFnd1IyVC9Cc3BQd3FOekhR?=
 =?utf-8?B?aUN1cEUyRU1yTVZLQ1F6TnpKZlVlYmFTNHNNSXRNcG9va0JKUEN6U2d5TWth?=
 =?utf-8?B?cjhkOW1wK0RQU3UwcEI5NGFzTWV6Y2dQUndxemxSUnJjMVprS01zSDV4NEJq?=
 =?utf-8?B?c25ZejRNekM1ZkhvUHo4UG9NVm56Q002MEp1QWN3dkhEQlJPMXpoUnBtVEVK?=
 =?utf-8?B?OHpJcmlKVHBSNHcvL0NLWTZWYUN6a2Z3T1NMdVJiL3VRSEV6blZZKzg1TnIr?=
 =?utf-8?B?Y3dFVmtERmhhQXkxUDZRU0Nndjd2LzVUR1g0UG41S1VscTNWekRkZUpLSXBD?=
 =?utf-8?B?Smloem5sWmJZN2lSNDUrNktqRVBPMVZyV2hlM3hVa2plTlNwdnQ4WDN0Q085?=
 =?utf-8?B?R2l6UjVhOG52QldTVkJKOVIvSmxheHdsc3hrZVJLZURwcFVCYlpjamdCQ1or?=
 =?utf-8?B?MEdiTFR5QmV3YlRDejVDeFI2cm9IS2hhZDhBTXpyZFRJNkduQ2lQT1FhNnZi?=
 =?utf-8?B?R1g4KzNZL2E3QjJMcCtSR0I3K1pXMkNzZXJDbGxodFNNdDFNclhSNHFGZUtu?=
 =?utf-8?B?RnphV3plbWdHZmpRdzJlRjJTSUYyeVg3dHdBR04vaHRJN014eWZRcktDTW5o?=
 =?utf-8?B?bUVBYlRRL3VqNHhIbzk2aXIrN1FpTEpUQk9ibitLWThJR3dpOXd1MTNsQXNk?=
 =?utf-8?B?c0RPRGtUYkhOZ0cxVm1jdGVoTy9hM3FYaUpEQzc3RkIvWVZVNmtyazhidThx?=
 =?utf-8?B?amxDUFZ2dHNoY0VkRGZIZGRWdW5aWmE4SXg4UWhjdStEYlBFWi9scTN2VW5B?=
 =?utf-8?B?L2g5d0QyL2RzYlNrMkwzcFBJVDR3WFB2MlI3SC84cSsxejMrNmZOOWJzQlZT?=
 =?utf-8?B?QTdPQ1NRcUdYemQ1Z1h5L1ZtN1ROcFB3TG1peU5kMk9reVdWK1BnVnN0VDFp?=
 =?utf-8?B?Q3VadWZxZDFhZ2dFK1hNQmV2MmdNM1M1S2pmUk5VODFjZjhVMElJSzVmaWxk?=
 =?utf-8?B?WWQzNm9IeUU1bmM5U01jSlVSNHg5d0dVZ1N6NGxFOU5YZGVVUnlObzFlK2Yw?=
 =?utf-8?B?MnczV1VHSkxCMWZXdFBtTXE0bTZmdFNJbnNuZnU0RlpGTzB5TXZaUU5zMmJt?=
 =?utf-8?B?UDhadzdXaWpYOHFPVDYwYXdOMkVzOHdNYmloWEJ1bXJTOEFsM2YyVzc5VU1t?=
 =?utf-8?B?K250ZGVaejM1NlpDRys5U2ZYWGUzaXF4UUg1ZjdsL2hJaTBMQlRmWmw3czMy?=
 =?utf-8?B?ZDZ1bWpWVm15NE1jOHM0dm5rM0QvaEd6ZkNITHI4TnZHZzB0SVNEL2hlWXVN?=
 =?utf-8?B?Z0g0Y2JHOUlSNjhmY3lGZlpaR3oxVUhHMm42TzF5M0FVMWJsb1kyczNkMzJQ?=
 =?utf-8?B?UzZUc25IN2xTSFJEMFh0Z2I5bCtSUFU3RFJjaFZVN3k5T0ZhQm12ajlqdjRX?=
 =?utf-8?B?WFRIeGNBT091ZC9pMXRFK1U3cCtUejRoV2FHNXVucHhoRW9RWDljR05nQWtN?=
 =?utf-8?B?QmtXQmtvS2FWVW9oT0xGQnlYblppVkRvbyt4TjhIL0F2TVE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWE2LzFOSytzbHJFK0t3WjVEVWZQZWxSNmlrTHNNdWlLWUxTeUpjMGE1a0ZZ?=
 =?utf-8?B?MzQyMExZaGVpUFdWeGF0NGpTeGNIeHFJOW1pYUpsMFBZcGZkRjRHazBjMHdn?=
 =?utf-8?B?RHVJNGJUMmVxNExramxPcFVoWnhLVkVxM0tvQVR1Q1JOTGVnNmRDSHhaTzVm?=
 =?utf-8?B?cldNL0Z0V3VrYzh6bkNEL0RmUGFpV2ZUck9sMWg1YU5JSk1NQnpwMzBNSW1I?=
 =?utf-8?B?ODN3N2RaUlZtUnlrRWNrRys2aksxemR5dzN1VXlGM3dwZTF3SVFKWUk0S1Bv?=
 =?utf-8?B?V3lHcndGcFlBd1V3MTVDalc1VU1XRUFTMVpTYWY5U3JTNUxKbXVNK090VTFJ?=
 =?utf-8?B?WE44bkZWaXE3bThNM0RtZy9ESU4yaFlSa1UvOXArVFBic2hwU1R4M3NtVDhJ?=
 =?utf-8?B?SmVaVXBGcFJvZ1BuaE5iWFVvQnZzYk10eXY5VFRjOGJlRnJ1NE0vazdwQ0NZ?=
 =?utf-8?B?UHVZR21wMmhHMlorS3FaY1d4UkdKbCtGVmo3SnhDa3FoSEllaTk5ZmpTa0lz?=
 =?utf-8?B?czAyTzhKYUZuaWNpT3JlaEdTOE5NKzhCWDduUG1VelZaa2hPMlZNRTZkNTND?=
 =?utf-8?B?UFpLOHYwTmg1dmloQjErWHdjVjFwN0xFQk5xQjNhbW9nUm1TNSs1WjhvQWZT?=
 =?utf-8?B?YXN1a2NjUWdzMzRWbm9MUWtXWW9kSjJXaGl3cFRyVG9LRmR4TmY2ZHdPbVRi?=
 =?utf-8?B?SXJBYjAzZUkwMVMwWVV4bThTR0g2d29IWFJ2VjFvSmJveEEvdllISi83Wkcw?=
 =?utf-8?B?SFEwdVJYRm5LZXA0ZTJJRUtja3REOG82NjYwNlkxNHkxOGFTVHptM211aTFt?=
 =?utf-8?B?RXhwejk5QXVCY0E3c0drR3U5SHpEdVRpQmxyN0hoeUhwZHFjVXhxaWVxaTM5?=
 =?utf-8?B?dE43UWdUb1JRNjl5d08vb2FWN05MNWV0VXVkSUNtOTlIa2srKytQaUdVb2xH?=
 =?utf-8?B?OUJidlo5cFJyV0NZWXRmMG50Ujlsd3pRV25MbjlacUdKT1YvNzNlVVhBV05Y?=
 =?utf-8?B?V3JKck5BY2Z4eU51aWlseDFZaG50OE1DbkM2Nm9aVlpKU05aNlRoTWZRNUFu?=
 =?utf-8?B?MlFRZXpZK3FYWDRxTFJYTms2S3g1RzJmTWtLSFlHcDFpVy92SGZuQnNPTGJ1?=
 =?utf-8?B?N2d5TG5zQVlQNEdqMmQ5akYxa1Z6N084dmNpb2dTenFvelNYNFRJUlN0N3M3?=
 =?utf-8?B?OG5LcXVDdHRtQ3VUUS80QXlRYm1Fd2g5TlRSeTU5NVVPRjVHNDZXbkFaLzNI?=
 =?utf-8?B?Q25UMkJNWnExWnhmTWtvUlR1ZUxnN3ErV205djNhakVrMUl6M1plQzV4NFlM?=
 =?utf-8?B?WEtDaDg5WmY4TlJsWUt0L0dDbmFVYW5yTUIvdHduQUc5MFFFMDJZR3ByZk4w?=
 =?utf-8?B?bldrUm04MUdHdDhjbkJCMERwc3pRYWFQQ01BZ0ZaeFpIajVKRWh3M2VqRytl?=
 =?utf-8?B?V1NkMUZ0b1BveDVKLzJiQjVLT0l4ZDRnMlgzMGhsd3p4OE9sOE5NUUFxRmZj?=
 =?utf-8?B?R2FOaW8yTG8yaFdIZGxOOVNxdDc2aUZNY2dJTXNJNmNzdDdhYjNFMnVOTDZw?=
 =?utf-8?B?SVMwT2FhNmVHNzJLanFuS3IxY0xnOTBEUTlJSVYzWWloR0cyWS96bS9BbmlV?=
 =?utf-8?B?b1lYcFVkQTArZmZGc1dnMXgrY1JkSnd3WCtyRlRPd21XSnd3WmRFUVBaN09m?=
 =?utf-8?B?NVVxTzdTeU0zbFBxcTQ1V2d2WXplSkJxT0JoTXVMNEV4ZkNvM3VwR1NuOENx?=
 =?utf-8?B?UGFsVm5SdXZMeCtlb011dEdOVm1mbmdGUUl0L2xrNlhhRzY3czQwQTlaNlIz?=
 =?utf-8?B?c3VFUnNWeXlGSitZTng4aWhtYnlwWDJ1cXFBTU4wbGkzT0tJRHFqenJYVEsy?=
 =?utf-8?B?V0xDczRqbmtRenNuajAwQlpJV3ZqeHB1YW16clA1cWkrQmREbWVDN3RGQzd1?=
 =?utf-8?B?YzNISkVoTGNqK2E4QzgwYm9lbDRDbktaalpzN2NDS1ZJaDd3VkVNUjl6T1Qr?=
 =?utf-8?B?b3R5eVVZSVZId2RUQW9MSElBRmMvVW1uQ2F3VEh4cTJ4Y054NjZFQWl0SjNr?=
 =?utf-8?B?QWhwM3pUb2hyMTA1aXUwa3ZxM1M1WUFDSUF6ZE10dmhGWmNvbE9YSzlnblJi?=
 =?utf-8?Q?B4YdhDf2b1uq6eHYS3pyL0AcN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2486e2-8796-4342-f93f-08de21bc21d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:21:44.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmWHvWwP/AzQfcmBClwR/Il5bWf/Sp95pwlQSCf+3YztSBYkNcIAIHo7hHgZpIIC5PR7Z7EMBE0OB/qq+lfBXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3815
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:21:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20510

On 11.11.25 17:45, Sai Sree Kartheek Adivi wrote:
> - Add machine conf and and kas yml files for TI AM62Px SK
> - Add u-boot 2025.07 recipe
> - Add patch 0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch to
>   enable KASLR support. This is already upstreamed to u-boot at [1].
> - Add new recipes for trusted-firmware-a, optee-os
> - Update SRCREV for cip-kernel-config to fetch ti_defconfig
> - Add wks file for supporting image builds
> - Update Kconfig to enable build support
> 
> [1]: https://github.com/u-boot/u-boot/commit/7d4136397715d2c08161a32a873c052dd1bb8b6c
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       | 11 ++-
>  conf/machine/ti-am62px-sk.conf                | 32 +++++++++
>  kas/board/ti-am62px-sk.yml                    | 13 ++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 11 +++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 30 ++++++++
>  .../trusted-firmware-a-ti-k3_2.13.bb          | 22 ++++++
>  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++
>  recipes-bsp/u-boot/files/rules-ti.tmpl        | 33 +++++++++
>  .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 69 +++++++++++++++++++
>  wic/ti-am62px-sk.wks                          | 15 ++++
>  10 files changed, 272 insertions(+), 2 deletions(-)
>  create mode 100644 conf/machine/ti-am62px-sk.conf
>  create mode 100644 kas/board/ti-am62px-sk.yml
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>  create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>  create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>  create mode 100644 recipes-bsp/u-boot/files/rules-ti.tmpl
>  create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>  create mode 100644 wic/ti-am62px-sk.wks
> 
> diff --git a/Kconfig b/Kconfig
> index 68773bc..0930f7f 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -86,6 +86,10 @@ config TARGET_QEMU_RISCV64
>  	select ARCH_RISCV64
>  	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
>  
> +config TARGET_TI_AM62PX_SK
> +	bool "Texas Instruments AM62Px SK"
> +	select ARCH_ARM64
> +
>  endchoice
>  
>  config KAS_INCLUDE_BOARD
> @@ -98,6 +102,7 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> +	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
>  
>  comment "Kernel options"
>  
> @@ -107,17 +112,19 @@ choice
>  
>  config KERNEL_4_4
>  	bool "Kernel 4.4.x-cip"
> -	depends on !ARCH_ARM64 && !ARCH_RISCV64
> +	depends on !ARCH_ARM64 && !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK

Let's put the target dependencies into a separate "depends on" line.

>  
>  config KERNEL_4_19
>  	bool "Kernel 4.19.x-cip"
> -	depends on !ARCH_RISCV64
> +	depends on !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
>  
>  config KERNEL_5_10
>  	bool "Kernel 5.10.x-cip"
> +	depends on !TARGET_TI_AM62PX_SK
>  
>  config KERNEL_6_1
>  	bool "Kernel 6.1.x-cip"
> +	depends on !TARGET_TI_AM62PX_SK
>  
>  config KERNEL_6_12
>  	bool "Kernel 6.12.x-cip"
> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
> new file mode 100644
> index 0000000..6e59250
> --- /dev/null
> +++ b/conf/machine/ti-am62px-sk.conf
> @@ -0,0 +1,32 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +DTB_FILES = "k3-am62p5-sk.dtb"
> +
> +IMAGE_FSTYPES ?= "wic"
> +WKS_FILE ?= "ti-am62px-sk.wks"

We already set WKS_FILE to ${MACHINE}.wks, so this is redundant.

> +
> +IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk"
> +IMAGER_BUILD_DEPS += "u-boot-ti-am62px-sk"
> +
> +IMAGE_INSTALL += "u-boot-script"

Not needed, you are doing UEFI booting.

> +IMAGE_PREINSTALL += "firmware-ti-connectivity"
> +
> +IMAGE_BOOT_FILES = " \
> +    /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
> +    /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
> +    /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
> +
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
> +
> +WDOG_TIMEOUT = "0"
> +
> +PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-ti-am62px-sk"

Please set COMPATIBLE_MACHINE in the u-boot recipe instead, see
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/4ba393e85e5a832e4248b6842badec41207846cd

> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
> new file mode 100644
> index 0000000..5127218
> --- /dev/null
> +++ b/kas/board/ti-am62px-sk.yml
> @@ -0,0 +1,13 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: ti-am62px-sk
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
> new file mode 100644
> index 0000000..f8cd973
> --- /dev/null
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
> @@ -0,0 +1,11 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-bsp/optee-os/optee-os-custom.inc
> +require optee-os-ti-k3_${PV}.inc
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> new file mode 100644
> index 0000000..444f6b3
> --- /dev/null
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> @@ -0,0 +1,30 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +SRC_URI += " \
> +    https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
> +    "
> +
> +SRC_URI[sha256sum] = "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49744701918e8b4d"
> +
> +S = "${WORKDIR}/optee_os-${PV}"
> +
> +OPTEE_NAME = "ti-k3"
> +OPTEE_PLATFORM = "k3-am62px"
> +OPTEE_EXTRA_BUILDARGS += " \
> +	CFG_ARM64_core=y \
> +	CFG_USER_TA_TARGETS=ta_arm64 \
> +	TEE_IMPL_VERSION=${PV} \
> +	CFG_TEE_CORE_LOG_LEVEL=1 \
> +	"
> +
> +DEBIAN_BUILD_DEPENDS += ", device-tree-compiler, python3-cryptography:native"
> +
> +OPTEE_ENABLE_APPS ?= "1"
> +OVERRIDES .= "${@':optee-with-apps' if bb.utils.to_boolean(d.getVar("OPTEE_ENABLE_APPS")) else ''}"
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> new file mode 100644
> index 0000000..5b572bf
> --- /dev/null
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> @@ -0,0 +1,22 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
> +
> +SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
> +SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
> +
> +S = "${WORKDIR}/arm-trusted-firmware-${PV}"
> +
> +TF_A_NAME = "ti-k3"
> +TF_A_PLATFORM = "k3"
> +TF_A_EXTRA_BUILDARGS = "CFG_ARM64=y TARGET_BOARD=lite SPD=opteed K3_PM_SYSTEM_SUSPEND=1"
> +TF_A_BINARIES = "lite/release/bl31.bin"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> new file mode 100644
> index 0000000..d831b21
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> @@ -0,0 +1,38 @@
> +From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
> +From: Gokul Praveen <g-praveen@ti.com>
> +Date: Thu, 10 Jul 2025 15:29:22 +0530
              ^^^^^^^^^^^

Still not upstream?? Please make sure that it's going to be included in
2.14.

> +Subject: [PATCH] configs: KASLR OPTEE RNG support for K3 devices
> +
> +KASLR, or Kernel Address Space Layout Randomization, is a security
> +feature in the Linux kernel that randomizes the memory location
> +where the kernel is loaded during boot.
> +
> +OP-TEE RNG is a Random Number Generator (RNG) component within the
> +Open Portable Trusted Execution Environment (OP-TEE) which provides
> +a random number to U-BOOT and U-BOOT provides this random number
> +as seed value to the LINUX kernel for KASLR.
> +
> +Add KASLR OPTEE RNG support across K3 devices by enabling the required
> +configs.
> +
> +Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> +Reviewed-by: Bryan Brattlof <bb@ti.com>
> +Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
> +---
> + arch/arm/Kconfig | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> +index 5872455a0fe5..4e7593616d8a 100644
> +--- a/arch/arm/Kconfig
> ++++ b/arch/arm/Kconfig
> +@@ -835,6 +835,9 @@ config ARCH_K3
> + 	select FIT_SIGNATURE if ARM64
> + 	select LTO
> + 	imply TI_SECURE_DEVICE
> ++	imply DM_RNG if ARM64
> ++	imply TEE if ARM64
> ++	imply OPTEE if ARM64
> + 
> + config ARCH_OMAP2PLUS
> + 	bool "TI OMAP2+"
> diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/files/rules-ti.tmpl
> new file mode 100644
> index 0000000..58e954f
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
> @@ -0,0 +1,33 @@
> +#!/usr/bin/make -f
> +#
> +# Debian rules for custom U-Boot build for ti-am62p-sk
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
> +endif
> +
> +override_dh_auto_build:
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm ${U_BOOT_R5_CONFIG}
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=${BINMAN_INDIRS}
> +
> +	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_A53_CONFIG}
> +	$(MAKE) $(PARALLEL_MAKE) BL31=/usr/lib/trusted-firmware-a/ti-k3/bl31.bin \
> +		TEE=/usr/lib/optee-os/ti-k3/tee-raw.bin BINMAN_INDIRS=${BINMAN_INDIRS}
> +	$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env
> +	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
> +
> +override_dh_auto_install:
> +	mv tools/env/lib.a tools/env/libubootenv.a
> +
> +override_dh_auto_test:
> +
> +override_dh_strip:
> +	dh_strip -X libubootenv.a
> +
> +%:
> +	dh $@ --parallel
> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
> new file mode 100644
> index 0000000..bac1413
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
> @@ -0,0 +1,69 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require u-boot-common-${PV}.inc
> +
> +TI_FIRMWARE_PV = "11.01.16"
> +
> +SRC_URI += " \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin;downloadfilename=ti-fs-firmware-am62px-hs-fs-cert.bin;name=am62p-sysfw-cert-hs-fs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-fs-enc.bin;name=am62p-sysfw-enc-hs-fs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin;downloadfilename=ti-fs-stub-firmware-am62px-hs-cert.bin;name=am62p-sysfw-stub-cert \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-stub-firmware-am62px-hs-enc.bin;name=am62p-sysfw-stub-enc \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin;downloadfilename=ti-fs-firmware-am62px-hs-cert.bin;name=am62p-sysfw-cert-hs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-enc.bin;name=am62p-sysfw-enc-hs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=am62p-dm \
> +	file://rules-ti.tmpl \
> +	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
> +	"
> +
> +SRC_URI[am62p-dm.sha256sum] = "7251394068d287ec81cb0f005a734de3bb7bb695d9dbcc3903ea83dda2182efc"
> +SRC_URI[am62p-sysfw-cert-hs-fs.sha256sum] = "fe36da7923ac6fa52eea5e601fb4321299df5e639d9dd66b41b6825bc1d9d539"
> +SRC_URI[am62p-sysfw-enc-hs-fs.sha256sum] = "4db6ed096fd5077023f292841a64aedb3a4ff8408d1160fb10a7aa0355d06e56"
> +SRC_URI[am62p-sysfw-stub-cert.sha256sum] = "22b58a07429da5ae0b0cd126d4ec0f429ee687429251f4fcfe9a2f5bb3e74b5d"
> +SRC_URI[am62p-sysfw-stub-enc.sha256sum] = "2cb73e5c9acf985325f40f16152906c9a2057f41ffb7903a981a34f7b2aaf524"
> +SRC_URI[am62p-sysfw-cert-hs.sha256sum] = "dfb1c90110155328bc19d9ecdbfacc5a899d4cce8378f8eb8f27877c9fda1fdc"
> +SRC_URI[am62p-sysfw-enc-hs.sha256sum] = "4d5216f8187441ef8af00ae7e79113d36964221a3a19a026aeec09e20a290931"
> +
> +S = "${WORKDIR}/u-boot-${PV}"
> +TI_LINUX_FIRMWARE = "${S}/ti-linux-firmware"
> +BINMAN_INDIRS = "./ti-linux-firmware"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> +
> +U_BOOT_R5_CONFIG = "am62px_evm_r5_defconfig"
> +U_BOOT_A53_CONFIG = "am62px_evm_a53_defconfig"
> +U_BOOT_CONFIG = "${U_BOOT_A53_CONFIG}"
> +
> +U_BOOT_BIN_INSTALL = "tiboot3-am62px-hs-fs-evm.bin tispl.bin u-boot.img"
> +
> +DEPENDS += "trusted-firmware-a-ti-k3 optee-os-ti-k3"
> +DEBIAN_BUILD_DEPENDS =. "gcc-arm-linux-gnueabihf, \
> +    libssl-dev:native, libssl-dev, grub-common, \
> +    swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
> +    python3-jsonschema:native, yamllint:native, \
> +    trusted-firmware-a-ti-k3, optee-os-ti-k3,"
> +
> +do_prepare_build:append() {
> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-sysfw
> +    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-sysfw
> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
> +    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
> +}
> +
> +TEMPLATE_VARS += "BINMAN_INDIRS U_BOOT_R5_CONFIG U_BOOT_A53_CONFIG"
> +
> +python do_transform_template:prepend() {
> +    import shutil
> +    import os
> +
> +    src = os.path.join(d.getVar('WORKDIR'), 'rules-ti.tmpl')
> +    dst = os.path.join(d.getVar('WORKDIR'), 'debian/rules.tmpl')
> +    shutil.copyfile(src, dst)
> +}

This can be a simple "cp" of the transformed files in do_prepare_build.

> diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
> new file mode 100644
> index 0000000..40214a8
> --- /dev/null
> +++ b/wic/ti-am62px-sk.wks
> @@ -0,0 +1,15 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
> +
> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

