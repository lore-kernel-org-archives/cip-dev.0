Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E36C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:00:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.60])
 by mx.groups.io with SMTP id smtpd.web10.18676.1742554849009449281
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tanZG/lB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8cqkD9KQe7EYa1qL1eDYagRC9S4b+EQ/3f5RQ0+saf2WyodKP4M28MILYHyUlcor0kEAbUoKUZxF5pPF1nOXTAsFfNE2lSnwoZ/KKOK6v6PsgDSbVzJaANpQyt7F/jTzDEX2CDkw7FKzC6QGZjWMoirKkuF4FSmmIuZJ5BYYQB3V599WtS8mUCs6RXoxbEyxBKrHAdVopzozIDWjKtNo5cyDz+25b1ksA+E3vhND4ACi0FuvGxWsgRDXNa+JGtSITY3RJLwe2XGOSUbjGqiB6TNOyg64iE3JFR3x8u1j3zDjEgNtw397HpH1oqgKJxiUNJrtbBtn+l1lGePrlzZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7CKs0QnwfHOKgZ/FHCmFRxO90Ost/D/uu83qVlq9PM=;
 b=Wkn/ZrN7T/qEiMLvGqAlofLPLKAA/VHaZaONHR3rNRWYwg+uJsIZc9k1AMHOJIFwKDMYTAPK7BwrB6qozLAoyx2iqwIShuiZ5ngEQLzuPuBRw8lDlq+sW9yPF+7lHWBkxHwdyPdLeHwP7bOLQNvXOXcCQYJeyWRySDtEYSM5N0gxUegNVzjLJBctKNWdnNGowmprysYx3/PmwNheOMSvFp0eMrDsXIyqR6h04RIXByUPt0ozMuwCufD7sPsMx0greT1XxjV6+fiXhgK1gUeNnpFo3Jwsjpt4EkeZkvtMWDCe+IFjIQ/q8EbwpMDt8YtzkMikNdv/nsalv2Kdss7XKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7CKs0QnwfHOKgZ/FHCmFRxO90Ost/D/uu83qVlq9PM=;
 b=tanZG/lBXcEWH9Zv3RvZZCL7T/99VzXGvY9KZFbhC9XICvHsQq59g8n8ygYND1UuEVXI9Fkvny3PGwBUornPZnUeRgPb0Hd4g+4wH9C/302Xeov4QmqO+fF65lecqwq4INnJIrYH1sdANYjX/Z4g/udExXsJ8qDPp/ekbEwOQig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:00:42 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:00:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/21] Add support for Renesas RZ/G3E SoC and SMARC-EVK platform
Date: Fri, 21 Mar 2025 12:00:00 +0100
Message-ID: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e3d5b0-d05c-4058-4ec3-08dd68679f29
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f1QCwzezEcCObuN+LEKQvIQNz/6CUghbz83ytrc53ESUuLig5QYgS9rtnfBT?=
 =?us-ascii?Q?PHFl42aNu7pqfBmDDMukxGN2XzzrXYg3fYWZ9gI5Q94Gmx/kvg2i8wYJpayD?=
 =?us-ascii?Q?8aiW8NpXt55rtxhVdNFj9yKT/IkeCGWfttboi2hil1UeJl+BYKpk7DwavRP4?=
 =?us-ascii?Q?sl0SDyqGPW7GEu8vJenZRuIvXoNtGF63vM+ThSCP7iAW1oRCnulsn7kQm3EL?=
 =?us-ascii?Q?CqyyKhvcC0rz92qQnYgH7jjaY7Hr5XCENI65gqM2Gx47a0sm4laQkH75B3iS?=
 =?us-ascii?Q?U/Omtnbsrd0F+QlvdZJY+sDBDfmN1/qW92h5KWmkqatBMcXS7Hjli7hSnru6?=
 =?us-ascii?Q?2ruyAh/9d9YzRFxia9L9izongrik+b2VE5htQvn0eAb2hMQlR/0n36pVYXgR?=
 =?us-ascii?Q?QLp3IJPWQbpK6D54+lE5EbFWN7C7j+MQBaRDgonww0Jrnc0DMiq+hFbUB62y?=
 =?us-ascii?Q?YPHx3dc6j4hgvU48RyfLV4CjECeiVj6SEmpzxb/FSK5uIj2RiY3tg5tlnpwY?=
 =?us-ascii?Q?aehCG4eLnzc/XOG48ecVUDvQZPypwHoXzd6KPzJA0xyq9pwERY4iVqjSON+1?=
 =?us-ascii?Q?7gOSAYs5uoDiAyriuKhVyi5WQQRxz6g2eRegtUbhFDlTtr1TTKeL0CCae3Ro?=
 =?us-ascii?Q?f/ZGZGN8118qru9Frd5ZOs2BUvaG+EtrHekzhyXOOhX0TN5+JSybo7UzMQlm?=
 =?us-ascii?Q?COl74B+EM8JfHnMpmR+7ZMtxG+sYZNKRMucvh/xj45TlMuP0W6XFm+1wSArg?=
 =?us-ascii?Q?l8rQXm2tKKlPqGeY5fGtDQ0iN9EXUeUWPup8OJG7nL6IQX2wx5uWEfz7di86?=
 =?us-ascii?Q?bHHD8pTDKOoj0TUnFoEJS6Oc69bTT30tJDVOk26XM3WIxPj7hvy7pCFTHWNn?=
 =?us-ascii?Q?C2fB+gvZbMg8S54yjs5vydIpaEJbGcBOBYUKuVZeqiBG+sjTI0h6lxq571Gc?=
 =?us-ascii?Q?sSVz3VF4m5hgGLP013N/OPn6/Y6ack2KJsim/1Ox5LtNshskdr1Cgp8aYdfp?=
 =?us-ascii?Q?nbvfUAIwE3V9MV1KxSXsErraS5X7ecFsU56pHXAaoiO9zYa9PVaRy6Hb8QvD?=
 =?us-ascii?Q?mb4wByq9x2ILj5p09ZV0A9jnAsYf5QEi/GOITiGAHu3xM3e7+nEgvk+BOYx6?=
 =?us-ascii?Q?HBBA0jgIaX6pE+IzjhaHAgJK+yXtWkP1RmqT7X8yC+JfOu57ZzZOvlzlb/oT?=
 =?us-ascii?Q?RpCe1q/dtogngYTY3oPRYS1iga/oLWFijvW+ZQJfVzib3TkMqMhbS9waYgUn?=
 =?us-ascii?Q?zhLgC6w5Immkl+9BSZwRT3d39+8cRUIlo+6/DmNi8vxWeWer3SyrrkqXONSM?=
 =?us-ascii?Q?YkP4rN7vGmLj7kOAJ7LhLMZMrufS+qAhX7AWskRuu2zV0dHqkBcNWbfoyJQZ?=
 =?us-ascii?Q?BbsHAYWknkJ8hu/RQ51CeCfrkf1zXZ1TxTGnns+diMU7wxX8odi+WQZwyIEm?=
 =?us-ascii?Q?qAuw+Ovb36te7LEKgEtek6lyROh8bhp0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VGt2dPFOfML3BQA6A60BvLuBSITv7MlF5khP7CCd2nySYMBCmJL48S0nCKKb?=
 =?us-ascii?Q?MPqWQX+asHGAtkPhegma61fk5lPQdbILX0RfdtmbA8mKK9Wuq+G523ezFlPI?=
 =?us-ascii?Q?0orRApsAMacL1CwFeyjgnOAgWwjoPN1dZrjYHJ3d6v0eQSQuU2V0xF8oLv9s?=
 =?us-ascii?Q?LE5WrMWTXqXH/8KBw3RmEFCUTi//eq/Jbo4RGnI0r1Il1N5Ip79x77a5l70+?=
 =?us-ascii?Q?osUzt9fcliYOcoV8HTomEPS7JpUqJjfY3Bu+4yQmC3aomElMUOxXa1m094Vu?=
 =?us-ascii?Q?17S9J7a/IxAHH2Wb3yX87sb+qnqEmFVDSYWoN9hvV2YLLc1xMWKq5urlVC4b?=
 =?us-ascii?Q?wgsexUWv3/XD00Chck+dRFGkc/SNVy1DVsw0yHlzAQvr1OqZbC1W4ZPn49YI?=
 =?us-ascii?Q?tCaaezh6TjAPQqvJETK+9p67pCD1cGtCqLOMhgn9lYDf2AlEtVrVUvCERCjv?=
 =?us-ascii?Q?BRqi2eAHZHSdr98cQ7oHKoOFjoGKlWlOeEkh9ipN4FMCGbKGFgGkgOtEqwr1?=
 =?us-ascii?Q?frf9OzJsZo1ZK3bQuNo1GL/abvmlAmRcukRG8x1A29nfF0lXwMikM/lIvjCD?=
 =?us-ascii?Q?2twDjmyUKASkF/20AQFsi8EnczsMixgr4ct4YWeQ1U0KbL/9q3Z3vng3Rttj?=
 =?us-ascii?Q?pRqNYd4aB4oNRn1m6mugiq+EhPu+hxghp6FiXQLyWUgqPLmWzx45bkinDO5I?=
 =?us-ascii?Q?kVmeR5LyJ56tGJNBUHXumHy8OrLizkNVFSY7HJDTZG0lok4WtKBM7/tHJkBR?=
 =?us-ascii?Q?xTi2j0o3rKHH7Do8y5TuhW2DK8SpEnm4jcs0yoOyX9bVD7kt8kWNdmsrTDAq?=
 =?us-ascii?Q?2gbL80uhL52QsVp7D9fchRHyqqSp4tv0qGj19kIXgjt0S8EUskP4yslofUc5?=
 =?us-ascii?Q?+ASgl9Knm1Oq7lBHJY42rXim3Ovbf8XQbUVVeig7r8Ql/djFf48S1iyfsGVa?=
 =?us-ascii?Q?ZMJBiRWJ8aWKHBvp6BCdWJCV5zPxkIq5K7uU+W0AwD5V9vUjXZDuKKAObP4Y?=
 =?us-ascii?Q?A6wsnQl2GRhMHotsPsl0pI0SXE/sO5jHvHNXgaLFcgkfbx/cS1DQ6uRXv94h?=
 =?us-ascii?Q?C51MV1gaiJMR3lgCCLs/HuPGJr7eG7tIXkTmiG8W7VJED/lUS9UbJZ3/Ts20?=
 =?us-ascii?Q?3zI4tuc/l4lP5BKyuEAsVesPAMzrktqA6EQuWP+pQdn0nGh0/8NeTKsfPxEB?=
 =?us-ascii?Q?7jJuyx6mX3zDRC8AjL113Nk1WXYPD/9DGHy59gMNfJ1g3syIxkBkZRt4CBwG?=
 =?us-ascii?Q?i4mPyfzUkyRthLZfxK8zrtSYbyTxsv9YYA27g/itKY3RPap6UQ2NkPq7Gdi6?=
 =?us-ascii?Q?Looibe4MxHFiws0v4etdEGQjpzjUbzWefzWPPm9OAlSMHl5wZU0bJmmd8DGs?=
 =?us-ascii?Q?rRfGagH4glMqDb3tpHoZHD20iHUkZiFBJvZTWds6+iBmif+Y/t0RHWSOX8pC?=
 =?us-ascii?Q?+X9UcCXT74+g0eVpKc+bnn83PpKHaTAia7hDWtr89XyksSYlqM1W5E0DpPko?=
 =?us-ascii?Q?JGzyXwvmopn8QbujETAr0qdu8/W7afgf1Fm2HBnk5ud9fc6qmg/3nKdO5+rZ?=
 =?us-ascii?Q?0wEWaJXZBj3qI0aqb/nNFdIdO0QZRON4i0E9wsIcvV+wCF9x3zVEEaz0Rijt?=
 =?us-ascii?Q?qCRhvtO3isCe4BXaQCQvhl8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e3d5b0-d05c-4058-4ec3-08dd68679f29
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:00:42.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZkUiD4/prJU7jKP5FxNswv3zuSBtga8Jqh34hTWbEV1kboMlEdEPwZw7T+OtAv4qFhyw2c+Dm941eJSSGcWm4ApJ8Lv7sa9mr6RirsY7hpX40yA3A80f+9PpRuXTC2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:00:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18307

Dear All,

This patch series adds initial support for the Renesas RZ/G3E SoC and
RZ/G3E SMARC EVK platform to linux-6.1.y-cip kernel. The RZ/G3E device is a
general-purpose microprocessor with a quad-core CA-55, single core CM-33,
Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.

All patches are cherry-picked from mainline kernel.

base commit:
 - d08cad4e6b10: serial: sh-sci: Increment the runtime usage counter for th=
e earlycon device

Test logs:

# uname -r
6.1.129-cip38-00033-gb59158b647b6

root@smarc-rzg3e:~# cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 2
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 3
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp a=
simdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

root@smarc-rzg3e:~# cat /proc/meminfo
MemTotal:        3888744 kB
MemFree:         3585072 kB
MemAvailable:    3519384 kB

root@smarc-rzg3e:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       2884       2689       2611       2768     GICv3  27 Level     ar=
ch_timer
 14:          0          0          0          0     GICv3 561 Level     11=
c01400.serial:rx err
 15:          1          0          0          0     GICv3 564 Level     11=
c01400.serial:rx full
 16:       1241          0          0          0     GICv3 565 Level     11=
c01400.serial:tx empty
 17:          0          0          0          0     GICv3 562 Level     11=
c01400.serial:break
 18:         49          0          0          0     GICv3 566 Level     11=
c01400.serial:rx ready
 19:          0          0          0          0     GICv3 563 Level     11=
c01400.serial:tx end
IPI0:       261        139        301        201       Rescheduling interru=
pts
IPI1:      2768       2155       2133       1553       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash =
dump) interrupts
IPI4:         0          0          0          0       Timer broadcast inte=
rrupts
IPI5:       186        156        150        171       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrup=
ts
Err:          0

Thanks & Regards,
Tommaso

Biju Das (12):
  dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
  dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II
    EVK
  dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
  clk: renesas: rzv2h: Add MSTOP support
  clk: renesas: rzv2h: Add support for RZ/G3E SoC
  clk: renesas: r9a09g047: Add CA55 core clocks
  arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add OPP table
  arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
  arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK
    board
  soc: renesas: Add RZ/G3E (R9A09G047) config option
  arm64: defconfig: Enable R9A09G047 SoC

Fabrizio Castro (1):
  clk: renesas: r9a09g057: Add clock and reset entries for ICU

Lad Prabhakar (8):
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

 .../devicetree/bindings/arm/renesas.yaml      |  17 +
 .../bindings/clock/renesas,rzv2h-cpg.yaml     |  83 ++
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 185 ++++
 arch/arm64/boot/dts/renesas/r9a09g047e37.dtsi |  18 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  18 +
 arch/arm64/boot/dts/renesas/r9a09g047e57.dtsi |  13 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  24 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  28 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |  14 +
 drivers/clk/renesas/Makefile                  |   3 +
 drivers/clk/renesas/r9a09g047-cpg.c           | 118 +++
 drivers/clk/renesas/r9a09g057-cpg.c           | 280 +++++
 drivers/clk/renesas/rzv2h-cpg.c               | 999 ++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h               | 224 ++++
 drivers/soc/renesas/Kconfig                   |   5 +
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h |  21 +
 .../dt-bindings/clock/renesas,r9a09g057-cpg.h |  21 +
 19 files changed, 2074 insertions(+)
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

--=20
2.43.0


