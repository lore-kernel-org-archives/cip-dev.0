Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E415FCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 05:58:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11282.1762840733900386551
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Nov 2025 21:58:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YmSUO3Jz;
 spf=pass (domain: siemens.com, ip: 52.101.84.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+uKavxyEXc0wMtycFLvhDG0vG7jS7wzi/WozAk3ACUhfrrmlnj25jvjwLVGVZK6O/YsCAj+sMYQ/XWUg7yIrJlWBt3PnfJAwDAzSSkNbkx/9U8LolzGaBgU5W8LGdBvVxuvX2XMYlmbGWJ9auCWLIA/kr+ABRIV5ofmre8ZrxAJmPG9Ak1yNxAeKje4Zxb6BY6dCikUasi3WmD3pSftIQ6SfBLjQBvFHx4/jabYjPr0F6IMkGtanaFgb7aDq2+47Wg6mvIBzrPI7a4V9LAo16qKDNgEY0pcl6v6kQfouazrNaxPLeu/fD2+qQJSn2cEc6uSHH6bh76rtD9IMybF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvTUoehxtUboV8TqMMMJcML0tNtBakayi7oBL0jGNvo=;
 b=y/LsaW9NVO5KNNboTnhFTclmM9nKE8w5lywhGjGlUvXaiYugeGfiNJlOKe+JAMmAOS37xG0Z7+x/RzVyAp1PY5hL/yZ7s8rueul7rG3llCOGQlDj3YQ/yOD4wdEeXlEyoYr8TXksBa2uzkonimNxEHZqgmgAZeuj9cOZ+n8EZMFMc9PoNQ+Wk5eJXHseFcJfFzwJHW8KAUWuTiMDW4amPyaG6Tp9fb20bfpCEAybQfKM6HixwfBFPOLzHDsL3RgzeQxKARLrWXsNIezq0l1E7m60cBWeFknO44WEo5yNsDzANgP2ZI21fMX5MBvHSu4bhpWlHFa2enttD+6rnIkg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvTUoehxtUboV8TqMMMJcML0tNtBakayi7oBL0jGNvo=;
 b=YmSUO3JzPfq1/ECQZN+2j7v10iDxUbGK4eFYdDLPKUMvdQvkPcYJNe7gtgkm19NqUhDD3GYzn22CrxQ4rxxLjBQ6HVA+1z5FdD5s1Jy5Mp7B1/E89EPz5ZSuZYYg9r4cgNIJZTotU0J7l/atjTTedxpZozG1wO3XH796irGAxD3XFDqxS1yNB259r6KNy7zHbZCSFJwOS+I9U7a1DXMkTgvR5zImjyHnT0aoDruNjQlAb1BWyrrtPfLZw5nw+RD3+FVogsxUvXEOTGYod4DRVv/k9/Nyvrl2LslQbpIyLLQfbO5vcApAYigmdcf8hIB4lzZqAI+6mVMIqTYYUkMGWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:58:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:58:48 +0000
Message-ID: <13e62f1f-981f-427c-8f0e-91cad14a5a84@siemens.com>
Date: Tue, 11 Nov 2025 06:58:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] scripts/deploy-cip-core.sh: Support
 deploying artifacts for RB tests
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251111044720.778805-2-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251111044720.778805-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 93095382-fc0a-4ae3-a3ff-08de20e761cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RnVLcGNNcVo0MHpRNWtESERDQjgvUnNIM1p2c2VSNXN1L2V3RVM3eFQ5N1hL?=
 =?utf-8?B?UnFVeS9OVERLY2YxbEgweDFad0FldEFsRjF2NVEzTFIvUk9sVk1vSFRQR0Vs?=
 =?utf-8?B?RDFUbGo0VllFSmNhLysxNVJlNnVjYnorQmg0Sll2bHBhbk5Ec0taTitMVFBq?=
 =?utf-8?B?OURCbGVkcGVpR2tra1Q1bUJ4dS81MmZqeEJtRWI4TGFaUlFqQ1BTWkdYZTNJ?=
 =?utf-8?B?QTdxNWtqdHhCZXMxbFdFUlExQk84QTVJS2dLRkYwTk16YkN0cVNUczBrL01M?=
 =?utf-8?B?ZjZZUU96VXN3UElyUGJDcHJyVUNmUUxld3RxaTQ0eUVxWmdFTWliTitnd255?=
 =?utf-8?B?eXZHaHdkWVRkYXhkZUx5Y3o4UTNrUzZWYVlEc0tmY2x5OTZQQWZQWGdJbndX?=
 =?utf-8?B?SCs5cXg5eHI3bHdmVlZIV0cxZmxpcFhDdEZHd1Vsd3h6dzBqTlhNWVF0Nm9q?=
 =?utf-8?B?MGxGVTRHUzU0TnJQOFQzWFh1cUxySTBQMUQrTGNtb0MvMUFnam1NMzVDdnVP?=
 =?utf-8?B?d09UR0VXZGJhZEhFa0VmVjhNRWRlUFlpeWwreUtKRjFFVGdVTGVNd2o2YmQ5?=
 =?utf-8?B?MWJqdVNhTTlNQ3hRMGcvY0wyeEkvMjhVNWhvSEQ4V3hiQzB5OE9yZUNmRHZt?=
 =?utf-8?B?L2FBSUw4SlV2KzUxNk03RE01S2RvMDRTMWJQUDdKL3pnTGcxWUlZSU14UGZ5?=
 =?utf-8?B?NHVKOEJ1ZWJPYlZFOFdkK3JqR0ljdVJFRTdWRHM0TGRkN2dEOFczeC9EMlIw?=
 =?utf-8?B?eml1bDJWczNEVDByWkdCaUxZaG55bzk0Q2hVaFRlUTRxUXJXL2lsckxJeFFH?=
 =?utf-8?B?VDkxWFhjVzVpTmlrNU5QbkM0QVg5TDEwQmZaMUZqZ2VZRjBhYTl3VVo4N1lP?=
 =?utf-8?B?bUd1b0JKS2lGTDBhU3lNUCtLYTQyUnQ0bWZaODJnSjBobWw5ajh0MHFtQnR3?=
 =?utf-8?B?SjRmaC96NmpRcXR4VU5HM2tzWXUrTWY5MkhrS2xPZ3hvQ3BGV1EyRk9tMGI3?=
 =?utf-8?B?VUtQVW51L0NJbzVrR3VHZFhFdFhrRWVNQjFoOXVsTjV2QTBvSDhlYVVja2dN?=
 =?utf-8?B?RFRWN1N4TWg5SCtoVW1sbDRvS2sxenBvRWR2L3JiWXVXSUtRMmJZUStwTlE2?=
 =?utf-8?B?aVp2Uko1blJjWWp3bTlMMkd4dlp3ZGFONnBNYkZRRThIQkZFcnhlbCtXN1pH?=
 =?utf-8?B?dDVnMDloSG1iV0o1cDJyN1JaWHRqWkpzNGJoWW1PdEJhajBQdnFDN0IvWkpN?=
 =?utf-8?B?RGZIWnF1TTBiNzNlZEd6bXdGajlrOElnamlSeHpvTTUvbThvODhRdGFXNGFo?=
 =?utf-8?B?aXVVcHYxNG1uNFBjcEZJM2ljQ3JXOXRjL2FKY3pEenpPWUllZWFMRXVKSkZ3?=
 =?utf-8?B?WW5TaG8yWUZIaWRKbE9JL2t2bENJUHNHUldUbm9jdGkzQ0R3TmJ6N0g4QWVz?=
 =?utf-8?B?TG01Y1RRNkpaUFViY1h1bzhIS2RNQkpJc21KcCtJTXUxZDJGd2w4aU9yMVZI?=
 =?utf-8?B?RThzaEVETVg4K2VVcStnVU8va1NVRE1QT2lPOUZHV2VJNWFEWXZQYzVhelpU?=
 =?utf-8?B?Y0w1dEVUYXdMQXVhSElYUWNWQlliWUNzRHNGd0swUkNsQitLTEE5cEF1ZlBE?=
 =?utf-8?B?L01GTEJBajhRUSt5VWF1VHVJeHhERHlMR0hhQXErYmRNVUtNakVrQnloa3R2?=
 =?utf-8?B?TGFpeFAzaXpyYjdMdFBYdGVoa2hBa3U4QVc5ZXhTdWZZZ3puL1FQVWlPOW9T?=
 =?utf-8?B?Qk1MT0s1UExrZFpvcWpnZXh6T0h0NzFESXgzMmd3OXE0dEd5Uzdab2xsWGRi?=
 =?utf-8?B?cGNicDhTQlpNNi9xeFk4ZFZBWTFVWS9WMnpQN2NUQ1ZSbXo4QTFPWGxUK2hM?=
 =?utf-8?B?TFF1d3poc2lNS2ZydC9oVTJMVU5uZ2hmZzh4dkt5MWpjN2gvbDFNYTU1VlZZ?=
 =?utf-8?Q?agsstn3EiuiVZ5QwA7G0peofjwgIwVeM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amVNTTRzUFBKRzROcHZZcENLT3VISXNHOGVEVDFYb2ZqVWJKdFFGb0FSUlRH?=
 =?utf-8?B?Mk5oOWVBcEVxdzJKdlhrUU94NGU4WGErVkNMeU1FVGhyZnNaQkdMUXhFRDdz?=
 =?utf-8?B?eTlRUGVsVDVvZmdpREpISnp3Ly9CcUFpSm5BeldmWVZaWDZWMUJBS2QrSDBp?=
 =?utf-8?B?SEIydjBtSndLOE9DL1RRQ2FvTEtxRmorbXd3Z3k2S3FRb0YyOWJBeFFNbUw3?=
 =?utf-8?B?N2tYNnZDSmdjL1VXbm5tSkFrSnl3bHhYamVSaHgyVFIwZnY0bWFNVHN1M2hO?=
 =?utf-8?B?MHliU3ppSTdkakIxVTN1bnZ6b0dVNlZNSHp5cGFvUnZ5djd1MnV6VENIZzFW?=
 =?utf-8?B?SnBnRmorSlZQTzVkeVF1cEVJQ0pjMXQ4YkFTMDBYV3c0TDdRM3dJVVFXeVRU?=
 =?utf-8?B?QUN6UGRwTStmVTNXNHpSUTg1aUx0ZnFqVlBNZkh2MC9lN3FzTjZWZ1RSb3Zz?=
 =?utf-8?B?K0xoVFJMYXZvTTREOGxqUjBHTFQzTjdhK3lqNjVUblk5ZCtWVWNmWllka21Q?=
 =?utf-8?B?czUxMXQ1dlJDQ3Rla2xrcEtJNVNKTkxUanFMZHU3MnpGSlRycHY0SWdMU25h?=
 =?utf-8?B?a1FiU1h4UlRUbEVlemFLa2xmUlFTZUVEUWJvZVFrMEYvVHBTVXlKUXBIdElK?=
 =?utf-8?B?S3JhWnhhRlhrSU1Ma21ici9yNkd4WkZYSlpsQnhSWWxpcVR3OHZOTHBWaG9w?=
 =?utf-8?B?RUVuOU1DSGxrTHVKTzRPZTY4L3VmVkRNY0hsRkZ1am9YTjBOdVJLNG1YRXNJ?=
 =?utf-8?B?d284eVgwNk5RcUZCci9pOE9IM2ZjeUhxS2wwR1UvY3YxRy9yS0c0OXBLODFG?=
 =?utf-8?B?a1FaUGJpQ215aWdheHNzL3RHSjNBdUtFTmdSUGtTem9sekl6TDh3bjBoVUZm?=
 =?utf-8?B?d01GcVd4bzNpRi94eFk4UjFMRW9jNDVQczdRVW9Oa05WelVzQUpHSGJJamR3?=
 =?utf-8?B?Yk0yMGR0WGZsM3BJYlhHVFVEUGxKL2dpcWtrdUxuajJLOEtjZ25TRmhycXkr?=
 =?utf-8?B?R3g4WWVPU0tJS3A4SlV0dk03SmpPbXBWb1pocUJsNS80MGZwVGZsZGsrOE5C?=
 =?utf-8?B?aHdiemJLVUMrc3dLWUpIWjErNUwxQlNiN21wa3NYUTliOHpHSEdMNmlTOWll?=
 =?utf-8?B?dUYzalVvU2ozNWtic1EybDFDaXJZQTY3aDlXUERPaU4vdUdjUnMzY3JWT25w?=
 =?utf-8?B?TERVU3d5UE5BUlpVckhBbHp0eHI4aHBZVWFLQTZ4NDN5ZHIvbllLUnoxWVlO?=
 =?utf-8?B?UUJLMURJcGlKVmdEeWR3dXhwV3hhQnY1dW9PMDMwazR3YVlpM2plbXZWbkNE?=
 =?utf-8?B?Rk9wWmszT0NrRkVhYjZIYzMrellBenp5bFJ3Wlo5RDNjTWNNcGRqSFQwOHpu?=
 =?utf-8?B?QUlTNDdkQ091YzU3dXYwVzhsL2lSVjhzY0xUNUJSKzk4cFM0UFAwUDVQcDUy?=
 =?utf-8?B?dHgxMjBueGFlVXZPbmIyRHAyMVZLVnNHZlBjRkk3VjBUa0UxbUJNOUl2Qk5I?=
 =?utf-8?B?RTZXQnJyOUFYWVRaa0JLZFUyU2NkYUxrZi9YK3VoaFowOC80dWovcFdSR3Vi?=
 =?utf-8?B?VUdPTWIzTnRQU3FoQjRIWUR2cHRuYm54dFM1blBTdmF6QzRBNHBvWWtrOTJO?=
 =?utf-8?B?bkJlR2dhWFBUZjZOTDBPbkdRY0Q0WWNoTkZTVUJONmpKZ2RyTkZGU2JUUnJP?=
 =?utf-8?B?U2hrRlQwVkRxckdkSDQvZ0Y2YlJCcXlQU1hGUFZ0TUMvZ0NvV2VTTUl5dVBZ?=
 =?utf-8?B?bk01RzNvenFRelRtaGt2T0hzemNZcjE0ZmZHcUZ5YlR4ZXd6SEttbGErSnF2?=
 =?utf-8?B?YzZ6WHdPbXc4NlY1Y2Qzdlp2ZWFmTWZhc3VtRzBseUFtaG02WDJ4S1JWK3ow?=
 =?utf-8?B?Kyt5ZXlrSk5ib2E5dEcxK01QbnlVNjF1WlgzcGVYNGVCbnp5L3d6cHZqUCth?=
 =?utf-8?B?TlZCOFRMSG9ncGlGbUdwM3JFNGN3MEFYcFNKajdyUUtyTGdlVnQ0NUhjaHZV?=
 =?utf-8?B?VWZZMW5tcG5SbGI0bnNyQTluWHRIcmRVakFuS2YwTDM1UVhiQ25yUlhtdVFH?=
 =?utf-8?B?aGRmODgzUHBtUzJyZjFXWTgzemJnbjU5TkQ2YytaZG9wajB4UVlXRFNOald3?=
 =?utf-8?B?L2c5ajF3ajZ3Uk1BbEFTdmlrV1R1NlRwS2ZJdVVlaFZrZ2MyRTdYbDRUZGhj?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93095382-fc0a-4ae3-a3ff-08de20e761cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:58:48.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPHz4bPI1BURCkwhefZgOiMszvgTW170k6r2Iz3AMV9SUbu0dq3iPStLizpRyrwGd7cKDrWtXHut+TD+tcizZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7536
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 05:58:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20490

On 11.11.25 05:47, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> RB tests require two sets of build artifacts to test for reproducibility.
> Let's support uploading two of artifacts to S3 when RB test is enabled and
> also support uploading individual wic partitions which are useful for the
> RB tests.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  scripts/deploy-cip-core.sh | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 5647381..7920d63 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -18,6 +18,13 @@ DTB=$5
>  REF=$6
>  DEPLOY=$7
>  
> +# Reproducible Builds specific variables
> +RB_BUILD_NUM=""
> +
> +if [ $8 != "" ]; then
> +	RB_BUILD_NUM=$8
> +fi

Just "RB_BUILD_NUM=$8", the conditional assignment is unneeded.

> +
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
>  	if [ "${EXTENSION}" = "security" ]; then
> @@ -30,6 +37,10 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> +if [ "${RB_BUILD_NUM}" != "" ]; then

if [ -n "${RB_BUILD_NUM}" ]

> +	S3_TARGET="${S3_TARGET}rb/${RB_BUILD_NUM}/"
> +fi
> +
>  if [ "${NO_KERNEL}" = "enable" ]; then
>  	__BASE_PATH=${BASE_PATH}
>  	BASE_PATH="${BASE_PATH}-nokernel"
> @@ -51,6 +62,12 @@ if [ -f "${BASE_PATH}.wic" ]; then
>  	echo "Uploading artifacts..."
>  	if [ "$DEPLOY" = "swu" ]; then
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
> +	elif [ "$DEPLOY" = "wic-partitions" ]; then
> +		# deploy individual wic partitions, helpful for RB tests
> +		cd build/tmp/deploy/images/$TARGET
> +		tar --ignore-failed-read -cJf "${BASE_FILENAME}-wic-partitions.tar.xz" ${BASE_FILENAME}.wic.p*
> +		aws s3 cp --no-progress --acl public-read "${BASE_FILENAME}-wic-partitions.tar.xz" "${S3_TARGET}"
> +		cd -
>  	else
>  		echo "Compressing $BASE_FILENAME.wic..."
>  		xz -9 -k -T0 "${BASE_PATH}.wic"
> @@ -100,4 +117,6 @@ DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}.dpkg_status
>  if ! echo "$CI_JOB_NAME" | grep -q "$1"; then
>  	DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}-$1.dpkg_status
>  fi
> -aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
> +if [ "${RB_BUILD_NUM}" = "" ]; then

[ -z "${RB_BUILD_NUM}" ]

> +	aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
> +fi

I folded those style optimizations in while merging. There were also 2
shellcheck hints (quoting-related).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

