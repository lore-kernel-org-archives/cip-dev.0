Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2FBEBFD20
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 09:09:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.267599.1776071333049283588
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 02:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=bAFSsx+k;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1776071320;x=1777280920;bh=
	4d6EfVZwRtl+onx9o+3VkDXtVaz5Gje3qNHNdzLeOVA=;b=bAFSsx+kEnnhRfBnlYr+xZ64Nq2hvj
	GlZTCV4hWUo4cJ5kK1mVIQTY45auWcfKskabgaQ5JxIJxbGwYkNf+5G2vPWGZrgDMJ7IAhY+t+cwX
	LzlcIEerDwpJe9qWEbB+Ypv4qFbjGibHBwjfaLdkCKwZ/XjL5ic2CBj/tkKoaSmU2+ZlI4GPef7I/
	lfri1Q+AN2ufSzkUa0SNghD6PPZEGOzSMxksL3CasyVO3gYOT6tyEvzzLJ1UNM0JVz5pqJVfTkh+A
	vWRR7yT96ftXbCYnbU/nvN6j6mvIOShrJAFpBhAWhBmRLBB90yeZtgfxthLZsCN17gXTX3aDYFcpx
	YNiw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 63D98dEx3342419; Mon, 13 Apr 2026 18:08:39 +0900
X-Iguazu-Qid: 2rWhfSiM7OVglAubh2
X-Iguazu-QSIG: v=2; s=0; t=1776071319; q=2rWhfSiM7OVglAubh2; m=6x2ZyfVJrzTswSGpeanKb7qiNe+Tw6eiLyJk8OWFv8I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fvM5f1JRQz4vyh; Mon, 13 Apr 2026 18:08:38 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHdOa91AqjBoxAyMC6ufyTeXL3SC8Rkf3SomS7hKyxJ2CCAQ8L5ya1oOeGI6NiEPVpNrj+IiuIMuOKAiWfDI7lDdQ6c/KJpR2VK0S77UOWUzfQW4SeCL7fo7gqcZvpYflQceRafxNtuKHsx97i4MAUb1F2lG5xV2HrgATwz95ebQDSTS5dSVe3KX8Kq1jvsZQSkbDooksvMldi8BGexJLjzanNgcv3/SX80F7NEoSWxpOshRvcbSELqm1kuQx5ZpTcroPBvbc3HOFW6zhqTkcJWA107EjLWwvV+Biu+UoE6uEys6rGroKJQu/L1trZMuHFc4WFTZnShfDco4laGCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wMfFr+E03w4jz9xXAtjzJKdU8WTLkPqV0QH2b1LgdM=;
 b=wXWnfsFtaESbnAkh4D/qdmClFHWKwCab7x2eXdILVDOCx65vbBZmMQtd3SNYkT76EXok16tNDhGKqjLt+w9q4tbvdQSTCPbKhrwZTvoWYpTetPB4iOvIdIdhs94aurXcHYueg51ykrxH6QLy5XdYhlieMgDfw1LlwaK/ZxqFSb3ur/WKh7Bh9wJESA/sz/gNUfpa1RFTqYI9LsSS1i98Jky+XDRpCTAKJehn6YnGJ1H2f/J5UFWkAoYyiBjnfBwJ/17G3OpPGtICDL8kgnmQImthGjMSqvgB4ZE5BanWMl/3tvSZmV3ENJ2UHNRDFCkMDvZhLO9EugpMBK4nCMVDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.252-cip71
Thread-Topic: [ANNOUNCE] Release v5.10.252-cip71
Thread-Index: AdzLJPL7yfxRaRS2RGK3SlHWPx07RA==
Date: Mon, 13 Apr 2026 09:08:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818AAFEF50E0889AF82A574CD242@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSAPR01MB7277:EE_
x-ms-office365-filtering-correlation-id: b01b8ac1-0a35-4c5f-5782-08de993c3e5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 k+uFptV4KNIIau7PJNT0PmZPs3/IE7jJHziqlvui5Jy7oVoEVlwCGcYQs6xa2yq0sN6oASFxhmfmRHmqS+YVNlpFK0uBEaivlbYdtrflgpsZ0ia1P0FDtnKbERfEUv1k+VMlb6U+5isni2yB8kmjWat9Ol43GdFTEaowgMt9MuCj+eQ3Mtb2H7PhYdVBUhAB5KvIBzjxVakEwGzz7PED+DKXlGaqbNOJCBl0cny9WlsgSwwVt0szRlV2plkPABLtGsqG70CP7aDObUOAOroBLq2dncTtTSu8HtVO8g7ZwNcPfe8y+cNn1mvBuC+YRMByejEb53Ua9p0PCrgZI1KInE21uliF73QlotkNf8JUhV94LXcSl2n9qoDKKQCrvqVi53CnUpf+LuzzfGZsgT32Z/2dTIm2PektGJsTYDanC9oVW+cFl04QnY4O2Ne9mvVOPDFataD7ZsvvkpgStaRZDMmbuETIELY3rhW1dHOV0mVSmak1Onm6JmN1hrASCVdtwrxFsxX7xkHk5Zi1J4EDlVsT8SHPvSbuhUjykFttcpUjJS/Sk6TbJdTnRGhn/g1M/8jvKYi6bKZUa6dLJJs8pmydZvK9qOw10l+rL0XoxVQLs3Wa1NJCMHmvWIhfagKjd2CaIj666eGzI2nLYDQMkO2NOZJ17ijErW/DAPixa5/s1FZjjTFWpwK7mpe7obmg+BMqwV/x+FGicd9OlZjGiPcqjxFJAqrdyB5OYN7Y+1JJYLen9uf7jOCh6fx7OlcTiNOIzK4aBQY6xJG26UuYOjO0graRnzpvagr6Ny4gFkg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TVRWZHZIOUFFQ0FWU1ZUUzRFblZOR0RyUXR3ZWdRMDFVeWU1TWpjL2pD?=
 =?iso-2022-jp?B?K0VwZGEzSHFWWXNmZ3F4QWUveFpYdG1Wa2tVdmxZd1NyZmhyU0ZrZnZR?=
 =?iso-2022-jp?B?K0NRRVRwUWwrSzJVRXRoY3d2aTJvcG1laklabmg4TzhHYno2UGlwVHlJ?=
 =?iso-2022-jp?B?VTQyZENlazc2MTZwcDZrN1NWNDgrMVQzOTF4bzdCbldtSnQydUlmNHNY?=
 =?iso-2022-jp?B?VU1FMVV6Yy9JUGJ0TUZsN2gxd2pkbGRzdG1TZ1lSYmVLK0ppVmpvWHZy?=
 =?iso-2022-jp?B?K3VwZXZjTURsSExwcERaTzRqTTdHWWhkdmN3ditKL3I1VmcxVGhkZHI0?=
 =?iso-2022-jp?B?ZG5yaUhPeGtCWFNxRmp6YlBvZXZYeWkrSUxWWFVrdXE1eFd0RTkyRFZY?=
 =?iso-2022-jp?B?NTlYWm4yRG1QMU0wREJNMlBYWHNRWTFERzRLUnd5V0IxMWlCK0NrMHU0?=
 =?iso-2022-jp?B?ekRrMnRycHJqT0xjTFVSNUUvTUlJZ3RnNXlYbmZ2WVYxWmJ2a1JhTi9p?=
 =?iso-2022-jp?B?UlljVURnYmNaZlRuQWxCd2tFQjYrZm0wVDlMNTlEOEpaby93bzlnT1Iv?=
 =?iso-2022-jp?B?K1Uvd1B3NUtKK3RSd2xKNURzcEtxRVZnSjY5RmFRcEVlc21vMTRIaVBR?=
 =?iso-2022-jp?B?ZUdvN21DZTgxV0svWXRrZ1RtbmU5WTJudzErNXpvaXF4Mjl1ZkNqbHhs?=
 =?iso-2022-jp?B?c2tKbndnRTBFMVF4RTJQY3BmOGhQSUJzUnh3UmU0K1haWXg4blJscHVM?=
 =?iso-2022-jp?B?bDFTbnphMnlTVENqdGdaaVQrbmhxM080NFpZbTJCcHV4WTJEcXdWdUpI?=
 =?iso-2022-jp?B?alBKVkFIaU9VOTlhUXBBdDVIQ2Q3UzZkTEMybHRLbFc5R0J1OWFueXlK?=
 =?iso-2022-jp?B?ZWQ0RFhrUlNmSVdrVUlwblFsUlhPV1J2MDR0QUVOS2pOT284NGFwVlVQ?=
 =?iso-2022-jp?B?a0lGOEZmd1lmTUZSL2JseEVkUGRDYURLRjNrKytYeGt5bUFCcEZvOVNZ?=
 =?iso-2022-jp?B?L3IzRjROSXZ2aUVDWnBXZVVQQUZ0SzZzR0loc1lKN1dwYXFXZGRvaC9J?=
 =?iso-2022-jp?B?eU1KRjdpVlFRUEM5emgxZ0RzRk9RRmlwa1VCb2lwOUFsdjYxYTgvanJq?=
 =?iso-2022-jp?B?UE8vUXl2NGpycVI2M3VFcjNzbFJpY2xORDc4aUQ2eG9QYUovTDhteGdB?=
 =?iso-2022-jp?B?WUZzR0w5eXJLMEhUdVNwUGQ5OGVMY3lVVTBKVE5kM0hDUm9YVDBpSE55?=
 =?iso-2022-jp?B?UEZwZGlQdTJZUERFUlZiVXBCQlp2cXcwcUF4djVUOTdUaVN1UGFwaENR?=
 =?iso-2022-jp?B?N0NWYUFidUl3MFF2d2VqQkg0czVnNlFzUTNpT2EyZTFSbE1qUmd0aStG?=
 =?iso-2022-jp?B?MjBDZ0dXZGJRTXZUR0RuV1hPckd0aHYwdHNxU0NiR0Zpb2diOWV2L2Ja?=
 =?iso-2022-jp?B?YWhFbEJFOHhWRTVaTUhWRUd0cE5scWNpcHZnN3hRTk92bHFYMzBBTmdG?=
 =?iso-2022-jp?B?WTNid1FsR2I5Z2hiVFBiTXlRR25PanpHR2IyQS9lTEZhK0N3Z2h3bnJi?=
 =?iso-2022-jp?B?NGF1TGhScnI1WWl2L0V4bzNrd1ZPTUY2dnZlbnJsVGpacWtyRlJFeUlo?=
 =?iso-2022-jp?B?TnpDR0pkU3lDczA2dGR0V0p6TjMzTnZCT1lnNGFNdGI0M2RsVS9FTkRl?=
 =?iso-2022-jp?B?MmRHbVNpbUhxV2xZZU5oVWNsL1o0MWE3dGpMS2g4bDlUL3FIUDJDQW9W?=
 =?iso-2022-jp?B?aVJJQlQya2Jrb2tORXk4S2ZHNHJSTWFlSWRVNytzZTdFSzZnQzlQZXNv?=
 =?iso-2022-jp?B?U2VuRTJna09Rd3l4NHpQY2NZZHlCb2VmQ1c2KzFVNEVvWmpoU2NyZzFM?=
 =?iso-2022-jp?B?UDYxTWgxZEx0QjRpVXFXYUtiTFQzVnI4aU1ubkRjOUsyckI2bCtaNmtt?=
 =?iso-2022-jp?B?T1duQVdjUm03ZytPSUs4UFZJZ2VPQ2ZKQ21CUDVDTWdQRGw4a2o2QktM?=
 =?iso-2022-jp?B?d0ttTGNUUkZtd2d0RTZ3MlE5elZhSHZXMWFueDJXa2I0MEJJeUFtQmxa?=
 =?iso-2022-jp?B?NVdtR3oxRTdCcFRCVlNxSG5RMHZaNmVtOXB5SG8xVzVzK2ZERkV0VGJo?=
 =?iso-2022-jp?B?QlRvN3U4Z3gzU05RT3RDdE9xZE01WlBld1IzNTNjcFVtUkVudHBSam5w?=
 =?iso-2022-jp?B?YXRYQkRrTXl5MGc3eFJVTlhXT0dsK01QcVFWVC92VFVKVWE2dEdnNjBZ?=
 =?iso-2022-jp?B?MlBzTVMrcFlzTFp6K3lQUm1BdHFzRE1UTHB5RC8wSGI5Sm0raDRyOWl3?=
 =?iso-2022-jp?B?VzVEb2t3VElQMk13NzByMlZ6eGQ5NC9BcytXRU8xRWFCbklGNHl0MzVT?=
 =?iso-2022-jp?B?ZUJtenpLVjhmV2NaTUE3T2MrWkJYOFYrSjdMcmxOeTJhMHVFVTlTUnht?=
 =?iso-2022-jp?B?bndKcHNZQUxrNmlmdW54ZzRUb21PdFB3dW1wNy9wVnoxS1RyM2JjbUt0?=
 =?iso-2022-jp?B?ZTBEUkZOeVFWMzhzU1NCRHYvN2pmaDJKSG5NckgzeFVwOUdRK1JXeWFp?=
 =?iso-2022-jp?B?QThNWTVMND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	mleOT2XMNqrpBYuonXqFL+em4qYiM+SMl8FK5au9wpVhLFjVuACY/gaKRtlve3P4MELBlf0c1I6M/YqMnhGH4ZJJHoXnW5qiG99rCUvQYHeb2xHNRx98HQHKhrdctXTV9LfLGbYbfuo2WLRRhOF96+6mXR9C6Z5IxkKNLgZWLctPNifLgF1zcPoy44LHPociN4xv3OKBBejrESaEBFrNzHAJmB/F1zZB+HT/p7Rr5PvbGKOcxg0lIUy2QgAYrfWoBY/ooluwpSuRKGMgRWEgWR6daOv18eGadWUUXSNER5trMPkJdnHrBck/+utaUFszPY355oS3PkzEDGVNExTxAQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01b8ac1-0a35-4c5f-5782-08de993c3e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 09:08:35.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1En+UUnHgtzHy2Oy7ADGjyOP8NYnzCAsdnhM/avn7nDWb5oyNM36FCr7ekIZITrLpT+kaQ64nP7vvB/t071hfjezJdnDFPG3oZQAIxKeOEGJiK+1pqiLkJrCZ1khQDhU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7277
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 09:09:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22678

Hi all,

CIP kernel team has released Linux kernel v5.10.252-cip71.
The linux-5.10.y-cip tree has been updated base version from v5.10.251 to v=
5.10.252.
This release also includes updates to PCIe device driver and DTBs for Renes=
as
ARM64 SoCs.

Information about this release is as follows:

  v5.10.252-cip71:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      6aaa48ed39383d53b0ed2dc209ed941b3cd7a7e3
    fixed CVEs:
      CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on incomi=
ng connection
      CVE-2025-71239: audit: add fchmodat2() to change attributes class
      CVE-2026-23241: audit: add missing syscalls to read class
      CVE-2026-23242: RDMA/siw: Fix potential NULL pointer dereference in h=
eader processing
      CVE-2026-23243: RDMA/umad: Reject negative data_len in ib_umad_write
      CVE-2026-23273: macvlan: observe an RCU grace period in=1B$B!!=1B(Bma=
cvlan_common_newlink() error path
      CVE-2026-31411: net: atm: fix crash due to unvalidated vcc pointer in=
 sigd_send()
    added commits:
      CIP: Bump version suffix to -cip71 after merge from stable
      arm64: dts: renesas: rzg3s-smarc-som: Set bypass for Versa3 PLL2
      arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
      arm64: dts: renesas: rzg3s-smarc: Enable PCIe
      arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
      arm64: dts: renesas: r9a08g045: Add PCIe node
      arm64: dts: renesas: r9a08g045: Use syscon compatible for the system =
controller
      arm64: dts: renesas: r9a08g045: Enable SYS node
      PCI: rzg3s-host: Fix device node reference leak in=1B$B!!=1B(Brzg3s_p=
cie_host_parse_port()
      PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTR=
CVIS
      PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
      PCI: rzg3s-host: Initialize MSI status bitmap before use
      PCI: Add Renesas RZ/G3S host controller driver
      dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
      of/irq: Update the out_irq->np before returning success
      of/irq: Allow matching of an interrupt-map local to an interrupt cont=
roller
      of: Add cleanup.h based auto release via __free(device_node) markings
      reset: Add reset_control_bulk API
      reset: make shared pulsed reset controls re-triggerable
      PCI: Move link up wait time and max retries macros to pci.h
      PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAI=
T_MS
      PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
      genirq/msi: Silence 'set affinity failed' warning
      lib/bitmap: add bitmap_{read,write}()
      clk: renesas: r9a08g045: Add PCIe clocks and resets
      soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap =
config
      soc: renesas: rz-sysc: Add syscon/regmap support
      mfd: syscon: Add of_syscon_register_regmap() API
      soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver
      soc: renesas: Add SYSC driver for Renesas RZ family

Best regards,
  Nobuhiro



