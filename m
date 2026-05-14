Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3EFCD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6960.1778751609053216275
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=a4MgFYRH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.42, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3YYtnVbOqjPdjs/1VZeWg6c2bPLXeJUbGeGrNMyUPVS9OwJfz+7MJyZaQap6e0esYDFtTsWcVxm3aF0f9mtcfQaWEeSNZDa4GcFFw/8LKIgD3nYU16NAGYbmq0mfdmW+/TkbqIbYZ0O0XRPtdRrnu/5AeEAp0KPf/mQDXZNwQZdkObp25I5jaPCBj9Ztn02ap7rs2Morws/p/NSpcWKwPDHJVppTQb8NuhIl5rVRlYs0b052e+NGyzudurf6ud4hhv6EasKMiS9AmnZzJ9FabcyvJzohAT0NoVkGUg8nwwif4wgJanhrMPSZ8wOBRE6WXTmtgIj9iUCrMPjsE0Dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY0bUkgaWGK1UzdowjfwaPCJrpqEmgDxCWF2PShiyEQ=;
 b=tgTjpWdf64bC/cBenZUtllo1YRufA58yg9FPLZxBIkuVLst+sBjwpZatAQ1wkZGeBWQArzyfOt5+b8OtMxKvQp+YWSjQTAG86x8uICpGW7C35vmps1qtnh+IKbRHNayU1oDsRRXfXbhfqSZg7Ka0bC0iqY+OI2EqxlDZQllR7SVr2mfC0vc/cVRUWmQ3oBcjomoySRPhtskBSq0HupjELcWe/4ZJzNOMqRogEZlynWh5lXX5ZzgjLccGDkH9NhsEZnhqFlRL6vCxJ0CZc/CK3uz45ablXmuhBqaWprP+RdkC7+iklZWkhD6OKgXn6uiXjyhbTPmew/KN2DetJzW2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY0bUkgaWGK1UzdowjfwaPCJrpqEmgDxCWF2PShiyEQ=;
 b=a4MgFYRHQPrHdS5O/uoqosAJWPXs+ZTc2DAIj8+bfWDOM0xqV24i2XGaDvh0Nsh7S8cqchoxDzsHq/FiZg9NK4MbzKcjYVkOeFbrZJLKl7WajPc1UAhFRi13obNXyiBb4pCstqT9fcVKBNJxf/k7MogY9uNxFORTBopnukkFPYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB8821.jpnprd01.prod.outlook.com (2603:1096:400:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:04 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:03 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe controller support
Date: Thu, 14 May 2026 09:39:18 +0000
Message-ID: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYWPR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e03e41-931b-41f2-725a-08deb19cc657
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	lbEn8niOpvoy8bhXQnDFdo52uCKbgrPNNwCVPCiBGQcDceMu6lXNHAvTODMYQjbLyPKR0f3v1izhFWsnbQBqjJZtsGyEUi8U2Me2nBwhF4hZZ4Zw/sFjkTyTJjrmza0QX8p/rX6zrt2F+PTfVdMHbam+jthuwi5owOqyGvXrVcQCayvMzUUUL9Th8mh5xE7bStp1zndgMFsqFPolkymgh22vcLkDV/+6DcpOYic2yDMr83MFYfAlSllNP0CBKVfwLveqn7tn+okAreo6Mq3MrK/9p64qSpCCx4vip/ClSgt2op31ozFpMFPTtzgOLSnf6dJUi0R6gDR8/IxhOPLjRHu0lBAn2at5GWM2vdHlYJp182r8HzsYTaPPyQkE6FMVWKf+ukV3SQxtqTVEMZYUgMbAlmDKKziAhkaczBG8cLvJVtqp2I8lEkDH0VGIzdiOMQIAV8gfGzjF8yYBsoyqaltU6jTWS94q3jq7KMBR50oM99HOHWkKS/sHLEc4wucA7Vs73nXw6SaadRZv8ao3c3xrDMaK3i+KxJyMHfLttefvYokbKS2m9qkq//U9BkWV176oo2I1jvcb6g67J/JZYksX1zFqCW3fMrooh8+iWvax+Ws2JPco3NLex1f0fejjCJuoOzDsZuQVhBEN2/uDkru/9qxIO26TJsmoW4f+Fx4p84uozA8mVqekgflF8WouO5D2ViJf+5hjUdbRGYxucIwwwgzpQGMIQ1dbE+4FyS3THFcNKcidiDGdKA1dqsZR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5faZ3+BYGOnKmFEbb7suY7sLIg4jRYk63AE2T+h8C1UKF59uzOKLWwMydJmE?=
 =?us-ascii?Q?1ctuT93cGRP5GcViJFaK+jMA7DJjySu1tPq4wyDxQNrzovkTpENU4JBiw+1a?=
 =?us-ascii?Q?Bm/VKJCfFPAK0J8c62U/uaapo6QjHFngTEDD+bJCxZdOj2WCSLs1bSABIxwp?=
 =?us-ascii?Q?u1IZyliUTwIPmbx+pOjf993rO6gEHNr7/45P3v/Ol4j6eTWc2vdNUstbCcOR?=
 =?us-ascii?Q?g1Bwrl/46VInRoEoyTuc7tnVrdYKR4xb/H9Eay9Es9NAOvk1/4evr/7aviG7?=
 =?us-ascii?Q?WBAldPcHmCoeoUYM1L6XFpfNxSrtXtg0odqJfm9/ZjkWULig0FjUTKO6L8bO?=
 =?us-ascii?Q?p10KOWXYn6owoY65MOW0D8FVDM2bssUN9bsJmTN0vb7mPMIB1ijtLEVLkSj2?=
 =?us-ascii?Q?VlSwrr9Y44WYJjy0cRMydxIS0x6+GjdufZD/LsTLdfF4RRZuIdtpcG9a4ZxR?=
 =?us-ascii?Q?oFgiTuDZCXmXgRPnt8tNbq7IXOkEdISwsdagx4PDst0JLctiSGOFmtJ+HwTc?=
 =?us-ascii?Q?p9uBrYFEz2bfpDyuYqGb8PxGdtdFj/UHQ5R/b+Jh4nHFhSrZWi+5UWu4JsjT?=
 =?us-ascii?Q?q9BxVMSoQgiEaAm9CWyj+q1hFW8KCaDZJn4oJF6RELs/h6giiyNLA/eHEDrR?=
 =?us-ascii?Q?ohevwwjPa3HXv6A7W5si3o9R2Fu22PAwhaDS+KkoKge32gLOOmP9xB7lYR9j?=
 =?us-ascii?Q?sBSUbbX9R5xIMnGgWPSbqlHvwcgABtp5h5XcGpAJH9rcXAxlp5zfTW3x4QMR?=
 =?us-ascii?Q?lAReLK+Co8G8zBM78lALyvuKdGqAAGsePZgYZ05l6CFuyTwqnMrayFBP2HH1?=
 =?us-ascii?Q?wNo4r/ivlpcRJs8qWtEAOEReHJXI7icOz82cDSidZXUdV7KpL4l8Wyg0wXKn?=
 =?us-ascii?Q?fKEEeuIa5fHBfEQAG79WIxMdz4UMbEsxJSGxUp3acHl3ldRm1wRF24QZS7O0?=
 =?us-ascii?Q?UjZqvjlHQDDIVFrqe/j0p+mAxdQMoUvC6Q3m7+SWkC6nU3zz8wpnhsnzRn27?=
 =?us-ascii?Q?uA7q9bOIOLyeDY8fUjq/uDChqVcZXxK5jQj88OM2L+m+7rsBxxGrmRQ1QWa9?=
 =?us-ascii?Q?wRowRgbOW4z88ATSgCRfjizIH/pXs8w/nuD4VqaKKhjPKRsMgQL35UOTH0fh?=
 =?us-ascii?Q?AQbEwAl17ZpC1KenbGDKf0fUJbHbIgSnieQpwLL2REljBvhZ0P+w/JHUenUG?=
 =?us-ascii?Q?U368QSP6A2076HYsamY69Vm1nhT0wtvn7tBxZ0ANyORbN7+jeZZSkBbTvqEm?=
 =?us-ascii?Q?kkiv2X0CzwdR+W7CJaXBvERVA4ohrIt4b5RBFIdqAW1t500trheb/jmTOfL3?=
 =?us-ascii?Q?m+2dT0uH2j3Lyunub7RizbU4S0+GYEy4PsNjAYOgDb3X7KWtSjeGohJ8Mhoq?=
 =?us-ascii?Q?D2ODh42E5AOdWsy9DzqSc8D1zqUBAwzXfyHQJ8uNkrcmLIfUm99eMOSuCNud?=
 =?us-ascii?Q?bpWtCPjxMXfe4Jp1oi8fhf6L8ErB1EWqXWs75KT2qUJrKnX4Kn1wvaGCsTWz?=
 =?us-ascii?Q?hxIDoIJoB6l41eeSfo+F+LbXYBcncN3VbMIOB+pr/SJ+kCPFfVVeXuz1XgLH?=
 =?us-ascii?Q?D5XA4PEH4R4GgeuLZFvape/VZHgpkpyzhqtXH6J+uCvvcyryZ7CnWU+EM8hi?=
 =?us-ascii?Q?h7t4x7nq49D3u8ioTN8YB6wegBNLqkgYDygOGj7JZ1w4qVxGrbL56RjQGtAk?=
 =?us-ascii?Q?V7677Kvf+ZglH5RTP2W7QWCzZ3h1XlNh/Y4KrFtN6ck3o/wqBzyl30Oow9qY?=
 =?us-ascii?Q?5ZCWG1OoFzCP9vHJUnqZOYhEORIHjgY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e03e41-931b-41f2-725a-08deb19cc657
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:03.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qwfsq44msLEeO8kCSKjRRcgaCfZ+fFNYVUjTW8i4hu12FxYdP3hCJwt6t8iq+dX6fOGdrTMYR3XR05oUg5ugoCSnzwZgfNFVRXHxD5s+DjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22934

The Renesas RZ/G3E SoC features a PCIe controller that shares
similarities with the existing RZ/G3S PCIe controller, but with several
key differences. This series adds support for the RZ/G3E PCIe controller
by extending the existing RZ/G3S driver and device tree bindings.

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

John Madieu (15):
  clk: renesas: r9a09g047: Add PCIe clocks and reset
  PCI: rzg3s-host: Fix reset handling in probe error path
  PCI: rzg3s-host: Reorder reset assertion during suspend
  PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3E
    SoC
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
  PCI: rzg3s-host: Make SYSC register offsets SoC-specific
  PCI: rzg3s-host: Make configuration reset lines optional
  PCI: rzg3s-host: Add SoC-specific configuration and initialization
    callbacks
  PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
  PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
  PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
  arm64: dts: renesas: r9a09g047: Add PCIe node
  arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 121 ++++--
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  69 ++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  16 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   4 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  11 +
 drivers/clk/renesas/r9a09g047-cpg.c           |   5 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 365 ++++++++++++++----
 include/linux/bitfield.h                      |  89 +++++
 8 files changed, 570 insertions(+), 110 deletions(-)

--=20
2.25.1


