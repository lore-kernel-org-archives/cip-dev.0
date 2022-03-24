Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE5CC433EF
	for <webhook@archiver.kernel.org>; Thu, 24 Mar 2022 07:31:14 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web09.7985.1648107072082817778
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Mar 2022 00:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HrNlZAhg;
 spf=pass (domain: siemens.com, ip: 40.107.21.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1cQ68G1DkoUlYd3gdt/YBi+hYV0E51fkvc65piIv75qRy4xiMHus0EMwCGfOofccA7m+3Jbqb+C5012tVQAe2hxGvn663QkY1DEwrx34swoZTChMCOnLgZg76deK8NAgASMcDxtlHlqCUdknRZ5vPntvO6BGDRox2ToQA/HMxFtI5OffWutD3QMz+6pbGCRyGgbscm3D/XfvczQbgRInihRRH+JWZ8gozipeIkV76m441isVVdCrD5r/izoBHBWS4adI8tZrEzXeEAUZi+5dMtqWGTOFLYBMscqThNPf4382u0MRXs8sng02vnZCcLDq7Jmk0aq7k1MC1dE4NVWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dcxqDEjxOQLJcZu3pPiPgA6QVQNdn+rQwy0U6Ep+NE=;
 b=Lt9x925bskekm8nHOuHX/i8+2FfncA94Y+XkWROFIjjHH4X0UT8/sJm+IeTh9WzovvzOazf7vZCvB3QM5431NmRBgMXLlLCeNu6ZdaWDFJ6t75cUCWppQnAT8URPL2BD8oKaVb1H+EG4PaEilxpwb+UPWvUiticLTJsTfN8ghSPtnIgPuJhzkGoVJa0sCM2aWDoh1l386Zq9dTVhzBfCvernkgmxXHabHsd4aykYPjccc4tc/hPvNGF5TqDBi/zC6xblGhdfk3v2ck8bn0zkrR21OY5+lX7NPcXhgCB+/Q5Kh3q+hT/4djN6i1p5rDZBhtxlxm1CLDti2WyKi/LdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dcxqDEjxOQLJcZu3pPiPgA6QVQNdn+rQwy0U6Ep+NE=;
 b=HrNlZAhg9Oduv5gjr6jwGN2BWnR75sYXyv/SNOTcHDKVsxmoPfZJ8I4SCeKzgVJgP7j39nvRWQAeUAIqOZHednTcfjXHdDZPybfL00LHJ6iASN9g4UVYl3FvuzGvNLSgE3EUwHQbFEAzi6UhzSGmnVlpDTzkhX9DddXvvXtaN6y2HikFju/UfD630wjjiVgtKigrw7jMwRe+MD3rYEH2ki1rkxfs6eWGN6fBLSYOMLeuLv2Zw+5PhI9cGLFeHAvoONzri9qXMJhlEt7/g5+8o8UwkNFOFN/asX3qSQ2Wfl0jp5Bzgh4NANGRY+6FZgT/VDsYOKCNrcmYtAx3eNTnOw==
Received: from OL1P279CA0004.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::9) by
 DB9PR10MB5329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Thu, 24 Mar 2022 07:31:09 +0000
Received: from HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::2) by OL1P279CA0004.outlook.office365.com
 (2603:10a6:e10:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Thu, 24 Mar 2022 07:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT018.mail.protection.outlook.com (10.152.0.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 07:31:08 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 24 Mar 2022 08:31:07 +0100
Received: from [167.87.0.244] (167.87.0.244) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Mar
 2022 08:31:07 +0100
Message-ID: <2a3000c4-5e2e-2779-24eb-9dfbb5ee81b2@siemens.com>
Date: Thu, 24 Mar 2022 08:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.244]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.616500-8.000000
X-TMASE-MatchedRID: EhMq+2gclHtUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto23H
	KB4DzLVlrpE34WGjdPo8WMkQWv6iUD0yuKrQIMCCAtDqHg/4Qm0C1sQRfQzEHEQdG7H66TyOk/y
	0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.616500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6495C9D9FE9A5B6C0A7B1E633E4B3E592F1D39F143F4CBD471E0D0A9ACC04D6A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00544c57-a63c-463c-9cc5-08da0d68433c
X-MS-TrafficTypeDiagnostic: DB9PR10MB5329:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB5329B8BC7976582E3AF1A35495199@DB9PR10MB5329.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y0wtt9H/jSPUhOf7rbos7Ac2wQP114oaev+SWwPSR5ntSKkRbMrByqCJ1OSaGC/DG7LrEfyPoajs4CxswJSoMBQySgcasHbu8J3zIGVs9T/8npCSHH0fy5meMFXBJXFh0dqw3jS/Dj2VcOinMcydgsN+sHlT4aU0Vc9do+KVcek8Xa1GwHIT9za1PXIQwO/u6EbXjDkyZWxCq/G5aCbbOIPV8/L3ZiP2Opg3avNqypO1YzSi7+KcZktSNrgQNfuVakq+psqyDgItyuAy7GTOdfK9CIcCozIccSO748dgKMI/EQQ+bPwIV6uPyAEySYTevS5DwsibKiw5ecMAh6ikX9RjKfPXeTkZ/FVRqz8vU52stAjgOz/70mjLevnrjKZw7r0X+qHwDWrbbviV8LXR8t0CrM/ICfclDlzFI2prP9p47913aHjDRzh+OSk6BKuXfTagKWW8e1oX/gWKhAG4VgitxBvDaCsZa409f0rsPSXjyBfiGfK4jG0m5iTJ+HsrKBvs+JaaKsCtFpQ4Woqw1ZkDdxA1tDRImQRSOfUYXH6EE8c57nHlFbok2TMx+ndhdfgO0bHgUyKU4N03eHzxX4E/NzZK+5LFUa7AZ95YTzCy0vKXKv0kMK2GvtRz56mCHUk3kaXCawXJl/SudHoEpdKW0ZOGJ2GL1HhMMWubG4a3/eTky62KzYVOkM5uWOBM64Z5S59/2S+pc/rsXw4zkb34M50PWJd+iznZNZqXc8bW2KpAHhxsFwnaAPrLj/yNwxowNv8io4BP9s8nv0ew0LAMsgMr1JUAJTrP115r6gPig/h93jef3TJSZL6gbkju
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(82310400004)(82960400001)(36756003)(8936002)(40460700003)(86362001)(31696002)(36860700001)(6706004)(16576012)(6916009)(966005)(70206006)(47076005)(70586007)(316002)(8676002)(508600001)(2616005)(4744005)(956004)(2906002)(336012)(16526019)(83380400001)(186003)(356005)(31686004)(26005)(7636003)(7596003)(44832011)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 07:31:08.1370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 00544c57-a63c-463c-9cc5-08da0d68433c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5329
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Mar 2022 07:31:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7819

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=3&day=24&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/03/cip.2022-03-17-13.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


