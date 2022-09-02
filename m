Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A7C54EE9
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 14:47:20 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.82])
 by mx.groups.io with SMTP id smtpd.web11.7438.1662130036308860765
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 07:47:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u5kxZ+5M;
 spf=pass (domain: siemens.com, ip: 40.107.22.82,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq09O8YHt1+XE3p4uwUW/MTG8kFAhBfNJESupQhR4qridVlgxTrS3/VcxHXnUw7rCHMPQH7cNTqOSzYTxtcQCQXtdHFiICR78zPJkCpsIqtSQ50C2XDIU2pGYtC7rB32ElsskaT3KBH8dURvWYyuyoE4RACwFuoOJriwnlBySxn5lG2sDDi+c80VVvDACHkXXfw/jDQPqXEn6ubKb56FMuSX9apQBbDgA/yLUTvM6X9aj3VrE6qsi6KeBx31zpdBcvgEtlWVA7FRPKIzBk9nFq9pZa/Kg97+Hi7zL/x34XxNRO5MW3qOHP7etSnCPmOTdahg1h61GJVtAA3YvfQh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62Z48Q4EAhMT4RjTSx+0Re3RezWkt8R2IXmUdm2P0yk=;
 b=G4TFT2w5CgQtbISY2X/PNMKTycQJvH8HdIKAo9HMF5l/zEhhIRokqGuBXwyJdrdok4JPkKAxjeDCkUvFr4uRJakFE7ze6YYzr81fJ5JayZAVXvmLNqEZ+5wOju/cu9LfSQ3gr4FW96kLteTWZ/TXAXZIVNxQtgB7VCKPicqiSo8p09N02bR4yCQCIEG2Rem0Rdodjzupr6psciEf1IEpKqzys7Dzx0+So4TPo1MBKG/BBzS8vgVEOwZBfSR5DBCGwV4cQAjKp8r096xuzD/yl2pDM3BnOh8lKBZp7yPmLSzyKOgGJIYYxp/YJ/CcCLzoo1Gi9aBYwbltS4GAVljruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62Z48Q4EAhMT4RjTSx+0Re3RezWkt8R2IXmUdm2P0yk=;
 b=u5kxZ+5MTQmBhZCNsBbzd8ur+4lhylcNjB3Dzoq7fb36WGrSKRydujLb5jN6P/j5dXCEgRb/PHf96tnTWFnMIcOQqgAohXt5JQ0LYXb0fO3kL4QLBK/ucCihv38rR4VuXdTsesoyVGCM3GP36G/llpmSVn7VW8Bdquouv/MMI4LoqE9R+UguMShXQVQi/Os4k0pzGNIF19EG5OR7Z0r10L/RGQuQ4OZ+K3mDy/Hm+cvZOEdur4RbtDtRPTwSdKgdJNAYNMJYSC43b1Ok+wjPgoknG73qOGA4gAu+EXCpbHSwCCqY2A/1snm5XoIhVe79abZggaXxRdoPHl6lZX3diA==
Received: from FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::12)
 by AS4PR10MB5223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 14:47:13 +0000
Received: from VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1c:cafe::7a) by FR3P281CA0033.outlook.office365.com
 (2603:10a6:d10:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Fri, 2 Sep 2022 14:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT060.mail.protection.outlook.com (10.152.3.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Fri, 2 Sep 2022 14:47:12 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 2 Sep 2022 16:47:12 +0200
Received: from [167.87.15.236] (167.87.15.236) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 2 Sep 2022 16:47:11 +0200
Message-ID: <19ae27fc-592e-e3a7-09ce-c258e2e42970@siemens.com>
Date: Fri, 2 Sep 2022 16:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Realtime support for 5.10 on RISC-V -- not there
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, <chris.paterson2@renesas.com>,
	<cip-dev@lists.cip-project.org>
References: <20220902095754.GA18026@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220902095754.GA18026@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.15.236]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.261400-8.000000
X-TMASE-MatchedRID: rRgX50UcFf7PhQMrvkSA3i87ok1axQd4c2zotcYu6/jx5KZMlKYS/fio
	Isi7Sa0gbDD7i2QfyEf47Xv617HbRyRbF/fU7LsUhSunsgDtnFYHdTtg0iNZI4IK2tjTqNotxYt
	6Ilbxn6nURn+XOe/hRbNSrREeq4umIFQ3w3Zkqyzxk5wM/pTh1vfuVpATnjcHdJwJSs8rAzmIWG
	vfT9ZpjE6yr+fYrPb07DWCYCEbYYDp6MBi+MH1la9iVfvGLbGiQqHw3tJ7i05uXgIqq6mQyvRU+
	9PTPHSYp+5vzsY5mKPw/uiEDEcVOeLzNWBegCW2RYvisGWbbS+3kKuphdkuP90H8LFZNFG7bkV4
	e2xSge6CTte5yrOoBl7sp3Z1r8VLdIM/6kvDhTYUe3mWK6ZUq0sMHBii02BH
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.261400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 E31CC93C83743FBCF0BE04F5F9D9A374F895A8960811E479827AEFBD40D34F0B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc610ae9-5c98-4716-316e-08da8cf2056e
X-MS-TrafficTypeDiagnostic: AS4PR10MB5223:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mPBiDUBjIWUnoni5xIS7DHQGhHpJbrqDeoTaCRJOGM81HtbRQUujjTHIoOsiYriDYkoPkj9TrTLCUcYYoq7vckJ74zxxlkMjGEHYPYKuNzqI7mIe9vt6bliddpYY7roQ/xCxqCNPRfMvZJBa36JcFsTPUZmxS2VhEKxBYDDHL0+QyPSdDUKWZmIGQNW8CB4Q2Z6CU3DcOOp1L3FIIqD3UijrtAB9e0B0MJbfelI//NYdu9U/Enn546DUP2Ul+J6ADuLAsUzB/0q0tXXXs84vdSjPRV6l2fdjQPPtU1PflNYMrOx8xENtN5aCnhNRIVPZ92oXXGKOS4G/4xtQ0dK2qMB6HO4Eo63JFFf6EkU9wBBQhLRMaBUp9eJg++cDe7obgR+1344OLWbV9POGmLOfXZ73azr1biB/WKU5uoOX8jVREOpYOF4HjqZ+yEWIctrWZjodAwWZ5WPWpwQDI2/tfWsXr+U19mMngN9dxqWFCP2LZvOENLAzqrDVmYv4zEDjHMJJSfXsNjzgdIZDmUw6+v7H+0WXRGH92wP+H1T8OXjiGOVNsvp05mbq5lA4sc4pzNKluwS+YUhI21vOzgCqo9vIEJEjNmbmqtZKAtcq0lOb5e6X+Kf/tKoILf729UUR2riF0jpWeml0bcn6Fj11DFsL+vAl2VXTxuSVtvvnePMGNw2k2kr9hHjwZal56fgNUAri9f0byaf5Z9bpbmpj2e1fVoM+DI4FJ1b6S3bGEO1478D1tKQD58wHhEICHgsdo3uzEqFNRLhvFOKSqwBEgDBGi9+v4dvcA9TX4Xk+sMjKn9fLuyDyxpeeWJw5LavURneGndbWYsowKDLzTLRwYS3m2rDSgLUvkjcWrz9hMw6NAwfOAz+daZpIK/D3PuRn
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(82960400001)(7596003)(356005)(8676002)(7636003)(36756003)(70206006)(44832011)(82740400003)(70586007)(16799955002)(8936002)(5660300002)(316002)(86362001)(40480700001)(82310400005)(6706004)(110136005)(16576012)(478600001)(31696002)(36860700001)(31686004)(16526019)(2616005)(966005)(2906002)(956004)(26005)(53546011)(186003)(336012)(40460700003)(47076005)(41300700001)(3940600001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 14:47:12.6803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cc610ae9-5c98-4716-316e-08da8cf2056e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5223
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 14:47:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9456

On 02.09.22 11:57, Pavel Machek wrote:
> Hi!
> 
> In rt wiki, RISC-V is not listed as supported. 
> 
> https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Platforms_Tested_and_in_Use_with_CONFIG_PREEMPT_RT
> 
> That may be outdated, but it does not have corresponding config option
> in 5.10.
> 
> pavel@duo:~/cip/10$ grep -ri ARCH_SUPPORTS_RT arch/
> arch/powerpc/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
> arch/arm/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
> arch/x86/Kconfig:	select ARCH_SUPPORTS_RT
> arch/arm64/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
> arch/Kconfig:config ARCH_SUPPORTS_RT
> pavel@duo:~/cip/10$

Thanks for checking! Same situation in 6.0.y-rt, it seems.

> 
> I do not think we can or want to support realtime on RISC-V at the
> moment.

In fact, we couldn't realistically commit to such a non-existing feature
/wrt long-term support.

If there is interest in enabling this, we can start a development effort
in upstream. But if that could then be backportable only to the next CIP
kernel, would even be open.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

