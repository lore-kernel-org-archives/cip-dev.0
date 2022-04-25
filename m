Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F5C5AC75
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.27145.1650877311485069492
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Apr 2022 02:01:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 23P91Vd7026036;
 Mon, 25 Apr 2022 18:01:31 +0900
X-Iguazu-Qid: 34trWdh3MEGSkktm7o
X-Iguazu-QSIG: v=2; s=0; t=1650877290; q=34trWdh3MEGSkktm7o;
 m=kbau1/EPd/fWaD8F7ZxXdWqIRIDw5T7fHKeFXhDVNoU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 23P91STa025867
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Apr 2022 18:01:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O553w95ry89eyfWngH5B3V6u8twJXZ7g9H9ukdQgcBoSPx337ibYuweCEgYP+uFXIXD2vmaZ+x1j7MaaAZaRzZ8C73R+QMP0CJgvYneGZ7wc4u5v15f86kftaJNT/ODwLCIKWbl/ZIVOBrIY8x56LQKjaXyYeFXm3n3QHQgAoSKFc5L7vuoQeOAlCDZVEUW4LXhuwrOCaPA7srJC6R63qkMYZDhqxtc+lLZYiW8YzY9j3WdzQ6yQhwxnQR7j/7lGOih9+qj578tq8JI14FISotVXUX816ppAy1TM/kO5LjyiTffxEqVaa9g/WUTzRZ+YVsBvEnkLH5ry3hCqHl0Yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28Sz72FPd2EBHAVz17s8bEHhGXBnPc4fwgMAsZ8P+v0=;
 b=hO804/QUakuk9NjZEBw5G2JwdIea0cz2BN/CTg9yKFXTVLstjNhqYeSTjI3gAnb1tijoHmPs9OSszYa0hFhzJ6b4sz6+rRLhChzeMuFU/o5j0BlOCIM3gPlqAVbQFUX+rxR54+B/QH9M5sfLz6BSj1vGkVpWgkhiyanXuaBX3oeMSxfRBssUGrFuun46flrhVwnLr1i77TiVxwdwmZ6XyZXQIk5JSxWiowisIDZHGUOfRV3XX6iIKTzYMIUqfmfQTCqp7LdQAcboD/OvD6YEjarLmsQV7k6++ZbO9hudJxm8I8+WTsFpd5hjzYXGJGUvZMp30NlRHlI7YnanW+takg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v4.19.239-cip72 and v5.10.112-cip6
Thread-Topic: [ANNOUNCE] Release v4.19.239-cip72 and v5.10.112-cip6
Thread-Index: AdhYfNyAfnR8mnnlTiqhz4pf9zV2fQ==
Date: Mon, 25 Apr 2022 09:01:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420BB61A805FD201A641B4192F89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1002c251-8337-4a9f-6c1c-08da269a2dd8
x-ms-traffictypediagnostic: OS0PR01MB5490:EE_
x-microsoft-antispam-prvs: 
 <OS0PR01MB5490EEBD28ECFC2E670BE55392F89@OS0PR01MB5490.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZWN6c4Wzlp1aVXoiibOo7Yka4LP/NxHZcNT8N0cIRBxpoSY/bLE+Z27or77GV9h0zlfsWSU6cwUl1B56cRYHb4FG6wnTlUvvbcSnjGdywsp9R6Sa7GjGVKosq3+S5CoGvyB4EvUnm8yB5ocZhHMg6ezNqz2eAXhE8wJBzw6dAGpOKyy3SXX+LA4kIzWeVo5xT0hrG6b+GdtRpE88Yz3wqUbmAMRGjK8psBYc8s3qrAfDXm8ChI7RjYly2YkTDD5ynt1tYkWz2odEQONcLED8bBS6ALKRXxzL5ZebsgRqHoMWYkqf9CpAEC38urYLfPHvTk7yDDsZuccI14Z2V6Zoje64jZI9SyaU8ONtr6TGw/1X8QlFV6/tFNpGokGSgZachJ1AOP6eFOhGjgc1SBD0lik4eijHiJfJoXEihfoXXOXo1yUjDXJeh09h6X9flLuOqFxagrhnn450qrAXCHizYkBzu0nGW6AUQHn3U65DcKz4hgwnK3TWC5wj0rFNFXxxnupx5bFzxK/459gcshhi+1tR8puSfpY0aA4qyfADabni6fk9FBn2HJhoIW5YK9WHvRoyZm51+FMi/UH9+GVlJLqs2Jj8V/ZXcBTRSGZGYFD49++62gKI0/NufU2DUK8kbQRVahp2y5ZD9OhexHqt9SKb2VmiQL7qRffP2Qv6RrlL9xi0S9l2oITlAdzNFIw1pUMACcS3rE+bl1VBKtl3cdVwI1sR6jGFwC460Wp5GcQd0OzOuDNVisbJIEOQusfiXSqYot6c0kKNpULO8gZK4w1nxdlIbXgnRTqVEFEG2mU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8936002)(54906003)(6916009)(26005)(186003)(52536014)(508600001)(966005)(33656002)(71200400001)(9686003)(55016003)(8676002)(4326008)(66946007)(64756008)(66446008)(66556008)(66476007)(5660300002)(86362001)(6506007)(55236004)(83380400001)(76116006)(122000001)(2906002)(38070700005)(7696005)(38100700002)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dTBkSmkzbWpHc1MraS9oeFN1YVpsdTU3alAyS0tkMzJqdzUwK1lBa0li?=
 =?iso-2022-jp?B?T0NoNlNSaURZZmsrempEdHdGdVBDNVcxSWdSYlVPVUNZV0pEMnVvaDdl?=
 =?iso-2022-jp?B?QzQzeXhaRnE3amNxbnpSTnB4ckRxNWRwYlVrdUlYYTZVMmVYRHVtRzBT?=
 =?iso-2022-jp?B?eEJJT1gyVE43b3N3a1lueW8wS1BxN05FamxySjJ6cnd6VU03aE4vb2M2?=
 =?iso-2022-jp?B?N2l5VUlvNUxvd3VOTitUTTIvOFJ5WThDWG9nOFFHL0RkTUNkUXErMEYz?=
 =?iso-2022-jp?B?bGp1c0JSTEhleGRiREpMb0lKT2syMUdvTmNMVml2c2tjUS9DL3M3OTYw?=
 =?iso-2022-jp?B?ODg5anQwSmZ3bjFqNUVKTHVwcndlcFdnZ3ozakw2NGpRM005S0hmdjlo?=
 =?iso-2022-jp?B?Y0lyZVRLUGswQnFmVEZxaGFKL04xU0ZXaTE1MGY1OHp5QWw1cXQrRlk5?=
 =?iso-2022-jp?B?Z2MzNjZhUzU4bTlaVWo5WWxMQzJ6aTllRHlWbS81UTh3ZVpHZWNtdktk?=
 =?iso-2022-jp?B?NHg4NlE5KzNoYWlxZmNBajBDWENBeEJleDR1L1pmRmI2WExTN2tVWFFk?=
 =?iso-2022-jp?B?bld1dHIzTVRJVXQ3TWJ2QlRESkh4cHlHZHJac0hRVi9DMW9DNDJQMFVa?=
 =?iso-2022-jp?B?MHpTa054ZUlXOG5hY2Rla3Mwem9mUGRJbk40SzUvZUJNYkU3cUJRTXdp?=
 =?iso-2022-jp?B?TUxrSUFSUWFqdWhtSzJSYTltOXA5L2trNUVtcWlxTUZMVXdydDNGdzB4?=
 =?iso-2022-jp?B?cUM4S0lxcjE3NHpVbkxoQ0xzWlRpU3JxdHI3blV1TVVidG5zNGpPb1RP?=
 =?iso-2022-jp?B?UW82ZkkySStGQmpZblFYZkd3SW5zNUx2TlFhQ1Nwa21vQUZja2tmMGI0?=
 =?iso-2022-jp?B?dW5Pcml4MnJzSFFWdnRLUWpkWjNIZlovbDRaLzR4aFpLN0FMOHVDbXJp?=
 =?iso-2022-jp?B?N2hiSzNONExTUjVDRzZrVGVXcXc4dEtnSTU2YVZZMXJxZVh4MENNMkZH?=
 =?iso-2022-jp?B?ZldqekdnYlFyeHpCcy9WeXl4NXVBWVEreEROUStPS2dRRTZCR3ROdm9B?=
 =?iso-2022-jp?B?NzkrWEpkYlV5THNDb0k5WXBvNW9vaHlHc04velJoM2xHZDlXZ1JZbmh4?=
 =?iso-2022-jp?B?NE9nTUpML0lCM3FKZnl5WXNjaC9acUNSaWY1R01vbjArWDFKZ2lEZkZH?=
 =?iso-2022-jp?B?WlFUc1lGL3IxTXRRSnRNZFBEZGhQQWIwclVMdXlBcnZWWWZmc3pkcWx1?=
 =?iso-2022-jp?B?TC9kUjBLK001bXpOWStYRjduRE1CaWU2R0JENXpuSWh0alR1ZEhBOEsy?=
 =?iso-2022-jp?B?Ty9KdGlzSFB5NEF1dlpFR1BOUkRTZnZaQVMyZWhOUGVVSW9LNVVLQVdM?=
 =?iso-2022-jp?B?dG5XV0lQQzkxWTlWMHFSVDRjdHNQZmYyREMyR3l4RUNVWjNITUtuZ1lw?=
 =?iso-2022-jp?B?UVIrcy9nZWkwUlA2cTA2ZUNHZzRQc1R1N1JnZGxDbkRubVRYODZxVGtz?=
 =?iso-2022-jp?B?enlXaFFXeFFwbFZySWhwN2hYdDduc0lYY240dE81YnJydk15VVprdTJi?=
 =?iso-2022-jp?B?K25DWGNmWlg4TzA4ZVVIcG92UjFoaURkRmFCZ2Jhbnd1UzlIa3R2ZUoy?=
 =?iso-2022-jp?B?YkxXY1N0aVVTVFlwY2NPdFBTeFRERUFmQkhhd1k1OENwKzNPNytKaGMv?=
 =?iso-2022-jp?B?Z3psOStjU3ZuSk9Bd1lQc0ozK3orQ2RwczhHQzEvK3RKVmtxaktHS05x?=
 =?iso-2022-jp?B?OVVUdG1STUdtT1pqVytkWXd4aW83b0gyRXZRc2dnUXc3N0dBM1JtWWYz?=
 =?iso-2022-jp?B?QitMcVFJeVo1Z2JROUVlbHhTaC9pb21sempDSEd1RkNlTnc0d3FDd0lq?=
 =?iso-2022-jp?B?UlhyNklhVGk1ZlhKTll6MUlGRUNQRFM5aWQ4TGFRcVBURGU0WlZQb2FJ?=
 =?iso-2022-jp?B?YUlWaVdrUXVTaklPSUQ5M0U1YmVSL01rYnd6TERzN2NZRko1Y3FFNDhu?=
 =?iso-2022-jp?B?VkV1REg2RUc0VzIxWWFjM0NRemNQS0dkb0tTZVVFVnpmKytEL2E5UW1F?=
 =?iso-2022-jp?B?bW02VUxNcGg3aHRJbzJkR2lyMU9lbmZzOExyR3ZUcFQrdUpPZnBBU0dJ?=
 =?iso-2022-jp?B?QkllSGkrTDl6blJtY25wTjE0UlltRWg2aUk4cDFxZHEvZnBEdG13aDh0?=
 =?iso-2022-jp?B?TXllTnM0RzRoUENoYmN1ZDlwZTU4L1FPME0wdjNwa05Za3g4U2REN1Yy?=
 =?iso-2022-jp?B?U3M0bzFEL3FpR0N5b2Q4OXA0THlNWTBjVlNnbkZzRTd2RjdESDJaUzNj?=
 =?iso-2022-jp?B?Y0IvVHpkaGRjcmlpb0JVV0JJNUlmRnBLUHREejNScHR3b045cnRhYnFs?=
 =?iso-2022-jp?B?T1QrN1BnMFd3SlRxZFdFSnN6NVJJUTBVT0l2ZEZ6M3pteFNlNDF2QTBP?=
 =?iso-2022-jp?B?MGZPTlpLSjJLL3A0N2FEcWZVRnE1WUwwemxUQmtkSmdIMWttOTJLdExv?=
 =?iso-2022-jp?B?Q0JYK1VSNENienVBZVB2VXd4VEp1dTNmU0t2b0JzVUV2NWlsaW82S2Nx?=
 =?iso-2022-jp?B?TXhZbG1JST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1002c251-8337-4a9f-6c1c-08da269a2dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 09:01:26.2111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 UDYC63Obnm+GTbMjBLgHD8TKEeYwuQTzTAgXn2oW0vCnDDyYKRxJD4tGSGoZcTeViAQofL/XWS/kkRXoCGZ3IFrU/1byXoGUxBRdhJu9Ee1yukaH7A5KhteW78+c8G6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5490
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8194

Hi all,

CIP kernel team has released Linux kernel v4.19.239-cip72 and v5.10.112-cip=
6.
The linux-4.19.y-cip tree has been updated base version from v4.19.237 to v=
4.19.239.
The linux-5.10.y-cip tree has been updated base version from v5.10.109 to v=
5.10.112,
and sound driver patch for RZ/G2L has been added.

You can get this release via the git tree at:

  v5.10.112-cip6:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      c8f6747dcd02a8f87731c324f4bc37bd120a8982
    Fixed CVEs:
      CVE-2022-28390: can: ems_usb: ems_usb_start_xmit(): fix double dev_kf=
ree_skb() in error path
      CVE-2022-28389: can: mcba_usb: mcba_usb_start_xmit(): fix double dev_=
kfree_skb in error path
      CVE-2022-0168: cifs: fix NULL ptr dereference in smb2_ioctl_query_inf=
o()
      CVE-2022-1158: KVM: x86/mmu: do compare-and-exchange of gPTE via the =
user address
      CVE-2022-1353: af_key: add __GFP_ZERO flag for compose_sadb_supported=
 in function pfkey_register
      CVE-2022-1198: drivers: hamradio: 6pack: fix UAF bug caused by mod_ti=
mer()
      CVE-2021-4197: cgroup: Use open-time credentials for process migraton=
 perm checks
      CVE-2022-1204: ax25: Fix refcount leaks caused by ax25_cb_del()
      CVE-2022-1205: ax25: Fix NULL pointer dereferences in ax25 timers
    added commits:
      CIP: Bump version suffix to -cip6 after merge from stable
      arm64: defconfig: Enable SND_SOC_WM8978
      arm64: defconfig: Enable SOUND_SOC_RZ
      arm64: dts: renesas: rzg2l-smarc: Add Mic routing
      arm64: dts: renesas: rzg2l-smarc: Enable audio
      arm64: dts: renesas: rzg2l-smarc: Add WM8978 sound codec
      arm64: dts: renesas: r9a07g044: Add DMA support to SSI
      arm64: dts: renesas: r9a07g044: Add SSI support
      arm64: dts: renesas: r9a07g044: Add external audio clock nodes
      ASoC: sh: rz-ssi: Remove duplicate macros
      ASoC: sh: rz-ssi: Add rz_ssi_set_substream() helper function
      ASoC: sh: rz-ssi: Use a do-while loop in rz_ssi_pio_recv()
      ASoC: sh: rz-ssi: Make return type of rz_ssi_stream_is_valid() to boo=
l
      ASoC: sh: rz-ssi: Drop ssi parameter from rz_ssi_stream_init()
      ASoC: sh: rz-ssi: Make the data structures available before registeri=
ng the handlers
      ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv() recursively
      ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()
      ASoC: sh: rz-ssi: Improve error handling in rz_ssi_dma_request functi=
on
      ASoC: sh: rz-ssi: Fix wrong operator used issue
      ASoC: sh: rz-ssi: Fix dereference of noderef expression warning
      ASoC: sh: rz-ssi: Add SSI DMAC support
      ASoC: sh: Add RZ/G2L SSIF-2 driver
      ASoC: dt-bindings: renesas,rz-ssi: Update slave dma channel configura=
tion parameter
      ASoC: dt-bindings: sound: renesas,rz-ssi: Document DMA support
      ASoC: dt-bindings: Document RZ/G2L bindings

  v4.19.239-cip72:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      fdf770b2db8080de95dcf74cc7547319034a4a56
    Fixed CVEs:
      CVE-2022-28390: can: ems_usb: ems_usb_start_xmit(): fix double dev_kf=
ree_skb() in error path
      CVE-2022-28389: can: mcba_usb: mcba_usb_start_xmit(): fix double dev_=
kfree_skb in error path
      CVE-2022-1353: af_key: add __GFP_ZERO flag for compose_sadb_supported=
 in function pfkey_register
      CVE-2022-1198: drivers: hamradio: 6pack: fix UAF bug caused by mod_ti=
mer()
      CVE-2021-4197: cgroup: Use open-time credentials for process migraton=
 perm checks
      CVE-2022-1011: fuse: fix pipe buffer lifetime for direct_io
    added commits:
      CIP: Bump version suffix to -cip72 after merge from stable

Best regards,
   Nobuhiro



