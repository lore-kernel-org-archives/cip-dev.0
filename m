Return-Path: <SRS0=QIgw=LL=lists.cip-project.org=bounce+64572+6528+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1FC2B9F4
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 10:55:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494C8613C1
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 10:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494C8613C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6528+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id z5taYY4521723xWklBYYxcBG; Thu, 17 Jun 2021 03:55:34 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web10.2334.1623895770046802371
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jun 2021 19:09:31 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masami.ichikawa@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id RLIF04244A;
	Thu, 17 Jun 2021 11:08:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdoPmPx7CYDZNZArd4fL2W2LmSioHpEqwuGhGLGQaKpItk1a6dbnGwgcx3vg+G5Q6d4ojE9bF5Ys71rmDNqbjlKCyu4gF7FD9FvisnoCYyNeT3sGg0QrVZUIh+q6ZXsTzfIcLRw/AwwE0Qvx8MzDt5JVQUNPz2w7HaelB46jdb9uD3O06kQlxKTXwXq1+0gyWqd4G1fkL49OaSLYIngvCg9ekCYQdWytlHchdzUwKE/3xJCuHymRxzS3yZC34o47IwFokNSt+Ipl9g3CcmZXcUbgz0Z16mpx0+Neo/a7e1dbdqJ+VtUXHeqWVwjB6vEDsIULsR9Qm28TlcJQmQVTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKb/pe6ES1u6M5YLRoHQmxaOi9sYrCUR4s6j8OqBBIg=;
 b=kP/y66SXqGP9xGE20mk/8vpj/HIg6vG8ozxSJxJr9guhOEYtly0PEsSrQ8bUQPMOGCDiLb3aaXIbEaR65ymg8MlMSYi95uZiNzE1JHCss9VC9CILdf9Xzyo9tuXusRQQnXiTwDhB3c/hMKtgoxrcKSNgSLhtef+oaudpovxqkyjk9+AAVJEbk1eKaVu2FO2CyBIqN4l/ew6wkXvqso3vixbJfXRlij07sz3mB2GsYq1511cGJm1uX7cXlNKXU1Mx+1kTT0bi6f82k1HZGIfjRlZTIrpV9Cap5fggpC+vvlKEiHRk9uOGcgAzgGeEIDGltj706U9smgwf36dqiEZlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB3882.jpnprd01.prod.outlook.com (2603:1096:404:de::12)
 by TY2PR01MB2138.jpnprd01.prod.outlook.com (2603:1096:404:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 02:07:54 +0000
X-Received: from TY2PR01MB3882.jpnprd01.prod.outlook.com
 ([fe80::695c:c997:e3f4:9eb]) by TY2PR01MB3882.jpnprd01.prod.outlook.com
 ([fe80::695c:c997:e3f4:9eb%4]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 02:07:54 +0000
X-Gm-Message-State: IMODf1PhND32pXsFEx5XDBpHx4520388AA=
X-Google-Smtp-Source: ABdhPJyqk6v7Mty9Hovyox1hzEm+vjXbs9pFqb823rOEKM1Weg2xBqkhizMwr+YZgAmF0ZFnYcunzSncJeIlm9MRBk0=
X-Received: by 2002:a05:6830:2649:: with SMTP id f9mr2308173otu.179.1623895668565;
 Wed, 16 Jun 2021 19:07:48 -0700 (PDT)
References: <20210610170538.GA12973@amd>
In-Reply-To: <20210610170538.GA12973@amd>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@cybertrust.co.jp>
Date: Thu, 17 Jun 2021 11:09:25 +0900
X-Gmail-Original-Message-ID: <CAODzB9rvyCg+=EctmFES3K+_Zi9pOxBJP5AWS8X6to311sscBw@mail.gmail.com>
Message-ID: <CAODzB9rvyCg+=EctmFES3K+_Zi9pOxBJP5AWS8X6to311sscBw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
X-Originating-IP: [209.85.210.53]
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To TY2PR01MB3882.jpnprd01.prod.outlook.com
 (2603:1096:404:de::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from mail-ot1-f53.google.com (209.85.210.53) by SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Thu, 17 Jun 2021 02:07:54 +0000
X-Received: by mail-ot1-f53.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so4644346otl.0        ; Wed, 16 Jun 2021 19:07:53 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b618f883-6a8c-4abc-47be-08d93134b7c2
X-MS-TrafficTypeDiagnostic: TY2PR01MB2138:
X-Microsoft-Antispam-PRVS: 
	<TY2PR01MB21380577A8A808AF7A29F529D40E9@TY2PR01MB2138.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	iP/5WqNBA8wrah5f/5S/mR272idqk2KcaQ4wp5xUBDPjM1HzvTRTOUxJsRWPuvNYL9q8PdbmSQXE9nVFDOb07R/0VjZJThWMMM5UQn0i72B2502M5iWNlkfPP8vv/Diyu6OBfvcrILLD9hiw4CuWIAHDUBrPHU52ghEVTfOFZQxPFvQCz4IrkCjmH1JkdizEYPf7SfZFo25YOinWq38gKsD7lNNylBtXtqdWAmRbDbns8dJ6F2+TneV5LUyCVsosCfBH1VZeisT7cbIfrlFr0/1qVgH9TuLi6pJytVHW1LpvuUQu+xs6XTzrfJC4cVKhtxYAmZGWeCGgmZgaAf+dGNx63Vtz2U6R0zmqBGB++RJbIO1f61c4gZeEwxJ9tgG1uTCtQV56k57iWmZc/gmmvbB+X9n0qMg5HX6V16eq8Lfx9ztPTz3kZ+VdLfYpKP6c0JIdZFkpqr5Ebw3DmEh6xxC9LMfVJ7gAUU79m97q62l/faW8z0qiemRtFUJzDyc+sAScJdlhSUpJiWi6PNjiG4pk1Nvto8nBsJNlbvrsZki8+DncRFHa8t7ECfkSPhVMtwr0u6rl0dxWrFMGFbQspScIXodiEeNL8Gp3v1AZMXlwD8/n9eE/+XvNsm3SSpYeTOsg57nktY7MHtP6vM/JYsC+XA2MEAkYHefSl/ysnqWbnqB8Wljjfo0FiooaVXMSSb/+9Z6Orb5pqmiRQ22Hyl74noIJc0QjTQuHcQpLGC8kBNweuVJSIedyw1oujCzvH/rj2Z7paDxHoqW79LidMd9S+rcUyoA3SbHcXg0BNpruGacKbaWq6HfR2qpZbUf5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cCt6YW0zanFRS05RZUtoaER6L3JTRVpmYkZETlNBWG84V3J3blNOVitoKzJU?=
 =?utf-8?B?MHNxZ0dnZS8zL2tySlNnT0hmN0h0L0hBeWF5MGNiVjM2cVgyS2NyT3pKZ1Ft?=
 =?utf-8?B?RG54a3VFcHhlWEdhR3BMTXdyUVhHaGlsQi9VYXNNVWphRkRWdVJGd29ic0ta?=
 =?utf-8?B?UUlXNExwNXkvcFl4ZmNFMkRacGNXRm8zaktLZEhQcUwvemxqa1hObkRhb09Q?=
 =?utf-8?B?cFdndFpZeGk0ZVkyc2xCZWxzVU92TWRSOXFBTjk4ZDNERThjOWNETkFaazcr?=
 =?utf-8?B?VG5kdXlmUmdZREhBQmt2a2VteVBlNVV6eUE5Nk43bWgyTkwxdWQ5b0t1aFY1?=
 =?utf-8?B?ZHNsS0ZJaUhQK05tQjVUeTdnKzdWZjhYQitmL2RPaWtPSVhtUXZtTG1UQnA5?=
 =?utf-8?B?WW8wV1J5ZDVscFFmamwzTHVDRHF5ZjBXdUhyeXphbDdtZmtVaUxYYWlyc2ZW?=
 =?utf-8?B?RlRWdHhPdjdHbithRXFSRXR1ZGEzbWlPbGxjY2dzcVBhRmkwRGpIZStRSjhi?=
 =?utf-8?B?TlZ6TkJyL205b1RuMk1BY0tJMm4zMldqQ1gxOGF0QWtCazRNSURhRVd6aE5V?=
 =?utf-8?B?V2RXeHJidlpaUmZhQlFyWjZ4enh1cFZ6NHEyMmNnNVJ2RHQ2MENaTWx0Mitr?=
 =?utf-8?B?SFU5cnlJLzVkVXJ1bzl3NU9nUFdDQWsvaVJHakMxVW14Y0xGZ1AvS1hGc2xL?=
 =?utf-8?B?Ym9hcGl1SkdMVDF0dXVwL0ZSVlErNjNnYWpseDV1QzgwVlhmbUdrUENpZVdU?=
 =?utf-8?B?YXBIUWRmZTh6Z0h0U2hrNnUwRlNiNTBkcnE4UTVYdFBxUmZCRE1obDVkYW93?=
 =?utf-8?B?Q29QM3JTSk1lVEwyZnFocS85WU5SS0JyanhBT0xkV3RRQ1pvc25sN2YrN2hq?=
 =?utf-8?B?TkdFQlI0M1A4ekdBNkliaElhVFA5anVtWmh0UnhpdklHWC9zNDhHWDg5cGZP?=
 =?utf-8?B?K295dlFFMkpMMVBpR3ZWYVJrbDI3bk1XdU56S2toTDBGdmFIQTlxTHpFZ3lF?=
 =?utf-8?B?WU5ubnlQY0hMemxxNmFLUXp3ZytsUnlLQ255YXF2clBudUdEbEhaWVpBT1hL?=
 =?utf-8?B?d3RMbUpTV0EreEJyb0lVVWMzaW5SVjlIaUdYQUg5MGR6Rm1qMzQ3N0R3QXEw?=
 =?utf-8?B?YzhjRTRVTkFVVE1pK0JnQzNOOHFWTGJ4ckRyZW5nNDVjbUw2TFJrUjRiLzhm?=
 =?utf-8?B?RDRJMU0wSWhaY2ErMVphMkptSVV1MXgxTFFBYWYzcnQrN05qRksvR0hmYjJa?=
 =?utf-8?B?WkJka2hPWkRMQzI4dTZnajN2TXFNZmRGS05CdUhIZ0YwNkE5b2ZURndWS3lG?=
 =?utf-8?B?UDQxQTE0a3Y3b0dpYWZPbThNTlhadlZ2eDRtQTZyRGdNYW9zMHhKWEZ5ZGhh?=
 =?utf-8?B?KzNXc0ViWGZVL3YyWUROTFRWOHp0QUJJUVFkaGhzMUs0MTJTZjR1K3k2UStx?=
 =?utf-8?B?SHVFVHBPL1NuZEllZm9LaVp3Q0h2c1JEWHZhT2tkdzFBRDBlcVkzdU1TajJU?=
 =?utf-8?B?MlZjZnc2Y2RFUnRhLyt2VWNXVTBkS0pZTzNpQ3UrZnZXTmsxdzBBNUxld3VV?=
 =?utf-8?B?czFLekl6Q1VGUzJiNjRubHFSZFp0TlJhZUlwVU1GMzBUSHU3Y3E5ZGsrK3Qr?=
 =?utf-8?B?a3EyQTJKcm5RYS9Jdk41WDNUN2dIZkJTUi82emdNSTl2YzFmY3ErU2Qyd1hq?=
 =?utf-8?B?aGROM3RrOFk5MjI4WUpHN0c3VE8vMnl5cVA0WGtMdXVPRnNJOWJGeTJYTG9J?=
 =?utf-8?Q?x+LoYI3Z15bLyfq+6wbe4IR5+MywOsCgGU4zme6?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b618f883-6a8c-4abc-47be-08d93134b7c2
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3882.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 02:07:54.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5xwJYWASRxwjzu4dErI38nyMQsVn0vC8uMtTvtCpGtLJ0BxcztxB7uX5JFrpbkzvdvblN1W54kzk6+eOwKAAS7UJNmuSR+8MdTPioDNjTUmYiofEtG1YNPnm1xpOJ7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2138
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="L12GWlqxP3mZR8DYdfNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623927334;
 bh=g7MzXD9ejr26BuGD3ZcAmTEClHtC7MY2OgryiCY5sZA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tvYrzORQlw/ywTyyq5gZSar3QH+O+dB5YOvd0VqUO5JTOc29IYDubx7qmwoVcY02jxx
 EUczzpToG5yvBibarW+c5DuHORvDFdeaQrECui77UGeTA0MKk8A9ImoJAiuTtDJYWdRVt
 N3hnnWX4EestjNSiQfK66olkYWctOy6Tf1A=

--L12GWlqxP3mZR8DYdfNo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

2021=E5=B9=B46=E6=9C=8811=E6=97=A5(=E9=87=91) 2:05 Pavel Machek <pavel@den=
x.de>:
>
> Hi!
>
> These are the new issues this week:
>
> Best regards,
>                                                                 Pavel
>
> * 2021-06-04
>
> CVE-2021-33200 -- BPF fix turned out to be buggy.
>
> * 2021-06-09
>
> CVE-2021-0606 -- EoP in GPU DRM Driver / reported by android, probably u=
pstream commit e7cdf5c82f1773c3386b93bbcf13b9bfff29fa31 ... may be interest=
ing?
>
> CVE-2021-3587 -- redhat Bugzilla 1968057: CVE-2021-3587 kernel: nfc: Nul=
l pointer dereference in llcp_sock_getname
>
> CVE-2020-36385 -- An issue was discovered in the Linux kernel before 5.8=
.1. net/bluetooth/hci_event.c has a slab out-of-bounds read in hci_extended=
_inquiry_result_evt, aka CID-51c19bf3d5cf.
>

According to the  CVE-2020-36385.yml it describes 'RDMA/ucma: Rework
ucma_migrate_id() to avoid races with destroy'. However According to
the  CVE-2020-36385.yml it describes 'RDMA/ucma: Rework
ucma_migrate_id() to avoid races with destroy'. However, the
description of 'An issue was discovered in the Linux kernel before
5.8.1 ...' seems like CVE-2020-36386.

> CVE-2020-36387 -- An issue was discovered in the Linux kernel before 5.8=
.2. fs/io_uring.c has a use-after-free related to io_async_task_func and ct=
x reference holding, aka CID-6d816e088c35.
>
>
>
>
>
>
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
>=20
>

--L12GWlqxP3mZR8DYdfNo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6528): https://lists.cip-project.org/g/cip-dev/message=
/6528
Mute This Topic: https://lists.cip-project.org/mt/83449660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--L12GWlqxP3mZR8DYdfNo--
