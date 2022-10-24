Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B06C38A2D
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:28:57 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.67])
 by mx.groups.io with SMTP id smtpd.web10.18723.1666614531141238972
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:28:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YpwmiY3x;
 spf=pass (domain: siemens.com, ip: 40.107.22.67, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S42+EvgUc9gzAH63KAoXLLnhraxmYS+KHpKLzS6UBmbI5Vowh961bJuM8+aOX8S5MH2imIqkTvxkmFT/TWBBSEtxPBnpdiOn61Xsbb88bvgy4qzv/5YRLQeKUHTtDIAEW7H0vui8vofpcED/fCpLGp1PeEeIPrB5wfOVEL5NJEB3/XgDG7/HNieqQlxNmkTRI1tdokAok8ingnuv58pNu65oIdeodTBjRv2nk0pzWlNrLGVV9bTGKvJe5xlMLDjo8RZE9/qXVVEEq0RHcn7qCt+P7VzpOzIueBqzGMmkTXDfPWwx8ir+f28IJ1i5WtKs+YG+1y+j7CeknFbKaOtfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liFCM8giZCFQLY7w62P7vdTEGzRf8ZYwoE7rWQzZRI0=;
 b=bq6r698zJ2WH0fcZ2IrRAC94/BW1QQ7aErjdZIeFocXQ41Pv27Wl0dbO5n3C1b2cdCqjT7olbu/u4iqbm8/B25Zq4hKN5aEaHcnmPV7QPEkB+zD7pKyzoCx7uO75g5qYY4d8cAUHUG8eiALIis70lv2okPaJAXH6ATzAK5AEs8XjUt5rDEtpyRKlv2SOvsI0fu3CbRANoHcqqAo+9l2PYfDHWwtTGmpvymTb+WTcNME4NA0Q6jZlFhl7EPmioCpqJOFoc5IawTZAh2Qh/TM1MwKyjVX0lDTOBULsK7auJMMG+vUbQ9S7Kdh3DjeZfDJD45CuyV6kBPvWeb2X02Eezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liFCM8giZCFQLY7w62P7vdTEGzRf8ZYwoE7rWQzZRI0=;
 b=YpwmiY3xBdrY+7OS7Ut2WDkLaLLa0+PsQcdR9eedGWnUvGHMv5UyTtvOsx5VNu9l8GgMFEksaqh0hmKlQfbu1CJPb6BIVd/jTaiymh7lR0FxeEk9msML+YYK3qukEtrMEdisVqaR2Dgp89sG1eUQmjyJc1gVmF+ajUcHpdUOe2X0YEbBfZv9wug02FUX2DXYzkyCbTfeb6cRs8QWFFc9EpAropQHMM4LCiOLioeXOJxF2QC++h3hyIz9rBqqGRGKvYK9So4snvfFEc0zkcUnCmcojZ+WgyXGLkYoN5iMmA9BEnArznvsB1o2RR4OLKlqwA93GYwYxJS1SKaYYGMrjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by PAXPR10MB5783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 24 Oct
 2022 12:28:49 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:28:49 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 7/8] enhance start-qemu.sh for arm64 secure boot
Date: Mon, 24 Oct 2022 14:27:24 +0200
Message-ID: <20221024122725.383791-8-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::7) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|PAXPR10MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c8f238-d653-4f54-65c2-08dab5bb4d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X1GtcJN60A1++kyEH6OHEPB2I/G11mvtCp86PYnpAEhzWyb29JkziegCsfiL/IKAYV+mspoPCd6VlWszDvQ5R8XY4zQ2rY65NpYt7MUNe1F/iaRQ940ku5pAGim7JkFDsE7HI07dPz3MeD7udRBPSl14V/kbg/p9139nICb86reHDKbzikWZlk1d3KuFhmJSNzyQ6kPZ8PAsMn/jmp6RMS69eDz1kVnRgZRADWnf9q7Ip+i2NcBOoq9m9KhedIabacZzpCAEHDfIqSGEnwfzhGoEVTHCH0ffu9rdbTInWzjic4k2mUUX0zFzMb5QeuxjDb58vgveCdwfeu+pGKi4MZHiM/dftF8/MvPB1xSkT/lRpOfhu9kx5yLyT8CpC+xn5qrA1XMGek8/pJbIYcf1DI0fHRaKYpPpFfBO+HBj7GyHDKqCXdYdIhBcLwD5Ac09FvZ4DtwCwzmL3/1jnW/GgIE+lSIXgShkVMan5c4h3ibR5+t0m5Xrs1wzDATVju/UUVjaGsfzkaDs3I2mJLBFRosnHrEMqBujhQIxYIue+dqVKSVLIH5DVCtMrWyFS2R9ruW3P12MTQD4RwH4pxog+nWNcZkKDeYEIs/nBYEaIP5oZ/UdPwenufYEvLJfSVkMH050SkOqshYeiWypac0/w/zLo03plNYKSl3jO4etdw3KEZob4aFy3k0SwBCerqGCAHzz+8ON1onfyDDAwEKbQw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(6486002)(5660300002)(186003)(83380400001)(2616005)(316002)(2906002)(1076003)(86362001)(38100700002)(6916009)(6512007)(4326008)(8936002)(66476007)(107886003)(8676002)(478600001)(9686003)(26005)(66946007)(6666004)(6506007)(36756003)(66556008)(82960400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ovpo3pWizSHnNq7SIeB8aW3BJZwu5f1fybt0DOimkcVJkNDLv4iPVfpeGZfp?=
 =?us-ascii?Q?mqZWUxdGmIFmQJctih1rN8Ljc4kT+nQCoqwwjz33o+CY5+aCHvXZgLdOS0S9?=
 =?us-ascii?Q?ctII0ZMd64oEbiARRZX43NMqercZpWynVmAQe9wSKtK12zhweC9Li7k/Dzly?=
 =?us-ascii?Q?SfgAh+Rgvf5ZX46aGnWlG4f3p8MBBlCTMg9SBBQQcid0NXSa8+o1wzH9d7e9?=
 =?us-ascii?Q?L3bHS8UCAZmo42AX47JVRlk3mFjQlGJKwKAI27bt4chBIVWvIbyMOz3c1etu?=
 =?us-ascii?Q?JnmDerI5+sjOQeRj77QMYgUIOSVU8zsAex5S9oijXa7Umy/uEd+26LEcYerN?=
 =?us-ascii?Q?WbxmCNmE8xv5B6FPvP/nwQBJAEEFyofXcJ5hbKvJYkLiBHyX406S4XR2KqDV?=
 =?us-ascii?Q?aJm0zhFT2p21IFEQX9f1xYQt0hqsSiHSgGyd3vtyUP4jDDmo66z7GNRweI0x?=
 =?us-ascii?Q?Fr0aqyXruUeasTSWdK4AeqSvcOXjcbTVzENfWl1L76dzdH4rXJWC5K7HNwmS?=
 =?us-ascii?Q?W6Myv6Dwz6xob/C9CjeFOvtUop05BWSH0v6kQ2WWmCbJzmnoARXvU2HaTLQl?=
 =?us-ascii?Q?TfA1L+B6Y4z6aSjjDt7+BURWY1LjYsHFzETsoJas7SKOBKw2rI/qKIc0q3O+?=
 =?us-ascii?Q?8yvwDBsyuVsXPWO81rgO4RKxH9Nap9uUID5pkuYC19qpOxHLk5y8xAS10bEi?=
 =?us-ascii?Q?qe9+v9sXkSuSwzVWjrJGJ/NglDH6Cmrng968L9SbYpkXaA2DKVFgAhRxrqUF?=
 =?us-ascii?Q?s0YwEbvtFP7Jvp4HfA4xoce92mHG+HDg3K+NKCBjcGkl7FVskYpxecHLoefj?=
 =?us-ascii?Q?sPgIWFmQaa4Lzu7VoDtUTtl9WY2YgnzBwa4K/5iIKlxtr7oDCjQS8Zjuq16j?=
 =?us-ascii?Q?egM7+YjjDUNnwSbaOYbwJsn9kaaHoSl0+n2gtJFzAD4v2KYOXHbDAOefp87n?=
 =?us-ascii?Q?4+EZw+NMOzuQeDPcr4+hE+N4SPzo4SNx+e+jgPIoTjhveFlZqLkne/4xyN0G?=
 =?us-ascii?Q?1EYzJH+OEZ9LgXGm4PiGFUnvQmi1oSamAjmnQct3IXXxQdYDBeHvKgLrjavS?=
 =?us-ascii?Q?6jhOiIoikpG1uVWexAlK8Svb0SFF35OrWga/pELAH5CPeWhizleCaZcz1zLX?=
 =?us-ascii?Q?E1TFIhsP4QTVVrQ1UWa+gVqbzj5AKJTRh78yALs/rq9QagAcJJy4wEyI3Zog?=
 =?us-ascii?Q?dJPu9RdmEQ1pgyWdvPn7OTND2+x2s7FLQTFt/Y3n3RQ0ZHPKEliooSOHSh6b?=
 =?us-ascii?Q?Wxgpod46FvNRrBGHzYnEIHaDsIfh26k3hNH1EMU127jaIcl67giu6r2n8n9d?=
 =?us-ascii?Q?+PQKZk31EaCOTb3S0JxiotQRAhDNlOmeifZYGMsazuQwVj2l5bNSli1YB3Dw?=
 =?us-ascii?Q?dSz6wthWGr00fSfEpTUbxkK1oCXzE/P1XAM3/gSd3nAja9PS4ZZcQkPOK7ej?=
 =?us-ascii?Q?M2+PV/xoa+62pU7OJ222TXCeAAuR7fWfaCnaxPFcJWJCbXvT9RsWl7nKCWaX?=
 =?us-ascii?Q?suZY699Obty8abQ7cC6+t6G7rGkm8lLDrV52B/1jrxNNtVsJEi03DfjP+IKk?=
 =?us-ascii?Q?M7MO25r6SQomDnCyNYz7dTnD3OCwNJ3w3G7/V4F+djYaoZNbOvoi8aXBZFln?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c8f238-d653-4f54-65c2-08dab5bb4d90
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:28:49.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKz5aHr3J0Gjjx7tBHoC8LSwdHui0T8aLfccQULB8r1JlJXH8koNrWxGqUzURukOTc4OhFIraB6S+4LzpXav7VvIso+KY0COMjswnTTChVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9811

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


