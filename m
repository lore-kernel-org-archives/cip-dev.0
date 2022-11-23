Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66319C4332F
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 15:30:25 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.45])
 by mx.groups.io with SMTP id smtpd.web11.23243.1669217420752158832
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 07:30:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RSESjxtL;
 spf=pass (domain: siemens.com, ip: 40.107.249.45, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp1dSxCoMOvRjashMIR8WMUpKEWIXTQetj3+I7rQFQHB3DOjGgkVdibn5whKl1WrYCHpnCDxaoZzcmJjanth6YyC4vk2wJVVDXUapBRjoDCL2vvy9fbN7l87DQ3xzJeU1ef+pdPiJPQXhWW2MgsF/Frf3BoEytjkIDk1VEYaamARb7Nug8lmk6aaf8s2ut0Rvrb8RGcGxQP6wUA6kcdB7TgZvsHbGy2VmiqkwEd9dpmcX9As/B9zHlZPjvoOf+kgTL4VXOor0iuO6+PaQr91qjUYZ/SyOby0eP7yxYr3uPJn+iZfiI4imU/ZjhPBfNfqVXYp0J75DVDxakEErjKqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68ObBLUGmv0zSm3gIMEVogaSsDbNOabZGMdqIwrYN/E=;
 b=nUMt0wlGxnY0bGtKHHC9Jjy0S/q1jYFIIWo9aoDD7e2jeHp8REBd38C9aQl9UZw13TA4jrVMssXoxoY2zIT2DVU+8u+Ox2ST9JzPRN4SPGoWlZm2JCQJa+z7KUdw0RGTGDA4DDmnsrD9pnoqhldah0owYzv4PuCIGKyIBZuCY6wgTlkUmqbKlqbs4co3lSLjFb1JrfJwWlm9Io/QYE3JCukYOHPlyUmCXK5X1vZriHK92t6BjcUIpLfm8ZZpOgGKtpCDS22Mb0UOqpQmc8bcdad8JS9XlsI1H8M7y6B3GDCQexm20+wPq1t03T86EJhKONOruuuCuEtSG3YHZfSj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68ObBLUGmv0zSm3gIMEVogaSsDbNOabZGMdqIwrYN/E=;
 b=RSESjxtLdO36ID4kMbTdJysQJKQTrLnTIV6qXiFLH7LH0mlfMz+V46BUEyfopG4piCIUcaigohmaVK/DaFBkcxnkZq/q2eSt0yj4fyY+SK/z1Akmwd/ivMcL2MOBE0dDcfML2b6qtrKxcELhpId57aTr18tW2KRfkvDKGpNdEWquD6SihbRmCPeXcP0C/Wblpf7koQyATcbJQ/Y1ipR3NbrCj3gVYjwu6vme2R0q0+/OCUBV8NoVg79o3HiC3heReNr2FG7zHhr1aD8jJZMDEtsmEzaLY15W3TjPTtXx/bl87btHIHpL6nupkdiG0oTkhgkaGTC1lyoUE3ACxvII9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:30:18 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:30:18 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 6/7] enhance start-qemu.sh for arm64 secure boot
Date: Wed, 23 Nov 2022 16:29:05 +0100
Message-ID: <20221123152906.75323-7-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123152906.75323-1-sven.schultschik@siemens.com>
References: <20221123152906.75323-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cde1ec-e49a-4b2c-3022-08dacd67a05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	auLyEou5M4s/+rzux1Vg7oEbqbgUm3UwEvoTkNUQY27Hc5nvEu3BPiXRkPgljJPauYk0VpRHBbc1UpS+EU/d2MWXT3L2OCU9akx9MRHSC5XQoZWBASZjcC5YaKR0pIfc85bMwmxTlybkfBT0HIy1mFG/bi2okfHm1pjmLsWxYE6eDod5OhfB8HhsyqY2kC7kzuBYlAdTsOdz6E3efEmml4x6wLFvZbp9FWzlJlsno+2AMNGQLGBa4mMsTnOVjngIdVarOniOWVr58VIfnk9GWeuuvYRV0B4U7KkvL4LhIx44aZN20+qWJtzKiakaDC+ixGMr39fw5U/PIU93AnmAHX13VQ26XPw9TGWP99lHLwZGLtrgFCQSd0F6yU1+iIYNCCGplD8RxDXjanmZgPJzajP3vSEC5Nv/xzERnOZI4JKQDggf9z7Kg8cdI9YRQUyOPrcKfr93pdsJOtgoU5qI/3ZqoFmk9crmUJNqBEQ/BkzIDGP/mWMetrOtscDtNgR2Qnpee5I/iBsIVFUnoPLU4Ua0Xs2AD9d+fIQCPDiie9hQFqbFMrCSE2ubNEJ17OIXVw7vuPs7IoRaSYYH5EWX76ISLn0XAwC19x9/I9d1MK+sgalo6FXsPSgSMIBmdD6BjZqNLq7pZSpGNTbuT/2/SQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(6666004)(41300700001)(107886003)(478600001)(6486002)(9686003)(4326008)(66476007)(316002)(8676002)(1076003)(8936002)(26005)(66556008)(66946007)(186003)(5660300002)(36756003)(6506007)(82960400001)(6916009)(55236004)(83380400001)(2616005)(86362001)(2906002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9S1CVvQ1AX3UKOGbf5d+4Vt031WmLM4j+P4cw8lWliHGivTyo9WbzjEkqUMg?=
 =?us-ascii?Q?W1Wg+iWxQHw/u7s+mv1YCFBCaVhklM0mB3YoRhNQpDqv3SoIVsWhbeRJvMYC?=
 =?us-ascii?Q?p1kgJk4tYuznEM4oqkvMiLvL2k5pFpZyXZjUyqyrSdx+PSTifdb7PLvrdwW5?=
 =?us-ascii?Q?R/dOoF5n+zY1ExX1Bs5cEZTfrews3mdwZRHP2KY1PmGhukAPaHID8Y5WFiyu?=
 =?us-ascii?Q?MKpBQdeDKUmK7mrQh4am7qx0UUEwLVY7B0UKZ5x8QeseBD5biYFzg9Vlgt/0?=
 =?us-ascii?Q?3YWAgqe614YU4OPkMKuDjSsSW9B6q9YVRriXyPDOwW4kvCjbzNqb2ynz4kjq?=
 =?us-ascii?Q?UT+bNvHlh9ZVqMpC2cu6F9cDRE6LejpvxSsSl3DSRfHCfk1yV3BM3EvfqFnI?=
 =?us-ascii?Q?jHVTDQPj7PfbANioRs8KaCS35M1004ovIdDI2tzqJ3fJRseiwSHRtvdwdTGJ?=
 =?us-ascii?Q?XeoW6oDK9dlg8uWL+FkfaTH9daA8n4ZQdSE9krMmL2zZRVVD87bCHbtn7nBb?=
 =?us-ascii?Q?9zDBzT0NF10BJFtGJ5R8K8SEWeyIV9gRhj9NkjEZPp2098jao7eAo6M1SGC8?=
 =?us-ascii?Q?Chj3AnvqWofY8FAql8+RrWcxNfos7dnQIz22s3VwAUtcPq0b5x+z+4qzhLDe?=
 =?us-ascii?Q?IHcftgqjzBgCJbIyNxvlcVbevselebcHaMRhS6MeWnhwGQVlzXvn+770HWJr?=
 =?us-ascii?Q?x6anBLDHl1rRS7pAD1i7XMIh7HC894w6SDc/5Utz0qKClGuLcpeBvUa3nPrk?=
 =?us-ascii?Q?EbYrNW0+a7Ts4oNil/Y9jybsKY2UoLZKtEebx3lJvqDELNYq0csmlWdvyCQ1?=
 =?us-ascii?Q?mYbnwoTjYTPf61rHD7M/qcZDapMN04fOBMuz1sturuC4fUqgQN2/I2YV+Xup?=
 =?us-ascii?Q?HtuwCML7Ad9qvpCXhTr5JuyT6DXHcsbGGkPqIVbcnhRWo+rswp1vUvuFSVZp?=
 =?us-ascii?Q?Cgd7ClTvvrPCLMEfdeXakgw4J8kqlOoHrgIFdPXDMSKvZurip4wQ9AMaRUVP?=
 =?us-ascii?Q?iXM8kYlO3zT8rg80wESGB4uLBEH04AmI3Zk5FgDz4cAIlgp6lqMDtRDdQOVt?=
 =?us-ascii?Q?Mv/b7SEOgo+kaH1yThFPY6L5cfftIHLIkDGiQVfUnJcug8czO2knVow1dsVw?=
 =?us-ascii?Q?UmvDtxTO33hw7HcvBZeVOqG3PbqPL5LhYwhHXpCX7ToqJ61eXx19r/bv9XTN?=
 =?us-ascii?Q?n9DMSt213idO4MBXJdphkDq5haWRtaIwRJJ5pVMkDY/mb0w6uvqM2F2WFzrE?=
 =?us-ascii?Q?mOo3fqfRKXHllxhft2bclUxZnwllD7C17/ArwgShz9QH0EhJBc/3Tjk15+ct?=
 =?us-ascii?Q?/rt+7tAdaX1bAUt7EHetbrfTf6uiRx9X32GuR42Pfn8EiOIE+GSEdRw8CXWt?=
 =?us-ascii?Q?qrQDIo06HxYRl2DybO3nU3uO0fv954TNGIyOKp0/f9+nAW+A/tlfdBmpb7Pn?=
 =?us-ascii?Q?gk+mTM+xPTAuUDGm7fw39mvrcF4zSiWg1rPrhYwTStjMP3VTfWSek8Qr0hDA?=
 =?us-ascii?Q?FCR9jkAGchh5nbdZwszIEk2aFV5ngvey3072UcZe5WBZmLGRlEqEnwV7dhDC?=
 =?us-ascii?Q?9qlikTSymJN6DeBA6IcISDpiagAF6sAHN8SKV6SIbFrieMRC6/P8Zy3T3alV?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cde1ec-e49a-4b2c-3022-08dacd67a05a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:30:18.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0UNte908G+cPRojU1F651zEVF8QLYh4DKN48ZHwJwd/4WX/qcb2FV7a7VHJFXmpaTZbt/6TwjaotjTFNAGvk8InyiZQITTs5r+XHxiROtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 15:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10096

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


