Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5079CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:34 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10727.1781685030667693608
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QYTPL8lS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE/Ir1IvffVKgCqisajFYU5l06GpD7qQTb7vQBhzf4nCpfMz7jAg0OPc11Chj4fB12kGQYpQkLskkOyx8F286vwO0xQ90VMH067Ktt55NuhKZsKA5HvDBtZZGa2UNEE15Qc6xSA7Li9B+LSQgvDxtl5ZkQ6aVeQrEqpmQ3TNL3cADUcxTiGa41BS50rWTuHYz23hDWlL93B3uUHJxAJNvA2qhMlvYwqu7SbI36Ei6kkwQFUz+8xZtb1WfGLwsZrDEZYfXp3PF+S5fGx4JthPY/kg94AFVeEj/nsvUw/J+00mMWN9FV5VxmUVw4pkJEbDC2IOvyaxoZKv5HE3hziBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lS08Owr7gvhqtIQeVkCu9nPjqIZ+xw3MQsUIGM+L5E=;
 b=foOFxUSG9JbEgtEzKHN8gsfjaJM3VFqzWf5THjt6z4a7J8SskT2vxYwIiNCVP53zJ9ZlR/rmwkPWDjeiog4Gpn5MTRlhWGgZsBWyZYHPnxcxDFGcEjAAM8zeO8ZzKDsPJyjw+bIeUn4MJ9IfgBEm2AtQ24fTI+HkuiAeYLdV12QwUbIBRH9SlF55DYy5CBllAW0Jgu59U1BxeXR2uL1kj+7ZTZbZe285omdRecZ6eljUB8U4pYRJln0U9ZW0QXUp8bZmWz4xGGLe21aBzjcFePUdPlfN9CNHnCzbKH2OSyBe7FIdgnR/q3EEf9SL5ytmmhd5+lYsK8ISwEqbNEFs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lS08Owr7gvhqtIQeVkCu9nPjqIZ+xw3MQsUIGM+L5E=;
 b=QYTPL8lSJNVTFEn8iEQO6wGlTIx6GhpgVuaW1bE6QkzLJWB2EHf7mkR6CSFRb7gMcDtDnM+zLRV4utNeeskl52jENTeR+YgCUSTq37cJ8NWaD7jBxQOksFs98Ufw766J4GWSzBEHgxuxd/xCn7L8ffZ4t971eBI7JuC3iNexg9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB10286.jpnprd01.prod.outlook.com (2603:1096:400:1de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:26 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3E SoC
Date: Wed, 17 Jun 2026 10:29:31 +0200
Message-ID: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB10286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfbaf87-347d-4947-0ddc-08decc4aae18
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|11063799006|56012099006|6133799003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	6YV3YI4BkyqhelkxMlQidsbAMCQ90XlLuK7UmhivmmQQG4o9YIIC+IJU8dM9qdELDnVtCQXP+790qfEdvMLo1laVmGX43C0RDTpxpVuypbW4p3koeQzQ4YZcvQLeMbklB0QypWSKQ71jRYQaha5XdpIAebNxwZzH6Lyb+l7bNe+/uJ80Dmovz6HhWcVSpjKpbK1gmdFN2ijpHc4ZEIg3qWZG/M+OoJNpb9lHhS9wTQqRKiOe4Nj8/GXw6frlePqj9qR88y3H9E+mK3l3s/uGGvCKnIVcsOxlkuMk4MVFzy+W1DhRULeIWttngJ1D2t3FAenB1BdHdZ24VkX0EFCGttbY+dv3DQRPG9w/h154UPSd7eyCZ82fLQ+KK4SAwQRrC6S5pw/Pkf61oDpfgw9UueCBtDCN5Ei8+oyb5ew6mUOatJeRY5PxtDk+UBsM0XO8HnCJSaanPpWufOxveLE23MvjIulH1ZyWZ6aNCFTqTpjXwDudB7Mo+O7VG6C1bHw1KIoAsCp54+83Jo9So7OPcqrMBOZItmylHDSayVIhCCsNepPj7G1LpcDO466C1IJUu6O0TDJM3WdgfNCvxx7U9oGt/AwJyjVKSjARjEPJwfDQW6eXSsM9JxrBslQllwfCZiFGjuWkdLhhERFf4YpiBad9BUdNXxLFuuQ4BfQUoTj8DEmrI7SxiZIM1gjmZo5C+0xFx5PUhTsL9xb1Chpfq49kELYRlPj4iw1CHRaAf/Cc9QO7sQmV/Bvx365Wa/BL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(11063799006)(56012099006)(6133799003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q9lsEQcw0w7FqSu3N4rfos7nggx52h4zchJWV41inlIMGbRgbCVmo72iCca4?=
 =?us-ascii?Q?aBpwyQi512AXh5CQvZIWYcYK5VgnayRSBBkKr31zlb/IsysZHIvgcYR5TdAV?=
 =?us-ascii?Q?sbjnTVPhdD9IwYw3IWmDnsKBvz24MKq16EVMRgd2SN/OeREIXUT8ML8q8eUM?=
 =?us-ascii?Q?SWKy+G+9vocGrC3mJHl0ezA9HX8h0SwZPfqKp+Yuder6IKfFQlb3zzU9rRHK?=
 =?us-ascii?Q?gGixbQcnzuUMYxRqlChCudKnRxsYwgF98wgbSRiZM1DzzNWGXra++8YuKZhG?=
 =?us-ascii?Q?hdFlkrE0NrmfVe8oggY7Kk8Sa92GEQdZ8oJKITLKWvVz9Rh4qOxk2K62POu7?=
 =?us-ascii?Q?uYj/mlM2ULRvDFPygFmgAetxSqzUzGdSe0mm+U5IBo8cOeTiv459Tw3HsOXx?=
 =?us-ascii?Q?YgHXAwGnHRh8DIEllpXKgLGLaCFAhu+SZaRErXDFTyVi9N0QuiNK6Fx6duUh?=
 =?us-ascii?Q?44K35d2QCgVcqgS/QTSMpWOIPYzm6Hz1vYkK6rgb94VFK5OSg/4Svm/3iRYt?=
 =?us-ascii?Q?jvCHMJ0fFlj/XLs01hdxBRru8nNQxpj/19Gg3yYcJuOKWLd0LBBoHOlTWhtz?=
 =?us-ascii?Q?edmXRDP+Gvn4RtkwyS4Jao6XimjYZi+WdyptAe/jcgUueDuJLtXqeqbJZIWH?=
 =?us-ascii?Q?qYXXdgRm5Ll2Z4r2tQ17M3JpRBG1pwmup5E6eEkCYte5BboOAXfIO25LmuVh?=
 =?us-ascii?Q?7FF7RlFrLZOPl+VMdPvgW7BlfUjvsI7gdeUbmRhSrZyVQv8/0817TkZKfpEJ?=
 =?us-ascii?Q?3Lnct5mdldFgPyESEy6TV6OPclry8gqrUvwp/GYdc8xqyhymluUBvXOMYWGX?=
 =?us-ascii?Q?AIW4xcNVC03LV7A4vxWI7PEgt6zaZK0UggCIXJIMQ/gyz0JYa49qT8ThjV3w?=
 =?us-ascii?Q?rnTQyATIQgpqUXvQMoj9J7G2jpKWni8Znb7uWE97PyMgf2Vo2MlJaKWrrfnP?=
 =?us-ascii?Q?EoGcFvBXIg6/SloKJOL5UKkaO05BnCHAr4DJKwR6koxctZo+z2Cqj9qrYvxe?=
 =?us-ascii?Q?M6843uu0jAHV8xViA6yCG67zQqWe39Lal4dxbk2/TL/BNJtWkkKAKVMFwFFy?=
 =?us-ascii?Q?Igy3g7vsi3jz4IImFf9s3GxCS2IF0HQ8Yfv1Vjqhg0IMSXacg42WuUXA1JD/?=
 =?us-ascii?Q?PSBoskRXYD3OAZJmM3vpqfcKXWzv+rOxI6clE+2ilZbD/IhAwEW5Oz3zil0F?=
 =?us-ascii?Q?aOomVJkER59LxtX+fRHqRxr4Uqhw9CtJFzXH7bD9RfGqTDE7REyWKx8EogLU?=
 =?us-ascii?Q?32Dj7y4Au/ITYf4N4keo/zwWK27LAIRKIFkIaeKoqMeU10HUsp9nd1v/a8Yb?=
 =?us-ascii?Q?qzl8Nx+iNYcwm8JOaNN/aFlYnnn2GpyjhRVWX2M0Wb8Ky4/5x/0908U/OwPd?=
 =?us-ascii?Q?r2reYteuInp7goUL/BdtaQts9bqwvqM8jVf/TsnXPV9vMHfIOish6hGuhBZ7?=
 =?us-ascii?Q?2W5biHiDZB/eutu9e3mQP+/TxYiX+IZKxYmzoykPamOqdQbjQVR7RoOS71SL?=
 =?us-ascii?Q?SmF6w2tqCJA78nL43N2taVvnVK931se8GY8FW5/8wbKIUu1amyN2dmihmgzb?=
 =?us-ascii?Q?dKkosuFymo7p+wxdNtKrC2ysPPRAwDGaF/L2URX+2ZOo6NdaX7fi6SGn8kur?=
 =?us-ascii?Q?QBQ7/Ap4CdDw1fCiF5/mBmjUS85XpYr3LUkcaP/jHyhEg4m+GpidSwmqN2vH?=
 =?us-ascii?Q?8DkG8yiXGXJVQ9B5wdgWJU00nkbK6TNyvTEBQqlZgDYBK7znPf/MdkQFdHqP?=
 =?us-ascii?Q?7FYMuh+5swSPUmpXUhNL8ACcbyphZ15wjtZiP1IJ+PlLoWu/fqoz?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfbaf87-347d-4947-0ddc-08decc4aae18
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:25.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KSjiRaaKH2MqwbfhLqpZLTahJLoBEuItLWsyCLn4nczKhGCBEWxf9ei8fwkLR00I7yqzJtNCL7YxuMM4UDtBVPGH16pnf3Eglpsgwlj/JeZPXZarAGJKCPkYjeq8Y3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10286
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23159

Dear All,

This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
features three RSPI controllers. The series also enables DMA support in
the RSPI driver, and backports the necessary infrastructure changes
into linux-6.1.y-cip.

The series is structured as follows:
 - Clock entries for the three RSPI instances on RZ/G3E SoC
 - DT binding updates: document DMA properties and add RZ/G3E compatible
 - Device tree nodes for RZ/G3E RSPI controllers and SMARC board enablement
 - Driver improvements backported from mainline: DMA support, device-manage=
d
  APIs, bug fixes for clock setup and FIFO thresholds

Kind Regards,
Tommaso

Andy Shevchenko (1):
  spi: Introduce internal spi_xfer_is_dma_mapped() helper

Bence Cs=C3=B3k=C3=A1s (1):
  dmaengine: Add devm_dma_request_chan()

Cosmin Tanislav (21):
  spi: dt-bindings: renesas,rzv2h-rspi: document optional support for
    DMA
  spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs
  spi: rzv2h-rspi: make resets optional
  spi: rzv2h-rspi: make FIFO size chip-specific
  spi: rzv2h-rspi: make clocks chip-specific
  spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
  spi: rzv2h-rspi: avoid recomputing transfer frequency
  spi: rzv2h-rspi: make transfer clock rate finding chip-specific
  spi: rzv2h-rspi: add support for using PCLK for transfer clock
  spi: rzv2h-rspi: add support for variable transfer clock
  spi: rzv2h-rspi: add support for loopback mode
  spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
  spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
  spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
  spi: rzv2h-rspi: use device-managed APIs
  spi: rzv2h-rspi: store RX interrupt in state
  spi: rzv2h-rspi: set MUST_RX/MUST_TX
  spi: rzv2h-rspi: set TX FIFO threshold to 0
  spi: rzv2h-rspi: enable TX buffer empty interrupt
  spi: rzv2h-rspi: split out PIO transfer
  spi: rzv2h-rspi: add support for DMA mode

John Madieu (1):
  spi: rzv2h-rspi: Fix silent failure in clock setup error path

Lad Prabhakar (3):
  spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
  spi: rzv2h-rspi: Fix invalid SPR=3D0/BRDV=3D0 clock configuration
  spi: rzv2h-rspi: Simplify clock rate search function signatures

Tommaso Merciai (5):
  clk: renesas: r9a09g047: Add entries for the RSPIs
  spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
  spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support
  arm64: dts: renesas: r9a09g047: Add RSPI nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |  19 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  84 +++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  16 +
 drivers/clk/renesas/r9a09g047-cpg.c           |  24 +
 drivers/dma/dmaengine.c                       |  30 +
 drivers/spi/internals.h                       |   8 +
 drivers/spi/spi-rzv2h-rspi.c                  | 574 +++++++++++++++---
 include/linux/dmaengine.h                     |   7 +
 8 files changed, 672 insertions(+), 90 deletions(-)

--=20
2.54.0


