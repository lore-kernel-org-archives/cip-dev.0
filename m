Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67985FF8865
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 06:56:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37218.1777272961402717008
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Apr 2026 23:56:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=jM+C56nO;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1777272947;x=1778482547;bh=
	FdRJ+diwDRkmZJwg6Dw/dKIixTJlcpjkTda24Lal7QY=;b=jM+C56nOKNzs216+f2V0ANER1fWB/F
	XAaWt3fej3jLo+6MO48WaLBuQVO0g/i5UDdR74hW55MrUYq1kodaveXUKBuzBu9qZSu87daQWq09/
	IHP1evSWXaYDiOgWi7ShJ/eQhDiAlVFmECtQ9nrgDbFrTYGBcUp/4pGGp2Di7je2p+x+2JvF3U9a8
	X5/2092hzTfl+aFluM0iCNR66o7jKGH22qsTtCbNEt7RNWKaCljIadVAErnTLZICchcdAP9vsUN8J
	c2pUtBSKHq/K3whklNbdeVkVNaUyuyuegThXP3l4uf9gC57+0MXYAuLpM3HzAEoddUA8jkgruv5cx
	WIFw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 63R6tkfT3121595; Mon, 27 Apr 2026 15:55:46 +0900
X-Iguazu-Qid: 2rWhuNCmtDVxKxhGZs
X-Iguazu-QSIG: v=2; s=0; t=1777272945; q=2rWhuNCmtDVxKxhGZs; m=NOwzDopkDtN7iuJ83QdzF3rp0nFzdxNBUGup+p4HIjM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g3vTr5tQcz4vym; Mon, 27 Apr 2026 15:55:44 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ6HOw5Ig67UutuD/O/3FSF/hljlF/OXxhEgWVPcvD2HpXuKRE6aEPKk41aCRIuS2a1dYhkCIR38gYsHCGQwrShVTH4Unilbe+vDfnue8l+gx37c9O2K4VQouI7JtHk4mtkMGO3pqBQe1WXFOxXZHhNOPDyMk/zXcrbf/CYRfE1vejATAkZCrVGrwqconfIMmap8fO8ulH1dK6FEOSypc4JrtdYK48aVDDxK2DrtgAeObY3D7RHa5FEb0tJ4rTOzcHZ/K7USGAJ6pmYDB5+TWCq4/7XScjF6flVKTT5dQ3Hw1io44dPkFjqov+wznOxeNSXCoAQfsz5DgFOCC9rJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT+XWWe3GAZE03IBQDOPoDtPtXIwjdzPqorzygFiqo0=;
 b=a21OaKSv0Yod0xh612IquFJONzZsDCvYK9KP5JOhmtDqChZ+TPt4NZfNTzOjj9tJ5SNafDbjGgzPXb6OxlBBOtJzarWcwVubI6pVoyiKLcEENfr747pFsLWlZnFymk8tOzhqX/ljrOSWFSpwWkoWlCAs4X1X2oVwzsyB5zvai9F1U68OqlX5rjH+e2ZqZOzw393gedWrZpKYza4/g5pLnT7Hko/MnO0hGT8f5tTPXK3EXiXM2ndAAfbaZvFaPPAF4JuT01ccyoS0uIUopx4Wz3M6ZrIPYlFrh11zSmeWvn7kCydIGD3BtTMwyMob7gRNeoYe5uFvxzWdPRBbCx39Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.169-cip54
Thread-Topic: [ANNOUNCE] Release v6.1.169-cip54
Thread-Index: AdzWEtP8u5TkNQHHQneaBaOkHTv9tQ==
Date: Mon, 27 Apr 2026 06:55:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818ECBCA0F09FDABE720E27CD362@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB17516:EE_
x-ms-office365-filtering-correlation-id: d492793c-7dbe-43c2-f3a6-08dea429fee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 zjdjlu1HNcTX4/z3y5gWBbJBG9ioca3TOBfQvQhcLfP0hblv9af3FpwHa70VHnTuswJR/ln8AtaPHWV+Or0dhBJh/N0KeLdrVf85EoNy6XFa/Zkh2z8izTQIJ2621ItZSdlqe7kzlufLQMM8lnIFb+ETB+JLW4KpolHYhzEz2Rre1Bi7Yj9LmfGWQ7w2yIHaRyMAO3LvukRbKOawdDIp8Wy5EuT7lZEKkSIHn3MbEj9u/cddLIr+FNe/5zNOjWDLpTMhQUVnud9lGlRHTYQIYuO/sd9ujf8gUvrQhEIYnJIPAIDiiV7qeSs5VycgmUoMJ766wqxZnM8KYeAH9ERhFzO/0aIcBAWPj/gD1hH4ABHyfHwFeFL2OG5YDmmjczTFPZj6HHdML3a7eB6YJNVkanDFRsmbYm2mcJ7RZyN5f3IRQchynoGwmJXpKrIEn74fileOBb8mDlxnQqFVsUWq3rRgTORhDQn40UXrVGARk4qsprdolgO/SNmScYjcJrgS3zR1cSaoVXIG+pWeSataLqXcr5s8AlmnCE0gZrPdVv+HACJLDbhys356ge9pp40PNo+4sycB7ak3bWbRxMAuaXNZrnKF32rCl54Ov0NF2zgRj/ATE3tIMEPg9YEmqhFinOmh0UoJk93uc3pzpaN58Zd6FWJCz2NNqrlXQ/Sek9gvBoH3fm249Z6E6gmXvrm5ObcgO0BVbLoHVmkobcNTst1DMoQ5srhknCsJRWXZj18Y2pVepDZmcZzgIpcwZiT+fEEyFq3eJtJTN/MEXLT/T2SIqpB4MAY37lWGYIvOmGY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bGJDSGN5bStzdGllUzR0MldjdXVCTFE4N2Q3YVNuTXdSMmZtTGZjY0RD?=
 =?iso-2022-jp?B?RUs0MW8vajBtRjY3dER3ZHdXVHZaTW9jSU1weFNHc0lVckI4bGROQTBN?=
 =?iso-2022-jp?B?NWJzWmRJSXIwUVZxUllGeEtiNDBLc2pXelR1dThMeFJmcy9Vbld1S29n?=
 =?iso-2022-jp?B?c1FnK01WN1RNTHA5ZDNjcGhkYk82SXgwcUVKUXNOWHA1ZnpuUTc0WERT?=
 =?iso-2022-jp?B?UnJIdUNQQ0VUdFp0NnFzTXFjaEZMTVlPNWYyblZEV3hMVXIxa2JjZVox?=
 =?iso-2022-jp?B?QWJtK2ZCT1ROTVZBZXVyczJ3MjBGcFNHeTVVclUzQmxMWjMzNjB4RS9i?=
 =?iso-2022-jp?B?Z1hWdUFTMFlNY3VzY0tETmVtYzNiclo5OFVEZEhTQ1B3S29vRXB6T0VB?=
 =?iso-2022-jp?B?Wjlad080V1JHdWt6eGZuQlcxUkxrRjFPbjN5R2JkbFM1MlQ5WHlvSjRy?=
 =?iso-2022-jp?B?VVZ2VEFXYXZlRm1LQ2xNaVFqRVFlRlNPRlJGM2hUNnIzSmRRMU1ycnZH?=
 =?iso-2022-jp?B?UmNGR0N2SFV6TXlQMGIzUEJBZUVqZEUwR3puS3MwUGxpQWkvU1F4WXd0?=
 =?iso-2022-jp?B?SThWY3ZlbDVIbTBGZGV2YTAzUVZpTXE0UmZDMGxERk5zRG5aN0t6dTlL?=
 =?iso-2022-jp?B?eWYzYk1ZNXk1bjlsZ25sQmtPL0ovdXZ2T0hOMC8zdzhUUEV3ZzN3MFJM?=
 =?iso-2022-jp?B?VTdXdHR2WGI0ZTR0bHdUTG9NandYVXJoQkM3ZVFLVGF0YXpsdWQ3ZlYv?=
 =?iso-2022-jp?B?eUxwUGo0QUQ4cDJSRWhucW8wYlQrOU54cTJHS3FHcGVEc3hnVHNiUmx4?=
 =?iso-2022-jp?B?RVFoTFh2cHRjNHM0UDNBOXdFL2JjNWgxMDRIR25zcjJBOU5LSUF3djJa?=
 =?iso-2022-jp?B?RGNXakY4MEFoQ3cyWk1oT2doLzJhaStWVkpnRHdNb2x4bEtxY0huWklY?=
 =?iso-2022-jp?B?NjhIYkVpbnMzUE5IcWZiMlZ1VGNueHl4RE83MDNNaWcxOFE4a2ZIcVpw?=
 =?iso-2022-jp?B?U1ZWSmNZT1dTeXhhYW1HM0RsRlZOczJ5eFVnMjJHdUdRcndidW5kam9j?=
 =?iso-2022-jp?B?VVJCd3F0Sm9WQkxkTHVLVkNjUkdPYXI0UE1TOEhpVkhIWHNXOXk1YjFj?=
 =?iso-2022-jp?B?bExsLzZMVEM3K0JxMXlPVE9WTTFVNXdNME9OeVZMcjRkdzcxUkh1MC9o?=
 =?iso-2022-jp?B?a1J5N1Y1ZlVYR2hwMnVSOGtBQVlhczBGWEd0N3VzekxRNzQ1OW11eDUw?=
 =?iso-2022-jp?B?cGNMeUh6M1dYNEdVazZKVWFucGxISy9pY01NRGRuMjg1YURPZnJ5TkxB?=
 =?iso-2022-jp?B?VzhqajI5WG00V2tHVTVEbzBjamx6RjF1SWtEMkFCT3MvNFh2MnptWFVD?=
 =?iso-2022-jp?B?RjdsTHVVbTBFdE5RNUNaZk9WM3VyRDlhRW1tV0hGOEpDOXQwU1JDYjRL?=
 =?iso-2022-jp?B?UWhOaVU5L0xnOC9saHBOSEk5UGFCWE9HbHh6ZVJyRUR4WjB0akQ2aWU2?=
 =?iso-2022-jp?B?Wk10Y2RIYlpQcjVmamhTYWRGNldPVUlYaUhVbGp6YWdVYWJnalc3QVk0?=
 =?iso-2022-jp?B?ZGFFNUE5Wk13c0o1VlNSNVV0cDdiU1d2djE3TW12cE5DdjhNa3ZQODRp?=
 =?iso-2022-jp?B?bEZ1TDJ6YmwvN29hYkc3NCs2ZDd0N2NFa2VLcWI5ZGIvRFljMFN0Z2dM?=
 =?iso-2022-jp?B?WGYzUVh1NytjVzB2VTFLR204Y2U5NGpaRTNtRGFhOHdXVU1ETTQ2WTZX?=
 =?iso-2022-jp?B?c1dwSktrWG5NOXhnVnNqV25WYWlDYk9Nbit4YmZQQ0JFT3k5ejBQN2Nl?=
 =?iso-2022-jp?B?V3MySUlzSFNqN3RsamhYVEM5eTNvT1prbVhwUldDazJPeFFFZEJDSzBM?=
 =?iso-2022-jp?B?SFJ6bWg4cU5OTWRPaVlzY1FscTI4b0lTY1B3TEErMWVPREhFalBvenFO?=
 =?iso-2022-jp?B?WEY0cmdoQVQxMC91dGIxQW52b0xGWCtvWDlINlc1d3A4enZOWmY3Y1M2?=
 =?iso-2022-jp?B?UnpkVmxMeGZybDAvNUxRdnB6RDBZU1haZTRUOHBKKzFaRFZVWXNHdHRR?=
 =?iso-2022-jp?B?SlVxRGJpY09Ed1JidUphRnNoQk9ETjZUNCtJYkZnSHp2WFFWRWQ0M1RV?=
 =?iso-2022-jp?B?RG1uUHZueUljenNaSnU4MnJjQXZFa3Rja3BmS0I1SWkxc0ZhaldXeHVk?=
 =?iso-2022-jp?B?OG5oS080RFppVEVFbElYTWlyUFJYaTNaODhlY09aT3RZSk1VeUJ3L05M?=
 =?iso-2022-jp?B?WFJsci85N1hTbEZxeVF0M0MzQklwNm5UbkFLaXc5L1B3Y0YrYjJwdlhS?=
 =?iso-2022-jp?B?SVRPbnJmTzJYb3VyaFVkUjhNdDZ6ZmtIbWp0bzN1TFRlTkhISGdjTTBN?=
 =?iso-2022-jp?B?VWVhZTRjd1ZUeFZVa2FtNXdIZmhVMU1wMEpHNjMxKy9YWkpUVkFCbmNa?=
 =?iso-2022-jp?B?MHAvdmhLVkhkV1dpeXZFU0FlUnpKYUxkTmtCNWNyM1RQYXFwUk1TenlK?=
 =?iso-2022-jp?B?ZGNCR2szaUFFMkxEaGx5OFZGV0t3cGNIaFpmMzB5NjNHZmltZ1RMRmE2?=
 =?iso-2022-jp?B?djFvWGpnRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Sf4QtHc0jnbXW7E2KkGpionTIToG92sX6S6+4Sx68NguJ2qfs4Qky8EoVAZBh37vy+zPxuCo14U7iF26KhBJitz6hfXhjZwwNkiyc9qBlFCmEpIGcVQytHeGhtQYIYG72j1FVg3VinRdCylEor8Dzs8IG3hxzrAnOsqcpE080lMw1SyAWqEF6GN8n+6FJBW9vHY6mVGczdPwSTXuxZbc6/C0K1mAsqVYJ1/7Pzb53ah4rCL8gx0bYBA5URSLRMofaZopKHXYYesQGveihFCGi9C5/dp5ijjLOtzKaANAgoPHW5vf9dM5pUbfL+Mz4llCALZTwzIAL+gVxMufwCT2gg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d492793c-7dbe-43c2-f3a6-08dea429fee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 06:55:41.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGjI8Vo5L77/PYaI4wyMxobnQ9HMj3oCVJF9kE8R2RcJVgj6TtRyhTGM2ckKXAW7xsmoDsOpejuwYFtNwHi2VaLki9wGvxYQl9p+GAVvNZgIvwQTOyLkScaCvhL1NgSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17516
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Apr 2026 06:56:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22812

Hi all,

CIP kernel team has released Linux kernel v6.1.169-cip54.
The linux-6.1.y-cip tree has been updated base version from v6.1.167 to v6.=
1.169.
This release includes RSPI, TSU, PCIe and CANFD updates for the Renesas ARM=
64 SoCs.

Information about this release is as follows:

  v6.1.169-cip54:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      99547ba00a2b5eec3dbc833600405443c5040b65
    fixed CVEs:
      CVE-2024-47736: erofs: handle overlapped pclusters out of crafted ima=
ges properly
      CVE-2025-37945: net: phy: allow MDIO bus PM ops to start/stop state m=
achine for phylink-controlled PHY
      CVE-2025-37980: block: fix resource leak in blk_register_queue() erro=
r path
      CVE-2025-38303: Bluetooth: eir: Fix possible crashes on eir_create_ad=
v_data
      CVE-2025-40242: gfs2: Fix unlikely race in gdlm_put_lock
      CVE-2025-71269: btrfs: do not free data reservation in fallback from =
inline due to -ENOSPC
      CVE-2026-23360: nvme: fix admin queue leak on controller reset
      CVE-2026-23401: KVM: x86/mmu: Drop/zap existing present SPTE even whe=
n creating an MMIO SPTE
      CVE-2026-23414: tls: Purge async_hold in tls_decrypt_async_wait()
      CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame(=
) due to missing sock_hold
      CVE-2026-31414: netfilter: nf_conntrack_expect: use expect->helper
      CVE-2026-31415: ipv6: avoid overflows in ip6_datagram_send_ctl()
      CVE-2026-31416: netfilter: nfnetlink_log: account for netlink header =
size
      CVE-2026-31417: net/x25: Fix overflow when accumulating packets
      CVE-2026-31418: netfilter: ipset: drop logically empty buckets in mty=
pe_del
      CVE-2026-31421: net/sched: cls_fw: fix NULL pointer dereference on sh=
ared blocks
      CVE-2026-31422: net/sched: cls_flow: fix NULL pointer dereference on =
shared blocks
      CVE-2026-31423: net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      CVE-2026-31424: netfilter: x_tables: restrict xt_check_match/xt_check=
_target extensions for NFPROTO_ARP
      CVE-2026-31425: rds: ib: reject FRMR registration before IB connectio=
n is established
      CVE-2026-31426: ACPI: EC: clean up handlers on probe failure in acpi_=
ec_setup()
      CVE-2026-31427: netfilter: nf_conntrack_sip: fix use of uninitialized=
 rtp_addr in process_sdp
      CVE-2026-31428: netfilter: nfnetlink_log: fix uninitialized padding l=
eak in NFULA_PAYLOAD
      CVE-2026-31433: ksmbd: fix potencial OOB in get_file_all_info() for c=
ompound requests
      CVE-2026-31434: btrfs: fix leak of kobject name for sub-group space_i=
nfo
      CVE-2026-31441: dmaengine: idxd: Fix memory leak when a wq is reset
      CVE-2026-31446: ext4: fix use-after-free in update_super_work when ra=
cing with umount
      CVE-2026-31447: ext4: reject mount if bigalloc with s_first_data_bloc=
k !=3D 0
      CVE-2026-31448: ext4: avoid infinite loops caused by residual data
      CVE-2026-31450: ext4: publish jinode after initialization
      CVE-2026-31452: ext4: convert inline data to extents when truncate ex=
ceeds inline size
      CVE-2026-31453: xfs: avoid dereferencing log items after push callbac=
ks
      CVE-2026-31454: xfs: save ailp before dropping the AIL lock in push c=
allbacks
      CVE-2026-31455: xfs: stop reclaim before pushing AIL during unmount
      CVE-2026-31458: mm/damon/sysfs: check contexts->nr before accessing c=
ontexts_arr[0]
      CVE-2026-31464: scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targe=
ts_done()
      CVE-2026-31466: mm/huge_memory: fix folio isn't locked in softleaf_to=
_folio()
      CVE-2026-31467: erofs: add GFP_NOIO in the bio completion if needed
      CVE-2026-31469: virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELE=
ASE is cleared and napi_tx is false
      CVE-2026-31473: media: mc, v4l2: serialize REINIT and REQBUFS with re=
q_queue_mutex
      CVE-2026-31476: ksmbd: do not expire session on binding failure
      CVE-2026-31477: ksmbd: fix memory leaks and NULL deref in smb2_lock()
      CVE-2026-31478: ksmbd: replace hardcoded hdr2_len with offsetof() in =
smb2_calc_max_out_buf_len()
      CVE-2026-31480: tracing: Fix potential deadlock in cpu hotplug with o=
snoise
      CVE-2026-31483: s390/syscalls: Add spectre boundary for syscall dispa=
tch table
      CVE-2026-31485: spi: spi-fsl-lpspi: fix teardown order issue (UAF)
      CVE-2026-31492: RDMA/irdma: Initialize free_qp completion before usin=
g it
      CVE-2026-31494: net: macb: use the current queue number for stats
      CVE-2026-31495: netfilter: ctnetlink: use netlink policy range checks
      CVE-2026-31496: netfilter: nf_conntrack_expect: skip expectations in =
other netns via proc
      CVE-2026-31497: Bluetooth: btusb: clamp SCO altsetting table indices
      CVE-2026-31498: Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len i=
nfinite loop
      CVE-2026-31503: udp: Fix wildcard bind conflict check when using hash=
2
      CVE-2026-31504: net: fix fanout UAF in packet_release() via NETDEV_UP=
 race
      CVE-2026-31507: net/smc: fix double-free of smc_spd_priv when tee() d=
uplicates splice pipe buffer
      CVE-2026-31508: net: openvswitch: Avoid releasing netdev before teard=
own completes
      CVE-2026-31509: nfc: nci: fix circular locking dependency in nci_clos=
e_device
      CVE-2026-31510: Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_re=
ady_cb
      CVE-2026-31512: Bluetooth: L2CAP: Validate PDU length before reading =
SDU length in l2cap_ecred_data_rcv()
      CVE-2026-31515: af_key: validate families in pfkey_send_migrate()
      CVE-2026-31518: esp: fix skb leak with espintcp and async crypto
      CVE-2026-31519: btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol cr=
eate
      CVE-2026-31520: HID: apple: avoid memory leak in apple_report_fixup()
      CVE-2026-31521: module: Fix kernel panic when a symbol st_shndx is ou=
t of bounds
      CVE-2026-31522: HID: magicmouse: avoid memory leak in magicmouse_repo=
rt_fixup()
      CVE-2026-31523: nvme-pci: ensure we're polling a polled queue
      CVE-2026-31524: HID: asus: avoid memory leak in asus_report_fixup()
      CVE-2026-31555: futex: Clear stale exiting pointer in futex_lock_pi()=
 retry path
      CVE-2026-31563: net: macb: Use dev_consume_skb_any() to free TX SKBs
      CVE-2026-31565: RDMA/irdma: Fix deadlock during netdev reset with act=
ive connections
      CVE-2026-31566: drm/amdgpu: Fix fence put before wait in amdgpu_amdkf=
d_submit_ib
      CVE-2026-31570: can: gw: fix OOB heap access in cgw_csum_crc8_rel()
      CVE-2026-31674: netfilter: ip6t_rt: reject oversized addrnr in rt_mt6=
_check()
      CVE-2026-31678: openvswitch: defer tunnel netdev_put to RCU release
      CVE-2026-31679: openvswitch: validate MPLS set/set_masked payload len=
gth
      CVE-2026-31680: net: ipv6: flowlabel: defer exclusive option free unt=
il RCU teardown
      CVE-2026-31682: bridge: br_nd_send: linearize skb before parsing ND o=
ptions
      CVE-2025-38436: drm/scheduler: signal scheduled fence when kill job
      CVE-2025-40016: media: uvcvideo: Mark invalid entities with id UVC_IN=
VALID_ENTITY_ID
      CVE-2025-54505: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-23268: apparmor: fix unprivileged local user can do privileg=
ed policy management
      CVE-2026-23269: apparmor: validate DFA start states are in bounds in =
unpack_pdb
      CVE-2026-23403: apparmor: fix memory leak in verify_header
      CVE-2026-23404: apparmor: replace recursive profile removal with iter=
ative approach
      CVE-2026-23405: apparmor: fix: limit the number of levels of policy n=
amespaces
      CVE-2026-23406: apparmor: fix side-effect bug in match_char() macro u=
sage
      CVE-2026-23407: apparmor: fix missing bounds check on DEFAULT table i=
n verify_dfa()
      CVE-2026-23408: apparmor: Fix double free of ns_name in aa_replace_pr=
ofiles()
      CVE-2026-23409: apparmor: fix differential encoding verification
      CVE-2026-23410: apparmor: fix race on rawdata dereference
      CVE-2026-23411: apparmor: fix race between freeing data and fs access=
ing it
      CVE-2026-31533: net/tls: fix use-after-free in -EBUSY error path of t=
ls_do_encryption
      CVE-2026-31628: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-31634: rxrpc: fix reference count leak in rxrpc_server_keyri=
ng()
      CVE-2026-31649: net: stmmac: fix integer underflow in chain mode
      CVE-2026-31651: mmc: vub300: fix NULL-deref on disconnect
      CVE-2026-31656: drm/i915/gt: fix refcount underflow in intel_engine_p=
ark_heartbeat
      CVE-2026-31657: batman-adv: hold claim backbone gateways by reference
      CVE-2026-31658: net: altera-tse: fix skb leak on DMA mapping error in=
 tse_start_xmit()
      CVE-2026-31659: batman-adv: reject oversized global TT response buffe=
rs
      CVE-2026-31660: nfc: pn533: allocate rx skb before consuming bytes
      CVE-2026-31661: wifi: brcmsmac: Fix dma_free_coherent() size
      CVE-2026-31662: tipc: fix bc_ackers underflow on duplicate GRP_ACK_MS=
G
      CVE-2026-31664: xfrm: clear trailing padding in build_polexpire()
      CVE-2026-31665: netfilter: nft_ct: fix use-after-free in timeout obje=
ct destroy
      CVE-2026-31667: Input: uinput - fix circular locking dependency with =
ff-core
      CVE-2026-31668: seg6: separate dst_cache for input and output paths i=
n seg6 lwtunnel
      CVE-2026-31669: mptcp: fix slab-use-after-free in __inet_lookup_estab=
lished
      CVE-2026-31670: net: rfkill: prevent unlimited numbers of rfkill even=
ts from being created
      CVE-2026-31671: xfrm_user: fix info leak in build_report()
      CVE-2026-31672: wifi: rt2x00usb: fix devres lifetime
    added commits:
      CIP: Bump version suffix to -cip54 after merge from stable
      clk: renesas: Add missing log message terminators
      clk: renesas: rzg2l: Remove DSI clock rate restrictions
      clk: renesas: Use IS_ERR() for pointers that cannot be NULL
      drm: renesas: rz-du: mipi_dsi: Set DSI divider
      drm: renesas: rz-du: mipi_dsi: fix kernel panic when rebooting for so=
me panels
      drm: renesas: rz-du: Implement MIPI DSI host transfers
      drm: renesas: rz-du: Add atomic_pre_enable
      arm64: dts: renesas: r9a09g057: Add RSPI nodes
      arm64: dts: renesas: r9a09g056: Add RSPI nodes
      clk: renesas: r9a09g057: Add entries for the RSPIs
      clk: renesas: r9a09g056: Add entries for the RSPIs
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
      arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
      spi: Add driver for the RZ/V2H(P) RSPI IP
      spi: dt-bindings: Document the RZ/V2H(P) RSPI
      arm64: dts: renesas: r9a09g056: Add TSU nodes
      arm64: dts: renesas: r9a09g056: Use syscon compatible for the system =
controller
      arm64: dts: renesas: r9a09g056: Move interrupt-parent to root node
      PM: domains: Add RZ/V2N compatible to PM domain detach list
      clk: renesas: r9a09g056: Add clock and reset entries for TSU
      dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
      dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
      arm64: dts: renesas: rzg3s-smarc-som: Set bypass for Versa3 PLL2
      arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
      arm64: dts: renesas: rzg3s-smarc: Enable PCIe
      arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
      arm64: dts: renesas: r9a08g045: Add PCIe node
      arm64: dts: renesas: r9a08g045: Use syscon compatible for the system =
controller
      PCI: rzg3s-host: Fix device node reference leak in rzg3s_pcie_host_pa=
rse_port()
      PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTR=
CVIS
      PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
      PCI: rzg3s-host: Initialize MSI status bitmap before use
      PCI: Add Renesas RZ/G3S host controller driver
      dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
      PCI: Move link up wait time and max retries macros to pci.h
      PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAI=
T_MS
      PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
      genirq/msi: Silence 'set affinity failed' warning
      lib/bitmap: add bitmap_{read,write}()
      clk: renesas: r9a08g045: Add PCIe clocks and resets
      arm64: dts: renesas: r9a09g057: Add CANFD node
      arm64: dts: renesas: r9a09g056: Add CANFD node
      dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N S=
oCs
      clk: renesas: r9a09g056: Add entries for CANFD
      clk: renesas: r9a09g057: Add entries for CANFD

Best regards,
  Nobuhiro


