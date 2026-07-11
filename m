Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D369C43458
	for <webhook@archiver.kernel.org>; Sat, 11 Jul 2026 20:49:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3510.1783802933018727772
 for <cip-dev@lists.cip-project.org>;
 Sat, 11 Jul 2026 13:48:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=sud77fT7;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1783802917;x=1785012517;bh=
	TsbDj5R6agDRLmKjgbYlwIQH4S98r9U0ztScCm1K+6o=;b=sud77fT7131Bu9K1PgroBocMb6f0t1
	WrX/iVs3OOr15ZApZ4ptpTN4AMBtkwuDmBpNaMMfwq78lF0tiFt9uIS8rWy8J6oyo7RaYtO8TqzOs
	+FtZSffr7vMul59kN7Z7x0y3X1+xDUkhc3LEfgzSVrcI7QyDPdJrTPX3DbLD9amT3yFAwQLk1pes9
	4khRCE58ABF2doV+XW4JQVz2B63tx6dhwIa9VIX1FXrt3wtCjlrF5frLnX6fADHrVeM7SlLK726WB
	IMniT/ZrdmsOSs+9JvmY6AIkrc3tJCBvZKd490HnbyjaOyXJJZixxkSKl0WrYeegY36ep9hvZLgnU
	1GhQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66BKmawo330464; Sun, 12 Jul 2026 05:48:36 +0900
X-Iguazu-Qid: 2rWhDvWdRhx91CPvEW
X-Iguazu-QSIG: v=2; s=1; t=1783802915; q=2rWhDvWdRhx91CPvEW; m=iBxP5gtbZ29x5wVEJ2id6DgB+7LidreIj2wEK8xLvNc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gyLQB1WBQz1xnf; Sun, 12 Jul 2026 05:48:34 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVR9COxhdFct8Mu0t/a++uAfsgb6SHnYxqPNP5PFqCzRqoSfgplL6KAFJyYsIV6BjI5o8UaVadbc8jImREpQtc/oiKfPzwPFqvye8DQXNvGIbNon8iQzwWPIsbO4AFEP/On4AVXEtx7AyKyvCPyAfLNrmjf3TlbI4NLvvOrckvjHUkij/698cOgqGBhzjaHJOTjtj/xeQlVclVG07at4ND/wnXYkoyyePlYyHi5Ca5r19wYhNVlaFbpPoOa3/pbXybR2RY54JNShRyBecHusp+/CcA0b3TTCa1ZKxg7/l9bP/8hjktvHeXUwbnIF6pc31TSNOCuOjenCYPR9GCR2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrmAs+yqsGULiyWY9kgIlF6utCBVuNef+NEPexTbLsw=;
 b=jSIDjDN5fYLr8NUnvKcK3L3yua340o0omoNS0YoQp2rBYzEaj2bq15O5LENpjBaPgNL2As9U7/O3SHgMO1QFw2T5eIpELiP4Tu39fsbIlUoXnseliwvnEon1NezsJ7nhFlf5v6OuE2vt9eCwhEwuW3/0NJDGUSGrH+Miwi7GiCLPh2/YIbQ6do7ydrrEnVieXSrNWmKJ2RrdELLedVeFPLEhZSUYqOofVhBzncHxx19tsk7jEVbIMo4HbEpKh0b1dpzmN+B/vFwRTmXFnjO16sMbQwwRxeEBRbMBGe2d+EDyc9GnBtYADs03L0Y4gIAeGLPwMGQWK2CSkgfxYW4ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <uli@fpond.eu>, <pavel@nabladev.com>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.260-cip75
Thread-Topic: [ANNOUNCE] Release v5.10.260-cip75
Thread-Index: Ad0Rdp4GFHoGzQrIR6OiHbZmpwz+Pg==
Date: Sat, 11 Jul 2026 20:48:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180F306E78E239D1453DE8CDFC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB11911:EE_
x-ms-office365-filtering-correlation-id: 71d0c11c-babe-45ca-36fd-08dedf8dc397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|6133799003|38070700021;
x-microsoft-antispam-message-info: 
 dv2/xQyEfaDUMGCQcd/YiIWAHedpzQeNpJDv+1NTzsq3QLEE7gqfx2zK3f5941oynr+sHYyvOYSrEDTvDZEqNFCWwh5lNViBOeRX84fWD1lvzg3/rp70m+q+K+KaK3M3Wh9CVraiDtfknUA5ckabjTqh3bANu/h/iRi8rFhKfKnk2WG3qsXfSUQdyubewBw4VOnCQI+ED+MmDmYtP35r7EeOiolRG0XwlQEX3S2q98tleJIpRdsEB2TWUxVNrEBJiYOPnF6HgLgTS1JzKMw911SWQtI2vHExoQhJ2Z1iGbEs23WgVyPotXk1InK0WfMlNOkqUDOhWB4UiyxH3wj5l0VK5/kVY0fJpW6hitLD7kVsPrIY0cHI4FtyKG6xsgcOwA1pUV8gDortjoRBpQEE15rKw36T6ZvQ6oz00uKCb64fBRLMg7wN2+KrRdVLoAbgI4DS2wSEZhA6JF2fql+I+aTNvJUEoq6Qvl8ukGxK+pRdTMTsrfxkdgTmDxdjQi/sDGqOmDnjXeBYgHyTsH4C7j2Sht5kvRSpU8oX7OjN7Pd8Her6ay/h3a/WdZyXReA4v6wYDOiR4MUHgK4wUPfnb7Erpi1TQaOhSkzOBI0LEiszYGHbmOgpJiNeix5P84ZmvdCnIcdlDCmvzQLiJ3+tsAQTXa8tpPZ0sXuXFu8T71LGab/pAWFT+aPlO0/h0Hkq0jx6t1qAei4mdBFU9OjhQQHuyWMw4L8tk/8KSvEFgKk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MWxYQWdLK2tRMmdRTVZuWkNINnk3THVwNjNkY2FXVkNKYi9yc3ExUlNP?=
 =?iso-2022-jp?B?MUFtOFUvV0tDeVNpNno5a0J1WmxLOGhMS3huVmdla01mc1N2V1NEb3pO?=
 =?iso-2022-jp?B?bnJOWU1HU2pZZTUyNlE0YXRYek5oRXYxNHhIWXkwT2h0K1NDSXJ5dVBu?=
 =?iso-2022-jp?B?MmRWUGVVSFB2amp2T0JQWWEwTTVHMHhLL2FNS2EvbnJqNHFSbE1wc1VU?=
 =?iso-2022-jp?B?SndnWkpHMGlpVC82U0wrNEU2RDQ0K1p0QVpuK0pIdTlFaHV1aERvTGZH?=
 =?iso-2022-jp?B?Z0xBVmM5ODJTR0YyZ0h5am9MMWswU0lsV1QxWmh3RzI5eXhXaDlQYTMz?=
 =?iso-2022-jp?B?eVRxUmVSSWhrZUx0RCt6d2RiN2dCakxwVGhmSzQvb014ZUNJUmQzNUY5?=
 =?iso-2022-jp?B?dFIxdmFMVEFLQkI2MmdQNU1xcC9jS1RSKy9mVEtkL3NTNE1wQ2kyM3Vt?=
 =?iso-2022-jp?B?YU1FZ1EranB2Mmx3Mmk3ZWUvd0tqWUhwMXN6NHl2TGZpMllWM2pqcEZs?=
 =?iso-2022-jp?B?bjF6QXJMRUhEWmoreXZvb2ZBdi92Z1hYYW9vcFJkOHV4L3JmVW1rS0RT?=
 =?iso-2022-jp?B?VzAwWUtCczNoS3RWZytuR2R2OVVjR3M1WFFQNW1CbUxZYlBkaWRrZWRp?=
 =?iso-2022-jp?B?WGVVeUpVU1loUExadWFMTktiT2k3Tmh6RE5oMmRIc3hLR0VUOEd4ZnYv?=
 =?iso-2022-jp?B?TjRVWXcvTFhZUmt3SXg3UXlCeEtJeWJtSFE3djBVLzA5Wld1VkFudlJn?=
 =?iso-2022-jp?B?eFJhYmVUU1hvNXdLb3ZmaWtLY1VSeWFPclpkLzJXWnBIL2JicHFML1JH?=
 =?iso-2022-jp?B?UEtENytjQVZ4eVZEenFudzdHbFVYTVVjZ044QlpTZXIrOStkdUs2c3NU?=
 =?iso-2022-jp?B?QUpGZWM1QUtOKzhvMGg3ZWtzMkh0U3Z5S1hvUTBYVGNCQlhpK0RneGVS?=
 =?iso-2022-jp?B?ajhjbG93cGpXMUNQa2F2bDBBdnUyUkJMWStHZjBoVnJoaUJtazZ1dktD?=
 =?iso-2022-jp?B?K3l0UEQ4UGdsV1c0ZGZadDUydklDV3o0VHdDQWVnTkRLamtZUWYrZE5j?=
 =?iso-2022-jp?B?QVZ1bEVIYW9VR3pTalRud3lWZmhEUVJReVcxa1ZNaUlrSDNpLzdIbW5i?=
 =?iso-2022-jp?B?cER0N3FKT1RucFNkeHo3QXBwckFteFBIb0RYbk9jV282cEZWU0pKa0VF?=
 =?iso-2022-jp?B?dTBEQXVLUFVNQWMyNUNUdEZqYWFNMm9RNXl1N3JoU2IvME01dTRZbm4z?=
 =?iso-2022-jp?B?cjBHY2o2NDREQk9SNjZaeTFWcmNzOFJQbDJ4UC9vVXVCOFpPZUdDekdH?=
 =?iso-2022-jp?B?SkMzSG9TSzNZUTJZWGNrc3I2cEJyaGVTQ2hGR0V1OEUySVk0cGkwVG15?=
 =?iso-2022-jp?B?MnA0NytwVXRnUkQwTy8yOU9YMFRDb3BPeUxnbEg2UjBWSU96V2hhNHlL?=
 =?iso-2022-jp?B?MU14bXluOHlyRTZEb0hKMHJzUVFvcHdRWENGR2pTOFBTZUxTRXFZOEFE?=
 =?iso-2022-jp?B?OGFMNU1SVS83ZDRjNytJWlJvYzNzZEtuYXpIQVM5Q0J0dWtyd2p1RWU1?=
 =?iso-2022-jp?B?YnhRS1RIdTZOdVluN3NodktiZ2laZENaME12MDA2ZnpmbFZYT1NzT2Y2?=
 =?iso-2022-jp?B?d2dielo5bGRvc3AxUStYQU9qNXdEOGFEeUJBVWVDdFJGN0Q0b01XNklq?=
 =?iso-2022-jp?B?WlNSa1pRaFU5dW84QzJPWElxdzUyVU5DbVRVZWQzRGcxeXRtaVg5cjFk?=
 =?iso-2022-jp?B?MGhiK3Q5S3NwbmpSazJjdDg1QU5GWkhET3h2NlRWUXd6bHFWS2tNcXdu?=
 =?iso-2022-jp?B?L0VvQnJ6bmd3U3JGYUdVQmcwT0JoTGZ5K2tML0RUSEJVWE5XUlZXelVs?=
 =?iso-2022-jp?B?c2wyQkVDRkxqM01Jb2o4RkxvRHhlbXJSSGJiZEt0S3pNOEhxZFlaM1VP?=
 =?iso-2022-jp?B?UEE1QUdXVm9ZandEVldLU2VVYzBKTTN4UUpJbGh5MXNraTEwT0d6dnRp?=
 =?iso-2022-jp?B?YzNleFNrLzhyYldqcEY3WWs2SlRUSVZ4RVVnZ1gyaTVCWVk4U3J5Z24y?=
 =?iso-2022-jp?B?SFE4ajcyQlV3bEI3cGpRSEFlcVNRVGRCTkF6QlpQYmJKaXo1T3JRZS9W?=
 =?iso-2022-jp?B?ZUFSdUtNMVY4T0pKNG01M0xVcFZmVDZpSWJUd2FsY05Ua1pseTZBQU84?=
 =?iso-2022-jp?B?bVZ2Y0E2L05CTjdmRGlKcU1yS3o3bGxzLys3M0d4UUtITVBUUGZ4d2Yv?=
 =?iso-2022-jp?B?VGxwRndBOE9XVmVQdUVxWEVzQzRNNTVHVitXVGJLL2tzOWxIR1FkTGZi?=
 =?iso-2022-jp?B?RzJvaUVoamoxQkRUbXZ3QmJILzVBNG9NM3ZVZ0oxOUl2emFIamZXTVlX?=
 =?iso-2022-jp?B?OWFYZDJLNXZ6ZnVRSlBFSlhWMzViSEJWeDFuRmlFVjBXVVoxZ1p3UjJx?=
 =?iso-2022-jp?B?Q3dsOU9udmdEZ0xzWk1KVWxTemRFUWYwRjlhUkRwUTZzZnpVU2gzMVNG?=
 =?iso-2022-jp?B?Szd0bC83NDVMMjE2aWEwa0NleGcwZUMyd0wzRE1BYW9jVnpPYXBOem51?=
 =?iso-2022-jp?B?MWhJbTZlWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Hecde6GdO+B/b8/AkdZ3A1bFMpCs4VGtso94l3PSXGeeeTHFDI8sgelqRVafcyzlelNd2JpKhP2P6dxV/ez7w/XxqCPVJlIRPndoYexDgNWemtW4EOiopAfrLwXfaSUk4gdLgvpwdeqxrRvkgWDxjg1C4MXA0nLCnj/3KdWwla9bADnlZPqRDzLPHT0vLiI9boRI3ko5Ag8LhvBHZSEAuAdddtccEzzYoLb4AWQSrRIuYAHZ5aq5ZrT45H9ni+WFiF8FfRZgaIeJEA5ztnqxPCDzF/6XuVbPDQ5pTiExV7q10L3uriUDBz511LjjvzniP04gJMTbOX3BSdTqijiW4w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d0c11c-babe-45ca-36fd-08dedf8dc397
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2026 20:48:29.7939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44y5z4Akca6df6pw2+mJ7czkVaGM5Jy2blk1PnmYLvaZWm4Ct4FqUjeeuZfCtz4NjmyHOmYXzsV/mDuzoHj89nYL2Cj6YqKU2g5HMHKcyU4Uj0dZx31l5Nb9pSAbSHjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11911
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 11 Jul 2026 20:49:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23558

Hi all,

CIP kernel team has released Linux kernel v5.10.260-cip75.
The linux-5.10.y-cip tree has been updated base version from v5.10.258 to v=
5.10.260.

Information about this release is as follows:

  v5.10.260-cip75:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      b73e77b0c18cc1f30ddf28f058396899224a50a9
    fixed CVEs:
      CVE-2021-47211: ALSA: usb-audio: fix null pointer dereference on poin=
ter cs_desc
      CVE-2023-54129: octeontx2-af: Add validation for lmac type
      CVE-2025-10263: TLBI errata in some Arm-based CPUs may allow writes t=
o resources owned ...
      CVE-2025-21863: io_uring: prevent opcode speculation
      CVE-2025-22026: nfsd: don't ignore the return code of svc_proc_regist=
er()
      CVE-2025-38129: page_pool: Fix use-after-free in page_pool_recycle_in=
_ring
      CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush=
()
      CVE-2025-39929: smb: client: fix smbdirect_recv_io leak in smbd_negot=
iate() error path
      CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible c=
ode warnings
      CVE-2025-68340: team: Move team device type change at the end of team=
_port_add
      CVE-2026-23099: bonding: limit BOND_MODE_8023AD to Ethernet devices
      CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_index=
es
      CVE-2026-31489: spi: meson-spicc: Fix double-put in remove path
      CVE-2026-31700: net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpa=
cket_snd()
      CVE-2026-31708: smb: client: fix OOB read in smb2_ioctl_query_info QU=
ERY_INFO path
      CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[] =
in f2fs_write_end_io()
      CVE-2026-43052: wifi: mac80211: check tdls flag in ieee80211_tdls_ope=
r
      CVE-2026-43350: smb: client: require a full NFS mode SID before readi=
ng mode bits
      CVE-2026-43492: lib/crypto: mpi: Fix integer underflow in mpi_read_ra=
w_from_sgl()
      CVE-2026-45850: ipvs: skip ipv6 extension headers for csum checks
      CVE-2026-45991: udf: fix partition descriptor append bookkeeping
      CVE-2026-46003: net: qrtr: ns: Limit the total number of nodes
      CVE-2026-46006: drm/nouveau: fix u32 overflow in pushbuf reloc bounds=
 check
      CVE-2026-46021: thermal: core: Fix thermal zone governor cleanup issu=
es
      CVE-2026-46026: net: qrtr: ns: Limit the maximum number of lookups
      CVE-2026-46038: net: qrtr: ns: Free the node during ctrl_cmd_bye()
      CVE-2026-46052: ceph: only d_add() negative dentries when they are un=
hashed
      CVE-2026-46056: Bluetooth: hci_event: fix potential UAF in SSP passke=
y handlers
      CVE-2026-46069: wifi: mwifiex: fix use-after-free in mwifiex_adapter_=
cleanup()
      CVE-2026-46078: erofs: fix the out-of-bounds nameoff handling for tra=
iling dirents
      CVE-2026-46086: net: bridge: use a stable FDB dst snapshot in RCU rea=
ders
      CVE-2026-46090: ALSA: aloop: Fix peer runtime UAF during format-chang=
e stop
      CVE-2026-46091: media: rc: igorplugusb: heed coherency rules
      CVE-2026-46103: can: ucan: fix devres lifetime
      CVE-2026-46107: dm-thin: fix metadata refcount underflow
      CVE-2026-46137: mptcp: pm: ADD_ADDR rtx: fix potential data-race
      CVE-2026-46159: btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU=
 which can lead to info-leak
      CVE-2026-46160: btrfs: fix missing last_unlink_trans update when remo=
ving a directory
      CVE-2026-46169: hfsplus: fix uninit-value by validating catalog recor=
d size
      CVE-2026-46180: wifi: brcmfmac: Fix potential use-after-free issue wh=
en stopping watchdog task
      CVE-2026-46191: fbcon: Avoid OOB font access if console rotation fail=
s
      CVE-2026-46196: tracepoint: balance regfunc() on func_add() failure i=
n tracepoint_add_func()
      CVE-2026-46208: batman-adv: stop tp_meter sessions during mesh teardo=
wn
      CVE-2026-46291: crypto: caam - guard HMAC key hex dumps in hash_diges=
t_key
      CVE-2026-46292: pmdomain: core: Fix detach procedure for virtual devi=
ces in genpd
      CVE-2026-46299: hfsplus: fix held lock freed on hfsplus_fill_super()
      CVE-2026-46320: tap: free page on error paths in tap_get_user_xdp()
      CVE-2026-46321: tun: free page on short-frame rejection in tun_xdp_on=
e()
      CVE-2026-46322: tun: free page on build_skb failure in tun_xdp_one()
      CVE-2026-52910: bpf: Free reuseport cBPF prog after RCU grace period.
      CVE-2026-52912: netfilter: nf_queue: hold bridge skb->dev while queue=
d
      CVE-2026-52913: batman-adv: v: stop OGMv2 on disabled interface
      CVE-2026-52917: sctp: diag: reject stale associations in dump_one pat=
h
      CVE-2026-52918: Bluetooth: serialize accept_q access
      CVE-2026-52923: ipc: limit next_id allocation to the valid ID range
      CVE-2026-52924: sctp: purge outqueue on stale COOKIE-ECHO handling
      CVE-2026-52927: netfilter: ebtables: fix OOB read in compat_mtw_from_=
user
      CVE-2026-52929: sctp: stream: fully roll back denied add-stream state
      CVE-2026-52930: ipc/shm: serialize orphan cleanup with shm_nattch upd=
ates
      CVE-2026-52934: batman-adv: tvlv: reject oversized TVLV packets
      CVE-2026-52935: xfrm: espintcp: do not reuse an in-progress partial s=
end
      CVE-2026-52939: net/rds: fix NULL deref in rds_ib_send_cqe_handler() =
on masked atomic completion
      CVE-2026-52943: net: skbuff: fix missing zerocopy reference in pskb_c=
arve helpers
      CVE-2026-52946: fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync sig=
naling
      CVE-2026-52947: net: qrtr: fix refcount saturation and potential UAF =
in qrtr_port_remove
      CVE-2026-52948: i2c: dev: prevent integer overflow in I2C_TIMEOUT ioc=
tl
      CVE-2026-53080: net/sched: cls_fw: fix NULL dereference of "old" filt=
ers before change()
      CVE-2026-53133: RDMA/umem: Fix truncation for block sizes >=3D 4G
      CVE-2026-53134: netfilter: nft_fib: fix stale stack leak via the OIFN=
AME register
      CVE-2026-53135: drm/amd/display: Fix NULL deref and buffer over-read =
in SDP debugfs
      CVE-2026-53137: drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to =
buffer size
      CVE-2026-53146: thunderbolt: Limit XDomain response copy to actual fr=
ame size
      CVE-2026-53148: thunderbolt: Clamp XDomain response data copy to allo=
cation size
      CVE-2026-53149: thunderbolt: Bound root directory content to block si=
ze
      CVE-2026-53150: thunderbolt: Reject zero-length property entries in v=
alidator
      CVE-2026-53161: misc: fastrpc: fix use-after-free of fastrpc_user in =
workqueue context
      CVE-2026-53168: fuse: reject fuse_notify() pagecache ops on directori=
es
      CVE-2026-53176: IB/isert: Reject login PDUs shorter than ISER_HEADERS=
_LEN
      CVE-2026-53181: vsock/vmci: fix sk_ack_backlog leak on failed handsha=
ke
      CVE-2026-53186: RDMA/srp: bound SRP_RSP sense copy by the received le=
ngth
      CVE-2026-53189: mm/huge_memory: update file PMD counter before folio_=
put()
      CVE-2026-53192: ALSA: timer: Fix UAF at snd_timer_user_params()
      CVE-2026-53194: USB: serial: kl5kusb105: fix bulk-out buffer overflow
      CVE-2026-53195: USB: serial: io_ti: fix heap overflow in build_i2c_fw=
_hdr()
      CVE-2026-53196: USB: serial: io_ti: fix heap overflow in get_manuf_in=
fo()
      CVE-2026-53199: hv_netvsc: use kmap_local_page in netvsc_copy_to_send=
_buf
      CVE-2026-53208: Bluetooth: L2CAP: reject BR/EDR signaling packets ove=
r MTUsig
      CVE-2026-53212: netfilter: nft_tunnel: fix use-after-free on object d=
estroy
      CVE-2026-53217: net: mvpp2: sync RX data at the hardware packet offse=
t
      CVE-2026-53218: netfilter: nft_exthdr: fix register tracking for F_PR=
ESENT flag
      CVE-2026-53219: netfilter: x_tables: avoid leaking percpu counter poi=
nters
      CVE-2026-53221: ip6_vti: fix incorrect tunnel matching in vti6_tnl_lo=
okup()
      CVE-2026-53223: net: guard timestamp cmsgs to real error queue skbs
      CVE-2026-53225: sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
      CVE-2026-53227: net: openvswitch: fix possible kfree_skb of ERR_PTR
      CVE-2026-53228: ipv6: sit: reload inner IPv6 header after GSO offload=
s
      CVE-2026-53238: netlabel: validate unlabeled address and mask attribu=
te lengths
      CVE-2026-53239: xfrm: policy: fix use-after-free on inexact bin in xf=
rm_policy_bysel_ctx()
      CVE-2026-53242: ALSA: PCM: Fix wait queue list corruption in snd_pcm_=
drain() on linked streams
      CVE-2026-53245: net/802/mrp: fix vector attribute parsing in mrp_pdu_=
parse_vecattr
      CVE-2026-53249: ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      CVE-2026-53255: Bluetooth: MGMT: validate advertising TLV before type=
 checks
      CVE-2026-53256: Bluetooth: RFCOMM: hold listener socket in rfcomm_con=
nect_ind()
      CVE-2026-53263: 6lowpan: fix off-by-one in multicast context address =
compression
      CVE-2026-53264: net/sched: act_api: use RCU with deferred freeing for=
 action lifecycle
      CVE-2026-53265: dm cache policy smq: check allocation under invalidat=
e lock
      CVE-2026-53266: netfilter: bridge: make ebt_snat ARP rewrite writable
      CVE-2026-53268: netfilter: conntrack_irc: fix possible out-of-bounds =
read
      CVE-2026-53269: netfilter: synproxy: add mutex to guard hook referenc=
e counting
      CVE-2026-53270: ipvs: clear the svc scheduler ptr early on edit
      CVE-2026-53273: tee: optee: prevent use-after-free when the client ex=
its before the supplicant
      CVE-2026-53337: net: bonding: fix NULL pointer dereference in bond_do=
_ioctl()
      CVE-2026-53339: i2c: qcom-cci: Fix NULL pointer dereference in cci_re=
move()
      CVE-2026-53352: signal: clear JOBCTL_PENDING_MASK for caller in zap_o=
ther_threads()
      CVE-2026-53354: arm64: errata: Mitigate TLBI errata on various Arm CP=
Us
      CVE-2026-53355: net: rds: clear i_sends on setup unwind
      CVE-2026-53356: drm/i915/gem: Fix phys BO pread/pwrite with offset
      CVE-2026-53357: Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs =
l2cap_conn_del()
      CVE-2026-53358: Bluetooth: L2CAP: use chan timer to close channels in=
 cleanup_listen()
      CVE-2022-49803: netdevsim: Fix memory leak of nsim_dev->fa_cookie
      CVE-2022-50114: net: 9p: fix refcount leak in p9_read_work() error ha=
ndling
      CVE-2025-23131: dlm: prevent NPD when writing a positive value to eve=
nt_done
      CVE-2025-39931: crypto: af_alg - Set merge to zero early in af_alg_se=
ndmsg
      CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()
      CVE-2026-31451: ext4: replace BUG_ON with proper error handling in ex=
t4_read_inline_folio
      CVE-2026-31755: usb: cdns3: gadget: fix NULL pointer dereference in e=
p_queue
      CVE-2026-43219: net: cpsw_new: Fix potential unregister of netdev tha=
t has not been registered yet
      CVE-2026-46252: regulator: core: fix locking in regulator_resolve_sup=
ply() error path
      CVE-2026-46331: net/sched: fix pedit partial COW leading to page cach=
e corruption
      CVE-2026-52909: ip6_vti: set netns_immutable on the fallback device.
      CVE-2026-53138: drm/amd/display: Bound VBIOS record-chain walk loops
      CVE-2026-53157: net: phonet: free phonet_device after RCU grace perio=
d
      CVE-2026-53158: misc: fastrpc: Fix NULL pointer dereference in rpmsg =
callback
      CVE-2026-53159: misc: fastrpc: fix DMA address corruption due to find=
_vma misuse
      CVE-2026-53167: fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
      CVE-2026-53177: bnxt_en: Fix NULL pointer dereference
      CVE-2026-53325: agp/amd64: Fix broken error propagation in agp_amd64_=
probe()
      CVE-2026-53329: drm/amd/display: Use krealloc_array() in dal_vector_r=
eserve()
      CVE-2026-53332: slimbus: qcom-ngd-ctrl: Register callbacks after crea=
ting the ngd
    added commits:
      CIP: Bump version suffix to -cip75 after merge from stable

Best regards,
  Nobuhiro


