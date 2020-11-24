Return-Path: <SRS0=H64M=E6=lists.cip-project.org=bounce+64572+5839+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE86C56201
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 09:58:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDC720637
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 09:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="P353xDRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDC720637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5839+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Wd6qYY4521723xsoXsa0ot02; Tue, 24 Nov 2020 01:58:29 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.98])
 by mx.groups.io with SMTP id smtpd.web09.50076.1606211907713903231
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 01:58:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbXR/PfRmuUy1refJL/9e6hmw+U/l18sJyzVzyR2srfzHn2kCxO1Ji4PZhs3z2QqCbx2oORzauwaq1o+Z4htOezWCJODePcVRlsp0K76nYXyVlLiPfOBfpJFAu4jAzk8m1ihHLuVdN9J6KTQ6zUioyzf2qk3tfbfon7iZ1s1TNTfvstm6q0xC/v2EF+dFJz0Kp2nMNZuBXJvD6oGoN+B70n8T6YOlRqZ98pNi20iLEF/ycRz6lp+QQ0AHnPaZkIy/vcIuTEJxVkhQK2AuHVrKY4gAH7woPp3UwawBgE7nMxo5S7RKtxODpmaYYIQw41jL/wgUHqZx+CocvVzMVYl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XhbsunhHqFvKpLLZzrBkedLmnr9f9ahR+8nVGIK2eg=;
 b=CRV9kPkHZWTMuJuKDiFyKrS0gWn7q2Dt6Ga/hEN7jjjDSEdJMq9aDq0Zl15bh2nXkk/3GGgqKsdXDC24Cz4QfoPTY9/5xe364UyP3bQX6QalVQMsiXt1xLYNybaGD9A2JW+JWNgSTii7b+XXZfhdxNAbdg7KoKSwUH3Pd+VTL0rXgfwlqG6pIz70MsaxQpWpmzR2ytO67aR1qWJboNSYVJX/eSaYZw/b3Wp2aoatuhsqSSIvO+PnIsnhK/yPUaMlHGd6UgwLFAWmzZubRbeP2aTBTDFQqHZQXaGjwaeMUtM8gDPXFTfG1tUAgOmEfKsrB/XtiNv61OVZBRv9zpq4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS0PR01MB5474.jpnprd01.prod.outlook.com (2603:1096:604:a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 09:58:24 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Tue, 24 Nov 2020
 09:58:24 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/2] Add sound support to R8A774E1 SoC
Thread-Topic: [PATCH 4.19.y-cip 0/2] Add sound support to R8A774E1 SoC
Thread-Index: AQHWwkV50FgLqd4AvkK9E0KoTjarOqnXDAEA
Date: Tue, 24 Nov 2020 09:58:24 +0000
Message-ID: 
 <OSBPR01MB5048A401E2CDE88FFB496611AAFB0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201124093749.GA21989@amd>
In-Reply-To: <20201124093749.GA21989@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d14edfc0-0dec-41c6-0800-08d8905f7bdc
x-ms-traffictypediagnostic: OS0PR01MB5474:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB5474B97A6F7897B35A1966CBAAFB0@OS0PR01MB5474.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 DXeNTut1eGcyx+waGAT6v/2RYVMTJl99Re54sATGEv51MehpyVOr+ntLCsb1wYR7Vhwk5X/Tk/mBi9BKRp7I6uLAdrXHunrEtp/7aCOSxVs5425C05t5/CJ9liMkLDZ2pj2LYaQiPRVl/Z/COvzFi3b5OT08JtZP/x/SO0VzRwIqRMy+lmzUpEf4UKF6ZXNekf26NPC5NueThxw4+5PsiUuKH+Nh9YZYGdfV1Ql8tFvNEQzs2zK4yCVtfrtPimvDgUKUz1p3/8P0XGm7J0Lh2m+CZy1vs8OLSp2nBaiRJRsdpmRik5z5iz8+fmSc49wG
x-ms-exchange-antispam-messagedata: 
 waQvRRp9k1wi225zyR826CyGlTknF0Bv6b2gwmy1ZZrj3dSGlD3CdLfQICZwbw1cAH+gtiV0z/n5GgemOP5RSXJDPC9aUgzNq3njPgQcAOfbxztb/wmjh6psdQs5XGOhJL0t82yIEweFF+UFbHJdOXewAsIiqZREdlPB7zPgXV+EsqknOYvSHy9TAy1HPLUi/v3Nnv251ydACYec5mXxyGpdoithEavez4DL9w+Y7Hk1rtnfH0L9RmuYpLCvHphEiqnVCRjFJyOL/KtyfvNgzgk3JocWMQdB/7rRjyR4YBjF6UXTm/oQGdIbsu8DDg/xIykeXiC74BbYJqJOVFAQjDwBhqqYm88pPDKfZlCUJrTzy8J9o42B0SjEyKYTmzouqfWe1Km/PTf2e6tZ5/GshIBsISdy3WUnkaawr6sZNbIfpAUv+Io9ifgpXlExTUcyZOZmd3fWHDIcz4L5xwTP71gT10JShwTiSdaeH8aTYsdkKYs84eaqjXEPDsQzHrHvC+f36NdHYnuojeQIPMnDfx+258iQguGsSq17HmV3NBmsKKTnR3T2J2R1G81gpiAVAYXkBEk7XCZwsPTIVLYG9hYePOPaoIFOPikehQi7+Uej+Bf8Hc998+fExyjpdvF3KOuBpl5T+vjEHK2rHxQ30miVhtwGUkpvnQDpBCVuZ/c0WqSuOqrWyW5HNXfvQnyoErFQ3uQWxm9cAPk3P1HJS9dnrU32vI4NEAcqEOivLeP5P5T5Ag2CLr+smqyt8axk6X1d9e09i/zn8nOvVpP7Ev/xOxyvc55aU7iWO4E01kv+VtFYlZVKSo0PIeKsiUQuU06Z6NjHeKVJr2+xofF6AbGnnlYh85M2yDqOMx9EOq5ZW2Fq0nqnSOTlcpMnaHbLhfJYBV9K9q2afxuIXlorBg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14edfc0-0dec-41c6-0800-08d8905f7bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:58:24.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWAbfrV16ahvSH8fyThE4L1LTLohL94BT156wt9h/P3rm1bgTh7HZyT6fbdjZMzEdkcZCAVPY/mpjejvQeHN0TlXdaPvKx/vxU1eRd9oNSTBfLHJCA7o2chh42jAjkOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5474
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VmQULaHNJcqodl9BnKoQS7Snx4520388AA=
Content-Type: multipart/mixed; boundary="H7OdmsCzbOlGFvqcBDPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606211909;
 bh=qPZJ4JYt4OL3jzeGn1FbUGRFRdxgXyvfSBn5mRiIERg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=P353xDREuItI3xp3Y0BB3iRfEDRQixaXraG9wVdgjPQmhZDjIkmnox8aeIx5U0Wv4pF
 JBaM1aGdVHS9O66nZd/xVTbBN7JgefLyJ3aVlf027lCkH1SGcrDdGK9rHJqrXylZoi9Rq
 Bf+1uIuc+8z2L1+FkZlihlPFdcsT72O2Fjs=

--H7OdmsCzbOlGFvqcBDPD
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 24 November 2020 09:38
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 0/2] Add sound support to R8A774E1 SoC
>=20
> Hi!
>=20
> > This patch series adds sound support to Renesas R8A774E1 SoC.
> >
> > All the patches have been cherry picked from Linux v5.10-rc5.
>=20
> Thanks, applied and pushed out.
>=20
Thank you.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--H7OdmsCzbOlGFvqcBDPD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5839): https://lists.cip-project.org/g/cip-dev/message=
/5839
Mute This Topic: https://lists.cip-project.org/mt/78450804/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--H7OdmsCzbOlGFvqcBDPD--
