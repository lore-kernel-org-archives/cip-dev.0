Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67FBD6DDDA
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 07:02:00 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.76])
 by mx.groups.io with SMTP id smtpd.web10.14985.1731654110871806255
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Nov 2024 23:01:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lJTokbP+;
 spf=pass (domain: siemens.com, ip: 40.107.103.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM22vBf/SANKWfU0m0uhkIYxxsgP89fZejqjUI3b7MuOHSG1gMSXRKKzqVah78L+jX3HBXOW3VKLtfZfDMHx2hZT3b8wbIrTQFK2Dq4kDqoAJfEfUnIIanDMiE8jZz32Eq/sI1/G5h8LB1dHagvJfZ2E4styqlRNH4zDlf4bskRWlh5xsIDu6hKZPNjJOKOs1Hgvevd4xZx6/wcBTlFIpLH2bLYxu1pKPUhqf2o7quK++wsOG7tHnO8L08hY/R5b5+GzTseeP48lmdpVa8XW26MO035BdnuDeyIk+C5ohDFty3MF2/P/Iof28SnMeOmjT5YGKTkehpx8bYefzkh8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf2mhA1ZT9uxEBtDwfSK7h3fq9YVWzXD607MW0QO8uY=;
 b=btisAItKe37a0gd5YVRgcmo3K3OhsLxXQaKxIS1OTkEdsdxiGufCsq5dIZPcuY78/CA5j1QOZ7vuGSCN36Jwj+YRpdPS0hPA14lW1/jweoVeZGtkdqlPcN4+K8g0Ex9iZelBPAHZ0LrjmAQEVB9j/ieVOiVIhTLD0t0Y1+poru7IRCvPdX003hBbbH/MGuo2Jr410qzxo4zbufzcyJBFTWaEjl2eOxUrcq7AXXed9p3JTcEVFLPXooHW8cE5l4wTYwuRtjIn72dR1JjhHmhPdFqglwQt6u6AHNwaOSmwW0CGmxn8eEHY+r2NZ6Dv1i2xxwM88tjCM+OLIPHttzhhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf2mhA1ZT9uxEBtDwfSK7h3fq9YVWzXD607MW0QO8uY=;
 b=lJTokbP+cC+aC2YwWg3X6HA/xWrgNWCF5cl5zklXHez6fOFF9MlKhX6z/c+hSFP9mVfTAT1wyaqjnW7+9taR5NL5tzLdhaeMklbflezeeBAVAH4VLTn7G6sIUjTY+wFlaN4LkvRCe+qRwEGjNjInN1+xbuTgJVmEJmK8+vIskdOUqlu2mmN4R4ZR7UXernARaZSsRNbr3fzi3YJz5fwMMrgrGZ7rBBjZsFyfUnCDIs8XnY3sSW2v5yufKpf6sT1ti9J1qSnChtU4FM1lxTtkCS2ZhIJnfW2GLCVtrfShjE4j4ximKNDqEFkfbXjj5rjdNISXfG6qzCJ2GuUHZgGrSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7753.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 07:01:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 07:01:44 +0000
Message-ID: <21235547-960c-47b1-9ed6-cd78cdd67bf3@siemens.com>
Date: Fri, 15 Nov 2024 08:01:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 6/6] kas: Add option for selecting
 read-only rootfs type
To: Gao Xiang <hsiangkao@linux.alibaba.com>, cip-dev@lists.cip-project.org
References: <cover.1730829273.git.jan.kiszka@siemens.com>
 <12bc32044317b4afd31a97d5eb14c38b997a89be.1730829273.git.jan.kiszka@siemens.com>
 <bcb07e33-2ee6-4b9c-a57d-07125662c7f3@siemens.com>
 <4e3b38a4-55b2-4f0d-81c3-347f6406ed7f@linux.alibaba.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4e3b38a4-55b2-4f0d-81c3-347f6406ed7f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 962b48f0-c4da-4d48-e649-08dd05435d1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OWlJcXAvUWo4T0Z2UHI3eVlPbWZFWjJTTTlma09PczVhZXY2THlUdEppaFJ4?=
 =?utf-8?B?WjNDTHdwaFo4NlArdmNBMk9nUjFJNU5oaENuSnQvZkVhYTdoQ0Fybm1tZHBv?=
 =?utf-8?B?azZpeCtuY2d6VjNwenJuME5kbmwvWVJZMW9kZkF3S1BsMFBycWU5M0xGUmtW?=
 =?utf-8?B?OFJTY3BUT3VLUnBTY1RRUHVRelpLN0tDS21ZeUdmeDZUa3RsRGFIT1ZTUHJ4?=
 =?utf-8?B?Qkp4TjF2UGtNQkdnQWw2eE5vMWw1WTlHOWxqVTQxR2NPSC9LaCtGOTlUd1pO?=
 =?utf-8?B?SHhMNFpKaHF3aytDMFc5ZEdTWFkrU2ZxR2tQMVR3Tk43VmRuK3ZhS2o1bkhz?=
 =?utf-8?B?bG5DbFo3QUNQVWZFWmwycFA2amd6RVIwZGpyTTdwWjU4Tmp0eStjS2htSTJx?=
 =?utf-8?B?ZjVabHlDZjNGWUNLVkNpUjlTN0dQTWdpblh1OTRDQjhVRXg5L0Vkd0xyTlll?=
 =?utf-8?B?YmNQODdDZ1UzU2tBREg1UkVOZ003SDI3WTNQaVN6dWdjZzlDL1pObERRTE8v?=
 =?utf-8?B?am1ZanFrYVg5Wmp2ZFlDMW9VQ044ZlAvd0t1S011TlNiVzdrUTl3dTdKQmg0?=
 =?utf-8?B?dXdGemV3d3JoOEh4cDRCYjFtSWRJYXhveGxrMzJXZkpVVEcxWlhjUlhnU3dt?=
 =?utf-8?B?TFBmY2wxcXluSUt0MjJQQ2RqL1F4STFaNGJSNUhLaGJpVEdZNndEWDQ0Vzkz?=
 =?utf-8?B?YVp2dDJuMkdETG1HZ2tKU2lLdUlEaGJuNlFyTEw5S1B3a09OUzJWSjRWaWNY?=
 =?utf-8?B?TVhyQU10bVFTTmtyTDJWZzBKbk0wZDRlcXdia2VjaDN3Tk51N3hQL1VWaGJY?=
 =?utf-8?B?dXJseS9PQkQ1aXpjaTZKb2ZSMWhNOFdEQ3phb2Rsd05OaU5lY3RNMy92ZWI2?=
 =?utf-8?B?UW9xLzc5K0JPTlpEV1ZzM3NFaXVtMkJkQitTMXkwQmZyOGRGL01sNWl2ZTNa?=
 =?utf-8?B?b3JnZ20rbTlJL2I3MlUvN0R0ZUlVMitqeUFPTmROUHVGOHpCT3NybTVIMjBT?=
 =?utf-8?B?V3VsZ0NMdU1DUHVyMWowZXZMejlmdzNCNnlnUFZ2RHNJN2JhRHBjOThwcHVU?=
 =?utf-8?B?YjZMelI4UHp2REtIUUtSbHVQeDViL09QdzZTVi9ia1BueDBOZldRWER2NzBm?=
 =?utf-8?B?dTBWREgwNFRRMXV0WkJOKzJtRW5kYXhvODdtazNuYnN4ZEJyN05iSUNRbGRH?=
 =?utf-8?B?SkxlMElUSFMzM0F2SnczMnZMTkcxK1kzYVE5cGJFOTk4cVlMOENFTGs1dHhK?=
 =?utf-8?B?d3RDNjFidjhJZEFJakVvSHB6NTJaT3o0VVIyL3BnWUs0QndhbmFhWWxXbFBS?=
 =?utf-8?B?RTdZb0xLK3MxemFwSE5NQzNONGFlSHBBdFFMMFEvbXZMNWhaeVJFcHVLYW5r?=
 =?utf-8?B?clE3OHUzS0V1ZDZ4UkMxMW5VUUtQK1FkUEg0L1ZlTlpZZGxta1p4eGJkbkhC?=
 =?utf-8?B?bTRqeFlKamVmV1VpYnlMckxHZEVMY2R0eVIrRE9jOG9UVGs1TXhTdzdVeDVw?=
 =?utf-8?B?Tk5IS3FJOEoxL2szVEdrNFZ4ZTlBSklHMWVSVGhSUzFnOVZIZk42TVozcGZ2?=
 =?utf-8?B?blRrNFcwUFI4dkU1MW9tbytQNmZacCtFU1JSaWVtcTBzSzczT2NEcHVCWDJp?=
 =?utf-8?B?dUpBeXhiMmhKUThFTEkxWGJtV0VzekRBckhIem05RDRrVm13RjRmd2pJeUt1?=
 =?utf-8?Q?Pmx0CMUG/tXOCkO/+rVb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjRUODRLOXFtdlJzUGFmVEQ0dWN2V3pCdFFseU55V3ptYVJWK0tLeTdyNXla?=
 =?utf-8?B?amdPd2FWUDIrRWlYRmNHWG1EazdYckNNZHYrTEhmL1ZSS25Ub1YrczY1TVZq?=
 =?utf-8?B?eGc1clRDQmZZS0JncENnbE51M2RFOGk3N291SExidVAvWitJb1lkWGJEYWFk?=
 =?utf-8?B?cDRxdFczR3pRQXRpMllBUjU4N1EzRzlxL1RwMVZqTE55WjErT2pYd3k5OHFt?=
 =?utf-8?B?a0h2NkJCRGhPbEN2MDMzTTdLemhwOTVBSVFkeUxLaklxWjRNbE1VaVVIOFB2?=
 =?utf-8?B?UEtwSzBDQ3ovYVF4alZHMXc4bG1IcGIzUDNxQkY0Z2FCSkVxNHdtcFNXYnhE?=
 =?utf-8?B?YXhLTWpZVE9LOWZrbjBGWmhTa0VWa1ZIRUdqVlZWd0x1d25MNzhBb09SMkpJ?=
 =?utf-8?B?WGE4MThNalYxb3NEVDJUbGl3cDZ4ZHFRRFUrZXVPY0I2R2E0VTJZYkdFczVW?=
 =?utf-8?B?MUZObnF3YmtjdndsS1lqdXBHV2MyK3BkQXNFbHJpQTlWNDlkZ1hPOGNaRHFV?=
 =?utf-8?B?WDhRRGZCcTVZa29FTU92UVVlMVR6QkppMWpzVlpmcllDdUxhTEM1K3lFWVAy?=
 =?utf-8?B?aVJrOFJZV3lYQzhUaDdoMFRyTXY3Q2VCZjZISWg1Sk1BYW43N2doSG5kb3hI?=
 =?utf-8?B?MVRIVUNNdnZIMGw3SDl0NlZZVU1IcTE2S1ZxZWxUb1JXVjl1WHBNZmNJTjAr?=
 =?utf-8?B?bnYrc29xMmhxa2dPbDNpdUNsZGFVSXZrbXUzK0ZLSmVFVTcvWmNVY0J6Z04w?=
 =?utf-8?B?b1A4eTRMTG9ieGFNdjhsZnd6SWpjOHo0bE9UbXZnRjhmdVl6RUxRdklDOVJ5?=
 =?utf-8?B?d3JpTFlycExtaTZSSWtwRnhsK0FtVHZLTUQrNWZlK1V0aVJMSlQzcEg1T2RD?=
 =?utf-8?B?dmVXcSsrbFJTMFhqaGlDVzFXMFFTcFBLK0FlUW0zcGx3YTVSVWpWT0RvOVRG?=
 =?utf-8?B?ZnMvdFlXQ1NZdFJaUnFmZ3U4VHVNZnNVZlpSUi9yKzVYR1pLUkdDM1J5N2ky?=
 =?utf-8?B?Uk16N2dxbEVPNWlMNnV0QU5aRnRzRVhVWjhHclRDWGNlWTRyUGY1V1p4N09M?=
 =?utf-8?B?cGhZSlhXT3VkMnpMRXc1V3lrMGNmUGpaNTVRMm9FYVRLVWh1MjdmbkRjbzZa?=
 =?utf-8?B?YVkxN3AwZmZ3MHV6YjdqRGZpN2tCbFlHZ3hXZ05kb3BLN3p6aUI2dUVFdmNE?=
 =?utf-8?B?anhnbHJScDRsNWtWbSttZGJqTWovRWFtZmdRcUw0cktkRmlDbCs3VUJCMmZU?=
 =?utf-8?B?dTEvQ1RobXhkR1ZsL2VIVUV2eTV6V0JTYkRtMVVFSmhDeG5IQUtJRkFhQzNm?=
 =?utf-8?B?WnVQRGdzVkhzdENnZEI3N3NKVTlwdDFYaFBDUnJDZy8xek9BUFZhMm0wTzRU?=
 =?utf-8?B?ZkNqTkJIUHp1QjczNnVlb0M4akZmNlh2eEwzVXM3bzRTV2ZaN2xLTjd5aVZq?=
 =?utf-8?B?RS80VUpCZmJGaThRNUdwenNnKzQwZlNYVENLeWVRTUcwSHZvbjhLOG9kUzJy?=
 =?utf-8?B?MHFucHV0eThVQ0taY3BKcEJ0RlZmVjBiK2lIOFV0ZENxeHZ2Q1E5UitFb3Ni?=
 =?utf-8?B?d0dnWm5aMjNaZHY2Qk5jcXZqdVp2QlJsdEdWbUNRbGxKN0lacUsxcHZ5OU96?=
 =?utf-8?B?dWlESEFSc1d3Z3IvWWxwVWpYT2ZDZGNsQk5wa0Rkdnd3QTcvRDc4S2RKOW9Y?=
 =?utf-8?B?NUIzRzVSNHRjVUlwbGVveE1kdno3UlRTWE5CY0hLcVZDM0FHanZqOGkrc3k3?=
 =?utf-8?B?cmNXWmhIcTVyOVZhVW9LdDhDYWFLUVZaTW1MNlVLZ2JtNDQrVEF6MmlJcCtF?=
 =?utf-8?B?a251MlArR1ZWTFNZdXhwQXN2elNxaFY3Z0ZnS1pLZjdrNUVrNUMwdFlaRlJ4?=
 =?utf-8?B?WDZWQUFUcWVjQnNnU3NVY0FwVDdMWE04QkxlOXlHc1piTGZ0aHc5WXZVTXIv?=
 =?utf-8?B?bGlXa3QxWXplTFhUMTRHcVZrY0U1eHBYNVV3WEgvTFlKdnB1MGg4ZXZDZ2dZ?=
 =?utf-8?B?UVIrU25rNGVONmNqMWNicElpVFBKUTJhNmlreEFnRjVocjNJSjRNN29wUmpU?=
 =?utf-8?B?Ym16TjhNNWI2dVlQdTRkYUJCUjNjaXREYzR0M3E2SFpFTmM2dFo3SkVHSVZJ?=
 =?utf-8?Q?2m8ItbBCnqoPbzXHvtQUUakci?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962b48f0-c4da-4d48-e649-08dd05435d1b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 07:01:44.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnifZkK6BPD6+dhMQJr5pfLaWkd4VfafgxyT+pEaFL948QdNxyNRDgl6hljFRWoMbm+Je+c/lntyk7xgsoQ2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7753
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Nov 2024 07:02:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17256

On 15.11.24 06:55, Gao Xiang wrote:
> Hi Jan,
> 
> On 2024/11/7 14:31, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This allows to select EROFS as alternative to squashfs. The option is
>> limited to 6.1 kernels, older ones will no longer be enabled. Debian
>> buster lacked the required erofs-utils package, and bullseye seems to
>> generate filesystems that are not detected by kernel 6.1. Therefore,
> 
> Thanks for the effort!
> 
> Could you give some hints of this case? Is there some reproduce
> steps so I could look into that?

$ kas-container shell kas-cip.yml:kas/opt/bullseye.yml:kas/opt/6.1.yml:kas/opt/ebg-swu.yml:kas/opt/erofs.yml:kas/board/qemu-amd64.yml
$ DISTRO_RELEASE=bullseye ./start-qemu.sh amd64 -global ICH9-LPC.noreboot=on

> 
> bullseye uses erofs-utils 1.2, and I think kernel 6.1 supports
> all images generated by old userspace versions.
> 

I've looked into the issue again, and it is related to our abroot 
selection script. That one does

blkid -p /dev/sda4 -s USAGE -o value

[1] and does not get "filesystem" back with bullseye for erofs. Given 
that bullseye is in maintenance and erofs is a new feature, I see not 
much value in addressing that. But thanks for your interest!

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script?ref_type=heads#L36

-- 
Siemens AG, Technology
Linux Expert Center

