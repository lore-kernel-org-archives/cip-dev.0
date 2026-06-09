Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC66CD8CAE
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 05:21:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.72847.1780982468636243444
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 22:21:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=n/EyHEjk;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1780982454;x=1782192054;bh=
	he2Ma58M1I9KUN0WR4CwD8UBc4GV7S6QHE14tMSHT8w=;b=n/EyHEjk3jSX4bHOUdRvGBaedRpJ/v
	GwZtC5Qwnlc2oBiSqeOeqCSuW4ZxVE1Ppvop8ICnhWIK3SLJS8uWlW7ZQRC9Jx0p3+acwRcSLfEQ4
	IezJiBHU/W9Z6RYJHePWMj/XHf9HO8IsUKQjjZPE6vFkKRngcQKxkIJ3LMHqHZM/RWuVjA3rUWCmi
	/L7tfbQ9Sm1Po4WgEeS81fiH85bq5v6CSp61EWUwZvyG7ragWxwm3nNnZYD5TuM0xizvdv5muLtgH
	gM1M83NTj5nSJAyumxnJv6Ta+tLJPcrmLl6S6MsFYMAKCjmRpqLHSRY2AqYpbA8BO692zaxjuXGkK
	mZAg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6595KrXc2239651; Tue, 9 Jun 2026 14:20:54 +0900
X-Iguazu-Qid: 2rWhY8Fxo6eAC0Hquh
X-Iguazu-QSIG: v=2; s=0; t=1780982453; q=2rWhY8Fxo6eAC0Hquh; m=ZgQFDeUyAGN8MGxybEY3nKTimzuctbPEpP5VmbUpSgY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gZHLX2s6Fz1xnf; Tue,  9 Jun 2026 14:20:52 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3GBdqUgC6v5jkB340uv273GP0HvKw/caUuLZihixu7zTLKdoFJRyb6a+ZQeFWtjmT0kRJTiNjwQ3tJJpk3wzvnBQiBj1qW/KQY375UI/bOwrOHSyZO8kDw/4Xx0Bc02mUzPd2JsKnP9gOAh1pR12HVXFkFr7PSQDpMxDN6cSJszjNEcuI0j9WcmBXBVqlxfdbY2tSpBfDbUSwxmu/ICBDf4rsRl9oYp/Rn3sq5XjoiGxPIwzelVmRIcgjvmiEEOovwSG/Wa28GFlpMCWrJ2ciENauFm5rIMwHJicVtNIXEz5s0+t0SIY/I7BvysvyGfFrjIyYFFaF0M1/6kqwkVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ouIahPNds1xI5iu2QHfaLkhjIeGHuHY7q+vCKocBAY=;
 b=OZc51qfuxa/f5gEaP8sY6N1RClBjIPf/U1pWhT2QYm4sDIHx3PYIEb2UHQz7atHdbPgBo/oWYMBbKmGBhVE8QFk1H6EqSeGe3dOOBPU4wm7mGCunVpQdbVPf1VNHbUkAPXTg1IS9c5xTLOU0T0X+zKK3Gsxzn0RgsG1vnnPQsBKvQo5gRqMcAqMi40Hs+wFFRw6MYz/JSitgmeo6xtWls8xoUU2Bx0nF6nZzxYdgBiIcvRW7NUCG7VUJKAYqxRAYP87FOFpF/2e0qSHsbagoDePkVTVFKlkemHd+UO0zqh5MU0IkrrT7iHurXsc31XHY1zY2E4IIytOmpFCN8ctmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.92-cip25
Thread-Topic: [ANNOUNCE] Release v6.12.92-cip25
Thread-Index: Adz3zNbhpW4X8s2PSM2R4hJSlpUWJQ==
Date: Tue, 9 Jun 2026 05:20:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481807A648BDB0A52308A190CD1D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB7332:EE_
x-ms-office365-filtering-correlation-id: 3d40bab5-ae1d-4494-540f-08dec5e6dd8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|6133799003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 3quFM/PuKenoWceQXB+xUZSWTVQ8NULmBgzVfOhQPUDT+aqEUlw56f+Sa0OrhKHpNXMBDwej79BYdPSFUQOoSKxINqeDSA/PJPtaU1eBs3pZFZWuFAGsawlwBwGnVxAhsQGwuQ/d5v8XEEQSj1vJ+M5mNrC6u94B46DWyoo0mkMVp1AI9at6uXAJ/MRoi3+dwAnWdFI6LCQlbtOhVMymdLAd82v2yRuApZkOJL7G/jCC2ochRJHm7vUu81OGCtWv2okEXozqo1PUgYyGNI/q1QMmdv8kikWhNn5ymR8OMw/rKOpvS8g+sRjN5rZE1RD/PXV9WKJsIxirHXEkfkWrW2yDesK6zwBZUcTQieN76m96uiZ3bvudMSsq7gauXJ9sPCXPcomBb5QaRudCjCBo4hS3LX1PH0+EK5F7oYcEPMO6+L1+r88hvTPGmbkNXz1WKGXbgYTyUVvOCY4C8nC6LYA2BhL0p2V5itGgXv8jbG+fqTUYNr/oemiUq5yIeXxjxwRmfZwznknYlMlA1u/SXinABztSHUXONf0X4r3AodWKmdWqmrlPd3CNcwxUrHEH0/4VAGCHN1G5fUihVcJqQfOWPRo+PDXPf7nQgR98ownQ8cei0nFrzNsQdYV48tp5f/aWJnbg8ExFgQbwAXsTd6lfAgd/50ikYoXy0YRAnlci+F2XDbFQmRYVTqYn1FO1HKy0OOmfkhhrCP+3hoo9B+ko6hKQntZiWsfM0PZl3/ovHHuApmRHzMjX/QEFqn/5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VnV5cWdJSHBXWHYwelQ0Q1VzMnRHeDZkQmF2MnBkNkhRQmNKSjhTQUdQ?=
 =?iso-2022-jp?B?N3RNUURpajIxeXFkOVpEbVZmTUNMd3NwNHdvckIvaEJKNVlDYUtpeS96?=
 =?iso-2022-jp?B?SUk2UHBqOHZFamgydHFkbExGSWcrYU9ZMTJ4VHYzTHZjK0tkM3JSWUZw?=
 =?iso-2022-jp?B?RmkvVGh3UUJaSzRYMEtsZ0lHOTdsdnN0OHpQTU1NRC90MWpzdFpZSHdY?=
 =?iso-2022-jp?B?ZVVTcFJhaFJqYUxLNy9rS0dVT1FVVEk5bDBuUU5qY0Z5RjlhZE5NRUF2?=
 =?iso-2022-jp?B?MW5IL0hnTDA0R21rSVJXRnlFa0JmSmVPcHBxdElPVUNNTFpOQ2VQZ2pr?=
 =?iso-2022-jp?B?T0VOSDVxWmlVK2FXMVVtYlQrbXNQZXR3MlBDckNUd3BNWGk3ZTBaQWp1?=
 =?iso-2022-jp?B?NmVyYjNHYWdsTW9xWk01aHhUVi9WYWQ2TmswbFlwMkdWMitjWWVBVUVH?=
 =?iso-2022-jp?B?QVZZOEtuaHBNb0ZGSGxHamcvUStzbzVTcVVPY05qS2V5d1FVc3V1QUQ2?=
 =?iso-2022-jp?B?RjlxVmFrUHhmVXJnYWlzZDV1djVRdDFxYkxoM2dGT3c0UUQ1aUFyQ2dX?=
 =?iso-2022-jp?B?UXdRQnN1dGlJMjV2cTRsZjB3TGd4MS93aWxUVlhxYnhMaE5jdDQrSVY1?=
 =?iso-2022-jp?B?dnZZWEFBV0pybmdHT3o3M0NCTTBOTjZGc3VhOGFYRVhzR0tweUo3VTV2?=
 =?iso-2022-jp?B?UTduSGh4cWwzQXRLUHkxM2RObmZmOTgxRlFyT1BjY21jcmFXbkdTdWRs?=
 =?iso-2022-jp?B?UHRERXpSVG9RdjZPaUZVc0JBcFhqUXlueWhrM3d1a3Z3UklmVzdIcXht?=
 =?iso-2022-jp?B?TzRxZGVVeElMWVg5TldwOXlwbzRQVktMb05qUVhvS0ZLMWFBYUhwM1Rn?=
 =?iso-2022-jp?B?K0xjYmxhcE1RNVBnSDVNMU1HRTFVSnhyb0VaQnJUV01HN2JRZURNZ3VR?=
 =?iso-2022-jp?B?RkZwYnJwS3RuVlBYcExxNGdwMmp6d2dvU0xwR29rd29Zc295eXUraXZE?=
 =?iso-2022-jp?B?d2RqS2l6TGc5MXhvejA4M1gvNnJydEYvaDY2TWZ0R0dmWDUzSVVuY3hB?=
 =?iso-2022-jp?B?WnRsQ0x5by90aFFyNllaMUVwUmdOYzhXbW5LYS9zeThZb1ltZUhoUlpv?=
 =?iso-2022-jp?B?ZGpRYmZnWXIxckZ0N1Y1OFBkUHQ4L3l5ajRaRHAxbWZWZzVhekdxQnZS?=
 =?iso-2022-jp?B?ZVcvVktqeWNvTElaOW1pNkNYVkZQdzhRNmVMZ0QzNkw0WkFFUXNZVWUv?=
 =?iso-2022-jp?B?RytZcVZoY2F2YVZTWkt1akx6UTUzdnlWNjl5ellZSHdKTHVDL1BSd2gz?=
 =?iso-2022-jp?B?UDQvT2dTcmFZZUNhUUdLM05zOE44NkNXakcydEJJQ2FsOTFnQlRPS0I5?=
 =?iso-2022-jp?B?cG44SCtqQWVSbFBwQWQyc1cvTEI5bmcxRnVLU2NXeWhVcC9iOHRCODdW?=
 =?iso-2022-jp?B?U3phMHptSEQ0L1h5UlRqVmsydHM1SGxCK1UrTU1wR0FlYzNQK01KS0w4?=
 =?iso-2022-jp?B?QkVVNGtwTW41cFozUUtiR3hiSVpDZFRiSzF5WmdBN3JWdDk4RytOblRz?=
 =?iso-2022-jp?B?ZG5ZQ1cxK1Rpc2dJeWRaSE9RSXZGeTV4TXJCNDR0MHAySSt6ZWU5V3dy?=
 =?iso-2022-jp?B?NGprNXRicURBUkRGTjRqRnF5bjk0QlAvU0IyVHJqNFY5L1V1VnpUd3RQ?=
 =?iso-2022-jp?B?S21IZUNuL2dFbU9sQjU4MGp1L05aY0Z3emlIWE1nYVNHWm1FYmw4WkY4?=
 =?iso-2022-jp?B?ZUY1UityU3hjK0lOSEF6RzNUNm5sOHJFTzhSZGRqRXNpNnkvSGFNYm55?=
 =?iso-2022-jp?B?VW9jT2ZMbWNOY2xsQlQwbnNsV21aZjIvR0VlRjRhVnFvbG95L0dmMTM2?=
 =?iso-2022-jp?B?U2pqZ3pra1ZSU1BhdkJvUnBqbnhIRGdiNFpTK2E0WDZZMWxja25IT2JZ?=
 =?iso-2022-jp?B?dlNrQmlkT0VBcW1vRUFUUGp4cmVpaTBvWGpwdHpkcmJjOXNqNHo5TDZs?=
 =?iso-2022-jp?B?WklUZHFCQnZUS3FtU0g4MGh6SDFYUHNxT3pneWFXY3YxMkhFMWdoSWwx?=
 =?iso-2022-jp?B?OHM1NDI5cm5zZzBJYUp0QUtVZmsyY1l6UHBCdThwN21UekpTejh1K1JL?=
 =?iso-2022-jp?B?aHVYdHhkaktsUlhsWCt4SnNPWGo4TzJ5OWw5OHp3bUUxTTVubGViQ2tp?=
 =?iso-2022-jp?B?bkIvQmlIUWYzOCtSWEFCQ3BtQW95dk9zTnRtaVV6NFcyaTJNY05lRVY0?=
 =?iso-2022-jp?B?Y05MQ3lRdzNicGo4aE1HeHVpOW5FbXJad2RCcWZWaUNCN0U5NnZ0NUty?=
 =?iso-2022-jp?B?QWlyNjZBanlGWnVrNzZSVjBROGlLVFFUTC8wbVBZS09mdWI0L0R6Tlc1?=
 =?iso-2022-jp?B?ZXpUbUtEUVM5Z29WOTVqQU1XUmpVSHNmNEhLQy9tQ0JvVTFIY2kzZldn?=
 =?iso-2022-jp?B?RWhHYUhvNmlkaEtSR2NsSGg4eW9BNG4wR3ZKSkh3WDJ1TnVyL3psOU1S?=
 =?iso-2022-jp?B?TkZEMml4UzJ6VXovcytobVcvUXZyZjJpUGYxUEhsOXp1TDhLUXRPcVgy?=
 =?iso-2022-jp?B?NDFJaXRXbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	FfTcuLwbK7bxW26Zs/KvJ41ovdhAywTjn7VMsIwGC3p/FJ6ujf1VjNITz/UmyehRxVS/Uyf9LUNdtN9qdukt1NbF5IfcGIam2rmY9eaiggzmrPZsIGqhmaY8lv/54mIgjHtJVigqtoFW362u8a0qn7QmSvFQG2xIhVZtEgJm1UfQe30g2+6sMD5/2yPBycw/Xz/rQcp+nyi8EqyvbJsWlQB1ixxOX5MM3b9GQgd5Xt8YX5P9+YMCMZ6JCAusTNarIkc7Jtykiy2j45EZabOtefDZzahwHjWMRHvKUW5DDcAGkAYlnfmUc9M+RYxNFyAvy9mJuVB/mVX4W5WRou1RuA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d40bab5-ae1d-4494-540f-08dec5e6dd8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 05:20:48.3039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yjpubRAJIvFB5siPVsyMYdOfFaBcmWGulzkM2w+jFOUEVbsZw0raDsjU4Q8FmgIdDPgkC3NIKEWnQQVc2V15c2bjlydc84jAoHk+aXLh3hi6xsQi8Re331DPvWcIohE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jun 2026 05:21:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23052

Hi all,

CIP kernel team has released Linux kernel v6.12.92-cip25.
The linux-6.12.y-cip tree has been updated base version from v6.12.90 to v6=
.12.92.
This update includes a commit that fixes build error caused by field_prep()=
.

Information about this release is as follows:

  v6.12.92-cip25:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      d43ccea178aeee0ab91f6e050ffb04eacac67b41
    fixed CVEs:
      CVE-2025-68251: erofs: avoid infinite loops due to corrupted subpage =
compact indexes
      CVE-2026-23272: netfilter: nf_tables: unconditionally bump set->nelem=
s before insertion
      CVE-2026-31613: smb: client: fix OOB reads parsing symlink error resp=
onse
      CVE-2026-43245: ntfs: ->d_compare() must not block
      CVE-2026-43494: net/rds: reset op_nents when zerocopy page pin fails
      CVE-2026-43503: net: skbuff: propagate shared-frag marker through fra=
g-transfer helpers
      CVE-2026-45838: bpf: fix end-of-list detection in cgroup_storage_get_=
next_key()
      CVE-2026-45839: bpf: reject negative CO-RE accessor indices in bpf_co=
re_parse_spec()
      CVE-2026-45840: openvswitch: cap upcall PID array size and pre-size v=
port replies
      CVE-2026-45841: netfilter: nfnetlink_osf: fix divide-by-zero in OSF_W=
SS_MODULO
      CVE-2026-45842: slip: reject VJ receive packets on instances with no =
rstate array
      CVE-2026-45843: slip: bound decode() reads against the compressed pac=
ket length
      CVE-2026-45844: netfilter: arp_tables: fix IEEE1394 ARP payload parsi=
ng
      CVE-2026-45845: net/sched: taprio: fix NULL pointer dereference in cl=
ass dump
      CVE-2026-45846: bareudp: fix NULL pointer dereference in bareudp_fill=
_metadata_dst()
      CVE-2026-46117: RDMA/mana: Remove user triggerable WARN_ON() in mana_=
ib_create_qp_rss()
      CVE-2026-46137: mptcp: pm: ADD_ADDR rtx: fix potential data-race
      CVE-2026-46160: btrfs: fix missing last_unlink_trans update when remo=
ving a directory
      CVE-2026-46274: io-wq: check that the predecessor is hashed in io_wq_=
remove_pending()
      CVE-2026-46300: Fragnesia: the Dirty Frag vulnerability class
      CVE-2026-46314: drm/v3d: Reject empty multisync extension to prevent =
infinite loop
      CVE-2025-22069: riscv: fgraph: Fix stack layout to match __arch_ftrac=
e_regs argument of ftrace_return_to_handler
      CVE-2025-40163: sched/deadline: Stop dl_server before CPU goes offlin=
e
      CVE-2025-71289: fs/ntfs3: handle attr_set_size() errors when truncati=
ng files
      CVE-2026-23394: af_unix: Give up GC if MSG_PEEK intervened.
      CVE-2026-23469: drm/imagination: Synchronize interrupts before suspen=
ding the GPU
      CVE-2026-31420: bridge: mrp: reject zero test interval to avoid OOM p=
anic
      CVE-2026-31486: hwmon: (pmbus/core) Protect regulator operations with=
 mutex
      CVE-2026-31560: spi: spi-dw-dma: fix print error log when wait finish=
 transaction
      CVE-2026-31717: ksmbd: validate owner of durable handle on reconnect
      CVE-2026-46158: mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      CVE-2026-46170: mptcp: pm: ADD_ADDR rtx: free sk if last
      CVE-2026-46216: drm/xe/hdcp: Add NULL check for media_gt in intel_hdc=
p_gsc_check_status()
      CVE-2026-46243: smb: client: reject userspace cifs.spnego description=
s
      CVE-2026-46244: netfilter: nft_inner: Fix IPv6 inner_thoff desync
      CVE-2026-46275: Bluetooth: hci_uart: fix UAFs and race conditions in =
close and init paths
    added commits:
      CIP: Bump version suffix to -cip25 after merge from stable
      PCI: rzg3s-host: Revert generic field helpers, use a local field_prep=
()

Best regards,
  Nobuhiro


