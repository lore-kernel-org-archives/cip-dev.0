Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08105C433F5
	for <webhook@archiver.kernel.org>; Mon, 30 May 2022 08:16:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.34370.1653898574062031339
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 May 2022 01:16:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 24U8Fp5f017953;
 Mon, 30 May 2022 17:15:51 +0900
X-Iguazu-Qid: 34trLtFNClpRO1wpZz
X-Iguazu-QSIG: v=2; s=0; t=1653898551; q=34trLtFNClpRO1wpZz;
 m=fONDJSnIZUp+0RcYbjrhz79CAlY7RXDmU0OidvlfKMU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 24U8FneL033046
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 30 May 2022 17:15:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am/uXPBX+K/nUTO6okObGslLcUe4zzNQTrdz90GRlBnzUghQqIUNc3HJffnpoG8lYADBSU2YQo/vFGqZOP/nDTKu/tCrIBxSGnKNRYWjjBW78mYhngyeYuw5LcG0M1y6IZXQP9NISFghkyAw242BH2wPemT2KVE0Xq/IB60bPkcKRob3L1qFibFIEzYd+QFPeZ8DWNuftNXjGh49XvyQD/HgkjxqaMY5mfwTzD/m2A0+ngdkF197AjdlYD1vA8Uj+cjLko8D3+NZrAp9mfGJdaL6UnhiPufP8wKpsgGoO5jBVAvP10yiBxHI3sP5WuvksXgz/2QHBRBo3OR7sqBUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WU5XB9O5kU1ncTrfoFfjS0D4YkKNCjjZOQmKuRvjGw=;
 b=hzweoaOMR3ARasCjkMVHBMmh6qfuzgXarwx59ycwJ4RYzxbA/O20WGJdqg2HFwoakLLSex7JbVFT41/HFR4ncKSnewyoVsliocmrm/gFgQVBTwo9FiWC0vY6/C0nbGYCAxbOeZidZ8GPU+xr/diTqzqYvz7Ifd/h58piuGDv9U1jebf9D6In1W37S7mBdS4VCzhRK3HoQynszixPzmzYRups8PzdrkIzN6MNPc5jTb4Rg2rwUgtsZ9CiQ/SbCP1U7+W6ake6orkB2lRXC4q+s/GS2mbxTBM7CkPwPDI/RyASclzfo3fFsa0BpJQCj5HssCa5W/lKsu/TQdqKUWRJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <uli@fpond.eu>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.245-cip74 and v5.10.118-cip8
Thread-Topic: [ANNOUNCE] Release v4.19.245-cip74 and v5.10.118-cip8
Thread-Index: Adhz/Pb9uyZ4iPgxRJG9tupDjQGWgA==
Date: Mon, 30 May 2022 08:15:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420E5E0C9B229CDDCDF871F92DD9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd9703b4-686d-40a7-f5c5-08da42149645
x-ms-traffictypediagnostic: OSBPR01MB4855:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB48558E14BFA8430088CD8FC392DD9@OSBPR01MB4855.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 H+MILd4s1tEr8gxGPClO5n5VzhOhdQyIqPvbdyipNdXSpTPPE9Hu3RiPVXYZQWBusGilVlB2EH8aICBgNL5kXhk8y4mqsDEMUwLZmwF3hraJEWmqLuwnsinePNc68yo6Hf16yakRweK5AUbOU8rx7QtN2rNBcG4huTY1XkSxbVeodSIK0Yr6ECDObrh1awtXCE6uW642yyUj64f7eayES54fXw6utEt2SQHGqXvqagDDhB5iFMm44pDrPhpdDgA8yQoYM+RolINy4bH7XdJtCfTYF6cH1GX5OLwQ9cFncNMWSUoxNPDCjN4jBY7el4yOkSpGuuzyM8AC+rYSmKB2NrFdk9DWkVWd5rGermVWqY4MhJo3ir/wmJH9yzoiReuzg6noS6i9NFgftwi1CnreNmy1xE6mD+MQRMfHTG9Fp3doi5C9TmvyEiwGQs0C5RuSYdM6nP1e9MtgrySSy2AYb4jJMh38FZK+DR7HgkYJC5VMBvn+93QgU0jOQ56v6vgLDqrwjDR3j1/qLEVMFlhZe57BW4cnokQ/58UhGyU3u/0WHTlpOMs01kG8CVJIea9UuUPpxRTpdyZokyyUPhtMfIQObHha76s5Jxp5g9N+f46nlhNoFolOC7KAni7VAiPyViDOuv7tKcLhaffAyls4A8cYetfJVthk4tsgGlLaWrhBVZKLvm40efoijiYrkIZL/D0yC6fogf2Pepat5Cx1N59x39T3nB/kXpP0LQ6bg9O+juAj6eyf7/UUyXChLlTxg4j/gb5syWQcP5Vj/mOWxugZm9//TRfIBi1TolEzpaM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(38070700005)(122000001)(71200400001)(86362001)(76116006)(64756008)(7696005)(66556008)(5660300002)(66446008)(4326008)(66946007)(66476007)(52536014)(83380400001)(8936002)(2906002)(33656002)(8676002)(54906003)(6916009)(9686003)(316002)(6506007)(26005)(966005)(508600001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YWZ3eUcyL0xRYlNaMDFGVjNJaXdxVTdFMFZRczBxR3dtUVVsblc0TGsy?=
 =?iso-2022-jp?B?SGNGZlEwMWZXNjVqR1FiVHVWMkxuYXJjUUt3VUdsV3BEK2tXcTBxVnRH?=
 =?iso-2022-jp?B?Q055dnUzVGYyY3Q1YXdNNzdoK0pXY1ZIVkI3c1ZnRjNtNk5YeGF2aG9o?=
 =?iso-2022-jp?B?R0VpQXBPNXB2SkdYT0JiTG14d3lLN0xWVWsxb2hFV29zT1RkVm5CMFl6?=
 =?iso-2022-jp?B?ZGVJaUtVMThIeE9KQzY5WFBrYlVWdkNuSjVrTzdidzFFTlhnRVpxK0Nw?=
 =?iso-2022-jp?B?TVpLTXFJS2FLZ0JFRWNyQ0EyWlByTmxDNS9yRStaMkwwODljZ3NEUjhF?=
 =?iso-2022-jp?B?RHFWM2JUcUt4aFpacFJoTFR0cmpnZ0pDT1VqYlFhUnI3d3B6UW96TGFW?=
 =?iso-2022-jp?B?aDU3OGd3Y0hBdDE3WnA2MDZkZEJhOXRCbzM1SjhrK2tXZUpzbHJjWTVl?=
 =?iso-2022-jp?B?VmZURFFObUY3OFdEOC9jR2NhdUxod0I2Wk1RbjR2Z2pxTFdmY0hkY2Vh?=
 =?iso-2022-jp?B?ZTRUSHMzaE1MR1RkNEswZTBGZ29jb3RtYjZNbU1VWjVaRnp1cGV6Uk1s?=
 =?iso-2022-jp?B?anpiWVBGOXRSa1pKMkNkSytzRjYvd2pTOFF1UkVNRzhyQWw3Z01QTG44?=
 =?iso-2022-jp?B?TUVmZ3BPUW41MU1pdWZKaWtSd08vNDRzQlpUL1ZvRWJJR3pNREVzT2V5?=
 =?iso-2022-jp?B?elRBNWExT0k3MXNLQ01INDdPSVp5ODgvcHBWeGFZMGthOGE3SFJJUUZt?=
 =?iso-2022-jp?B?VzZPeTRVOUZjdXJSd1VnNFdRSjl1ZWwzaXZtYkNxL01wdEJJQ0RLTSsv?=
 =?iso-2022-jp?B?eFlvUmZGTHZvMUI5NnZpZ3ByNXVrTUFzd0Q0WmxrYmFHU1hJRHYwK2lj?=
 =?iso-2022-jp?B?MFR1MVIycEUvc2g3NTZUQzNGbHFmMmREUDJWS2s5cDhXblE3T0xkZVZW?=
 =?iso-2022-jp?B?ZS9mWTVxeUlqLzI5ejlabUhGbzJoalpkVStkdnk0MXRoZWZZQTFMR1Vy?=
 =?iso-2022-jp?B?S0hySDlDOWJqdWNoSmkxNFRZZVRTaS95bzdyMVdPMEVZSDc0MnNvUnIy?=
 =?iso-2022-jp?B?bUJvTmdrcUdpTE13MVBXeHJSV2kwNG9ETzJKRVQycmRiZ0YzNHh4d3Ro?=
 =?iso-2022-jp?B?QzhiNEJqSWdjeDd0WnpmNDc2QlhIMjFrNFNvQVJsWmRIUy8rTGNEYmR2?=
 =?iso-2022-jp?B?dzJVQmhPYVBlcUQ2OUNHNXBrMzdhOHZwblQ1YWtzS1VoVEpSVHYyc2I3?=
 =?iso-2022-jp?B?RUoxbENHQUpUNFlWeExUaHoxWUNpc2xvNnZPSkVFdG9mRkpxOE9CWlBM?=
 =?iso-2022-jp?B?V0MrNWYzajZrYnExL2lleW8wOFZ5VUllU1JNN29KdFFZTitmWCszWlcr?=
 =?iso-2022-jp?B?clkrOXhWK0E1VlMvVTlTNVNzMHgxV21zSXo0aXhMbWxNVzluT215M0tl?=
 =?iso-2022-jp?B?NldxK0xQUFdOc2xzZTZPajVNdEVqbllNajliVEhyQTlubUdyNmdvTTZK?=
 =?iso-2022-jp?B?OU9FcHdrQUZkZFhEQzlJcEw1R0F2TGJmSUU5OHJGUUZxWkZlYWpnSUVC?=
 =?iso-2022-jp?B?bllMRThpTEhMOGI4RnFwVU50LzcwcERkeVZCbmRoMFBPTDBFRytDamFn?=
 =?iso-2022-jp?B?WWZXZmVsamljSXhLRmdlWXZjZzdESlloMFhVWXRDbHg2c2ZpYUt3UWxU?=
 =?iso-2022-jp?B?Ym4wRHlpcVAwcTFSZnZzZnFKUDNEM1FmUzBjWVVucStrNWtzcFZGWEVP?=
 =?iso-2022-jp?B?b3VnaUVVZWpkbzJLaW9JRFJUQ2tWdXdubGs0S3lpQ0N0TzhZRmVSOHE4?=
 =?iso-2022-jp?B?TGxTSFBFbTVjVHV5SHRSKzBPemV5cFZueGp3ZjZVRjZETWRQV1N2TWFr?=
 =?iso-2022-jp?B?UjdjT2k4ZUlUaWZmQktlT1J3SHNiNEc4Tm1vUGVOclhlT1Z4VjBGeTJV?=
 =?iso-2022-jp?B?WVVHZkZpV2JrVy9CZWM4RTdTazFROWNISi95QzMvUDFCZkNuOXBPeFdX?=
 =?iso-2022-jp?B?NUx1RndOZ2lKZHdoSkNyZitZZkptMkt5ZkZZZ1VpN2kwZFB3ZEppZkdL?=
 =?iso-2022-jp?B?VDFZQkJreFJ4d3VZbG1IVVJYV3ZuVVR1MWNmTGFyOEJBbHBpeHRtWWFo?=
 =?iso-2022-jp?B?N3docDF6ejVBWDN5blhUWmFNR0k4Yy9selJTR0NMWUx0QjAvN1ZKa3JW?=
 =?iso-2022-jp?B?cjNQYzBFejdrYzEvTG1SMlJnYUh1dXRwMklIVFFFSDc1Z2d5UGMzWTRE?=
 =?iso-2022-jp?B?ajJ5TkxSUVdjS0lUcGhSR2hZbGNReFo1Z0JxTGNCSG5TQzJITENlMGg4?=
 =?iso-2022-jp?B?Vk9aRk9NTUNGdWQxZDlpemNPckRPV0ZyWmlqOE1WTndDUmEvV0JQMmMx?=
 =?iso-2022-jp?B?VHZMQVRXZ2hSNlcxREkzYWZNNVl1cTBuUXJWNGhCdUdjcEdsTTV4WEJE?=
 =?iso-2022-jp?B?QURtREp5SnhVNnJqRXVnb0tsWkxQRzMxWVV5bDdPOXgrQ3YwTFBweXJs?=
 =?iso-2022-jp?B?MGRzdHMxVktBUHpyNVpac25CZmprSkRIWVJNQktJYzUwU01ZWisvRWYz?=
 =?iso-2022-jp?B?ZnR5WUpRemN0S011ZDI4WmQvUlV1Y1dwR1pnVQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bd9703b4-686d-40a7-f5c5-08da42149645
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 08:15:41.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 AIEI3nPXHcpbkImnXuDpZIZ//c1V7MnvoyQb6SwK1mMmgs38O5ZgHKBl5KinbJ8lyZ07OfGioO2+0mbudxlb2fUXFpJ/AXWWnk+13ZJUhe85djPSUWQJ2QLGK12dNBnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4855
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 May 2022 08:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8460

Hi all,

CIP kernel team has released Linux kernel v4.19.245-cip74 and v5.10.118-cip=
8.
The linux-4.19.y-cip tree has been updated base version from v4.19.242 to v=
4.19.245,=20
and the linux-5.10.y-cip tree has been updated base version from v5.10.115 =
to v5.10.118.

You can get this release via the git tree at:

  v4.19.245-cip74:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      0be9d6774be9b192bcea6fddada917ae3d22f22e
    Fixed CVEs:
      - CVE-2022-1048: ALSA: pcm: Fix races among concurrent hw_params and =
hw_free calls
      - CVE-2022-1729: perf: Fix sys_perf_event_open() race against self
      - CVE-2022-0854: swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
    added commits:
      CIP: Bump version suffix to -cip74 after merge from stable

  v5.10.118-cip8:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      fe1deb7aab3c7aa10be6d34eb5d17e4d3de8451f
    Fixed CVEs:
      - CVE-2022-28893: SUNRPC: Ensure we flush any closed sockets before x=
s_xprt_free()
      - CVE-2022-1729: perf: Fix sys_perf_event_open() race against self
      - CVE-2022-0854: swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
    added commits:
      CIP: Bump version suffix to -cip8 after merge from stable

Best regards,
   Nobuhiro


