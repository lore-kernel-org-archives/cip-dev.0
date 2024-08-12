Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4E3C3DA7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 11:25:34 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.40])
 by mx.groups.io with SMTP id smtpd.web11.44010.1723461925481468997
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 04:25:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SvLjQf8M;
 spf=pass (domain: siemens.com, ip: 40.107.103.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXM4b/05u/c39uAbEKk0xqIEFHUMv8gc4NkVMDndbb/qhAQTgZNY2rgddedBpqq1kPZ7hixzW5gtm8uIInLjvzPbuuOFrJttBOq15l08eJftLWN1em0WAoecRCpsIt7F5QwZ9HQwFMKgLePkHV+nPnzPDDpfBhP5Tngibx1bzq4L0upYiHU1eR2AI4M39+wZFAWGNXOiUzAHSG6A+GZ4mlQqdx6cTGpAfi66q1kPU4zkhmBL07rQeSId7mQiImmp/coDNX00QR1w5MQQyKkK2+rEoqRqkW5/a/CDx372sr6Lbfr+e6Yq7w7HpOsNhkL6endBV5b0En+RpHdMsGNZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgh2LpfGtsWxbiYuZjBZJWQJEaZJYAPz+MVHzxvkv5U=;
 b=qWgpSuqGtRUpqpdZl4iVKMUpsrfKBRlphu2UiyiGWWGvsiKT+IRwsn/jdLndRd+FBHoI1tq6R7tj55pa5mmygpaehOCUbt/95M+kSdXwn6Lfv52IWSul1CAAky4UND48gP5Wo9SwQveAyAz7xIBJAmTS3U9kqzxN5ol4rzSw3Y5X0vYXMth2MmWtYJ3nkDIO9VCDymXgCyAdWtgGze4Qo1Kh2DXHxLXsP9ETn9ZCexjDMQmkJR61a4q9vM8AZqcJ2QOvvDWCQJqKagWOaHLfs9UNgm7K+XpbRjbzNlm/0GSy1E5PKyudNxlpdlCzdMmvSukt9d1IaJRoU+jDjhXdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgh2LpfGtsWxbiYuZjBZJWQJEaZJYAPz+MVHzxvkv5U=;
 b=SvLjQf8MhzvM7R50S+JbINIKcnywk6mkW80CMPXwOb43J+b3QaSQO0s13+KAVR0vHFvUfV85DeznaUGTOBUPUsyzAJa3KEMsBqV0iVH0gzRVMGIF7xRkx4yCWqvUQVcnmc/eUt4YUpNMsjSshhPPsRYvNv9YOQsENQ0Y2nD5Ut9QRz0cQZNZ66ivLe0dA3W1iwljGywybb5iJvxUEKn5VdOwHAG3eEnzWHGsdyTkbKcyKP4c+WVqTnqtSXl5hisapfq18qEmnBHn4SpP3azLYCvxAEgvm8OVQBNhM04C7gMOxzoX3oaI8ODedOyuUKFWMCpa+S9mFxMoSDvKbWgOKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 11:25:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:25:21 +0000
Message-ID: <9fe32cd5-7159-4e53-b8e1-3db1f29fe383@siemens.com>
Date: Mon, 12 Aug 2024 13:25:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v6.1.102-cip26
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <ZrjoeDL95EC/rBlE@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ZrjoeDL95EC/rBlE@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c7e4d7-4d32-405f-9226-08dcbac17416
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MVdJcUFwZnZsS2hMRTZsU1V1MzllQi83VjZ2ajA5clVMZ3ZLUk1Uc1FDYWJ2?=
 =?utf-8?B?cG5IRHlnMEI2STdBUkRkMkIxV0VidmpBa0d4TkZpaFlJeW5Sby9iSlF3bjVG?=
 =?utf-8?B?ZXdSbGh6dGVCcmVJYmpMOGZaTkl5cnJPdGJHVFQ5SXR3bkZwVzV5ektQbnpL?=
 =?utf-8?B?dzhHTkdQS1dNQXE4bTN1YnJQQkpxeVZuZ1hWeUlCdUtCd3F4MTl4SWRqZ09m?=
 =?utf-8?B?N3hibDBYdVkwMzZFOVFROUtBNGJjY3k4SVBoUm1iZkxyWVF2N2FoSHNjdC9B?=
 =?utf-8?B?cDh2YjNkZTROcms3ZlVNaSt5UUF4K05IaTJWOUFjcHhHZVhFRlJGSDUxbWxH?=
 =?utf-8?B?NDdZU2t4MGJPdFNzcUZJdEVHK0JKbEFjU3VjWnoyR2VMOGRxdGIxNzFiVi9V?=
 =?utf-8?B?WkNhSWVqZUdVa3pEdENiRGNjT2o0MFcvUEgyWXViL09WTnF1dS94RWhGdUwx?=
 =?utf-8?B?ZDMyWW5aYlZ1NUZDNk5pNHQrYTF6RENjRCtsUlJQMVJPV3Y2RHEvQnY1L0c4?=
 =?utf-8?B?Y2RWQ2ZTVVBlWGlBRGR0cWlOSk1HaVJ3RCtqcHpSR1pLUm90V05CYnRFZzZF?=
 =?utf-8?B?VEw1MEE0WlZ4REJ1MHRUaDBncmw1dHlJWjBsL2Q5UzVvdE1TVEtuRHlqRElu?=
 =?utf-8?B?WXpYNG40aVBnN3pqdnZlYloyZUs4V0JmeUFsY3NFTzVzVnd3aHRGSkJEODRo?=
 =?utf-8?B?ajdoTkQwSWhUUXA2SkdHeXFHVXNlZFZyWkhDNjV3UDZsSEYrSHFwd1ZJTVFN?=
 =?utf-8?B?UkIvTHpraDgyWmRlRmc1Q3k5VjluSHhzb1plRFltK1dSbktHRUsxZzhUbE1n?=
 =?utf-8?B?YWNxN01Dd29OQmtzS1owbUV6UUVPZmdGVCtTdlpneUxNaDRIQ0ZDclBSNU1U?=
 =?utf-8?B?T2NnTjFldVlLeDloUitKL3lPMThjTWVncDFPajNUeUIvYzJaSEpLaVFCdVNp?=
 =?utf-8?B?WVdrV0tSTVcwbXhlbURjeDdtbGR5UUI0QU84OEtLR0N1OGhPL2FlcjVOYmRz?=
 =?utf-8?B?emNWaERmTEs2S3dXbVJWZTFHaHFqM203NVRhVzdMYzhhODFEZmwvT04xQ1Jw?=
 =?utf-8?B?N2V3K3lxUDI5V0FGNWEwYW8yL3F1SEd0d0djcXJVTTRTYS9xV0tpMXZXMjF3?=
 =?utf-8?B?M2ZWZ0QzVytmSWIybDdjUmloSzFEZnF2NHlpZnNWbkhYcVVmNVpIOVU1Yjkr?=
 =?utf-8?B?SHdsNTJqdGFDNU54SFFiWHBsWDlWWFYwcTBBaCs2cStiTXpQeHUvT2tjcUJ3?=
 =?utf-8?B?azh1MzUzT1NaV09zSEhialEyVGtOUi81eGxkZW0yakVqakd0M0pOVk84aGZU?=
 =?utf-8?B?b1JOUVpkZlhrOEhpZGtlRUl3emxicHhMUmdYQk9ZMHJXSnlmMmFLNDlPL1NC?=
 =?utf-8?B?NVh4MWpjR2QySTZhT2NXYzVFZTVPdXFPMDdpdTZTOVZVT0ZKYWdrT3lobjI4?=
 =?utf-8?B?Vy9BaFRueFNDUHJuNis3QjlNWUxtWldVRUV0ZWFHQXVmMWZxZG83VVA2K2Ri?=
 =?utf-8?B?RXpNTW81bnF4cXZsdFAxV0hhUDlQL1NMTHlxV3ViQ1BzRVhhSXB6WDVGbnps?=
 =?utf-8?B?UkxDNFZWdFJUcjR5UUdoRE9aSGE2VE0zaFBBSHl3cHZYVThKVnhvbXZzS0w5?=
 =?utf-8?B?UEY3SFNVQjM4d1pHRnhIOEZOUkJZYzVvVFRFN01KOEtKWjkySVVEV0RLblVU?=
 =?utf-8?B?SnV4Q3NkeFRjdTVCZ1B6cTVOZDhkZmIxb1ZXTnlrNVRGZmdaUUdwSk5MMStz?=
 =?utf-8?Q?IVCFGGn6VWDWYzQg8E=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2NSUzNwM1FsTFE3cXdhUWVZSDNGbkxCVG5ZVEF0b2lpbFN2RC9UWWg3ZU9C?=
 =?utf-8?B?K1Mzd3FzRjlXTGN0a0NOTzAvYkVURzBHODV3Sm15c3RaVzZJQjJZVzk3NG1O?=
 =?utf-8?B?bTMvNS9Ea21KYno2SzkxQmJ6aUpwd0RnU0F4enRxcit3UVBKUjJyQXRjOSts?=
 =?utf-8?B?aUU1V203aGV3WTZyaVFmYzJsNTM0djNyOVpvVmNVdEh1YWNXTG5Sd2d0WW9G?=
 =?utf-8?B?VDY5aTBlSy9XQThZS3VNZ01PWDRrZjhzYlFmYzBjNkdGcTN2dUJ6TFpWZUsw?=
 =?utf-8?B?bzNHajVYMjFxYmUvc0hIZnl5aXN6QnZnQTUvUENSd0kzTEtBMytVckJuZ3pU?=
 =?utf-8?B?R3duUVFySWZGMFJzbmNqK2Z3OWE4QmJBSnRXNWllK3NtdHNjNmtzWDdMOW8z?=
 =?utf-8?B?ZXJTMXVCdUhNaFVnWDdNWm4yWmtZRU1xcXRmL283bDdTVE9ESzQrTUlkTkFU?=
 =?utf-8?B?R09RS2x4cXo5WWlydjlNNnhGSDF2MmN3R3ZqQ0g1VUo0WWhLT2ZBL3hZc1Fv?=
 =?utf-8?B?RVoxQXlZa0JqQzl3WjVlWkl6UnZmVjZNSHB0SllOMWh2R2xwTCtyODZNMXlJ?=
 =?utf-8?B?d0F0b1NwTnRobS9RYWp0Q3B2ckN0NnpxOW1tQkQ5T1NQbVdxK2ZTS2ZiaDRx?=
 =?utf-8?B?TkpzdjJhRyt0UW9NWUo4d0dMUHhENkp5VDRydXRlSmdJVlUrcENiMWwyYTlZ?=
 =?utf-8?B?MXBFWCtoanNNbjNwa3JJQkplNWtlVWM2a1U3ZXlsVmNMQjFLSy90ZFRobGdT?=
 =?utf-8?B?VXJFTVBCUk4vRnhsQTZ2bmZSaU1nMGVKTDY2bGRIeUhVUXpSeDBKcTNWU01T?=
 =?utf-8?B?UUVpdjlIZlVQelR1cTdSS2Q5OFFQUjV5aDZ5Y2ZnZG01dEZ4YVcxVXZQck9I?=
 =?utf-8?B?dVFrZmFnTTFnUDYzNnhXRVIxZGRGSkJwV2pLYk5EYWUzMGF3ZmpHYzFmM3B2?=
 =?utf-8?B?dkYzalBPcE1GdDNNRFRGRWdYOU94cnQyS1MzekpxcjZFeHJUVmkxcmE3M2Fz?=
 =?utf-8?B?R2F1dkJRbVM1cnVFcUVXcGxhbEJ4K3lHQ3lIaGZ3ZzhmTVB3aUhSa0NiR25Q?=
 =?utf-8?B?Sm1Bd2xMdVh6ckFvQjdvTmxvTlJ4Q2NSd2JaNGdCVjh6aGFRanRkNCtCN3BC?=
 =?utf-8?B?VU5pV1Buc2Z2OCs3NWlBQ3RCa2lmTXBkMzhpWlBxWFByY1hRWldMQzQ3UnIx?=
 =?utf-8?B?MytRUGNFcW5ZNEVsOG1LRjNmYUhYWExxYmNQZHpUT3RLK0ZTNnN3eVdMeUlE?=
 =?utf-8?B?aDlPY0NWeGdhU3o2cUh3V1ZqM3VuVTgrSkIwUDVobW1GUU5xeE5WYUphV3Ja?=
 =?utf-8?B?c0ZQcDdPTElTVThmNk5Jd09wQjd6K1YrODQ2U2wxRlkzZXRwdk9XSVg4M0xn?=
 =?utf-8?B?Sm9LRFZRUDR5Mi9RcEpYY2Z0Ymw0SmJoMDN4SS9yZm1GbkFDREh0blhaVm94?=
 =?utf-8?B?QVV1WEhrRlZrclhHdFIvMk1VYjNBV2ZURzNha2YwWkkzQWhmNjBSTktkMCt0?=
 =?utf-8?B?b056TTZPeWJuSzdPV2dVeEpzK2plZGtGcG1PRC8ycE8zd0xBUU5YVVhkeHBi?=
 =?utf-8?B?T09JNjhrcVdHQi9iNHIvMHhqK21NcmZjeFBzb05IcUMvTi8rQUoyeEI0TW5t?=
 =?utf-8?B?ZUNFZTBXNUgxYVNhWmFpaVY3aVZCUStUL1YzYjRRekJmUi9iTFZKdGJ1UlRz?=
 =?utf-8?B?UWJWWk5hR3A2RGtaR0VIWHRrOEdTYmVhSUIwbjBBcFhYaVB5ZWk4OEFHRm1F?=
 =?utf-8?B?WCtZVXV2MG1Yb2xROGNDUVRSV1poVkd2WVUrVHI3T1IvTEJQeGl0N2hwLzNs?=
 =?utf-8?B?RlRoNUJnMnd5enlidk8rZWhXdVZBR3lTQ2ZwbDJRSVQrWndBeHNwanloRjlW?=
 =?utf-8?B?ampKNGt4bG5UQitJWWovQlZ3NUdlZkVrR1ltUEJBZzU1TFVKMFhidnVGYnhi?=
 =?utf-8?B?bXJndHNGVCtucFV2TTcxZlNTRmc3Nlh6aWhwUENlUFRaMnM0VmQzMXZ1UnU4?=
 =?utf-8?B?WU5vK2lKNXAyb2tOM2U2K3BFY1ZpdFpYNDdaeno5bWNsVEs2K2p5YU9wOHhU?=
 =?utf-8?B?TnpyWVE4aU12V0FwV0Nwd3JiMDdxUjZ3M2ZiNFQwYlBjU2ZtMmpYSE5sWWsx?=
 =?utf-8?Q?1tvDnkyswF77HQwq5RopmUDOq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c7e4d7-4d32-405f-9226-08dcbac17416
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:25:21.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLYJOSIJ8yzUBUxyhmjMvsFj00LoaapwBztv88VHmcVxj1Jb2uYnl8H06xofgOgAfkrcvT1d7zwb6Q1TZ/DLaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 11:25:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16780

On 11.08.24 18:36, Pavel Machek wrote:
> Hi!
> 
> New -cip release should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rebase
> 
> And their content should be identical.
> 
> There are also tar archives, at:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> 
> Best regards,
>                                                                 Pavel

Did you push the tarball of this as well? I find 6.1.101-cip26-rt14 but
only 6.1.101-cip25.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


