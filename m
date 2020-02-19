Return-Path: <marian-cristian.rotariu.rb@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32BA2C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1C30284587
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u6CIWP9YRwot for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 19:04:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410113.outbound.protection.outlook.com [40.107.141.113])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AAA7D8443D
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATGcRvaxEmOORPa9tcHYCpqKsR3gea9zFhWFm6J7tSAkvCeDMAHEHmul7603vbC5inAoVoxG2ILwayaY+5uP2QWK67I1FcSLkEvseArtLaCCc59G6Yhz4mxBj9WwVFqx/SO7v2my+y+dNnzr0vPvB/txKhlDwaoqRfNBKAOLffwOmSpcB41OI8AmisN7sr8a8JOIjV6Gv0J5KzU7VeOL1aVQ42DfAjjOUcks4eoRcLIpCqf/yYOfjH2pCC1sDkcWLN1BA32XA3WzPoV1eXylQS35/25ydKBUC59V07ANXBw3J2TzGzs16URCtCfn8t03rxE2436VlJi2uQrjtTTFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhI1k+jkh39xmw06JWpUZxmynK18HxSe0D6ysyugfoU=;
 b=SwkL2F0nFRKvOZCKbRzjmUGPvcFLfr5ajuBon4Zs56T7WANQO2puH0KlPKdRLYHt4iGDRnCY0E82n2uxPpBEkd6mgtYjkcaA7BgKGGSWXkqUcB2W2UPk/UWjwdwIWpLekW41gtEx66WTtTjnaD8xxDQOD66LbY1J1tOq7kaB29gszzR0ZaqacTcTR1vX5KeA6Hn/dsjRT26HYKuVofkPqPC8iVnMgCAX8U30VoCKbLWeuRKPizyTHatNviCkEJn1/LjGHLcKCsQyyuMzFVt1wtIQjjThmiZ6F84nDrxx14BOYk11wITp2Igkd9MfeH9fa/Uu1cNIkzC7Ynpw1HFAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhI1k+jkh39xmw06JWpUZxmynK18HxSe0D6ysyugfoU=;
 b=s3w2bIKTpiqA0Vjl+/C8z/8wInhYMeyj6T6S+9yivSfPKnEn+fNpBfmm2ZxbvrZjpWk6mmPBAzo2jVjGpvGnhw5GPN2fUgwtSCcAPFTZCiPGoTJQHuZlFyyU/XUO6a66QGT4rs26Wk10SaW6JcC90xpPwQp54TPtB7JaDzgtIkI=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB3620.jpnprd01.prod.outlook.com (20.178.128.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 19 Feb 2020 19:04:17 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 19:04:17 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 04/23] usb: roles: Find the muxes by
 also matching against the device node
Thread-Index: AQHV5vlgmn+ZrgaDyEK7nGIgcqkG7Kgi3LTw
Date: Wed, 19 Feb 2020 19:04:16 +0000
Message-ID: <OSAPR01MB502856456636C79D7F6490ADAE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-5-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219075114.GB31996@amd>
In-Reply-To: <20200219075114.GB31996@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ff39354-1b8c-4209-e0e8-08d7b56e84a5
x-ms-traffictypediagnostic: OSAPR01MB3620:
x-microsoft-antispam-prvs: <OSAPR01MB36201ABD25D25F19ADC4A214AE100@OSAPR01MB3620.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(55016002)(9686003)(86362001)(4326008)(478600001)(52536014)(5660300002)(6916009)(966005)(33656002)(7696005)(53546011)(6506007)(8936002)(71200400001)(81156014)(81166006)(8676002)(66476007)(186003)(64756008)(26005)(2906002)(76116006)(66946007)(66556008)(66446008)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB3620;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXIkry+IUMiydM3LLYgof0ZKPawmFKobpzHipQJjRj64u8WqmtsG2KgvCLMTmij+W2rj+r9TF67wZ5DUjj6x8EQyVu/WGZL9hIIqyflpTBrpw1sSmPjUNvQXKgGYaTUMgpCESza3VSZgZDj7gKzcoJPDVYMOUCGyK69bKWOqinewyOjDhoicv2JzX4RgcXhAgiCkj27bb7y1it1kqoFt1JyVw7mCq7eM2SALeAbCNZ9KZ+h00+Ju6UpUBWETzdoTC8WXSAMa8H+hwRkIvq0iz7vM7XFzBr70ZQlR6hjiw4gFv1mJPPmDrBF1Kb3wmrTwu1avWRpBkillTu4oIzcT3dOWA0k3z6JU5YPLqtqiyoOh2Pix2iJQ6K9cXhRZ6rIuLLPeO5D0d4T54VcMkLqKbp1fnqYrytw2stj9coOTGHBumyuyXzHaiUmnSIW9tSqCG/L26UqM33liNy/ehxSivfrF3I8QJU3bIoso4qjcYNZ/rdS/XL69MLhgW2F02j/hw737iaVfUMHva8UNnWtJOA==
x-ms-exchange-antispam-messagedata: RjqkzXtB0ErNvFcsqHcI0KXxFl17fB0omNzaQBZCXwnX9O8qONSChLnFJB3KgOaJFU0279GQMSaNJ9H8g+TiwIHpE3HRGbIDprq6YUle5vEkcBDtXbj8a+VksEMrY1LUZF1eMs4hv/Q/44YvmPk3uQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff39354-1b8c-4209-e0e8-08d7b56e84a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 19:04:16.9419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEJfu67tGg71ki2NaZVKcWc8D6CEicqavi2ybeMxcwh/2r3Zb3lZA76JRRz74urYErY6lZVVkxxE4HuyYxDOndcMiXvIfGdcfswnhKri83DdSOCNyAnpjesJx1sPj5oJEcqMNniHEU0HhR+8TItYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3620
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 4.19.y-cip 04/23] usb: roles: Find the muxes by also matching against the device node
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
X-List-Received-Date: Wed, 19 Feb 2020 19:04:23 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 19 February 2020 07:51
> To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 04/23] usb: roles: Find the muxe=
s by
> also matching against the device node
>=20
> Hi!
>=20
> > @@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct
> > usb_role_switch *sw)  }
> EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
> >
> > -static int __switch_match(struct device *dev, const void *name)
> > +static int switch_fwnode_match(struct device *dev, const void
> > +*fwnode) {
> > +	return dev_fwnode(dev) =3D=3D fwnode;
> > +}
> > +
> > +static int switch_name_match(struct device *dev, const void *name)
> >  {
> >  	return !strcmp((const char *)name, dev_name(dev));  }
>=20
> This renames  __switch_match -> switch_name_match. That is welcome
> cleanup for mainline, but not quite neccessary change here. As the functi=
on
> is static and local to the file, we can live with that, but I hope you ha=
ve not
> had to do extra effort to backport it :-).

Unfortunately, this patch is necessary for the following patches as it intr=
oduces
the necessary fwnode. Generally, yes, I had to find the minimum set of chan=
ges,
not to modify too much the USB core code. I opted for complete backport
of the upstream patches, not to chop them off and also not to add much code=
 on
top of them (only some minor checkpatch fixes). I think it is better not to=
 increase
the delta between linux-cip and upstream too much.

But, looking retrospectively, this might not be the best strategy.

>=20
> Best regards,
>=20
> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


