Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AADC433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 07:41:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.30937.1644824461099264194
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Feb 2022 23:41:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 21E7ehfl012083;
 Mon, 14 Feb 2022 16:40:43 +0900
X-Iguazu-Qid: 2wGqgqrv9G0D6Dqcuh
X-Iguazu-QSIG: v=2; s=0; t=1644824443; q=2wGqgqrv9G0D6Dqcuh;
 m=uLEPV19EH/TziaUt9u/Qw/JNjrBWMJdW/EmVAx8cZjw=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 21E7eeI8008903
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Feb 2022 16:40:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOk9IEHof2djFixUBHsZaBNcCuTLu4Hh8HLMqd5a3dCD1+w9hnzt1hKFNSDEGNjrx37FxjfcaRi5rz7Yy1sLrEwudzKkRM0fN+gka4qyhOwT+5se9p9mWbt8pCzk9ap+7zko3tQk2n0Ted1LV9YFYOCBYAm3xMt2O+eGYEVG2NqnoYol54KA1kdbjoTwEUJM0o0PsqJRdmSZdIoo4RKLZ9h17cSBcIYYIrkX5LFLnUaa1OMNq8Bzg9R2LWkUWsRczV2uCIQge+BXFJuELyuyO/6ZSfh4E2uakNsQM8wUlK0sgc/R6jOe16dhIQ6BisqO+AzO9huTAwZXmumyf21k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsiWGKByO34GukZQIVur+ygqIV1sgMdhNhwA9AO7BdM=;
 b=f/Y3oBeo6J377CVfDxL5P+6TOSVWsHVuYEtx3/IVrJEB+PBQ4iJ8IkxMQyL+vY1hxpyRaS2rsGVUXva5mj/PAn5Ke58DDCly1qUhv8ZHqMIrmHlDCnYYKLgSDAFhvqP200QHXK0S+RsP7PshCrSTIhxLmh/3XmMoCA+SD854vBVBPIVw/goUbFv+hK9wN+kULH+LMoFy7gKD4+QnXx5UoNtofgzY3Hd7BlenGUHw6rriADzpSaYJSd7/wGg/hUX9/cO6HgcJkxCo3+OCO9iIn95UKrDhXZl+cqN9ZAbBV1u+S7i/nkMwp/qw3KRBkXI95piQqx1zXowZo2x2/t/vLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: RE: [ANNOUNCE] Release v4.19.226-cip66 and v4.4.302-cip68
Thread-Topic: [ANNOUNCE] Release v4.19.226-cip66 and v4.4.302-cip68
Thread-Index: AdghdVZOJAEUrhB6SZCwAgGYA5UwCgAAFn+Q
Date: Mon, 14 Feb 2022 07:39:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62525324BE0ED56C4094A23592339@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <16D396D91883F219.26336@lists.cip-project.org>
In-Reply-To: <16D396D91883F219.26336@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 743042c3-df3e-4a52-160d-08d9ef8d2798
x-ms-traffictypediagnostic: OSAPR01MB1457:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB1457D647860D90E8B5AD7E8A92339@OSAPR01MB1457.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WcjpbHiPsqkesJh9+WoJ4TX9EaCfLGCXyztUWtD7/xMz3DsohRZok3WCnVxnHeQv78ueDv29GtWdOXi8otyD+L1WS2AG0DJJDfGBDHkbmW66f+72RglUHKJmp+tF0LKUadHJ1599BcUd5hrUbqYDXJHs1qsVy22sly+dlEnFkH1NGBFQd+R5qLN023HpFspKIfiBDbIsZox9yoHN3FfP55l7vCN/QKcCjYPEmWOaZERG+k4R7VGR5evOjKFliYsT2zujBLJzRf9WYbj//9/PRC9Aj72O5uvfubQG7jEJF+AC5Jv/f+I+7ieHdRBxZTb0MuJ9omrS5zjrSPKeRyN44FKjyP3bnQZsIo9TZQIpQzJ8cGWbyF+KAMV9BtYdNjeG6NqQCbfWtnnzFVWFVh4rLzy0aBa1aoy9FCIpun14PdMT+raYD+pnBG2cP0rcDaIC1KMYugvFa9ypuWq+kPE2I/w+EM9gK2PoAmAlK0JIiEGmBb4U8Fj2TiHaDIdqAmSShIyQE8Ks/lWcB6dL7xcwuRQl2OI1hgTpEdf/XYvp4nQLStpO1IBVFM2JFkje6phM/sTtTVHYe/Hh16voXqDTGqwBa4k2rmCLBKiVi/kbWgK/ns1NjZlsepTU4cD1jezOVdgISoeROha5Q9B2xRNOXjpmZE2NTGG8TU8h0yabLXmFsTbwRhQITfA0Ur1CQcc0T9xA9lBsd5tyJi39YaLsCYNHIdFPBLjnlelN+xAt32jN6Jj7vsW9I8YycRlYK8wmUnyhp7avk4T/qePGLcL9Pnh2qCJ7FzzY5//TOXrC9CQpu/i0+6r4j0QMbiAZRxa+ebYdCkty0loehAHmwfsghw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(55016003)(122000001)(2906002)(38100700002)(38070700005)(966005)(9686003)(508600001)(5660300002)(186003)(26005)(52536014)(33656002)(66556008)(66476007)(7696005)(66446008)(66946007)(76116006)(6506007)(8936002)(8676002)(64756008)(4326008)(71200400001)(316002)(54906003)(6916009)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bzBCWUtUZUpCcHZOZVMzNlZ5aGp2aEdETlIzbWJqdlNBaXkxam0wUUdQ?=
 =?iso-2022-jp?B?cnJvekNTMHZMMlFyM3AycTRmQVp4MmhOOEFFeHI3ZGt5Z2JTZTI1YThw?=
 =?iso-2022-jp?B?ZEEwelpnUWZ2aERDRXlacnlGWE1LT254QjQzOTcyV0Vtb0FDOUZ3dHNp?=
 =?iso-2022-jp?B?YlUvNlhZVEg1TFFDdmdRL2JzU3ovZVZpQmZPNlhqK1lmbU5LWkRHZmVN?=
 =?iso-2022-jp?B?dXQxeW0vRWtNUTNZaGptS29MMkdKRCt5cmdreXhNRU85RG5OcFRxRVJY?=
 =?iso-2022-jp?B?QVNtcU5qMU4wWXZMMHhzaHBSNWhrd1lnNWYwb09YMGZ1YmlpQlBiUlJG?=
 =?iso-2022-jp?B?d1MvaVFTcWJMWTkzRmRpVTV4MDk4V1JkRkprSFlwMlkycWFTVHFZc3Np?=
 =?iso-2022-jp?B?RmV4T2pWbVQ5bHVvRU50em5vZHBkOUZwSVYzTER3YXAwdThDWE1uUTEw?=
 =?iso-2022-jp?B?UkpkeEhFd3RYUTl0eTZ4MHNWTVRDMmdnK2tMVWJIREN3THJKWlJUM0lW?=
 =?iso-2022-jp?B?b3JzTmYzVlc4QXpsaDMvK0NxakpzTXJpSXFES0VJV2h6Ryt5cC9IUFQy?=
 =?iso-2022-jp?B?Ny9YeE0yRW85N0x0bmRKaG1pejdaNnBwWUlqS3pkRmo1WHAyNUJiTHFN?=
 =?iso-2022-jp?B?dllMZUxZYXU3bHpOMUg4TllaQTIwNVV1MXVzNk1qdFBJMncxRW9LMGlI?=
 =?iso-2022-jp?B?Z1Z4eVRVTWhBMzhXemVBRXNJd29LV0dTaFZON3d1emk3MkFxdFVhYUlV?=
 =?iso-2022-jp?B?Z2I2UzcyNU4xSGJObHlwWTRreXMvREFXcE9pRFY2c1VMcGZ5OHphOTcw?=
 =?iso-2022-jp?B?cWhkeE9KcUNaaVdDeG9WZUxMZkNZbEduaVcwdlRNdTFmOVlVMkRyOUJx?=
 =?iso-2022-jp?B?a1Y3V2FwQ3ZEQVkwRkplN3B0cVh3c3dCK0ZYK0JSUWQ1aWZOUjllOHJp?=
 =?iso-2022-jp?B?dmhQeHkyTHdjbGJPZWNuc21vUDBkN2Flbmp0REdkYVZad2xOT0FTcTNu?=
 =?iso-2022-jp?B?OGl1RHR2ZGFvUFhXakVtU2NEVVIrVndIYitNaHFBYmh5dWJQMHZ2eVhQ?=
 =?iso-2022-jp?B?SXM5emZNRzlqU2JFUEJIYXo5RDZOOGhYRVJRS29KcUZaTXUrY0grMGth?=
 =?iso-2022-jp?B?elljcndObDV3L0VKNFlPTndxOUNRdHdCeldhVmNXcXpET2VsMGQ1aWc2?=
 =?iso-2022-jp?B?M2RCN2kzakRxbnhwWmZ0bzRhVE9NbnlVbTVOK2VDeHhHOHZCdVVDSnd0?=
 =?iso-2022-jp?B?Z1I4NGdKK3Y3RW5GVWhpakNXNFFXM1M0QUdRbC84QmRkMmlqbm12aDB6?=
 =?iso-2022-jp?B?WFR6eHlycDJSK2VHdnhnVVVqaU16RWV3NzNzbTc3c1ZydEVscnBWSjNa?=
 =?iso-2022-jp?B?SDNIb1BpUW5aSXRPZFJpd3lUMWtRQWZ4MkJBbUxFcjVDUGVPQmF6YVM1?=
 =?iso-2022-jp?B?RmVGbGt0d21VSEE5OG5Xak1pNWNIZHp5bys2L1ZOL09OWUN5S1BHL3RG?=
 =?iso-2022-jp?B?Q0ZlbTE4YWFPaUZLMW9kejY5U0pWNm5yMDhGOUtiM2U1WWkvZjdUeHps?=
 =?iso-2022-jp?B?TUFWSzlXZUFoN1JaQ0hjM09ub1V2LzFJYVlBcjAwZ1dlYkFTMS9XdVVH?=
 =?iso-2022-jp?B?c1lsOVFlU1Z3d2k2STVGTC9lSXgvZ0NFVlNRdnRyUStYUm52MnpCdmJm?=
 =?iso-2022-jp?B?S1V0UVdwVmVjcjhOb21GMFdXOCtyN2xYRkJpelo3R01YV3lOeUpPNkY3?=
 =?iso-2022-jp?B?bzJGVlpkR2pYZFRNSitmRmhzLzN6NnV1ZnBrd2FWdVhaTWovWHRRaGJj?=
 =?iso-2022-jp?B?a3lJRkVZVk83Z3lRd1h6bmNRbXp0N1h4NTZ4cmkxNFlLTkNMT2VsSkxo?=
 =?iso-2022-jp?B?eVQxZ2d5ZTN4ZUh5R2l1NlZnMTlualM3T0JqN3BSd3pZQVQ5LzkwVkQ5?=
 =?iso-2022-jp?B?c0RYakY1cjRRUGsrZ2o1c1ZCaWtGN3BTV2xpMVFCTFp0YUo4M04wc25q?=
 =?iso-2022-jp?B?UnUwaWdSazlwTTMvREU4Rkd1bjB5aFk4U2xUaXhZRUduZUoyd2NuSWRD?=
 =?iso-2022-jp?B?WkI4SDV4Zzl5ckhwdTJXVm1NckZxazVGYklBaEZLZGd6ZGhCbEVVWjBR?=
 =?iso-2022-jp?B?NlQ5V3lDQlFOZERUSzduNzEyb1IyV2F2OW43K3ROWW1JdzdobHVYR2Rp?=
 =?iso-2022-jp?B?Yk9Zc0pxNnJLbW96UG83dkFaM3Z6dzhrdzZGZHBGdXN1WjdtZll1eVpx?=
 =?iso-2022-jp?B?empTTWtJV2tJZ2ptQUxpcWhVdUM4ZmZBNStRb2lmN1ZUdUtjQjdiZGNU?=
 =?iso-2022-jp?B?UjRzbUtFdmxybHA5K2t0eUYybTlmWkdCUXdmUklvNmU4Zy81ME1mOTNa?=
 =?iso-2022-jp?B?UEhzcVVtcm1yaVhnRFN0YlZKZndyejRibDZaejNCbXJSZXFaNE1ZQmRB?=
 =?iso-2022-jp?B?OWpFQkVQM2Z3Z1VsMk53KzcwcGh5b0JqRFpRc2ZlcFk3dUFtRWR2TUlP?=
 =?iso-2022-jp?B?a0xKZjMr?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 743042c3-df3e-4a52-160d-08d9ef8d2798
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 07:39:38.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 7UE2ykET0+POVnZRWT3xdIfotc37WtSBBokXRKmK1zFX3f8QU8MOjUEnGipXb5kE2vU2BJxxDVzNb4agAmdvEbSgrnGv8++jbpuQokyIFQBGPf6AS93/vXjap7IhHew5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1457
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Feb 2022 07:41:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7591

Hi again,

> CIP kernel team has released Linux kernel v4.19.226-cip66 and v4.4.302-ci=
p68.

I was wrong. The correct information is:
CIP kernel team has released Linux kernel **v4.19.229-cip67** and v4.4.302-=
cip68.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu
> Sent: Monday, February 14, 2022 4:35 PM
> To: cip-dev@lists.cip-project.org
> Cc: pavel@denx.de; jan.kiszka@siemens.com; uli@fpond.eu;
> masami.ichikawa@cybertrust.co.jp; Chris.Paterson2@renesas.com
> Subject: [cip-dev] [ANNOUNCE] Release v4.19.226-cip66 and v4.4.302-cip68
>=20
> Hi,
>=20
> CIP kernel team has released Linux kernel v4.19.226-cip66 and v4.4.302-ci=
p68.
> The linux-4.19.y-cip tree has been updated base version from v4.19.226 to
> v4.19.229, and The linux-4.4.y-cip tree has been updated base version fro=
m
> v4.4.296 to v4.4.302.
>=20
> The 4.4.y tree is EOL[0], and the release from the LTS ends.
>=20
> You can get this release via the git tree at:
>   v4.19.229-cip67:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.19.y-cip
>     commit hash:
>       c390d35f51edb249e63aab6fb5086ac4e0bf90d4
>     Fixed CVEs:
>       - CVE-2022-0330: drm/i915: Flush TLBs before releasing backing stor=
e
>       - CVE-2022-22942: drm/vmwgfx: Fix stale file descriptors on failed
> usercopy
>       - CVE-2022-24448: NFSv4: Handle case where the lookup of a director=
y
> fails
>     added commits:
>       CIP: Bump version suffix to -cip67 after merge from stable
>=20
>   v4.4.302-cip68:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.4.y-cip
>     commit hash:
>       ea2b25643aed790866a050f9605bbe7b845b8f31
>     Fixed CVEs:
>       - CVE-2021-45095: phonet: refcount leak in pep_sock_accep
>       - CVE-2021-4155: xfs: map unwritten blocks in
> XFS_IOC_{ALLOC,FREE}SP just like fallocate
>       - CVE-2021-43976: mwifiex: Fix skb_over_panic in mwifiex_usb_recv()
>       - CVE-2022-0330: drm/i915: Flush TLBs before releasing backing stor=
e
>     added commits:
>       CIP: Bump version suffix to -cip68 after merge from stable
>=20
> [0]: https://lore.kernel.org/stable/1643877137240249@kroah.com/
>=20
> Best regards,
>    Nobuhiro



