Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A04DC11D04
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 10:44:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9830D2071E
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="W5w6cu3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9830D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B90882465;
	Thu, 20 Feb 2020 10:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n0_Tf9fdUgN1; Thu, 20 Feb 2020 10:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 93AC6822C6;
	Thu, 20 Feb 2020 10:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FF0BC013E;
	Thu, 20 Feb 2020 10:44:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03FFBC013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 10:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E2E5A20789
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 10:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXhsuYWYCkks for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 10:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400101.outbound.protection.outlook.com [40.107.140.101])
 by silver.osuosl.org (Postfix) with ESMTPS id 36B241FEF0
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 10:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC3/zRAcb/ljDyuGd8TO+suUQ4IlTmjtFeo8trhktPhJgsNQZGymznXvwG0Mqp4R2j2nNy3+7gGWYCV1ZyHElaK99ypmEkum19/ZD3H0XF64HPbyYkacWiy4QIqWW0C9YECvIE0ycbHN3xErzONwSanAWx0zyboXVqDopoPUVZFg/oQ9aVhK31VD1T4nZUb6kD0+fVXwDF3Ii6sLqD1y1fqmy4r4uqReTIBU9ziwAqKQFtg6fqm5bsCpvGN4YIvxR5+rCmFYI0u7lkBa0Nsk8CSCR9EdXdIzfqtV4FJOCU8h047qNa0SuhM/x6S5V6bRlR9vydQsm2lZF6RD/9F9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cmHSKslqsAsw+qU7Zo5wZHxx9n53yx8Wc3d9QJTeg0=;
 b=B57VufLMw4dhHd7qeMijo+xK7f19irFnKKlocaKRfcl3Y+I5CbaWiNEWnJosKIPkdmTWpnGMngcH5/3+HBf898jxHUtl1+SeCALmwnq4G/JSlBv9XJiHCYnAU+Es8GwNGhRkYKthpE+hW4RioHv2mfAAFGhi6IiRCHmkB/vnKERXQyQIT5l0sjP7KfKEd/WD03FUV8qgoVaPN4XY4PVQ0kfx4u+JvuDkG9iKXpSgPjJbANwxzESsqK7ZrtVw8yc50WyDlve8mPgbQ/vGwHktkOvV2S254wluOBHV87Ed3eSgIjha7iBRmEVwYk0j1Dfibrl+T8VM65Upef2OJoKatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cmHSKslqsAsw+qU7Zo5wZHxx9n53yx8Wc3d9QJTeg0=;
 b=W5w6cu3C+wqzjppMf/iVlSlOxzN7WCPXalP0HTVXslGom/FQ3S/oINslmuadiVzdmGHSCp+lv0vdZErTMCZv75td+0BvEsx3ScF/y8qvDTWd80FLrbrHEFqC5SqD2dfUqL8zpukRQaoPdTzLKVpN2BBwl5b2QCsgu6Qx/T+qnmc=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB3889.jpnprd01.prod.outlook.com (20.178.100.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 10:44:45 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 10:44:45 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 05/23] usb: typec: Find the ports by
 also matching against the device node
Thread-Index: AQHV5vock8qsPk6fpUqIY6lBRA6ZOqgj4sjw
Date: Thu, 20 Feb 2020 10:44:45 +0000
Message-ID: <OSAPR01MB5028928128CE601FDAFB1AF1AE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-6-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219075630.GC31996@amd>
In-Reply-To: <20200219075630.GC31996@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbd7ad3f-29f2-4b05-73ac-08d7b5f1e674
x-ms-traffictypediagnostic: OSAPR01MB3889:
x-microsoft-antispam-prvs: <OSAPR01MB3889E527EF5C611944A75A8CAE130@OSAPR01MB3889.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(71200400001)(316002)(4326008)(52536014)(86362001)(6916009)(5660300002)(55016002)(9686003)(8676002)(53546011)(7696005)(66946007)(76116006)(186003)(2906002)(64756008)(6506007)(66446008)(8936002)(81166006)(81156014)(33656002)(66476007)(66556008)(478600001)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB3889;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V0FpgfygMnfDHG8EQ2tEZOllF3VggHZIY6ZhxZEPhNChVKL5ZmqGaaEua3gL/qR7ptX+li9OXlnX5elQ1nVy8abBfKjsTosNw4llG9JcVmIKcvWrtV1gTYk2Y0ngSID/+M9p+WtimEVSaMq/+UFSjUJiZxuJGJ3ys98XSSDy+bvKmzdokQThHHmAwjygPRYDJg/U1PUuxm3nFazWTTASA5XVdLyIRYg/eCT73FGADlPjMCq4AXiDFESzkqWrJjGzZnZh/d79MwHGNPBOh9C6PTXU+X/ES+tR5QkZGTaeaISWhuhMy8Cy1r83Ao8rw8A0eLMtOENg4UJCmqRYTc4eoX8bsxRmvw6ipRFs/ESsXLa7wqPKHIxjA5dxQobr3NJiCJxffCTWSE8qCfBYO4zbENiuSC38EDLxWNPComniBZXIZURivpvz6vuXTqdfMnoV
x-ms-exchange-antispam-messagedata: fg1YJI4syG5DQQaPsKMKcphBxkUDAzCJa0+jVmrcTpCXrlIuidZ2AUbIQawXnVILFvV7R67f7yMooIaEopBvxtPo794Yk+1FmcZFBQO4gxjdxiGV1RjUxNpyREqWCloNmM4nbHNY8Tqde4jGtVJ+NA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd7ad3f-29f2-4b05-73ac-08d7b5f1e674
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 10:44:45.2972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTtgW7NChNOL2CZvy3UByri+Fnkxqxr7XuSkiBNpffCcghsTEp+wlBncsXQmTw1JIjnNJAvEAA1kk+OlJ74tuTDQccMQSMKjZTuyhWpzg3rvzHHljlJW2NF/RBL6QCv7snjNh9FpSTwNDWM4w+nlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3889
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 05/23] usb: typec: Find the ports
 by also matching against the device node
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

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 19 February 2020 07:57
> To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 05/23] usb: typec: Find the ports by
> also matching against the device node
> 
> Hi!
> 
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > commit 6a0bbcf96b2273f110a14d11a5952527c5921191 upstream.
> >
> > When the connections are defined in firmware, struct device_connection
> > will have the fwnode member pointing to the device node (struct
> > fwnode_handle) of the requested device, and the endpoint will not be
> > used at all in that case.
> 
> >  static void *typec_port_match(struct device_connection *con, int ep,
> > void *data)  {
> > -	return class_find_device(typec_class, NULL, con->endpoint[ep],
> > -				 __typec_port_match);
> ...
> > +	dev = class_find_device(typec_class, NULL, con->endpoint[ep],
> > +				typec_port_name_match);
> > +
> > +	return dev ? dev : ERR_PTR(-EPROBE_DEFER);
> >  }
> 
> So... this adds handling in fwnode != NULL (expected, okay with me), but it
> also changes behaviour in fwnode == NULL case: return value changed from
> NULL to ERR_PTR(-EPROBE_DEFER). Are all callers ready to handle the
> changed situation in -cip? Could we get some explanation why it is
> neccessary/good idea?

This is part of the Type-C Alternate Modes. This callback is used only by the
typec_altmode_register_notifier() that should be called by the upper driver
that uses the USB Type-C port in the Alternate Mode. In this way it can receive
notifications from it. 

In its initial form, this function explores the graph child nodes and finds the
adequate USB port controller device. But, this device might not be ready/probed
yet. Hence, the EPROBE_DEFER addition of this patch.

Strangely enough, no one is using this notification chain so far, not even in
mainstream. I guess Type-C is still in its infancy. 
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
