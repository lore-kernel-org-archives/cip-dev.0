Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C326C43334
	for <webhook@archiver.kernel.org>; Thu, 30 Jun 2022 10:46:30 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.79])
 by mx.groups.io with SMTP id smtpd.web12.23610.1656585982438665116
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jun 2022 03:46:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KZoogrlg;
 spf=pass (domain: siemens.com, ip: 40.107.7.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyLBFh/IBwpTd3TAJMSwDeNHFXmP/KrzAZ68vYB2QJ7V9h9VAMcV8AfG5i0tnWoPPeKYp3rhI6xOpmzv5HS+QeU0cpFwo0+1NNueMC1c8hRH+Cz2gIYFxWts+KnDT8/ugslQ/18F59FIICyGkE7DxTZa3vVEJd4Lsg7Li1WsedvYRCjKHEM0NOqlfpgviCc3uzCPqal3OrwZJa/3mzCSg/DVv3ThuMY4fI7EO8BpZYAH+voL6gjgjtL6GpUwUKx+E4dvFX/Y7idNcBY6JkSu+HkvcUAEZ9JaEE5sl13VbJOlrxiS/CfdrtrHxqOi8I8IcQRqKxDSYr7CRE3/AIEMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeAIKUQswCpl19nzlys3yIMu0XZ0Be3gCnkeeAOhFhw=;
 b=IJDzQd5pIau/yaSMpM/wZMiozPZvg5nht6RduOw2gmu7vudJsl6D9Hn9s6RFvLV1r7WThgCMIHkqQKlUY41w8cwGdfW1XpsLEcfolzGxLJCsJKcxMkcbockvgHJviEFokROQkvR6fSLtqANuVo/oRzl/NE5M12sRfL92+h8ExOeBdIOXiQEaBTX+MwzsoptEDGGNyvO/Y4IJFwjKtuYFgHH2/556Vsp4kK+/EJw1CBTRlUU5YPd9UdqDWCyjXxga/u62UHr3kZQSYMRg/LTYPbabSMfz7J7D6MvcAxb5g5m23IB0gqbX4urrJHvIQEwSc8dB7wYrlwC5zLbNRT7odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeAIKUQswCpl19nzlys3yIMu0XZ0Be3gCnkeeAOhFhw=;
 b=KZoogrlgTbv8NXsTvgX0UriLb3rklQM/4Ub6G7QIK0tCNIxOxIoSp7P6ME9hGYljwBbXevQOCFBFQrqNFZu4qgEf2Yv58yTg45AqeV0XDGetBtm6wBnvsrBkRO3zWY8Xoh7Q00YvEsaKzxe2bz5KHDusET2ZchHI9q5J46TTWY2/QLaTDI0KmHLVMX9Io302Zmv765TURuasKBufUgX+CxLM5sRuysWlpytlO9q40oOKZ9Z7VYOKwx6X8itt2vvy6Yf786m5lv2TuydNuV/Q4rxhqcRvz7Ffw+sxJNkgSHArUVR7zDlte/RONoZAWL6yy8hHGADKENDleqAig1jdyg==
Received: from SV0P279CA0046.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::15)
 by DBAPR10MB4074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 10:46:19 +0000
Received: from HE1EUR01FT088.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::cf) by SV0P279CA0046.outlook.office365.com
 (2603:10a6:f10:13::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 10:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT088.mail.protection.outlook.com (10.152.1.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 10:46:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 30 Jun 2022 12:46:17 +0200
Received: from [139.22.106.52] (139.22.106.52) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 30 Jun 2022 12:46:17 +0200
Message-ID: <cfc656c4-c8e4-6b2b-6fa8-699cf6bac5ae@siemens.com>
Date: Thu, 30 Jun 2022 12:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.52]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.877000-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSxUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGLHcQQBuf4ZFt1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4inZm/Y3MNbKgYWo9dIuk10AkgXPI5D5JuEk8h
	agIbaGmmyiLZetSf8nJ4y0wP1A6APkvV+z371TK5MIx11wv+COQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.877000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6C752832B4EF91DE4CDA194289ACA472D6B5928C04CAD0FFA1656E3FDD4EF7C92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d81c4229-14e6-442e-9f39-08da5a85c38c
X-MS-TrafficTypeDiagnostic: DBAPR10MB4074:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B/R6zCF6D3KPlgChHLrMjLT0dBCOi4p2MOM2yTAJYcS+lyuEDmQ8oFQwpwSDeST2vwpH5CrIeokk2j23XTSp1YxN3nlRaGC6SVa7sFQDtAEZ5goxRVu7JFMX1iFSjwIPX1Msm3Xj69bYii7kj3Ato1ukikdRELVhoTaBfkPUP/7vn3+MERUvx8ASKtTyWVXKxdkdxaTTzpqD40u3MOtiEuSHpt+tbd/WVynNtBPHwILDr8nCglODZtiyr8kfmaWh2KhOZzvv++69A510tqrcSmbM3Iw3E+cac9mDRmhq/SaMYMNwVqlA/QzNE51LodSb0TjTnOcksVdjsGnDI5YrEZaDQbsbHcsk7zSQwYlQCW2mlLCwIhVzeGm9DjPDFXmUisR78uBDwusmKICB2Yog7WUYIPOtoNGNQsQ3tqr4dPM2sBlQe2jCJ6j9kAMGkZVwBJ4c9pVl1Jt03q+HMJ/5vb3NOsZo0Tp2DPjgGEu3w1IrFFw7Jbq3XnFtOtjWPcvk7HihKLcm0oPFBGu0R8gC8XPdbEuqkBF3syGOS6zrvhJFulK7JRi+quI2UfeRBKn3thGFUi2IxU2rkKJxT4zNsbuqcB2Z6JuvJ+SHsZ9ySVOqtnGzewRuXdXBbO5HcP7yELPdeSwCwjMdmuqJC5B+Lb5TF5ZWnUwZRat3aXS4kwPnqQYA1eKd4vPTQ7n+ENlD3rFnVwLOnidupIP91SlUy5VV4RxGCWfJlrjqMUWvP1qYp5XqLk4kJhHN2EjqA1ldpGsJDA+ARhKimlt5kWlJd8kOdWnOsdd5DD1AdHSogDLdrcb0tNlIv1bRKPUa2x9v1A03DA06YTaCySgnEXR6WQJclGnVI4OlblXX9usdT2bs6+bf1zI5rTxhflu+CV+15I7Ksx7nxc4pjYYrpEP4zB+jBJ1gvyJRvxrHiRUAmnw=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(4744005)(7636003)(83380400001)(44832011)(82310400005)(5660300002)(31696002)(26005)(8676002)(36860700001)(7596003)(40460700003)(478600001)(70586007)(8936002)(186003)(47076005)(6916009)(16526019)(41300700001)(16576012)(40480700001)(956004)(82960400001)(6706004)(336012)(2616005)(70206006)(356005)(82740400003)(316002)(36756003)(31686004)(966005)(86362001)(2906002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 10:46:18.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d81c4229-14e6-442e-9f39-08da5a85c38c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT088.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4074
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jun 2022 10:46:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8630

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=6&day=30&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-06-23-12.01.log.html

* Action items
  1. Provide ignore-list for failures of KernelCI on 4.4-cip - pavel
  2. Check cip devices on kernelci old pull request - patersonc
  3. Update https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware - iwamatsu-san
* Kernel maintenance updates
* Kernel testing
* AOB

Jan



