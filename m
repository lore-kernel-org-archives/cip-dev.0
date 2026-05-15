Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276BBCD4851
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 23:08:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46523.1778886508863080290
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 May 2026 16:08:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Ck7rqRx3;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1778886491;x=1780096091;bh=
	D6LYFaR3Au4bJkRecdlIyGzE/TyPnjM6trgkRTfLwsY=;b=Ck7rqRx3VSt7C902QpTqgstdm6iXzL
	3nttrFeajaTJXl3v8/CIlWBDtqy3w89r8DbBaS+OivOQNm4WtcckhQYRf3OMtxWISXcmf9mXA3vIa
	xlEvGv6Wi6iP6npYJKUV8kvWTKibbc3LaM+Um5Ept27xHmGHj4yFLToI7u51Gw8PCyCKCvhPSvz0C
	xwsybxawSe5CL4WutHKw41iIjJkkheApjKnBs6apt638XLfm/Q4m+zINRVUcwO9QABx7O61w5YTlv
	8w8AlhPbqadiPGi1NnPSW/FV0kCOepU4cL18HfiByaO8LFC8e0izbYh4ZKcKV5snUU/uHb+5B19qH
	ZeVQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 64FN890S3338463; Sat, 16 May 2026 08:08:09 +0900
X-Iguazu-Qid: 2rWgT28L2BWCpz4i00
X-Iguazu-QSIG: v=2; s=0; t=1778886489; q=2rWgT28L2BWCpz4i00; m=JgfnXUfowQYsX+YNq8jflHqiEIpI5b4EhvKdHSPplhc=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gHNCX0y3mz4vym; Sat, 16 May 2026 08:08:08 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HORJ3Ye/YHK5+BYvGbaQxXcN6zB2Tz0nUPglF6FTMlaI8oRBy1nfZCLDmInGekpMhpTXCEtBsG28jQH3pravfrQxbKMrnhoji+1KIiJQVj9vXfY0ajB3TJphQ8VMhaVyrxEX6zT3K7+pZ1k3IfQRp0T2q5KybVahGRFD6A/zS0StKo5vw2QjQNz8VS4aLfIHcLfa6MfGuk3YZtNZJJ7Hoto6/RwEG3HeRC7m6jr+nc3cOqMldVoyYnae/eWxbX0XNUbRlCFtirWeIFiwzop4O6/bfQi6VB3ycKdqa3Ss1QnIKS9xSMgLwcNoKmXRiSEKw6BsZDjkBfejs97TxKBDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u2ql/seT64QOLIt75xuM1jOdAKO7ro66YVnabE8Llg=;
 b=NzXwbug9oNxGyZJFAsV+zYUhW4oXJBBhlQuVzkHGRKGszaNqhEBkMRAAU1HEJtoCMxYmo53ziVXLVVV/3T6auSMb2PEviqQCcj0gTrsh07xnLCmHASjHIV0Vnyfh0uTquMh728FI2R/bMFvACQg0Bf3hTw/8x5xoIiurF9rLe65xJ9j71R+979jNSHsUfApjs2SVuXbo41BG0nhMJBPaDffGizsuTxDY24LojMLskAlv+2Qi7QkWYoskaeFRqqOWPZLHRlo3r2Xd6dPcMu//w1JX04ao/PokGFADGvvNsKIeJJNTbvF9K+Y0NuF8Xhy48Nkx2fToSazddBEkBrOA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>, <pavel@nabladev.com>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.88-cip23
Thread-Topic: [ANNOUNCE] Release v6.12.88-cip23
Thread-Index: Adzkv3DVK6lfdwBXRjiDfKWed5EJeQ==
Date: Fri, 15 May 2026 23:08:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183AF140FE3CDCF3C4392ACD042@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB17551:EE_
x-ms-office365-filtering-correlation-id: 6f600ec4-e797-4d13-d583-08deb2d6d229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info: 
 t640Vk4Z7FpzJnkgXxjExQa3DQD4WB+lJtZ4+uM7tmm7tsEV4cOZ2Boa/o9hLntsibJTX72FZrkSY+q0+rcLhUGppFdQ427FqncxFh3N5/4E9Yia9ui02EpYWMckeE4ToBtVtViNKsQfpnbagMEc2eNapl7xapZ1yTO1tu1YFrm0S/v5WWnuz5J41QD78V1K977lRZBkO/ZCgFmPShe+lQfC24dH5UIvC428Hdlxzic/l5BF6ho4G+LAwxWykdQXFueEOEXbY7lq9mvXsb1JxI172uWjwgEIUIp7JRsqklNXiJZ2NDd523m1rcobfhh3fkqB1tMYnxQlCl4E4VM3OXjFFPonNMNcaNxCcIqpYr4oPvNZjcWYI4Oj3EUkEN2s1pZzkyJqvKG3IPu8v0JZlaj4ZdelQZEJz/lqlaOqH+eilnaJvXTI7uwTELGsN2wPtuYOXMIMKUamjJt9YXkwXn/8xl2oYvtEU4grapL0BHG9M+fgEY6iygbL4joFiHC4Siq6FNkDSUpJgOLDBkE69OaopkqQeqKjSkAEmzkQZhqFPdML8HRQ+Gu4docKkxo6DCLzBzhoGxf+/ilMAngm31eW0wodm6fxLjlDLdlJ3Qj6IN0qXEdpcAOSTBBEiaxW/1o1lqSSyEi/sWlRBmaszOA18bD5qYLZThlvxJZ6Gx2Z2wtbnyb8BYgO9yMG6mrd4vXghLaajnPANHo//z3MvznjY+rM5QnKqx7Pd8QV9FnF+Yx3HKUEcgE+UncS9vPC
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z2J6NklaYkFLeVZOQ3lCNDRqekJ4VERIZm85eFZocFNKamRtSUgzMldt?=
 =?iso-2022-jp?B?TTd4S3dNdmx4Mk5nVEFydVdWaXhzcUpVcDFjMXdoM0dVUnpRaUJneGxz?=
 =?iso-2022-jp?B?Njh3RE10YTluaUszYzhHdVc4NTFWL0NlUmZXUzNGNG9BVEVXdEhaWTRD?=
 =?iso-2022-jp?B?Z2JFUm9vTDIwVHEwL0NtaEg3eFk2MmdOREMwbC9nd1VKMlpwTnNaU2dp?=
 =?iso-2022-jp?B?V0tWazV6dnh5UytKY3UwK3hGTUg3eG95bjVaOHpESjBGZjI2K05IMStF?=
 =?iso-2022-jp?B?Uml1cFVhTHppdUFCYVFiYlZMZXJ4bHIwTkpDR1FiSXBOenp1WlE3K1pq?=
 =?iso-2022-jp?B?S1VLQ1BSUlNBK2tLSWRDK2xEZjVSVmFDWnF1OFZHUVVUY1EzT0YxNUZw?=
 =?iso-2022-jp?B?QjV4MEIyRVB2Wm9GeGR2TWlNUVZBdHlLWmU2V2FyYW4zOEx6UGNnUks2?=
 =?iso-2022-jp?B?OWxZUHkvVTdCTXcrbS9xWnpVWmZYQjZwSjJReDdaNUl2NytMRjlYbnZZ?=
 =?iso-2022-jp?B?Y2hqcWMzUDFHZmttcmhvejRXUXRmWFhNS2w5emgya1o0VDBzamtwSXNo?=
 =?iso-2022-jp?B?UmZBSkgxMVNqakRTeUdmQzB1S2pZbUhidjBnS3dtMGl2UEpuQURPWmt3?=
 =?iso-2022-jp?B?UG56Z3JMSGJMWlhuOEk3OHIzdGFiZllWK0JuMCtKdVE1QlQ1RXY4UVpX?=
 =?iso-2022-jp?B?ZXV3Wm1BejluRVZHQXllMk0rMFQxMkVSRDdjU05uRDE3aEk2YnFHamd4?=
 =?iso-2022-jp?B?MGI3TldnaDJlUlMwT0dmM0thWTBCMXJ6Sm5LQThLN2xoNnBXZGR2YVJR?=
 =?iso-2022-jp?B?d3hrbGxmMGNoUVdrM052WXFkSjk2R0ZETm5IWXpoVitaUzdXaFJuS1JF?=
 =?iso-2022-jp?B?Tmg4WWVQT2UwdWZUN2hLQ0NVVWJnZlpaSVg4OXpsbmRyMU1MeTJaK0RO?=
 =?iso-2022-jp?B?T3cwTFl2ZGxLU2syS3JNdHhJaGxiZ3lxcDU3MjFYditaajdZVk1LT1VO?=
 =?iso-2022-jp?B?bE43N3NFcEwvYWVDTE92bWg1b3c4d3dWTUt1ZnJYNURCZlNpRmhjR2dl?=
 =?iso-2022-jp?B?VmtFVGt6c0xqTVdKZzFocklGYVl0N3cvNEtTN0V1MlprYjlodFVPWGZm?=
 =?iso-2022-jp?B?cVk4cmVDRW5UcU43N3o0eDBmZmMxLzdPRzVNdnRSMk1ueFlORlRKWndk?=
 =?iso-2022-jp?B?T045a1RGUkQ1aVhOZmROSGVIeGpDSTFoTUd5UktHdVY4NVVWZHFGOUdJ?=
 =?iso-2022-jp?B?eDBRMkN4aHBrTE4zd3RCMkV5bm5vaWRPd1ZDU0pkTUZCNks5VSsrREJU?=
 =?iso-2022-jp?B?QnZyUFJZNGhaRDY5MWZIUmJFczJSemdFN0puK3JVdG5PVkFuTmk1TjBU?=
 =?iso-2022-jp?B?NTNWUk9EaHhSMi9rR2N1YytwK1VwRmpkWjR5RVBPdVcrQmVXUzJheDdX?=
 =?iso-2022-jp?B?a1JubkpBUW1QVFZtM3VXOURoWFZZZzNBMkZSWWMvV2RvaU5EZU5mQXEr?=
 =?iso-2022-jp?B?bnBKa3hIT3pYNGlKNzd5MVVkbU42bTRmdy9mU1MxL0RCdEh0aXh0Y2hw?=
 =?iso-2022-jp?B?UGE0QnRmTnB6QWNaL0x6Nmh6SEhXTjRHR2MyVkM3SDVTcGk2RkEyUXNE?=
 =?iso-2022-jp?B?OUVoSEJhSG84c0dMSzk3TDI4aE9MK1YzYVowbEJzcW9sQ1lhVysyWlNS?=
 =?iso-2022-jp?B?d1MvOE1jTXpINTk3aGNORmx3L3pjNytEWTZXdHM2K0VPdG94Vm1GZE1K?=
 =?iso-2022-jp?B?czNhZ043WWlxS2ZmV25zcmMySHV5V0ZlSUs4Z21XLzhSL0VUV1YrSm0w?=
 =?iso-2022-jp?B?cFRNYjdFYWZkVVhxNXlsbHdJSHVFQ2VmVjdZcmwrS01kZ1pRVllqeXQ2?=
 =?iso-2022-jp?B?MEpPdlBTQ1RmUm5Qdk10TmVzUE95TXhtS2czc0dzRTVSSmdtMmZEMU80?=
 =?iso-2022-jp?B?bm5LSjVZUUdvV1BkaXpXSzFBNHp1UDlacEw1bVMyZHlUcFhLODloSTZi?=
 =?iso-2022-jp?B?YU1RRkphN29xRTNRdmlVV3ZuR3MrNTBjZjlaWTlKZ1RuaUlGdzRvNzV2?=
 =?iso-2022-jp?B?YW1nMXp3UHBlL3NIZ01CTmorcHhsT0VYYkhacUJhVCtveXNHVlI0WUpk?=
 =?iso-2022-jp?B?aXNZT3lXQ0pVWE96N2svT1JUbEFxZXNIT0xjbllSMUhnNU94TzFBL3Zi?=
 =?iso-2022-jp?B?NjFUdDJvbXRXUnQvZ3pRZmpNZmZ2RWNHYm1SUEtOK0RWa2RzUnBJNXcx?=
 =?iso-2022-jp?B?dSsrQXZyNXAzS3lwcnRnUTBiQ0JadTVOYWlkbXMyckVTZ3VCbHVuUkxN?=
 =?iso-2022-jp?B?QVVCQmJBY2srcnpyZzFHODc4Wk45a0VWajZpbjJRS3dLcFRPV2ZmN25C?=
 =?iso-2022-jp?B?Z3V0Qkl0TkR2MHZLWUVIYnpjcEx3TEJTS0I5VXlGVEg4WVhjUndiZ2kw?=
 =?iso-2022-jp?B?cHN5eW1DbkJZRnppLzZLY2tOWXpndWxoRUhLZWk2N01XbmpBY2JISmU5?=
 =?iso-2022-jp?B?U0lQMFlINk1lOWRuditrbUVBNkRWaVB6MnNZSXgzQVA3c0lrT0pzeFYz?=
 =?iso-2022-jp?B?Tm1ZR1Vjbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Vmm0hnFMYkwM+d7PS17P0wfCBxUIVMjjpHGsgH/ftgIOyPJ/w1QfB0x/edPMXtI88D0Md+GQjygP76uRKitNxYHZyP5Z+LSA08HBGdkdxc40X6DLcW9LSUCQJMlX7YxPZkpEzy84eikvBX9JWCxqfzP++GJImF+fCmMmMXmYeTZRu+RmqrK4S8wNR63s26qujTryU4YEjfFt0bzV9lA39B7FDqlEvU1eOesUt6GOVoaOhPTfB2OQu6UzD/rBCG8F8ZTGtNUxZ54U6i5Zj24lbJS66lOjdpDW2ouffbqnz12fo+5VQ0q1hdfmqA8dT0nADY6SWQesMRZjLrDnSV4YTQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f600ec4-e797-4d13-d583-08deb2d6d229
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 23:08:05.1340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6KY1+Hz75k5SWDT64aS+HcomxSKUzYLmp1/HpnZFfqtwBJdRQKSWu/chEyAAl4OrgSEs554RwoifGf3nMWpn6RXDYcO1yarDboilt9BbWdDHXLVTt/bfzVbfKThImPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17551
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 May 2026 23:08:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22970

Hi all,

CIP kernel team has released Linux kernel v6.12.88-cip23.
The linux-6.12.y-cip tree has been updated base version from v6.12.85 to v6=
.12.88.

This is based on the LTS release that includes fixes for Dirty Frag (CVE-20=
26-43284,CVE-2026-43500).
In addition, the CIP kernel includes update patches for USB 3.0 onRenesas A=
RM64 SoCs.

Information about this release is as follows:

  v6.12.88-cip23:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      fdb821a4c1ec0b772fcb433fb653749292ad424e
    fixed CVEs:
      CVE-2025-38584: padata: Fix pd UAF once and for all
      CVE-2026-23468: drm/amdgpu: Limit BO list entry count to prevent reso=
urce exhaustion
      CVE-2026-23473: [REJECTED]: io_uring/poll: fix multishot recv missing=
 EOF on wakeup race
      CVE-2026-31419: net: bonding: fix use-after-free in bond_xmit_broadca=
st()
      CVE-2026-31709: smb: client: validate the whole DACL before rewriting=
 it in cifsacl
      CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[] =
in f2fs_write_end_io()
      CVE-2026-43284: xfrm: esp: avoid in-place decrypt on shared skb frags
      CVE-2026-31499: Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
      CVE-2026-43088: net: af_key: zero aligned sockaddr tail in PF_KEY exp=
orts
      CVE-2026-43109: x86: shadow stacks: proper error handling for mmap lo=
ck
      CVE-2026-43220: iommu/amd: serialize sequence allocation under concur=
rent TLB invalidations
      CVE-2026-43490: ksmbd: validate inherited ACE SID length
      CVE-2026-43500: rxrpc: Also unshare DATA/RESPONSE packets when paged =
frags are present
    added commits:
      CIP: Bump version suffix to -cip23 after merge from stable
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB3.0 PHY and xH=
CI controller
      arm64: dts: renesas: r9a09g056: Add USB3 PHY/Host nodes
      clk: renesas: r9a09g056: Add USB3.0 clocks/resets
      dt-bindings: clock: renesas,r9a09g056-cpg: Add USB3.0 core clocks
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB3.0 PHYs and x=
HCI controllers
      arm64: dts: renesas: r9a09g057: Add USB3 PHY/Host nodes
      dt-bindings: phy: renesas,rzg3e-usb3-phy: Add RZ/V2H(P) and RZ/V2N su=
pport
      dt-bindings: clock: renesas,r9a09g057-cpg: Add USB3.0 core clocks
      clk: renesas: r9a09g057: Add USB3.0 clocks/resets

Best regards,
  Nobuhiro


