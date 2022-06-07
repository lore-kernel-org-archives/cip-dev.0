Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C2C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 07:20:39 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.42])
 by mx.groups.io with SMTP id smtpd.web08.9359.1654586424422043301
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 00:20:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bUrcCpxv;
 spf=pass (domain: siemens.com, ip: 40.107.1.42,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AObMFHV75XrqA4ex2/wGofhY+NLp2EbrGTxbuqnyK/mbOvIqb676IGtEpweLVg8nuqfmdEgDVjpHrHlWqgjL4GKR6rwf7Leb8HD5M65ZJQ+S4UzAtmm/JvZOKCsyPymqSb41K2k2hJIqJ6r12+u3yOxZqXAuuGa9oGSS7yG7LeNgqViO5JdiQH9PG0BB0rPKXsiY241bgJ2yksxo1VvIyVT7hdCL50r5Ld+TQTT5hrr4/xSwT+3aKICIrhoNeabRyY6/oLpKcWnfydNCalgR1Yvr6IsI2adShRQky3lBPcMzE86TAGEY5HpdGaIOh1z08dGEf2rgMwDiunKwNBPaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp8wyOY0ugyfLLjsJmtHf6PEt1psQ2t2oZ1mz6S/c5s=;
 b=fg3zd5R5m21CCl6knCpapUisF5XXNUvaFvywkl9EOGPfvRxQwt2SRRwGvi6ywaewSSrIMDZlwxWq14IhodBDFbpHKodE92ORUcvo39ti8tJC0Ic3gED0IR2JSYYhzi8JMEFwz43LN7vzWUdT0vHJ3Fx1TwGX9yB1OI378vrpEdfjMOCqsVL0LqaEQnBexxJ99Mf1xNipe3P/p/UAlvC0kYvGVe94/WS1IyJBDFbV2pNj9n9FSlgnN7IfQyaVlPesjrxw+3SVSO9BZAWoQXmbYf1gAZJ2YkFIBGvTNhhkwXyWSQTQQxgoaHkjblfrlwerP+hLj+hstgYRqTF7dZBlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp8wyOY0ugyfLLjsJmtHf6PEt1psQ2t2oZ1mz6S/c5s=;
 b=bUrcCpxvAV5bjtp3cXFMA7uiMtkL1uunZVwbkowdq2hIyB7QWXgEHCCJhX/eAmZuCRiPquk57Bp1d/M+d6yJDgsl7gPXBT/Q3R0OSjV1TOmYos7vubSflG/sa97gDeTgn8butbWLoXRkU0YR4ECqz4ZYJOtv9TuZfPpFkCPpq0ms0n2cUwv5H39wch5uPM607fEeKBv1QH6z+87aCyeYqpuJrXFcsFcSWhaInATkq3rusyvxQ4u7iSYFPCXqPwYU4cwLiROgit3PVgwUl2GISQfpewof7qWc9SR8qClxY5v3c1Ty8QrwVhxsdxif3fVKY27ZQ7cuJSGX7eVivQw+kw==
Received: from DB6PR0802CA0045.eurprd08.prod.outlook.com (2603:10a6:4:a3::31)
 by DB4PR10MB6214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:385::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 07:20:20 +0000
Received: from DB5EUR01FT093.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::d9) by DB6PR0802CA0045.outlook.office365.com
 (2603:10a6:4:a3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 07:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT093.mail.protection.outlook.com (10.152.4.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 07:20:20 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 09:20:19 +0200
Received: from [167.87.36.249] (167.87.36.249) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 09:20:19 +0200
Message-ID: <8a6279d1-a02f-8808-de08-c2c195d36969@siemens.com>
Date: Tue, 7 Jun 2022 09:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: pkexec vs kernel -- root to anyone who asks nicely
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, <cip-dev@lists.cip-project.org>
References: <20220606175706.GA19989@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220606175706.GA19989@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.36.249]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.491800-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/TPhQMrvkSA3qWxvLzh6MfqPg9yfk4YC0bece0aRiX9WtDZ
	1FFTJUymf2dEskHXJhB+Nx1ftYxL8PVQVYs2pZMx4FtEpuiqagBy8WyFAksD+HtNecKMjy32PPc
	wU/BDpbkCUrUdjFToCjpIhhonTuyPSAeDxNvlbxBpmEYU/5eJwcOaxLY/AijDXmFVlObh0PxBfk
	JWKY0KaQrVgpI9tRVko8WMkQWv6iUD0yuKrQIMCMEd1ZAImbbyiYZyrULQL1bZs3HUcS/scCq2r
	l3dzGQ1qdk2nO+ebu/4B+6m0Xf7Wxto2Vt/otkGxizDnpoBadxZigI3vq+dsw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.491800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D69D61533693BEB8F547B3C3CED48023B06932911DF11054BDB71E39E0D63DA52000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19037438-a608-4cb0-21b9-08da48562e27
X-MS-TrafficTypeDiagnostic: DB4PR10MB6214:EE_
X-Microsoft-Antispam-PRVS: 
	<DB4PR10MB6214A8095A8EBFA74E7BB8D995A59@DB4PR10MB6214.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TJKzF/yWLuIl6UIVN6q917vYQ09w6qpvbcCcF0GM0UO+C8oJhDET5DMiI3xUUcMtvUF2NQZf5PKOTuPTo5s6jcX49EhgOaZZAgL1ELaTHg9kw7ZvY8VAQfngp2FmBZK3pxE+R2FLU7uW7b8vbDa5U+fwNYJXMYWXhlWPz8hI0QV6WHHMC16ESkDo/Jpr3pQ/M2/nJhwm1ysUJfoSGl3pNq0bNM1elBOk4r14Z7nO8Ezd4sYBmszcwgAg4XBeurMqZJQD7M4YR2Bo06jnRxdTmt7UdM+vAtpODIwlylDcTkjCI9xRSm0Tow6xN9PSZ3kBdNBFmPd1Q9ZtabZFzeWHy5wtzTvYCHmV9WH8bN4eW1uisTkYL1Z5P9pwcVpmy+Oom+HBCD4VeRC9jTHzsArvW2oFpsZu0FNKarGV271B/VQ5OL6ZrsNRQ9pME/19jIbpW3vFEP6xmzXatEoCqqbcAMuyBoAdt667Hf8pAqkTq+aSSI99fdSCih8SODpirAOaCB6wvGG9eG34k5TAd2PeTR4+Ukr4H9cjBYJoTGLE2g3hOt6pGRad1EtdpcN1iLGIEtgq4ss0AIsmQ8AIFZ1vQXJfELa4slyqC0xH5oYWNCoMCm5oPppgG9OtM++N95G5wHPvprbnbYujnazJO9Q93yIyplWHlAeFGuNEev8W0UMvxgd+csbbEOyfcnIUyrgkwFGaooIHfWPgANadGV3XJ1e6mO4WKoBufFp0h4PfZX+2RSrM5agd0Gnl05J8rF3x3Zxl3CPI95c7S/5PCb9hXjgQfst4ruYZ0us2ht+Pvey2oNE7N4IhpMPPqClC9ZDNtmToLUj8bOfct0jy51/ExSJYtmJ/c6+c7sjoM+hkcLI=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(8676002)(8936002)(956004)(186003)(2616005)(508600001)(82960400001)(6706004)(81166007)(316002)(26005)(36756003)(336012)(2906002)(83380400001)(16576012)(31686004)(356005)(110136005)(5660300002)(44832011)(70206006)(70586007)(4744005)(53546011)(31696002)(47076005)(36860700001)(86362001)(966005)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 07:20:20.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 19037438-a608-4cb0-21b9-08da48562e27
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6214
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 07:20:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8498

On 06.06.22 19:57, Pavel Machek wrote:
> Hi!
> 
> There's a security problem in pkexec vs. kernel interaction. Impact is
> local root. If you want to get root on someone else's system, it
> should be easy right now. It is fixed in 5.18, 5.10.120, and latest
> 4.9 and 4.19 kernels.
> 
> Do you have untrusted users on your system and you need pkexec?
> 

Is that https://nvd.nist.gov/vuln/detail/cve-2021-4034, and does that
relate to "This vulnerability has been modified and is currently
undergoing reanalysis."? Or is it something else?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

