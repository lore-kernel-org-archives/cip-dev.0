Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAB9CC6B2F
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 04:24:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31999.1792038244797993048
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 21:24:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=hEZX5Xgn;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792038235;x=1793247835;bh=
	bapsNS1Ccn5FmJrl3dOIBL3GprJbIGvhbi3gckRUzvE=;b=hEZX5XgnKNfee84QfkmM4i6CSJsfUF
	QseypLYa/tINQJSPadqB12FAorbUTldq4gBI96mB+BmDBAHvs7wBkG/DBCxEOSvYrL5b070kGx8Hd
	+bKpmGJPmqRQfPJTSJSEbvl2K2REGUG+mL5PmitO0udwXbiipwRx4PJB5jMUus+5p81em6IQsXkuG
	ID/4eu3bYTEeFFVzXj7kErtL13miVhd2OfVDaXyN6DCeTaBkMJiPOxnpJODTcxcNXhDO84MtiJzux
	Id1MvlcTnAvDh1N9fDpWsP6CXTH/znhMghVPRtH6FD7WN1LypKxSNoOm/qkzqW7ppnmt6BimB/je0
	x/sA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 69F4NsEe783949; Thu, 15 Oct 2026 13:23:55 +0900
X-Iguazu-Qid: 2rWh1SQBs0UVSZq3bm
X-Iguazu-QSIG: v=2; s=1; t=1792038234; q=2rWh1SQBs0UVSZq3bm; m=ECBHoPeGCcze3fkQYrfz9xs9hDa84VDcYHLhKR/aRQ4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j4w1j6F2vz4vys; Thu, 15 Oct 2026 13:23:53 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag5MjfbHW5vCVSlPzD0MUpoG31vfy/sEHH5/ybLZQuVauoeFlxz5TnKr2gBypaaPXe8lNvfqvKah9Z5LXtvJ1wWs9J+V+anXF+St5L0VdebqUyvS7CK80McS8vLofy9ggzKHrrnktVtjqCvKIYfQbkOugROkJ6ZOCtCGtm3zEcO08nOv6SLBTKBfCSn4quGi5gDRDvHAmkbKkloVlV+XE58W9MKw2rdczc5KtMA6tA+xLJLHUl76HwSl6sWWr6YtSPHnrI3M31NWmV4gUDDPmztE/13ausDIHvpCpXIrtA4B+azhEV8BRgeBrPlWm+kob9whpdU6Z4e75zC8POzuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRO5jVE/hK2xTzAOZLB7JTKSXh5HtFxYHL5yfM3xs3I=;
 b=i7JUmeCYfpFFd5DCB9RdQLL7hcWMmeZjOZa0yhe8hybVwK6frklj4SjDYriDiW6tI2nQnLIaFsZnO7Lpgo9F0qWJBYtWTSNW+4qVWNJHMdGTAhn0J9FD2g4QYOO1WyFbJ0j65dj+CciXxxx2Et2FRUy8VGE+GFNsOPunLQ2iTu/nLwHwdKK4wpwnZwsalxvCSFMiNZW64ZIvPeXdYcLobzkQsrclydOIQLY8v1dC3gb3+/nzNZrnc1u3jvyjy5+5V269W61yUQKNCdfWocEGOhwpiwJ/c9tdzrSCqX387K0d7xH4PqU3noAKZV4upU0Bh74tf5g7dfEURZ39AAvCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <masami.ichikawa@miraclelinux.com>, <jan.kiszka@siemens.com>,
        <uli@fpond.eu>, <chris.paterson2@renesas.com>, <pavel@nabladev.com>
Subject: [ANNOUNCE] Release v6.1.189-cip61
Thread-Topic: [ANNOUNCE] Release v6.1.189-cip61
Thread-Index: Ad1cXOkkIqYE0u7yTqmtUN8z0D8Ihw==
Date: Thu, 15 Oct 2026 04:23:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818944FEAABD61A012FDC86CD9C2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB17290:EE_
x-ms-office365-filtering-correlation-id: 1e782bf4-fe67-4027-ac71-08df2a741b58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|5023799004|11063799006|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: 
 cpa6H2COUKQZpDQBJ9nXudLHCLs4SjyA3mu/42pMiEKbzBTcYSdkV+NZwdAQUl17Z7OM4bbDnyCjzajwZGdO9/N15cxEAPlOVM2zbMDmoPC6a3j5CYiyQB6U2YCUKuJFrgihqqr+9kuIiWAZW/kFcR/INlWgMQIjD+3Pqm8r/U3Z+q5bEhHuU8eMk81JZOu8NUkjsQJrXWjok9zqiSFYV1xoLULTHsnan6chFPV6WIOwb5FCMgwOIsRo4wq7nw3WdIg04Ld6YtsB670uOJYEaYoPOq1cJiU/g8Y8VHghGamKr0aU3bL/tvIjiejzYhA7xHMiD+KStM5kvDd8K7FTStJUtf1/2Y67J4bL5WxJRal5eMCl3E1jq2xPzIp4JHDvIgZtmG+FOb7Iqc9rsXh3s5OZ0WgH18+wPnNEgyA3zI7U8oLXiK/OMDQZNbj3FiKm2Fkl3eurKzQxrnM31gq9zz+Gf0GgltgF8y/f9Eaze5a0Y26qY9QGVfS9SZYKNSqAtt/6aL/5F8kiVd4jR9x+JkeyV2b0XqQGZsqgmE7So3pOI6Brx0GOGNdEfhv/grnuAQwxFkR6qrt+2u2JEPtRIMq/f6Qy1EV8w4LJ6/zTu00LtaQ/8vJZdICj5suG4YmqySATbzwVnuhHwS5k0qMQwQh6IbFS1awYo2lndN1OQPE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(5023799004)(11063799006)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K1VYZWJoQURRUjRtQlowUmdIQnNpY2M4Q28zNTgzY2s3SDFsOVF2SU9r?=
 =?iso-2022-jp?B?d2ZnanNHRmhkaDlTbmV5UjBTcUJ0WGdMMW1VUWJMdTVLdGFHTFFmYjFD?=
 =?iso-2022-jp?B?RE0vT1pkTWhYVW42cXI0ZUZIbVhhQURGZUt3MVRScTZuWFpsL1dhUDJV?=
 =?iso-2022-jp?B?bE0wbjNVYjZhQ3lYQVFyNmxGWStoTFM3SXFYbTJ2TkZMRjFtL2wvMHhQ?=
 =?iso-2022-jp?B?Zm9ncGF3dE5lVERKMGtNc3hLVFZVN2hIMzFraTJJRm9ORmU1emFzT3J6?=
 =?iso-2022-jp?B?UEp6VnpwOWhpK29BTFdqTS9KK3pxTXFHL0pkUkVmREJ2ZGFJd09iSkw1?=
 =?iso-2022-jp?B?cVNQaTJQVGMyM1hwU0U0NWk3am5sOUcwZmEvZExaZWFwWEQrbHhtM3FD?=
 =?iso-2022-jp?B?RllsZTNReUw1cEpCaGtxd05DUGo5S0RmdjlVTmhuamxRcmorUGlYLzFS?=
 =?iso-2022-jp?B?Nk14M2p6Y2UxZVE0YVVDL1dwZWtRRm04VklKZ2dJSmFRMzcwQ1ZmSVBi?=
 =?iso-2022-jp?B?VjBTZ2hKZXFsV21POGRkbWdsY09nbVRMV0N3bW03K212UWFjWWtYS3hU?=
 =?iso-2022-jp?B?NFB4SkZFSm1HMGJpMTh1S0RlcEFaN3BNdFU1c0JSK0VkVll3b0pNYTd5?=
 =?iso-2022-jp?B?Y1RLMVNwczJmek9CSDdzNUxjQVRmR2NIeEdtRGd3akQ4ZXBEb3MzdGNZ?=
 =?iso-2022-jp?B?SGU1YXdUSTU1a1NmWWlvNUtlS01Uc1hqbENHb1lKdnpKY0ZkZDNtT1pv?=
 =?iso-2022-jp?B?aFBSay9ENWlZa0pWY0NNKzFiaVI2ak5ZQ3NDaDVGaXdwTkRQTHJTQ0Rm?=
 =?iso-2022-jp?B?bjVBZXN3SjNSMHhQczBqbm5zMWlvdEdjU0Q3UllFSngxcFNscVNYS216?=
 =?iso-2022-jp?B?UVJNSU9IRit1ZUJwaFFtRnV3SDNOdkx4dzNNV1ZmOXl0RnUxdjBPODlz?=
 =?iso-2022-jp?B?eDg3ZkJyRVB3a1JDN2J3MTlnMTk3N2JnSVhBZEs1aE5HRXNRMU40Nytk?=
 =?iso-2022-jp?B?bkNVWC9RU21DUVBoNzNISlRLNzBTaXQ4T2djNmQvZHRleWFHOWIvYkM4?=
 =?iso-2022-jp?B?SXU1Y01kZnlpa25GYW9xRmFJckUrTEhqWkxQY0lzRHBkaXVNOGZGcng0?=
 =?iso-2022-jp?B?WFIrY0pTd3pqcithMjFDcCt3TmVVZ2JRZTFpVkZsbmtydjR4R0R0eUUr?=
 =?iso-2022-jp?B?VDRubTcyaUxmS09zUzhSeEE1TjFmQUVEczNMdzNBQWJjSDZZaEJ0VUx5?=
 =?iso-2022-jp?B?N2R4Yk1NaXZkcnBFK25wRkdrRFhIeFM5QjJvNWpLcnROSW9wY0NvTDll?=
 =?iso-2022-jp?B?a0lEZkFJamtQYm1qZXRXUVN3SjBIV09UblVld0JZUUdWYXRmdStRMkhR?=
 =?iso-2022-jp?B?TXJob3BxVHljNEpDSjRlRlViaWJPcHdBalVnekxqRHVycU5YbnJteDVo?=
 =?iso-2022-jp?B?Vk1jTEJYcU1ScnlvbE93dFkwUzczbGNoN2ZkVjhnRWl1UHQzYTlWVkMw?=
 =?iso-2022-jp?B?akx0OTQxRmdIbmw0SEkvSG5DcWlGRDFDaEhlS2RWVXVKOXFiZ2tUNUZE?=
 =?iso-2022-jp?B?cUkwZ1FyTk5zc25yaU1YbE4xZjNCRUx2ZE1iaE1oM0wybnNlUFVUNWpa?=
 =?iso-2022-jp?B?K1RnVFIvdGhFdG50MnU3MHUvd3RONmhRYzdHRnNmZTJ1WXQxWWQ0V2FW?=
 =?iso-2022-jp?B?RHNOT1l6b3hoU0hEOXMrYllWY0dVNmZGSXZ3bFBlTHNVc0cyZWRzeUpt?=
 =?iso-2022-jp?B?dlp3d21XUlpFZk0zWHRkVXZ1MW43RlViUGxmdllsYmJ4ZFVCbVBnZ0FE?=
 =?iso-2022-jp?B?cWZOVXJ6UFRvYWFvbnJpYmJ2OGx2R2xVbTd2V2tuZUptb3U2RnRDdi9Z?=
 =?iso-2022-jp?B?L2RNRXBBalUwenI1VkhyVWpNM1RCQVk3NHdWQWtnbm1DelhQRGFCMmR4?=
 =?iso-2022-jp?B?aGprdEpMRDYwQUhXcHQ4SnI2Y0xmZUhSUlppVTlsUHlzZFZTcGtob2oz?=
 =?iso-2022-jp?B?aGxlM0N5dlBkb1E2V3JNd3JTOXlQeXBGWVVlaytSYmFUeXJPbDBUaloz?=
 =?iso-2022-jp?B?VU1VYlJITjlkQVQzRk1kZWorV2d4YlV5N1JhSUkzbUFiQkVJMEkvclVw?=
 =?iso-2022-jp?B?ejNPVG83VU44dDlybUJMMjdKekFTNUk5cCs0Qk1PNTlta1dXY0xmRFdQ?=
 =?iso-2022-jp?B?Mm9oQ0puOThZdzRQVHY5Yk5FTmJSS3FmUWJpR1kwM2dlTFVNYkk2M2Zk?=
 =?iso-2022-jp?B?QURtc2JDWDkxK1RuVlByaDVHRkpDVUJmTWp5eVNrYTZ5VHhhZjFIQVVP?=
 =?iso-2022-jp?B?MTNKVnYyTG40Y3JZV1ZqZXMzMzVsZHVjSW5jcGcvdW04WHdaUjNObXF5?=
 =?iso-2022-jp?B?dXRZVjkrUnIwTjM0SXNNVS9rdjBhdXlMSkR5WEpKbTk2RUQ0REpsSG9F?=
 =?iso-2022-jp?B?SGQxVS9kMEFheW5mWVRvQkdmWlFncmU0ZHlmN1Z4azhhdk1wSG9pRjRn?=
 =?iso-2022-jp?B?SEdqY2ZSZEpWTElha0hLYXZDazF3Y1N6Tld1SWM0WUVlcU1xM0ZJT2Vr?=
 =?iso-2022-jp?B?NXVnVWZUYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ET10u4mUwo+iI+ChuUvrPQ33ehumexKzlca87qR4iapRVswZJMBewoizWFUXQUV3ksMMOjF95/yOggKAUC3wz41B5f41szBnBGnyECWVz3USrIws36FCw5rWsrH3Gy2Z+5I94GL46EvqGb+CUqThemVOxwiJpDCMo5b+HQAjcTaUbhRNJgv5GqUGgad2ds1uiCiZDOa48tB28NGoQedB0z9CFLLLPUxB1QNS1pDvAcNoX7Jb11ANagU6uiOTN51XylwJwCPTK4rLXOfJtM+WXMcPBekC1YNi9UBzD7OfE+zjjIS5vREikYdhbk9MoXTvAxRGObpb+5wmcfZPWvkDGw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e782bf4-fe67-4027-ac71-08df2a741b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 04:23:47.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMo6iAi/CsJfn0zqbS7bDc3bEwJ2kKIOVoywDv2OO5ixzBFbJAkrv+u0nGGsez65nGvvCIzp9VYrNuEyv0RpYeP9YuDwGcghO2nKxCqRK61scGrbHEn0/sw4Lk19P+zP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17290
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 04:24:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24469

Hi all,

CIP kernel team has released Linux kernel v6.1.189-cip61.
The linux-6.1.y-cip tree has been updated base version from v6.1.187 to v6.=
1.189.
In this release, we added missing iommus and DMA support, enabled the RTC w=
ith
its nodes and drivers, and updated pinctrl and mmc features for Renesas ARM=
64 SoCs.

Information about this release is as follows:

  v6.1.189-cip61:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      ae2e5e1c152300e768185f2cb1dc6725eebb186c
    fixed CVEs:
      CVE-2023-52676: bpf: Guard stack limits against 32bit overflow
      CVE-2024-35887: ax25: fix use-after-free bugs caused by ax25_ds_del_t=
imer
      CVE-2024-50017: x86/mm/ident_map: Use gbpages only where full GB page=
 should be mapped.
      CVE-2024-50029: Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sy=
nc
      CVE-2024-56639: net: hsr: must allocate more bytes for RedBox support
      CVE-2024-58097: wifi: ath11k: fix RCU stall while reaping monitor des=
tination ring
      CVE-2025-21649: net: hns3: fix kernel crash when 1588 is sent on HIP0=
8 devices
      CVE-2025-21651: net: hns3: don't auto enable misc vector
      CVE-2025-22039: ksmbd: fix overflow in dacloffset bounds check
      CVE-2025-22103: net: fix NULL pointer dereference in l3mdev_l3_rcv
      CVE-2025-23129: wifi: ath11k: Clear affinity hint before calling ath1=
1k_pcic_free_irq() in error path
      CVE-2025-37833: net/niu: Niu requires MSIX ENTRY_DATA fields touch be=
fore entry reads
      CVE-2025-38266: pinctrl: mediatek: eint: Fix invalid pointer derefere=
nce for v1 platforms
      CVE-2026-100070: netfilter: nf_nat_sip: rewind offset when NAT shrink=
s the packet
      CVE-2026-100071: net: hsr: free learned nodes on device setup failure
      CVE-2026-100075: RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters
      CVE-2026-100078: wifi: iwlwifi: mei: pass correct argument to functio=
n
      CVE-2026-23191: ALSA: aloop: Fix racy access at PCM trigger
      CVE-2026-23447: net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bou=
nds check
      CVE-2026-23448: net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bou=
nds check
      CVE-2026-31420: bridge: mrp: reject zero test interval to avoid OOM p=
anic
      CVE-2026-43088: net: af_key: zero aligned sockaddr tail in PF_KEY exp=
orts
      CVE-2026-43198: tcp: fix potential race in tcp_v6_syn_recv_sock()
      CVE-2026-43288: ext4: move ext4_percpu_param_init() before ext4_mb_in=
it()
      CVE-2026-45897: netfilter: nft_counter: serialize reset with spinlock
      CVE-2026-46090: ALSA: aloop: Fix peer runtime UAF during format-chang=
e stop
      CVE-2026-52944: ksmbd: fix FSCTL permission bypass by adding a permis=
sion check for FSCTL_SET_SPARSE
      CVE-2026-53078: bpf: Fix same-register dst/src OOB read and pointer l=
eak in sock_ops
      CVE-2026-53098: wifi: mt76: mt7915: fix use-after-free bugs in mt7915=
_mac_dump_work()
      CVE-2026-64210: net/mlx5e: xsk: Fix unlocked writing to ICOSQ
      CVE-2026-64321: nvme: target: rdma: fix ndev refcount leak on queue c=
onnect
      CVE-2026-72131: nvme-apple: Prevent shared tags across queues on Appl=
e A11
      CVE-2026-74268: tcp: clear sock_ops cb flags before force-closing a c=
hild socket
      CVE-2026-74334: RDMA/nldev: Fix locking when accessing mr->pd
      CVE-2026-74474: vxlan: use pskb_network_may_pull() for transmit path =
header pulls
      CVE-2026-74565: netfilter: nf_tables: make nft_object rhltable per ta=
ble
      CVE-2026-80671: perf sched: Fix register_pid() overflow, strcpy, and =
BUG_ON
      CVE-2026-80689: tracing/mmiotrace: Add NULL check for mmio_trace_arra=
y in logging functions
      CVE-2026-80912: selinux: reject an unclaimed class value in security_=
get_classes()
      CVE-2026-80914: Bluetooth: ISO: fix use-after-free of listener socket=
 in iso_conn_ready
      CVE-2026-80928: smack: fix cred UAF in smack_file_send_sigiotask()
      CVE-2026-80930: tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
      CVE-2026-80931: w1: ds28e17: reject an oversize length on an I2C bloc=
k read
      CVE-2026-80932: vsock/virtio: flush works in dependency order
      CVE-2026-80938: wifi: mt76: mt7615: avoid waiting for mac work under =
the mt76 mutex
      CVE-2026-80941: wifi: rtw88: Fix potential memory leak in rtw_txq_pus=
h_skb()
      CVE-2026-80944: wifi: mwifiex: Detach sync cmd buffer on interrupted =
wait
      CVE-2026-80949: wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_co=
ntrol()
      CVE-2026-80951: i3c: master: svc: bound IBI payload to the requested =
max_payload_len
      CVE-2026-80952: i3c: master: Fix info leak and UAF in device unregist=
er path
      CVE-2026-80963: dm-stats: fix a crash if allocation of per-cpu data f=
ails
      CVE-2026-80964: ALSA: virmidi: Check card index validity at probe
      CVE-2026-80965: ALSA: serial-u16550: Check card index validity at pro=
be
      CVE-2026-80966: ALSA: portman2x4: Check card index validity at probe
      CVE-2026-80967: ALSA: pcxhr: initialize mutexes before requesting thr=
eaded IRQ
      CVE-2026-80968: ALSA: mts64: Check card index validity at probe
      CVE-2026-80969: ALSA: mpu401: Check card index validity at probe
      CVE-2026-80971: ALSA: bcd2000: clear the URB pointers on disconnect
      CVE-2026-80972: ALSA: aloop: Check card index validity at probe
      CVE-2026-80973: ALSA: 6fire: bound the MIDI event length from the dev=
ice
      CVE-2026-80976: seg6: reset IP6CB after IPv6 decapsulation
      CVE-2026-80977: net: skbuff: don't touch shared zerocopy state in skb=
_tx_error()
      CVE-2026-80978: net: cap advertised IP tunnel headroom
      CVE-2026-80982: net/smc: fix use-after-free in smc_rx_pipe_buf_releas=
e()
      CVE-2026-80983: net/smc: fix socket refcount leak in smc_switch_conns=
()
      CVE-2026-80987: NTB: ntb_transport: Reject oversized TX buffers
      CVE-2026-80988: NTB: ntb_transport: Fail TX enqueue when the QP link =
is down
      CVE-2026-80992: net: ravb: avoid dereferencing an invalid PTP clock
      CVE-2026-80994: net: openvswitch: fix flow mask use-after-free on flo=
w deletion
      CVE-2026-81000: net: tun: bound receive headroom
      CVE-2026-81001: slip: fix use-after-free in sl_sync()
      CVE-2026-81002: xdp: fix zero-copy frame layout
      CVE-2026-81003: net/iucv: filter frames in afiucv_hs_rcv() by ingress=
 device
      CVE-2026-81005: ipmi: si: Fix NULL pointer dereference after failed r=
egistration
      CVE-2026-81007: ipmi: ipmb: validate write message length
      CVE-2026-81008: interconnect: Fix use after free in icc_get() and of_=
icc_get_by_index()
      CVE-2026-81017: platform/chrome: sensorhub: Bound the EC-reported sen=
sor number
      CVE-2026-89440: mmc: via-sdmmc: stop card-detect handling on probe fa=
ilure
      CVE-2026-89444: platform/x86: dell-wmi-sysman: Don't hex dump attribu=
te security buffer
      CVE-2026-89456: s390/dasd: Propagate partial completion length across=
 ERP recovery
      CVE-2026-89457: s390/dasd: Guard sysfs discipline callbacks against u=
nallocated private data
      CVE-2026-89458: s390/dasd: Do not complete a failed ESE read as succe=
ssful
      CVE-2026-89461: power: supply: max17040: synchronize work cancellatio=
n on suspend
      CVE-2026-89463: power: supply: ucs1002: fix use-after-free on remove
      CVE-2026-89464: power: supply: twl4030_charger: cancel workers via de=
vm
      CVE-2026-89469: power: supply: lp8727: fix use-after-free in lp8727_r=
elease_irq()
      CVE-2026-89470: power: supply: cros_usbpd: Limit port counts to EC_US=
B_PD_MAX_PORTS
      CVE-2026-89471: power: supply: cros_usbpd-charger: bound the EC-repor=
ted port count
      CVE-2026-89474: power: supply: bq256xx: drain usb_work before freeing=
 the charger
      CVE-2026-89475: power: supply: bq24257: fix use-after-free on remove
      CVE-2026-89476: sctp: fix stream->outcnt underflow on duplicate RECON=
F responses
      CVE-2026-89477: sctp: fix NULL deref on untransmitted RECONF completi=
on
      CVE-2026-89478: sctp: drop a chunk if its transport was removed
      CVE-2026-89479: sctp: stop processing a packet once its association i=
s deleted
      CVE-2026-89480: nvme-tcp: reject a read that transferred too few byte=
s
      CVE-2026-89481: nvme-tcp: fix host memory disclosure on R2T for a rea=
d command
      CVE-2026-89482: nvme-tcp: do not accept C2HData based on blk_rq_paylo=
ad_bytes() alone
      CVE-2026-89483: nvme: zero the discard fallback page
      CVE-2026-89485: lockd: pin next file across nlm_inspect_file lock-dro=
p
      CVE-2026-89487: openvswitch: only skb_tx_error() a packet we are abou=
t to drop
      CVE-2026-89488: openvswitch: Fix CT limit teardown use-after-free
      CVE-2026-89489: openrisc: fix arbitrary kernel memory access via or1k=
_atomic syscall
      CVE-2026-89490: ocfs2: fix readdir position truncation on 32-bit kern=
els
      CVE-2026-89491: ocfs2: cluster: don't sleep while holding o2hb_live_l=
ock in o2hb_region_pin()
      CVE-2026-89493: ocfs2: validate rl_used against rl_count in refcount =
block validator
      CVE-2026-89494: ocfs2: validate lengths in dlm_mig_lockres_handler
      CVE-2026-89495: ocfs2: bound namelen in dlm_migrate_request_handler
      CVE-2026-89496: ocfs2: always run deallocs on copy-on-write completio=
n
      CVE-2026-89497: orangefs: skip leading spaces before parsing client d=
ebug masks
      CVE-2026-89498: orangefs: fix double-free of trailer_buf on readdir c=
opy failure
      CVE-2026-89504: regulator: as3722_get_regulator_dt_data: fix prematur=
e of_node_put leaving dangling of_node pointer
      CVE-2026-89508: RDMA/ucma: Lock the handler in ucma_set_ib_path()
      CVE-2026-89510: RDMA/cxgb4: Cancel reg_work before freeing device on =
remove
      CVE-2026-89511: qede: Fix NULL pointer dereference in TPA fragment pr=
ocessing
      CVE-2026-89512: remoteproc: scp: Fix device reference leak on failed =
lookup
      CVE-2026-89515: scsi: core: Fill in DMA padding bytes in scsi_alloc_s=
gtables()
      CVE-2026-89524: wifi: ath6kl: clamp assoc request/response lengths be=
fore subtracting IE offsets
      CVE-2026-89525: udf: reject VAT indexes equal to the entry count
      CVE-2026-89532: svcrdma: Fix pcl_for_each_segment for empty chunks
      CVE-2026-89533: svcrdma: Fix offset arithmetic in read_chunk_range
      CVE-2026-89538: SUNRPC: Reject krb5 v2 wrap tokens with oversized ec =
field
      CVE-2026-89540: sunrpc: init gssp_lock before publishing proc entry
      CVE-2026-89541: SUNRPC: harden gss_unwrap_resp_priv length checks
      CVE-2026-89542: SUNRPC: harden gss_krb5_unwrap_v2 against short token=
s
      CVE-2026-89548: SUNRPC: always drain cache_cleaner before destroying =
a cache_detail
      CVE-2026-89549: sunrpc: route to a populated pool in svc_pool_for_cpu=
()
      CVE-2026-89551: SUNRPC: xdr_buf_trim: clamp buf->len to avoid underfl=
ow
      CVE-2026-89554: mptcp: fix uninitialized local_id in syncookie MP_JOI=
N reconstruction
      CVE-2026-89555: mpls: reload header after pskb_may_pull()
      CVE-2026-89557: md: do overflow check for sb->bblog_shift in super_1_=
load()
      CVE-2026-89559: libnvdimm/labels: Prevent integer overflow in __nd_la=
bel_validate()
      CVE-2026-89560: landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whi=
teout creation
      CVE-2026-89562: ip6_gre: fix hardware header length for NBMA tunnels
      CVE-2026-89563: ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
      CVE-2026-89565: ipip: fix skb leak in collect_md mode when metadata_d=
st allocation fails
      CVE-2026-89569: Bluetooth: RFCOMM: serialize security confirmation ha=
ndling
      CVE-2026-89573: dm array: reject an array block whose value size is n=
ot the caller's
      CVE-2026-89575: dm raid1: reserve space for NUL-terminator in build_c=
onstructor_string()
      CVE-2026-89576: dm-era: fix shadowed superblock leak on take-snap fai=
lure
      CVE-2026-89579: bpf: Harden bloom filter sizing and indexing on 32-bi=
t kernels
      CVE-2026-89582: bnx2x: fix double free in bnx2x_init_firmware() error=
 path
      CVE-2026-89583: Bluetooth: eir: Fix OOB read in eir_get_service_data(=
)
      CVE-2026-89585: auxdisplay: charlcd: cancel backlight work on registr=
ation failure
      CVE-2026-89586: ata: libata-scsi: fix DSM TRIM for sector sizes large=
r than 2048 bytes
      CVE-2026-89587: ACPI: pfr_update: fix stack buffer overflow in query_=
capability()
      CVE-2026-89594: hsi: omap_ssi_core: fix missing DMA mask setup for SS=
I controller device
      CVE-2026-89595: fsnotify: Fix stale object mask after concurrent mark=
 updates
      CVE-2026-89596: forcedeth: fix off-by-one when saving/restoring non-P=
CI config space
      CVE-2026-89597: fbdev: uvesafb: unregister connector callback on init=
 failure
      CVE-2026-89599: fbdev: omapfb: panel-dsi-cm: initialize lock before r=
egistering display
      CVE-2026-89603: entry: Fix seccomp bypass after ptrace with TSYNC
      CVE-2026-89604: efivarfs: Rate limit statfs() handler
      CVE-2026-89605: ecryptfs: release message context on send failure
      CVE-2026-89606: ecryptfs: reject too-small tag 70 packets
      CVE-2026-89607: ecryptfs: reject oversized encrypted_key_size in pars=
e_tag_3_packet
      CVE-2026-89608: ecryptfs: pass packet set buffer size to parser
      CVE-2026-89609: ecryptfs: hold msg ctx list lock when cleaning daemon=
 queue
      CVE-2026-89615: fs/ntfs3: bound page_lcns[] index by the log record
      CVE-2026-89616: fs/ntfs3: fix info-leak on partial LZNT decompress in=
 ni_read_frame()
      CVE-2026-89617: fs/ntfs3: validate dirty page table on log replay
      CVE-2026-89621: HID: mcp2221: validate report size in mcp2221_raw_eve=
nt()
      CVE-2026-89626: HID: sensor: custom: Fix field sysfs group cleanup on=
 failure
      CVE-2026-89627: HID: roccat: free buffered reports when destroying de=
vice
      CVE-2026-89628: HID: picolcd: clamp eeprom debugfs read to bytes actu=
ally received
      CVE-2026-89634: smb: client: fix ALIGN() overflow in symlink_data() e=
rror context loop
      CVE-2026-89636: smb: client: clear ce->tgthint in free_tgts()
      CVE-2026-89640: cifs: fix loff_t underflow in cifs_remap_file_range()=
 when len =3D=3D 0
      CVE-2026-89643: audit: avoid dropping live tree ref on fsnotify rule =
autoremove
      CVE-2026-89649: ceph: bound xattr value length in __build_xattrs()
      CVE-2026-89650: ceph: bound num_export_targets array for mds info v2/=
v3
      CVE-2026-89653: ceph: reject export_targets ranks >=3D CEPH_MAX_MDS i=
n mdsmap decode
      CVE-2026-89655: ceph: fix UAF in __kick_flushing_caps() on cf entry f=
reed during unlock
      CVE-2026-89656: libceph: reject buckets with mismatched CRUSH ids
      CVE-2026-89662: NFSD: Prevent lock owner use-after-free during client=
 teardown
      CVE-2026-89663: nfsd: revoke copy-notify stateids before dropping the=
ir reference
      CVE-2026-89665: nfsd: reject out-of-range useconds in NFSv2 SETATTR/C=
REATE
      CVE-2026-89669: nfsd: initialize copy-notify stateid before publishin=
g it
      CVE-2026-89673: nfsd: fix XDR padding calculation in ff_encode_getdev=
iceinfo
      CVE-2026-89674: nfsd: fix XDR length calculation in nfsd4_ff_encode_l=
ayoutget
      CVE-2026-89684: nfsd: fix cpntf publish race in nfs4_init_cp_state
      CVE-2026-89694: nfsd: check client ownership when cancelling a copy-n=
otify stateid
      CVE-2026-89696: nfsd: block non-SAVEFH ops after FOREIGN PUTFH to pre=
vent NULL deref
      CVE-2026-89697: nfsd: add fh_want_write() for early-verified SETATTR =
in nfsd_proc_setattr()
      CVE-2026-89699: nfsd: validate symlink target length in NFSv4 CREATE
      CVE-2026-89704: nfsd: sample writeback error cursor before async COPY=
 loop
      CVE-2026-89706: nfsd: Reset write verifier when async COPY writeback =
fails
      CVE-2026-89710: NFSv4.1: fix layout segment leak on the pnfs_layout_p=
rocess() forget path
      CVE-2026-89711: NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check
      CVE-2026-89712: NFSD: restart ssc_expire_umount walk after dropping n=
fsd_ssc_lock
      CVE-2026-89720: ubifs: fix out-of-bounds read in signature length che=
ck
      CVE-2026-89723: nilfs2: fix slab-out-of-bounds in nilfs_direct_propag=
ate after truncation
      CVE-2026-89724: media: vicodec: fix out-of-bounds write in FWHT encod=
er
      CVE-2026-89725: media: cec: stm32: prevent out-of-bounds write on RX =
overflow
      CVE-2026-89726: lib/ucs2_string.c: fix out-of-bounds read in ucs2_str=
nlen()
      CVE-2026-89729: HID: sensor-hub: Fix out-of-bounds write in sensor_hu=
b_get_feature
      CVE-2026-89730: fpga: altera-cvp: Avoid out-of-bounds read in trailin=
g byte write
      CVE-2026-89732: usb: gadget: f_fs: Prevent deadlock during ep0 read l=
oop
      CVE-2026-89733: usb: gadget: uvc: fix dangling pointers in uvc_functi=
on_bind() and uvc_function_unbind()
      CVE-2026-89736: usb: gadget: u_audio: Fix use-after-free on sound car=
d disconnect
      CVE-2026-89741: Revert "media: v4l2-dev: fix error handling in __vide=
o_register_device()"
      CVE-2026-89742: rapidio: mport_cdev: fix use-after-free in dma_req_fr=
ee()
      CVE-2026-89744: device property: fix infinite loop in fwnode_for_each=
_child_node()
      CVE-2026-89746: tracing: Fix use-after-free with same-name named trig=
gers
      CVE-2026-89749: tracing: Fix crash passing ERR_PTR to kthread_stop()
      CVE-2026-89751: x86/tdx: Fix off-by-one in port I/O handling
      CVE-2026-89752: mm: memcg: stop reclaim when a limit update is supers=
eded
      CVE-2026-89753: mm/vmscan: report RCU-tasks quiescent states in shrin=
k_lruvec()
      CVE-2026-89756: mm/migrate: report RCU-tasks quiescent states in migr=
ate_pages_batch()
      CVE-2026-89765: timers/itimer: Zero-init old itimerval before copy to=
 userspace
      CVE-2026-89776: vxlan: vnifilter: enforce exact length of GROUP/GROUP=
6 attributes
      CVE-2026-89777: vfio/pci: clear vdev->msi_perm after freeing it on in=
it failure
      CVE-2026-89778: isofs: fix out-of-bounds page array access on empty z=
isofs block
      CVE-2026-89779: fs/ntfs3: validate ef->size covers the record's name =
and value
      CVE-2026-89780: net: qualcomm: rmnet: restore skb->dev on deaggregate=
d frames
      CVE-2026-89781: fs/ntfs3: fix out-of-bounds read in read_log_rec_buf(=
)
      CVE-2026-89782: fs/ntfs3: reject restart table growth beyond U16_MAX =
entries
      CVE-2026-89783: xfrm6: fix out-of-bounds write in xfrm6_input_addr() =
when secpath is full
      CVE-2026-89784: SUNRPC: check rpc_sockaddr2uaddr() return value in rp=
cb_register_inet4/6
      CVE-2026-89785: fs/ntfs3: fix out-of-bounds read of INDEX_ROOT in rep=
arse/objid init
      CVE-2026-89786: ext4: fix out-of-bounds read in ext4_read_inline_dir(=
)
      CVE-2026-89787: ext4: check dir entry fits before reading the hash tr=
ailer in ext4_search_dir()
      CVE-2026-89789: gtp: add synchronize_net() in gtp_newlink() error pat=
h to prevent use-after-free
      CVE-2026-89816: drm: Fix drm_crtc_commit leak if signaled when PAGE_F=
LIP_EVENT is used
      CVE-2026-89817: drm/gud: NUL-terminate TV mode names read from the de=
vice
      CVE-2026-89818: drm/amdgpu/vcn: fix integer overflow in dec_msg buffe=
r count check
      CVE-2026-89821: drm/amd/display: avoid divide-by-zero in __is_lut_lin=
ear()
      CVE-2026-89822: drm/i915: Guard against NULL driver_data in i915_pci_=
probe()
      CVE-2026-89823: drm: fix race between partial drm_dev_register() fail=
ure and ioctl
      CVE-2026-89824: drm/panel-edp: fix i2c adapter leak on probe failure
      CVE-2026-89843: scsi: qla2xxx: Zero-init bsg stack buffers to avoid i=
nfo leak
      CVE-2026-89845: scsi: qla2xxx: Avoid req_q_map double-read in qla2x00=
_error_entry()
      CVE-2026-89846: scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-=
data read
      CVE-2026-89847: scsi: qla2xxx: Avoid double completion in async IOCB =
timeout
      CVE-2026-89849: scsi: qla2xxx: Reject non-SCSI SRB on status IOCB fas=
t path
      CVE-2026-89850: scsi: qla2xxx: Don't query firmware state while chip =
is down
      CVE-2026-89851: scsi: qla2xxx: Fix FCE trace enable parsing in debugf=
s
      CVE-2026-89852: scsi: qla2xxx: Zero mailbox struct in qla2x00_get_fir=
mware_state()
      CVE-2026-89853: scsi: qla2xxx: Fix FCE trace use-after-free during fi=
rmware dump
      CVE-2026-89854: scsi: qla2xxx: Fix cs84xx use-after-free on host tear=
down
      CVE-2026-89855: scsi: qla2xxx: Serialize flash version read in reset =
handler
      CVE-2026-89856: scsi: qla2xxx: Clamp MSI-X derived queue counts to av=
oid truncation
      CVE-2026-89858: scsi: qla2xxx: Bound image count in qla2x00_update_fr=
u_versions()
      CVE-2026-89861: scsi: qla2xxx: Hold vport reference in qla24xx_report=
_id_acquisition()
      CVE-2026-89863: scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA =
delete check
      CVE-2026-89864: scsi: qla2xxx: Bound i2c->length in I2C bsg handlers
      CVE-2026-89865: scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg han=
dlers
      CVE-2026-89870: media: zoran: Avoid freeing a registered video_device=
 twice
      CVE-2026-89871: media: video-i2c: fix kthread error pointer left in k=
thread_vid_cap on failure
      CVE-2026-89872: media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_pa=
rse_link
      CVE-2026-89876: media: tda18250: fix possible integer overflow
      CVE-2026-89877: media: saa7164: fix cleanup on resource allocation fa=
ilure
      CVE-2026-89878: media: s2255: check firmware size before reading trai=
ling marker
      CVE-2026-89879: media: s2255: bound JPEG frame size before copying in=
to the buffer
      CVE-2026-89880: media: rtl2832_sdr: release URBs and stream buffers o=
n start_streaming() failure
      CVE-2026-89881: media: rtl2832_sdr: use vb2_video_unregister_device()=
 on remove to fix DMA leak
      CVE-2026-89883: media: rc: sunxi-cir: Unregister rc device on probe f=
ailure
      CVE-2026-89887: media: i2c: ov7740: fix use-after-destroy in remove
      CVE-2026-89888: media: i2c: ov02a10: fix endpoint parsing use-after-f=
ree
      CVE-2026-89890: media: go7007: defer the ALSA v4l2 put until card rel=
ease
      CVE-2026-89891: media: em28xx: fix use-after-free of dev_next->devlis=
t on disconnect
      CVE-2026-89892: media: em28xx: defer audio-only extension registratio=
n
      CVE-2026-89893: media: cx23885: cancel NetUP CI work before teardown
      CVE-2026-89894: media: cx231xx: reject geometry changes while the VBI=
 queue is busy
      CVE-2026-89895: media: cobalt: Avoid freeing ALSA private data twice
      CVE-2026-89896: media: cedrus: fix memory leak in cedrus_init_ctrls()
      CVE-2026-89897: media: cec: Serialize exclusive follower delivery
      CVE-2026-89901: media: airspy: use vb2_video_unregister_device() on d=
isconnect to fix NULL deref
      CVE-2026-89922: KVM: s390: Take srcu when importing watchpoint data
      CVE-2026-89923: KVM: s390: Free guest debug data on vcpu destroy
      CVE-2026-89924: KVM: s390: Fix old_data leak in guest debug error pat=
h
      CVE-2026-89925: KVM: s390: Fix memory leak in guest debug handling
      CVE-2026-89926: KVM: s390: Fix length check __import_wp_info()
      CVE-2026-89927: KVM: x86: hyper-v: Clamp stimer deadline to avoid liv=
elock
      CVE-2026-89930: KVM: nVMX: Service local TLB flushes on failed nested=
 VM-Enter
      CVE-2026-89932: KVM: nVMX: Always flush vpid02 on first use
      CVE-2026-89936: iio: dac: m62332: Fix regulator reference count imbal=
ance
      CVE-2026-89937: iio: chemical: sgp30: Handle IAQ thread creation fail=
ure
      CVE-2026-89939: iio: chemical: atlas-sensor: fix PM reference leak in=
 buffer postenable
      CVE-2026-89945: ASoC: cs35l34: drain threaded IRQ before runtime susp=
end
      CVE-2026-89946: ASoC: cs35l33: drain threaded IRQ before runtime susp=
end
      CVE-2026-89947: clk: meson: align gxbb_32k_clk_sel number of parents =
with actual count
      CVE-2026-89948: batman-adv: bla: fix freeing of claims on meshif dele=
tion
      CVE-2026-89949: batman-adv: dat: avoid unaligned fault in IP extracti=
on
      CVE-2026-89951: batman-adv: fix stale receive device on merged fragme=
nts
      CVE-2026-89952: mtd: rawnand: validate ONFI extended parameter page s=
ections
      CVE-2026-89953: mtd: mtdoops: free page bitmap when the backing MTD i=
s removed
      CVE-2026-89954: mtd: afs: validate v2 image info bounds
      CVE-2026-89957: s390/vfio-ap: Fix hot-unplug skipped when last AP ada=
pter or domain removed
      CVE-2026-89959: s390/vfio-ap: Fix control domain removal in vfio_ap_m=
dev_cfg_remove
      CVE-2026-89964: parisc: eisa: Fix infinite loop when parsing invalid =
IRQ value
      CVE-2026-89965: nvdimm/btt: reject an arena whose nfree is below the =
lane count
      CVE-2026-89968: nvmet-tcp: reject unsolicited H2CData PDUs
      CVE-2026-89969: nvmet-tcp: fix out-of-bounds write when receiving an =
over-long PDU
      CVE-2026-89970: nvmet-auth: Synchronize timeout work during SQ teardo=
wn
      CVE-2026-89973: nvme-tcp: check the data direction of a C2HData PDU
      CVE-2026-89979: ALSA: pcm: Fix race between non-atomic ops and trigge=
r-start
      CVE-2026-89980: ALSA: harmony: initialize locks before requesting IRQ
      CVE-2026-89982: i2c: mux: Fix channel node leak on adapter add failur=
e
      CVE-2026-89983: i2c: core: fix debugfs UAF on adapter removal
      CVE-2026-89984: perf/x86/intel: Fix kernel address leakages in LBR st=
ack
      CVE-2026-89988: kprobes: Protect kprobe_blacklist with RCU
      CVE-2026-89989: ima: Check for ERR_PTR from dentry_path() in validate=
_hash_algo()
      CVE-2026-89992: cpuidle: dt_idle_genpd: kfree() the original name all=
ocation
      CVE-2026-89993: dmaengine: dw-edma: Initialize IRQ data before reques=
ting IRQs
      CVE-2026-89997: dm: fix resume-vs-remove race
      CVE-2026-89998: dm: fix race when loading and unloading a table
      CVE-2026-89999: HID: wacom: validate report length in wacom_intuos_pr=
o2_bt_irq
      CVE-2026-90000: HID: rmi: fix OOB access with undersized RMI reports
      CVE-2026-90003: futex: Prevent rcuwait use-after-free during requeue =
PI
      CVE-2026-90007: scsi: pm8001: Use rollback index when freeing MSI-X v=
ectors
      CVE-2026-90011: scsi: target: iscsi: Reserve a terminator byte for th=
e login payload
      CVE-2026-90015: xhci: fix lost bounce buffers on TDs spanning several=
 ring segments
      CVE-2026-90017: staging: rtl8723bs: fix OOB read in rtw_action_frame_=
parse()
      CVE-2026-90018: staging: rtl8723bs: fix OOB read / stack overflow in =
rtw_get_wps_attr()
      CVE-2026-90019: usb: gadget: fix null pointer dereference in usb_put_=
function_instance()
      CVE-2026-90020: USB: gadget: fix NULL pointer dereference in gadget_d=
ev_ioctl()
      CVE-2026-90025: usb: typec: ucsi: displayport: Fix OOB altmode array =
index
      CVE-2026-90031: usb-storage: ene_ub6250: fix race between scan work a=
nd probe
      CVE-2026-90032: media: usbtv: keep device alive while ALSA card exist=
s
      CVE-2026-90033: ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_=
output()
      CVE-2026-90034: usb: image: mdc800: change kmalloc() to kzalloc()
      CVE-2026-90049: net: skbuff: don't skb_tx_error() the source skb in s=
kb_zerocopy()
      CVE-2026-90053: net/sched: sch_htb: limit htb_classify inner-class fi=
lter hops
      CVE-2026-90054: tcp: fix corruption of urgent data on multi-segment r=
etransmit
      CVE-2026-90055: usb: atm: usbatm: fix invalid ci_range initialization
      CVE-2026-90056: net: fec: only stop PTP if it was initialized
      CVE-2026-90057: slip: remove slip_hangup() to fix use-after-free in s=
lip_receive_buf()
      CVE-2026-90058: net/sched: bound qdisc_pkt_len to prevent qdisc soft =
lockup
      CVE-2026-90060: ALSA: control: Don't add invalid kcontrols to LED lay=
er
      CVE-2026-90062: netfilter: nf_tables: move hardware offload step afte=
r building the chain blob
      CVE-2026-90063: virtio-net: Ensure that TCP packets don't overflow gs=
o_segs
      CVE-2026-90067: libceph: validate banner payload length
      CVE-2026-90068: ASoC: dapm: Fix off-by-one check on the second enum c=
hannel
      CVE-2026-90070: tpm: st33zp24: Return zero on status read failure
      CVE-2026-90071: net/sched: sch_teql: restore skb->dev on the slave fa=
ilure path
      CVE-2026-90072: net/sched: sfq: clamp quantum to avoid signed overflo=
w soft lockup
      CVE-2026-90073: net/sched: hhf: clamp quantum before hhf_change() to =
avoid overflow
      CVE-2026-90074: net/sched: fq_pie: clamp default quantum to avoid sig=
ned overflow
      CVE-2026-90075: net/sched: fq_codel: clamp default quantum and mtu
      CVE-2026-90078: net/sched: act_skbmod: fix length calculations and av=
oid invalid header warnings
      CVE-2026-90081: net/rds: use wq_has_sleeper() in rds_cong_map_updated=
()
      CVE-2026-90088: Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() =
to prevent infinite loop
      CVE-2026-90090: Bluetooth: btmtksdio: Fix out-of-bounds DMA read in t=
he TX path
      CVE-2026-90091: Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen(=
) vs. put_chan
      CVE-2026-90092: Bluetooth: L2CAP: reject accept queue add unless BT_L=
ISTEN
      CVE-2026-90102: NFSv4/pnfs: key the data server cache on the NFS vers=
ion
      CVE-2026-90103: NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      CVE-2026-90107: net/smc: free pending qentry in smc_llc_flow_stop() b=
efore memset
      CVE-2026-90108: net/smc: free stashed qentry before overwrite in REQ_=
ADD_LINK to ADD_LINK transition
      CVE-2026-90110: inetpeer: randomize RB-tree node comparison using Sip=
Hash
      CVE-2026-90114: net: bridge: Reject descending VLAN tunnel ranges
      CVE-2026-90122: clk: visconti: Make sure clk_init_data is fully initi=
alized
      CVE-2026-90124: irqchip/renesas-rzg2l: Fix loss of interrupt
      CVE-2026-90126: rtc: pcf8563: fix clock provider leak on unbind
      CVE-2026-90128: vdpa/mlx5: fix wrong list iterated in add_direct_chai=
n error path
      CVE-2026-90140: cuse: wait for pending RCU callbacks on module exit
      CVE-2026-90141: ipvs: fix integer overflow in ftp helper port/address=
 parsing
      CVE-2026-90143: net: kcm: Hold RCU read lock while running BPF parser
      CVE-2026-90151: NFSv4: remove callback IDR entry on client allocation=
 failure
      CVE-2026-90157: bpf: Reject negative optlen in cgroup getsockopt hook
      CVE-2026-90160: lwt_bpf: Restore reserved headroom after xmit program
      CVE-2026-90176: ksmbd: Do not skip lock checks for single-byte ranges
      CVE-2026-90180: block: mtip32xx: synchronize ioctls with device remov=
al
      CVE-2026-90184: null_blk: serialize configfs attribute updates with d=
evice setup
      CVE-2026-90185: null_blk: serialize configfs attribute stores with th=
e lock
      CVE-2026-90186: null_blk: reject per-device queue resize for shared t=
ag set
      CVE-2026-90188: null_blk: free global tag_set on init error path
      CVE-2026-90189: null_blk: register configfs subsystem after creating =
default devices
      CVE-2026-90190: null_blk: use DEFINE_MUTEX for the file-scope mutex
      CVE-2026-90194: ACPI: scan: fix bus ID cleanup on device_add() failur=
es
      CVE-2026-90196: ASoC: SOF: validate topology volume range before allo=
cation
      CVE-2026-90198: ALSA: core: Fix use-after-free in snd_card_do_free()
      CVE-2026-90202: scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buf=
fers
      CVE-2026-90203: Squashfs: check block offset is not negative
      CVE-2026-90207: ALSA: seq: midi: Serialize input teardown with event_=
input
      CVE-2026-90209: s390/debug: Fix deadlock during unregister
      CVE-2026-90214: ASoC: xilinx: formatter_pcm: fix stream_data leak on =
open error
      CVE-2026-90216: ubi: Fix rollback for explicit UBI device numbers
      CVE-2026-90218: RDMA/cma: Fix WARNING in res_to_rt
      CVE-2026-90219: RDMA/cxgb4: Free debugfs on registration failure
      CVE-2026-90221: nfc: nci: fix use of uninitialized memory in CORE_INI=
T_RSP parsing
      CVE-2026-90222: nfc: pn533: hold a reference to the request skb durin=
g send_frame
      CVE-2026-90223: nfc: llcp: bound SNL TLV parsing to the skb and add l=
ength checks
      CVE-2026-90224: nfc: nci: fix double completion race in nci_data_exch=
ange_complete
      CVE-2026-90225: nfc: llcp: read llcp_sock->local under the socket loc=
k in getsockopt
      CVE-2026-90226: nfc: llcp: avoid userspace overflow on invalid optlen
      CVE-2026-90228: nvmet: fix NULL pointer dereference in nvmet_execute_=
identify_ns_zns()
      CVE-2026-90245: fbdev: kyro: Validate overlay viewport coordinates
      CVE-2026-90248: net/sched: cls_api: fix teardown of an adopted proto =
on insert-race loss
      CVE-2026-90249: iio: light: gp2ap002: Fix unbalanced runtime PM on re=
peated event writes
      CVE-2026-90251: Bluetooth: MSFT: validate evt_prefix_len against the =
response length
      CVE-2026-90253: Bluetooth: MGMT: free the mesh send cancel command wh=
en it is cancelled
      CVE-2026-90254: Bluetooth: hci_sync: free the advertising instance on=
 the failure and cancel paths
      CVE-2026-90255: Bluetooth: hci_conn: fix the SCO setup context lifeti=
me
      CVE-2026-90257: Bluetooth: virtio_bt: avoid OOB read of build info st=
ring
      CVE-2026-90274: coresight: etm4x: fix underflow for usage of (nrseqst=
ate - 1)
      CVE-2026-90281: phy: qcom: snps-femto-v2: Fix possible NULL-deref on =
early runtime suspend
      CVE-2026-90283: hugetlbfs: release subpool on fill_super failure
      CVE-2026-90284: firmware_loader: do not queue completed sysfs fallbac=
k requests
      CVE-2026-90285: scsi: qla2xxx: Remove redundant VPD flash read in sys=
fs read path
      CVE-2026-90286: drm/amdgpu/gfx6: Use PFP on the compute queues too
      CVE-2026-90287: phy: sunplus: fix error handling in sp_uphy_init()
      CVE-2026-90290: arm64: hibernate: Restore DAIF state on error
      CVE-2026-90292: RDMA/siw: Fix use-after-free in siw_accept()
      CVE-2026-90293: IB/isert: post the full-feature receive buffers after=
 session registration
      CVE-2026-90294: IB/isert: delay the final Login Response until the se=
ssion is registered
      CVE-2026-90295: cpufreq: imx6q: fix out-of-bounds write when probed m=
ore than once
      CVE-2026-90296: cpufreq: imx6q: fix devres accumulation across driver=
 rebind
      CVE-2026-90297: drm/sun4i: crtc: Propagate layer initialization error
      CVE-2026-90298: drm/sun4i: tcon: Drop TCON TOP device reference
      CVE-2026-90302: ocfs2: synchronize heartbeat callbacks with o2net tea=
rdown
      CVE-2026-90303: ARM: 9485/1: mm: acquire mmap write lock around show_=
pte() for user faults
      CVE-2026-90307: RDMA/srp: fix heap information leak on a truncated SR=
P_CRED_REQ
      CVE-2026-90309: RDMA/erdma: Hold CQ references when processing EQ eve=
nts
      CVE-2026-90314: remoteproc: fix OOB read via signed offset in rsc_tab=
le_for_each_entry()
      CVE-2026-90316: drm/omap: dsi: Do not copy isr table
      CVE-2026-90318: fat: release buffer head after rebuilding parent
      CVE-2026-90319: rapidio: clear mport->net when rio_add_net() fails
      CVE-2026-90325: blk-cgroup: skip dying blkg in blkcg_activate_policy(=
)
      CVE-2026-90327: phonet: pep: do not write beyond optlen in getsockopt
      CVE-2026-90329: HID: synchronize input before cleaning up a failed pr=
obe
      CVE-2026-90334: tty: clear cdev pointer after cdev_add() failure
      CVE-2026-90341: firmware: coreboot: Validate table bounds
      CVE-2026-90348: wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdu=
mp
      CVE-2026-90352: wifi: mt76: mt7915: release hif2 reference on probe I=
RQ failure
      CVE-2026-90353: wifi: mt76: mt7915: fix ext PHY use-after-free on reg=
ister error path
      CVE-2026-90354: wifi: mt76: mt7915: fix double hif2 init on the non-W=
ED path
      CVE-2026-90357: wifi: mt76: mt7915: unlink TWT flow if the MCU reject=
s the agreement
      CVE-2026-90360: regulator: core: use system_freezable_wq for init com=
plete work
      CVE-2026-90361: wifi: ath11k: fix leak in ath11k_service_ready_ext_ev=
ent()
      CVE-2026-90362: drm/msm/dsi: Drop dev_pm_opp_set_rate(0)
      CVE-2026-90372: wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu=
_get_sta_nss
      CVE-2026-90378: wifi: mt76: mt792x: Fix memory leak in SDIO TX path
      CVE-2026-90382: wifi: mt76: mt76x02: do not WARN on invalid rx descri=
ptor length
      CVE-2026-90386: i3c: dw: avoid shift-out-of-bounds when DAA assigns n=
o devices
      CVE-2026-90388: iommu/dma: Check atomic pool allocation result direct=
ly
      CVE-2026-90391: lib/test_hmm: fail dmirror_fault() when the mirrored =
mm is gone
      CVE-2026-90393: bpf: Fix potential UAF in bpf_netns_link_update_prog
      CVE-2026-90394: power: supply: sc2731_charger: cancel work on remove
      CVE-2026-90395: power: supply: isp1704_charger: cancel work on remove
      CVE-2026-90403: wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      CVE-2026-90411: nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure i=
n init_request
      CVE-2026-90413: IB/isert: reject login PDUs declaring more data than =
was received
      CVE-2026-90414: IB/isert: reject PDUs declaring more data than was re=
ceived
      CVE-2026-90415: RDMA/cxgb4: free STAG index when TPT entry write fail=
s
      CVE-2026-90416: RDMA/mlx5: Fix stack out-of-bounds read in cc_params =
debugfs
      CVE-2026-90419: nilfs2: prevent out-of-bounds read in super root bloc=
k parsing
      CVE-2026-90420: nilfs2: fix infinite loop in nilfs_clean_segments()
      CVE-2026-90431: remoteproc: Prevent crash handling to race with rproc=
_del()
      CVE-2026-90434: isofs: release zisofs block pointer buffer head
      CVE-2026-90435: RDMA/mlx5: Fix integer overflow of user QP buffer siz=
e
      CVE-2026-92476: crypto: keembay - Initialize completion before reques=
ting IRQ
      CVE-2026-92477: scsi: ufs: debugfs: Reserve space for a string termin=
ator
      CVE-2026-92481: pinctrl: mediatek: free EINT resources on unbind
      CVE-2026-92494: ext4: fix buffer_head leak in ext4_init_orphan_info
      CVE-2026-92496: wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv=
_op_rx()
      CVE-2026-92498: wifi: ath6kl: avoid buffer overreads in WMI event han=
dlers
      CVE-2026-92501: ext4: drain in-flight DIO before buffered write fallb=
ack
      CVE-2026-92504: thermal: intel: int3400: clean up ODVP on probe failu=
res
      CVE-2026-92507: RDMA/core: Fix potential use after free in ib_dealloc=
_pd_user()
      CVE-2026-92508: RDMA/core: Fix potential use after free in ib_free_cq=
()
      CVE-2026-92509: RDMA/core: Fix potential use after free in counter_re=
lease()
      CVE-2026-92510: RDMA/core: Fix potential use after free in ib_destroy=
_srq_user()
      CVE-2026-92511: RDMA/core: Fix potential use after free in ib_destroy=
_cq_user()
      CVE-2026-92512: RDMA/core: Fix use after free in ib_query_qp()
      CVE-2026-92514: RDMA/erdma: Fix CEQ tasklet use-after-free on removal
      CVE-2026-92521: ACPI: PCI: Clear driver_data on all paths that free t=
he acpi_pci_root
      CVE-2026-92522: ACPI: processor: validate MADT IOAPIC entry bounds
      CVE-2026-92523: RDMA/nldev: validate dynamic counter attribute length
      CVE-2026-92524: irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domai=
n_alloc()
      CVE-2026-92525: RDMA/rxe: Validate num_sge/cur_sge before indexing wq=
e->dma.sge[]
      CVE-2026-93037: RDMA/hfi1: Propagate sdma_txinit_ahg() errors
      CVE-2026-93039: ASoC: meson: Keep link pointers valid on realloc fail=
ure
      CVE-2026-93040: dmaengine: dw-edma: Serialize channel state checks
      CVE-2026-93041: dmaengine: dw-edma: Serialize abort state updates
      CVE-2026-93046: software node: Fix software_node_get_reference_args()=
 with index -1
      CVE-2026-93048: mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_parti=
tion()
      CVE-2026-93049: mtd: mtdswap: Avoid freeing registered blktrans devic=
e twice
      CVE-2026-93050: ipack: ipoctal: fix UAF, null-ptr-deref, and use-afte=
r-free in cleanup on remove
      CVE-2026-93051: misc: ad525x_dpot: use driver core groups for sysfs f=
iles
      CVE-2026-93052: misc: bcm-vk: Use acquire/release for msgq_inited
      CVE-2026-93053: speakup: keyhelp: guard letter_offsets possible out-o=
f-range indexing
      CVE-2026-93054: uio: Fix stale info pointer in failed registration pa=
th
      CVE-2026-93055: UDF symlink pathComponent header OOB read
      CVE-2026-93056: usb: gadget: f_uac1_legacy: remove broken string conf=
igfs attributes
      CVE-2026-93061: gpu: host1x: Avoid stack over-read in debug output he=
lpers
      CVE-2026-93063: wifi: iwlwifi: mei: check SAP message length before r=
eading it
      CVE-2026-93064: wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitis=
er
      CVE-2026-93067: drm/bridge: tc358767: clamp the reported AUX read siz=
e to the request
      CVE-2026-93073: dax: read holder_ops once in dax_holder_notify_failur=
e()
      CVE-2026-93095: hfsplus: validate thread record before delete key reb=
uild
      CVE-2026-93098: rpmsg: glink: fix deadlock in endpoint destroy during=
 driver detach
      CVE-2026-93102: RDMA/hfi1: Free RX data on late probe failure
      CVE-2026-93103: RDMA/hfi1: Preserve unit 0 on allocation failure
      CVE-2026-93108: RDMA/ipoib: Drain RCU callbacks during module teardow=
n
      CVE-2026-93109: RDMA/mlx5: Drain RCU callbacks during module teardown
      CVE-2026-93110: RDMA/core: Wait for RCU callbacks before unloading ib=
_core
      CVE-2026-93114: platform/surface: acpi-notify: Check ACPI companion b=
efore use
      CVE-2026-93115: platform/mellanox: mlxbf-pmc: Check ACPI_COMPANION() =
against NULL
      CVE-2026-93117: usb: fix UAF when probe runs concurrent to dyn ID rem=
oval
      CVE-2026-93118: usb: gadget: aspeed_udc: check endpoint DMA allocatio=
n
      CVE-2026-93120: usb: gadget: configfs: fix out-of-bounds read of qw_s=
ign
      CVE-2026-93130: platform/x86: dell-wmi-base: Fix resource leak on mod=
ule load failure
      CVE-2026-93131: platform/x86: dell-privacy: Fix race condition
      CVE-2026-93136: bus: mhi: ep: Fix device refcount leak in the error p=
ath of MHI device creation
      CVE-2026-93137: bpf: Fix use-after-free on mm_struct in bpf_find_vma(=
)
      CVE-2026-93138: bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
      CVE-2026-93140: udf: Mark LVID buffer as uptodate before marking it d=
irty
      CVE-2026-93141: usb: gadget: r8a66597: avoid double free of ep0_req i=
n probe error path
      CVE-2026-93142: thermal/drivers/rcar: Fix error checking in probe()
      CVE-2026-93145: clk: qcom: gdsc: tear down per-domain genpds in gdsc_=
unregister()
      CVE-2026-93149: wifi: mac80211_hwsim: avoid NULL skb in stop queue dr=
ain
      CVE-2026-93151: nvmet-rdma: fix response resource leak on queue teard=
own
      CVE-2026-93152: nvme-apple: Use acquire/release for queue enabled sta=
te
      CVE-2026-93158: crypto: sa2ul - stop probe if context pool creation f=
ails
      CVE-2026-93159: crypto: atmel-sha204a - fix heap info leak on I2C tra=
nsfer failure
      CVE-2026-93160: crypto: atmel-ecc - reject hardware ECDH without a pu=
blic key
      CVE-2026-93161: crypto: qat - clear AES key schedule from stack
      CVE-2026-93165: platform/chrome: sensorhub: Fix memory overread in ri=
ng handler
      CVE-2026-93167: csky: Fix a4/a5 restoration in syscall trace path
      CVE-2026-93170: dmaengine: xilinx_dma: Fix channel idle state managem=
ent in AXIDMA and MCDMA interrupt handlers
      CVE-2026-93177: drm/amdgpu/pm/powerplay: bounds-check voltage index i=
n Vega10 lookup
      CVE-2026-93178: drm/amdgpu/pm/powerplay: bounds-check voltage index i=
n SMU7 lookup
      CVE-2026-93182: sched/fair: Fix overflow in update_tg_cfs_runnable()
      CVE-2026-93183: drm/lima: call drm_mm_init() with a valid allocation =
range
      CVE-2026-93185: ASoC: rt700-sdw: always drain jack work on remove
      CVE-2026-93188: HID: roccat: bound device-supplied profile index
      CVE-2026-93189: HID: core: quiesce input in hid_hw_stop() to prevent =
use-after-free
      CVE-2026-93190: platform/chrome: cros_ec_typec: Reject out-of-bounds =
PD cap count
      CVE-2026-93191: smack: fix incorrect task context in smack_msg_queue_=
msgrcv
      CVE-2026-93203: batman-adv: bla: avoid CRC corruption due to parallel=
 claim add
      CVE-2026-93204: batman-adv: dat: atomically update mac addresses
      CVE-2026-93206: PCI/proc: Use file_ns_capable() when checking config =
space read access
      CVE-2026-93210: smb: client: harden DFS cache against invalid target =
hints
      CVE-2026-93213: of: fix out-of-bounds read in of_alias_scan() stem pa=
rser
      CVE-2026-93214: usb: gadget: f_tcm: fix deadlock in usbg_make_tpg()
      CVE-2026-93219: clocksource/drivers/timer-sun4i: Advertise a real min=
imum delta
      CVE-2026-93222: signal: avoid shared siginfo namespace rewrites
      CVE-2026-93226: ipv6: use RCU iterator to dump route exceptions
      CVE-2026-93234: drm/gud: validate TV mode names before creating enum =
property
      CVE-2026-93236: media: meson: vdec: fix NULL pointer deref in vdec_tr=
y_fmt_common
      CVE-2026-93242: scsi: qla2xxx: Fix response queue over-consumption in=
 __qla_consume_iocb()
      CVE-2026-93245: apparmor: policy_int make sure list heads are initial=
ized before fail path
      CVE-2026-93247: Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL der=
eference
      CVE-2026-93252: ocfs2: fix circular locking dependency in ocfs2_init_=
acl()
      CVE-2026-93256: arm64: hibernate: mask DAIF before restoring hibernat=
ed kernel
      CVE-2026-93261: locking/lockdep: Fix NULL pointer dereference in __lo=
ck_set_class()
      CVE-2026-93262: md/raid5-ppl: fix use-after-free in ppl_do_flush()
      CVE-2026-93264: RDMA/efa: Fix PBL chunk length computation
      CVE-2026-93268: ext4: skip extra isize expansion during mount to prev=
ent deadlock
      CVE-2026-93271: wifi: ath11k: cap out-of-range rx MCS instead of leav=
ing bogus rate
      CVE-2026-93274: pinctrl: bcm2835: Don't remove an unregistered GPIO c=
hip
      CVE-2026-93278: staging: octeon: add missing napi_disable in cvm_oct_=
rx_shutdown
      CVE-2026-93279: staging: octeon: add missing tasklet_kill in cvm_oct_=
tx_shutdown
      CVE-2026-93280: greybus: audio: bound the topology section sizes agai=
nst the fetched size
      CVE-2026-93281: wifi: rtw89: fix HE extended capability length check
      CVE-2026-93283: i3c: master: Fix device_register() error path
      CVE-2026-98152: nvmet-rdma: fix queue leak when connect backlog is ex=
ceeded
      CVE-2026-98160: staging: rtl8723bs: fix mismatched free of HalData in=
 rtw_sdio_if1_init()
      CVE-2023-52629: sh: push-switch: Reorder cleanup operations to avoid =
use-after-free bug
      CVE-2023-53231: erofs: Fix detection of atomic context
      CVE-2023-53336: media: ipu-bridge: Fix null pointer deref on SSDB/PLD=
 parsing warnings
      CVE-2023-53353: accel/habanalabs: postpone mem_mgr IDR destruction to=
 hpriv_release()
      CVE-2023-53429: btrfs: don't check PageError in __extent_writepage
      CVE-2023-53491: start_kernel: Add __no_stack_protector function attri=
bute
      CVE-2023-53538: btrfs: insert tree mod log move in push_node_left
      CVE-2023-53574: wifi: rtw88: delete timer and free skb queue when unl=
oading
      CVE-2023-53627: scsi: hisi_sas: Grab sas_dev lock when traversing the=
 members of sas_dev.list
      CVE-2023-53762: Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sy=
nc
      CVE-2023-53851: drm/msm/dp: Drop aux devices together with DP control=
ler
      CVE-2023-53857: bpf: bpf_sk_storage: Fix invalid wait context lockdep=
 report
      CVE-2023-53999: net/mlx5e: TC, Fix internal port memory leak
      CVE-2023-54227: blk-mq: fix tags leak when shrink nr_hw_queues
      CVE-2023-54233: ASoC: SOF: avoid a NULL dereference with unsupported =
widgets
      CVE-2024-49568: net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when=
 receiving proposal msg
      CVE-2024-56545: HID: hyperv: streamline driver probe to avoid devres =
issues
      CVE-2025-21759: ipv6: mcast: extend RCU protection in igmp6_send()
      CVE-2025-40074: ipv4: start using dst_dev_rcu()
      CVE-2025-40097: ALSA: hda: Fix missing pointer check in hda_component=
_manager_init function
      CVE-2025-68190: drm/amdgpu/atom: Check kcalloc() for WS buffer in amd=
gpu_atom_execute_table_locked()
      CVE-2025-68736: landlock: Fix handling of disconnected directories
      CVE-2026-52988: netfilter: nf_tables: join hook list via splice_list_=
rcu() in commit phase
      CVE-2026-53005: af_unix: Drop all SCM attributes for SOCKMAP.
      CVE-2026-68097: ksmbd: validate ACE size against SID sub-authorities
      CVE-2026-68161: sctp: close UDP tunnel sockets during netns teardown
      CVE-2026-68236: drm/amd/display: set new_stream to NULL after release
      CVE-2026-68286: drop_monitor: perform u64_stats updates under IRQ-dis=
abled section
      CVE-2026-68287: drop_monitor: fix size calculations for 64-bit attrib=
utes
      CVE-2026-68288: net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLO=
AD
      CVE-2026-68289: tipc: fix integer overflow in tipc_recvmsg() and tipc=
_recvstream()
      CVE-2026-68391: Bluetooth: mgmt: hold reference for hci_conn in mgmt_=
pending_cmds
      CVE-2026-72334: Bluetooth: ISO: fix malformed ISO_END/CONT handling
      CVE-2026-72402: bpf: Mask pseudo pointer values in verifier logs
      CVE-2026-72413: sctp: fix err_chunk memory leaks in INIT handling
      CVE-2026-74289: ipv4: fib: Don't dump dying fib_info in fib_leaf_noti=
fy().
      CVE-2026-74294: ASoC: meson: aiu: Validate written enum values
      CVE-2026-74496: fou: Fix use-after-free in fou_create()
      CVE-2026-74521: ksmbd: use memcmp() to compare ClientGUIDs
      CVE-2026-80521: af_unix: Unlink scc_entry in unix_del_edge().
      CVE-2026-80833: crypto: sun8i-ss - Remove crypto_rng interface
      CVE-2026-80834: crypto: sun8i-ce - Remove crypto_rng interface
      CVE-2026-89792: ksmbd: prevent out-of-bounds reads in share config re=
sponses
      CVE-2026-89796: mm/damon/core: avoid infinite kdamond_merge_regions()=
 internal loop
      CVE-2026-90304: ARM: 9484/1: enable interrupts when unhandled user fa=
ults are triggered
      CVE-2026-93286: net: appletalk: fix NULL pointer dereference in aarp_=
send_ddp()
      CVE-2026-93287: i2c: smbus: reject oversized block transfers in the c=
ommon path
      CVE-2026-93288: netfilter: nfnetlink_log: wait for rcu grace period b=
efore freeing pernet state
      CVE-2026-93781: scsi: core: Do not block on tag allocation in scsi_eh=
_lock_door()
      CVE-2026-93782: vhost-scsi: flush backend after device ioctls
      CVE-2026-93783: Bluetooth: RFCOMM: validate skb length in rfcomm_recv=
_frame
      CVE-2026-93784: wifi: cfg80211: validate IEs in cfg80211_wext_siwgeni=
e()
      CVE-2026-93785: cifs: validate idmap key payload length
      CVE-2026-93787: smb: client: bound dirent name against end of SMB res=
ponse in cifs_filldir
      CVE-2026-93788: wifi: iwlwifi: acpi: validate WGDS table revision ind=
ex
      CVE-2026-93789: wifi: iwlwifi: bound aligned TLV advance in FW parser
      CVE-2026-93795: blk-cgroup: fix leaks and online flag on radix_tree_i=
nsert failure
      CVE-2026-93797: wifi: iwlwifi: mvm: fix an off-by-1 boundary check
      CVE-2026-93798: btrfs: fix reloc root cleanup in merge_reloc_roots()
      CVE-2026-93800: btrfs: fix use-after-free on reloc root after error i=
n insert_dirty_subvol()
      CVE-2026-93802: wifi: rsi: validate beacon length before fixed buffer=
 copy
      CVE-2026-93803: wifi: libipw: fix key index receive bound checks
      CVE-2026-93805: wifi: cfg80211: validate rx/tx MLME callback frame le=
ngths before access
      CVE-2026-93806: wifi: cfg80211: validate assoc response length before=
 status and IE access
      CVE-2026-93807: wifi: rsi: avoid reading TKIP MIC keys for non-TKIP c=
iphers
      CVE-2026-93808: ALSA: usb-audio: caiaq: validate EP1 reply lengths
      CVE-2026-93810: cachefiles: Fix double fput
      CVE-2026-93811: ksmbd: Fix acl.sd_buf memory leak and invalid sd_size=
 error handling
      CVE-2026-93812: ksmbd: fix sd_ndr.data memory leak in ksmbd_vfs_set_s=
d_xattr
      CVE-2026-93813: btrfs: tree-checker: validate INODE_REF's namelen
      CVE-2026-93814: spi: core: Abort active target transfer on controller=
 suspend
      CVE-2026-93815: net: au1000: move free_irq out of the close-time spin=
locked section
      CVE-2026-93816: f2fs: validate inline dentry name lengths before conv=
ersion
      CVE-2026-93819: PCI: mediatek: Protect root bus removal with rescan l=
ock
      CVE-2026-93820: PCI: rockchip: Protect root bus removal with rescan l=
ock
      CVE-2026-93821: PCI: altera: Protect root bus removal with rescan loc=
k
      CVE-2026-93822: PCI: iproc: Protect root bus removal with rescan lock
      CVE-2026-93824: tls: reject the combination of TLS and sockmap
      CVE-2026-93825: spi: Add NULL check for spi_get_device_id() in spi_ge=
t_device_match_data()
      CVE-2026-93826: HID: hidpp: fix potential UAF in hidpp_connect_event(=
)
      CVE-2026-93830: net: stmmac: xgmac2: disable RBUE in default RX inter=
rupt mask
      CVE-2026-97407: ASoC: rockchip: rockchip_pdm: Handle runtime PM resum=
e failures in set_fmt
      CVE-2026-97408: Bluetooth: L2CAP: validate connectionless PSM length
      CVE-2026-97411: net: ibm: emac: mal: fix potential system hang in mal=
_remove()
      CVE-2026-97413: RDMA/rtrs-srv: Fix integer underflow in process_read =
and process_write
      CVE-2026-97415: btrfs: tree-checker: validate names in ROOT_REF and R=
OOT_BACKREF
      CVE-2026-97416: btrfs: balance: fix potential bg lookup failure in bt=
rfs_may_alloc_data_chunk()
      CVE-2026-97417: netfilter: nf_conntrack: use get_unaligned_be32() in =
tcp_sack()
      CVE-2026-97418: ALSA: es18xx: check control allocation before private=
 data setup
      CVE-2026-97419: hsr: broadcast netlink notifications in the device's =
net namespace
      CVE-2026-97420: bpf: NUL-terminate replaced sysctl value
      CVE-2026-97421: RDMA/umem: Be careful about boundary conditions in ib=
_umem_find_best_pgsz()
      CVE-2026-97427: drm/amd/pm: bound pp_dpm_set_pp_table() memcpy
      CVE-2026-97430: xhci: Prevent queuing new commands if xhci is inacces=
sible
      CVE-2026-97434: dpaa2-switch: fix handling of NAPI on the remove path
      CVE-2026-97435: net: dsa: sja1105: flower: reject cross-chip redirect
      CVE-2026-97436: dpaa2-switch: rework FDB management on the bridge lea=
ve path
      CVE-2026-97437: ntfs3: fix out-of-bounds read in ntfs_dir_emit() and =
hdr_find_e()
      CVE-2026-97438: fs/ntfs3: validate index entry key bounds
      CVE-2026-97439: fs/ntfs3: preserve non-DOS attribute bits in system.d=
os_attrib
      CVE-2026-97440: net: qrtr: fix node refcount leak on ctrl packet allo=
c failure
      CVE-2026-97441: ata: ahci: fail probe if BAR too small for claimed po=
rts
      CVE-2026-97442: wifi: ath11k: fix invalid data access in ath11k_dp_rx=
_h_undecap_nwifi
      CVE-2026-97443: perf/ftrace: Fix WARNING in __unregister_ftrace_funct=
ion
      CVE-2026-97444: ACPICA: add boundary checks in two places
      CVE-2026-97445: ACPICA: Enhance buffer validation in acpi_ut_walk_aml=
_resources()
      CVE-2026-97446: ACPICA: Fix NULL pointer dereference in acpi_ns_custo=
m_package()
      CVE-2026-97447: ACPICA: Enhance OEM ID and Table ID validation in acp=
i_ex_load_table_op()
      CVE-2026-97448: ACPICA: Add validation for node in acpi_ns_build_norm=
alized_path()
      CVE-2026-97449: ACPICA: Add package limit checks in parser functions
      CVE-2026-97450: ACPICA: validate handler object type in two places
      CVE-2026-97451: ACPICA: Fix integer overflow in acpi_ex_opcode_3A_1T_=
1R() (mid_op)
      CVE-2026-97452: ACPICA: Prevent adding invalid references
      CVE-2026-97453: ACPICA: validate byte_count in acpi_ps_get_next_packa=
ge_length()
      CVE-2026-97454: ACPICA: add boundary checks in acpi_ps_get_next_field=
()
      CVE-2026-97455: ACPICA: Fix use-after-free in acpi_ds_terminate_contr=
ol_method()
      CVE-2026-97456: ACPICA: Fix condition check in acpi_ps_parse_loop()
      CVE-2026-97472: ipv6: addrconf: fix temp address generation after pre=
fix deprecation
      CVE-2026-97475: thermal/drivers/tegra/soctherma: Switch to devm cooli=
ng device registration
      CVE-2026-97476: rds: filter RDS_INFO_* getsockopt by caller's netns
      CVE-2026-97481: serial: 8250: fix possible ISR soft lockup
      CVE-2026-97482: usb: gadget: goku_udc: avoid NULL deref of dev->drive=
r in INT_USBRESET log
      CVE-2026-97483: usb: core: hcd: fix possible deadlock in rh control t=
ransfers
      CVE-2026-97484: usbip: vhci_hcd: fix NULL deref in status_show_vhci
      CVE-2026-97485: omfs: handle set_blocksize failures
      CVE-2026-97486: hpfs: handle set_blocksize failures
      CVE-2026-97487: jfs: handle set_blocksize failures
      CVE-2026-97488: qnx4: handle set_blocksize failures
      CVE-2026-97489: bfs: handle set_blocksize failures
      CVE-2026-97490: affs: handle set_blocksize failures
      CVE-2026-97491: net/rds: Don't sleep inside rds_ib_conn_path_shutdown
      CVE-2026-97492: wifi: mac80211: don't call ieee80211_handle_reconfig_=
failure when not needed
      CVE-2026-97495: drm/amdkfd: Check bounds on allocate_doorbell
      CVE-2026-97497: drm/amdkfd: Check bounds for allocate_sdma_queue rest=
ore_sdma_id
      CVE-2026-97502: mmc: davinci: avoid NULL deref of host->data in IRQ h=
andler
      CVE-2026-97506: crypto: ixp4xx - fix buffer chain unwind on allocatio=
n failure
      CVE-2026-97507: media: dm1105: fix missing error check for dma_alloc_=
coherent
      CVE-2026-97508: thunderbolt: Set tb->root_switch to NULL when domain =
is stopped
      CVE-2026-97509: thunderbolt: Keep XDomain reference during the lifeti=
me of a service
      CVE-2026-97510: thunderbolt: Release request if tb_cfg_request() fail=
s in __tb_xdomain_response()
      CVE-2026-97516: wifi: rtw88: Add NULL check for chip->edcca_th in rtw=
_fw_adaptivity_result()
      CVE-2026-97517: wifi: nl80211: reject beacons with bad HE operation
      CVE-2026-97523: mptcp: close race between scheduler and state change
      CVE-2026-97524: mptcp: avoid unneeded actions on subflow reset
      CVE-2026-97539: usb: xusbatm: don't rely on id table pointer arithmet=
ic
      CVE-2026-97540: net: usb: pegasus: don't rely on id table pointer ari=
thmetic
      CVE-2026-97541: wifi: ath9k_htc: don't store usb_device_id
      CVE-2026-97556: smb: client: avoid leaking refcount when cifs_sb_tlin=
k() fails
      CVE-2026-97557: smb: client: avoid leaking refcount in cifs_queue_opl=
ock_break()
      CVE-2026-97564: smb: client: reject userspace cifs.idmap descriptions
      CVE-2026-97568: mptcp: syncookies: remember the request backup flag
      CVE-2026-97572: bnxt_en: Propagate RX ring init failures in bnxt_init=
_nic()
      CVE-2026-97573: bnxt_en: Handle buffer allocation failure in bnxt_rx_=
ring_reset()
      CVE-2026-97576: media: v4l2-ctrls: validate HEVC tile counts
      CVE-2026-97581: media: verisilicon: hantro: bound G2 HEVC tile loop t=
o the buffer capacity
      CVE-2026-97582: hwmon: (gpio-fan) Fix use-after-free in alarm work
      CVE-2026-97592: s390/crypto: Fix missing scrub of temp buffers with A=
ES ctr and gcm algorithm
      CVE-2026-97596: ipvs: reject invalid states in connection template sy=
nc records
      CVE-2026-97598: ipv4: fib: bound automatic table ID allocation
      CVE-2026-97601: ieee802154: 6lowpan: fix NULL dereference in lowpan_n=
ewlink
      CVE-2026-97604: fbdev: vfb: defer cleanup until the last reference
      CVE-2026-97608: netfilter: nf_log: unregister loggers before per-net =
teardown
      CVE-2026-97611: net: openvswitch: fix use-after-free of the flow tabl=
e mask array
      CVE-2026-97612: net: mpls: clear inner_protocol when the last label i=
s popped
      CVE-2026-97899: drm/i915: Fix memory leak in query_perf_config_list()
      CVE-2026-97904: cpufreq: initialize policy rwsem before sysfs publica=
tion
      CVE-2026-97905: cpufreq: zero-initialize policy cpumask before sysfs =
publication
      CVE-2026-97909: ASoC: sti: initialize IRQ lock before requesting IRQ
      CVE-2026-97910: ASoC: sprd: validate compress buffer sizes against fi=
xed allocations
      CVE-2026-97920: tracing: Keep the entry count when the histogram stat=
s allocation fails
      CVE-2026-97921: tracing: Free histogram the field rejected for a bad =
modifier
      CVE-2026-97922: tracing: Free histogram var refs regardless of how of=
ten they are referenced
      CVE-2026-97923: tracing: Free histogram the var ref when its initiali=
zation fails
      CVE-2026-97925: tick/broadcast: Plug clockevents replacement race
      CVE-2026-97926: ufs: validate cylinder group metadata before caching =
it
      CVE-2026-97927: ufs: create the root dentry after loading cylinder me=
tadata
      CVE-2026-97930: ALSA: usbusx2y: fix in04_last array size mismatch wit=
h in04_buf
      CVE-2026-97931: ALSA: us122l: Prevent write upgrades for read mapping=
s
      CVE-2026-97940: ipv6: fix fib6 walker UAF on seq stop
      CVE-2026-97948: powerpc/eeh: Fix recursive locking on devices without=
 EEH sensitive driver
      CVE-2026-97951: scsi: target: iscsi: Fix hang for aborted WRITE_PENDI=
NG commands
      CVE-2026-97952: sunvdc: unmap LDC cookies when the descriptor send fa=
ils
      CVE-2026-97954: net/rds: fix tcp stream corruption with large pages
      CVE-2026-97957: net: hinic: fix mailbox segment buffer overflow
      CVE-2026-97958: net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_c=
tl_chain().
      CVE-2026-97959: net/sched: cls_route: free emptied bucket on filter m=
ove
      CVE-2026-97963: net: stmmac: initialize ptp_lock at probe time
      CVE-2026-97964: ppp_synctty: ensure a writeable skb header
      CVE-2026-97969: watchdog: msc313e: Fix clock leak and spurious timer =
in settimeout()
      CVE-2026-97970: watchdog: msc313e: Avoid division by zero
      CVE-2026-97973: net: macb: destroy the phylink instance on the probe =
error path
      CVE-2026-97977: Bluetooth: btusb: Fix UAF of btusb_data by rx_work
      CVE-2026-97979: ice: add missing xa_destroy for sched_node_ids
      CVE-2026-97981: net: ethernet: cortina: Count dropped frames as NAPI =
work
      CVE-2026-97982: net: ethernet: cortina: Fix budget accounting
      CVE-2026-97986: virtio_input: stop callbacks before unregistering inp=
ut device
      CVE-2026-97987: virtio_input: reset device if input_register_device()=
 fails
      CVE-2026-97991: vdpa_sim_blk: reject out-of-range sector starts
      CVE-2026-97993: vhost-vdpa: don't install the eventfd_ctx_fdget() err=
or in config_ctx
      CVE-2026-97995: virtio_console: do not free control-out buffers on re=
move
      CVE-2026-97998: netfilter: nfnetlink_log: cope with concurrent instan=
ce destruction
      CVE-2026-98006: ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev
      CVE-2026-98008: net: macb: fix NULL pointer dereference on unbind wit=
h fixed-link
      CVE-2026-98009: net/sched: ets: clamp quantum in parse and fallback p=
aths
      CVE-2026-98010: net/sched: drr: clamp quantum in change class
      CVE-2026-98011: net/sched: hhf: clamp quantum in change and init path=
s
      CVE-2026-98012: net/sched: sfq: clamp quantum in change path
      CVE-2026-98013: net/sched: fq_pie: clamp quantum in change path
      CVE-2026-98014: net/mlx5: E-Switch, prevent mc_list repopulation duri=
ng vport disable
      CVE-2026-98015: net/mlx5: E-Switch: fix use-after-free in mlx5_eswitc=
h_termtbl_put
      CVE-2026-98016: net/mlx5e: Fix use-after-free race in sample_restore_=
put()
      CVE-2026-98017: net/sched: defer qdisc freeing after failed creation
      CVE-2026-98022: net: cap tx_queue_len at S16_MAX to prevent oversized=
 ring allocations
      CVE-2026-98023: vxlan: reject dynamic fdb entries that reference a ne=
xthop id
      CVE-2026-98025: net: usb: cx82310_eth: drop URB after 0xffff reboot s=
entinel to prevent partial_data heap overflow
      CVE-2026-98027: net: dsa: mv88e6xxx: bound the policy rule dump by th=
e caller's buffer size
      CVE-2026-98030: net: dsa: bcm_sf2: bound the CFP rule dump by the cal=
ler's buffer size
      CVE-2026-98031: nexthop: Initialize extack in remove_nh_grp_entry()
      CVE-2026-98046: bpf: Mark bpf_btf_find_by_name_kind() as sleepable
      CVE-2026-98055: ASoC: Intel: avs: Clean up the bus when fetching ML c=
aps fails
      CVE-2026-98063: bpf: Fix NULL-ptr-deref in btf_var_show()
      CVE-2026-98064: bpf: Fix NULL-ptr-deref when showing a void BTF type
      CVE-2026-98066: ALSA: caiaq: Fix potential double-free at error path
      CVE-2026-98068: net/rds: don't let rds_conn_shutdown() consume a conc=
urrent drop
      CVE-2026-98069: net/rds: acquire the fastpath locks in rds_conn_shutd=
own()
      CVE-2026-98070: net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbac=
ks()
      CVE-2026-98071: net/rds: clear cp_flags bits individually in rds_conn=
_path_reset()
      CVE-2026-98072: net/rds: use wq_has_sleeper() in release_in_xmit()
      CVE-2026-98074: bonding: do not clear curr_active_slave prematurely w=
hen releasing all slaves
      CVE-2026-98075: bpf: reject BPF_PSEUDO_FUNC reference to the main pro=
gram
      CVE-2026-98076: tracing/probes: Fix use-after-free on field name/type=
 of events with multiple probes
      CVE-2026-98077: netfilter: nf_conntrack_sip: fix OOB read in sip_skip=
_whitespace()
      CVE-2026-98078: ipvs: fix reversed sequence option serialization
      CVE-2026-98080: btrfs: do not force reloc root creation during qgroup=
_account_snapshot()
      CVE-2026-98088: scsi: mpt3sas: Avoid out-of-bounds cpumask_of_node() =
call in _base_assign_reply_queues()
      CVE-2026-98089: bonding: alb: fix uninitialized transport header acce=
ss in alb_determine_nd()
      CVE-2026-98090: btrfs: restore active device pointers after failed sp=
rout
      CVE-2026-98091: btrfs: detach failed sprout device from transaction u=
pdate list
      CVE-2026-98092: ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close=
()
      CVE-2026-98094: staging: fbtft: make dirty_lock IRQ-safe
      CVE-2026-98095: af_packet: Don't cast tpacket_hdr.tp_len to int in tp=
acket_parse_header().
      CVE-2026-98096: ipv6: sr: restore network header before routing and f=
orwarding
      CVE-2026-98098: tipc: fix NULL deref in tipc_named_node_up() on empty=
 publication list
      CVE-2026-98104: net/sched: cls_u32: fix duplicate handle when node ID=
 pool is exhausted
      CVE-2026-98108: Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT=
_FLOWCTL pchan
      CVE-2026-98113: ksmbd: rate limit unmapped SID errors
      CVE-2026-98116: ALSA: pcm: Serialize PCM mmap with buffer reallocatio=
n to fix page UAF
      CVE-2026-98121: watchdog: msc313e: Fix NULL pointer dereference in PM=
 callbacks
      CVE-2026-98123: sctp: fix soft lockup from unpadded ASCONF-ACK parame=
ter iteration
      CVE-2026-98128: scsi: mpi3mr: Fix target device refcount leak in mpi3=
mr_sas_port_add()
      CVE-2026-98129: scsi: mpi3mr: Fix NULL pointer dereference in mpi3mr_=
sas_port_add()
      CVE-2026-98130: sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START
      CVE-2026-98154: nvme-rdma: fix -EIO cleanup order in queue_rq
      CVE-2026-98157: EDAC/device_sysfs: Use kstrtouint() for poll_msec to =
prevent truncation
      CVE-2026-98158: ppp_async: drop the errored frame instead of resettin=
g its headroom
      CVE-2026-98159: wifi: mt76: mt7921: validate CLC firmware records
      CVE-2026-98167: smb: client: fix server->total_read for compound encr=
ypted PDUs
      CVE-2026-98169: smb: client: fix potential OOB read in smb3_enum_snap=
shots()
      CVE-2026-98171: smb: client: fix next_buffer UAF and NextCommand boun=
ds in compound PDUs
      CVE-2026-98172: smb: client: fix smbd_connection leak on cifs_get_tcp=
_session() error
      CVE-2026-98181: drm/gud: fix out-of-bounds write in gud_plane_atomic_=
check()
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
      CVE-2026-98194: wifi: libertas_tf: fix UAF in lbtf_free_adapter()
      CVE-2026-98195: wifi: iwlegacy: fix broadcast stations deallocation
      CVE-2026-98196: wifi: brcmsmac: fix UAF in brcms_free_timer()
      CVE-2026-98197: hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on re=
move
      CVE-2026-98199: hwmon: (pmbus/core) increase number of phases and add=
 new mask
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
      CVE-2026-98207: mmc: spi: reset bytes_xfered before retrying CRC fail=
ures
      CVE-2026-98208: mmc: sdio_uart: fix xmit_fifo leak when the port tabl=
e is full
      CVE-2026-98209: mmc: sdhci-of-aspeed: Remove children before releasin=
g SDC resources
      CVE-2026-98210: mmc: mxcmmc: cancel data work and watchdog on remove
      CVE-2026-98213: mmc: core: Cancel SDIO IRQ work before freeing host
      CVE-2026-98217: IB/mlx4: Fix use-after-free on pkey sysfs registratio=
n failure
      CVE-2026-98221: KEYS: trusted: Fix tpm2_load_cmd() boundary check
      CVE-2026-98227: memstick: ms_block: destroy io_queue workqueue on rem=
oval
      CVE-2026-98233: net/packet: clear RX owner on VNET header error
      CVE-2026-98234: net/sched: hhf: cap hh_flows_limit at change time
      CVE-2026-98236: net: wwan: mhi_wwan_mbim: check skb_copy_bits() retur=
n value
      CVE-2026-98237: net: wwan: mhi_wwan_mbim: guard against a cyclic NDP =
chain
      CVE-2026-98238: net: wwan: t7xx: validate the netif index in t7xx_ccm=
ni_recv_skb()
      CVE-2026-98239: net: lan743x: fix RX checksum use-after-free
      CVE-2026-98241: ipv6: xfrm: use full sockets in local error paths
      CVE-2026-98246: Bluetooth: hci_sync: Serialize local codec list clean=
up
      CVE-2026-98247: Bluetooth: hci_codec: validate vendor codec count len=
gth
      CVE-2026-98249: arm64: hibernate: pass HVC_SET_VECTORS args to the re=
sume hvc
      CVE-2026-98251: openvswitch: avoid reallocating confirmed conntrack l=
abels
      CVE-2026-98252: RDMA/core: fix refcount bug in iwpm_get_nlmsg_request=
()
      CVE-2026-98253: RDMA/ucma: Serialize join and leave on copy_to_user f=
ailure
      CVE-2026-98255: tcp: exclude old ACKs from tcp fast path
      CVE-2026-98257: rds: ib: use rds_conn_drop() on protocol version mism=
atch
      CVE-2026-98262: ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_3=
2BIT_ONLY
      CVE-2026-98264: ALSA: virtio: reset device before deleting virtqueues
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
      CVE-2026-98308: ALSA: hda: trace PCM open only after assigning a stre=
am
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
      CVE-2026-98328: wifi: mac80211: add HE 6 GHz capability in the scan e=
lems len
      CVE-2026-98331: wifi: mac80211: unlist vifs when their netdev is unre=
gistered
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
      CVE-2026-98367: RDMA/siw: Clear association under lock if siw_qp_modi=
fy fails in siw_accept
      CVE-2026-98368: esp: downgrade zerocopy managed frags before mutating=
 skb frags
      CVE-2026-98369: xfrm: add missing rcu_read_lock(), skb_dst_force() an=
d dev_hold() for xfrm_trans_reinject()
      CVE-2026-98370: xfrm: fix compat ALLOCSPI request use-after-free
      CVE-2026-98374: tcp: fix use-after-free of retransmit_skb_hint in tcp=
_send_synack()
      CVE-2026-98378: bpf: Skip unsettled links in link iterator
      CVE-2026-98379: netfilter: ip6t_rpfilter: reject routes without inet6=
_dev
      CVE-2026-98380: net/sched: reject IDR error pointers when deleting ac=
tions
      CVE-2026-98381: veth: manage XDP program pointers during channel resi=
ze
      CVE-2026-98383: bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
    added commits:
      CIP: Bump version suffix to -cip61 after merge from stable
      arm64: dts: renesas: r8a774e1: Add missing iommus properties
      arm64: dts: renesas: r8a774c0: Add missing iommus properties
      arm64: dts: renesas: r8a774b1: Add missing iommus properties
      arm64: dts: renesas: r8a774a1: Add missing iommus properties
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC
      arm64: dts: renesas: r9a09g056: Add RTC node
      clk: renesas: r9a09g056: Add clock and reset entries for RTC
      dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
      rtc: renesas-rtca3: Factor out year decoding helper
      rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
      rtc: renesas-rtca3: Fix incorrect error message for reset assert
      rtc: renesas-rtca3: Check RADJ poll result during initial setup
      rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup er=
ror path
      pinctrl: renesas: rzg2l: Populate struct gpio_chip::set_config
      arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels
      arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
      mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
      mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC

Best regards,
  Nobuhiro


