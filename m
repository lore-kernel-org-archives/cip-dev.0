Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1879D1269C
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 12:23:58 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web11.16591.1730809436597968300
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 04:23:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LZ2XQx7w;
 spf=pass (domain: siemens.com, ip: 40.107.21.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKTMw+Xsv4HJkxSS3JcLR30YFISukEBeRk1giyoUF/FmQPjzkeuIgE4k43eItos+cdMXxBE9sIsqmth4N2IG6lQsnBohtEFCBa0WWlisSLmyTtT8anxMru+j0i8UgTZ9CtL/Qjz38gxLIJT1jDBKp/YOWivpSPH5JYDj19Xm+LuEhbnyK02llUfD4wT6H9ky8x+ZLvvBO7FvWECYyPGxI5bh77Rne6NPmVY2e9LZE0fYvl9c3PLFWf6tw/tEcIoq/f+KmYLodz8NFou3xBI7hJ/uxDxBklLONeuuNrj1aIedpSv1cVoaL8TM524TdbHaouD0WdnGfJa+/3TFQ3gR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr7X8YvUnaEn9t5svB+pB17RFzgdRLWs2C1RAzasiJQ=;
 b=Y6Al6s/MKflrB5a96xb0xn5n3X7WdV9h5BQbZQUN2zEqnS2rZK0nQPn/I6/+ACjB3IlD42SAIIqlGWfo1piUnYm0NTn0Wc4fdccDXXRqB4xTWDiUI6LLVn84DkU3zjpy0PsANt7MceHhoZrEy6f//5lYGczKnKom2EJDOdZpqsk5hD7LLaZUMsYqbJVs1AVqZo6AOSTFGE/L+p8jxC1C4BpwXDEX5hKeYbKa/YgpgSAPo9ug0sKrshf4iDjXgrDQWuB6ahwyVAEhplL/4fLxBGz0bWSGKOpO90NA0eldMWwcln8Tp1l4V7JxdcTuVJ8Z1w1fqIQHYG+1Y7UwlDuIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr7X8YvUnaEn9t5svB+pB17RFzgdRLWs2C1RAzasiJQ=;
 b=LZ2XQx7wLYTp0km5UWwH5PEZ7vtiOrV9o6aQcPypbbBjpLO5Fl4TUE/fCK2tbJJ/i8tQO8Z1Y8fQc/IEqk8lYhogAQHk8cm6P0XfwE+g4o1ItSZ4GelyvJfV485CCaydpzGfMul9Uz1ecdrogqlg02osyXZLnBQOH03FSsL6/z4Ca/sY23SL5gaDalRtFAxESHErUTfG6u+zSfyNR3KH7KZQrFZaK7195mcNidewwHKdeKFJ7GB2mjDpXVuraiqbyC0ieVB/ybK/+Z09EW03kkY7O03KHIA/H81ld1vzyyoVa9QxVvR8hmruLa1Zz9q0WuX5ZXl2dMF7HeFhJQXtOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB7550.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 5 Nov
 2024 12:23:52 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8137.014; Tue, 5 Nov 2024
 12:23:52 +0000
Message-ID: <b37fad86-788b-46f1-92ca-812f9f6dd0a9@siemens.com>
Date: Tue, 5 Nov 2024 13:23:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] qemu-arm/arm64/riscv64: Switch to
 cip_merged_defconfig
To: Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <fa83e565-8950-4ca7-837b-1c513a119bfa@siemens.com>
 <cd17b322-28c8-46c7-9876-22cd3f32033d@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <cd17b322-28c8-46c7-9876-22cd3f32033d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b7a810-39f1-49b0-52f9-08dcfd94b56d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Qk1oRmRIZWtCZzExb1M4b2EwQk9xR0FuTm01MTNEbkZpSTBaL2VGaFNCM3hq?=
 =?utf-8?B?cEJVenBBNklyZ1ZEUDVVYWVqemg5bm5VT01CZm56WmRLcFNwTDVacjZLTGNF?=
 =?utf-8?B?MGptQVYzZmhOWXlZcVpjeEhZdG1aT3VscjBCQW90RWtPWGxCdDd6eTNVY1FF?=
 =?utf-8?B?RldOaGlkMGp0NFVjSERRYVF3MkpJTkxQVTlxRWhVY3hiWjhUNVhKczdyeVMx?=
 =?utf-8?B?N2pFL2Y1SjVLTmkzWkhZNEdDNHhTRFBXZzN0QmozZFU3QVYxQzU5M0Z1RU1y?=
 =?utf-8?B?dk0vdHVac0xwTVhlVXQwdzQ2RTJCTkRoeXZ4VzJhelVFUlFNRXpzazhROUVj?=
 =?utf-8?B?ZUV1b1d0TEtncVRReFhDeFpXZlJvNDUxZEEyM0dueVJ3a1lVc1NTSGNSVXJP?=
 =?utf-8?B?NmFDc3Y4L2h4dDFEcDNXa0ZaTUptYW80bzlDbnhjYkM3aDlFcTEzWTZXL2wr?=
 =?utf-8?B?cmRsbGEvSFZ0ZjhsU3NnQUJuTHU0enlMRU1acHZKY1pmeE0wVGhEalJGQ3Nl?=
 =?utf-8?B?REhvbDhudnc1N1dibU85SUE5K0xyKzYydzFqa1ZPdkZnbkk0RDFRTlVobDlt?=
 =?utf-8?B?bW4yeEZIUTl1N1kycXpnZUJ3UlhienV4dmxWU3V6UnhRcW5hcWRiMWNIUEoy?=
 =?utf-8?B?KzM2TUVyWVRwL1I3K1NwTVNtWFdwRnRMS2dEMHZmUVNTemFkMkZxSVFKbitT?=
 =?utf-8?B?WWtLbm1PR3ZZeHcvZEtOaWl1WlliMFpnWU9TY2tJbi9CZ2hwc2dobTVVVHZ4?=
 =?utf-8?B?NnllSVZQTzlxUDFCVTgrMldoQTNocFU2cGlwU056OVRVOXJ2RG1Dd2FNTWtw?=
 =?utf-8?B?VjZZenIyZjNqUjNkeEEvYUl2T1ZEWU9VbldVK2NGaXlQTk1OSHNNVXlHMkFR?=
 =?utf-8?B?MndnR2FhWUk0dUovN1V6MzZVQzdKUDlCZklwOXFEVWZaTDVBUXZoSWJNZXJr?=
 =?utf-8?B?SE1LaWtqTnlSUU5LNGtkNHlaQm03MG9sOHRIdkNFbU1hbUhqTzVxZ0ExZ0gx?=
 =?utf-8?B?ODJKNEZHdXB3TWI1TUxhYVBQdU5rSkhERjJKQ1NMOTNiMDdqM3pYVzZTdUlV?=
 =?utf-8?B?LzgwVkJEYldja2RySkxEVFFKZ0szMitKQVVQc1lVL0lsYU04TnI5WVZhR0ZI?=
 =?utf-8?B?dkhVL3d2eVRwRVU4MFF3WWpYdlNBcXRiOU5IcWdKUkt3N2VJQVM0TERhMXd4?=
 =?utf-8?B?ZTMwWUZzVjlZUkNxeWZKcWRGK3VHQTVMb0lIRHZVUEVqcDhFR0hmYkgyK2Vp?=
 =?utf-8?B?Vk5zZndtRHpOeHQwcEJyVlhzdTFKWENaRmNsS1NaekJqT1drUmN0ZUd5RHJG?=
 =?utf-8?B?UC9zd2pNTjVhdlFDT3BERmI2L2szUFpmSWhwQkYvdGtXdUh5blg3eFZmdTNm?=
 =?utf-8?B?U3lnOHAwNEQ1MDhjdm5GenFZQ1hjOUZSdXdmZVdUYjVoZ2FvZFUrRkVsODZK?=
 =?utf-8?B?S2pPelIvTktWMnNVVi9rTEd6TTM5SURPT09mMkZYbWordE5acVhPT3pTTHVV?=
 =?utf-8?B?SnJ5eGNHYjB0Yk56bzJNd0E0bVk0THczRzJMRnNBQkdreW9KdlViTzVhWGdV?=
 =?utf-8?B?a1BaYTRkTGJBTEhJWHhZU040b0M5eDhOYVhJcHB0ZGxTcE5aWDA3Yk1yWFBK?=
 =?utf-8?B?ZlVXbVVjQ1VpMm03R0VDWVhOV2VyeWV6SE9MVEVaQjJNWlR6czYvRGFkbjBD?=
 =?utf-8?B?YmswTDBuZ0kwUEZhRFZzVXF5M0lka1ZMQXh3MkZsdHZmYXRoUjhYSUlSUjgy?=
 =?utf-8?Q?DKAxY3aFoQIvmpaI1DlyBh2X+rf4nRpxqNMokJj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWJMQWVoMlRaT1RUVytxVzliQnBIRkN1R1RkN0luR1NBWk1pNEd6U2t0NXhi?=
 =?utf-8?B?SW5mMG1DbVI1NDJ2ZlNCMU8vNlp0SzNGWU9xazA3RjIxMGxEbm83N0Rjbkhu?=
 =?utf-8?B?amZsL0V5VUNvNCs4NG5NTzNBRllUZGs2RDVwbGw3cVhFT0hqUlZEb2RZSVJH?=
 =?utf-8?B?YTZaajE0WlFiejAxNFJ2RHhjWDFvZUJXOUJjaFdIZGRCVjRuUXdxckdXdVFX?=
 =?utf-8?B?cWJXNUhJbEVQM2wrS2RxcklIQXF5ZmZYV25jeWltQ2ZKWlh6L1RER3JqRGRW?=
 =?utf-8?B?MjRlZmFPaWFqSWZyQmJpRVVObGY0d3E1WXhYd3l5S2pyaFZQZ2g3bDJWa2l2?=
 =?utf-8?B?RkJkbTJUclBEeWE1WjdUV0hFeFp4KzdqejNEdGRJVXlLMWRXRHhla01IcWJ4?=
 =?utf-8?B?SlpxNjhkdjdwSGJUYVBaZFR4eTlUNzc1TUw0eWVUakNjWjZjWXUwYlB6YU1G?=
 =?utf-8?B?YzhNNjE0R2dETjNtTTBJTjEvaHhlNzBtdGlqWVBaVnlRYldWc01IL1QwRC9C?=
 =?utf-8?B?MEJjNHkvVXJnNFc1OUdVanZ1aDl2VlRKblRlUFpYMzdjb0lMOFUyVzVCMEhO?=
 =?utf-8?B?Z2NBTjF5bWhNc0l2S1ZHaGxERmNUYU56d2U2dUF0TnNYUHdWNDV6TjZZdHRr?=
 =?utf-8?B?Qkx4T0dtblZmeUZmeUdYZktZOE4zdHF6TXI3RUtTWGZxTUpucXIzMUUrVTBw?=
 =?utf-8?B?a2RiUkRmZWFtK1NvblY0ZElKNjZ1WGw5VlhhQldab3RsTjZraEtjMHJ5c2FY?=
 =?utf-8?B?NmJ5WVdnY1JLaGRibjNpdWFFNWJld3JTZWZIWTl6Tk5QNkl0YkNhK3BxZ20y?=
 =?utf-8?B?M2hiNkg2SlB0a3N0TGRLclZSdEJ5eEpkREMzN0g0aHkvRHYyVWFsdmVMaUtN?=
 =?utf-8?B?cnpBb2dxVW0vV1hHTDFDNWZnc0MwNjlBdjZSNm9XQVRMaTJWUDhXM1ZiNXdG?=
 =?utf-8?B?S1lVblJXUTVybDB3Nm10SWxZNHNGVlFtSENzVXJnVUtaZWV5T2d4VjVnTWFD?=
 =?utf-8?B?SWgvWFBzeXVwZ2pIRGJyMk96ZUM5Qjc0SytCY21NU0tjaEdvYnR1MXg3cDRr?=
 =?utf-8?B?VFF5NE9ZUlVlZGh5R2srdzVsb0owSkVzQS9TU0JCRVRaY3pDbkZpUFVscEZW?=
 =?utf-8?B?WW0yZlUyeE5IYUgxK01DZkw3aWJ3SzJUSi9ncXR2bGlHa3JPS05qODlpL2VB?=
 =?utf-8?B?dGZiWU10aTI1YnZESmEycUVPdzJ1bkVNL0xCTXEvd2FMZGFoSlVLQStVc3U0?=
 =?utf-8?B?VEJhWHkvTmQ3Z2lxTVhHVjJUdjVnUmRFc01HcnJqaWR2SG50TEFMRFFTN1h1?=
 =?utf-8?B?WE1wZ0RnYzh0R2lvZ0ZBdWJpYllmUCtwRjdvd1ZuZ3ptRXlqUHpRSDByM20v?=
 =?utf-8?B?YllTTEszMzJFL2xkMWRlVVhuRXhvSUN6Z0QxSHRqWjJBdXZXQTcrTjk4NkVz?=
 =?utf-8?B?dnkxWk1NWFBBQzRFNVkzU0xBOW5oQ0R0Yk1ubFZ1Nkh2MG5NTC9jeEpkU3lz?=
 =?utf-8?B?bnRKU2ZaVTRBL2FVSzB1N01qUzFiWm4rS3pOT3hmdjB5ajF5dUpuMUV4RTNu?=
 =?utf-8?B?U0p4cnVaOU9ONERCdDc0NlZzTHNYUVRKcmgvdjIyUHI4ZGF4WVNaVXhET3Ro?=
 =?utf-8?B?N3p1Qjh4bkFHb01TeVF3NmRGUVdORUtIOElGNW0vQTJNQ3JZMEd1UjVGZXhO?=
 =?utf-8?B?RXBOTkRZN1pwanlZQnI3V0ZvL0l2S2tJdDlqWFdCaVZwODUyci8rc3V1eGcr?=
 =?utf-8?B?RmRvaXdCQjEyOXc2aUoyT3JMT1A2d0lYQkN3NWJHNlh4T0lVNkNqNGpzYWl2?=
 =?utf-8?B?NEI0cW9LdnBrL1R4VmpCMDl3bGljQ2piM1o5bDFmS0hrTGpOc1daQ004TjlK?=
 =?utf-8?B?SVg4ZlNQOUNYZTY3elVzNjZOdmt2dzNmejJBYXFWanpULzQyTHN2VFFaZEow?=
 =?utf-8?B?YWUxWUl5bU4wQVY1YmttSlN6UUxteTk0bmV2SDJEam5FQXVqQks2djRTakda?=
 =?utf-8?B?QmZEeUw2elN1ZXMrUi9CMUkrY0tPQWc3S2FWQ1V2U3lPVld1UkRpekFyT0gw?=
 =?utf-8?B?cExSazhVaWpTNmV3UU9CNFFCc2Z6WWZyczlQQXliZVhpbHNPVm1kR2UyeTVB?=
 =?utf-8?B?NDhXbkloS29WVDM1TmpOUWpydkJSeldvRk1VQklTTGRiNExhaGpGUXd4eWJa?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b7a810-39f1-49b0-52f9-08dcfd94b56d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 12:23:52.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raWb5tAET+weS2Ja0TkjHwkxi5CYel/lmFN1XS72PLPxtY1mfQR/qFD7kCEErs0l+gpnhkW9klu6KL0Hs/WDZ/B0TFQWj90lwDwqTyStDLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7550
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 12:23:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17176



On 10/30/24 14:32, Jan Kiszka wrote:
> On 30.10.24 14:20, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This allows to pick up all common features someone brings into the
>> merged config, like we already do for qemu-amd64.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This is actually a so far missed pre-condition for the EROFS changes in
>> https://lore.kernel.org/cip-dev/cover.1730289107.git.jan.kiszka@siemens.com
>>
>>   conf/machine/qemu-arm.conf     | 2 +-
> 
> Grrr, too early for this arch at least, we are missing some more
> switches in the merged config. Quirin is checking this again.
It looks like we forgot to generate with the provided fix-ups for arm[1]
I will generate them anew.

Quirin
[1]: 
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/merge_fixups/arm_fixes.cfg?ref_type=heads
> 
> Jan
> 
>>   conf/machine/qemu-arm64.conf   | 2 +-
>>   conf/machine/qemu-riscv64.conf | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
>> index d2dd81f4..17c08832 100644
>> --- a/conf/machine/qemu-arm.conf
>> +++ b/conf/machine/qemu-arm.conf
>> @@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
>>   
>>   IMAGE_FSTYPES ?= "ext4"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
>> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
>>   
>>   # watchdog is not yet supported in our QEMU executor for this platform, disable it
>>   WDOG_TIMEOUT = "0"
>> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
>> index 7acf1079..a2c5e53e 100644
>> --- a/conf/machine/qemu-arm64.conf
>> +++ b/conf/machine/qemu-arm64.conf
>> @@ -10,7 +10,7 @@ DISTRO_ARCH = "arm64"
>>   
>>   IMAGE_FSTYPES ?= "ext4"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
>> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
>>   
>>   # watchdog is not yet supported in our QEMU executor for this platform, disable it
>>   WDOG_TIMEOUT = "0"
>> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
>> index 02bb60a0..36d6d943 100644
>> --- a/conf/machine/qemu-riscv64.conf
>> +++ b/conf/machine/qemu-riscv64.conf
>> @@ -14,7 +14,7 @@ DISTRO_ARCH = "riscv64"
>>   IMAGE_FSTYPES ?= "ext4"
>>   USE_CIP_KERNEL_CONFIG = "1"
>>   
>> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig"
>> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_merged_defconfig"
>>   
>>   # watchdog is not yet supported in our QEMU executor for this platform, disable it
>>   WDOG_TIMEOUT = "0"
> 

