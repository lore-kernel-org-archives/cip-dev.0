Return-Path: <SRS0=I4zY=4N=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3DC35DF9
	for <cip-dev@archiver.kernel.org>; Tue, 25 Feb 2020 08:59:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2519221927
	for <cip-dev@archiver.kernel.org>; Tue, 25 Feb 2020 08:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="POISWPVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2519221927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D402B848A9;
	Tue, 25 Feb 2020 08:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p-K-+O7ZSnw7; Tue, 25 Feb 2020 08:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 30E3A84DBD;
	Tue, 25 Feb 2020 08:59:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B20CC0177;
	Tue, 25 Feb 2020 08:59:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D2DDC0177
 for <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2020 08:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 073B98484F
 for <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2020 08:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SfRWiyEoXlz6 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2020 08:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400120.outbound.protection.outlook.com [40.107.140.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5F8CA868B5
 for <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2020 08:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhWRBLPk/x3C/OnTxPVp+b223L8k+DYzle0Ch7oI7lSFS2D84l2OYi1MjgnsYPeXJLFQ9ed26wtxO1Kx0sS6ZTopCXlGpASSPtm4a5NZfy288d71l4tp+AZkL7rKdYKNej8NqfcK94ZxUJdh8jOJUf/aXhLvXOzNDXZ79UmIGOlCToh4FsLHSVRRgoz2tU9R5nDXU6c9/RtEuYg1/woUfYGW6e8uDVamcTCtnO+OLlcdg/Mk/aGZfxPIXpJDbZ9r+GH49CMl0H0MDHgYoJw4cnptqRoF6xXXi2SYMUWngmDKMZt0YK4WMxiqczG+YDCtQKa7EKtR8KPJ+upKkHn88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuUjUP4LT6MjnFURmgRCyyKOgPN9CnXD6CiNtHYZ5VA=;
 b=N1ZvU5gfdUqMjP61aZhGT4esWpZPBzf2oC7uZnejknJ1fyFcfBDOQnFdLRn++90Vuqok2raR5zyaPuDMeo8m5EDx4ZKhwpFq+0L0b+eKygrXiOTrRHsIr29SYpUQPSVkE+zELmUgVOiKAVx5HcGZWojrvVNfHH1TUJmuhzANjFu1ocRCwgFKpbhHO6YsJU+ZJl8jTFIitpXsMk0xTfa9UJin1Cfo+75hsXggrFbijSiQwOQBffiftCel2T7MY5yYjzJpJuVCiRDA/bmg76VRx2vxCrtqBqECWf00gOpSAPrv5hFzoJlMx+ECWWdIMNMcnKXAlAKgs98s9Drl50u6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuUjUP4LT6MjnFURmgRCyyKOgPN9CnXD6CiNtHYZ5VA=;
 b=POISWPVIyiyZmRBGl463f++H1HHlB04B8MYrfPNYW7B+HlPGCSV1m3EGsZnHz4pKRBELGU/aaNrKYhIrlPSMrvQ1oJiPnSGkyLnFJ2JQBY3quuD/fiTAH7cZmu6yxR1op0qXeaPg9XTr2x5jAPf5EJB6s+RR0RMxsmDERfn2sZs=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB1956.jpnprd01.prod.outlook.com (52.134.235.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Tue, 25 Feb 2020 08:58:56 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 08:58:55 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH v2 4.19.y-cip 00/22] Renesas RZ/G2E USB Type-C
 Backport
Thread-Index: AQHV6obV3ut2XxhETUCK9LWOGXZsiKgq3hAAgAC/9lA=
Date: Tue, 25 Feb 2020 08:58:55 +0000
Message-ID: <OSAPR01MB5028D3186D67969DD6EA461CAEED0@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200223202123.GC24510@duo.ucw.cz> <20200224212956.GA7452@duo.ucw.cz>
In-Reply-To: <20200224212956.GA7452@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09dd6744-c916-4254-cd27-08d7b9d0f1e3
x-ms-traffictypediagnostic: OSAPR01MB1956:
x-microsoft-antispam-prvs: <OSAPR01MB1956F70470451FCB62A1B59BAEED0@OSAPR01MB1956.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(52536014)(66476007)(4326008)(64756008)(66446008)(5660300002)(966005)(66556008)(66946007)(2906002)(71200400001)(316002)(76116006)(86362001)(7696005)(81166006)(478600001)(186003)(26005)(6506007)(33656002)(9686003)(55016002)(6916009)(81156014)(8936002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB1956;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NH+WeMZs32WpuHtG5o4MX3Z+BtJDRfOXLCo+LRTxPr50X+eyYHGfoEA7sIipDWuQ0TEPU5VF9rUXdhMGm4nLzyvvhE3OwUNeIyjj/KmIhgHVIBk7DQVJ7ZxUj5W9Znu+DVMRN38KJhTTOsLm8p+1MTHEWpurgh5ryY6Pn7vOIgpiiGSLSZI8zvB5XJgspzqEB3ew66iC5FZfP9PVvqNavj3EG6DWp/mWmk0u/ukzf/+XcT8/EgOnXyRaZOnqOxJO/ntENShOnMJkEDJHd+sEW6GO9199ncySSHZ2mf9ezvDPp2MZnFsXstzNpgRcnBP3o/Bbp82rKlIY2gARGmn3+hIqilND4DYfRChccGXabtbO9QVZhDLp20Ob22/Xui0TYNj+fuUv/LEYS9r/GZ4BXwsG2iD2wANxNMX4rRNkJNP2WtQEY4lLY8D3uDcRCSh86LrUHtT4fKBjU/4SIIu8sbJKLVt3lyr4bQGSzir0KpmD/B1R+PnqdgvfnK9mZPpdMP5zybqEVLFexiWyCg919g==
x-ms-exchange-antispam-messagedata: aull3F+SsmDOiODTFQ54m9mDL2M1WWHy9We4Ux5/tN41vK9MZx1mZ18FriGyMIvxfBh3eno2H5UcS24HXtmdm5zwz2VRUk9JkJnHc2QtJtPb/OLgzz4tEOfh/6KKIFFLF7849iAfnCtqBHkMRIwzpQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dd6744-c916-4254-cd27-08d7b9d0f1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 08:58:55.6120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnFeIpNYwaUUhbe7q3sd50KV0XwHbDlz1p7YSLRmWI1L7GllRGC+5sZR4UIlmeJDrxiiwGJaWsd9+o/IS1D3ChsbVa8u0Taga1ogjNhHgAm5W5CP2mg9LHD6tEtrcutV54a7H+oPivdOgb4QaiK4lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1956
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 00/22] Renesas RZ/G2E USB Type-C
 Backport
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

> Hi!
> 
> > > This is the second version of USB Type-C backport of RZ/G2E board,
> > > named Silicon Linux EK874. The first version was reviewed by Pavel
> > > Machek. All the modifications included in v2 were recommended by him.
> > >
> > > This patchset revolves around the following patch set from upstream:
> > > https://patchwork.kernel.org/cover/10969899/
> > >
> > > Unfortunately, the driver is using a slightly different version of
> > > the USB API. In upstream, the connection between the fwnode of the
> > > USB controller device tree node, that is the connector device tree
> > > node, and the USB peripheral device tree node is nicely done via
> > > some new function calls that are basically some extensions to the
> > > graph traverse and graph discovery methods for the device tree parser.
> This is needed for role switch feature.
> > >
> > > I tried to create the minimum set for the USB API extension and it
> > > should not affect at all the current behavior. All the modifications
> > > are additions and some rewritings of some of the current functions.
> > >
> > > I also backported some fixes where I have found them.
> >
> > Series looks good to me. I submitted it to the test system:
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/12034205
> > 6
> >
> > If it passes and there are no other comments, I'll apply it.
> 
> Applied, thanks!
> 							Pavel

Thank you!

Cheers,
Marian
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
