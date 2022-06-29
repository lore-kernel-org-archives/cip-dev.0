Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F1C433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Jun 2022 17:03:55 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web11.14104.1656522229933133272
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jun 2022 10:03:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AK9fvVXT;
 spf=pass (domain: siemens.com, ip: 40.107.20.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfUoj+t1HatkGLOo7K1y1lUYasU/daRXFR1E5RpxKCbNx/q+8c+F9D6tn2vmsOzneBwPqFtoYI1asewEa0IhHjzfiBS3SUK2Ltc1ZEtpgmbQ8iRhhDnJs4jAxjM9KpSIe877XXj0zryAwhTN3vywR1M22IL2N+9eVwYcDXTs3dXhRgH4mOnbilE3hOOstus5gk0PJIXRkpcVfvYn15mDcBxXPn6ks6Ic5QVbYoB9NayFi/6tKjW9Uup54H0rB72PJBtmbM6X8IWX/PqmyuGikdguKk1wi0U9RWKqC6M2A9A3x3yc+ATeqa9moGppRDvZ/+t9uoZuRH2bYMBXrgirIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+nxjl+VH/TUfCgYKfYDgFPhT95DM9r4oIzgj687ulA=;
 b=Z29AgCepvzazAlj8IrXDnRAWgIcMaK4cARMDtyJ2KRi0xeq4gTZPoPObcaBiNbN3DVbhohI8KuJg7PdMcwtbYPj1K4PYsLs2hC2ww2vv1CXcn84vU2ne7WZQZPbHU7zJm9oxnxVYWPTGiN5lEjxp6bem1Oiguxn805ofqcZPcplagAHqdua1z1U2IliVrbytBKYkNG7Zf+bTuEyOSPA8cY4gFobRTBUi7RoQqMLN3Q65yyiuZuCNO9VVkYmrnKx/tgY7+0c6aqouX9B8id03FAi0aF5M+SmjZyiiGfrQQ5bLD8NCs4dUo7IkypWpPZz9yI7GAhxFjMeg+REfbmZsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+nxjl+VH/TUfCgYKfYDgFPhT95DM9r4oIzgj687ulA=;
 b=AK9fvVXTz7dpNCB/bXAb21DCx6HntcaBD48QZtxHvIR6n2nYTcpcRzHuRtmC3M1Vr3JcR1+qRx2kBUnbAncswaHzo5vosDHBlv950yCtFTqOBOhzZ1QNTkgVUDCEcVrC930JFko4wzeqkG6KVjWd39YwRUgHCdzZZ+W7qqMrKbiHNqlq5M84FvhI/IHsDHANPcrorBUxhmJesnYTOBvltwTFwHlO27mCDNFkVDbfSmg5dLiNfzb3tT6+bTLGwH4JKXZ6RYIGQSgPuYVuWhQYp0n0W1pNqH9EZnB96J6ZZ1Y7SkGCLyt45LvayP2I0swcT9ue2F6pLx4EaeJiw+sM8A==
Received: from AM6P191CA0067.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::44)
 by AM7PR10MB3592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 17:03:46 +0000
Received: from VE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::a8) by AM6P191CA0067.outlook.office365.com
 (2603:10a6:209:7f::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 17:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT037.mail.protection.outlook.com (10.152.3.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 17:03:46 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 29 Jun 2022 19:03:46 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Wed, 29 Jun
 2022 19:03:45 +0200
Message-ID: <529de450-0253-0072-01ae-bf8b2df9f454@siemens.com>
Date: Wed, 29 Jun 2022 19:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [ANNOUNCE] Release v4.19.249-cip76 and v5.10.125-cip10
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>,
	<masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
References: 
 <TYWPR01MB9420A4CEE36E4B536184CBA992B89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <20220629154518.GA32481@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220629154518.GA32481@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.150300-8.000000
X-TMASE-MatchedRID: FSxjOqe5tUM5QaOxwNGfvo9bHfxDWoib9K9H/7vO+WGdVNZaI2n6/wEP
	JrYlsf/6Y4zJvUjGrxU47ZUjoCwI8hukv7bSdnumSnqWaNSp56yio/mbsX1aFCX+a5eEMES4vvk
	zqYJBDFZHrX2E2MkfRIVg+E7Q3H80K+fbv4M7+TC1M6vEQZCbhkkjllSXrjtQOX/V8P8ail2cIZ
	LVZAQa0IwZVlv5NpEAUEhWy9W70AEgBwKKRHe+r1a0SUcJoIL/GzGNgljJU+Rj2gLhzDXOpWfoI
	PBEhmnLf7HtnKqJ2vo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.150300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 8BD9566781234A0084C9F6A87F1BE565DFC2A77EC27A040C21D1AC12840457382000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873abf2d-cb3c-4fb2-0031-08da59f15474
X-MS-TrafficTypeDiagnostic: AM7PR10MB3592:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SFdQYTUwd2ZEckNMZHpzRTF4czVIVkhzMlZlUG9Lb0NJN3VYNmRvWjF5b1Iv?=
 =?utf-8?B?THhyckFJRThyYzJJMGhxOVVUbmhHTXVHczBLbEVHT1QrNktPUW1JQzRJUlJj?=
 =?utf-8?B?Z3NQdVROZ3ZtaVlUOEMvdmkxa0dWYXptYmxSd2F1UTlRUFkrMmt4UjRaN1lU?=
 =?utf-8?B?eXBobW9ET2FpUEhxYnRiek9zdEpObHFLa0QzV0paNkhKaW5vMTlkTTRpQVpx?=
 =?utf-8?B?V29PVUgvRlhab2VDWE5YczViRXcxK1hWZXRWUkljYmpBbkxMQ3hxOStCRjY1?=
 =?utf-8?B?dm5aUFRrcWVqd0I1ZHJhek1jUGx2U1RpTWd5NmQwaWR3NXMyRFhFN2kwUFNZ?=
 =?utf-8?B?R1dhdGlTa2xUYnpWcGpQRk5sWDNOZFl2QVFHN1liNWpiU2NSa01Fa2ROT1Qy?=
 =?utf-8?B?T2gyNEVtdUM2ZWxEQkRTRUNITlRwaXV3V0h0VEl5bnNabWE0amU2ZTFiUWxU?=
 =?utf-8?B?cStXZGhlWTlnTUhkZURTOTZJZExTMTlXbEgwdU12TDBQaVNpT2ZoYkk0QmxQ?=
 =?utf-8?B?eEN5eFcrZ2dJYm95eWhvZ1ZZSDZMQ0JqdHlKeG1ha2t6Nm9UUVdncDdJOUxa?=
 =?utf-8?B?K29tRDA1ZmNUTEVjNG14Yndmc2tCOW13TnZzbWxQajZMKy9Td1RISlZJeHRi?=
 =?utf-8?B?WUpZeS9ETkE3clByS1d2RHBzSlk1LzhHTGh4QjlQZFdKM2JDQTlIMmFFd21j?=
 =?utf-8?B?NXpoTXB0L050VEJlMEdaZXFMb3I4L3JTSGRkUm9Jc2g0cHVoRTVmSXQ5bkcx?=
 =?utf-8?B?bjM0VHJXRHRZdGxpNkNoTXp3MnVnRkp4RXhCbHhPU2ZpaXI5ZUp6UEdMcTFX?=
 =?utf-8?B?dUVoOXJxSUpLTmd2WCs5TzVRM0lzUmQ4UkY3THh6eE9BdHQ0VUM3MHdNTUVK?=
 =?utf-8?B?MEQyUEtLY3d5TG9PQUZOaVpNNVFaU0UwbnZJQk91MllZYnRuYURmdk9seVJ5?=
 =?utf-8?B?SHVUMjVFdnZlY3ZQaTVSakNCaFhpUDhJUmYwaVN6UVRITWdCWXpZN3MvWEF3?=
 =?utf-8?B?M2RrN3FweEZLemhPWVBhTnpOSk9OVDBFZSsvVHp1NDZoSXFGYjk5dHd1c2tq?=
 =?utf-8?B?TE9ZU3lST1JEaXEvRU9TMi95cHB5WTd6VGNCVEg5QWVaY2NXZDVweTkrMVhu?=
 =?utf-8?B?Qm1hVkVNRnVEOGZOd2pMUGw1U2d5NjVBTUlJVmpiVUdKd3p1T2ZuN0dYbFFU?=
 =?utf-8?B?N1BMUk1sbE90dnZoaHhhTHVYb3RXTG1ISlZNRncxTS9vN0ZlTi9haWVEMm12?=
 =?utf-8?B?bUgwRExNMXovYnhYQTRCTG03NHZNMUtJOXpueXZCVE5jQ0dUQT09?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(40470700004)(36840700001)(46966006)(70206006)(82740400003)(81166007)(4326008)(8676002)(8936002)(956004)(2616005)(53546011)(356005)(70586007)(82960400001)(26005)(5660300002)(82310400005)(31686004)(36756003)(86362001)(40460700003)(40480700001)(31696002)(966005)(36860700001)(2906002)(83380400001)(186003)(47076005)(44832011)(336012)(16526019)(4744005)(110136005)(478600001)(6706004)(16576012)(54906003)(316002)(41300700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 17:03:46.4706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 873abf2d-cb3c-4fb2-0031-08da59f15474
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jun 2022 17:03:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8626

On 29.06.22 17:45, Pavel Machek wrote:
> Hi!
> 
>>   v5.10.125-cip10:
>>     repository:
>>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> 
> 5.10.125 was immediately followed up by 5.10.126 due to bug in
> io_uring. If you use that functionality, you may want to speak up.
> 

Given that this feature is default-on in kernels, is rather easily
accessible and may create "funny" results in the presence of this
regression (of 5.10.125), it feels like we should follow that update.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

