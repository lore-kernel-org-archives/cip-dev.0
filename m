Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B36C3A5A7
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 17:24:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web08.275.1649117895241939524
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 17:18:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 2350Hsmk004160;
 Tue, 5 Apr 2022 09:17:54 +0900
X-Iguazu-Qid: 34trDs1hpmXyqXXRZR
X-Iguazu-QSIG: v=2; s=0; t=1649117873; q=34trDs1hpmXyqXXRZR;
 m=oKWRQHPugaYSrvM7bC8PIV8SO+HUHQ3n8t8+91bvJFM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 2350HpTb010607
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 5 Apr 2022 09:17:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asxjeeda0oZO6eXJivR9fcgYteEqh0r2524PRyk3UboumnY3ZrUU2kU4knxVpaCxYmsw0OWP4Ditd6JQBsAkHJ/1s5R/HC6VV+uyFxEg4LRFXufjUy+/yToqtMQCX7Og4fMb88FOrjoVnhs2IirFpsWxj6vKxamSWTUxj12TgE4mdz6KuZaEetcPfaJ7nKE8mKKV/cQI+BT217b7RXHiCKtef04KJoEpvMWGp93a9fVLKQy9OHlOgCkQO6ZCkUy2xec3zK/XxoRNQ1mHmQ2ohNIAN3D+hT49Hy+gv+yT4b60i4OGijOoC+ujtoe3igqOJ1QotVxTNhc+sDwIN+b5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PTnzDQsVyLqQZICjWy4qR4CBBugEhTRbfEkH27VK9w=;
 b=B7ImGPdkGMWr0rchIAe4uok65/uUCvRX461X1+wxa2LDiOl8tKDS+ptR+JWMeeQo5285jIYvEZX96nIqft9v7mLCzwD+UPDyC6W4/fEGNC62yeZYu0GfY27EnC5yUV+fdz/i5X/T/oXKdXVHBjah58ErpCwsFPYA4Tq7a8GwOHudn2aa4rWqTGAeOXT7SIUej4o369KesQZVPpwWBXkH82E+5Qlovfg5HSf6As696DDxcj+h5fuSy/44I0Yr3U47u3G/DW/Jrq8VcIanPt033juFaEYfq6U0FFOslFmZD2a6nDjGeDJ1ZOKNP2/qfegOzCXQyTbLCozZF7ISXuvb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v4.4.302-cip69
Thread-Topic: [ANNOUNCE] Release v4.4.302-cip69
Thread-Index: AdhIgkIHlUW4qe9UTZC8rpHNt5pw0A==
Date: Tue, 5 Apr 2022 00:17:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB625209A2D9DA2657AD75622492E49@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ffc2650-0117-4403-c158-08da1699b586
x-ms-traffictypediagnostic: TYCPR01MB6702:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB67020129D7DE973B2947ADE092E49@TYCPR01MB6702.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Vxz5fe2lIytLtXUuG33vcOiB4BfYhm6mQdSZnPkGEYPYLOzzdUBdxqHAkkRiHrzqhjQovrWTAd1umKJo2Hst9R624JUhI+6B+VEHy6Cqaoht6TScIBuRRmhJf/ekUxqw+lMRpXRyTfekJ8ocQup+U43QbteV49Wq2VIqf576LLIhcFfjyl+q2Gz1DB8SQQyIAK/3mlwxRDVNYb8Amhpf28ulVfT2b7Ft5rwoYqGlEVhtP1ZlRMCi9jmGCAzc48N0wadhpX9DzsGjTBLcRzVBiHtnJ1a8rB3JTPRkmxrG2V/bp4KN262MmGM9wafEW9eAaImT6W7KV/PHKT531mcuZR0y9fz3WbFuHeYEfZ823xTuwQAejMEgH3PEP/Z17vqil035g0ZCS4cDe3ZbKBi7LsKwZ6fDUdNHP9YbBNdSw0/epslBbTzn8ZElHaiXHGmepkHuGZfE1DhW3cGEBrtiU2RBHA3s117Gxvon8tzBdbSY+0CbwT5NU4RKdeQSkCfErtAieU0eGK3ea48172KIeo9FmUvJprLsRFGrME8LhHVni04Qg46qRgbAJcoOY0gzo1NcNXsdujFO/denx++DPXwh4qDJg7f7OVDvkcROxmFmsVhbWhVaKwfHXql7YBJnX7RNrdUwAhL2b9Gus2/LlRsIW92IZL5LN5vFNcQkcrAj0ShCADAG8+ozMSLSGpJ216kRAXmMMb3lfiYdAJhIKu3T6HdvNBpa6Zw6iU5i4nRSShxQMuEMGaZ19wVhFvsE0SpjfmdiYyoSRXQGy7AAZ9BPt8D2ngNUw3iB4a4W7H24P/Lra7lH1jI5iECp2WQ8OFvZf5bQlP5Ylgc7DAflZA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(5660300002)(33656002)(54906003)(86362001)(966005)(8936002)(83380400001)(186003)(52536014)(508600001)(26005)(38100700002)(6916009)(55016003)(316002)(66476007)(66556008)(9686003)(66946007)(66446008)(76116006)(122000001)(6506007)(7696005)(2906002)(64756008)(71200400001)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bExaOUJyTlNYQUgvdjZ2V1F0VmJsUEFHM2xFcVhFMndDTDVVaEpSdmV0?=
 =?iso-2022-jp?B?ZmJwUHhneVJNVWZNM3MyZTJIbzVDU3FWTzk5bTE2Q3hVOGpmeXc0UXZa?=
 =?iso-2022-jp?B?WjF2RlNIcUloMkIyckNxRnhjT0l1QnpBWkE5NHoxK3ZUKzZ5ZjJXMGp3?=
 =?iso-2022-jp?B?NzhGSjVXOUYrZ2w0ZzBJSzNySnlyZVdJaEZPR0VOK3A2MU5BYWpWM1dv?=
 =?iso-2022-jp?B?bXV4OHZPVE1XaWRpdHFqamFkY2h6N3FiR3pWR2h3ZDhrWUxVSnV6N2Nl?=
 =?iso-2022-jp?B?d1dLc2o5VW5XekhxdEZlVE5GczZLYXFhVFhPeTFwOHg3K1IwMDBEKzhL?=
 =?iso-2022-jp?B?c2dzNzB2K3lUWktsNWl4UFNIUnFxa1JjVDZkOHlmNjRLOXNsd0x5SS94?=
 =?iso-2022-jp?B?QzZsNXdRRTdQN0pqZk5KTzRGOGJNSmhQVll5RVVpYXlIc0VkaStxd3NB?=
 =?iso-2022-jp?B?UGVMdThDTExSQXdQWE8rdmJ4WE40SFlkM085NS9wbHZ0VmlLenBndWJ6?=
 =?iso-2022-jp?B?Qm5Kblo4OW5uWm82SW9CSEhqUjlacDNkejAxaHl0QWpiQ016VS85LzVV?=
 =?iso-2022-jp?B?eHVvc3dqVXg3Q3RpeWhtLzB5UTllSXIxQklqTmN3NmtTb0JyU0lZN3g2?=
 =?iso-2022-jp?B?YkJ6Y0tXS29SL1pNTDZ1QkVpa0hkUGYyTHRYeHIxM0c2U3FjTmxGeEd2?=
 =?iso-2022-jp?B?ajlnU2FiTXR6d2dyclQwaUhTZHZzekFJRjdueEw5YXdzYlNJM1QxckJw?=
 =?iso-2022-jp?B?VnFuUVZ1eTVGaXpqaTFsY0IzaWpweCtKdzg2M3RsZWZHRXBtaDNXbFpk?=
 =?iso-2022-jp?B?aHBOREdqSjBYQklyaHpEbkZyOVBsb1RJeDZCZWVqZU93QXg0cTRVdktr?=
 =?iso-2022-jp?B?S0VCL3RSN2FJUGlvNzRNVUJsdDNVRjh5alRlTEpQTEh5aG5aMGtGRDhM?=
 =?iso-2022-jp?B?MG1UT2pXWkorMjVkTjNQVXFGSGdGTElpQ25va0Q2UlRtZnpYajB0Qisy?=
 =?iso-2022-jp?B?cU82anNTU25lS3plWGh3NlU5T042RDlzK20vTEJERXMrYkQ1NUFwMjVU?=
 =?iso-2022-jp?B?MkpDVzlvUnZ1eGZKdTRPemp2WVpvYTNwVGhoVnRKSWNKSTIyMTE3RHM0?=
 =?iso-2022-jp?B?cE9rTmo4dkloL0s1Z1lXei9Gei9hUU1yQmhDSnN0UE5vc0V0aHNMd01j?=
 =?iso-2022-jp?B?V3UvNVJuS2RmR2g4ak13Q3ZOK2cxWk1nOFRpWVhVK2h3Ni83cDMvaE9F?=
 =?iso-2022-jp?B?S0srUzFsbWZNZFNuZjVCOWI1QTduNHR3SjRFUno5ZFkzWE9UR0s2enlh?=
 =?iso-2022-jp?B?eGV4TzlZNldqSDY1QkhjVWRMYk1BWC9qUStTb1FLWSs4SVV1anVTRUhJ?=
 =?iso-2022-jp?B?NzNVWWZQWXVJaVpveExEZFVuY1dMbng0SkVFVnByamJQUTdYS2p3V0E1?=
 =?iso-2022-jp?B?N05aeFR3NjdhR3VHMUl0YW5na2ErY0FadXV3V3d1ZzB1NWZ1R0l1S2RL?=
 =?iso-2022-jp?B?RVVtd2lIZHVXSmM2cEE3N3FDT3BGK0YxNVJaMFhUZEhqZXpBQmZpdzhG?=
 =?iso-2022-jp?B?V1Z1OHc3OWJxdXh0dHkxYXdqQmRUbFk5MXVWZ0M5U1ovRnhMdWFhVzRZ?=
 =?iso-2022-jp?B?YlhmOFI1eTduYStUWHNTY2tVenExZkhMUE9aK2s2c3QvSWNrOXB3bWM5?=
 =?iso-2022-jp?B?UlVjUW1nOWFiZUFud1FDQndPR3JMK3ZQZklGUHFRenNoVW4reElOdEs1?=
 =?iso-2022-jp?B?SmxNbHF1SFF6RzRFaG9mQUJQNW94elpqcUVNd244YlY1NE5tTG00MzBl?=
 =?iso-2022-jp?B?S1Juem8zYVEzQjRwK3E4NDFDdC9wbC80MzZxY094aGhVMGNhT2gxK2wx?=
 =?iso-2022-jp?B?RkQ4N3BRd1NSdlRuTkh6d2RSOWZWQXVUVnByc1p4cjZXRFlBQVE2c0xl?=
 =?iso-2022-jp?B?SGVVYytSWlpUM2tvaUwxUXdiWHNWS29mVnpxMnVzYjhJd3o5NXd0OFZa?=
 =?iso-2022-jp?B?K3Vha2NBTW85NzBUeDVUZW1rczZadUdWcG45eG9NNWx0aFBBc2F5ZEc3?=
 =?iso-2022-jp?B?aUlVTmpUVmRYMUVtZmMzMXZTWXZYUTl2SzVRWlVmVStWdzNvOS9hWEVQ?=
 =?iso-2022-jp?B?TEZzRm5UaDlGUEFzWEppa0djZ21Xd2g4VHlSY2hrOEVrbHJSMkZ4T1ho?=
 =?iso-2022-jp?B?OUJjekZsbzg0eDI5MzlWWDVTSHptVnA3NGYyak12RVJ4dVFhTGg4aVNM?=
 =?iso-2022-jp?B?UU5UUHZ6YW4vNW1qQmp5WjVBOG42enJrZlg5R0d6WldMVXcxZ1J3OEZr?=
 =?iso-2022-jp?B?QTUzNkJ6Vk45d0NnVHRTaGVnOHMvZnFuUWJJRVNIZU5pNE1FS0JQZGxH?=
 =?iso-2022-jp?B?RlBtOVl4U0VxUHh4QXBHeDRHckxjRWZPVXYyOFBNbWkya3cwMUM0QU9i?=
 =?iso-2022-jp?B?RTNlS3BOaTllOFNyLzY2bnFPZUYwNDVPbVNnZjZob1paaGRwbXpDVWlP?=
 =?iso-2022-jp?B?eHhqZjlJaGY0SGpROTFlMmZnNDFOdERPcHdkVnl4aEhRU2cxbWIxMWMr?=
 =?iso-2022-jp?B?c0U0UXdJMURod2hWRDBwb1FpeEdnWkt2a09uUQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7ffc2650-0117-4403-c158-08da1699b586
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 00:17:45.7192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 BastaykxrSxpGTNFKY+zuqamVrEnh2P2DfYWx96TEyefx2m8NewuYkJszIMlcMe3CyWRonF4WMTMfMdefAVYeKx2rXZFGKJosdXV3lAHiVmM5iiDRaE6ZdOTTi89y/KU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6702
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Apr 2022 17:24:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7994

Hi all,

CIP kernel team has released Linux kernel v4.4.302-cip69.
This is the first 4.4.y-cip release using the 4.4.y tree with extended supp=
ort in CIP. After
importing patches posted to LTS into 4.4.y-st tree[0], it is imported into =
CIP tree.

Yoe can get this release via the git tree at:

  v4.4.302-cip69:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      20a82a3d747c0e408aad2987930f4e89217fcba0
    added commits:
      CIP: Bump version suffix to -cip69 after merge from cip/linux-4.4.y-s=
t tree
      Merge changes from 4.9.305.
      hamradio: fix macro redefine warning
      net: dcb: disable softirqs in dcbnl_flush_dev()
      HID: add mapping for KEY_ALL_APPLICATIONS
      Input: elan_i2c - fix regulator enable count imbalance after suspend/=
resume
      Input: elan_i2c - move regulator_[en|dis]able() out of elan_[en|dis]a=
ble_power()
      net: chelsio: cxgb3: check the return value of pci_find_capability()
      ARM: 9182/1: mmu: fix returns from early_param() and __setup() functi=
ons
      can: gs_usb: change active_channels's type from atomic_t to u8
      net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()
      net: sxgbe: fix return value of __setup handler
      net: stmmac: fix return value of __setup handler
      mac80211: fix forwarded mesh frames AC & queue selection
      net: dcb: flush lingering app table entries for unregistered devices
      netfilter: nf_queue: fix possible use-after-free
      netfilter: nf_queue: don't assume sk is full socket
      xfrm: fix MTU regression
      ASoC: ops: Shift tested values in snd_soc_put_volsw() by +min
      ata: pata_hpt37x: fix PCI clock detection
      usb: gadget: clear related members when goto fail
      usb: gadget: don't release an existing dev->buf
      i2c: qup: allow COMPILE_TEST
      dmaengine: shdma: Fix runtime PM imbalance on error
      cifs: fix double free race when mount fails in cifs_get_root()
      Input: clear BTN_RIGHT/MIDDLE on buttonpads
      i2c: bcm2835: Avoid clock stretching timeouts
      mac80211_hwsim: initialize ieee80211_tx_info at hw_scan_work
      mac80211_hwsim: report NOACK frames in tx_status
      Update with patches from 4.9.304.
      fget: clarify and improve __fget_files() implementation
      tty: n_gsm: fix proper link termination after failed open
      tty: n_gsm: fix encoding of control signal octet bit DV
      xhci: Prevent futile URB re-submissions due to incorrect return value=
.
      usb: dwc3: gadget: Let the interrupt handler disable bottom halves.
      USB: serial: option: add Telit LE910R1 compositions
      USB: serial: option: add support for DW5829e
      tracefs: Set the group ownership in apply_options() not parse_options=
()
      USB: gadget: validate endpoint index for xilinx udc
      Revert "USB: serial: ch341: add new Product ID for CH341A"
      ata: pata_hpt37x: disable primary channel on HPT371
      iio: adc: men_z188_adc: Fix a resource leak in an error handling path
      RDMA/ib_srp: Fix a deadlock
      configfs: fix a race in configfs_{,un}register_subsystem()
      openvswitch: Fix setting ipv6 fields causing hw csum failure
      gso: do not skip outer ip header in case of ipip and net_failover
      USB: zaurus: support another broken Zaurus
      sr9700: sanity check for packet length
      parisc/unaligned: Fix ldw() and stw() unalignment handlers
      parisc/unaligned: Fix fldd and fstd unaligned handlers on 32-bit kern=
el
      mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status
      Merged changes from 4.9.303.
      tracing: Fix tp_printk option related with tp_printk_stop_on_boot
      ata: libata-core: Disable TRIM on M88V29
      KVM: x86/pmu: Use AMD64_RAW_EVENT_MASK for PERF_TYPE_RAW
      EDAC: Fix calculation of returned address and next offset in edac_ali=
gn_ptr()
      ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_range=
()
      ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw()
      ALSA: hda: Fix missing codec probe on Shenker Dock 15
      ALSA: hda: Fix regression on forced probe mask option
      drop_monitor: fix data-race in dropmon_net_event / trace_napi_poll_hi=
t
      taskstats: Cleanup the use of task->exit_code
      xfrm: Don't accidentally set RTO_ONLINK in decode_session4()
      drm/radeon: Fix backlight control on iMac 12,1
      quota: make dquot_quota_sync return errors from ->sync_fs
      ax25: improve the incomplete fix to avoid UAF and NPD bugs
      selftests/zram: Adapt the situation that /dev/zram0 is being used
      selftests/zram01.sh: Fix compression ratio calculation
      selftests/zram: Skip max_comp_streams interface on newer kernel
      parisc: Fix sglist access in ccio-dma.c
      parisc: Fix data TLB miss in sba_unmap_sg
      serial: parisc: GSC: fix build when IOSAPIC is not set
      net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup
      Makefile.extrawarn: Move -Wunaligned-access to W=3D1
      drm/edid: Always set RGB444
      Merge patches from 4.9.302.
      HID: wacom: add USB_HID dependency
      hwmon: (dell-smm) Speed up setting of fan speed
      USB: serial: cp210x: add CPI Bulk Coin Recycler id
      USB: serial: cp210x: add NCR Retail IO box id
      USB: serial: ch341: add support for GW Instek USB2.0-Serial devices
      USB: serial: option: add ZTE MF286D modem
      USB: serial: ftdi_sio: add support for Brainboxes US-159/235/320
      usb: gadget: rndis: check size of RNDIS_MSG_SET command
      USB: gadget: validate interface OS descriptor requests
      usb: dwc3: gadget: Prevent core from processing stale TRBs
      n_tty: wake up poll(POLLRDNORM) on receiving data
      vt_ioctl: add array_index_nospec to VT_ACTIVATE
      vt_ioctl: fix array_index_nospec in vt_setactivate
      tipc: rate limit warning for received illegal binding update
      net: fix a memleak when uncloning an skb dst and its metadata
      ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table() on failu=
re path
      bonding: pair enable_port with slave_arr_updates
      ARM: dts: imx6qdl-udoo: Properly describe the SD card detect
      staging: fbtft: Fix error path in fbtft_driver_module_init()
      ARM: dts: imx23-evk: Remove MX23_PAD_SSP1_DETECT from hog group
      usb: dwc2: gadget: don't try to disable ep0 in dwc2_hsotg_suspend
      scsi: target: iscsi: Make sure the np under each tpg is unique
      NFSv4 remove zero number of fs_locations entries error check
      nfs: nfs4clinet: check the return value of kstrdup()
      NFSv4 only print the label when its queried
      Revert "net: axienet: Wait for PhyRstCmplt after core reset"
      NFSD: Clamp WRITE offsets
      ima: Remove ima_policy file before directory
      integrity: check the return value of audit_log_start()
      bpf: Add kconfig knob for disabling unpriv bpf by default
      tipc: improve size validations for received domain records
      moxart: fix potential use-after-free on remove path
      usb: gadget: f_sourcesink: Fix isoc transfer for USB_SPEED_SUPER_PLUS
      ext4: fix error handling in ext4_restore_inline_data()
      EDAC/xgene: Fix deferred probing
      EDAC/altera: Fix deferred probing
      nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client.
      scsi: bnx2fc: Make bnx2fc_recv_frame() mp safe
      ASoC: fsl: Add missing error handling in pcm030_fabric_probe
      net: ieee802154: Return meaningful error codes from the netlink helpe=
rs
      spi: mediatek: Avoid NULL pointer crash in interrupt
      ASoC: ops: Reject out of bounds values in snd_soc_put_xr_sx()
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()
      af_packet: fix data-race in packet_setsockopt / packet_setsockopt
      rtnetlink: make sure to refresh master_dev/m_ops in __rtnl_newlink()
      net: amd-xgbe: Fix skb data length underflow
      net: amd-xgbe: ensure to reset the tx_timer_active flag
      ipheth: fix EOVERFLOW in ipheth_rcvbulk_callback
      netfilter: nat: remove l4 protocol port rovers

Best regards,
   Nobuhiro

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/=
?h=3Dlinux-4.4.y-st

--
Nobuhiro Iwamatsu


