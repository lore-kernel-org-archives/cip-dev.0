X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.112])
 by mx.groups.io with SMTP id smtpd.web12.5040.1657784451352404653
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 00:40:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=OS7LgG8M;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.112, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpXkU7Th8ELE/3jRhQrI4lR7rtNrnGxkpuaj35s78i2G6Qp8YxJpW/EtyxukEw7/2nVqSZl2rRdVPdPZTCK7VRw/yUglv7yvRFG0WC7LIOPZbwozDwoTr40UP9mG8RDqT6eoXG5CNLXNfZg/oa/hV0rfU9SvKsxTqnoa7YewMNaCBVyYezpr8/WTtSJNomi/qFOHFA4P9MNrcdhunAim/JDf2592PYagAjMTLSXHg8rCTUiQw9Ea1+LBWxowNPEm2FZO6t5bNbewHcsGgMsfkils2I/8LLD0XEjx+BV/PS5QdeFYNaGKJlioKVhmqrR7huz8FTrhHhjkkn/EqgM8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnJ0+PmMdiSJkeA7vhVAa8Unu4DxecxHynvqvR4ZV38=;
 b=KPuraIFZYWR8pmhhFZJfJptJaj+65JCD2MgdqpcTHvYSgdm764qNLf1d/TrURCtNYm/aWu5IZDxiNAFbrHNCeudsFG/kZbmANxCdVz3My06AbFv90s9LxCrvvM5a1KfmLIndfYm/RNPyGsr89kVxc7Ll+K8sy6A4u/fgvlAI/XXTVxKGsM6+6WfmiMkpuxedc+wO+ddbT7POR9GRgtLf2x6NMJmb7G8195vvaE6NEgpdXfsP7lfHrzrLXstYREqJSX/5KeMhOK9aaDPMeNFEKoplqOJi1FtvkdlArOzJlZ0M2LmbNJdaOd6FWevqNfbzZE+k3b74czXJGzpiRGiisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnJ0+PmMdiSJkeA7vhVAa8Unu4DxecxHynvqvR4ZV38=;
 b=OS7LgG8MrbbiZ4zGN8HKGKrXh4JLliC/8AfH1uX/XPeTpJwmtbV4BFJJdYJVdq2DbVvGo2zBwI47UmK5ebmCk53oVNY4IKN4WZun0Mnr8wAULpyD2VSZHOjzcRATpeok0WVHmqH9k8pqKtfhGPRdc7GXzMjXD+UU4Tf3GCnG0gM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8573.jpnprd01.prod.outlook.com (2603:1096:400:171::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 07:40:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce%8]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 07:40:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
Subject: [5.10.y-cip] Build error with defconfig
Thread-Topic: [5.10.y-cip] Build error with defconfig
Thread-Index: AdiXVI9B/xxyxtJrQnq1UezaIf6MeQ==
Date: Thu, 14 Jul 2022 07:40:47 +0000
Message-ID: 
 <OS0PR01MB59221770F791E070A85C623386889@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e042925-f524-4964-ea3a-08da656c2a8d
x-ms-traffictypediagnostic: TYWPR01MB8573:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HnuV0Wkd80F8Mtzr4Uve+VdJdvjd5MGDMob8/Onz74/FOomiYNUeEVP3CsbBYgFlU1yoRqOZL1U1g8/lw4bd6UB1NeH2KOEGDgJvZ2U0uDcq64ARtn7SHtRzkpBiVXu0x2NOBBMk8KP9n/yp7Xt8DruKMtIDloCfxlrqU0y/eNlrq/GRJgm2Ucb3sKmDk4LDSpJKEmY6qsINF7vUffjvtpPP92y7MFu9z6J84zpTwcdxswr/smulHy6DhWL+BU84Wm+jtXs11GNH1rpJvgHgYnsj9iiiFUYrUCUd9rCWAOG2IyNoh8YatlIFSMsj3PcIUeO40D++/v9pVjBTFs2dEec7sZjvfrlOM1vuHIGGJo9vsHGw7EQqaAVxcDzX577qlIPDf8R/0KqV6h28XyL29akQqndUu9RCl3CzoABYc1EJAM4yq4PcFyS4dBeF74EjZTsrECg1eUUEhb9Hevbz7XLyxIwa2EmXls5COXs1xUCPy4OcegVXx17vHEQ7EUn6liFmc0F3sLPZFxulT9uNbc8rDigkZL6B168ggIgi4ekuBk/zp+wNOpTX12wOueWPyyyBnZ7Thn8PnjhAwLicgmgqO2TkdTshvSNcOTVARWrLnMWrKd8pT6TuKuPsOOX0GUbvC8BxO5Dn8jirElyIHY5+b4/cMzLzx/2SZXAZRdc2EavCF2dxeL8M5YTp0Tm62La6zm6GbV4A/vKpXK31mna7oqPmpdjIM/WJD/ETNaB5NKGgiN62tEhzNDxOrYn7PBCva7ssKz7SXwaJS1u6HjVzygGzVh3DWLqPdVX6eRLKB9hKMJoOG7saJAejlI/e
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(8936002)(66446008)(66476007)(64756008)(52536014)(66556008)(5660300002)(110136005)(66946007)(6506007)(8676002)(316002)(71200400001)(76116006)(9686003)(38100700002)(86362001)(26005)(122000001)(7696005)(186003)(38070700005)(478600001)(41300700001)(2906002)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/IanZJi2StEv4LgW2jnkBsn81QlaTof8gTvYjCQ9njouEDj7AF8qT90KdXOH?=
 =?us-ascii?Q?bydWISOQIfZvUzBgYOas7+Ltb7xkwqTumWJZc8HhrxvYXuv0vpXge7yRsP1A?=
 =?us-ascii?Q?s9uHZPqOEjp9VCpQ6NplCoKm8tm2lpjNTbCjO9/dzL4qsQwGyZpvn9JSz7o6?=
 =?us-ascii?Q?A7l+y/LXCqv3HdRZg914qy/sErzBGyvyYNE8Rp7uh23JEJvwAyULhI6P+Y4K?=
 =?us-ascii?Q?VEyPCTowQzJF/JQWKTMu0r1dGLWcaXgcWrEkbuWwWCBUZMps+4Wy63fCPgkz?=
 =?us-ascii?Q?CSCMdNKLnw298NX+3DYWDc/K5OU2uqgelnTT9dFMfhft8ud4UeXVDzGSdIJs?=
 =?us-ascii?Q?aFqCggZ90T/aTjqMGbPppmGJVDLMkF2yiC8XTU/B9TfV3H5/Wav63u6RDTvy?=
 =?us-ascii?Q?SBRpi0s7pOKoUjWPJb8cDMUP8q7WFHYhUsRrl1ETz3gw9KheNBMpc25g52LL?=
 =?us-ascii?Q?a4nuINMWBx1xFYiXvEIvw/hZhG44f9PGYrob4GWVOEXYJTNNGw+mTIw2sotz?=
 =?us-ascii?Q?sHH/GAamwhfvm5zZ/WEGUdMc5mcL7rbR0n8fZVDldUXUUveKYW+hPSTWz5uc?=
 =?us-ascii?Q?jQzc6bFI41Kot/p3Gzss7zzIFpkMo/SqiNFY5/q39qPHsUXlfJ1mt05akl/h?=
 =?us-ascii?Q?p8pQjPI/UDPJJERlHWhTq66i+09GTD+iWUwRRe4agpN5IH02qjmWalgBBxLU?=
 =?us-ascii?Q?gTgDtYrSWtuScZxKc17g/euqUU6bdYYg28P+d40J5jFJTCsP2yjPWIQupjOk?=
 =?us-ascii?Q?1fL7bB5LmgQ3cY9N72oBvU5kr/ane7L9eL8Jp0jrrpcSgD+2TAw00Q/xZgda?=
 =?us-ascii?Q?9oVPz4eS1YmnsVL4+xerN893iBhZ1mWtyrJFiT8DDqRAPxrRfZZl96I2tcPZ?=
 =?us-ascii?Q?qGSDLtj80TRnJ+72vwLwTeDzVKL/16FLIXNiMSuEKzOEtHG8s/bDhCOzwDxM?=
 =?us-ascii?Q?fMHupMROZDq8q9hloCUPmK6knUtXuWEokYZ5mbFHwxpl6beNz/eNgUk6naL+?=
 =?us-ascii?Q?otytTZVF4wBfY6CcxeaTlxVT9xPlzdNxnDhanb2UCn0XS4iS3p63sfoATse1?=
 =?us-ascii?Q?wFkZqYnmUCAj74kXPLEasvztA5aDTgT2AS27GZRHhr/1dqAi5lQKrCWxdj2m?=
 =?us-ascii?Q?/XQx7GL9CfF9lUx/srAvbecxfhVjzJCXOATe7i1cKKiUzndGwS4q7yc8CA0C?=
 =?us-ascii?Q?p6IGasA6j/vy+fmnVahS7PKSWyZNPusLw8SINZRH79AXxQaVA6xH+AQnToym?=
 =?us-ascii?Q?HjTMat3jNuaPEXIXL9/2awYJMcDeVHkWGKJ7XXXCcAoqhu79dTHE4B2MBkCD?=
 =?us-ascii?Q?2inzW3hZimssJSPxA1GoPzBiTqx7IBh0AyFswVnc2BDnWHxZyEAiU+3er+WN?=
 =?us-ascii?Q?o8NX4gUJ1MV5D0V+R0fch7UljtNyOFRowgLbtnVZNfD+qu9uT+Z6hi5QS5k+?=
 =?us-ascii?Q?HDYQ/ZkOd6WJVfGCM8M2jlXe8tldJXpNGp/5Ts7GR2tsZRqayH2rWM35PrWK?=
 =?us-ascii?Q?GyQpQh8gj1TTejpFnGCJGeQmhxGXbFfxGRN7d42QrmoVl5XiiPyC+iIOSA7y?=
 =?us-ascii?Q?dLLz/u+MztcEfO0XmoWqIip8ThEUF+VtoieOjGi7yRcdaF6VMNSODR3VZS/3?=
 =?us-ascii?Q?EQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e042925-f524-4964-ea3a-08da656c2a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:40:47.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAR2oDo8ebmF7cK0k9hCdEAyj5rYzua3DScDTw2/JAzh5NocdzoWZqxYkZSltzA9HNjmNrntorUOxZ5eDWXFsi6Wsd0j5Btjt5vgxwAWDjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8573
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

Hi Pavel and Nobuhiro,

I get build error[2] with defconfig with this commit id[1].

Q1) have you seen this issue?

[1]
commit 19dd4538e81e4019bc96ac6521af3a4ec93e110c (HEAD -> test, tag: v5.10.1=
29-cip12, rzg2l-linux/linux-5.10.y-cip, origin/linux-5.10.y-cip, linux-5.10=
.y-cip)
Author: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Date:   Fri Jul 8 14:30:34 2022 +0900

    CIP: Bump version suffix to -cip12 after merge from stable

[2]
Build logs:
biju@biju-VirtualBox:~/linux-cip$ ~/compile_copy_rzg2l.sh=20
*** Default configuration is based on 'defconfig'
#
# No change to .config
#
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      arch/arm64/mm/dma-mapping.o
  CC      arch/arm64/xen/../../arm/xen/mm.o
  CC      arch/arm64/mm/init.o
  CC      kernel/dma/mapping.o
  CC      kernel/dma/direct.o
  CC      kernel/dma/ops_helpers.o
  CC      kernel/dma/dummy.o
  CC      kernel/dma/contiguous.o
  CC      kernel/dma/coherent.o
  CC      kernel/dma/swiotlb.o
  CC      kernel/dma/pool.o
  CC [M]  fs/btrfs/disk-io.o
  CC [M]  fs/btrfs/inode.o
  CC [M]  fs/btrfs/file.o
In file included from ./include/linux/dma-map-ops.h:75,
                 from ./include/linux/dma-direct.h:10,
                 from arch/arm64/xen/../../arm/xen/mm.c:3:
./arch/arm64/include/asm/dma-mapping.h: In function '__generic_dma_ops':
./arch/arm64/include/asm/dma-mapping.h:32:26: error: 'struct dev_archdata' =
has no member named 'dma_ops'
   32 |  if (dev && dev->archdata.dma_ops)
      |                          ^
./arch/arm64/include/asm/dma-mapping.h:33:23: error: 'struct dev_archdata' =
has no member named 'dma_ops'
   33 |   return dev->archdata.dma_ops;
      |                       ^
./arch/arm64/include/asm/dma-mapping.h: In function 'get_dma_ops':
./arch/arm64/include/asm/dma-mapping.h:45:10: error: 'xen_dma_ops' undeclar=
ed (first use in this function); did you mean 'get_dma_ops'?
   45 |   return xen_dma_ops;
      |          ^~~~~~~~~~~
      |          get_dma_ops
./arch/arm64/include/asm/dma-mapping.h:45:10: note: each undeclared identif=
ier is reported only once for each function it appears in
./arch/arm64/include/asm/dma-mapping.h: In function 'is_device_dma_coherent=
':
./arch/arm64/include/asm/dma-mapping.h:64:22: error: 'struct dev_archdata' =
has no member named 'dma_coherent'
   64 |  return dev->archdata.dma_coherent;
      |                      ^
./arch/arm64/include/asm/dma-mapping.h: At top level:
./arch/arm64/include/asm/dma-mapping.h:67:10: fatal error: asm-generic/dma-=
mapping-common.h: No such file or directory
   67 | #include <asm-generic/dma-mapping-common.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cheers,
Biju

