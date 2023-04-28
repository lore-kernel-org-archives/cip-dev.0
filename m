Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634DC77B61
	for <webhook@archiver.kernel.org>; Fri, 28 Apr 2023 12:38:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.18371.1682685531345529752
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Apr 2023 05:38:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 33SCcTtb023386; Fri, 28 Apr 2023 21:38:29 +0900
X-Iguazu-Qid: 34ts1GHAdUbvN7XNUQ
X-Iguazu-QSIG: v=2; s=0; t=1682685509; q=34ts1GHAdUbvN7XNUQ; m=bczm+04NOhuCujui7O88WS0Nd0APs/Vq8+RguWSl0yM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 33SCcRsc014291
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 28 Apr 2023 21:38:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo3XyQeM5UR9uTI8oT3NH0ku0vAAP1D4GiYUDKcXH4vy38zsOu6RryMYT2fV8ywFztqQycmKGfcsoddYc4vTi3PnGX9sg3jhF/X7rUhFrloO5tOs1SCKXPHItYtp3RhacgfbgudblQ49tz9aJXxIUMXAYPMuBqGtKWv0lYCLnMwpb5EED5bXkTKfY87Qw/exkfCo6F6bJ7yNElDsAto5ITDEeWXcaAojnH1RBGt9GDWeChD6eBvbz4LmEh8FgEy7ELvbKtvIEUr0I8jdUiH79Fcahxa+l7WJl3NJNBW5F0UlBG6nKGRDt/N7TzMJ103zAdZ1CoGARsRxB7QBDgIeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+f6dWdks+Cy1h5AwlbBX0julNKxONmIfEZKq/4vmKQ=;
 b=hLXawv4b7vds0ERU/8f8jG2PNsu9/QAiTdEbk4/ESU07s9W1tMyoNezmtQwx4gPHKYVcIZCDZqNOxPbA99RbNg+qqYhXdWHbsMy4f1kJLgtTSJn7UhZsE8s7As1+z8tiPMCJB5OPNzl01WU3XDV0sYJbyKavf/KLCmRnzHXB13O9CRpkVhU3A574hSXG38FCVsab0FJ1G5AncgrPOu+4P148XvBLuCwrmW/Q1nnSPMQZaZSma48GMVFNovAQ8Z08mkhYvAWpq6TlT6MumzqDinE9UM661D+vI5TepYuA544QFNR7SSgP3FxI7yAopnfc+RlU2+rmGj3m7LFeypopLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.282-cip97 and v5.10.179-cip32
Thread-Topic: [ANNOUNCE] Release v4.19.282-cip97 and v5.10.179-cip32
Thread-Index: Adl5zipP9IhzeXCMQbS72FM6rxMuNw==
Date: Fri, 28 Apr 2023 12:38:24 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94208329022BCA60DD0886BB926B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB12004:EE_
x-ms-office365-filtering-correlation-id: 6a183854-4929-4851-7831-08db47e57573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3a7B2G9U4ow2w0g1tOMXqtdIfpFwAyY4b8MecxZXMGbjG9MHVbLir7PsY702VcFvSa5Qj+Ig4P6CC2DBGCrtLfFl0cuUQbx25w2dhxum6QTQqjmtWPQxCmXRIa4O4alSnE4Y6xtOP1krmOV9zwgi9i+OG5KIq+VY8sJ07n70rrI7dgdDJIqNVJFCwUT8QYrahXCLVBunQ+rmG6CjD5iZqplEMfSEjFLM7FTaTurs7R31N4CEnhqUsfPpUZhmFkBghsqoeefBY2wZ6LojDjOP/iM6ZkO+YrfqvaogXL5wD6Gp+NRJmVTHrCvppdA8vrBZFNlDGJeVildTZ8xTOUT71rl9Rk6V55DMc0mbvOzbCFGHJBdNUOXXUYDIUQo6BZm4OG4NqnNCtzIr+whYwrcHV+GqXK3W8/V3DYL5jQz9V78Uy8EZL/PHv+tfQuoZyuwlaeJG+wqAZSsQ4cvD5RSUv4NZwWfw0uFBI9BSAnupqxF0czr3fMtu6HWzhHpasi5XG+4a2CdOdgCZePMMOrgPe1/m72BpwF4/NQhTwvaDOxl2Q5/W12v6IfAjHZYVqdQB70CFEzXObuCu9FHNofCSLjWWs6LksV9JLMPZ83Dsc3VNFSjdXLC/SuG5gC0AMS7+PUBmK9awC/p28HzPutLtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(7696005)(478600001)(966005)(6916009)(76116006)(64756008)(66946007)(316002)(4326008)(66446008)(66556008)(54906003)(55016003)(66476007)(186003)(26005)(6506007)(71200400001)(9686003)(2906002)(33656002)(41300700001)(8676002)(8936002)(5660300002)(52536014)(122000001)(38100700002)(38070700005)(86362001)(83380400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VjVjN2hmMDBJYThwZUVOemJTZEhGeis3REZBSWVMS2RyaGNmVjVYSHJR?=
 =?iso-2022-jp?B?NnR6MVZHQUhJRzJPU2w0aXZvSmZBRlJZeHZWVDMxTmVVOTNWMTIxY0hu?=
 =?iso-2022-jp?B?cDNMbXltQVdHdTNpc1ZIa3VqRGErcDhnWTFZeUR6VWp0dWFmeU5FSHdh?=
 =?iso-2022-jp?B?L3ozWk1aa2t3eE5FZzJDNElNZHVJcVdubkYvYXIwWDZadU9QUVNpdHZQ?=
 =?iso-2022-jp?B?bktXMEVKU0xYQUFUbmdOSndnd2lkd3k5bzRHNlFXSVp2K0taWmZTTDFK?=
 =?iso-2022-jp?B?a1d0VVBKZ3NJdEdDZ01UNVhNK1pZQVZlK0NXc2E3UUh1YlM3SCtZakFr?=
 =?iso-2022-jp?B?aUxVc0xFdTVqM2RWTjRwcU1iUEtnZmNIT0FzWVcvWHNiNmZuY2Jid1FR?=
 =?iso-2022-jp?B?SEE3bkJxRDZYSmFSOWp0bzZDby9vakVkVXJPVlQ3dGpIbEVWd0N0NERx?=
 =?iso-2022-jp?B?UkY1VjJVcCs4OG9EbHR5SUZYU3dJb04vN0FWbitKLytnbUZldk9KeDFT?=
 =?iso-2022-jp?B?emNOSnpoRGZvc3BOaGpFdzBJdGJKVDJNbys5cXRrNVVpWmVjVUZHRG9q?=
 =?iso-2022-jp?B?UWRobGpXL0ZOdDNpbzd5SkVldWd0TmJseDVWQXZ0T09KR2kyMGJLZjlN?=
 =?iso-2022-jp?B?aWhaREE3bW1wcFBXaWJ6MHNNVE54RHBkVmE2UU4vZ2F2TWo1TE5ZZHlJ?=
 =?iso-2022-jp?B?cFg0VkEwdUVVb0NIS1BoSEJ3NFVaQStMWTU3T3gzQ1djTG1KNWhaOW1j?=
 =?iso-2022-jp?B?T0lleXc1eXhUNjFxZlhqdU4ydXIxQVJqRzN1bkhhVkliTUcvbXlFT2dJ?=
 =?iso-2022-jp?B?Q1BDQU96MlVpM3E5NWgvZzZsTjJSL3JRNGM1NjlUR1BoeUJHNjJsMytT?=
 =?iso-2022-jp?B?aFRYOFJvTlMvWm1OdnlCV3JKaVZTQXpBQk9MS21kK094YVRRNWxaM2Vr?=
 =?iso-2022-jp?B?dnQ3VzZTYko0RENWWHVmbWR2WENzdm0vcFlIMzdvQSttdk9PYktUNHZ6?=
 =?iso-2022-jp?B?Rml3d3QwQzRpbmR5NmZSQmhrMk5Ueklqcy94Zno5YWduMXFsYU5WMTZ2?=
 =?iso-2022-jp?B?WTQxbVdVNGlCS29QYzY0THVuRmxDUlo0T2NhNXJPV2VpTE10VUhFSGx2?=
 =?iso-2022-jp?B?RWx5Vi9YMWtidTdtRjVXek4ybGszQnRRYVQzT2V5cU50eEZqM1dNL0E0?=
 =?iso-2022-jp?B?dzRaUjBsVFQ2a2tXYkp3NlozWUcwd2l1c0ZNNWNEMWczM0RXdTR4ckFs?=
 =?iso-2022-jp?B?ak9mRFgrOVhMaWJrOGZlTnpsS3BVV25LT3JnQ1RBdUxQendxM1hRNENS?=
 =?iso-2022-jp?B?b2lDWDJ4a3JvNDdVdDBWSU5yQ0w5R2NlRnZzOVAydHZZQ1dWUWwyQVB2?=
 =?iso-2022-jp?B?dzlwY0xnY2xaZkZjU0JkNlNQL2lKUzl1SllZQUpFVnBZREFzN1NVLy9q?=
 =?iso-2022-jp?B?eWhaUlVnNFdxK2U5REptMmNXNTdTUGk5WWFoTm16ZnU1MGdiZnlmQUJx?=
 =?iso-2022-jp?B?eThMM1IyWnNiN1g2Z1ZvbmRrUE90dnJRc1ZkbEp4SHlIQUI1cG1JbkVV?=
 =?iso-2022-jp?B?bnBBWE9pM01objAvV2FhSmlkRWlXT2ZlTEtmQ1Y0NUVrR0FsOVRyb3Fj?=
 =?iso-2022-jp?B?TmRRek5kaUU2endKVW4xQkQxdU1PWWpCWUY4TCt0NkhtOGxTZ1NSNW14?=
 =?iso-2022-jp?B?N0dkS0cyWXBGNkhSdkJrSkxCRVZEcTRDUHQ2TWpZaWUwZUY1eWJxSTNt?=
 =?iso-2022-jp?B?bmp4UFJ4cnhsU2JBd2w5TWpPUnpmOWgzL3ZJTXFWZTNtS21SNUVwVEdL?=
 =?iso-2022-jp?B?SEI2bytOUzVWdEZPb3JPa2ZYMTNOWVNjaXlHUktDeXQ0SnR0Qk9qTUNG?=
 =?iso-2022-jp?B?NzVHTkZGd3FNVElheUtvd0ovOVhFZlIvZ3lGdTBDWVFhZWZrY2N1NUN0?=
 =?iso-2022-jp?B?VTduZDdMM3lmcXF1dmh5Z2JxV1I1ZitUQWpGRENoREpubXJ3dWVLVUpr?=
 =?iso-2022-jp?B?NnRFdnBGVVFpSUZVZ1BtZkV1MFZZMzAwQXdwaHZoM2ZtMzBHM2EwY1Yw?=
 =?iso-2022-jp?B?VnB2cTh2RDltR1VKY2dMRm5mVW9ua2V4dU5SL1czN1hiU2YvTUgva3Bz?=
 =?iso-2022-jp?B?NnM4SWRKTFpBdUYzUnhaRzRkZ0RsRldkZzQwZ0krV3pZNE1IYzlhemY1?=
 =?iso-2022-jp?B?RVhBT3k1bzBkNnY4TEZoTmxMS0FFbTFCZ2xueWgxVG5FSE5WT1VwckhY?=
 =?iso-2022-jp?B?MVFoblJ1WjdlYnArbTk2ellWQVYrRVgvNm11eWZUOUxuYnYrQmV5S051?=
 =?iso-2022-jp?B?OXB5M21KSklvRHpRZUY3amo5bVJ1YjNRRHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a183854-4929-4851-7831-08db47e57573
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 12:38:24.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gh+i/byEiVuY77QJo+ACge5tY5Taq6c7AXr39u3dzYhkgmM79E190ByjI85MOmIFW86PnIURc6ct145dgsW82oMddQZgygjoGEAy5UwSyA/g7ScgUOYvuQLicxQbRX+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12004
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Apr 2023 12:38:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11370

Hi all,

CIP kernel team has released Linux kernel v4.19.282-cip97 and v5.10.179-cip=
32.
The linux-4.19.y-cip tree has been updated base version from v4.19.280 to v=
4.19.282, and
the linux-5.10.y-cip tree has been updated base version from v5.10.177 to v=
5.10.179.
And in this 5.10.y-cip update, the patches related to RZ/V2M SoC and this S=
oC EVK Board
are backported.

You can get this release via the git tree at:

  v4.19.282-cip97:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      2806abebc536fd0cfae1a365ce76816febe69606
    fixed CVEs:
      CVE-2023-31436: net: sched: sch_qfq: prevent slab-out-of-bounds in qf=
q_activate_agg
      CVE-2023-30456: KVM: nVMX: add missing consistency checks for CR0 and=
 CR4
      CVE-2023-1859: 9p/xen: Fix use after free bug in xen_9pfs_front_remov=
e due  to race condition
    added commits:
      CIP: Bump version suffix to -cip97 after merge from stable

  v5.10.179-cip32:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      113faaf50d23879378cb772597f4d6fdb1f4cc20
    fixed CVEs:
      CVE-2023-31436: net: sched: sch_qfq: prevent slab-out-of-bounds in qf=
q_activate_agg
      CVE-2023-1859: 9p/xen: Fix use after free bug in xen_9pfs_front_remov=
e due  to race condition
    added commits:
      CIP: Bump version suffix to -cip32 after merge from stable
      arm64: dts: renesas: r9a09g011: Add pinctrl node
      pinctrl: renesas: Add RZ/V2M pin and gpio controller driver
      pinctrl: renesas: Select PINCTRL_RZG2L if ARCH_RZG2L is enabled
      dt-bindings: pinctrl: Add DT bindings for Renesas RZ/V2M pinctrl
      clk: renesas: r9a09g011: Add PFC clock and reset entries
      arm64: dts: renesas: rzv2mevk2: Enable ethernet
      arm64: dts: renesas: r9a09g011: Add ethernet nodes
      ravb: Add support for RZ/V2M
      ravb: Use separate clock for gPTP
      ravb: Support separate Line0 (Desc), Line1 (Err) and Line2 (Mgmt) irq=
s
      ravb: Separate handling of irq enable/disable regs into feature
      dt-bindings: net: renesas,etheravb: Document RZ/V2M SoC
      arm64: dts: renesas: Add initial device tree for RZ/V2M EVK
      arm64: dts: renesas: Add initial DTSI for RZ/V2M SoC
      clk: renesas: r9a09g011: Add eth clock and reset entries
      clk: renesas: Add RZ/V2M support using the rzg2l driver
      clk: renesas: rzg2l: Add support for RZ/V2M reset monitor reg
      clk: renesas: rzg2l: Make use of CLK_MON registers optional
      clk: renesas: rzg2l: Set HIWORD mask for all mux and dividers
      clk: renesas: rzg2l: Add read only versions of the clk macros
      clk: renesas: rzg2l: Move the DEF_MUX array size calc into the macro
      dt-bindings: clock: renesas,rzg2l: Document RZ/V2M SoC
      dt-bindings: clock: Add r9a09g011 CPG Clock Definitions
      arm64: defconfig: Enable Renesas RZ/V2M SoC
      soc: renesas: Add RZ/V2M (R9A09G011) config option
      soc: renesas: Identify RZ/V2M SoC
      dt-bindings: arm: renesas: Document Renesas RZ/V2M System Configurati=
on
      dt-bindings: arm: renesas: Document Renesas RZ/V2M SoC and EVK board
      serial: 8250: Make SERIAL_8250_EM available for arm64 systems
      serial: 8250: SERIAL_8250_EM should depend on ARCH_RENESAS
      serial: 8250: extend compile-test coverage
      dt-bindings: serial: renesas,em-uart: Add RZ/V2M clock to access the =
registers
      dt-bindings: serial: renesas,em-uart: Document r9a09g011 bindings

Best regards,
   Nobuhiro



