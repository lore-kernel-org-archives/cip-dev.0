Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F684CCA462
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 09:27:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17513.1792142818810572892
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Oct 2026 02:27:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=UU9O4l9G;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792142808;x=1793352408;bh=
	LFgYLVesUPX2TYOeWLsZTn3vfFb1t0R2ZFGiLgKLj2w=;b=UU9O4l9Ge/0qiuek9rbDjA9vF8zYfR
	vgvA2uXCW8frsvqcLcMZlfdvSMRUCGlmWDhCFcUje/bFUhXGEoBc1gZqugQUCZyl4OBCmp0NDvKJA
	BsjAR2cWYq+BcpttoTJEpNNuQPw9TFDAp64Aq5cL2uDagDx0K6JMCH8Ry6N7azEGz6XUpNGzOiA/d
	AMgJjH6rOSS9bnHrUYD9mwsbMXfDBvAnSVu34lvHM62HoqP0+981i8qupujWN65q3AjW+miVSmrA1
	lfvEJe9WviyafW22R/e3VON3j0udowT5bYKz96BbuCJd4PKJpTvmfVjQjNBR5BcrN2r2iByBD85kH
	HlSQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69G9Qlcs3555560; Fri, 16 Oct 2026 18:26:48 +0900
X-Iguazu-Qid: 2yAaUghfCTfEv0xhx4
X-Iguazu-QSIG: v=2; s=1; t=1792142807; q=2yAaUghfCTfEv0xhx4; m=PX2cyQXwWl3lxn3ZrtCWygTGlg8oe0+S6SQN/lfjIak=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j5fhk4ql0zyPZ; Fri, 16 Oct 2026 18:26:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYyuZxCCRRrI20rq0uKAVfhwMrwagBK59RLkw1eLECJZDU+qIZqkAF2bhNZ136hfY5NYUPG5baBx+IWRleEp2H2f+f/A1I/3i7/nOBLyO6kWWgdSvg5lXJ7svC7+vdsaVh0iW0QgdQHOiNfePubrwwFIDlaMNy7uIPJJb0pYJK6pjhmsTjubuwUSXXMygZeT0po/2bgQC8JJiHSdWrD3N1J/gjlXyEGzD1gMmwuv8RgIHt52fkulHjt8ZFQcKEsllRpbLrKfdP5tM7KC/fYRGMU/zPadaYhDwaZEYSyG0iNps2ensn+ZXW5L2HJLVgKTEa41+1o+zgWr+TFRPM6gLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBOSvEM4FFLuWHoEJVF4JCv+vs7JeR//P7La7HHn36Q=;
 b=p2lZHo/7QbynFgvKcwTo2fKT9Vy+pqTAFjI2wHOjY7MMLykEKDdUU5qGy08gqioMvVZ3IeQJX+ypasnO/pv2AVqQCOfgPrAVttBfL2G7phApL813rg0Srv5Ddu7PxHhNE2mc73R/XuYZgiUzbwJ9cIlybdHi0ZcbgvIyM1rVo1i4rY+yE9EEcQc2IZkM1C/NygMsnKRN6gezB4Vn+/jQh/y6n9CiK3mdKhnfSy3qcb+IzsXB1x/NO41lYV6Q/F49zTSHjuUrfUF0XEH4JfAa9GqaL5B1o41fTA902pjGMmYvAKKzBizLA/FEV21Bo9rAHWZx7A4X4ILuUJPx/idv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <masami.ichikawa@miraclelinux.com>,
        <jan.kiszka@siemens.com>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.112-cip33
Thread-Topic: [ANNOUNCE] Release v6.12.112-cip33
Thread-Index: Ad1dUHBqSMf8Ye/GQsyleIE8tJPxOw==
Date: Fri, 16 Oct 2026 09:26:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A6AFCEC09C05FE968B4ECD9B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSRPR01MB11457:EE_
x-ms-office365-filtering-correlation-id: e063ffef-381b-4730-9bfc-08df2b6797d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|18002099003|3023799007|11063799006|261009223027099003|5023799004|261009223327099003|261009221727099003|261009220027099003|261009221227099003|38070700021|56012099006;
x-microsoft-antispam-message-info: 
 uX4s9ccZi7s/SA5e5SPlZJOkrYAG1UTOOWiu7CYd84B5FHvHx/+uLMYeZCd9ZvZ9sMuN8XsyIu4B/dxBMBhVB+9MCJfS7JsOjpJoiGUsLA00IuNAJcdFd8tz/jd/Ig3dYqOOivDhWJ31NCN6Y1B5lr1YBvdkiDpuyblrbBGozix2KL87hsv8PWLQnmtY4XczdsFqX/Do08KTRCvvVEfcpAZTCk+DNHOxu8+fHGvoOIS1EmXm9RAt4yj/GDh28Lbjm0XRfbs30l1a6PJpEZd4yK7HiOxX/FKHAS4cSFmajQ478qxOZPStJFv8xxOgzxAxEn6ggp/+9j+2HlJImHrotmlWyi4l7t34JTy1goumBArYhXSt6CfeAOIJmDUt1WbDWMVNypTKNL8U9GFHuVUqwxL2Zf8YQT72QqSBgEjmCWlPOi5RLrjayGgMGAek9Iv1OI/4kqaYjQAusQGvw6H2yxSzIsV9eWDGfo1kX/r16fCc8J1kO8Q9kxNMegjQ/iWvdWzb1zPBT49g+/nQnFNol4kS5DsGkcpa59/GTkVWRSih1NdEN9xz6BNkkcf1J2M6IHvQVm3ir03FnUcZyBpIM7gEo/N63LNiigDjcUwBeUKJaZ5FBhf1dHcIRIGHrDu1+fF3zyqRXnY9uIgHgDD4FSVfiSm+u318x+h1MTFaFqc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(5023799004)(261009223327099003)(261009221727099003)(261009220027099003)(261009221227099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?enBsL0dIY0pzcVZFKzFWSkEwb3QrTk83L1lPbXM3T2Z3bHV2WG9ZZlQ1?=
 =?iso-2022-jp?B?UTJjeCtLNFNFUmx1VytPM2grWlVQKzMxUmg2MEs3NW1GclcxVkcvaUNT?=
 =?iso-2022-jp?B?dm00VWUxSGFuNW9VcDY3ZW5mTW1rRzh2VDZVZlc5blNZbmpWZUhyaTJN?=
 =?iso-2022-jp?B?Ui9rcGJxSmprUkVmcC9sdmpQRTlsYUVJUGxibVlCM0FpNEllZ292OWl0?=
 =?iso-2022-jp?B?Z2t3VksrbWNWendGZCtRNUF1VllITXN6bEUrV3ovKzBWSVZWN2dRd0lG?=
 =?iso-2022-jp?B?WmdmQXhkaDRTQkJLWk9CcEo5YnpXb3JudzFDWFh5bW10Ykkvb0hQeFB4?=
 =?iso-2022-jp?B?bDJpUWU1elVJTWthNWlrRFM4VkV6WGg2WkdoWXE1SVR4dGw0T1ZubEg2?=
 =?iso-2022-jp?B?T3g1RncwVHRFaXRCVnhJVE9PWFk2NGlmeTFFK3gySU9weEtPeUZmZGFZ?=
 =?iso-2022-jp?B?UUNHenVNaXNTbGFWYk01UUhkUDc5a2l6RFpydmhyYytoUnNNaklsY1Na?=
 =?iso-2022-jp?B?TzBlK0RwaUVNOXdzOXE5L2tEZHliQWNkdnQrWVlEZnd1S0Jabk14NnNj?=
 =?iso-2022-jp?B?bGpQSTdDUnl1WmF3OEFkM1JQd3BWWDNlS1RCZjluT3hxV0ZqUlhwVlhR?=
 =?iso-2022-jp?B?MUJnUDhJQVZKVTUzZXVhN2tIaFV0NTM4YldlQzdIaXhzV2M0Y0REc1BY?=
 =?iso-2022-jp?B?c1p4cE5VemlMU2RNVzNLeFdmNjhJV3B3Y1VJeFZhU2h1N3psSFpTWmFD?=
 =?iso-2022-jp?B?YmRUSzNHdk9Uejc4c1BvUktrRlU5NUtmeEYreGdGdXVjWXBWZWttaXVx?=
 =?iso-2022-jp?B?VmMwdTQyZXJMdDFLK2piN21SSm9LV1VBV2FPNDFweEpTRTAyVklhclVy?=
 =?iso-2022-jp?B?bGNMYXg4dWxBMjRZenErZFFJZlYxd21qRDFORzZkV1dkeUtvWjlCL3pU?=
 =?iso-2022-jp?B?TzdOdnRzWElsb0t4SHdxTDFtSnFkRnBuRWR6NXNyenY2QmtNd0tlZXJ1?=
 =?iso-2022-jp?B?c1ZzQUlCODZxL1BhWWFLVXp1b2RPUHIxUUxaZnlxeW5RY1cvVGxtSUZQ?=
 =?iso-2022-jp?B?R2U2UUJjQjEvSVgzQi96bG1VaVBETXJrMjh2VjZvVzdQVUJTQzRhMzFI?=
 =?iso-2022-jp?B?cVlPMEpRd3l1K1NQd2ZMc2JabHRNeFZQZTF4anJrQlVXeStWL3BLOWNV?=
 =?iso-2022-jp?B?VDNHS2gyQnZWT1gyNUlEYW9xaFZwRVpnU1NCYVNvUjcvN2MvaytXNUox?=
 =?iso-2022-jp?B?M2F4MlZSZFpYTC9WTmtpNnloNTJwWndITkVYamNLRHRneE84NmNnSnlq?=
 =?iso-2022-jp?B?dXplQ2lHUjNKOHBBQXNYb0dPdVh1R2x6eGw3TXZRUWhzbk0vT2dDN3k1?=
 =?iso-2022-jp?B?aWtOUXhFTlNBMHBaUUU4cUZFOWdoWVFlazkwWGNISzQxOGNOdi9Lc2JP?=
 =?iso-2022-jp?B?WDNTZTB5U2x1WlZTaVU0VkY3VFI3RHVROWJlbEpzcjA1QlcvbUZyU2Uv?=
 =?iso-2022-jp?B?V3VnTkVUWC9EUjRFYUp4bTBvd2htZVpqTFh6VUg3RHpHQXpxTnBBcE1p?=
 =?iso-2022-jp?B?ZDB4dXdRYW4rY0RWVVRaNGRQNUwrbHVITnFIcnJTTktBdnkwc2NrZ3BX?=
 =?iso-2022-jp?B?a1Ewc1ZqSWhJOThkYnpza0RtSUpjVWJCTFd4MFJoaHNocUdJQ1IrY0dP?=
 =?iso-2022-jp?B?UFBoOHZOT0VneCtpV3dOWFQ1d29zWDFFTzFjRmxqWUR5ZW5pOWtiRUR5?=
 =?iso-2022-jp?B?T3RpNVEySFAvMFg5Rmx0aEZmbkRkV1UzVXFxVk1SQUR4cjJjbE91QmR5?=
 =?iso-2022-jp?B?dVlKVFJGaFU4WHQ0MUgxcmY4bFRIQUh3ZlJkUlJKWVMxTS9QT3EvR05y?=
 =?iso-2022-jp?B?RjNwVUxLR3JzR1JlSDNRQk9TUTRMc2hzNWpCOTE2OHpBdXQ1a21kakRs?=
 =?iso-2022-jp?B?NFBHdVo3blNKTjY2ZEdKMWFhdUw0VHgwcjVKMXo5NWhTMyszYWpPaUsx?=
 =?iso-2022-jp?B?bU1JeE1CQ2xSckVoQWJySzNuNVBGS0oxb25vbDNxMmFkNXVMS0prSmV0?=
 =?iso-2022-jp?B?WWZEbHpBSFV3SVVGSEl4SDVnSVFHcFQ2M3Z3bXh6NFZqamtZUXp5eTUz?=
 =?iso-2022-jp?B?L3VuUHJBbnJaaXR6WkpET2ZpRlpndHRIMmFQWXJMcWZxbVI3TGQ1b1U5?=
 =?iso-2022-jp?B?U0JOZWpLZUZDVWxkUmFkMWVTakdwWXRRVGtVKyt0eEVjSEZXWUR4c2hy?=
 =?iso-2022-jp?B?THJEU28vUVllcHJDUUJmS3FKMHR5bEdPNWFnbkRKSU1QZll1QmZxeWhY?=
 =?iso-2022-jp?B?MEhBRWJDWkcwVzJIVGhqTHVDMDA3ZU9EMWhnWGltQVYvZXBDK1JqTGR3?=
 =?iso-2022-jp?B?NjVCbGk3RXh0SmRQcjMvU0RqNGFoWHRzM05yWjFGb2Jwd3NveWFiMGNY?=
 =?iso-2022-jp?B?OWRETWZKLzVWbldPTjB6UVhiaWRmQTFXdW1yOEZSYU5PVCs0OFNHcGlB?=
 =?iso-2022-jp?B?cU1YMVdzeEF0TXp5c25YU2ZrYmV3cGp0Y3RBd1RsUWJrcDVmbjFFRXc4?=
 =?iso-2022-jp?B?OTJ5NER5Yz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	USIjiRol0Q79fxP2VaFF8p14GaK7QYdaUeIF2Z1hVM1fqx245rO6i+orREwagLwFLYIFXjsbu5ypERaWcobdf/Lw6RX28YREujE8Ie5+RDXXQhmy520lbCvE583vtKGOxGEat94QzDhCMA9ErqT1TIF9t8eb6g5a/QTLXrBtV5yEsrnAhykgqsVucYWD8u1kTm0nj3O5JtD7vNWu9hl9W73KDkAFqZPgdSIoYlBOLMD92HozyzIGKQCz1WOGagNPwiq+JL3PRCCsCKTcUp/zfFr3/lPsW0G2ZjdGELtfG9ltE7jI73nCXJBsUjdAXn9MkhUKMbTsy57dJDRUc6omHw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e063ffef-381b-4730-9bfc-08df2b6797d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 09:26:43.8256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRM3K0/xePS+jlPkg/tU+bvenKnVwH5UHZWS22QDcSVk27L4E76NFEb89+svmaDDYLqsQ6RftnslZ0qk2073cos6uKFYBRCIYn+4CiF5SKuF2FqzEz92qrDQBfJWpjRt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11457
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Oct 2026 09:27:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24477

Hi all,

CIP kernel team has released Linux kernel v6.12.112-cip33.
The linux-6.12.y-cip tree has been updated base version from v6.12.111 to
v6.12.112.
In this release, patches were integrated to document the RZ/G3L SoC for the
Renesas RSPI driver, add RSPI nodes for r9a08g046, and enable RSPI2 on the
r9a08g046l48-smarc board.

Information about this release is as follows:

  v6.12.112-cip33:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      3be432a1964261021750e13704e407022ff319c8
    fixed CVEs:
      CVE-2026-23175: net: cpsw: Execute ndo_set_rx_mode callback in a work=
 queue
      CVE-2026-23203: net: cpsw_new: Execute ndo_set_rx_mode callback in a =
work queue
      CVE-2026-52988: netfilter: nf_tables: join hook list via splice_list_=
rcu() in commit phase
      CVE-2026-72315: smb: client: fix busy dentry warning on unmount after=
 DIO
      CVE-2026-72463: xfrm: Fix dev use-after-free in xfrm async resumption
      CVE-2026-74347: netfilter: cttimeout: detach dataplane timeout policy=
 and repurpose refcount
      CVE-2026-80929: sysctl: move the "cad_pid" entry from pid_table[] to =
kern_reboot_table[]
      CVE-2026-80935: wifi: mt76: mt7996: bound the device EEPROM address b=
efore the EFUSE copy
      CVE-2026-80937: wifi: mt76: mt7915: bound the device EEPROM address b=
efore the EFUSE copy
      CVE-2026-80939: wifi: rtw89: pci: add .shutdown callback to stop rfki=
ll polling on reboot
      CVE-2026-80980: net/smc: stop killed, freed and out_of_sync sharing a=
 byte
      CVE-2026-81015: platform/x86/amd/pmc: Fix LPS0 and debugfs leaks when=
 STB init fails
      CVE-2026-81016: platform/x86/amd/pmc: Propagate SMU errors and valida=
te S2D address
      CVE-2026-89437: platform/x86: int1092: Fix potential memory leak in s=
ar_probe()
      CVE-2026-89441: mmc: via-sdmmc: cancel card-detect work on remove
      CVE-2026-89445: iommufd: Fix UAF in selftest IOPF reporting
      CVE-2026-89452: iommu/msm: Unwind probe state on registration failure
      CVE-2026-89467: power: supply: qcom_battmgr: fix use-after-free
      CVE-2026-89500: ring-buffer: Make cpu_buffer::free_page a buffer_data=
_read_page
      CVE-2026-89503: ring-buffer: Fix subbuf resize race with ring_buffer_=
alloc_read_page()
      CVE-2026-89520: sched/core: Make core-sched flips wait for in-flight =
selections
      CVE-2026-89739: usb: dwc3: gadget: Fix use-after-free in dwc3_gadget_=
free_endpoints due to race condition
      CVE-2026-89766: pidfd: hold exec_update_lock around namespace ioctl
      CVE-2026-89795: PCI: Allow per function PCI slots to fix slot reset o=
n s390
      CVE-2026-89797: power: supply: ab8500_fg: fix use-after-free on remov=
e
      CVE-2026-89806: drm/sysfb: ofdrm: Fix integer overflow in fb_size cal=
culation
      CVE-2026-89827: drm/amdgpu: avoid force-completing uninitialized UVD =
rings
      CVE-2026-89832: f2fs: fix to clear dirty flag on folio in error path
      CVE-2026-89837: f2fs: fix dentry folio leak in find_in_level
      CVE-2026-89838: f2fs: limit recovery filename logging to stored lengt=
h
      CVE-2026-89840: f2fs: validate MOVE_RANGE destination size
      CVE-2026-89859: scsi: qla2xxx: Zero dport diagnostics buffer to avoid=
 info leak
      CVE-2026-89868: media: chips-media: wave5: Add timeout while stop_str=
eaming
      CVE-2026-89921: KVM: s390: Zero initialize data structures for inject=
_pfault_token
      CVE-2026-89956: s390/vfio-ap: Fix missing lock required to access lis=
t of ap_matrix_mdev objects
      CVE-2026-89971: nvme: skip the zoned limits update if the zone info q=
uery failed
      CVE-2026-89972: nvme: add missing SRCU grace period in error path
      CVE-2026-89996: dma-buf: dma-heap: don't publish fd before copy_to_us=
er() succeeds
      CVE-2026-90002: ftrace: Take trace_array reference before accessing i=
ts ftrace_ops
      CVE-2026-90013: tracing: Take trace_array reference when opening opti=
ons file
      CVE-2026-90016: staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_=
ie()
      CVE-2026-90023: usb: gadget: f_mass_storage: fix null pointer derefer=
ence in fsg_common_set_num_buffers()
      CVE-2026-90029: usb: storage: realtek_cr: fix use-after-free on disco=
nnect
      CVE-2026-90030: usb: dwc3: clear forceRM when issuing EndTransfer
      CVE-2026-93196: nvdimm: virtio_pmem: refcount requests for token life=
time
      CVE-2026-93199: i3c: master: Do not treat master device as a duplicat=
e target
      CVE-2026-93200: i3c: master: Fix use-after-free of master->this
      CVE-2026-93231: lockd: fix swapped arguments in nlmsvc_match_ip()
      CVE-2026-93244: drm/sysfb: simpledrm: Improve stride validation
      CVE-2026-93285: f2fs: embed f2fs_gc_kthread in f2fs_sb_info
      CVE-2026-97527: scsi: qla2xxx: Serialize NVMe unsol ctx list with a p=
er-fcport lock
      CVE-2026-97528: scsi: qla2xxx: Unlink NVMe unsol ctx before freeing o=
n LS reject error
      CVE-2026-97529: scsi: qla2xxx: Validate BSG request_len before readin=
g vendor_cmd[]
      CVE-2026-97530: scsi: qla2xxx: Fix soft lockup polling continuation I=
OCB signature
      CVE-2026-97531: scsi: qla2xxx: Skip vport under deletion in report ID=
 acquisition
      CVE-2026-97532: scsi: qla2xxx: Null out freed pointers in qla2x00_mem=
_alloc() error path
      CVE-2026-97534: f2fs: accurately adjust free_sections during free_seg=
ment_range
      CVE-2026-97535: scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bi=
tmap size
      CVE-2026-97536: scsi: qla2xxx: Fix use-after-free of qpair work on qu=
eue teardown
      CVE-2026-97537: scsi: qla2xxx: Fix queue teardown NULL dma_free and b=
itmap locking
      CVE-2026-97549: xfs: fix under-reservation of blocks when repairing s=
f directories
      CVE-2026-97559: smb: client: fail DACL rewrite when the new DACL exce=
eds 64K
      CVE-2026-97566: mptcp: pm: kernel: drop pending ADD_ADDR when removin=
g ID0
      CVE-2026-97571: bnxt_en: Propagate TPA buffer allocation failures in =
bnxt_queue_mem_alloc()
      CVE-2026-97574: bnxt_en: Don't free the live ring's TPA state on queu=
e restart failure
      CVE-2026-97594: landlock: Fix use-after-free of the source's parent d=
irectory
      CVE-2026-97597: ipv6: flowlabel: cap duplicate leases per socket
      CVE-2026-97603: idpf: disable DIM work before freeing q_vectors
      CVE-2026-97609: netfilter: cttimeout: prevent UAF during module unloa=
d
      CVE-2026-97615: net: bridge: use option bits for CFM/MRP frame handle=
rs
      CVE-2026-97618: io_uring/net: don't overconsume buffers when using MS=
G_TRUNC
      CVE-2026-97619: io_uring/rw: end write accounting from ->ki_complete
      CVE-2026-97620: drm/xe: Flush LSC untyped L1 dataport cache after rcs=
/ccs batches
      CVE-2026-97901: genetlink: pin family module during policy dump
      CVE-2026-97906: bootconfig: Fix integer overflow in initrd size check
      CVE-2026-97918: tracing: Undo the registration when enabling the hist=
ogram trigger fails
      CVE-2026-97919: tracing: Take the reference before publishing the nam=
ed histogram trigger
      CVE-2026-97933: tracing: Take trace_array reference when opening a tr=
acer options file
      CVE-2026-97934: tracing: Fix memory corruption from a "STACKTRACE" hi=
stogram key
      CVE-2026-97935: tracing: Set the trace clock before registering the h=
istogram trigger
      CVE-2026-97938: reboot: fix cad_pid use-after-free race
      CVE-2026-97939: ipmr: account multicast table and route memory
      CVE-2026-97949: configfs: unhash the dentry before dropping the item =
in rmdir
      CVE-2026-97950: configfs: pin the symlink target's dirent instead of =
chasing ->ci_dentry
      CVE-2026-98065: bpf: Reject key-less BTF for hash maps
      CVE-2026-98101: ipv6: mcast: use copy-on-write RCU updates in ip6_mc_=
source()
      CVE-2026-98161: nvdimm: pmem: keep PREFLUSH before data writes
      CVE-2026-98167: smb: client: fix server->total_read for compound encr=
ypted PDUs
      CVE-2026-98168: smb: client: fix reparse buffer bounds in cifs_query_=
reparse_point()
      CVE-2026-98169: smb: client: fix potential OOB read in smb3_enum_snap=
shots()
      CVE-2026-98170: smb: client: fix OOB struct field reads in move_smb2_=
ea_to_cifs()
      CVE-2026-98171: smb: client: fix next_buffer UAF and NextCommand boun=
ds in compound PDUs
      CVE-2026-98172: smb: client: fix smbd_connection leak on cifs_get_tcp=
_session() error
      CVE-2026-98173: smb: client: fix use-after-free of iface in cifs_try_=
adding_channels()
      CVE-2026-98174: smb: client: fix rlist race and missing initializatio=
n
      CVE-2026-98175: smb: client: cancel reconnect work in clean_demultipl=
ex_info()
      CVE-2026-98179: drm/amdgpu: fix rmmio iounmap skipped on device remov=
al
      CVE-2026-98181: drm/gud: fix out-of-bounds write in gud_plane_atomic_=
check()
      CVE-2026-98182: wifi: mac80211: refuse to make a monitor active when =
it has no queue
      CVE-2026-98184: wifi: mwifiex: prevent authentication frame length tr=
uncation
      CVE-2026-98185: wifi: mwifiex: validate scan response extents
      CVE-2026-98186: wifi: mwifiex: bound the pairwise-cipher OUI walk to =
the IE length
      CVE-2026-98187: wifi: p54: require a full exp_if record in PDR_INTERF=
ACE_LIST
      CVE-2026-98188: wifi: p54: validate curve data length in the calibrat=
ion curve converters
      CVE-2026-98189: wifi: wilc1000: fix RX buffer OOB-write in wilc_wlan_=
handle_isr_ext()
      CVE-2026-98190: wifi: wilc1000: fix out-of-bounds read in P2P public =
action frames
      CVE-2026-98191: wifi: wlcore: release runtime PM ref on regdomain con=
fig failure
      CVE-2026-98192: wifi: wcn36xx: Fix potential use-after-free in TX ack=
 timer teardown
      CVE-2026-98193: wifi: libipw: reject TKIP frames without a full MIC
      CVE-2026-98194: wifi: libertas_tf: fix UAF in lbtf_free_adapter()
      CVE-2026-98195: wifi: iwlegacy: fix broadcast stations deallocation
      CVE-2026-98196: wifi: brcmsmac: fix UAF in brcms_free_timer()
      CVE-2026-98197: hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on re=
move
      CVE-2026-98198: hwmon: (pwm-fan) Stop RPM timer before freeing tach d=
ata
      CVE-2026-98199: hwmon: (pmbus/core) increase number of phases and add=
 new mask
      CVE-2026-98200: hwmon: (hp-wmi-sensors) Fix use-after-free in fungibl=
e_show()
      CVE-2026-98201: Input: zero ff_effect before compat copy in input_ff_=
effect_from_user
      CVE-2026-98202: Input: synaptics-rmi4 - fix GPF in suspend and resume=
 when unbound
      CVE-2026-98203: Input: soc_button_array - check btns_desc->package.co=
unt
      CVE-2026-98204: Input: rmi_smbus - fix out-of-bounds read in rmi_smb_=
write_block()
      CVE-2026-98205: Input: evdev - zero absinfo before partial copy in EV=
IOCSABS
      CVE-2026-98206: Input: cyttsp5 - clamp the HID report size before mem=
cpy
      CVE-2026-98207: mmc: spi: reset bytes_xfered before retrying CRC fail=
ures
      CVE-2026-98208: mmc: sdio_uart: fix xmit_fifo leak when the port tabl=
e is full
      CVE-2026-98209: mmc: sdhci-of-aspeed: Remove children before releasin=
g SDC resources
      CVE-2026-98210: mmc: mxcmmc: cancel data work and watchdog on remove
      CVE-2026-98211: mmc: mmci: Fix use-after-free in busy-timeout work
      CVE-2026-98212: mmc: hsq: Fix use-after-free in retry work
      CVE-2026-98213: mmc: core: Cancel SDIO IRQ work before freeing host
      CVE-2026-98214: selinux: recheck intermediate backing files on mprote=
ct()
      CVE-2026-98215: selinux: preserve user SID across nested backing file=
s
      CVE-2026-98216: IB/hfi1: Fix the PIO_CRED credit-return mmap
      CVE-2026-98217: IB/mlx4: Fix use-after-free on pkey sysfs registratio=
n failure
      CVE-2026-98218: i2c: atr: fix dangling adapter pointer on add failure
      CVE-2026-98221: KEYS: trusted: Fix tpm2_load_cmd() boundary check
      CVE-2026-98222: KEYS: encrypted: fix integer overflow of datablob_len
      CVE-2026-98227: memstick: ms_block: destroy io_queue workqueue on rem=
oval
      CVE-2026-98229: xfrm: save input state data before secpath resets
      CVE-2026-98230: xfrm: use hlist_del_init_rcu for state_cache and stat=
e_cache_input
      CVE-2026-98231: xfrm: serialize state GC with device state flush
      CVE-2026-98232: scsi: core: Validate MODE SENSE lengths in scsi_cdl_e=
nable()
      CVE-2026-98233: net/packet: clear RX owner on VNET header error
      CVE-2026-98234: net/sched: hhf: cap hh_flows_limit at change time
      CVE-2026-98235: net/sched: act_api: release tail references on DELACT=
ION failure
      CVE-2026-98236: net: wwan: mhi_wwan_mbim: check skb_copy_bits() retur=
n value
      CVE-2026-98237: net: wwan: mhi_wwan_mbim: guard against a cyclic NDP =
chain
      CVE-2026-98238: net: wwan: t7xx: validate the netif index in t7xx_ccm=
ni_recv_skb()
      CVE-2026-98239: net: lan743x: fix RX checksum use-after-free
      CVE-2026-98241: ipv6: xfrm: use full sockets in local error paths
      CVE-2026-98245: btrfs: take commit root semaphore when iterating in m=
ark_block_group_to_copy()
      CVE-2026-98246: Bluetooth: hci_sync: Serialize local codec list clean=
up
      CVE-2026-98247: Bluetooth: hci_codec: validate vendor codec count len=
gth
      CVE-2026-98248: arm64: percpu: Fix LSE operations on {8,16}-bit types
      CVE-2026-98249: arm64: hibernate: pass HVC_SET_VECTORS args to the re=
sume hvc
      CVE-2026-98251: openvswitch: avoid reallocating confirmed conntrack l=
abels
      CVE-2026-98252: RDMA/core: fix refcount bug in iwpm_get_nlmsg_request=
()
      CVE-2026-98253: RDMA/ucma: Serialize join and leave on copy_to_user f=
ailure
      CVE-2026-98254: swiotlb: use the adjusted address for the highmem pag=
e lookup
      CVE-2026-98255: tcp: exclude old ACKs from tcp fast path
      CVE-2026-98257: rds: ib: use rds_conn_drop() on protocol version mism=
atch
      CVE-2026-98260: exec: Cleanup POSIX timers right after de_thread()
      CVE-2026-98261: cifs: Fix server use-after-free in cifs_chan_skip_or_=
disable()
      CVE-2026-98262: ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_3=
2BIT_ONLY
      CVE-2026-98263: ASoC: codecs: rt712-sdca-dmic: fix uninitialized stre=
am_config->type
      CVE-2026-98264: ALSA: virtio: reset device before deleting virtqueues
      CVE-2026-98265: ALSA: usb-audio: Clamp implicit feedback packet count=
 to URB capacity
      CVE-2026-98266: ALSA: core: Fix potential UAF after asynchronous card=
 release
      CVE-2026-98267: 9p: Fix v9fs_issue_write() to update i_size and remot=
e_i_size
      CVE-2026-98269: btrfs: abort transaction on failure to update inode f=
or hole punching and reflinking
      CVE-2026-98270: drm/amdgpu: check ras and obj before dereference
      CVE-2026-98271: net: skbuff: do not leave stale header offsets after =
pskb_carve()
      CVE-2026-98272: net: mvpp2: prevent buffer overflow in page_pool allo=
cation
      CVE-2026-98275: net: ethernet: cortina: Ack RX overrun interrupt corr=
ectly
      CVE-2026-98276: net: lock the socket in sock_gettstamp()
      CVE-2026-98282: powerpc/iommu: Fix the overflow validation in iommu_t=
ce_check_ioba
      CVE-2026-98283: KVM: PPC: Book3S HV: fix use-after-free in kvmhv_emul=
ate_tlbie_all_lpid()
      CVE-2026-98287: pppoatm: ensure a writable skb header and linear data
      CVE-2026-98290: Bluetooth: RFCOMM: avoid socket lock inversion in lis=
tener cleanup
      CVE-2026-98291: Bluetooth: btintel_pcie: fix off-by-one bounds check =
in RX submit
      CVE-2026-98293: Bluetooth: ISO: Fix parent socket leak in iso_conn_re=
ady()
      CVE-2026-98295: Bluetooth: coredump: Quiesce dump work on unregister
      CVE-2026-98297: Bluetooth: hci_core: Fix queuing tx_work after workqu=
eue is drained
      CVE-2026-98298: dmaengine: mmp_pdma: fix wrong sg length in mmp_pdma_=
prep_slave_sg()
      CVE-2026-98299: tcp: do not let tcp_rmem be set below 4096
      CVE-2026-98300: tcp: Don't call skb_clone_and_charge_r() for close()d=
 listener in tcp_v6_do_rcv().
      CVE-2026-98301: net: bridge: mst: move switchdev call outside rcu
      CVE-2026-98302: net: fddi: skfp: fix NULL deref when setting the MAC =
address while down
      CVE-2026-98303: ipv4: icmp: reject RTN_UNREACHABLE input routes in ic=
mp_route_lookup
      CVE-2026-98306: seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP d=
ecapsulation
      CVE-2026-98307: wifi: ath11k: cleanup arsta in ath11k_mac_peer_cleanu=
p_all()
      CVE-2026-98308: ALSA: hda: trace PCM open only after assigning a stre=
am
      CVE-2026-98309: drm/vc4: Use managed KMS polling to fix UAF on unbind
      CVE-2026-98311: wifi: virt_wifi: don't transfer operstate before regi=
ster
      CVE-2026-98312: ALSA: 6fire: fix OOB write from device-reported iso l=
ength
      CVE-2026-98314: ALSA: pcm: set timer->private_data before registering=
 the PCM timer
      CVE-2026-98316: ALSA: bcd2000: Fix race between rawmidi and disconnec=
t
      CVE-2026-98319: drm: Fix drm_pending_vblank_event leak in error path =
for out_fence_ptr
      CVE-2026-98320: netfilter: flowtable: hold reference on ct until flow=
 is released
      CVE-2026-98322: netfilter: nft_nat: fully initialise new_addr in netm=
ap setup
      CVE-2026-98323: RDMA/siw: Bound fragmented header copies by the remai=
ning length
      CVE-2026-98325: wifi: mac80211: set up the TX info early to fix failu=
re paths
      CVE-2026-98326: wifi: mac80211: mesh: release the channel if start fa=
ils
      CVE-2026-98327: wifi: mac80211: mesh: reset the CSA state when leavin=
g
      CVE-2026-98328: wifi: mac80211: add HE 6 GHz capability in the scan e=
lems len
      CVE-2026-98329: wifi: mac80211: don't allow injecting frames wider th=
an the chanctx
      CVE-2026-98331: wifi: mac80211: unlist vifs when their netdev is unre=
gistered
      CVE-2026-98334: wifi: mac80211: reset state when starting AP fails
      CVE-2026-98335: wifi: mac80211: abort chanswitch when leaving a mesh
      CVE-2026-98336: wifi: mac80211: don't offload TC setup on AP_VLAN int=
erfaces
      CVE-2026-98337: wifi: mac80211: don't start a ROC while scanning
      CVE-2026-98339: wifi: cfg80211: don't filter by BSS type when removin=
g stale entries
      CVE-2026-98340: wifi: cfg80211: only group hidden BSSes with beacon e=
ntries
      CVE-2026-98342: dmaengine: wait for RCU readers before releasing dma_=
device
      CVE-2026-98343: dmaengine: fix use-after-free in dma_chan_put() and d=
ma_release_channel()
      CVE-2026-98344: dmaengine: Fix device kref underflow in dma_chan_put(=
)
      CVE-2026-98345: wifi: cfg80211: check IP header size in cfg80211_clas=
sify8021d()
      CVE-2026-98346: wifi: cfg80211: don't get the radio mask for netdev-l=
ess wdevs
      CVE-2026-98347: IB/IPoIB: Avoid restoring OPER_UP after multicast flu=
sh
      CVE-2026-98348: wifi: libipw: reject too-short association responses
      CVE-2026-98349: wifi: libipw: reject too-short beacon and probe respo=
nses
      CVE-2026-98351: wifi: virt_wifi: free skb when disconnected
      CVE-2026-98352: RDMA/rtrs-clt: Fix CQ pool leak when connect is inter=
rupted
      CVE-2026-98354: RDMA/mad: Fix receive buffer leak when PKey enforceme=
nt fails
      CVE-2026-98357: IB/isert: wait for deferred control PDU completions b=
efore releasing the connection
      CVE-2026-98358: IB/iser: reject a remote invalidation of an unregiste=
red direction
      CVE-2026-98359: RDMA/core: Reject unregistering netdevs in ib_get_eth=
_speed
      CVE-2026-98360: RDMA/rxe: insert mcg into mcg_tree only after rxe_mca=
st_add() succeeds
      CVE-2026-98362: clk: scpi: bound-check DVFS index in scpi_dvfs_recalc=
_rate
      CVE-2026-98363: firmware: arm_scpi: reject DVFS OPP count above MAX_D=
VFS_OPPS
      CVE-2026-98365: RDMA/rxe: Fix integer overflow in mr_check_range() le=
ading to OOB access
      CVE-2026-98366: RDMA/rxe: validate access flags before swapping the M=
R's PD
      CVE-2026-98367: RDMA/siw: Clear association under lock if siw_qp_modi=
fy fails in siw_accept
      CVE-2026-98368: esp: downgrade zerocopy managed frags before mutating=
 skb frags
      CVE-2026-98369: xfrm: add missing rcu_read_lock(), skb_dst_force() an=
d dev_hold() for xfrm_trans_reinject()
      CVE-2026-98370: xfrm: fix compat ALLOCSPI request use-after-free
      CVE-2026-98373: mm/hugetlb: preserve mremap address delta when skippi=
ng page tables
      CVE-2026-98374: tcp: fix use-after-free of retransmit_skb_hint in tcp=
_send_synack()
      CVE-2026-98377: vlan: require the MAC header to be present in __vlan_=
insert_inner_tag()
      CVE-2026-98378: bpf: Skip unsettled links in link iterator
      CVE-2026-98379: netfilter: ip6t_rpfilter: reject routes without inet6=
_dev
      CVE-2026-98380: net/sched: reject IDR error pointers when deleting ac=
tions
      CVE-2026-98381: veth: manage XDP program pointers during channel resi=
ze
      CVE-2026-98382: bpf: Reject dev-bound-only programs on other devices
      CVE-2026-98383: bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
      CVE-2026-98384: bpf: Fix out-of-bounds read of sk_protocol in bpf_soc=
k_destroy()
    added commits:
      CIP: Bump version suffix to -cip33 after merge from stable
      arm64: dts: renesas: r9a08g046l48-smarc: Enable RSPI2
      arm64: dts: renesas: r9a08g046: Add RSPI{0..2} nodes
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3L SoC

Best regards,
  Nobuhiro


