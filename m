Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D525F34C64
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 15:47:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.275992.1776095246097732607
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 08:47:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uCuD0yu4;
 spf=pass (domain: siemens.com, ip: 52.101.70.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sq8lj5NGIxM6s9Igs9uzyQpN7lPOxERoufyRJecOjaEK/iLPW39qfQVlnBg45fDRrcQDjxVBnCW2nid8bT4waEQqakAnlIhTpDi0ezB8cwAuHp4QLu8C0HIAxs/YpW4ve0iYM2mxjmGGw+idecRaNy0ENocNzape606TkieK8TnY3lgco4L3nHQtVX4AH75uilGrYO02JbkjjoOFAzLe7IWaY4zqO8mPg3X+sgqeRg4KrveQon2XD6mCdvxK8h9ieinbSpFWDjqii5ugN5WZFvMfye9IXzP2AZyQ5L/fziVw7wqHjwykS8h80pzJ8yTxPBWDiMBbvAn293NBhzTbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmgZlJEIUums0sbNgNNu610E3WD/iSY1LlAnkHTiPIQ=;
 b=PJAUPVVGjfyeyBagHSzCj+EADKg8d7yLtwZJfITvVw9qhQDdsOWt5p4rtwdlVWc6RS0RBnvJQaifkW6bmM05EtnHKX4ItdxyVqFtKvYy2Bt1slXGK0ximfzaAcmjYHQLvWE9q2NcT3gProwDlsJnwF8/LmnpXVocKYPJjVmqlipp4uVyoxtP8XzC0lRwXPn3xIbjqIyzpCxkE8YdqyLa3+d4I3LC9Ig/3+EEzuQyEetUvi1/rQH1vD6+YGO5l0X/mJPSERKz/wbHib3EUe0IbxPsKRNlJEwby1JEpfNZkTkua/vsJgnd7wo1ijA6gKBxLBh9omQ0oj7i93Egb4SfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmgZlJEIUums0sbNgNNu610E3WD/iSY1LlAnkHTiPIQ=;
 b=uCuD0yu4Tqh4rY7BvQebf1dcCbmSDi5NYyGieUJyz/f+wbyhDaR9Gc9BaARUUhWnoQTrBHJGE7Ry71nU48o3F9rvdKzNC043dO+kUQpmJ1ZjykA5cCFGWxhZz2YDJeJW2ng2cZfCCjI/9AMziTNKoaq0zHK8778CCaEN7WjVIt/VzC6bOFTWV8xk0ZS6PhyDQOyPmULAy4GNgy5mrzfVu2lb51jJ9GCAQELkescbhqB6qjPvS4w9Bp1FJ2SnCLQeRSnu7+fJiL658VzFT8GUct1+N9qbrotl7S3+nJLlHOtJnTAe487dIP7CSKDWmbrR9xUcSHgufXFUzlQQdrmiqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 15:47:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 15:47:22 +0000
Message-ID: <0dc1572d-f80d-4537-8a8e-11b5dd830411@siemens.com>
Date: Mon, 13 Apr 2026 17:47:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v4.19.325-cip131
To: Pavel Machek <pavel@nabladev.com>, Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
References: <459507685.15146.1775979436923@webmail.strato.de>
 <52d1c70f-ac3e-4f4c-9593-c20f08d60e9e@siemens.com>
 <adzTjVKf34vhQw__@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <adzTjVKf34vhQw__@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d31b52d-37c3-49a0-f826-08de9973f389
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	yAo1FE5AfvtxhpIm6gpc3NVIaTQgQYLgQgFGT96sKcKG5eHLCc5F+PdmMTTkud4oyLbSbQRXhRGUOILPRpp4ncsgFccl7jlYRjS3p1tQRYKcIjKyY+JvkZIXB2JKQxk+V1IPx0v7aEGOwOvKq7Dl1DrC7dgaC4ns3FZnaikPy2ptw9ZDnJU6+BYZaALda7uT9Ayv2ZLNsfyMAfp0ZccK/Th4QCjplQFoepURuCV7bXabbzOG5WUCKyGZQYyyQM/TKX4rKTAfn6qrMI91ai2FU3yzww45YehmAvo4EMMN14jSExtR5HtlfWLY4lviaq94dzyegBkg75k5PUsHPOIFKMG5T9IDuk7oQR6r+QVNSjzpdMrc6XXVI8LKHZ8X8SPN/DjZcSBTsQudVQbjM4mZZOxv6D7gWh2qFrvqDk1Fr+4Qidn/7c9XKz//Z+yzmAS8Xq36KfiWLuf5qQJ8wn2FduPGYepygrAfegWDweQMslCppWecTXO5YAKyRlGp4YH+3xdWn+KquiBbmWxeCXF5qECP8ZJBwU701h7cbRSXLvolz5UmutmQv1s8TtYt1xVxyxd46mWznt2Ix+odOmu0GOZ0+nfqtdSkr/ir9SGGcQx7BOo2AEzvSSCYJb9GNN5gfWakR+MjQf1noF4WSzTE1h0FA3e42uD+YF4MvPhoIUB0A3m3JOBSUXofc9AX6Gwb8LbpanxdlV9eUAeKUQ4S+NqvM8lIWfpeNXpuFernBS0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkNZNG5JcTA3Y1ZzSTVRVHJlVGFzYjhmWWlrQUxoa1dibkhwb0Q5NGVVV2do?=
 =?utf-8?B?cXc4aUIrWThSbjFkRGhMMzRmVlJyTisrMHg5RERVYXdQR3VOVThoOVlRVHRQ?=
 =?utf-8?B?c0RyMWgxSEFQMnhOcmJxSzZTTmVMeStzQWQvcXFkTVJTblBJb2w0cVV4ZWNo?=
 =?utf-8?B?ak9jOVdOenkwOFBRSU81UkVwbzdoSlRxNCtxU2o4RHRTb2c0TWdQS1VTdjlN?=
 =?utf-8?B?K0RYdDFqcmFacGVZMFNkU0FyL1AvMVUvdGt6dFhUL2tDS3puQ05NZk9UK29S?=
 =?utf-8?B?U0ZwNXNOblI5NEtjUGVTQXZQZHNXa2RBUER3c3pjUzBSUjJSL2ltQ1hwQTRa?=
 =?utf-8?B?TkcxZExBT1lCKy9MdXRGMkhjeXQvNjJDNk13Y0NDM0J6Tm5oa1N3K2Ztckwz?=
 =?utf-8?B?OEdKNjB4MjBHMk96OExLNmhCclFTRjkvRzhRQ09KNzcyQ0Q3T1hPU1A3d1Mz?=
 =?utf-8?B?V0NYUnNQU0IrWmdUQkFvMTRDOTZRK0k4V1I3c2I1K0swbjBxYUhrbHhVNGor?=
 =?utf-8?B?ZFJuK0t2NzdaNHlmQTRRbVlQTER4SUs2MWNkbWVDeWhSTzZrU3ZoN2RLVURO?=
 =?utf-8?B?RkZKdTBwWmdzR0cvdDZpcy9KMUZDTytkc2JIbUJOeW5xcVpJaEZDVHJjOHJv?=
 =?utf-8?B?dHBWdVRoa0hTellHajdTQ09FL3dFTWFIWlQxUUF0dlUxeGhCbjlxdTR5Unhu?=
 =?utf-8?B?Qk02VmYyRVcxKzNpSG9qK0IyazlocTJRSHdKWU9vS0c1VWJEVmFTaTRGUS94?=
 =?utf-8?B?aFNBK1hGeTY2UktIN1ZOR2ZIL0c5aWZjRHpiTVlGUFRBcWxOUkFTSlpoVmUy?=
 =?utf-8?B?RmtKcTFvbkJKdW9DbHZHTDY2L0oxakFCUFNTV0J3L0tzeHR5U1hHa0dhNUg4?=
 =?utf-8?B?djJhc3h5bEUxT1BIaForeDAxSENRd0JmR0JoS0FHM2tjenFPNUlna0VPSEs5?=
 =?utf-8?B?UENFaHJ3Y29KbUxaQWJyV0w0MXRJSnU4WEhrd3ZTbDk4ZkFjMS8rZnJlbERw?=
 =?utf-8?B?V2lOM2NTMmQ4WUlzYzh5WUR1cmp6MEl1alZRWVhRM280VFVCbHZweTUwbGVU?=
 =?utf-8?B?YUZ4dUdjc1lybzUwalpXdkR6aWxlVEg2bkovWGtUcXg3dzRDNFZmZEczQ25Z?=
 =?utf-8?B?bklOaElGa2s2dS85OEUvOFgyaXlJblFNK0RJWmdraUpmRHBKNEVLdzdzSjE3?=
 =?utf-8?B?R3Z3YzFDQ0hUNElLY0tEYkRwZ1BFekpQVUF0MW1xNTEyMlAyNDVxRE1Wc1BB?=
 =?utf-8?B?U3JmNGI4WnlHd0NvQjZPV1RpQVUwT0pmK3oxbFU1OEdLUXVVbmNybVVhQXZE?=
 =?utf-8?B?bTNTR05KU3F3cFRrSEVHdnlIczcyNGVjTmZ6MHhwNWk2Nyt1bThHTW43QUZh?=
 =?utf-8?B?WTBid3MzcDRFZXEwYUNUczdYWFN0M1Z3NThDQjNYZHNnYlpyWmdSUHR1eEp2?=
 =?utf-8?B?blppMlVqVlUzZzNNUjMrcHM5WHNrc0d2THNyeHlQcnZuSFQ1bHBTRW5uTkRY?=
 =?utf-8?B?bUdnaGxhMWY1Y1c5YUlBblY5R1YvVk5PaXQ5akdxcHJWMmJOUktZc3BxTDd2?=
 =?utf-8?B?dUgrNHh4b2ZVRnhueHlKckZqa2pISTVObzFJaUVRamh3ZWFURmRydWFKemNX?=
 =?utf-8?B?T0EvSC96UHR6UmlFN0xDVzVlTjJaMldLUXBjV05DS0FzY3M0dTZQczRtQ2w3?=
 =?utf-8?B?UC9oNGVjdHFJOWc5b3dyaExyQ1V4VEFYWWFNVDVBMXBIMnlBVDMxOGovd3g0?=
 =?utf-8?B?bnpKN3hPQjlIa2FnanpoNldPZEo3YW9wRSt1aElBQi85QnE4MVh0SEkvOVVn?=
 =?utf-8?B?QWx6bEgvNmM1czJ2eGw3NDFkaXhKdUFJVVk2VDNmQ2ZrY0EwYXhUeWUzM0Nr?=
 =?utf-8?B?YzN3Y2pia2I0QW80RUNUdjZZUW5XZzdxbDdSbHNGVVNQNkFOV1dHa01VM1hv?=
 =?utf-8?B?ZENzVjQwMEdyeElpU1Q4VURUdzhpUWZCOWpkU3hwZjhyR1BEdkR0TVZ3dGVy?=
 =?utf-8?B?SW01T29XcWxmdTVsaUNzUzJ0cDdGQm94bWNsRERsWW5XYUgyUGpZMEM5SkQ3?=
 =?utf-8?B?ZUQyc1h6ZXVjYXBGb0FlOHNET2E2MkpNaU1NTjV0ODFQdnFObTgzczR5c3Q1?=
 =?utf-8?B?ZjdwLzhxdks5OHMzemZDTXRvaVJnYzcwUXp5aHFoTm1sSHJidkpCRy9pODMr?=
 =?utf-8?B?TDQrSjl1TE9CQnhHY3JMWnR1SEQ0Z0R0S3JuckpuS3M1RWRVVExWYVNkNlNq?=
 =?utf-8?B?ZlhJUERaSmQyVVd2V3hsTU5EZmlSRDFZRitON0pvaEtCRjZYZ3BjQ1p2a3NL?=
 =?utf-8?B?UjBuYXJzU0FCZXhWTWFQRktXOEdnUlNuenV0Qm9jeWU4bStIM0lSUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d31b52d-37c3-49a0-f826-08de9973f389
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 15:47:22.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIifozJto9pP692bbFZNE5oQHwB7aCqSIn1fmiUZrhSJ3nntLEJFvJmKLPxDXq6D6WBXqb2BCEeN6zBWZUEylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5417
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 15:47:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22681

On 13.04.26 13:29, Pavel Machek wrote:
> Hi!
> 
>>> the CIP kernel team has released Linux kernel v4.19.325-cip131. The linux-4.19.y-cip tree's base version has been updated to v4.19-st15. The trees are up-to-date with kernel 5.10.252.
>>>
>>> You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/
>>>
>>>   v4.19.325-cip131:
>>>     repository:
>>>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>>>     branch:
>>>       linux-4.19.y-cip
>>>     commit hash:
>>>       7aeff6c7984c582f96916d12bd33eefbd746459c
>>>     Fixed CVEs:
>>>       CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on incoming connection
>>>       CVE-2025-71239: audit: add fchmodat2() to change attributes class
>>>       CVE-2026-23241: audit: add missing syscalls to read class
>>>       CVE-2026-23243: RDMA/umad: Reject negative data_len in ib_umad_write
>>>       CVE-2026-23273: macvlan: observe an RCU grace period in macvlan_common_newlink() error path
>>>       CVE-2026-31411: net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
>>>
>>
>> Looks like we are phase-shifted on 4.19 between regular (-cip131) and RT
>> (-cip130-rt47) again. Was there a particular reason for timing things
>> like this?
> 
> Sorry about that. As far as I can see, we have few options here.
> 
> a) Release new v4.19.325-cip131-cip-rt in next few days.
> 
> b) Do an v4.19.325-cip132 in May.
> 
> c) Do nothing special.
> 
> I believe we can stay with c), but can do b), too :-).
> 

Given the age of the current 4.19-rt baseline, b) or a) are needed, I
would say.

Before future releases of self-maintained version, may it be -rt on top
of plain, or a new plain version close to a -rt due date, please always
synchronize with each other. This is a bit of redundant work when all it
would have taken is to chat and maybe wait some days more. At least this
is my impression now.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

