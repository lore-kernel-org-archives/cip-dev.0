Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F6ACD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 06:06:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9266.1781676379070995545
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 23:06:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=JVrd/097;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1781676366;x=1782885966;bh=
	zVlDCukNLN7RPsLS882RpMeJSYcUO4/WRVSWkBgjjHA=;b=JVrd/097eOUepLw4kH1g1nxKXtt4RV
	PZ0xoZ2kCP8XgGKpDsG9VcaWlux9u1kCQv04ixWzDcJeBlc+QiLlOOdJlhFUrcaALIcC0Vzw/FEAu
	Zi1yvbO5K5/bBXEQI7BquUZC0sRevXeYRT5ag2XNVVYfJaJ7NDJDtWuvHbcSTja8a2TWJFxp+9xGa
	7mHAWlGibPWikA4/ogXkQwqtm7tX2WvdxMfT2JndgF/Rp7rxHrwRc0kFq3FPmHTkTCbMiUfvDCbRd
	cNjLCNBZn4AWDVIDMiqOZN3nAxchaB0azIk3TSgEhdS7viK5dtuybeqPFLjKR4Hilf4VrWsPNuLEs
	IO4A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 65H665mg3731634; Wed, 17 Jun 2026 15:06:05 +0900
X-Iguazu-Qid: 2rWhEh6OXteWlb4FdB
X-Iguazu-QSIG: v=2; s=0; t=1781676365; q=2rWhEh6OXteWlb4FdB; m=ITUKTF/CIlB4WkKsV1i63rWR2g2u5sHECErmBvfEBVs=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4ggCyz3lBKz1xnf; Wed, 17 Jun 2026 15:06:03 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiW4CKsoKwVMx/uagocf+gBZutLnTIYlAiNLnKpUGHWsY4F11armJmvqbXUG4udV5GGx9hsA52IuOC6y4oyicrQVa4yJcjTs3TVdyDM38AaYVffcSBIKGJsnD9KnCR6syqX1HQznO6FgmtHGVa05Sk78rdPG/OFsLnHRcvOovaDM9ukYoeYA6xjn/bPa1WeNwL2tOtPprO0GPRNITDr0u7vulLht9OIT4YkUnpu2staYOosfBVs8QsfZtU7v6hiIRorV5JOLhG1QXxgHJOP+TR2Dyxtg6qBnImrGdOm0Xo9PrOT0ng6noXYthTk6vn81f1yWZrvSSbxkDdBkQ+5oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paCrTmFg+KwZ8L/T5Cvne2bT0zjuAf4xD/ZOZfHfNsM=;
 b=Wh8+eYBWR3SNFPYwWtZ1Vhmv5oYJuorP3cTPYQVvkC9i3T8dFk9tzKAh9XAhTIFhIGz4LH/LUScVTcIwAAZusw5Kt+jmU/Uzv9hXEGWSD29lK+SbiwKa6Zi67xtUnd0FM81CKR/A4dIYVdIuTV0zCdvyFrkK1ZGPE24ideQyLpQghnStMqNuHF+dA+gzrp7ffVd06sPAmj/lKk00/mrPHb4YDyWGq8EW/gCMG9TNA+SEuHjJBQPzWX4TANjTewGKptQSgiZI7fRX4u29IGJJmxxIYwYNlUlH+EF7Kq7SZ/zamLHU2G9ywOMj9CosXLm635sPNgJ8r8k9yqNisWVNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.258-cip74
Thread-Topic: [ANNOUNCE] Release v5.10.258-cip74
Thread-Index: Adz+H0vxUXsj9Z6yTKus2T6+Y6C3jw==
Date: Wed, 17 Jun 2026 06:06:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A053A150979398C28266CDE42@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8418:EE_
x-ms-office365-filtering-correlation-id: 1e0d3734-6d32-48da-0f75-08decc36814f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|38070700021|11063799006|3023799007|56012099006|6133799003;
x-microsoft-antispam-message-info: 
 xeJ4V16/sByw4IrOK3KwuSMAYg2y28RNE7ADRj8qnNHi9mKLLuHOK4Y4WdnUQhG5676DIJAZ62CdQ6w0Qn+CGHxrUMrYfZZlldbiT3rfNmD69lJO/2Lzx1m3onXrDNbNhhx+38BfSbm+uHCkrj8EFEaH2helNhnwcmF7n5Uv+hJvo7NdQ5TnLGf20GtB7+gkGZdmzTCiWy3SXY8WwkcsJHkf29RWuoZkUzALG/s5EckTAybMoRg/nokExhqhNjdOidUfRhjE5N36ozgzyBHOfD633cizbdS8qdViLZtapyl5G+rtmC1PRcIvjaV+4gr2vPWRSdZaLaGHRw9V4mKe7Bk2uBR3vfBQ/guNfI7RdASdSpjRPi0965CzMP59XHxG2ZaCT2oz0s8ZExWihcYNvD4blqa48kGgM08JYAlwlGxsAykZYrhtbDHYf3Q0xQaaAxYmWMLMGYq3BLSwRluxfQiu/LGXMNEhpUNy9MMpl75yoZDOUJooywr0oAhj5qLkNxiRhlApxoSHEKXFvxqk573odVcnUtMIzU6IhL1qfR8uGpQP9WNRxclpidkiKpk2t95wiOzJuUNlt2kjK3ES/ANSzK2mx257PiTl5TZuL7tKJCjQyEj/BI3xZlbstIKJiUljYNIfl1WijjzmQNjvKWUKNRQuW8SHZyA5sMPwqA2xEKoJuhk5wHUvYTeVQink0il40aWKhO2iMAIJoTZOoC9+lEX9EAExzJJfzmefueMT314ATuhW9oCYVXjB3l8w
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(38070700021)(11063799006)(3023799007)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UFdUTDh0cnR3cUYrSzZpZjdQSzRkalFmcFJSUFNNcFFERnA3THR6MGNj?=
 =?iso-2022-jp?B?aGMzUFRFczVCRTN0cS9HY2F2YXV5RzByRzQ5aitYcHMxeCtoMTgrTHdZ?=
 =?iso-2022-jp?B?T0JxMXhmd1FycUdFL3owSUJnMlFURU5yaEhkNFF3cG5JdzBzOXZuUWJY?=
 =?iso-2022-jp?B?YVFWTlYxQUhiT3hSUVBNa2IzQlpZTU51MzhGTnBNSHZiQ1dURnM5QVpL?=
 =?iso-2022-jp?B?ekNQdjZSd1VQSCtVWS9paE9tbkxUTkk3bWtMQnVoRzRqaW5xSTBkRjhP?=
 =?iso-2022-jp?B?NmFXQzVlYnBSMmhuUFVYdU1wRXB0N3M3OTVHSDJScTkvK1dQbzZQNnor?=
 =?iso-2022-jp?B?T3ZBenNJTFVtMExZQUdZQnBibEVlZDBaVlg4OWFlL1RHOG1HbnlCMjB1?=
 =?iso-2022-jp?B?eXVDLy83aTZiWjM3Y1N3YmhENlhUeU9YUnJuRzBVNEkzam1DZldDcXdL?=
 =?iso-2022-jp?B?QzJEN00zZnhrdFJhNXVpSmZvdXVFcnY0Rm1wRVdkY05lYkVBYkErTTEv?=
 =?iso-2022-jp?B?S2dPZUJEbEJNM1p4aHBoZGVMcU9EbWZlM1hHZERTZXQ3eWQ2QkI4QTZm?=
 =?iso-2022-jp?B?bjRiVFhhTTY2eWZOc0lKZEhMVlcyYWlHRGRqR1pMRDdlYTYzMGdZR05G?=
 =?iso-2022-jp?B?UzNPbDdjRnhvOHljU25zbFpKZ2RIUTlQQTlrTmVObVh3TGdYdC9SM1h6?=
 =?iso-2022-jp?B?TFp5T0RUcTI0aCtaM0FtMFJmWWVkWjhzMFh5ajRVMndTczFFeTd0UUtM?=
 =?iso-2022-jp?B?SFYvUEJNS0ZhK0Z2NS9saEQvM0NtRVdEYzhGaVJ5MDV6QUF6encrKzVZ?=
 =?iso-2022-jp?B?QzRHeFgrVElaNFhIUmJ0RHFGMkNub1g3UjZpTDZtYlo5Ull3VnU3cDl3?=
 =?iso-2022-jp?B?dEJHV3FiNmg4OHdUSEZxbUtLbnlyT0ZiK29DbHVYQjE4Nk9TN2NPRDJT?=
 =?iso-2022-jp?B?RjNpL3BNWkdWbzZiR1lXSmI0YzJmZzBjN0tudDRkSjBOSllSa3hnZ2pX?=
 =?iso-2022-jp?B?TEt1QU13SUsxVmQxWmdUQ3ZmbnhZcUFHWXp5aFBSd0M2OW9FdDVWT3dW?=
 =?iso-2022-jp?B?a1IxY2QxWElCY0VxekJRWUREdlVDbDExczcwYy9WK0Q1b2VJVFpFMGlT?=
 =?iso-2022-jp?B?bnVKYjFQcjM0VXc3QkhoVGd3cFhSOU51Y1RHVGlsRVdYQkcwV1g0ejJ0?=
 =?iso-2022-jp?B?eFNsdWhXWm0xTW1sdmZVdUhyclFWT1VxNUFwT2xRSmJmVjVIRXE4Vm1P?=
 =?iso-2022-jp?B?VWNzWkFUZXlub2UwRVpwSHZZaWIwVEF4cGtyejlreFVpVmtKbE8yZGFa?=
 =?iso-2022-jp?B?eVJmUFYvUVROUGpKRlJXWU5scmVBVHlFWXRuWjU5NEczUUk3QStwVjdW?=
 =?iso-2022-jp?B?UmQ5b045Rk8zU0pDNVMya044Snp3cStFRDBlcU5XVnIycDlFUDQ1dzIy?=
 =?iso-2022-jp?B?U1JTTlB4WnlhdjJzUng4aWpUbU9XTHE4NXMrcVUrWjVrRzdVdnFkMHRU?=
 =?iso-2022-jp?B?MFJubmlPaTRYMmJKdXk4TEpaYkswRkhJZXRoRVVsc0pCR01pMU5Nb2Vk?=
 =?iso-2022-jp?B?R2pSYldJWURVcFJDMHVrODl5RURGb2s3T3JjR1I1YzhSZmFGQTZuRTVY?=
 =?iso-2022-jp?B?V05xRzJhdEhWY3M1YmZWN1ljcUY3VVcwZ3lsOWpNNEt5NkZxQ3NlQjJW?=
 =?iso-2022-jp?B?azJBNE9NcUE3K3pBeWJBeUJFZ0NCY3BDc0MxaXg2czROMG1WQmNLbDNR?=
 =?iso-2022-jp?B?L1VXY3pSUGdoNCtqM3ZrcjBBQnFDVW96MUNPWFVLaWl6cDFBQm51OWZm?=
 =?iso-2022-jp?B?ZkltRkNYbEk3aXpVbEJQNko3NExISzJHV3FLV0VhaklxeE1ZY3NhMFB4?=
 =?iso-2022-jp?B?V3A1Z2RDbnB3eEo0c2RoMk95RmxXRWFMejVzaEhEOCs3c0ZHbVB5enNv?=
 =?iso-2022-jp?B?Vnk3Y3V5ek5hY0xRNWNHemd2UVVGU21xbVBYQkNrVFdwZGRuS0JQbjBB?=
 =?iso-2022-jp?B?RzhwT2JySmtQelNyeXRxVVlpV2xqMi80R3NwTS9Xd0lFK0EycDZDUFdC?=
 =?iso-2022-jp?B?U3JUZ3BoTU9JWDJPMkdIaG1ka1FQMytVZTkzai9wWHVzRHp2QU52SUhq?=
 =?iso-2022-jp?B?TkpNaTAybmFKaTlIZGZBR1VaL3R1Y0xheWxGbVIraGtuYnB5RWk5RGRC?=
 =?iso-2022-jp?B?dVRTbGVXRktxRFdiYWw3UnBBR0pGN3JCNG1wVGxqYkQ0SlIyN3RHb21i?=
 =?iso-2022-jp?B?Z1hUa0d3WFVlZkE3RWdhOXlTdFVPSnQwa3ROby81L1ZBb1hjS204MHdZ?=
 =?iso-2022-jp?B?blVkT1I1MnJPaC9mUjcwSmdESGFuRHUxcFl4OTBzMmhTSFdrVStibTMy?=
 =?iso-2022-jp?B?K2xJUTBtcERIVFdJUmpNK1FsRVE4TkpwUXg0NTdwaGs4M3ZYZ1pqRFZq?=
 =?iso-2022-jp?B?MmZwdnZXZ0ZKNjRHZmJWdmoyOUkyUmllNWdUcGEyRURkdXNLb3J1ZFMw?=
 =?iso-2022-jp?B?T016NDVtWkJNTUtMTzB4MkNERWdBUzNrb2RQbHhuZTIyLythclB0TDVs?=
 =?iso-2022-jp?B?eXhZZ0FMWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ZB+91ktT55prNy/yis/hvnNkrG30osWesK2jny20GGL1fddT0tSeq0KlHEPciI7hzCXMtgxs7Mw3CjD++J6QS0CGNq3Te29Emf5d7GFQwiNjuKUdoqhBHN67v4eiBFuyk8aF02+UWdDelovv7MnsR5dUwBJi+D/DS8HBro4PsfJhj78qkqDb7Gxr0cf8vlJt37dsdwaSCJ3iP8Rq/MYtL/rGNfVD1bVgNdbrLOWc7fSKc3Tl5Wpljj0yRiYfJuj2Bc0IunPRf3X6RiY9EkvG9hAjm0O977DNzCX3UyQmaJB1qaW9+8ezXXkphiZ7wRl2Tc/5yYSCfdUGlUq0TUaIDQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0d3734-6d32-48da-0f75-08decc36814f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 06:06:00.2483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3q94H5UV2M7cmPLUenmkxtsK/nWoDse6LtOji5AuAnkTWcqH1FHFWu/uG1T116bZxUXWCAbnZlFYlA5OI+bxRzMIj9x4Yt3O8lMcNLU/tBLrycxhvmcNAih/jWvcQ9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8418
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 06:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23158

Hi all,

CIP kernel team has released Linux kernel v5.10.258-cip74.
The linux-5.10.y-cip tree has been updated base version from v5.10.256 to v=
5.10.258.
This release includes an update to I2C (riic) driver for Renesas ARM SoCs.

Information about this release is as follows:

  v5.10.258-cip74:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      b56d51797ae30c19ebf7a70a94d700bc9af2b549
    fixed CVEs:
      CVE-2026-43503: net: skbuff: propagate shared-frag marker through fra=
g-transfer helpers
      CVE-2026-46300: Fragnesia: the Dirty Frag vulnerability class
      CVE-2021-47188: scsi: ufs: core: Improve SCSI abort handling
      CVE-2022-48703: thermal/int340x_thermal: handle data_vault when the v=
alue is ZERO_SIZE_PTR
      CVE-2022-49135: drm/amd/display: Fix memory leak
      CVE-2022-49158: scsi: qla2xxx: Fix warning message due to adisc being=
 flushed
      CVE-2022-49183: net/sched: act_ct: fix ref leak when switching zones
      CVE-2022-49822: cifs: Fix connections leak when tlink setup failed
      CVE-2022-50073: net: tap: NULL pointer derefence in dev_parse_header_=
protocol when skb->dev is null
      CVE-2022-50472: IB/mad: Don't call to function that might sleep while=
 in atomic context
      CVE-2022-50493: scsi: qla2xxx: Fix crash when I/O abort times out
      CVE-2022-50552: blk-mq: use quiesced elevator switch when reinitializ=
ing queues
      CVE-2023-53133: bpf, sockmap: Fix an infinite loop error when len is =
0 in tcp_bpf_recvmsg_parser()
      CVE-2023-53421: blk-cgroup: Reinit blkg_iostat_set after clearing in =
blkcg_reset_stats()
      CVE-2023-53596: drivers: base: Free devm resources when unregistering=
 a device
      CVE-2024-43902: drm/amd/display: Add null checker before passing vari=
ables
      CVE-2024-53213: net: usb: lan78xx: Fix double free issue with interru=
pt buffer allocation
      CVE-2024-57945: riscv: mm: Fix the out of bound issue of vmemmap addr=
ess
      CVE-2025-22107: net: dsa: sja1105: fix kasan out-of-bounds warning in=
 sja1105_table_delete_entry()
      CVE-2025-38584: padata: Fix pd UAF once and for all
      CVE-2025-38710: gfs2: Validate i_depth for exhash directories
      CVE-2026-23066: rxrpc: Fix recvmsg() unconditional requeue
      CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths
      CVE-2026-23444: wifi: mac80211: always free skb on ieee80211_tx_prepa=
re_skb() failure
      CVE-2026-31407: netfilter: conntrack: add missing netlink policy vali=
dations
      CVE-2026-31532: can: raw: fix ro->uniq use-after-free in raw_rcv()
      CVE-2026-31576: media: hackrf: fix to not free memory after the devic=
e is registered in hackrf_probe()
      CVE-2026-31577: nilfs2: fix NULL i_assoc_inode dereference in nilfs_m=
dt_save_to_shadow_map
      CVE-2026-31578: media: as102: fix to not free memory after the device=
 is registered in as102_usb_probe()
      CVE-2026-31580: bcache: fix cached_dev.sb_bio use-after-free and cras=
h
      CVE-2026-31581: ALSA: 6fire: fix use-after-free on disconnect
      CVE-2026-31583: media: em28xx: fix use-after-free in em28xx_v4l2_open=
()
      CVE-2026-31585: media: vidtv: fix nfeeds state corruption on start_st=
reaming failure
      CVE-2026-31586: KVM: SEV: Protect *all* of sev_mem_enc_register_regio=
n() with kvm->lock
      CVE-2026-31588: KVM: x86: Use scratch field in MMIO fragment to hold =
small write values
      CVE-2026-31590: KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCR=
YPT_REG_REGION
      CVE-2026-31596: ocfs2: handle invalid dinode in ocfs2_group_extend
      CVE-2026-31597: ocfs2: fix use-after-free in ocfs2_fault() when VM_FA=
ULT_RETRY
      CVE-2026-31598: ocfs2: fix possible deadlock between unlink and dio_e=
nd_io_write
      CVE-2026-31599: media: vidtv: fix NULL pointer dereference in vidtv_c=
hannel_pmt_match_sections
      CVE-2026-31602:  ALSA: ctxfi: Limit PTP to a single page
      CVE-2026-31603: staging: sm750fb: fix division by zero in ps_to_hz()
      CVE-2026-31605: fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREEN=
INFO
      CVE-2026-31607:  usbip: validate number_of_packets in usbip_pack_ret_=
submit()
      CVE-2026-31615: usb: gadget: renesas_usb3: validate endpoint index in=
 standard request handlers
      CVE-2026-31616: usb: gadget: f_phonet: fix skb frags[] overflow in pn=
_rx_complete()
      CVE-2026-31617: usb: gadget: f_ncm: validate minimum block_len in ncm=
_unwrap_ntb()
      CVE-2026-31618: fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREE=
NINFO
      CVE-2026-31619: ALSA: fireworks: bound device-supplied status before =
string array lookup
      CVE-2026-31622: NFC: digital: Bounds check NFC-A cascade depth in SDD=
 response handler
      CVE-2026-31623: net: usb: cdc-phonet: fix skb frags[] overflow in rx_=
complete()
      CVE-2026-31624: HID: core: clamp report_size in s32ton() to avoid und=
efined shift
      CVE-2026-31625: HID: alps: fix NULL pointer dereference in alps_raw_e=
vent()
      CVE-2026-31626: staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_ve=
rify()
      CVE-2026-31627: i2c: s3c24xx: check the size of the SMBUS message bef=
ore using it
      CVE-2026-31629: nfc: llcp: add missing return after LLCP_CLOSED check=
s
      CVE-2026-31630: rxrpc: proc: size address buffers for %pISpc output
      CVE-2026-31634: rxrpc: fix reference count leak in rxrpc_server_keyri=
ng()
      CVE-2026-31637: rxrpc: reject undecryptable rxkad response tickets
      CVE-2026-31642: rxrpc: Fix call removal to use RCU safe deletion
      CVE-2026-31656: drm/i915/gt: fix refcount underflow in intel_engine_p=
ark_heartbeat
      CVE-2026-31657: batman-adv: hold claim backbone gateways by reference
      CVE-2026-31664: xfrm: clear trailing padding in build_polexpire()
      CVE-2026-31673: af_unix: read UNIX_DIAG_VFS data under unix_state_loc=
k
      CVE-2026-31676: rxrpc: only handle RESPONSE during service challenge
      CVE-2026-31681: netfilter: xt_multiport: validate range encoding in c=
heckentry
      CVE-2026-31684: net: sched: act_csum: validate nested VLAN headers
      CVE-2026-31685: netfilter: ip6t_eui64: reject invalid MAC header for =
all packets
      CVE-2026-31686: mm/kasan: fix double free for kasan pXds
      CVE-2026-31694: fuse: reject oversized dirents in page cache
      CVE-2026-31696: rxrpc: Fix missing validation of ticket length in non=
-XDR key preparsing
      CVE-2026-31697: crypto: ccp: Don't attempt to copy ID to userspace if=
 PSP command failed
      CVE-2026-31698: crypto: ccp: Don't attempt to copy PDH cert to usersp=
ace if PSP command failed
      CVE-2026-31699: crypto: ccp: Don't attempt to copy CSR to userspace i=
f PSP command failed
      CVE-2026-31701: ALSA: caiaq: take a reference on the USB device in cr=
eate_card()
      CVE-2026-43058: media: vidtv: fix pass-by-value structs causing MSAN =
warnings
      CVE-2026-43075: ocfs2: fix out-of-bounds write in ocfs2_write_end_inl=
ine
      CVE-2026-43076: ocfs2: validate inline data i_size during inode read
      CVE-2026-43080: l2tp: Drop large packets with UDP encap
      CVE-2026-43085: netfilter: nfnetlink_log: initialize nfgenmsg in NLMS=
G_DONE terminator
      CVE-2026-43089: xfrm_user: fix info leak in build_mapping()
      CVE-2026-43093: xsk: tighten UMEM headroom validation to account for =
tailroom and min frame
      CVE-2026-43103: net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      CVE-2026-43104: drm/vc4: Fix a memory leak in hang state error path
      CVE-2026-43105: drm/vc4: Fix memory leak of BO array in hang state
      CVE-2026-43110: wifi: brcmfmac: validate bsscfg indices in IF events
      CVE-2026-43111: HID: roccat: fix use-after-free in roccat_report_even=
t
      CVE-2026-43113: wifi: wl1251: validate packet IDs before indexing tx_=
frames
      CVE-2026-43114: netfilter: nft_set_pipapo_avx2: don't return non-matc=
hing entry on expiry
      CVE-2026-43117: btrfs: tracepoints: get correct superblock from dentr=
y in event btrfs_sync_file()
      CVE-2026-43281: mailbox: Prevent out-of-bounds access in fw_mbox_inde=
x_xlate()
      CVE-2026-43493: crypto: pcrypt - Fix handling of MAY_BACKLOG requests
      CVE-2026-43494: net/rds: reset op_nents when zerocopy page pin fails
      CVE-2026-43496: net/sched: sch_red: Replace direct dequeue call with =
peek and qdisc_dequeue_peeked
      CVE-2026-43497: fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent =
use-after-free
      CVE-2026-43501: ipv6: rpl: reserve mac_len headroom when recompressed=
 SRH grows
      CVE-2026-43502: net/rds: handle zerocopy send cleanup before the mess=
age is queued
      CVE-2026-45834: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_st=
ate_change_cb()
      CVE-2026-45835: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_ne=
w_connection_cb()
      CVE-2026-45836: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_ge=
t_sndtimeo_cb()
      CVE-2026-45838: bpf: fix end-of-list detection in cgroup_storage_get_=
next_key()
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
      CVE-2026-45846: bareudp: fix NULL pointer dereference in bareudp_fill=
_metadata_dst()
      CVE-2026-45986: crypto: ccree - fix a memory leak in cc_mac_digest()
      CVE-2026-45987: KVM: nSVM: Sync interrupt shadow to cached vmcb12 aft=
er VMRUN of L2
      CVE-2026-45994: ibmasm: fix OOB reads in command_file_write due to mi=
ssing size checks
      CVE-2026-46002: ext2: reject inodes with zero i_nlink and valid mode =
in ext2_iget()
      CVE-2026-46004: ALSA: caiaq: Handle probe errors properly
      CVE-2026-46018: ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RA=
TES
      CVE-2026-46019: crypto: atmel-aes - Fix 3-page memory leak in atmel_a=
es_buff_cleanup
      CVE-2026-46022: misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mous=
e_interrupt()
      CVE-2026-46023: dm mirror: fix integer overflow in create_dirty_log()
      CVE-2026-46027: net/smc: avoid early lgr access in smc_clc_wait_msg
      CVE-2026-46033: crypto: authencesn - reject short ahash digests durin=
g instance creation
      CVE-2026-46040: inotify: fix watch count leak when fsnotify_add_inode=
_mark_locked() fails
      CVE-2026-46043: RDMA/rxe: Validate pad and ICRC before payload_size()=
 in rxe_rcv
      CVE-2026-46044: ipmi:ssif: Clean up kthread on errors
      CVE-2026-46046: ext4: fix missing brelse() in ext4_xattr_inode_dec_re=
f_all()
      CVE-2026-46047: net: qrtr: ns: Fix use-after-free in driver remove()
      CVE-2026-46048: ALSA: caiaq: fix usb_dev refcount leak on probe failu=
re
      CVE-2026-46049: ALSA: ctxfi: Add fallback to default RSR for S/PDIF
      CVE-2026-46051: md/raid5: fix soft lockup in retry_aligned_read()
      CVE-2026-46053: net: rds: fix MR cleanup on copy error
      CVE-2026-46064: ibmasm: fix heap over-read in ibmasm_send_i2o_message=
()
      CVE-2026-46070: md/raid5: validate payload size before accessing jour=
nal metadata
      CVE-2026-46077: crypto: atmel-tdes - fix DMA sync direction
      CVE-2026-46080: ocfs2: split transactions in dio completion to avoid =
credit exhaustion
      CVE-2026-46088: ALSA: control: Validate buf_len before strnlen() in s=
nd_ctl_elem_init_enum_names()
      CVE-2026-46098: net: caif: clear client service pointer on teardown
      CVE-2026-46101: netfilter: reject zero shift in nft_bitwise
      CVE-2026-46102: net: strparser: fix skb_head leak in strp_abort_strp(=
)
      CVE-2026-46108: ipmi:si: Return state to normal if message allocation=
 fails
      CVE-2026-46109: usb: ulpi: fix memory leak on ulpi_register() error p=
aths
      CVE-2026-46120: ip6_gre: Use cached t->net in ip6erspan_changelink().
      CVE-2026-46122: wifi: b43: enforce bounds check on firmware key index=
 in b43_rx()
      CVE-2026-46124: isofs: validate block number from NFS file handle in =
isofs_export_iget
      CVE-2026-46127: RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdm=
a_copy_pd_uresp()
      CVE-2026-46128: ipmi: Check event message buffer response for bad dat=
a
      CVE-2026-46132: net: rtnetlink: zero ifla_vf_broadcast to avoid stack=
 infoleak in rtnl_fill_vfinfo
      CVE-2026-46133: RDMA/rxe: Reject unknown opcodes before ICRC processi=
ng
      CVE-2026-46146: ALSA: usb-audio: Avoid potential endless loop in conv=
ert_chmap_v3()
      CVE-2026-46149: scsi: target: configfs: Bound snprintf() return in tg=
_pt_gp_members_show()
      CVE-2026-46150: fanotify: fix false positive on permission events
      CVE-2026-46151: usb: usblp: fix heap leak in IEEE 1284 device ID via =
short response
      CVE-2026-46161: md/raid10: fix divide-by-zero in setup_geo() with zer=
o far_copies
      CVE-2026-46163: wifi: b43legacy: enforce bounds check on firmware key=
 index in RX path
      CVE-2026-46167: usb: usblp: fix uninitialized heap leak via LPGETSTAT=
US ioctl
      CVE-2026-46172: ipv6: xfrm6: release dst on error in xfrm6_rcv_encap(=
)
      CVE-2026-46177: ipmi: Add limits to event and receive message request=
s
      CVE-2026-46178: RDMA/mlx4: Fix resource leak on error in mlx4_ib_crea=
te_srq()
      CVE-2026-46184: sound: ua101: fix division by zero at probe
      CVE-2026-46187: wifi: rsi: fix kthread lifetime race between self-exi=
t and external-stop
      CVE-2026-46189: RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucon=
text() error path
      CVE-2026-46198: batman-adv: fix integer overflow on buff_pos
      CVE-2026-46205: staging: media: atomisp: Disallow all private IOCTLs
      CVE-2026-46206: batman-adv: reject new tp_meter sessions during teard=
own
      CVE-2026-46209: drm/gem: Fix inconsistent plane dimension calculation=
 in drm_gem_fb_init_with_funcs()
      CVE-2026-46212: batman-adv: bla: prevent use-after-free when deleting=
 claims
      CVE-2026-46214: vsock/virtio: fix accept queue count leak on transpor=
t mismatch
      CVE-2026-46219: spi: mpc52xx: fix use-after-free on unbind
      CVE-2026-46220: drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fenc=
e emission
      CVE-2026-46227: sctp: revalidate list cursor after sctp_sendmsg_to_as=
oc() in SCTP_SENDALL
      CVE-2026-46231: batman-adv: bla: put backbone reference on failed cla=
im hash insert
      CVE-2026-46233: batman-adv: bla: only purge non-released claims
      CVE-2026-46234: vsock: fix buffer size clamping order
      CVE-2026-46236: media: rc: xbox_remote: heed DMA restrictions
      CVE-2026-46238: batman-adv: stop caching unowned originator pointers =
in BAT IV
      CVE-2026-46243: smb: client: reject userspace cifs.spnego description=
s
      CVE-2026-46273: ibmveth: Disable GSO for packets with small MSS
      CVE-2026-46275: Bluetooth: hci_uart: fix UAFs and race conditions in =
close and init paths
      CVE-2026-46276: drm/amdgpu: fix zero-size GDS range init on RDNA4
      CVE-2026-46285: mtd: docg3: fix use-after-free in docg3_release()
      CVE-2026-46294: dm: fix a buffer overflow in ioctl processing
      CVE-2026-46301: spi: topcliff-pch: fix use-after-free on unbind
      CVE-2026-46303: isofs: validate Rock Ridge CE continuation extent aga=
inst volume size
      CVE-2026-46304: nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_f=
ree
      CVE-2026-46306: flow_dissector: do not dissect PPPoE PFC frames
      CVE-2026-46307: wifi: ath5k: do not access array OOB
      CVE-2026-46319: net/sched: act_ct: Only release RCU read lock after c=
t_ft
    added commits:
      CIP: Bump version suffix to -cip74 after merge from stable
      i2c: riic: Implement bus recovery
      i2c: riic: Add `riic_bus_barrier()` to check bus availability
      i2c: riic: Use predefined macro and simplify clock tick calculation
      i2c: riic: Mark riic_irqs array as const
      i2c: riic: Use GENMASK() macro for bitmask definitions
      i2c: riic: Use BIT macro consistently
      i2c: riic: Use local `dev` pointer in `dev_err_probe()`
      i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
      i2c: riic: Introduce a separate variable for IRQ

Best regards,
  Nobuhiro


