Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6975FC4332F
	for <webhook@archiver.kernel.org>; Thu, 13 Oct 2022 05:30:00 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.45])
 by mx.groups.io with SMTP id smtpd.web12.4159.1665638996129498227
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 22:29:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ItqxxY7G;
 spf=pass (domain: siemens.com, ip: 40.107.8.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj7n+Mla+2FIyVj6/8bM0BAs8Exd7X03KBavaHOeWToxKDRF9ucTURU36UodOjxf4o0B8BhryukE+OkkbD+9dyxcdVYTEFEtk8TNEzt9B8ze69OYAa83ADmTjzoG5E4AnNzuH+x6mN29DvmuO5Z0NLJUlTrweWoILJNpyMkM6M+oR4pYECCWz1FB08anKXDKn3aKxd8gYrxY8/7fSJYVTD0sONU0RseDbhWH26uX/LAsiaK05jPHqUdAJNntz5lcJ8PRaKo7/hdIkfXEDdQaLLOfCkJTSvTAUM3aQJj4QuEwIFWRJ14+U26aGBHXbqsZaNqVVAF3qcgi3Gs4OBJpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7qGMbfg7tEe16LmrEWx+NUcd6ofqwn7TNIUvy3FOHw=;
 b=l7SfuxZMzuM3rZMd6jufgcxySjNs51B2UXygX/WXN99j/ACE4vKEr5eCoJBunUr1tequ6nb8ynoyD5Z+uOLay+b41AOv083E1jkqVOTj7sVzGpLxVjQj/juLmP331whBzPQ30Tp0Sv2buQk43+WWNDRZ6uuEi+oxA/2BrFFrDrRfcf5EKIAfGWaA9bZRKG35CSmZayKsXNMdVrFlO+gNZAQJ4litz6nKA29eCN7p15gH0AoHDR12jumAq6zvTIA0qZMqG0ldYbsx4Wzd3BZzf+QB13z7dnbIJ4Rr5MrqVqNoRXpUhbDf9aw8GBDnltP1DaiWY2JJ92Kx3ftVYGuCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7qGMbfg7tEe16LmrEWx+NUcd6ofqwn7TNIUvy3FOHw=;
 b=ItqxxY7GFu2JeUaam6iF6dQR0uYGRX9tpBDhXDoXIe4kDhkIEBQBlrpnCDDNoqGxQchHfAsNdo+eVxpiB5To/J9VmU8xyZPx9hwxeOoxEzzCjoqSHIbYgxhPNMOGitmevkcLwTJcLwQgKrR8SVPbwJp0MM030jKzD6cuntZMjbMh2cL5DHxJTZAXxrGH1/S3BSa4TF8mJopgvToB8jEWVKDjoxOXPEEIccZ+qAI9srMz+5w9m/FQLZ15Msdc/Z2px30mMy11+tuTx1r1WyECIWG2/lg/1TH59onLVceZwMDnOthW8LZH06UfMlX7jrlLgGn+iwFES9rr4FviSFue3Q==
Received: from DB6PR07CA0157.eurprd07.prod.outlook.com (2603:10a6:6:43::11) by
 GV1PR10MB6026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Thu, 13 Oct 2022 05:29:52 +0000
Received: from DB5EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::8d) by DB6PR07CA0157.outlook.office365.com
 (2603:10a6:6:43::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6 via Frontend
 Transport; Thu, 13 Oct 2022 05:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT059.mail.protection.outlook.com (10.152.4.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 05:29:52 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 13 Oct 2022 07:29:51 +0200
Received: from [167.87.51.246] (167.87.51.246) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 13 Oct 2022 07:29:51 +0200
Message-ID: <50102871-dc37-735d-9627-d17d0cfecff2@siemens.com>
Date: Thu, 13 Oct 2022 07:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Troubleshooting missing lore messages
Content-Language: en-US
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	<cip-dev@lists.cip-project.org>
References: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
 <20221012175240.c4bek2kewebfykae@meerkat.local>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221012175240.c4bek2kewebfykae@meerkat.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.51.246]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--25.159600-8.000000
X-TMASE-MatchedRID: irl7E//xM945QaOxwNGfvo9bHfxDWoibW6eKzKKCgnNswYo64ufkVRlK
	jo8zguyK0HzpRBx3TOPlA7g/sXkwnEWdn3bz0r+CcWOYAHU7QJQOSgCuU6WnaXTzPL3sqyAmAPi
	R4btCEebunV8bk7umYiZKRIFpXA+BKUkPazQdQqJelZ4vWjCl2qJ7FHB/koSEC4s/hE51YdVWii
	lUG+b2zT+B/tp8itBTNwZbS5KD+xSGFjTbFLhtjymqOJk2EKACfofCvt/VZMIaLqFbxdotGXh8J
	8VFDfTIH82viJ3EvH8RZcCYVXElTumAnh4TvJGJ1zdrdsb97pJeUmqJNf32Qm5eAiqrqZDK9FT7
	09M8dJin7m/OxjmYo/D+6IQMRxU54vM1YF6AJbZFi+KwZZttL7eQq6mF2S4/seWplitmp0j6C0e
	Ps7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.159600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 09905C81AE5F796BF85C56ABE55DC746D0D777236C606210E481903F7D140A132000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT059:EE_|GV1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff8c13f-862c-4e0b-a0ff-08daacdbf48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	p1GO0T+mF+8T0rAIRLfvHg6zCTecFlsSK9s+7qn/V8Vx9PMOOvL36aeBbNDGAh6FkL4rTaiW05yom2eOnl0/ujRlsp9CWUy8lZmsnDoFPfCkfOEEJfHS17QCUUpxHaeDxaWNFHeIAL5bjWqgkcovJGFpGXRME09zMtdYe7Q8NvmPD4hQJYL39VRgW4EEFh6R0NKKrKe5wnLZXmB/IE7boJzf5E/wgsjQzwpd98euY+Ig2/8z+CQ+DzE4jkDCxQSETSdBdZ8jMoerXECD1eExztDxY86udNaEq+2tk7wo2ReV0QHQECr6PwWepU7lQtNT2pi+ZZis+W+tixCri6JUZgrHHQReHzUs6iELDPt9hbxTq08bVuEMpfBXZLo+LazEn26NWK8PX40Z90OCWPjnst4SUwcfvKMFOMYv+pw3J5NrMtxcQhDJ1tOmFYhnSfZ3KdEyXS1/wcuThNjSHof1d8ugJbVsGBpTR6Y5J+MRbUTqQyPiGOVm8TO/7QJ0qOEbwdYmXTD50baMNun7scNbwQE6aFzi1MWGNkMN5tFhIlmD+p8PxboD/z+Y7W+Zo4YWRFJkVOvWEfymAHBWOt0RHGZsJXuAAmDhk8VAY59CYe5v/volqqjpnjy4AI+qSSzrN3IYFHvcktIfyiE4EQR/tj5khKgcaxrEGws3YcQKYUupGsUahltQ5kIgW6y/tcAVKk1LKEuD3cDTTdkt2P3aAta1L+S7DVkDNVeuzDHe6cNNQQlDgTrpDlUHekK4jVKHComMFo5v/bTr4FqD39BjYmJj9T59nheZANazgZoJfa8JY3FrfhM/KVZltW7GDG9DSO6xrHbYIaSFprf+rTyoAw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(7636003)(7596003)(356005)(110136005)(16576012)(316002)(478600001)(31686004)(82960400001)(82740400003)(6706004)(186003)(16526019)(336012)(70586007)(70206006)(6666004)(8676002)(3480700007)(5660300002)(26005)(31696002)(53546011)(41300700001)(8936002)(40480700001)(36756003)(44832011)(36860700001)(83380400001)(40460700003)(15650500001)(956004)(2616005)(2906002)(86362001)(47076005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 05:29:52.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff8c13f-862c-4e0b-a0ff-08daacdbf48f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Oct 2022 05:30:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9749

On 12.10.22 19:52, Konstantin Ryabitsev wrote:
> On Tue, Oct 11, 2022 at 05:09:11PM -0400, Konstantin Ryabitsev wrote:
>> Hi, all:
>>
>> I am aware of the problem with occasional missing message on the
>> lore.kernel.org archive. Due to the way groups.io operates, the messages are
>> actually delivered via the web hook (otherwise groups.io mangles DKIM and,
>> occasionally, patch content).
>>
>> In order to troubleshoot the problem, I've added a lot of debugging calls and
>> side-dumping of incoming messages, and I'm basically going to use this thread
>> to spam the list with some messages that let me make sure that everything is
>> working as intended. Once that is done, I'll wait for the actual 500-error
>> message to arrive, so I can narrow down what is actually happening.
> 
> Okay, we've identified a few issues already (like groups.io not redelivering
> messages on a 500-error), and I've re-fed all missing messages from the
> archive so there should no longer be any gaps on lore.kernel.org. This will be
> my last test message, but it's possible that we're still missing some fixes.
> 
> If you notice future missing messages from the lore.kernel.org archive, please
> alert us via helpdesk@kernel.org.
> 

Thanks a lot for your support, Konstantin!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


