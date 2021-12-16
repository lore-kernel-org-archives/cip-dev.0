Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D00BC433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:24:00 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.53])
 by mx.groups.io with SMTP id smtpd.web08.10413.1639661038295536940
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:23:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KfPeH5Ab;
 spf=pass (domain: siemens.com, ip: 40.107.20.53,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWVV1wVSMGWPJeWATcL71cJWoDuKwi5hXKFzv84MGbAXy1NjXhsdIHEjdY+cdFX3wuG/IOD7O2RWHwyjSFxyjWNBynV9aEpmzQEx2ci6A0oe9270Gqd/e0Ke22KR8cuQ8Lu2M3e1wEU6B1dg24tVHD3eeUPnHjl4fbtlxEpejQqZ6dUE+4mF60NNuOyGmHP6dJYQqYl2J5aZ/9hCOUteHoyl7sdbm1k7fVx2yJ6H+I8wYvGRfd6tL9aqIGZHFcTGgTPvb9fjKPj3Qpb8aorn6kH3Sf+t3G2LuUJewdj9IOTNEzFm6Bf0SzkRf9P61CinizhyXX9v3uhOWPIizJpWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws3+GmDfRNtM2ziKd9X7czbrEtFM8Pmdx/QDEAJcwvo=;
 b=N6qQ+VuckppiZuCBXw9VZwO2u7VlQatdoY+QgGegM/GcsA3+6Ew2UZMLkep7EGB6IVcYDzvHG7h/00gLrj8JEjfUeEIkU7IW0/w4Wyn12Ta1CtcmXEfRjhVjRcYRk2U+OMIqvzE6z9g3nXawKIiVbnz0QJ5LtvPxxUN2F2dC3hm5UBEaBGSHdaQCwvXny1yjyDov3DncF+wyNTSAlLbthGwj4/okDyIMKHO8vwtq8lpWXxc609nBiN89/5E4AGr8o6QQFUGAgPkrG3T6ZDQ/vXaVqqQEjBukWAuVo6znHMhjf85zOi3nn9DMspC7FDosGzjYyZlyqErjm1NH78jB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws3+GmDfRNtM2ziKd9X7czbrEtFM8Pmdx/QDEAJcwvo=;
 b=KfPeH5Aby1BdK3f6Ir72N1Jz1Vujuz9zE+fnpDJoNbiEPgCHm9UWs183iO2KZHdIErrAv3vbeb4szgxQWLu5RslNGvzIqNf6TodPpo3Pf4VoDCvEwOyos74U/4gQTuPLJNr4QG3vsPSsRyGM3UJ3+hz0q2U5QwnpG3hstl72oAVMhvWxQ0SbL8vfjsDZv9R83MwPB9foTltMStxsVicfAbSRteKqwsukGefPCIF8KqECP0ej8+D2y+eqtSbzrk97azqkLnOaT4qIf64EjTR3ShEWPhqBYBeKf1sBcYq7a6ya80USfnq1bw3DMarU41BlZcjymRI/IF6msVZEvG7goA==
Received: from AM6PR10CA0049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::26)
 by DB6PR10MB1735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:38::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 13:23:45 +0000
Received: from VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::b7) by AM6PR10CA0049.outlook.office365.com
 (2603:10a6:209:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 13:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT055.mail.protection.outlook.com (10.152.3.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Thu, 16 Dec 2021 13:23:44 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 14:23:43 +0100
Received: from [139.22.140.88] (139.22.140.88) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 14:23:43 +0100
Subject: Re: [isar-cip-core][PATCH 1/2] Drop stretch support
To: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>,
	<cip-dev@lists.cip-project.org>
References: <20211216130450.3402865-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216130450.3402865-2-Vijaikumar_Kanagarajan@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fd82da76-9435-4ff2-3172-3ccb9d5c2866@siemens.com>
Date: Thu, 16 Dec 2021 14:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211216130450.3402865-2-Vijaikumar_Kanagarajan@mentor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.140.88]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f666316-0335-4e77-1a8e-08d9c09748c7
X-MS-TrafficTypeDiagnostic: DB6PR10MB1735:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR10MB1735FB99BF6C99E842ECF6A395779@DB6PR10MB1735.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	st1hGw5RSDVJJ6NoJGi3nho8q6yX02N9tC6qHb3c9AGoWi/Boam/DqgXapYEa8WmVB2f4KYuX5fXpTB9qS/k3ZYnR+R3K0b7Z863/hs8i6bFoXu+aHisqXLiNaI13Qw6uX3HigrB5i89Zj6mc+Lmsx1ZzKgQF9KqlKbEGojxOWdUiSWj7D7LZiywfk5/Icrhj039DVJBmb7EsytADx9fXGZ5Z0SyCJCnlNrVCsDutFQ7iGYe4XjvhYs3HwDZw1H996dw56fxis/ZBp5e35A7z9patgBkn3gOMQLHeCAshHpR6f09tqm9ngmh0ONpdtUQR/PkFQlhEKZc6xPQ8jYgdWUUVOVP1Q0cLgFFKiobFeecBTtTOPxARh1IepcbhO0LJZTN78phMMKM6FX1F0H2eJwAF9HD1G/Vzs0/nT+ndFIk2TDE3VyjMMc8xEeN1KHy/j2EG4ga12zbh31bjbB7bsFiYrRO+LQiFcrFIoZrd/eVajd2/nXEJVu0EziN6EuHal0QctA8qSF4Uyzkdxl9EM8v8QlfSBDwLyE5BChEfVzEXtdtn7Ys34Mc6lyVUuM4JfD0jRm8Btium1HGnYrWCsNff+o5680gq7Tw2fHMojz/5ExqfzP7udt+17lokmyPRvtXLVcVN9SWI9w83BUTcy02dPeqvLpGHP3Mb59l/XFhLBNTQurDP57VDWSA0RasuPJtbLfN3FjUB0USY7RbEcMMnBWB6LtMhVRpO40I1GsE9Jl8mcrkEJafe02M27xP2ViTTsuq5tRL6YKDAoXoyC4yhyph4XY7nbjQ8Bb7a94nVvDnwRhLVczPueT3xvcU7aoZ5X4rybL91jWRinFZ+Q==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(8936002)(7596003)(4744005)(26005)(82960400001)(53546011)(44832011)(36860700001)(356005)(7636003)(16576012)(31696002)(36756003)(40460700001)(31686004)(82310400004)(47076005)(508600001)(336012)(110136005)(8676002)(6706004)(5660300002)(70586007)(2616005)(16526019)(186003)(316002)(70206006)(956004)(86362001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:23:44.2769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6f666316-0335-4e77-1a8e-08d9c09748c7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:24:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7153

On 16.12.21 14:04, Vijai Kumar K wrote:
> stretch is now old enough to be dropped. Support the current
> stable(bullseye) and old-stable(buster).

The more accurate reasoning would be that the generic profile of CIP
Core does started its work with buster, stretch was only experimental
for this layer.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

