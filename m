Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1ECC4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 07:03:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.600.1667977388434983502
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Nov 2022 23:03:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 2A972iWo006797; Wed, 9 Nov 2022 16:02:44 +0900
X-Iguazu-Qid: 34trW0L3lUsC3U2xhz
X-Iguazu-QSIG: v=2; s=0; t=1667977364; q=34trW0L3lUsC3U2xhz; m=4yXPiEqNfxjYGRqGQ4FrQRqPblb/jTxlTh9EI6r/Ljw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 2A972fCt029306
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 9 Nov 2022 16:02:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKxeFGI6NaXoaXwBI+sBnb5QYHp0K3NVwuBahFPUG2cmTGf84xn/TBbJyeosrp5TETzi5pAkiXy8mh5TtdLWxYJ+DatxmdcbEvCKGKO0wahVJR5i5l9wowDvn+cISRefPr9ZMZMqcIqf/9U5WLV2+fRkiNsaKylO1pt5b5oTHXSvCg7RtS3g/5MCrWwutPHmGCcMy7R7hv8QvD26hl+YpEBsb7wFsj8U6z1GMsdNSz7v6V0JdD5+19s+DUhDfjI4u41BwLFS14Sp01038WF+lADM5WhAJegdB9MPHLP/ZMB49UbxtOBAS7V/4fvGJ4Wl4xNT1VK5D0N64Op7egncNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr4O9SsNdnn6adgZfQxR0s95jzxL8x7nUNqowwPPAbE=;
 b=UXrj0P3rl64TF8cjCge8Knq9O8VJIkFQqZuPVJ3/un7b3Sd+hbB209CG20MR8nLay+kMGSaDJOFNJ3esjlsbTo0cnZEBwueGzjU35GDlFy9t5zCzlSHdqTrvDtZnM4H+wsFWqn7+Gw186f1H4NUxbGUU2TQ+3WJEfsTZPaUAU2HSEY2ZAwywDR/UCDf3Yl+PVNQ+ZU6W9MEBBasVA08vioha/quQP9YCjIZhJUMPVv/6St47aIeRRhvqK+TvGBd6i44lO9v8jv0p8Tkn45+ovQahCnPyHNJ3R9uzpXXNdWGesLWgZYytqFBE/Z0KcN7BJgYAuFrhY8L3v71vgS/wtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v4.19.264-cip84 and v5.10.153-cip19
Thread-Topic: [ANNOUNCE] Release v4.19.264-cip84 and v5.10.153-cip19
Thread-Index: AdjzSeg0Y/wJ3g7AQdW6EOHz/L9ebQ==
Date: Wed, 9 Nov 2022 07:02:38 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94201FEA4D18FDE0292F29D9923E9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB8612:EE_
x-ms-office365-filtering-correlation-id: 19589460-142d-4fbc-1dc4-08dac2206348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GixdgW9ruVTAhty2kZzCTSfqf2Ul0t51/a9BlZF/cXG1KApoP4p8yEp9aKaLwRPilimSm+nMG353rtegvWKF8Ur4DnW8Duf7oxt579sRzO2NLMZq3WDWEc6un1QEz6jQI6FaqHn1xzZ4Npty3DYineADGIC7JvACiGkrQtWKWFQHgHyYfG2yhudQlJACT+Mj18sZjwWvYyAudBY1tjuiUQ/t8jyUPpKvXPEhJbqczDMSLsb9HJeZ5Ik9zuntPfiFTDcQXZdXCDx+I7Dg/q7fJ3QlPHcJtuj8Gvm5nejk7WKuJCGqZX32De8aDzZd8IVg5xf3t0fR98OnjD6uMGqGPOU3eXcASFDRiKrXr51MpwsYIURLCzoAFbuJnaDRmHk89uiH+kvk6wVso+koYNN8YEpgNs2pClzQX/D6D2t+LC20alzBF4JwaHysc9g7tlAXYtAHTN61G6829xA1LhqA2ujNGaEWu88nkj3foNqRe9i1HGWMEun8O4k4Q0SdabUGh2UhRSZeDx4YD5tkV899xE98caj3/MxapsICP2olGNF+FqQuuqTMQBmQD0VNbMyFr9550ZT8d7uYXkuqJL2ZrIJDgHLWWJfPf+C9Go3T+AuERKigvcrU6wOznyH8byV1RtI3PgGth9wyiwxiEKBb0pmMw6xhiN3F7DnjHJdSzXooQHFd5cEWZ+z+kMWDBs6jfjNB7sRQN03FZP9opsn0VolDsGUdeendhllzgDYpON50m0NT5y+HwvSt0xucyegdDTykxDBvcSeev6GPhWakjPGNhYGCKKEfQGewgGbIG05z+YoDh7sHW/WOL6PBmYU0XkYTriHEp4bGMQLYf2mYE+EM6Q/fo7quKT1+0OirqhE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(76116006)(66556008)(8676002)(38070700005)(38100700002)(66446008)(4326008)(66476007)(71200400001)(54906003)(64756008)(66946007)(316002)(33656002)(6916009)(26005)(8936002)(186003)(86362001)(122000001)(55236004)(41300700001)(7696005)(52536014)(5660300002)(9686003)(6506007)(2906002)(966005)(478600001)(83380400001)(55016003)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TXFHSjV3UVpzU1cyRXJlc2I3bTliNFV6R1NwRzdBbk1aZnNlOHYrTUFl?=
 =?iso-2022-jp?B?K0lLVVFnNjd2a1dRYlVSRlpzQzNlTEl6ZEY2VnkwZWtnTW8vRStGWVEr?=
 =?iso-2022-jp?B?cmNza3BHTi9LMFNUMFdWd0g5SGlCcmJBczZ3SmQvbnhYT21XdnBwNENj?=
 =?iso-2022-jp?B?S0I5U1pHVnZRRHAvTXp6V2FNQnVjUDhOOUwvY0QrTGRVWjJtZHNsWG1N?=
 =?iso-2022-jp?B?aTJ0OUVHNDJ0RE52a0J5bTg0Nk9NQTBEWkI4SGpmRGJ1azNRTjUvZHJT?=
 =?iso-2022-jp?B?VjFJNTlGdVJpb2JsTmtuMW5IdklrL3l6VEJ6RVBJMXhqUmpiZGhrUnYy?=
 =?iso-2022-jp?B?WThsaEhoSXdBSzUvVHNwMm9ieFdVYmlybk9VTS9mN2RlbkVrZ1VsUTQ1?=
 =?iso-2022-jp?B?Kzg5Um5YS0dXalNRanl2TGZ4R3VaNDQzN1A2NXZnRGczTjgvdDBRSG9a?=
 =?iso-2022-jp?B?MktYM3VaanA0a1lnUG5TQ0RmYjY1UzFNRHRFc2RmUVRjTE1zbmV0d0U0?=
 =?iso-2022-jp?B?dGRwZk5vNVl4aG9hREhSVjZSTzdldzdnbE5BS2lBSlJsMmRXandhYk0y?=
 =?iso-2022-jp?B?Yk5WUDd0VzM5ZWZKdHhqejViWHJkV05WdWVsZnlsWWM4QVUyZ29TYVlv?=
 =?iso-2022-jp?B?WmZvdXhpU3ZtclN1TjQ0a2tJOGFleGE0T0dLbzdJWlFqckxTd2NIa0dJ?=
 =?iso-2022-jp?B?ZkxOTkEyaC9GVCtSaFJCekVqejFqNk1SdXAzeDRyNXJOc3ltQXlza1gv?=
 =?iso-2022-jp?B?bFROU1F5ZGxpM0tEQ3Jta1c5V0xYSHFLVktDYnB6TE1lS1Q0RnJpTGxL?=
 =?iso-2022-jp?B?MjJVQUxXbWpRWkYxRU9NVEhNbGlXTCt6MG9hYzdKUGVHb3VHNlJTcCtq?=
 =?iso-2022-jp?B?VXdYUXAxT2xHWTVHbGlsS21TMTFQT3hTU0VnZVJrcDliVk1BdVdaVnBi?=
 =?iso-2022-jp?B?d2JpSTZYM0hxTXFSS0ZGUndua2tmVkd2a1FaN1RaVmFNRSswYnQ0aXdJ?=
 =?iso-2022-jp?B?YnE2N1hMa1liazBCUElxVlpkbytRclE2NjV1Mk9kWkRWN3c3SFhGQ2NC?=
 =?iso-2022-jp?B?ZDAwR3d2WkRVZDc1TUtBdS94bEZJcGozeTQ5eFg2UnprZkU4N0hrd2Rn?=
 =?iso-2022-jp?B?bzZZOG1tWG5QUGY5OXpoTTdhVFp6aXQweFR2S1F2SmhwVXEzVVlwbFk4?=
 =?iso-2022-jp?B?dnMrYU94R3psdXZodmYxQzBDMEEvNDFVM0c4cWlQYnkyMTllcWQ5dUZq?=
 =?iso-2022-jp?B?WXFjSWdZWDRacUIvWDYvV01Mc1dBZm4wUkV0YmNwUUJIRTdwbWZoeDZM?=
 =?iso-2022-jp?B?MitEbll2L1d4T01VOFhFRlZnME1Ob3NUdmdJSVpEek5WS2s0YWM0UGZC?=
 =?iso-2022-jp?B?YU1pcmxOZUo0L1RSVDI3U2RvSVpkbWgwLzdyMERCR1hXTEF5UnZydDFa?=
 =?iso-2022-jp?B?T2QxMk9mWnhIUTdsNFZzb3h3UVI0b0VhcUlnS215bm5ZU21GdjFXUlJr?=
 =?iso-2022-jp?B?YVFHQ2ZiemZUT2RDR3U0SjRvUktMdUhOcTNhNW9rTUxkVldiZEl5Wkl5?=
 =?iso-2022-jp?B?dEYwWVQ2NHRIZ3pFcFNPMzVQWm5YMjc2eVNDMVFEQlZ1dDdoRkN3RThw?=
 =?iso-2022-jp?B?cVJRVDVNK1Z2QTFwU3NtY3MzVlRXb3I1aVd2RlNkWmtBT2M2VmpuSEpq?=
 =?iso-2022-jp?B?OFZxOGtOd3RldzhkeE5IaTFxMUQxTDF0RFVSTVJxZGRNYVJ0RXAyQ2FB?=
 =?iso-2022-jp?B?aTIyV1Jock12Wm0xclVOT2huQVk4VFJVQ3pCY0cwN04xUlBZUE1XQXZi?=
 =?iso-2022-jp?B?aGlYcExPdFI2SXY0eXYvSW9HbUtiU1RURGhyMkwwdmsvOG1lZ3FhenVB?=
 =?iso-2022-jp?B?TzFVaGh2T1J1T0NMSzZFUGs0UFhGOUh3eXgxL0xsdnpZbTVLYUUyNXNV?=
 =?iso-2022-jp?B?ZEpSeXZ3UGJlTm51dnNncnREN09XMW1paFRxUE9Va01DWEVBeGQzZ2Qw?=
 =?iso-2022-jp?B?QVdCcWdDc3JwWCsweEdFSVJkTk01UEVsUytobjVvdkh1V3JRbXB6U05s?=
 =?iso-2022-jp?B?VWdkN2JBZThNZTJYMy81bU8wSGo5blRldWJIMjJRNm11N1luNVh6WEo4?=
 =?iso-2022-jp?B?dlA5S3U1MzF6U2FkdXNhNm1RaXA2aUU5MExxRFpsblRhQzB6WHBFS1VF?=
 =?iso-2022-jp?B?clZ5czlzdXN3L294V1A2SGE0cWhLMjF0QmNWb3dTWU5XVnAzUmRqWjlI?=
 =?iso-2022-jp?B?azNBVTFXS29SUHhXU2l4aDMxWWRVSTVpeDhTMUsydVRmQnBVNE9zNnBu?=
 =?iso-2022-jp?B?YzdYVnZNMjFZMi9BUHFiNWYyREJTMVplc1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19589460-142d-4fbc-1dc4-08dac2206348
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 07:02:38.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEE/trE3AdIiH+0PDXBd7lMAsvUIurpeZ2S5QNDEpEDSnnvgDN4R7u2BnCyGgr4xUlk820TX/uuaQQ3NGqqvV97JilbfOHfgx8q+fn7xgBCTMsp8wOL4+KsIvefZDuAv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8612
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 07:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9956

Hi,

CIP kernel team has released Linux kernel v4.19.264-cip84 and v5.10.153-cip=
19.
The linux-4.19.y-cip tree has been updated base version from v4.19.261 to v=
4.19.264,
and the linux-5.10.y-cip tree has been updated base version from v5.10.147 =
to v5.10.153.

In the Linux-5.10.y-cip tree, there are fixes of the device provided by Ren=
esas in ARM SoCs.

You can get this release via the git tree at:

  v4.19.264-cip84:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      4e20f3800768ffe0d18b4cece5744ec28709b4d3
    Fixed CVEs:
      CVE-2022-40768: scsi: stex: Properly zero out the passthrough command=
 structure
      CVE-2022-3535: net: mvpp2: fix mvpp2 debugfs leak
      CVE-2022-3594: r8152: Rate limit overflow messages
      CVE-2022-43750: usb: mon: make mmapped memory read only
      CVE-2022-3621: nilfs2: fix NULL pointer dereference at nilfs_bmap_loo=
kup_at_level()
      CVE-2022-3649: nilfs2: fix use-after-free bug of struct nilfs_root
      CVE-2022-3565: mISDN: fix use-after-free bugs in l1oip timer handlers
      CVE-2022-3542: : bnx2x: fix potential memory leak in bnx2x_tpa_stop()
      CVE-2022-3646: nilfs2: fix leak of nilfs_root in case of writer threa=
d creation failure
    added commits:
      CIP: Bump version suffix to -cip84 after merge from stable

  v5.10.153-cip19:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      0f7fc281d55b27b299e8388c7d44809289ba8b99
    Fixed CVEs:
      CVE-2022-40768: scsi: stex: Properly zero out the passthrough command=
 structure
      CVE-2022-43750: usb: mon: make mmapped memory read only
      CVE-2022-42721: wifi: cfg80211: avoid nontransmitted BSS list corrupt=
ion
      CVE-2022-3621: nilfs2: fix NULL pointer dereference at nilfs_bmap_loo=
kup_at_level()
      CVE-2022-42722: wifi: mac80211: fix crash in beacon protection for P2=
P-device
      CVE-2022-41674: wifi: cfg80211: fix u8 overflow in cfg80211_update_no=
tlisted_nontrans()
      CVE-2022-3649: nilfs2: fix use-after-free bug of struct nilfs_root
      CVE-2022-3646: nilfs2: fix leak of nilfs_root in case of writer threa=
d creation failure
      CVE-2022-42720: wifi: cfg80211: fix BSS refcounting bugs
      CVE-2022-3303: ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC
      CVE-2022-42719: wifi: mac80211: fix MBSSID parsing use-after-free
      CVE-2022-3594: r8152: Rate limit overflow messages
      CVE-2022-3542: bnx2x: fix potential memory leak in bnx2x_tpa_stop()
      CVE-2022-3535: net: mvpp2: fix mvpp2 debugfs leak
      CVE-2022-3565: mISDN: fix use-after-free bugs in l1oip timer handlers
      CVE-2022-2602: io_uring/af_unix: defer registered files gc to io_urin=
g release
    added commits:
      CIP: Bump version suffix to -cip19 after merge from stable
      can: rcar_canfd: fix channel specific IRQ handling for RZ/G2L
      ravb: Add RZ/G2L MII interface support
      clk: renesas: r9a07g044: Add conditional compilation for r9a07g044_cp=
g_info
      arm64: dts: renesas: r9a07g043: Fix SCI{Rx,Tx} interrupt types
      arm64: dts: renesas: r9a07g044: Fix SCI{Rx,Tx} interrupt types
      arm64: dts: renesas: r9a07g054: Fix SCI{Rx,Tx} interrupt types
      arm64: dts: renesas: r9a07g043: Fix audio clk node names
      arm64: dts: renesas: r9a07g054: Add DMA support to RSPI
      arm64: dts: renesas: r9a07g044: Add DMA support to RSPI
      arm64: dts: renesas: r9a07g043: Add DMA support to RSPI
      arm64: dts: renesas: Adjust whitespace around '{'
      mtd: hyperbus: rpc-if: Fix RPM imbalance in probe error path

Best regards,
   Nobuhiro


