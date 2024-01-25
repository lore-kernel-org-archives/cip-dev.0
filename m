Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FD3C48260
	for <webhook@archiver.kernel.org>; Thu, 25 Jan 2024 12:38:04 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.125])
 by mx.groups.io with SMTP id smtpd.web11.16520.1706186274721603607
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jan 2024 04:37:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=fCNOoZOP;
 spf=pass (domain: renesas.com, ip: 40.107.114.125, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWerDh9gaIsGoJJBRo0ox4c41XnS6bIW4IAuDLcn2OohlyG+J8WJjeZ95oV5pXJmPNq5pnsIE2bcURWWwRNGXqxkTvLxnYILZwYZlB+iaiOSQaXuQQwR1r/+r11WIdfRgfr+Jv9lVXwK40YLYzeBOeOFSUuYoUL5P0P4/M3i5vBGW4UvclO31eRbEAUMUYHt8UF8O1wJ0czipTCZK8jt7po1ZhgVlM+FnNBSnyLjCeyfYNDswsBtLxlSPiIx8oqARdYPEmDnhaTTtZnFh/a639lZPXdGEmiKbCIFEEA1ORwl2FJPyIjvt/6ruVO8gxVCxdyagUS/ntoZe9nCN0kTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/OWqanDJyIPE6rPX2frzgiAn/V+hf+24NxNI2yQnhc=;
 b=FQCHZKaRtWU/1tjJFr2vrECve37p8wuDsy//kj8NJnr1M1iIy7MrgwD47D6HLzOx8EZ8wfVdlYP3bAKQv6WUsxLvnrXZe9NX+wGkofVSheBTZKkg4t3KXFEfXEjKMFDwzAiWpWr4ByyALEktqup+zce4unZM3m3SMWT7LHP0Gy6JlM4pZSiEgfz3//f3gr7/Uy3FETV9j5/JQwnFK4nAC9bDcfJaRyMOVPxbHuANauBSo9J5XcIzA1w0Y3HzVq88FjQ0R0k/lkz2bWi07VEpgSwvfQz9Npc7Wx4SKxOxm+FpQEhcT4AxpV6UMlnh4dZ6Vq/T9czvm0K0KFHjOMBR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/OWqanDJyIPE6rPX2frzgiAn/V+hf+24NxNI2yQnhc=;
 b=fCNOoZOP8FRwBD9MCW/eLUy/TY4zasd9ltTdYZdyNAIQHO7vAP0cvXrU6ns4Hoi1JaEPQKUtAoinTyu1ThsRa4620GyHNWjYrHyPuEfpyWbTyjIWT/diEA7FTQoMfsAoMGH0iGn07SEVFSY4swwxyaitWFPa06yJe07K/SUKMiA=
Received: from TY2PR01MB3209.jpnprd01.prod.outlook.com (2603:1096:404:71::20)
 by OS0PR01MB6180.jpnprd01.prod.outlook.com (2603:1096:604:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.14; Thu, 25 Jan
 2024 12:37:49 +0000
Received: from TY2PR01MB3209.jpnprd01.prod.outlook.com
 ([fe80::4a73:f955:2b4c:5ef9]) by TY2PR01MB3209.jpnprd01.prod.outlook.com
 ([fe80::4a73:f955:2b4c:5ef9%3]) with mapi id 15.20.7249.011; Thu, 25 Jan 2024
 12:37:49 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "pavel@denx.de"
	<pavel@denx.de>, "uli@fpond.eu" <uli@fpond.eu>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v5.10.208-cip43
Thread-Topic: [ANNOUNCE] Release v5.10.208-cip43
Thread-Index: AdpKtRh0mVlCbqIxSX+7kXZlaPr+LgE1XLdw
Date: Thu, 25 Jan 2024 12:37:49 +0000
Message-ID: 
 <TY2PR01MB32098853D67E3CECD6ABB2BFB77A2@TY2PR01MB3209.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB638843317C0D8CAD4195EAE792702@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB638843317C0D8CAD4195EAE792702@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3209:EE_|OS0PR01MB6180:EE_
x-ms-office365-filtering-correlation-id: c1adbb73-ab53-496a-4616-08dc1da270bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LQRRGMqHl64gJXV/zZ2oZdXOd5ILoe9Y61yebJUVtaYE4WjBYyTXwYCGEz8Ec8W9tro43IPbRs3mkLqJc9tRtPQrkMQpwv8anIIks9N0Enb+ni9FIpXoiZipW2fz1I63vaLBjaF1HYgmKL0m8VarHBBiGThmVL0hlDA768h91G547R1y5GHnf3/+4ow/fdLJMCinkU3elt8HSdc1F5lxWNNjFGw01ec1vcahcV4eQPmeU4Q5K5gg3A2LbcC1bDCJCcolQfa3UTVEbMsqgr5YUdBymL79kgFg2kyw3YRpIVxgvCNP5irwF5zoCltpZqvwK5U2cKrdVzdJ6DfH+yDc0h9pEAiVe4+svhtjUSK2vVBA39Xk4PJdIdY4FXOUok3SRCvWVSJYIUUjMvAopGZpa9G31bLQ4+u2ffy8Zv94wMcszuZbiBDaa3vL7ePaqCXc/Ni+SsiewJIyjPm7rw0/kH/uM5sqIbNJtjfHHT9orgNt5Zs9ED7xaoiiWv9J+LZB+ZxV/Qu18EP8xOIjXSRuoDT0X/Cyq+ZtQm2eJtb2wwdgDYCZDZa+ttq8zLIeeyoYxVm2v8i1YMnnaAxU+N1htBv59W15Iye3/uW9NFj+hMw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3209.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66476007)(52536014)(8676002)(4326008)(8936002)(33656002)(2906002)(5660300002)(86362001)(316002)(110136005)(76116006)(66946007)(66556008)(66446008)(64756008)(54906003)(38070700009)(966005)(38100700002)(122000001)(7696005)(6506007)(9686003)(478600001)(83380400001)(71200400001)(26005)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?uRcm6wKZzxBES/qKZVZ4Xi2LaeiQGFistHZwe0cy510RvCjjqbDdoZdN?=
 =?Windows-1252?Q?vEVxpdfBOjPB2/B4nD4Q+MpwoIo7Zl7CerUZSWTRMG9J7CMVUpU/y+WV?=
 =?Windows-1252?Q?HtMBtHoc7HkMZ530av8Ld2/6Sxxsh98Ld4z43S+MSYvn29FWZMk7DWWT?=
 =?Windows-1252?Q?eCUtYmaEBE2peqdk6/zGtLJzPuHwDuwU4OVX4l5GBZ7SZS+OR7Iby+7p?=
 =?Windows-1252?Q?Dn+c2K0KAaE6IVVnH9kfWzUBw76h5WPs494b/Qx+m4wF9ybsK7o+IBrQ?=
 =?Windows-1252?Q?20dIWCNB3fSYJatnlvqF0tpMQXkAkHNhDVMhcNCYAkvdO9M4L3ytzrn6?=
 =?Windows-1252?Q?ttAebUUvKunNjjqLNYm7XhE011XowO64p2t6KvBEI7T4krBk+gujmsAX?=
 =?Windows-1252?Q?vMBSULs++7Dwjg6JhGyM6TwdR62++g2Z0psVdQ64jtBXZbfMf1VsoQ87?=
 =?Windows-1252?Q?nDWe0ZbPLq+pT+bNB9a+NF4hVJkdfUkd5m1A06ei5zQPSWSFXFnq2Hbc?=
 =?Windows-1252?Q?EoFQLydqr66Ynf5BlmoxW9PUefnGoG5cwu8dIdPQfNEAAAiRSaAycxuT?=
 =?Windows-1252?Q?mtoN9DBFEMY5zlYd26OLm3J6GEstzZuFiJIMxGeFrxokH5taVSRbyJQu?=
 =?Windows-1252?Q?kbaWjqqfyjkdg5NSX1aVrgdH4/aENqEdjtOHFhkeWqqmMu4UdZuw00gQ?=
 =?Windows-1252?Q?EHsn9zpOrQsFufRwFk4R7r09XBgOwzgnV7edCWlTa2lRjnYBMf9Pqyd4?=
 =?Windows-1252?Q?8pAwUSdjaEL4H8F5WVzmkUyUxywcL0YBkxVqoPHKL0GoUq42jVO2knUd?=
 =?Windows-1252?Q?+iaFROjnkLOU5XEgFdWzUvYC9wznLnRdkm/aaqKF/yHr2xJeFcDRAUzG?=
 =?Windows-1252?Q?9W3JX7tL0kSD6sfLizjI/RQrpKdG+8GSrE6zyIGgi9UMCyYJIp/k9uZN?=
 =?Windows-1252?Q?6ege/fjtZm9h5ezCq+6dqji3kbOIPH/MYr/ns8BC9aQOFj+u4GdbI5jH?=
 =?Windows-1252?Q?koQ+MSqKgoEaagoRfhloqxW2J1HqoKXeaGmWYO3WXY87trcxtcLDUUIl?=
 =?Windows-1252?Q?+DLp09ohKeR2XGbqFWdcOMT7Z8ObfyBR6uYAz15DPQ6UKqpl6DSr2UOf?=
 =?Windows-1252?Q?DDbm/xbl68kxCxbVulsVTaDiArS1JwiTr/NIp1qBedt4yK9X2q5M7taM?=
 =?Windows-1252?Q?NlD5sVy+/PUwhrM5BlTXGeYpzkDuhY2MheYNRVhf2QeLKQEEi13Cp+S8?=
 =?Windows-1252?Q?51Mh0tgssi4P/PWRIV4soRUgf5F/qerNuIS5T0MdUiv08pDvjTH5KINW?=
 =?Windows-1252?Q?YMdb4CDlCDL0MvJfF8j5QSjZTcw0FC7i+TzDKzTStuKnUxwUuKrDmjnx?=
 =?Windows-1252?Q?vqzgYpKmZFsC7jDjKvjz3TXrplbA8IciRhKXs3W3+2gIbP6SS8R9HV1o?=
 =?Windows-1252?Q?D1ERDa0NtXaT4wWfSmQvVr3fnWhEgZtjI1y4hC30y/Qj8mGUuuxTHN0W?=
 =?Windows-1252?Q?czuIVW1M9IZhxjNiHqZDLmO8BRlagNG0ig2YRVNSKUB+P7lGUaAC5lE+?=
 =?Windows-1252?Q?kO6DwJUSo1mfA3HDjhZ88wLhDs9/DM7lF5aeTOFTpwJgc00YSkZOaT9/?=
 =?Windows-1252?Q?VCcn12e2C6ZmUgoA57A5OcXZfgkI5LkRHoZKuacmwgoK08VKiv9vBNFI?=
 =?Windows-1252?Q?h1C3Xc5cLaRLoH9SyYl5PyY08NKP0h9zWmtsW9YMifiFTqo13cLQBA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3209.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1adbb73-ab53-496a-4616-08dc1da270bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 12:37:49.2709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/iUAwO+uv9Huj2TTRP7S4+CIbYgHmc52BX5JpY5dbpTHj26ivhCOpW3aZlZWcJ9NmOLReR95IKX0b2EzC8EfWUKbuR/4I0of9hSjYGg/k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6180
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jan 2024 12:38:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14457

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Friday, January 19, 2024 8:55 AM
>=20
> Hi,
>=20
> CIP kernel team has released Linux kernel v5.10.208-cip43.
> and The linux-5.10.y-cip tree has been updated base version from
> v5.10.205 to v5.10.208.
>=20
> You can get this release via the git tree at:
>=20
>   v5.10.208-cip43:
>     repository:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-5.10.y-cip
>     commit hash:
>       b445cc998c55d40197d601584361f73e1183d44f
>     Fixed CVEs:
>       CVE-2024-0646: net: tls, update curr on splice as well
>       CVE-2023-39198: drm/qxl: fix UAF on handle creation
>       CVE-2023-6040: An out-of-bounds access vulnerability involving
> netfilter was reported and
>                fixed as: f1082dd31fe4 (netfilter: nf_tables: Reject table=
s of
> unsupported
>                family); While creating a new netfilter table, lack of a s=
afeguard
> against
>                invalid nf_tables family (pf) values within `nf_tables_new=
table`
> function
>                enables an attacker to achieve out-of-bounds access.
>       CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize
>       CVE-2023-51779: Bluetooth: af_bluetooth: Fix Use-After-Free in
> bt_sock_recvmsg
>       CVE-2024-0193: netfilter: nf_tables: skip set commit for
> deleted/destroyed sets
>       CVE-2024-0228: [netfilter: nf_tables: skip set commit for
> deleted/destroyed sets]
>     added commits:
>       CIP: Bump version suffix to -cip43 after merge from stable

Testing results summary:
- No regressions found.
- 12 tests failed - these are expected spectre-meltdown-checker results.
- SQUAD link: https://squad.ciplatform.org/linux-cip/linux-5.10.y-cip/build=
/5.10.208-cip43_b445cc998/
- SQUAD comparison with previous release (no changes):  https://squad.cipla=
tform.org/_/comparebuilds/?project=3Dlinux-cip/linux-5.10.y-cip&baseline=3D=
5.10.205-cip42_3ce67a889&target=3D5.10.208-cip43_b445cc998&comparison_type=
=3Dtest

Kind regards, Chris

