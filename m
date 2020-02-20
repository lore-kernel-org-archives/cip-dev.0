Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BBC11D05
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 16:28:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298C324673
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 16:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cyDls5fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298C324673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCA2A84627;
	Thu, 20 Feb 2020 16:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b6e41P6fS6Rm; Thu, 20 Feb 2020 16:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 735FC81FCC;
	Thu, 20 Feb 2020 16:28:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62079C013E;
	Thu, 20 Feb 2020 16:28:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4F24C013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 16:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DDA4B835EF
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 16:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8RtOivWMaigg for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 16:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410093.outbound.protection.outlook.com [40.107.141.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 78FFA86073
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 16:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6S7vMOlbVMBdsURUfvWIG6KsNdVwh3a1dIpKD9OKyvtW241TxYFzwO0n0f1sEf+jlnh89xbcxbEbDXE+L0EdoJiJNlSdX33pjGhMBPyFPdUd6AWqVMR8Kz3JTQ4dpt3ZuMAdzhdWPFHn63WOlde5B214oZH4JU6imT2DZT3vlUqZNEEkV/m16sg8UsK30HHebmIwGlQg9lxS4Hx/+MXRjH7LhERJgTdV/zspupGJR302Ud8wjMRTcL8VzidjMgOVD7GAHZrpyQmuOnc7urgdRb+tA8SEnl/MhRuY4T1a0z+6gP9nkIMWRjhf1+zHOE5AFtWojyFLxHf3D6buOiLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aueo9w123H8WBa4LmzhA0tku+uVzN/J23w8xPQju8mk=;
 b=JA3XsdFVTvGut6mvEinjg1HtjOpsQ77GT8/kpHBRV3vMch2H1n+Qfh8cGI8G1xHZNoXWBJi2QJ3zdyQeCg3DAOUsTXaXZUwXbBFB28yQ1qDPii08Qm34dxuo2masWuiZaCEphyAZo488BmeWTdHnzt0nD39SGnwKojODjFAlyFz7dHQ1cNYHVmyCVMEpmSdEw90dqKnZE0JliXaH5GhQ4dekb5xfcoV5oGpAZ0A8HlBIVO4hvRNo9dG7fRuMdcevNuBCoGQ0qHqS91dGt+//5TzLmtuH/yeFlWag4AIJqS2QHrY974BSmY+n+EGDQLqY2M6EGmbSCVxLY2A8rw7SeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aueo9w123H8WBa4LmzhA0tku+uVzN/J23w8xPQju8mk=;
 b=cyDls5fNtPT18OmHq3sIFyEiZusIE5KJnKxkzLOpsoWPXd9ChC5umavQYVBXLKgyjajPM/Fy68YHfDWEOoBmpulBKcyrLZDf8xZr9CXYBWi+uluOyzuHYiUutVxBHsks53JC0Q+qaHltzPlWnsbe5XDS2qkgFtY2gADRvTljmvc=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB3026.jpnprd01.prod.outlook.com (52.134.246.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 20 Feb 2020 16:28:07 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 16:28:06 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 15/23] usb: typec: driver for TI
 HD3SS3220 USB Type-C DRP port controller
Thread-Index: AQHV5vxbM2cAaZW+M0GaP16aywZW06gj6vowgABQ84CAAAh5cA==
Date: Thu, 20 Feb 2020 16:28:06 +0000
Message-ID: <OSAPR01MB50285AC7E7B81A56E26497A0AE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-16-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219081234.GD31996@amd>
 <OSAPR01MB502894683145EEC15BD1DDD7AE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
 <20200220154643.GA26735@duo.ucw.cz>
In-Reply-To: <20200220154643.GA26735@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee968d36-c489-47d1-e6bc-08d7b621ddc3
x-ms-traffictypediagnostic: OSAPR01MB3026:
x-microsoft-antispam-prvs: <OSAPR01MB3026A1787841873BCFA5B8F0AE130@OSAPR01MB3026.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(199004)(189003)(86362001)(33656002)(53546011)(9686003)(478600001)(4744005)(6916009)(26005)(186003)(52536014)(6506007)(8936002)(4326008)(7696005)(71200400001)(55016002)(76116006)(8676002)(2906002)(66946007)(316002)(81156014)(81166006)(66446008)(66476007)(64756008)(5660300002)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB3026;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/k6T5hIoIiqBNu4RZcJIq4DqA3eDadJanj961mFNK8LwzXHqZEsXTlzVYebmfhdN0aUpJRMc0cEtvknI5+XMcDTL0V4rYBLoydCICV6zHpmUvjNrJbXmkL2PF2VvYpFVhvDNr+kQsThXAM1hdWmuhIsqzMWJfXe3WFGRPHzgDYBDEwQoUuEfHjxYBskWwNCfKMwAn+6jaXwnhpLvsoByKNoLjp6A1H+HYEZyRFJ7Yf8i0duwYfMr12BmApzsTEWY7vYjWEc0DGrbMy91coFQcVgvfWZ7FmBouyP0iO7H0FotGIFwp5USOMZPjqnEHAvAZu/OZV63CiuyQxa//NaYH5ZIRVCHObaKFxjVOkqXly6Axb+q1RT87x1YgaQsr43WkjN9opDyM9/WxASY2QtSDF9ANVvqLe+x8IwYtzYZfazfE5skxC9CB3r1jbvuKuA
x-ms-exchange-antispam-messagedata: CeRE2dt7OTFg7j4nOEZPOUy4TEcCGo/yD5Vxt6Lm1uSR7XZoGXc9ZTlzgeuKDgTq4MNYd1h1DJR9Khcj+i6uSe1Dv05nuJS3RRtyw8DIF+xq/QMTfQVSPQTmNzHXqnAKqKRaLUsN0J9Bh43iNCLxxQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee968d36-c489-47d1-e6bc-08d7b621ddc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 16:28:06.3995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozNKzxCZNEAFGpcEJw/3T1O0oZ6Bbv8ybFTOw4XcznRuxyCOU7sv7j4Ha/0IpR6Tx/0INld/I7Xcz0F9c7QuJecIdtB85i0TIvp4CQNzv3Ht1BygOtxfEGDeZ67zrJzXWGiHSyV+br7Yw9QpIdpCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3026
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 15/23] usb: typec: driver for TI
 HD3SS3220 USB Type-C DRP port controller
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi!

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 20 February 2020 15:47
> To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 15/23] usb: typec: driver for TI
> HD3SS3220 USB Type-C DRP port controller
> 
> Hi!
> 
> > > > +static enum usb_role hd3ss3220_get_attached_state(struct
> > > > +hd3ss3220
> > > > +*hd3ss3220) {
> > > > +	unsigned int reg_val;
> > > > +	enum usb_role attached_state;
> > > > +	int ret;
> > > > +
> > > > +	ret = regmap_read(hd3ss3220->regmap,
> > > HD3SS3220_REG_CN_STAT_CTRL,
> > > > +			  &reg_val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > >
> > > This function claims to return "enum usb_role", but here it returns
> > > errno from regmap_read.
> 

Yes, this a mistake. The error should be properly propagated to the callers
(that is hd3ss3220_probe)

Also in the mainline. I will fix it in v2 and in mainline.

Thank you for the good catch,
Marian
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
