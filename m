Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399BCCE7A81
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 11:39:51 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.56])
 by mx.groups.io with SMTP id smtpd.web10.58621.1695641984655346942
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Sep 2023 04:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=0AJvxJ/H;
 spf=pass (domain: siemens.com, ip: 40.107.105.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEasIj0bym4L+EWSYueN82FVR6/rttqjAdOP+J8F3Iv0VGe+dfGn0+R85KhTfJOneMd6Fs2EQRERdlkS+BGuaswCeFy5quB3lLrSKven1k60vF5MHRoplrbSxPsZp+qkegzBlpyob+FntYujBfxxZcmahgHFXCdJQdnqyC+sfjdi1I0WjYAFx4BT0mYZqpJQpFCNaGrOoV5Wswcv5lPjE9n+QNF9H5Vghg5sS9i7JfA9/o+x//tHpwGigBdBcrAqTAGhcWsElt7FPbFtIxKlxF3CuVcdn/0efXAFHHUBaOWIiRG3R8yoG/ylZWHEypF1GosCoZnsbLHJ4uTZ+sd3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rjgyAq3iR5U8DF5FiVVq3Dhw3r0+RBqXstux0wSQkU=;
 b=dllQVJ6h3g26D7rk3XCB5SHr6cokCH98qARX/22v8zphQDyELfbrGQMlu8wL1ZZvRJkDMIw8GdlrrBfaiBnZYkd8i7VxhERAPGGlWhF9h7IMAav2R5Jw0iObKSIXXKtfTPqysqNFb9hftqUEsxJK05BlQHw+qOKHyE/9+r8V+kWyWOuGhTgZfc33U2FpHTGikQdRwxAxSJeouTzxiuCbo5nrs347WV99KnKoe4STBO2j8nBX/3aq+8ksHiORv9oNJzdkZBaY4Nph5cS6eLllkHg7T8T71k2I1LiJ26EZOo6RZc4UI6ir1Ci1F7/hpJ8xMoZ9wdi87prrl+Zz5KIOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rjgyAq3iR5U8DF5FiVVq3Dhw3r0+RBqXstux0wSQkU=;
 b=0AJvxJ/HC6oOdU3eT92opbPAn11a3BqC2IQ0a9t9f3AzbN7IZXbq7jmrVmIdlIYrYnSqRntOgDTClMNUwdYoLtNM+HAND3eClKdtVxv61RqV/Ycvt2wu/DylGFc838s/FAM5iRgpl5UMsXwxe4JDpyKmkxmssCjEQqfm8U3rlRb1iBRuRpgedAqGOOi3nlkfgvvQf6qn4hiXNCSENkiH+ZAu8NDQL9VbSHePh/zDarH4HyD9j8VzJvXscQU0o9mlnYme+z/hhKvh/k1YGZkKsg1ly6TxxN3qxJIq/7YdPunhaAa02l0KeGket4ZsWbBSGAnJMLPF+wtn5IBwsSGkyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 11:39:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:39:41 +0000
Message-ID: <32f8de55-544b-4ec2-b10f-48effdab052f@siemens.com>
Date: Mon, 25 Sep 2023 13:39:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] 6.1.54-cip6-rt3
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <ZQyEf0znmxMBLsoY@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZQyEf0znmxMBLsoY@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:610:20::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 915fea5c-d7bc-49b7-de38-08dbbdbc1b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pBzRoKtKv9hhYUxW8LDYursh9w8Qb0/e/XExSOa2Rxq3t8+1IjYSuTHy8fc1NTXLfMmz2ZdFLxRQSTHHbFKW096iAwjXx8CHxaWuhG4Zwzlae9lYGTBEOqnrgHnaYV/FMasoGB64wSYHVA9PV0Cx1d6S95kDzerdhkCh7GdMgP5mV2SIK6q8xk9rzTls8w8M/G311xx3rnyFi5Z1S7pbiQ0pqE80xk0ju8zSDlvO2aqcStMS5qIoDFk7k5Rn2bNNG1IWGFcY5Afg4bN71Ovgk7G7rlEczcGfX2MCMXabExXYs5zFh2n32CGQhnyNvjTUk0x1ZHX7X1BX3DkIJum7Cl8hLMkRnwk15MFeA7eKsvd56QOqDkZKplhDwT/EhmT0YCe0Ov208/CR+jbiPPgLWYnXVEmcgkcdO38VQ1qeh0eGQ8LkERrJkGLnywhvZYEsOlceKn1qJSNEhriiHuI13RdSpshW9O/JEr14VXQORhC7jbV8tA0d2/ca1odpVj7zqCMsh+1EUn0/0W9etMEyxd+nnLPxbX4OhgIkTft/3+8ISlkxGVTWS1hJ543t4WKcU6S4vlYf6eQYRtePBxSMu87g/SEh8RMgXfPgiFBqccJbvdUsbWhQez72MCT8lwza8OPCf6C0JJgWQyVSvyOX9Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(8676002)(8936002)(31686004)(44832011)(5660300002)(53546011)(316002)(6506007)(66476007)(6512007)(66556008)(66946007)(26005)(83380400001)(38100700002)(6666004)(82960400001)(31696002)(41300700001)(2616005)(966005)(86362001)(6486002)(2906002)(4744005)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGtrUExSNzhTWE1ta2JTN2doaDZLc1RGT0JFOURWZFBodHdua29CeVQxL3RS?=
 =?utf-8?B?OVNvVjNLOHVubE1IalhYN3RCY2dXSHI2Smo4YWpheDIxb3IwdmNzT1Z2S0JC?=
 =?utf-8?B?eWtkd0xKVUxucU1tU21CU05uMno4MjAvMVFpUWNRa2NESjBMRDNLYk5BZzVO?=
 =?utf-8?B?UlB6L1NjbEFRT3IvZ1dHNU9OdHpjUmxwQVBjVHVOcHB0RUtPOE5IMHQ3R3J0?=
 =?utf-8?B?eHZTSy8wYzF3dzdGdTliMXl4a2hEY1BYRVlkcUpIaUM2WFkweHQrUnZMb1JN?=
 =?utf-8?B?VnlpcWt0R0ExcDhGMWtjVU44SmQvamFoSWxlU0ZzQ0tYWDJGamY3N3QwWDJV?=
 =?utf-8?B?SVoraVk3RTFxWGYrZEhoSXUxdTBiL241TkxFUzZDNi9nbit6MkpQRFlrV0dJ?=
 =?utf-8?B?K1BrclI4UHF4bTU3VDI0OFpsMVlFSFpRSW5oSllIQjcrVTZHbTdMZjRWUWhY?=
 =?utf-8?B?aERENzBvRjBTT25GWTl2eW01L1BPMllJZk53ZVpjM0pENE1Lc1pQclplMjMr?=
 =?utf-8?B?NkhIQUZDVE1obG0vcmpJNWgveS9RdUp5UHhwSnRkenlRTzFKemM4NllRUDlN?=
 =?utf-8?B?OGRvZXpyYmlqVVNwTzhtRDFIU3UyTzRha25VQ0pNZnNPeC85ei93eW82UExJ?=
 =?utf-8?B?dnBBR1VyaTl4MFFiT09rcjJaSUFEOGpvNlRueUd1S29DcjA3TVV6YU5XeHZj?=
 =?utf-8?B?VSt4NlYwZ0lrTVNycWI2MVhnbWpiTTZteUFUR09qUmlFZ25yTHVQT1d2Y3d2?=
 =?utf-8?B?d05uaUc0RW1xcDY2WjFWZ0RuZGs0N1V3QmlpUkFVNy9QS2RjTGtZVTcvQTlw?=
 =?utf-8?B?UkU1SFdxV3RyVVQxemlsUG4reWNsaUJ5T0I4T00xOXVLVDJFcE5RMERSN1FG?=
 =?utf-8?B?ME9IT2tUd3NhTysyVG0xaHo3L1VHQ2VySTllOXcyT0hQMmFmU1plY0hYT2N1?=
 =?utf-8?B?eUhEbGtXclVpc3NvZTFlWUFsdFY2bkNDM1NKdTFLTUFna01rWWcxK3JLUG5n?=
 =?utf-8?B?VmduZkczcjk0U3k3STVYY1Brd05xSVpXdU9qOEkrMjJOZFprZ0N2VjVwaXB4?=
 =?utf-8?B?Y0dhUVJrVlhMRnBkcXVCOHRPUnFPaFhabVZGTzQ1NVNhSmV6RFNtQlRoVFVU?=
 =?utf-8?B?SnhDM2dJNXEwT1Z3SC9jWFRrL3IyWlBadFBYeEMrZnFzMEN1Zi9nbkUxTzZJ?=
 =?utf-8?B?V0lXVEk2dTg3Rmtab1hLUGNJVnkwM3ZSeFNQQStqdlNVK1dTNG8xTFZqeEZl?=
 =?utf-8?B?OHZKcnhCODVJQ09WWlhEMllGWmQxcFJhd05QamxVeWFNemIwV3J5ZkFiZWIr?=
 =?utf-8?B?R0lKSUVjc1lTcW8zZ0xtNC9Vb0xjaTdFNVhqTTlYaTFqZkdzT1R0d2p5eEFt?=
 =?utf-8?B?MzExVmNJdzhYUGNNUzNwekU5bUNjczVkUnh1RUFRK3ZOUUtLTW1VeUlTbE1D?=
 =?utf-8?B?TUw5YzFHNHM2d3VubXhra1BTbjFZOXlqb0NPanE4WTFpdE1ibWFxUXV2QWQw?=
 =?utf-8?B?Njk1RzNXc0ZkTTFCeWt1OEZEdUhmZWRMcGE1Q0w1b3ZUTzd4N2pCNGVBY0xX?=
 =?utf-8?B?UW13WlRVT0pvZUg3Y2p5d2FNQjlST1BnbXVuU25DQlhndjdLbzNyYTZrVUFm?=
 =?utf-8?B?UFM0MUFOZmVMdzBYZDlSbEZTNkN6QVQ1UE5TZWlOYUt6alJVSXpnL3VFbDU0?=
 =?utf-8?B?TWVUUHJlU2tSRWRjUTJYT1Y4N2RuOWdjRXlSbThSREttWmdXeEpLbWlQOHpl?=
 =?utf-8?B?bkg0WjdNOVlRalVmdzlETEIyTkI4cFlmM1Y3MTJ4eW5xSGZzNGtaVVNtWE1q?=
 =?utf-8?B?RWg0ZDBjbFdCNVk0dG9MVmdRR09sd1VTbEthdHhQUmRsdElzUWZDMndPT3lt?=
 =?utf-8?B?ZmxyaGdDZkVhL2tpcG8zeVNoNHB4eGVmdjQ0UGdqZVZDTU43ZFRoSG5pK3JM?=
 =?utf-8?B?aDJvbjlHdm9sb1JNcjI1bkdTYmZVZFNrLzlnam9JVDN3aUJwS3BtR3dJMzRU?=
 =?utf-8?B?L1VPYXVjVVV2eStZSFNvczB2WWZSRUk5c2h5eGJscWlBSTFucW1qZjJGN1pD?=
 =?utf-8?B?Z2xOTEVpbHQ3WHNPRVpOdnVCblh5bW02QWFLYU9WYmpUaXNuT0Z4cS9XZHVa?=
 =?utf-8?B?Z1p0STF1YjlhVzNaenBDOERLNFdmK0p0bUY0TkVpK2UxNVVvRHVheTl5czd1?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915fea5c-d7bc-49b7-de38-08dbbdbc1b26
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:39:41.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma85lZRaq3OZknN+MZf99TF0cJIrECabVDST424148A9v16ABsjgZOlaeV0KqxLOK2axBw9wgDe+h+4gntWiYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Sep 2023 11:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13218

On 21.09.23 19:59, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase
> 

Please don't forget to upload the tarball. We can't update our CI otherwise.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


