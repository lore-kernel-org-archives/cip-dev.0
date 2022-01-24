Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D0C433EF
	for <webhook@archiver.kernel.org>; Mon, 24 Jan 2022 14:01:09 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.78])
 by mx.groups.io with SMTP id smtpd.web10.3897.1643032867465986930
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Jan 2022 06:01:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hbk2N/yn;
 spf=pass (domain: siemens.com, ip: 40.107.21.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+I4Z/aYguca2jZH9PWeWPkJvpRbnF1lTVklf6/+ZZ8BruzIq6JLO5iJK+yKMnf1xWpYuKlmw2WGi9MDB0HJ23fxBSMO4Xydhwg0Bp/AHybeJoOOgIxVXu3Zc9adKfZQkWUhLOe0Q+97REyRgw83sGMkNRUMoiH7/uydBXutXEhUOIAQZreZHPbAcle9o1C37R+4qHb9CC4ki4LCWQyKCf5VsaMgWDf3OZh0/06sfz6F5vjztRZhr11gsv3kocCRsDpW++Z0I4+hNOR7lGV7U9MKFScEt17nexuGNf3kBoXEZUs1RA5pyNiUR6NBgBeqwYfaj/IPpI8R+5PiptGY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JcXrOJ5C0vhAKdEKCI04EqhTH9sEmzCYWPXRU8iBOU=;
 b=lWkB1/J+AYz1rAQGPv7MX5lOvc96YeLuRSSZw3uvdXAVUNZ5QaHx28+KvRo1UF47sNPQBKwO95QL5OIs0C9Loi0etyGt+r0/Hr76X62A/2GlYByL2rCIiz6Z6h6t65nEHFEwnnuoqNLAveDfMXwHrs+hiieOVA23QHjOW+PPNYkhMEHaCcTxMWMRXOSz0a5yX08Qk0y9SOfADTCbM5estYuvKMa0DRTZUBxdiAZdOyg0juDc2caCQ408twlgoj4GeRpL9mXNHYGA1ym98SJDN6hoEOvjfO3QxR9T3RpK6Jy19PCJ9J8D8+EVI9BhJOrc5QfygODpTS+Td7+3l7LoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JcXrOJ5C0vhAKdEKCI04EqhTH9sEmzCYWPXRU8iBOU=;
 b=hbk2N/yntp/BEQPcFzG2bsLOdlyll0+9qmBoGfZgE1anOz8c9k0rcyRbSe5WMoS9WCbyYXCnw+nWHboYL9PQoe9uLJR+7YB0S6bX6PMEofL7lG0YUsCtVR6yHHXtdOZV/BIIsUVqKMTpafgkwlPkyxvzVBUoYzUwwraJbbJ5AFwZLApdumAIdjdCkmV5niEi0Gwr7xb5oiUcDzF3d3a143fWhNxb6YC7xrFanmjmri1KpITA2xiUQpkCLycrdrTJclczndEjP8H7wc2CeKWIezFvENI4eUHor02SqPY8UMROtyDnW8yxbwbknvE4wybTIq1FyRwLXOWhF0rD2G/3pQ==
Received: from AM6PR10CA0084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::25)
 by VE1PR10MB3791.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 14:01:04 +0000
Received: from VE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::e5) by AM6PR10CA0084.outlook.office365.com
 (2603:10a6:209:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Mon, 24 Jan 2022 14:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT058.mail.protection.outlook.com (10.152.3.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 14:01:04 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 24 Jan 2022 15:01:03 +0100
Received: from [167.87.32.56] (167.87.32.56) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 24 Jan
 2022 15:01:02 +0100
Message-ID: <0b30e976-3a36-21a5-821a-9f0138d911ae@siemens.com>
Date: Mon, 24 Jan 2022 15:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [cip-dev] 4.4.X-stable and 4.4.X-rt maintainance ends in less
 than two weeks
Content-Language: en-US
To: <cip-dev@lists.cip-project.org>
References: <20220119141210.GA2310@duo.ucw.cz>
 <CAODzB9r+R2hKi2_Au17JLMG4us4W7jrzQhBXVdSBXm_ub+CDhg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CAODzB9r+R2hKi2_Au17JLMG4us4W7jrzQhBXVdSBXm_ub+CDhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.56]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22a8000f-a529-4034-c4f4-08d9df41f5ea
X-MS-TrafficTypeDiagnostic: VE1PR10MB3791:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR10MB37913112681A2FBD5C6ADA8B955E9@VE1PR10MB3791.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MUg4ZjBORi9yZ3I1U3BKT2JEN3JNTU5DN0twVmJiaURaanU4NkQyMk1kUzVO?=
 =?utf-8?B?SUFzZ0JHYjZheUh5dCs1WFQ5T2tFVFBLbXkwaGxIb2xwT0VuRTYyeUtsRXRR?=
 =?utf-8?B?RHpXenk5UXVXYjZKaU54dFBrQmdpSFNSYW4wdmdvclIwcHZERWF3TjB0bHQr?=
 =?utf-8?B?dGd6dXhvK2NOK2FsMzI2dVRPNFNmc2QyY3ovUy8xaDRjMHFVeDJCUGt2WFN5?=
 =?utf-8?B?Y0swQjRGc0ovRnJvMHRKK29TRjdMa2lXdTJkZ3h4ckVGQ3NBbmhRMFlkMUd0?=
 =?utf-8?B?UkhQWWNMZXhBWXV2UWlZajduNjhRS1BiVjluRkhuNlZOSEVNa0I4Rk12STg4?=
 =?utf-8?B?RXltano3RndzSnhUaUNZbUtVVDBSVFJIVndaOC9qRW5STGhEaWpINVJqSXBO?=
 =?utf-8?B?SlBpaDFOVXRqN2hQbG50Mlkra3pRL3FnaVFmODNtcysxUTF0R2lyaVJCRkc0?=
 =?utf-8?B?ZDdSeUN1SmM2blk2RGRnbUwwRjV4VENhQ1BtNUorVjErRUorek9OK09BNjB4?=
 =?utf-8?B?M3Y5Si9TU2cyajhyQU56VkNJL3NOS2pXTFA5cEFXNmlVTmtHaG1ScHpNbjRG?=
 =?utf-8?B?SG1pUUxuMGowNy8xYUpUbHViS2FoQmlEcCtpRFRMWG1Ba2xFejZibnMzSWhy?=
 =?utf-8?B?Z2hROHNxdEVTdUZ5Rmo3SWg0eDBqZXR6YWF4MlRoLzVQdTdrWnp6VEk1V1dr?=
 =?utf-8?B?cHZBekNmMEo5NTZmRWl3VzZzbTVVSm9NN29ndzJuempJYkFOd1gxTE9yWGxN?=
 =?utf-8?B?WXdLbWVkOG0weDhpQTUyZmpyZ090SzBpUUx2YTVzYlN2cG85NURzVFZYdlZi?=
 =?utf-8?B?TVd0VEhlTE1YV0xCRzlDWmhqa0RtajFSdGVGU3F0NEVTU2l4T1NIVUJ1RWc4?=
 =?utf-8?B?em5nUllobmxBUTE2aGk2S1pGWUVmWVRnWTVXaGVtZ1FGakt3RzZQSkoyOXI2?=
 =?utf-8?B?azF0b0M4MWZxUmE4U01Ta3dNWW9ETk9KNWdkeVhVRmpJVlc5SGwxZGNodFNQ?=
 =?utf-8?B?SjFDb1V2ZDE4TG4yTmViRCtIeTdSWG9WdzVhdjRjUlpSQWs1dTEyMW55dTVs?=
 =?utf-8?B?RnVURWtvVDZSTjRqenc1d1ExbzhGU0R4ZTRIcFdlNFZnVzJVR05SQTNwc2tJ?=
 =?utf-8?B?ZDBhS2dJcWpQemQ1K3BkaUk5S0c5NFhPMHpSWk9jVFJKWGxsL2xqaElQL0c3?=
 =?utf-8?B?QjE1WEthS3NndVd2OFFoYkhpS0pXUmdXMUlYWEkxR2dzWkR4V0YyR3ZZcG5X?=
 =?utf-8?B?NWdkNkJFaUp0OGNBbnNNbG4zTFJjV2Q0M0RFdCt1YjBQSlluMXpVcUFReTJQ?=
 =?utf-8?Q?oTbMl82btgdII=3D?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700004)(31686004)(86362001)(70206006)(70586007)(44832011)(31696002)(40460700003)(47076005)(16576012)(81166007)(36756003)(83380400001)(8936002)(5660300002)(6706004)(6916009)(356005)(82960400001)(26005)(2906002)(53546011)(8676002)(16526019)(956004)(186003)(966005)(508600001)(316002)(82310400004)(2616005)(36860700001)(336012)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 14:01:04.0778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 22a8000f-a529-4034-c4f4-08d9df41f5ea
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3791
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Jan 2022 14:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7477

On 20.01.22 03:26, Masami Ichikawa wrote:
> On Wed, Jan 19, 2022 at 11:12 PM Pavel Machek <pavel@denx.de> wrote:
>>
>> Hi!
>>
>> It looks like stable 4.4.X maintainence ends real soon now:
>> https://www.kernel.org/category/releases.html . I talked to Greg and
>> it seems like plan is to end it at the beggining of month, rather than
>> end.
>>
> 
> Thank you for asking the actual EOL date.
> 
>> That means we'll be on our own maintaining -cip and -cip-rt versions.
>>
>> To review our 4.4 branch:
>>
>> git log --pretty=oneline linux-4.4.y-cip-rebase
>>
>> We have 757 patches on top of 4.4.216, and there are some 14000
>> patches between 4.4 and 4.4.216. Going forward, most new patches will
>> come from upstream.
>>
>> We do some compile testing, but we only run run-time tests on two
>> targets:
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/448669210
>> .
>>
>> Given that most of work we'll be doing will be maintaining -stable
>> patches, anyway, I believe it would make sense to step up as official
>> maintainers of 4.4.X-stable and 4.4.X-rt series. We'll need to do the
>> work, anyway, keeping -stable and -cip split will not result in much
>> overhead for us, and this way we'll get a lot of visibility for the
>> project, and hopefully a lot of additional testing.
>>
>> Any thoughts?
>>
> 
> I agree. The split -stable and -cip work sounds reasonable.
> I think it would be helpful, if AUTOSEL system continues to pick
> patches for 4.4 series.
> 

I do agree that, if we need to integrate patches anyway, providing them 
as a prolonged LTS should not be extra effort. But what will and can 
people expect from that?

The original LTS kernels conceptually covers everything that is 
code-wise included. Our CIP kernels do not. While it might be still ok 
to fix trivial build issues or even runtime problems for things CIP does 
not cover in the configs when they only occasionally occur, we will not 
be able to commit on doing that all the time - resources are limited, 
and the focus needs to be on CIP-defined setups.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

