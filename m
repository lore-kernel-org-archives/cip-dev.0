Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F2C0502C
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.5830.1661987930021799456
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 16:18:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 27VNIS5t021311;
 Thu, 1 Sep 2022 08:18:28 +0900
X-Iguazu-Qid: 2wGqsxJV6HK1Ax1Hnv
X-Iguazu-QSIG: v=2; s=0; t=1661987908; q=2wGqsxJV6HK1Ax1Hnv;
 m=Ped5xXz04J0fOgBxESQv5U1b3q/js6VQO0BeYTKYb8g=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 27VNIOPq008264
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Sep 2022 08:18:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFPU2XFrm/r0cs3FVxASscfzs/MTp/yY+1UKQ1GFMWclicL5iFBF2UUO4dIPMp0XEIIOL9MxWcNFT7EsVbyBFZzDbCpiT5pLDGpZBHZ/MwkejnyXz/mpGHbsgVuAvTfJ2lmoUhidODidDDAohfLxyKh1XiV6GyZinbb6r/S5WyUKOqRuVjUUB7qXTuQJsZAMQAw/4xW0i0t4TBk76bGbwW72GvjWn+mCGp4v9EyxgNw5zxtguZ2pGYKt+axLub8kBGg+Djc43uP+ppB/kw1PP26zNSgwcznijB42rwN0QDnSK9jKUo5oF4lABRUcpWDafCjNPNGVmO/xKpkIwcOkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EGKmBbj/vabrxYCSK+3LqwlDq/crxdY7s0JZVXp8SQ=;
 b=NoZ2cP8pzgvN61iqFMijyGrhz1jRDUNnKEVKPz2cy21XY7NqJGzOXOHmhX+LTPK2RyNlgJ1w6Oy6iTzGDs2QAUU7mW4VYoymW6j5BlJ20N6/Th2Sje4r301PVnawfQz0bI2RzPT6XYofOEon6xJflMwCxXyTWg/UTm79sfZSJ2d1qCeJw6xFXT5DVAuDabdIo33RLPmxLISEBIt4sGyN1FPjGcQF+n3mfkSB5pBXvKBBQHkPy+EQlxwkoQUd5UP1s2vRWi3sHiY+q8FixF8fg/ie6uvSFhgS9xl1yEfd2cUSzetNlC1qkS7Y9i+UH94SNR1xSj9r6kJ2ZoX7IXvM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <uli@fpond.eu>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.256-cip80 and v5.10.138-cip15
Thread-Topic: [ANNOUNCE] Release v4.19.256-cip80 and v5.10.138-cip15
Thread-Index: Adi9j8wNln5z4rP1SZOCH0tmWwQUmQ==
Date: Wed, 31 Aug 2022 23:18:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420E9E1F771CBB3FD62E72392789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21a913cf-3f59-4c45-76b8-08da8ba71931
x-ms-traffictypediagnostic: OS3PR01MB8875:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8W8bSCPuXRCp4dTsjcmC4iNhrl/gaVHbu2YnqzDQT+EbS3YjhPAsilodAg75IchvB8naKptbEYB6HRWQRlfy6x+pPZICsJPqGymFjn4+SUmDSTujn4qFQrHHUqpJS2qiwwWWzwFDZxt5qOPBedAzkrUR3m9ZyhkJ17Xg5OWmXy+VLtoM2C9ZgEc37EE5JUR4WsUZEVdyxi0uOTr5q61y1uM4TPPRqX0jmHhSAS+ijsyFFcPcxMKv/qcmXNLd3vshQrnvjymps7BwiVuFsCG7SW5QijjMdTaFoGHLUSYxeAY3/dVZoSrM6CgBYhM9+z4QS6wTQFwAMKlZXi0xs0tZzyGeVUVj3yfSKG5cohxhRKEOos9qCXqUTP+DRhBZqlcf/S7Tik967BHwWe0odRYL0hWoooWFLr1IDvuWVrRXnMDSCV9MBXJMNwExYdnbZnFL85CBnWtmn99qhD8lYy9liiFaxJUUeWozuhVsl8zqm7pevANGl1AooKCaAssdKDM94cME/1J1YPW0e2vAedPymkNM8NqJX/Wvz3A6JUEPPoUupPYcw6h+Agqk+zaJviYyeFY4hvbCT6jejM775AOVqd9TLLkZpjEh4Jvbq0mBM6YqxVZ9C6sWCRU8UzxHXrtjV3BcJ2Gcq8+8pSZ0XkXegpbiHPESq5+XbXfNJZKmUDY12FSbI+c8oD5Joj1bGn+ETfV4Fx9LipAU+jKDfN+UtivMrAirrePindBM7/a5fM3NvPX8MIUHv2kstV5pJ5Nvts9okEx+WNn+d/qIw7KyAJKaIlW6QKUrjqgdF+wG6bM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(26005)(9686003)(86362001)(38070700005)(33656002)(186003)(41300700001)(83380400001)(7696005)(6506007)(6916009)(54906003)(71200400001)(55016003)(4326008)(66556008)(66476007)(8676002)(66446008)(966005)(76116006)(64756008)(316002)(478600001)(122000001)(66946007)(38100700002)(2906002)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZnE4eUN4OXlCQ3ppenUyVFRuUUNybW04cVB3enhxZ0MvRkFObXpScnJY?=
 =?iso-2022-jp?B?WmN4VWxQeGUrakRKSFg4bXBTdm5oSUhIV1NyVzNyZGdJWDRGaUlaM0FK?=
 =?iso-2022-jp?B?VTNtTTNUUTNtRS9pNnI4b2ZRelprcERVTy90YlJ5a0U3aHNkbDVGbE1D?=
 =?iso-2022-jp?B?cEY0aHRlUnNiNkQyVU1OcHcxNTY1OG8yNFdQdDJHWWdZcmFueWJ5Qktw?=
 =?iso-2022-jp?B?WlRMMHdmYjNSb01DQnVCSHRycWFQWHB5YXMvQzZTdzJZR1MyNVVFWkJK?=
 =?iso-2022-jp?B?c1hBMmZtMkp3MjZwZjBVeUlxbU8xbFRoaW1kRElNb3FYeG9QOW9jQ2x0?=
 =?iso-2022-jp?B?c09JalU2czUvN2gxL1FEd0NXMVhseFB0TXRBYkZJYjJqd2FLa3ltbWtV?=
 =?iso-2022-jp?B?UGw2NExibWl6NU5rSHRnZEVPTGgxQ1NqL0dmenFiMm1XRUVBYnRuUE9t?=
 =?iso-2022-jp?B?M0phdE8vVHJKZ0pTeVFQalppODJCZDkzTC9OSVlsUktsbWt4eWsvNnpi?=
 =?iso-2022-jp?B?VkVubVEyeXNsMmJUYnZNSVd0bDJET0NPUkwvNk9PRkg0b3dlWnEwY21u?=
 =?iso-2022-jp?B?dklRbkxaNEk1Mm9EL0J5TVJPVE5xY2ZWVVlOdmlLemVlWG9NM1h1SWVQ?=
 =?iso-2022-jp?B?dkwvVUhhUjVHS1U5eDAzYnBHaHB0SGM4QWtLYXk4eUtsSTg4eE1vR05F?=
 =?iso-2022-jp?B?YVYwQnpBZkdlRmg3aTdzVGhPdUNUOE5wR2pNRzk2ZEMwRFVMZjZQWnFH?=
 =?iso-2022-jp?B?b0lpM2RjZlRwT3ZlamFBc081OTNKSGluVTdPYkVRbTVVOWZSRDFvL0Nt?=
 =?iso-2022-jp?B?bmRlQlowbG14NEdudHNrNHFYbExEbFVGNGNnSm1WRnBPV1FIQ3p0SWdz?=
 =?iso-2022-jp?B?QTJqQUZwdWhVeE9QdlNjVGtVUis3Q1RHNktYLzMraWRIdXZSTDN2YW5l?=
 =?iso-2022-jp?B?NVd3UjVWWTZCN0FOakRESkZoOVllVGFrV0ptM2FTWDJCd1ZmK29NWHc0?=
 =?iso-2022-jp?B?ZTltZC9QMWtWNVhHSTM4YWZIM3k3dDQwRkFtTFk1VG5paCs2TjFoVGJL?=
 =?iso-2022-jp?B?VHZzTm5tc09XMW9CNytIMFFhcUhKdTR5cVpzUjdQWUpwZmMrM2pCbmtN?=
 =?iso-2022-jp?B?OWg1eTVHS0p6SWRCZUNQWVBPYjhnTFlhQTVhbUdDQzJXQ3FsVTc0UHE0?=
 =?iso-2022-jp?B?SnorY2RBVDYzUjVhRlNUSmJLVm15clZTT1EwT1psYTYxL3gzNDhERjYr?=
 =?iso-2022-jp?B?TzBsUnd0NVNJNktCNUx5bTJCc2VFc05KTFNYVVN1MU8yMXhSUFFFSXU5?=
 =?iso-2022-jp?B?USt0aHVnRmNQK3Z1QXZiYkJhdUI1enJQNWJ1dy8zSEpPbCtlNS9wSWlv?=
 =?iso-2022-jp?B?Y0dNenFQS1owVXNMbkVBcW81YzZ5eXpBVU0rRVJXQWZDUEw3a2RVSHAy?=
 =?iso-2022-jp?B?RzhzMzlWV2VMdDdGYktpYThHTVhZcEFDdFJTenRZRGpaUmZ0RDlva3hF?=
 =?iso-2022-jp?B?Z0ZFR2c1bGIzRUcyQU1IQk0xdy8xUUVsdkYvNmVKWTRDdEwyWlVtd0t4?=
 =?iso-2022-jp?B?NkJZWlBPcFpBd3RIOU9NbEZaM0YyVStXVW42MTdhcHhQK2JMTDZrdjNP?=
 =?iso-2022-jp?B?TXE1bk0zaE5yQ2czdTJhSzI2WXFKck9SLzZ1SC9vMlVxS05jRFpwWkNz?=
 =?iso-2022-jp?B?cHBkWjhZME5qWmEzQzRNaWlpNDhrU3Q2OGJxdk5kRUpIMWJyNHZYYWwx?=
 =?iso-2022-jp?B?YTF5UnZBREtldmkvZ20vaTUwRGEvSkd4UzRQZVRVRXp0VzRudEx3L1RD?=
 =?iso-2022-jp?B?b3FadGt1dCtlNWFZYU5Pb3FCcmMrdHFhcUExSlNBYUNBdDRvclUxTWpn?=
 =?iso-2022-jp?B?bTJJM1phNDBQcndTVnk5bXhmQUR2MFAyTTRYRUJrRjhxNFZQcjhxNWtv?=
 =?iso-2022-jp?B?Y21XSStlanRmWVRWR0p4NGthKytNV290N0o0KzlDYk1QamxVcHdUWUFx?=
 =?iso-2022-jp?B?NlJMaWtDYVp6UjlEWW1rWHJxR2tCSUtua3preDlZVlpkMWhYU1NLT20y?=
 =?iso-2022-jp?B?VE0wYXhPZkpCN204N1N5Q3lraDNmWkl6azNBNmRUMWIyVGFLeHJ0cktu?=
 =?iso-2022-jp?B?MGMxRlpZSjlxZ2tveFAreGZ6NGlHdXJKQTg3WlBCdUpNZS9BMmM0ODlQ?=
 =?iso-2022-jp?B?bThRcmY4SER3S1FkUDI1VWlnQzBCM3NiZnBwNit6OHN5VE8rc2N5QWIz?=
 =?iso-2022-jp?B?cjREc2hkVy9nb2pGWEVLZnJVOWhLZnUwL2RwMVEzV3dWcDFaVnRPS1dl?=
 =?iso-2022-jp?B?WHV3bkh4eUYrMmJCdkw5OWFaVHRDTzlGRlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 21a913cf-3f59-4c45-76b8-08da8ba71931
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 23:18:22.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 N7dJ39iErTlOJIBxAjhq8PfsmfdgVsBloUJcUf5Ht67esSkUv7poTT9WaIiHM3aXSHCbt+Bc+HFHMjdagsGmejV4u5yKgBK6aqppuovRh3Z2O5CeTEJtJ4H5yShDmdkH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8875
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 23:18:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9395

Hi,

CIP kernel team has released Linux kernel v4.19.256-cip80 and v5.10.138-cip=
15.
The linux-4.19.y-cip tree has been updated base version from v4.19.255 to v=
4.19.256,
and the linux-5.10.y-cip tree has been updated base version from v5.10.136 =
to v5.10.138.
The 5.10.y-cip tree has applied small updates of Renesas ARM SoCs.

You can get this release via the git tree at:

  v4.19.256-cip80:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      e5c44c8629fdb37d31546d9544b68fef7292f810
    Fixed CVEs:
      - CVE-2022-2586: netfilter: nf_tables: do not allow SET_ID to refer t=
o another table
      - CVE-2022-1679: ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
      - CVE-2022-2588: net_sched: cls_route: remove from list when handle i=
s 0
      - CVE-2022-2153: KVM: x86: Avoid theoretical NULL pointer dereference=
 in kvm_irq_delivery_to_apic_fast()
      - CVE-2021-4159: bpf: Verifer, adjust_scalar_min_max_vals to always c=
all update_reg_bounds()
    added commits:
      CIP: Bump version suffix to -cip80 after merge from stable

  v5.10.138-cip15:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      f2d94917db95e02bef61288aba5b06e0dfef3a73
    Fixed CVEs:
      - CVE-2022-2586: netfilter: nf_tables: do not allow SET_ID to refer t=
o another table
      - CVE-2022-2585: posix-cpu-timers: Cleanup CPU timers before freeing =
them during exec
      - CVE-2022-1679: ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
      - CVE-2022-2588: net_sched: cls_route: remove from list when handle i=
s 0
      - CVE-2022-2153: KVM: x86: Avoid theoretical NULL pointer dereference=
 in kvm_irq_delivery_to_apic_fast()
    added commits:
      CIP: Bump version suffix to -cip15 after merge from stable
      PCI: Drop PCIE_RCAR config option
      arm64: dts: renesas: r9a07g054l2-smarc: Correct SoC name in comment
      clk: renesas: rzg2l: Fix reset status function

Best regards,
   Nobuhiro


