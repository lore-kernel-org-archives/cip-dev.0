Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA79C433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 15:29:25 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.47])
 by mx.groups.io with SMTP id smtpd.web10.22943.1669217360624698783
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 07:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Q3vM2Zrn;
 spf=pass (domain: siemens.com, ip: 40.107.8.47, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwPZsJ6mP1XFUsLPRgsYEZnFA7I/9QTErgfxbNNIxA5HMp2jnNrORLvrLXL4HogtKLV9gH7JFxU697KsC+kx+k/U1KPJieyt2ibgNSeCos5mG1o04sjDIDDCtgyc4Qxif8TDTaNrUmvaDqLD0CwgpAtw9rQVB8wTk0swfyUzc8D4BntLcpnfTxvq+ZPNjvWY0XdZ68cDz3sCgzylzY/NMv8xeBVcNqJ5tqeITHjB58p/W8RAESoJH+lS2BtkGoBy/ap6kP8Ma2SfP5lsYzkkPbrNxCARAhl+AC5BLBcbOgeBgQm6kEV1lrdQL7QyKdwcfJQsOnM0ls2WWY4do67tVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BhNk/ecIhz3210uXw31u5ORFFSHDt4P6XeaQ9DVPJ4=;
 b=fATD/L77sXTFVr8Q9olxeh68bD7W2UeYxXc93YpbEQ6wZr0rqeuaIP706gm04+gTsLWu3BBCD6qp6nGdx8AdlOx9fqdmz1jdcDUnigZCu0ahL1fGTVea5iFTIZQtWzP1OfveL/k1BBYVDSQFzbfBLS+DdYlLXhuU/8XjymldDLZVe3U+r+WWZiCzPTNe5wAIqUtOIe35q9BPC3WWXAlCfhAkmgfGmmdQFe9BE455JV5kK1uWKKI+dCOqHIhLSqBQBsq7rHT5di9vvqyXLjZ3lkdmhuJTwFWayWlc/W9fIP9jN7cKPAMEIx2mF4L8+i55zR91MN5zKCDOywfsC9P1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BhNk/ecIhz3210uXw31u5ORFFSHDt4P6XeaQ9DVPJ4=;
 b=Q3vM2ZrnINOV+MWQcfe4+8lFkBJHhgn3k9njyKM18KsthZpiAkAOwkiOxRCHqMp6BCelsH7QIhL/L2zwUp48u+7pDQA8WuTAtO+5zKg/xq/kzNhG4ekqIv3zMT+Na7Vj7btT5XdON+/Y6AksVtECS1x73OUo6H+biVHU46QSJqNiozKjykilYPEBlOycCQFzQv2kWS8zkcfXsVr81pxCuSJYoTD9Nm0njQLmV+jwVYyH4Y8S1oRIlf8r5FYnZyywQSSrM64PRa+d/p3YIHN8ZjgGDLkGA/fzS0yvmt2GIha3bTB5qImkWBuiQyh1cikSZhsa4jFqr6JMz82mqFZQOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DB9PR10MB7244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 15:29:17 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:29:17 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 0/7] Secureboot on QEMU with EDK2, OP-TEE and RPMB
Date: Wed, 23 Nov 2022 16:28:59 +0100
Message-ID: <20221123152906.75323-1-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DB9PR10MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: de41a595-4901-4db3-c05d-08dacd677c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PX03pKvksa0+tIqSQ/SPp7H7HN+90qhs7BZw9H3k6H3cSRYLSpZtE+srBH0P511VQXHpX01kYNbMEUZPb3FiBhzuEx4J0VpZRsHeOboA81TCDx8Nz6i0VrXvDS+QmcOCqC3HGSXH7FOY79cWQZ05uV8y2vcpi02HYdaQwBffhadZ4hXvD8DzMXr8L/HrJDw7ExdK3Rv+cLvhw+uIfgqFypcoj9YFSeVcI7idXeJnCkpgsC0spFGISNodr3XY+lqbR+k1aYuLUBvf2UfL8xifb//UrFdkPS6CArpe6NIioNFgAggx3dqZ3LGwK5fdasrDmZfZdQFrkdxbOuf2441GcJNFpu4IVmtxrwuGv+I0D2baa2NEHyM2t1ePACXo3wzTpxmRar9QQW0qDZbhNL3q2tT1W8Md6hc76AOl110NcITMJQlQhI2OfR3IVpsfmdLpz8uMa2HXelXIRZmHKV85z2nhDMVu8WSP1s04XGAAjx7JZn5ivWo7sA8HmCAiLHTnLVJYYriYs67j8+plgcLbZqcNb59eqOW0HQIzeNu0xbWWQT2H6YGyCmtTDRUUG4AsudL3iEq27QEyq7swfhIwmEBlFcHpDA2NXtaUGKMaAPxSIJmz8amPRBF2WS83UYZg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(478600001)(66476007)(26005)(6916009)(316002)(2616005)(6512007)(5660300002)(8676002)(9686003)(66946007)(4326008)(66556008)(6506007)(55236004)(82960400001)(186003)(41300700001)(1076003)(38100700002)(36756003)(8936002)(83380400001)(107886003)(6666004)(86362001)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OO9+qvATlB3VNKM6vHOythlEAqFgW+Llvgbh+RAWh+Dv1UQ1THASlzS1oDqN?=
 =?us-ascii?Q?+bssbPCcYL9BT9J5Xjt/4h6i1oHc949ZkddCAa7RgSV0HKENaaGfoKtESwU/?=
 =?us-ascii?Q?wIKEZ5JZobyDNVs/XtuQh2l89zcYN1vHvKu/evf5gkum1L7BG+lNpu2Oefnq?=
 =?us-ascii?Q?Jdxgb6mB1lbwfiCYc4jJWCJtU6lw1weS2zsKxYuWfuwLzR05glL5xnnJfjzq?=
 =?us-ascii?Q?CrZsz2536Wnr84Zs+q7k3/IKpCzuKpvParJwsjOnkmON7Jd6hD4gb4r8aYdZ?=
 =?us-ascii?Q?pKwXMts/y7o3SkdS0DiJOIAOb2vgOcu1Kfmo+r91UHIgGMd9yBGXPSiJR/ZL?=
 =?us-ascii?Q?ZNCSB/PpmIsJLJP2aDXAoEcdKPUme52dj36gOSc8/BlGimh9EwrfJiiypIBS?=
 =?us-ascii?Q?R7uHPK2naJ5Dq/Lq5ntcDOB46B5+DN6PoWvCWClgmxZpMuh1A+nWXPy7CcFe?=
 =?us-ascii?Q?4MrsdiF+88c3jjq12RUhWnrJXH5x+DmBlk67/dNCCvflV1ESYnXXJJfdoD/P?=
 =?us-ascii?Q?Nxb0K9Hi7xHQk/lQsUfVPD0QYKYNEFVbFioDCmW8YerOen46eSTosU/MVqXf?=
 =?us-ascii?Q?+xjW2u1zPdV9D4BwDH9OQ0KQGf5UJ4n1lp28pWj8ZT3VpfLddpdy98Ys2BoV?=
 =?us-ascii?Q?IaKCCU6/WMGiPjYP+1QaF6LaJ0itYFk3blaVZbLEBQ9lJjo3QqW+BUZWTu1z?=
 =?us-ascii?Q?nfakcRdgh6VVnxrydePFXv+J3ecukds1SKQC3trP7NgOMWSV7DAjj7A9eCqL?=
 =?us-ascii?Q?m0+04fXtpTCwiOmK8UipsFfKThVkvlDsbVOPJpZeAd7DjR7YQTjdRyXkjeSy?=
 =?us-ascii?Q?aFOVNlzc6NLMixEeeYcTK4Fa2gVanCAHSeOH8ozRjuy6t+MxMv9VCWxHq7xE?=
 =?us-ascii?Q?uUionUCgtYIv/lniXQGzGQLgMw4JaQagTqXRl0xFkgfvwysCiJP+TfB8rDZG?=
 =?us-ascii?Q?L4D1wGk9xJxZgKyHtvYB20HUqr3NUscwxqEoTm4S5EcJLfavTXXTznRQzy46?=
 =?us-ascii?Q?Gw8GYH7gezovoszB8n0EnJyiqJxanuRHmggClegSywdQyUM7YDqgK/QB4LHa?=
 =?us-ascii?Q?6R59trsh0UeGO9+MxXqpmWH/5AGEZKk+hLj10F1MYf/jqShzabsUrK1yh5uf?=
 =?us-ascii?Q?xm0J0zwzR6M2VrdcYXQiuJEtUq745BckTAiDVUkEHnU/7qKOmbUkxxf0qVBI?=
 =?us-ascii?Q?THrhO0RLsfpgVVyLQZqQPY7FMP5s5v8dYsl3DWjfuj4+q1rWIE42flnxfpGs?=
 =?us-ascii?Q?aLMGr4SQIwiPAdIt+eJKWqR9ItipDUbdC2ueOYkAUmsXwG2sUctJcMKAPOFr?=
 =?us-ascii?Q?iD7RrNwTj4t7mK3cJ7OD65Uo4z2nOhcA9USXpKkZkD/wd1VIYtB/d0+iwFl/?=
 =?us-ascii?Q?roTZv41GD5XTokhe4OWUmVNI6fnMuxelIgsAeNbxLwoh2osowNlI8c2IMol5?=
 =?us-ascii?Q?WUoWGuyI5F5BmGclHMmAs1tpbuvOqBLPxBcoW6dHi2rTEMqlobG1wjjr/Z/J?=
 =?us-ascii?Q?QfS2zXfJUNrNj8sxmlQsVTzWIQMc8mvDoXz20GaeUxzmu7QfZFJsMXj+xRnF?=
 =?us-ascii?Q?GmpEgB+UE9QXUbcWY6R474smgLrGWMT8C/J0Fi1Jl8gg68BipMP8M28pfRSe?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de41a595-4901-4db3-c05d-08dacd677c29
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:29:17.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/SmcfM/5NaYu2xuQULNsJ8lQ1UCscUSAgOWSoMxTrWVEAzdK2J+zctxc0b0wrkP1VuR9t9i6ryrBZejQG6S/C9rflKvqqSKBR1J8wBY/EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7244
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 15:29:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10090

From: Sven Schultschik <sven.schultschik@siemens.com>

This series of patches will add recipes to build a QEMU setup
which uses OP-TEE to use RPMB (Replay protected memory) of
an EMMC for a secure storage. Which is used within Secureboot
on ARM64.=20
QEMU itself does not have an implementation of a
virtual RPMB. Therefore a patch for u-boot is needed which
adds this feature to u-boot, but breaks hardware
compatibility within u-boot. The virtiual RPMB workaround
is not persistent as well. Therfore a method to copy the keys
to the deploy folder, mount them into the qemu and provision
them on every boot is implemented.
As soon as QEMU has a native persistent RPMB support included,
the u-boot patch and the mounted keys can be removed.

Sven Schultschik (7):
  add recipe for edk2
  add recipe for optee qemu arm64
  Include optee into u-boot
  add u-boot patch for qemu to support RPMB
  add recipe for trusted firmware a qemu arm64
  enhance start-qemu.sh for arm64 secure boot
  Use of snakeoil keys for qemu use case

 kas/opt/ebg-secure-boot-snakeoil.yml          |    1 +
 .../edk2/edk2-platformstandalonemmrpmb.inc    |   56 +
 .../edk2-platformstandalonemmrpmb_202205.bb   |   12 +
 recipes-bsp/edk2/files/rules.tmpl             |   61 +
 .../op-tee/optee-os-qemu-arm64_3.17.0.bb      |   54 +
 .../trusted-firmware-a/files/rules.tmpl       |   22 +
 .../trusted-firmware-a-qemu-arm64_2.7.0.bb    |   62 +
 ...hack.-Breaks-proper-hardware-support.patch | 1375 +++++++++++++++++
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |    9 +-
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |    9 +
 .../secure-boot-secrets.inc                   |   19 +
 start-qemu.sh                                 |   20 +-
 12 files changed, 1696 insertions(+), 4 deletions(-)
 create mode 100644 recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc
 create mode 100644 recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.b=
b
 create mode 100755 recipes-bsp/edk2/files/rules.tmpl
 create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
 create mode 100755 recipes-bsp/trusted-firmware-a/files/rules.tmpl
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-=
arm64_2.7.0.bb
 create mode 100644 recipes-bsp/u-boot/files/0002-rpmb-emulation-hack.-Brea=
ks-proper-hardware-support.patch

--=20
2.30.2


