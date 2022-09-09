Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B815ECAAA1
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 08:30:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.4324.1662712227257170577
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 01:30:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 2898U8uo010549;
 Fri, 9 Sep 2022 17:30:08 +0900
X-Iguazu-Qid: 34tKrWNyUD2EZeXmVv
X-Iguazu-QSIG: v=2; s=0; t=1662712207; q=34tKrWNyUD2EZeXmVv;
 m=geiFEofRJ2YZsqF+qai65uqskHVAG1EYB3K8euh7AVY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 2898U54Q003186
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Sep 2022 17:30:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgwz69HxTfzBEKFbQngUSJncDmgT7uLe6POXxUTP0VtghUSnh+4tQJ/bFVLiIKbcxBSL/qXLKF84JHdt2AyruTCi9hQCk0VTBBP86E5vCo6+0ZbPUPV3FV0r4g1gRw4DMHzOH+Sg1xU4nwkVYbxUDOoFSylRxJHsyeKgJmaLa6VBW5XKPaAvjRGk91m9gMjOIlR4K+eCg+Z9AJo4kK4vL7mGqHfnTnbRIOWOVisEolT6AYji6rvRgSEZKmKOEHB7T0BpA7cUgATVNEqB+2gDAEcMKbYPwop7o82aMKC/g3gLFCTcHLUws8/tXjbT5cRYtIzkAqAqy/hsH2ZSqn3ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh/ghtsVTXoRuUYJYEASKtqXeEWvf+95YV/eWJVBOmw=;
 b=GfHWkbBSbva5cE83Z4anY4h94PBnTS56apgfgiJuEcPYMPiIWs9td5MyBPjqLmd4WSU7OP5jn4B2J1qpcNsY0C2tiDn5G0tlByKyN2e2xuCzos5eviTyqn5BzNI5X5W5NSq6Gsookft4waoczscJ4EZ5z8v3XrBtB9A9SpM8pnpYKM9yN7Ow/JQ8/tSE/SYhm6exf12QcgEOeb9WqCN8aljWuV2OxzFIUpJMTa+Q7IMtW4qhSgzx6bUjyXmKZ7jAkKuHFafBUc+uiIhZhCmBkRYBEcu8LpC2XhY0uqSWhsFu95qFGZtvfqDHo/kSg+qoxLR07d76qy//wHdo/jusKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.257-cip81 and v5.10.140-cip16
Thread-Topic: [ANNOUNCE] Release v4.19.257-cip81 and v5.10.140-cip16
Thread-Index: AdjEG8k4ZxPi1mNOSnCja3zXndeEKA==
Date: Fri, 9 Sep 2022 08:29:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942063F981E39F7AA306FA0892439@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB8469:EE_
x-ms-office365-filtering-correlation-id: 15079e01-ed55-4da3-4414-08da923d74b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /hpX6NIpQbbTShglpX4LcNK1xiD2KRZhmsYRmFmS37CbCzJKkd9IGWHecssdtjsDm9uTrsp22gYLpRjsSeY0oLPhscXiZa0quhiZv5IxM/t7/chhauOBCz3B0UwlywrcY0Fx9Muy1864jqO7Ybv+xpc557NLX0v09LGSxspGJCSJHOXBlyZCeJv5rANCBD2TZi41bjLngKg29+tPENzi7+pHbJgedg3jA0lsUF3/KboMltHdq1fj+ECsmk0fq9vQ2e5kG3oKRfCP9ycYv5yB+JQ9zPoej3M4sbdf4WkXoOuTA0cx9EBlk2zsE/h3zCNFGZWb9+dO9zUO04Mu25hjTeBTgCY2TYydrBZlCnsPUfedUy2nz94p59wjldLHHh9mN7xrVzHpXAVbpL5Lj3gCaUj7Bi9XGByMxXWUvFCrOWd4bsTQwsiGfHIf0g+ltwVKZwq2UMri+ZVCXo04pO2l7DhuU0uINS5LMurZN7L5HNchSDTpCz+4Kh8Kvb/3DlN50kT3dOY2eg9xhqCmeFzFsWZuZXiGtGaKLR1QHPr/Menz44YEZO+7jC+9mF4WUtr4wO3m1xs8F8lrUvlxDypSB2bCMDqyQsizSBkxSivy6yPES/zksE+d+AQviaJ+Ij9s2c0ErvDPwRppb/FwJzvqnocViHlz0ohfnh/akfRio+73woHyUJbnjLJOomx1vJjq0Pm7GxpLq6dPQHMioKii6gF4DWTRU9fj1rNahgw4OK8Z07eab2DwUhCCrNT7wlC/LBkhQF7AbtE6y51VcdlNVnXe1r35Z5cgDdUZdQI3ld4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(6506007)(9686003)(478600001)(71200400001)(186003)(55016003)(41300700001)(38070700005)(7696005)(38100700002)(26005)(55236004)(86362001)(966005)(122000001)(83380400001)(316002)(6916009)(52536014)(54906003)(8936002)(33656002)(2906002)(66946007)(8676002)(64756008)(76116006)(66446008)(66556008)(4326008)(66476007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VG8vcjBqRWFmNEN6SnUzT0RVOVUzeUFHODZsbzlDSzIyemEzMzJuRVR0?=
 =?iso-2022-jp?B?QzZKdkU4UWh4aVVHcXpaNldhc2YrSTFWZllRVUdtOU5hNHVxT25TR2Ra?=
 =?iso-2022-jp?B?ZzNqNGFCNmgrQ3lHbWNxdXp2bGE0M1J6TnV1WUtDQXI1RHlvOXkzbGgv?=
 =?iso-2022-jp?B?UGplZ0h0YWdUWHRUdjdCcHdDd0FNR0pvbS9maWhvU3gxNDMzS1NqNXdn?=
 =?iso-2022-jp?B?WXExL21mejN0bjdtY2xSYkM3UXd6emtXR0YvajBWTkRkRWtKcXgxYW1X?=
 =?iso-2022-jp?B?aVg2SUtheVJROUdYc1YzSmJIeHkzaG12djd6b2lZUzVrMVFiRmxlRUk5?=
 =?iso-2022-jp?B?a3RGajRDNlhWVGRiNGVWa2Q4SUlEcWJPVzBzbXR2VGdzYjBDWkQ0SWNN?=
 =?iso-2022-jp?B?elQxTmtWUkJoeUE5QnFXc3ZGMVgreXlWeDdoQjNJNnZxVG9wOEJwazdp?=
 =?iso-2022-jp?B?RTVtMGxqVFMzcXV0QmNUMXRCTGw5UVdDNGdZaFNTUVBiRnFrekMxeTBZ?=
 =?iso-2022-jp?B?S3ZncFhFSk9jdzcyZXpIeWo2Wm5MRFV5L3gyRGsxOEFnSDVjZlJESnM2?=
 =?iso-2022-jp?B?QzhEbTFhK2tsZ056T21Gdm80cE55SmlJQWN3NDl2WUswMnFEL2wvMENT?=
 =?iso-2022-jp?B?QjhzdlRyTWhmVkhUV005WHpza0tTeTdOaDBQczV4ZGdBSGNSQWh1ZFFa?=
 =?iso-2022-jp?B?a0hsVVlUZHd0a1VWQ00xa0NXVWYrYVFqOHY4NzNWSVAreWE3QkxFVkIy?=
 =?iso-2022-jp?B?OEFqcjJDM3Fwck5YeWZEY0c4OUI4Y0RCb3B3TCtPK3JqZC95LzkrS3NO?=
 =?iso-2022-jp?B?TEM1dEZGZ01YUEYwUlhrOVRNTHJxQjJMU214R3g5bmdlMzJIWmo2R1dG?=
 =?iso-2022-jp?B?eSs5cTFRTWxEdXJMd2lwZEh2V1V5c0RCSXRPNzJSVFFndDVvUXozYlZv?=
 =?iso-2022-jp?B?TGRWRUlId3MzckFxbTUxZTBKYXVubVdVc0JPSnRIRll2a3ZYdG1qVkhW?=
 =?iso-2022-jp?B?T0NkU2VnTVNlb3dMMC85bXl5TG5kQ29mNzNmaVNlU3BVaEE5OFlZVXdX?=
 =?iso-2022-jp?B?WTVZRzF3Q1gwZ2ZqOHpmTFpuTitaWmZtSXFNdHJYcHJ6SlF4K2YzMitN?=
 =?iso-2022-jp?B?bWpHbU9JaktpWGdoVCtqdHpoV2MwRWM1RWVSZENFem9Hd0wrRlo5ZWdv?=
 =?iso-2022-jp?B?NXk2SzQxblZQZThDYUFYYkNNQzBTU21sMlJnWE14aVNRWjB3VVh0WDVW?=
 =?iso-2022-jp?B?SUk1QjdhZnhiQXc4SVV2c2doWlBJNjc4YjBmYVFBa3NROVZ5dEgrR2tr?=
 =?iso-2022-jp?B?RHpSNFphZVVpbGd6Y1V6K0NGS3A3SWwzUTByejFaeVNSRE02c2t2WTRB?=
 =?iso-2022-jp?B?Lzc3RG9iMGRLWkhTbjhUOHlmSTF6YS9PendUbTNtb290YVRMMlhZZmh6?=
 =?iso-2022-jp?B?WEgvcGJBcVhMZk9oZ0NYUnJYeGxNd2ptcFdMT0VpcUdPYzJIY1JpdzVW?=
 =?iso-2022-jp?B?OTJ1L09hNDBhSEVhZ2pSZHRGcVpkY0dWSmRiZ01YWExVaEFlaXFpZnZq?=
 =?iso-2022-jp?B?Z1pQMENjbWdPWWo5K3MyVWl6Sk5KUmw0eXZ5V0ZLMXd0YzZyc1hvWTRq?=
 =?iso-2022-jp?B?RFUwcGUxRW1LK1M0UkdVU04yUkhvaFNaWkVnWHZtUElGa25tTzQrOUZ1?=
 =?iso-2022-jp?B?NUhJRE55N1JHeFNlM1VZVXA0WEZvOEJDaVB2dGpOS0VtMGVjcFZLak41?=
 =?iso-2022-jp?B?bEljSHpJRldpRmtzRHZ0NTkvTDVuUVNubjZTRFpxTDJZSEEyNEtvWG1E?=
 =?iso-2022-jp?B?cklHeVJKVXE2dFEyVWNETEF6UUZwYktBS1lWNEl1clBjTG13YktZdG82?=
 =?iso-2022-jp?B?dTJJdXZ6WEN5YWUxbkpVZzllelYwRGMrN1ZZbkVRcEJKc1ZlWmNXUmIr?=
 =?iso-2022-jp?B?dkVscy8vS25sakpyNHJwTy9GcGdzSjVRMmluSE5mOUYzWWxHaWxkYUhs?=
 =?iso-2022-jp?B?WjBiSmN3VkxtLzBTb2M2TFR6d0J0dHJiWGFVNEZUa0ROaE8ydjdSTERl?=
 =?iso-2022-jp?B?TXhXamY1MU9qeUFUQzFzV200Tm5ZZkVmK2VIRlp1MHd2bER6YVAyV0tp?=
 =?iso-2022-jp?B?aDBITEQ5SEpQRjBZZ1lYZ0l5RDNvTC9KK0tkbDlFL25kWVJkTEI5T3Ry?=
 =?iso-2022-jp?B?enR6bDBkaXVhQUs1SStIUTBxNkwySnhIdE1zM0hPMndDajl1SXM1THlr?=
 =?iso-2022-jp?B?Z0orTFhpTzU5VzdkcDQ3TXk5dGVyaE5lTkpuT09CRUU3RTh1Z2lvbU92?=
 =?iso-2022-jp?B?dHQ2TmIwNGh5WGR6NjFkQ3pUVlRzSldKakE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 15079e01-ed55-4da3-4414-08da923d74b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 08:29:47.5149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Jk92EezmZzjWQrs6h05wjofjBjzEIavE9BpHsPU3XULNL/uofuy3NyW0OR1vXkkTtocp1CCWFqBShbeUqkRW98QpOfAUIg9sy50ormFiw6LGALXtSg1Z86wvrHlSjJOm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8469
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 08:30:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9481

Hi,

CIP kernel team has released Linux kernel v4.19.257-cip81 and v5.10.140-cip=
16 The linux-4.19.y-cip tree has been updated base version from v4.19.256 t=
o v4.19.257, and the linux-5.10.y-cip tree has been updated base version fr=
om v5.10.138 to v5.10.140.
RZ/G2UL SoC and reference board support have been added to 5.10.y-cip tree =
with this update.

You can get this release via the git tree at:

  v4.19.257-cip81:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      16d8368674cebd6b5d9a4b7317c0837f0a24eb5b
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip81 after merge from stable
      drm: rcar-du: Fix Alpha blending issue on Gen3

  v5.10.140-cip16:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      e972e58dc6d8823515d89143ffc10d6dd7c9e621
    Fixed CVEs:
      CVE-2022-39190: netfilter: nf_tables: disallow binding to already bou=
nd chain
      CVE-2022-3028: af_key: Do not call xfrm_probe_algs in parallel
      CVE-2022-2905: bpf: Don't use tnum_range on array range checking for =
poke descriptors
    added commits:
      CIP: Bump version suffix to -cip16 after merge from stable
      drm: rcar-du: Fix Alpha blending issue on Gen3
      arm64: dts: renesas: rzg2ul-smarc-som: Enable ADC on SMARC platform
      arm64: dts: renesas: rzg2ul-smarc: Enable RSPI1 on carrier board
      arm64: dts: renesas: r9a07g043: Add ADC node
      arm64: dts: renesas: r9a07g043: Add SPI Multi I/O Bus controller node
      arm64: dts: renesas: r9a07g043: Create thermal zone to support IPA
      arm64: dts: renesas: r9a07g043: Add TSU node
      arm64: dts: renesas: r9a07g043: Add OPP table
      arm64: dts: renesas: r9a07g043: Add RSPI{0,1,2} nodes
      arm64: dts: renesas: rzg2ul-smarc: Enable USB2.0 support
      arm64: dts: renesas: rzg2ul-smarc: Enable Audio
      arm64: dts: renesas: rzg2l-smarc: Move ssi0 and cpu sound_dai nodes f=
rom common dtsi
      arm64: dts: renesas: rzg2ul-smarc-som: Enable watchdog
      arm64: dts: renesas: rzg2ul-smarc-som: Enable OSTM
      arm64: dts: renesas: rzg2ul-smarc: Enable CANFD
      arm64: dts: renesas: rzg2ul-smarc: Enable i2c{0,1} and wm8978
      arm64: dts: renesas: r9a07g043: Fillup the WDT{0,2} stub nodes
      arm64: dts: renesas: r9a07g043: Fillup the OSTM{0,1,2} stub nodes
      arm64: dts: renesas: r9a07g043: Fillup the CANFD stub node
      arm64: dts: renesas: r9a07g043: Add USB2.0 support
      arm64: dts: renesas: r9a07g043: Add SSI{1,2,3} nodes and fillup the S=
SI0 stub node
      arm64: dts: renesas: r9a07g043: Add I2C2 node and fillup the I2C{0,1,=
3} stub nodes
      clk: renesas: r9a07g043: Add clock and reset entries for ADC
      clk: renesas: r9a07g043: Add TSU clock and reset entry
      clk: renesas: r9a07g043: Add RSPI clock and reset entries
      clk: renesas: r9a07g043: Add clock and reset entries for SPI Multi I/=
O Bus Controller
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G2UL USBPH=
Y Control bindings
      dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
      dt-bindings: iio: adc: Document Renesas RZ/V2L ADC
      ASoC: dt-bindings: renesas,rz-ssi: Document RZ/G2UL SoC
      dt-bindings: watchdog: renesas,wdt: Document RZ/G2UL SoC
      dt-bindings: thermal: rzg2l-thermal: Document RZ/G2UL bindings
      dt-bindings: memory: renesas,rpc-if: Document RZ/G2UL SoC
      spi: dt-bindings: renesas,rspi: Document RZ/G2UL SoC
      dt-bindings: phy: renesas,usb2-phy: Document RZ/G2UL phy bindings
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G2UL support
      dt-bindings: usb: renesas,usbhs: Document RZ/G2UL bindings
      dt-bindings: i2c: renesas,riic: Document RZ/G2UL SoC
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2UL OSTM
      arm64: dts: renesas: rzg2ul-smarc-som: Enable Ethernet on SMARC platf=
orm
      arm64: dts: renesas: rzg2ul-smarc-som: Enable eMMC on SMARC platform
      arm64: dts: renesas: rzg2ul-smarc: Enable microSD on SMARC platform
      arm64: defconfig: Enable ARCH_R9A07G043
      arm64: dts: renesas: r9a07g043: Add GbEthernet nodes
      arm64: dts: renesas: r9a07g043: Add SDHI nodes
      arm64: dts: renesas: rzg2ul-smarc: Add scif0 and audio clk pins
      arm64: dts: renesas: r9a07g043: Fillup the pinctrl stub node
      arm64: dts: renesas: Add initial device tree for RZ/G2UL Type-1 SMARC=
 EVK
      arm64: dts: renesas: Add initial DTSI for RZ/G2UL SoC
      pinctrl: renesas: rzg2l: Return -EINVAL for pins which have input dis=
abled
      pinctrl: renesas: rzg2l: Restore pin config order
      pinctrl: renesas: rzg2l: Add RZ/G2UL support
      clk: renesas: r9a07g043: Add WDT clock and reset entries
      clk: renesas: r9a07g043: Add OSTM clock and reset entries
      clk: renesas: r9a07g043: Add clock and reset entries for CANFD
      clk: renesas: r9a07g043: Add USB clocks/resets
      clk: renesas: r9a07g043: Add SSIF-2 clock and reset entries
      clk: renesas: r9a07g043: Add I2C clocks/resets
      clk: renesas: r9a07g043: Add SDHI clock and reset entries
      clk: renesas: r9a07g043: Add GbEthernet clock/reset
      clk: renesas: r9a07g043: Add ethernet clock sources
      clk: renesas: r9a07g043: Add GPIO clock and reset entries
      clk: renesas: Add support for RZ/G2UL SoC
      soc: renesas: Identify RZ/G2UL SoC
      dt-bindings: clock: Add R9A07G043 CPG Clock and Reset Definitions
      dt-bindings: net: renesas,etheravb: Document RZ/G2UL SoC
      dt-bindings: mmc: renesas,sdhi: Document RZ/G2UL SoC
      dt-bindings: dma: rz-dmac: Document RZ/G2UL SoC
      dt-bindings: serial: renesas,sci: Document RZ/G2UL SoC
      dt-bindings: serial: renesas,scif: Document RZ/G2UL SoC
      dt-bindings: pinctrl: renesas: Document RZ/G2UL pinctrl
      dt-bindings: clock: renesas: Document RZ/G2UL SoC
      dt-bindings: power: renesas,rzg2l-sysc: Document RZ/G2UL SoC
      dt-bindings: arm: renesas: Document Renesas RZ/G2UL SMARC EVK
      dt-bindings: arm: renesas: Document Renesas RZ/V2L SoC on SMARC EVK

Best regards,
   Nobuhiro


