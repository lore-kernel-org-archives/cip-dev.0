Return-Path: <SRS0=sIiI=LQ=lists.cip-project.org=bounce+64572+6571+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C4C2B9F4
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 10:32:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C86613AE
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 10:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C86613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6571+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UXHxYY4521723xMnbI5Rp3AM; Tue, 22 Jun 2021 03:32:25 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.99])
 by mx.groups.io with SMTP id smtpd.web12.7010.1624357943090820291
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jun 2021 03:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWPoYXVn6ulmvBUxki41mY2lmCPrwFgHIp6SoP5gUo5l2/myazRbALrCM1dGw5Q4OcHaEkqQBD1mw9Vwq1kaHVT0Fm6N0ihIBRowxqEM/me/VgHqfx8MmLtOrT/IdTXM3z9993Y3aAldMWhUFGXycwZLoeSgueoR5g9nWJaT3zwrRPgRfy6ZSX4i7x0I8Ooz/KiLZJA57TWMXCanshW0pxwvlfLL2vc2cRVJUG8L7jPknjC58RzYYAuQvC9SDTKSKODqHDSmEePoULNUhMQWRo/7BBDRcOX6biznWVyYTdUifESnUrcIkiJQyfVaukXw/mMuNXKlpx7I8GAJVBxYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc6hjJavhfWC1OzKtqcEzirqYhE3Y+2kgqvXB4RuS7s=;
 b=j0Eka5+2KyMepdb5Jvg7VBMOlQ4BI4KCVdYrJyIaLSs/inKGyqebEU6yCHEJC4T2OP2jA38DY01MhLIGDgN3x+zycb/RgWMwJihoM78sChLBCWbfRXxfY8xRXXlLuPnB1VWbJSo4AEj4TFsuDVlUl7ephVOG7JCcs5xKB6YjnsmbXCgywlLMvjV1i6cs/afzcbNiwLyn7L40Z8jLbHPHJ0KrRsDMxg6vkrOgR9jX6n79IN/5H0LGoV0gDF4No6z8ITMCFEIFJC7a/+8Uvj3OCv64/xqczCLH22UrdS1ynWuufEYmfDhWsyBLF2eOuLek84AT8len6WX9XfTIAUlucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OS3PR01MB5720.jpnprd01.prod.outlook.com (2603:1096:604:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 10:32:19 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:32:19 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] Patches that need porting from 4.19 to 5.10-cip tree
Thread-Topic: [cip-dev] Patches that need porting from 4.19 to 5.10-cip tree
Thread-Index: AQHXV5dAOgFQ9IZYP0C3M2ezHIqpi6sf8ghA
Date: Tue, 22 Jun 2021 10:32:19 +0000
Message-ID: 
 <OSZPR01MB6877A74A6479B7870A3211F0B7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210602100440.GA27003@duo.ucw.cz>
In-Reply-To: <20210602100440.GA27003@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [217.39.106.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd95c2ba-dde0-49fa-06e9-08d935690384
x-ms-traffictypediagnostic: OS3PR01MB5720:
x-microsoft-antispam-prvs: 
 <OS3PR01MB5720075617029F486377F717B7099@OS3PR01MB5720.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 /MIc55KZhsGU0VDnL0aO5VzbprQRb69qF/ETECYSpOMsF1BloFzkIgkfUO9h0d+20x584GVBDMyzC4H6VwZmVMfdltdn79/75QYBOH4ywB9P1UVK9zS023tc96QyTfOvFb4guyIW+QgaswSsXsgd/Qf5E+gEs06rSn4bl08SeAEWsXZt/P7cDJNSC/6JK0dLghgYesO5+dUMJjsIbB1BVsMjzMPv8T0rywZKPAq9odIXpco6NFiQcpOL/0ndLDS0xKDp0k5A/akASjvzXxAyorevPld5FgjzWCsP5OvG7IcZyGiT8nKNTClu9WXErjfMjrS0FoBDqM5h8KO6NBpPQFDPkyC7eK7GihUPsF4VMN8ruhbRhxaURFQMshkffICHf1LS6+JI52JjEzOuGU9fos4gRqkyDvANlZxBHNbhC9e8CwKhtEWox2CIgZZwVycVxI2t1ooQOaMFFoA7dHtESN+zN7tDCSGKu9l55DfsYAgovFJFVhxnTGwQtATi0yOjXdo7jEvOTcoENfi2ZdWNq5CqB1smBwDfy1bTVQcedKtLadiPHeQAbJVURY9qOAb3oCRaUcrlAnlBL4JHjnMW/DwhUO6HnPZRVJI/cRHGXVIcQQrlhme4PZhr2Ro6UR1mU6xJ2J3DdgrUr2WpySrrpNvyD76e0JsmGk1wmKOJXwUSlviNqegPmO/hm9iERNFkKCAYmmQzj7y8e4yL+TIMjSt3x5Nt42fBcXl1VFefwkc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?IGJl0uJFCiL19AbtNMVXnH2Igr3eBx2AIT3yrC2jTqQgYddMBzGCtC9I?=
 =?Windows-1252?Q?dEQzWcwKo8e0fPf+6KMI2O9Ei0TetLlU6Izmv0XFcXN3WpMGvH3zo8cv?=
 =?Windows-1252?Q?PlxyhXYIWjtauFiA0pg7zHCqKrQ46DbViOKSEeoaGC8/1BvZGwRA2kTH?=
 =?Windows-1252?Q?Um+kY8vl3uPpOt2dfFlQUWOf94vRA2ZlXiNONTAHB/9ehGBb6GVP44Q6?=
 =?Windows-1252?Q?LbNm5Jzu3CeSgAU3oeB4YINtiKwUFk9iWRc3VxKTn6mtN1HJB5j9rxQs?=
 =?Windows-1252?Q?gI7jjoYkvzL8b470emhQLe1Q2dMrPNng0YyoU/h9Y/71lKXS3ZINyRgH?=
 =?Windows-1252?Q?3g+VuEiGgcIxgjn9os8ewsgNOZdc/ePLc2YS/866v9/sxmAUYswq/9Vc?=
 =?Windows-1252?Q?iI1+GuTHNjmaSSri1Y/odfR3X8/A8omoY/eZ7fJ9+QjwtDz/vZltYfdZ?=
 =?Windows-1252?Q?CIHYADKdOtyzYOfZS5UIF1oPeNf5CAXkFwuwEWC/ck4ObNuu5RW2co2y?=
 =?Windows-1252?Q?lAsrrrukxSmGE6g5T3xglwPhp2SFxeze8NQPt5TpJ48N5TQKHAGcnZkU?=
 =?Windows-1252?Q?iViPK24tYXvaB/Up+fNyEudQi82PQjNFXWnwsmN6HZc+396PAUDBIeDa?=
 =?Windows-1252?Q?rd3EXK8Rdc4Pa85VWoXHuu0Wu/oTSWukWtuT6iX8muNOUJkvH5Aei1Kh?=
 =?Windows-1252?Q?0FmbjYaZU0UKVvZReqdhGahM5uv53qPr7fV6MY+lJdGp7+Bd2QhBh2JZ?=
 =?Windows-1252?Q?/S6GIQ01XwWKHeTKRUgMA2+QSsewvQswmjC0lAz/yA1lgRA6klighQzv?=
 =?Windows-1252?Q?ldzLC6fhK9YpJJIEYbanS8LQnVVfIF5TuFh0PdBtZ90bEtmA21NB3Ouq?=
 =?Windows-1252?Q?T8QmvkK36rKuvCmaqQampT07VUIsYnw02ksn1w07S2rwuqOCmU+YA6dm?=
 =?Windows-1252?Q?Q/RTe6yYZ2uS9C3TWHZhOiYpu13K0Vlc8mXZHjDePWdQO5XHofQNK87F?=
 =?Windows-1252?Q?bqi3S9+QirSnwjPHmA9tPX2RKTnutIK+wJYTeM0iYOe9kKL6hxus1bPu?=
 =?Windows-1252?Q?79pa0z3hnjOGSz2XHY0s+PJA+aYcjGjVkQFpWew4rYP8y3ZuavwfyBAm?=
 =?Windows-1252?Q?UD0sDSe4F7E0QUtI3PzcMNiKeG120uuAXRgbNgfY9HeWbXcRKir0NJio?=
 =?Windows-1252?Q?iaG8TJVypM5lCSN5X/FT853FgplN52yu75NYHuLfgDNoVhQ5ofEQC9wO?=
 =?Windows-1252?Q?qAyumu0rh6HP1Ph1IJP7BWohuBJYZjC3cvEpAhM/y61ImcgXCl46JV+W?=
 =?Windows-1252?Q?e3y42sDRdS6E0ixpodKRwX9CkdWAKve8IR2Tc9QA1IHXDaTZaPTijNr2?=
 =?Windows-1252?Q?zh56w99rj+k1L6LJM+v+NvW+7Ov5jlzmAlQJZ1+/1GzjewaPhyOKWAp5?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd95c2ba-dde0-49fa-06e9-08d935690384
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 10:32:19.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yf1OrBzLPjPOBUpM1LNcDxHKu2ync68JsqvgCru7+Z+1Vg8CArKU+6ETVU6I1w+xbDUHdPw1VICyoEDHAwXWUEgBm89Ayqr8ne8/TW02V0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5720
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7TDsb2KUyRGIaurn2J1tVznyx4520388AA=
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_OSZPR01MB6877A74A6479B7870A3211F0B7099OSZPR01MB6877jpnp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624357945;
 bh=0ELXFZox15zNRiWnNbTOiYoYvEPzYOj2PC6I0Sl5NM0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=E+f0lRgcSsp3zVU+zWfIfZeAdB54+vN1CTNV1HpGPfiiD3h4ULpEodUxbOM85URf2yT
 lv2yQL9Mo5HE7c/ASyaqJTUmUKq94IVw5h8By8WjKqhZx6IpcJEB4XBJYAc1KYJidkyWM
 MkpCXJgUWmRHwlNwO8ISo6BVO7iMDRURkbE=

--_002_OSZPR01MB6877A74A6479B7870A3211F0B7099OSZPR01MB6877jpnp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 02 June 2021 11:05
>
> *** gpg4o | HINT: Error while checking message with detached signature
> (PGP/MIME signature)!
> Couldn't locate the original MIME source of the mail to verify the signat=
ure!
> gpg4oh32.dll:: func_IV Init OK ***
>
> Hi!
>
> Here is the list of patches that are in 4.19-cip but not yet in
> 5.10... according to my scripting.

Prabhakar has reviewed your list and has submitted all of the relevant patc=
hes in his "Renesas RZ/G2 sync patches from 4.19-cip to 5.10-cip" series [0=
].

Attached is a spreadsheet that summarises his analysis.
As you can see there are a lot of patches that are already present in v5.10=
, and some aren't needed.
There are a few patches marked as "Don't care". This is from a Renesas/RZ/G=
 point of view. They should probably still be looked into by someone in CIP=
.

[0] https://patchwork.kernel.org/project/cip-dev/list/?series=3D504483

Kind regards, Chris

>
> I pushed script generating this to
>
> git@gitlab.com:cip-project/cip-kernel/lts-commit-list.git
> bin/forward.py
>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
>
>
> * Patches that need porting from 4.19-cip:
>
> 6 b4b2650cbf85430cfd0e838b848fc779a9379014 pinctrl: renesas: r8a77965:
> Add QSPI[01] pins, groups and functions
> 7 783046e9b89118fcce8f932a1dd10ba79552d3c6 pinctrl: renesas: r8a7796:
> Add QSPI[01] pins, groups and functions
> 8 905e62d4e852ead346aaf7ae76e314a09a11d218 pinctrl: renesas: r8a77951:
> Add QSPI[01] pins, groups and functions
> 9 07caae75cd573c78a770e5fb11312ba7d673a7ff pinctrl: renesas: r8a77990:
> Add QSPI[01] pins, groups and functions
> 10 4e0363080cdb4190bd1d2827321f1b429d84bad3 pinctrl: renesas: r8a77990:
> Optimize pinctrl image size for R8A774C0
> 11 cd95c31242acda152274f73abd60a61cbcadac0c pinctrl: renesas: r8a77965:
> Optimize pinctrl image size for R8A774B1
> 12 1360fb65cd05d086d215027cc1d0c43a51244c00 pinctrl: renesas: r8a77951:
> Optimize pinctrl image size for R8A774E1
> 13 ab6dc69195ac22e8ff068c1c855acb91e680f6d9 pinctrl: renesas: r8a7796:
> Optimize pinctrl image size for R8A774A1
> 14 7b9d9793bf4df4f9dfef02a4a493fe6f53b2e28d clk: renesas: r8a774c0: Add
> RPC clocks
> 15 2040e52e8e8a6785f0c7d12dc42122900e60f308 clk: renesas: r8a774b1: Add
> RPC clocks
> 16 375a1ec05fe71b9c3011eee2a0d3d23d93768924 clk: renesas: r8a774a1: Add
> RPC clocks
> 17 4caef8210f620992dacf1b061f0ec308f31b516c spi: rpc-if: Fix use-after-fr=
ee
> on unbind
> 23 d331c0b9639ada0baa2d3737eb6e7328ff7e5984 spi: spi-mem: Fix passing
> zero to 'PTR_ERR' warning
> 24 80c0e04c6a5a07397a6ae0284b01bc7b64f30845 spi: spi-mem: fix reference
> leak in spi_mem_access_start
> 28 445839e697735da852301b00643c338a12ada29e memory: renesas-rpc-if:
> Make rpcif_enable/disable_rpm() as static inline
> 29 310876d304f306b602afb5fa169933d14a01a32e memory: renesas-rpc-if: Fix
> a node reference leak in rpcif_probe()
> 30 9809d206e61cee897c910aff0121017fb787070e memory: renesas-rpc-if: Fix
> unbalanced pm_runtime_enable in rpcif_{enable,disable}_rpm
> 31 197a622f5082286e418cfd598834dcc90b34fd20 memory: renesas-rpc-if:
> Return correct value to the caller of rpcif_manual_xfer()
> 35 ff7d6b51a9ee605f2363aa3e52207478e512c83a dt-bindings: PCI: rcar-pci-
> host: Document r8a774e1 bindings
> 37 0cf9d7a50c7b6e4e161b0951dc095b95d7765847 dt-bindings: timer:
> renesas: tmu: Document r8a774e1 bindings
> 38 286116ae7a41b39e1d126a96ceccdc12e6e61e77 dt-bindings: pci: rcar-pci-
> ep: Document missing interrupts property
> 50 28f5a43839f091edddbec332646183b4d9c60546 dt-bindings: phy:
> renesas,usb2-phy: Add r8a774e1 support
> 140 49753c6e27ed35223cdab939c34ff1d85f200765 mmc:
> renesas_sdhi_internal_dmac: Add r8a774e1 support
> 162 5185f29a28f69357e2571eabab706480eb2a9cb6 arm64: dts: renesas: Initial
> r8a774e1 SoC device tree
> 229 6886f3f499dc78b0e184152fae0b4c80cc0b8675 drm: bridge: Add dual_link
> field to the drm_bridge_timings structure
> 240 7a23d2d2cc0d03784113e460c3180fdbc49eb62b dt-bindings: display: Add
> idk-1110wr binding
> 320 1d387d03a3d98834f503c7aaea571d7d4c1f5c39 dt-bindings: mmc:
> renesas_sdhi: Add r8a774b1 support
> 415 825a0a574f2cf0b82a4ea54db3ff1615499f8162 arm64: dts: renesas:
> r8a774a1: Add missing assigned-clocks for CAN[01]
> 418 286155ab664e0873e931c78499bc093c9f773648 arm64: dts: renesas:
> r8a774a1: Use extended audio dmac registers
> 627 0ccb93953810660266f7095e0541c6db19920642 staging: m57621-mmc:
> delete driver from the tree.
> 632 37c7e76a75a0d5906d792628e4747607a963ba24 arm64: dts: renesas:
> r8a774c0: sort subnodes of the soc node
> ~fatal: Not a valid object name None
> 732 f437c4e92c6a06adb6bdd9b47ad86ff25eab6c92 arm64: renesas: Enable
> GPIOLIB to allow GPIO driver selection
> fatal: Not a valid object name None
> 757 23c298f18b709c501148065d3b1843a1e56c2d76 arm64: dts: renesas:
> cat875: Enable PCIe support
> fatal: Not a valid object name None
> 758 ccf5aeb525d50febc096ed65d7321b13569085e0 arm64: dts: renesas:
> r8a774c0-cat874: Add pciec0 support
> fatal: Not a valid object name None
> 759 4f5abfb59eaa94f917cb73d9948ecfb66c833e61 arm64: dts: renesas:
> r8a774c0: Add PCIe device node
> fatal: Not a valid object name None
> 760 56d76f342f9f70001d8cb3f29a279700f9b12e4c dt-bindings: PCI: rcar: Add
> device tree support for r8a774c0
> fatal: Not a valid object name None
> 761 1a75ab1f4df2ae74779936083852ebc7532d80cd arm64: dts: renesas:
> r8a774c0: Add MSIOF nodes
> fatal: Not a valid object name None
> 762 595a7f055da0526376c7529f7591c7cb3f06f8fb spi: sh-msiof: Add r8a774c0
> support
> fatal: Not a valid object name None
> 763 686bc4f4664ca2515e2596c87e053f70c26cb934 spi: sh-msiof: Add r8a774a1
> support
> fatal: Not a valid object name None
> 764 3c0ca6208e581210266ac1bde0597a8b13d6a337 arm64: dts: renesas:
> r8a774c0: Add I2C and IIC-DVFS support
> fatal: Not a valid object name None
> 765 6b8ffb2a25fde65773cc98bb37c1f5b86b29d98a dt-bindings: i2c: rcar: Add
> r8a774c0 support
> fatal: Not a valid object name None
> 766 57144a0ab9bdbcf7e51b9a8eefd55b7b8a7ab826 dt-bindings: i2c:
> sh_mobile: Add r8a774c0 support
> fatal: Not a valid object name None
> 767 3cb9d1fc68b381379438f85e8566be39ca86cde7 i2c: sh_mobile: document
> support for r8a77990 (R-Car E3)
> fatal: Not a valid object name None
> 768 4267473f0afbfb14a85466040b5d28184790f2cf pinctrl: sh-pfc: r8a77990:
> Add HSCIF pins, groups, and functions
> fatal: Not a valid object name None
> 769 c559288186c43feee8481cdb677812c9b56c4ebf pinctrl: sh-pfc: r8a77990:
> Add VIN[4|5] groups/functions
> fatal: Not a valid object name None
> 770 e14007c4eff147aa062d7bc207d889848a95ac40 pinctrl: sh-pfc: Add
> optional arg to VIN_DATA_PIN_GROUP
> fatal: Not a valid object name None
> 771 c2432cc0a06bb67dada320d7e3a8a53d33a7d9ab pinctrl: sh-pfc: Reduce
> kernel size for narrow VIN channels
> fatal: Not a valid object name None
> 772 1134bc50b536702feb7960496879d964491030b5 arm64: dts: renesas:
> r8a774c0: Add watchdog support
> fatal: Not a valid object name None
> 773 d02d91565cd06e884ce7c6abc648e70f692afeca dt-bindings: watchdog:
> renesas-wdt: Document r8a774c0 support
> fatal: Not a valid object name None
> 774 685eeb31df5f059ae52a17ea240c0e2bced51936 arm64: dts: renesas:
> cat875: Add ethernet support
> fatal: Not a valid object name None
> 775 840667a2401281cc6eb43c38a70ba3f2839e9cd2 arm64: dts: renesas:
> r8a774c0: Add Ethernet AVB node
> fatal: Not a valid object name None
> 776 3ab91b007ba07b8790b5ac91e63abf68a3b63195 dt-bindings: net: ravb:
> Add support for r8a774c0 SoC
> fatal: Not a valid object name None
> 777 7464f0a341b18617028767239419527c4a8dc669 arm64: dts: renesas:
> r8a774c0-cat874: Add uSD support
> fatal: Not a valid object name None
> 778 85785a241cd0b07dc9bb7afc6c26a452a9c120eb arm64: dts: renesas:
> r8a774c0: Add SDHI nodes
> fatal: Not a valid object name None
> 779 e931302e319287e29ec343fcee4789cc2e0723a3 mmc:
> renesas_sdhi_internal_dmac: Whitelist r8a774c0
> fatal: Not a valid object name None
> 780 79936bb2cfd319411e89ee16db624eaa8cad6acf dt-bindings: mmc:
> renesas_sdhi: Add r8a774c0 support
> fatal: Not a valid object name None
> 781 2a8127243eaa15e0a713b7792bc523c2657626d9 dt-bindings: mmc:
> renesas_sdhi: Add r8a77470 support
> fatal: Not a valid object name None
> 782 c1e764da7f384908eb2ba1f0c4a9277c2624b2a8 mmc: renesas_sdhi: Add
> r8a774a1 support
> fatal: Not a valid object name None
> 783 90a422ce4e21b7a2fcfe3d0f2e2d87ec23295679 pinctrl: sh-pfc: r8a77990:
> Add voltage switch operations for SDHI
> fatal: Not a valid object name None
> 784 d6e55053ae891aa8449d59a6213619f24e96cd75 pinctrl: sh-pfc: r8a77990:
> Add SDHI pins, groups and functions
> fatal: Not a valid object name None
> 785 71db71d6fcdc19a02756e945c4e7636494ab2705 pinctrl: sh-pfc: r8a77990:
> Add Audio SSI pins, groups and functions
> fatal: Not a valid object name None
> 786 6743ed6a0d1aa99ba2e0803462de96ac6e7988fb pinctrl: sh-pfc: r8a77990:
> Add Audio clock pins, groups and functions
> fatal: Not a valid object name None
> 787 8bc5c9ee19e33db1ba0e72e130ca0a9db648f502 arm64: dts: renesas:
> r8a774c0-cat874: Add pincontrol support to scif2
> fatal: Not a valid object name None
> 788 3622335f8805f90163a092d71b26dc0544795806 arm64: dts: renesas:
> r8a774c0: Add GPIO device nodes
> fatal: Not a valid object name None
> 789 87a67df9ce41fd37fa6eca4150de4075770dda35 dt-bindings: gpio: rcar:
> Add r8a774c0 (RZ/G2E) support
> fatal: Not a valid object name None
> 790 5c3b53f2aacbdcc4cf37fb1cfdb809d5bf60e46a dt-bindings: gpio: rcar: Add
> r8a774a1 (RZ/G2M) support
> fatal: Not a valid object name None
> 791 db269e707a0ca48ec72fb57ee37b57cda3c51780 arm64: dts: renesas:
> r8a774c0: Add PFC support
> fatal: Not a valid object name None
> 792 b403eaddb8e3aa7dc223acc9460d1f458b089de4 arm64: dts: renesas:
> r8a774c0: Add INTC-EX device node
> fatal: Not a valid object name None
> 793 8c5724802482b046430e148086ae9f59dbc9add9 pinctrl: sh-pfc: r8a77990:
> Add INTC-EX pins, groups and function
> fatal: Not a valid object name None
> 794 71ff3592223e16fa3761c64408247256262a05c8 pinctrl: sh-pfc: rcar:
> Rename automotive-only arrays to automotive
> fatal: Not a valid object name None
> 795 527669723d13048c2e9c51648105a6bedd2d1b89 arm64: dts: renesas:
> r8a774c0: Add secondary CA53 CPU core
> fatal: Not a valid object name None
> 796 3a5215b1dba913b21901a8d6217b9e1cddc90f52 clk: renesas: cpg-mssr:
> Add r8a774c0 support
> fatal: Not a valid object name None
> 797 c8ddda1c217fa5fefab21a9061e552bfaf642b46 dt-bindings: clock: renesas:
> cpg-mssr: Document r8a774c0
> fatal: Not a valid object name None
> 798 ecea245b76dc32d74f9c3bf988331a9c52bb21a7 clk: renesas: cpg-mssr:
> Add r8a774a1 support
> fatal: Not a valid object name None
> 799 2976b26a3565fdc2f670386cf5897a12f6a0f0b2 clk: renesas: rcar-gen3: Add
> support for mode pin clock selection
> 800
> fatal: Not a valid object name None
> 800 c1167ef78ee521291d43fd15e90abd06d4101a8d clk: renesas: rcar-gen3:
> Add support for RCKSEL clock selection
> fatal: Not a valid object name None
> 801 d6a86311ff22de60051923eeef768d5bbf215603 clk: renesas: cpg-mssr:
> Add support for fixed rate clocks
> fatal: Not a valid object name None
> 802 5a2b81b50d3600f2d8ab5a56b3ff797f7892dde6 clk: renesas: rcar-gen3:
> Add support for OSC EXTAL predivider
> fatal: Not a valid object name None
> 803 de6945365656d66517f4dc79fde35598c5286234 clk: renesas: Add r8a774a1
> CPG Core Clock Definitions
> fatal: Not a valid object name None
> 804 05c4844d0cea6b5f67bb213138b50a784f0eb0cd clk: renesas: Add r8a774c0
> CPG Core Clock Definitions
> fatal: Not a valid object name None
> 805 896d958fa17fa96af56fd6623bf2709f860adcc6 arm64: dts: renesas:
> r8a774c0: Add SCIF and HSCIF nodes
> fatal: Not a valid object name None
> 806 30aba1d2348d672c5f3d329aa21eafeb4987ad4a dt-bindings: serial: sh-sci:
> Document r8a774c0 bindings
> fatal: Not a valid object name None
> 807 4c4c1c48e912195c6fe0ecd93968878eff26c04a dt-bindings: serial: sh-sci:
> Document r8a774a1 bindings
> fatal: Not a valid object name None
> 808 4ff8a74d753b87b3be2ad0863d83a7851f489ce3 arm64: dts: renesas:
> r8a774c0: Add SYS-DMAC controller nodes
> fatal: Not a valid object name None
> 809 405a6a65aae3d091f6150045c800aec620447a69 dmaengine: rcar-dmac:
> Document R8A774C0 bindings
> fatal: Not a valid object name None
> 810 6c7bed298844e51397a6292cc4f7f68147cbd2db dmaengine: rcar-dmac:
> Document R8A774A1 bindings
> fatal: Not a valid object name None
> 811 80f5600da4e0e161c33f64b97972464805358d99 arm64: dts: renesas: Add
> Si-Linux EK874 board support
> fatal: Not a valid object name None
> 812 53b8c67a5cd7b1b06ccfb54e72cccb306db3a7ab arm64: dts: renesas: Add
> Si-Linux CAT874 board support
> fatal: Not a valid object name None
> 813 70863942b6e2e5c481e34166a4458eabfe66ea34 arm64: dts: renesas:
> Initial device tree for r8a774c0
> fatal: Not a valid object name None
> 814 bf68b54fa9e618462220f0e537f23788eaa2a081 dt-bindings: arm: Add si-
> linux cat87[45] boards
> fatal: Not a valid object name None
> 815 7caccda8939c381fc316f450daa9307d227a4a67 ARM: dts: socfpga: Rename
> socfpga_cyclone5_de0_{sockit, nano_soc}
> fatal: Not a valid object name None
> 816 07872e3a35c87fb2ed45e1d97dd3e0d520563ce6 dt-bindings: irqchip:
> renesas-irqc: Document r8a774c0 support
> fatal: Not a valid object name None
> 817 0b6ed88107a0edd34387d6f6503372aa1b8b26c1 soc: renesas: rcar-rst:
> Add support for RZ/G2E
> fatal: Not a valid object name None
> 818 8e6d55825b605ad1ee44f8e915aae8ed929c282c dt-bindings: reset: rcar-
> rst: Document r8a774c0 rst
> fatal: Not a valid object name None
> 819 23167181232538a100b062df5755d5b3d71b7602 soc: renesas: rcar-rst: Add
> support for RZ/G2M
> fatal: Not a valid object name None
> 820 130d91f7584a388e60b93d1bc8c814f6940e8bbc soc: renesas: rcar-sysc:
> Add r8a774c0 support
> fatal: Not a valid object name None
> 821 dfd2ff6f8995347155da1c4e06bfb48400f73915 dt-bindings: power: rcar-
> sysc: Document r8a774c0 sysc
> fatal: Not a valid object name None
> 822 441d6cdc76d76fbd71524cbb23d34dafe664a1c8 soc: renesas: rcar-sysc:
> Add r8a774a1 support
> fatal: Not a valid object name None
> 823 cbed3e68d7df310bf6948f49da8e865be1e78168 dt-bindings: power: Add
> r8a774c0 SYSC power domain definitions
> fatal: Not a valid object name None
> 824 bdd3f78dc7b2dc96b667c2c61818b3a39ac38e03 dt-bindings: power: Add
> r8a774a1 SYSC power domain definitions
> fatal: Not a valid object name None
> 825 785d7afc3e8859704675d9de80bb8d272dcfee99 arm64: defconfig: enable
> R8A774C0 SoC
> fatal: Not a valid object name None
> 826 4145aff423bdaceb488e6f1b68b4f8d8e81bee82 arm64: defconfig: enable
> R8A774A1 SoC
> fatal: Not a valid object name None
> 827 641132722015595793f56fe31765636ddf7a6999 arm64: Add Renesas
> R8A774C0 support
> fatal: Not a valid object name None
> 828 b6ddebb2cc793ef2fda081fd2ef2439c158caac4 arm64: Add Renesas
> R8A774A1 support
> fatal: Not a valid object name None
> 829 61a802c7a80707423375e206e58ef7e5ca9ffca6 soc: renesas: Identify
> RZ/G2E
> fatal: Not a valid object name None
> 830 895d87e0dbf3763480914ad062dadc1c97aa277e soc: renesas: Identify
> RZ/G2M
> fatal: Not a valid object name None
> 831 76b8e853948bfaff083afb3dd985eb19f3aab30b dt-bindings: arm: Fix
> RZ/G2E part number
> fatal: Not a valid object name None
> 832 1148a8e70700a6204e599ea7f8aaef89bed34bc2 dt-bindings: arm:
> Document RZ/G2E SoC DT bindings
> fatal: Not a valid object name None
> 833 296e6f9e7e8543d6a0bf877a53f17331b0bf7445 dt-bindings: arm:
> Document RZ/G2M SoC DT bindings
> fatal: Not a valid object name None
> 834 21da9b1699d543ab6e1b46357d0aa2dbfc865934 pinctrl: sh-pfc: r8a77990:
> Add R8A774C0 PFC support
> fatal: Not a valid object name None
> 835 5966ab46b8674e58af974681859c9165582422a7 pinctrl: sh-pfc: r8a77990:
> Add MSIOF pins, groups and functions
> fatal: Not a valid object name None
> 836 158e9af63287618d3c432246af352ad12c0313e0 pinctrl: sh-pfc: r8a77990:
> Add DU pins, groups and function
> fatal: Not a valid object name None
> 837 ae8c3339f4abb8e7622f70461eaa577b38ec9c4d pinctrl: sh-pfc: r8a77990:
> Add PWM pins, groups and functions
> fatal: Not a valid object name None
> 838 651bece87545408c40cc747f6f8ff9b535141a7a dt-bindings: pinctrl: sh-pfc=
:
> Document r8a774c0 PFC support
> fatal: Not a valid object name None
> 839 773c0e700b3ee45f41dd7540eea76cc1e9b4756c pinctrl: sh-pfc: r8a7796:
> Add R8A774A1 PFC support
> fatal: Not a valid object name None
> 840 9dcfa7fb9457ba7eeb2c9bcdf4e7238fb0e2ad4b dt-bindings: pinctrl: sh-
> pfc: Document r8a774a1 PFC support
> fatal: Not a valid object name None
> 841 796b0ba74eb56f983753be661049153071c55af9 CIP: Add a number to the
> version suffix
> fatal: Not a valid object name None
> 842 2d19be4653f5e74ed95560b69f94eb6791d49af3 Linux 4.19.177
> 843 fc1e3f5d1d7f77be91f85d7d4ce94ebfe3d8d284 kvm: check tlbs_dirty
> directly
> 844 2c68bb33dad9f3cab171bb64e1766bc5a7e9b7e8 scsi: qla2xxx: Fix crash
> during driver load on big endian machines
> 845 98f16e171e2849dba76e2e0346e914452c030dc5 xen-blkback: fix error
> handling in xen_blkbk_map()
> 846 f84c00fbd27b043fa42a56eaaa14e293877bc69b xen-scsiback: don't
> "handle" error by BUG()
> 847 717faa776ca2163119239ea58bb78c4d732d8a4f xen-netback: don't
> "handle" error by BUG()
> 848 a01b49a9bf91a723f541139c063c1ff681ac536a xen-blkback: don't "handle"
> error by BUG()
> 849 271a3984f73c485f4c1b796a61cc5bd3994a0463 xen/arm: don't ignore
> return errors from set_phys_to_machine
> 850 e07f06f6bbeed5bf47fed79ac6a57ec62b33304a Xen/gntdev: correct error
> checking in gntdev_map_grant_pages()
>
>
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--_002_OSZPR01MB6877A74A6479B7870A3211F0B7099OSZPR01MB6877jpnp_
Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;
	name="cip510.xlsx"
Content-Description: cip510.xlsx
Content-Disposition: attachment; filename="cip510.xlsx"; size=21458;
	creation-date="Tue, 22 Jun 2021 10:31:06 GMT";
	modification-date="Tue, 22 Jun 2021 10:19:32 GMT"
Content-Transfer-Encoding: base64

UEsDBBQABgAIAAAAIQA3Mb2RewEAAIQFAAATAAgCW0NvbnRlbnRfVHlwZXNdLnhtbCCiBAIooAAC
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACs
VEtvwjAMvk/af6hynWhgh2maKBz2OG5IsB8QGreNaJMoNgz+/dzw0DQBFYJLoybx97AdD8frpk5W
ENA4m4lB2hcJ2NxpY8tMfM8+es8iQVJWq9pZyMQGUIxH93fD2cYDJhxtMRMVkX+REvMKGoWp82D5
pHChUcS/oZRe5QtVgnzs959k7iyBpR61GGI0fINCLWtK3te8vVUyN1Ykr9t7LVUmlPe1yRWxULmy
+h9JzxWFyUG7fNkwdIo+gNJYAVBTpz4YZgxTIGJjKORRzgA1Xka6c5VyZBSGlfH4wNZPMLQnp13t
4r64HMFoSCYq0Kdq2Ltc1/LHhcXcuUV6HuTS1MQUpY0ydq/7DH+8jDIugxsLaf1F4A4dxD0GMn6v
lxBhOgiRNjXgrdMeQbuYKxVAT4m7t7y5gL/YXSlXc86ApHa5ddkj6Dl+ftKT4Dzy1AhweRX2T7SN
7nkGgkAGDo/0WLMfGHnkXF12aGeaBn2EW8YZOvoFAAD//wMAUEsDBBQABgAIAAAAIQC1VTAj9AAA
AEwCAAALAAgCX3JlbHMvLnJlbHMgogQCKKAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAArJJNT8MwDIbvSPyHyPfV3ZAQQkt3QUi7IVR+gEnc
D7WNoyQb3b8nHBBUGoMDR3+9fvzK2908jerIIfbiNKyLEhQ7I7Z3rYaX+nF1ByomcpZGcazhxBF2
1fXV9plHSnkodr2PKqu4qKFLyd8jRtPxRLEQzy5XGgkTpRyGFj2ZgVrGTVneYviuAdVCU+2thrC3
N6Dqk8+bf9eWpukNP4g5TOzSmRXIc2Jn2a58yGwh9fkaVVNoOWmwYp5yOiJ5X2RswPNEm78T/Xwt
TpzIUiI0Evgyz0fHJaD1f1q0NPHLnXnENwnDq8jwyYKLH6jeAQAA//8DAFBLAwQUAAYACAAAACEA
Gi4QC2UDAABkCAAADwAAAHhsL3dvcmtib29rLnhtbKxVXW+rOBB9X2n/A/I7BRNMAJVcFQjaSu1V
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
LnhtbFBLBQYAAAAADQANAGgDAABUUAAAAAA=

--_002_OSZPR01MB6877A74A6479B7870A3211F0B7099OSZPR01MB6877jpnp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6571): https://lists.cip-project.org/g/cip-dev/message=
/6571
Mute This Topic: https://lists.cip-project.org/mt/83254843/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--_002_OSZPR01MB6877A74A6479B7870A3211F0B7099OSZPR01MB6877jpnp_--
