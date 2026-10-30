Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1120.1793396547120196801
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 14:42:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=tK9ovNcF;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1793396539;x=1794606139;bh=
	FPt9TsSwvYL/T4GF25lVAmll2VurrfoyHnbPyzMlW9g=;b=tK9ovNcFw7mvcdg77aqzMb2waLY44e
	mnsf0YbKW6j/so4nnxI/HYLIY4WLcq7DmYOh8ZMNKwALDvGL2n/oOQcGMl2ghc1Nn0qAmbS6+FeAt
	uPFCQhonO2xK0wpz37zE4kwFCgWkTLXtJloJn24A3VCYclIDLIQWlqvydHU8sRuwnimbAeYj5D8xF
	g8diGv/Fa/hiJjff8d4wjQiVu9eEseJ+ZaAVn0/wQChMYoV6QzATjjLFtPZ0Gez/OTvMv2LZMo0AN
	Y6mXVeJzNF4zNbwoxPumzSOB2Siisc9eRYIv7ChgbDjrwXSTK9rXV4ZuFySBOhhVJh43MWIsLYIkw
	5JYA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69ULgIrP3253838; Sat, 31 Oct 2026 06:42:18 +0900
X-Iguazu-Qid: 2yAa9Lyb4clfjYyhCC
X-Iguazu-QSIG: v=2; s=1; t=1793396537; q=2yAa9Lyb4clfjYyhCC; m=Jdy4PypT5tXQ6GTSAD2qIAM9y5RERVDhDQr8ncHq3WE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jGZLx0dTbz1xnZ; Sat, 31 Oct 2026 06:42:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D10F6ts7cwkkZXFgs21obPmheVBqVxStK7cjXjq35C76tbEeqE+yhqepVowRlkhaiYLB+d6W/CWv+LlaIxKZoBH8FMvDCAUhEFzv0G5Ed7ag5r0kxWGpo2EXtp0OFS+DumwyORaQObcmeZOX9GN1Jcpb2mCwnMY1t6nTkrkzaR5297Eew3pHgmqyC6b69EDCBjL4owx7owddO2jNMj9bFpo7HlehC8dbtmVH8SB7ST0UdBDuLJdrjDPRxJXvNvEhVAgBHeHGstYp7sRnGsPQRg1xrnioTUEuvH4OHUizETre6lgrerLL1u6i+4vPe/2WwwT8cAHa3yWR9oAYVfiXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQQ5nGv4UbeWTRJl1N4oMp8I44LYWl2pEqjBHaBL2Ys=;
 b=IgvLLRVTVhenmdmTDqdnmSFjy8HeGccIAub/Aqrbiy8w8RAXlbTUU8SIv9KwWqim5MQSKXl+xGk0ROOasKyudub+GFc1N+cmyloq/h6ryZXtvnKkBqK2TQY68WH82MRNGA/f6JfGWgFfD1ovJouioUk/TfSpVfRsnFVWBZWsMWCtnFOE2J7ARl77Ddy0aoygNRhH9AN7OkJs9Y/GaMyxyTejhK1WMa7+qxhrVE91UArQbkuu9fbuJhmO2WG6xWBU8KWjHoS1CEiUvWlraodAfYtevkp4S8DHi8/sOMv47DhLOqpzBZixgYeMsHRnl3aCFA1/30PS0NmRi0aTsv9WQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <masami.ichikawa@miraclelinux.com>,
        <jan.kiszka@siemens.com>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.114-cip34
Thread-Topic: [ANNOUNCE] Release v6.12.114-cip34
Thread-Index: Ad1ot2g/U3b4LTGJSAGSZv8UeAtv0w==
Date: Fri, 30 Oct 2026 21:42:13 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148182E5786728BB5185D5636CD6D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB967428:EE_
x-ms-office365-filtering-correlation-id: f22105be-50f7-4744-9199-08df36cea935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|38070700021|56012099006|5023799004|11063799006|261013131602099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021130227099003|261022113327099003|261022075727099003|261022105027099003|261022115727099003|261021121427099003|261021123027099003|10067099003|3023799007|6133799003;
x-microsoft-antispam-message-info: P/PQGg4a4toZONYg0PkwYQA9l+Ocpy/rZ3gqbU0RmdMz2Lq1dAHk0rhunuuAltnrzMzu2MfF0dKBcosr1rJMMe9l+5iXmvKA/2oNj3iB59eldqNeA9i2UZ7iU6U9TtHppzZ8hkBg9aig2I8WYrQfiZffgTvsMmK2jdY671xM/MxW1rIauF6Tm1bEa4UjRqFCNAd65w1DEmGSPND83UMFcAWW+8cNLZ0t6wyZSOSAy9TNpZQZ/BhhLREpIqaRCwp29ValEvsToSNoTIC35sDJ76fe3cXP5GJhZhgggUWsmTA+DEAnRAPr87IUZ2GMJNgf9o4UG1Rlnvq7F7GU6GosW1z6spvh2P24bqe4WiYkJNSUq7sGctFCK9Hu+rOzlcXxxTqB7BRnJiRhBSrfjB4cdDXJb+PsR92m9xYpLqlrUGW2RK4jt/eJTetX3bo4W+trbCGd6M1GxgSLoCg11wun6Rz95N/h44ip8yH7B8TVxg8OuGr44d4c8+LB+0rSvoguMxZJtlAmbGHzFNkdZ2WAVkUVTTw+ImOOTXsU+LNNlw64uNO0A7APdyReZLmYWKNwZmFkr3r/PrqHvgPeKjoaIJbmwcEIkZNTCl5GnjyaB9pHCTQfnDnFVLky9jlzJUoGtoU+xwtcJwFKcaLELRtTu5vSQtQkUDpeHTy6hcFsLxEhfUZuP+xcifJTiqC6VA46
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(38070700021)(56012099006)(5023799004)(11063799006)(261013131602099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261022115727099003)(261021121427099003)(261021123027099003)(10067099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aEJtYm9XQkQzZVlCTkhVQS9ZaWw3WWVoV2R4ZUNlRXQrU3F2WnBpMGRB?=
 =?iso-2022-jp?B?NjhBbDNxUmUyR2ZjRHRIdjl5bzREYTRjbWVROGJoWFcwZTdRei83UmM0?=
 =?iso-2022-jp?B?a0d2a215ZlpaMmlzZjdtVWR0WWszR0VkRFBKQnBWWTcyUW1vVXh1RjAw?=
 =?iso-2022-jp?B?d3RDZjZwMCt6V0xONVlDQkpZZG9WMFp6NytUVmd1S3YzUGFrZit5bkND?=
 =?iso-2022-jp?B?ZUtWdmg2VCtRcWRxcHZjUjhWQURCNThhWHEyMEFia21RWjBmdzNDS0Za?=
 =?iso-2022-jp?B?WEx0UHdTVU5DeWViTjl6anJyU0V2V1h3TS83VnpJT3RHOG9CN2RzSXJu?=
 =?iso-2022-jp?B?NWpib21yTVBnODdDTGt2UE5QeFJ1MGlQNUVlVU0wMDVDNTZMa2hjL2p2?=
 =?iso-2022-jp?B?S3ZYWjZTSzFVWXZnTmxxQjBDRUxCMlR4czFjMUwxVnMxK3QxNEdNakpl?=
 =?iso-2022-jp?B?TmVPYnJFYVdRS3UyRDl6amtTMllZNWJjMTcydUFxbjQxMk55SThVempF?=
 =?iso-2022-jp?B?WVpDZ3hKb21RME1Mako5KzhXa2R4MTdiQ3R4dmFCMjZIU2xvZkNOWmtO?=
 =?iso-2022-jp?B?R0NFMHlCV2hHY0JVbnhiWk54ZWJ4ZUhBWm43VXBBYWtpUFFSN1NsTFJD?=
 =?iso-2022-jp?B?bE5sSW9CWFBUTnVnMFhwbEM4dFNSeURxMkJFZnpQQmJlR3IyS0kzc1Jv?=
 =?iso-2022-jp?B?alVaUmtPck5ERmZXTVBrbHh1VnpqWHNFMmlLeUhYWHNNSUZkR1NDNm9S?=
 =?iso-2022-jp?B?MW5lV1p1VFM3VUV4TmFnMFp1Y3FtcEYxa3h6UjZwOXZHNHQ1bVg2RlZ0?=
 =?iso-2022-jp?B?ZzRySCtUNHFLZXdhUVFlYlR0cXRoaitUa2lZbUplSFhxUEMyNFIyWWNH?=
 =?iso-2022-jp?B?Y0o4NkNsWnppVHlpMUdoQzdydFIrQ1BwcW9Fdi9haUxjSkRlSjl6VEd5?=
 =?iso-2022-jp?B?OWlaR2QvNWNSN2lkSW1jTFYvYTA0SUg0THpRbyswSUtBYlJCZjBEcWdQ?=
 =?iso-2022-jp?B?Q1ArQUtzMjJIbjQ5amVERzJDZU1hbldqMHd6bnV6U0V5Yjd5MWVFMXpu?=
 =?iso-2022-jp?B?cVlkdGtzTVY1c3ovOFQ4VlhGb043ZFE2UjVlSmNicFFDNXdyeHVGeVpL?=
 =?iso-2022-jp?B?dkpYR2RSNjBFckp2TG1OSjJoLzQwQnhDRElaeDVXeXFTWnVINkdqaTNP?=
 =?iso-2022-jp?B?dU9xVksxR245MDhROTkwRkIvS2w1c0NKRUJIaDhnV1FQZmg2c2VGY2lM?=
 =?iso-2022-jp?B?RFpjUHc0RFZPOUwwZ25HVVcxeU5xQ0N3dHBkbjZLK3pyR2NkWmVPVG5Z?=
 =?iso-2022-jp?B?Y0sySE9DNmVNWHV0bWZQUitJSnNKanYrS0taMXVtZkFoWUI5V1RqYlhG?=
 =?iso-2022-jp?B?MXBRMXNOb21oVHNRb25kcStNMUMxeHcxQzZ2YVp5ay8vZVNjMTNyaU5x?=
 =?iso-2022-jp?B?eFJEdDY0WWhVdndxdk5qOXBkS2RWSEdmWUtVK29rUEdzZ3BSN011T2Fm?=
 =?iso-2022-jp?B?S252a0p0aHBhQmY5aEVPUyt5d0NxNGZVUzZsUTgyQUFPR0VwbGpKN21C?=
 =?iso-2022-jp?B?N2xKWTM0M3FydzgzNVRGMmxHaHRaeEo0Z29wZStHUFl6Z0tVK3BXQnFX?=
 =?iso-2022-jp?B?RkdxeGFzc2RpMkRWQ2xEbjhMdHJxd0RoNGxhUkVNUFlEeTR5M25ub1p5?=
 =?iso-2022-jp?B?MnF6MUdHRWZsS2k4am91cTZsaWJqdmxrb3c4b2ozcVI5ZE1sTGZYdXp1?=
 =?iso-2022-jp?B?azd6aUo1TWF4YWk1V1FoOEtCNXRGUWI0R0tLRW5XUVNsNVJFRW05ZzVE?=
 =?iso-2022-jp?B?dUMyZmdlQXp6R09LZVlaak9MUWdadTA3SzY0RmRSUllveE0xSmR3VFEy?=
 =?iso-2022-jp?B?NlluSnNxQkt3OU1UcFd5QWJHaXpEc1UzNVZGNkEwNCt5aVZLVldvS2pi?=
 =?iso-2022-jp?B?YU9ucXdoOWgzVWtZanZpcG1zdmtjTjR0STF5OWd0OC91eTV4eE0ybW1K?=
 =?iso-2022-jp?B?OFoydmhNSENCeUZQN1hZdG9MbHJVc2FwWGN6UWxFNXJCb1FIUG1vT1lm?=
 =?iso-2022-jp?B?cHdyT0JWbkdIUENaUGRJZHlTNm1nZTh0cU5xbFFGaGxZbTU1QnI5c1JT?=
 =?iso-2022-jp?B?c0tLQnBTOUZIWHA1TFlueTMwNXIzNTdWeHRzS0pnbUZyZG9QRXBoZTR4?=
 =?iso-2022-jp?B?UVBUVEhIT3hpemszdU1YVkJvcDExRmxJeEdFNTZRSEcrRWd4VDBBMEkv?=
 =?iso-2022-jp?B?QUk4Y0ZTNSsvcG92QWVBaE9oTmRLcTN0VkkzcUVvMVVHQjhUQVQrejRC?=
 =?iso-2022-jp?B?UTkxSGRwUjRFWTY0RW54U0JzZWt3TFp3WTdaY2VpT3VLWG5RWENzU1Ft?=
 =?iso-2022-jp?B?VUdhVmRqTEwxQkZXaUYrUGlMbXEvUGJCK1FyaTV6Vmt2TG1hai92TG1X?=
 =?iso-2022-jp?B?RFh3NDFFTDRuVGhFVis2aVh2VzV4cVh5NjZGUDRObmozM0Q1dGZkNnNy?=
 =?iso-2022-jp?B?Y0k1R1ZqOU9ENSt1Uk1QTTdQcEYwSVZPUDc0K0RWeTNLUU9ESXhpYkRZ?=
 =?iso-2022-jp?B?NW9tQVNscz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kwdv3GhdrRyP/uXIFXvF6Wxh423vO93jd1KGuc33kjyXW/PpBPetU49VlZBjumABdqGO0BUqcE+KnyKU6/fIi7AWfaXcOHYY08QxuXvm5hvy9QeYaoHQzvxudnk5jl0pasnIWPiDjoVuVf0i9OvV8LscUg0odL+kqdG6ooBBvpKfgBGILu4IY7mzzVcakb00CH0SI/mNvSNfQfJb0MDJBRxt8Cy5syPGtrFO2IpBAsmmRB5EcfXhmKbV+X+FSCbGmvNGhA7XDYlaGOJ5QWXanFEOsG5WlbH8aQKyawc2hlBsg+uG6PSSWb9yyRnjoT7MTM1lDs7oSY5wg8ehVp9KMw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22105be-50f7-4744-9199-08df36cea935
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 21:42:13.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxofC/HMrjHnmptN2Cq73Mf6RvvhQj6L+Aodt0ybWLoDF8eI9PY2v3ytNu/4SsDLRTyAMH5ACF/RQMA+Az7xIfh5jO0xqXXDscsfq6ioEqxuQu6ZUKmyz5Ej9gu3EVXn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB967428
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 21:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24595

Hi all,

CIP kernel team has released Linux kernel v6.12.114-cip34.
The linux-6.12.y-cip tree has been updated base version from v6.12.112 to
v6.12.114.
Additionally, support for RSCI on the RZ/G3L was added for the CIP kernel, =
and
bug fixes and functional improvements were implemented for I3C, ADC, irq ch=
ip,
and the device tree.

Information about this release is as follows:

  v6.12.114-cip34:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      ee3102643c9554e927f87b7a22c59790ef9718f6
    fixed CVEs:
      CVE-2025-38204: jfs: fix array-index-out-of-bounds read in add_missin=
g_indices
      CVE-2025-40158: ipv6: use RCU in ip6_output()
      CVE-2026-74534: Bluetooth: ISO: fix refcounting of iso_conn
      CVE-2026-74596: fs,fsverity: remove check for fsverity being enabled =
in setattr_prepare()
      CVE-2026-89527: svcrdma: Use svc_xprt_put to free listener on create =
failure
      CVE-2026-89633: smb: client: fix OOB read/write from unvalidated Data=
Offset in coalesce_t2()
      CVE-2026-89638: smb: client: clear setuid/setgid bit on write with ci=
fsacl/modefromsid/posix extensions
      CVE-2026-89912: KVM: arm64: vgic-its: Don't dereference a NULL collec=
tion on ITT save
      CVE-2026-90146: bpf, xdp: move offload check into dev_xdp_install()
      CVE-2026-93179: drm/amd/powerplay: fix VoltageObjectInfo zero-stride =
loop and OOB read
      CVE-2026-93243: mm/secretmem: properly account locked pages
      CVE-2026-97558: smb: client: fix cifsFileInfo reference leak in defer=
red close
      CVE-2026-97567: mptcp: prevent race between disconnect() and rtx
      CVE-2026-98375: xen/netfront: drop RX packets with a short Ethernet h=
eader
      CVE-2026-98432: ipv4: free inet_opt and ireq_opt after an RCU grace p=
eriod
      CVE-2026-98440: KVM: arm64: nv: Delay freeing of shadow S2 structures=
 until VM destruction
      CVE-2026-98443: xfs: fix cursor and pointer handling when recovering =
iunlink buckets
      CVE-2026-98445: xfs: don't let memory failures leak blocks and kill r=
epairs
      CVE-2026-98450: smb: client: close completed creates on compound wait=
 errors
      CVE-2026-98451: smb: client: use finish_no_open() for non-regular ino=
des
      CVE-2026-98453: smb: client: close handle after create-context parsin=
g failure
      CVE-2026-98458: Bluetooth: ISO: release unused CIS holds after channe=
l attach
      CVE-2026-98655: perf: Require kernel access for text poke events
      CVE-2026-98656: iio: trigger: cancel reenable_work before freeing tri=
gger
      CVE-2026-98657: iio: proximity: pulsedlight: fix iio_device left regi=
stered on PM setup failure
      CVE-2026-98658: iio: proximity: aw96103: validate firmware data lengt=
h
      CVE-2026-98660: iio: pressure: bmp280: fix out-of-bounds access in sa=
mpling frequency lookup
      CVE-2026-98661: iio: light: rohm-bu27034: Fix infinite delay on error
      CVE-2026-98662: iio: light: gp2ap020a00f: drain irq_work after free_i=
rq
      CVE-2026-98663: iio: imu: adis16480: fix unprotected debugfs reads
      CVE-2026-98664: iio: imu: adis16400: fix unprotected debugfs reads
      CVE-2026-98665: iio: health: max30102: fix NULL dereference in interr=
upt handler
      CVE-2026-98666: iio: gyro: adis16136: fix unprotected debugfs reads
      CVE-2026-98668: iio: buffer: Ensure bounce buffer used for unaligned =
case is zeroed.
      CVE-2026-98669: iio: buffer: serialize buffer teardown with mode clai=
ms
      CVE-2026-98670: iio: adc: xilinx-xadc: free IRQ before cancelling the=
 unmask worker on unbind
      CVE-2026-98671: iio: adc: sun4i-gpadc-iio: clean up on thermal zone r=
egistration failure
      CVE-2026-98672: iio: adc: stm32-adc: fix possible division by zero in=
 processed channel
      CVE-2026-98673: iio: adc: pac1934: check ACPI label duplication
      CVE-2026-98677: iio: adc: ad_sigma_delta: fix use-after-free on unbin=
d
      CVE-2026-98679: iio: accel: kxcjk-1013: reject duplicate event disabl=
e
      CVE-2026-98680: iio: accel: kionix-kx022a: Prevent memory leak and fi=
x state
      CVE-2026-98681: smb: client: split cifsFileInfo bitfields to avoid sh=
ared-byte RMW races
      CVE-2026-98686: smb: client: discard post-EOF pagecache when extendin=
g a file via zero range
      CVE-2026-98687: thunderbolt: Reject oversized XDomain properties resp=
onses
      CVE-2026-98694: thunderbolt: Fix KASAN reported use-after-free when r=
equest is canceled
      CVE-2026-98695: USB: serial: fix ioctl hangup race
      CVE-2026-98696: USB: serial: fix driver deregistration order
      CVE-2026-98697: USB: serial: fix dynamic id driver deregistration rac=
e
      CVE-2026-98698: wifi: mac80211: handle empty FILS association request=
 payload
      CVE-2026-98699: wifi: mac80211: fix mesh fast xmit path deletion UAF
      CVE-2026-98700: wifi: mac80211: set info->band for 802.3 encap offloa=
d frames
      CVE-2026-98701: wifi: mac80211: release mesh path quota on failed add=
itions
      CVE-2026-98702: wifi: mac80211: reject invalid 320 MHz CSA bandwidth
      CVE-2026-98703: wifi: mac80211: minstrel_ht: validate fixed rate inde=
x
      CVE-2026-98704: wifi: mac80211: keep fallback association elements al=
ive
      CVE-2026-98705: wifi: mac80211: account proxy paths against the mesh =
path limit
      CVE-2026-98706: wifi: mac80211: drain PS delivery work during station=
 teardown
      CVE-2026-98707: wifi: mac80211: shut down RX BA session timer on tear=
down
      CVE-2026-98708: wifi: mac80211: keep paired old chanctx alive
      CVE-2026-98709: wifi: mac80211: count only matching reservations in r=
eserved switch
      CVE-2026-98710: wifi: iwlegacy: 3945: free EEPROM data on remove
      CVE-2026-98711: wifi: cw1200: fix TX padding OOB read leaking heap da=
ta to device
      CVE-2026-98713: KVM: arm64: Apply the fine-grained UNDEFs without FEA=
T_FGT
      CVE-2026-98716: KVM: SVM: Use the active VMCB's MSR bitmap when check=
ing if MSR is intercepted
      CVE-2026-98717: KVM: x86/mmu: Bail from shadow walks if the root is i=
nvalid or a dummy
      CVE-2026-98720: KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS =
controls are modified
      CVE-2026-98721: mtd: rawnand: cadence: Initialize IRQ state before re=
questing IRQ
      CVE-2026-98722: mtd: block2mtd: Fix divide error when erase_size is z=
ero
      CVE-2026-98725: nvmet-auth: fix out-of-bounds write in nvmet_auth_cha=
llenge()
      CVE-2026-98726: nvme-multipath: fix underflow in ANA log bounds check=
s
      CVE-2026-98727: nvme-multipath: set BLK_FEAT_ZONED only after the zon=
e info is known
      CVE-2026-98728: tpm: fix off-by-four bounds check in tpm2_get_random(=
)
      CVE-2026-98730: Bluetooth: btintel_pcie: reject oversized TX packets =
in send_frame()
      CVE-2026-98731: Bluetooth: btintel_pcie: fix plen overflow in btintel=
_pcie_recv_frame()
      CVE-2026-98732: Bluetooth: btintel: fix buffer over-read in btintel_h=
w_error()
      CVE-2026-98733: Bluetooth: hci_core: Serialize fragmented ISO packet =
queueing
      CVE-2026-98734: Bluetooth: hci_core: Serialize SCO and ISO scheduling=
 with teardown
      CVE-2026-98735: Bluetooth: hci_core: Serialize ACL scheduling with ch=
annel deletion
      CVE-2026-98736: Bluetooth: hci_conn: Lock parent access during enhanc=
ed SCO setup
      CVE-2026-98737: Bluetooth: hci_sync: Fix inquiry cache use-after-free
      CVE-2026-98738: Bluetooth: Serialize SMP remote OOB data access
      CVE-2026-98739: Bluetooth: RFCOMM: Fix initial port reference race
      CVE-2026-98741: ALSA: ua101: reject mismatched capture/playback packe=
t sizes
      CVE-2026-98742: ALSA: seq: Serialize compat port-info ioctls
      CVE-2026-98743: ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stre=
am_config->type
      CVE-2026-98744: ASoC: codecs: max98363: fix uninitialized stream_conf=
ig->type
      CVE-2026-98745: arm64/fpsimd: signal: Forbid non-streaming SVE payloa=
d on SME-only systems
      CVE-2026-98746: serial: ma35d1: Fix clock reference leak in ma35d1ser=
ial_probe()
      CVE-2026-98748: serial: 8250_bcm7271: fix use-after-free in brcmuart_=
remove()
      CVE-2026-98749: tty: serial: max3100: shut down timer before freeing =
port
      CVE-2026-98750: tty: fix saved termios reset race
      CVE-2026-98751: tty: abort break signalling on hangup
      CVE-2026-98752: tty: port: fix tty_port_tty_vhangup() race
      CVE-2026-98753: tty: tty_port: restore TTY_IO_ERROR on activation fai=
lure
      CVE-2026-98754: tty: vcc: hold port lock when clearing tty pointer in=
 vcc_cleanup
      CVE-2026-98755: tty: vcc: zero-initialize control packet in vcc_send_=
ctl()
      CVE-2026-98756: usb: cdns3: Fix NULL pointer dereference in cdns3_pci=
_probe
      CVE-2026-98757: usb: cdns3: fix use-after-free in cdns3_gadget_exit()
      CVE-2026-98758: usb: typec: ucsi: glink: fix use-after-free of ucsi o=
n remove
      CVE-2026-98760: usb: typec: tipd: fix uninitialized typec_partner_des=
c in tps6598x_connect()
      CVE-2026-98761: usb: typec: tcpm: recover after failure to start the =
frs ams
      CVE-2026-98762: USB: dwc2: shut down wakeup timer before freeing HCD =
state
      CVE-2026-98763: usb: core: clear both ep_in and ep_out for non-ep0 co=
ntrol endpoints
      CVE-2026-98764: usb: gadget: f_fs: Fix NULL pointer dereference in FU=
NCTIONFS_ENDPOINT_DESC
      CVE-2026-98765: USB: gadget: dummy-hcd: Fix wait for outstanding requ=
est completions
      CVE-2026-98766: usb: gadget: aspeed-vhub: cancel wake work on device =
removal
      CVE-2026-98767: usb: dwc3: gadget: fix IRQ storm on invalid event buf=
fer count
      CVE-2026-98768: usb: typec: anx7411 - stop the IRQ before destroying =
the workqueue
      CVE-2026-98769: usb: gadget: f_uac1_legacy: validate bRequest index i=
n generic_{set,get}_cmd
      CVE-2026-98770: usb: gadget: midi2: Fix the jack descriptor array siz=
es
      CVE-2026-98771: usb: storage: sierra_ms: reject short SWoC info trans=
fers
      CVE-2026-98772: USB: serial: fix port tear down use-after-free
      CVE-2026-98773: USB: cdc-acm: skip URB restart in port_shutdown if di=
sconnected
      CVE-2026-98775: nitro_enclaves: fix use-after-free on SLOT_ALLOC fail=
ure
      CVE-2026-98777: binder: fix leaked fd fixups on TF_UPDATE_TXN superse=
de
      CVE-2026-98778: binder: fix is_failure flag for superseded transactio=
n cleanup
      CVE-2026-98779: drm/amdgpu: fix ACP MFD device leak on init failure
      CVE-2026-98780: drm/amdgpu: fix IP instance memory leak on kobject ad=
d failure
      CVE-2026-98781: drm/mediatek: Fix pdev reference leak in mtk_drm_bind=
()
      CVE-2026-98782: drm/mediatek: Fix ovl adaptor platform device leak
      CVE-2026-98783: drm/mediatek: Add missing IS_ERR check for ovl_adapto=
r platform device
      CVE-2026-98784: drm/amdgpu/gfx6: fix firmware leak on teardown
      CVE-2026-98785: drm/amd/display: check dc_state_create_copy() for NUL=
L in dm_suspend
      CVE-2026-98790: perf: Fix race between perf_event_exit_task() and per=
f_pending_task()
      CVE-2026-98791: net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dere=
ference
      CVE-2026-98792: netfilter: flowtable: generalize pending status bit
      CVE-2026-98793: netfilter: bpf: reject invalid NAT manipulation types
      CVE-2026-98794: ipvs: filter some flags received in the backup server
      CVE-2026-98796: net: ethernet: mtk_eth_soc: allocate dummy netdev soo=
ner
      CVE-2026-98797: net: cap skb->queue_mapping when the tx queue is pick=
ed
      CVE-2026-98798: net: bcmgenet: fix NULL dereference in set_coalesce b=
efore first open
      CVE-2026-98801: net: restrict SO_RESERVE_MEM to TCP sockets and cap m=
ax value
      CVE-2026-98805: tipc: prevent GCM nonce reuse on peer key changes
      CVE-2026-98807: net/mlx5: Fix slab-out-of-bounds when handling team d=
evice events
      CVE-2026-98808: net: systemport: Fix buffer overflow in bcm_sysport_g=
et_stats()
      CVE-2026-98809: Bluetooth: hci_sync: don't drain cmd_sync backlog on =
unregister
      CVE-2026-98811: net/sched: cls_api: reclaim an empty proto on the err=
or path
      CVE-2026-98812: net/mctp: publish the mctp_dev only after it is initi=
alised
      CVE-2026-98819: Bluetooth: btintel: validate DDC record lengths
      CVE-2026-98822: wifi: mac80211: prevent AP VLAN tx from other interfa=
ces
      CVE-2026-98823: wifi: cfg80211: preserve hidden-group beacon IE owner=
ship
      CVE-2026-98825: rtc: mpfs: fix unchecked devm_clk_get() error pointer=
 in probe()
      CVE-2026-98826: rtc: ac100: Fix clock provider use-after-free on prob=
e failure
      CVE-2026-98827: wifi: ath9k_htc: bound TX aggregation to MAX_TX_BUF_S=
IZE
      CVE-2026-98828: wifi: ath9k: reject short WMI command responses
      CVE-2026-98830: wifi: wfx: validate MIB read length before copying to=
 caller
      CVE-2026-98831: of/overlay: don't leak fragment references when chang=
eset init fails
      CVE-2026-98833: mtd: core: call _get_device() with the master MTD
      CVE-2026-98835: iio: accel: kionix-kx022a: Fix array boundary check
      CVE-2026-98836: ALSA: line6: reject oversized playback packets
      CVE-2026-98837: ALSA: caiaq: unregister the input device when probe f=
ails
      CVE-2026-98838: vt: skip screen update for DEC alignment test on back=
group consoles
      CVE-2026-98840: vc_screen: reload vc pointer before if (ret) in vcs_w=
rite() to avoid UAF
      CVE-2026-98841: virt: vmgenid: set driver_data before registering not=
ification handlers
      CVE-2026-98844: netfs: clear post-EOF pagecache when extending a file=
 via write
      CVE-2026-98845: tpm: Disable TPM on null key name mismatch
      CVE-2026-98846: sctp: check RCV_SHUTDOWN after the sendmsg connect wa=
it
      CVE-2026-98847: rtc: spear: initialize IRQ state before requesting al=
arm IRQ
      CVE-2026-98848: rtc: ac100: Assign .num before accessing .hws
      CVE-2026-98849: pfcp: fix socket lifetime on netdevice registration f=
ailure
      CVE-2026-98850: net/packet: prevent TX_RING byte count overflow
      CVE-2026-98851: netfilter: nft_flow_offload: drop flowtable reference=
 on init error path
      CVE-2026-98852: net: extend IPv6 exthdr detection of tunneled packets
      CVE-2026-98854: of/overlay: only treat a positive changeset id as reg=
istered
      CVE-2026-98855: of/overlay: put property on deadprops only after chan=
geset add succeeds
      CVE-2026-98856: kprobes: Skip disarmed probes when checking optkprobe=
 overlap
      CVE-2026-98857: ipvs: bound LBLCR and LBLC cache growth
      CVE-2026-98858: io_uring: fix task_work add use-after-free with SQPOL=
L
      CVE-2026-98859: HID: multitouch: stop the release timer from being re=
armed on remove
      CVE-2026-98860: HID: bpf: cast size to ssize_t when checking hid_bpf_=
hw_request
      CVE-2026-98862: audit: fix exe mark UAF in kill_rules()
      CVE-2026-98927: KVM: arm64: nv: Fix life cycle of the nested_mmus arr=
ay
      CVE-2026-98931: mtd: spinand: fix NULL pointer dereference with no EC=
C engine
      CVE-2026-98933: usb: hub: use shorter 120ms post resume hold for SS r=
oot hubs
      CVE-2026-98934: ipv6: sr: use skb_get_hash_net() in seg6_make_flowlab=
el()
      CVE-2026-98935: rtc: dev: zero-initialize struct rtc_wkalrm to preven=
t information leak
      CVE-2026-98936: wifi: ath11k: reset ar->num_stations on hardware star=
t
      CVE-2026-98937: perf/core: Check kernel access when kernel callchains=
 are requested
      CVE-2026-98940: ASoC: qcom: lpass-cpu: use DAI table index for playba=
ck constraints
      CVE-2026-98943: [REJECTED]: HID: steam: Clean up locking
      CVE-2026-98944: HID: steam: Refactor registration
      CVE-2026-98945: HID: steam: Rearrange teardown sequence
      CVE-2026-98947: vsock: Fix memory leak in vmci_transport_recv_dgram_c=
b()
      CVE-2026-98948: mlxsw: spectrum_flower: Fix port range register leak =
in tmplt_create()
      CVE-2026-98949: drm/imagination: Fix reference and vm_bo handling in =
remap()
      CVE-2026-98950: flow_dissector: avoid u16 truncation of hlen in bpf_f=
low_dissect()
      CVE-2026-98952: pfcp: make sure the SEID is linear before reading it
      CVE-2026-98953: devlink: fix devlink_rel reference leak when notify w=
ork is pending
      CVE-2026-98955: flow_dissector: avoid u16 truncation of skb->len when=
 computing thoff
      CVE-2026-98956: ASoC: adau1372: allow sleepy powerdown GPIOs
      CVE-2026-98957: wifi: mt76: mt7915: disable rx napi when removing dev=
ice
      CVE-2026-98959: btrfs: fix xattr replace when multiple xattrs are pac=
ked in the same item
      CVE-2026-98964: nvmet: use the local P2P device on metadata allocatio=
n failure
      CVE-2026-98967: cxgb4/ch_ktls: disable softirqs around tid_list erase=
s
      CVE-2026-98968: amt: send the relay's General Query directly from the=
 receive path
      CVE-2026-98969: net/sched: em_text: reject unterminated algo before a=
utoload
      CVE-2026-98970: drm/vc4: Free the BO cache size list on teardown
      CVE-2026-98971: gpio: exar: initialize the ID before registering its =
cleanup
      CVE-2026-98979: namespace: refuse an automount below a mount that is =
in no namespace
      CVE-2026-98980: namei: don't reveal overmounted entries in refwalk
      CVE-2026-98982: namespace: don't let a pseudo dentry become the root =
of a mount
      CVE-2026-98984: dcache: don't put a mountpoint on a dentry that's bei=
ng removed
      CVE-2026-98990: namespace: check a submount for references right befo=
re unmounting it
      CVE-2026-98992: namespace: don't copy an unmounted mount tree
      CVE-2026-99003: drm/panthor: validate userspace queue count against i=
nitialized firmware slot count
      CVE-2026-99004: drm/imagination: Size page table preallocation by dev=
ice address
      CVE-2026-99005: drm/i915/gt: Unmask interrupts only when ACTIVE is tr=
ue
      CVE-2026-99006: drm/i915/gem: Prevent overstepping exec array boundar=
y
      CVE-2026-99007: drm/fb-helper: defer setup when fbdev_probe() fails, =
not just on -EAGAIN
      CVE-2026-99008: Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rf=
comm_dev_shutdown
      CVE-2026-99010: Bluetooth: RFCOMM: free the skb when the DLC has no o=
wner
      CVE-2026-99012: Bluetooth: ISO: Serialize concurrent connect calls
      CVE-2026-99013: Bluetooth: ISO: Reject concurrent BIS listener setup
      CVE-2026-99015: Bluetooth: hci_sock: Serialize dead-device detachment
      CVE-2026-99018: riscv: entry: gate shadow call stack reload on sstatu=
s.SPP, not tp
      CVE-2026-99020: regulator: tps6594-regulator: Fix n_linear_ranges for=
 TPS65224 BUCK2-4
      CVE-2026-99022: regulator: ltc3676: don't read the write-only HRST an=
d CLIRQ registers
      CVE-2026-99024: optee: register TEE devices only once fully initializ=
ed
      CVE-2026-99025: openvswitch: fix soft lockup in the netlink flow dump
      CVE-2026-99029: net: sparx5: free the matchall entry on destroy
      CVE-2026-99030: net: skbuff: don't leave stale bytes in skb_copy_and_=
csum_bits()
      CVE-2026-99031: net: bridge: avoid recursive multicast port cleanup
      CVE-2026-99032: net/smc: protect clcsock lifetime in smc_getname
      CVE-2026-99033: net/packet: guard the ll header push in packet_rcv_sp=
kt()
      CVE-2026-99034: mmc: sdhci-sprd: disable runtime PM on remove
      CVE-2026-99035: mmc: mtk-sd: Cancel request timeout work on remove
      CVE-2026-99036: dm: fix reading free memory in do_resume
      CVE-2026-99037: dm-crypt: reject the lmk IV mode with AEAD ciphers
      CVE-2026-99038: memstick: rtsx_usb_ms: complete requests after eject =
instead of dropping them
      CVE-2026-99039: memstick: core: wait for request completion before fr=
eeing card
      CVE-2026-99040: KEYS: Fix add_key() race with keyring restriction
      CVE-2026-99043: ice: fix metadata_dst refcount handling on represento=
r teardown
      CVE-2026-99045: ibmveth: h_free logical LAN on open-fail after regist=
er
      CVE-2026-99049: gpio: xilinx: fix runtime PM leak on request error pa=
th
      CVE-2026-99052: selinux: preserve NATIVE_LABELS on already-initialize=
d sb in set_mnt_opts
      CVE-2026-99053: tipc: hold a reference to nodes found by link name
      CVE-2026-99054: tipc: destroy topsrv workqueues before closing connec=
tions
      CVE-2026-99055: tcp: reject net_iov in zerocopy receive mapping hints
      CVE-2026-99056: strparser: make sure __strp_recv isn't running before=
 tearing down the parser
      CVE-2026-99057: xen/netfront: don't leak the skb when xennet_fill_fra=
gs() fails
      CVE-2026-99058: workqueue: Fix NULL current_pwq deref in chained work=
 check
      CVE-2026-99059: wireguard: noise: reject response consumption after i=
ntermediate initiation
      CVE-2026-99060: wifi: mt76: mt7603: initialize global station WCID
      CVE-2026-99061: wifi: brcmfmac: fix P2P device removal race in brcmf_=
detach()
      CVE-2026-99062: vsock/virtio: account only unread bytes in read_skb()
      CVE-2026-99063: dm ioctl: don't let data_start run past the buffer
      CVE-2026-99064: cipso: adjust cached option offsets when removing CIP=
SO
      CVE-2026-99067: btrfs: scrub: fix local_root reference leak in scrub_=
print_warning_inode()
      CVE-2026-99069: Input: ati_remote2 - fix type confusion in device att=
ribute handlers
      CVE-2026-99070: ipv6: do not warn on route notification size race
      CVE-2026-99071: ipv4: do not warn on route notification size race
      CVE-2026-99072: ipv4: stop route notification sizing when nexthop gro=
up shrinks
      CVE-2026-99073: ipv4: stop exception dump when nexthop group shrinks
      CVE-2026-99074: ipv4: stop PMTU walk when nexthop group shrinks
      CVE-2026-99078: net/mlx5e: Prevent stale XSK buffer release on MPWQE =
refill retry
      CVE-2026-99079: net/mlx5e: Prevent stale XSK buffer release on refill=
 retry
      CVE-2026-99080: fs: Free any excess xarray nodes in clear_inode()
      CVE-2026-99081: bnxt_en: fix DMA mapping length for padded small pack=
ets
      CVE-2026-99088: net: openvswitch: validate transport header presence =
in set_ipv6_addr
      CVE-2026-99089: ASoC: samsung: i2s: enable op_clk in probe to balance=
 runtime PM
      CVE-2026-99090: drm/amdgpu: serialize vblank counter reads against GP=
U reset
      CVE-2026-99091: Bluetooth: MGMT: Fix status of pending commands flush=
ed on power off
      CVE-2026-99094: Bluetooth: btintel_pcie: fix TX descriptor bounds che=
ck
      CVE-2026-99095: drm/vc4: drain the hangcheck timer and works on V3D u=
nbind
      CVE-2026-99097: tee: shm: reject zero-sized allocations in tee_dyn_sh=
m_alloc_helper()
      CVE-2026-99999: ipv4: validate checksum_start before completing check=
sum
      CVE-2024-58074: drm/i915: Grab intel_display from the encoder to avoi=
d potential oopsies
      CVE-2025-22109: ax25: Remove broken autobind
      CVE-2025-23132: f2fs: quota: fix to avoid warning in dquot_writeback_=
dquots()
      CVE-2025-23135: RISC-V: KVM: Teardown riscv specific bits after kvm_e=
xit
      CVE-2025-37743: wifi: ath12k: Avoid memory leak while enabling statis=
tics
      CVE-2025-37746: perf/dwc_pcie: fix duplicate pci_dev devices
      CVE-2025-37906: ublk: fix race between io_uring_cmd_complete_in_task =
and ublk_cancel_cmd
      CVE-2025-38029: kasan: avoid sleepable page allocation from atomic co=
ntext
      CVE-2025-38041: clk: sunxi-ng: h616: Reparent GPU clock during freque=
ncy changes
      CVE-2025-38042: dmaengine: ti: k3-udma-glue: Drop skip_fdq argument f=
rom k3_udma_glue_reset_rx_chn
      CVE-2025-38064: virtio: break and reset virtio devices on device_shut=
down()
      CVE-2025-38132: coresight: holding cscfg_csdev_lock while removing cs=
cfg from csdev
      CVE-2025-38137: PCI/pwrctrl: Cancel outstanding rescan work when unre=
gistering
      CVE-2025-38140: dm: limit swapping tables for devices with zone write=
 plugs
      CVE-2025-38178: [REJECTED]: EDAC/igen6: Fix NULL pointer dereference
      CVE-2025-38187: drm/nouveau: fix a use-after-free in r535_gsp_rpc_pus=
h()
      CVE-2025-38199: wifi: ath12k: Fix memory leak due to multiple rx_stat=
s allocation
      CVE-2025-38207: mm: fix uprobe pte be overwritten when expanding vma
      CVE-2025-38261: riscv: save the SR_SUM status over switches
      CVE-2025-38284: wifi: rtw89: pci: configure manual DAC mode via PCI c=
onfig API only
      CVE-2025-38359: s390/mm: Fix in_atomic() handling in do_secure_storag=
e_access()
      CVE-2025-38421: platform/x86/amd: pmf: Use device managed allocations
      CVE-2025-38597: drm/rockchip: vop2: fail cleanly if missing a primary=
 plane for a video-port
      CVE-2025-38605: wifi: ath12k: Pass ab pointer directly to ath12k_dp_t=
x_get_encap_type()
      CVE-2025-38636: rv: Use strings in da monitors tracepoints
      CVE-2025-38656: wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_star=
t()
      CVE-2025-39677: net/sched: Fix backlog accounting in qdisc_dequeue_in=
ternal
      CVE-2025-39775: mm/mremap: fix WARN with uffd that has remap events d=
isabled
      CVE-2025-39789: crypto: x86/aegis - Add missing error checks
      CVE-2025-39830: net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init=
 error path
      CVE-2025-39834: net/mlx5: HWS, Fix memory leak in hws_action_get_shar=
ed_stc_nic error flow
      CVE-2025-39859: ptp: ocp: fix use-after-free bugs causing by ptp_ocp_=
watchdog
      CVE-2025-39862: wifi: mt76: mt7915: fix list corruption after hardwar=
e restart
      CVE-2025-39878: ceph: fix crash after fscrypt_encrypt_pagecache_block=
s() error
      CVE-2025-39879: ceph: always call ceph_shift_unused_folios_left()
      CVE-2025-39910: mm/vmalloc, mm/kasan: respect gfp mask in kasan_popul=
ate_vmalloc()
      CVE-2025-39921: spi: microchip-core-qspi: stop checking viability of =
op->max_freq in supports_op callback
      CVE-2025-39933: smb: client: let recv_done verify data_offset, data_l=
ength and remaining_data_length
      CVE-2025-39958: iommu/s390: Make attach succeed when the device was s=
urprise removed
      CVE-2025-40065: RISC-V: KVM: Write hgatp register with valid mode bit=
s
      CVE-2025-40086: drm/xe: Don't allow evicting of BOs in same VM in arr=
ay of VM binds
      CVE-2025-40113: remoteproc: qcom: pas: Shutdown lite ADSP DTB on X1E
      CVE-2025-40130: scsi: ufs: core: Fix data race in CPU latency PM QoS =
request handling
      CVE-2025-40136: crypto: hisilicon/qm - request reserved interrupt for=
 virtual function
      CVE-2025-40338: ASoC: Intel: avs: Do not share the name pointer betwe=
en components
      CVE-2025-40355: sysfs: check visibility before changing group attribu=
te ownership
      CVE-2025-68174: amd/amdkfd: enhance kfd process check in switch parti=
tion
      CVE-2025-68193: drm/xe/guc: Add devm release action to safely tear do=
wn CT
      CVE-2025-68209: mlx5: Fix default values in create CQ
      CVE-2025-68236: scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS pow=
er down (PC=3D3)
      CVE-2025-68318: clk: thead: th1520-ap: set all AXI clocks to CLK_IS_C=
RITICAL
      CVE-2025-68319: netconsole: Acquire su_mutex before navigating config=
s hierarchy
      CVE-2025-68353: net: vxlan: prevent NULL deref in vxlan_xmit_one
      CVE-2025-68359: btrfs: fix double free of qgroup record after failure=
 to add delayed ref head
      CVE-2025-68360: wifi: mt76: wed: use proper wed reference in mt76 wed=
 driver callabacks
      CVE-2025-68368: md: init bioset in mddev_init
      CVE-2025-68376: coresight: ETR: Fix ETR buffer use-after-free issue
      CVE-2025-68729: wifi: ath12k: Fix MSDU buffer types handling in RX er=
ror path
      CVE-2025-68730: accel/ivpu: Fix page fault in ivpu_bo_unbind_all_bos_=
from_context()
      CVE-2025-68735: drm/panthor: Prevent potential UAF in group creation
      CVE-2025-68745: scsi: qla2xxx: Clear cmds after chip reset
      CVE-2025-68755: staging: most: remove broken i2c driver
      CVE-2025-71074: functionfs: fix the open/removal races
      CVE-2025-71141: drm/tilcdc: Fix removal actions in case of failed pro=
be
      CVE-2025-71227: wifi: mac80211: don't WARN for connections on invalid=
 channels
      CVE-2025-71285: net: qrtr: Drop the MHI auto_queue feature for IPCR D=
L channels
      CVE-2025-71313: PCI: endpoint: Add missing NULL check for alloc_workq=
ueue()
      CVE-2026-100072: ACPI: platform: Use acpi_bus_get_primary_device()
      CVE-2026-100074: bpf: Mark bpf_refcount field as unique
      CVE-2026-100076: staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on=
 mgnt-frame error paths
      CVE-2026-100077: drm/msm: Recover HW before retire hung submit
      CVE-2026-23007: block: zero non-PI portion of auto integrity buffer
      CVE-2026-23017: idpf: fix error handling in the init_task on load
      CVE-2026-23143: virtio_net: Fix misalignment bug in struct virtnet_in=
fo
      CVE-2026-23208: ALSA: usb-audio: Prevent excessive number of frames
      CVE-2026-23217: riscv: trace: fix snapshot deadlock with sbi ecall
      CVE-2026-23259: io_uring/rw: free potentially allocated iovec on cach=
e put failure
      CVE-2026-23327: cxl/mbox: validate payload size before accessing cont=
ents in cxl_payload_from_user_allowed()
      CVE-2026-23371: sched/deadline: Fix missing ENQUEUE_REPLENISH during =
PI de-boosting
      CVE-2026-23377: ice: change XDP RxQ frag_size from DMA write length t=
o xdp.frame_sz
      CVE-2026-23385: netfilter: nf_tables: clone set on flush only
      CVE-2026-23472: serial: core: fix infinite loop in handle_tx() for PO=
RT_UNKNOWN
      CVE-2026-31493: RDMA/efa: Fix use of completion ctx after free
      CVE-2026-31526: bpf: Fix exception exit lock checking for subprogs
      CVE-2026-31562: drm/mediatek: dsi: Store driver data before invoking =
mipi_dsi_host_register
      CVE-2026-31568: s390/mm: Add missing secure storage access fixups for=
 donated memory
      CVE-2026-31573: media: verisilicon: Fix kernel panic due to __initcon=
st misuse
      CVE-2026-31579: wireguard: device: use exit_rtnl callback instead of =
manual rtnl_lock in pre_exit
      CVE-2026-31592: KVM: SEV: Protect *all* of sev_mem_enc_register_regio=
n() with kvm->lock
      CVE-2026-31630: rxrpc: proc: size address buffers for %pISpc output
      CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect
      CVE-2026-31746: s390/zcrypt: Fix memory leak with CCA cards used as a=
ccelerator
      CVE-2026-31771: Bluetooth: hci_event: move wake reason storage into v=
alidated event handlers
      CVE-2026-43009: bpf: Fix incorrect pruning due to atomic fetch precis=
ion tracking
      CVE-2026-43022: Bluetooth: hci_sync: hci_cmd_sync_queue_once() return=
 -EEXIST if exists
      CVE-2026-43034: bnxt_en: set backing store type from query type
      CVE-2026-43042: mpls: add seqcount to protect the platform_label{,s} =
pair
      CVE-2026-43048: HID: core: Mitigate potential OOB by removing bogus m=
emset()
      CVE-2026-43053: xfs: close crash window in attr dabtree inactivation
      CVE-2026-43083: net: ioam6: fix OOB and missing lock
      CVE-2026-43101: ipv6: ioam: fix potential NULL dereferences in __ioam=
6_fill_trace_data()
      CVE-2026-43115: srcu: Use irq_work to start GP in tiny SRCU
      CVE-2026-43118: btrfs: fix zero size inode with non-zero size after l=
og replay
      CVE-2026-43127: ntfs3: fix circular locking dependency in run_unpack_=
ex
      CVE-2026-43172: wifi: iwlwifi: fix 22000 series SMEM parsing
      CVE-2026-43185: ksmbd: fix signededness bug in smb_direct_prepare_neg=
otiation()
      CVE-2026-43191: drm/amd/display: Adjust PHY FSM transition to TX_EN-t=
o-PLL_ON for TMDS on DCN35
      CVE-2026-43204: ASoC: qcom: q6asm: drop DSP responses for closed data=
 streams
      CVE-2026-43213: wifi: rtw89: pci: validate sequence number of TX rele=
ase report
      CVE-2026-43234: team: avoid NETDEV_CHANGEMTU event when unregistering=
 slave
      CVE-2026-43263: media: chips-media: wave5: Fix Null reference while t=
esting fluster
      CVE-2026-43272: ring-buffer: Fix possible dereference of uninitialize=
d pointer
      CVE-2026-43294: drm: renesas: rz-du: mipi_dsi: fix kernel panic when =
rebooting for some panels
      CVE-2026-43298: drm/amdgpu: Skip vcn poison irq release on VF
      CVE-2026-43299: btrfs: do not ASSERT() when the fs flips RO inside bt=
rfs_repair_io_failure()
      CVE-2026-43308: btrfs: don't BUG() on unexpected delayed ref type in =
run_one_delayed_ref()
      CVE-2026-43309: md raid: fix hang when stopping arrays with metadata =
through dm-raid
      CVE-2026-43310: media: verisilicon: Avoid G2 bus error while decoding=
 H.264 and HEVC
      CVE-2026-43311: soc/tegra: pmc: Fix unsafe generic_handle_irq() call
      CVE-2026-43325: wifi: iwlwifi: mvm: don't send a 6E related command w=
hen not supported
      CVE-2026-43337: drm/amd/display: Fix NULL pointer dereference in dcn4=
01_init_hw()
      CVE-2026-43346: ice: ptp: don't WARN when controlling PF is unavailab=
le
      CVE-2026-43352: i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling i=
n DMA dequeue
      CVE-2026-43353: i3c: mipi-i3c-hci: Fix race in DMA ring dequeue
      CVE-2026-43414: scsi: qla2xxx: Completely fix fcport double free
      CVE-2026-43443: ASoC: amd: acp-mach-common: Add missing error check f=
or clock acquisition
      CVE-2026-43463: rxrpc, afs: Fix missing error pointer check after rxr=
pc_kernel_lookup_peer()
      CVE-2026-43464: net/mlx5e: RX, Fix XDP multi-buf frag counting for le=
gacy RQ
      CVE-2026-43465: net/mlx5e: RX, Fix XDP multi-buf frag counting for st=
riding RQ
      CVE-2026-43485: nouveau/gsp: drop WARN_ON in ACPI probes
      CVE-2026-45932: bpf: Fix tcx/netkit detach permissions when prog fd i=
sn't given
      CVE-2026-45934: btrfs: fix EEXIST abort due to non-consecutive gaps i=
n chunk allocation
      CVE-2026-45940: net: stmmac: fix oops when split header is enabled
      CVE-2026-45956: drm/exynos: vidi: use priv->vidi_dev for ctx lookup i=
n vidi_connection_ioctl()
      CVE-2026-45961: gfs2: fix memory leaks in gfs2_fill_super error path
      CVE-2026-46014: KVM: SVM: Add missing save/restore handling of LBR MS=
Rs
      CVE-2026-46032: KVM: nSVM: Triple fault if restore host CR3 fails on =
nested #VMEXIT
      CVE-2026-46044: ipmi:ssif: Clean up kthread on errors
      CVE-2026-46059: KVM: nSVM: Always use NextRIP as vmcb02's NextRIP aft=
er first L2 VMRUN
      CVE-2026-46066: ceph: fix num_ops off-by-one when crypto allocation f=
ails
      CVE-2026-46071: KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12
      CVE-2026-46130: dm-verity-fec: fix reading parity bytes split across =
blocks (take 3)
      CVE-2026-46148: spi: microchip-core-qspi: control built-in cs manuall=
y
      CVE-2026-46171: riscv: kvm: fix vector context allocation leak
      CVE-2026-46175: f2fs: fix fsck inconsistency caused by FGGC of node b=
lock
      CVE-2026-46181: RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()
      CVE-2026-46228: spi: ch341: fix devres lifetime
      CVE-2026-46245: drm/amd/display: Fix dc_link NULL handling in HPD ini=
t
      CVE-2026-46256: NFS/localio: prevent direct reclaim recursion into NF=
S via nfs_writepages
      CVE-2026-46272: coresight: tmc-etr: Fix race condition between sysfs =
and perf mode
      CVE-2026-46302: selinux: allow multiple opens of /sys/fs/selinux/poli=
cy
      CVE-2026-46324: netfilter: nf_tables: use list_del_rcu for netlink ho=
oks
      CVE-2026-46325: RDMA/rxe: Fix iova-to-va conversion for MR page sizes=
 !=3D PAGE_SIZE
      CVE-2026-46330: Revert "net/smc: Introduce TCP ULP support"
      CVE-2026-52937: tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
      CVE-2026-52956: libceph: Fix potential out-of-bounds access in __ceph=
_x_decrypt()
      CVE-2026-52983: net: airoha: fix BQL imbalance in TX path
      CVE-2026-52991: sched/psi: fix race between file release and pressure=
 write
      CVE-2026-53000: netfilter: nat: use kfree_rcu to release ops
      CVE-2026-53017: f2fs: fix data loss caused by incorrect use of nat_en=
try flag
      CVE-2026-53018: f2fs: avoid reading already updated pages during GC
      CVE-2026-53024: greybus: raw: fix use-after-free if write is called a=
fter disconnect
      CVE-2026-53025: greybus: raw: fix use-after-free on cdev close
      CVE-2026-53091: net: pull headers in qdisc_pkt_len_segs_init()
      CVE-2026-53103: wifi: mt76: mt7925: fix potential deadlock in mt7925_=
roc_abort_sync
      CVE-2026-53104: wifi: mt76: Fix memory leak destroying device
      CVE-2026-53108: powerpc/64s: Fix unmap race with PMD migration entrie=
s
      CVE-2026-53109: powerpc/pgtable-frag: Fix bad page state in pte_frag_=
destroy
      CVE-2026-53118: vdpa: use generic driver_override infrastructure
      CVE-2026-53178: staging: rtl8723bs: rtw_mlme: add bounds checks befor=
e ie_length subtraction
      CVE-2026-53224: sctp: validate embedded INIT chunk and address list l=
engths in cookie
      CVE-2026-53258: wifi: fix leak if split 6 GHz scanning fails
      CVE-2026-53277: KVM: arm64: Take the SRCU lock for page table walks i=
n fault injection and AT emulation
      CVE-2026-53281: iommu/vt-d: Avoid NULL pointer dereference or refcoun=
t corruption
      CVE-2026-53284: btrfs: only release the dirty pages io tree after suc=
cessful writes
      CVE-2026-53285: drm/amd/display: Wrap DCN32 phantom-plane allocation =
in DC_RUN_WITH_PREEMPTION_ENABLED
      CVE-2026-53292: net: phonet: do not BUG_ON() in pn_socket_autobind() =
on failed bind
      CVE-2026-53297: net: mana: Guard mana_remove against double invocatio=
n
      CVE-2026-53321: io_uring/napi: cap busy_poll_to 10 msec
      CVE-2026-53330: drm/amd/display: Fix out-of-bounds read in dp_get_eq_=
aux_rd_interval()
      CVE-2026-53368: f2fs: fix fsck inconsistency caused by incorrect nat_=
entry flag usage
      CVE-2026-53377: drm/msm: always recover the gpu
      CVE-2026-53401: fbdev: omap2: fix use-after-free in omapfb_mmap
      CVE-2026-63811: f2fs: read COW data with the original inode during at=
omic write
      CVE-2026-63825: gcov: use atomic counter updates to fix concurrent ac=
cess crashes
      CVE-2026-63832: wifi: mt76: add wcid publish check in mt76_sta_add
      CVE-2026-63853: drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ri=
ng
      CVE-2026-63857: net: airoha: Do not read uninitialized fragment addre=
ss in airoha_dev_xmit()
      CVE-2026-63859: net: airoha: Add missing bits in airoha_qdma_cleanup_=
tx_queue()
      CVE-2026-63879: drm/amdgpu: fix amdgpu_hmm_range_get_pages
      CVE-2026-63979: net/handshake: hand off the pinned file reference to =
accept_doit
      CVE-2026-63998: ethtool: module: call ethnl_ops_complete() on module =
flash errors
      CVE-2026-63999: ethtool: rss: fix indir_table and hkey leak on get_rx=
fh failure
      CVE-2026-64006: netfilter: nf_tables: fix dst corruption in same regi=
ster operation
      CVE-2026-64024: tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN p=
rediction
      CVE-2026-64036: cgroup/rstat: validate cpu before css_rstat_cpu() acc=
ess
      CVE-2026-64038: hwmon: (lm90) Stop work before releasing hwmon device
      CVE-2026-64060: netfs: Fix leak of request in netfs_write_begin() err=
or handling
      CVE-2026-64068: netfs: Fix missing locking around retry adding new su=
breqs
      CVE-2026-64076: netfilter: bridge: eb_tables: close module init race
      CVE-2026-64077: netfilter: ebtables: move to two-stage removal scheme
      CVE-2026-64079: netfilter: x_tables: allocate hook ops while under mu=
tex
      CVE-2026-64117: wifi: mac80211: capture fast-RX rate before mesh reus=
es skb->cb
      CVE-2026-64146: erofs: fix metabuf leak in inode xattr initialization
      CVE-2026-64154: drm/msm/adreno: Fix a reference leak in a6xx_gpu_init=
()
      CVE-2026-64159: netfs: Fix zeropoint update where i_size > remote_i_s=
ize
      CVE-2026-64190: net: team: fix NULL pointer dereference in team_xmit =
during mode change
      CVE-2026-64213: hwmon: (lm90) Add lock protection to lm90_alert
      CVE-2026-64281: svcrdma: wake sq waiters when the transport closes
      CVE-2026-64283: KVM: guest_memfd: Treat memslot binding offset+size a=
s unsigned values
      CVE-2026-64388: smb/client: fix chown/chgrp with SMB3 POSIX Extension=
s
      CVE-2026-64389: ksmbd: validate NTLMv2 response before updating sessi=
on key
      CVE-2026-64400: ksmbd: prevent path traversal bypass by restricting c=
aseless retry
      CVE-2026-64513: KVM: x86: Unconditionally recompute CR8 intercept on =
PPR update
      CVE-2026-68081: KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails =
due to invalid guest state
      CVE-2026-68105: drm/amdgpu: Fix kernel panic during driver load failu=
re
      CVE-2026-68211: media: stm32-dcmipp: Return queued buffers on start_s=
treaming() failure
      CVE-2026-68233: drm/vc4: Shut down BO cache timer before teardown
      CVE-2026-68238: drm/amdgpu: Release VFCT ACPI table reference
      CVE-2026-68241: drm/i915/mst: limit DP MST ESI service loop
      CVE-2026-68242: drm/i915/gt: Fix NULL deref on sched_engine alloc fai=
lure
      CVE-2026-68258: drm/amdkfd: Check bounds on CRIU restore queue type a=
nd mqd size
      CVE-2026-68291: idpf: fix max_vport related crash on allocation error=
 during init
      CVE-2026-68295: LoongArch: BPF: Zero-extend signed ALU32 div/mod resu=
lts
      CVE-2026-68312: cifs: fix cifsFileInfo leak on kmalloc failure in def=
erred close drain paths
      CVE-2026-68323: tipc: serialize udp bearer replicast list updates
      CVE-2026-68375: bnxt_en: Handle partially initialized auxiliary devic=
es
      CVE-2026-68383: drm/xe/guc: Keep scheduler timeline name alive
      CVE-2026-68393: Bluetooth: hci_sync: extend conn_hash lookup critical=
 sections
      CVE-2026-68399: bpf: Fix UAF in sock clone early bailouts
      CVE-2026-68400: firmware: arm_ffa: Fix Endpoint Memory Access Descrip=
tor offset calculation
      CVE-2026-68401: firmware: arm_ffa: Fix out-of-bound writes in ffa_set=
up_and_transmit()
      CVE-2026-68404: wifi: cfg80211: use wiphy work for socket owner autod=
isconnect
      CVE-2026-68409: wifi: mac80211: defer link RX stats percpu free to RC=
U
      CVE-2026-68412: wifi: cfg80211: Fix an error handling path in cfg8021=
1_wext_siwscan()
      CVE-2026-68418: RDMA/irdma: Prevent user-triggered null deref on QP c=
reate
      CVE-2026-68421: sched_ext: Don't warn on core-sched forced idle in pu=
t_prev_task_scx()
      CVE-2026-68426: xfrm: fix stale skb->prev after async crypto steals a=
 GSO segment
      CVE-2026-68435: LoongArch: Fix address space mismatch in kexec comman=
d line lookup
      CVE-2026-68436: drm/amd/display: use kvzalloc to allocate struct dc
      CVE-2026-68441: net/sched: Handle TC_ACT_REDIRECT from qdisc filter c=
hains
      CVE-2026-68447: drm/amdkfd: clamp v9 CRIU control stack checkpoint co=
py to BO size
      CVE-2026-68448: ovl: check access to copy_file_range source with src =
mounter creds
      CVE-2026-68453: s390/zcrypt: Fix buffer over-read in cca_cipher2protk=
ey
      CVE-2026-68470: wifi: mac80211: validate extension-frame layout befor=
e RX
      CVE-2026-68471: wifi: ieee80211: validate MLE common info length
      CVE-2026-72009: pmdomain: imx93-blk-ctrl: Extract PHY as shared domai=
n for DSI/CSI
      CVE-2026-72031: ata: libata-core: Add NOLPM quirk for PNY CS900 1TB S=
SD
      CVE-2026-72073: mmc: vub300: fix use-after-free on probe failure
      CVE-2026-72098: dm-verity: fix buffer overflow in FEC calculation
      CVE-2026-72162: ocfs2: fix UBSAN array-index-out-of-bounds in ocfs2_s=
um_rightmost_rec
      CVE-2026-72288: KVM: arm64: vgic: Handle race between interrupt affin=
ity change and LPI disabling
      CVE-2026-72321: ipv4: igmp: Fix potential memory leaks in igmp_mod_ti=
mer() and igmp_stop_timer()
      CVE-2026-72329: net/liquidio: drop cached VF pci_dev LUT
      CVE-2026-72337: Bluetooth: 6lowpan: avoid untracked enable work
      CVE-2026-72341: net/mlx5e: Fix publication race for priv->channel_sta=
ts[]
      CVE-2026-72363: netfs: Fix folio state after ENOMEM whilst under writ=
eback iteration
      CVE-2026-72366: netfs: Fix netfs_create_write_req() to handle async c=
ache object creation
      CVE-2026-72367: iomap: guard io_size EOF trim against concurrent trun=
cate underflow
      CVE-2026-72375: afs: Fix reinitialisation of the inode, in particular=
 ->lock_work
      CVE-2026-72380: xen/pvcalls: bound backend response req_id before ind=
exing rsp[]
      CVE-2026-72383: sctp: fix addr_wq_timer race in sctp_free_addr_wq()
      CVE-2026-72388: drm/panthor: Always use the IRQ-safe variant when acq=
uiring the fence lock
      CVE-2026-72397: hwmon: (pmbus/core) honor vrm_version in pmbus_data2r=
eg_vid()
      CVE-2026-72398: sctp: add INIT verification after cookie unpacking
      CVE-2026-72404: tipc: fix UAF in cleanup_bearer() due to premature ds=
t_cache_destroy()
      CVE-2026-72423: bpf: Guard conntrack opts error writes
      CVE-2026-72439: md/raid10: fix writes_pending leak on write request f=
ailures
      CVE-2026-72440: md/raid1: fix writes_pending and barrier reference le=
aks on write failures
      CVE-2026-72488: soundwire: fix bug in sdw_add_element_group_count fou=
nd by syzkaller
      CVE-2026-72493: net: serialize netif_running() check in enqueue_to_ba=
cklog()
      CVE-2026-72494: RDMA/irdma: Replace waitqueue and flag with completio=
n
      CVE-2026-72495: RDMA/bnxt_re: Avoid repeated requests to allocate WC =
pages
      CVE-2026-72497: RDMA/bnxt_re: Add a max slot check for SQ
      CVE-2026-72499: RDMA/bnxt_re: Free CQ toggle page after firmware tear=
down
      CVE-2026-72500: RDMA/bnxt_re: Free SRQ toggle page after firmware tea=
rdown
      CVE-2026-72501: RDMA/bnxt_re: Initialize dpi variable to zero
      CVE-2026-74257: sockmap: Fix use-after-free in udp_bpf_recvmsg()
      CVE-2026-74261: ALSA: seq: avoid stale FIFO cells during resize
      CVE-2026-74264: net: watchdog: fix refcount tracking races
      CVE-2026-74269: bnxt: fix head underflow on XDP head-grow
      CVE-2026-74272: cxl/region: Resolve region deletion races
      CVE-2026-74273: cxl/region: Block region delete during region creatio=
n
      CVE-2026-74317: ixgbe: do not configure xps for XDP queues
      CVE-2026-74338: bpf: Reject sleepable BPF_LSM_CGROUP programs at load=
 time
      CVE-2026-74344: bpf: Clear rb node linkage when freeing bpf_rb_root
      CVE-2026-74350: ocfs2: validate fast symlink target during inode read
      CVE-2026-74368: wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h=
_verify_tkip_mic()
      CVE-2026-74373: md/raid1,raid10: fix bio accounting for split md clon=
ed bios
      CVE-2026-74374: md/raid1,raid10: fix error-path detection with md_clo=
ned_bio()
      CVE-2026-74375: md/raid1,raid10: fix deadlock in read error recovery =
path
      CVE-2026-74385: nvmet-tcp: check return value of nvmet_tcp_set_queue_=
sock
      CVE-2026-74388: ALSA: seq: oss: Fix UAF at handling events with embed=
ded SysEx data
      CVE-2026-74405: OPP: Fix race between OPP addition and lookup
      CVE-2026-74407: wifi: ath11k: cancel SSR work items during PCI shutdo=
wn
      CVE-2026-74449: drm/amd/display: Fix divide-by-zero in calculate_mcac=
he_setting on zero viewport
      CVE-2026-74466: s390/zcrypt: Close speculative mem read possibility
      CVE-2026-74506: afs: Fix UAF when sending a message
      CVE-2026-74513: dibs: fix use-after-free of dmb_node in loopback atta=
ch/detach/unregister
      CVE-2026-74520: iommu/iommufd: Fix IOPF group ownership UAF
      CVE-2026-74527: octeontx2-af: Block VFs from clobbering special CGX P=
KIND state
      CVE-2026-74529: Bluetooth: hci_sync: hold conn in hci_connect_pa_sync=
() callback
      CVE-2026-74530: Bluetooth: hci_sync: hold conn in hci_connect_big_syn=
c() callback
      CVE-2026-74533: Bluetooth: ISO: fix race of kfree vs kref_get_unless_=
zero
      CVE-2026-74537: Bluetooth: ISO: hold sk properly in iso_conn_ready
      CVE-2026-74538: Bluetooth: ISO: lock sk in iso_connect_ind
      CVE-2026-74542: netfs: Fix folio_queue ENOMEM in writeback by adding =
a mempool
      CVE-2026-74544: net/sched: cls_u32: validate offshift to prevent shif=
t-out-of-bounds
      CVE-2026-74558: xsk: reclaim invalid Tx descriptors in ZC batch path
      CVE-2026-74559: xsk: drain continuation descs after overflow in xsk_b=
uild_skb()
      CVE-2026-74571: btrfs: skip global block reserve accounting for rescu=
e mounts
      CVE-2026-74600: mm/page_table_check: skip special zero mappings
      CVE-2026-74605: eventfs: Use children field for rcu head and add memo=
ry barriers
      CVE-2026-74611: tls: rx: restore msg_iter before TLS 1.3 optimistic r=
etry
      CVE-2026-74687: watchdog: at91sam9_wdt: prevent timer rearm during te=
ardown
      CVE-2026-74690: s390/ism: Fix UAF of sba and ieq during ism_dev_exit(=
)
      CVE-2026-74695: netfilter: nf_flow_table: drop existing skb dst befor=
e skb_dst_set_noref()
      CVE-2026-74697: bnxt_en: Disable EOP for TPA on all chips to prevent =
data corruption
      CVE-2026-74711: hwmon: (pmbus) Fix type confusion in notification log=
ic
      CVE-2026-74713: vhost_iotlb: bound map allocation in add_range
      CVE-2026-74715: bpf: Fix netns reference imbalance in conntrack kfunc=
s
      CVE-2026-74723: btrfs: lzo: reject inline extents without valid heade=
rs
      CVE-2026-74728: xfs: handle NULL b_addr in xfs_buf_free
      CVE-2026-74729: soc: aspeed: lpc-snoop: Fix usercopy overflow in snoo=
p_file_read
      CVE-2026-74733: gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap=
 lock
      CVE-2026-74734: firewire: ohci: fix NULL pointer dereference in ar_co=
ntext_release
      CVE-2026-74747: ipvs: revalidate ihl to prevent out-of-bounds access
      CVE-2026-74752: sctp: validate cookie AUTH state before use
      CVE-2026-74754: scsi: core: pair EH runtime PM get and put
      CVE-2026-80581: ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in=
 case of IPC timeout
      CVE-2026-80607: tracing/probes: Remove WARN_ON_ONCE from parse_btf_ar=
g
      CVE-2026-80614: net: emac: Fix NULL pointer dereference in emac_probe
      CVE-2026-80616: ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg=
802154_switch_netns()
      CVE-2026-80623: coresight: ete: Always save state on power down
      CVE-2026-80628: ALSA: seq: oss: Serialize readq reset state with q->l=
ock
      CVE-2026-80631: btrfs: lzo: reject compressed segment that overflows =
the compressed input
      CVE-2026-80634: netfilter: flowtable: avoid num_encaps underflow on b=
ridge VLAN untag
      CVE-2026-80643: EDAC/igen6: Fix call trace due to missing release()
      CVE-2026-80653: scsi: hisi_sas: Add slave_destroy interface for v3 hw
      CVE-2026-80655: soc: xilinx: Fix race condition in event registration
      CVE-2026-80662: cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability s=
ize
      CVE-2026-80668: netfilter: nf_conntrack_expect: use conntrack GC to r=
eap expectations
      CVE-2026-80692: Bluetooth: hci_sync: hold conn in hci_connect_acl/le_=
sync() callbacks
      CVE-2026-80693: idpf: bound interrupt-vector register fill to the all=
ocated array
      CVE-2026-80698: dmaengine: idxd: fix double free of wq, engine, and g=
roup structs
      CVE-2026-80705: drm/amd/display: check if dml21_add_phantom_plane() i=
s successful
      CVE-2026-80734: btrfs: initialize inode mapping flags for cached inod=
es
      CVE-2026-80738: bpf: Check sk_state before sk_protocol in bpf_tcp_*_s=
yncookie
      CVE-2026-80747: drm/amdkfd: Add bounds check for CRAT subtype length
      CVE-2026-80761: Bluetooth: ISO: zero the sockaddr before returning it=
 in getname
      CVE-2026-80786: fbdev: Wrap user-invoked calls to fb_set_var() in hel=
per
      CVE-2026-80866: tipc: avoid busy looping in tipc_exit_net()
      CVE-2026-80884: ntb: Store original DMA address for future release
      CVE-2026-80897: netfs: release readahead folios on iterator preparati=
on failure
      CVE-2026-80905: net: tap: fix wrong transport_header when sending VLA=
N-tagged frame
      CVE-2026-80920: io_uring: defer eventfd signaling when queued from a =
wakeup handler
      CVE-2026-80948: wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dv=
m_start()
      CVE-2026-89528: svcrdma: Reject Read lists that exceed the page budge=
t
      CVE-2026-89534: svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement =
fails
      CVE-2026-89537: SUNRPC: Reject short RFC 4121 MIC tokens in gss_krb5_=
verify_mic_v2
      CVE-2026-89601: ext2: Fix lost inode updates for IS_SYNC inodes
      CVE-2026-89631: smb: client: reject a tree connect response whose byt=
e count is too small
      CVE-2026-89642: cifs: call pagecache_isize_extended() in cifs_setsize=
() when extending
      CVE-2026-89648: ceph: cap delegated inode count in ceph_parse_deleg_i=
nos()
      CVE-2026-89654: ceph: fix UAF in check_new_map() on session freed dur=
ing unlock
      CVE-2026-89682: nfsd: fix fcache_disposal UAF by inlining dispose sta=
te into nfsd_net
      CVE-2026-89705: nfsd: restore rq_status_counter to even on all nfsd_d=
ispatch() exit paths
      CVE-2026-89709: lockd, nfsd: RCU-protect nlmsvc_ops dispatch
      CVE-2026-89757: mm/mglru: fix and remove redundant unevictable folio =
handling
      CVE-2026-89788: ksmbd: fix tree connection use-after-free in smb2_tre=
e_connect()
      CVE-2026-89808: drm/amdkfd: Fix the case that vm range is hole at svm=
_migrate_copy_to_vram
      CVE-2026-89810: drm/amdkfd: Fix error path at svm_migrate_copy_to_ram
      CVE-2026-89811: drm/amdkfd: Add TLB flush after MES queue eviction/su=
spension
      CVE-2026-89812: drm/amdgpu: force complete the MES ring fences on res=
et
      CVE-2026-89813: drm/amdgpu: force complete the KIQ ring fences on res=
et
      CVE-2026-89833: f2fs: fix to avoid potential deadloop in f2fs_fsync_n=
ode_pages()
      CVE-2026-89906: LoongArch: BPF: Refactor jump offset calculation in t=
ail call
      CVE-2026-89913: KVM: arm64: vgic-v3: take an LPI reference in vgic_v3=
_save_pending_tables
      CVE-2026-89920: KVM: s390: Fix memory corruption by not reinjecting C=
K machine checks
      CVE-2026-89987: mm/huge_memory: transfer the pmd dirty bit to the fol=
io on zap
      CVE-2026-90052: [REJECTED]: dm-integrity: fix buffer overflow with ke=
yed discard
      CVE-2026-90061: netfilter: nf_tables: skip double clone set expressio=
ns on element insert
      CVE-2026-90083: net/sched: act_ife: Only operate on Ethernet frames
      CVE-2026-90084: octeontx2-vf: fix workqueue and netdev race in probe/=
remove
      CVE-2026-90086: xsk: honor XDP_TX_METADATA in zero-copy path
      CVE-2026-90087: Bluetooth: do not leak an hci_conn when a second LE c=
onnect is rejected
      CVE-2026-90093: Bluetooth: L2CAP: access chan->conn safely in get/set=
sockopt
      CVE-2026-90097: Drivers: hv: vmbus: Skip VMBus module cleanup for non=
-nested root partition
      CVE-2026-90099: net/sched: account classifier filter allocations to m=
emcg
      CVE-2026-90104: NFSv4.1: zero referring call lists before decoding
      CVE-2026-90105: vxlan: fix reading neigh ha
      CVE-2026-90106: net: bridge: arp/nd proxy: fix reading neigh ha
      CVE-2026-90111: ip6mr: do not clone dst in ip6mr_cache_report()
      CVE-2026-90116: ALSA: mtpav: shut down output timer before card teard=
own
      CVE-2026-90142: virtio_net: Fix resize of the RX ring
      CVE-2026-90144: dpll: fix NULL deref in dpll_device_ops() during tear=
down race
      CVE-2026-90149: NFSv4/flexfiles: fix NULL dereference for NFSv4.0 dat=
a servers
      CVE-2026-90154: ksmbd: scope session state changes to bound connectio=
ns
      CVE-2026-90155: ksmbd: detach blocked lock requests before freeing
      CVE-2026-90156: ksmbd: safely discard unregistered deferred locks
      CVE-2026-90161: erofs: fix interlaced ztailpacking pclusters
      CVE-2026-90162: ksmbd: defer publishing granted locks to prevent UAF/=
double-free race
      CVE-2026-90167: ksmbd: serialize oplock close with pending break owne=
rship
      CVE-2026-90174: ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_use=
r()
      CVE-2026-90177: bpf: Check pointer type for all atomic RMW paths
      CVE-2026-90179: apparmor: fix deadlock in complain-mode change_hat
      CVE-2026-90182: blk-iocost: clear delay state when freeing policy dat=
a
      CVE-2026-90183: blk-iolatency: clear delay state when freeing policy =
data
      CVE-2026-90204: ocfs2: validate DIO orphan slot during inode read
      CVE-2026-90205: ocfs2: validate orphan slot during inode read
      CVE-2026-90206: nvmet: fix max_qid race between configfs and controll=
er allocation
      CVE-2026-90208: clocksource/drivers/samsung_pwm: Switch to raw_spinlo=
ck_t type
      CVE-2026-90217: bpf: Compare iterator types during state pruning
      CVE-2026-90231: apparmor: fix unconfined user namespace restriction f=
orced stack
      CVE-2026-90232: amt: Don't support cross-netns setup.
      CVE-2026-90234: NFS: Return a delegation the client fails to record
      CVE-2026-90240: iommu/vt-d: Flush context cache with correct SID when=
 tearing down aliases
      CVE-2026-90247: bpf: Fix mmap_lock leak in irq_work path
      CVE-2026-90256: Bluetooth: L2CAP: use proto_lock for l2cap_data to fi=
x l2cap_disconn_ind
      CVE-2026-90259: btrfs: qgroup: fix a wrong length calculation in qgro=
up_free_reserved_data()
      CVE-2026-90260: btrfs: zoned: don't clobber the extent buffer when ze=
roing it out
      CVE-2026-90263: btrfs: check if root is readonly when setting posix a=
cl
      CVE-2026-90264: btrfs: always wait for ordered extents to avoid OE ra=
ces
      CVE-2026-90265: btrfs: defrag: fix deadlock between defrag and delall=
oc space reservation
      CVE-2026-90267: scsi: sd: Fix special_vec mempool leak when scsi_allo=
c_sgtables() fails
      CVE-2026-90273: coresight: etm4x: missing cscfg_csdev_disable_active_=
config() in perf enable
      CVE-2026-90289: drm/amd/display: Resize MST HDCP per-connector arrays=
 to 32
      CVE-2026-90300: bpf: Clear buf on error in __bpf_get_task_stack
      CVE-2026-90301: ocfs2: o2hb: quiesce negotiate handlers and timeout w=
ork
      CVE-2026-90311: thermal: hwmon: Remove hwmon class device along with =
its parent
      CVE-2026-90320: ocfs2: validate external xattr entries when reading m=
etadata
      CVE-2026-90321: ocfs2: validate inline xattrs during inode block vali=
dation
      CVE-2026-90324: ublk: check import_ubuf() return value
      CVE-2026-90326: blk-cgroup: fix race between policy activation and bl=
kg destruction
      CVE-2026-90328: HID: steam: Reject short reads
      CVE-2026-90330: HID: logitech-hidpp: Fix FF device cleanup on init fa=
ilure
      CVE-2026-90333: dm-integrity: replace forgeable discard filler with a=
 keyed sector marker
      CVE-2026-90335: tty: skip cdev_del() when no cdev is registered
      CVE-2026-90336: serial: core: clear freed pointers on uart_register_d=
river() failure
      CVE-2026-90337: serial: core: do fallible allocations before the cons=
ole can be registered
      CVE-2026-90343: wifi: cfg80211: stop PMSR before P2P and NAN teardown
      CVE-2026-90345: wifi: brcmfmac: fix P2P action frame handling without=
 device vif
      CVE-2026-90346: wifi: nl80211: clean up color-change beacon data on e=
rrors
      CVE-2026-90347: arm64: ptrace: Keep 'orig_x0' in-sync with x0 on sysc=
all entry
      CVE-2026-90351: wifi: mt76: mt7996: do not attach hif2 WED when the m=
ain WED attach failed
      CVE-2026-90359: bpf: Reject >8 byte return values on return-reading t=
rampoline paths
      CVE-2026-90363: drm/msm: don't tear down KMS twice when KMS init fail=
s
      CVE-2026-90365: wifi: mt76: cancel reset and rc work on device unregi=
ster
      CVE-2026-90367: wifi: mt76: mt7996: hold dev->mt76.mutex while disabl=
ing tx worker in SER
      CVE-2026-90408: wifi: ath12k: fix overreads in ath12k_wmi_process_csa=
_switch_count_event()
      CVE-2026-90409: drm/panthor: Add vm_bind region with kbo range overla=
p check
      CVE-2026-90417: RDMA/cxgb4: Fix dereg_skb leak and double free in wri=
te_tpt_entry()
      CVE-2026-90421: PCI: Fix UAF when probe runs concurrent to dyn ID rem=
oval
      CVE-2026-90422: clk: mediatek: pllfh: Fix IO remapping leak in regist=
er_pllfhs error path
      CVE-2026-90424: iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-fai=
lure path
      CVE-2026-90427: iommu/tegra241-cmdqv: Don't fall back to a freed smmu=
 after devm_krealloc()
      CVE-2026-92480: scsi: ufs: core: Validate string descriptors
      CVE-2026-92482: pinctrl: mediatek: use devm_gpiochip_add_data() for G=
PIO chip
      CVE-2026-92485: bpf: Fix WARNING in bpf_tracing_link_release
      CVE-2026-92503: ext4: fix ABBA deadlock in ext4_xattr_inode_cache_fin=
d()
      CVE-2026-92520: bpf: Zero queue and stack outputs on lock failure
      CVE-2026-93058: drm/msm: Only fini scheduler after successful init
      CVE-2026-93081: firmware: arm_scmi: Fix SCMI device destroy lifetimes
      CVE-2026-93100: fs/resctrl: Prevent use-after-free in rdtgroup_kn_put=
()
      CVE-2026-93104: RDMA/rvt: Return NULL after port allocation failure
      CVE-2026-93105: esp: do not unref managed frag pages in esp_ssg_unref=
()
      CVE-2026-93116: platform/x86: asus-wmi: fix resource leaks on probe f=
ailure
      CVE-2026-93122: usb: gadget: uac: validate rate list length before st=
oring
      CVE-2026-93125: bpf: Reject rdonly/rdwr_buf_size kfunc arguments that=
 exceed u32 max
      CVE-2026-93129: platform/x86: dell-wmi-base: Fix handling of ultra pe=
rformance key
      CVE-2026-93144: bpf: Reject writes through untrusted BTF pointers
      CVE-2026-93146: time/namespace: Validate nanosecond field in proc_tim=
ens_set_offset()
      CVE-2026-93148: bpf: Reject MEM_ALLOC BTF accesses past object bounds
      CVE-2026-93168: dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_po=
ll_timeout
      CVE-2026-93175: drm/amd/display: Fix dangling pointer in CRTC reset f=
unction
      CVE-2026-93176: drm/amd/display: Fix dangling pointer in plane reset =
function
      CVE-2026-93181: perf/x86/intel/uncore: Fix uncore_box ref/unref order=
ing
      CVE-2026-93202: i3c: master: Fix recursive locking during device regi=
stration
      CVE-2026-93216: mm/page_owner: use memcg_data snapshot to avoid TOCTO=
U in print_page_owner_memcg()
      CVE-2026-93221: nfsd: convert nfsd_net boolean flags to unsigned long=
 flags word
      CVE-2026-93230: mm/hugetlb: initialize gigantic bootmem hugepage stru=
ct pages earlier
      CVE-2026-93251: ACPI: bus: Introduce acpi_bus_get_primary_device()
      CVE-2026-93260: powerpc/xive: propagate IPI init errors to prevent us=
e-after-free
      CVE-2026-93272: remoteproc: qcom_wcnss: Fix handling the lack of PD r=
egulators in v3
      CVE-2026-93282: ksmbd: fix maximum allowed access checks
      CVE-2026-97422: drm/amdkfd: fix SMI event cross-process information l=
eak
      CVE-2026-97424: drm/amdgpu/ras: add ras_suspend callback and use it f=
or cp_ecc_error_irq
      CVE-2026-97432: wifi: iwlwifi: mvm: fix P2P-Device binding handling
      CVE-2026-97477: RDMA/counter: Fix num_counters leak on bind_qp failur=
e in alloc_and_bind()
      CVE-2026-97478: virt: acrn: Fix irqfd use-after-free during eventfd s=
hutdown
      CVE-2026-97479: driver core: Avoid warning when removing a device whi=
le its supplier is unbinding
      CVE-2026-97480: tty: serial: 8250: protect against NULL uart->port.de=
v in register
      CVE-2026-97493: drm/amdgpu: Bound GPIO I2C table entry count from VBI=
OS
      CVE-2026-97501: pinctrl: mediatek: paris: bypass pinctrl GPIO layer i=
n set GPIO direction
      CVE-2026-97503: genirq/proc: Size interrupt directory names for 10-di=
git interrupt numbers
      CVE-2026-97513: media: chips-media: wave5: Release m2m_ctx after Inst=
ance Removed from List
      CVE-2026-97515: i3c: master: svc: Prevent IRQ storm from false SLVSTA=
RT on NPCM845
      CVE-2026-97538: hwmon: (asus_rog_ryujin) Validate HID report lengths
      CVE-2026-97554: smb: client: avoid using uninitialized SIDs in cifs_p=
osix_to_fattr()
      CVE-2026-97561: smb: client: honor forceuid/forcegid when mapping SID=
s to uid/gid
      CVE-2026-97928: drm/amdgpu: skip the VMID 0 flush for VRAM
      CVE-2026-97960: perf/x86/intel: Prevent drain_pebs() reentry
      CVE-2026-97962: net/mlx5e: Move representor vnic reporter to eswitch =
devlink port
      CVE-2026-97975: Bluetooth: hci_sysfs: Fix NULL pointer dereference in=
 device_del()
      CVE-2026-97988: vhost: invalidate vring access on IOTLB transitions
      CVE-2026-97989: vduse: validate virtqueue alignment
      CVE-2026-97997: virtio_ring: fix stale descriptor flags after a faile=
d packed add
      CVE-2026-98003: iommu/amd: Do not reallocate GA log buffers on resume
      CVE-2026-98019: bpf: mark a NULL call argument precise
      CVE-2026-98032: tracing: Fix subbuf resize races with trace_pipe_raw =
readers
      CVE-2026-98033: bpf: Preserve inner map identity in callback frames
      CVE-2026-98034: bpf: Mark NULL kptr stores precise
      CVE-2026-98038: bpf: Keep refcount_acquire nullable for borrowed RCU =
kptrs
      CVE-2026-98043: bpf: Don't infer non-NULL from a pointer with an unbo=
unded offset
      CVE-2026-98044: bpf: Reject legacy packet loads from callbacks
      CVE-2026-98047: bpf: Check ancestor frames for rbtree callbacks
      CVE-2026-98048: bpf: don't rewrite bpf_fastcall patterns entered by a=
 jump
      CVE-2026-98049: bpf: zero extend the result of an arena 32-bit cmpxch=
g
      CVE-2026-98053: ASoC: Intel: avs: Refactor and fix init_config access
      CVE-2026-98058: bpf: Mark syscall helpers as sleepable
      CVE-2026-98062: bpf: Mark signal tracepoint siginfo arguments as scal=
ar
      CVE-2026-98067: erofs: disable LZ4 rolling decompression for now
      CVE-2026-98073: net: Remove conflicting altnames for dying netns in _=
_dev_change_net_namespace().
      CVE-2026-98079: btrfs: zstd: fix lost wakeup when waiting for a works=
pace
      CVE-2026-98084: bpf: backtracking shouldn't clear outer frame R1-R5 f=
or callbacks
      CVE-2026-98085: bpf: backtrack_insn(): Handle ld_{abs,ind} subprog ex=
it edge
      CVE-2026-98099: ipv6: mcast: use rcu_assign_pointer() for __rcu list =
updates
      CVE-2026-98124: smb/client: invalidate fscache for fallocate range op=
erations
      CVE-2026-98131: net: stmmac: fix dma mapping leak in stmmac_tso_xmit(=
)
      CVE-2026-98134: bpf: check_cond_jmp_op(): properly infer if register =
is null
      CVE-2026-98147: printk: Don't WARN on kthread_run failure.
      CVE-2026-98148: drm/gud: validate GUD_ROTATION_0 is present in suppor=
ted rotations
      CVE-2026-98156: drm/virtio: use the DMA API for resource backing on X=
en
      CVE-2026-98916: wifi: nl80211: check link is beaconing for color chan=
ge
      CVE-2026-98974: xfs: fix exchange-range-to-eof file size exchange
      CVE-2026-98975: xfs: stop exchanging reflink flags when exchanging ma=
ppings
      CVE-2026-98977: namespace: handle mount locking for automounts correc=
tly
      CVE-2026-98981: namespace: unhash a dentry before detaching the mount=
s on it
      CVE-2026-98985: namespace: check the mounts before reading their pare=
nts in pivot_root()
      CVE-2026-98993: namespace: don't inherit MNT_UMOUNT in clone_mnt()
      CVE-2026-99002: drm/vmwgfx: validate pitch coming from userspace
      CVE-2026-99009: Bluetooth: RFCOMM: connect the session socket without=
 rfcomm_mutex
      CVE-2026-99014: Bluetooth: hci_sync: Fix command skb lifetime during =
scan setup
      CVE-2026-99019: scsi: ch: Do not keep references to data transfer ele=
ment devices
      CVE-2026-99027: net: team: stop reusing skb after queue override
      CVE-2026-99028: net: xilinx: axienet: Free outstanding DMA buffers on=
 dmaengine stop
      CVE-2026-99041: ip6_gre: remove obsolete ERSPAN PMTU update
      CVE-2026-99044: ice: fix use-after-free in dynamic port cleanup
      CVE-2026-99082: KVM: x86: Use active memslots for the per-vCPU MMIO c=
ache
      CVE-2026-99083: ksmbd: fix heap out-of-bounds write in krb5_authentic=
ate()
      CVE-2026-99085: sched_ext: Fix CPU hotplug hang when a dying CPU's ta=
sks sit in the BPF scheduler
      CVE-2026-99092: riscv: patch: fix handling of bpf-jit execmem address=
es
      CVE-2026-99098: dm-integrity: fix buffer overflow in inline mode with=
 large tag size
    added commits:
      CIP: Bump version suffix to -cip34 after merge from stable and fixes =
for CIP-related patches
      irqchip/renesas-rzv2h: Restore function parameter for suspend/resume
      PM: domains: Mark dev_pm_domain_allow_detach_on_unbind_cleanup() as i=
nline
      iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
      i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()
      arm64: dts: renesas: r9a09g047e57-smarc: Drop SW_SER0_PMOD condition =
for rsci4
      arm64: dts: renesas: r9a08g046l48-smarc: Enable rsci{1,2,3} nodes
      arm64: dts: renesas: r9a08g046: Add rsci{0..3} device nodes
      serial: sh-sci: Add support for RZ/G3L RSCI
      dt-bindings: serial: renesas,rsci: Document RZ/G3L SoC

Best regards,
  Nobuhiro


