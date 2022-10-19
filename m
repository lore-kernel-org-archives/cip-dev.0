Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDD8C4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 09:23:31 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.64])
 by mx.groups.io with SMTP id smtpd.web08.5951.1666171409261868401
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 02:23:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=peg9/OmU;
 spf=pass (domain: siemens.com, ip: 40.107.6.64, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtfo18fkF1hnxURGicFArL+LW+evlmMv38Rutk4ne7kdT3XCDWLVtRmwSNwJ/zxk5MgXmzAwT9wwTbSEDUCnvTNbUgL7yiADlqGCs2CJ99dwf52r5Phug0kQ+fH9ZizMg1xHCFtIUN0o1H7wpS/lqdLSgr/UYkpTzI1jKHiM3EwaGJTEsC1QiMY7P+uMfTCQ0CMagQkYjNpFHyfAGWyjvP1ZLzqcT1DLy1irZoHjadiQBuwMiKZjB0vkrTn8Kk89YBFH+T+5IlvFD84MjH+VE/PZt/33w6tgIRE7nH+FNAsJ0NPMgIFV/bhoAboYy1y/DFdNbv4SSzWbcwIjcqxOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liFCM8giZCFQLY7w62P7vdTEGzRf8ZYwoE7rWQzZRI0=;
 b=SzGdTodTJATrTs3b1f5VC8usJ9roUOg9O6BECXDJo7gTc4oKl88UbQQRK7kT7N+kalCk6auZtkb7nIMW8djjSgAyOmu2n5nV+I9feeQ0kzc3+7s0cumhNCa25K1s9VxYhf7OYlu+tTbaT+fiIxSFhC9cl22+cUdSpPfg5YI/mAW5gYtKvf8cNRvHG8NWj0mtwxZ+AKNI16NqJU/GysC1U/hm6MX37dSBnwCmgOc84lDpudLru+Ak9SjzhKiG1UaJz9FDnyITY75os8A6bh9J0R/UZLh0IE+2kMJWetVU8DB6WCgYv7r9SdHIiUm1Mrk7j/SUWaWfqhkaZkyW+EFAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liFCM8giZCFQLY7w62P7vdTEGzRf8ZYwoE7rWQzZRI0=;
 b=peg9/OmUeOF1ow7Xggww63VDVI9kTuqm/5Q6HsiFASmy+M2BWLKmiiJlFVcqbrRMGm8I1D0ATCEDTopWRgnGouAGeKG3hVsfed/Tm3c2cVMQMB+dULK/kJah5PoivxZ6JjfNBCHS94wP6Gqj92he6DZU/U9dukJIF/pbQ+WY6FO75FSVNgjguVAREljGK5RuFbKNUPo/X0iaTDZP+Uhr19R96WwfRgiCqYzbu2rO9ObVt7du1epqEkrDA152Fbf7AUfncK0XXJJjILMjLDL6r+tdq4UY/gKNCNKXgNdXGFHfKArcK6E5zMroH3Qvl9f1ZuIpO//x6P9EFcs4AAca6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by AM7PR10MB3510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:138::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 09:23:27 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:23:26 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 6/7] enhance start-qemu.sh for arm64 secure boot
Date: Wed, 19 Oct 2022 11:21:16 +0200
Message-ID: <20221019092117.5291-6-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019092117.5291-1-sven.schultschik@siemens.com>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::7) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|AM7PR10MB3510:EE_
X-MS-Office365-Filtering-Correlation-Id: c97b0ee2-f22a-4a62-6c2d-08dab1b3941b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZSfNgvcy+fbCcj8lnCxOBs02DvM2ykifvw4tKPeekbSyhbaijhjQvB7XxpzvQ85QuR5GKBH/fMeYzAqkxc2Unv4P2UY+PNL/jiN/vU2LoxxucLPamz1s5ndlS0LEMjhtDJQWYU8n/MmJgGXgVT1QdcbBk54t6vge0ha8eVTu3iGnNH6JhG/x3TWUFbbfgESNSn5I+oJ1LxTcMPYf59Y3bzY+AW3zvIrDSgIAxAFvadQ9K5plRlVi4CLRGVmk1S7H8vXe66zugpzXjG1Ihqff56bErwHoJ/YAI6b7cYIAHe7XB1tNh1Fo0koCGLNMkGyzqFstIqRskQfJk5uUFyVkfNjieGMzkYFKtk5FKVpk9UZU3xuzSQ0zQ5FiVCf1qOFvofg2viVqIyIP8deqjhuh2X8mqv49IfC0UITS6r4JqlnrzpbfV00mHENCIG2FeR4jduDUmw88j6li+shsLVlbdTdZyMeOtUI74M3OY7r+8VSAzEEYM+/XYhxgc5Zd2JeVCXLtJTjfvr+M4y3hn5s7FRqStBys2FIumBnH7G8KhR6bUpARWSl1Te9gMTEJMhbuvlu0UGBeMnsMjGJgwCqnviHfok6e14Iu+28v5ZpbkmFCnlqQCe3ohicwrZrlHYMHtmmwFE90qYWhmm767o2Lp5kYngJziF243DHC9FfiqVIBFUXsJ0w0hGkQHJXeYg81kcnyxOjewInHi6suJgBDSg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(26005)(6512007)(9686003)(6506007)(41300700001)(86362001)(83380400001)(36756003)(6916009)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(5660300002)(107886003)(6666004)(316002)(82960400001)(6486002)(38100700002)(2616005)(2906002)(1076003)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tIFEKUid1evOIx4YiSVfr4ootQgobYfoag4F0ZGbGdtVPIKru8tRSn13+mjn?=
 =?us-ascii?Q?niBmEtS0ctTqzJFQ2qB/dk7j4+1JqTc+0WoctSOUuVpqMQ72RukdQjdUyRog?=
 =?us-ascii?Q?jx2Bj4/EnfVXyDMu47ZNFoUBKc5P8nQDVeUuljQS7Grnfj85kctEgH3HCMue?=
 =?us-ascii?Q?gaZbsuQ6CPhRlk8KC6j1mCuGb2jF7VkWkUmSoRuy7gR7UqEYW5iD9qvRdxe/?=
 =?us-ascii?Q?m32d3auE7SubxmKqggAQqYw3tUO2CoHJiJAj8g2sobQnXKKMK1Dy1ijEPOQY?=
 =?us-ascii?Q?ShkCVu4b4SVSiRi+w21wZfxxieMxeSPgF5Xh0i/0cCEcdZdXg4lWSghx5Lxk?=
 =?us-ascii?Q?zObSrow0g7vmbN7w4VCnfhehO2nMf8xKEYTzZPI4eONBknsEnQiDLXXZIv8u?=
 =?us-ascii?Q?o776U2RF2peC8nU8CG+H7Bm04k/MiA8PFdyWe634MAp0hrJAhuPCV+HnSUtA?=
 =?us-ascii?Q?C5ESNFzQa+preEnepCMUvHliyu2oRz6sl+Xs4130iZX9HCF32qdHdFlQkMge?=
 =?us-ascii?Q?xxqYHP74oAnAVcE4tFq0PcjC5xlEp/+oa1+Iy131Mpn9Dkrf+rgtaTbZpYJp?=
 =?us-ascii?Q?N1OjgSEQCotutpktd/1v0VqFITEuxjJelNuSvC6Trpj7I4oCiIy/3FKkPZGm?=
 =?us-ascii?Q?1e2QC/0zt0DxWLmjvLhej829mTlKiPnTJKqSh3EEIF/R+DkJSRxF4O5v7lCY?=
 =?us-ascii?Q?DF3TlzeMppKyXGG8C2NkUc8DaWgRPiWUFDibXXeB3wYYGOYG/GMdgPWqei0j?=
 =?us-ascii?Q?DTvG5GW/KP0mhfliIcsyqNE1S2aSl7hdvvDUTTP/pWnayKcw5gQaRwXK2YPF?=
 =?us-ascii?Q?Ir3MOzVf9fDd2sETI0RtzrHAYIQJRxWQxiLVQuY1KDYLNrXxpPUij1R6tOl6?=
 =?us-ascii?Q?XS+WuAL/aRaOSewxQLo699m1B0NNm4JuJJoBAdec0srB3WK+uJ4Y7lXsciCB?=
 =?us-ascii?Q?XLKR1TmXhyNM+SWO6V5fP4YQYO6PRm+UCi/hmH58aWfLuE3kWDE6FHkFuvoO?=
 =?us-ascii?Q?gGDMcWhsjC6cf7aQ7aLJW3F6HVpxtY+z6xPOsnHrsrtCseM5p8B38PHIiqIe?=
 =?us-ascii?Q?dZmq4hD62W67sRP4Jj14M2iTnUdJ4tKNeFgTthAnLMeCTcrFgiEs1r8KjOwt?=
 =?us-ascii?Q?3x5mJn4voQzX3ksklR0A9hqf7Vf8ainB0nh4HWumCIueBIwuCwmCjSWNGFov?=
 =?us-ascii?Q?XiNi1ZY3f252/aZNdr0pvc1yEFjZbgNRQCXO6aD1qRlXGmlVdYYSELhe8/fU?=
 =?us-ascii?Q?RXrHvs3acoApUrdPtbGQISZQxSvGsGePD+7SgVjw4Kjv4YYnefoZmnigE4uG?=
 =?us-ascii?Q?9rTnSJX+XAu/deUV5V9F/MMWD0skvkg2M55MjZ3OAzzIX9+cji47bd9P4/Sh?=
 =?us-ascii?Q?s4AMfio66ZQi8OATE67gKWuuHILa6g2UX3PRf0NbB7n745kll7NPvciCS7OF?=
 =?us-ascii?Q?TA548XNijlcbmH2MO2PDkrYSc+JYE7YhQdWlwbD1IqqJb8jq7DmjKZSSSdk4?=
 =?us-ascii?Q?KcYgxgRv0kD+li38hww1mfQMquyF1rCqxAQguL+0BPZK11k7QtV7P+JVfWeM?=
 =?us-ascii?Q?zeElLlwelCN/lR2GH0dZcULQZSrqpX0opKjWbK/Cmazx6EJh8xuEEGpnAMYo?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97b0ee2-f22a-4a62-6c2d-08dab1b3941b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 09:23:26.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxPabFV9zqaQcJ9+FYrvtoGjBQj30y89e16VqWXUMlQHaDlLlv+EKKnirWb6uoT7MmDGXxUMRI4FCtghrz8JMetOj6HBNG4pBSHDUrpc6vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 09:23:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9780

From: Sven Schultschik <sven.schultschik@siemens.com>

The start-qemu shell script need some adjustments to switch on secure in th=
e machine statement and adds the virtual random number generator if secure =
boot is enabled.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 start-qemu.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index dd16aed98..18946a6c9 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -80,13 +80,22 @@ case "${arch}" in
 		QEMU_EXTRA_ARGS=3D" \
 			-cpu cortex-a57 \
 			-smp 4 \
-			-machine virt \
 			-device virtio-serial-device \
 			-device virtconsole,chardev=3Dcon -chardev vc,id=3Dcon \
 			-device virtio-blk-device,drive=3Ddisk \
 			-device virtio-net-device,netdev=3Dnet"
 		KERNEL_CMDLINE=3D" \
 			root=3D/dev/vda rw"
+		if [ -n "${SECURE_BOOT}" ]; then
+			QEMU_EXTRA_ARGS=3D" \
+			${QEMU_EXTRA_ARGS} \
+			-machine virt,secure=3Don \
+			-device virtio-rng-device"
+		else
+			QEMU_EXTRA_ARGS=3D" \
+			${QEMU_EXTRA_ARGS} \
+			-machine virt"
+		fi
 		;;
 	arm|armhf)
 		QEMU_ARCH=3Darm
--=20
2.30.2


