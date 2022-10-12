Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B2C4332F
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 10:20:18 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.77])
 by mx.groups.io with SMTP id smtpd.web08.18383.1665570015726769034
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 03:20:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LCj/U7ya;
 spf=pass (domain: siemens.com, ip: 40.107.21.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFu3FUeDO3hm2b2+NIsby0X/4cAZGe9D4e/ZcBl1Byios7CAQT3mXrjGlzMMKKW2squPpcRCk6dZ8xvpcL/FgNGxLSn9QfLMGqqUKNFBxadz/Xn0EtFXKLeMRk9h094lsx5nnfxc/f50Ya46waPs+wM8J2LkV4A9XiW4VcKQWbgjyFDvmJodYKOxamj9ANDQBEUZOL5DSm072UoWcSmj6mkZAsp5wIsHVis4Fd1NXvNCLVZSlAGLIg4hqOGD0NH/9F138jKryDs0Hx53VlQkzVb8XHDkbs4gVDie3YpS4ib35q3AHiu1MsWGndJ2akfBePuVtW5OwzEgGTeb96ZBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYQCHAKTF3fJgDj4SGWIVwZKxtlDshB9+6hzx8o2eRs=;
 b=jG1iPAYsE8oMLlZkJs8ZP5EL3DVlxV/t+0mIAX6+ko/lTKB6Blrr7yyojocShhgR8YPHxdyhbnx2NRnZHhkIod9M+qZnxHQ/ymjmlzYmkwN1Vs1UfnQrYaWSJbAnCB7aXH9anebcewGlrbbVC5oTJQBWMEF8LPHqPP4hebsjiEjh5SdrrJ0moMVnxAsw0eiAGFN92Fg9K3iGmvCqelQ5FTfAQx9WyOq4BqM7IjdGqFJCLnzxnjV3sOte4kTe5Klv5CTKXnGTazTGbpyv3wY7REHNckCObkIWRHCRB8WPMI+Lqq7/9ElOZe/Fx4LaublRAZdM+k7fjYR1GX31ZY1hdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYQCHAKTF3fJgDj4SGWIVwZKxtlDshB9+6hzx8o2eRs=;
 b=LCj/U7yay0P9zchUfrPZ6nAHHPfQHRxyjCh5SVbtavV0ZiozZ0XCRjtrwleRgNy9H6a2DHnYoFohDAg5C/dIyIUhLGIeLiF9cmAM5ytU1ywyQeQNbdpYXItKK8baLFBsv/tofaA+aaaRyWhi8cXW8CNYyWe17/34PebJHTg992VPkufKq7q1sWuKwkgER42ZIMw8KF58ZC+pVGHJD4GQfqQPQ/e1bnQuC75uFvkPelm4o0wYYiB/2O2KarM3hhgzEM+t3wYKt15BlBQysDvXDAWC1ZkS1nBEdcWMV05OAU2SWJ2exxI666KCKUlSq3x+PmCnc8/W1071/T5eA+Krlg==
Received: from OS6P279CA0138.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::15)
 by PAWPR10MB6782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:336::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 10:20:12 +0000
Received: from HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3a:cafe::45) by OS6P279CA0138.outlook.office365.com
 (2603:10a6:e10:3a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Wed, 12 Oct 2022 10:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT050.mail.protection.outlook.com (10.152.1.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 10:20:12 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 12 Oct 2022 12:20:10 +0200
Received: from [139.22.133.11] (139.22.133.11) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 12 Oct 2022 12:20:10 +0200
Message-ID: <73ba5e31-243b-1ddd-e225-6c285297e5ab@siemens.com>
Date: Wed, 12 Oct 2022 12:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/3] fix: add missing class dependencies in
 image_uuid
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: <quirin.gylstorff@siemens.com>, <pluto.svc.chengdu.cn@siemens.com>
References: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
 <20221012100641.2986740-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221012100641.2986740-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.11]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.979800-8.000000
X-TMASE-MatchedRID: Am/bhnZHfiNo0FBZlmedTrZv+ayzmKtKPg9yfk4YC0Zeu6aRt5rYySUn
	Lzk1+IxzYpaRze8Sn/VF23po/1bOKtSTXCtUgK1nf/c8dBER0g3OelbOO++oFpr5ykm9NtIcBGw
	ExtNOAA+GToisPp3j9UAc6DyoS2rIfGLYftM2IgkvHEcEx0NzujLvC8LxRzod9u1rQ4BgXPJ9LQ
	inZ4QefL6qvLNjDYTwsuf7RWbvUtz66w6vTIwLSAtuKBGekqUpI/NGWt0UYPBuPmzVRGyF9KJah
	HOXQ3dimrvKopUrx9p3sH++09aeLhjynaUDLxMG
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.979800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 46DB90AFE7F771E74B94A79054B675BD01D34B4B0D07A2CB83B2E87F181911F72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT050:EE_|PAWPR10MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a588aa8-eed0-4173-e36a-08daac3b58e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UJnvwnwCirmN49KfHlvaptIgUTeeEvmFxK2pHUDgVIFRmCIMCZxHVRqyGKeyDFfWonINcfqASpaNV/RrSqIPpznX61rcJ+L3mRpetdrkzC510QFbWApUwiRdtzAvs3aAPzkCYrxr3z+tVmRR0e3FaX5nMibz8s6u6HWllaWK/zXetGrJLrGXqH7S603c0i41ZaiQ5flR8gdW+IUf29jJo/K5US3yuPxdgC6xZO4MWNCt8oxppMr6TW7q1NzWm6VwNI2eInmBcbFPrxi7aJ7s/dX1AxdBcoZqauu+zGNPqzb5KQ0HK2xhcmTaAOwNZ5Qb9tIeiLSR7lMMZfvh6w6VgUJO4a4V/K8sw26agmcbKir9qjvEh9ZjmL60f75j1CFvKb83190YbejWHo13BOI9TSXaS67JB1nfjHP1HLqL0lETxNTSE09jHqLGy8R1Fi95PS6qEEAOO071wzbQXg2qjwOVL2nK5OCwH2SnoBovAi/hjHl4y/O+WAEM0w+bWV9j5uXqMD5XnjLGo2UG9H03oRBszDhzcVoCPLSupA2Us+VkNDXVPrBzsacIYcRzfw0diEGVySwrPe6x9mwanUsrLKKj0/4FYOyNQ+a7yQsPZEUJZF9pca/sR8xJzrjOg/hqgLPgdoH9sn04kyAhSLb5oyqaVirhmlgxt8xQzxk7p/Dv78sUbBVb6GbL6EK8/Q3aFQwCZkW1KdAnx+WM5/wsqFmF0BZCBGZwj+55+iGjbEzD6satC5Xtt9zaowSqsjSeS/lqVnri5M05lk4JnUL192FsUyqlT431RbHNIBfTrF9HfKWEuu9zsbmWaHYotEEylmN+pwXTAwum8axCgBkscw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(336012)(82310400005)(36756003)(83380400001)(8676002)(6706004)(110136005)(82960400001)(478600001)(316002)(16576012)(54906003)(16526019)(86362001)(356005)(7636003)(7596003)(70206006)(2906002)(40480700001)(36860700001)(82740400003)(5660300002)(4744005)(44832011)(31696002)(47076005)(70586007)(4326008)(41300700001)(40460700003)(956004)(2616005)(53546011)(31686004)(8936002)(26005)(107886003)(186003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 10:20:12.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a588aa8-eed0-4173-e36a-08daac3b58e9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 10:20:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9739

On 12.10.22 12:06, Felix Moessbauer wrote:
> The image_uuid class references tasks and variables from image and
> rootfs. By that, the class has to inherit the other classes to ensure
> that the components are available, independent of the overall include /
> parse order.

Just for my understanding: Is this more a theoretical issue, or did you
actually saw errors because of where you included the class?

Jan

> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/image_uuid.bbclass | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 71cc3ad..277941b 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -10,6 +10,9 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +inherit rootfs
> +inherit image
> +
>  def generate_image_uuid(d):
>      import uuid
>  

-- 
Siemens AG, Technology
Competence Center Embedded Linux


