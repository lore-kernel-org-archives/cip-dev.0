Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADBFCD1288
	for <webhook@archiver.kernel.org>; Thu,  4 Apr 2024 04:08:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.30743.1712203697489487605
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Apr 2024 21:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 43447lSc2670164; Thu, 4 Apr 2024 13:07:47 +0900
X-Iguazu-Qid: 2rWgHjhWsqQuNLySOm
X-Iguazu-QSIG: v=2; s=0; t=1712203667; q=2rWgHjhWsqQuNLySOm; m=Hp5/8UtXqybVO0TJpjmKgztaVaVARxXiTPrGo07Uy48=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 43447iDj2594486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 4 Apr 2024 13:07:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6U9KWkm5LeS0CkBPOub4TBNfW4AnYNPHrfjzMqt1bYcjsFv/qLgBZSf3FLtEPOBJFtn3I5aaoqQ4GrcfpDPFqwktoWHzKMJyGyX8gvQ9Ucl+ntUOVq8MhiWbRmhp+OTbjTa1VzZ+a1ZoDBWgo5r3mvR3KNfNwfi04hrlGQnODG9M6NRtRbOTUq+j7e5Z1n7aNBxszz4NgfnN8zEdvTNl58qMDoXz8kEykoSLwT8fZv42jJkDaQpir2MJ1pVffiyc1ovU8QS/XvOWIC3XUPaT/vvWef5jyOOocJSA9FnWDQeNNfp+afcxpf7fUROrvNkuR+cFOQzCiGpBoTqWVdTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9isfnWiIN2l54k7EHeXruSsdjlLIb7Q/h6wV/h5sATk=;
 b=Hm08lXO1uphJy6UJIv68RrtlKM1jpnIgpFYCwnAkkHlBFEJ/euO2pAF7w20trsxkt0HL0PocnTFylBf/XjCKhRYM/N/YwP6sQRNKsxJcmWE2NiZfd07J5GBUzIjlME9AmkN+UnX5HFnPheW5mpcS6KH3H42AdQ/t8UpbnfM2CvOx1eH3GH3JFwduBjTMRla9jTWK6jLRfwA9RAwUqMDJOvfs0UmqTfGQ6EEcNgJlgMb2mvq5Qjwjeyg4F21CRZEfcHKhX7eys+NltmNS7j+VxMX3y+HdS7bi2mbEm8iBCxwZBxguW3LqFt4M0Ilj6N3fy5htUsAkTOkY6Cpotz5hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.214-cip46
Thread-Topic: [ANNOUNCE] Release v5.10.214-cip46
Thread-Index: AdqGRY/pZv0MdrddTuWIKR7zCuInqw==
Date: Thu, 4 Apr 2024 04:07:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388582886B587C9B216097A923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSRPR01MB11437:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 A/pY7vwMutcM5QnTMv4qb00ursxwxhuTXQ6DJ9ceJ7YbKgQbxuNllagb1CySxSonkUt+1XC11/QObpx5Ketgf371giX7QVhuwr1ChNWFL6xVV9rr9LWoYCeSmwzKldLVwFe4dkrn/1XY/ypSHIYVUOPiDJAVslLnV9WM58+wlZ3/NMgmq6Blr8IlKIyd3KNUVOq5tpA33yd1n9/0D9y2269DZyeQCato8Gg0FtZdaqQz0LCg8tFwRDmFDxI1uFnG7bMVMxjvyRVPSg4Lq3HfMsV+CBo2JMACfJp9xQAgBLPSxH0Tnqdb5YQ8MYmCfmcY2N5jo3O/QvU8TcCq05rxjGrnUff/hyuGtjTW3zzshmCNLvDH7M3uAVxZisjmEJ6Rc8rl3lQdLUWiN0BgqPZPUKBXkc27xTWJxVnT06NLJQoX39jZ01/RhIy78vz6Y7zTUIUuXgGMueuTmYTkpoeKnzigXxu4Xl9xFM7ltTmsflAfzMJ/RdE7eNqNrf5fBMyk2ieprXNA2cCAB97bSaNTwnGpdP8OHxkueEalLq5Q/600ERJYbZMpDreBI2gNNVInFss8GP+gic4jq8lZOrpycZn8RgpYFunZeyv8kMlx4qtVA3YhJjMw3c4+F9m7gr2dCdADHkvtsVK6gQUvWcp9dz94eEa0/B8sYSQ0q5krF94bimb505UVMFNAppCr4pw+hx7ZjoaDUXQFRV+e3i0wfFAFqWm1KBSbNxsjt/IA1xo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dDlOaWdkY3pLdmF0QVRQaVlqcGEvRFV0eUFSaEF2K2NiYXR6UHp3NE1E?=
 =?iso-2022-jp?B?L0ZZeDNCS0Uzd1o2UlhSOXZRa0hnQmdvcjVvcWIvSWQvUVFuVjhPcy9G?=
 =?iso-2022-jp?B?UEoyOTV1Yjdsa0lmNHpPSzBXNGtrUWFaa0o3QzR0NUdKYlB1UThCUU5V?=
 =?iso-2022-jp?B?d2hZQTdwaG9JNERnRTFNcm5SZVl6RFlYYmh3bTJ4bzNWTEltbEhYejZ6?=
 =?iso-2022-jp?B?QTg5ZVluOFA1NzFWTDNySzV6NlBYSTRMY2dFMkdKYzhVZzVJMXVWNW9x?=
 =?iso-2022-jp?B?UlhIZ01QcVZzY2ZJL3JXWlZoOUxKc3BCVlROTHEvOEhRaDJrYmdVamZ6?=
 =?iso-2022-jp?B?akIwOXU4ZVE1NVFCWm1ZSlo1VXFXUXBqWEJCZnMyT2J4M3hVanJDSStR?=
 =?iso-2022-jp?B?RkVMNUJUUzZsSjRnaS9SQkZ3cEJhMVBKd1k0Mjg5SXB1KzVNL0kvNW1k?=
 =?iso-2022-jp?B?by9lZVNpWHRSL1A5UlUyWUR3QlhvZTBoU0dScG9TZitTMFBzdzFnMUJU?=
 =?iso-2022-jp?B?UFF4cGE0MFRLanRrd2xGWE1zQU5VR2ZLbVhZME9vNE9ob0Z5dG8yM3Ra?=
 =?iso-2022-jp?B?VGZheEZLVXIreTJSTlh1dnFKZGZxWkorNFcwdEp6U3p1KzFwZEQwRXRu?=
 =?iso-2022-jp?B?MTV3SjdoUDFTUVFTVXJQMGs3NXJ1U3phWUJ5UUQwVWRJWkN6MFhaV0J1?=
 =?iso-2022-jp?B?SytpUW9VaVhTRU5OK2xFajVvSGNWN0tKOXJKODVRZVFpZDFtdXZwNE9m?=
 =?iso-2022-jp?B?OVFYTTdmWHhjOSs4SFRIK2pZTzh6NTN3OHJ1SVRENm5WUlJtek9pVERO?=
 =?iso-2022-jp?B?ZlNLUC93N0txRzVsT1picXFFSkRteVRSY29YSnpqOUR0WjgxYmEzMjNL?=
 =?iso-2022-jp?B?K09KanRjTHNXU0dPSmo2TGJielo4WEVsRktkclQ4eU0vRnVVMnJmcjJ2?=
 =?iso-2022-jp?B?S1pFaXBMaHRFR1kwZ0Y5WkxhWjd4L1BRK05oVko0K2NSNDBwVmlBVG85?=
 =?iso-2022-jp?B?M3ZQQ0xqMW5PN29VZHNIb3N2V3FLK25zL1N1S25mbFZPUTRaUkVSUThN?=
 =?iso-2022-jp?B?QjBGNkF4M2lWUFdxYU5nb2lscU5YMHh2UUhheTFZUU9IVWRsbjhJRmJw?=
 =?iso-2022-jp?B?M0RlK0RuZ3N2b1c4Qk0xRzlGK0hYcThiK0ljQmgwWHpxNUxESU9GL0xQ?=
 =?iso-2022-jp?B?WWRqSVZNRUdqVXJVT0l3SnFwclVsTFU1azhhVEFTbmtydDlES0hxc1dI?=
 =?iso-2022-jp?B?RjJhVHo4Q1puNDVxUVZwbFVXTUtPOUhSd05JbVlHZWk3S05lZmdWWE9R?=
 =?iso-2022-jp?B?cEsrSWE5ejJPM0s1NG5zQ29YcmxPdGg3NXhzQTdLTjZUQkM0V3ZBSTlz?=
 =?iso-2022-jp?B?K0J2UUhGSXJXSHF6RzgvTGhIcFRPTnVHbmhBSW1aQm9zQ3JDRTFhOGpn?=
 =?iso-2022-jp?B?azVnTEtqc3JkcDFRNzJUNHIwWElqV1RaaWZ6cHdYMXA2MXVQS1lkTThx?=
 =?iso-2022-jp?B?NjBKNWt3U0E0OHdxZmFkUkEyYVVWZG5GV0wyZS9nclgwYllKR0tGcUpK?=
 =?iso-2022-jp?B?WE9ISVBBanJ3TGJDTjd5LzhDd1JpZkNsTGVPZXQxZ29SNERSTXh3aFFa?=
 =?iso-2022-jp?B?TDM1VGpqcDNEOTFhbE4vOUJlc1FMZzJhYldaZ1ViRDhOaWRFZHlnS011?=
 =?iso-2022-jp?B?KzFpS0ZCZjZYb0pSSHR0S2ZZdFN4S29FUnRuQk9Sa2JqT1RlUXhubTh2?=
 =?iso-2022-jp?B?bHRLT0ZyUWQvM0dMMXN2Qmw0b3lCZFV0N1NLdVE4R01CcXpWdDY0Y2pL?=
 =?iso-2022-jp?B?U3kxSTBwMzJEY21sMDEwTlg5VERmK0lmYUdQK1kxNGtLN3pBVnNSZ0t0?=
 =?iso-2022-jp?B?VmFxL1lqYW15K21wTGxldWt4L2NpbGo4dG5xK0JMY09uY3dkUFcxSjY2?=
 =?iso-2022-jp?B?aDVld0c4aVRDckV2UzNmYU51clFVTVdMeTJYQUhkdjZRN3I1RG42dG9H?=
 =?iso-2022-jp?B?WTEreDJXajBML1RRaXhIYnM1YUpyajV0UjlxN3pyeCtDWmRvLzhmVThB?=
 =?iso-2022-jp?B?cGFJVEh6SXVJUU1pejZNUUFKcFF3bFF0eFVsUTAvQVBlQmlzU2dWYVRP?=
 =?iso-2022-jp?B?QmdodjAray9Xc3JWYmNDaUhNbWJ0ZXJ0RkFoK1p2a28xTEU5MWhtU1BY?=
 =?iso-2022-jp?B?cVlqckdsMU5KL09JQnlObTM5ejZZeGxrV09VSkJUY0JaNktLZk5rdVlv?=
 =?iso-2022-jp?B?dUYyb0VjUzgvazR3M3FLc1JOQmVtRUFOQXNLRk4yaVNBNUl5SUYxZjZp?=
 =?iso-2022-jp?B?NjB1ZlpqTWpjdzhkY2lyd1RFdFJoQXpFUXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e43945-23ff-4601-04dd-08dc545cc6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 04:07:42.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0WSHECVnB3iIIRminmrRQteqBxkj8rh3HS6BLbewP67fLJXhmjSZd4f/VrpY4/rluMFlQgDOk1lOO8lyqbmGMDFZ4STMOvrYJGdO6tCTuwCM0GmHtjoi9kqxa9jK8Ml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Apr 2024 04:08:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15488

Hi all,

CIP kernel team has released Linux kernel v5.10.214-cip46.
The linux-5.10.y-cip tree has been updated base version from v5.10.212 to
v5.10.214. This release also adds RPC-IF and Interrupt Controller device
drivers for Renesas ARM SoCs.

You can get this release via the git tree at:

  v5.10.214-cip46:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      d1b399d941d4ab1d2107fef7a680deac88ccbc38
    Fixed CVEs:
      CVE-2023-7042: wifi: ath10k: fix NULL pointer dereference in
ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
      CVE-2024-22099: NULL pointer dereference bug and buffer overflow vuln=
erabilities was found in the bluetooth subsystem
      CVE-2024-26651: sr9800: Add check for usbnet_get_endpoints
      CVE-2023-6270: AoE: improper reference count leads to use-after-free =
vulnerability
      CVE-2023-52447: bpf: Defer the free of inner map when necessary
      CVE-2024-26659: xhci: handle isoc Babble and Buffer Overrun events pr=
operly
    added commits:
      CIP: Bump version suffix to -cip46 after merge from stable
      arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for =
ETH{0/1}
      arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support for =
ETH0
      arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support for E=
TH{0/1}
      dt-bindings: interrupt-controller: Add macros for NMI and IRQ0-7 inte=
rrupts present on RZ/G2L SoC
      arm64: dts: renesas: r9a07g054: Update pinctrl node to handle GPIO in=
terrupts
      arm64: dts: renesas: r9a07g044: Update pinctrl node to handle GPIO in=
terrupts
      arm64: dts: renesas: r9a07g043u: Update pinctrl node to handle GPIO i=
nterrupts
      arm64: dts: renesas: r9a07g054: Add IRQC node
      arm64: dts: renesas: r9a07g044: Add IRQC node
      arm64: dts: renesas: r9a07g043u: Add IRQC node
      soc: renesas: Kconfig: Enable IRQC driver for RZ/G2L SoC
      irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same ti=
me
      irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigg=
er type
      irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
      irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
      irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset ba=
sed on register's index
      irqchip/renesas-rzg2l: Implement restriction when writing ISCR regist=
er
      irqchip/renesas-rzg2l: Document structure members
      irqchip/renesas-rzg2l: Align struct member names to tabs
      irqchip/renesas-rzg2l: Use tabs instead of spaces
      irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity s=
etting
      irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()
      irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source
      irqchip: remove MODULE_LICENSE in non-modules
      irqchip: Add RZ/G2L IA55 Interrupt Controller driver
      of: platform: Skip populating IRQ to device resource table
      irqdomain: Make of_phandle_args_to_fwspec() generally available
      dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Contr=
oller
      pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity=
 setting
      pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper
      pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
      pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
      pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interr=
upt
      pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and IRQ_DOMAIN_HIERAR=
CHY
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties =
to handle GPIO IRQ
      arm64: dts: renesas: rzg2: Add RPC-IF Support
      memory: renesas-rpc-if: Remove redundant division of dummy
      memory: renesas-rpc-if: Clear HS bit during hardware initialization

Best regards,
   Nobuhiro



