Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C832C3527E
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 15:41:14 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.57])
 by mx.groups.io with SMTP id smtpd.web10.3540.1649313819874554143
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 23:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lNf82AHX;
 spf=pass (domain: siemens.com, ip: 40.107.8.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFL3a5Z64qMWNWO1OeKhTYoJ2Ogeirb/qBWkkkRmJ/U4/Viyc0ZPneBdiwcy3AQi8RLtAG7hdYkd9WZ8+zV5WgMDpytBCHMn+1J9/RBf+kIDhntxr4pz2GyR3kzi7aMcIaYXnxat5nWGIPCRt8e97LCQ8LvMCMMtN74NbVrpijlubd4V6aiOWJLoKDhUNpAVNF4mbwLkGKhryayiPdEyFmZ/YKJkMkhAumqo0pSrp13ZLKmRxZ4E8y1it1hCRKBjghEibAdraGopspG0nHz2rSyPcm2Q8anq3PxvgM/nWS4MpA9AMwh1lnu5omynUHnG5sfLCBDu26kcMaAlG6RgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDqgGsVrmP/TCIe4TuTcb/I88Q6aVUh9Qyz7aqhtkWk=;
 b=EsdN9ozzOFYM6TAwN1bNLgjXOcW3CBLMTU7InUcBemrGVzc68huvZfRp4SOnMIVjcCyOZFKhjuKRiJYU6ZkxLnOQqdivUFmNRUx7a7umZwK9e1sQYDPSBTT3Aj+mPerU+Y0AxD8uUaCvTlUtdbP7mEfOkh+PMLCIv0AAz5g1zWiQemQW7QRZ5Chp8rDAXEdljkwKni9rMd7vAjWXs4oi4QmVzrkqs1s+nwni5Gw4TI+o7L/GM9xxVMOGtrT6V5Q9cRSKNTowsol39PrqOAB+S6IsMrU15NnSIDtOfGvCPPDfWq0HM0npoWLICHeHX7C8SNQeNZOa17wytdRcXh1KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDqgGsVrmP/TCIe4TuTcb/I88Q6aVUh9Qyz7aqhtkWk=;
 b=lNf82AHXGEupxDRGlVPlMGl59NbKtZPVeEM3CHYG67eIaEC7i6nobmh4TrgvzTuNZGWAABc2WGbz62LH+n6nvcMPftP7XAm0rp41aLNqXuU+iQpoVplRYSbqzXVlLYW6viJuRBDG3c26T1n3ym4GZSWPsFuVaaQaroZs1I2UAir7VrvX6mfjr9PrxXBReYtJn2Xszes/VctK6MbaroWcOonGwx+dlmMg6kjexXO+grHSGvpaqwe4VKgFkFPzi0FEexubNmfUDLqxUMzBf0ea4vWMjx84avNcQX+ax/5gJmeSiM4ppO7HfxM6JNylIpgur2YvNDvZUR0VzhLs7ODteA==
Received: from AM5PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::25) by AM6PR10MB2390.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:51::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 06:43:36 +0000
Received: from VE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:206:16:cafe::1) by AM5PR0101CA0012.outlook.office365.com
 (2603:10a6:206:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Thu, 7 Apr 2022 06:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT024.mail.protection.outlook.com (10.152.2.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 06:43:35 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 08:43:34 +0200
Received: from [167.87.32.126] (167.87.32.126) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 08:43:34 +0200
Message-ID: <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
Date: Thu, 7 Apr 2022 08:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: 5.10.110-rc2 mirroring/testing
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, <cip-dev@lists.cip-project.org>,
	<Chris.Paterson2@renesas.com>
References: <20220406220612.GB4213@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220406220612.GB4213@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.126]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.886400-8.000000
X-TMASE-MatchedRID: YxAl3cAVoyr/J7/cdz0rWgkxjdn4BEWssEBAuoaUqK+dVNZaI2n6/1tX
	gpRlmDcoY4zJvUjGrxW7BSKCqxjid770xstTEnEw2gVKB/vv+izUPdM50hQuqm5eAiqrqZDK9FT
	709M8dJiHPSXOyvGapqPFjJEFr+olA9Mriq0CDAih1H96bfHINdAtbEEX0MxBxEHRux+uk8h+IC
	quNi0WJBvBL1JI5YTsmgLfQTlOuqoF7e9oCRhQSMPR8NxVIUXZftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.886400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 97E1EBACC1404B6A33073910E7458FB4E171CDCDFE923772FEA85D7DF0AD7C312000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78daadf6-981e-49c7-1cbb-08da1861f0d9
X-MS-TrafficTypeDiagnostic: AM6PR10MB2390:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2390AD717047E7AAC4CA552295E69@AM6PR10MB2390.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AdPjb3ywQ42HVulw8fapaGNUN8FXKp91Dd5rmPeAThQybb/sBRAW5AV2D1mqPQALhn7zs80Cj1SA0nSy/plufLS/Rw35brBYAAlHZYbj754u4IcdXx85fn805kzv+R616FrJ4PElCibXd2eYVGzGOho4Ea0ZhpzspGZBTCwPJFcr8sZVj3qBCYpl/MvIfypd187QVx3sGdnzuYON0Peu4Kb4pgHfbc7BzEuDo66lS5PSU37DwjLZR+xsV288RunswJk4hr0zzMniDTISKyX+xJ6fW5YPs1elAcUTCd6E2ALKjHhi42iYu+pIYJGie2VUBwIWAruO1QdvbAngVk5H5IU5raNGYLMnanGtK7Qms/CQz5RDvyDgxqhWQDuUQRZEqgCogzwdl8hi6AY28Ybfm8XM8cbbStvwDz+SC2jqYBCZ4/svlM5RWfKTMeoQ9DUjAia8xGnIZq1m4Vprh613tBGvwZ06vCVHOe9tgva+eERcz3IIAQTFfok75x/Jhhq+C96vmZ2Wy/nQ/EOWrw0tfBiegfJ0x1ZDrRxjdJe70tCchmtlJfT2ZOXI+DM20vHfw8OrZire6HT6O7b1tGyGNoZF8ZTYLxeJFUAnWqqlnDCFWO6MlDrtpY/LqQ/mkIFAwdjuR1RCN1cEpGAELcQA5zAAUSHfLFmCfzPDxPP5hF3isUdXA71mYDYoT1BJQ3M1Qpu1FWNndAHfvPL73KqemaMYizryyBIvHpnuGajyXW9IEIsqEwcGIkAcePR6VQq6MhNAfZmLozWecgbmfpVmWS36C5QmzK0rFtQRyut1e8rKhxFDQv87uUh+OYxVInaJ9EeTCC6ID1T9DD/wDFqnFiiUJ36zY3JHya0t59FlcL/EVqP+NNJhbgItBy/226OP1ZNvq/SgPKz1tjUmZYJ3L7+PBtj4FhY6kiIFfy4lO9M=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(82960400001)(70206006)(82310400005)(70586007)(966005)(508600001)(44832011)(36756003)(6666004)(4744005)(31686004)(53546011)(8936002)(81166007)(5660300002)(8676002)(2616005)(356005)(83380400001)(110136005)(47076005)(16576012)(31696002)(2906002)(336012)(316002)(6706004)(40460700003)(16526019)(956004)(86362001)(26005)(186003)(3940600001)(36900700001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 06:43:35.7532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 78daadf6-981e-49c7-1cbb-08da1861f0d9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2390
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Apr 2022 15:41:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8017

On 07.04.22 00:06, Pavel Machek wrote:
> Hi!
> 
> 5.10.110-rc2 is out, and it would be good to test it, but somehow we
> are still at -rc1...?
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.10.y
> 
> Does mirroring need to be kicked again?
> 

Maybe the problem is rather this:

https://gitlab.com/groups/cip-project/-/usage_quotas#storage-quota-tab

Already linux-stable-rc uses 11G by now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

