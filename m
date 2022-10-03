Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695DBC433F5
	for <webhook@archiver.kernel.org>; Mon,  3 Oct 2022 18:36:22 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.75])
 by mx.groups.io with SMTP id smtpd.web08.1253.1664822179620121265
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Oct 2022 11:36:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uYCi7yuM;
 spf=pass (domain: siemens.com, ip: 40.107.105.75,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jN68rjUF3HFyvt1LG33w7n5648BD5OPCX/BW0Jp5cF1TcGNa+3dBVtLLBev6WDLhTjUQsh+CRji1DwvlHlGOxfWsEhcY4QhUgdQ9g3JXniuTqUzPd8SlMlKdPq6fcaS3VEIVVGq30ZA1LN5wQyiXbjHPsAbmdfqYpBGJDfEDf6sMn9iCFoNznvTQcPISN07Nq/iairkinn/aduP3bEQnaFIeeQcM6mYi9iEYzWcIbkvksnbl5lF9fUc6DDukpl4q0lyhhOI90DXkk/nQ3sHmgOS4CVdmER2D04I1QtFFwcQoG2Cpuh7EfoWRN2QMFt5q7LVqM9PZpkpghYgLQftc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE/3OyZlK/Lk0RNTabCRI00U2xIS/XsSnd5TXuJ297g=;
 b=Q9ZkcJJRP6GSZZMUmygwMHiEj+njqbIJ+dZpbD7qZYI5VtSAMIFYyKXe6pe26n5foZZWPESveJoCWipBVAkJ+vH5Pz78KqssWnhq2yDmH+MgVVlv6U/4I4nvOws5oki+uZC/RHGYsLL0Njf6gNVoGy22R0YJzPEUh3tkIrPYSmQ7XDAfhK8mTfM3Dg5f8itLfJyrC+JQyinPFFQvcYs0zkR3I0dsV9EXKJb0waqSFe2ZtET85XXEUxJU7hn1KSynbvIOD5OW4jjNjrD3oOCSUh4XVQ3kLWLszbXW/QTU7w2kEcT7vzdytIFhHT5Y5hYwJhKgfex/SypYv1HwQccbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE/3OyZlK/Lk0RNTabCRI00U2xIS/XsSnd5TXuJ297g=;
 b=uYCi7yuMAEOJwPdvBFv7DvvC2S0G0yb3HflgY8Lt+qOhvQTSVpFcLAHVn1/nyWPV2gqDxr+7zcnvomzR1c836AW9PQ3KcL029RRqAKCxYAaN3BYN/n6chzWgxQgBNsciGY3c30wmNOUafAAJCDvcZQy7vbbEOpOQnr2/UOZsApTFJp6F9fEoQfKz/Lzgsqka5Y6w8MHB29M6YoF7ytnaKslzYT/GMTcF5exxQR/IXLpaM+gMeu/5YcjOOnNLjc9HdtjOLwLdLmecNVXHaU+B6Ng24kzAsDEBUAOvMCXQjtlZbQPK4Ir9ptU0y2y56lbNVNUQxBNnmzE8EsCz1TSv4w==
Received: from DB3PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:8::48) by
 AS8PR10MB6868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.15; Mon, 3 Oct 2022 18:36:17 +0000
Received: from DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::4d) by DB3PR08CA0035.outlook.office365.com
 (2603:10a6:8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 3 Oct 2022 18:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT096.mail.protection.outlook.com (10.152.5.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 18:36:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 3 Oct 2022 20:36:16 +0200
Received: from [167.87.50.151] (167.87.50.151) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 3 Oct 2022 20:36:15 +0200
Message-ID: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
Date: Mon, 3 Oct 2022 20:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Preparing isar-cip-core for RZ/Five
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.50.151]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.401000-8.000000
X-TMASE-MatchedRID: uyA4gwy6vJV7P8RSHdALIRCgQCYqwPevdQhEcSQwzFiK5Jq39CIIv+qh
	uTPUDQDt/0sRqdZstnazQLQkumjaI43/v2FX9O5v7WsBGjYJOMnfJt2GYIjmPEUzvZoSFxuNSLy
	uC617NWlsMPuLZB/IR0WW3gw3ZYYJHWMdWhfFbfzVMJCZKkTk5UlULkR1azUxjrVn4cme+w4ujM
	j6uE1hubbMVaqtU3gFki7wEI18pApBj25t7WpOfpGTpe1iiCJq71zr0FZRMbCWlioo2ZbGwdmzc
	dRxL+xwKrauXd3MZDW2yXVx6y9ff+ksM4uhsvpxPfxFCbtZ4NGemRfmjQDdyCI4Jjm0z4Sq
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.401000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 5C8BF31D53F4D0DE62BA146FAA9BDA56299D0CB6EAF71087FC0DB1E72CFE91A32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT096:EE_|AS8PR10MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bc5935-e2f1-4d30-278a-08daa56e285e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8CUy1pIhsJ1wuYvIH6A740xMaI0ATSQOjNxTfBVaaWVAkyQHxGeHwvOZ4FwMmfuwLRlyU3wkgrAMTNlfrjvLGgfPz1uhhX/B4hsiM+oTKsiaIExxFiB8XDsFH7VnvMTUmMZl6Ox7VnHFi5uuPl43VyLX11sDPyZHEFMUD/XPyeFGJlBYOCJRUg/NQSeu3RtyxKByZEgo1hXs1K2XNpwXWWn5kcB0GSm2lyDG1OtPdljRkOTE5LK17jVbQpHlHn5rIHRU3BhQMZhTS/X8ZHpxWb5UGRd4FbsWQJ/ZZteHHQuv+oCOGvXdIy+lq2vYZ/x6vCiicq1tM76P1b8DaD6i6I5u1pk4AZ/F4TG4xKXz9vkF9ZFuHjv5H1luD6k2f87S+TdhmAWo3ZhGAjDt+n8RLojVm/zKqsKKaXhnriatBPINFGnz3SRnImRYhC/Fv/V/WFHyewGOFLEH6jfi6hUK0oM4YOgqzmyq3w2VbHDY9P8cxwycqHE7vL2OQQWVV3jvL/lHjMpLplv3et1d3zfgqUbR15wWGIitKy5KIKyGP0I4fE7qbs/uj3hh31wtr9QfZfGBD6/VxvLngBUBGKuwfA/FYfZ6mYeNDn9Hx5I3xNyFmkzQXYl1tkqNYGXaw/cyZXMJNyb7etOMnnSJTNY8zL38ihDSIQg45pK9atgdwhkU58K/JIKQfEClLzJz7PcOq9w12WZs3B+pk7t6OA3qGt1rYvTG3c+/1OJEiLv1qJlIgh1kAW5X6pK6Pbme8zvRxDh1ZtrW0M7dHsHCsn4S9Hh6nEAAqwk76kG1iZUVXRUbvRAfXh4sqgCDUZz8jdZIQlyqL/GUrmJ+AVntqiaH4ZPKV3kMqZ8HGu4qM6Py2XI=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(6916009)(8676002)(16576012)(4326008)(186003)(336012)(47076005)(31696002)(956004)(2616005)(70586007)(316002)(16526019)(70206006)(8936002)(40460700003)(2906002)(44832011)(6706004)(478600001)(4744005)(86362001)(26005)(41300700001)(31686004)(82740400003)(82960400001)(356005)(40480700001)(81166007)(5660300002)(36860700001)(82310400005)(36756003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 18:36:16.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 12bc5935-e2f1-4d30-278a-08daa56e285e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6868
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Oct 2022 18:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9615

Hi Chris,

after getting qemu-riscv64 ready (patches will come tomorrow), I also
had a quick look at the RZ/Five eval board you shared with us. But that
raised a couple of questions, maybe you can help:

 - Why is the default U-Boot hard-wired to a very special boot mode? I'm
   missing standard distro boot - which would include UEFI as well.

 - Where is the U-Boot tree (upstream support is apparently missing)?
   I'm still trying to understand the instructions how to replace it in
   QSPI, but first I need a fixable source tree.

 - Where is the kernel tree (also no upstream support yet)?

 - Can I reconfigure the carrier board to automatically power-on after a
   power cycle? Without that, it would be impossible to add the board to
   a remote lab.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

