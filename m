Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BEC43458
	for <webhook@archiver.kernel.org>; Sat, 11 Jul 2026 20:49:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3528.1783802974052178807
 for <cip-dev@lists.cip-project.org>;
 Sat, 11 Jul 2026 13:49:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=xsAioljF;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1783802965;x=1785012565;bh=
	xRR0gouG7AWZGT8fCGy23Sgyf2flZZUia2K2ncaKc8A=;b=xsAioljF8xGgLlb9b8tXnIl2AFBW+j
	LxjjagROL1EJsKxQUuf/EYZHKNLTBp2zO8JjQ0DHdNQmG0q3myJWqI/SNI0o+VRJXGFt3u+krqzpK
	M1DwXk3qnbcCtCnwgpP1bt+pCmkIdHSGZwG3N9dSJ5nZKxF533y/EDu0isVScam8/fiitWma31XKt
	1e97zflw0gPLmCweGejce9VtFSWuG37i9XAWqWtzzHpEqNFke7c1bKf14wUo9Y0QPHcLMX45JQrVn
	adeZWuKn+Nui9WspNihWyBg7ijbOpxdm0kBFgNNpIUQeoBmPn69KV+D+eobDMFVvDxpCAWoGdUSQQ
	pr4g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 66BKnOc3599103; Sun, 12 Jul 2026 05:49:24 +0900
X-Iguazu-Qid: 2yAbwL37MNEu1kUVZx
X-Iguazu-QSIG: v=2; s=1; t=1783802964; q=2yAbwL37MNEu1kUVZx; m=wH7d/m13KMbuHXLKJKgknTK+YQEM/2RGuJiTysAOpUs=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gyLR63GZfz1xnZ; Sun, 12 Jul 2026 05:49:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyXqldtLdmyH/aas+EHr/gstXyoLCqjbmUsogfOchopClZka/O821ac7nO7NCkjTqjV8EY9FxGr1RdrBVRqkfJqU/mUi844bKY3l8XR074iCMFUoJFgCyCy3R7xCBaBc+LvLOFOgVxB/1wKB8fAjHrqgrEglOUcVuUL1I/3rIN8YuwGbAqAlyjhOaLQ/cs0jxX8L9IhFbVVEMmiAngCYJSvwian/JWC47XXasWs9puL7KIcGEajcRb0hd3Cd7TLddqbuzsZrmDKnne+g/hua4dj4b7T03CKWDI0Cl8bfrULNIZSp4DlicL0mnVeumndjcsyyfLpw3u9ctejSGDQZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlMoZCmQGFgfMufXJJxoggppbGIK3BqzHrqIjgMqDzI=;
 b=a9IkrbJME2v7XtPuApRuUFemW7aQTmuJVRAELQ8IvSbDuiFPp6nZx8UxEKM3pfctN0frQuw1j72ofFl9UQ8JpEtSKxyZElKv+ew5kxZQTO5MIiM5qrgPrNNasctIcj+bu7V8NQd24aMFpCNipCz27hVDz2+dqqIpdGE7fooSAXqoWZ9IFI7lRD/YhYDBQ/KCi8V12f+AcfDwDU+iAKNBbaa6qccuSJKYG2X75ua0ZnagL8f5ijJgW+5cwhtZFhYVGgGbUxrK8b0yOgKnJeOzI2mo/5jaK1GNWgR2Icpv0iKNKi89/k5O7fFUvGbTcMKnHp/o9HJO/23vQmGqfi3C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.95-cip27
Thread-Topic: [ANNOUNCE] Release v6.12.95-cip27
Thread-Index: Ad0RdrtvYJSVMfmSRk6EjRk5WWKh0A==
Date: Sat, 11 Jul 2026 20:49:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818354C14DE7889071C39BDCDFC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB11911:EE_
x-ms-office365-filtering-correlation-id: 24eeb36b-cee8-4472-3370-08dedf8de195
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|6133799003|38070700021;
x-microsoft-antispam-message-info: 
 xWGh3f6RtIatSl4H9CVZGak2mcEaHfZ0QxnC/iGzPTqhO3X12FVuK92dFD/ma0V+MfL+syERxmKRXgSnkSWEVbaZF5TvEd9gcvz+nV+137+BN/HP60BoZSB9QzouaQGp8kN9EW/A3peZdVTqCHQ+EixSsubYMmsJ3xmpx2CFC2/L2uN51DhJbuFjHclF5ZefTBf38NSwugEINp0BOK53IzXdCZWAv0fI6AvVEaCrOyv1IlfQ8zpclcI9md8KPkD7rABZ+pUR05tlNM+SfW5SMrsvDjOid9YKTfeBWBp6Vy4YuYp4Te3Mz1okKoIAwqpCkQh1yIUDcJOTX1lr2BQcIRo5IetfIjHmhb3uSB/46sJOUVH45MLkS+nGTx/UMdsyVA6sCOEnMo5gBr78V6+KwRwxt3FWg11/TYFgGBRqgMHqngWHgai/1JhPGBi+81/zLUMjPea2y8Xj9E+qCGPIC/tWs+n6zpwBgpb9XUn9viwa9pabzqGw+4/CCX7f4jddsrn6w4QgkITvjPc8SwYa/fKrNSFEdBuWrQ35ynt47QZ2t36jUtMmOFk53Ql8vSxcpmI1aiYGHNq17Lgh9uaBafcWxaAqzcYWg39uoNl+0kUWR7Jzhf5uUDzNC/azU7LtvKjSY8HYQarn4MMn+1b5V+/9+aWxzdKgfSSmKwyCBk8RURcdvJO84UpoP6YwXYJZKNg0IrVYjuGFqEmqEQiKWNVyRAWu2aHchSDTsB0bUTQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?b2ZRYzlKY3lOb1MxWU9mWTlwU3JpYXRqWFljdTlscTJsNk1qSjNQb0Zh?=
 =?iso-2022-jp?B?QU9ES2huTUJwT2FKaDNCSGgwVERVakRtb2pRZVFWTXBsdlZuSSt3UUpl?=
 =?iso-2022-jp?B?VjhZekVka29leUFVVW5wc3lacWJabW00bnF4WG9aV0piWnJkRzd1ek9C?=
 =?iso-2022-jp?B?eUxkckJ5dVRYM3dHZGpuOFhZMGFiQ0w2WGNMSnEyTmdtU0xuZEo4QlN3?=
 =?iso-2022-jp?B?bXIwb1FaRzdxaFFRRTlLakhObHE2c0FrYUw2MDBrVE5ZYUJZeWhHRzlr?=
 =?iso-2022-jp?B?WFhaNjJMZXlkUDd4cU1KVEprbmJNbEE0NmFQZXFabGZoNUlKaGZQRUx0?=
 =?iso-2022-jp?B?TWFxWmRTL1ZxSEcxbzlrZXc1WUJqQSszbzd4RTVPaWt5TVk2aW1wY3Fl?=
 =?iso-2022-jp?B?d1g2VlVkNVdETERFRnMrYXpLdDlWOXpCTDVtSzc0cHBoVTAyV0Zlb21H?=
 =?iso-2022-jp?B?Wm1KZWdlVFlHcVZDd0dqOXNwZVppTE5FMVluYkc3N1pPQ2d3eTE1UmU3?=
 =?iso-2022-jp?B?aGRJSDB3SHovcG0rNEJUcGpibmlBYm95WVd5TG1nYXB6VVZhNFlqemls?=
 =?iso-2022-jp?B?VERmc3h6VWFwQ05DNklqV3UrYkl5VjBvQmc3bjhEVU9qU2RCL1N6RWhj?=
 =?iso-2022-jp?B?blVVU1V5MlNnSFBuc29odTl6clR2clZWcnVTU1dPRWtCMEJkQmF6dTZ1?=
 =?iso-2022-jp?B?WjNHcVRMZ3FXcWRCK0hXSTBCZWNYU1ZjVm9XNFVhZVRUYnNGTnVlQm1r?=
 =?iso-2022-jp?B?UFpWSEtxWFh2ei9GSE0vRXVmd3UzNjZlV25DckVZQnJWb0NodUhXd0Qr?=
 =?iso-2022-jp?B?SGRBdTQ4UTl0anlVcnJ6aGRHZXFGZjU3aVBKNVIvU0ZXOTh6ZWNaME1P?=
 =?iso-2022-jp?B?UGNWZndCZWRsOG9LYjFpSGw3ZG5idnFUZnZKUWZsYWt6U3VOTHhMc2I2?=
 =?iso-2022-jp?B?bWc5akhGSm1rNUNpMmppaXhIRC91dVY2QTNLM0tlVUZRQmVDYVVGaDdM?=
 =?iso-2022-jp?B?TTRjUy9lNWttdSt4UVUwUmphWDBGaDlUbncyeXZ2SFB1Q1ovanVNTUNm?=
 =?iso-2022-jp?B?dFVCZGlscXlIQVVwZWVsR0dBKzFKWlp2cGUyb244a1J1bVRNc1dVYllG?=
 =?iso-2022-jp?B?bnhBN2ZYWS9EMjdtWVRDWUlERjE3TUZpVzhHcUN4WXRqdUpIRllteWdT?=
 =?iso-2022-jp?B?bTc4NFI3WlpHaEZTaXByMTdtbVlBR3JqYWZnRURhK2orZVV4cEpkTk5q?=
 =?iso-2022-jp?B?bEdXV3NJK3luZWFTbEc2NE1WWm9UOHVKRU5HQ3lweTlPVzRxQjVXVDRI?=
 =?iso-2022-jp?B?NG4zL0ZlVTZqSGFFUjFYbjI4bEN1VDEvR3FSb21LNW9HMllmOUx4RWlo?=
 =?iso-2022-jp?B?T0JBVlY0dTlvOFFNZGJ1ZWp5NDZlT0dQRUNOSDNqVmdLeE9IaFY2RmV6?=
 =?iso-2022-jp?B?eStmUDk1WFI2bERhTDhEMUlmczhjT211Q3JzUTdNZlFzQXZUUS9FaEQ2?=
 =?iso-2022-jp?B?NTZVVUlpM0MxeWgrUURFM0ZSVTdGSUErdEsyNWwxZ2UzS1cxc0NsWGZQ?=
 =?iso-2022-jp?B?V2Q5bmRxVlN6Z01QdDRTRFNxbkJYQUhVTU1rajNqY3Rvb3JkSlBGQnMz?=
 =?iso-2022-jp?B?VXhqZnBSeVlPRnZDRjZ3YWJvdTVyMnpsL1habjV0eGYvQ2ZaL3JOMXZX?=
 =?iso-2022-jp?B?R1ZOVDdTYTVlZkV2ZjNmQXpaMVVSbk1ISy9HSUZzcGdvMVFzMjcwRFFV?=
 =?iso-2022-jp?B?Rm1KOGM4Um9Yc25JYjdGUEhLTWRTaUVTbEJqNHRpdzRlcXdVUHd4UWtj?=
 =?iso-2022-jp?B?d21XWis3bDJsWFVZc09vWDBVSDFURndaZGZVTFowd1craCs1ODhMK2xE?=
 =?iso-2022-jp?B?WmlHSGxPcVZqUVBzV0tiNzI3UHN4bHpoNlBrU3ZpbUgzMWZXZVRKbFJ2?=
 =?iso-2022-jp?B?UVlLWmtuTDhOUGg3MFYwbXhZR2tDMkpUM21pUTBVWW11bnNKd2JWVURR?=
 =?iso-2022-jp?B?bU4rQUdZeTBiWStjeDJ6dlgwZ2lITG5zdStpemJwS1N1MGk5VUhFWklR?=
 =?iso-2022-jp?B?VFpOcW9rNEE5eklaeFBvNVIvL1NSYlhsWVQ5T21xdFV1U0Z5TXduNGRQ?=
 =?iso-2022-jp?B?eStjc2VaUXlUVTNCaWE5ZktCWFRjVXFtMlFkY2g1cWd1dDQ3akVDcU1k?=
 =?iso-2022-jp?B?T3dEdmpaZTdxNlh6eGFqYThFMEE2R0MzY011ZkVXQWtaNmtRQWpPSjFa?=
 =?iso-2022-jp?B?TkFSdXFpMEduSzVybjdHbmlHOE5kQndFUXlDQjJ4KzhkM1dSdjhPWFYy?=
 =?iso-2022-jp?B?d3MwV1UzbWQ2b0ZjTy9Xb1Q2SkhxdWJSSGNNT2tTTkR6eEZiaVBPbVl0?=
 =?iso-2022-jp?B?QWNnelIwd3VjMzdaZzlFNEorak5LT2pmKytNa2hLUWc0cmd2K1FZbXdF?=
 =?iso-2022-jp?B?dnZrYnhhNnlyTWlaNUhObXFyaE11THNLNXl6UUF1RTJBUm54Z3ByYXR2?=
 =?iso-2022-jp?B?ZTgxc3NWYkJrcGtaYVJhQXJObDZ6NDd0dElWSkdNWVRlUW5RckFxTjZG?=
 =?iso-2022-jp?B?bVk0ZExJcz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	fKx69+o2nqDaCvqb4zp+uugnq9tq4fnGBOZTzXI+R6jrcTPzm0t/UCK6UG+Zn/s/mEkOnpM0P6ETcZGQWk9pmBuCgS8t0fowGrngNZNmTXrD1XeNV95xTittaY0lpLgl0Y6NvlP8dcjBsGq4MhyBNKZvWrmRbI3MQxGJBtGLkGResYlQtqDJIL1eWIM/RxfcTlamN6aAEFb0H4QsM18HeINiYNlMR0+6itZ03HuYkMAmYaawIukZ6sATqDBrt/fXM124+nOC1KI+7Sgiwj+fOy6hkLng2rRjEj9AE274Nc5OtmAVMJLT3oM3RGHR7L3wKVaRzEljWdhap1FYhcEd8w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24eeb36b-cee8-4472-3370-08dedf8de195
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2026 20:49:20.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZ96xlth+cukKjcKcy6jtP8Ivzc8Yo+utfwVgN7fKXCI+Hva/rFy4PZrsgTewM52zSf4htsNY451z9SSSvp0kxCaE9dKusBSuRpwIzR7hC3ivROCh00b0H1PLgkbMvpS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11911
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 11 Jul 2026 20:49:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23559

Hi all,

CIP kernel team has released Linux kernel v6.12.95-cip27.
The linux-6.12.y-cip tree has been updated base version from v6.12.94 to v6=
.12.95.
In this release, peripheral drivers such as irqchip, pinctrl, clk, dt-bindi=
ngs, and
dts have been added to provide new support for Renesas=1B$B!G=1B(B RZ/G3L a=
nd RZ/V2N SoCs and
related boards (such as the SMARC EVK).


Information about this release is as follows:

  v6.12.95-cip27:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      86374cd567f1cf864cf654149961dd218ca7eee3
    fixed CVEs:
      CVE-2025-23131: dlm: prevent NPD when writing a positive value to eve=
nt_done
      CVE-2026-23052: ftrace: Do not over-allocate ftrace memory
      CVE-2026-31732: gpio: Fix resource leaks on errors in gpiochip_add_da=
ta_with_key()
      CVE-2026-43010: bpf: Reject sleepable kprobe_multi programs at attach=
 time
      CVE-2026-43216: net: Drop the lock in skb_may_tx_timestamp()
      CVE-2026-43355: iio: light: bh1780: fix PM runtime leak on error path
      CVE-2026-46054: selinux: fix overlayfs mmap() and mprotect() access c=
hecks
      CVE-2026-46242: eventpoll: fix ep_remove struct eventpoll / struct fi=
le UAF
      CVE-2026-46252: regulator: core: fix locking in regulator_resolve_sup=
ply() error path
      CVE-2026-52909: ip6_vti: set netns_immutable on the fallback device.
      CVE-2026-52975: bonding: 3ad: implement proper RCU rules for port->ag=
gregator
      CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()
      CVE-2026-53101: wifi: mt76: mt7921: fix potential deadlock in mt7921_=
roc_abort_sync
      CVE-2026-53139: drm/v3d: Skip CSD when it has zeroed workgroups
      CVE-2026-53142: drm/xe/display: fix oops in suspend/shutdown without =
display
      CVE-2026-53151: rxrpc: Fix the ACK parser to extract the SACK table f=
or parsing
      CVE-2026-53157: net: phonet: free phonet_device after RCU grace perio=
d
      CVE-2026-53163: locking/rtmutex: Skip remove_waiter() when waiter is =
not enqueued
      CVE-2026-53167: fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
      CVE-2026-53179: staging: rtl8723bs: fix buffer over-read in rtw_updat=
e_protection
      CVE-2026-53325: agp/amd64: Fix broken error propagation in agp_amd64_=
probe()
      CVE-2026-53326: debugobjects: Don't call fill_pool() in early boot ha=
rdirq context
      CVE-2026-53327: debugobjects: Do not fill_pool() if pi_blocked_on
      CVE-2026-53341: fhandle: fix UAF due to unlocked ->mnt_ns read in may=
_decode_fh()
      CVE-2026-53359: KVM: x86: Fix shadow paging use-after-free due to une=
xpected role
      CVE-2026-53361: af_unix: Set gc_in_progress to true in unix_gc().
      CVE-2026-53362: ipv6: account for fraggap on the paged allocation pat=
h
    added commits:
      CIP: Bump version suffix to -cip27 after merge from stable
      irqchip/renesas-rzg2l: Add NMI support
      irqchip/renesas-rzg2l: Clear the shared interrupt bit in rzg2l_irqc_f=
ree()
      irqchip/renesas-rzg2l: Replace raw_spin_{lock,unlock} with guard() in=
 rzg2l_irq_set_type()
      irqchip/renesas-rzg2l: Add shared interrupt support
      irqchip/renesas-rzg2l: Add RZ/G3L support
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3=
L SoC
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Use pattern fo=
r interrupt-names
      irqchip/renesas-rzg2l: Drop IRQC_IRQ_COUNT macro
      irqchip/renesas-rzg2l: Drop IRQC_TINT_START macro
      irqchip/renesas-rzg2l: Drop IRQC_NUM_IRQ macro
      irqchip/renesas-rzg2l: Dynamically allocate fwspec array
      irqchip/renesas-rzg2l: Split rzfive_irqc_{mask,unmask} into separate =
IRQ and TINT handlers
      irqchip/renesas-rzg2l: Split rzfive_tint_irq_endisable() into separat=
e IRQ and TINT helpers
      irqchip/renesas-rzg2l: Replace rzg2l_irqc_irq_{enable,disable} with T=
INT-specific handlers
      irqchip/renesas-rzg2l: Split set_type handler into separate IRQ and T=
INT functions
      irqchip/renesas-rzg2l: Split EOI handler into separate IRQ and TINT f=
unctions
      irqchip/renesas-rzg2l: Replace single irq_chip with per-region irq_ch=
ip instances
      irqchip/renesas-rzg2l: Drop redundant IRQC_TINT_START check in rzg2l_=
irqc_alloc()
      irqchip/renesas-rzg2l: Fix error path in rzg2l_irqc_common_probe()
      irqchip/renesas-rzg2l: Remove dev_err_probe() if error is -ENOMEM
      irqchip/renesas-rzg2l: Simplify checks in rzg2l_irqc_common_init()
      irqchip/renesas-rzg2l: Switch to using dev_err_probe()
      irqchip/renesas-rzg2l: Remove pm_put label
      irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()
      irqchip/renesas-rzg2l: Use devm_reset_control_get_exclusive_deasserte=
d()
      irqchip/renesas-rzg2l: Use local dev pointer in rzg2l_irqc_common_ini=
t()
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable PCIe
      arm64: dts: renesas: r9a09g056: Add PCIe node
      dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support
      clk: renesas: r9a09g056: Add PCIe clocks and reset
      pinctrl: renesas: rzt2h: Skip PFC mode configuration if already set
      pinctrl: renesas: rzt2h: Remove unused variable in rzt2h_pinctrl_regi=
ster()
      pinctrl: renesas: rzt2h: Add pin configuration support
      dt-bindings: pinctrl: renesas,r9a09g077: Document pin configuration p=
roperties
      pinctrl: renesas: rzt2h: Fix invalid wait context
      pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register(=
)
      pinctrl: renesas: rzt2h: Add GPIO IRQ chip to handle interrupts
      pinctrl: renesas: rzt2h: Allow .get_direction() for IRQ function GPIO=
s
      pinctrl: renesas: rzt2h: Move GPIO enable/disable into separate funct=
ion
      pinctrl: renesas: Remove unneeded semicolons
      arm64: dts: renesas: r9a08g046: Add OPP table
      arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH0) interface
      arm64: dts: renesas: r9a08g046: Add GBETH nodes
      arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK boa=
rd
      arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
      arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
      arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
      clk: renesas: rzg2l: Refactor rzg3l_cpg_pll_clk_endisable()
      clk: renesas: rzg2l: Consolidate DEF_MUX() and DEF_MUX_FLAGS()
      clk: renesas: r9a08g046: Add IA55_PCLK to critical module clocks
      clk: renesas: r9a08g046: Add I2C clocks and resets
      clk: renesas: r9a08g046: Add SCIF{1..5} clocks and resets
      clk: renesas: r9a08g046: Add WDT clocks and reset
      clk: renesas: r9a08g046: Add CA55 core clocks
      clk: renesas: r9a08g046: Add GPIO clocks/resets
      clk: renesas: r9a08g046: Add GBETH clocks and resets
      clk: renesas: r8a08g046: Add support for PLL6
      clk: renesas: rzg2l: Add support for enabling PLLs
      clk: renesas: rzg2l: Drop always-false check in rzg3s_cpg_pll_clk_rec=
alc_rate()
      clk: renesas: Add support for RZ/G3L SoC
      dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3L SoC
      clk: renesas: rzg2l: Re-enable critical module clocks during resume
      clk: renesas: rzg2l: Add rzg2l_mod_clock_init_mstop_helper()
      clk: renesas: rzg2l: Add helper for mod clock enable/disable
      clk: renesas: rzg2l: Add support for critical resets
      clk: renesas: rzg2l: Deassert reset on assert timeout
      clk: renesas: rzg2l: Re-assert reset on deassert timeout
      clk: renesas: rzg2l: Simplify rzg2l_cpg_assert() and rzg2l_cpg_deasse=
rt()
      clk: renesas: rzg2l: Rename mstp_clock to mod_clock
      clk: renesas: rzg2l: Remove unneeded nullify checks
      soc: renesas: rz-sysc: Add SoC identification for RZ/G3L SoC
      dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3L SoC
      dt-bindings: soc: renesas: Document RZ/G3L SoC variants, SMARC SoM an=
d Carrier-II EVK
      net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
      net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
      net: stmmac: platform: Group GMAC4 compatible check
      dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L RMII{t=
x,rx} clocks
      dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
      dt-bindings: serial: renesas,scif: Document RZ/G3L SoC

Best regards,
  Nobuhiro


