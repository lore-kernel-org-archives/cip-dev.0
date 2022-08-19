Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF30DC00140
	for <webhook@archiver.kernel.org>; Fri, 19 Aug 2022 00:07:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.49313.1660867648291724537
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Aug 2022 17:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 27J078XJ018591;
 Fri, 19 Aug 2022 09:07:08 +0900
X-Iguazu-Qid: 2wGrJ42ogwv9L4l38T
X-Iguazu-QSIG: v=2; s=0; t=1660867628; q=2wGrJ42ogwv9L4l38T;
 m=Qhg/pRTemvH/fSR0L2HJbWuLQfFm62VgsuZZSs2woNQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 27J075bx000530
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Aug 2022 09:07:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKXwV8Ateezf7zuq7YmXrEpmdTOQEd3BZGmXhQ/Dv7iOr6p3fGTjMftXHiQqtfFm6UIcZaU6tJtXq7g2MakDrZyfSQ8s5FdeZ2bJPcOEZ6YIrIAjm5ArEAVCBoE+djRzxmFyBCJM9eiCnc0Exk/2FfnoQWlMVsmc7Rm5f3Ps9rwq87UDfT0jiKoRc7yNAAlPTe9JluIFujTImDOiROr6QN+ZZkU8KR9oAQcf0fCIxvJF4Wu2j3RXeU5N4ar/Ru/dmeDjcHjrJgO1/UCTIAmUXbUviLNYVtgQIJ1nx6cQozjQVeMWTtD6W/seS8Rzs6t2XBmB1r3FNttx11FO3llzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr2hJbkAopU4g6QAs7COsl1DtQAAghGB2DK35ZlDG78=;
 b=brA07dZzL3w4yFI621y7/VJ1Xnhk5HXzNvCPlQNv/Xyq8Hw33hwnsUbhP8x4T0FnES4fuCA+pOs2wQNIciP80MmziRQ8Y2xwOdNZ5uCeoXniqlB1w4fVtp4YLSc1DadsD8RSWGr9snwLUypwHESxfzQpQHX+zCgJiEt2Bd+HAzg7iZmEU0skxtIkycQSApMno5pDciNtWYWlMudWY+Nu410VtYeaFPFKPGXljjKCIvIY5ukJUGrxhWuTrxqc8cUC+7XlnEewaXshFPpGBvZHO8xzmXcPTpMnqhLfZ51r3A8chWKd08YOA8g8yc2PVTpJEwZ1S8UBW/YKa/TFmR4R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <chris.paterson2@renesas.com>, <uli@fpond.eu>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.255-cip79 and v5.10.136-cip14
Thread-Topic: [ANNOUNCE] Release v4.19.255-cip79 and v5.10.136-cip14
Thread-Index: AdizXx7+c2eDfeLcS/eqFqWkdZG8OQ==
Date: Fri, 19 Aug 2022 00:06:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94203CB905E59D076F372A5C926C9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4574a972-9827-42cb-bbaa-08da8176ba78
x-ms-traffictypediagnostic: TY2PR01MB3146:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3gNEb41LOkkJLCNrrwVvCBhV/6w0b6TQGy+kABz1jghvdpqp9CpIe5hUTZPvS4A+95co6iLThhfCkzfTAWvXJUeF3DI2icpLx2HOaeg//EWRuIZkjUVgbt0avUP3l8LuaJlP8VkgASHDr8+x/NqCV/yAJuThg8Ih2xQzry+aUZL+jLEavky/Kive3H2QhMv0tcHaSSu/5aE6SJYo2UkLtN9LfjUI2j3BWe66yT9GaM/eOCNjS1x8sr3pBSu5xXbupyKdWTmr0SUVprnQBETCJhaGenAyulRFkZIhec82jh3nDjBN24eSmHNxH4l5tUdt6wuPHZXDVjQDYxZfoUu3p3kieTfvaIWWSIWbqVTVkpQi8BXsoTCy1HKgJ+kqiTBxWE8MZvE5AcLRwwe6tTwhOhmjpgns9Mxga+6SO2DgxcP79bCpqE6A/0qRodZKlw+ymE2H3ya8VQRbc9rFRCMesvkFLni5MGFe0sZutRjRD148ySjUKZE+k4mePW3NdJKbw0UK9P1ruTkuaylYD3i/2PzUi9OP6KOsSCHe3NuzM+mQXbUXXUGy42t8mhVHNTvSoPAJCcazOUuQwLAhH3SF5kCxEhpOvwXWd+QMtwimAECGoCcbua9Y6uJp1ADOR7YUOTt77rFmtwcspokdOk409OZJhkks5oa1CaO1dvzCQgCRIPFtsuiRzOT6r7bJH/py7rZrpmMLz0q1+55e0NiR5+YKTd+lzPACBmIZflZBC47YPe4abNKEJkvhJ9ORiuKWZ46eT8vVbINga2iJ8L7x9VNEpRP5J7+HrYBwfN+iF9s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(5660300002)(54906003)(4326008)(66946007)(55016003)(66446008)(76116006)(52536014)(8676002)(6916009)(66476007)(64756008)(66556008)(316002)(8936002)(38100700002)(2906002)(122000001)(6506007)(38070700005)(41300700001)(33656002)(478600001)(9686003)(7696005)(26005)(71200400001)(966005)(83380400001)(186003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T0ZZUU5SU3E5Yml0K3UrM28xTDFsTTBjZDRrTW5IRGNWZU9jSjlsWW5X?=
 =?iso-2022-jp?B?Nm1CVnRnZTNVM1N3ajVMdi9BaHVmNk5PMFFZWWR1bXQvdWNXYlppd3R1?=
 =?iso-2022-jp?B?MHdTR25yTEhtMlNQcTlpdmVmWjF1aDh1bi9FbEtRWDdicUJmTWxOcUJ2?=
 =?iso-2022-jp?B?WXFZMnRxdVp2WkwyZGl4T21XK0d5RWRQbzREbEtuZnRBOGdqdTdCVlIx?=
 =?iso-2022-jp?B?RE5ONXJoNGdmRnRGSjF3dmlHd20yKzdvMTdHcysveFpYU09CbEpRdjhM?=
 =?iso-2022-jp?B?M1dLSjFVQ3dlTHRCTERLWVZHVTZMaUFZQ2NXVjhPMFE1dWkvTjZiWURp?=
 =?iso-2022-jp?B?c0c0aDZlZzh4byt1VTJmUmNlVSs3TXlyb1V4eVdwWEIvTmJwclpvenVX?=
 =?iso-2022-jp?B?NmZDR3BmV3BVU0FXcm9jWWtCanpZWXhlbFFYczF2dVBqWmVOeEF1WEZ2?=
 =?iso-2022-jp?B?UFpnZmVrblREekxzb2ZydWJ6QUpWY3hUZzlDYU9rRUFBNFlwcWh2S1JH?=
 =?iso-2022-jp?B?cnhERlpubnJWTUpuamtRdU9tUzNpS1l4bkdGQXllTHhlOVk3amVHODhW?=
 =?iso-2022-jp?B?VDRPWm5jdVhvZkcrRGNTQmF5cm12K1puSEFaVjY3cFJLdFJha2V6aTMy?=
 =?iso-2022-jp?B?YWFHQUdjZDFwaDNIK0w1aENRN2M0clhtZ0I0VkJpY3RKKzdQam81V0pz?=
 =?iso-2022-jp?B?SHlFUENLWjAvdmw5aEtkTUY3aEtkeXBqTklCcTFXTVkreHppemQxWnZo?=
 =?iso-2022-jp?B?bDhKTWxyRkd5ZUIxTElpeVdiQVJXbU03M09ncHlnSXd4NW1PaDdIZlVL?=
 =?iso-2022-jp?B?Y2FuQTZRUkl2VGhQWjBHZFRSYmk5YnNndTJVZ2FKRkZXdDFxWTJHb0Za?=
 =?iso-2022-jp?B?OEJIbzZzNml1TjI4VytzQnJBRS9kUUcrdGV6RytVVnZQd2p3aFBKWUd4?=
 =?iso-2022-jp?B?dG9hajJ0c28xTkNpVGNZWlg4VUNQb25EZ1RGNVRrUkVESlNBTGhaTFlF?=
 =?iso-2022-jp?B?aXYvbDlNVFZHUzhoUjNCRG5haUtOaS9RZnkwaEVKVHl6WnBZaUdNUkZG?=
 =?iso-2022-jp?B?L1gyUDhLdW9td3ZoaU45OVRVNXpMd0RpNXRVei8xNzlTcWhSVEVpWDlz?=
 =?iso-2022-jp?B?MnZucnhYeXZwRTZIYXdRZGttazkvby93QS9ZRXBvdVZCLzFNMjFjMDA4?=
 =?iso-2022-jp?B?SE9nc2FkM20xajlOMXZVWlZrNjFhUGZaVzZFd1djRitzbEdIQ1RXWUxk?=
 =?iso-2022-jp?B?aXdxS1hGeS9aL2RFVG04c213cXBLeHduUjhuKzFUK1hQTUNwTUJmV3ll?=
 =?iso-2022-jp?B?OUJNdHFSbEtuZkQ4YnJpNU5lcVd6NGJUVTcraGM2b08xNDhkcmtFS3lK?=
 =?iso-2022-jp?B?N0hqL0pXdUJBRFFYMFNlU0ZmSWFmWHZQbjNNbURqYnNSWXdKNGtTRXU4?=
 =?iso-2022-jp?B?Y0JteXcwQ2R2U2V3VWNVZVZCamhncWp6RTErWlRlTTJIOEZkcU5nbHlP?=
 =?iso-2022-jp?B?SkxySUtrWVpJUnpZRmora2VhdXB5ZGY0aFNEb0dNNDBxejl0d0p3NmQz?=
 =?iso-2022-jp?B?cEJSR3lqOWVVRzQwend4dERManp6VkZRNzZ1M1Z6eXJaMEJhWm1QdHRJ?=
 =?iso-2022-jp?B?eHc2VTdwNjBmS0NyTUJnb210NGVqRURzSW5YbFM3dWZxN1lTczNXcFBs?=
 =?iso-2022-jp?B?ODNOMjhrU083anhMUkJhYjNlbjF1dGJqVldDRDcxcU9lRHBYK3VWbnVa?=
 =?iso-2022-jp?B?Ty9IN2k4ZFVVZVhTYS9nYTlBMDZXNHJ5VXZWdkFKQitjYzFBbjAvbjZQ?=
 =?iso-2022-jp?B?N3o1ZldQWTNRNzdzd2ZsRXFScEUzeHJXbUx0aFM1NVVGVER3c0JMUzBQ?=
 =?iso-2022-jp?B?Rkx1T2ZySnE5c1AzNThiMVlWYTI3NnF2cDRVUkpPVm1TeUw1UnlKc1k1?=
 =?iso-2022-jp?B?Nmh6eTFZUk4wVlU5OGFnV2dUU3U1bzdUaDlsUGpERjRtVnFEVG1mVzc1?=
 =?iso-2022-jp?B?UU54SDh4bU91bjB2UFl2TE5aUWFUUElHc1JmVmw0ZFozWnRHeG0wUHh4?=
 =?iso-2022-jp?B?b1k4ZXdSRTA1UUJNc3dISjdPQlRmVjFsVEcwRFZDM1BLTUtySkE5SFRI?=
 =?iso-2022-jp?B?S002L2FuZ04rVVllRG9FVjEya0RqTUxiOWEyYUlTQUhCbFdNd3hiVE5m?=
 =?iso-2022-jp?B?SFEwWUhjdzEvM0xjQWprQ2NoVkIzbm5RY3NzdEhJd1ZKQ0ozRHJrbnZi?=
 =?iso-2022-jp?B?Ymc5ZWkrRHBDUmlJOVlPV1hpdkRCYmFpVGpUQUgrWkNUM3A5U1VXRng5?=
 =?iso-2022-jp?B?WFhoOTZVdVpVSVBIOWlTVnM2V3Z1QzN4VFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4574a972-9827-42cb-bbaa-08da8176ba78
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 00:06:56.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 na0LxlRvUfMIb2Zb5A74G5ty/REudkSDcI2qIKwXPhUi6hS9ZbzX7TcfoOhTVguQF35rdATuQXfmwZRD6T1GiHO1mAYcbHO0QxzmDOgGhmxrwhBW5ifwFo6uI4U6TahO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3146
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Aug 2022 00:07:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9293

Hi,

CIP kernel team has released Linux kernel v4.19.255-cip79 and v5.10.136-cip=
14.
The linux-4.19.y-cip tree has been updated base version from v4.19.252 to v=
4.19.255,
and the linux-5.10.y-cip tree has been updated base version from v5.10.131 =
to
v5.10.136.
This release adds support for RZ/G2LC SoCs and adds device drivers and DT p=
atches for
this device.


You can get this release via the git tree at:

  v4.19.255-cip79:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      d48af81b093ff24e12907e79ce476e6efc4f7e4f
    Fixed CVEs:
      CVE-2022-36123: x86: Clear .brk area at early boot
      CVE-2022-36879: xfrm: xfrm_policy: fix a possible double xfrm_pols_pu=
t() in xfrm_bundle_lookup()
      CVE-2022-36946: netfilter: nf_queue: do not allow packet truncation b=
elow transport header offset
      CVE-2022-26373: x86/speculation: Add RSB VM Exit protections
    added commits:
      CIP: Bump version suffix to -cip79 after merge from stable

  v5.10.136-cip14:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      cf2009ac91c8812c08044a33e89c1a53727345bb
    Fixed CVEs:
      CVE-2022-36123: x86: Clear .brk area at early boot
      CVE-2022-29900: x86/kvm/vmx: Make noinstr clean
      CVE-2022-29901: x86/kvm/vmx: Make noinstr clean
      CVE-2022-21505: lockdown: Fix kexec lockdown bypass with ima policy
      CVE-2022-36879: xfrm: xfrm_policy: fix a possible double xfrm_pols_pu=
t() in xfrm_bundle_lookup()
      CVE-2022-36946: netfilter: nf_queue: do not allow packet truncation b=
elow transport header offset
      CVE-2022-26373: x86/speculation: Add RSB VM Exit protections
    added commits:
      CIP: Bump version suffix to -cip14 after merge from stable
      arm64: dts: renesas: r9a07g054: Add TSU node
      arm64: dts: renesas: r9a07g054: Add OPP table
      arm64: dts: renesas: r9a07g054: Add SPI{0,2} nodes and fillup SPI1 st=
ub node
      arm64: dts: renesas: r9a07g054: Add USB2.0 device support
      arm64: dts: renesas: r9a07g054: Add USB2.0 phy and host support
      arm64: dts: renesas: r9a07g054: Add SSI{1,2,3} nodes and fillup the S=
SI0 stub node
      arm64: dts: renesas: r9a07g054: Fillup the WDT{0,1,2} stub nodes
      arm64: dts: renesas: r9a07g054: Fillup the OSTM{0,1,2} stub nodes
      arm64: dts: renesas: r9a07g054: Fillup the sbc stub node
      arm64: dts: renesas: r9a07g054: Fillup the I2C{0,1,2,3} stub nodes
      arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting can{0,1}-stb-ho=
g nodes
      arm64: dts: renesas: r9a07g054: Fillup the CANFD stub node
      arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting gpio-hog pins r=
elated to SDHI
      arm64: dts: renesas: r9a07g054: Fillup the SDHI{0,1} stub nodes
      arm64: dts: renesas: r9a07g054: Fillup the ADC stub node
      clk: renesas: r9a07g044: Fix OSTM1 module clock name
      dt-bindings: thermal: rzg2l-thermal: Document RZ/V2L bindings
      dt-bindings: watchdog: renesas,wdt: Document RZ/V2L SoC
      dt-bindings: soc: renesas: Move renesas,rzg2l-sysc from arm to soc
      dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L phy bindings
      dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/V2L USBPHY=
 Control bindings
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2L OSTM
      dt-bindings: i2c: renesas,riic: Document RZ/V2L SoC
      dt-bindings: can: renesas,rcar-canfd: Make interrupt-names required
      dt-bindings: net: can: renesas,rcar-canfd: Document RZ/V2L SoC
      dt-bindings: net: can: renesas,rcar-canfd: Document RZ/G2L SoC
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
      spi: dt-bindings: renesas,rspi: Document RZ/V2L SoC
      ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
      dmaengine: sh: rz-dmac: Add device_synchronize callback
      thermal/drivers/rzg2l: Fix comments
      mmc: renesas_sdhi: Fix typo's
      mmc: renesas_sdhi: Get the reset handle early in the probe
      spi: spi-rspi: Fix PIO fallback on RZ platforms
      spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()
      spi: rspi: drop unneeded MODULE_ALIAS
      spi: spi-rspi: : use proper DMAENGINE API for termination
      spi: rpc-if: Fix RPM imbalance in probe error path
      memory: renesas-rpc-if: simplify platform_get_resource_byname()
      memory: renesas-rpc-if: Simplify single/double data register access
      memory: renesas-rpc-if: refactor MOIIO and IOFV macros
      memory: renesas-rpc-if: avoid use of undocumented bits
      memory: renesas-rpc-if: simplify register update
      memory: renesas-rpc-if: Silence clang warning
      ARM: 9093/1: drivers: firmwapsci: Register with kernel restart handle=
r
      arm64: dts: renesas: rzg2l-smarc: Move gpios property of vccq_sdhi1 f=
rom common dtsi
      arm64: dts: renesas: rzg2lc-smarc: Enable RSPI1 on carrier board
      arm64: dts: renesas: rzg2lc-smarc-som: Enable OSTM
      arm64: dts: renesas: rzg2lc-smarc-som: Enable serial NOR flash
      arm64: dts: renesas: rzg2lc-smarc: Enable Audio
      arm64: dts: renesas: rzg2lc-smarc: Enable i2c{0,1,2}
      arm64: dts: renesas: rzg2l-smarc: Move out i2c3 and Audio codec from =
common dtsi
      arm64: dts: renesas: rzg2lc-smarc-pinfunction: Sort the nodes
      arm64: dts: renesas: r9a07g044c2-smarc: Enable usb2.0
      arm64: dts: renesas: Align GPIO hog names with dtschema
      arm64: dts: renesas: rzg2lc-smarc-som: Enable watchdog
      arm64: dts: renesas: rzg2lc-smarc: Use SW_SD0_DEV_SEL macro for eMMC/=
SDHI device selection
      arm64: dts: renesas: rzg2lc-smarc: Enable CANFD channel 1
      arm64: dts: renesas: rzg2lc-smarc: Enable SCIF1 on carrier board
      arm64: dts: renesas: rzg2lc-smarc: Add macros for DIP-Switch settings
      arm64: dts: renesas: rzg2l-smarc: Add common dtsi file
      arm64: defconfig: Enable ARCH_R9A07G054
      arm64: dts: renesas: Add initial device tree for RZ/V2L SMARC EVK
      arm64: dts: renesas: Add initial DTSI for RZ/V2L SoC
      dt-bindings: net: renesas,etheravb: Document RZ/V2L SoC
      pinctrl: renesas: rzg2l: Improve rzg2l_gpio_register()
      pinctrl: renesas: Kconfig: Select PINCTRL_RZG2L if RZ/V2L SoC is enab=
led
      dt-bindings: pinctrl: renesas: Document RZ/V2L pinctrl
      dt-bindings: serial: renesas,sci: Document RZ/V2L SoC
      dt-bindings: serial: renesas,scif: Document RZ/V2L SoC
      clk: renesas: rzg2l: Simplify multiplication/shift logic
      clk: renesas: rzg2l: Remove unused notifiers
      clk: renesas: rzg2l-cpg: Add support for RZ/V2L SoC
      dt-bindings: clock: renesas: Document RZ/V2L SoC
      dt-bindings: clock: Add R9A07G054 CPG Clock and Reset Definitions
      clk: renesas: r9a07g044: Update multiplier and divider values for PLL=
2/3
      clk: renesas: r9a07g044: Add GPU clock and reset entries
      clk: renesas: r9a07g044: Add mux and divider for G clock
      arm64: dts: renesas: rzg2lc-smarc: Enable microSD on SMARC platform
      arm64: dts: renesas: rzg2lc-smarc-som: Enable eMMC on SMARC platform
      arm64: dts: renesas: Add initial device tree for RZ/G2LC SMARC EVK
      arm64: dts: renesas: Add initial DTSI for RZ/G2LC SoC


Best regards,
   Nobuhiro


