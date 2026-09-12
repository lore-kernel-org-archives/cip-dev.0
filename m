Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D248BC79FB6
	for <webhook@archiver.kernel.org>; Sat, 12 Sep 2026 04:08:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.397.1789186077603188055
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 21:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=f06Fyldq;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1789186068;x=1790395668;bh=
	+pWDpkOh+JoBZNFPefMhp9peWgxcK0P//ulmKxCe6FM=;b=f06FyldqTfl09k11AhyiOEI0p+9PTM
	eB97js7Hx6baPA3hDgkNLjjfi0ZIW8JfCc2SGQaHlx2bjoWCpFqqWchm2avJNEtWAl29DgxXQ8gdJ
	5ns4UjehfKF4ckjcDieIAx61FAvDTLyH/HWq2dRgbglj1Z8adlmPVr96nvwcnkpokJ5FkFhyHTInG
	PlXum5eCOsp//jhEQ0bTmw0Ei4bWtuqTJTF652OlpD+qRcLQrAKF46AdyuxFFMfz5jcRGWCc36CYA
	IINutDUnJentzdb6rknGvlQhAxHwrmKsG/9fty6IfjUIjBHyhPmrsVZnasJ9qReG/HNmCDFE+GyAl
	wqsQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 68C47m993143035; Sat, 12 Sep 2026 13:07:48 +0900
X-Iguazu-Qid: 2yAadI9Pq7OueCjzua
X-Iguazu-QSIG: v=2; s=1; t=1789186068; q=2yAadI9Pq7OueCjzua; m=zaNvOHrMXrsRgw8k4X61Z2xMR7j4pU6ivZQ76eeBc7o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hhdDM2zgSzyPQ; Sat, 12 Sep 2026 13:07:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbEjNKX3uziq9dS9XNYjxHgGvMr/a2XZdFezBpUEN9bBk1yF2NFMzpR2iWXqtciYgVRVvtJoAV2aeXc8rFtFxwhOM/4h3iXI6ktNxjZsqlyBSfThQZCLMQJhhdAOKF3I2+dqdJeh4NKA2ID+FY83bIqgqpPSEamBWoN0aVbrqw9VXJPkSVr+e+sfmYPEhrhi5IU+Vuh4EtpOroxCSS2v1rWqjHoJgKf5jtPFrJCA57bvStxwdPOumThUyHKyOr8aOcWGmfaEfpncnJN8OQzgeexvf4fwGaLx8FskOVBGTG6OjDFJJ8Ssb7RYMkO2NSg7ZOlk+z0j0lW7QrL1RvK3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPdJNNybX+WG21TaSOP7BxKPDecfxlCJSsD3I5juNc8=;
 b=TogYaAcU6PCkRnBPtlbL3axWAk92evb+2YpXGKG/QwUqHxXXsuvbiZX5ktjawZrv+y01UNsdoLsscerkKD9PDsauk1godWpSFhcmK7mwOf1Q+14mpDVLUqs1xRTuFF4YrxdNLUwHP0ECS7yzW8t1fm1yWd5vh4erqNdO34Cn3CCJDBaN5Ouu1BiF+tx62tCSm7YnLCqVCkCAiEWlpXvsK+Zxk0IVZ8qB05d6J7CM6uu7w0Vwq//Zp/5EsncVFSNpD0gbn3jwr8yIqJeJSKkBx6FET79yE9VbHtz0DLDNiNRkiY3ruRv5lhM14sTHf7gZqaEjFluuw4x80Rd6Nh4tUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <masami.ichikawa@cybertrust.co.jp>, <jan.kiszka@siemens.com>,
        <chris.paterson2@renesas.com>, <uli@fpond.eu>, <pavel@nabladev.com>
Subject: [ANNOUNCE] Release v6.1.187-cip60
Thread-Topic: [ANNOUNCE] Release v6.1.187-cip60
Thread-Index: Ad1Ca5SBx/nS6fLZQzOBeXCw7yaU9g==
Date: Sat, 12 Sep 2026 04:07:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C2EA2DBDEB6F6A92DB77CDBD2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10230:EE_
x-ms-office365-filtering-correlation-id: 46eb3433-5ca4-4fa2-eba0-08df1083652a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|6133799003|10067099003|11063799006|56012099006|5023799004|18002099003|3023799007;
x-microsoft-antispam-message-info: 
 mi00TR1/dqlrkII35wv6wG8D/XrWy+F+EwPPUi+erD6yT9Zy0h9b7gLMfCuWsKGFNLEAecMvLo2nFe3BfDZBZxFKlqxkwB7ED1pK52tkJ0awqFsnc1U2v6T7gWaOfndTWNBrkCe36U0hBRo7DqqgS8LaiKEtvV43PaNoHmR0VUyepQR++/QIJM5zOW7JCVtApGSgfRRESXxA1eRzE81lfiAmdsT4F8KYmGKbkWSuTcjrMj2iA/QFl9LVPP4jgCE+bvfNQ/EY+G/69HJnlRIp7A+5ScVa///t3pPyj/XKXo6drbvd0zfJc9TVCc/h5v49wAKCj0Rqb3se3iA0MIis4x6JdLHZU3qdtbtcdBKPhc6ndvScVmCPTfbF5f2bh6hGHdny1k0gvrBC9GX6Ha4pu8jdg9baxCy8FDUoAsBrk9a/9CK/Lqo7qzlxz/6v06SCjS5Asii0Krupk1S/I9XgBPEc1jqfl7HvvyOdD3WzQT2Mx7abRnqKSQPGxWcW6apuUmkRrCIwTP6CkuNUyJJC5J9wAwPtIEsJdzjNVei6bwv42UDFwUdVirLrhyLGaOrWWEeht2nMApvKW3tsli0kzx4NyyFTVhIr+7wIv3Q0wFuAfsueTpNaHI2oMstO281VDMlQnUUd5070V0pygKLUbAM/oLkAGwBzwL2WXleAHeqV8/pu4+S3Xao+rl2zfLPrY541HyYcixE0JqhZfeSFIKul1/4RK6aPbz0dC3/M4NI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eGNBQzR1aXRISWZHaWdBdHNOVUMxL2hOb2ZuR2ltYWlUb0tEdEY0VldO?=
 =?iso-2022-jp?B?MjUrZS8xMkNhbFozUXZzSlhLY1hUSlhEbkJrdUllU0htd1lOb2NWZTlJ?=
 =?iso-2022-jp?B?THliRkV6cVhqNStKRzdYblNHZ0dXbEM1SFdTdUJMb1BvaWYxSUZvU2Qv?=
 =?iso-2022-jp?B?ZVJvTFF3dzBmZ3YxMENTQ1o2RTlSNFEyNFlBUXRrQi9LZzZNZXd4NG9I?=
 =?iso-2022-jp?B?ZWE4eU5keFAxRkIzdVkyekQ2L2xPbnl3Z2MxRHc5NjVYM2xNcHA3L2Qy?=
 =?iso-2022-jp?B?NUFBemp0ajBQbm13TkFRWCtLbEJ2N1hQWHg3eGVJc1ZhMWEwbXRLd3c2?=
 =?iso-2022-jp?B?K1pDallmY0RhSjNQMGdkY2wvMnVCam1PN3BoR3pVS1grWlgwd1hCd2tP?=
 =?iso-2022-jp?B?bXZrLzhIaTdmZXF5YWdqQzRjdHd2M1lSak9HUGxmdi9PaXlhditQYmd4?=
 =?iso-2022-jp?B?OHFsTTY1dGx1ZS9Sa2trWVNna0xlcnVoVGhsY014QUI2N1kxZDJRTm5W?=
 =?iso-2022-jp?B?VldYczFhZVIzMnlkcG5LWnM0RXJDZTg4OG1sTFl0QVFkaGk2UEQweDJ2?=
 =?iso-2022-jp?B?VU9Ubk5vVjRZWS81TnNRU2lPY09XWTdhTEVkQVBLK09aQUIvZWxMZVZr?=
 =?iso-2022-jp?B?cHkzbnViQXhSS2ZOVjNkMXVsR09sNDZyQ3ltR3p6eU9Fa042clAyNnFs?=
 =?iso-2022-jp?B?R1hCYkJZRHN6OUNGUldJd1ZtNFcybHc2aWM3U2wwMjVteWxjWWRjWXYv?=
 =?iso-2022-jp?B?RURGQXM3Nk5YczFMU2Q4V3RSaEM0NjJMSmpZM0dScmFoa3dmMEhJZCtt?=
 =?iso-2022-jp?B?MjFFSUFwUkVMY05nb0ZsWWVvSUpxMEJrM2lERlRuMzVYTm51MnIrWHJp?=
 =?iso-2022-jp?B?T3MyOTV6ckxBMGhzZ0FIYXI0MDBiaUQ2TUhXRWdwQTJQbzhrZmZBNUts?=
 =?iso-2022-jp?B?VEU2MklsVDV4RWxaMDNiMDJIdjB1VG9uODNCc0ZwRW1Kb0NKNlEzejdq?=
 =?iso-2022-jp?B?NkR2NlRjY0hSTHFRR0J2QmdrV2VwWVhodDJWaWJTMm1DbWdCc3NDWjdZ?=
 =?iso-2022-jp?B?NS9HNjZjL0VEVG0vTXg3aWlBRXdlYVB3L3AvMndLTW1iZEs4OTlrenMz?=
 =?iso-2022-jp?B?aXBodENKdGpCb01ZSmh0dmwwYUUxSmhJbDNZVzhINllaSDNBamUvd0kr?=
 =?iso-2022-jp?B?OG1FazF2S1cvSWJzSmZTQkw4UHZ3SEl2MzdmZjA2NlFoYUVzbzZMR3dK?=
 =?iso-2022-jp?B?Wm1rK3d3L3FDYTloOWxGdTh0dXY1NmNiZlFialAvYUhRclQxeUxtNEhI?=
 =?iso-2022-jp?B?d3NGNzcrZnRJRy92WWcyTjY1RFNZOHpLYzBmaVNHVTlNM3VUZ3FMQjRq?=
 =?iso-2022-jp?B?azY2NjZBSGtiMTJ1RFNnMFZ6cm1GMGN6eDZjODQ1RXAydzFMNUw5STUv?=
 =?iso-2022-jp?B?RjFzMmptTm1RYlRpRnZiWmNHL25xV2E1RTFYaHBIdTdKa1BFOTAyNTZj?=
 =?iso-2022-jp?B?UG43ODQvQllMY2pZTGNJdGVZZzJ2Y0NHS0hlbDZLckdNYlBaRnptM0c4?=
 =?iso-2022-jp?B?SVAveW1qTU9oUVpNWndQTkQreGlSUS9CMEF1d2l4bFlqVjY0SERuZnRq?=
 =?iso-2022-jp?B?dFNMUk93M2dFdlpJeFNZdnFRZ0RxNFZzUFRydlNGdGo4elJmTGdTVGZP?=
 =?iso-2022-jp?B?RFNZbnZUZTdpZStZTWxjZTdRdGlwNTUybWF2YjN5QmNZVDB0S3VuSnQ4?=
 =?iso-2022-jp?B?QU04VnMyZ2E1b3NlVTVCOVl6YzU5ZkhEMTR3ZHE1bGJ6U0phMDhwRDVw?=
 =?iso-2022-jp?B?ZHFUVUhLb09xTHBoalVJbncvNzA1OHFCTVAxajg5M1hQUXpCZkhUR0NO?=
 =?iso-2022-jp?B?THBKbzRpSGRRS3RiN0RzZ3F5S1lQUjFoN3FIQldBYjBlUDlCb0RTcWs3?=
 =?iso-2022-jp?B?M1YrNnA4Ni96QVZjS1hEUmNPM05pdGs0Ym1BNXZEdkJ1SmVRbzNNMDVv?=
 =?iso-2022-jp?B?QzMwTG9SYXhvQVVmS2dsSVpLblVtU2lLbVVzY3JDZmM4TWxjRmp4Y0ZF?=
 =?iso-2022-jp?B?dHJyZ3NJelZRcXhDbnVUdlE3dzMrN01GNzExL0c4L0h5bUNYSjVXU2RV?=
 =?iso-2022-jp?B?bDBVcnh6cmVSeTVZbG96Mzl1ank3YWIrRzdUbkZUYjVxMHVXUUlpalM1?=
 =?iso-2022-jp?B?TlZobWFLQUhMdkNJazc4bGVBNE53MTFqOUZnNzJKRlR3cnMyRXBxREd4?=
 =?iso-2022-jp?B?cklTNE0vK09DS0RlS01CaVNBeUpDbFhvZ28yVmtwc0RtVy91OTZDZElp?=
 =?iso-2022-jp?B?QnRWR2FncXp5cWJxSDE0bFZTbGZ0Z29JZE92aVMxd05OaVVyOEtzVytt?=
 =?iso-2022-jp?B?ZEFRMWhjdEc2VUZDa01LY1lraEdKK0JXMkVNRnFwcCt0ajU4MkpUNTFl?=
 =?iso-2022-jp?B?dkYzcU5LSHcvQVdnZjBEdCtvVkozMDZDcHQrZFVZL3IzNXF2Rm9xVGtR?=
 =?iso-2022-jp?B?cGxCSUtlOHBXSHB2SnU0cEgxMnc1bEk4UlRFYXZrOGpCNzlVdjZkZFdh?=
 =?iso-2022-jp?B?eVdpV0NpWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	gWzSV6EMHij1i+2YMlmM39TYOrP7cewWfv0mrmnbZKW7KQiUvBoMvu1bb45uuetmhK38rik573JQFLUfp0k8jTLuyIyWyAcnrYVdYoELLWQdp2lfJFQpfCCnnzUKk/RXpF7Jy02QipM+V9LVZiPrDHPc7zgT7MUwzuPcPTohupDPD/fWyzZBu4szCacoRhSZcyaGHrqMPj9q0e91OnBTQbSUBsQT+Kc45VAO1d55BWf7nqJMoYupP9ZCCRF8ZoiAwlOmNxH+XrIPqnUgaxwrTy8ucqGRoqWMPEP685VtRNE8ffONwdcWJINGWHKQ0E1j+r264VmZgTKRYClB16zc8g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb3433-5ca4-4fa2-eba0-08df1083652a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2026 04:07:43.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59EiIUKwP3YK7W5ptxOsNCCja+tpm1F7PEPG1EZA1NJe7i4sjzcfBu07+BnbYKLGVHMXwjHY4tjDqhR8rylK6QvI1o8RL4VdsDo97RfMyWNo+C5nzRAet/XNfoi7ZFjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10230
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 12 Sep 2026 04:08:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24154

Hi all,

CIP kernel team has released Linux kernel v6.1.187-cip60.
The linux-6.1.y-cip tree has been updated base version from v6.1.182 to v6.=
1.187.
This release inclued code cleanups, improved error handling, and functional=
 enhancements
such as support for CA55 software interrupts (SWINT) and ICU error interrup=
ts to the=20
Renesas RZ/V2H irqchip driver in the Linux kernel.

Information about this release is as follows:

  v6.1.187-cip60:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      9511bc9826da9685fc7a42d09416f41b29b88454
    fixed CVEs:
      CVE-2024-26730: hwmon: (nct6775) Fix access to temperature configurat=
ion registers
      CVE-2025-39901: i40e: remove read access to debugfs files
      CVE-2025-40307: exfat: validate cluster allocation bits of the alloca=
tion bitmap
      CVE-2026-23394: af_unix: Give up GC if MSG_PEEK intervened.
      CVE-2026-43491: net: qrtr: ns: Limit the maximum server registration =
per node
      CVE-2026-46111: Bluetooth: hci_conn: fix potential UAF in create_big_=
sync
      CVE-2026-53090: bpf: Fix ld_{abs,ind} failure path analysis in subpro=
gs
      CVE-2026-53361: af_unix: Set gc_in_progress to true in unix_gc().
      CVE-2026-64427: HID: logitech-dj: Fix maxfield check in DJ short repo=
rt validation
      CVE-2026-64434: Bluetooth: L2CAP: Fix UAF in channel timeout by holdi=
ng conn ref
      CVE-2026-64507: x86/bugs: Enable IBPB flush on BPF JIT allocation
      CVE-2026-64508: bpf: Support for hardening against JIT spraying
      CVE-2026-64542: ipv6: ndisc: fix NULL deref in accept_untracked_na()
      CVE-2026-64543: tipc: fix use-after-free of the discoverer in tipc_di=
sc_rcv()
      CVE-2026-64561: KVM: x86: Check for invalid/obsolete root *after* mak=
ing MMU pages available
      CVE-2026-64562: KVM: nVMX: Hide shadow VMCS right after VMCLEAR
      CVE-2026-64563: rhashtable: clear stale iter->p on table restart
      CVE-2026-64564: sctp: don't free the ASCONF's own transport in DEL-IP=
 processing
      CVE-2026-64565: Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_=
process_data()
      CVE-2026-64567: btrfs: reject free space cache with more entries than=
 pages
      CVE-2026-64569: mpls: fix NULL deref in mpls_valid_fib_dump_req() on =
CONFIG_INET=3Dn
      CVE-2026-64571: wifi: p54: validate RX frame length in p54_rx_eeprom_=
readback()
      CVE-2026-64572: ipv4: fib: free fib_alias with kfree_rcu() on insert =
error path
      CVE-2026-64573: Bluetooth: qca: fix NVM tag length underflow in TLV p=
arser
      CVE-2026-64575: bpf: tcp: fix double sock release on batch realloc
      CVE-2026-64576: nexthop: initialize extack in nh_res_bucket_migrate()
      CVE-2026-64577: gtp: check skb_pull_data() return in gtp1u_send_echo_=
resp()
      CVE-2026-64578: ksmbd: validate compound request size before reading =
StructureSize2
      CVE-2026-64579: xfrm: policy: preallocate inexact bins before xfrm_ha=
sh_rebuild reinsert
      CVE-2026-64580: xfrm6: clear dst.dev on error to avoid double netdev_=
put in xfrm6_fill_dst()
      CVE-2026-64582: RDMA/rxe: Fix a use-after-free problem in rxe_mmap
      CVE-2026-64583: usb: gadget: udc: bdc: free IRQ and drain func_wake_n=
otify before teardown
      CVE-2026-64584: usb: gadget: f_midi: cancel pending IN work before fr=
eeing the midi object
      CVE-2026-68093: KVM: SVM: Bump asid_generation on CPU online to avoid=
 ASID collision after hotplug
      CVE-2026-68104: drm/amdgpu: invoke pm_genpd_remove() before freeing g=
enpd
      CVE-2026-68106: drm/amdgpu: fix division by zero with invalid uvd dim=
ensions
      CVE-2026-68108: drm/amdgpu/vce: fix integer overflow in image size
      CVE-2026-68111: drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      CVE-2026-68115: drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      CVE-2026-68117: tipc: clear sock->sk on the failed-insert path in tip=
c_sk_create()
      CVE-2026-68121: pppoe: reload header pointer after dev_hard_header()
      CVE-2026-68123: openvswitch: fix GSO userspace truncation underflow
      CVE-2026-68124: mctp: serial: handle zero-length frames to prevent rx=
 buffer overflow
      CVE-2026-68125: mac802154: llsec: reject frames shorter than the auth=
entication tag
      CVE-2026-68127: ila: reload IPv6 header after pskb_may_pull in checks=
um adjust
      CVE-2026-68129: gve: fix Rx queue stall on alloc failure
      CVE-2026-68130: ksmbd: defer destroy_previous_session() until after N=
TLM authentication
      CVE-2026-68131: rbd: Reset positive result codes to zero in object ma=
p update path
      CVE-2026-68135: net: hip04: fix RX buffer leak on build_skb failure
      CVE-2026-68137: net/x25: fix use-after-free in x25_kill_by_neigh()
      CVE-2026-68140: net/iucv: fix use-after-free of a severed iucv_path
      CVE-2026-68141: net/af_iucv: fix NULL deref in afiucv_hs_callback_syn=
()
      CVE-2026-68142: geneve: require CAP_NET_ADMIN in the device netns for=
 changelink
      CVE-2026-68143: net: slip: serialize receive against buffer reallocat=
ion
      CVE-2026-68144: phonet: pep: fix use-after-free in pep_get_sb()
      CVE-2026-68146: ftrace: Add global mutex to serialize trace_parser ac=
cess
      CVE-2026-68147: fscrypt: Avoid dynamic allocation in fscrypt_get_devi=
ces()
      CVE-2026-68148: fscrypt: Add missing superblock check in find_or_inse=
rt_direct_key()
      CVE-2026-68151: binfmt_elf_fdpic: only honour the first PT_INTERP
      CVE-2026-68153: libceph: remove debugfs files before client teardown
      CVE-2026-68154: libceph: reject zero bucket types in crush_decode
      CVE-2026-68155: libceph: Reject monmaps advertising zero monitors
      CVE-2026-68156: libceph: refresh auth->authorizer_buf{,_len} after au=
thorizer update
      CVE-2026-68157: libceph: guard missing CRUSH type name lookup
      CVE-2026-68158: libceph: Fix multiplication overflow in decode_new_up=
_state_weight()
      CVE-2026-68160: ceph: fix pre-auth out-of-bounds read on snaptrace in=
 ceph_handle_caps()
      CVE-2026-68164: mm/damon/core: disallow overlapping input ranges for =
damon_set_regions()
      CVE-2026-68165: mm/damon/core: validate ranges in damon_set_regions()
      CVE-2026-68171: [REJECTED]: arm64: syscall: Ensure saved x0 is kept i=
n-sync with tracer updates
      CVE-2026-68175: tracing: Fix resource leak on mmiotrace trace_pipe cl=
ose
      CVE-2026-68176: tracing: Fix mmiotrace possible NULL dereferencing of=
 hiter->dev
      CVE-2026-68180: intel_th: fix MSC output device reference leak
      CVE-2026-68182: comedi: comedi_parport: deal with premature interrupt
      CVE-2026-68183: firmware: stratix10-svc: fix memory leaks and list co=
rruption bugs
      CVE-2026-68184: cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
      CVE-2026-68186: binfmt_misc: set have_execfd only once the interprete=
r is opened
      CVE-2026-68187: exec: fix unsigned loop counter wrap in transfer_args=
_to_stack()
      CVE-2026-68188: Bluetooth: RFCOMM: Fix session UAF in set_termios
      CVE-2026-68189: Bluetooth: hci_sync: Protect UUID list traversal
      CVE-2026-68190: staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()
      CVE-2026-68192: wifi: brcmfmac: make release_scratchbuffers idempoten=
t
      CVE-2026-68194: wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buse=
s
      CVE-2026-68195: wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buse=
s
      CVE-2026-68196: wifi: wilc1000: validate assoc response length before=
 subtracting header
      CVE-2026-68197: wifi: mwifiex: fix NULL dereference when the AP has H=
T-cap but no HT-oper
      CVE-2026-68199: wifi: ath6kl: fix OOB access from firmware ADDBA wind=
ow size
      CVE-2026-68202: ALSA: seq: close a re-opened queue timer in the destr=
uctor
      CVE-2026-68204: media: vivid: check for vb2_is_busy() when toggling c=
aps
      CVE-2026-68206: media: v4l2-ctrls: validate HEVC active reference cou=
nts
      CVE-2026-68207: media: ti: vpe: unwind v4l2 device registration on pr=
obe error
      CVE-2026-68209: media: sun4i-csi: Return queued buffers on start_stre=
aming() failure
      CVE-2026-68210: media: stm32: dcmi: unregister notifier on probe fail=
ure
      CVE-2026-68212: media: saa7134: Fix a possible memory leak in saa7134=
_video_init1
      CVE-2026-68213: media: rtl2832_sdr: Return queued buffers on start_st=
reaming() failure
      CVE-2026-68214: media: rtl2832: fix use-after-free in rtl2832_remove(=
)
      CVE-2026-68215: media: radio-si476x: Unregister v4l2_device on probe =
failure
      CVE-2026-68216: media: pwc: Return queued buffers on start_streaming(=
) failure
      CVE-2026-68217: media: pwc: Drain fill_buf on start_streaming() failu=
re
      CVE-2026-68218: media: pci: dm1105: Free allocated workqueue
      CVE-2026-68222: media: msi2500: Return queued buffers on start_stream=
ing() failure
      CVE-2026-68223: media: meson: vdec: Fix memory leak in error path of =
vdec_open
      CVE-2026-68226: media: cx23885: add ioremap return check and cleanup
      CVE-2026-68227: media: cx231xx: fix devres lifetime
      CVE-2026-68229: media: cedrus: skip invalid H.264 reference list entr=
ies
      CVE-2026-68231: media: airspy: Return queued buffers on start_streami=
ng() failure
      CVE-2026-68234: drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_r=
eserved
      CVE-2026-68243: drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SS=
EU
      CVE-2026-68244: drm/i915/gem: Do not leak siblings[] on proto context=
 error
      CVE-2026-68246: drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      CVE-2026-68248: drm/i915: Return NULL on error in active_instance
      CVE-2026-68249: drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      CVE-2026-68250: drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      CVE-2026-68251: drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      CVE-2026-68255: drm/virtio: bound EDID block reads to the response bu=
ffer
      CVE-2026-68259: drm/amdkfd: Check bounds in allocate_event_notificati=
on_slot
      CVE-2026-68269: drm/i915/gem: Add missing nospec on parallel submit s=
lot
      CVE-2026-68277: drm/dp/mst: fix OOB reads on 2-byte fields in sideban=
d reply parsers
      CVE-2026-68278: drm/dp/mst: fix buffer overflows in sideband chunk ac=
cumulation
      CVE-2026-68279: drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband=
 reply parsers
      CVE-2026-68284: bpf, sockmap: Fix cork use-after-free in tcp_bpf_send=
msg()
      CVE-2026-68294: net: qrtr: restrict socket creation to the initial ne=
twork namespace
      CVE-2026-68297: tipc: fix u16 MTU truncation in media and bearer MTU =
validation
      CVE-2026-68299: vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Gene=
ve packets
      CVE-2026-68300: sctp: auth: verify auth requirement when auth_chunk i=
s NULL
      CVE-2026-68301: net: hsr: fix memory leak on slave unregistration by =
removing synced VLANs
      CVE-2026-68302: amt: re-read skb header pointers after every pull
      CVE-2026-68304: wifi: brcmfmac: fix 802.1X-SHA256 call trace warning
      CVE-2026-68309: wifi: mt76: connac: fix possible NULL-pointer deref i=
n mt76_connac_mcu_uni_bss_he_tlv()
      CVE-2026-68310: wifi: mt76: mt7915: guard HE capability lookups
      CVE-2026-68313: tipc: fix infinite loop in __tipc_nl_compat_dumpit
      CVE-2026-68315: sctp: validate stream count in sctp_process_strreset_=
inreq()
      CVE-2026-68320: sctp: fix auth_chunk_list capacity check in sctp_auth=
_ep_add_chunkid
      CVE-2026-68322: rds: Fix inet6_addr_lst NULL dereference when IPv6 is=
 disabled
      CVE-2026-68324: iommu/intel: Fix out-of-bounds memset in dmar_latency=
_disable()
      CVE-2026-68325: iommu/amd: Bound the early ACPI HID map
      CVE-2026-68326: wifi: mwifiex: bound uAP association event IEs to the=
 event buffer
      CVE-2026-68327: wan: wanxl: Only reset hardware after BAR mapping
      CVE-2026-68328: nfp: Check resource mutex allocation
      CVE-2026-68331: dpaa2-eth: put MAC endpoint device on disconnect
      CVE-2026-68333: dpaa2-switch: put MAC endpoint device on disconnect
      CVE-2026-68335: rds: drop incoming messages that cross network namesp=
ace boundaries
      CVE-2026-68336: bonding: fix devconf_all NULL dereference when IPv6 i=
s disabled
      CVE-2026-68338: net/packet: avoid fanout hook re-registration after u=
nregister
      CVE-2026-68340: hwmon: occ: validate poll response sensor blocks
      CVE-2026-68343: smb: client: validate DFS referral PathConsumed
      CVE-2026-68344: usb: atm: ueagle-atm: reject descriptors that confuse=
 probe and disconnect
      CVE-2026-68349: wifi: carl9170: fix buffer overflow in rx_stream fail=
over path
      CVE-2026-68350: wifi: carl9170: fix OOB read from off-by-two in TX st=
atus handler
      CVE-2026-68351: wifi: carl9170: bound memcpy length in cmd callback t=
o prevent OOB read
      CVE-2026-68352: wifi: ath6kl: fix OOB read from firmware IE lengths i=
n connect event
      CVE-2026-68353: wifi: ath6kl: fix OOB read from firmware num_msg in T=
X complete handler
      CVE-2026-68354: firewire: net: Fix fragmented datagram reassembly
      CVE-2026-68355: wifi: ath11k: fix potential buffer underflow in ath11=
k_hal_rx_msdu_list_get()
      CVE-2026-68357: watchdog: pretimeout: Fix UAF in watchdog_unregister_=
governor()
      CVE-2026-68359: hwmon: (nzxt-smart2) Stop device IO before calling hi=
d_hw_stop
      CVE-2026-68360: hwmon: (corsair-cpro) Stop device IO before calling h=
id_hw_stop
      CVE-2026-68361: hwmon: (corsair-psu) Stop device IO before calling hi=
d_hw_stop
      CVE-2026-68362: wifi: ath11k: fix NULL pointer dereference in ath11k_=
hal_srng_access_begin
      CVE-2026-68363: wifi: ath9k: hif_usb: don't dereference hif_dev after=
 re-arming firmware request
      CVE-2026-68365: USB: serial: io_edgeport: cap received transmit credi=
ts
      CVE-2026-68366: usb: gadget: uvc: clamp SEND_RESPONSE length to the r=
esponse buffer
      CVE-2026-68368: usb: gadget: f_ncm: validate datagram bounds in ncm_u=
nwrap_ntb()
      CVE-2026-68369: usb: gadget: printer: fix infinite loop in printer_re=
ad()
      CVE-2026-68370: usb: gadget: dummy_hcd: prevent fifo_req reuse during=
 giveback
      CVE-2026-68373: wifi: at76c50x-usb: avoid length underflow in at76_gu=
ess_freq()
      CVE-2026-68376: sctp: fix auth_hmacs array size in struct sctp_cookie
      CVE-2026-68377: net/sched: act_tunnel_key: Defer dst_release to RCU c=
allback
      CVE-2026-68386: bpf, sockmap: Reject unhashed UDP sockets on sockmap =
update
      CVE-2026-68388: smb/client: handle overlapping allocated ranges in fa=
llocate
      CVE-2026-68395: ata: sata_dwc_460ex: enable SATA interrupts only afte=
r IRQ handler is registered
      CVE-2026-68397: net/iucv: take a reference on the socket found in afi=
ucv_hs_rcv()
      CVE-2026-68398: ppp: defer channel free to an RCU grace period to fix=
 pppol2tp RX UAF
      CVE-2026-68402: wifi: cfg80211: bound element ID read when checking n=
on-inheritance
      CVE-2026-68403: wifi: brcmfmac: initialize SDIO data work before clea=
nup
      CVE-2026-68405: wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ =
lock
      CVE-2026-68406: wifi: cfg80211: validate PMSR FTM preamble range
      CVE-2026-68407: wifi: nl80211: free RNR data on MBSSID mismatch
      CVE-2026-68410: wifi: libertas: fix memory leak in helper_firmware_cb=
()
      CVE-2026-68411: wifi: mac80211_hwsim: clamp virtio RX length before s=
kb_put
      CVE-2026-68413: wifi: ipw2100: fix potential memory leak in ipw2100_p=
ci_init_one()
      CVE-2026-68414: wifi: cfg80211: cancel sched scan results work on unr=
egister
      CVE-2026-68417: RDMA/siw: publish QP after initialization
      CVE-2026-68422: btrfs: fix root leak if its reloc root is unexpected =
in merge_reloc_roots()
      CVE-2026-68425: IB/mad: Drop unmatched RMPP responses before reassemb=
ly
      CVE-2026-68427: gpu: host1x: Fix use-after-free in host1x_bo_clear_ca=
ched_mappings
      CVE-2026-68428: KVM: x86/mmu: Fix use-after-free on vendor module rel=
oad
      CVE-2026-68430: drm/amdgpu/gfx8: drop unecessary BUG_ON()
      CVE-2026-68432: vxlan: require CAP_NET_ADMIN in the device netns for =
changelink
      CVE-2026-68433: libceph: bound get_version reply decode to front len
      CVE-2026-68434: serial: 8250_mid: Fix NULL function pointer dereferen=
ce on DNV/ICX-D/SNR platforms
      CVE-2026-68444: firmware: arm_ffa: Fix NULL dereference in ffa_partit=
ion_info_get()
      CVE-2026-68446: drm/vmwgfx: Validate vmw_surface_metadata::array_size
      CVE-2026-68450: btrfs: free mapping node on duplicate reloc root inse=
rt
      CVE-2026-68451: s390/zcrypt: Validate length for CCA ECC private key =
requests
      CVE-2026-68452: s390/zcrypt: Validate length for CCA AES cipher key r=
equests
      CVE-2026-72113: can: bcm: add missing device refcount for CAN filter =
removal
      CVE-2026-72114: can: bcm: validate frame length in bcm_rx_setup() for=
 RTR replies
      CVE-2026-72115: can: bcm: track a single source interface for ANYDEV =
timeout/throttle ops
      CVE-2026-72116: can: bcm: fix stale rx/tx ops after device removal
      CVE-2026-72117: can: bcm: fix data race on rx_stamp/rx_ifindex in bcm=
_rx_handler()
      CVE-2026-72118: can: bcm: fix CAN frame rx/tx statistics
      CVE-2026-72119: can: bcm: extend bcm_tx_lock usage for data and timer=
 updates
      CVE-2026-72121: can: bcm: add locking when updating filter and timer =
values
      CVE-2026-72124: can: isotp: serialize TX state transitions under so->=
rx_lock
      CVE-2026-72125: can: isotp: fix use-after-free race with concurrent N=
ETDEV_UNREGISTER
      CVE-2026-72146: dmaengine: sh: rz-dmac: Move interrupt request after =
everything is set up
      CVE-2026-72237: perf/x86/amd/brs: Fix kernel address leakage
      CVE-2026-72392: ipv6: fib6: fix NULL deref in fib6_walk_continue() on=
 multi-batch dump
      CVE-2026-74443: drm/vmwgfx: bound DMA command body size against suffi=
x pointer
      CVE-2026-74444: drm/vmwgfx: validate DRAW_PRIMITIVES header size befo=
re division
      CVE-2026-74446: drm/amdkfd: hold event_mutex while checkpointing CRIU=
 events
      CVE-2026-74453: drm/vc4: Zero the tile state data array before each B=
IN job
      CVE-2026-74454: drm/vc4: Supply the overflow slot size in BPOS, not t=
he whole bin BO size
      CVE-2026-74455: can: peak_usb: validate uCAN receive record lengths
      CVE-2026-74456: can: peak_usb: peak_usb_start(): fix double free of t=
ransfer buffer on URB submit error
      CVE-2026-74457: can: peak_usb: add bounds check for USB channel index
      CVE-2026-74458: can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): val=
idate received command extents
      CVE-2026-74459: can: etas_es58x: es58x_read_bulk_callback(): fix RX b=
uffer leak on URB resubmit failure
      CVE-2026-74460: can: ems_usb: validate CPC message lengths
      CVE-2026-74461: i2c: imx: Cancel hrtimer before clearing slave pointe=
r
      CVE-2026-74463: i2c: jz4780: Cache host clock rate at probe to preven=
t CCF prepare_lock deadlock
      CVE-2026-74464: net: openvswitch: fix skb leak on flow key update fai=
lure during ct
      CVE-2026-74465: net: openvswitch: fix potential UAF on meter attach f=
ailure
      CVE-2026-74467: s390/qeth: Check CAP_NET_ADMIN for private ioctls
      CVE-2026-74468: gpio: pch: use raw_spinlock_t for the register lock
      CVE-2026-74469: sctp: prevent peer transport count overflow
      CVE-2026-74470: scsi: scsi_debug: Fix REPORT ZONES alloc_len underflo=
w OOB write
      CVE-2026-74471: tracing: Check return value of __register_event() in =
trace_module_add_events()
      CVE-2026-74472: ublk: reset kernel-owned dev_info fields in ublk_ctrl=
_add_dev()
      CVE-2026-74473: vxlan: use pskb_network_may_pull() in route_shortcirc=
uit()
      CVE-2026-74475: vxlan: use neigh_ha_snapshot() in route_shortcircuit(=
)
      CVE-2026-74478: um: vector: fix use-after-free in vector_mmsg_rx()
      CVE-2026-74480: net: bridge: stop fast-leave after deleting a port gr=
oup
      CVE-2026-74481: mm/page_reporting: use system_freezable_wq to fix UAF=
 during suspend
      CVE-2026-74482: mm/huge_memory: unlock i_mmap_rwsem before releasing =
after-split folios
      CVE-2026-74485: binfmt_misc: reject a flag character as the field del=
imiter
      CVE-2026-74488: wifi: mwifiex: use the subframe length when parsing A=
-MSDU TDLS frames
      CVE-2026-74490: tipc: avoid use-after-free in poll trace queue dumps
      CVE-2026-74492: netfilter: ipset: do not update comments from kernel-=
side hash adds
      CVE-2026-74493: net/smc: fix socket use-after-free during link group =
termination
      CVE-2026-74495: igbvf: Fix leak in TX DMA error cleanup
      CVE-2026-74497: ALSA: usb-audio: Clamp frame size in implicit-feedbac=
k mode
      CVE-2026-74498: ALSA: usb-audio: Fix DMA buffer out-of-bounds write w=
hen fill_max is set
      CVE-2026-74499: ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_ou=
tput()
      CVE-2026-74505: ALSA: 6fire: Fix UAF at error handling during probe
      CVE-2026-74507: Bluetooth: HIDP: validate numbered report payloads
      CVE-2026-74508: Bluetooth: HIDP: reject frames without a transaction =
header
      CVE-2026-74512: audit: fix potential use-after-free in audit_del_rule=
()
      CVE-2026-74515: KVM: s390: pci: Reject adapter interrupt forwarding i=
f already enabled
      CVE-2026-74516: KVM: SVM: Update x2APIC MSR intercepts if AVIC is inh=
ibited while L2 is active
      CVE-2026-74518: mm/hugetlb: fix list corruption in allocate_file_regi=
on_entries()
      CVE-2026-74519: pinctrl: devicetree: don't free uninitialized dev_nam=
e on error path
      CVE-2026-74522: ksmbd: fix use-after-free in __close_file_table_ids()
      CVE-2026-74523: qede: sync udp_tunnel ports outside qede_lock in the =
recovery path
      CVE-2026-74525: net: sxgbe: free TX rings on RX allocation failure
      CVE-2026-74540: Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
      CVE-2026-74546: hwmon: (adt7470) Fix divide-by-zero TOCTOU crash in f=
an speed read
      CVE-2026-74547: hwmon: (adt7470) Fix busy-loop and I2C flooding in up=
date thread
      CVE-2026-74548: forcedeth: fix UAF of txrx_stats in nv_remove
      CVE-2026-74549: hwmon: (nct6775-core) Prevent access to unsupported w=
eight registers
      CVE-2026-74550: net: do not send ICMP/NDISC Redirects when peer alloc=
ation fails
      CVE-2026-74551: hwmon: (nzxt-smart2) DMA-align output buffer
      CVE-2026-74552: hwmon: (lm90) Only report alarms if driver is ready
      CVE-2026-74553: hwmon: (nct6775-core) Fix number of temperature regis=
ters for NCT6116
      CVE-2026-74555: scsi: libsas: Fix HA resume deadlock and hisi_sas dis=
k-wake race
      CVE-2026-74556: scsi: libiscsi_tcp: Bound SCSI Response data segment =
to the connection buffer
      CVE-2026-74557: scsi: libiscsi: Fix stale-data leak into the SCSI sen=
se buffer
      CVE-2026-74563: rds: tcp: hold the RCU lock across ipv6_chk_addr() in=
 rds_tcp_laddr_check()
      CVE-2026-74564: netfilter: xt_hashlimit: validate hashtable supports =
XT_HASHLIMIT_RATE_MATCH
      CVE-2026-74566: keys: make keyring key-chunk byte order agree with ke=
yring_diff_objects()
      CVE-2026-74567: keys: fix out-of-bounds read in keyring_get_key_chunk=
()
      CVE-2026-74569: netfilter: nf_conntrack_sip: widen NAT rewrite delta =
to s32 in sip_help_tcp()
      CVE-2026-74577: net: mpls: initialize rtm_tos in mpls_getroute()
      CVE-2026-74579: netfilter: nft_payload: fix mask build for partial fi=
eld offload
      CVE-2026-74580: vhost: reset the vring metadata cache on vring reconf=
iguration
      CVE-2026-74581: net: ipv6: clear suppressed fib6 rule result
      CVE-2026-74583: net/sched: cls_route: fix fastmap use-after-free on f=
ilter
      CVE-2026-74585: thunderbolt: Bound the DROM dual link port number bef=
ore indexing sw->ports
      CVE-2026-74586: sctp: clear new_transport when removing a peer
      CVE-2026-74587: sctp: fix use-after-free of cached ASCONF chunk
      CVE-2026-74588: sctp: keep chunk->transport in step with the list it =
is queued on
      CVE-2026-74589: bpf, sockmap: Fix sk_redir use-after-free in send ver=
dict
      CVE-2026-74594: sched/psi: Shut down rtpoll_timer in psi_cgroup_free(=
)
      CVE-2026-74597: ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
      CVE-2026-74598: ipv6: fix Route Information option length validation
      CVE-2026-74603: ptp: ocp: Fix board ID over-read
      CVE-2026-74604: Revert "thermal/drivers/hwmon: Cleanup coding style a=
 bit"
      CVE-2026-74608: smb: client: Fix use-after-free in cifs_try_adding_ch=
annels()
      CVE-2026-74609: tipc: read le->link under the node lock in tipc_node_=
link_down()
      CVE-2026-74613: vsock/virtio: avoid refilling the RX queue after tear=
down
      CVE-2026-74614: vsock/virtio: read virtqueues under worker locks
      CVE-2026-74615: vxlan: do not arm the ageing timer on a device that i=
s down
      CVE-2026-74616: xdp: reject clones that overrun skb_shared_info tailr=
oom
      CVE-2026-74620: net/sched: act_gact, act_police: range check the fall=
back control action
      CVE-2026-74622: net: atlantic: free RX pages of consumed but not refi=
lled buffers
      CVE-2026-74623: net: atlantic: free stranded TX buffers on ring deini=
t
      CVE-2026-74625: netfilter: bridge: release template ct on non-IP path
      CVE-2026-74630: ipv6: prevent in6_dev_get() from resurrecting inet6_d=
ev
      CVE-2026-74631: net: smc: fix splice entry lifetime imbalance in smc_=
rx_splice
      CVE-2026-74635: fbdev: bitblit: bound-check glyph index in bit_cursor=
()
      CVE-2026-74636: tracing: Fix race between update_event_fields and, ev=
ent_define_fields
      CVE-2026-74641: ALSA: usx2y: bound the hwdep mmap fault offset
      CVE-2026-74648: staging: rtl8723bs: validate monitor transmit frame l=
engths
      CVE-2026-74649: staging: rtl8723bs: fix missing shared-key auth chall=
enge length check
      CVE-2026-74650: staging: rtl8723bs: fix OOB read in WMM_param_handler=
()
      CVE-2026-74651: staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()
      CVE-2026-74654: serial: 8250_dma: Clear stale RX state on shutdown
      CVE-2026-74656: ipv4: fix use-after-free in fib_nhc_update_mtu()
      CVE-2026-74657: ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
      CVE-2026-74658: futex: Prevent robust futex exit race some more
      CVE-2026-74659: net: bridge: mrp: fix uninitialised bytes on the wire
      CVE-2026-74660: netfilter: ebt_nflog: pin the NFLOG backend
      CVE-2026-74663: net/sched: reject overly deep qdisc hierarchies
      CVE-2026-74664: net: openvswitch: reallocate update replies for misma=
tched IDs
      CVE-2026-74667: net/packet: reset the MAC header on the packet-socket=
 transmit path
      CVE-2026-74669: ipvs: clear IPv4 options after rebasing tunnel ICMP e=
rrors
      CVE-2026-74671: ima: fix out-of-bounds read in xattr_verify()
      CVE-2026-74673: Input: evdev - fix information leak in evdev_pass_val=
ues()
      CVE-2026-74675: vt: stabilize tty reference in kbd_keycode with tty_p=
ort_tty_get
      CVE-2026-74676: vt: add permission check for KDSKBMETA ioctl
      CVE-2026-74678: net: usb: ax88179_178a: fix skb leak in ax88179_tx_fi=
xup()
      CVE-2026-74679: usb: gadget: f_ncm: Use unsigned int for ndp_index
      CVE-2026-74680: usb: atm: cxacru: properly kill rcv_urb on error in c=
xacru_cm()
      CVE-2026-74682: ALSA: usb-audio: fix OOB write on Type II inbound URB=
s
      CVE-2026-74683: Input: evdev - sanitize event type index when fetchin=
g event masks
      CVE-2026-74688: sctp: clear control chunk transport if it is being re=
moved
      CVE-2026-74689: net/atm: fix slab-out-of-bounds read in vcc_setsockop=
t()
      CVE-2026-74691: net: thunderbolt: Tear down DMA paths before stopping=
 the rings
      CVE-2026-74692: net/smc: fix TOCTOU race between smc_listen_out() and=
 listener close
      CVE-2026-74693: net: prestera: validate firmware header length
      CVE-2026-74694: net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payl=
oad length
      CVE-2026-74696: tcp: fix TFO max_qlen accounting across reuseport mig=
ration
      CVE-2026-74697: bnxt_en: Disable EOP for TPA on all chips to prevent =
data corruption
      CVE-2026-74701: net/openvswitch: check Ethernet header length in key_=
extract()
      CVE-2026-74704: net/sched: sch_cake: drop WARN_ON(1) for malformed pa=
ckets in ACK filter
      CVE-2026-74705: udp: fix potential use-after-free in tunnel segmentat=
ion
      CVE-2026-74714: bpf: tcp: Fix use-after-free in bpf_iter_tcp_establis=
hed_batch()
      CVE-2026-74717: net/mlx5: fw_tracer, return NULL on create error
      CVE-2026-74719: net/smc: fix qentry overwrite for CONFIRM_LINK and AD=
D_LINK_CONT in smc_llc_event_handler()
      CVE-2026-74720: bpf: Preserve pointer state for commuted arithmetic
      CVE-2026-74722: btrfs: fix memory leak in btrfs_do_encoded_write()
      CVE-2026-74724: ipvs: avoid out-of-bounds write in ip_vs_nat_icmp
      CVE-2026-74726: bonding: alb: re-check primary_is_promisc under RTNL =
in bond_alb_monitor
      CVE-2026-74730: NFS: Pin the 'struct nfs_server' during a FREE_STATEI=
D call
      CVE-2026-80678: i2c: imx: Fix slave registration race and error handl=
ing
      CVE-2026-80679: s390/dasd: Fix potential NULL pointer dereference
      CVE-2026-80680: i2c: amd-mp2: Unregister callback on adapter add fail=
ure
      CVE-2026-80681: vxlan: re-fetch eth header after route_shortcircuit()
      CVE-2026-80684: KVM: s390: pci: Fix NULL dereference on AIBV allocati=
on failure
      CVE-2026-80706: can: softing: fw_parse(): validate firmware record sp=
ans
      CVE-2026-80707: can: j1939: transport: j1939_session_fresh_new(): ini=
tialize receive buffer
      CVE-2026-80708: s390/zcrypt: Fix missing mem scrub at clear key impor=
t in cca_clr2cipherkey()
      CVE-2026-80709: s390/zcrypt: Fix wrong domain value verification with=
 EP11 CPRBs
      CVE-2026-80714: ipvs: do not propagate one-packet flag to synced conn=
s
      CVE-2026-80716: ALSA: pcm: wake linked drain waiters on unlink
      CVE-2026-80717: sctp: validate Adaptation Indication parameter length
      CVE-2026-80718: mm/percpu-km: fix bitmap overflow and accounting in p=
cpu_create_chunk()
      CVE-2026-80722: wifi: mac80211: validate individual TWT params before=
 driver setup
      CVE-2026-80726: KVM: x86/mmu: WARN and clear role.invalid when creati=
ng a child shadow page
      CVE-2026-80730: ring-buffer: Fix crash passing ERR_PTR to kthread_sto=
p()
      CVE-2026-80731: net: remove CAP_SYS_RAWIO zero-padding in dev_validat=
e_header
      CVE-2026-80732: ata: pata_sl82c105: fix bridge revision use-after-fre=
e
      CVE-2026-80733: net: remove WARN_ON_ONCE() from sk_mc_loop()
      CVE-2026-80888: drm/vmwgfx: drop dma_buf reference on foreign-fd prim=
e import
      CVE-2026-80890: sctp: reject stale cookies with mismatched verificati=
on tags
      CVE-2026-80891: KVM: s390: pci: Validate AIBV and AISB before pinning=
 guest pages
      CVE-2026-80893: mm/hugetlb: fix swap entry corruption when clearing u=
ffd-wp at fork()
      CVE-2026-80901: ipvs: fix the checksum validations
      CVE-2026-80902: dmaengine: sun6i-dma: Fix reclaim descriptors while t=
erminating DMA
      CVE-2023-53706: mm/vmemmap/devdax: fix kernel crash when probing devd=
ax devices
      CVE-2024-38620: Bluetooth: HCI: Remove HCI_AMP support
      CVE-2025-38117: Bluetooth: MGMT: Protect mgmt_pending list with its o=
wn lock
      CVE-2025-39758: RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendp=
ages
      CVE-2025-40054: f2fs: fix UAF issue in f2fs_merge_page_bio()
      CVE-2025-40206: netfilter: nft_objref: validate objref and objrefmap =
expressions
      CVE-2025-68305: Bluetooth: hci_sock: Prevent race in socket write ite=
r and sock bind
      CVE-2026-31419: net: bonding: fix use-after-free in bond_xmit_broadca=
st()
      CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect
      CVE-2026-64139: ksmbd: fix SID memory leak in set_posix_acl_entries_d=
acl() on overflow
      CVE-2026-64192: bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BP=
F LSM is uninitialized
      CVE-2026-64270: Input: mms114 - reject an oversized device packet siz=
e
      CVE-2026-64272: Input: mms114 - fix touch indexing for MMS134S and MM=
S136
      CVE-2026-64280: fpga: dfl-afu: validate DMA mapping length in afu_dma=
_map_region()
      CVE-2026-64294: mm: do file ownership checks with the proper mount id=
map
      CVE-2026-64586: wifi: brcmfmac: drain bus_reset work on device remova=
l
      CVE-2026-64590: dma-buf/udmabuf: skip redundant cpu sync to fix cache=
line EEXIST warning
      CVE-2026-68082: libceph: fix two unsafe bare decodes in decode_locker=
s()
      CVE-2026-68096: audit: fix recursive locking deadlock in audit_dupe_e=
xe()
      CVE-2026-68099: ksmbd: restore DACL size on check_add_overflow() to a=
void malformed ACL
      CVE-2026-68100: ksmbd: validate num_subauth when copying ACE in set_n=
tacl_dacl
      CVE-2026-68132: super: fix emergency thaw deadlock on frozen block de=
vices
      CVE-2026-68136: net: gro: fix double aggregation of flush-marked skbs
      CVE-2026-68138: net/sched: serialize qdisc_rtab_list against concurre=
nt get/put
      CVE-2026-68159: libceph: bound pg_{temp,upmap,upmap_items} length to =
CEPH_PG_MAX_SIZE
      CVE-2026-68162: sctp: avoid auth_enable sysctl UAF during netns teard=
own
      CVE-2026-68169: mptcp: pm: userspace: fix use-after-free in get_local=
_id
      CVE-2026-68181: mei: bus: access mei_device under device_lock on clea=
nup
      CVE-2026-68198: wifi: ath6kl: fix use-after-free in aggr_reset_state(=
)
      CVE-2026-68253: drm/i915/hdcp: check streams[] bounds before overflow
      CVE-2026-68254: drm/i915/vrr: require valid min/max vfreq for VRR
      CVE-2026-68280: drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DE=
V_PM_OPS()
      CVE-2026-68367: usb: gadget: f_tcm: synchronize delayed set_alt with =
teardown
      CVE-2026-68371: usb: musb: omap2430: Do not put borrowed of_node in p=
robe
      CVE-2026-68392: Bluetooth: mgmt: fix locking in unpair_device/disconn=
ect_sync
      CVE-2026-68431: ksmbd: validate minimum PDU size for transform reques=
ts
      CVE-2026-72012: tracing/osnoise: Call synchronize_rcu() when unregist=
ering
      CVE-2026-72015: fs/resctrl: Fix double-add of pseudo-locked region's =
RMID to free list
      CVE-2026-72017: net: macb: drop in-flight Tx SKBs on close
      CVE-2026-72023: octeontx2-pf: fix SQB pointer leak on init failure
      CVE-2026-72030: ata: libata-core: Reject an invalid concurrent positi=
oning ranges count
      CVE-2026-72035: net/sched: sch_taprio: Replace direct dequeue call wi=
th peek and qdisc_dequeue_peeked
      CVE-2026-72040: ipmi: fix refcount leak in i_ipmi_request()
      CVE-2026-72041: espintcp: use sk_msg_free_partial to fix partial send
      CVE-2026-72045: octeontx2-af: cn10k: restrict VF LMTLINE sharing to i=
ts own PF
      CVE-2026-72051: net: ip6_tunnel: require CAP_NET_ADMIN in the device =
netns for changelink
      CVE-2026-72057: net/sched: act_ct: preserve tc_skb_cb across defragme=
ntation
      CVE-2026-72062: gpio: mt7621: avoid corruption of shared interrupt tr=
igger state
      CVE-2026-72063: gpio: tegra: do not call pinctrl for GPIO direction
      CVE-2026-72065: net: mana: Validate the packet length reported by the=
 NIC
      CVE-2026-72069: locking/rt: Fix the incorrect RCU protection in rt_sp=
in_unlock()
      CVE-2026-72070: wifi: libertas_tf: fix use-after-free in lbtf_free_ad=
apter()
      CVE-2026-72073: mmc: vub300: fix use-after-free on probe failure
      CVE-2026-72077: Input: ims-pcu - fix firmware leak in async update
      CVE-2026-72096: dm-verity: make error counter atomic
      CVE-2026-72099: dm-integrity: don't increment hash_offset twice
      CVE-2026-72110: bpf,fork: wipe ->bpf_storage before bailouts that acc=
ess it
      CVE-2026-72142: i2c: imx: fix locked bus on SMBus block-read of 0 (at=
omic)
      CVE-2026-72157: net: thunderbolt: Fix frags[] overflow by bounding fr=
ame_count
      CVE-2026-72168: mtd: maps: vmu-flash: fix fault in unaligned fixup
      CVE-2026-72170: 9p: skip nlink update in cacheless mode to fix WARN_O=
N
      CVE-2026-72172: mm/mm_init: fix uninitialized struct pages for ZONE_D=
EVICE
      CVE-2026-72191: ntfs3: validate split-point offset in indx_insert_int=
o_buffer
      CVE-2026-72216: remoteproc: qcom: Fix leak when custom dump_segments =
addition fails
      CVE-2026-72236: s390/perf_cpum_cf: Add missing array_index_nospec() t=
o __hw_perf_event_init()
      CVE-2026-72242: selinux: avoid sk_socket dereference in selinux_sctp_=
bind_connect()
      CVE-2026-72252: netfilter: nft_set_pipapo: don't leak bad clone into =
future transaction
      CVE-2026-72253: netfilter: nf_conntrack_sip: validate skb_dst() befor=
e accessing it
      CVE-2026-72260: ASoC: mediatek: mt8192: Check runtime resume during p=
robe
      CVE-2026-72262: ASoC: SOF: ipc3-control: Fix heap overflow in bytes_e=
xt put/get
      CVE-2026-72299: tipc: restrict socket queue dumps in enqueue tracepoi=
nts
      CVE-2026-72305: VDUSE: avoid leaking information to userspace
      CVE-2026-72308: mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
      CVE-2026-74436: rxrpc: serialize kernel accept preallocation with soc=
ket teardown
      CVE-2026-74441: usb: typec: ucsi: Fix race condition and ordering in =
port unregistration
      CVE-2026-74450: drm/amd/pm: fix pptable use-after-free
      CVE-2026-74476: veth: convert frag_list skbs before running XDP
      CVE-2026-74479: net: pktgen: fix proc entry use-after-free
      CVE-2026-74486: binfmt_misc: use exe_file_deny_write_access() for the=
 interpreter clone
      CVE-2026-74487: binfmt_misc: restore write access when removing an en=
try
      CVE-2026-74494: ksmbd: reject repeated SMB2 NEGOTIATE requests
      CVE-2026-74509: Bluetooth: hci_sync: Fix advertising data UAFs
      CVE-2026-74510: Bluetooth: mgmt: fix UAF in pair command cancellation
      CVE-2026-74511: [REJECTED]: Bluetooth: mgmt: fix pending command UAF =
in EIR updates
      CVE-2026-74514: KVM: s390: pci: Fix memory accounting for pinned/unpi=
nned pages
      CVE-2026-74575: thunderbolt: Prevent XDomain delayed work use-after-f=
ree on disconnect
      CVE-2026-74595: fscrypt: use the mount idmap for the owner check in f=
scrypt_ioctl_set_policy()
      CVE-2026-74601: ring-buffer: Use current_context for safe per-CPU buf=
fer swap
      CVE-2026-74607: KVM: SVM: Serialize accesses to the owner and mirror =
list with separate lock
      CVE-2026-74612: veth: fix skb length accounting after XDP frag adjust=
ment
      CVE-2026-74621: net/sched: act_ct: fix sk_buff leak when the header c=
hecks reject a packet
      CVE-2026-74624: netfilter: nf_conntrack: defer invalid log until afte=
r unlock
      CVE-2026-74628: net/x25: fix use-after-free of the socket by its time=
rs
      CVE-2026-74632: mm/huge_memory: fix huge_zero_pfn race
      CVE-2026-74672: mm/vmalloc: acquire init_mm lock on huge vmap to avoi=
d ptdump UAF
      CVE-2026-74737: net: ethernet: ti: am65-cpsw-nuss: Fix port_id extrac=
tion from SRC TAG
      CVE-2026-74739: net/sched: cls_u32: skip hash tables in u32_bind_clas=
s()
      CVE-2026-74743: macvlan: inherit needed_headroom and needed_tailroom =
from lowerdev
      CVE-2026-74744: ipvlan: inherit needed_headroom and needed_tailroom f=
rom phy_dev
      CVE-2026-74746: netfilter: flowtable: publish GC-visible tuple last
      CVE-2026-74748: netfilter: ipset: fix refcount race between list:set =
GC and swap
      CVE-2026-80527: ceph: fix hanging __ceph_get_caps() with stale mds_wa=
nted
      CVE-2026-80528: ceph: avoid fs reclaim while using current->journal_i=
nfo
      CVE-2026-80529: xfs: don't swallow dquot recovery verification errors
      CVE-2026-80534: xfs: fix ilock leak on error in xfs_dq_get_next_id
      CVE-2026-80540: drm/amdgpu: Fix UVD decode image min size calculation
      CVE-2026-80541: drm/amdgpu: validate GEM_CREATE domain combinations
      CVE-2026-80550: s390/vfio_ccw: Fix out of bounds check on CCW array
      CVE-2026-80552: s390/vfio_ccw: Ensure index for read/write regions ar=
e within range
      CVE-2026-80558: libceph: Avoid using invalid osd indices from primary=
_temp
      CVE-2026-80559: Input: sur40 - fix input device registration ordering
      CVE-2026-80560: openrisc: signal: do not restore privileged SR bits o=
n sigreturn
      CVE-2026-80561: libceph: fix multiple unsafe decodes in decode_locker=
()
      CVE-2026-80565: crypto: qce - fix error path in devm_qce_register_alg=
s
      CVE-2026-80567: Input: synaptics-rmi4 - propagate F54 worker errors t=
o V4L2 queue
      CVE-2026-80568: Input: synaptics-rmi4 - block s_input when F54 queue =
is busy
      CVE-2026-80569: Input: synaptics-rmi4 - bound the F54 report size to =
the allocated buffer
      CVE-2026-80570: Input: synaptics-rmi4 - zero report size on F54 work =
error
      CVE-2026-80573: Input: iforce - validate input packet lengths
      CVE-2026-80574: Input: focaltech - fix array out-of-bounds in focalte=
ch_process_rel_packet
      CVE-2026-80584: s390/qeth: validate user buffer length in SNMP and AR=
P query ioctls
      CVE-2026-80586: mptcp: options: reset DSS fields in case of unexpecte=
d size
      CVE-2026-80589: block: stop the timeout timer when releasing a never =
added disk
      CVE-2026-80686: mm: migrate_device: fix pte_pfn/pte_dirty called on n=
on-present PTE
      CVE-2026-80715: igc: remove napi_synchronize() in igc_down()
      CVE-2026-80742: af_packet: Don't send zero-byte data in tpacket_snd()=
.
      CVE-2026-80743: ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq=
 handlers
      CVE-2026-80744: netfilter: nf_tables_offload: suppress WARN_ON_ONCE f=
or ENOMEM in abort path
      CVE-2026-80752: Input: psxpad-spi - set driver data before use
      CVE-2026-80754: Input: synaptics-rmi4 - fix F55 transmitter electrode=
 count typo
      CVE-2026-80756: selinux: do not cancel a policy conversion that never=
 started
      CVE-2026-80757: selinux: reject a class permission count below its in=
herited common
      CVE-2026-80892: erofs: cap LZMA stream pool size
      CVE-2026-80904: net/tls: Fail tls_sw_splice_read() after a failed asy=
nc decrypt
      CVE-2026-80906: net: packet: fix wrong transport_header when sending =
VLAN-tagged frame
      CVE-2026-80908: drm/amdgpu: Reject UVD message with dimensions above =
4096
      CVE-2026-80909: drm/amdgpu: Reject UVD message with invalid number of=
 h265 refs
      CVE-2026-80910: ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol acce=
sses
      CVE-2026-80913: selinux: require every boolean value to be defined
      CVE-2024-46741: misc: fastrpc: Fix double free of 'buf' in error path
      CVE-2025-38616: tls: handle data disappearing from under the TLS ULP
      CVE-2025-68794: iomap: adjust read range correctly for non-block-alig=
ned positions
      CVE-2026-46158: mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      CVE-2026-46170: mptcp: pm: ADD_ADDR rtx: free sk if last
      CVE-2026-64581: xfrm: fix sk_dst_cache double-free in xfrm_user_polic=
y()
      CVE-2026-74582: packet: use consistent hard_header_len in non-ring se=
nd paths
      CVE-2026-74626: NTB: ntb_netdev: Preserve RX queue depth on allocatio=
n failure
      CVE-2026-74637: perf/core: Fix group leader use-after-free after sibl=
ing detach
      CVE-2026-74647: misc: fastrpc: Remove buffer from list prior to unmap=
 operation
      CVE-2026-74662: inet: frags: publish queues before arming timer
      CVE-2026-74666: packet: synchronize pressure clearing with ring recon=
figuration
      CVE-2026-74668: packet: use consistent hard_header_len in TX_RING sen=
d path
      CVE-2026-80536: xfs: bounds-check buffer log item's dirty bitmap
      CVE-2026-80539: drm/amdgpu: disallow multiple FENCE chunks in one sub=
mit
      CVE-2026-80547: s390/vfio_ccw: Implement a crw lock
      CVE-2026-80548: s390/vfio_ccw: Selectively expand io_mutex
      CVE-2026-80549: s390/vfio_ccw: Move cp cleanup out of not operational
      CVE-2026-80553: s390/vfio_ccw: Cancel existing workqueues
      CVE-2026-80555: s390/vfio_ccw: Free all memory if cp_init() fails
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
      CVE-2026-80764: Bluetooth: hci_event: fix LE list UAF on reset
      CVE-2026-80765: HID: hyperv: validate initial device info bounds
      CVE-2026-80767: HID: sensor: custom: Fix use-after-free in enable_sen=
sor
      CVE-2026-80772: HID: nintendo: fix out-of-bounds read in joycon_ctlr_=
read_handler()
      CVE-2026-80781: HID: core: fix OOB read of field->usage in hid_set_fi=
eld()
      CVE-2026-80782: HID: magicmouse: do not keep a stale msc->input if no=
 input is claimed
      CVE-2026-80788: nvmet-tcp: Do not WARN on remotely-controlled oversiz=
ed SGL allocations
      CVE-2026-80790: nvmet-fc: fix invalid free in LS IOD error path
      CVE-2026-80791: nvmet-auth: zero the AUTH_RECEIVE response buffer
      CVE-2026-80792: ipv6: fix use-after-free in ip6_finish_output2()
      CVE-2026-80793: ipv4: reject undersized MTUs in ip_do_fragment()
      CVE-2026-80794: nfc: nci: fix uninit-value in the RF discover/activat=
ed NTF handlers
      CVE-2026-80795: nfc: nci: fix out-of-bounds write in nci_target_auto_=
activated()
      CVE-2026-80797: nfc: pn533: purge fragmented skbs during cleanup
      CVE-2026-80798: nfc: llcp: reject PDUs shorter than the LLCP header
      CVE-2026-80799: nfc: llcp: fix OOB read and u8 offset wrap in TLV par=
sers
      CVE-2026-80800: nfc: llcp: bound the connect_sn TLV walk to the skb
      CVE-2026-80801: nfc: microread: validate target discovery payload len=
gths
      CVE-2026-80802: nfc: fdp: bound the device-reported read length and f=
ix an skb leak
      CVE-2026-80803: nfc: digital: clamp SENSF_RES length to the destinati=
on buffer
      CVE-2026-80805: xfs: validate attr entry pointer before field access
      CVE-2026-80808: ext4: stop retrying saturated xattr cache entries
      CVE-2026-80809: ocfs2: fix missing metadata reservation for large xat=
trs
      CVE-2026-80812: ALSA: dummy: Check card index validity at probe
      CVE-2026-80814: rndis_host: add overflow check in rndis_rx_fixup()
      CVE-2026-80819: Bluetooth: RFCOMM: take rfcomm_mutex for the deferred=
 setup accept
      CVE-2026-80823: nfc: st21nfca: validate ATR_REQ length against the re=
ceived frame
      CVE-2026-80889: can: isotp: fix timer drain order, wakeup handling an=
d tx_gen ordering
      CVE-2026-80916: kcov: fix data corruption and race conditions on PREE=
MPT_RT
      CVE-2026-80917: PCI: host-generic: Fix NULL pointer dereference on 32=
-bit CAM systems
      CVE-2026-80918: HID: core: fix number/pointer type confusion on long =
items
      CVE-2026-80590: inet: frags: strip GSO state from fragments before re=
assembly
      CVE-2023-54141: wifi: ath11k: Add missing hw_ops->get_ring_selector()=
 for IPQ5018
      CVE-2023-54263: drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP
      CVE-2024-46754: bpf: Remove tst_run from lwt_seg6local_prog_ops.
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
      CVE-2026-46266: inet: RAW sockets using IPPROTO_RAW MUST drop incomin=
g ICMP
      CVE-2026-53089: bpf: Fix use-after-free in offloaded map/prog info fi=
ll
      CVE-2026-64082: riscv: Fix register corruption from uninitialized cre=
gs on error
      CVE-2026-68476: ipvs: reload ip header after head reallocation
      CVE-2026-72323: ipv4: igmp: Fix potential UAF in igmp_gq_start_timer(=
)
      CVE-2026-80762: Bluetooth: hci_sync: Fix accept list UAF during suspe=
nd
      CVE-2026-80763: Bluetooth: hci_event: validate LE Set CIG Parameters =
response
      CVE-2026-80766: HID: uclogic: fix use-after-free of inrange_timer on =
remove
      CVE-2026-80768: HID: ft260: fix stack-use-after-return write in I2C r=
ead race
      CVE-2026-80770: HID: nintendo: stop device IO before hid_hw_stop on p=
robe failure
      CVE-2026-80783: HID: magicmouse: prevent unbounded recursion in magic=
mouse_raw_event()
      CVE-2026-80784: mptcp: pm: fix memory leak from alloc-during-teardown=
 race
      CVE-2026-80789: nvmet-tcp: bound SGL data length before allocating co=
mmand buffers
      CVE-2026-80796: nfc: nci: add data_len bound checks to activation par=
ameter extractors
      CVE-2026-80806: ext4: don't enable DAX on new encrypted files
      CVE-2026-80807: nilfs2: reject invalid block index in GC ioctl
      CVE-2026-80824: usb: usbfs: fix use-after-free of usb_device in usbde=
v_release()
      CVE-2026-80826: USB: c67x00: fix use-after-free in c67x00_add_iso_urb=
()
      CVE-2026-80827: USB: serial: option: fix slab OOB read in interrupt U=
RB callback
      CVE-2026-80828: ALSA: usb-audio: Complete cleanup after system-resume=
 errors
      CVE-2026-80829: ALSA: usb-audio: fix OOB write in snd_usbmidi_novatio=
n_output()
      CVE-2026-80830: usb: core: Add lock to usb_wakeup_notification()
      CVE-2026-80831: crypto: mxs-dcp - fix source scatterlist length acces=
s
      CVE-2026-80832: crypto: qce - fix CCM AAD buffer underallocation
      CVE-2026-80840: ipv6: seg6: clear IPv4 control block on IPIP decapsul=
ation
      CVE-2026-80842: net: bridge: mcast: fix use-after-free of a master VL=
AN's multicast context
      CVE-2026-80843: xfrm: fix xfrm_state_construct() auth-trunc leak
      CVE-2026-80844: xfrm: ah6: validate routing header segments_left
      CVE-2026-80846: xfrm: drop ESP-in-TCP packets with no ingress device
      CVE-2026-80848: xfrm: espintcp: fix UAF during close
      CVE-2026-80852: tls: device: fix out-of-bounds write in tls_append_fr=
ag()
      CVE-2026-80854: usb: gadget: f_tcm: keep port count until LUN teardow=
n completes
      CVE-2026-80855: fuse: fix invalidate lock leak on open O_TRUNC DAX fa=
ilure
      CVE-2026-80856: fuse: fix invalidate lock leak on setattr writeback f=
ailure
      CVE-2026-80863: RDMA/rxe: Fix OOB in free_rd_atomic_resources()
      CVE-2026-80921: KVM: s390: vsie: zero stale crypto bits
      CVE-2026-80923: xhci: dbgtty: Fix unregister on tty_register_driver()=
 failure
    added commits:
      CIP: Bump version suffix to -cip60 after merge from stable
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
      of: Reimplement of_machine_is_compatible() using of_machine_compatibl=
e_match()
      of: Change of_machine_is_compatible() to return bool
      serial: rsci: Fix symbol namespace of MODULE_IMPORT_NS()

Best regards,
  Nobuhiro


