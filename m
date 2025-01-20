Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFAC02185
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 13:51:33 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.44])
 by mx.groups.io with SMTP id smtpd.web11.36743.1737381092257746849
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 05:51:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=c10BDgvX;
 spf=pass (domain: siemens.com, ip: 40.107.103.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSO7Jw2JflhW3Fb/JQVd6nXFo13qOGnfv6hPD4NJ2jgYP3g3DJfqPVH0yKILLf3uyxtPVV+xTt969dX+xJRNtRH0v8RDBR6Wps69YWRZ7PESUD77x9l+2PXksAU525UzZLHokaXOe75aFpLf47O8Gsc+DFoo3vBsFiUf/ik5ls3xpOUdjm/XOnjRwTPrU1W4iqMUTK3pIOFICKSbGYioGC+qayQ0f2iM9lbQL8/VwnlXaB0YTI5FhQPMO/6jOQdhaWm4wEPxl4vCTxT73kFZJYFmXAF4ao23SD5XzQm2KZ1k/jLz0Bmb49NRJCS5xER3sHPxx45fbkodetcJyOWq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXEbU3or+twfqaZvx4/2o6TP/m7Z2rojmziyXagOKqs=;
 b=fuNPXKulMHoOfEAOY+n6U3oy0d9Mu6oA8tJK15T1s1knsiLnPxeQT/OqnN4KAnLfGTAwWU7JU0qJ3X/PCuz295MjVuV26omPPoW1PnsGouJ5zsk+UQpIz9X2RQ033FAj9f7ySP7Zqvu4lb2PcU+OyirN2IUgVZ71cwljuFqdk9RTLG7sy5HCyTI6Y59DaYLRkDmBrMas6PsraOGaWMrYqMRbNPVjix5P6WI3765FZI6YfD4ltqbHTvQ89iHJVFau2n5iinvVdP+EXUSV+CsUvUxW5HbZVNcajur1lm3HxXNemjNFnXqFl7tJJcISpS1k6W+xIghb2wTG/ioaR9xhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXEbU3or+twfqaZvx4/2o6TP/m7Z2rojmziyXagOKqs=;
 b=c10BDgvXsO51yb4/GmyQvyBmFcC0+5Z9Z8T4AK6arm/yod8M6Hu1fZNdf4+9rOFyPGKshVyZUk+93PNEumK1oXUyuuoDnpQxPoBJxzl76aDtBOLxy9jE14TEP6AYz/cBswrFf+cGbec6BuGfTbpQ+tVw4G8BUCM6AfcbDDXN77IYOnzUeklGo0B3c0YA2IQPYeT72uwpTT0DOlDNZxoFYWPxKEK11oObKL6IDcVIqxtchujPtz+kP4dIzeQ789w7UfQFzpydQjtYblXW54FLIMySVzaVQ40MAMy6okf/yH6YV4DcYhv25y/vrubZsOvWMvk0D9k3I6ndO0EuYJMelg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8792.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.15; Mon, 20 Jan
 2025 13:51:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 13:51:29 +0000
Message-ID: <612ec933-6036-4df7-bda2-c07e4989a6c8@siemens.com>
Date: Mon, 20 Jan 2025 14:51:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
 <0c27d834d60e2408da0e016254ad260e5dd534e5.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0c27d834d60e2408da0e016254ad260e5dd534e5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0012.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ef30bc-43ab-4e20-3716-08dd39598a35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SEVjQ0JYSDNBUHJnRmlKSmVjYXo2R1JBejJtME4rREc1RlRZZEFuKzdzNm5Y?=
 =?utf-8?B?eThiWngxSCtOQzRqYVllWmhFbnJOci9zc0txYzJIdE1YTHNIcU80c001RWJ0?=
 =?utf-8?B?NHR1VThVVjRVejVUYWRoYWVPd2RIR0ZLYkdXWVRpTENjVGJoeVpGNmNTa1Q0?=
 =?utf-8?B?cGgvNGVSeUphdDdZMFd4c3FXcW1zSnhrdSsxY0NZMHo4VVJBRVF6QnFPdHk0?=
 =?utf-8?B?aTg3akQ0UTVNNEVZMWthZS9iL0hML25aeTk0QjhQQ29PbTY2YmV0V2lHUFhP?=
 =?utf-8?B?ZE9OQ0FzZ0VlS2JmRmZUd2NKOFRLY3ZuWWZhaFVudThtM3pUV2RGSkxGcEtx?=
 =?utf-8?B?U1VxYS8xQTU3N2xjTkNNekw3Nko2eUhOQ1pmbEtpZW5DVjRKekdmbENyek8w?=
 =?utf-8?B?U0p5eWpORmJnZi9rT3FxUDhjY3h5OFBXN1NsVnUrK1l6SW1Za0hXVkwvN0pY?=
 =?utf-8?B?YzdBM01aUkdKWHdVMDBuOFpsUSs4QVZjZEc4WWI0VWtoa0ovZVFqa2JYaVFO?=
 =?utf-8?B?c0MzTHBva0YwZ0VWcnFBanhHTzFYdUp2Wkkya3Blam0vZ3JzemdFMzZyOVdv?=
 =?utf-8?B?V1o3Q2VEQi83RE8wRXBYbzBFSjJCbG94MXZjcENpOHlsN21uUzJFVWpqMkFD?=
 =?utf-8?B?cmdTWmFveC9hUlJmZU4zU3F4K2ozNXA5TWZyMzdNNVowMmIvRkEzWnkvaGVS?=
 =?utf-8?B?VnBUSnU2bDdpOHh1Z3ZKU2duRjRGSUVtUHNOM2dESWt1ZVJaWlR2a2FHQnhO?=
 =?utf-8?B?TDVLcGNlSFUrM2twYXdoVThJeEJ1aGVyTXZySDJwaXVwTGJtRGd6VkIxZG1C?=
 =?utf-8?B?N2NrUlJ2czRRamVLZzhlRUxBVzAxOS9WeVpJVDdvMFdKYkdiZzhXZ3psM2tx?=
 =?utf-8?B?aExYK2Q2Zit0enFOVm4zd3RkTXJLZ290K1hIV0txK1hnK3JOMGh1dmtqUmtw?=
 =?utf-8?B?STZGd3BzM0pOTDlqVzQ4aHhOM3RkUUZxYnA1cUdzdW0reWQ4MlZ3bU1hcG1v?=
 =?utf-8?B?MlgzUlVjMHJHd0UxcnNTdnBMOUFieHlLZFJ5U1BsbE1BV29COEpiWFhmWUR5?=
 =?utf-8?B?eXFrRkNYNXF3MEkvOGtaZStqUWpqSnhoUDk3RHdzdHZnY25iOXl4STRkRkhh?=
 =?utf-8?B?d1BMZGNoTm5Wbm90bVdTcGQ3WWsyQnl3am1kWFo0TG0ySzJHNmtwdG9zKzQw?=
 =?utf-8?B?bUlPWFNSRXB1aXdJandyTnR4M09jdUpQOUNSVVN3Wi9KRVNYQ2ZmV3lBaXV5?=
 =?utf-8?B?TllzMWhNTXhZcmdsZ2plZzJSZFc3ZXREUTFGWnRLVjBlLytyNUczanlGT1R5?=
 =?utf-8?B?M2ZPalFwNm5vQ3VDMmNFaFF4RnJoWElXL0RmakpxcjM5Y2VONVZvTHJVRENG?=
 =?utf-8?B?MkVFdjlPUFdZdExBZGFSYjVST1AvY3VWa0kwQlhSMHhhYnh5UGN6Q3RodW1F?=
 =?utf-8?B?MDJEQ0g1MDJsRWNMQ21MUkdWM0E3NzVvaEU5U2xGZHhJUkFlK3BiUlFWYUZs?=
 =?utf-8?B?TEtGWCtRN0NwRXM2aEY0S3dvUU9tOGZUQ05XU0FiT3BxL1YrUWc0RUtjWUZm?=
 =?utf-8?B?S3NZbmltM21WY0szUDZnQ0hVc0hQM056Y0N4ZzdJbGc0MVJiRU4xSlVCcmxB?=
 =?utf-8?B?QmJWVlZGYUtPTlYvVE1RTlRBdGJiaUtBRDNKTy93M2kyNGZtNEtuQ0JaQ3Qy?=
 =?utf-8?B?T29mOWoxT3JEd3ZJZ0dZVXF0UHRGTGhhamRRbGJnYTNFbkp2MWxYbVJtQjNk?=
 =?utf-8?B?NlZuT0lJMk9JSzlBcHJCdDY4VlRzNmUzZmdnd0tmQTVNSGc2QmU3cGFveEFu?=
 =?utf-8?B?TklWQUd3eUVJMmxVVUVVWVV4T0NwcVlUeEtOWFJ5ZnFFVFlvU0dzQkRVM3FD?=
 =?utf-8?Q?KzrJIjbvwxKso?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2JyNE1wMHI0SHhlWDN1ejVxWFMrRFVVTXdBemRFQ3lxR2x3WFIrZ1FBc2Mz?=
 =?utf-8?B?ZGM0QkFTcHkvT2dWVWJzUldjd0VuVFJZUGNDY045M3h2TXJSR3hKMnBhbm5K?=
 =?utf-8?B?M0ZtNmw0V3libHhDd0I3OUNxZnZpNm5FTEkrZnM2ZC9ocXdsV1RrQXJCaHo1?=
 =?utf-8?B?ZXZhUzY1aGxXbnNqeEZyTmNaNStDNk5zUTdyUlFIVUlKTzE3Qk5EM3JCVVlm?=
 =?utf-8?B?bExMcXREMFArQzNTaDFidEVRUU9VRTltRWJ4aVB3VWZHbG5LRFRCMWMwRjlt?=
 =?utf-8?B?ZVlOR3Z0anlEaDlkaWFGbEh6cEhidHBaa3N6Z3Q4UzF1b2NxcklBbWovTmIx?=
 =?utf-8?B?RFZudkRKNGZLR1NCK2sxeUE0OEh4elJSZHJrOWo0RXA1QWhDVWhEdGpoWHJa?=
 =?utf-8?B?KzdtR2pwSnBQVTh2akU0SmtJN0V1MW9HenJya1ZzRkE1WTJMei9HYmZ5eGZR?=
 =?utf-8?B?Nk5IcXV1SEdmUUNTaVJkRzBkM3ZCeWpvZXFmZXg5RGZpeS9BL21sWWJyUE5E?=
 =?utf-8?B?SkFvODN4aW1LNzg2emdsbUJXTlJKSEswd21wYko2ZkdFWE8wRXdzQS85THVx?=
 =?utf-8?B?UC9HQVRoVEwyU1VsY05xdUFtdXVuQkJrbWNKZmdoMHVsMnhOdjhnbHE3Y0dy?=
 =?utf-8?B?WDhaTG5kd0FSdHFaQmtZT3BxaWx1TThtc0ZQelM3YldEWVRZclhCTTIyUkgy?=
 =?utf-8?B?SFhTYk1VREQ3ZkxtUGhScGRMeDE0T0ZZY3k2Q0ZyeVhuRzRyamFVRjNRMng1?=
 =?utf-8?B?MGlQc2ZiYyt1Yzd2UTZtcC9FSG9PLzZKSGEvV0pQMWlpelJ2L1k4WTVLVmJO?=
 =?utf-8?B?TjUrVW54YkxLNVViakFlV2Y5VHBzNjYyR204c0RsM2dxMm1Fa2w3aVRsK0Nh?=
 =?utf-8?B?M1dzeFAyMUJGS29pZG5tUUtWTysrTjNuZTFYVGxPS2c0SUM1b29ZT1k5T3Y5?=
 =?utf-8?B?RWRVY1B4OWFoWmZnQnY3dWVtUWRIM0VzUXJDcnZmMzI3WjJUcHhVOUtuKzB1?=
 =?utf-8?B?aXBEVFMwdWNRcFhCZTZZbHVha2NSV0M4UGN1RXdsMnBBdGh1TVJlSW96YTZa?=
 =?utf-8?B?WVpTRWRQT3FjaUtXUW1jRUVFUlpBU3hiRE9TRko3RVJRdFBNR0grT0FsSyti?=
 =?utf-8?B?OExwbTZFVEFIVDdDRW5tbG1GL29JQUJTVEdESWN0ZGNsVnVZWmVxVEE2L1B2?=
 =?utf-8?B?WEl4Q09EcGhsSGJ2YlpaUjlGZ0RCcjF6OEZZem9vTUh1OVJ6azQ4bURyTEox?=
 =?utf-8?B?NThQS2ZFWUYvODlVT1pSUEs5OEZValBpeThIKzlUc29SdXhNY2RUWS85aXJB?=
 =?utf-8?B?RExuWk5abHlRQzdENzZ4bWxpS2szVFdUN0c2UzhkQWc0cmhIWU9DTnoyUEZk?=
 =?utf-8?B?OHZxNzZ4TnFxVU9rRGR4cnp5UWQzMjMvMjVBQ1NmUER2MUVpcTU2SUgzelI2?=
 =?utf-8?B?bGViOVZodVYvTGg5NTNvRkpCU3VxNi9qYmZwT1kzU1RIeVVMdS9icnFIQkRq?=
 =?utf-8?B?TS9ZNWZ4cW9MZzFFcG16cWFsemxrZUFpazVrRWY3NytHYnVlV1ZUWDhXZDA1?=
 =?utf-8?B?U3V3OHNmVnNMeXRhRXYvbXI0QSs4Y0FPbyttdXlIVmJCcjdJY3RoNk1hd0g2?=
 =?utf-8?B?Skd5ZHJtZ2VYYlppT3V5TERQUjN5ZGRReTh1S1JkLzZQY1NFcThNcmRObG55?=
 =?utf-8?B?bVFVSjc2WExiTEJKTnZpRmFadW1zdjZIZmVjL2p5Vk5Ja2M2SnpkazZUMkxr?=
 =?utf-8?B?Nk14WjdRS0s2RDZFVGJWb1NXM2F5eFFrdlYwaHUzNlE0WXBaWWQxcC91VlR0?=
 =?utf-8?B?MG9LSzU4Wk5ITWtGZ0N6VWJLTlJvLyszVzN5MWg1L1FkT0grVG9CUlhGMGY5?=
 =?utf-8?B?RzZkdFErU2ppVzZ3d3VjUUlQbWhGbGtSQ3lxU2JOQjZob0xwS3QrNys5MHMy?=
 =?utf-8?B?UzJnck9QZEUzZllReTNoZnJxMHhjdFBWS0VSVHRFemtmMzFib2RteFdnQ2ZY?=
 =?utf-8?B?M2xTTVpkd0g3b0pUNnNqTUROVXN6SER2ZUJPWk5zQnlpV0w0OUFza3A5Um1E?=
 =?utf-8?B?Q3RidVdqM0I3dXRCblUzOW5HMkRlRGJ0eWcxTHhYa2FqQzJqaW1RMm9MdHpp?=
 =?utf-8?B?NXd2cnpQdFlwZnBTVUJNaThrR1UzNjVzVVFkNW1LMHl3c3VROURiVGNwZWdt?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ef30bc-43ab-4e20-3716-08dd39598a35
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:51:29.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7LSB/dVelCcZafbrOvW5G4ij6Y/dEDcOvdffoFJjt6oqx1Knk50LurBsOkZ/htMaO4RJk95x/PHhrzkaYwdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8792
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 13:51:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17552

On 20.01.25 13:51, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Mon, 2025-01-20 at 13:34 +0100, alexander.heinisch@siemens.com
> wrote:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> In the current implementation (since: 284175c3) disk expansion logic
>> is done before the actual disk encryption.
>>
>> This results in reencrypting the full expanded size of the disk,
>> instead
>> of only reencrypting the sections containing the actual data. This
>> results
>> in a drastic increase of time (approx 20x on our systems ) needed for
>> reencryption!
>>
>> Since relevant disk contents are only available in the sections of
>> the disk
>> available before the expansion, it is sufficient to reencrypt them
>> only.
>>
>> This patch changes order of encryption and disk expansion resulting
>> in
>> faster encryption (since only the necessary parts are encrypted).
>> The resize operation does not reencrypt the added disk parts but just
>> extends the LUKS container (cryptsetup resize) to reflect the maximum
>> available disk space.
> 
> The thing I am not sure about this patch is, if executing the disk
> expansion here is really the way to go, or if we shall just reuse the
> expand-on-first-boot from isar (incl. fixes proposed earlier - [1])?
> 

If you find a good way to factor out the common code an reuse that
inside the initramfs, I'm open for patches. However, as we discussed on
the isar list as well, using the systemd service later on will no longer
work once we properly hide the keys when initramfs ends.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

