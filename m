Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC056C4332F
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:50:22 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.47])
 by mx.groups.io with SMTP id smtpd.web11.22513.1668977419572189914
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:50:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=SlCtJ2bH;
 spf=pass (domain: siemens.com, ip: 40.107.6.47, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RujEWRLIpPEB5fAYiU9y75MCsl0+pgfj8CZr6BefY1tAOUKCG/8y8UFgT8fmpMBWzw9n6+7MoBVZpgbSREVcyFsYlWLMpGdi/RpdsPIrgJUgTsZw9vGfGTxsnW+2R1aPH5zLMkvNEgLN3Mi1TWK7/c2y/9sS1out+L0juDcARlVHdhRbGYOWrDwSGt2swNb8/zKQUlkBb6LGuY0fKWG92oB83WXHqBBb+P9ZdBtjrtGKOoTAS3wi7qjzN/7xm7gL/gRhUOVeWr8RBzyHHEFY+do9RDKWP/JhClMDXHsj/0s/+kSGwM3cztzdltQZN43siPofwLlm4Iab3PFFrWdnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68ObBLUGmv0zSm3gIMEVogaSsDbNOabZGMdqIwrYN/E=;
 b=amFp3sVfM0AwcfLkCy9vpGh2VMXMuQHI4DD2/EsM+5tlmhaP3qB8ugRVnCEXt/vYDbthSZ9s+qAGlrDbN5wa60ubtXNGT01+ZPUZo4uKoEcPeDRNZxJ01zTS0B4/643qzxn+ateV803mWUl5ffBt3yZZuJJ27QkaSY5iiAMWbjhqtdK1BAzPb7NUDzXPRGlIUEqYYJcq+ebq9Iw5jgTUtyuUwQCNNJ2Y7iJqflVlpOpUbHLbNXjecWXVYh4B2BtXNFK/b1gkAfLE2GGJOEr/JO6WfUNZ7YZoI8jzpWYcVOhKgqRvujKZnZnP5TiXj3P1jh1ykUZFtNf9vFmn7eE7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68ObBLUGmv0zSm3gIMEVogaSsDbNOabZGMdqIwrYN/E=;
 b=SlCtJ2bHhfeOzbxWL1/IIumRil6Mj0WitMD4lRJDuA+Uz1cfDkuVhaU5sLddx5J2G2H7ViKBp/0ZMYIgUh/b6FzXL+BN0ppLJuDo5ubrIXakBuU05tbKXYoi8c0BlgQ1EKckKQ6dZN2A+I7cjkkvDG3XH21QbPK6kJTT6NxVlSsifVkaO3dgR/qkiFrwKtr/b8b6BegfpVwKmylY1Lo/lLyl07TDxo4smIHVNH2vJX14tITvWX6qu00S/nv8G9Jl/ax37y40zzpcDY5S8nMQFU1C0L/Dfvth6cNJ1Mm3zQPyK2MZ5wiYYUwlYUm7OMB+PCu5F1R0DhH+BrGCAsU2vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:50:17 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:50:17 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 7/8] enhance start-qemu.sh for arm64 secure boot
Date: Sun, 20 Nov 2022 21:47:10 +0100
Message-ID: <20221120204711.5826-8-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2f27ea-7e06-47ee-9923-08dacb38d3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t+jBfSLUROmOp18KV7zG+y/aS691gB4DJFzn5OMtgnp2TeOY4p0rnzsYnh0txchU0G67pyrH7dqPZMJDDp3o9sWIIMOaU/hKkzC4UeXoPSDWYQ087pZE5MQgsDphawxTN++uFxJz9hGYLpOdST1pI0JOCJmHSeoVknfPEHIh/Hcasg7zwDYa2WctpQxRF6DpBKYo3f/m8U+Pm7sLq4IcaA1Ml6SCMh2eEHvS3pN9lRtRnGGvMOoXJBwkcx/ZYkPYUiEVAx0ReIUTZzgNTBDxaOAfoSg87GO/ZYiBYxPiTbtjUZfoQCc1aGIc2PlzvFu5Lq96cOxot9N7r/OEkJnUj6lqvu6STDLVeoZcJpLQBtjI7biG/o1TAu7byclVbGxg3BOAy06Oc36O68hAANINfK3fp/KM4wwoUmwIZvBd3CdyjYqKbPP8stzX3pTZy4PcwQzqCMFvkKKAruPQuB8UheEsENSV2ya/QHrKvTHmF0PFoIZy7T/A8RDUq0LjSw3GvTl9NFm97R6aRWCa1MJzMuIAzQo1L7vgx6c/uuL3WRNGImI8bg0fveg7A+ewxLjayFqSmZ6Vf2W/xrCkP8Uy8F6UI+BzL3YlUjsp0Gi9gCZdhzaEpNQSyzhn0X/MGwyBFO55l3lJNAy4rM9wZ7EFGg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(83380400001)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(6916009)(8936002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(6666004)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nKD+tp8ofQWp3Isl18Uw4mFxs5lxkmDeXHNU9AxdkOUv8nTmA/gIaZnln6ZU?=
 =?us-ascii?Q?TnKhzfCRA5u2JNSKpK59w95rdq78EkmuGCuLJfEeYbFw7A5Y1QEMpHbUPg7m?=
 =?us-ascii?Q?ZA65pmdj0dpYSIYQcZXoAhwsVX4H5xEouAqEFgfxkARPydJuBiy4jTyEz7Bw?=
 =?us-ascii?Q?75QMwq8DhuD9L/9qAGd0j9q+xC9zrISV/r2tn+DgzK3i14P/9rQWAZnBe+rW?=
 =?us-ascii?Q?8Q3hTCFFsg1sRPbYzjwoMm4yt4cphTXnZMnsqjdvUdgRjooQEFM0z/p2KzLv?=
 =?us-ascii?Q?JDk/HE837g1PjS2iVhcjZHwWwI45BXuOBsaueLC/VgFTCbJph+aaGIRjeUct?=
 =?us-ascii?Q?6Cj1yjDsMK2SCnkPxZMZVtqf4l16GyOfDuse5dHIf4wnxsYBhsJMxR99vn42?=
 =?us-ascii?Q?Oq+WX0+1YN2xuGVNCWkDFu5Fg3+gRrXENQZwEGjCmFYWzj91Gm/Z8hzBHnxD?=
 =?us-ascii?Q?uxttzjiRQvok7fFhMBsru4MCW6xWlHsmHp9wrSlbAlUIUQIbjPzLNVVRHXoc?=
 =?us-ascii?Q?+/vTMrx0C56/ntyUcNAQ5q1wXjAoRCsoCMw9mRJJEPrtkFWd/oqL1Mv+9jXC?=
 =?us-ascii?Q?vy1m6P9Gecs5nyyJlAckBf/u7NH/CDKeCAZX4yNLJz1ZQCV/h9On1iMQm2aW?=
 =?us-ascii?Q?eMYVH0TKDkJEEcz91T0kKuKMNiyuz3tWynUOEOJWypLrXOYf26P1YRND4Zrn?=
 =?us-ascii?Q?MW6imbDLrYXnCvLVPaK0yjkJY5hIbZPWVq86jpHdH/ypTlMEJi9mQ7nUIFvE?=
 =?us-ascii?Q?VDrAde4tae1l4sV86oaJ0CdLkMbMPdtxWG9ASOktzcZCdXMXwGWr7yari/c8?=
 =?us-ascii?Q?Ud/gQyTdUZoxshZlZ+O8ZswyzWV+qZwyzNm4GZyJTccYGVjvjQ/S0v/z2DMC?=
 =?us-ascii?Q?eFCViRmoNPesLNvgsh5/MLL4GWox1we+/kCkdEHRjBngsGUIjhCHsh1XKWDg?=
 =?us-ascii?Q?AwBO5sYLwNGDTWCNw0mHklwCefeA5cdUFgtpAih9tvgKY3Ub+VGRtiTvFM5v?=
 =?us-ascii?Q?7A33XSkflNt1VWQbGneak4K6j7LZbJa91s3QwakI1TrW8pl3mFegitMcbc7V?=
 =?us-ascii?Q?rEFLGI2PTz4OftUovzY0LvIywRYnzzkxrGLY7G6Pd0xEaVgiSUyGYzvl8tnu?=
 =?us-ascii?Q?Iy10n+5QRdvxfNmKvU8GaB6mRvzfG1x1CDrAX0GKw3jUlDM39gEXz7WZXbkp?=
 =?us-ascii?Q?9HvLAx28yTn59JmnMTiXDABepSbA7ymYFiJ2+w/YBc13wKVBIyZyAZ6jBRXC?=
 =?us-ascii?Q?OrwYCAYEWts3QDLLSr1saWUaWVbrp0TdvzshgCgjwM0Ty81GLWbslreyu7BI?=
 =?us-ascii?Q?m8dDGyN1t9W6dRW4udrYzzWHOner6ZPQl5Wvh3zmYaeOzbqRsm2tt8N15nMR?=
 =?us-ascii?Q?pgCmeMLOppTcPoxkmXGIe6ONEm3tAocdlKt7EBaT7hYZS2cfOAlT9Z72FLF6?=
 =?us-ascii?Q?1RaVuCu7pSkK0HHrs9IZtfo9zB9goO6n7cW5t9endBqbbs21V59jdOIozvhL?=
 =?us-ascii?Q?faZkQo9gqbZIikGjQpbdztRJyKHy64nNmw1b9AiPrbuE5nvc74fDnyluX3j5?=
 =?us-ascii?Q?8LGB1FzfvJYd2AmQfBhTALkwZ9vbcP6Dcq1sOYQNSef8dAAjUvHcRDFc4m6P?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2f27ea-7e06-47ee-9923-08dacb38d3c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:50:17.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J83VM/CQHbKGYzKPEclxq5S1wT9w5q5C4PlQ+rTP4+vG3Fa1o1oKEkOVQgo0f9t+HEKi0Loro/QUth4m32AKaG/JrIAg2TkNtNtLDovVTpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:50:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10060

From: Sven Schultschik <sven.schultschik@siemens.com>

The start-qemu shell script need some adjustments to switch on secure in th=
e machine statement and adds the virtual random number generator if secure =
boot is enabled.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 start-qemu.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index dd16aed..5617a2a 100755
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
@@ -165,7 +174,11 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			fi
 			;;
 		arm64|aarch64|arm|armhf)
-			u_boot_bin=3D${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH=
}/firmware.bin}
+			if [ -n "${SECURE_BOOT}" ]; then
+				u_boot_bin=3D${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARC=
H}/flash.bin}
+			else
+				u_boot_bin=3D${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARC=
H}/firmware.bin}
+			fi
=20
 			${QEMU_PATH}${QEMU} \
 				-drive file=3D${IMAGE_PREFIX}.wic,discard=3Dunmap,if=3Dnone,id=3Ddisk,=
format=3Draw \
--=20
2.30.2


