Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066E1C38A2E
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.55])
 by mx.groups.io with SMTP id smtpd.web12.19001.1650530470534294819
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 01:41:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CDVnL558;
 spf=pass (domain: siemens.com, ip: 40.107.22.55,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W05rbH/qWtStlhfcqaLFNk1xJnSEQnzgKamuviBwpzNs4ZUYDxo6MblU4NxJRPLUvcGHXSVeGm9jq8KFLTzm+bFzpkXs3Ie2DiEBehHHEvMfQBbAT+B91X/oC5e57JisSvmO7j7SbvfdH8xhARVQUWNw5B/kp/rn5hJgzlXkBowuAwI/KJoVPBSS9gyx0WmmVuKu+Zd/9GKTDx+EID/Od/yPGHRXMVFHPjFbJvnSLP5nPd+XKlXBjxrAJ4WXbf0i8gSJbUUtzOYmZQZXN/FEkarSentxijTfkq+qMA4sx3TsHfVU0GoSQG3aTeyAiblFais3DAhmwDm259VLq9wlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2caoZTJ4cl6AycXxmr/Zzq8x34VwSGHgk/EG2H+C/Q=;
 b=neP8GhO5smEBNnugZFUz0FtDBXoJ7FrJWzCBryPGAKnECZ6YUvaZ5FYAgrMHicerSWbp3M18eTDOQ8Hm6bKXA33vb3fpYFdHH7twGSkM+/InSMWcKVTCXCrMUFJi5Xp1z2XS2a774Ft0EAgX/UvGUzuqV15RSWXfo0A+9n4Rbila30sFtio2WsOd6HX9C0B4p+EzbO8WktGbw2cBdnHg12FQwaBvYE+yimBxGOI7l3M8OvRgk1vxGaOE9/HHoNwSstq9KPy9ZsPTouX2cIR//kJ3Fyi2EmxwcvgSY3PvSme6USWD45fHimM1B4pZo0/AHivImAHjvtewqIrmUzBE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2caoZTJ4cl6AycXxmr/Zzq8x34VwSGHgk/EG2H+C/Q=;
 b=CDVnL5588oHv57W7BKId9Po5n5l59l/BQeed1SaH4MkGSZJY9N9Sqlm2MUp98wjXoIH6bD2E/UhzZjOzrQ+SU9cSlbNjRCl9naIp91N6z/Xsru2ahItDH0IktQtLeXNyTXRnjynEUN2a9lZK6tn8UoQzmj7SahMmZcqT8FApVWz3Jx2Zx6Zze409Uy9OnTxYpJONceh5UdkrRTKJTfAE5JO58PsWHbLxm7Z7BN+4UbGlhwalgiJdP5nQqvc1w8xHF4EOSy4J/RRizuEW3GL2ZJh4XqhX6c8mXzsRvZGTmaZbdqj6JPgduK3WrwuP7+U5SFAawx5pb3JBiY6nTH5yBw==
Received: from SV0P279CA0028.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::15)
 by AM7PR10MB3976.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:140::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 08:41:07 +0000
Received: from HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::ef) by SV0P279CA0028.outlook.office365.com
 (2603:10a6:f10:12::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 08:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT103.mail.protection.outlook.com (10.152.1.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 08:41:07 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 10:41:06 +0200
Received: from [167.87.32.12] (167.87.32.12) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 10:41:05 +0200
Message-ID: <1ee8862a-b28d-021b-5eb1-7cf6e0946df2@siemens.com>
Date: Thu, 21 Apr 2022 10:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.12]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.222600-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/RUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto23H
	KB4DzLVgv1OPvvDLzsImdkknPE0j7i8zVgXoAltkWL4rBlm20vZiFQvkZhFu1q8/xv2Um1avoLR
	4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.222600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 0457B2B06A23EA20639F8CFD56A2816A9FBDAB9BF0C573D72C8EB68B6596BFDC2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27f0c32a-61d2-4791-97a6-08da2372ada7
X-MS-TrafficTypeDiagnostic: AM7PR10MB3976:EE_
X-Microsoft-Antispam-PRVS: 
	<AM7PR10MB39761E6EE9BF62AD5156A70895F49@AM7PR10MB3976.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xWpH2GEJJtZb2sG+4dtBsedwKfyJXFcZbjERQjhfNNiQvgCNgOola8E2oWJUzucIHgYCv6fZC2/8qQIDH8OzkFT9RCy2pheopMHrIs7xzjFLEM2OgOn9gCOFWOmheoGQdg4WUCg/+78Lt57Xj4qXsnJb7BaDqt2TnMOREyUha5nDTTyvV7bQJaRq9nKQRCVwaSFM2v0CVemF1fh3e3iLk1DcgCiKVYbfL+pnEcB04EGgs1YZA/ZRx+Z1EQ76KPSsNnG1vEyeC0QysdaaLFxraKHVy8e4QgmL2KWHjewoPNhPiZ8pmsTaw+VZBASohHquvFjv8ODoawNSrsPJ8mRPchnn8VbG93rWxzkmu2qdd+MdBGrD/MYZiwgx536muj8T8YVSQRlWXpHX5imiB5tPiyt899/0KAD9pLNeDWzxBDQjIKLNQ/jFBV7YClsaYVZgopObKLNbPlZusvIOwkr5WRr1p6FP7QyZ+wKJgr/kU47xX/rFC9KsNI9/FUHgsMMWylwLxTpS9vmcNWtLB+v1WVOkB+TQBJ0pqA1URJn6ltvzp/UcH6smD25wfo2kwmhGWIGvVx4vA1f0AdWEXjbelTl6mXXQ+62Je9EUReZ/I3abhKm93uTh3FYJXILc/5s3H8jp3tUtJE+o/TzFleq/ECDDUyrueYKYUEzq2V12grjs5wD0+ZgoYmb7b6k0E/bYfW+RYrWTdTmsoN0GyUi1BxLxx2m4gN6wCb97NDneB7b+hX23mwSeWhcBP+WjrY1zDumREcCE97f7J6BFni7/sjX06aXnXzjTmjfsW6YZQggb2nnBgRjdskHqZWyjR5O3XB7Z/ZUAsn/NK87ZCX6iNkcEWLyLjj7iLBiHxmjEBAc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(81166007)(36756003)(70206006)(47076005)(336012)(4744005)(82960400001)(82310400005)(36860700001)(316002)(70586007)(8676002)(356005)(6706004)(31686004)(16576012)(966005)(508600001)(26005)(186003)(86362001)(5660300002)(40460700003)(83380400001)(16526019)(2616005)(31696002)(8936002)(44832011)(956004)(2906002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 08:41:07.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 27f0c32a-61d2-4791-97a6-08da2372ada7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3976
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8156

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=4&day=21&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/04/cip.2022-04-14-12.01.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
  2. Update spectre/meltdown for kernelci - alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

