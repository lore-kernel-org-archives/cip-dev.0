Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873EFFF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 01:37:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32898.1777253851526716626
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Apr 2026 18:37:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=h0VoYeKu;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1777253836;x=1778463436;bh=
	naXsFSsOf9PT3ED5MYLoZ1cwOBpfo6EALezbgeUOiTM=;b=h0VoYeKux9AHSoIazcyB0a39Cs+cCX
	fvk9633KQXTkSU3upEwevnDF3RjBZf/HH9aaUzvbm9IGoA8Iq59YaOWxB4XEMJMZj8fZ6OhkMzdD8
	I2PmCkrD0X9rqN/lLH4+U7Ex6M8CQHCVTsip60SdaQ7PmdMiXAywOMSX0WJQ8TSMBaGcINVi0k4JY
	RtckXsM5E3ofz302D/fCSnP9T9uldqk9ujteyf1O1WIhplxThyO63ZaXvVWCrVwtz84kIBSanN3jm
	cJlLyYndJPrxnM0Az8zWl4ADAyCEOJXSuUOGaVYunss0RZHatG8bVCzxLdBl67lrAg8tdp3ms3B87
	qX3g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 63R1bEwq071193; Mon, 27 Apr 2026 10:37:15 +0900
X-Iguazu-Qid: 2rWhBcKdnnZ28VZFGH
X-Iguazu-QSIG: v=2; s=0; t=1777253834; q=2rWhBcKdnnZ28VZFGH; m=QLE7BN/LOr34dB/1AwPuaLBhcb2cCWSt157CT15pdlU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g3mQK2CNgz4vyq; Mon, 27 Apr 2026 10:37:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBFWkcgs9H4hCBiDIZGNfqoLGOjaFm9fj10mxwq5/simgsgLNg/yzW0J5KESIVyJr5Pz5as+v8mMdD6j8qIFP7wLvvauHh7o5aKd780VgJG6/m+J+xHyMMNjH0ECmLlgtUjgAocevzdKRWV/bnbbkqyrXJ9eb4T4UA+K2DXw5WNJJqmCFbHtvTnhDW+lKY8INAGbImlP3tInkiU3KoAixVMwea9GIWJWLaPnO1uyLIOuv6WHcyMya+3d68Pwz+AFTcK7iG0sXETxpynOQNE/XoIJvimi6yoAIb953swZBw88l/lQ+fu26nBqQlOEFLxTLdbslEDx+R45PsfM6QjeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLB3GxSHCNPaE3YNQUVBCZU5XC43LmnHQ3wcmZnATXE=;
 b=UZAva2MKO6AzUhHr7ZH/oqQEEpwEz66SwmWDrpEG5Utjd7zBOcJ+U3paB0s9pIbQYAGlXAejYeUQhN1wur/m+uScqZresEWLX+gAi9FT1Zk74Yf0NJiiyfmwXNZ6jX8wZTamLFynoVnNZAMXmPc2C+zsUAVVMFcKaeSq3pBqOPzzKB//sLZmtV42R5QBOhTj0Zu7VVkELsXh+Ke+CEgPZzg3Or1v0auo3zbbZLcXLa4sCTM8LppxUDW2VFvN3RCnHymA40nhmzuMPcnHuubYQR/gFwMuHIiU0LuDzJrvAgPT9RYLrz0n3OOMRC9ttmYo3F78gkjvN7dOxh0noWIScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.brandt@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.83-cip21
Thread-Topic: [ANNOUNCE] Release v6.12.83-cip21
Thread-Index: AdzV5jIOTw/9U7oaTROrD1KSPvxgJQ==
Date: Mon, 27 Apr 2026 01:37:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D035DFC17A1AF6FF19E5CD362@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9526:EE_
x-ms-office365-filtering-correlation-id: 8f81a201-fd2b-4095-342c-08dea3fd802a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 JeRi6tpHn/ah0F2QlwyO3TCdU8rwV14cnHc8iOv/hK3ha0HkkcGBDCy1e72ECwcflaA+eZTPuk4/RcPeexi+VhQ/qBlb8zzVkOhVVcMGj+x1mp+wQd0qVG+p+w1KevZkxQwsJ2d7kZ+Vi7WgQAMr31/PTF2DNnVZ3LLdjQH1FBEhadHMgWeJEQ9E1pggJGUW4LPsXh1RHLiD1/jNuSyqFBcZVYHSuRuTQchX8yZrXrd1ombfju4mVSggL4l5a9ZX+WngvzNlp6qc1Pwbwx6wCrR7Xe7CpkbHMvQLE6TsO98ZoA3RddeyIy+mdbqJiEcGz96QwvSYSwQoxoGzRkggBdWxi/txlvzuGrgOgFwz0Bu20bhFwo9n8sYhcC2bTDK/ZvLKVJYTPBbuE9uKi1QPU8H6unuXSq+1sjUCymzQai0x5aeDMHBgM2JY6IbSN7yGyH0xv3DF39ZL1SRx5GDMc46qdyt/lVKXY5bbck7LjnAm2mSZ55NGKHQPGp3zsKNMn88ObOB+oHmhx/t5EVglmT9bpQLiLcc2n97d3GFjKiT6GtsxjU+pcVjHU76KCLv3UhhCe+ZmAz/ouPLxI/jcfTeAHY/Q2KyamILqT26iQA5dQAMA60svBRBsft7gLfUyNQpDBzW2Tt6kcmzIMIDi3sMt2ieET2i02/znqERT4JTnLoMPILWKJt9imVzr0w0QQ55b073D3nf6uOSAtclOuzA5vrQlmnWmP1DotK+fyqC6T8Ek/HUWqiuUd6iNewyJ9l2cfhEWqTCsbRi5b27sIkmdthJhpSulKdJ8JC9iQrk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RFY4YkRUS0Z5alhOUWw1ckZyUnRzVDQwZm9UenpDVlJqd0ZuY1hZamtk?=
 =?iso-2022-jp?B?OWdSSi9ZNzF0bm1IVGVwN0dESlp4cjVvNkdQV2lRNlJWSEZmT0dJbnIv?=
 =?iso-2022-jp?B?Y3RHV0UzZ203K0R2RnJMQURHU0NpMmdjZjRGQW85clNkK1pjL2tSeVZX?=
 =?iso-2022-jp?B?OTVSNCtWSnpRb0pBZ1hqcGRsL3J3ZUxpNktPTUp5RExyNFJoSm4rNFlZ?=
 =?iso-2022-jp?B?RUpYeTZjWERGclRlemRxMDRhd21na2tuS0pLY21VbEU5bTYyUXpyYi9P?=
 =?iso-2022-jp?B?ZVpMNzlDYldVc1dMRWZyN056ZTRnanl2Q09oVDE2ZGZoT2dTSk5ZVkFC?=
 =?iso-2022-jp?B?YjRkcVpIOEhPTFhWR3NEbTVvNWhBR28xaThZcTNIeXpGVXdnbmtSMVZR?=
 =?iso-2022-jp?B?ZG15UitsRTVEVzFzaUlVcmNPYk91TTJ5Mm5rMTRxbTU3aXMvL1lqTk9D?=
 =?iso-2022-jp?B?cGhpZ1RJOEI0NEVtQkpyR1FzVGhUaVJaZVNyZHVJODBaTFFGblcrNUtO?=
 =?iso-2022-jp?B?dzZYaXQvNHoybGIvc1ZKM0gzU1dTZjEzMHhPWWVFSWxxSW9Sakp5WC93?=
 =?iso-2022-jp?B?MWhpZ28yQjVCZm12aWRDNkE1TkNJb2tBcm5FVUlIVHR1VWpzd3pzOG16?=
 =?iso-2022-jp?B?M0tPeEFTSTNUSGNUUHlGTGZ4S2hkVEZVcUV1YWk4ZjJLZmNVaEVwYWZB?=
 =?iso-2022-jp?B?RFpOQVBKaVVsbWRDSnNjcVViV1JmaFFWbC9vUmNwWXFTV2VWNUVRTWtq?=
 =?iso-2022-jp?B?RW5Zeng0YldOSEJ3YThzSVFZSlQ5M1BWZE0wQVE0TFlLNDZIV2IzbHUw?=
 =?iso-2022-jp?B?bFZvUUlqNkRKRk5oQnpHdkNUOEVTWVl5UUltWnY2S0MvMWNKamtJN0hV?=
 =?iso-2022-jp?B?dWFMZDBtZEhJeHAvRWJKOTFOaDNCYTdZdlF4b2JwbVhHczIwaHlodW9X?=
 =?iso-2022-jp?B?OUNGQlVMaEFGL3daRnNHWm5mT3hZeFg4VE5RcUFJVndTZFhCN3NvQ1lF?=
 =?iso-2022-jp?B?dzlYSzhwSFMzL1llRlJPNXl2eXRJMWIzd1U4WWJkMFFodEZnTjlBVVRO?=
 =?iso-2022-jp?B?cmMrMnZFc3B0d3JwZS9YMThRZU1NSTNMUEpiQXZyVFlrU3h6YW4yL3Bv?=
 =?iso-2022-jp?B?Y3lpeUZLUzlMN3N5c2FUaFdJVkJpSU4wNzJPMzFVZG5DZlpQdW1QanZJ?=
 =?iso-2022-jp?B?cjd5cTRmTTZBd3pPMWdjMTNGbkZudzFFM0pEY0c3WndJUlZIempGakRw?=
 =?iso-2022-jp?B?L2FYRlg0ZDE0RVlOa1AxdkpFNERmY0IvOHBHV0VJT1ZjN0ZGdktXRkJF?=
 =?iso-2022-jp?B?d0hYZWV0MXdnandZQWZVeWdVdDgyVWZkL09vNCtjaXZuVXhlOFJ0cTAv?=
 =?iso-2022-jp?B?STY3VE0rZW90OGNwUFFuWXlNdFVMRlZwZ1hzOU5LTmlrVVgzRzJhS2p3?=
 =?iso-2022-jp?B?Wlhtb2d2clREWkcrd1NOSnJSa3l2aGIzcEZXSHNBVW5wcEtGMjVuYkZC?=
 =?iso-2022-jp?B?MDhQWlp0bkpmcXJ0U2dyTTJOY2hzS2dkU01hdFNqNTY2WVlIbmhPcFY3?=
 =?iso-2022-jp?B?TkorVzlUNTk4amFiWHcrZlIyMUNIVTZYR1VzSnh2ME5MSE95M1FlTG1h?=
 =?iso-2022-jp?B?aGd3MUo5YVorbkJaZGRhSUJWUWtjZDgvdE82ZmIrUzBrVkJLTGNpL2RC?=
 =?iso-2022-jp?B?Wm1hZklrbWY0bmNpTiszbkgyTzMwaEU0L3p1azVmNzJKaUR4Zm5ndkpK?=
 =?iso-2022-jp?B?UUdjZ1FwWTNKRXlsbUlEMU5tS2VNL2lFWVVXTU9pZ2paVzAxWm9OTGdk?=
 =?iso-2022-jp?B?YmZRcXF0SVpiZEZ6SnRiU2FhUXM4cUdUNWt5bTVEL2VGY1hPRUZRYlZ2?=
 =?iso-2022-jp?B?emhyVm9zWkNTcXpVSkZWakxySHd5STA4STQ2Kzc3YW5INEE5bDNWdk53?=
 =?iso-2022-jp?B?ZURtNTlza0c3TWtLNEtlY2J0YTNiM2VwTUY3YnVTeWhaNVdJOFhneU1T?=
 =?iso-2022-jp?B?bjdOWXJGOG1Qc0tyZnJqMCt4K1d6NnNlaW85TFRtZmxwT1RoY29GREJm?=
 =?iso-2022-jp?B?Q1l1QjFjMVdhbmtidlNlaUt4b3NCTTZxMVpwNjR4alMwaDQ0aldYTWtK?=
 =?iso-2022-jp?B?a2FUSkJ2bkJDVlhLTlBObTdCcVJZZ0VsZzNvNEpOUkEvdEVDdDhxaStP?=
 =?iso-2022-jp?B?ejN6K2lDQ0VDOFpEMUZmQU83OVFuREVBZTBBTlJFOVQrQ1YrMHFBYmZK?=
 =?iso-2022-jp?B?VWZ3SXplK0p5NlJVQmtKRFlyWERvbFVxNk42Y1I0ZmxiaDJZS2ZpbWNv?=
 =?iso-2022-jp?B?TUw0NFk5d00xQm4yYWRXKzVIOWhOZytCRFVrdmkzKzlHQythaS9jUUZK?=
 =?iso-2022-jp?B?NzdDUWd4UjA2T0QxUGhSZGw4Z2NaZ1RHT0VYTktHRER1aXJEeEFYdXM1?=
 =?iso-2022-jp?B?OWp3SFhKMnZWZ0kwRkpmZ3VMbTFXZkFBQm5FZUFQNXpNMEsyV25mb2NY?=
 =?iso-2022-jp?B?dXhoZE92WTdVM1JJYzBCRUgxS2xTN3V4N2FONmdXNTgyU3IvWDdNWGJs?=
 =?iso-2022-jp?B?VEM0K0ViND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	aVaiom8cyuRWHNtEJXsG099KwAmB7mlQMQ2DyWm5BlEqPr5MhYTXxc0GFQ77UIeNSVgSRzfk1whaZbNe0e1SOR9fHY1ZUvuVMB24+Wk4vTXgrRtbxOllmqHm5PAijD5tE/4ZC6J69hgW0QDjZfkdRcjxbtA0qfx5+oHyd2c2GuNIflZrPOUngMWndXPFZEJsvElQl53Zf5cRg+9/NTelATDjNAL34zLZr2jU1XLQuvLadkm5lguGPEs9A3KPOpF5OpHxzwO3YtIMb56GJ/jPEg2aUjXbNG1dS+BduttfPtlr4rY5eO6TAHTmRyqlcT84vwMFp2zFP+o5dBmIEzi9TQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f81a201-fd2b-4095-342c-08dea3fd802a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 01:37:10.5410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cqW7GF6NC6bdhkfZLdiS8uBORVGOhVWyByDEsbPTL0cyPke2WmSFwrkSTe7gJUz2Cy8cCHurFczXjCc9z/AoNHmwr2s8Jo3IB01nldLwb4uuwsdKH4ihub5w1CdW8EG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9526
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Apr 2026 01:37:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22810

Hi all,

CIP kernel team has released Linux kernel v6.12.83-cip21.
The linux-6.12.y-cip tree has been updated base version from v6.12.80 to v6=
.12.83.
This release includes RSPI, TSU, and thermal files for the Renesas ARM64 So=
C.

Information about this release is as follows:

  v6.12.83-cip21:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      9948023c5f0ce7c3d0d18b0d3af918bc37d783f8
    fixed CVEs:
      CVE-2025-71269: btrfs: do not free data reservation in fallback from =
inline due to -ENOSPC
      CVE-2026-23389: ice: Fix memory leak in ice_set_ringparam()
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
      CVE-2026-31432: ksmbd: fix OOB write in QUERY_INFO for compound reque=
sts
      CVE-2026-31450: ext4: publish jinode after initialization
      CVE-2026-31466: mm/huge_memory: fix folio isn't locked in softleaf_to=
_folio()
      CVE-2026-31675: net/sched: sch_netem: fix out-of-bounds access in pac=
ket corruption
      CVE-2026-31680: net: ipv6: flowlabel: defer exclusive option free unt=
il RCU teardown
      CVE-2026-31682: bridge: br_nd_send: linearize skb before parsing ND o=
ptions
      CVE-2025-39930: ASoC: simple-card-utils: Don't use __free(device_node=
) at graph_util_parse_dai()
      CVE-2025-54505: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-23302: net: annotate data-races around sk->sk_{data_ready,wr=
ite_space}
      CVE-2026-23330: nfc: nci: complete pending data exchange on device cl=
ose
      CVE-2026-23374: blktrace: fix __this_cpu_read/write in preemptible co=
ntext
      CVE-2026-31429: net: skb: fix cross-cache free of KFENCE-allocated sk=
b head
      CVE-2026-31430: X.509: Fix out-of-bounds access when parsing extensio=
ns
      CVE-2026-31533: net/tls: fix use-after-free in -EBUSY error path of t=
ls_do_encryption
      CVE-2026-31628: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-31634: rxrpc: fix reference count leak in rxrpc_server_keyri=
ng()
      CVE-2026-31637: rxrpc: reject undecryptable rxkad response tickets
      CVE-2026-31638: rxrpc: Only put the call ref if one was acquired
      CVE-2026-31639: rxrpc: Fix key reference count leak from call->key
      CVE-2026-31642: rxrpc: Fix call removal to use RCU safe deletion
      CVE-2026-31644: net: lan966x: fix use-after-free and leak in lan966x_=
fdma_reload()
      CVE-2026-31645: net: lan966x: fix page pool leak in error paths
      CVE-2026-31646: net: lan966x: fix page_pool error handling in lan966x=
_fdma_rx_alloc_page_pool()
      CVE-2026-31648: mm: filemap: fix nr_pages calculation overflow in fil=
emap_map_pages()
      CVE-2026-31649: net: stmmac: fix integer underflow in chain mode
      CVE-2026-31651: mmc: vub300: fix NULL-deref on disconnect
      CVE-2026-31655: pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock en=
abled
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
      CVE-2026-31666: btrfs: fix incorrect return value after changing leaf=
 in lookup_extent_data_ref()
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
      CVE-2025-21709: kernel: be more careful about dup_mmap() failures and=
 uprobe registering
      CVE-2026-22986: gpiolib: fix race condition for gdev->srcu
      CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths
      CVE-2026-31407: netfilter: conntrack: add missing netlink policy vali=
dations
      CVE-2026-31531: ipv4: nexthop: allocate skb dynamically in rtm_get_ne=
xthop()
      CVE-2026-31532: can: raw: fix ro->uniq use-after-free in raw_rcv()
      CVE-2026-31576: media: hackrf: fix to not free memory after the devic=
e is registered in hackrf_probe()
      CVE-2026-31577: nilfs2: fix NULL i_assoc_inode dereference in nilfs_m=
dt_save_to_shadow_map
      CVE-2026-31578: media: as102: fix to not free memory after the device=
 is registered in as102_usb_probe()
      CVE-2026-31580: bcache: fix cached_dev.sb_bio use-after-free and cras=
h
      CVE-2026-31581: ALSA: 6fire: fix use-after-free on disconnect
      CVE-2026-31582: hwmon: (powerz) Fix use-after-free on USB disconnect
      CVE-2026-31583: media: em28xx: fix use-after-free in em28xx_v4l2_open=
()
      CVE-2026-31584: media: mediatek: vcodec: fix use-after-free in encode=
r release path
      CVE-2026-31585: media: vidtv: fix nfeeds state corruption on start_st=
reaming failure
      CVE-2026-31586: KVM: SEV: Protect *all* of sev_mem_enc_register_regio=
n() with kvm->lock
      CVE-2026-31587:  ASoC: qcom: q6apm: move component registration to un=
managed version
      CVE-2026-31588: KVM: x86: Use scratch field in MMIO fragment to hold =
small write values
      CVE-2026-31590: KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCR=
YPT_REG_REGION
      CVE-2026-31593:  KVM: SEV: Reject attempts to sync VMSA of an already=
-launched/encrypted vCPU
      CVE-2026-31595: PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in=
 epf_ntb_epc_cleanup
      CVE-2026-31596: ocfs2: handle invalid dinode in ocfs2_group_extend
      CVE-2026-31597: ocfs2: fix use-after-free in ocfs2_fault() when VM_FA=
ULT_RETRY
      CVE-2026-31598: ocfs2: fix possible deadlock between unlink and dio_e=
nd_io_write
      CVE-2026-31599: media: vidtv: fix NULL pointer dereference in vidtv_c=
hannel_pmt_match_sections
      CVE-2026-31602:  ALSA: ctxfi: Limit PTP to a single page
      CVE-2026-31603: staging: sm750fb: fix division by zero in ps_to_hz()
      CVE-2026-31604: wifi: rtw88: fix device leak on probe failure
      CVE-2026-31605: fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREEN=
INFO
      CVE-2026-31606:  usb: gadget: f_hid: don't call cdev_init while cdev =
in use
      CVE-2026-31607:  usbip: validate number_of_packets in usbip_pack_ret_=
submit()
      CVE-2026-31610: ksmbd: fix mechToken leak when SPNEGO decode fails af=
ter token alloc
      CVE-2026-31611: ksmbd: require 3 sub-authorities before reading sub_a=
uth[2]
      CVE-2026-31612: ksmbd: validate EaNameLength in smb2_get_ea()
      CVE-2026-31614: smb: client: fix off-by-8 bounds check in check_wsl_e=
as()
      CVE-2026-31615: usb: gadget: renesas_usb3: validate endpoint index in=
 standard request handlers
      CVE-2026-31616: usb: gadget: f_phonet: fix skb frags[] overflow in pn=
_rx_complete()
      CVE-2026-31617: usb: gadget: f_ncm: validate minimum block_len in ncm=
_unwrap_ntb()
      CVE-2026-31618: fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREE=
NINFO
      CVE-2026-31619: ALSA: fireworks: bound device-supplied status before =
string array lookup
      CVE-2026-31622: NFC: digital: Bounds check NFC-A cascade depth in SDD=
 response handler
      CVE-2026-31623: net: usb: cdc-phonet: fix skb frags[] overflow in rx_=
complete()
      CVE-2026-31624: HID: core: clamp report_size in s32ton() to avoid und=
efined shift
      CVE-2026-31625: HID: alps: fix NULL pointer dereference in alps_raw_e=
vent()
      CVE-2026-31626: staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_ve=
rify()
      CVE-2026-31627: i2c: s3c24xx: check the size of the SMBUS message bef=
ore using it
      CVE-2026-31629: nfc: llcp: add missing return after LLCP_CLOSED check=
s
      CVE-2026-31647: idpf: fix PREEMPT_RT raw/bh spinlock nesting for asyn=
c VC handling
      CVE-2026-31673: af_unix: read UNIX_DIAG_VFS data under unix_state_loc=
k
      CVE-2026-31677: crypto: af_alg - limit RX SG extraction by receive bu=
ffer budget
      CVE-2026-31681: netfilter: xt_multiport: validate range encoding in c=
heckentry
      CVE-2026-31684: net: sched: act_csum: validate nested VLAN headers
      CVE-2026-31685: netfilter: ip6t_eui64: reject invalid MAC header for =
all packets
    added commits:
      CIP: Bump version suffix to -cip21 after merge from stable
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
      arm64: dts: renesas: r9a09g087: Add TSU and thermal zones support
      arm64: dts: renesas: r9a09g087: Add OPP table
      arm64: dts: renesas: r9a09g077: Add TSU and thermal zones support
      arm64: dts: renesas: r9a09g077: Add OPP table
      PM: domains: Add RZ/T2H and RZ/N2H compatibles to PM domain detach li=
st
      thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
      dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
      thermal: renesas: rzg3e: make calibration value retrieval per-chip
      thermal: renesas: rzg3e: make min and max temperature per-chip
      thermal: renesas: rzg3e: make reset optional
      clk: renesas: r9a09g077: Add TSU module clock

Best regards,
  Nobuhiro



