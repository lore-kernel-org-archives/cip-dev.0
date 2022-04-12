Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADDC3A5A7
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:40 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.70])
 by mx.groups.io with SMTP id smtpd.web09.7652.1649745499860347589
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 23:38:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IAJcuCVd;
 spf=pass (domain: siemens.com, ip: 40.107.22.70,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBUR19QXqOXYcqknv0IXduQQ802DOmyWeE6djMPjwZJbO3RvqsLD913QqzwDP+NoxlqsCq7mpH2Q2sSm2Q73U+PdhfU7fjt88d607/xAW3j+wM0K3A1i7kRh8kV5t9cldqVpO62AE3Kgo9ac7w5eiWFtri8r7OS+xMuhRLooYFlMU+Y4V19FNQdquPKOmFpY9m+yXsYAGGDeagxzoYkZE019pT0hw/j2AOHlN+y/YyeADUvMYH3OL8XQnj0NsXUUUk4kfQLyiL836A+xUZFw96pNA534QpPcU/EAyAzuIan3m2jxoX+g2jH/InpVaxzwPpgTw26Iw3TtwYZTXv20PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3q8tg10esreyrN/5xuHFc8SQCmwxPmN6BqVmuKVelg=;
 b=Aym/We54vwACs5U6/y8Cd2VS2g6VT0+PyCWHRhvxiPJZ2etGK+2mfV2iqabJD8b8tqCtfC9EK0po0UM7O/0YQwZfcZiOpcokj/EpfF3riwQUl3t1imSGK+1NLVuEWLuy0iL41sfYTvnbpkZVTatK2UGV84/GzdJHLuuJiiLmDd2dABPaG2NRa6ZhcbOnwZWG/wU181gFBww1SKz4LGpBWqbAVacNx/gasZiSUCjWairECRKo7imgSInOSex2Y1z39XYG9RQZW58T6LzuI/yH4IwrgcdNZ09eGX2GvaCFUcHLs3Krpk6RooMP7ipB82oIJjYLyn5EtEub5YL4ifaLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3q8tg10esreyrN/5xuHFc8SQCmwxPmN6BqVmuKVelg=;
 b=IAJcuCVdps5MDdyEkn0LCWvYtEN7LfanzGC1i9A/BRnsnCNdcsqoni8T2sgf8cdTr7w0NjWwxRcLKbM8ZuVKnbd9MD2ft/iB+hCsaSJqtx5uzlqYrRtZhoq539zremEaqDUpBaISlSDjMgDX+3NnsxDFXnzktYvvXOJrTQoXX8qABb3hOj+eMO5hQs0+jZaPfA22F8Yu1xHhJ0sZTfOsu46SrmjCmZkr2AdxxjHUFUe6n05HkIZ/7PhH5MtTsREQUwRvgaioEYgpN108WUbukvgTNfI7nP0UeZL3UKHKLHwCrOMgFBX0EgKocaH3M24MBKWRxeMJttUtHTkNkTajyQ==
Received: from DB3PR08CA0007.eurprd08.prod.outlook.com (2603:10a6:8::20) by
 VI1PR10MB1838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:39::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Tue, 12 Apr 2022 06:38:17 +0000
Received: from DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::7a) by DB3PR08CA0007.outlook.office365.com
 (2603:10a6:8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 06:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT096.mail.protection.outlook.com (10.152.5.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 06:38:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 08:38:15 +0200
Received: from [139.22.136.137] (139.22.136.137) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 08:38:15 +0200
Message-ID: <ea3aed14-8d65-42ad-4210-ed1664fb8e55@siemens.com>
Date: Tue, 12 Apr 2022 08:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: cip runner offline?
Content-Language: en-US
To: Michael Adler <michael.adler@siemens.com>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, cip-dev
	<cip-dev@lists.cip-project.org>
References: <29265285-2084-12a6-4cb9-1b7a31d14a47@siemens.com>
 <OSZPR01MB687760863E6FD8E921C9B80CB7EA9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <257197f9-3563-b5dc-2eaf-dfb002e3acd5@siemens.com>
 <20220412060628.vqy36h6ljqedpamw@backstein>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220412060628.vqy36h6ljqedpamw@backstein>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.136.137]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.212700-8.000000
X-TMASE-MatchedRID: 0ayLSLUekQU5QaOxwNGfvo9bHfxDWoibhHu2koYAjWESkDbX2wMzOSkD
	YTG6KmZan5NUeSJv39zBXJlzYVjC7Av/EwG4HFql/o7BUAbaNDkqXuKH5Jbj7PgWrMZvbmeHJih
	/yo+OvlW3CLdtdG1oCGBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9OX/V8P8ail1yZ8
	zcONpAsdmzcdRxL+xwKrauXd3MZDWI/UjpULaEopDpCLVprjWjEuQ5713E6hVrgC3NRENdPQZlY
	czlZ9l9
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.212700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 AF9AA08CB519329DE281E0D866B23796F0C9C85916626E602265861AEEBFA80A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b9f13c-9d93-458c-f696-08da1c4f0674
X-MS-TrafficTypeDiagnostic: VI1PR10MB1838:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB1838D682E122A3333864D75C95ED9@VI1PR10MB1838.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1Lnt1sackPP1dm30f+jSSXbIZtUzyMzctfWtVgI9YiqhpxXZr3rZcOTR/HT9C8P+YH5DgAFf+Ad/oDwtGPaIJo+o6syqmxfoFaagX98Wz/1NbHg986M376ujUxZj4fX0NFAv5CK6bM8NlPXRwgblrS5glAMJsB4KtGrpbLh6Q8ObZB1LLjnkDgU7nnU6gwPUWnrDBvU7khv2mnT8wd362tnu8JSyKRm8RWxPlzcyZkTFccNEAGkNAEq+cKI0D5Dygxs4/zB9Uf0tr3B3Kgvq6TBL1iuS5E6F/G1nUMXSeXDN4j61V1Q2M6b50hpOhPQIjFK2jEn7F5zv/5u/P8y8C0A3gHHCK15K7brOxL4BNQS0sLrO7I+pBuvs0QegcYplhUnPV9oQ9qeYSpw+Nc4KYqjSU+spFVyAGFdbWL4PF/75svhry72Oj5+wQsTBmjd4uV8f2+DiVlHYyeQyKwiMQl3nSYgBdCbpfCctnJofqJfSDkYfijEiIrmt3X5cuOCWVn5g+5hLZ83MOVTD2D1zyi/lCtb/6If0lmVFV6u230TXOnDAF7cXHIahSFsMomZQ+3BSATA/RJk6faxRDETk8U1P7eG53j8Di9uNEqifCGh5x+7qklonvgkM3dWLUxC/2Ra5vbOVWDBVTHOjifbTQ9LtEaqz0OVuA5Ok5rrK4r6Xi8gfzMf9xiguv6QblprBPfdw0UvZU1vmZ5IRf/CagW/IKvxO7maXfIig/3Ia3NMULqpw9XnNUnw9Oq5UA6MA
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(8676002)(4744005)(47076005)(44832011)(26005)(36756003)(82960400001)(6706004)(36860700001)(31686004)(37006003)(356005)(54906003)(16576012)(7596003)(7636003)(316002)(82310400005)(6636002)(70586007)(70206006)(7116003)(508600001)(4326008)(3480700007)(6862004)(5660300002)(8936002)(956004)(2616005)(40460700003)(53546011)(336012)(83380400001)(31696002)(16526019)(186003)(86362001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 06:38:16.2044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 58b9f13c-9d93-458c-f696-08da1c4f0674
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1838
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Apr 2022 16:46:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8048

On 12.04.22 08:06, Michael Adler wrote:
>>> Hopefully we'll be up and running again tomorrow.
> 
> The new runners (v8) are up and running now. Gitlab has changed the runner registration tokens (which I cannot access
> directly), so that caused a little delay. I also took the opportunity and upgraded to the latest stable K8s version. (As
> usual, this implies a few security fixes.)
> 

Perfect, thanks!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

