Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CDC54EAA
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 23:41:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.1877.1675122109411084842
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 15:41:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 30UNfRgE030433; Tue, 31 Jan 2023 08:41:27 +0900
X-Iguazu-Qid: 34tMMX4CASygRBNnPU
X-Iguazu-QSIG: v=2; s=0; t=1675122086; q=34tMMX4CASygRBNnPU; m=hcHEZfyQLTSvk4JqTq7ij4bRjnUTb4IndHbnj9bNeTk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 30UNfO59040448
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Jan 2023 08:41:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McUV+9Po4vswWNWJL046ALsWzAFCQd++9e7loHQib5+l/R/fJPi2rY99G/fnpVBv+NJ1oZ+o2OCX0CGtDeVNG7qJ4iFlD1YTPq/xErW2m+sx1NtnzB/f1LJwjfcMCnR1JOdo2nnFXHvQzUdx6XS/ExUJz5vfl8/0iU6nicGN+O34XdcBLtvMuYSZPSPDsD1r7xDsDONXSP//vH51sR7Atstmxvrv6cns6DspXacpBdVCS1F/pJl1fiweod+6Ciei4H8ACFoslE/D59Q9SyXmYZ7KrB2wNuN2WHc9pKqCQ3wbUrbPcrAm1wYMDLSbWrDh38oP8d69DGRtUNTwabmv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQejwlnDEkKFE3FvP3NcAvchSF/nKMNuFjfQr/x+QZ8=;
 b=XixnbhhpOxSaUyp54xuO7sbNYTAoLrRbzBhQbLBFSEby+w8VtglwicKdncCV1KLPIRK+OcTfGHEcoysfhmORxyCVsh4dGQs0zvramuGw4/6B1L3BaZIDU21eiNrqnWkud0ywAF/mrHW42ON9qczMFtvtR6u1wQfUVnHtFNSjrKZj3FT5FX8Uk/Wk2aRX5CGRUK6B/I06+M/maX99L6myW/1PEb3c5fOipTic0H2US3dPZVWcM1VHpi09oDfvv0mnpbDsylMsabfSu/nRPZ5RCOVpd1AYc7CF+OyWFpqesxRGePOmXxmYpMq3BDwvnDr3eAQXO6pQjSzjbMkgKt7SAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.4.302-cip72, v4.19.271-cip90 and
 v5.10.165-cip25
Thread-Topic: [ANNOUNCE] Release v4.4.302-cip72, v4.19.271-cip90 and
 v5.10.165-cip25
Thread-Index: Adk1A+zWpS0f6MdGQqy8C6zcHBuscA==
Date: Mon, 30 Jan 2023 23:41:20 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94206873832A2D4F5915D2CF92D39@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB11782:EE_
x-ms-office365-filtering-correlation-id: 7630131b-c87a-4a81-2db3-08db031b7d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtHf9mgBvaK+nhfEkdv7lq1Zdxm8vh94tvc4KzBRnrgvXnIEsDCtTo7/nUZXC0UCR51Qd9vih3wy+2mZjoMxRTSA+QNGfr+okl2KYewetiLYPOWGrXGAevJZghR5PFtfwYs7WXyPx66rRnyjQ7qYOvij6rDLbsUgM+L58RFiHHzYt5DLo75u5TB3EAS6tF34qdhBmMEahZnp0Fy1F0Be4doYRdBsuRMABkaVf+dl5nBsWIaw/G3Za/FWs7VQVv+ZtXhX7eAOZiCl+4KKD7b0aqcsVkf5VbCGIxfWX9wgrQ20OUaYTnPwXHxb0PkdesD/k8ojU0U678cGZ6mxsJUiwSOEi2VAA4Qc/P6cI0IcDaWdfzTzTG/73mY30nvdE8xMk9Yd9coLo3svVXeZMbVQ6qwlhwTbgY3hsur0sCodhMyPzLJLG5K+5FNtbftEQGHSzi75MGY+gzV14yJnhc6qcC9gTN2jr04ZrcylgvxaoWYXyth6nwrdRE7B1xpdEttU2JF1kd9LcGeYH/nGN83sCODOLVGHRdYr6Yj0Beyb3ihr4iv/tTwRw2KcehKJHUdIRENnPmhOJaZCcXmV1a5bj849D5A1Rr1YQqxL/TViDCSwCf1WecY7v5y3UZRW3X3xd+sIZyC1nrResk+JcEMIFgPnnjagCGb/oiAtwo9wdSUByJnClLbQYAkbHrOvLMKabBoMx4NIIkvGWBqG6HeOOJKhR6aClcz6WJvHYXW+/U9Uj4COuGJPIVlbsxMlHrZqvqsG1t84rh+aLD30F59B46Qu2TyxPV/xIPBZYT8y2dU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199018)(316002)(54906003)(33656002)(38100700002)(122000001)(41300700001)(2906002)(52536014)(8936002)(5660300002)(55016003)(83380400001)(6916009)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(7696005)(6506007)(966005)(71200400001)(478600001)(9686003)(26005)(186003)(86362001)(38070700005)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eDBIdXZ4OXFqcGFSZ2pCU1JCUW50aERiMjM3R0FQYTEzNnI0MS96UjFV?=
 =?iso-2022-jp?B?dlhoR2NPV0JSVkdWUDJQREJ0TVFZbUdyMWxvWk05R2FycTE2OEdTeElv?=
 =?iso-2022-jp?B?b21iR3U1U0xBWXpRZ0UrYlY0dkl4UCtzSGczRUpxNmM4RG9CbkJjcmxq?=
 =?iso-2022-jp?B?eHUvQlRRSEpxb0RrQnZacFFJZDlsYXJ2QXR0TWtCbVZEcjZpenprMnhV?=
 =?iso-2022-jp?B?Z3hXWFR1cEVWRk5OUVdDcDljY3ZqV1g2bDFidEl3UUlVcTFTeDF5MHZG?=
 =?iso-2022-jp?B?czZSODBvc0JaRlExSHZ1MXo5dFF0bmJBVUVoK0EzM0FwUVpabUNUMmtl?=
 =?iso-2022-jp?B?VDlzUDlMR3JQN2xmWWNNdzRnTmF3OHlkaTZaU2h4MUlvWTFaNDM4d09X?=
 =?iso-2022-jp?B?T09UaktWd0tlVGhoQjVLV1B4ZkhQdGZ3N251em00OUN6MWZSNzYyTUIz?=
 =?iso-2022-jp?B?dExPM3daSkRaTWNMZkM5cFNKV1VOVXA4REg0U1JiMktJNUM2Tnk2c0h3?=
 =?iso-2022-jp?B?Z0hDc3ByTE5mK0JBckIvSmxTcW9yZjBjRFZMbEdjMGFrbmNPbkNrZmFU?=
 =?iso-2022-jp?B?U3NuRU0zVldrS1QreitmUlRESVZOeDB3bDI5b2o2ZHVRWk1YV3pLZFhw?=
 =?iso-2022-jp?B?Q2lGenNmTVZzWEY1WmFCZmQ2eE5TYkxJUXNYZU1rYnI4R1lPcmsxWFFq?=
 =?iso-2022-jp?B?a2NTMGN2cFpvZXFvT25wL3lzUXJQei9OdjdpUWF0ZjZRRCtjZWtYM1Bm?=
 =?iso-2022-jp?B?azIrRHVyQ2hiU3lIUVlGbUt5dFlSUGcxTUlpU2NESVkxQXVkTHFPa3JG?=
 =?iso-2022-jp?B?WFpyell5bTdCV2xyYjl5MGRyYWF2ZE0vZ0ZrYk9tMWQrQ0NLdEhQQ3hG?=
 =?iso-2022-jp?B?Q3FQdTlNa2RUZmxmazFjUTk1eXJWL2tzTDhHQlpIVEVpYXBicWlhZlpu?=
 =?iso-2022-jp?B?QXEwSGNBNjVEOWM1Q3kzK0RjOVU2VndiNkNXNWl0SXFlYnRHMFd1RmZx?=
 =?iso-2022-jp?B?RUhqQ2VCTUViL0ZvR2d1Q2RvMXE2TlpsOGt5dmZCemlDM0krdEYxNWpD?=
 =?iso-2022-jp?B?K3ZsQW9hbzVLK0k0N1lZRzgvcWc2am56NEhnT0h5cXFYWWNWVTNrVExt?=
 =?iso-2022-jp?B?Q1FQQ1VIVnNsRDlNUTU4MS9qT3FOODJTT0M3ZlhWU3FYQUs4TkI5UnY2?=
 =?iso-2022-jp?B?cXJZNktPeExTNXRtRTRibHZrSlZtS3N1bE9lVk5CUWo3N1paRDBUUFhZ?=
 =?iso-2022-jp?B?cWJyOVQrbkN0UmNvbmtkblIrS0kwMWJUSUo3OUVEeG1pTGhqUTBDbFFm?=
 =?iso-2022-jp?B?OTZ3Zjk4WUhIT01kM1ZNYWt3OU5idDBiZzhCd2Jiajc0TWRZVTQ4NXU3?=
 =?iso-2022-jp?B?VU4rTC9nSURnbk8xY3VzOWUxRloyU09WQ094UlNYbEZXTFJJTzB1dVg5?=
 =?iso-2022-jp?B?T1d3NTdIUUZBaVRVc01ob0hrazZUUjZXWTQzaVE3UzUzTTRDNG9FWVVJ?=
 =?iso-2022-jp?B?ZzQzTDU4NXBEZlpUMkEwZW8raDA4ZzhJSTdhZ0FUdXFiL09xZGM4V1Bi?=
 =?iso-2022-jp?B?YTlEWEFFODBZRTNxL3VpMS9DOWtQaHJEcllGKzFOOGpNRzliV245WXc1?=
 =?iso-2022-jp?B?Z21FMlhVRlRQc1YyZTB6R3FKWkFQd0hoQldqOVcycmUxVzdCbXA2Rytz?=
 =?iso-2022-jp?B?K1EwS0IyRXRpNnhJWDVnekt5K0RvWXIzTkZWSWVyQ1dvY0JzclhOSkZJ?=
 =?iso-2022-jp?B?OGFHdEdMUUUyYXlTNk5iS2lmODNxK1pBUi81czR4dFNYMEJRVWlJT2dS?=
 =?iso-2022-jp?B?TjFWWVlRZDVHTUpJK0ppQU1WV1dTcWxpYXdzdllGTHNQWnVLeUgyMFJv?=
 =?iso-2022-jp?B?Q21zUzZsK2NTd1VrdDJGcjFrSGQveWxYVGNnMjBiMnZDcktXSlJuNWxP?=
 =?iso-2022-jp?B?WWlkeTk0WEdadGo4dXd3V2Jla1hBR2pWcXRpcFpGako0ZkdITHZHTlBo?=
 =?iso-2022-jp?B?a1dxQSs4R0JMUXhaN2hTc0EwclMyaWVCRlpQL1ZDb0ZBSlpmM2xxSTdw?=
 =?iso-2022-jp?B?Tm1HYjJPWFR5RDQ1VTdDS3dlSDNrL2dkMzFDaWJINzhTUjdwb1VNM0lm?=
 =?iso-2022-jp?B?OHNBZm1VY09WVHJOZTF0K2lUOUMxSS80R2RxYVVRWUJlUTEzZnFVZnFE?=
 =?iso-2022-jp?B?Mmcxb1M3YlNYNFRONGFUZHRFMzJDbTA0VzhGRHFMcXpFSC84Zkd6Q004?=
 =?iso-2022-jp?B?NXczdDRpeExVcVNyUHhFOHJqSDZ4bVJxY1pwcHRhRTRQekNETXQ4NWR1?=
 =?iso-2022-jp?B?S3BNSUpBR2dmcld1MjNqMXZLMks5YzVOSEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7630131b-c87a-4a81-2db3-08db031b7d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 23:41:20.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lc2qq2XENeaaMqy7kSBzOKt/Bxp3ychIub9PonUuzVbdhd6DpLSVbZ9NYZkObVdbZu/idLFvoFu9EENQxDV4Ir0UWZ3/6J+Hshjv9eSd/EkxW7PJtzDd1tXcifSBptZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11782
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 23:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10514

[ANNOUNCE] Release v4.4.302-cip72, v4.19.271-cip90 and v5.10.165-cip25

Hi,

CIP kernel team has released Linux kernel v4.4.302-cip72, v4.19.271-cip90 a=
nd v5.10.165-cip25.
The linux-4.4.y-cip tree has been updated base version to v4.4-st37, and th=
e linux-4.19.y-cip tree has been updated base version from v4.19.270 to v4.=
19.271, and the linux-5.10.y-cip tree has been updated base version from
v5.10.162 to v5.10.165.

You can get this release via the git tree at:

  v4.4.302-cip72:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      0af99ca381ce97af181eab7f6fc808b1e039ac3d
    Fixed CVEs:
      CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().
      CVE-2022-40768: scsi: stex: properly zero out the passthrough command=
 structure
      CVE-2022-3646: nilfs2: fix leak of nilfs_root in case of writer threa=
d creation failure
      CVE-2022-2663: netfilter: nf_conntrack_irc: Tighten matching on DCC m=
essage
      CVE-2022-3628: wifi: Fix potential buffer overflow in 'brcmf_fweh_eve=
nt_worker'
      CVE-2022-41849: video: fbdev: smscufx: Fix use-after-free in ufx_ops_=
open()
      CVE-2022-45934: Bluetooth: L2CAP: Fix u8 overflow
      CVE-2022-4378: Linux kernel stack-based buffer overflow in __do_proc_=
dointvec
      CVE-2022-3424: misc: sgi-gru: fix use-after-free error in gru_set_con=
text_option, gru_fault and gru_handle_user_call_os
      CVE-2022-3621: nilfs2: fix NULL pointer dereference at nilfs_bmap_loo=
kup_at_level()
      CVE-2022-42329: xen/netback: don't call kfree_skb() with interrupts d=
isabled
      CVE-2022-42328: xen/netback: don't call kfree_skb() with interrupts d=
isabled
      CVE-2022-3649: nilfs2: fix use-after-free bug of struct nilfs_root
      CVE-2022-3542: bnx2x: fix potential memory leak in bnx2x_tpa_stop()
      CVE-2022-39842: video: fbdev: pxa3xx-gcu: Fix integer overflow in pxa=
3xx_gcu_write
      CVE-2022-41850: HID: roccat: Fix Use-After-Free in roccat_read
      CVE-2022-42896: Bluetooth: L2CAP: Fix accepting connection request fo=
r invalid SPSM
      CVE-2022-3594: r8152: Rate limit overflow messages
      CVE-2023-0047: Out of memory in local cgroup's memory may cause denia=
l of service outside its area
      CVE-2022-43750: usb: mon: make mmapped memory read only
      CVE-2022-3565: mISDN: fix use-after-free bugs in l1oip timer handlers
      CVE-2022-42895: Bluetooth: L2CAP: Fix attempting to access uninitiali=
zed memory
      CVE-2022-3643: xen/netback: Ensure protocol headers don't fall in the=
 non-linear area
      CVE-2022-3643: xen/netback: Ensure protocol headers don't fall in the=
 non-linear area
      CVE-2022-36280: An out-of-bounds(OOB) memory access vulnerability was=
 found in vmwgfx
      CVE-2022-2978: fs: fix UAF/GPF bug in nilfs_mdt_destroy
      CVE-2022-3564: Bluetooth: L2CAP: Fix use-after-free caused by l2cap_r=
eassemble_sdu
    added commits:
      CIP: Bump version suffix to -cip72 after merge from cip/linux-4.4.y-s=
t tree

  v4.19.271-cip90:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      6cd0670e124d09e80f2daaf2ecb13922a603f30d
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip90 after merge from stable

  v5.10.165-cip25:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      52aae1dc6afe62fedb14c89fd4feca1d8bb13416
    Fixed CVEs:
      CVE-2023-0266: ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to=
 prevent UAF
      CVE-2022-41218: media: dvb-core: Fix UAF due to refcount races at rel=
easing
      CVE-2023-23455: net: sched: atm: dont intepret cls results when asked=
 to drop
      CVE-2023-23454: net: sched: cbq: dont intepret cls results when asked=
 to drop
      CVE-2022-3424: misc: sgi-gru: fix use-after-free error in gru_set_con=
text_option, gru_fault and gru_handle_user_call_os
      CVE-2022-47929: net: sched: disallow noqueue for qdisc classes
      CVE-2022-36280: drm/vmwgfx: Validate the box size for the snooped cur=
sor
      CVE-2022-3534: libbpf: Fix use-after-free in btf_dump_name_dups
      CVE-2023-0179: netfilter: nft_payload: incorrect arithmetics when fet=
ching VLAN header bits
      CVE-2023-0394: ipv6: raw: Deduct extension header length in rawv6_pus=
h_pending_frames
    added commits:
      CIP: Bump version suffix to -cip25 after merge from stable

Best regards,
   Nobuhiro


