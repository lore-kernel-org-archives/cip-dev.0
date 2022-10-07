Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D7C433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 08:19:23 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.71])
 by mx.groups.io with SMTP id smtpd.web12.2146.1665130752140513087
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 01:19:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MfBRrRqX;
 spf=pass (domain: siemens.com, ip: 40.107.2.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYKZ9H7nPeqIqtyeWhffK0vOOqdHPtTQZg3M7H6M7nuhZf0sx1Oue0/jB7w9oWLfEmYC/G492hGIDqvVhRRdGbt5apgagQzD4wMVULfeB7mXXVsuNZ9AWzh0f0Ah07WC1KbSgOFMwZGYPc7mcScuoLeWCM33QiPK7wkyrskQJANVTl8v2yn/Z23srmE3jLkzO9RethX1Bv3UpYWVc/RzpY/xCb2e6ukdzp8EECRXiXaCsnr7+MCF7TNUorttB0NDUvVowFGPP+I47e66rAT29BFdHzw2pAGxF7pWA4x2/3EWbOSbgErD2sSS6puqbS1/CShRunJfOo+p02hNRXKQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTI2DvjGhhTlk8byv1rg4KmjpK2XcsxRaPpbqDCr9So=;
 b=MqNquPG9SKvc7GpJ9LRDr22W6xnyzAyL6dtsggN/uhZvI0ac3vpJdLvwha9GNmx0gj01GD4hNdezdqxd0CDD0FmThM8OTc84zjYjH35LqdR8kqCu7Cxvh82/ypdzAM/67k9AlgOWPivbpehdQfh0v98FRoacMrdgYuxvmKpdF8Z43Vvz9OEejvq70NHMRMFdfc15hECSfidr2aFih7XJiSpJ27D7m5D4fiYErloBr6ElkmHOyxl4yCkUeXP7IGr9x8w2xh0DducHAd0abV8KMr17kX+ZfwSgjnJM7GHbgrwqaufH1j0kfQHnJmlEzSxjnvzMIm5xpDNhNPON9r1TPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTI2DvjGhhTlk8byv1rg4KmjpK2XcsxRaPpbqDCr9So=;
 b=MfBRrRqXbOkrs1WnFX+Th7Sb+9NYTPfr7Z1nHHOY6X5/eyRppZXp58l5GzbG5aXTyjOygaPi1PaUYJ9j57qrbGuMEp8CaTLLhmO79Yp4YqW1E71qhkZOWor/8o5XZgHS2B4f05YIylaEfzr7Pc7D8P0Thqi7QZHWWpN9mS2y1yqF30UOPpCrrq1DUdO31kpswlvUIJvUcJdzSZPH3KOxZ+nN9fgAXwwgchskkIRQrMhH3zOdzcoD7QPq1wo1joPBqx3PvVOXPiaMWwnRtjUKE/wZlcChZrxoM/0q/Q4By8JrqF4mnl0K/8rjYfQeom4Vpeq7hHhDL4fnfU2RS01gHw==
Received: from FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::12)
 by AM0PR10MB3556.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 08:19:08 +0000
Received: from VE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:15:cafe::97) by FR0P281CA0007.outlook.office365.com
 (2603:10a6:d10:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.13 via Frontend
 Transport; Fri, 7 Oct 2022 08:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT031.mail.protection.outlook.com (10.152.2.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 08:19:08 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 10:19:06 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 10:19:06 +0200
Message-ID: <95aed7d4-b775-7273-9478-b0d9ca77938c@siemens.com>
Date: Fri, 7 Oct 2022 10:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: ldconfig segfault on RZ/Five was Re: Preparing isar-cip-core for
 RZ/Five
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>, cip-dev <cip-dev@lists.cip-project.org>
References: 
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
 <20221006220740.GA7670@duo.ucw.cz> <20221006223251.GB7670@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221006223251.GB7670@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.749100-8.000000
X-TMASE-MatchedRID: FSxjOqe5tUM5QaOxwNGfvo9bHfxDWoibL/tBTZzO5Q0sWKt1qrD4oYIX
	oaQH2H4PA1njkhEhkqCBKSUXG3panT4pF0eDRQgZPGiD7E7pfUe4gkDxrhjpU1xWWs3RUcVroIc
	Z8kDSGx0hnmSpmb/95ZVHMRn1pNBtK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063
	Wh9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrbMA+nEDAgRi9ojyOl88jTFcAiulW5TcNzZDx
	/3gcT/uYVcoKtebTuQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.749100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D488CA319A23EF9CA40551001FBFDD6E3726412A8DDF00DC9C597C938E95578E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT031:EE_|AM0PR10MB3556:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ac5fad-b9d7-4aec-f0a3-08daa83c9b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z7Mr616UNkeoDcCUh52Ro+L8k2YYApY3ErefrthwA0X810k6Z3xCSf1GI229UMMQSHhLirZ2QQOPo541oJycPobJhryvy9ZVCcNWqaTBmRzKEdwT7fWgjPQKYfoJccL0Y3LNg1S7E5VhbpQHMqOxeQ/+Ahhfm00ZCrs3AYDLbd+eCHMOZ7Y8KVSwon2uF0niZ9dquXHq/xN6MA+7kOJ/ASz6C/b41GO0jrQZ6uxIHsuswB/BMmym3AC9NhO9Ftoyz54FuZWYOP5BxfqMWr0X+r1TAcWzqAocrCDo1SV98VEoECCdnN3P6fqxR9SMKkGw5qtFKmmVdYwcBuw33fKv84SNnzolwAPPFDFOe8dSa/GOHD/VXk+A5mlbkDJIFoIpKsa70zMoM6zgvXbQWCSLp9zRNST4gGUemDIIKtdWUr8MIaO/6+hotvk7hEDjUET2xGEoHOXrsmhm+jrL3jNCH0WvKUt/RrBOmH0h1FwjmK3MGFS3yO2XilchU04DI8iNbGRtt3kLZLOhfNL5xLqTpBtLMqwr81dgs5ruQL9T+7yCLfZB/iizU8gy3b+ZXll02watp6uau8DbEr3QUWNHM6DV+DZoCjMEppQ8H7X815BhF9lcROAgktKg3hBqUpK56icmvOd6hYvNjF5OpCYWXZJFBL1FSjzJaZKay1KU3yKIxH/5e3SAkQlTCZccIr93dHt0IuT7OeNCKs77ADbwK+vWTHOLlOEvhVb3T3dKCZ78K+yS2NTgCJ9vArtAvHr5n1n9PCgNcnpYb8VpDwyCeyGYCk0cRhExWgx25WyeegZTDg+kVUxUuEPlOJDXTPvQahTJO0VlJx/1Rn48dk7P10bPd/hfN14+GeouRwZx2CI=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(81166007)(2906002)(31686004)(44832011)(356005)(82740400003)(82960400001)(40460700003)(41300700001)(5660300002)(8936002)(36756003)(16576012)(70206006)(8676002)(70586007)(186003)(36860700001)(4326008)(6916009)(336012)(47076005)(478600001)(54906003)(82310400005)(6706004)(16526019)(53546011)(40480700001)(86362001)(316002)(956004)(26005)(2616005)(31696002)(6666004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 08:19:08.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 00ac5fad-b9d7-4aec-f0a3-08daa83c9b92
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3556
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 08:19:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9669

On 07.10.22 00:32, Pavel Machek wrote:
> Hi!
> 
>>> I tried, but installation fails - illegal instruction.
>>
>> Yeah, ldconfig is needed for installation. But I get a segfaulting gcc
>> binary.
> 
> It crashes rather soon after startup, so I was able to trace complete
> path.
> 
>> But I do have slightly different results then you (I think; I'm far
>> from risc-v expert). I did a breakpoint:
>>
>> Breakpoint 1, 0x00000000000385d4 in ?? ()
> 
> I believe it should not end at 0x00000000000385d4 at all. The
> 0x000000000001537e jal instruction should end up calling 0x3806a
> AFAICT, but it calls 0x385d4 instead. It happens during
> single-stepping, so it should not be anything subtle.
> 
> (gdb) disassemble $pc,+0x20
> Dump of assembler code from 0x1537c to 0x1539c:
> => 0x000000000001537c:  mv      a0,a4
>    0x000000000001537e:  jal     ra,0x3806a
>    0x0000000000015382:  auipc   a5,0x8a
>    0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
>    0x000000000001538a:  ld      a4,0(a5)
>    0x000000000001538c:  beqz    a4,0x153f0
>    0x000000000001538e:  jal     ra,0x38abe
>    0x0000000000015392:  ld      a0,0(s6)
>    0x0000000000015396:  auipc   s7,0x85
>    0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
> End of assembler dump.
> (gdb)
> (gdb) stepi
> 0x000000000001537e in ?? ()
> (gdb)
> 
> Program received signal SIGILL, Illegal instruction.
> 0x00000000000385d4 in ?? ()
> (gdb)
> 
> Best regards,
> 								Pavel

Did you try to compare the call trace to QEMU, where we divert?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


