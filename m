Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D14C44536
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 05:56:37 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31512.1769061388608224139
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 21:56:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XWBayh55;
 spf=pass (domain: siemens.com, ip: 52.101.69.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFaiJJVTYIAxdTqm51AKgS6ZNVwtABeXF4KgIyofi5p16f6RC/4jxGUZpy950rXFXScJqwt3e3QTv+uLnzW/ho+E3keLprOAm3FsxXldmMflPmDVBNV0fleIC/mNAT53s1hVHzhDsgvYOsA5//atHe7hMZi6ExPreESg8RhpNIKL0e3hmbwMZoeyqoaWTQ3r9vR4Y0A5yV5ig1heO05QF0b54VP5Ig60iAt1B7SOhe/b0S/C2U6IlgREJM9gsF+u7TaosEQOPUtPV0vtp1C9aif7plrqgGNdetIh1IVn29dV7FKB4+2YegMsnkBVHWfcnlT3g0YAxcudDOp7AfXhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5myoEbMW7u5prZDZ0WiRvZK5y4fcVc2rhs4Ikm7d52A=;
 b=Tdr+R3YzGjbVxNZd7hGQpttVqfRoyJDxoc/W8ow6XTIJzcsWP9h9ofNYkmKmmYAIPe5gvMhZo0KWfgri/1r4FJFspGsWSHnlJt/hzFIJhAsJ1f9MMSn8fy9zgoBajrsG9Bp7aWsSlqRyYQsDwtA260RP2+s3In30zlTVEf5Mm1s7R2IfFgCcp8HQSSS8H6QHKhaRXn79bk+dyWbvaPsFJreuwNaMVAiAlBDxFRZkT51yYLGkqzVOXFGE6MS+fLqdvEvk0ZSDtBSP7ZOiCAPJKe7lLg5FMAGHH9APgBb9lx2bEHT2MQZCozkkIpjtvYVqaBZ/kU5k+1nNF0Ri/97Fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5myoEbMW7u5prZDZ0WiRvZK5y4fcVc2rhs4Ikm7d52A=;
 b=XWBayh55aFerehU86bQnEz3kXBi24JFabTYFZt8Gm81Vv6KjLYa2BrqomSO6E9gWIenlyCviKe/nFn9H9lrqRWK0lqAEJTlP/u1KCYl8YqRpH9HebK0XmdAqKjFAENXBv/q6T7mVPkfKkvAetZ8QKp1SNdDFDl4K9O7h9itB/2mqCirK5XBebSyDHrFRzjqq+VGR9EA3IH6kJZJFkFfBpbq/P9mX/YmiJ6a9L+gOC9d462bywB6TPfG03htaHt10ajqdZFzJ9OapNUqqf+oJX/Nu+O6m3XBh6DWEKjXgcSHjP62+J3cKn13ftkm43nmmlZ4NFZuSaJqt5Er4H8a/Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 05:56:24 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 05:56:24 +0000
Message-ID: <9c55b85a-a802-40e5-bf1f-29cfad4dbb9e@siemens.com>
Date: Thu, 22 Jan 2026 06:56:21 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: fecd85d2-37ed-486a-727e-08de597af96c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SG5TSjZXS3Z6V1I1N1ZkWEpLUnBCbFBvY1JXTWdNZDllUmJEN1h1dnV3UEJM?=
 =?utf-8?B?M3RHLzJKS09HTkYxK0Y2cEttcHhXYUxpdE9lSXBDb013WXJ2a09UV2t6OUF4?=
 =?utf-8?B?eC9TNFVLQmNQQ0xvVnYra0ZYU3ZjZVl6SSthOWZTS1cvNkRzNStqMmVETGpB?=
 =?utf-8?B?S2dwL241M0p0N0JtSm1Md1BTR0pEdXBXOU1RUVdaY3JhVTJpbXFkZFF1TU9S?=
 =?utf-8?B?KzhVLzhQbENKVzRhdlNlQW5wSFRRbG5mMERsd1MraG9LbkhWdjdXMjk1VitI?=
 =?utf-8?B?d1ZUVk04RmgxK1l1Yi9oMjdkdit2L3BSN0tsakR3MkV0a2dodGNqV1lmME1x?=
 =?utf-8?B?VUc5WTJQblV1Mzl5VWJzbUY3dnhNQ1BKUldTTTNOUjY2dTB1YnRBZ2Q5VU1C?=
 =?utf-8?B?ZDNpZS9NZGZXd095MzhHV1ovRStpT3REQndtVGpiNi9hZHNmS2x4QldCUFB2?=
 =?utf-8?B?U0NBeW1KdEJlUWpnY2JIcTBZYlQwYzVUM1IxUEFGYjdUK1Bsei9tdE5mM0ow?=
 =?utf-8?B?d212aEFtWUpDYnU4RHJUVWFWYnRlV3g5ank0VEVuWnBKMVpmSWl4K2gwKzFZ?=
 =?utf-8?B?TW92MFU2b2xLbkhkU1RMUUp6VHkzcHYzYlMzU2dFRDl2QURWMHJmMDl3VDhs?=
 =?utf-8?B?YlFkMFJuQk9KbjBBVzZiM3hrUUNjeEdML1lCS2swVjgyNzhyZm95cjBTUHdG?=
 =?utf-8?B?ZXZBYytldDNuMHhWYnYySkdUdjVkVmJ5RGhBL25JZG9ITlN5c0t0cXNPTmdk?=
 =?utf-8?B?TmVuZEVEZy9FN2V5UjFTdmFVaTk0bjREQnJTNHNKc21nVlpVcFRGbWpGRlAr?=
 =?utf-8?B?c1ZiaGdxMGpHdEMrdFRLK3dhZzRGUkJybGxOdERuM2lEcitXYXVPUzdRYkJG?=
 =?utf-8?B?RXlrSDVyNFBpRmRQTVBEczRYMVZsY09BVjBLSXRTbmRrMXBEVmpLU3BzR2Nt?=
 =?utf-8?B?dGJmZ1BMcG54cnhoTE5mdkV4VUI3S2E4Mk1jSVUyVUdHRHdlN2E4MzQvQnVU?=
 =?utf-8?B?ZnovR3VnWjBkbjg1ZFVaZzg5UTFsZUo5Um5SNGgwNEk0d3VqVkdIZGx0NDFx?=
 =?utf-8?B?aytYK3BmaXQ0WHh3WDZsUXE0SGtZbWwwelBpNVNXcGcyMXhwZnd2TlFndVp5?=
 =?utf-8?B?ZVdBYjFxQW82Z29nYlZEVU14UGdFRWxKeTRDaU8vT1JnY2dhbXhUdVB4U2or?=
 =?utf-8?B?N1daSDYyTFo3ckFpb3J4YzZ2cjRSeVhGK0p2dHEzSjJPTVo0bnB0VkgwOFZm?=
 =?utf-8?B?K25JQVdGR3hIcDhJTFJpVFRYR1oweVFKWU1ldHQyMEZPc0JJRm5Ga0VnQVBq?=
 =?utf-8?B?NXM5WCtkdFMrdGthVmIwaWkxbGN4b1lpZGJ6anpwcXFVNk5UT0hvYnh2a1U5?=
 =?utf-8?B?cHgvZDhld1JIaXpjRUE2RWQ4a3RxanFKeHBhVXVsVE95eDN6M1k3MGNCWlhV?=
 =?utf-8?B?UHI4a1M4aWpZYzNuVzh5YUE1OEM5cElQRlhKKzUxaU1RT1E2OEF4ZFAwYmE2?=
 =?utf-8?B?QVFsTEJpSVBJcHd2YUFBc2tCckdiOEJSdXpiUzkzRUJBdFd3TWE3a0o2UGdw?=
 =?utf-8?B?Z2h4djNDeFpwUXErRmlHclpBM1VrMTRaNkFRNHNBa2Z0aFM3cFhpN2NOaVZy?=
 =?utf-8?B?ZFNrTGpqM2RzcXI0RGRHRytIbkVVQ1YwUWNzRGpMMHhzVEJsWDRRSVBJVWFI?=
 =?utf-8?B?bGJCemhYYTF4RFc5aGU4R0dwSjl0WFBucWRranR6czNBM21yWGt6d1ZRV0NN?=
 =?utf-8?B?L2xRejFBQXl1N1M5dlpnK1dtMlc5LzNPaEV5YkhHd1JNZXRVTG9BMUlBS2Jr?=
 =?utf-8?B?b2w4czdVZUVreVhhRTR6ZWtXV3dvM3JjR1VkeG1tSEpMbUJJd3ZjVmdDY0tI?=
 =?utf-8?B?WXF6VlRJOE42ZWoya2xhbnVQRmw0b2RiY3dPUWZoOXpCWkdDRHhJUzllb05i?=
 =?utf-8?B?RkhEaVF4dUlUVEx6b2UrdTMrYVBUc3FBa3p5SjNQREZqaE1xbVhNTGl0TUJk?=
 =?utf-8?B?UjdUeUVEOWsrRDMwOG5pNytBbWIrZ2Q2OUZBcnErbnh0cGxXbUgzSWVqR2di?=
 =?utf-8?Q?xSayHF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUxDSHhqa3lmYWoxa1BMQkRpdUlWNmV2UlNYdGZFSUs1SmZmOWVWZkF5UWlV?=
 =?utf-8?B?TnVjOUhxSnAyYmViMU43a0lsNndsdFlJeDNua1hVNkJEZWd6WGd1V01GYm5w?=
 =?utf-8?B?OTI0dStTV2swaUJJcWVuSDVkeW9EdWVFSlhRUEk2Y1VvSitJdGRJd1hLRWwr?=
 =?utf-8?B?cjJCa3h1NFFRbUVpZk14c1pKbVc1dXYzanRmSEpVSTdjbE9sVjR1a1pqeWFO?=
 =?utf-8?B?YWgxek82ZHdJL0wwU211RlZNSFVkOXRISzBLWXZ0S1JKR2F5N205dmJTZ0ZE?=
 =?utf-8?B?NHBZcXpPeG9xcVB4Q2NqYkRqQ2xEUE9CODAvbEhBUzRlQlg2NXF0ekZ4QnJl?=
 =?utf-8?B?THBSYXpMck5LWGdCeHVoNExYdFZibDJSYUF4L1FFUDI5Y0V4RVdaa0tQZXBi?=
 =?utf-8?B?VVB3RzcxbXQyUFAwQlkxeTNuendmc0hSQ1FzUHhsNHlXdjBjRCtrd1dvS3FG?=
 =?utf-8?B?T1RERi9QTzFYQ3p6S1YvNURlYUNPWmhTNk5OY2dMS1JyRVF2QStybzNtaHU5?=
 =?utf-8?B?NDZ6T3l2Mk1MbzRva0toTmhkSnVvQmVWUmdtOW9HZ0VHWERXMXlzbDYxaFMz?=
 =?utf-8?B?VjFOeTFleFl2U0VxUlNVUGt3WXdSa3pYaVA2OGtDUGFjVEc1SU8xbnFWVzQy?=
 =?utf-8?B?MW82dXRSbC9rdVJHQ0o1aFlkK3Vud0xXaDVNRkRodllTb1hibndJcXZaZjRD?=
 =?utf-8?B?ZktjUUFDbjcvc2R5cDF5ak82Q0dyQlA2RFZKT0d1SHJzYkE1amhHd0VERXp1?=
 =?utf-8?B?S3ZVdUNUU01xcFJpYitaZlVvZGlycUQrWE1ZeGhVTXNTL0tuYlBaazI1Z2lC?=
 =?utf-8?B?R05QTjNtVTloWW9GR3BwSkpDdFhjcmN2SlRCYUdGcVBPeVpBRDJEMmYwVGpT?=
 =?utf-8?B?U3pXMm9LL1pzUmpUYzhWeStNdG5qeHhxR21pY2o1Zmpob0w4YjVYbS9helIz?=
 =?utf-8?B?L25kMmVEdkRETStTcVpNSGdDTG9FT3FPV3c2VHdyeEFaTEkySzBJR285SEtm?=
 =?utf-8?B?NzUxMWFqSkpNTjA0M2duVFIzelBJS2k5ckxjUnh3YkRSWm5YUW5obnZpVk95?=
 =?utf-8?B?RTg3U0FaQXZHay8xR2RHdHMxaW9DdU4vOVhjV2JJMjk5S3J3cFlMc1dZMVJh?=
 =?utf-8?B?TTFuOGRQcDdOSFQxZ2lKKzhONjNPOU5oOGUwZE50bktNaG9GSGcyZzV4dTBo?=
 =?utf-8?B?M1VvYld0eFVBM0l0STRrZnhxeGd1OHFkQm9oaWVvR3ZLOVBhMVM4b3lxbGxT?=
 =?utf-8?B?UXI1RmhsYmJ6RnpRb0owT1NKTWFCQjlRNnQ4Tm1Vd0ZCQ1JJRWhTY0JRY2FJ?=
 =?utf-8?B?a2plekJNeGU3TGRUQ25xaG5QV1Y4UmVCVU0rcTIxK1psL1B4YXd3NExBUG8y?=
 =?utf-8?B?bTRIcE9CUGs5ZXZYTkVFMVRVRW42MXdLV2tYRWNSKzROeVpJc3VRckxSTEtN?=
 =?utf-8?B?MFpLT3hWRjQ2c1dBcVBJcitMOFREa3R3VUxFOFlXd2Q3MDJpSklkOURJb0da?=
 =?utf-8?B?Z2Uyd2RabHNORERySFBkNE02YTdNMG9COE9MMW9pZFZkQTZoc0ZWTGlleFpI?=
 =?utf-8?B?ZnBvNmxRakVQU1BFYUZrdkcrSFZYcHFDOHNWWUhETjBlc0pVN3RvcFA4WDN1?=
 =?utf-8?B?ZFFoa0pEU1F3cnp5UVY1a1ZzVFM4akhmbzZXbi91TTJLcGd5QWdabDZYSDhR?=
 =?utf-8?B?UmdmN1hTTXkwYTBmWjhIUStkTUJFbGNGOWZrVWt0SWtnK2hHUnRwWTN4L3BQ?=
 =?utf-8?B?VDFwN0tTczNrVjE2cGhuMWx3YVMvQnovbE9WVWM3dGJVd3M3UEVscStCNUJo?=
 =?utf-8?B?MFFsdlVBaUUreWhQcE9CdUlmY2V1RG12eVZSOTJRd09XU3E0WUkvR1VxZXRJ?=
 =?utf-8?B?WXJSdE1SZ0JubUVlWjhQeU9aVGJJVWs1TmRJRVZVeEl6czhGTHphV3NJakVT?=
 =?utf-8?B?UDg0NjVtVEMrR1llb1NTdytpajJqb0g2OUZYeUdsUEx3WndTTW40L1JhRE1w?=
 =?utf-8?B?OHhBVGJ2R1NiV1ljMko5V3poeXg3Vk5GUHA1eHdSa0lsdjRYT3BGTW1IL1BJ?=
 =?utf-8?B?NUgyTzljR3BRU2hsOVdPT1l1Ui9keFdXQkZDclhVVW1zQnkzeDBURXNtdGdo?=
 =?utf-8?B?YzJVM00vOFMyUWZNMXUxRklQb28rMm8zaXBPdWhDR2RjekRVWlFudmQxZmZR?=
 =?utf-8?B?QnpFdGlyR3U1QVVvRWRqL0NhejlPcmxWZ25hYlZ0N1ZEUnBwM04xOExwTzUw?=
 =?utf-8?B?L1J1TkoyaTcyQXVoYVNkajd1S1ZtQk83cFg5YnFyQlNtTE44ZFNtVXJuVW1J?=
 =?utf-8?B?UWhtSCtWRmZtcW1kQWo4aFVxUzR0VjFhSVBuUXNTdE56SW9Hdyt5dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecd85d2-37ed-486a-727e-08de597af96c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 05:56:24.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eClx3UhF8goB22E9zdC+XrOTGoSnJKbzctf6MQpRF9c/nXUZLPHUEuSM1HUjtJ3JDVarAafwNwKaUDhz3oIf1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6138
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 05:56:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21694

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=1&day=22&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/01/cip.2026-01-15-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jan 22 05:53:14 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jan  8 02:18:47 AM UTC 2026
  limit date: Sat Feb  7 02:18:47 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jan  7 03:16:59 AM UTC 2026
  limit date: Fri Feb  6 03:16:59 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 18 11:41:27 AM UTC 2025
  limit date: Mon Feb 16 11:41:27 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Jan  9 05:02:19 AM UTC 2026
  limit date: Sun Feb  8 05:02:19 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Jan 10 07:38:46 PM UTC 2026
  limit date: Wed Mar 11 07:38:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Jan  9 02:26:25 AM UTC 2026
  limit date: Sun Feb  8 02:26:25 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Jan  6 02:25:59 AM UTC 2026
  limit date: Wed Jan 21 02:25:59 AM UTC 2026
  Status: *Late*

