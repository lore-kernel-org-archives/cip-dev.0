Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10AC433FE
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:48:22 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.42])
 by mx.groups.io with SMTP id smtpd.web10.22408.1668977298306530554
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=eLVx8JEt;
 spf=pass (domain: siemens.com, ip: 40.107.6.42, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCRzIf62Ri7EnmIuwO5w+WIIk4JYcMPoYqHgnGTH3ZokEqvZphX54l4brFpfDNDVU30n5BT0MdjjpmjmbqdDfSBx3uWOpIfvF0wD7VwLJYJbv/Pc8+V8HxkdKnkGSUNLMcWJIULZDWWA/oKGFmQamWOjQBosVygIHQelX8IhCQe09cTXihJVgfA5rR4iYehgBr1WHFOURwcaUv51Okvnk9z0u8tSvP69SfP/8mW/2u+/9O+r7KxMXIGHcbbKXECH6r/SbN8tcgEpUw9y8dj71KPW3pmvdJb2ht4o1s5azWdtKZDDQ6gr4E+hNenILWn3culKflpQSwtkz6SxpTgfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agCy3Cfxo9B8eqbXLWJDceIz1tmToWIPDEt2kHRvqFM=;
 b=MMArNrPkvrLeXKTUeWKL9W0YpKYjyMtBcwbM1nTsppxI6Ejhd4Su2z3O3UAYJGhdsAzQVRsQEWMo3btw3Bi7J7UH/tgcV4w6TbGnQ+K6qmLOFEwwK0VKObDjVSTDwoD2Grmx6GvUen5sJkpbsQEjpPvoMLN2fkzolTvdTNNQyZ/HOI5WlB6DG284HwA0AF/VF5S8a5sbQ+0e5gaW+DE4WlGOdnu3oLOiGKPZ4bFxLwUkJASseOsDIHK6Keqa7BBiTbO+pZ6emKO9InUoxMdFvbONKruAMzQzaePAkKheO+tW/ZHVmjnanwlanEuDS6ZFL9jaIxVGa2Zr79GLlbcldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agCy3Cfxo9B8eqbXLWJDceIz1tmToWIPDEt2kHRvqFM=;
 b=eLVx8JEtbHQuTAb3N74kj6QrJcKJAX98Ep++5648iFr8TaFSVPRmXdeOSCqRdnQfR41iLNnMUX/v7WQjX8/kOeqz3auOyNcQLBWMTnPuiqUtEBD8BXMQR5PLsS45GKzCWbn4ik247HUeXMG+UrycrSl0zshtT/YhZCdPAtnZokPcHjLn2YcoKUpeUAeuS58U4FLzdHKTDRrtWb9Dc38UuOBQnZfvuSy4T2zkUD5E/wTBUB3KhXwJL4N4jbiTGHu7WoozZ1fAsMk12fQ68MNdZpE4TXAF8GY0xDSz1AdDdIWL1iFyswwmmDmpsEe74uCtlUO5hX4V9xgVcTgO7nZvwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:48:15 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:48:15 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 0/8] Secureboot on QEMU with EDK2, OP-TEE and RPMB
Date: Sun, 20 Nov 2022 21:47:03 +0100
Message-ID: <20221120204711.5826-1-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 775ab0cc-95a5-402d-8c2e-08dacb388be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DRycMfD6lbo9qAyZiAzZflFlRYyefxEypMqfNT7LXpguqkRV1vj0Mf4c02rHTqxlJMaRuJBtf0myuQeL4ViducZPfBiFiwVmq7HCl78TzyAda8vqwoFrBytMWGWE4dcrQrGwPh87yrLJE8lazhuWKz+cHDBEjAFCRn5hrqGkp8uWQDHaQYB6sUOJT7ubu6udn0x3ErRkuIA+1iY4NS5ciw2vQ7Vk4VNa0KXIOIl3MdPf+SY0AYChwP4T2lPWEW7mh+7+QedYTTGjCD6N+z5k2SVqtKsWLgkghQHSb31w9g8J1jNGPvDxOoJ3sV7s1zpVePJnjyfHjTDB4T4C2Ff4aSkKDfyPH5pDTzD5MtZPlZMvBn/LPC7rbLV69pmcWgGGNTcNu5Yb0uKGICWCCR9xpNItHOFTd3ueRwHSib9OEmuqe7momcPB4v33vr8TjQShXpFVnM85HX93XiohpN+CPqxXpFAMBHaZ9t+87n13CplMbL9GlzdBwOnT/IvKdzRYx5hP7HB/HkVi+CozkEaQb7IfylPimB2AriemgVQzH9NO+fxYKXgZyXiNhQR0NKnijR8zWafAvGQCAz+Gw0hrSGZbGcQGVwMqbVGERuNAnTLfh0DjxeYN1LZzoERCW3y1MDNi+7SYsVmJ3X/nCZUIgw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(83380400001)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(6916009)(8936002)(19627235002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(6666004)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TVLFvZ/IgCXhQ65qasEmIhgg7U3dq8uZQPxuNHTpTr7C9pcYSDs3M3Nxa2e+?=
 =?us-ascii?Q?YOnMoaBVlg6M1hmwwsTxg91w3BiOi5rPH4ngZSbwR3Ej8MrHVEZ02iFqzNEj?=
 =?us-ascii?Q?5kevwCAJCYdA+LuAASnC3h4JfAjFbEoBsqP5WePqXt1zAUGc3o6n2oLIEmE6?=
 =?us-ascii?Q?7UwrGAXrgMTnlWQki6cXQygh13+mZidHq/cp1oYhlbr8F4nq5Y0FEepIwlNV?=
 =?us-ascii?Q?IKH34D/DMtN/YDU2AKo2RkvxU2e+hg2hjMZHMhC3USye6XlBsoPwj+bMEk0N?=
 =?us-ascii?Q?bC0XQaunOKcVMKWov63dOHnO0mNjTokWQBcqNH4g+BDXBORcAlW17PC43lrK?=
 =?us-ascii?Q?QC1h0bypsOOAaylGoZbO1E37A75rN2ZcYXdHHVn5NMa5qZabyFyovFdMEu8A?=
 =?us-ascii?Q?ZH5fDUm00salVj2dBgwR4cpye2kliNaAKKL5zvtDLznBcSnN/hfVJUCDSBFO?=
 =?us-ascii?Q?3PUeRWzCti7Chr9EbEQqAthMrihW3g2SLRGoeQQ6ZmumJ1HHNLjcb7zwTDPv?=
 =?us-ascii?Q?KHTneemcbf2I7suuQeHfOoPsdqjIm5tI+NAzIhi2Jxxs4dBC5ZE5FOznoWbL?=
 =?us-ascii?Q?PMcR+OViA9DuBQGa1RAHhzxGj2YkPyzIvE8YdqAhj4++P87bWq68N8t/AkC3?=
 =?us-ascii?Q?XMFazRL2LMofUK3QCxRhc9xRhmF35kcvnW5V7QJDOmP/YtradLDXyhYU9PAv?=
 =?us-ascii?Q?2FIC/RdRJhn0yLIbVOQvnHqO3AY2QADgWMb+yX0rA5DDzAeNY/xKyaQpoydC?=
 =?us-ascii?Q?w1/ANdkANy1QrzS+6mG+G0Fe9L0z7kVbxMht2K3AP+1g66kawcrGla4N+6zP?=
 =?us-ascii?Q?GmVYrCH8VXXXKEi/Tm3OrnDicpA0cWtnNu04QnxmkyuJAInJJm6jkXT4o96R?=
 =?us-ascii?Q?iBEbLNyQJqUOGhmOb1KHNOazfywXzP8qr2cwkheYk64eiUL/tMSO4lTaDK3F?=
 =?us-ascii?Q?CUwwLdgk7DhlOXMLHCDdyqSeTm0OwxRpqFZyrhzcgZ2gjPZWjc24lpBlcLY3?=
 =?us-ascii?Q?+Dal/g1V9Mj5m+DYqilnS9oboPefbSGN9TRR90uWReDsMQWZ5UdR1ZIkU3UP?=
 =?us-ascii?Q?RLw162BbDmZkheEBVkFH+3gVnseO4Zyk6ExABSs38ydxxIKQ+lkZQehbwzes?=
 =?us-ascii?Q?bvQk+FNM4dlJWCzqkLDsDiwnWUMF3q1kQZ0OlmBnEFAqECzdy5AmWjwKKsHX?=
 =?us-ascii?Q?9XJ5YBpyK3l3x3hZWjE39/vivOnb+bHvRqEciB/z21hKN4UmC569MaXqi+/w?=
 =?us-ascii?Q?8DZIqJebXtLwW61VkhNoRMQ1XbtV6hdPseNvjS9TVU56EvSknRfBgFdWGeOq?=
 =?us-ascii?Q?sJ30H3ImT98j0m+4x2c4tSGaql87oUKxPNKid/P7lxEpS023BIdJ+XdN2p9R?=
 =?us-ascii?Q?YsbJCQmI/YfJYsb0wu3x6edxxdDRbd/3C42b7g6+dw8q1yZcNE7OAWKRRyfq?=
 =?us-ascii?Q?q/spZ5uEdPmzKL2QAh0tfGiYBKgsxwm84vLeyxkvdHt4p8kQ1gWxVQ1CDE3U?=
 =?us-ascii?Q?CXjjo+bPy+9C/Dz+1UiO0H953l0m0wYGAaH7wX5xkLsAU4IItUywX59ycn2/?=
 =?us-ascii?Q?DANPQjB3QQw7Zu4P66/54LAlpV9gToZ63o7YB2VT4z5gM8yUhrK4kZDqfVqf?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775ab0cc-95a5-402d-8c2e-08dacb388be4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:48:15.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivbE8p0+sOzN6vTNj2wAAnf24UuSAaWpZ5P3CanJrcURL+fGCr1XnIjbgQzJWrl1M67dcs4NfRb6ZIyGRWFPhFrnDvJ3ypN9y1c5knnbfLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:48:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10053

From: Sven Schultschik <sven.schultschik@siemens.com>

This series of patches will add recipes to build a QEMU setup
which uses OP-TEE to use RPMB (Replay protected memory) of
an EMMC for a secure storage. Which is used within Secureboot
on ARM64.=20
This secure boot solution works with a platform key (pk),
a key exchange key (kek) and a signature database (db).
Therefore the ebg signer, secret boot secrets and snakeoil
keys are change to this setup.
QEMU itself does not have an implementation of a
virtual RPMB. Therefore a patch for u-boot is needed which
adds this feature to u-boot, but breaks hardware
compatibility within u-boot. The virtiual RPMB workaround
is not persistent as well. Therfore a method to copy the keys
to the deploy folder, mount them into the qemu and provision
them on every boot is implemented.
As soon as QEMU has a native persistent RPMB support included,
the u-boot patch and the mounted keys can be removed.

Sven Schultschik (8):
  add recipe for edk2
  add recipe for optee qemu arm64
  Include optee into u-boot
  add u-boot patch for qemu to support RPMB
  add recipe for trusted firmware a qemu arm64
  change ebg sb signer and secrets to pk kek db
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
 .../files/sign_secure_image.sh                |    2 +-
 .../secure-boot-secrets/files/KEK.auth        |  Bin 0 -> 2066 bytes
 .../secure-boot-secrets/files/KEK.crt         |   19 +
 .../secure-boot-secrets/files/KEK.esl         |  Bin 0 -> 839 bytes
 .../secure-boot-secrets/files/KEK.key         |   28 +
 .../secure-boot-secrets/files/PK.auth         |  Bin 0 -> 2064 bytes
 .../secure-boot-secrets/files/PK.crt          |   19 +
 .../secure-boot-secrets/files/PK.esl          |  Bin 0 -> 837 bytes
 .../secure-boot-secrets/files/PK.key          |   28 +
 .../files/PkKek-1-snakeoil.key                |   27 -
 .../files/PkKek-1-snakeoil.pem                |   21 -
 .../secure-boot-secrets/files/db.auth         |  Bin 0 -> 2067 bytes
 .../secure-boot-secrets/files/db.crt          |   19 +
 .../secure-boot-secrets/files/db.esl          |  Bin 0 -> 837 bytes
 .../secure-boot-secrets/files/db.key          |   28 +
 .../secure-boot-secrets.inc                   |   59 +-
 .../secure-boot-snakeoil_0.1.bb               |    5 +-
 start-qemu.sh                                 |   20 +-
 28 files changed, 1873 insertions(+), 63 deletions(-)
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
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.auth
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.crt
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.esl
 create mode 100644 recipes-devtools/secure-boot-secrets/files/KEK.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.auth
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.crt
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.esl
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PK.key
 delete mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snak=
eoil.key
 delete mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snak=
eoil.pem
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.auth
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.crt
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.esl
 create mode 100644 recipes-devtools/secure-boot-secrets/files/db.key

--=20
2.30.2


