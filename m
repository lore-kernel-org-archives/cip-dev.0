Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C66AC55187
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:55 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.51])
 by mx.groups.io with SMTP id smtpd.web08.8668.1649916997774141505
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 23:16:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=N2udwQJM;
 spf=pass (domain: siemens.com, ip: 40.107.5.51,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSVbVLvYdMR9/OXf9umHJNITY2Ht9SHF5fY003JYg9JW5kho0YK6xOzy0TnunCRvujL1mTH05ghVPNwxT+fOWVLOZN4tktzdd0nODGQmnUMg2wnhyihh2+6/qi/11MBzgkkfHnsqDNGfCLlQ2UlnrsPqfjFksMvF4YBITdqjhjENAWsQHRPQiU++fqpwneSYjLyNmaztILUXI21sZ5edGcnHMOP2NJjGVixyNRp/RiKawSIRigygFwhd3d7xWIf2GSuiH/4pTxkEPPzq5vqzmoYFIrB4B+lOJHQ5tWZenUtSxvxIxakkft5eCuv+MYmj9XlIs/rAXbNKyXoolRa9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvOjiegCnN+GJbRUNzsnbkPl1u0zUFaj7jCjgQ6bRAs=;
 b=Xnk2RgdxMo0OwIH5H/vw77FH1FGcxI1tiP5yPZ1CyD4Qh/sCFjOkWd2SCRbzIeflCU0IYn7yMKSMdtLxMUAsy83Rf6CYjSnjOLjZkmSoZXgpbi+L2pK7TufVUQIhKiRutTye206oIY4yt4SImk8EJ/R+I5J4D65OwMG4aKo+A6nff+wWPMjMH20S1u3kL192NPIFUOP5uOrB4pZrCcfYniclNCxTuR9imu5DH53OoouQiabJT6OcZoMeIG9dr1ikDocMj259tt2dQ8VEu/QPktPFInsAsLSSkFMzHm9e0LYr2Tc95SbYahTqofQickAGkw/MQC1biVm7hga0w8ExhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvOjiegCnN+GJbRUNzsnbkPl1u0zUFaj7jCjgQ6bRAs=;
 b=N2udwQJMw1eJ0/eRNfGSmxVzhEQSaOheSIUvu9Q5pwbDpuLZgLBXPqjj1/ymh9zH1uN8dn0F0OINiZFdXPFXPyeLOs5tnfe55m+ihLI1x2x7Q0D6wkK/lKaBhmmFKd4qyJel7puZr4bh1yKhZoAxOMJBWjL04ZWlxY63WdqTlB71QcbzNSDNUW6/SUCTDf5qsFqhG7pXu0+uyesBO0jSJstlSEa+8QRaiZVb5J/LcGFSatQsLvHzoScfv0dolV1XPSW7JdaWEECAG/OMc6wJtJ4oXbxN9lVLut12JZRwwa2E64uxO0yFAfzPwORHyfzG1OAyT2cNKof7hfTvpbcs0Q==
Received: from DB6PR0301CA0046.eurprd03.prod.outlook.com (2603:10a6:4:54::14)
 by DB8PR10MB3579.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 06:16:33 +0000
Received: from DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:54:cafe::24) by DB6PR0301CA0046.outlook.office365.com
 (2603:10a6:4:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19 via Frontend
 Transport; Thu, 14 Apr 2022 06:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT029.mail.protection.outlook.com (10.152.4.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 06:16:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 08:16:32 +0200
Received: from [167.87.32.156] (167.87.32.156) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 08:16:32 +0200
Message-ID: <f4c7edc2-d6ca-2cce-0fce-e0c5490507c7@siemens.com>
Date: Thu, 14 Apr 2022 08:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.156]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--22.014900-8.000000
X-TMASE-MatchedRID: 8xNMUprDHadUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfppkXECarrzOd7mjXJ7tMk5XZBccONAXs3zen1b+Th8qByx
	Vkfd04JJLfEy2DFePtEANTSZ3u3XhcB9Plq4M1IldbqAzxizwITX7PJ/OU3vKDGx/OQ1GV8mMVP
	zx/r2cb+gtHj7OwNO2OhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.014900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 0D85DE1CF8F7C39FEB4BEDE09AAD2213D93593B21439A49CDF587BDA453D3DE62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dcc20d0-9b17-46ab-f044-08da1dde52aa
X-MS-TrafficTypeDiagnostic: DB8PR10MB3579:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB3579BE95224709239875F99F95EF9@DB8PR10MB3579.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3QJChrRvsoRp0+DGpnm2qFPezcL4LYKFITG7qrE0C63avkRSCvs/TqoNEZlHmspsxxeIF2TlC/5wQYAn5KWXMA9CUUVrmUXcwpJM0emoASA+SciXx7E41s4MmhZOIOdx3e3i5hTaFNifVsm3Oi9KaRVwTwrG9MzkJEvvssVFiVd5CQfGvnw3i7HsoTh2bOfHxUP3A9m8SPiK9dsYDszQAMje3UE0DXg74V7z1jNnUq2otAG6J6iN+GvJHELX3Solz0y6m3eg1Xa/RGhxc8JG4QPsa0sdxZ6zObVs+ubsGVXtP60lw0q2ff8yoPFCweyB63DIQ5EpqVsD8dvRuT3TWETeQCaX55D4VWQflmszFA9oYJCQtrZujAADYrbrOJKZ75s0BRFG+t260SG0bWaK4ADA/R+zT+cu7vpe2CoONVe7mh/kOb3K2MIAhhVh4SMaHfZHrHE0JmN9NBtgMC5n/hqOq/roTdsc9K/6w+z+7KpHu14SucyE7YYMq7nZWHTXHz6oUA18L1ZOXZggraqve8NCkenGbfzWjMBGwstKjdqAnCq3qZkz2bJldjg3Og8FfS/x9bGjXDQYH+Ju1LNx63As9w+9uAil3OBYMFfJ2I3ZV0/muBKzOws0a084Q5TsT979NMOJ+8PrWSSjKJWqOcgZBM2gYtlPoKuG7oW7aHh/9hD1RC7J4faN+/zOkOoRy+ujSsYJ677ON1/WlWjSkZMWupTFnNqNY3J2rKDmzdg6eRc2qVuj2cVoxD0wxUfdWsvkIoPpnyP7R2kH/Za9xzI5t7KjT+buJ7zWuX2eCdjk5MKrFVFbwTjCaQ/O0DZMwpNDzWCjmX3k3EjnBTP0XH6CjTFqdSYu0zpjTtP6emo=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(6916009)(8936002)(70586007)(8676002)(70206006)(16576012)(2906002)(6706004)(31686004)(4744005)(966005)(498600001)(36756003)(44832011)(82310400005)(86362001)(81166007)(83380400001)(2616005)(356005)(82960400001)(336012)(16526019)(186003)(26005)(47076005)(36860700001)(31696002)(40460700003)(956004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 06:16:33.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2dcc20d0-9b17-46ab-f044-08da1dde52aa
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3579
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 16:03:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8094

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=4&day=14&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

IMPORTANT NOTE: We moved one hour earlier as some people requested and 
no one complained!

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/04/cip.2022-04-07-13.06.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


