Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C85C433F5
	for <webhook@archiver.kernel.org>; Sun,  6 Feb 2022 18:47:49 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.86])
 by mx.groups.io with SMTP id smtpd.web11.12061.1644173267711835827
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Feb 2022 10:47:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dxw/nEOf;
 spf=pass (domain: siemens.com, ip: 40.107.6.86,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHmVde+Ju15OM+XOWFTnwdYMv0YJFL0KGaSSNtzHMb06QPHUDzXj4Oj6FEAoZdbaoZ5xkhQzZuTabn4PLNaYoJwxE6S8suNhjKeW1ev0O9jO7faHm/3lvK/BDBuPazh8rNNwUciW13jfRScOpQBBc1ckR9Dro3IcZIEQy8lzMewQTxq8wxYRUzaZJoSxaHCl/UlLbOlJwJGHej+o+d7wRwzNErW9w7vkmF5UCdO79xa9zlgansH3nMThdVlmfAnd/zc4N2eja3W6K6275NimIgoEFA+Ee9NojroEVHPIdqaQDWvIvOwFDe0bYdZrRtaC/7ECDDAtOj2VnpP+0qJWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2bOEb83zBOJu897jq+HE+CoF1+8f537JvxconCA8V0=;
 b=k/bMqLNJwgBL+NS3HLyuYYgCJV61VI8APdSvZsjHIEAPfmcF5dmC3MXl8BM97D2ARSwxbaQprwgO4EMgDjwyUYYEMq0pJYI22TGGH82fqfTQi9igbX8pQiSomZqnxQ48kOeMikxkvwsl4uErMcTMVbjsAcB151OLi2op0lktv6pU9L7m9zMNFne53sWjzsnw7P0UfDADyGP+WpN1o9leDxnxE08RAq7WSmjkzURR2Ut7QYsb3+FUhoHwfW0CPdkL9ptnXaDdTnf1x9Ee3QmO1zMhVb4ih7NA15J8ZrBsIOdT4zoRsTcd1kCEl9iB6h7AAqx8/cyrAXrtZ9QJZ3iIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=toshiba.co.jp smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2bOEb83zBOJu897jq+HE+CoF1+8f537JvxconCA8V0=;
 b=dxw/nEOfestlnxuXD7bur39qkBnDISebgOcMRMOurtkOuKndrqBNbwg200UzsXVc8UwndU5X71v/84YOWExV+lUWn8xG8/mmek2NlU9qi4MqRwf0s+cV2rLiNU10TpajV7sIzpCRSSTdl8ePVA5CiU5TluozmaFS51eYK9YfcRVn7Mdl834RQBr3uU7iI858xdJpITiGaAQJNLw9+qilm7bcGrl606c0WuxiZD8H31SCmAEiTTbVx6Y31hM12DydRDmafIFKalH8fQHNUuaRiGIAkMewMDv7xNf3CDpqmAwiTlPAvUNdbacWYFGlmntrXO6DoMP1/RIG+eGmEb/4PA==
Received: from DB6PR0301CA0023.eurprd03.prod.outlook.com (2603:10a6:4:3e::33)
 by DB9PR10MB4761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 18:47:44 +0000
Received: from DB5EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::2b) by DB6PR0301CA0023.outlook.office365.com
 (2603:10a6:4:3e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Sun, 6 Feb 2022 18:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT046.mail.protection.outlook.com (10.152.5.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sun, 6 Feb 2022 18:47:43 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sun, 6 Feb 2022 19:47:43 +0100
Received: from [139.22.137.203] (139.22.137.203) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sun, 6 Feb 2022 19:47:42 +0100
Message-ID: <1ac8ef07-4bba-71ef-83da-524c1a717be0@siemens.com>
Date: Sun, 6 Feb 2022 19:47:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev] 4.4.302 is going to be last 4.4 release
Content-Language: en-US
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>,
	"Pavel Machek" <pavel@denx.de>
References: <20220201213254.GA3001@duo.ucw.cz>
 <TYAPR01MB625279122E073EFF486368C392289@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <TYAPR01MB625279122E073EFF486368C392289@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.203]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6233c3d-6cc2-4ba5-ad24-08d9e9a12928
X-MS-TrafficTypeDiagnostic: DB9PR10MB4761:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB476185CB9C3D53242041BC5A952B9@DB9PR10MB4761.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e+mNakvMEbEo/aiT/Oe++8U356bKDankz+LSpOjDLA2x38pQf2dTbSqz/u75Ea4ALEEmw/Fov8CGZZ8t+mjIelOhhqDVIA698B1/HbnXffVugrBCcLr/8GFDQBhPwKPpz+GO/IDPMy2sKLMoWIijV5vM9fe52urhANEeQtWUXR0ffoHOCFLARk0g3dKd2VkL6iehHD/zkovpDJJWomyP/RXz9Z/4Nf9twB9lzWFqZm+ebbTzRHPxUXBpu1Y6QUl+v6NeZiPNkd0banb928XxQePWa4gtbAL766Hg1UK3bdWRTLLl+HW9xmcjSi1IkKuubgwPwQC3dJ7kn12MCktHdmoZxJ8N/Ptf4g928XHpP/pC0L98II96up5jUZwQFFsTZJ3Dxna0ROXs/aTfZCJp+d5zuIgFPgl2PS2eUnkMs2kYC0bYuFIuJmrVMVyYHz8ojHlKTSBbYzyvJ0+RNPgXmS1THbv+0/wa1d0nAAOUwtR9mA/B6A6dlv14c3u4zBxbKl8fyVsWgzZO+tq4SJxUH4izKqDKvrVzHwE2BwLAFh2/p0JdBkRScpHwwH0birBqJWjKi86uT763gcN0u65RBe0SrLcEe3mq/VE03rfK+OoA6WB1UTtq9264+9Q1mwcEaXXsdobCtEQLFkqqdYKQrpnqABLiKsvO8ExnHfriN37x8wrXIWZNr2atN/5cGi7qY7ZcOnWskZVSUafWNNWCGRRWd0zMpI0+08cH9FhbYTcx2/Dp/uVcvRwyVGIfG+Ajbw2qxTDg+4qtaOufrILt1ezxWf4u97bzvd5+o2J0f2w+yHapcrSEH2nPJ6YlXXb0fBFgsGNu5wYWLqMQWBX5Vmk0asi7mOXHuMyDrUyysLg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(316002)(82310400004)(6706004)(966005)(81166007)(82960400001)(40460700003)(16576012)(110136005)(86362001)(44832011)(5660300002)(356005)(31696002)(956004)(31686004)(36756003)(8676002)(8936002)(70586007)(70206006)(53546011)(83380400001)(36860700001)(26005)(186003)(2616005)(16526019)(336012)(47076005)(508600001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 18:47:43.8392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e6233c3d-6cc2-4ba5-ad24-08d9e9a12928
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4761
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 06 Feb 2022 18:47:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7576

On 03.02.22 08:13, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Pavel,
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Pavel Machek
>> Sent: Wednesday, February 2, 2022 6:33 AM
>> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
>> Subject: [cip-dev] 4.4.302 is going to be last 4.4 release
>>
>> Hi!
>>
>> Greg says:
>>
>> # Message-Id: <20220201180822.148370751@linuxfoundation.org>
>> # Subject: [PATCH 4.4 00/25] 4.4.302-rc1 review # ...
>> # NOTE!  This is the proposed LAST 4.4.y kernel release to happen under # the
>> rules of the normal stable kernel releases.  After this one, it will # be marked
>> End-Of-Life as it has been 6 years and you really should know # better by now
>> and have moved to a newer kernel tree.  After this one, no # more security fixes
>> will be backported and you will end up with an # insecure system over time.
>> # ...
>> # Responses should be made by Thu, 03 Feb 2022 18:08:10 +0000.
>> # Anything received after that time might be too late.
>>
>> (He sometimes releases kernels before the deadline).
>>
>> We may want to make any announcements now or just after 4.4.302 is
>> released... so I guess we should start working on suitable wording.
>>
>> Something like:
>>
>> CIP project is committed to maintain 4.4.x kernel till January of 2027 [1]. We are
>> maintaining -cip branch [2], that is stable kernel with about
>> 1000 of patches to support our reference hardware [3] and -cip-rt branch, with
>> is merge of -rt and -cip trees.
>>
>> If you for some reason need 4.4.x with bug and security fixes, and are running
>> similar hardware to our reference hardware (x86-64 and armv7), -cip tree may
>> be good base for that work. Testing of the -cip tree is welcome, as is joining the
>> CIP project.
>>
>> [1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
>> [2]
>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linu
>> x-4.4.y-cip-rt
>> [3]
>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/ciprefe
>> rencehardware
> 
> Thank you for taking up the issue. I think the content is fine.

Looks good to me as well.

Given that 4.4 is now history and Greg even mentioned CIP in his
discontinuation message [1] but said that we would only "consider" to
continue: Let's follow up on his post, only referring to the regular
linux-4.4.y-cip for now. Who of you two could do that?

> BTW, do you have any future information about the RT kernel team?
> We may also need to check the RT patch.
> If you don't have the information, I'll ask the RT team about this.
> 

Why should 4.4-rt continue if its former upstream retired?

Jan

[1] https://lkml.org/lkml/2022/2/3/91

-- 
Siemens AG, Technology
Competence Center Embedded Linux

