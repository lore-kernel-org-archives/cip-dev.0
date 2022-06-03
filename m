Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C60C433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 15:27:58 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.82])
 by mx.groups.io with SMTP id smtpd.web12.8742.1654270074016239249
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jun 2022 08:27:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d21kZjQH;
 spf=pass (domain: siemens.com, ip: 40.107.13.82,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF/ggsIIaJKUs8BB0iWDDykKwWuvm8v5BkGOtdA6o0kl2AOynJlKEhEtbq/l4Dsk5ic7inglHKjtPicOFMttxO1fNwaYccgBbhRpu9uz+fT9tzamhNXJGN81F+CIxbbLublVxRvoT5OitNYWIWKmB0xJHEKBncqWJMHTMyB1XymWFklB4tJo0Vs98phFMWsXHIbVH8zRKF/g4v03VQtVnbc/y5IeEapm+2u7GiaWNRBTR7DGAlswMOWtJGntAuk/g0vEgNlrbXntbdRWK4/j7eXos6yWlFjzZ6VxQR5Hv6ZZW1aLoEBAHmOdwBUNwhzybMAVkDtHtnkWHZYRqNWVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7mXujcnjm+2A2MX/LeRLHbHm6q3ctHC1LkiGmp2h54=;
 b=lks3gqIxuEuRPcCH7i1IbvyU6Yff8uSyIQeNZlJcmxjCdffCbRPqVg56wk6mZUVO/yXvvxnacIgefJVb072T7s9M+lTRbY3/ueVux2JlKWzL8GvPPeMZyf8gvFBZLPEImH9uV/HLxnhsbPhuZ3RNftkeFZpyqh0Rbp0AwHO9pJ/abbhNRjO+/jg9yG/zsr3GDivBzpzKv+7v10BOIT5evD5lav8PF2XpigXBlHj2yrH+EfSNLQrw0GGGXLr6B7jn4AbGiIPfRfjq6ZA78JJ6TSh7Wp3n7Bi+gR8IlPNV5ctmST4oCHd4Ezm7KAilO7OE8ltkZQ9Ex5koX+wCvLh3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7mXujcnjm+2A2MX/LeRLHbHm6q3ctHC1LkiGmp2h54=;
 b=d21kZjQHWcgl3XoqcTuVO1zpvjS9aNCRJYxbIrZ94cxk7CMc/tWprDpCwfwMxOdez7dZPPN4Mozsv67neeDPrfYdb0JXKD8xsEwmCpPdzRfIGBlLgIjNRsIM17e7JUUzRHx+LeBZb/+52wAGNeMdNwu7v2vY+gz9N0FkWukrGLY0fBNMj8zxPbhMkR3DXFPmSzR9GUgVdudu3kKlKfjxYEgxSwR2rbrglTklfGcP9p2vpsOfHTRt825gXQrfuzbU0+Nv+nbQQINEHAG7eQpqlU6+20RDwZsgLmmrvNWloFzo4iYH+oLQEtgh6D9E/CiZvOy8tMjHKQ5ruNCvgI9oLw==
Received: from DU2PR04CA0344.eurprd04.prod.outlook.com (2603:10a6:10:2b4::17)
 by DB8PR10MB3547.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 15:27:50 +0000
Received: from DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::cf) by DU2PR04CA0344.outlook.office365.com
 (2603:10a6:10:2b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 15:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT091.mail.protection.outlook.com (10.152.5.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Fri, 3 Jun 2022 15:27:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 3 Jun 2022 17:27:48 +0200
Received: from [139.21.16.8] (139.21.16.8) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 3 Jun
 2022 17:27:48 +0200
Message-ID: <f1c75b36-4dc9-dcdb-b388-95add01ca821@siemens.com>
Date: Fri, 3 Jun 2022 17:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][RFC 0/4] Adapt isar-cip-core to ISAR
 IMAGE_CMD_*
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, <adriaan.schmidt@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.16.8]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.447000-8.000000
X-TMASE-MatchedRID: ObgwaKFsELBo0FBZlmedTrZv+ayzmKtKPg9yfk4YC0a5kFk6DtF9f23L
	B2YI359FB+A0yBBPPYwMyjRdBmXLaAlfxg5ncm7ilYUFo9LzIpmMPz8Goa6fXUaMPBFKXyAUYFs
	T/TpvJqYH8UzOewTxw4A+sls4Cb83sA502JwhhUHfIqy7qrBQpy+pYxwv+BZOZf3zf+xpuLi7xm
	CZDXrutalOQjQcrzOloSnPJtmDAFLJIuRHt43jisKHlSQGL2ITmv0Xhs8HK83HrhS+VKSDcfioI
	si7Sa0gJ7XU0Q1VfIcn4JkU8L63Qcd+uwyEzGRili14pejvmEdQWjkLGApnaY9Ha73XaFhEAPiR
	4btCEebvRQsknAWmGmBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1BX1YjBRZkAyngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8Krc5wYq4JPRQIy4u+8EtrcP5DAURLeDX8v/78Jx
	8YapTachhYrarK2v0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.447000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 1D63B0C70BC2111F7644E3C1CAE0190283D56CF3520E6C117C0F1D037098B5382000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129032f1-1675-4d08-f48c-08da45759e42
X-MS-TrafficTypeDiagnostic: DB8PR10MB3547:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB3547FAA2C604A44A3CA816B495A19@DB8PR10MB3547.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gsa3KLGa51+riIayQoWznCXs70Ox29WOFnseXpCKQKcANn150DqAu8dnEnVrafXbXD1ys5hN/hZk2acU58xezPfE174mi8PicRlM9yF3MwahW3S7ExNbSW6YYhWQ7h5P8XdSlJcY/iWSMqYPp7giXybHU6U7D+1iDjVpqZj/Hzu6vWa7hTXA/AWDvTIPf0qBpIe2W6yPKrz5BvLECiMFPGiD40mh/f9fwoK7lS1lftGgONCtYcJQXXm71vFDXIgrYoPRAHTZiBU8vtljEPkeKCQC03QQ+R9T8clVqpHvmMWNixhyuUGhYPCBkpGkazohcAVh/9SXLfIOf4LaEP6LQiuEFZixecdn4B0edDNq3EtvlEX12MLJAn4vT+huLtvAp9WmzvqKMsN6tw4bR795ep6yN0HNfcNJN6tA50gVmUDrwSgz+s9efh2agM150bPo0HzD1Jrde4iaaFwYNMQMTErfkP5YAeJ63TUD5KyTJTUkieoyvDewllh94VV2FstnTe85nFk+ejmvLxesLM5ShNG5O0TGIsTEnwZwDELt3zWtArhyGq3e4RRwSwy5Djxy4BMQ84+c08sZWn6jtk2KsVG0u2QLx9GE1Duqldbbo7sKWHhDvl6oSwKq6BZqLCR2t33FrxV+ocbyNyRkLMZu6zhD1DLDdScbFcHFumDiivTxhf35huOXBqPF1fmMcvd2ZNkn2q37DBZop7WZdFfwN8d+5dNz6LMKXcgCB3zMvkeS+LBQFyr6I2CJfw1dveNwCbVew0ZNtR7L1wcfRbYKoAdzC2KH+FG9LQgUEEbcGST+dwLHQ2OyARd55ePYl15rs3CEjxrTh/ms8geV5er9VTEpUYP48nvgglzFwiqiOYUtBtVEaHL+1GX2W/FchZeNCYT7GdNdZW9CfCx09GHV0Q==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(966005)(16576012)(47076005)(508600001)(6706004)(110136005)(336012)(8676002)(70206006)(31686004)(70586007)(40460700003)(316002)(6636002)(31696002)(2616005)(956004)(81166007)(26005)(82310400005)(36860700001)(86362001)(83380400001)(2906002)(82960400001)(44832011)(356005)(53546011)(8936002)(5660300002)(36756003)(16526019)(186003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 15:27:49.4399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 129032f1-1675-4d08-f48c-08da45759e42
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3547
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 15:27:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8489

On 03.06.22 13:56, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This series adapt isar-cip-core to the IMAGE_CMD_* introduced in
> ISAR commit [1]. See also ISAR API changelog[2].
> 
> This new feature remove the *.img from all wic images.
> 
> Also as new naming convention image recipes no longer end with `-img`.
> 
> The image types wic-swu-img and secure-wic-swu-img were removed.
> Rename `squashfs-img` to squashfs according new naming scheme.
> 
> To use squashfs include:
> 
>     IMAGE_CLASSES += "squashfs"
>     IMAGE_TYPEDEP_wic += "squashfs"
> 
> 
> To create a verity based image to following line need to be added
> to the local.conf or similar configuration:
> 
>     IMAGE_CLASSES += "verity"
> 
> The modifications for a read-only root file system are now part
> of a bbclass which can be include directly into the image
> recipe.
> 
> The modifications to generate a SWUpdate update package are
> also no longer part of the image build process and in a seperate
> bbclass. This class needs to be included in the image recipe.
> 
> Please check/test the interface changes for swupdate and read-only root
> file system.
> 
> I tested qemu-amd64/qemu-arm64 with swupdate and secure boot.
> 
> Quirin
> 
> [1]: https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add96ecdf14
> [2]: https://github.com/ilbers/isar/blob/next/RECIPE-API-CHANGELOG.md#changes-to-image-types
> 
> Quirin Gylstorff (4):
>   ISAR update
>   start-qemu.sh: adapt to new image names
>   Adapt swupdate and verity to use new IMAGE_CMD_*
>   scripts/deploy-cip-core: Adapt to new image names

Thanks for this update. I'll have a look and also try to apply it to
meta-iot2050 as test case.

One question: Is the series bisection-safe, or are the patches 3 and 4
needed to build again. Patch 2 is likely needed to run the result again
after patch 1, right?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

