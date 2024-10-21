Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C33D17128
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 19:00:09 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.83])
 by mx.groups.io with SMTP id smtpd.web10.489.1729537199675937485
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 12:00:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z9C2amm8;
 spf=pass (domain: siemens.com, ip: 40.107.247.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRLRTvujqxF+N5e8uOoWzDzIH7SH/ejNP8Vy3PLbod0g6c6bb0dSGTr4TgFrIVvQnDYCbHsVDd3jkPy4OZf6C1y7Vkre3NlZxmZfPa+mCU39osgYOJgPV5mOa0j2VrSBUS3lyE29ymOyXRj/1STSTEtkG5a2MQDUV1GKuCH8UrArk90WusSKoR8WMIe4LdAoH6N9r6V19L1+jx9EO+aokWOXTH21WGmmNoytvdHyCGJsoag+CtmZTVK5+6wk5TFkPS0XEhUpbzcTw1t5qpEJSXO5NmscWJfQ0D8dQ3dqVraGYHLQ/IajXfQbuJSolhQsa2vn1c70slAB/K64yZV0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5BLP9sXdDkYoyzKtN/Np0tunujoX91dfS56YPMHxJs=;
 b=Mg3F4pFcP3RRGoCAEbYcxcVYHUb0zKjpAsn+7Er7WqDWIbKiJtn9562FYoY3CHT7uKmSi5ZWQIZwXndQsJlYm+UepX3nMgX72Wsxb4C90NnAx3fLFuhFmPgZXt+vM85B6rUOPBNWfbeKAk9nak/swgaunZyIgaxPog//YogN3wNSiIEGtSQyUG2AMtD5i+JquBqpVyTNvSd+4LyAkjHS70hTXxF7LAT+pfllA2YtW+gZ+8QQhWGEa3rs56sbfDACd20qI358nMSp6OE7PemRE+TwIdf6HIwRsz6W6WbEDps8J/B/TQItJv4/DfOCZ2vM30glNC8XSrzCzuRQo9s4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5BLP9sXdDkYoyzKtN/Np0tunujoX91dfS56YPMHxJs=;
 b=z9C2amm8NTDoN/4NW0HSNwaAhPhD3khMoLOV+8mSuNuZKrKvk70ZBwbKeFTi9BLraFqDET5t9ZNuXc02vBwA9kjk/wk9CZmIORYXTmlBkYM7BpM3Dnd8wESMtOS+j2eimkFAL4GPAAO0cD7HLcoBJPvAxLzaWnWiA+sJwI+k5LZwuBWYsN/iYETILItzRoYZrxfP5N/fuX+Go3sT3bPtw4Bz5bSyvcp4p1oNYjsMomkvI68ikn3SS8a+5PJ8uOkoMZYQw8q4uUb/iFMuKuq3dH5ZP5LxCs2g2UmPsFGksFdH/UqR0MyF5yGRNrVMmfqjraN38MHoGi+UtO68sKw4rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Mon, 21 Oct
 2024 18:59:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 18:59:55 +0000
Message-ID: <42448455-fc7f-4dbf-9bfe-ee741128bf21@siemens.com>
Date: Mon, 21 Oct 2024 20:59:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v6.1.111-cip29-rt16 (rt42)
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <ZwezX12F5AOLW6rU@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Cedric Hombourger <Cedric_Hombourger@mentor.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ZwezX12F5AOLW6rU@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e6bec8-cb7a-4875-dfc4-08dcf2028d67
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?eC9BbnZ6VjQ3VDJRMk05R1VpZ1dQdkRKeWZDc21NbXRESzhiUmo3NTZ6S0FQ?=
 =?utf-8?B?ZE5LK2RoaC9HOHJsWksrVDZFd0FoU1ZkMk5rUHV3UHkzeDNVbHdvTVhBN3FJ?=
 =?utf-8?B?OCtCR3ZDMmZIYXUzME81N3V0TVJaZ3pQRHVpYVBHWHVjT2tuYXZta0hjK3Bw?=
 =?utf-8?B?Yk5lTUlPNXlhQ0crS0VkUVBQdVZBeEErYmdldEd6Q2YwOUt4aXlZNU95NFNq?=
 =?utf-8?B?d00rb0JnL2FVQlk4aEwzNlZWUktjMVhUNzU5VzcxRUhJL2Q0REZORVBWSXNR?=
 =?utf-8?B?cEQ0bXNvUENXWHF4dzJtYXdKbHo1VUpzSFJYM0hIcFF5VjJjQjFNY1lScG5H?=
 =?utf-8?B?Y05FaTViY00zUUxrQ1c5Z0ZNWW81Z0xKWU5oek12MlFtN3V5aXdRTm1PUWpY?=
 =?utf-8?B?bU9yNEh3dTNFS005Yk42dFl1d2ora3VNb0lWR3B5Yk42RmsrNVFRY2Uwbkcz?=
 =?utf-8?B?bldjZ28zZlpPK3pxTkYwZ1hPNHJwaTY1UlprQnVWTEsrN2J0ODMwVFFmN0NK?=
 =?utf-8?B?QjBkNzZtQ1EwSFltM2hnbmZPVmxpdG8zY0FGVUVSeTFzUGp2UkVUeWxENWR4?=
 =?utf-8?B?c3dFTURFMjlaRHBFdks2YjRGMEphaGllL0NscjJoYkF6OGQ5eTZSRlpRREVM?=
 =?utf-8?B?eTNucG01WVh1QVJjWWc1ZnovS1FKWThrNk5uZ3B6YVJ3TVA4WVB3bkdXVlRp?=
 =?utf-8?B?V0pQUTZqUDY2VzdYZHlPYU50YUVpd2lDRkxYSU8zK1k4UlUzaGxBZDhJTDFk?=
 =?utf-8?B?cDJBRHZtamthQzRCNGhRNWNSZ3lrRGU5RG4yOVI0S0x6MnBOTW9nTER6WEE3?=
 =?utf-8?B?VEs5Z25IWlVGVDdtODc0eWlxVkRxVmtsZk9Jdkk0TWNmM1o3U2dtYllxTXpC?=
 =?utf-8?B?RGdRaTFadGpHa0llN0lVaHd5K1NxbTZPTnpoVWs0dDNjbjJCNGlZQTVuVkd6?=
 =?utf-8?B?cWc0OHg5T1pLSXIxNWpudXppcnh3bnVCNTJrRkU5SXBOVVYzVGcrOFJTOUhl?=
 =?utf-8?B?TG5lRmdjNWRsUkVYMExiNHAwN3NGZHRQNXlPS2JlUjRZZUg0dHAwUndCeThS?=
 =?utf-8?B?M2xKcjVMRXl6OEJPeE1aeTVWZGROMTRKeXFiSUFFRmN0OUJOQ2FVWGh5NWs3?=
 =?utf-8?B?bEVuN2x5b050L3pac0NZQ0dJSVloeHRlQUgxR0J5OWtLL01DVHJaUUt5WWJh?=
 =?utf-8?B?R2kxWnpZUi9peDdZRUVacmk3TnIvYkZlLzRkTkV3MFBFeDdPQUlBS2tnQk9N?=
 =?utf-8?B?NkZqZWNvOEdyRmlPOElDRGxZL2svS204TUNQUXJvTUFvV3hRcjl4TGZoaXdm?=
 =?utf-8?B?RExteWhXZ3hBZlNtZGt0NnJrYnJMV3BiR1VtTzNPTXNva2tuVGFSWTY3WUhE?=
 =?utf-8?B?dnhESE5TdFk5ZVNtTVAvelFlaCtBNjkvK3FRUC9EYWVnbjgzL2JjbGhnRERE?=
 =?utf-8?B?Z05ZTnpqKzcvWUloUEp3Sm5IcXhUVk1DbVF6M2hIS1VsRkp3OFlzTnVRbnJ0?=
 =?utf-8?B?aTNzU0luaVFicDlwVXJwaXp2U2RSbEpYVlg3UEFoS0NEdXhIZ3ZkbUZqdXRn?=
 =?utf-8?B?bHVvazhQam44U2MrMjNqQmhsekZLQk5wN3FQaTZzaG1CdDEyR3BncmdRZmxE?=
 =?utf-8?B?S21CZmFwbkdXWVRRYXp5MUF5ZUdqSmtoUHVtTi81NFdEYUVwOW85UmdEYWhn?=
 =?utf-8?B?ZUVaTm5IMEM5cWk4U2E4bUdqc3pibDVJZitLWVFxRFJkREk5OFJGeUdzTWtw?=
 =?utf-8?Q?ynjjQaeNvirBEzPlo0BVN+IxoadTxkVM7HVWDvW?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?dVZNZ1huVTcrMHBVQ3d4Y2J3Q1BTdXJqSDVSV3JLVHlBcDk0cnZMUUUyVEdt?=
 =?utf-8?B?Wk9kRTdPUFM2clpsNURCN0liUy9ZVlBiNXFYTVdPczJDZGRyZFlTSSsvV2J0?=
 =?utf-8?B?MENOSWZjaC9iMEZuRzRCNTJCNC8rRGFjVGdxV1pyZHVuSHRGSFprcGkzOEpw?=
 =?utf-8?B?WDJrMEdwTHIwaS95bUxWL284Q0Jva1BzUFpVbEJySEFlSUczS1EwVUt6azgv?=
 =?utf-8?B?NVpMSWozczhaQnBPK05TRC9MYkNhemlMRFhEbGZvM2NqeHFQS09UbmZFSHpR?=
 =?utf-8?B?NWRXTFZOUmdWd3E0Sm1qN0J2Zm5SK3NERzM2MWxGT0diVVV6UG5GQzBkMGsx?=
 =?utf-8?B?ZkRwd1RCM1hPMk9kSVFGNzhhY0J2cTJyZ1Zvcjg5Q1RXVE9Hc2EwNHpjL1N1?=
 =?utf-8?B?VVBrU1loek9rclJmcFpBK2ZnKzRnazltSW5lRms1R1VWT2lpV245VkxrZUh6?=
 =?utf-8?B?ZkRnSFdmc09Zc1FWZVBVNmt5cG9vc21QbjR4U2FYenEwUmVLQi8yMm9uMlEx?=
 =?utf-8?B?VGZUZTFrU25rUm9HM3BacXdLYVg3aUFyUGhEWURDUXJtSEp4OStGdzRRWmI2?=
 =?utf-8?B?Z01ud0dxZ2x2QmM5dTVFVUxBWjJqR3JGV3hBb01QYUFUaGFxOG5UZ2ZLR0xV?=
 =?utf-8?B?NmRGV29CWGdIRjZmb1hlczR2ZDVmdDE5T2tHR2tDOVQxRStZVWZ1aitGQ2ow?=
 =?utf-8?B?SEhuemhQNC8vWThzbmtUMW55cjdWNlpiS0h2aXdiVVZuN1pYTjhiY0hpMHB3?=
 =?utf-8?B?V0cyd2lkSWpOQk1iUVNTMGUyaHBlbk93OFRMK2FyNVBtNG13MitWUmRtWUs5?=
 =?utf-8?B?UGtPT1daekp0TmdYR0ZrUFFCMVVYRTJmT0Nvajcrb3pBR1p4dmlKK0F4eWZ6?=
 =?utf-8?B?ZG1TQWE0dWhBdW1nbnpuUndLM014ZUlFdFVtZ3hxREtJQ0FwTFdGR3lCd1E3?=
 =?utf-8?B?V2xqQUdhaGk1MFNwSkJiU3JhSVphNjFpdlZuQ0RQYnhUZitJM2ovazh1cGFl?=
 =?utf-8?B?OXg4WVpjd2Z0bmlUSmtsV3FibXkzS1JtZ2RkZHVwM01aeEdNUm1nOU9kTW45?=
 =?utf-8?B?aTRFRTI4bzJyOU9KdS9BYUQ5V0pmWWFXeng5ZSthRnhhOWZoVWlkbS9iVjFB?=
 =?utf-8?B?N2lUcHo5TGVHVVRDNTF1bzdSQXFlZEhLb0Znek1pTUJEYjBqZTR1R3dybWhj?=
 =?utf-8?B?VjFWbE43Q2FkSUR6d2FrbXRDQVl0VWJTcjBCVVc0Y01xcmRXaXhCNGs0Qjkr?=
 =?utf-8?B?WUs2WEJwNnRLNTNNMDNzei9SZWhXalNqUGFuendseDlpaURjYStVL2hWR2V6?=
 =?utf-8?B?ZVEwVmlRaTh1QU5jSVFOYVVrOXhSbWYyeVZWUFBaaVAzMXJMOGNLQ0U4bU1Y?=
 =?utf-8?B?RXJaRWZxMTVXQ1ZiMkh1VWpJQlpkVWdpTTIySkpoYUllS01EbkZ0eVBrMk9z?=
 =?utf-8?B?dnBpTFhacHE2d3FBd3I4MjJGZzFib0dSVVlWZzkybDA4SHV3MjNtNEhKKzM0?=
 =?utf-8?B?U09qTm1JczRrbmpHbzJiV0ZGN2paRmdld1FjNjFXVy9BcDZmK1M3SHZ5aUVG?=
 =?utf-8?B?Tlgzd2Vocm9qckZtMUZ3SlBkODJERnZMK2VwNnpSZ2NEd0dMNmR3TklRSlFF?=
 =?utf-8?B?L1dIRjdycTBYQzF2UTUralBQUDRKcnY1STg4YldzUmg5aHVadUtucmNnTERR?=
 =?utf-8?B?MHVGb2dDY29mUC8rd0NMOGZCSG15WG1uemxoa1F4aGcyR1dDWnJBWnFrbzkz?=
 =?utf-8?B?c2NnRTdhWUxadHFJQTR6T29wSjJISVRaZzVNbnE4aEpyTkhuRCtrWnZXL2FJ?=
 =?utf-8?B?N0h0dmN6WlhCTW9CWlpwRUdmdC80WWdXVXFFcjdycnZ4MVFsVkF6bW9XUDBN?=
 =?utf-8?B?V3JIUzlKWHlOZHlYbytSek5VWGV3eVhvSmhFOTdMM24waTZqRW5xajQxOE1N?=
 =?utf-8?B?R1lhcW1vSzVKWDlNTGZ0dHhFOGhYcE1XRUJ3aWdrZVZnS0k5MzA4K1VicXFI?=
 =?utf-8?B?N3FXMFluckFKWG1VcWp6c1M5WG9mU1ZkUFdvMitFdkZxQndON1pFMlpuS2l2?=
 =?utf-8?B?Rld3eFFpRitPODhwdkNGRE9TWk44SjFsck54RkNsem9mTU1QcjR5S2QxRytB?=
 =?utf-8?B?MlNEWWFISVl5NTF1QTlVVWpPVUNlK1AxamNUWDNRdi9JckQxcXRYL2R0aGFw?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e6bec8-cb7a-4875-dfc4-08dcf2028d67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:59:55.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8XzRPssjJkYHbjwOEvLtL4rAFqt4NbGZ51TB0zMGwZkHvWpeGzvPXVpPC2vDzwGmXKfKzJTaiyWgSaKL0nV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8558
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 19:00:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17062

On 10.10.24 12:58, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase
> 
> And their content should be identical. There are also tar archives, at:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> 

Cedric pointed out that localversion-cip-rt of this release was not
updated. Is that not happening via some release script? Can we do that
in future to avoid such glitches?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

