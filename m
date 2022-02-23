Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C7EC433EF
	for <webhook@archiver.kernel.org>; Wed, 23 Feb 2022 23:27:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.3424.1645658852001347045
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Feb 2022 15:27:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 21NNRBW9028235;
 Thu, 24 Feb 2022 08:27:11 +0900
X-Iguazu-Qid: 34tKD4oVUYapCcSDnm
X-Iguazu-QSIG: v=2; s=0; t=1645658831; q=34tKD4oVUYapCcSDnm;
 m=yElKklqh+CxJPVq3rRk1a7eelZKHmo+mdQ4nZA/6Ti8=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 21NNR8AB010841
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Feb 2022 08:27:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYn4ud0i0tt9lY0opGOzDl1TA9SVSuh7pzXSEhIQuJat22WY2QfuO91v5TKiQdXTPLY+pY6E1zg38Ysugsk4bBzjTh/uv2G8dRFH2aY464heaTVkkiHrGeJ86SHlxUvNvOCdsIqbuDlAmfekqusY+F30QqVdULfs0CKnx/XoR3sanpAFWyulogGQHdMsloCgLWVN9pBSZjcLV4LzxBfyFQgOIR4mwfmdAJ+uTdMNXfy3RDNNSmQQFr/2GgK/qCeAN69eYvfYYb5gJg/iRkmplDGsG8Qrw4EbbZR3XZCJiy/5Y2aquTR7GoG85EZqWxID0QvhsEd5hGU893Zo5xVghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkvtP8cdlIMEV9bqUPoLSie3EJTGdMcHffThKO+4r+E=;
 b=cNzAxraNUzOPTHtOWP+D8R8piyucvWvJ+GBPp00qJ14hnJxX7rX5ELMovS72pYEfKj3RTq2GLhFHHRYXodM8/VxjiluWMw9rMn1Sg/M7tu338CNTe5WN3Ykd6O5Z4D7ClmvGOLG3AKRkBb7Ppnlh5IThTNNKctGKeYIP+T4OBRELeA97iyLvX/wQ7F5F35AjN33BfM7ykkCBQHfu/V+jmGqNrgWBg/tZ/XbHG9Z82oGsXTM6p9Gz+jkhvmg6Rbe9d8ntuPlFNC+YQIptKG2JQUTcosWLYhePT3CILbuvg+WNgUbXW61NDHYbdiqG9gFMcjG8dkVmrot+JCFRuIPi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.100-cip2
Thread-Topic: [ANNOUNCE] Release v5.10.100-cip2
Thread-Index: Adgnu5EAEkCwmOZEQmiBAd01J8Tlvw==
Date: Wed, 23 Feb 2022 23:26:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB6255F86B8E55B4FAA4227F25923C9@TYCPR01MB6255.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a26ec995-57bb-4e39-e971-08d9f723f80a
x-ms-traffictypediagnostic: OSYPR01MB5384:EE_
x-microsoft-antispam-prvs: 
 <OSYPR01MB53843B4406EF0B02EBF76BE5923C9@OSYPR01MB5384.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SQ3apK8C58bM9J5x+xhsHsSlRG/HEum3LVQuPwriat4zQyZbWO/i4JVBQdGHo5dLwJus2YISVGGNIu+EUtPX0AqKUhMlI18Tvwh3rFk5NzxODo11SUn97yjm5ir5bdjm0Y9DT6rxdDph/ezkSH6ckTGMopdWo4p6toguJCUIHAvwwgs/WiNR6oKPu0Q7p1mFruSV6JImK+LSoLa55k23oAhEDxzjcGfgbM+ghEorl2OdwoHm/W05iteCsTMNr0Qpizw1LFhtsyzjCnc0Pq1RCq465uijDJ6kx4jNQhuggu6p4q7IMfMnhEF6s0Xf1JIAiAtVhYIEugXLWndLhZQorT2e8NL5uA0kvkiVSilaTGZBXPCm9RWSu+K1FC5JxwELHnYBDuWitAml0GJyAM0UpN3X9uSbcSqYoXQnlZ66J+F+5HXlE7lVkbz7THqfswB6NmaaLM87sb0xqE17WLxsd1m3k/v5VzZqHDu85wsehr0hcY/cxpfvDfX+yIwN+g2+1eItcnWU65Mv/sVftVKI46XZGIxR0ksIil1l3hI0uEeJwvx4I0rXDeNG/94FEPr04g6B1BbL4J+H/Jk8rLKLMO169xOauds7mkXPbGtngwuVkNdK7HbQ22WXUpYp/SsHixv+4ZXgeJjz8gFH9usQYNEzCeNJV8+c+jqLXHA/9yORjBsU28P059NKWwpT5WKl2gTvCJEqmMUEc71JgbyHPM8AudQ3rNgzOK5CgjtHnFdUzhxyWVaP9C7E6XMABbSgO1pZ2IoFJmeIhWn40baF+CcPj8BMR8L8klnFrXFr2OQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6255.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(33656002)(508600001)(71200400001)(30864003)(55016003)(7696005)(6506007)(52536014)(86362001)(2906002)(122000001)(966005)(8936002)(54906003)(38100700002)(83380400001)(186003)(5660300002)(26005)(66556008)(8676002)(64756008)(66446008)(66476007)(4326008)(66946007)(38070700005)(6916009)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Rktqb3pZdjBGeXdUQ0d1Z3NpTnpXM00yTVc2c2JCS1ZLS1RJak1oTDFV?=
 =?iso-2022-jp?B?QWVwZnZtZlc2dDdiNVNXckJZU2lzNWpvcXlUQ1lsYk8waUd0MDRtcVJU?=
 =?iso-2022-jp?B?ZXJ4aEJNdXJjeUdkcFZoQndSdHRuWnVrSnRnNkdiaXdJeUFsYSs1VDc0?=
 =?iso-2022-jp?B?QVVsUVRBZGVzNTZsUTVWdytoS1hyUHUzVFpDbTQwUkJrVFRRWkZkTzd0?=
 =?iso-2022-jp?B?UWVmYUtrbFA0L0Fmc1FxOGYrbEhTbm1vRzdXV25sbm9IR1I0UmJoMjl5?=
 =?iso-2022-jp?B?M2NpclFvZlFRYmxlWkVoTkN1OHhWNGEwRG0vMWRMNStOVFN2RE1Bd2RO?=
 =?iso-2022-jp?B?T0RLU0RHSHVjMHJwRU8zS3dnRzgrUkRreFF6TDNPaFFJSDlUQWtBOUVM?=
 =?iso-2022-jp?B?UmRqWDZuYldLck8zTTJYNkpWeWtNS3VSQ0pDeDlHaytoRWZlQit6K3RR?=
 =?iso-2022-jp?B?c29lSzIvQWJEazBEN3NaTVBDWHBEeEhCdDdLRDkwTDQxbjFMSDAxMzF2?=
 =?iso-2022-jp?B?TUpGWDVDaEhDczMzUFMxWXdSK1lnQVNkSmlHcWlOeGRVV0R6TGlwdmlC?=
 =?iso-2022-jp?B?Yi9IRGRya1NmanFKMDdqUVZFQ0Yzbmh6a3NRU2xuZUV6ZnlaUjZabTNr?=
 =?iso-2022-jp?B?YzJwWFF0YzhCdWttUzFlMytxRnJxR3BLNjFYM25XV0FycmlyUlNYWkk1?=
 =?iso-2022-jp?B?cEtDRlA2bHkzLzV5dGJ0OWxpZjJLemY4bHlmaXcwdlZTcmtVWWVQVmkv?=
 =?iso-2022-jp?B?Z1lnUWFUemIyKzBHWHd4ZXpoQ3FObGF3WVhaZU9LUzFrVDVWZnZRMFpW?=
 =?iso-2022-jp?B?RlovSDhZWFV4NXZLbzJVUFBvMXUrSFdvU3VCdyttVW44azZZSnZnYXBD?=
 =?iso-2022-jp?B?RTZCcXNyQjJOZEFkQk1WL0ZWWjB2b3FRR25mbU1FL0VZNVBlOEtEUEpF?=
 =?iso-2022-jp?B?TGh0VSswc2Y3RjZYZUVYS3R6b204VUJROEpuNmNONEFrOWtDbkhmUnpH?=
 =?iso-2022-jp?B?UXFMVzZXWndDdURZV1ovTk5jK2hZMlZCdkNtRDdpV25Veno3a0NKVXRF?=
 =?iso-2022-jp?B?ZThyeTdtUFR1L2E5SS90cHo4Q2d6RExPR2s0azlvcTZwZHR5RGErT1M1?=
 =?iso-2022-jp?B?NitGSGk1aDBVY0hNeU91czFFcHBSc25KMXluK3NuVE9JN1daVEhiSHNS?=
 =?iso-2022-jp?B?VlFueFAvcjRTKzN3VnBaN1czQlN3dzNkenJRQnhZWmRWcFZuQkdyUzBP?=
 =?iso-2022-jp?B?TUsvVU5LanpHMDFBWFpRU2pUcWJGUER4dEdibGcxNEdZczQrWERpUGsy?=
 =?iso-2022-jp?B?UTE0b0czb0pFMzB4Q2JrODJ3Q2R0TUx0MndtTThobVhpYkZKLzExRDBF?=
 =?iso-2022-jp?B?WVF5dkxtTVB3aUdMSzQwWEYxb1pmdkxGb1Rjay8wcmhNQk1DbGN2N3hH?=
 =?iso-2022-jp?B?RVUyMlNlZG03NmNKc2dxZ0trYXRUOHdzZFJBRkUxZjU5YzAyc0o0aERi?=
 =?iso-2022-jp?B?cEgxR1NlOFhwV0VoNFUvWnh4L3k3WGRpT3M4Vmh2MXZIK3pDTEUvUVFB?=
 =?iso-2022-jp?B?T01xdUt4c3E3a1NaSG5DLytzWEJEanVoMWdSTnNyU01hNHBscUYxMVFr?=
 =?iso-2022-jp?B?eUhqTTZVdkw4UTJrTjBDMW94c3VhSi9vRHdNc1EzUktiZVNtNUFrclFk?=
 =?iso-2022-jp?B?NFFGS2F2LzZSYTdtSG82S2g1QkRZQXVHdHFuR2wzNWtadjJHM3VSdWtr?=
 =?iso-2022-jp?B?N0ZoNjYyZEpSb1V1Umh6RDZSSFBLeWVVVkNLTWIzWitiWXhoR0lvcTFy?=
 =?iso-2022-jp?B?SDhqWWl6WmpUSDVMQU5nVDAwS2xOZXVET0FMVkxMeGFNdFUzTkowUnlm?=
 =?iso-2022-jp?B?b1RLQWMrV2hTYnlkcjVYNGR0cm4yUWRNcGtkOVB5cTFLS1drMHVwdFZT?=
 =?iso-2022-jp?B?amNBczZ1Wm9PZEFVaGYvVHA4NWxKRzJlcytmS25SRjM3VDY2YXU4eDJr?=
 =?iso-2022-jp?B?TFdERUFCdlQrV3pYWHRoWGdpQjNYcFdqbCtKKy9DTkNVTm1weUdadWt2?=
 =?iso-2022-jp?B?L3J2dDVPQ3g4RG9vWVlteVNORzFRak8wK3FoYmRuUlFuQURkSkdheDBK?=
 =?iso-2022-jp?B?T0dBM2ZUbVlMMEZFVlplYlhtVmpwVW8rQ2lucmwvWmNMeEVGd00zTHlp?=
 =?iso-2022-jp?B?czFXKy9mVENTbk15cUsvaXFDSmVXMmlCR20wR3V4emZSYU0zaTFRMDBy?=
 =?iso-2022-jp?B?NGtzaUtqY3hESHdTVzc2RE9Ob3BGTFlaS3RueTFld09NaGROZGxuMktQ?=
 =?iso-2022-jp?B?YWVqWm8zbHhhSS9qVjYxcGpTU2NSdE9EekphY1lNUDd0WjBHNVM0eGx5?=
 =?iso-2022-jp?B?ek1XWEtjSUFDVllwOEFPL0JrUXdnWHBKY05UL3YyVVJMUlZza2ZtY29q?=
 =?iso-2022-jp?B?VzdSTnRNMUluUDFaR2FJQkpPN1NZS0Z6MkRVbEZMQ0trK2picHZpQmQr?=
 =?iso-2022-jp?B?a3gzcVA5?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6255.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a26ec995-57bb-4e39-e971-08d9f723f80a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 23:26:50.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 yPp3S6hHzvdXAKMxbNMP12HBIUtBsowFsi1x3C77TjmOcI0HDCcmFMLd5ORwOmo2o6B1ExvDsg/yjBE8dk5ANOu9ZkZYArYY1nDFzX935hcX1nzC0zEo9sP4jkWUMchQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5384
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Feb 2022 23:27:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7638

Hi,

CIP kernel team has released Linux kernel v5.10.100-cip2.
The linux-5.10.y-cip tree has been updated base version from v5.10.83 to v5=
.10.100.
In addition, support for Renesas ARM SoC RZ/G2{L,LC} UART, I2C, Clock, Ethe=
rnet,
pincontrol, USB, iio and these documents have been added.

You can get this release via the git tree at:
  v5.10.100-cip2:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      	3b0f99e9e53f690945381bc3cd661dcc82d747ee
    Fixed CVEs:
      - CVE-2021-43975: atlantic: Fix OOB read and write in hw_atl_utils_fw=
_rpc_wait
      - CVE-2021-4083: fget: check that the fd still exists after getting a=
 ref to it
      - CVE-2021-39685: USB: gadget: detect too-big endpoint 0 requests
      - CVE-2021-28715: xen/netback: don't queue unlimited number of packag=
es
      - CVE-2021-28714: xen/netback: fix rx queue stall detection
      - CVE-2021-28713: xen/console: harden hvc_xen against event channel s=
torms
      - CVE-2021-28712: xen/netfront: harden netfront against event channel=
 storms
      - CVE-2021-28711: xen/blkfront: harden blkfront against event channel=
 storms
      - CVE-2021-45402: bpf: Fix signed bounds propagation after mov32
      - CVE-2021-22600: net/packet: rx_owner_map depends on pg_vec
      - CVE-2021-4135: netdevsim: Zero-initialize memory for new map's valu=
e in function nsim_bpf_map_alloc
      - CVE-2021-44733: tee: handle lookup of shm with reference count 0
      - CVE-2021-45469: f2fs: fix to do sanity check on last xattr entry in=
 __f2fs_setxattr()
      - CVE-2021-45095: phonet: refcount leak in pep_sock_accep
      - CVE-2021-4155: xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP =
just like fallocate
      - CVE-2022-0185: vfs: fs_context: fix up param length parsing in lega=
cy_parse_param
      - CVE-2021-43976: mwifiex: Fix skb_over_panic in mwifiex_usb_recv()
      - CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store
      - CVE-2022-22942: drm/vmwgfx: Fix stale file descriptors on failed us=
ercopy
      - CVE-2022-24448: NFSv4: Handle case where the lookup of a directory =
fails
      - CVE-2022-24959: yam: fix a memory leak in yam_siocdevprivate()
      - CVE-2022-0492: cgroup-v1: Require capabilities to set release_agent
      - CVE-2022-0516: KVM: s390: Return error on SIDA memop on normal gues=
t
      - CVE-2022-0435: tipc: improve size validations for received domain r=
ecords
      - CVE-2022-0487: moxart: fix potential use-after-free on remove path
    added commits:
      CIP: Bump version suffix to -cip2 after merge from stable
      arm64: dts: renesas: r9a07g044: Sort psci node
      arm64: dts: renesas: r9a07g044: Add SCI[0-1] nodes
      arm64: dts: renesas: rzg2l-smarc: Enable SCIF2 on carrier board
      arm64: dts: renesas: r9a07g044: Add SCIF[1-4] nodes
      serial: sh-sci: Add support to deassert/assert reset line
      dt-bindings: serial: renesas,sci: Document RZ/G2L SoC
      dt-bindings: serial: renesas,scif: Make resets as a required property
      clk: renesas: r9a07g044: Add clock and reset entry for SCI1
      arm64: dts: renesas: rzg2l-smarc-som: Enable serial NOR flash
      arm64: dts: renesas: r9a07g044: Add SPI Multi I/O Bus controller node
      clk: renesas: r9a07g044: Add clock and reset entries for SPI Multi I/=
O Bus Controller
      memory: renesas-rpc-if: Add support for RZ/G2L
      memory: renesas-rpc-if: correct whitespace
      memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
      dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
      dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
      dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements
      pinctrl: renesas: rzg2l: Add support to get/set drive-strength and ou=
tput-impedance-ohms
      pinctrl: renesas: rzg2l: Rename PIN_CFG_* macros to match HW manual
      pinctrl: renesas: rzg2l: Add support to get/set pin config for GPIO p=
ort pins
      pinctrl: renesas: rzg2l: Add helper functions to read/write pin confi=
g
      pinctrl: renesas: rzg2l: Rename RZG2L_SINGLE_PIN_GET_PORT macro
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add output-impedance-ohm=
s property
      pinctrl: pinconf-generic: Add support for "output-impedance-ohms" to =
be extracted from DT files
      dt-bindings: pincfg-node: Add "output-impedance-ohms" property
      can: rcar_canfd: rcar_canfd_channel_probe(): make sure we free CAN ne=
twork device
      arm64: dts: renesas: rzg2l-smarc-som: Enable Ethernet
      arm64: dts: renesas: r9a07g044: Add GbEthernet nodes
      clk: renesas: r9a07g044: Add GbEthernet clock/reset
      clk: renesas: r9a07g044: Add ethernet clock sources
      ravb: Fix typo AVB->DMAC
      ravb: Update ravb_emac_init_gbeth()
      ravb: Rename "nc_queue" feature bit
      ravb: Optimize ravb_emac_init_gbeth function
      ravb: Rename "tsrq" variable
      ravb: Add support to retrieve stats for GbEthernet
      ravb: Add carrier_counters to struct ravb_hw_info
      ravb: Fillup ravb_rx_gbeth() stub
      ravb: Fillup ravb_rx_ring_format_gbeth() stub
      ravb: Fillup ravb_rx_ring_free_gbeth() stub
      ravb: Fillup ravb_alloc_rx_desc_gbeth() stub
      ravb: Use ALIGN macro for max_rx_len
      ravb: Add rx_max_buf_size to struct ravb_hw_info
      ravb: Initialize GbEthernet E-MAC
      ravb: Remove extra TAB
      ravb: update "undocumented" annotations
      ravb: Add half_duplex to struct ravb_hw_info
      ravb: Add magic_pkt to struct ravb_hw_info
      ravb: Add tsrq to struct ravb_hw_info
      ravb: Exclude gPTP feature support for RZ/G2L
      ravb: remove APSR_DM
      ravb: Initialize GbEthernet DMAC
      ravb: Add support for RZ/G2L SoC
      ravb: Add nc_queue to struct ravb_hw_info
      ravb: Rename "no_ptp_cfg_active" and "ptp_cfg_active" variables
      ravb: Rename "ravb_set_features_rx_csum" function to "ravb_set_featur=
es_rcar"
      ravb: Add reset support
      ravb: Factorise ravb_emac_init function
      ravb: Factorise ravb_dmac_init function
      ravb: Factorise ravb_set_features
      ravb: Factorise ravb_adjust_link function
      ravb: Factorise ravb_rx function
      ravb: Factorise ravb_ring_init function
      ravb: Factorise ravb_ring_format function
      ravb: Factorise ravb_ring_free function
      ravb: Add ptp_cfg_active to struct ravb_hw_info
      ravb: Add no_ptp_cfg_active to struct ravb_hw_info
      ravb: Add multi_irq to struct ravb_hw_info
      ravb: Remove the macros NUM_TX_DESC_GEN[23]
      ravb: Add tx_counters to struct ravb_hw_info
      ravb: Add internal delay hw feature to struct ravb_hw_info
      ravb: Add net_features and net_hw_features to struct ravb_hw_info
      ravb: Add gstrings_stats and gstrings_size to struct ravb_hw_info
      ravb: Add stats_len to struct ravb_hw_info
      ravb: Add max_rx_len to struct ravb_hw_info
      ravb: Add aligned_tx to struct ravb_hw_info
      ravb: Add struct ravb_hw_info to driver data
      ravb: Use unsigned int for num_tx_desc variable in struct ravb_privat=
e
      ravb: Remove checks for unsupported internal delay modes
      ravb: Fix a typo in comment
      net: ethernet: ravb: Use devm_platform_get_and_ioremap_resource()
      net: ethernet: ravb: Fix release of refclk
      net: ethernet: ravb: Enable optional refclk
      dt-bindings: net: renesas,etheravb: Drop "int_" prefix and "_n" suffi=
x from interrupt names
      dt-bindings: net: renesas,etheravb: Document Gigabit Ethernet IP
      dt-bindings: net: renesas,etheravb: Fix optional second clock name
      dt-bindings: net: renesas,etheravb: Add additional clocks
      clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
      arm64: dts: renesas: rzg2l-smarc: Enable CANFD
      arm64: dts: renesas: rzg2l-smarc-som: Enable ADC on SMARC platform
      arm64: dts: renesas: rzg2l-smarc-som: Move extal and memory nodes to =
SOM DTSI
      arm64: dts: renesas: rzg2l-smarc: Enable I2C{0,1,3} support
      arm64: defconfig: Enable RZG2L_ADC
      arm64: dts: renesas: r9a07g044: Add ADC node
      clk: renesas: r9a07g044: Add clock and reset entries for ADC
      clk: renesas: r9a07g044: Add SSIF-2 clock and reset entries
      iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in rzg2l_adc=
_pm_runtime_resume()
      iio: adc: rzg2l_adc: Fix -EBUSY timeout error return
      iio: adc: Add driver for Renesas RZ/G2L A/D converter
      dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A=
/D converter
      arm64: defconfig: Enable RIIC
      i2c: riic: Add RZ/G2L support
      arm64: defconfig: Enable RZ/G2L USBPHY control driver
      arm64: dts: renesas: r9a07g044: Add CANFD node
      clk: renesas: r9a07g044: Add clock and reset entries for CANFD
      clk: renesas: r9a07g044: Add entry for fixed clock P0_DIV2
      dt-bindings: clock: r9a07g044-cpg: Add entry for P0_DIV2 core clock
      can: rcar_canfd: rcar_canfd_handle_channel_tx(): fix redundant assign=
ment
      can: rcar_canfd: Add support for RZ/G2L family
      dt-bindings: can: rcar_canfd: Convert to json-schema
      dt-bindings: can: rcar_canfd: Group tuples in pin control properties
      arm64: dts: renesas: rzg2l-smarc: Enable USB2.0 support
      arm64: dts: renesas: r9a07g044: Add USB2.0 device support
      arm64: dts: renesas: r9a07g044: Add USB2.0 phy and host support
      clk: renesas: r9a07g044: Add USB clocks/resets
      phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/G2L
      phy: renesas: convert to devm_platform_ioremap_resource
      dt-bindings: phy: renesas,usb2-phy: Document RZ/G2L phy bindings
      dt-bindings: usb: renesas,usbhs: Document RZ/G2L bindings
      reset: renesas: Add RZ/G2L usbphy control driver
      dt-bindings: reset: Document RZ/G2L USBPHY Control bindings
      dt-bindings: usb: generic-ohci: Document dr_mode property
      dt-bindings: usb: generic-ehci: Document dr_mode property
      arm64: defconfig: Enable RZ_DMAC
      arm64: dts: renesas: r9a07g044: Add DMAC support
      dmaengine: sh: make array ds_lut static
      dmaengine: sh: rz-dmac: Add DMA clock handling
      dmaengine: sh: fix some NULL dereferences
      dmaengine: sh: Fix unused initialization of pointer lmdesc
      dmaengine: sh: Add DMAC driver for RZ/G2L SoC
      dmaengine: Extend the dma_slave_width for 128 bytes
      dt-bindings: dma: Document RZ/G2L bindings
      clk: renesas: r9a07g044: Add DMAC clocks/resets
      arm64: dts: renesas: r9a07g044: Add I2C interrupt-names
      arm64: dts: renesas: r9a07g044: Add I2C nodes
      dt-bindings: i2c: renesas,riic: Document RZ/G2L I2C controller
      dt-bindings: i2c: renesas,riic: Convert to json-schema
      clk: renesas: r9a07g044: Add I2C clocks/resets
      arm64: dts: renesas: r9a07g044: Add pinctrl node
      arm64: dts: renesas: rzg2l-smarc: Add scif0 pins
      pinctrl: renesas: rzg2l: Fix missing port register 21h
      pinctrl: renesas: Add RZ/G2L pin and gpio controller driver
      dt-bindings: pinctrl: renesas: Add DT bindings for RZ/G2L pinctrl
      clk: renesas: r9a07g044: Add GPIO clock and reset entries
      mm: slab: provide krealloc_array()
      clk: renesas: rzg2l: Fix clk status function
      clk: renesas: rzg2l: Add support to handle coupled clocks
      clk: renesas: rzg2l: Add support to handle MUX clocks
      clk: mux: provide devm_clk_hw_register_mux()
      clk: renesas: Rename renesas-rzg2l-cpg.[ch] to rzg2l-cpg.[ch]
      clk: renesas: rzg2l: Fix off-by-one check in rzg2l_cpg_clk_src_twocel=
l_get()
      clk: renesas: rzg2l: Avoid mixing error pointers and NULL
      clk: renesas: rzg2l: Fix a double free on error
      clk: renesas: rzg2l: Fix return value and unused assignment
      clk: renesas: rzg2l: Remove unneeded semicolon
      dt-bindings: clock: r9a07g044-cpg: Update clock/reset definitions
      arm64: dts: renesas: r9a07g044: Add SYSC node
      arm64: dts: renesas: Add initial device tree for RZ/G2L SMARC EVK
      arm64: dts: renesas: Add initial DTSI for RZ/G2{L,LC} SoC's
      clk: renesas: rzg2l: Add multi clock PM support
      clk: renesas: r9a07g044: Add P2 Clock support
      clk: renesas: r9a07g044: Fix P1 Clock
      clk: renesas: r9a07g044: Rename divider table
      clk: renesas: Add support for R9A07G044 SoC
      clk: renesas: Add CPG core wrapper for RZ/G2L SoC
      dt-bindings: clock: Add r9a07g044 CPG Clock Definitions
      dt-bindings: clock: renesas: Document RZ/G2L SoC CPG driver
      serial: sh-sci: Add support for RZ/G2L SoC
      dt-bindings: serial: renesas,scif: Document r9a07g044 bindings
      arm64: defconfig: Enable ARCH_R9A07G044
      soc: renesas: Add support to read LSI DEVID register of RZ/G2{L,LC} S=
oC's
      soc: renesas: Add ARCH_R9A07G044 for the new RZ/G2L SoC's
      dt-bindings: power: renesas,rzg2l-sysc: Add DT binding documentation =
for SYSC controller
      dt-bindings: arm: renesas: Document SMARC EVK
      dt-bindings: arm: renesas: Document Renesas RZ/G2{L,LC} SoC variants
      dt-bindings: arm: renesas: Document Renesas RZ/G2UL SoC
Best regard,
  Nobuhiro


