Return-Path: <marian-cristian.rotariu.rb@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35C62C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 243B38436F
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2sz+3Oj1lCp for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 19:15:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410107.outbound.protection.outlook.com [40.107.141.107])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AE35A81B85
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4La/Rar3YUw5BIuo1y0rnR+EwxbeqkadRDEdxUybJ0pRSoYSNyjjBpt+w3kJc/X2x152JQCqQFf2xSkOjnbvMEvJT6590eAscgOo+Df5qw7RuBNVM650HIP68C440cGpnDg6w33GPBrCcNAELnpJL4/HSezG7ugTfVNtR/z4amXGQSbP0bRgfTRyFwQxBunzte5lftJbjqI7Ve6HP2FXUaHChdLk2IDBYGCuhy2MPoUmN2/ZW4Lbd4CnGlJ0pYOl6U0/n+EatIG+eanAiTH0WZeFNEePy+Ag1sanHUX/2fjBTbmTdRz2Lm5Hwf4OCXvctEQKCimTttW6AuBXB796A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK+gecFi8CMnoxodhHjQlE2La8OvBEhPeFHvHoHPa3Y=;
 b=KNrrDJLCfdgWWwcepiClJYfDZoelUp40ZXyiVbts4ZrIooS8pBqi0VVJohPztndqhPy5rcwoJCJ6rGkV54pPvUE6asp5kwrmOAuWexsdYqVn3cEvDPECAifdOKIyLI8Y4iOXR4Eg9snJSnp14rIImR8podomzbm2up20EDPFseMCHWkVZ4j0DrvnOqYRVnzg7GL1Cfwd2ULIq+a7XCTsfsMriP4zKuLw2b3XcRiFNEqIksAnmSxm//1uLCEanmu0BGamGgTaA0wsJPtrtiWgRYjDSCFie9eeOe7nshOs1BVABtz2Xmc4dKzpnRHi6mxcEjvMcC3S7Mbp5NMk+yoBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK+gecFi8CMnoxodhHjQlE2La8OvBEhPeFHvHoHPa3Y=;
 b=BorWHuAKpq0SO87Z8r0O2O19opb8uyQPHwhRFIqv77xGDi7Uc0GoSKPUwFgTnVgnjRSQBdvL+l0IuoEnc0ENTkEADDA+eHPsRh8kvlFhVRAH/clJUe7UzkZw/HiNjLxuN6cTK9EDMP+j9fY8prawAAru7NCiIuVU5HXPEBKNRQI=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB4995.jpnprd01.prod.outlook.com (20.179.179.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 19:15:45 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 19:15:44 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 16/23] usb: typec: hd3ss3220_irq()
 can be static
Thread-Index: AQHV5v1/3K/uQzYvhUWMy7k0WBbzu6gi46cQ
Date: Wed, 19 Feb 2020 19:15:44 +0000
Message-ID: <OSAPR01MB50286A8EFD6ED76AC8BB33B8AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-17-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219082046.GG31996@amd>
In-Reply-To: <20200219082046.GG31996@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55fae8dc-db96-44ff-6d3d-08d7b5701e87
x-ms-traffictypediagnostic: OSAPR01MB4995:
x-microsoft-antispam-prvs: <OSAPR01MB49957767C3765D51ABF652EBAE100@OSAPR01MB4995.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(64756008)(66556008)(7696005)(66476007)(66446008)(478600001)(2906002)(81166006)(66946007)(8676002)(76116006)(6916009)(81156014)(8936002)(4326008)(33656002)(52536014)(86362001)(186003)(26005)(4744005)(9686003)(53546011)(6506007)(71200400001)(5660300002)(55016002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB4995;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LgQaFBqFkqvNLwRstVk2b68bHbXW0Qx8Nj4lIlxQmcfBBsj0++52tp+NZwhF+9tTt8qTCwheIim0dUYb26mAPzrfrUSHI2fqkb7xTDeYCWVLxuZMAqpDFhUdy9lbx/D/493bhYzcssBrIxRqSGQM5UFUXM/NCUc802LiSL57c4nBS/iZzt0FWc6gOZRTyyJDr1YprB/i4EhO6Jzrco52UlpDiiq9EuZU/S8O+Zy5Avxz20yGmwmIeW8V1sq21PlN8ydkLyyI/VSRBwCW/SkhJfXJ7Z2PpYdhmvV5+J7GW6n6QujLMNmd0KXRNgSFb0ifwiVLoVDS6e77Ttyi6dHsR/fJ35IREINuqbsYTdWnCgDB2kT5rNkRk5mIgd5Klp+0HRJg+D9p19F+Irtd9iabXM5atdc+LTc7YyjQjZaIDlE/y1BhOazlYLAkKH7HIPgX
x-ms-exchange-antispam-messagedata: P7DrShYSiSrRZblxzSjM5PV3CViGYde8pWqo+kzp3n2WL6KqhYV4I6whiv4IGeJ+gcZ0Ye0YQpNQj/Aw2xNRt9iK+X/dLuQRSHmKhNNquPOaPIMjcGjHGN+Kp1yc2VUHmOGa5+804i4o97+QjXgqeA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fae8dc-db96-44ff-6d3d-08d7b5701e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 19:15:44.7951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egC9Ksb+m3iIrl0CWGxgfInVrztvyI3GVQKuL2ZsGNItg7LEomyq8pfBm8p4YX2JYPgBxlxduMNfV4fSJCDUu53WcXJurf5KSNHG6DsapdJoyxj5+VLGFCFB0sfcMl2MLgO3Gd2MYdDUNWjne3HydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4995
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 4.19.y-cip 16/23] usb: typec: hd3ss3220_irq() can be static
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Feb 2020 19:15:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 19 February 2020 08:21
> To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 16/23] usb: typec: hd3ss3220_irq=
()
> can be static
>=20
> Hi!
>=20
> > From: kbuild test robot <lkp@intel.com>
> >
> > commit dd3fd317e2beb899cbffcf364de049b9f9a02db5 upstream.
> >
> > Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C
> > DRP port controller")
> > Signed-off-by: kbuild test robot <lkp@intel.com>
>=20
> This is not your fault and we should not attempt to fix it here, but we
> normally require real, human names for Signed-off-by.

I will drop this in v2.

Thanks,
Marian


