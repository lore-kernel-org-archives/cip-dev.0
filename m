Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB552C44529
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 12:20:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21273.1784636440788598236
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 05:20:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=FCGWeuf4;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1784636429;x=1785846029;bh=
	uFaO691WC8w0k5nZE4fLiVhfVD2mJSw9psZ94zGq9dw=;b=FCGWeuf42zSuYK3mFGjMwmuzwKuXPC
	LK7EHBY64yyFOANsQZPqs7AjzJa5FmvLkYqGQtuW1I9siTjZAEGqM+no3a3oPW+aVT6sQrnBqDKSe
	qi3uB6lGNow5J8pBxRZTZqeVtQEAVU1+y83INGoO8HNJAFgnyWXbBupCzTweMZrGtqJj+CkDvitB0
	44a2CEPrxPKzBpqmAClQ567b1YFvgmvylZU7faiQH/miq5XvcYs/7gD8XOOm+pjG6JUdsYPsF6c3D
	CVUsgBYgXYKISGTUQ6Db4jnrbbO4WzeLmZhq2d5H3vpAylIrDNrhVt+6qhJOSsOgz2EgNVI0YqWTS
	c6NA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 66LCKRmU2645408; Tue, 21 Jul 2026 21:20:28 +0900
X-Iguazu-Qid: 2yAbkFS0Lzu9kXtuwz
X-Iguazu-QSIG: v=2; s=1; t=1784636427; q=2yAbkFS0Lzu9kXtuwz; m=tioH2GncLNZf6wXfIt7d0W0vmSrswxTkXgL9cGzlguM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4GgG0C5Mz1xnZ; Tue, 21 Jul 2026 21:20:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIVhmcDMHGxzUSambsEyus9tn2YGjnLi5kFzVPE+ya7D5X74sCzjAjcEtLKlCZcgdiNrRtpke8jLRkBsXzUf8Z/79pNo8sGe6v3YVfZ7/o1lbp0tI25anTAmzCNYp8W9Og94NzYhVXq+4+6sjhF4tcU1/SxJ3EOSOytg7Fz5cdw0Alm+zWPTDU+IEzqOi+h2nr1DvZdQAffHl6s7itf7qkImh+SW+sLQcw9M4L2CokBzeKB2WcpANsscZzEJv8w7F6thjCEs+Jx+L6OQhN4OAxgdEC+cbBqE91qokHCh/4r9B4WKD09SZIlSnE7vnefjp/c/joDq8uI9OSUJwDbkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FVvyHpt+gNOoonZW8/cQyf7psYWfNDYJpzJAs6Tey8=;
 b=i8RLI5zuCslWIwRP/N8w21IuU//gqjBEGRZD5aLZfhsdA21N9xbws6iylT47c4wv2UP8gd623DxJb41EvuzJuC50nX1XVV3+S5u+cqlK6RiXaxUcr0x9xG+j4c43PNiEvLlvmy41tqiQizAF4L8fpU165i7sA5SJExnBKvBnebYhxw2ScS7LMVxhk8o+jWFtmPjj85DovoMJ8P8dWuQf1sa1+W1tinx+DS/cupTiacxMreA/pBRUfWoVgedIkl/+QHuHc/ZpOBvuTppSCCi+esitwpjgj1A55/MQeTxcyIkm3QKh7PtkxsAdFF1a8fWOAvgnWEaHISnQLqjZJ+j45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.177-cip58
Thread-Topic: [ANNOUNCE] Release v6.1.177-cip58
Thread-Index: Ad0ZC0aIUxaOU7TnQaSnssxfmNaNIQ==
Date: Tue, 21 Jul 2026 12:20:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A3080106B78557C45BD2CDC22@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15962:EE_
x-ms-office365-filtering-correlation-id: 9928bff7-53d9-404d-314a-08dee7226fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|10067099003|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 R/UcHL+iwVlMADSf/mIbKnHb+LcLoUj1oVJRXHJa/VPWAWiZXx/kqu3CZrV2gPS8yAVssT0TQqCqfxLXgVvotmj9UrBJ7a4KWzA6OD2fRKpfn72B5laqehbNYkGXR/eCaYwWxMDFhJkGePrFqEZrVifO4fIJH9FFSjg0VDbfLXkuaa++s/K89IlOxr2VHwWLmV+vY3+FY7VvYI3VNqVsHxrSvT7M7972Omwza/g4Skm39LvjgGefnw4lusUEWjgVnlH6otbeG9BJ1dvU7+uVo1jp31ECeWHrJQombyf5QZ8VZh6p9RqtzsVCSKdBhoc5mha/v2b9VmzWdfqx7lht9tp9w1X19BjN2He1KPzS+YC+tnCT44gENU3EknH9uZb8iOj+qU9lf0cc43PhEcRPYy8wd1PBY8NdDqU8BO0tU51QuA7DsydMuafiRCY1vxA0miyeMiUUejd2pe2jcqtCGVYhh+GjgXXojQL0PsgxrMcw5z6jrVIzxI4bKYx33I3KCpU67jMTNkg5HqYtF73ZVJPRRPycxTz0GZvqWxLBdKhcOxu4G/yu0A6N3GaudeOsQjN52Y2QrWh0+ToPC8rHn+cNk4kt70etAltkZlfAkzQuIzkzqfhyYo7Znj+pZlOGZKOh47THe1H9mxpdK4bclRxGIj8IzBMO/Ka/pVDVEYSfDoj099OfeldcpsqjWT+efz3t7LQqfsQAm6S5n5UlYCpffkScR1LJ+ASh8G0fbOs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WTA0WDVOREY3cW84Qlc3bXZaN3dhNTlnVG9POE9vTFNYSnNmUXdPcUkz?=
 =?iso-2022-jp?B?VnRiQ1VqOHZBWXltejA3M3JRaDkybXpHaEZTOEdyOWpFWGNNcVlxS2Iy?=
 =?iso-2022-jp?B?SVRZajlWc01UMEw0QThxYUZEZGc0ZjlTR2Q4ZHdBRnZxaUxtUHozOTBE?=
 =?iso-2022-jp?B?bWtZVVpCMHg3aDBBUUNKblVkWTR2RXd0M0lqSE82UXFGSXJWMFhHRGo2?=
 =?iso-2022-jp?B?UHNuTDFiSm9FTC9xb3ZSRVpjMTlyeVV5SmVHWWhHbmRySFhWRGYzclMy?=
 =?iso-2022-jp?B?UnR1eXI2TDdCSGVoMUhFR0J6dVo0OUdTLzVjUER1V05OdkxGa0FDcmpp?=
 =?iso-2022-jp?B?L0MvdzZWT1dlWEZoYWxIK1ZuSlJRSUp2NXF5Z2hOY0lJc0RWazlrTWZt?=
 =?iso-2022-jp?B?OEZKSnVxMXU1cXJUbUd6NDZFS3NHdlhsYjZWZGVKMjZTZVZnc2RkU1BC?=
 =?iso-2022-jp?B?UFV5N0tFcnc0c29nQW5rUlMrNXZYdEtSTTE0M2UyMHg2YlpNYzJDaENy?=
 =?iso-2022-jp?B?b0JwT3V2UTY0ZjZRNTBrVVpzVzZXVTRldWw4UmgzVWc5N2pQN0dVb0pL?=
 =?iso-2022-jp?B?T25uNFZWL0Z4dTlFM1llUXVZM2YvVk1IdGdjVWlGUThtZVZiVmh1cHl2?=
 =?iso-2022-jp?B?QTY1U0YxZG1kaG55dHRSOENZbFpuUjVFeUhPRXJrNVF4eUdzQWtRajg5?=
 =?iso-2022-jp?B?cm9PU1lsckE2L0lpclpRRXEybU9DWWh2MXFQdVpzcGRUVmpBSkNUYTNF?=
 =?iso-2022-jp?B?M2pKSnQ0Vm9yMGhnVzhmUG9yOUo2R1lMZzVvZU00dFMxVk1nclpXcWVl?=
 =?iso-2022-jp?B?ZmFDVTQvQW56VTVwdldnQ1lCSkZrYUpCMkdOL1NVSkw4UW56eWpRbzVZ?=
 =?iso-2022-jp?B?SnlvRHl1cHJsR1M5RCtiOGs5alNQaGlTTXZZZ2doQ09wYkNSditONGht?=
 =?iso-2022-jp?B?eng3LytNOEVXdDBCTktoNExvalh2aXlQaWROcDBsb2g3T2YwSEVsdkE5?=
 =?iso-2022-jp?B?ZXJRYmIwa1ZzUTZqOXFmZTE0VmlyOUxJYkd5Tk5Vek9MUmEvR01GNWI4?=
 =?iso-2022-jp?B?RFhzRXV2T3JlUlhtSmczQ1VnTUw4ckNyUloyUGRkbTFadGxwclBweHAz?=
 =?iso-2022-jp?B?UU1weXNqVlQ0S3hUMGMxREdNOFRpcVoxSDJoSE5qaGZoK3ExUVBjcnVU?=
 =?iso-2022-jp?B?ekM0V1pMSi9vYjMxcm9wa0tHOVFZd1JzcUQ0dGZwa1hGRnBic2J5b1E2?=
 =?iso-2022-jp?B?bm5peXQvOGg0Vkx4ZHQ3V0lNd1dJK2xramVWOUhvTjFsWjlaYnVmejVG?=
 =?iso-2022-jp?B?eUJwUG83c3ZFbVBHYklaanFkblJDWHNDU1dPWU40Uk81UjQ0VXFCdm5S?=
 =?iso-2022-jp?B?KzRnMjJYTDlpdXFEb1hIdG9sdFNXT1I0aW9aTDdzTGxtOFM1NDR4VnZq?=
 =?iso-2022-jp?B?ODdsVDNYT29wUmNPelQvVldEWHdaRUtqNTdhUzFCTDg0TUVPWmFsVUds?=
 =?iso-2022-jp?B?aGdtK081WTF6Wmx0dU90bTZGUHg0Y2hmRFVHdVhodjgwQTByZEtkc3pv?=
 =?iso-2022-jp?B?bHdpQ09UWlM4WVVDb3QreGltQ3U0QVZCa2MxYVl0SHBZbUJsUHB0eHdG?=
 =?iso-2022-jp?B?SDRvS0RNTVA1cGR6VTU5ZzF2VHgzL3dGbGxFRjJySmNoVk1XSGxXOFI5?=
 =?iso-2022-jp?B?R2RxZDVudzlwR1AxaXQ2Y2RpaU0xZFNTa0l6WE9VWGFNRDdmbG51aU9n?=
 =?iso-2022-jp?B?d0sxNXFZK1JKSWx1TElJLzJEbGh5b0g3b2xDZzhoNDNWZDdSb2RkcXhI?=
 =?iso-2022-jp?B?VWdiUlpocjJ3QmVLT2lFSlFoU3ErVjZzVXlJSG84R0lHbkx6bnRVSmJF?=
 =?iso-2022-jp?B?RGd2ZnU0V09HN25uSVd6RWNvTlhTNEd4aVQ2bnZWeUhaMTVhT1VHRFpK?=
 =?iso-2022-jp?B?SG1kelVOWjhhUmdJMHMwc2VrSjZkcGZMV0EvS0w5ck5kaDV5YzViNDdP?=
 =?iso-2022-jp?B?T21VUDZNdVZXeE5VRWF4QjdEcXNHcFVjWVZjQlAxSUxjTCtlTThib00z?=
 =?iso-2022-jp?B?ZTZWbmJxMW9sMS9kV05wcHAzZDJudmdDV0pmTGZIU05YdXdJQ0x3R3V6?=
 =?iso-2022-jp?B?SThOVFFwSXBoaXNPbzZhaGh4b1JJV0xoL1JOUHE1WFhoSFNreWNhYTBz?=
 =?iso-2022-jp?B?d1BYbjIyVnBvZ1dQeGlHVGJZRUJSNStHQWozMEJScGUyYUVnV0owQlZy?=
 =?iso-2022-jp?B?dXBqZXFkNmxpVTZ4dFF3NXZTOW12T3h4Tm90bWREQUhmRmE1M1BUM0Mr?=
 =?iso-2022-jp?B?dGV4Y1ZncnFTWEgzbnl4WENHL2R4aFZYaG5XUkVFZ3VBRUEwN1l0VHN1?=
 =?iso-2022-jp?B?dTcwdEtnZW42TGx4bytDMHo4WTY0YlEvY0tpVGZOYW5IU0t6c2dCalNl?=
 =?iso-2022-jp?B?MjBGbVpxMmRYSmY0YUdDc0dVZ2xJR25TMElKRy9UYWlOczlCL2t5UFFq?=
 =?iso-2022-jp?B?TmZpTDVJVjhxOTQzREptU2FEdzZyUjROS05ZYUFpalc5WmVPdWZkbjlk?=
 =?iso-2022-jp?B?cW15bTZmbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ZB/hrCm32+obVY7aEasEQpr+FJzJReECdTVf7KabZQd8RqK02UHtcgQWsQdz9JO8of+fA/+z5OkGyANFpCK1gVPK61yjXi59ZB65PtgxDVLAHRQUSpun3FmTlN3VfU66S1doR1Vw65KRsXtp1Hy+5f0RlKJliePor9bl86kYj9FiMtHe62fslCX++pOu4VkA0oPEgPtk0w3kjNYvH24XS7YHMrlM4xW/qxL587/oBecG1n180j6d+Ua43j8PnA5stzGlA3Mbvs9moWN9+/K1gUwmwSMOfCJXxIPlkP1+ZwI9acDT5unBsAGfL3Lrw1uWVILGRtN+P8CVMDGc4+yo3g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9928bff7-53d9-404d-314a-08dee7226fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:20:22.7021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6BnyvKlnJeA1SFzcBgMoR7bv4pdwtnecjMx467ZmytGqbKimiC8cgJ4PepywJWmz8pIcsZrI6g3TfgueZVDV6XXuTSdffxdO4tK9SVEV10Ns5N3w5J+zIs03tCzmnVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15962
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 12:20:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23700

Hi all,

CIP kernel team has released Linux kernel v6.1.177-cip58.
The linux-6.1.y-cip tree has been updated base version from v6.1.175 to v6.=
1.177.
In this release, we added DMA and multi-SoC support to the Renesas rzv2h-rs=
pi
driver and enabled PCIe/SDHI in the device tree.

Information about this release is as follows:

  v6.1.177-cip58:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      fc5e5c9987657c209a948e82e24f138430909af2
    fixed CVEs:
      CVE-2023-54125: fs/ntfs3: Return error for inconsistent extended attr=
ibutes
      CVE-2023-54271: blk-cgroup: Fix NULL deref caused by blkg_policy_data=
 being installed before init
      CVE-2024-27012: netfilter: nf_tables: restore set elements when delet=
e set fails
      CVE-2025-10263: TLBI errata in some Arm-based CPUs may allow writes t=
o resources owned by a higher exception level, potentially allowing privile=
ge escalation
      CVE-2026-23310: bpf/bonding: reject vlan+srcmac xmit_hash_policy chan=
ge when XDP is loaded
      CVE-2026-31700: net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpa=
cket_snd()
      CVE-2026-31709: smb: client: validate the whole DACL before rewriting=
 it in cifsacl
      CVE-2026-31712: ksmbd: require minimum ACE size in smb_check_perm_dac=
l()
      CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[] =
in f2fs_write_end_io()
      CVE-2026-31727: usb: gadget: u_ether: Fix NULL pointer deref in eth_g=
et_drvinfo
      CVE-2026-43116: netfilter: ctnetlink: ensure safe access to master co=
nntrack
      CVE-2026-43219: net: cpsw_new: Fix potential unregister of netdev tha=
t has not been registered yet
      CVE-2026-43303: mm/page_alloc: clear page->private in free_pages_prep=
are()
      CVE-2026-43421: usb: gadget: f_ncm: Fix net_device lifecycle with dev=
ice_move
      CVE-2026-43492: lib/crypto: mpi: Fix integer underflow in mpi_read_ra=
w_from_sgl()
      CVE-2026-43495: net: wwan: t7xx: validate port_count against message =
length in t7xx_port_enum_msg_handler
      CVE-2026-45850: ipvs: skip ipv6 extension headers for csum checks
      CVE-2026-45930: net: mctp: ensure our nlmsg responses are initialised
      CVE-2026-45991: udf: fix partition descriptor append bookkeeping
      CVE-2026-45993: LoongArch: Add spectre boundry for syscall dispatch t=
able
      CVE-2026-45996: spi: imx: fix use-after-free on unbind
      CVE-2026-45999: erofs: fix unsigned underflow in z_erofs_lz4_handle_o=
verlap()
      CVE-2026-46003: net: qrtr: ns: Limit the total number of nodes
      CVE-2026-46005: xfs: fix a resource leak in xfs_alloc_buftarg()
      CVE-2026-46021: thermal: core: Fix thermal zone governor cleanup issu=
es
      CVE-2026-46026: net: qrtr: ns: Limit the maximum number of lookups
      CVE-2026-46038: net: qrtr: ns: Free the node during ctrl_cmd_bye()
      CVE-2026-46044: ipmi:ssif: Clean up kthread on errors
      CVE-2026-46052: ceph: only d_add() negative dentries when they are un=
hashed
      CVE-2026-46065: fbdev: defio: Disconnect deferred I/O from the lifeti=
me of struct fb_info
      CVE-2026-46069: wifi: mwifiex: fix use-after-free in mwifiex_adapter_=
cleanup()
      CVE-2026-46083: spi: fix resource leaks on device setup failure
      CVE-2026-46086: net: bridge: use a stable FDB dst snapshot in RCU rea=
ders
      CVE-2026-46091: media: rc: igorplugusb: heed coherency rules
      CVE-2026-46110: net: stmmac: Prevent NULL deref when RX memory exhaus=
ted
      CVE-2026-46116: xfrm: defensively unhash xfrm_state lists in __xfrm_s=
tate_delete
      CVE-2026-46125: wifi: mac80211: remove station if connection prep fai=
ls
      CVE-2026-46137: mptcp: pm: ADD_ADDR rtx: fix potential data-race
      CVE-2026-46159: btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU=
 which can lead to info-leak
      CVE-2026-46160: btrfs: fix missing last_unlink_trans update when remo=
ving a directory
      CVE-2026-46164: btrfs: fix double free in create_space_info_sub_group=
() error path
      CVE-2026-46169: hfsplus: fix uninit-value by validating catalog recor=
d size
      CVE-2026-46180: wifi: brcmfmac: Fix potential use-after-free issue wh=
en stopping watchdog task
      CVE-2026-46190: mtd: spi-nor: debugfs: fix out-of-bounds read in spi_=
nor_params_show()
      CVE-2026-46191: fbcon: Avoid OOB font access if console rotation fail=
s
      CVE-2026-46193: xfrm: ah: account for ESN high bits in async callback=
s
      CVE-2026-46195: smb: client: validate dacloffset before building DACL=
 pointers
      CVE-2026-46196: tracepoint: balance regfunc() on func_add() failure i=
n tracepoint_add_func()
      CVE-2026-46208: batman-adv: stop tp_meter sessions during mesh teardo=
wn
      CVE-2026-46280: lib: test_hmm: evict device pages on file close to av=
oid use-after-free
      CVE-2026-46291: crypto: caam - guard HMAC key hex dumps in hash_diges=
t_key
      CVE-2026-46292: pmdomain: core: Fix detach procedure for virtual devi=
ces in genpd
      CVE-2026-46296: spi: s3c64xx: fix NULL-deref on driver unbind
      CVE-2026-46299: hfsplus: fix held lock freed on hfsplus_fill_super()
      CVE-2026-46314: drm/v3d: Reject empty multisync extension to prevent =
infinite loop
      CVE-2026-46320: tap: free page on error paths in tap_get_user_xdp()
      CVE-2026-46321: tun: free page on short-frame rejection in tun_xdp_on=
e()
      CVE-2026-46322: tun: free page on build_skb failure in tun_xdp_one()
      CVE-2026-46323: net: gro: don't merge zcopy skbs
      CVE-2026-52910: bpf: Free reuseport cBPF prog after RCU grace period.
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
      CVE-2026-52942: netfilter: nf_log: validate MAC header was set before=
 dumping it
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
      CVE-2026-53131: netfilter: require Ethernet MAC header before using e=
th_hdr()
      CVE-2026-53133: RDMA/umem: Fix truncation for block sizes >=3D 4G
      CVE-2026-53134: netfilter: nft_fib: fix stale stack leak via the OIFN=
AME register
      CVE-2026-53135: drm/amd/display: Fix NULL deref and buffer over-read =
in SDP debugfs
      CVE-2026-53136: drm/amd/display: Clamp VBIOS HDMI retimer register co=
unt to array size
      CVE-2026-53137: drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to =
buffer size
      CVE-2026-53146: thunderbolt: Limit XDomain response copy to actual fr=
ame size
      CVE-2026-53147: thunderbolt: Validate XDomain request packet size bef=
ore type cast
      CVE-2026-53148: thunderbolt: Clamp XDomain response data copy to allo=
cation size
      CVE-2026-53149: thunderbolt: Bound root directory content to block si=
ze
      CVE-2026-53150: thunderbolt: Reject zero-length property entries in v=
alidator
      CVE-2026-53159: misc: fastrpc: fix DMA address corruption due to find=
_vma misuse
      CVE-2026-53160: misc: fastrpc: fix use-after-free race in fastrpc_map=
_create
      CVE-2026-53161: misc: fastrpc: fix use-after-free of fastrpc_user in =
workqueue context
      CVE-2026-53168: fuse: reject fuse_notify() pagecache ops on directori=
es
      CVE-2026-53176: IB/isert: Reject login PDUs shorter than ISER_HEADERS=
_LEN
      CVE-2026-53177: bnxt_en: Fix NULL pointer dereference
      CVE-2026-53181: vsock/vmci: fix sk_ack_backlog leak on failed handsha=
ke
      CVE-2026-53182: wifi: nl80211: reject oversized EMA RNR lists
      CVE-2026-53183: mptcp: allow subflow rcv wnd to shrink
      CVE-2026-53184: udp: clear skb->dev before running a sockmap verdict
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
      CVE-2026-53198: ksmbd: fix use-after-free of a deferred file_lock on =
double SMB2_CANCEL
      CVE-2026-53199: hv_netvsc: use kmap_local_page in netvsc_copy_to_send=
_buf
      CVE-2026-53207: mm/memory-failure: fix hugetlb_lock AA deadlock in ge=
t_huge_page_for_hwpoison
      CVE-2026-53208: Bluetooth: L2CAP: reject BR/EDR signaling packets ove=
r MTUsig
      CVE-2026-53209: Bluetooth: hci_sync: reject oversized Broadcast Annou=
ncement prepend
      CVE-2026-53212: netfilter: nft_tunnel: fix use-after-free on object d=
estroy
      CVE-2026-53213: drm/vc4: fix krealloc() memory leak
      CVE-2026-53215: net: mvpp2: refill RX buffers before XDP or skb use
      CVE-2026-53216: net: mvpp2: limit XDP frame size to the RX buffer
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
      CVE-2026-53236: tcp: restrict SO_ATTACH_FILTER to priv users
      CVE-2026-53238: netlabel: validate unlabeled address and mask attribu=
te lengths
      CVE-2026-53239: xfrm: policy: fix use-after-free on inexact bin in xf=
rm_policy_bysel_ctx()
      CVE-2026-53242: ALSA: PCM: Fix wait queue list corruption in snd_pcm_=
drain() on linked streams
      CVE-2026-53245: net/802/mrp: fix vector attribute parsing in mrp_pdu_=
parse_vecattr
      CVE-2026-53249: ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      CVE-2026-53252: Bluetooth: fix memory leak in error path of hci_alloc=
_dev()
      CVE-2026-53253: Bluetooth: bnep: reject short frames before parsing
      CVE-2026-53254: Bluetooth: RFCOMM: validate skb length in MCC handler=
s
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
      CVE-2026-53274: net/smc: fix sleep-inside-lock in __smc_setsockopt() =
causing local DoS
      CVE-2026-53275: ipv6: mcast: Fix use-after-free when processing MLD q=
ueries
      CVE-2026-53329: drm/amd/display: Use krealloc_array() in dal_vector_r=
eserve()
      CVE-2026-53331: slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->l=
ock
      CVE-2026-53337: net: bonding: fix NULL pointer dereference in bond_do=
_ioctl()
      CVE-2026-53339: i2c: qcom-cci: Fix NULL pointer dereference in cci_re=
move()
      CVE-2026-53343: ARM: 9475/1: entry: use byte load for KASAN VMAP stac=
k shadow
      CVE-2026-53349: netfilter: nf_conntrack: destroy stale expectfn expec=
tations on unregister
      CVE-2026-53350: ASoC: wm_adsp: Fix NULL dereference when removing fir=
mware controls
      CVE-2026-53352: signal: clear JOBCTL_PENDING_MASK for caller in zap_o=
ther_threads()
      CVE-2026-53354: arm64: errata: Mitigate TLBI errata on various Arm CP=
Us
      CVE-2026-53355: net: rds: clear i_sends on setup unwind
      CVE-2026-53356: drm/i915/gem: Fix phys BO pread/pwrite with offset
      CVE-2026-53358: Bluetooth: L2CAP: use chan timer to close channels in=
 cleanup_listen()
      CVE-2025-23131: dlm: prevent NPD when writing a positive value to eve=
nt_done
      CVE-2026-23272: netfilter: nf_tables: unconditionally bump set->nelem=
s before insertion
      CVE-2026-23278: netfilter: nf_tables: always walk all pending catchal=
l elements
      CVE-2026-23302: net: annotate data-races around sk->sk_{data_ready,wr=
ite_space}
      CVE-2026-31451: ext4: replace BUG_ON with proper error handling in ex=
t4_read_inline_folio
      CVE-2026-46252: regulator: core: fix locking in regulator_resolve_sup=
ply() error path
      CVE-2026-46331: net/sched: fix pedit partial COW leading to page cach=
e corruption
      CVE-2026-52909: ip6_vti: set netns_immutable on the fallback device.
      CVE-2026-52928: af_unix: Reject SIOCATMARK on non-stream sockets
      CVE-2026-53138: drm/amd/display: Bound VBIOS record-chain walk loops
      CVE-2026-53139: drm/v3d: Skip CSD when it has zeroed workgroups
      CVE-2026-53157: net: phonet: free phonet_device after RCU grace perio=
d
      CVE-2026-53158: misc: fastrpc: Fix NULL pointer dereference in rpmsg =
callback
      CVE-2026-53163: locking/rtmutex: Skip remove_waiter() when waiter is =
not enqueued
      CVE-2026-53167: fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
      CVE-2026-53325: agp/amd64: Fix broken error propagation in agp_amd64_=
probe()
      CVE-2026-53326: debugobjects: Don't call fill_pool() in early boot ha=
rdirq context
      CVE-2026-53327: debugobjects: Do not fill_pool() if pi_blocked_on
      CVE-2026-53359: KVM: x86: Fix shadow paging use-after-free due to une=
xpected role
      CVE-2026-53362: ipv6: account for fraggap on the paged allocation pat=
h
    added commits:
      CIP: Bump version suffix to -cip58 after merge from stable
      i3c: master: dw: stop hardcoding initial speed
      arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0
      arm64: dts: renesas: r9a09g047: Add RSPI nodes
      spi: rzv2h-rspi: Fix silent failure in clock setup error path
      spi: rzv2h-rspi: Simplify clock rate search function signatures
      spi: rzv2h-rspi: Fix invalid SPR=3D0/BRDV=3D0 clock configuration
      spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
      spi: rzv2h-rspi: add support for DMA mode
      spi: rzv2h-rspi: split out PIO transfer
      spi: rzv2h-rspi: enable TX buffer empty interrupt
      spi: rzv2h-rspi: set TX FIFO threshold to 0
      spi: rzv2h-rspi: set MUST_RX/MUST_TX
      spi: rzv2h-rspi: store RX interrupt in state
      spi: rzv2h-rspi: use device-managed APIs
      spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
      spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
      spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
      spi: rzv2h-rspi: add support for loopback mode
      spi: rzv2h-rspi: add support for variable transfer clock
      spi: rzv2h-rspi: add support for using PCLK for transfer clock
      spi: rzv2h-rspi: make transfer clock rate finding chip-specific
      spi: rzv2h-rspi: avoid recomputing transfer frequency
      spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
      spi: rzv2h-rspi: make clocks chip-specific
      spi: rzv2h-rspi: make FIFO size chip-specific
      spi: rzv2h-rspi: make resets optional
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support
      spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
      spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs
      spi: dt-bindings: renesas,rzv2h-rspi: document optional support for D=
MA
      clk: renesas: r9a09g047: Add entries for the RSPIs
      spi: Introduce internal spi_xfer_is_dma_mapped() helper
      dmaengine: Add devm_dma_request_chan()
      arm64: dts: renesas: r9a07g054: Add max-frequency to SDHI nodes
      arm64: dts: renesas: r9a07g044: Add max-frequency to SDHI nodes
      arm64: dts: renesas: r9a07g043: Add max-frequency to SDHI nodes
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable PCIe
      arm64: dts: renesas: r9a09g056: Add PCIe node
      dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support
      clk: renesas: r9a09g056: Add PCIe clocks and reset

Best regards,
  Nobuhiro


