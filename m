Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E21C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 12:10:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.21217.1706875855940998379
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 04:10:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 412CAdiT1401924; Fri, 2 Feb 2024 21:10:39 +0900
X-Iguazu-Qid: 2yAbDGJnhzcG0vmBqm
X-Iguazu-QSIG: v=2; s=0; t=1706875838; q=2yAbDGJnhzcG0vmBqm; m=+jKYOvNh2O0ri8diUT8ZMZty3pFszVxn8wh+u/CX83s=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 412CAagB2721372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Feb 2024 21:10:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmCTLu7+FCFTDgm4UFYldSVQ98EIKqRcxOZVmu32Rp7Ag5q/SINZobwWJub3slwe2y+MBcadUJWZpVFWwFIXcMjxekvZByliJVplE+DGOSAedhw6XNQ0XfbXb+e2nPIVbKFbD4Kc+lEvjju6T5dfqEIS9AWZOZ1j44fF34Z9puoW5vwqHaTr2NN17JDC1lynp940FNpZpCzi5ypWtESW+SKGqeujNzNKBxbU4Sx/YD1HnL0WY9uEEHkaSBjRKfe1mL2PGARCypN0IxxkpEsXt5oK5WmNYUxVEXzmoTwZhmlZ8hhNOaYPGHDtJd4P3ZgEjmU+5PyTCDEHo9y9n6TYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38TK0UPVsxUlcqjIecHsaYYschXZfXkbiUE6bFiDekU=;
 b=EK/fXfENEFoHli6hwZrdPoQvRjv1EjMl9mPht3u/0AXRPo7kqmX2xq8R8J4Paww6KDq/oPdpq2XccOl25HeaLWTvY4+GwVFY9HIBy/1xHYT65svL2nD5Y1v+hfDWGTt/2wNGidek0px6E48SV2sKFJnU4WGN14bbnIjN68wVvcU6CqOgGPKuM8l1tpiJztTCA9rYOmyvAd5t1ERUa85Py/HcqLZ5egdrUEeYXtz3XvtXeDhuLEnDboKgoZAUWwj5WWoOEmvpLA6b5UaFkLqbEsBWg5Lg/szD3aHa8Vt9gT3WKrEqtFBRcof/TaRgv+jR4IzXVvNgkSFpv5VpcCfOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.75-cip14
Thread-Topic: [ANNOUNCE] Release v6.1.75-cip14
Thread-Index: AdpV0JzmAHJdkSMZS0CA5lhb/yUUoA==
Date: Fri, 2 Feb 2024 12:10:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F4C818B9775AF73BBDE192422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8262:EE_
x-ms-office365-filtering-correlation-id: e75c6d65-a6ca-48ce-0f57-08dc23e7f556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CthuSYfVTNM9081tT9R24MR7P4xt7tGST6MI97qSQ8UGnZH5R8D8lhSZDwK7GG+kQT8XIPmGeP47wXRBmBZVfL49cQ4MPCstdQfkhfifXNYwiwXQtwx4EiIEKjF+zcDRRYwh1I4BXBYQKdMTZSy7IyxqbkTqU8XOVFFwJw7Yl85te8nz+o4vsymZGhcExtcPWG7AboFGZGmhz1qtMmArcQfZs1XBCfGDSYpunmaDW0glVRSLIGTfjwirJkp8u2xDcBItTNqh/REwRoi6MmbjrvEpVg+0mmULEz7VwfebwUHie2S3DPaJP73YqbGhq2QhmjBJV3gif0jin7l6D4I9fEYGaBEetGInH6DdDDIlockV8EO9KewqDVwg8etDhG1dzzjEyA2IQHSnrEmu9oMIx68xyY0ZLqSCB80obN6XyJhxIA+XrTEbbDPhTsrVjX5+GkaBbSS5YGZYn2+arq12TbnGMnMUYxVMtoR6Niqv31rLhgckYSwMEvTv3FsltVZB82xX6WaYKYiUgJvrJ5e0fv+YX7T/w3BU8kD+QJzSdBoY24NJYL6jcjX1d3QVltroCKrqai7ASZPWsTwPNo97XWCLo/bYfnNiRbcTDoGYs3yBR25VZs8sMjfxRt1ceC5qg6s/KTGrfoT9eylJ/lqtsi/i0ZKpzW6gUiZh8xy40Ns=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66556008)(64756008)(66446008)(26005)(6916009)(83380400001)(122000001)(86362001)(41300700001)(38100700002)(33656002)(54906003)(8936002)(66946007)(76116006)(52536014)(6506007)(2906002)(5660300002)(71200400001)(966005)(316002)(478600001)(66476007)(8676002)(4326008)(7696005)(9686003)(38070700009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Mjl1MUNZb2x1aU9SaU1lMkxRbDAva3M5SkMwMWFiSjNqQXNnTURmWGIv?=
 =?iso-2022-jp?B?MkgxZjR4Z09lU3pxM29HeWNoMVErUFVsOVpxdEh3MC9mVGRWZUFucnBC?=
 =?iso-2022-jp?B?Ulk4S0UwUDUxb1ZlSXZ3RkJ3REgvZVYrU0lHT2FKWlFZSnpDeEVLa2du?=
 =?iso-2022-jp?B?a2JUSnhvVTdkaXY3RGx0WVY4c1BqWG1pWHVKdXFXME1xa2J3dm44Z05n?=
 =?iso-2022-jp?B?N3QxSGpPME84VEdjVE00ZFlPRXM2dkpaQXkwbEMwVHUzVG1WZUE2c1ZW?=
 =?iso-2022-jp?B?QzNLa2NGV2NaL2RUNGYwMCtpZnkrKzlEQnV4bSsyT3VHQzF3N2xDbUx4?=
 =?iso-2022-jp?B?dFI5WExCVFhtbytwdndoV0NKMjk3Y0hwcjZCdjJ6N3F2WVJxbWNORm5h?=
 =?iso-2022-jp?B?dXgyWFhiWGR3eDRrTWRaY1ZDNGFTNjZRN2dXR1pOMXhoQVJxSTBIb2tX?=
 =?iso-2022-jp?B?TlhqT2xhUGt2dWJoZHpmNldLYkptOVZBSnE5RVdnTldEaWpjVGhkdWts?=
 =?iso-2022-jp?B?bUlZNDlVNnkvLyt0UXgwNXN4SXJRZTMwbHo4RU9wR2RGSFVTMnVjbUJk?=
 =?iso-2022-jp?B?eDJWUkN2TmJ5RFNMVEFmbnVIL3VlV3BxSFJvdFBYcDVuNnY5QVN1RkFP?=
 =?iso-2022-jp?B?UWtSTXp1WVhXdjkrRFNxU0t3V2h4ZjRSN09rdmRrOFBueUlSb2tqT1FG?=
 =?iso-2022-jp?B?R0kwTXgvS0h0YU8zNVFxMTlKSkVCUFd3eVN1dTJEWm91NFVnV28waE9J?=
 =?iso-2022-jp?B?bU9XNmdieWlKMGtNQkVncEJ4K1hrZHNDWmVKUUdsVnkwYzRlNHFyRWxQ?=
 =?iso-2022-jp?B?WkhsaWltL3NnVnozVkVhSWxDM1RHTGtMNGF6WEVCVXZsYUpsdWlBRHFv?=
 =?iso-2022-jp?B?Wlc0cE5YeHNyNXlFL3hVbEFvbU41bGg5emZlcmYxcHBiVWtzZGYrd2ZC?=
 =?iso-2022-jp?B?V3ZzN21XVVJLOXM0L3ZicWZiNEwvbVdqMDFSb0N3QmlmK3hITGFFN216?=
 =?iso-2022-jp?B?aU53N0MyNG1JV01MV09xMncrbkJLOW5MQ3JVMjRROEhEeGpnUDJOdkNW?=
 =?iso-2022-jp?B?VzZ6NnluREp3Nng4WDNUUjFHWGJzaUp1WEpub3ZkNmtmWmpZMy8wK09p?=
 =?iso-2022-jp?B?OVlsaHlWZ09tVWhid0NHVHlwWVRPaXlLQ2dtOXVBeDYwVU5pUE4va3dm?=
 =?iso-2022-jp?B?S3JHOU05NlkwaVl1bENJa0NWbFk1Z1JkdmlXQWFGLzBsQ0NFZGVGOXhB?=
 =?iso-2022-jp?B?OWhuWGdBZnUxdHo4V0tYNzRuQm9yTjNManNFVitPbjdqV0NyanZmVzVJ?=
 =?iso-2022-jp?B?REYzYWNCN3U1RVJtQUVobGliSHFkSTg0RFZRSlBleHpYOFQ5N0F4UHRp?=
 =?iso-2022-jp?B?cWt0eTE0QjUvS1V2ZnVYd2dUSDNFRldpVmhNR25mM2U4YUVvSHkwR3R5?=
 =?iso-2022-jp?B?aVRzdnVxUzNjVUQrV095SnYyczlIV2dJc3ZWcVRmTHVwdTRDTDJYbk5t?=
 =?iso-2022-jp?B?V01IZ1Urb0FHdlNibFY5SzVBTHNZbEl3MEQ1K0lLV0o4aThFTm9KMW9B?=
 =?iso-2022-jp?B?SzFsNjNaMXl5cUZUdU42c2duUmtXVlc3NmxWSU1LRUU4V2RSbHJ6M1VG?=
 =?iso-2022-jp?B?dEh2VndEdzRDWldoSzRqcE9raGUxY29COW02S3BObjVCYkJPS0ovOHV1?=
 =?iso-2022-jp?B?WFZuT3ZWZlNFVG1PaklOQnczOUZ6VGpsZHl6OXVUaUVrVWd0QWlSRzBy?=
 =?iso-2022-jp?B?c0FHM1R3R3NvQnNEbDUyaW9ITG1sTFFhcmtzOW1YZ0VlanNKUHpIeitZ?=
 =?iso-2022-jp?B?ZUxlTGRhR0hFRllmbC92SjhyQTgwYWFKZ0MrazlLRnphTTBES0tBUmVy?=
 =?iso-2022-jp?B?RFJMMWJkNE1BZHIyOE5pdW5nVncyTSt0TU9pcGE3M0xodlR5K3ZrQzEv?=
 =?iso-2022-jp?B?Ynhtd2pPdzREWkZVYnltVmxLNWZPNkI0VEllc2lXTjYyMmp4WENMSmlF?=
 =?iso-2022-jp?B?L0M4SFVuY2dnYTRGZXF0OUt3OWVSVTRLNFBUc0NNTWovSzFETmp3eno0?=
 =?iso-2022-jp?B?bEFEOGVSQ1o4VUZNb0MvZXQvdGlPcXdUM3QzUEdvY2tCZnBaZXc1RVEw?=
 =?iso-2022-jp?B?NTJ4ZUlUbmNlYmpkMjZVcEJPZVhYaWJnR1lPcms0MXNHTkl6K2lCU2Fy?=
 =?iso-2022-jp?B?ZUlQaGVCdkIyUGMrd2Y3Qlc3RE53UFpmOFFqT1VEOXM5TTdEcHhwMEgr?=
 =?iso-2022-jp?B?UnB6L3p2NGU5RjV1VmtEbUUwRzdGQ091cW9HVXRVZEd0R3RwQmxFdEp6?=
 =?iso-2022-jp?B?MGl2Mzl4YXpZRmVTUFByVEpOSGh1YVNla3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75c6d65-a6ca-48ce-0f57-08dc23e7f556
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:10:33.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fDev3W6YrqIkZzBc0DNJa1aSJhDEGKPQMst2rMMcli/5bM59VIMr5Iq9KsT2MoLVQyxXcqMDpyiv6ykS8phWJxqWgOpO2i7hJkwqHJj6RnEZFmxu7mwNTXUrZKBF/fH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 12:10:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14627

Hi all,

CIP kernel team has released Linux kernel  and  and v6.1.75-cip14.
The linux-6.1.y-cip tree has been updated base version from v6.1.72 to v6.1=
.75.
This release adds support for Renesas' RISC-V SoC ( r9a07g043f) and referen=
ce boards.
Also added fixes for Renesas' ARM SoC and clock frameworks.

You can get this release via the git tree at:

  v6.1.75-cip14:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      f555c0a7ff8af9ddf857352bab79675e17c358ec
    fixed CVEs:
      CVE-2023-5633: drm/vmwgfx: Keep a gem reference to user bos in surfac=
es
      CVE-2023-46838: xen-netback: don't produce zero-size SKB frags
      CVE-2023-50431: habanalabs: fix information leak in sec_attest_info()
      CVE-2024-1085: netfilter: nf_tables: check if catch-all set element i=
s active in next generation
      CVE-2023-6915: ida: Fix crash in ida_free when the bitmap is empty
      CVE-2023-6610: OOB Access in smb2_dump_detail
      CVE-2023-52340: ipv6: remove max_size check inline with ipv4
    added commits:
      CIP: Bump version suffix to -cip14 after merge from stable
      pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity=
 setting
      irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity s=
etting
      clk: Fix best_parent_rate after moving code into a separate function
      riscv: dts: renesas: rzfive-smarc: Enable the blocks which were expli=
citly disabled
      riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
      riscv: dts: renesas: r9a07g043f: Add L2 cache node
      riscv: dts: renesas: Clean up dtbs_check W=3D1 warning due to empty p=
hy node
      riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support for=
 ETH{0,1}
      riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
      riscv: dts: renesas: rzfive-smarc-som: Enable WDT
      riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
      riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable ADC/OPP/Ther=
mal Zones/TSU
      riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
      riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
      riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
      soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
      cache: Add L2 cache management for Andes AX45MP RISC-V core
      dt-bindings: cache: andestech,ax45mp-cache: Add DT binding documentat=
ion for L2 cache controller
      riscv: mm: dma-noncoherent: nonstandard cache operations support
      riscv: errata: Add Andes alternative ports
      riscv: asm: vendorid_list: Add Andes Technology to the vendors list
      riscv: dma-mapping: switch over to generic implementation
      riscv: dma-mapping: skip invalidation before bidirectional DMA
      riscv: dma-mapping: only invalidate after DMA, not flush
      riscv: mm: mark noncoherent_supported as __ro_after_init
      dt-bindings: riscv: Add Andes AX45MP core to the list
      dt-bindings: riscv: Sort the CPU core list alphabetically
      riscv: Kconfig: Enable cpufreq kconfig menu
      clocksource/drivers/riscv: Get rid of clocksource_arch_init() callbac=
k
      clocksource/drivers/riscv: Increase the clock source rating
      mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option dependa=
nt on ARCH_RENESAS
      arm64: dts: renesas: rzg2ul: Move PMOD_SCI0_EN macro to board DTS
      arm64: dts: renesas: rzg2ul-smarc: Drop including RZ/G2UL SoM DTSI

Best regards,
   Nobuhiro


