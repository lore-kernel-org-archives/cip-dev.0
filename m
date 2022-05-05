Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048BFC433EF
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 07:16:25 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.59])
 by mx.groups.io with SMTP id smtpd.web08.7987.1651734979991272358
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 00:16:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jaEW+oPa;
 spf=pass (domain: siemens.com, ip: 40.107.1.59,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Tp10QWF3oOyyIfIEAA7E8A0sVPybJLtAY5ZtTJ8o7CdZpCAkWLG/FedwKovzZ/h6zMnvSN9jQJso+WgdsMvDi0TeIOhWVk0w9pu53NPXq7SkJTuJFXz+sJvCI8ImdnollFtVN+0+M515AEZ/NY8RzpPUN+U8aFQqjFbmsW6o0YL8X8ekjyXtz9S8i6Gs0z//CJJMf6rdjDy96PFf6Jg5v/fWcQ3rDQLFhTy7ZOsn1G+1OPUfvujWvfypefRZGaewm2hhrOXqu9MKDB1SxGK0r3ldfomcmoZxssGPyITXtD8v60mOOHv+Bb4y/WsMWQAxSEgqdml282NH5UmJ6fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GevibZlob8ELC6ZcsSwkV5qBWyLHEZVrBp12BLH5tbo=;
 b=FqN20y4yxBFnBPfjUtUWFuePP+Pev7+9E4Bb+IE6yVem7v2koq3jzSn556MkUbS5ZCR+DAmVYu1xXywck8mU3MoSw8SnOb7W7WwnwWUICzzVleJLWRcSB5Q/dULii7v2EcJOrKQgI61hOz9wdt6KXilocLqUuMS8+eAQoauyUrMV482/+zjl4lzGIxFfN1+/TClJIB7CyMatI+gZZKno/vGjMZ/w7Ua5lw6L8GbZbonu+sifyFu0xjyLglwpvFMh9fvSO6OfZYOIriwx6DEn2DuaFrRS2fKauQb5Z+Udz8CCgHXQM1WBqqtMjj3bjgjGmbh6h9AcXsxiYRXaUBDcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GevibZlob8ELC6ZcsSwkV5qBWyLHEZVrBp12BLH5tbo=;
 b=jaEW+oPasUlJfTIlI5waWchl4xkZhbtS5oygjvRanAxtbu0EBrTLm/V3VJMROAvuLmX1n0S2PVS5FGUwfqYn58yosRP1rhYzmSslbReRKiSys17Q+pz8PyPJKDsvr7mWUJhHuktIZ0raJsno1avc+qbJR7lmkIDwRBhH5CoB/oyMv8y5gLzfb4Gar4LdAjJUy+MfTLsLjIh651ELOY8ted74Tdlw8ptz3ERj4gEZQCNicK6VL6yIR8ZIuNfpPlf6p3V3GaVy4mit6futBlhdHaze/2CLpwF7pOlSe6dNG330U3dIGTaOF6beG39syGFWB1zS1U00fJLipBoOoffPDw==
Received: from AS9P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:50f::10)
 by VE1PR10MB3887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:161::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 07:16:16 +0000
Received: from HE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:50f:cafe::93) by AS9P251CA0002.outlook.office365.com
 (2603:10a6:20b:50f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Thu, 5 May 2022 07:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT039.mail.protection.outlook.com (10.152.0.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 07:16:15 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:16:15 +0200
Received: from [167.87.32.15] (167.87.32.15) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:16:14 +0200
Message-ID: <49bc030a-b9c4-4e18-72f7-854739ddb92a@siemens.com>
Date: Thu, 5 May 2022 09:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.15]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.977900-8.000000
X-TMASE-MatchedRID: RfRf601lRZFUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto23H
	KB4DzLVlhs8uimgHNCgj9S01KNC/gKHc7YsBPi4pGTpe1iiCJq71zr0FZRMbCWlioo2ZbGwdmzc
	dRxL+xwKrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.977900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 287437562FBA1E6A0616387DB3F9E1355C60380E0B149951CD4492852FE142D02000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2509f5a2-2c20-4e70-7a8f-08da2e6724cb
X-MS-TrafficTypeDiagnostic: VE1PR10MB3887:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR10MB388710AF105C14CC86FD560D95C29@VE1PR10MB3887.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tKijRSXX9P72syCHwHsAhmI6Q1MXvmuMJS28oPKy5EoOokvhj87ADFPca6Jn9TtQCDS5H1ot/TLSRDFJPElkRocfkQvYRLyvbGYcxYItyh6eT3ttMLMA0did0DgN7PA64NJWpTWlZWjc+Q5Npbbmnb8Yu38vWQPmOrJet+XqoCWJZG+brW0YmjFrMew9VUBCFDzngKsuvC84LeG4yJE4mJ3N6/mtFuYQeMYja3t01bscWNsj1PYg/KEUrv66acaN4UU9nPOg8FpSSWzg3lfaWbBaMjp85ldkOYwdancispfagZsLNDWwoeNTZ2knoOQ03KJZo/fIB/ewAOJM27CcIHMnYPe079JUTos3k2BlGU6JBhkEAuEKas2nsbVsnNiqDEgrvpnzh/tFUS1W1dYqJ3JauHDBPLurDv2szO3q9f6h+CqNtpsHh50/iwIRxkS/S806RXi3wCBv3Q/mn9mPkBT1Xg1x99BDNxgj964vf+9g55fMRcbu9OLdZLdjDbgm2v2SdOx9Iepvu9nZfDDd9zEn3pRSh2GMAn/ATl8sEdoj61UkdfwQjwQRhatz7Vu3OT1LcQSR/zVANkJ918EfiHrW2iwhP0wAoZ0c9ha73ozpxUUHPYEkUVWEcd2N7AVQMsRuywnByssD3q6F8/x4I2xzGbacm/HYK/BoiQBv7RHdTCKK8uhjxa/jBrA1URpTJuWqPQro2HmpMahyMGv0fSGBYM3v01ovMVdIbjAT/kOqMhexmjfumGUQ/s1O852QWq7pQj/RbUh12BQ6gdKRpbBtnhoETeeC1TjTkRlWBP5LLTcHzhYeLae6nGNWBIdyTulADgzJLF3/4nR0H+OXguodjoYmty8JCad/jbHLb94=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(508600001)(2906002)(70206006)(8676002)(70586007)(316002)(186003)(16526019)(44832011)(5660300002)(4744005)(47076005)(36860700001)(82310400005)(82960400001)(81166007)(356005)(336012)(956004)(2616005)(36756003)(31696002)(86362001)(966005)(16576012)(8936002)(6916009)(6706004)(31686004)(40460700003)(26005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 07:16:15.9267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2509f5a2-2c20-4e70-7a8f-08da2e6724cb
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3887
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 07:16:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8253

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=5&day=5&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/04/cip.2022-04-28-12.01.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
  2. Document CIP kernel release cadence in wiki
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

