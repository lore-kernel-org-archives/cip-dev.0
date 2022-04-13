Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51442C38A2D
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:07 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.82])
 by mx.groups.io with SMTP id smtpd.web11.4115.1649841149452916685
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 02:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NzYZAIp7;
 spf=pass (domain: siemens.com, ip: 40.107.14.82,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7FTP6poYslZnrZVmoOIU0DVY2DMkUijEjNX8+0mYf7S7GsMmnm5ICaZUXLpRDRJPASpjvGABYZAyilnB3XnGcs6RfC+/B2+qOYrqnlC5xCB3+NKpoozhYmhWJ9E6BbaldKvqKPFs2Sp1I4LJtGDArCXih2Sx6EJG65IXlfIi5am12F3M2szKqhiMLGgQd8RNeBTt5IgR60lMHQvQjCLWNRwaXckMg9sQ+bj0F2qdh4SE6EHKlcTI513+/EK4/HvZM9FH2eec685udjJ7NbvjoJztuIBbLUYwmUgy/ZhX9TQ4OgzhMztGVWo9QgPts1JI4O7osmmI5qrOWiJ3b8aRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am4PP/eNMShSCQKvxU+G03+5e1Gcqk8X6v/MSc7H7is=;
 b=Aq0IDzzgO2jjs1B2EiDMx5ZdgIV9/6qaDkFcsw6Lqc5RsglnC0+CsST1Kt96KRAYLFOmYgDqwB8+Cjxeweycq1onSwsFnKCaFBr+JoK0RtzS9pVu9LhwzRYftHADjMmlIMLpmSl0C9Y+NoSyqtVsEd7/U+BvJV3RL0snOUEFJsyk9bxfF/QaxGulkKvTt6D4OBnM32qWb1EBxJt8D/FBw37rLMf4+XKj5Wf0Bvj2GjEeik/q8PnklolQaAewpc2tWFzWVh+PbxYZ+ayDtQdkpglfq1I18w8gapyNVP0abqWxO5hxrsw59xZdzXLuh4oxtLYnxyLUqQ4ztzUAq9I+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am4PP/eNMShSCQKvxU+G03+5e1Gcqk8X6v/MSc7H7is=;
 b=NzYZAIp7QYF3v2mrYtxDvg3ZaAO2Dncm61JAM/GAbj6Ig/T3RAMvbWiH/9lNVhyh2QSA0UK8MzOyNGLyuov7F2w53ukuRwQwkbGRCM8+2rwoZey8rh0C+4y6bvuIDmyZKmYP0RGn4zgy7LsPwxdhivRbfR9fw0FPGUY5DI8KH+dT2MyJ5d9BkbMopyW4SgJ1L0UCqd+PlI3Z7ZuhzPh0N9j1M6mqvUFxZgnxI8wcVd3pZMdKDsNXtOIYj3qR1yzqneB6/0DNeSqnE4VM4ljZJqvyM+1iVvbsLTLPU/DBUdvPxmWMb5e0OlVS4guwut0GvMgNl/LzuucjggbVVl0nng==
Received: from AS9PR05CA0050.eurprd05.prod.outlook.com (2603:10a6:20b:489::24)
 by PRAPR10MB5225.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:12:26 +0000
Received: from VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::b4) by AS9PR05CA0050.outlook.office365.com
 (2603:10a6:20b:489::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 09:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT072.mail.protection.outlook.com (10.152.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:12:26 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 11:12:25 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 11:12:25 +0200
Message-ID: <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
Date: Wed, 13 Apr 2022 11:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, <cip-dev@lists.cip-project.org>
References: <76860af5-c727-1ca9-a572-ef505ed51aaa@siemens.com>
 <20220407090607.GA20233@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220407090607.GA20233@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--32.049400-8.000000
X-TMASE-MatchedRID: AnkS0S6+UFoDMlIVqipPBYfom6lOnMHW9ckR9dcPDoLx5KZMlKYS/RXH
	Q3ZMOWk2JUnVf1l8eNdUkIVI/RHRUZ000U/rJkU2VOKdUBTzw78BmTlS9cosJhHJWwDGGGOsCqI
	E7aqEIgY1Z0DEBOIiJce9wJwZtc8QZRUjkVFROF7f1NaPaZcxZPP3RSAOdjDs3zen1b+Th8odX5
	RGQhYd7iIHc2T938o/AMJcHOzzDuM/wTQ33io10KvBA2ZMpJwcVoMi1N1nGG2OtWfhyZ77DnRkf
	QtLSKiPXvSWyok2Zx6G25LVQH++69x84w2g38c4tGnq9cM87zufyRP3jjLl9x3IeIGfKJW/twqm
	BYuNEYoM74Nf6tTB9of5DJGNGiouK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063W
	h9WVqgmWCfbzydb0gzhYgVA8TZw6No+PRbWqfRJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--32.049400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3892D96565B873E97EDDC585D04ACFC083E4EE154C7948C32E5274C61EF7408D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3343d40-347c-4005-234c-08da1d2dba30
X-MS-TrafficTypeDiagnostic: PRAPR10MB5225:EE_
X-Microsoft-Antispam-PRVS: 
	<PRAPR10MB522527F52C8D3D836D04EF6C95EC9@PRAPR10MB5225.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R6I3EU2KB89YTFgty0sG/iNqYTtShFep4T2dF0PnWPuG8G25cq6k0YsaJrhWovmwskSVEanr2qjuNK58KDD3IQ80bfgGx6WMq9aA/eVoR/UY1Xr/HotzbB9AC2d9+ry/WM/GDMWJL9/07xaM9am9bI0ig99qxk68JfemkQ8YpuF9yKDy8HkEA+VUPg1m+0Uj+osdWM2hmVuR8lXaifWY+zE2ESRxAzEx+aWtjCIGcYIk7ebRpqMzIl1Qp/xS9ifNCP6EDmB6DhGuAr8oSL2tY51DyDJvbdmscdYv4wfm4VqM+JuZdeUpcRfRME2ESslou+guPH1TL6lhH0VE/53vUs9z45G73zL6StCPkZeFO+B0ShqWhy12INn6MDhBPn5nD0VyUEYG891NbKwZ1Z0nEztmRn10vSYrUUD0mjnXYgcF2LwrHk3Gdya+PGuUEmgGeBriwS5eI0aiWp69EAEzAhkQSmIcAjSj3Y6YBwFtX4X3b2hE3czxdSahMzjUw9c+tGnvRR/Dd978F7OKfxoODCa1BMvV9TfXVSSWUxdowjAxeS4Kb4ExR1S8sIYDnOb9GrxUS4YyqqVxoQzU0EKdTjZtI7tuyFgCe51550S+B3opZK4aXP0jAvpCUKuhnouzD0QnUVIHccr9CObK1zaf4ITnRk4UDNuU0TTlQxELoczcuguNV+xWPzVPSgXGqHtzF8+EVP9MGZQjekJXYca6cQSAKOQz9pCGWiK+iEQ9OU1mTq61/5rB0soxbUH9Oa/aRXk3NI/kqL37LwqktCTgKpzSEvWv0LzG/hHLPAGtLuRCdmL/fLVwpeMxR0cx1i3XB9VLpH95WxmRsHmd4OsZI70Nhk/9vOIDmaJXK8Pph3I=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(966005)(53546011)(81166007)(83380400001)(86362001)(26005)(47076005)(44832011)(2906002)(8936002)(5660300002)(31686004)(36756003)(36860700001)(16576012)(336012)(6706004)(356005)(110136005)(40460700003)(82310400005)(498600001)(16526019)(70206006)(70586007)(8676002)(186003)(82960400001)(2616005)(956004)(31696002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:12:26.0328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b3343d40-347c-4005-234c-08da1d2dba30
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5225
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8072

On 07.04.22 11:06, Pavel Machek wrote:
> Hi!
> 
>> Kindly be reminded to attend the weekly meeting through IRC to discuss
>> technical topics with CIP kernel today. Our channel is the following:
>>
>>     irc:irc.libera.chat:6667/cip
>>
>> The IRC meeting is scheduled to UTC (GMT) 13:00:
>>
>> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=4&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
>>
>> USWest    USEast    UK        DE        TW        JP
>> 06:00     09:00     14:00     15:00     21:00     22:00
>>
>> Last meeting minutes:
>> https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/03/cip.2022-03-17-13.00.log.html
> ...
>> IMPORTANT NOTE: I'm unfortunately not able to run the meeting myself 
>> today due to an appointment conflict (damn DST...). Could someone else 
>> from the kernel team take over again? Thanks in advance.
> 
> After DST shift, 13 UTC is not really great time for me, either. 12
> UTC would be better, 9 or 10 UTC would be even better. I don't propose
> shifting today's meeting, but should we talk about shift?
> 

Forgot to follow up on this:

Are there any concerns among our participants to move this by one hour
earlier?

If no, the next logical question would then be:

Stick with one hour earlier, or will this cause conflicts again on the
end of DST in Autumn?

Please raise you voice.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

