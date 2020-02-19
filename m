Return-Path: <marian-cristian.rotariu.rb@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D34CEC013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C1878866AB
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E+8LTF4ycbEn for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 19:11:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410099.outbound.protection.outlook.com [40.107.141.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 651218663C
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 19:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4pGyyAQDrycIbL3Zb5W8TRMQdaT92zCnr94xA+3vRJ6GH0dVrAIV7J1xG6cDZpU9vePkSkt984RJFMORcYJdsMFH/hWaY9dHQ4dd9pScw/M6x8XUGx8QHVWOA3K3QCHj5BAJealbkeJL+e8/ns+swMaOKr2ZMmIMx+05T0t3NSyeXy+3C+ClSaC9eAmppkfkPtJfqj30Fg/tKfvmnB7OoToTwG2pz7oABnW+0h0rj5FiEZnfRySsX2Xe/LsROb4hEYfL01TBTRc/NCVPgpn4w4cqyKuiI06OrYMMzeRZK9Wv++/YO3h+Ic+QFlrnECR0DL8J1AdmyblumP/XPskBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRtTsQb2YqPi97FX5M/kgpH79QIo4SO9Dna6M56q0Jo=;
 b=m1eLxUCI/UFb8ro8tU4/kYcxp3BSwr1Vql2Yxd+My723idSLxpHPlWPFETxq8W/8855IwnpbR/u58SWV64ZUuhmEPcFmdmpFPzsobVzghQ9ySLrl2GqGCU32hhzQvDOPHeXnNIBYW0jj1LTrQxE/LT6bOEmzhVFizMuyfoLosh18NjapsZQC1QYZzzfLKqW/A+v6AdjvXtd78u+vxm0BN/B+JF0MZ513jL+9h6v2qiXprLsKfJ/s6IldnW7bCTidkV4GgzBwlnhH8jMYvQpuMO2OBun+sjwE9+wDY6Jsdr7JQTkFNZWdWQl5CUj6h71wwF0xn18dleW/bS6e61mEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRtTsQb2YqPi97FX5M/kgpH79QIo4SO9Dna6M56q0Jo=;
 b=LdtOYIHb7rI0e/tWFwtT2FPysyG7szSsMpbiexFNptjj7cNS/CbJPxnDcYV7XPLRyUD6Oo2Bdc7lNqDSnqh8J/s4FRSitPJZwb/jixMVJqutiodF2Gndmr+yvizej+GzhpgmwhMbfqSu7f3OFN0cY2DioYurRKGEkogXYEfsEmY=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB4673.jpnprd01.prod.outlook.com (20.179.179.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 19:11:00 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 19:11:00 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 01/23] device connection: Add fwnode
 member to struct device_connection
Thread-Index: AQHV5vgpA1MVZiLBuEKexsAY1lfzSKgi4SOw
Date: Wed, 19 Feb 2020 19:11:00 +0000
Message-ID: <OSAPR01MB50284ABED8F0CD0555EDF057AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-2-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219074232.GA31996@amd>
In-Reply-To: <20200219074232.GA31996@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a27fe086-e031-4e25-90f7-08d7b56f7515
x-ms-traffictypediagnostic: OSAPR01MB4673:
x-microsoft-antispam-prvs: <OSAPR01MB467363F4BE5E49FFCB5FA165AE100@OSAPR01MB4673.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(76116006)(8676002)(6506007)(478600001)(66946007)(81166006)(4326008)(66446008)(66476007)(66556008)(64756008)(2906002)(81156014)(8936002)(4744005)(6916009)(7696005)(86362001)(5660300002)(52536014)(316002)(55016002)(71200400001)(33656002)(9686003)(26005)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB4673;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgJQjiS2DS9yC+cm+IhWDCM10ISES0/PXNQUjhoPMEw0qo1/brQfwpVA0idtAwzocDwG95TO1kpaUQ+GMrBWd8mCJtL3L/Bimmo40FzMOHhTY2LTComjOxmu4J/5yjwZdV5+c43cx1RbM7RadUmFSufXUxoWUX7h+fU90vYP6x6Hd1Kzrf+nlj29/Qb8IWYcIfd9t4yYmRJ989MxPFynINm9Qs2dWzeFXD62O7EhrudXIdOPKjzoy/RztAdvUUkDoQ3iPkAGNOwa7XeVRmNFBUBYnsiLYZIpbBn1GykCJdmvwcZFjb7vuA3XmMep9tYKsITKi/ANUIbwNEZBs3IzQ2DScTkEKe0EG64yZDKE8qYQXAXbI4sslDE9oNZ1OVzplDR9To6K+BhaWUT1ZSNTtc3mR9i3y/5jYb7FQT3JoD7FmFiKgaoq2cgLTKsIfQbM
x-ms-exchange-antispam-messagedata: IA6Q7GyL6ys8FQ6Ui1MygZMxVzZP+EXgc74B7K5voAwsxs7ZA4XG+iAEwxKo5HnelaFwuAtNxl3Mk3H8/9QiRZZhnFqdal6WQq2MwaSGJHbjqyTTF/i2MC49poYol57+9bIqDmQm91xXV/dvCHpuAw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27fe086-e031-4e25-90f7-08d7b56f7515
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 19:11:00.4010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqTCttthbZYyd5eXf/jXFJNhVTBL66iwptqHkYC9L96IV/1ekNxgZpBAzM79ucR2+WBQd141AdkLZJin5QQIf6GbQmA6q4kGUbFHN/GoyeZXK7BeEBa7AOoC8OrNrm7NkjAUrc06s9JErz3gN0Gh9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4673
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 4.19.y-cip 01/23] device connection: Add fwnode member to struct device_connection
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
X-List-Received-Date: Wed, 19 Feb 2020 19:11:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > commit 09aa11cfda9d8186046bcd1adcd6498b688114f4 upstream.
> >
> > This will prepare the device connection API for connections described
> > in firmware.
>=20
> > @@ -753,11 +753,17 @@ struct device_dma_parameters {
> >   */
> >  struct device_connection {
> > +	struct fwnode_handle	*fwnode;
> >  	const char		*endpoint[2];
> >  	const char		*id;
> >  	struct list_head	list;
>=20
> Ok, so this really needs to be 0-initialized in all cases, or we'll be br=
eaking
> existing setups. Are we reasonably sure that's the case?

Yes, I need to add two 0-initialization to the following drivers:
drivers/platform/x86/intel_cht_int33fe.c
drivers/extcon/extcon-axp288.c

In upstream, these drivers opt for fwnode node discovery instead of device_=
connection definitions.
I will do the modifications in v2.

Thanks,
Marian


