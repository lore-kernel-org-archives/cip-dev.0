Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F3C4707F
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:38 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.88])
 by mx.groups.io with SMTP id smtpd.web11.553.1649700027635144644
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 11:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=knUt17jO;
 spf=pass (domain: siemens.com, ip: 40.107.8.88,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjCSMWEVZNd2YAi2zMlxzPHC+iXZ+7hEzuD2xpjSHe1KGXmKN/5TFWUOwCl5hGiCHJvN0y8E9FzCZq9XVLt7jVNz0K+Cw0QO3JsFWu3I7LPFy/rqtfekC/Dtgbz3Oi/iiepkCc0ebDBAopOV6y8jqHzTuVifW35ZwQpLX04zzhmq07NPIGAoXUegTxiKATWpWlXn9O9FUDVJEtw2taUib7vUzFGmFk4UE+Ne1pRqCjR0jdc5ffsSsfOqEQz01N2QxmiadKx+ZJM+CalK1GcbnWvEoOAr2iqxcb6st9ZJQsQ+ZOj1Hw/WZZTsYpjTfavptZb/gitcu89oiGG91k/qOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoKdy9PckP2Apg2jyQJjORB6jx9gh34J4jhPJUkpFes=;
 b=faicCpe0qs81+ZI0D4/2kggM+5CUi6mL/yvyUlAaFvEq2NxnO7VdTdncX1rp7eKY3xqgd7fC2M+mjkovX6z0ZN/U8Zus/OXXM5j2yjfJE7pyziq/TDNDZgEgWZRrl9o2m/shQVdIFVIJFO9CGDyXAO6BeDEh6nvBIF4qb1KfI0F0f2Kfjx6R1wFsRhyBR1kxOM0nfW5ev0dnzXuOU0SJYU/7pHQNaF6nDoIWxaxd3PF0hMP+meXaY76Ko8pY1Q1FxJ5uvmID625gYGfGPECgz2ecl2Nv1ApftMfzkKctXq4DM0yGBQgX4ZFJhSLYIrScXj7MYTPxTw4ehzX3whsEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.73) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=temperror action=none header.from=siemens.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoKdy9PckP2Apg2jyQJjORB6jx9gh34J4jhPJUkpFes=;
 b=knUt17jOp2ZX0VtbH2YOjwWjlQr+44Ump9yXysNfEs88Gy5AfN2rJjJmj5gqRR/xMoS/alX4zSQ/ahgwDKaal5iBxEwZ41Bhiwu+zV1P12fq5uKAbd/7WViFJCg3hlHejvT6vSxQQzEjnaTwzXWBHdriV2cdZn6mdq1SPUatBDPLLhX8TB/HJmswTHXDdUicVFzYnX/s8cQ3YV/swPl3K60O8UPcElHxj1C2INsGQ30341usp2OXB+dgvcXp99pFKYUXCwf56joWJGZcnCV/tS6YSq5adC9goIOrMFlwZdaB2f5R+77vQRN4g4jsww92rUy04NS4Slsg6yBvwivN1A==
Received: from AS9PR04CA0069.eurprd04.prod.outlook.com (2603:10a6:20b:48b::11)
 by DB4PR10MB6286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 11 Apr
 2022 18:00:24 +0000
Received: from VE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::3c) by AS9PR04CA0069.outlook.office365.com
 (2603:10a6:20b:48b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 18:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.73) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT076.mail.protection.outlook.com (10.152.2.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 18:00:22 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 20:00:22 +0200
Received: from [167.87.0.22] (167.87.0.22) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 20:00:21 +0200
Message-ID: <29265285-2084-12a6-4cb9-1b7a31d14a47@siemens.com>
Date: Mon, 11 Apr 2022 20:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>, "Adler, Michael (CT RDA IOT
 SES-DE)" <michael.adler@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: cip runner offline?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.22]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.547100-8.000000
X-TMASE-MatchedRID: WJ9mwfADKFEKXYJZUfgmMRUWc5DwcsWWExzvxkft9nluXgIqq6mQyvRU
	+9PTPHSYp+5vzsY5mKPw/uiEDEcVOeLzNWBegCW2RYvisGWbbS/MLxRqW4dWs+2eKH3LGf9LQYH
	vllMlP5OOhzOa6g8KrUHA96c6R51zRARMDC/0tPE/qQisWCTxx8f5x8DO3SMb4EyvSgqYhDw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.547100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 55B8633FDD646F9A20921628D957CA0F3FD6360EC1AC54FF86014F7B548073F52000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f150a4-951d-4e94-a2c7-08da1be52618
X-MS-TrafficTypeDiagnostic: DB4PR10MB6286:EE_
X-Microsoft-Antispam-PRVS: 
	<DB4PR10MB628645BB2FF4BD3B556299D695EA9@DB4PR10MB6286.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V86k6LEEUk+alH3oyQOYS2EEJNbF1j5CCOm1ZdF8GVrNea+CpUGnEsUoG1dE7QZk3L/8U1A9RzCwnAXC8pk/j/NSl08sGXrfTbYSJi300uSBnBDxWIA9AQU5qLKVfwPiyeifcjpoSzAfj+EIwQl1j36264FxLXZ70JTqKrJFgssXygnzV1DnV/QHGtr2iYtXr4X4Zkx5OPSBpBcKC19pfnK8AW2BWwjZjwV+/EOPweh2g6xuHmkTf5jWTbwtGClljzdFYhQ9Vnx21nsgSq50prAHtJr7eOOALDunGSJzhNcyCgZ8r+4vEbFvF2zWST+xFXecKAnBoCpK/ZutzqXcpaR9Pf7sPyiJl7RknSbbCmgYEQ4ZYSXKKI6IK4kqlJqqoOwOdVUhDU/gx5asoZ3bAXyRYZhDPq6JCoL3bGTTJbpfPlvBNrwtMGuqZkz5NkSgRSLKMmV5WD6hHEa3qtvNReIUtSBP8Lxpqj6s/Tyiv1Z7sSF+YC18I0wzt3jRrubY917uyjziMHVN0qOT6ZwIQk2cItFUa+HBGCRIhJrgpFel4WbiBQjQegb56bM7U8fFsiVabyESu1gY2PH18TjVryZN6EI6yXcm7hf7oTpdzy56CjpK1zzJ3GHfIFAHh4WhWSjC+6YsVZmnP75x1IL5Hdm4ff1nbIphCIDXcqjaRbfz9Dyg1d4maMEg+B1n4mYR6HgsdJli9jpuQu/tHEGcWrkm94izuGahmwSHkazlncZ3Qgw7KsVHmypKSlzUndETEcx+e7dmbsX3svUqnbhPjLzn545rcXY7Byf/SCsN+gbU75sSbjjXPPvnzKALiI4FhGoQaL9M7jmdWST7aaufkNq++ww09VSXnhuKETSlNXz0AztEa101Eb6b+7i2KIOvd5ZsrjqxRtcdy7lYsd8YcQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(6706004)(6636002)(2616005)(956004)(31696002)(2906002)(508600001)(5660300002)(82310400005)(3480700007)(16576012)(8676002)(316002)(966005)(86362001)(70586007)(26005)(356005)(36756003)(40460700003)(110136005)(4326008)(336012)(63350400001)(47076005)(63370400001)(8936002)(44832011)(31686004)(36860700001)(558084003)(7116003)(16526019)(82960400001)(186003)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 18:00:22.6331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 86f150a4-951d-4e94-a2c7-08da1be52618
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6286
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Apr 2022 16:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8028

Hi all,

https://gitlab.com/groups/cip-project/-/runners/12564521

Any planned maintenance I missed?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

