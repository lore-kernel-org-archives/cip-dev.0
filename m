Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D298C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web11.34779.1741778625533897542
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BrB3OHyI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLDJpS3AgEjKy97miN0veC5+DTFjmL7HwS9d4y0WUa3PEXE6FZ/IZ2b2Uq8MZ7+U/3WF1Qoz+Joal378OEyuJOjb7wMzkUYGUycjAyylgYTSiXG9T4g8TX0Dn0A/08PSh3zW1cHqgyP1HeuFKbXS0GS6pjdDoEVggSz4MvzgwdbKnK72Xtx7CADbCVcD7nJ4JcBEzVgWuiLfDhIQrp6nlz8+xVdxLJ2VSIbdOGgNITZtqnJfSfmQ36OKaXgNk6Vxr+Ydn9mfliBKUK6o3Q8QKLt2SoXzioTD9DalVQF+WfIhI4BsVL4O4Z+DFakw6uUumb/V5CJpevcXCaxieQpN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QIILN/Js/q5jHh1I8Y/6VHwpghE9IEWDALuHeIq9l4=;
 b=BVoSWgqH9YM6SCakX7TX17i9NcAheBySLTNEcEEr7iDD3BdpQCLnBifLXe2v7lzILcFrwwNC7Eg1HdQESyegTO7aycnv9DiyFoRcvzdu+3OanF6lH/8LsXqYTmLfFPupHZ9Z7VJ0Rqar9n0EkQeYjwhii8EEo5GIYc5TMZhaOv+gAmZYlAwmXlsY5lUiRGKZoPOB1B3Tw4yCycm4YAlsl1p8e29Vk5uJicDVFm9prYqzwnKEVNciPVIaM9ja77Ts2i8gsQMRop86NBNlqKalkbcQ/4FfSEgBECHL16HrP7wobyFttxLyKyL3NeVW7IFvXPvj87o2gCdFlCYBh/gusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QIILN/Js/q5jHh1I8Y/6VHwpghE9IEWDALuHeIq9l4=;
 b=BrB3OHyI/a9ABUgX0uLIaXcG9BPVlOuuHkcrNWSBTWY3Ty2YCL/RErhaVnV3pBmaOqESTNRbfhiaXcE64a2olg2YoFTVCn8A1ll8K1uqW7NCevZbO+Ch1OXFBVGivQupE+sxJC2s7Es9R77rotq81cjTTHsFpqmwucHc8j9Mq9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB10581.jpnprd01.prod.outlook.com (2603:1096:400:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:23:38 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:23:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Date: Wed, 12 Mar 2025 12:21:37 +0100
Message-ID: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB10581:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e23467d-499a-4651-b0b7-08dd615855b2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XtRduFZQiS5APFHdNUfQJtrR2uhGHKoQ3R8ilRgpxStqsX2+o+pAjnbr1gDN?=
 =?us-ascii?Q?l5mjLLdEarEfsYUybdLqfw2esKX+vEcxsqd9zgUqcM46nKw5LrO0bwS/yRpF?=
 =?us-ascii?Q?F9VfRyIu1Vvf5bf429vBywp1/2Vkn0Vn7Cak44NHCZMtiQREzdRsXKIODEx/?=
 =?us-ascii?Q?rGwF4+FfhgaRBJwaBRLryAvy/ox6d8nvXe1u1eqAUHp1j7ECLkYq+YlHyw0I?=
 =?us-ascii?Q?iW2UWZ/zdHc+rtkymX0rddRYkajYEC28v2Qj5Fc5B/QaZv6Eor/sxZ+QtKIt?=
 =?us-ascii?Q?7IB1KzPi1ogDS44OHTi8BSN7Ydf6egDYXvxZ6palWyDDSLbf4zDNi/ksao4+?=
 =?us-ascii?Q?Z1QNGteUrOm4d0bMACYSdrpU5faLKkjsxDi/bDvtKm5FT2g+2Jvmz53B0ts5?=
 =?us-ascii?Q?W3mtBYo77ePj3DSyBq17JaDIZUEXVs5CV4VP/eMCEuC/fiBQOS+YHYooOyjL?=
 =?us-ascii?Q?/T1Y7BpqCrxYYwo/E4/KbD7ZurZvmfvm+J6UbK6NESSQolEGWRhSNOpWCzcm?=
 =?us-ascii?Q?GMo3xsOOsNQ22qk4ZPFTsSGfS1VUhbRlIZpgCj9m43YSc+HkuuXqw3OZhXk1?=
 =?us-ascii?Q?l17tNCEO11mhSyXkkM62xn3IEbbZspQF6b4ijA9LQItQB2DGj6keyadQLQLn?=
 =?us-ascii?Q?0CzaQ5Tv4gxnb/NfcbeXN5d7MfN3/LGARZLuqJN4r524qA9mhBR/SO/8TP2t?=
 =?us-ascii?Q?6pgWmNH3/GusOZq2Vxjfyd9JUf8u5S27z7EAcDj66DSM8yTrCH0+0CME9XNw?=
 =?us-ascii?Q?Dd/QYhFNozQ89FvH1dIARVwPwd8v6vLFUp0m53yAdPKCSAf3hqiU0XT5IRgK?=
 =?us-ascii?Q?Z3IZlM6yxpfc5n2kRc8b9JB1758D4qR3PekUilKGZi7OYPh7RYoIodf5pcTe?=
 =?us-ascii?Q?ZaPXd9E9vLjQQi0y73QMjJpzS3zkfH2jPDHbuT1FF8hHnpI/doxWyr9b5jnc?=
 =?us-ascii?Q?17WimTSlerSfpKwbgtXSJfwF9R32EBIQLUdzXkg3f97l3xgdnJoDehq5mCHQ?=
 =?us-ascii?Q?1nlMV+RxwLKTQa1kXM5Q39kccFSoMxCkbTXra3bPz8U8tMt+rMgpQPeMzM0n?=
 =?us-ascii?Q?JBpSaidMo/Rh3z5YdjwDYyDTAxBUtCt1cnsQKl0X3BEder85ITZL0S6s6QkU?=
 =?us-ascii?Q?+FzSzzYMn0hhvCVAIZYqruCzsJE9jOTnlua9+cq/2lgZ4+w8bnDCvi5zM8UN?=
 =?us-ascii?Q?egjYUXeP1nDFsSd2Q9/B3CF8CkG972jquXKy4hPEDSOML7N90cSuQbP6teLw?=
 =?us-ascii?Q?muCQEMGhhUA9o106JQn+awmNlt8GDlzQkmn6ajun4wiOAgcZHJ4V+QNFpv7a?=
 =?us-ascii?Q?TeemgqUflXvIgcoIXhSVAy8qzDvs8U062BOGubnCG/x6EVZI9yyWPXdRvvuN?=
 =?us-ascii?Q?h2H5NL/EHMqsjMB0jcYki6czyuVFsZ9HPG3661UP1gGFgm0b7U+TNAMD71vL?=
 =?us-ascii?Q?Edsgx95t3jV3byb63IDlgwXOxFQ02BXp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JOTaaV85rCMAF07UiV8QelKkurc+AoZ4z5jXMXnv1U+rg4TRw/ubFAjjP1E7?=
 =?us-ascii?Q?0OpvOaVIhnBeic/byDrgclAmWOz/Ilm+Pz39yMNz+PPpKgwu8+VL0aN0JCiY?=
 =?us-ascii?Q?8ykZ9NAd6fTV0/tcgRKScn0DTI6AnZ4atXAtNd5ULcxp7bwoMuNgOSdIxn+h?=
 =?us-ascii?Q?sVJIIqpDCHhlpdW43ZycaU4Dt+UFJt+/+3pJE6lbtjM/3ah+0hZhyCGy/LtY?=
 =?us-ascii?Q?JciuShX/xMK0lUu/y5I6sn3g8hft7AcwTYJZvdgm4wePN8nyTU8y0Dc5oztX?=
 =?us-ascii?Q?MmmLOuYU8Xngz7NEnvGZ/kq6X7bs89yvwbyDLiY3NxAQKTZTQgsdKCArbply?=
 =?us-ascii?Q?mz2PAoAMDP0hzfJVE4WOB6okSMgr7Ek9AOSXROfnySEXeFi+Leghn0AGw29V?=
 =?us-ascii?Q?Ct1V2j+H3ojU5Vvv5V7FolTfc8WdSbBmFxQfiVUhZdhfavqgQQdkTf4hzMMG?=
 =?us-ascii?Q?cHA2WfaAAQq4nOfbhFYdsYV/ECEY88zc1iS1kad32IMEbQWl+0xbgye9soje?=
 =?us-ascii?Q?ErHS8RpIEpjVUp9zCZwjcm0wfAovYfwr3WvyuTYqE5x2IPqqA7aVOrp2myQR?=
 =?us-ascii?Q?g4i8Dx6MrgkG0dKW0BCi2egtWcho+2YBp/GmdrRkKa52BSMi8bD0hIGbVoL0?=
 =?us-ascii?Q?8sXUIAOzNsEY/DQnPO9gN5HJUECdVZTDYNm+gLgMkfJBa+ZrP1KPT8ddXfi+?=
 =?us-ascii?Q?u7L4GDsclkxAJuq0wKeGCIY5UjWFrCioZVsJdZxMtI3RquPjnk9tNt5O7Kt/?=
 =?us-ascii?Q?0EsRx+cH5/F7/gKa+QNEhSXd9J+soYWuHqcjLgpmn5/6+ZdfD1N480TR2DIu?=
 =?us-ascii?Q?Erv8UlY2pdXL6DHJB6+FPDhe8Kkv5gxiKohyfvjYQcE4NbnmPkvnI2bSoLqb?=
 =?us-ascii?Q?Lc44S/Q+EYXTAvar2Wjzj7swU587t22ZWfN/3Mqm1/CNv5XdBEx2p+gKNMDB?=
 =?us-ascii?Q?A8oQKwliUetlS0yOyq1K9BksGfmw4WXQZjRothrkZRY9XEYvOb6llGnsfY7s?=
 =?us-ascii?Q?u/8FlmhoqfBYUqFiNx5/8V5ma7QVfSB12+9oRWCy+k2pZ9e+9hYnDzAuYZsB?=
 =?us-ascii?Q?eOIvs4alt6I6kniHMFfuLOk9mBOCn0ED8vs7YP5jJ9iyxDpo4cn5NASlLVLq?=
 =?us-ascii?Q?JadkS8rDJgjx3MDJYlPohjKFFnVrY20PI22K2Y2PCqj+YXzBZHi3yFY/PLnf?=
 =?us-ascii?Q?BXmNTGaqOtpc1VHjztz1e/pvbLxOBcvxc4nSURYX7ARhvFdZgVv1uVSgTXER?=
 =?us-ascii?Q?nhlACxY9NA2Oi4J35LqJI1vJWQZlQU8Z7BaJRG2FB5e+b9SRbgMN80CXpkX9?=
 =?us-ascii?Q?zTUtVRiLYeDTLlflGMLCo/cN7Yk3kIfvpSqVXRb5gpEKBmqRNLhLp2IxKKD0?=
 =?us-ascii?Q?OECBednCY/WasTAzYL6Y8mgVuNrUUPRwoWGmjdpgIB9/+dJGykunvoAjIoGG?=
 =?us-ascii?Q?KGyHqa+yLotbRpVGsrlBF/HGi4DF9UsB7kUV0YCdism/taGX+Z65D/c1Lp0l?=
 =?us-ascii?Q?nOvc3cTetj52oM1GLgmf1cND/qGpA+5/aoIR0aXToZoTFpb0EcnOAkwjXIHy?=
 =?us-ascii?Q?0i7cFlGTE7sSvR4rpr/bVMYBghIVryHnpvYn15j1f8Y2WQSnIFgftrf0rmD6?=
 =?us-ascii?Q?BIt7chr1o481H/zCtn1F2so=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e23467d-499a-4651-b0b7-08dd615855b2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:23:38.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QO80G80ofBCgsBJWCvWJex3EWn7yOCHmpUE0h1QmM0E63Zb8j0jtn2lW/anGgIJYtrp2CRllhGV9yDiBPdj+8Hl1WAhqgmX0FAqP/l8SXgPNInqQo8nXDonuwsko6uzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10581
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18092

Dear All,

This series add support for RZ/G3E SoC to linux-6.1.y-cip kernel.
All patches are cherry-picked from mainline kernel.

base commit: 8da62141b20b (tag: v6.1.129-cip38, linux-cip/linux-6.1.y-cip)

Thanks & Regards,
Tommaso


Andy Shevchenko (1):
  pinctrl: renesas: rzg2l: Replace of_node_to_fwnode() with more
    suitable API

Biju Das (24):
  dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
  dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II
    EVK
  dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
  clk: renesas: rzv2h: Add MSTOP support
  clk: renesas: rzv2h: Add support for RZ/G3E SoC
  clk: renesas: r9a09g047: Add CA55 core clocks
  clk: renesas: r9a09g047: Add I2C clocks/resets
  arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add OPP table
  arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
  arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK
    board
  soc: renesas: Add RZ/G3E (R9A09G047) config option
  arm64: defconfig: Enable R9A09G047 SoC
  dt-bindings: pinctrl: renesas: Add alpha-numerical port support for
    RZ/V2H
  dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
  pinctrl: renesas: rzg2l: Use dev_err_probe()
  pinctrl: renesas: rzg2l: Fix missing return in
    rzg2l_pinctrl_register()
  pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
  pinctrl: renesas: rzg2l: Add support for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add pincontrol node
  dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
  arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol
  dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
  arm64: dts: renesas: r9a09g047: Add I2C nodes

Claudiu Beznea (5):
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Move runtime PM enable to sci_probe_single()
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Increment the runtime usage counter for the earlycon
    device
  dt-bindings: i2c: renesas,riic: Document the R9A08G045 support

Fabrizio Castro (2):
  clk: renesas: r9a09g057: Add clock and reset entries for ICU
  pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX

Geert Uytterhoeven (1):
  serial: sh-sci: Use plain struct copy in early_console_setup()

Kartik (1):
  mm/util: Introduce kmemdup_array()

Lad Prabhakar (46):
  dt-bindings: clock: renesas: Document RZ/V2H(P) SoC CPG
  clk: renesas: Add family-specific clock driver for RZ/V2H(P)
  clk: renesas: Add RZ/V2H(P) CPG driver
  clk: renesas: rzv2h: Add support for dynamic switching divider clocks
  clk: renesas: rzv2h: Add selective Runtime PM support for clocks
  clk: renesas: r9a09g057: Add clock and reset entries for
    GTM/RIIC/SDHI/WDT
  clk: renesas: r9a09g057: Add CA55 core clocks
  clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks, and
    resets
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and
    'output-enable' properties
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the
    object
  dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open
    drain properties
  pinctrl: renesas: rzg2l: Allow more bits for pin configuration
  pinctrl: renesas: rzg2l: Drop struct rzg2l_variable_pin_cfg
  pinctrl: renesas: rzg2l: Enable variable configuration for all
  pinctrl: renesas: rzg2l: Validate power registers for SD and ETH
  pinctrl: renesas: rzg2l: Add function pointer for PFC register locking
  pinctrl: renesas: rzg2l: Add function pointer for PMC register write
  pinctrl: renesas: rzg2l: Add function pointers for OEN register access
  pinctrl: renesas: rzg2l: Add support to configure slew-rate
  pinctrl: renesas: rzg2l: Add support for pull-up/down
  pinctrl: renesas: rzg2l: Pass pincontrol device to
    pinconf_generic_parse_dt_config()
  pinctrl: renesas: rzg2l: Add support for custom parameters
  pinctrl: renesas: rzg2l: Acquire lock in rzg2l_pinctrl_pm_setup_pfc()
  pinctrl: renesas: rzg2l: Add support for RZ/V2H SoC
  pinctrl: renesas: rzg2l: Update PIN_CFG_MASK() macro to be 32-bit wide
  pinctrl: renesas: rzg2l: Adjust bit masks for PIN_CFG_VARIABLE to use
    BIT(62)
  pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN definition to top of
    the file
  pinctrl: renesas: rzg2l: Reorganize variable configuration macro
  pinctrl: renesas: rzg2l: Return -EINVAL if the pin doesn't support
    PIN_CFG_OEN
  pinctrl: renesas: rzg2l: Introduce single macro for digital noise
    filter configuration
  pinctrl: renesas: rzg2l: Move pinconf_to_config_argument() call
    outside of switch cases
  pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drain
    outputs
  pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
  pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell
    helper
  pinctrl: renesas: rzg2l: Fix PFC_MASK for RZ/V2H and RZ/G3E
  dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
  dt-bindings: serial: renesas,scif: Validate 'interrupts' and
    'interrupt-names'
  dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as
    required
  dt-bindings: serial: Add documentation for Renesas RZ/V2H(P)
    (R9A09G057) SCIF support
  serial: sh-sci: Add support for RZ/V2H(P) SoC
  dt-bindings: i2c: renesas,riic: Document RZ/Five SoC
  dt-bindings: i2c: renesas,riic: Document R9A09G057 support
  i2c: riic: Introduce helper functions for I2C read/write operations
  i2c: riic: Pass register offsets and chip details as OF data
  i2c: riic: Add support for R9A09G057 SoC

Paul Barker (3):
  pinctrl: renesas: rzg2l: Clarify OEN read/write support
  pinctrl: renesas: rzg2l: Clean up and refactor OEN read/write
    functions
  pinctrl: renesas: rzg2l: Support output enable on RZ/G2L

Shen Lichuan (1):
  pinctrl: renesas: Switch to use kmemdup_array()

Wolfram Sang (1):
  serial: sh-sci: describe locking requirements for invalidating RXDMA

 .../devicetree/bindings/arm/renesas.yaml      |   17 +
 .../bindings/clock/renesas,rzv2h-cpg.yaml     |   83 ++
 .../devicetree/bindings/i2c/renesas,riic.yaml |   26 +-
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |   61 +-
 .../bindings/serial/renesas,scif.yaml         |  141 +-
 arch/arm64/boot/dts/renesas/Makefile          |    2 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  387 ++++++
 arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi |   18 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   31 +
 arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi |   13 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   24 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |   28 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/Kconfig                   |   14 +
 drivers/clk/renesas/Makefile                  |    3 +
 drivers/clk/renesas/r9a09g047-cpg.c           |  150 ++
 drivers/clk/renesas/r9a09g057-cpg.c           |  280 ++++
 drivers/clk/renesas/rzv2h-cpg.c               |  999 ++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h               |  224 +++
 drivers/i2c/busses/i2c-riic.c                 |  125 +-
 drivers/pinctrl/renesas/Kconfig               |    1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 1229 +++++++++++++----
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |    3 +-
 drivers/pinctrl/renesas/pinctrl.c             |    3 +-
 drivers/soc/renesas/Kconfig                   |    5 +
 drivers/tty/serial/sh-sci.c                   |  160 ++-
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   21 +
 .../dt-bindings/clock/renesas,r9a09g057-cpg.h |   21 +
 .../pinctrl/renesas,r9a09g047-pinctrl.h       |   41 +
 .../pinctrl/renesas,r9a09g057-pinctrl.h       |   31 +
 include/linux/serial_sci.h                    |    1 +
 include/linux/string.h                        |    1 +
 mm/util.c                                     |   17 +
 33 files changed, 3747 insertions(+), 414 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzv2h-c=
pg.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a09g047-cpg.c
 create mode 100644 drivers/clk/renesas/r9a09g057-cpg.c
 create mode 100644 drivers/clk/renesas/rzv2h-cpg.c
 create mode 100644 drivers/clk/renesas/rzv2h-cpg.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g047-cpg.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g057-cpg.h
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h

--=20
2.43.0


