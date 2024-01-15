Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B28DC3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 14:25:16 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.118])
 by mx.groups.io with SMTP id smtpd.web11.81168.1705328713634652929
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 06:25:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Vr8UPoIe;
 spf=pass (domain: renesas.com, ip: 40.107.113.118, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxFhAPyomhDca2SCY9MiTBPJ59Sd4JEdLFrK7UI5izQupw1a3Fa/hmy76ZInOiyILYz5BWj12nclUe82rh3vbFlOZdN3CCtMVf1iHyLfXPO0+MoQ0fmTl57YpWTCBG+ZRyfE3DeU+1h7K7Zf4ACu7GMYtyRmpxtuJqoADN3BuyVrkRi48jQ7znoF6S1n1A1EzzukxFOknw8MOwKUGp6ktr6ow9MCJYKZdrIokM/Hm4nZW3TjFk/AQcH0RcHpZs2ZS483F6WJdqg68CO/sOmXR/l668zJLixUE5nhUFNfm0U9K9qOQonOMveYN7oAtf8Nuf+IWBhmJuCSoGvr74/+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQqHAHbt8a81gBAwtucBRBa+3KP7CQGf2Y0VgVFUA6A=;
 b=N0/arOom+WCUHEYLXwpzvjP10TjajbEOyI9hRAV+NxLTY3CkqIp+Xnzrf55RnsA4FmHjy1O9GgMoP5k0jbzghPLV2ZxgLsRrFcXS7oEEwfblfsAxC1fB8k+24qfp7QXihRMI3dDHppkZaxuIlHffU52jAF8zJ/A5teuq3B4AONlNSWT9mIiGcbSY7i4VYHUEmYvrVYcP7FRhyXdcSa7J63fimxdPAEMudqJxFxOQfznJgMN2R+kKcoOMYA52VwP7iAeXDoQ1rKSiaHvf54de2Mwr7SQ1rJ0PBg3YBXyU2/Oruw0OoiPzC4Ie3fq+kfq9ygQLhztNuAKdsTLab/f9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQqHAHbt8a81gBAwtucBRBa+3KP7CQGf2Y0VgVFUA6A=;
 b=Vr8UPoIe2KYLQ52CmiWZn003s7cnFVFTBbaTr+H6gjm0bmc8MoNaKWZ9xZMA3zsosPfHLVANiFAKtfeqG8wZ0bL4pIMUoOEqdz+pi3A0FMYIczHM+QfkyRGrDxs3VOHxmPvRQvhr+f0FlEvkct6rRSIGnqYi9BmljOCUoRJSlr0=
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com (2603:1096:604:13b::10)
 by TYTPR01MB10921.jpnprd01.prod.outlook.com (2603:1096:400:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.17; Mon, 15 Jan
 2024 14:25:08 +0000
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899]) by OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899%2]) with mapi id 15.20.7202.014; Mon, 15 Jan 2024
 14:25:08 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "van Buuren
 Sietze (XC-CT/EMT2)" <Sietze.vanBuuren@de.bosch.com>
CC: "pavel@denx.de" <pavel@denx.de>, "uli@fpond.eu" <uli@fpond.eu>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v4.19.304-cip106 v6.1.72-cip13
Thread-Topic: [ANNOUNCE] Release v4.19.304-cip106 v6.1.72-cip13
Thread-Index: AdpF3I5BvtOFCptKSPq70r13AdXH+wB3OgnA
Date: Mon, 15 Jan 2024 14:25:08 +0000
Message-ID: 
 <OSZPR01MB681659203C0EFA2BDF73D6BDB76C2@OSZPR01MB6816.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6388D8875E335EAFFA242BE1926E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388D8875E335EAFFA242BE1926E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6816:EE_|TYTPR01MB10921:EE_
x-ms-office365-filtering-correlation-id: 3502538f-6c92-49f5-0d88-08dc15d5c677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NAri4OXYxToqzZJuewbDWG19X1vprQutgoW/Lof/f6XZ/ELBXrQ9MvYetLi9+0q0ZqxtFZdflUlwxFe3c9fmffK/iZlCnVM7zhNTSfDXqbZcDbRXXUABXJP1nd08V+pw1WElxWPZZoj9LHe7KSJY3F+ZcDK1BZu6q5aodTdtJYNOcjochlqRbvJQRsKzMu9fhxdNZ3deKbIx9jIlgbpR1FvZla4Mow0EDbpY7NadL8wnqhDQh2xkqHr8ksYoXP6SbcOCCOnmnc0dhTLBX0f6XhqfRaa6OJb/4YzB0ZZFpgSMptxJXAAKtINALptFy050tSFstLL2AMLokGsO2e1IgT8rlQJB9xF6EhGCxJPSXweTqz/DIkBYH7MjCQ7vsmoaq04zu/cIh6Hk0burWqplB/5eGwtDJ4+GNCoqlHg8fHyxAdx0e6sVHct+w4ouDfrTENacdqCzrBHwMo2qZyDPZCH4AabhLitXvx/vOTY6u/hyBYHpLQVkKnEDPJ3rul9Jx9mAUFz/tSqb+RipitnYwZiO+3soNkjfcgfGnOk884iON7mtlmsxGM90FvMnaaKJ68xjb+jYCXK5BPQWqEKKV0FehUpDxGgqGB77VNZrSF4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6816.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(83380400001)(86362001)(33656002)(38070700009)(7696005)(52536014)(4326008)(8676002)(8936002)(71200400001)(5660300002)(9686003)(26005)(38100700002)(122000001)(66946007)(76116006)(66446008)(66476007)(64756008)(316002)(54906003)(66556008)(110136005)(2906002)(41300700001)(478600001)(966005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Ml13m7VGU/6ZC5DdURghX24s6tYQOJytUGriURDQ3dMB4vsjXync9Due?=
 =?Windows-1252?Q?9ywt8AZ9ruM3f/9azRqY5J7XICuTp/HHHjFrXyhjJiT5YBNjZm+A3Kco?=
 =?Windows-1252?Q?n4fTeT6GXCDtFSSP+b423Ene2plowsE3EC3ZguW7pgtSaK1iWEKoghIL?=
 =?Windows-1252?Q?ZO3unuR+TJ1hsyLBEffTXHiU79Ct4fXBWUcWDW6WlsLxvR1rWGC3BY2W?=
 =?Windows-1252?Q?WIalc0/qMMDGuMlS/okK3qM37BBMNvPwTGppNs//rr17hndgsk5x4g8j?=
 =?Windows-1252?Q?T3fQMPFmlU344K4wNGdnv1xh5VD0toSK5g3dWFJs62zcrjAWVu39AZKp?=
 =?Windows-1252?Q?T026SSWLYbxHBACVPZRcv9+Io2O17p9+p9Ix7XnIhfYPE7/cR8XAyE++?=
 =?Windows-1252?Q?ntYZmLs7kZBhiAlFJKB0E4SjudwG9EniW60m9tvjhkykvuhCdiSdLDYs?=
 =?Windows-1252?Q?BtCDoHH8OBnWUWoaK3bNtxK0Tyhr5VHoVl+ebA1PcDbPfMdkuStrnylZ?=
 =?Windows-1252?Q?xk2vgXynL8c6Is4vE60smT0FkLxj6FmPCojEdmCnIC1e7fwvf/a95cgK?=
 =?Windows-1252?Q?TGxpUhLiksWhMvYs5Xe1HO+ejvkqeHOniCEskyK06kssl6BQ8sEmRXxV?=
 =?Windows-1252?Q?9QSPF+D4mnr1rPqp8gJMAjKJs7yRvYJGa9yvcQyteN2xBZLNaXBdDURq?=
 =?Windows-1252?Q?jwZ8UTe8mV5n+3Kw0DmqjuwMzw6156w/MrCyTSfJyBMSc2mdrzV/RAl+?=
 =?Windows-1252?Q?fBTdT/cLe7Kzel/JysHCyBlVCIq0QdZksa3NoD3Cfikl+9UO1hbSVq8s?=
 =?Windows-1252?Q?/GcO34SsDv7jTDoZQozvqCa2BwzoK0lEPrIh47rk98CaAYKUyPlyVARc?=
 =?Windows-1252?Q?Hmt+hgXBgUlhYRcXx4iaO7iCGkd2yeqI4ozes+mHiUD9DmKGkB8AoTrr?=
 =?Windows-1252?Q?wGRKP7GzeQbi27p1EZxGZXN+YtscsYA+FDfENDagCTzP9ynwOCOxZDDs?=
 =?Windows-1252?Q?NX/ttJI+INbGSlaY/TejzKC/qr+pvYfI1FIBY3OAZDt//Y21INwmr0OB?=
 =?Windows-1252?Q?QaC8lODcDENksGb66NSmwQ3gr5rg06ttsdYXXzzAjZFjEbZo39rcxnOc?=
 =?Windows-1252?Q?c6jCfw9yZMqc85UJ8qgVs6vTuomlY+6QVmALnYT6QW+dBcIKOJWD7z0C?=
 =?Windows-1252?Q?DurM4UOcIncrIQ5uQAAkO3YOOWvGRfRxKH0oxEEJKEa3QrJSn8e9C7XX?=
 =?Windows-1252?Q?prytxKGJpCMes39T3qRatBci3btSNT7uHifkaPku2sbUACz8Q4bFp1y3?=
 =?Windows-1252?Q?ZUaXjV7I10KLXUCmBhsXW0F6kOBlZIHVCmV0V+RH0a5YZnQfFMu9omfy?=
 =?Windows-1252?Q?jyjYT6Bjvg7BLYSzqdNVXMfV/KK3+IumTzbOikIm7UEK9nUYgOVF+eY1?=
 =?Windows-1252?Q?j6yxmRf206tzeXZECxg+NsgO5trvxPnm3sJ8LMAH3gnvqYQeslOodfxu?=
 =?Windows-1252?Q?iLwQc7bhugfJc8O3cnSrJkmvkKvrr7LN3jtbgk/4FTrXDZ+g25YGuCBD?=
 =?Windows-1252?Q?8PBH71+pBiAF0aw70FXslfnBtqdxdplXCB5HPZmH94iszksrDfk3drzh?=
 =?Windows-1252?Q?61WmHcDLj+Z4sUGlIWj4Jq0lCQMHOnS5ONUmjbHcktNKeP7vI36Mfrd0?=
 =?Windows-1252?Q?S6oQcZGXHQpjCNBZfYSoTj5Zwjsy4Nj1leqiLMTWgYiMe3IBTgxtKg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6816.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3502538f-6c92-49f5-0d88-08dc15d5c677
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 14:25:08.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSd2zNHRg9YkudxO9F92nA8KqyUfx2q5J1L9IzU+SAJalRVE6+2xR19aegl07FXMav6k17LTYu8a7sH0K7//JS/x2okmtgXLiRsDSWvORZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10921
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 14:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14385

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Saturday, January 13, 2024 4:56 AM
>=20
> Hi all,
>=20
> CIP kernel team has released Linux kernel v4.19.304-cip106 and v6.1.72-
> cip13.
> The linux-4.19.y-cip tree has been updated base version from v4.19.299 to
> v4.19.304, and linux-6.1.y-cip tree has been updated base version from
> v6.1.67 to v6.1.72.
>=20
> You can get this release via the git tree at:
>=20
>   v4.19.304-cip106:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.19.y-cip
>     commit hash:
>       6617f4528449a329abd3b2dab36052b341610d99
>     Fixed CVEs:
>       CVE-2023-0590: net: sched: fix race condition in qdisc_graft()
>       CVE-2023-6932: ipv4: igmp: fix refcnt uaf issue when receiving igmp
> query packet
>       CVE-2023-25775: Improper access control in the Intel(R) Ethernet
> Controller RDMA driver for
>                       linux before version 1.9.30 may allow an unauthenti=
cated user to
>                       potentially enable escalation of privilege via netw=
ork access.
>       CVE-2023-6931: perf: Fix perf_event_validate_size()
>       CVE-2023-51781: appletalk: Fix Use-After-Free in atalk_ioctl
>       CVE-2023-51782: net/rose: Fix Use-After-Free in rose_ioctl
>       CVE-2023-51780: atm: Fix Use-After-Free in do_vcc_ioctl
>       CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize
>     added commits:
>       CIP: Bump version suffix to -cip106 after merge from stable

Testing results summary:
- No regressions found.
- 7 tests failed - these are expected spectre-meltdown-checker results (not=
e that SQUAD is showing double this, that's because we've got the results d=
uplicated)
- SQUAD link: https://squad.ciplatform.org/linux-cip/linux-4.19.y-cip/build=
/4.19.304-cip106_6617f4528/=20
- SQUAD comparison with previous release: https://squad.ciplatform.org/_/co=
mparebuilds/?project=3Dlinux-cip/linux-4.19.y-cip&baseline=3D4.19.299-cip10=
5_d152f9dce&target=3D4.19.304-cip106_6617f4528&comparison_type=3Dtest

LTP results haven't been included because we need to work out the best way =
to standardise the use of the "ci/iwamatsu/linux-x.y.y-cip-rc" branches. (L=
TP is normally only run for release candidate pipelines).
It doesn't look like were using the -rc branch with the same code version a=
s the non RC branches, and the results are getting mixed up with the non RC=
 results.
We should probably split out these to report to a different SQUAD "project"=
.

>=20
>   v6.1.72-cip13:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-6.1.y-cip
>     commit hash:
>       847d28968b6f4ca12f696d32771f7309efb14c83
>     Fixed CVEs:
>       CVE-2023-51781: appletalk: Fix Use-After-Free in atalk_ioctl
>       CVE-2023-51782: net/rose: Fix Use-After-Free in rose_ioctl
>       CVE-2023-51780: atm: Fix Use-After-Free in do_vcc_ioctl
>       CVE-2023-6931: perf: Fix perf_event_validate_size()
>       CVE-2023-6817: Netfilter did not skip inactive elements during set =
walk,
> leading to a
>                      double-free or other unknown impacts.
>       CVE-2023-6622: netfilter: nf_tables: bail out on mismatching dynset=
 and
> set expressions
>       CVE-2023-1193: use-after-free in setup_async_work()
>       CVE-2024-0193: netfilter: nf_tables: skip set commit for
> deleted/destroyed sets
>       CVE-2024-0228: [netfilter: nf_tables: skip set commit for
> deleted/destroyed sets]
>       CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize
>       CVE-2023-51779: Bluetooth: af_bluetooth: Fix Use-After-Free in
> bt_sock_recvmsg
>     added commits:
>       CIP: Bump version suffix to -cip13 after merge from stable

Testing results summary:
- No regressions found.
- 12 tests failed - these are expected spectre-meltdown-checker results.
- SQUAD link: https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/=
6.1.72-cip13_847d28968/
- SQUAD comparison with previous release: https://squad.ciplatform.org/_/co=
mparebuilds/?project=3Dlinux-cip/linux-6.1.y-cip&baseline=3D6.1.67-cip12_33=
a81955d&target=3D6.1.72-cip13_847d28968&comparison_type=3Dtest


Kind regards, Chris

