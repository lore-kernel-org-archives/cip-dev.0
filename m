Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BDC98302
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 18:00:06 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2183.1790099999347837331
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 11:00:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eBZEiZvR;
 spf=pass (domain: siemens.com, ip: 52.101.65.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p21CsfgvyDLxED3I7o52E3u3FqTG4k0Aku6r+Anqhi3cGkjLmJPZHoBd8RALDBYk7xXpkS5SytoCpDe0gN2+xTdQXtYzn8Crjy9sJycTHMnxpVZ1OugXaPGeMJ78PcqpyVZ9YdccxRry23YtJ6AzK62I+rGeT3TrUMzF3N3khsK8zvR/tj5Ts+XjPB4FdBWAaeFfTuMazEcIm8cO/4Aec2s8EhEdRPUaHL52aRbRau1MDOQgsEWqdFgTeoqwiA7wxjSAaF8mmdgY1Q+Hiis6hrZVqXSpHZcerKWLwMhESnGvTvEfVaWR2wzjwpGG54C8ynEDTHpetF5sIa1evPEMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeUPk4e9mbZhbClH915h+4zrFOroTP/UGyw1TokCXk0=;
 b=FMLOSF53dqSGcYTpfCeWV+7IZpeOfxT4Hs0hKDmeJJc7GoglKYWCkpPkwteeRn3P/+KY+qWF10XUXFgwmDN1Si+qOfyNadtCtAAimZZ3gOt+FBDnM/hYX4kz36NrpJXZIpUFMnaU+uO68G+IRDKoLYuYES2SvP/WUZ4WDyAXr26IV3kPrmJnvH0t1A7RgZHHTfvFVHI5mkqDUCks86RCiDE1QTdnJgkhTPs7RYQzb8i+W6C5tIGG5B6W+M+fr5nsQQZoRgBHeO7My6EEE/3DKbTIcsKuvUTv4VhUNc6d7vIlKBXG+nSOS8jjzTA5gBgW9vSAfjQMXo2XtBj87oGdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeUPk4e9mbZhbClH915h+4zrFOroTP/UGyw1TokCXk0=;
 b=eBZEiZvRsrZ2VxpGTaV3Nf7gnXv+cCnXeAJNXQv9MoF+QVekZMUiEm3uo10uU4VgROLfG8VeJjJpoByo5u+b7nf7FrB+eghQyk1lGBSY7U0ZWB0y7BI2oa6IK11vOe1ZA3rWb+f9ajA0RKx2bm/1v8LmAG65GdIxpYlEMwiIE7FTVuvmW52TRpyp0izozVfed2uEuBaqAPTudrhlSDs0qoQosmT++f0SKGOddkty5EQ0M/x4m0kUxErXMQytFvlDUrP981V0VSa3k2O5izayA5YwRia/cvzx+WKx+Tyd5Qq25fWGdVwdPvVQv/ZldAOkBBqlVNiBu7K0SIFx7rlIow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 17:59:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 17:59:54 +0000
Message-ID: <0a6317c3-cf7f-4ba8-824f-b6e806f79d70@siemens.com>
Date: Tue, 22 Sep 2026 19:59:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2.2 2/2] Fix file timestamps are not
 reproducible for EFI certificates
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Shivanand.Kunijadar@toshiba-tsip.com, kazuhiro.hayashi.f74@mail.toshiba,
 kumar.dinesh.h95@mail.toshiba
References: <20260922145022.167894-1-felix.moessbauer@siemens.com>
 <20260922145022.167894-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260922145022.167894-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: e3eab29d-1ae4-48e8-f747-08df18d34e8a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|6133799003|22082099003|55112099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	Or6q0PM6RSXB/HgoxeC1fvgvJ6nW8Fo3xKRcv/uecFQ1mDm++1n6VRuBC5MHuUW6zZnaQR0OAKbciqVvV2acHTDIr6rAy4PdQSq+j7UxoKJnc8UjCfqLlG0i2yUSouMAFSlgUo1ACG4PQfTxYAJeclbCzwYIlDVuZro7ztWcccfxq3jcogJr/vsgSzjtf2nl+LEm6416t8FZ+t/LY+xtRYjZ2vPNOUtNzV4xzBcAj8yw77t3u+ELdGiXDLmIY+Qaao93KUiplPZiFD2BKt9IkyO0kFTFuXGq/5TvqFuMUbtGHSWL1eX4YXLZLfkR+oRGowL17Y/fC3GR9dYivekBhrNNKuGUj/pXlfdKLHm8u37qRVaKockejApQU1CKbvKTZ7A6IyQcm5I+r+xA7SrYij0BhwPqpMwKcRnJPoYa/xow4BAa1P0RGrs5pc9dytveRYXDtSvnAdIrzmnEOjVaScw6/r8MuXJJGUIwbxHJG+1/+KjzliGSmdrQ67ngwfvnAJTRCi+1IDCOqmwaQ3QT4YNBgYTC9nvYswNiBWyhOedgbLb/xf3yrcU0J0Uv944lszmMkztHSkUpOChTnG4XR7n7Nkk6OvAr/l3YeRynjDOxj6WWJe6ydod34HxJ7te0dEcmTV8mA2Se15KVxOg72FnCUS4uOnP7JCl4bZyps4U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(6133799003)(22082099003)(55112099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXI5NHc3NFF6ZTBXM1Jtd2JTdE5PRVZBL3Z6M0tNWEFMVmh3blV4K0xPYTRh?=
 =?utf-8?B?Si9UaiswbUlvcDNnOVJNcnkzSC9xeGZoZDNsaHlzS0YvK1oxOXZIQUpQelds?=
 =?utf-8?B?T0VaUXYwOGFpbUtBdlRldm5WSTZXbERiR3B4ZXZmNjZuNmVjWVQ5cVZnQlJq?=
 =?utf-8?B?SWhmaTBzWjZIV2t2ZmlTc2ZGdCs3VjJGQmdZOWlJZ2xXd0RJTXNxQVR5ZkJF?=
 =?utf-8?B?WFptZXdTc3YwNXpadU1ZQjlXZGZWemhHTlk2cXFGd21XZ0VHaGgrYmhpcmhF?=
 =?utf-8?B?aHVGQVpoNjY4OHk3VmE3aTZYSk8wU2FGQzBBampRVUhBaHUzTElHUnh1amlp?=
 =?utf-8?B?My9vdy92WWVhL281RXFHNEViWnlMa2h3UEtWT0pxR0FHSzBuVVN2eDErZlJI?=
 =?utf-8?B?YlpGRmc5aTJ1b0JrWWVDRjQzUTBsMzA4ZW5BL0ZPWU9ZbzFJT29WKy9mKzB0?=
 =?utf-8?B?anRoSWtGdnBOdU5hWEFscmhqZkFONG5ELzFXWnZMaVBuOXpLZmJyQ3BGV3pV?=
 =?utf-8?B?UThtRUFRRlUzQ3BvZWxVQVNrZENzZE1LNVNoaW5hclJGVStTZTBhTFRPa3Vv?=
 =?utf-8?B?aWZDN1lTMTRlemlJV2dzQ0x1VXFpOUE0WVlFR0dIZ2x6TFJrRUNjZXdNMGc4?=
 =?utf-8?B?ampoUXJyZEQ2WkZSN2xTZEpNaFBZZ05DS3prMWtUajBHSW9aZ1FORW5zSjIr?=
 =?utf-8?B?b0xGRUdWVVNWcUxrT2pTQUNhZjREWXdHSktBYjRJOG40bExLTlQ5UnVRS0ZG?=
 =?utf-8?B?RnpsUzk3UzZhVGMra01vMzFsNHRkQklDSElBbE9zM1VrRytjc2pEL25tRzUz?=
 =?utf-8?B?SlptVmxvZ3ZmMHFuOG8xS0wyeDEzL1ZMZXJFQktON2p0S28ycm9JaXE4S3lQ?=
 =?utf-8?B?ODFidkE4d09iOW14aU84czYrRzFVbG0xdmZ6NVpmSXNucyttWjlOalFreEFy?=
 =?utf-8?B?RU5ySWZhZXhjaldwTDQwcU5teFBhYTNVdDJ4ajZmcFhwWk5JcHo2QW41Zm5B?=
 =?utf-8?B?TlVGZmt2cVdHOHc5azB3dnJ0ZGdHdUJtbXJDeTRXUWtsUmJXT21YR0RKa2NI?=
 =?utf-8?B?U1NsR3ppaGIrWGI5UHdZWEJaMFdOYmlXc0d1NlAxcERPRllJNGJsV2VtQ0RO?=
 =?utf-8?B?c0ZYOWtIbW1nZC81V0plUHZ0RE16eW16K2hiTWp5MWJZem1QeWtyY1d4b281?=
 =?utf-8?B?YjMxTk03TzNpOE93ZGZtMGtHQnZlMGpFZk9KeXhMOEJ0MFJJemg0VFI5WWpX?=
 =?utf-8?B?cWx2MXEvb1Jaekk4b3FsNTAveEJHTDVlRWgxM21tTlNlTlBRQ1FiOFM1enFN?=
 =?utf-8?B?YkE3aUkzSUc4UnVpOGUrZUhkLzloWGJ4bW5BUTNQekxaUTZ6cktRR0UrS1BV?=
 =?utf-8?B?c2E5OGpYOEVhYjkvaVA1UUFCZTVhMzN1VWlXUmJoRGkyektyWGNZekVOdXVu?=
 =?utf-8?B?NFFWdDZueXZUMFFCWmExd2FvNWpHQ2dOa3NGSk1Jc0RHSzJaeHRqV1IzbGEz?=
 =?utf-8?B?bVp2OU5OZVVXMkEzNHp4emE1SHU2YlVZQ3pEVndocGxmWlFCb01iUnJucXVM?=
 =?utf-8?B?NzJ4TktiV2xXanJkSGo0aGloVHN1SlRXRFBVWEtPbUFEbUZPZFNhK3BCL2gv?=
 =?utf-8?B?LzJhaTF4YTZ3YmlBcm5SZVJ6Y05FWDRocXk2YXJONHF4MUh5TGhWaTdnRVVv?=
 =?utf-8?B?NHNxWTNsamJvRlh3c2ZENkl1TDdXblQ4RmxtL0ZmQzVrMHpzbmJENWJERFkx?=
 =?utf-8?B?REFmUWxycmdGdCtYT2lweHpqYmFvRmZJTmE0LzRlWVZQbTNVcXZzZ3VqdWJY?=
 =?utf-8?B?WTZHWjRMMjVkZW4rNW9IS1BNYnEvSUlVK01sd2wwd2xEZ3gyeG43TTd1NFFQ?=
 =?utf-8?B?T2lUdVJialFHa1gzVnVRSDdHZytoWnhwTXpmdWtTZXgrZlVRZmZpMm5BT2Fy?=
 =?utf-8?B?TklaYVkvVWpUVHB1bjYxRUp3RFc0ak5tWUVLaEwvb3FsM2VPVGd0RDR6VHpM?=
 =?utf-8?B?OFYwTkl5UEwvZzVTQytWZll5OHEwKzM4V1k1V2hYd1YwNFRaTUs3SGxlQU0r?=
 =?utf-8?B?b3pYSE9zK1dSTGZYUlphUWd0YlhQdHJ0Mks0dzBNRDJPVnkrbTNJSE5vUXFl?=
 =?utf-8?B?ZUVVdHF2dnFMUVpwbnNuN2RUQzRhMi9Wa2lsSW5TTHdnb0NrTis1T3ljN0pC?=
 =?utf-8?B?MGU1SElsK0NQZHgzYU1JZlk3Skd0K0hsVldKRHpRL3I0NUR3QmE5UkpFbWlw?=
 =?utf-8?B?REt5OUh4R3Fvb28wL1pVMHVQNzEwOU1SeG02Ky9JYVdNRDlmNFpnbGMyUCtX?=
 =?utf-8?B?SmJYWHBOZ3NXMmRaL0NrQU9Bc0N2UlZqd1JtV1pjQTIwNWVEQlU2QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eab29d-1ae4-48e8-f747-08df18d34e8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 17:59:54.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg1+OPFBR+ScWYkD4TF3vx3wSLK8wT0TzoPZP8jxzF/Z9l9oq9ws/eKgN5Gldp+qQIA6+lq+53bZTC46PHKmvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8917
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 18:00:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24268

On 22.09.26 16:50, Felix Moessbauer wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
> 
> [Felix: let dch timestamp depend on SDE, pin timezone to UTC when
> signing, pass timestamp in correct format to sign-efi-sig-list]
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> index b14d6cc..dfb0ff9 100644
> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
> @@ -28,6 +28,8 @@ SECURE_BOOT_TIMESTAMP = "${@time.strftime('%Y-%m-%d %H:%M:%S', time.gmtime(int(d
>  
>  DPKG_ARCH = "all"
>  
> +inherit secure-boot-timestamp
> +
>  do_prepare_build() {
>      bbnote "Use timestamp ${SECURE_BOOT_TIMESTAMP} UTC for signing EFI certificates"
>      deb_debianize

Now we will have the note issued twice, no? Also, SECURE_BOOT_TIMESTAMP
is calculated redundantly.

Please submit a v3 series which actually replaces the patch I already
merged.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

