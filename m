Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712ACD495F
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 07:04:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.10285.1695279834490131915
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 00:03:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38L73UoK1441405; Thu, 21 Sep 2023 16:03:31 +0900
X-Iguazu-Qid: 2rWgyA9op6qzw1qajb
X-Iguazu-QSIG: v=2; s=0; t=1695279810; q=2rWgyA9op6qzw1qajb; m=U1JwrNY8ml42diMD0CDKakcj8khCh+TzpPXj3JD4cjs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 38L73Qba2533107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Sep 2023 16:03:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1QOxjJ31gxq9j45cdRS66xJhuuacJaQYIT8OO7sN6qBy5xeyVnrhWzQc2wWKeMSmax2LUKGa0MyvBgywPYVEgtLBJm/Ycjh7efkR20Fqz1LKatFKv6btkWn664D8SN4F0aababgSEQEXsQ498FHp8LWu7EEAzBSWB2LADSIeH9zoC3ZFX2oZ2cnaAJujN7ep8vMV+o2sncZAa3xlH1+4gdP/nvvr/ytehDL+6Z6hAXZGLK0mDHP+VKlWYRlHX31re4UAR9lhdPpjPckh0mV/2XY0nh72sLZav1xQAxo3rTtaAHnCNhofzn4sMdKuNh5NkdJIFR8f7azIsRs4QpCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qV2LrBHawQhIG3ydinzuj1HULyk+sN2q0cp9zNuroQ=;
 b=WP9zhiSgTPgZi0NE96TLPrj/lBr86enQz/HuioOQFCJBIXG9jRk7z9mbfY05inSQuW3sf5D8h/3K18oQX+LtcytPYIqeBSrRFnSmFgkoY5dtaF4pNLwLInNub0piuTqgitZiQgJg23mpJ9uU8gljEUiImZUjNq+NZ5/Mb8nxGmU0DALkuEhVccXhPUdV+azxNU63fjluYPSjlCi0SouHebPouJTpdC2BC6+4Eucx73X8tFR7j3W271JeX7ymQP5PrCteR0cmJGn8nsoqLUPLO/FxvObLinthqcYcgbcq67Ufxwbr2glTnRBWdDHxnSO1qStuQF/iIRc1JQpe6Aw9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <uli@fpond.eu>, <pavel@denx.de>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.1.54-cip6
Thread-Topic: [ANNOUNCE] Release v6.1.54-cip6
Thread-Index: AdnsWU36SKlM3T8+SrCY8URFBR7hjA==
Date: Thu, 21 Sep 2023 07:03:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94209C6022E8D47449CE068B92F8A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB11041:EE_
x-ms-office365-filtering-correlation-id: 74ae82d3-2c31-4a05-777d-08dbba70d902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uqN5TZIcNyAeW9bDGvzIT4s72LAQ1uVxAbaV1IbFq4QETl6MJG2JWFGDoAO7UttRf/0Hgpwp0eVq93pA9LYARpguQ6dmKtFxcqcBT9T5Yk1nQ1+Lz4W22s1fnxfXtpXukS8QhG0TK40Som0Qvh9TuyU2ePbG2riCvNwtVWKH0a1D8Rzyj//u5IhDqhG0pQ8qQF/jN1g1mgeIgCsg60EDHAp7iz1T+Moovtw4s4Px8E0Jiemvusj7gJvHUpl4u7qbT12J/zmfSf4KTvwnUtFG45xiz/3m60IBrLKrd7eRobeLUfwmjZlwtEuEi3cD0Vj9/aWobuLmEblp0iQCznehOsWCg+vYDJ4UEGDLv1SVMJtrLM9ZcRKIXJFShrsw6qHzO/O2NJ1peJXkDGL7bxdjVXaGGc4592G6LxUc92BaiYGxSqYFU5H4iiZA26PpYqelbI8UCO0j6AZtOTbozlV7GNfPDZjHGSYWw6+8K7iBYHxi41QZH+3PBRrHKwFbFOgTq7l+yA0/uxDice+WvrUKdvzu5aqGpXzrPASrXhaM1lbM1zYuIKpuC3YMUmp3OH0iM7GZYj074YQuELtSz2GUFFUbVhC4tDm1TIrb+1LQdJjaHRnjUKdPiohbJY9WsuK9
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199024)(186009)(1800799009)(66476007)(55016003)(33656002)(2906002)(86362001)(38100700002)(38070700005)(5660300002)(8936002)(122000001)(8676002)(6916009)(4326008)(54906003)(52536014)(41300700001)(316002)(76116006)(64756008)(66446008)(66946007)(66556008)(83380400001)(71200400001)(966005)(478600001)(9686003)(6506007)(7696005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ek0weS9WdW9MRFk2RVlUN0VlUWZFcXE0SG0zdkIwQTVkVjZlSEtoMXEv?=
 =?iso-2022-jp?B?Ry9QUGN4Q1BxOGdDUUN6MTdwWHVldnN3ME5GTjM4Y2xLdHFhSEFKV0w3?=
 =?iso-2022-jp?B?ak5US0p4a05jdUc4VytES2xaTFhHays4aHlEazhGVFE5SzR0Q054K2hF?=
 =?iso-2022-jp?B?OENDaXBmejY5Y3hxRlRkbkh3U284Q1BUTXJka3Vuc3YxOWVTNDBTdW9T?=
 =?iso-2022-jp?B?bm5NZmVJK2YzYWsrSVVsKzdnTkFlelFrWUdkSVhFcmNadW12ZDI5ZXNZ?=
 =?iso-2022-jp?B?ekFKeG1FOUFhOHd4VjRyYVpqMDVaVjJlZG1JRldDNmxLQkY2U2ZtcGpk?=
 =?iso-2022-jp?B?UGkrb0s5TFAvbTRhZDlkckkwZEx3TlBlOERHNWtRQ3lsN2x0SUJtcE5G?=
 =?iso-2022-jp?B?azNGYWtmQkZHQmZLNzkxeExXR2xnRnBrTm40azdJWXRyNEZMNWprTEVE?=
 =?iso-2022-jp?B?bE4vK0syUGhDV244N2ZnK1VoVDFUYXUxZFFIZGtHOUVvbkNFNU8rTkxi?=
 =?iso-2022-jp?B?Sm5KcnJhS1FwMy9hbHZjZGhZK05Mc3hYR1J5TjlqV1lLQ1d2OUhDcm9L?=
 =?iso-2022-jp?B?dnBqYXlkMVVsK0U3b3h2K0IxRllRcTl2S2sxd091Rm1mY1lpTzVod1Q3?=
 =?iso-2022-jp?B?L3hGeWtsM25pVjEwdnh3Ym1NbWhybGxqTCtESUZQTW1rZnY2YmQ4WEZ3?=
 =?iso-2022-jp?B?VStzVnJ5aTV1Qy9icVZiY01ZLzFiNlpNbVFydXhnUnhPMlpIMlUyakFz?=
 =?iso-2022-jp?B?YUxYd3VLakx2bjZ4cUlsTmc3Q0FaQ3VjTGJSNXFSM1pYdnJ6c0VuZHpG?=
 =?iso-2022-jp?B?ZkxVYlJFZ3lYVmM5UmZPRGNNTXdSMGZGdTRpUU9XLzRqc3VUZk96Zjg3?=
 =?iso-2022-jp?B?L3dMK2tWUldzNXc3QUpvdnZXU2NFYlZzT3o2YjVVWGQzcWZQSXNLYTRn?=
 =?iso-2022-jp?B?S3JabEZrYlZBc3BKZmoyKzQxVWZKS2tiTUdEbyt6RUpubXBQdUd4WXFh?=
 =?iso-2022-jp?B?dEwxV0tqK3ZOYkw2WDBrRlFOQzZtQWpxSXBqb1JsZVdXOWxwcmlNVG9U?=
 =?iso-2022-jp?B?d21hTkNNV3RhQUt0UEFHZE1Jb0ExRllxeE5HV2pCWUlEM1NveTZLQ3VY?=
 =?iso-2022-jp?B?K1hQS3JqeW5ERHNGTUZBRC9aWElEaDZzUG43Uk5JVVZ0NEZhNjFQKzRy?=
 =?iso-2022-jp?B?Wm43OXhnemVrbTdhdG8zTnVqdWoxZms2djZPaUhZMlV5cmlDekdNdG9L?=
 =?iso-2022-jp?B?SUJKVXNoYys5OHJaRmVYNTFaZkZEVExYTGh2Y1NZTmVmYjFhb2RGSi8z?=
 =?iso-2022-jp?B?cEtYNVpYVEcrOHNrby8yMmJySXlsYnRkZlZTaXNZbWhNenNaVnFOVXVE?=
 =?iso-2022-jp?B?a3lyY3FQR2hKaXdUVURWWUJJTGYyampHNzgwMzk5UzFUYkE2NTZVVlQz?=
 =?iso-2022-jp?B?akNLRnJTNXh0NU1kWHNBZGVodElwS0hhdEc4KzBUcUQ3VWVyQ0VUUDZp?=
 =?iso-2022-jp?B?aGFuOGFpdkRVUkpHZStQaWlPV050bVN0U2FpWmNYeHM2KzZ6dksxYXB5?=
 =?iso-2022-jp?B?YmhwU1I3cEFFSW9LUWQ1eE91L1lQODNkRWRlZkM0aUhjMitUaU9kcmlL?=
 =?iso-2022-jp?B?M1ZXR3d1cFN0QWRUeVBaeDBqTFliNWpydTRJdE1VRlBtZFFtdzduN0Vi?=
 =?iso-2022-jp?B?UDJmQ3hrS3JLZk85T0NINHlNazZ2ckQxUnZHUzlKWnRUSEc3UlBPNFor?=
 =?iso-2022-jp?B?MklMZy9iVllJQzRDdHZ2alNpckx6NnZ6YThyWlpqeWJJcmJMYkg1amJ3?=
 =?iso-2022-jp?B?Y0Jld1J6UDZYcmVZSm02RVBUZ3JBalBsM2dycEdrMFNMb0VieW1XcWsw?=
 =?iso-2022-jp?B?NE5UOVlNSmFtY2lDNWROOXgzZDREWWM5WmtnMFVpSjJWam5SR3BDVE1I?=
 =?iso-2022-jp?B?NEVPYTZoemt5NjUzQzdaSjA4NStCNERKcWxBZUdJSmZaSjh5cHluRng3?=
 =?iso-2022-jp?B?UWR3cXVhb2huY2R6ZWRYVnVocktXZFE2VmQ1dmFRRkpiZU5MT3lhQm1Q?=
 =?iso-2022-jp?B?QmwwTFJLblRKVDBKTWdSYnEvOHI0Um4rMDErS2RIRXBRaG5EMW5Sa2s2?=
 =?iso-2022-jp?B?V2xybXkvdi9VMkp5VkhiQmZQa0xhU3poeHhNbzJPL2pKNTU1c3VQZVFh?=
 =?iso-2022-jp?B?SWZtSDV3NW11VTVXNzE4RHRNcDRPUTE1S1lXTndaaXNFUkltbzhlckZM?=
 =?iso-2022-jp?B?Ukl2UXdPZnNHd3EwUEtpZWFuT2tPbUp6Zi9SUEJaR1hYaXZ3Rllvcnp6?=
 =?iso-2022-jp?B?RDFySWxFSVdLRkpMSDI4Mk1RNHFMM3k3bXJqdWdVc0lWTSszSWg0QjVZ?=
 =?iso-2022-jp?B?ZHFJdG10akR1V0dGZDZHRFRySmEybml3M2U0RGtMQVJlalBqZDRLVVFp?=
 =?iso-2022-jp?B?MUMyVVV0bGVHVkh3M0ozbFhydi9RR0o5dmxRPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ae82d3-2c31-4a05-777d-08dbba70d902
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 07:03:24.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4A7n0kN6KYPfF1mlrXhUdVAx8P7LCqF8+Rh6BhkgedQceLtovRPPCekbt+X3l1dWc8xwGFuNZtnD4He+28dNSJiJDBNBobgeqaeJ94Tfzr3iXMAqxZ9ZJuSWMvP+ynq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11041
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 07:04:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13184

Hi all,

CIP kernel team has released Linux kernel  and  and v6.1.54-cip6.
The linux-6.1.y-cip tree has been updated base version from v6.1.52 to v6.1=
.54.
And this release includes MFD, RTC and MTU3's patches and bug fixes for Ren=
esas
ARM64 SoC.

  v6.1.54-cip6:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      5f8461a2ec855187b1bab7e4aa419338772fe9bc
    Fixed CVEs:
      CVE-2023-42752: integer overflows in kmalloc_reserve()
      CVE-2023-37453: i out-of-bounds in read_descriptors in drivers/usb/co=
re/sysfs
      CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc cur=
ve
      CVE-2023-25775: Improper access control in the Intel(R) Ethernet Cont=
roller RDMA ....
      CVE-2023-42752: integer overflows in kmalloc_reserve()
      CVE-2023-4921: net: sched: sch_qfq: Fix UAF in qfq_dequeue()
      CVE-2023-4881: netfilter: nftables: exthdr: fix 4-byte stack OOB writ=
e
    added commits:
      CIP: Bump version suffix to -cip6 after merge from stable
      arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
      arm64: dts: renesas: r9a07g043: Add MTU3a node
      arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
      arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
      arm64: defconfig: Enable Renesas MTU3a PWM config
      pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described
      counter: rz-mtu3-cnt: Reorder locking sequence for consistency
      Documentation: ABI: sysfs-bus-counter: Fix indentation
      mfd: rz-mtu3: Replace raw_spin_lock->spin_lock()
      mfd: rz-mtu3: Reduce critical sections
      mfd: rz-mtu3: Link time dependencies
      mfd: rz-mtu3: Fix COMPILE_TEST build error
      clk: renesas: r9a07g043: Add MTU3a clock and reset entry
      dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
      arm64: dts: renesas: rzg2lc-smarc-som: Enable PMIC and built-in RTC
      arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support for =
ETH0
      arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
      arm64: defconfig: Enable PMIC RAA215300 and RTC ISL 1208 configs
      rtc: isl1208: Fix incorrect logic in isl1208_set_xtoscb()
      rtc: isl1208: Simplify probe()
      regulator: raa215300: Add missing blank space
      regulator: raa215300: Change rate from 32000->32768
      regulator: raa215300: Add const definition
      regulator: raa215300: Fix resource leak in case of error
      regulator: raa215300: Change the scope of the variables {clkin_name, =
xin_name}
      regulator: raa215300: Update help description
      i2c: Add i2c_get_match_data()

Best regards,
   Nobuhiro



