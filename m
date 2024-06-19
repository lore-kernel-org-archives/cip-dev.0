Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4DBC27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 08:44:21 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web10.16282.1718786658143116619
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 01:44:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=U6Amkr4/;
 spf=pass (domain: siemens.com, ip: 40.107.22.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG4tC/L0aBKtEnf7Rq4vT78YzrkKqSJp/KsbFBm/8rrLGdC/TX4TmiwgFTWMd+ZA0Zd3BYLPG5N+ihpcPeyD2/WmRDfRxlTxYu9cfWm5RU60+NxKE+mvp/2RnG4XGVteZoe7FScZe+xudINursEp98S9BjlqAzhoTKYfJV0f8euH2eyEkPr1dJN7WFMU4OGB1+NJPJzVAYGa0JZf5H2Aefl9iPjyGE3ULxv+c6bpDj7bYbKhL1aQIEfO1jK8N65j/BefbpFo3qYGeE3tVgivoV8/WxabxmGty0ZuiJSv2iZTnP6UaiTBddU71/IuMgee97q9yyVVpbm1xCz6mj+kvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUMX++OinZhEcGT3twfpeGj/aJeJyUTB3KTY2GoYLvM=;
 b=JIKhcTP0zlRzbX/8rLsFBFmIlTugBWRFKqEgq7SeiUJtkSIIOpfTIFSJCnhnHH2cGyrH7LUia28TKXYDXd73onGEHZqY28k/+5x/Mh6OJlRRAgHOK4XcCNGHg+dWC8+TUk2Q0H20qQNyFFrog0UZjkUphvioZ9dkelz3JTetNnadNNBYGCbigsg+O9Q/0X8xG0u7VkapYOsuHfCqEQ60qVC8bKnPPUIpXvLoGBVrUW5qm18qiMZGo1r64qUpj+tip2b/2QLGXCNDu8WqtEKbZiCxzzYkpZ/tj1+5RyD9sHQWYXuT05cgqc3iKaxLCqTCCoRE6gtw2k8e/hd8KGxn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUMX++OinZhEcGT3twfpeGj/aJeJyUTB3KTY2GoYLvM=;
 b=U6Amkr4/v96WcbGqeI6Quex2Ub8ss5+LrcvZeMJWymsk1ldNTY/uGDkuJsJHf/ZhtfCI+xfyP6WvmYokajwEJgtTPHZn74G2oOFcLx6xI34Qvuyr+yPDp7AiB0avmtYwWRd9K1/CpECbNh3mPA2OhoYBg10bryb/a5v5Lk2QMt6ZZZ/JSHlIMNnkouCczOIuV8ju8QOtJWbq7ZXBvvhEttxmE5QmGEuAfTAdXj+2ZtRLVq5QxE8WrOnNR/DLBw+8nVjQ0u5ji0tfI36u90bii8UT1T8NxnElsthElOrYOn+pUsUsK5lEyaNSMM4/aGdgSyM8CUq6N+Uhj1/HGodDqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 08:44:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:44:15 +0000
Message-ID: <9a14755c-f33c-4d9d-91c0-4270b098d35a@siemens.com>
Date: Wed, 19 Jun 2024 10:44:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: fix reboot progress
 with wfx
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
CC: Christian Storm <christian.storm@siemens.com>,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <20240618155914.1458889-1-Quirin.Gylstorff@siemens.com>
 <d3c6d33f-4e7e-44a9-9fa6-cfd308e645b4@siemens.com>
 <6fc5ee26-59a9-4c68-ad2d-597a01e5f5fb@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6fc5ee26-59a9-4c68-ad2d-597a01e5f5fb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1becdc-252c-41a3-dea2-08dc903bffc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9dibIcZcFAon1zaHvJaH/BTel3QhetNggn2JJSoA9RLVRHB9AS6R7mEC5miZ?=
 =?us-ascii?Q?kxBllK8nI6AYuh2uo5xkh34kOhxKTvqungWvl0oCE+wLB4biQ4fxgClHwvZ6?=
 =?us-ascii?Q?5Zv+tiwHVLALwDI/COiogPcrZOYD1/rvwieoRkYK/McaM3Jyzm0n5O6uMIcM?=
 =?us-ascii?Q?ILwfW+CzB5G9+izvA90wm5Yopkqfy5nPcmFEB2c3FIQPDfXM/JSFkZkR4tC8?=
 =?us-ascii?Q?B+sFGOPmjbwzzdmwmhiiDtb7oQduLj/0Vdp5SjNI3f/+TU38fsbeaZGzWNMB?=
 =?us-ascii?Q?wZyPsFlLGB4uvvEmEsSxtoacE0wmsProuoeqSegNq2xqcAAPA2yBv1/WJPBp?=
 =?us-ascii?Q?m2hFIbwuaX4Eg4yw3qO8WVNT3SM+U2VxiENVI1L/AD/1Yb3LU97zX0zVjwbX?=
 =?us-ascii?Q?Z+Wshs5F9Hca+tnCSPZ4HoOnL+tGSm6lAmti8uJ/kN1Wjh1BS+IgLTObgVeS?=
 =?us-ascii?Q?P7mCtnhNeLeO1n4DnFhbIr9vjDHcna/ZHtbu8HOOTOEMovGSQUit8qc2Qjhf?=
 =?us-ascii?Q?F0DmFJ1yvxviDfowDjMHL3/R/nyXvU+/DiZFeUm/jBI+B0DM+md57+yK+Bo9?=
 =?us-ascii?Q?SfGcfdP1S4KJzb139otjhJr4KPc+0HpgyWcLksRpXiQS5D0lm8bOfvnKBywO?=
 =?us-ascii?Q?CxP/Vhd4ll5VqzQ9K2XGBHvBVTW6Lbn7gPID56RsP/fsoJusVp2o8tpuiJGP?=
 =?us-ascii?Q?d1iNFXFXYPAnc/1t/8jBb+qNyl4+L4ViW+QIAlRXpBf+0VvbAnJ6sHpZ0xVj?=
 =?us-ascii?Q?Q+CXxb8dDzSN1rRlX5n/YPMCH4/D96ev62LPtreNv4oZXC4xn7IQdHuv2aK6?=
 =?us-ascii?Q?rgTGF3/jQtFRCvu49+Rewtnd6rcgqZ6aweKLaAEy7QmmQHiI1PkmLOazcujH?=
 =?us-ascii?Q?uJCY9+CeHOXFk92QJYWHdylD2y84+zeX1p9aX3muyc/NoZmPPZqFJrYn4/tL?=
 =?us-ascii?Q?bu6SXiMc0kdK2j4yrbscCybfZCReBJrtM21HgpTzpXRdl69PCN2s8UxlX80b?=
 =?us-ascii?Q?XBGLvxNZr09RL9piZf/sHoYrescv6b9Sm9qnKJlywm+hbhALCK7HNFmFg9YP?=
 =?us-ascii?Q?YOSi/G5C8PiCjjBBU3K6AuT5pb3KUuu0PmbL4KyJ4mDsh2C14tzW0sPr05W2?=
 =?us-ascii?Q?SOIfehLX+5mEVHwQfFELdzTBLq9TBgW1Y1j7118RcyjWKQDVbTzTQ6O8TWUv?=
 =?us-ascii?Q?7r1g2p5KMgiqo9Yxh7OflBnQ84mI7g53fDufQ4AkYyEQR/ksZzf4djztY9a/?=
 =?us-ascii?Q?NXMU8ydFLI58qv8y7o83?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZocfP3hr4TSyDrIkVaJ1sOkQJfp1KOlGaSXom2qCVj/n0VpBfCbmIf9H0DXx?=
 =?us-ascii?Q?iTB/tc3NfGjOVuDir0sNkXvnXtk8xqGbd5dpjO0R/o7LFTLhSekLXGWSG49b?=
 =?us-ascii?Q?eTE+8vS0dp1Cxs6Ex9iGWke4oVtYdjFTeOqkBxkZ7pz9venY+5Qp+A299WNh?=
 =?us-ascii?Q?dTzs+xJl0koNsZpXAfxQ8wYIDxLxqpCubdbpuM4fDOoE15hxwIOy9zU2Umzz?=
 =?us-ascii?Q?DTsg1/QbjFnt0HaE+HUHzi9ckZL907x9trZcZDkK8TIqAEH86YxrQB199fdQ?=
 =?us-ascii?Q?LEJkrjxUhxeLZinfhS5V/gX2xFvf6CKh/xgdghJri792981AKFJ05RwhY8fU?=
 =?us-ascii?Q?WBdkikzOQkxpFdQ6OucDZtBGn8PMh90TQfLec0rNZOZqsWexYbvZtmDInKXm?=
 =?us-ascii?Q?h6+fZFeMfjb3WmjQj1xq3Q8ciUbqCsRwmz/5RO1V6lSA8K6UFlIATT2X7mL5?=
 =?us-ascii?Q?WYQXyShSUgwxORwCCOCo+Lk1/35okd6DJ/kIGO9c+xUfC83LveBN6q3EvtOq?=
 =?us-ascii?Q?uu61PKpjP90thPn4B28EzAvsn91U/rW1DCm+xfX/BVju4GHuvxCorqnYyuEf?=
 =?us-ascii?Q?ZMPhOSTj6KAJhiBs1r2B1+cSAH+V7WtBf8pHTuPC/6cfqkW7raGN+AeI10hg?=
 =?us-ascii?Q?ncY7OwWUqMrza4MZt0+iQVoMbbSRa8W7+PPRDzTiYuFSTtsAOQu8TwWCo7kC?=
 =?us-ascii?Q?FGkwUPs8LrJhlxHsG+gI/9OLHNldMjm/FvzHr8/7Hg/cs4WambsHeDeH/itX?=
 =?us-ascii?Q?orEGLus7XfY8k7+a8DRqNhFFqx0E/ENeLHDb5PTOSB7iofoLkXqRB78M+UnC?=
 =?us-ascii?Q?B7oUkiUKzUOkLeX5AtUecDKalITW2PtmLiN5rkkooykZmWjwqSS/9f0LvdPO?=
 =?us-ascii?Q?oRSNluOC6Nj+BtYKJqP6ZEto91Pa8G4ivIAPZWmU19j5woUmUhOcZYf6MRWX?=
 =?us-ascii?Q?qXmu6ETXCxdfz/K2jZQo1bG2pIWsLCqPasdkMhAiFKtlNDwJ0zSwTEI72VdW?=
 =?us-ascii?Q?rliFCtwzsypvFTy9HPHwD7/Rl9FnXFPhqlX22LO/y010jlLhc3gfRM20RKo7?=
 =?us-ascii?Q?GzgMJHndFwpdseZ3G1l+kAo2CWy6oLvxuRgqV5P28rpQmlHh1z53vZlP/LFb?=
 =?us-ascii?Q?LkW0HypB2+fVjAQy1H/GplUoiDylwOedhNHQ2TcV4SiH2yamnq/8kWU7N2k7?=
 =?us-ascii?Q?SZBHSA/9C0ZNbYP1JYziKpn9lDYr24ibM9+yOuB9LuLx17TjnFZgq29OosK0?=
 =?us-ascii?Q?NiBVnlSUEzFqcI6dX6JNC1VAjo6Y7b9d5iM6YIyhUfky/futqtlFXkFqbrI4?=
 =?us-ascii?Q?vez5I8UnFQ09kTYF8iLkQcxTuIf7XyB69DCbxIvkaIJta2t5bGf0GFxnMhJw?=
 =?us-ascii?Q?5wiOr2uOtkSZX/q4YP2A4s3zHT3M02bZ1kOoz+1pJpyyvn956ewTgw2/p3xa?=
 =?us-ascii?Q?Igvo71NdTQF7uBKJmlE8TZP78SMYwnpwrLoI+dGjxutaddLssKlPtGLzDIVo?=
 =?us-ascii?Q?EwUQd0PUbzVb+YlNqGNkKopc6uDmuimQgEZNuj8TgPQ8sHk6TQv9e1wizZiH?=
 =?us-ascii?Q?k0Ax11nK8bJawoGtknNVEuLae0k9M4T10BYgFxYEyEmIf16Vg02mRldfRY0C?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1becdc-252c-41a3-dea2-08dc903bffc4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:44:14.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35IOCajJW2HBhQpWRJvI5dwWTfL9hNjj150stnJf/faMkFQPZlJOKBGlub1cpbc8B4/qXkqWnDecvT318JJL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3263
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 08:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16291

On 19.06.24 10:01, Gylstorff Quirin wrote:
> Hi,
>=20
> On 6/18/24 10:31 PM, Jan Kiszka wrote:
>> On 18.06.24 17:56, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This back ports the fixes for the wfx progress handler to avoid a
>>> second reboot on the device, see [1]
>>>
>>> [1]: https://groups.google.com/g/swupdate/c/wJ6g5lajuYw
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 ...d-suricatta.ipc.progress_cause-table.patch | 30 +++++++++++
>>> =C2=A0 ...ress-Fix-reboot-mode-message-parsing.patch | 52 +++++++++++++=
++++++
>>> =C2=A0 recipes-core/swupdate/swupdate_2023.12.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +-
>>> =C2=A0 3 files changed, 84 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644
>>> recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ip=
c.progress_cause-table.patch
>>> =C2=A0 create mode 100644
>>> recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-m=
ode-message-parsing.patch
>>>
>>> diff --git
>>> a/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.=
ipc.progress_cause-table.patch b/recipes-core/swupdate/files/2023.12/0001-s=
uricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
>>> new file mode 100644
>>> index 0000000..69873cb
>>> --- /dev/null
>>> +++
>>> b/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.=
ipc.progress_cause-table.patch
>>> @@ -0,0 +1,30 @@
>>> +From 3ac2b34958a31c3694a78f840201373cfaff6c10 Mon Sep 17 00:00:00 2001
>>> +From: "Storm, Christian" <christian.storm@siemens.com>
>>> +Date: Mon, 3 Jun 2024 20:16:56 +0000
>>> +Subject: [PATCH 1/2] suricatta/lua: Add suricatta.ipc.progress_cause
>>> table
>>> +
>>> +Reported-by: Adithya Balakumar <adithya190298@gmail.com>
>>> +Signed-off-by: Christian Storm <christian.storm@siemens.com>
>>> +---
>>> + suricatta/server_lua.c | 5 +++++
>>> + 1 file changed, 5 insertions(+)
>>> +
>>> +diff --git a/suricatta/server_lua.c b/suricatta/server_lua.c
>>> +index 7ac5e972..2641a037 100644
>>> +--- a/suricatta/server_lua.c
>>> ++++ b/suricatta/server_lua.c
>>> +@@ -1592,6 +1592,11 @@ static int suricatta_lua_module(lua_State *L)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 push_to_table(L, "SUBPROCESS", SUBPROCESS);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 push_to_table(L, "PROGRESS", PROGRESS);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 lua_settable(L, -3);
>>> ++=C2=A0=C2=A0=C2=A0 lua_pushstring(L, "progress_cause");
>>> ++=C2=A0=C2=A0=C2=A0 lua_newtable(L);
>>> ++=C2=A0=C2=A0=C2=A0 push_to_table(L, "CAUSE_NONE", CAUSE_NONE);
>>> ++=C2=A0=C2=A0=C2=A0 push_to_table(L, "CAUSE_REBOOT_MODE", CAUSE_REBOOT=
_MODE);
>>> ++=C2=A0=C2=A0=C2=A0 lua_settable(L, -3);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 lua_settable(L, -3);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 lua_pushstring(L, "status");
>>> +--
>>> +2.43.0
>>> +
>>> diff --git
>>> a/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot=
-mode-message-parsing.patch b/recipes-core/swupdate/files/2023.12/0002-swup=
date-progress-Fix-reboot-mode-message-parsing.patch
>>> new file mode 100644
>>> index 0000000..9719057
>>> --- /dev/null
>>> +++
>>> b/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot=
-mode-message-parsing.patch
>>> @@ -0,0 +1,52 @@
>>> +From c65f5435eec2a0c51f6f0c356451c2091b2f3fdc Mon Sep 17 00:00:00 2001
>>> +From: "Storm, Christian" <christian.storm@siemens.com>
>>> +Date: Wed, 5 Jun 2024 06:35:24 +0000
>>> +Subject: [PATCH 2/2] swupdate-progress: Fix reboot-mode message parsin=
g
>>> +
>>> +The incoming msg.info reads, e.g.,
>>> +{"0": {"1": { "reboot-mode" : "no-reboot"}}}
>>> +and sscanf() also needs to parse/read over the enclosing
>>> +{"0": <...>}
>>> +part, though discarding it.
>>> +
>>> +While at it, use static buffer allocation as the BSDs don't have %m
>>> +
>>> +Signed-off-by: Christian Storm <christian.storm@siemens.com>
>>> +---
>>> + tools/swupdate-progress.c | 7 +++----
>>> + 1 file changed, 3 insertions(+), 4 deletions(-)
>>> +
>>> +diff --git a/tools/swupdate-progress.c b/tools/swupdate-progress.c
>>> +index 584910d4..14040757 100644
>>> +--- a/tools/swupdate-progress.c
>>> ++++ b/tools/swupdate-progress.c
>>> +@@ -339,7 +339,7 @@ int main(int argc, char **argv)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Be sure that =
string in message are Null terminated
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msg.infolen > 0) =
{
>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
ar *reboot_mode;
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
ar reboot_mode[20] =3D { 0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int n, cause;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (msg.infolen >=3D sizeof(msg.info) - 1) {
>>> +@@ -354,15 +354,14 @@ int main(int argc, char **argv)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * will be added, JSON lib should be linked.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * NOTE: Until then, the exact string format is
>>> imperative!
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =
=3D sscanf(msg.info, "{\"%d\": { \"reboot-mode\" :
>>> \"%m[-a-z]\"}}",
>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cause, &reboot_mode);
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =
=3D sscanf(msg.info, "{\"%*d\": {\"%d\": {
>>> \"reboot-mode\" : \"%19[-a-z]\"}}}",
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cause, reboot_mode);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (n =3D=3D 2) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cause =3D=3D CAUSE_REBOOT_MODE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(reboot_mode=
, "no-reboot")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 disable_reboot =3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 free(reboot_mode);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg.cur_image[sizeof(=
msg.cur_image) - 1] =3D '\0';
>>> +--
>>> +2.43.0
>>> +
>>> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb
>>> b/recipes-core/swupdate/swupdate_2023.12.bb
>>> index 1c140b0..cc01a98 100644
>>> --- a/recipes-core/swupdate/swupdate_2023.12.bb
>>> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
>>> @@ -27,7 +27,8 @@ SRCREV =3D "6ccd44a8539ebb880bf0dac408d5db5de7e2de99"
>>> =C2=A0 # patches
>>> =C2=A0 SRC_URI +=3D
>>> "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch=
"
>>> =C2=A0 SRC_URI +=3D
>>> "file://0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
>>> -
>>> +SRC_URI +=3D
>>> "file://0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch=
"
>>> +SRC_URI +=3D
>>> "file://0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch"
>>> =C2=A0 # suricatta wfx requires suricatta lua and the dependency
>>> =C2=A0 # is not set automatically
>>> =C2=A0 DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattalua"
>>
>> We only support wfx with SWUpdate 2023.12, not with the other versions
>> we have recipes for, right?
>=20
> IMHO, we only support wfx with SWUpdate 2023.12.
>=20

OK, thanks - applied (likely as last patch before the release, finally).

Jan

--=20
Siemens AG, Technology
Linux Expert Center


