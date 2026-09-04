Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D8DC624D3
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 13:54:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14378.1788530061563250266
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Sep 2026 06:54:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=g3m1GBAc;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1788530048;x=1789739648;bh=
	jgb5EgBqKYlqR8kw83ElxmlhXB/A2H0cT5Rol9VPxD0=;b=g3m1GBAcVtZVU1mwLl/DPWGixUY/eu
	OzjwQjgufbXuhF/M9cB+vJ1T2i+WKbKlJ5sypVu1JsNqN1cnLbf8lh5OXcsg0tdotlqeJWKB99568
	P5BeDc3vbA5gQEZoyj+8i8UAEsDm8lLlCrUyVcPMzYjvCtcRmP1rmVFEdqYZiVXBfb+1HMZCg7L2v
	xRPMzfgPUEpu4jw24vqRqxM2TyuN5NDter3S2ssHPDYl41ErDGn81qs6UJdQF/NMw5rxUF/RCmovK
	HD28qMOKqd9gNKdZO1UNW7s3sjQJfC8QLT9BsQsiJssNskkrkiX+CKuAdqdRcI8N78KRz0E7fYYL2
	x1ww==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 684Ds7LF3287141; Fri, 4 Sep 2026 22:54:07 +0900
X-Iguazu-Qid: 2rWhW3h7ptBz6m3ONc
X-Iguazu-QSIG: v=2; s=1; t=1788530047; q=2rWhW3h7ptBz6m3ONc; m=JgCw+pZlnZqHb8L4rMTDIQFzcB1BEH1gR0n8Lvzx26c=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hbycZ3s7Wz1xnf; Fri,  4 Sep 2026 22:54:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg5BPtrLq9OtyuUKj0ci0x1DaJBGdHapGqbzMnPCNme5dPmv3jIFoyzsmGrT/BMQQ/Q5RaWA0P96kVwF1d/Z2NcYKq2fQ22dRQhVmCxwjnp3JQJSJ40/+r3jLKf6yxJ9qJ6bGjh1W13040OAV+hiheLtHLSvVqqMvs3wDKeXgFWX/7flOpyxnWenDNny5m8bAwwtOcQxwMyPbzyXkw+fQR+2Fs/eolxq8OYIK+Ssa6EwrBCVmJmXUPEkb2Yo7UO3aNWygLNIn2t4Wjnf1yPW5vHCbBUlCrxiw4osgz1EYFFYm7zhnKL3DosXXnO4qdGKPxNa94LIL/cbqdPNSGYM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZibpTSYZDPjUNkHv5ZCbpnyadydw4F4R5oTdKiPWxE=;
 b=OUnSDXNrHXxwrWu77KGwnI4Hagr8ePI/BzLcJymf53nenDqPoQyJrnm3kqy8XLnYckfMl5D9jL9uZCfhPLqwmMfkwQG04B0gOpF3mGph0bMnFrUjHjL8lCS2lZyUXZT/RqVDbA7z2YWrp43vFcms8gFOfXUirCGnrM5tDdthAYQr6PgK5RtZydyR+selJy1ZFrFJZlsIf4CqSnLraXmnZt2zK9E9/qxIBflqNTKkWI/9PldwMDBm4KvTsT1sst4weFFiARCx6vSTDYDB51TU1dQ31cxN1H2ObzLkxIRpxu0YyvdWEsEoctmlCHVqzTrLii0Q9baq7ENhax1g9C0veQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <uli@fpond.eu>, <chris.paterson2@renesas.com>, <pavel@nabladev.com>
Subject: [ANNOUNCE] Release v6.12.108-cip31
Thread-Topic: [ANNOUNCE] Release v6.12.108-cip31
Thread-Index: Ad08dLsrN/TK65FBS1GT2PSkvrYhlQ==
Date: Fri, 4 Sep 2026 13:54:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188A01D606BF5AA5B0B6CBCDB52@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB14124:EE_
x-ms-office365-filtering-correlation-id: e3cf71b2-cd88-47c9-28d9-08df0a8bf9cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|11063799006|10067099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 
 XtH6rUSSX4eH4Q9J1OFlCGSpCsUTKjn3erTsbZvrC+MAdGHtRgtn1ga2kwTmrCuUTuOGghGVBfNLeR/8Jlb84sXGjQ5wnmEagicwEeVKQ5S6jVlACpZ804/Zibu0Y4nZNrRiBc3NRi94FjiqERK37Rairj53cumZQOs791POy3G8TeUs2moV9Y8yS+bGmJkDo5Rs22teBggC7ITBOD9sC5sxAE3xgFRqCl8N5mCTLVBwU5j4us+YdM9goobQZqd/CuN1JI3t18c1sjJD2kDTT/dfPdWsX80NRQkYwqeJ2JRSDu+2WMipXRLevBksskxYDQLM9zxr/xH88NT5UQnzZ2KdZiEIA5hrOEIOtE61mnzTQOXCSIj9bmqfDfcA0nWD0fMh6s3uBu6ncIncosDda7EFVlzCmGTEcTdr08ur3ISwfROL17vJBRpt1EP7EDuQaV/J6nErJgBKKFi/pmtSTfd5c+0mIdb+iazUrX3OCJLK0dXBg7BrBkUamw4fmazMNDQm1RuWG1GgRklt1Gzx8Q1npBsXPXuLhWuETZj3TCP46PrdI+qHMEQP0KkU4Yi+Gh0GEuVhiTviojeNpH8oFA3dl9y5d6VmVjdZDoX8S33qpoc3U2yqNDXUyoSQmwGXJoJ2tQadwUgglV1kxi6WYAoj6hLRzNXu34N2a5uB18Xmv/SYwVjcEG6eWhSeZMt8ERoqTQCP/+DaNoXTgz0hYYEUu47yoDQoo9OQkb2eWTw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RDhvUG10bTlhbkFJOUFBL05qQVpxa1IyWFNjTFJjV3FnWTVEK3pNUnFK?=
 =?iso-2022-jp?B?SDVPU1ZYRWI2TS9mQ3BOYVliYTg4UXFpTWkxdUNsQi9NTnFkNWFjUWVM?=
 =?iso-2022-jp?B?cEJIc2NsUEJEMkpzQzBlaS9MczUwRGxjTGpHN2RrZVdUVkZ6YUZrUzN2?=
 =?iso-2022-jp?B?RVZ2SHdkT1Fic0lFekg5eHRTNmxEQzRCWnpmcno5Y3ZaNVdyWUNTNFhh?=
 =?iso-2022-jp?B?bnpqM0J4clNjNUoxMUxhTWRmRm5xbUw1dlgzenlabXhHMG1DYVQ3N1lP?=
 =?iso-2022-jp?B?ZHhSS3BaemxaOHBQMzdQUWZ0L0IxUFd0d2xBTVdiajhIS0ltbXh1VjI5?=
 =?iso-2022-jp?B?TTMzSm5WbGJGRlhhWXBoNkVxTTRrRVlrbWUweVl1OWI1OFBGRWExL3FE?=
 =?iso-2022-jp?B?VnBaV1BBTlA2V1dMM0JHdHpiNkpHaXREU2Y4ZlFyWEhWeUExWWlLSmhH?=
 =?iso-2022-jp?B?U25NTW55a1ViWEY1WklBcm1UWURaYTR1SEhEOUhwWUZNbWJqZmFWUW9z?=
 =?iso-2022-jp?B?Um9LZlI5TXkwOG5jandiUzMyQmFzOUFDRjdRVnNUc1VZOGR3NndjWkcz?=
 =?iso-2022-jp?B?V1N0RlRNMXdGSkhGRm1uZTFGQmpSbTN4bld4aFhZV1R6ZlNsbjVIdURJ?=
 =?iso-2022-jp?B?WmdpMGY3U0hGby92c0VRQ3ZLdldSWWpuV1FjWGVUbVJQTGhkRnN0L2ZJ?=
 =?iso-2022-jp?B?R0J5c0tHdzNVUURwV1ZNeEpzL3BpMUU2d09nOElUTmtvVm5CZWkwZkd3?=
 =?iso-2022-jp?B?T1Q2Z0NZMmRNKzl6Qlc0MWIzRTl1UWxTQ29mdnBHOEtHR1Q3dWtmUndx?=
 =?iso-2022-jp?B?ak5hamU3SXhjaGtHZlo3aEpuYTU3SUlMQ084L25jRWlyYklNUW14MXBY?=
 =?iso-2022-jp?B?QTNKMGIwbnlDL0JuZEg0cis2Z2oyb2JCUDVWSk9LeHB1N09EN0FVSUdU?=
 =?iso-2022-jp?B?Mnc3S3R5Z292SDYyZFNmV2wzaVAvdTVDUDJLa1ZSeVh5N0pnVUxHYUIv?=
 =?iso-2022-jp?B?NEJHZ2x3Q1loV1RYT1RRUlNmMk9pT2lqbXhmRVFFYXRCZzc1UVl4N0ZN?=
 =?iso-2022-jp?B?RDFPYktCN3l5ZTBMN040b29jdHhQb1c2VkRySVJ0NVN2WDhDRE9OQWJI?=
 =?iso-2022-jp?B?WC9vQUNqb1gxaVBGODB3aWZqTDB1WjN2Si83TEFMZjhmVWw4WjVVeWVo?=
 =?iso-2022-jp?B?cnlKRlhZaDlQZFJ0OXZIQ0dvVHhEVnRRVE5pUWdhcG01Sk51c2NDa2Qy?=
 =?iso-2022-jp?B?cmZtZ0E3Mk1XSVJsTzdsbUxDdkdBcEZ3U251T05VbGZTSzN1RmgweXY5?=
 =?iso-2022-jp?B?YmhhL2x5WmlBU3QwdElnUC9QZUhweVRkTWFMRDJnOFBvUnlyQWRZMStV?=
 =?iso-2022-jp?B?Y2N6ZUVxWm5Oam9VakRpU2l4dVh6TkxCNHFhbWl4cFE5SGozSzRKMlhV?=
 =?iso-2022-jp?B?MHRpcXRwTDRKc3cydW5mb0NFYXhDSUNmemlvUVpWeE5ITUZUUzZONXUv?=
 =?iso-2022-jp?B?ZCtvazZjWTJhbGVvOEdSMXU0empmeVNJR3dQVzkxcUJVQklMd0ZvaVlM?=
 =?iso-2022-jp?B?RVBJbVBaMzBRaStzekhCd0lXQUhkb2xYQzNoTE1SU1BkNXpGdWJGRVBS?=
 =?iso-2022-jp?B?TUhRT1ZlNUw1UnA0ZlliaTNHVXh6WjB5dGtlZWFDVkRiVmdYeStzNFhj?=
 =?iso-2022-jp?B?TWZtN1B0b2U3SGVxSmZqYU1maTNicEMyUWs0L2tBbnExa2t1eHNsMWgw?=
 =?iso-2022-jp?B?ajFPYWxSWndWUjgzVTlFS1JvTXhNZHZMZ1RZS0ttNHR0cllWSmE0ODJY?=
 =?iso-2022-jp?B?ZjdMSmtNQWRwSmpZQ2xHejkwYmtnL1cvOGMzRm1wSk9tTlJiaUdPNDVM?=
 =?iso-2022-jp?B?Vm55OWl4OTgrOU1QUDdoZFptREx4cmtiSHJlMVkxVm01U3AzbW9oY1FY?=
 =?iso-2022-jp?B?K2dsQ05ObW5vRFlwdENNeUZaV1hrNDFQc3g1eTFPYzEraUloY1ZKaHd1?=
 =?iso-2022-jp?B?S3hKRjdxa1dBdGV4SVBhWngvS2pCclg2Nml6NzdQbVF3NmcvMFdzd0Vv?=
 =?iso-2022-jp?B?eGtJMTBGWU5hVnJTZ1NML3JIWWFjZEszdVN4T1hGd3NaZ2pzcWR1d0hu?=
 =?iso-2022-jp?B?anZoTHY4MWJpVEVQU25WQ1ZPYTdTL25RbUdnUUZoTzJBK01mZHZGOGJV?=
 =?iso-2022-jp?B?aXJoaEVJaFd3WkV3eks1aUkwdHBoZWd2MnltV2ovMmxpVUMvMGw5YlpY?=
 =?iso-2022-jp?B?Z2NQckNCaUNsRVdIYnI4bEVGTjNJbXBSRDRUTXkyYVlBanpQdjdMTlAv?=
 =?iso-2022-jp?B?MktMVFlHL0JxQytlZnNpUzVMd0RGZGtLN2J0dk5NRUlKcEpQekFBWEtu?=
 =?iso-2022-jp?B?NnovL2cwQnhtci9OV1c5ZllZb0duNThYOC96K1JyR3ZsZE85L0hQTmZQ?=
 =?iso-2022-jp?B?QkUxaFBMVE5PM1JYSXhFRHROOVk5RFdFbFFsMDdEeEx6QmpuNFJMbWVO?=
 =?iso-2022-jp?B?STQxOHpoaW50UXJvRjIzeHowM2p5cElTOUdiYWMrZ1l4cENUUk5vYnhv?=
 =?iso-2022-jp?B?MzVITUZ0UT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	VKIODWKYyZP1HEA8fC+/90CLhhEdhv4qrfKPkgw9VUqYFtsxAFabK9Vs22QHOmGk7+5IfNQ2j8A5ro3ItvfYEZTrv4y9zlJ+lajBpQ/LvuamEQpHsKDQXxB16rq/CMpubMQjg3Vk3OskXdDqY0qvHR2NpY7igezoMjFqPKghZrx0PukCEQMcnKERCzqnaoSBLAqqLR81UeU8waT0seiOtlCZ8VirzemzWyvmKJtzRmB3nbMoqkjw+1+x5K4vdTtWUmZXUPOlT6RNnLS5xr9wvrS7gglnLqARqLJpm0tiEY1tGUWhtMLEQO8sDw1ZjMVuc1hfIF54K5P6n0Zx1Lmu+g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cf71b2-cd88-47c9-28d9-08df0a8bf9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 13:54:01.7111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swe5X9CzjS3MVp0SJfbxMxmUvD2orQqE4SgtbyNQgowqZ6ONrbpt9gF5veHyg+rOpD+DM5KSxxfjNx0LCGVvJ2WIXEBSeSeUNv88El3I2imQEW0a1ij0fdmY2a8dK/cI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Sep 2026 13:54:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24095

Hi all,

CIP kernel team has released Linux kernel v6.12.108-cip31.
The linux-6.12.y-cip tree has been updated base version from v6.12.104 to v=
6.12.108.
In addition, this release includes new support for the interrupt controller=
 (ICU)
for Renesas SoCs (RZ/V2H, RZ/T2H, RZ/N2H, etc.), driver refactoring, enhanc=
ements to
the device tree, and bug fixes and feature improvements related to the netw=
ork clock.

Information about this release is as follows:

  v6.12.108-cip31:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      9ac614bae427312bd04cbbd221d65afdb77353d0
    fixed CVEs:
      CVE-2025-40054: f2fs: fix UAF issue in f2fs_merge_page_bio()
      CVE-2026-68166: userfaultfd: prevent registration of special VMAs
      CVE-2026-74474: vxlan: use pskb_network_may_pull() for transmit path =
header pulls
      CVE-2026-68159: libceph: bound pg_{temp,upmap,upmap_items} length to =
CEPH_PG_MAX_SIZE
      CVE-2025-40074: ipv4: start using dst_dev_rcu()
      CVE-2026-64216: netfs: Fix potential UAF in netfs_unlock_abandoned_re=
ad_pages()
      CVE-2026-64581: xfrm: fix sk_dst_cache double-free in xfrm_user_polic=
y()
      CVE-2026-74626: NTB: ntb_netdev: Preserve RX queue depth on allocatio=
n failure
      CVE-2026-74653: serial: 8250_of: clear stuck empty-FIFO RX-timeout on=
 LPC32xx
      CVE-2026-74662: inet: frags: publish queues before arming timer
      CVE-2026-80536: xfs: bounds-check buffer log item's dirty bitmap
      CVE-2026-80557: libceph: fix OOB read in decode_watchers() via missin=
g bounds check
      CVE-2026-80562: gpio: ml-ioh: use raw_spinlock_t for the register loc=
k
      CVE-2026-80572: Input: byd - synchronize timer deletion before freein=
g private data
      CVE-2026-80583: ASoC: codecs: lpass-tx-macro: Fix enum kcontrol acces=
ses
      CVE-2026-80725: net: gro: properly validate BIG TCP aggregation crite=
ria
      CVE-2026-80737: serial: amba-pl011: synchronize DMA teardown
      CVE-2026-80590: inet: frags: strip GSO state from fragments before re=
assembly
      CVE-2024-58094: jfs: add check read-only before truncation in jfs_tru=
ncate_nolock()
      CVE-2024-58095: jfs: add check read-only before txBeginAnon() call
      CVE-2025-22104: ibmvnic: Use kernel helpers for hex dumps
      CVE-2025-38203: jfs: Fix null-ptr-deref in jfs_ioc_trim
      CVE-2025-38206: exfat: fix double free in delayed_free
      CVE-2025-38237: media: platform: exynos4-is: Add hardware sync wait t=
o fimc_is_hw_change_mode()
      CVE-2025-39833: mISDN: hfcpci: Fix warning when deleting uninitialize=
d timer
      CVE-2025-39925: can: j1939: implement NETDEV_UNREGISTER notification =
handler
      CVE-2025-40064: smc: Fix use-after-free in __pnet_find_base_ndev().
      CVE-2025-40102: KVM: arm64: Prevent access to vCPU events before init
      CVE-2025-40139: smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_c=
lc_prfx_set().
      CVE-2025-40168: smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_=
prfx_match().
      CVE-2026-45963: ASoC: nau8821: Cancel delayed work on component remov=
e
      CVE-2026-53089: bpf: Fix use-after-free in offloaded map/prog info fi=
ll
      CVE-2026-64070: powerpc/hv-gpci: fix preempt count leak in sysfs show=
 paths
      CVE-2026-64082: riscv: Fix register corruption from uninitialized cre=
gs on error
      CVE-2026-74753: perf: Reject exited events as group leaders
      CVE-2026-80755: selinux: reject a permission value exceeding the clas=
s permission count
    added commits:
      CIP: Bump version suffix to -cip31 after merge from stable
      irqchip/renesas-rzv2h: Kill icu_err string
      irqchip/renesas-rzv2h: Kill swint_names[]
      irqchip/renesas-rzv2h: Kill swint_idx[]
      irqchip/renesas-rzv2h: Handle ICU error IRQ and add SWPE trigger
      irqchip/renesas-rzv2h: Add CA55 software interrupt support
      irqchip/renesas-rzv2h: Replace single irq_chip with per-region irq_ch=
ip instances
      irqchip/renesas-rzv2h: Clarify IRQ range definitions and tighten TINT=
 validation
      irqchip/renesas-rzv2h: Switch to using dev_err_probe()
      irqchip/renesas-rzv2h: Use local device pointer in ICU probe
      irqchip/renesas-rzv2h: Use local node pointer
      irqchip/renesas-rzv2h: Fix error path in rzv2h_icu_probe_common()
      arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Add GPIO keys
      arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Add GPIO keys
      arm64: dts: renesas: r9a09g087: Add GPIO IRQ support
      arm64: dts: renesas: r9a09g077: Add GPIO IRQ support
      arm64: dts: renesas: r9a09g087: Add ICU support
      arm64: dts: renesas: r9a09g077: Add ICU support
      irqchip/renesas-rzt2h: Add error interrupts support
      irqchip/renesas-rzt2h: Add software-triggered interrupts support
      irqchip/renesas-rzt2h: Use pm_runtime_put_sync() in probe error path
      irqchip: Add RZ/{T2H,N2H} Interrupt Controller (ICU) driver
      dt-bindings: interrupt-controller: renesas,r9a09g077-icu: Fix reg siz=
e in example
      dt-bindings: pinctrl: renesas,r9a09g077-pinctrl: Document GPIO IRQ
      dt-bindings: interrupt-controller: Document RZ/{T2H,N2H} ICU
      net: stmmac: address non-LPI resume failures properly
      net: stmmac: simplify phylink_suspend() and phylink_resume() calls
      net: phylink: add phylink_prepare_resume()
      clk: renesas: cpg-mssr: Handle RZ/T2H register layout in PM callbacks
      clk: renesas: cpg-mssr: Simplify pointer math in cpg_rzt2h_mstp_read(=
)

Best regards,
  Nobuhiro


