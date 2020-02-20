Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD07C11D04
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:40:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9317F208C4
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="eM7QQjXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9317F208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E18D87BA6;
	Thu, 20 Feb 2020 11:40:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hf-f18Xmaz0g; Thu, 20 Feb 2020 11:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D949D87B94;
	Thu, 20 Feb 2020 11:40:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD5E3C013E;
	Thu, 20 Feb 2020 11:40:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58C13C013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E95687BA6
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JyTjUwb37LAj for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 11:40:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410127.outbound.protection.outlook.com [40.107.141.127])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E941087B94
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6BAMUf50Dme/y5qoRIqKCVOMPRqTMBkusEDTAgBrJ1U4GVvESYSX/xL22alQW9Gbmo0TCQw58n3o2XPFsM8edvq4bMUVxMhXujhW3MPr76gg6g+pR5F2342BrbqEDa4A7gtAPsxVGT6HUs3EaPr1fgboh0RtJacWqQjM1Fv9Fg9IBY/6G6tT59isXlIPtYSCE2hbDRsej9CyprPdr4j54p9YITOq3vGQXyu6ihsId+FK6YylWsZi4BvigNdHAOduU9V8OYGZq4w8xEed4Ez4lvQ9NGb2uohEpZ18nOipF0ZJpijI/yS3WMMTU/J3h8fCTQlB7PeqOWqd+imTYgGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B975jEhy/60DYFVfTEI+TW7c+YG+kl/7mNr15GqIV00=;
 b=PmPpLQyDw0AF0l+ljEwfE2wFDvvzQKo2nmODd6Bh2ge4BQfA/FDqlkXQpUuQq6kl+bCXa6XGGeCW28poY+4F3WCdUNxzMyYe7Os2/O2c+bGGSoWEyFmdAkQ6vPPSO38ODT4BfXNU036XKZ3RvXqYcwnu04T7olmgptrZIRcvcBQ4XUk6f0i0DID61k95fQKZ7/iooS3upWxv7stfq1epu1OHWOfMgNCpIRGo0T6VvzpMo3d2ziiMdQzVl495dwXcWxiUO//vFgkWMRts3gZmRAHr7JeoXhts9Fwzussa/M58Lp1muKU313jKdbd9Pb+bky2Z3vM484QDi3mbBmuGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B975jEhy/60DYFVfTEI+TW7c+YG+kl/7mNr15GqIV00=;
 b=eM7QQjXBQjP4dkCgyZpGXO/8ESy7zcjvlulZxJDHndGPX/LHXH39IlR2njIz/ZLt7tvCHReMtyDa1ZuaQXrvrtCAUS9UxLll7ebdA2/QN6fnCiCwtHQlyGKVObPYEyQcf73q2tu6Lrvqmeeq+1AK1yQ9VlvIY+8Hn/Vs9liOriA=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB1538.jpnprd01.prod.outlook.com (52.134.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 11:40:24 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 11:40:24 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 17/23] usb: typec: add dependency
 for TYPEC_HD3SS3220
Thread-Index: AQHV5vzlp+SsO4bvhUydmENHq4xKKKgj9Keg
Date: Thu, 20 Feb 2020 11:40:23 +0000
Message-ID: <OSAPR01MB5028AA819CCF2EF35A68E18AAE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-18-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219081627.GE31996@amd>
In-Reply-To: <20200219081627.GE31996@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95685647-0936-49ae-5adc-08d7b5f9ac74
x-ms-traffictypediagnostic: OSAPR01MB1538:
x-microsoft-antispam-prvs: <OSAPR01MB1538CB63EE202122B06C735AAE130@OSAPR01MB1538.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(189003)(199004)(5660300002)(4326008)(86362001)(7696005)(81166006)(76116006)(66446008)(81156014)(66476007)(8676002)(6506007)(8936002)(26005)(66946007)(53546011)(66556008)(64756008)(186003)(52536014)(71200400001)(9686003)(498600001)(6916009)(2906002)(33656002)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB1538;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbkspdcescVhePZ6y5u96gnDi2VSG3JDN7vEgl7xsuM5JVy+JiSgi9M5UJFxQ2m/cuP2EP0goivRJ7WgQdqL4SIvbSJzs7aWrP+nIC5gObq/vcVJsNzxrMNURPPGOxmj4eusS8j5likmUxY9OZuhLyMlsqg86HA5dmkus7tlLSvv7N5r7dDDDkRXloRCwYC2uWLYXjZhhpU/yZzb8ZIZt7Tk9DvpAD9SJloRaYKVgA+ChaOWX9O5TQRV7AwmZg/3FYmbI5g98GFuTyYos0+qGZFM7n7R7VPmw6y8cDGUuGHb1uD1KLfsTlTGzSO0lISt56Hr1egXHfQ/CfbOLsIoTcVxtKQ49+ccq7O7mRcClETfYUBHWuywJWn2BidEBL5rgcwNqvwwLD0XkrmLx+d5kgDQRNe8w0m0NW2rigt0/p69hMaJ1Ak7rlGnBe5eHh5D
x-ms-exchange-antispam-messagedata: A2Pk2G6ohEELWvqih/fnA9EspJzrt9A2G+AOem3+fE/MB4lQXKeSZ8KQy7nHGfZOEb3SqgmXLqP4372ptq9DcLo54COsToZV7QJiMhZ3OnElRLK+dXs72mDQmPv7ZU8Vb88abs0hsB1av+mANtx/Ug==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95685647-0936-49ae-5adc-08d7b5f9ac74
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 11:40:23.9726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5iNjTr5aBFsnlLaWcf1Hj2mbS8u9mNFmPLV1aJqD+s9TbVfj5mXKh04qwNz7dJqmsFClPpCjBmFh3aKYb8v1BVLUIlBvvq8rIPLlxUc/Hu6MbbBm35qQHC7/TUVPhk5EiFbWHBvLnzi8MzUNCziyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1538
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 17/23] usb: typec: add dependency
 for TYPEC_HD3SS3220
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
> Sent: 19 February 2020 08:16
> To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 17/23] usb: typec: add dependency
> for TYPEC_HD3SS3220
> 
> On Tue 2020-02-18 14:05:14, Marian-Cristian Rotariu wrote:
> > From: Mao Wenan <maowenan@huawei.com>
> >
> > commit da4b5d18dd949abdda7c8ea76c9483b5edd49616 upstream.
> >
> > If CONFIG_TYPEC_HD3SS3220=y, CONFIG_USB_ROLE_SWITCH=m, below
> errors
> > can be found:
> > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
> > hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
> > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
> > hd3ss3220.c:(.text+0x154): undefined reference to
> `usb_role_switch_set_role'
> > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
> > hd3ss3220.c:(.text+0x294): undefined reference to
> `usb_role_switch_set_role'
> > hd3ss3220.c:(.text+0x2f4): undefined reference to
> `usb_role_switch_set_role'
> > hd3ss3220.c:(.text+0x348): undefined reference to
> `usb_role_switch_set_role'
> > hd3ss3220.c:(.text+0x390): undefined reference to
> `usb_role_switch_set_role'
> > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
> > hd3ss3220.c:(.text+0x5e8): undefined reference to
> `fwnode_usb_role_switch_get'
> > hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
> > make: *** [vmlinux] Error 1
> 
> I guess it is okay here, but for more serious bugs it would be nice to merge
> the buggy patch with a fix -- not to break bisect.

I kind of forgot about bisect. I was mostly focused on keeping the original patches
from upstream (in this case, it is more about the commit message as the fix is trivial).
I will send this patch in v2 also, since you mostly agreed with it. Please let me know
if otherwise. 

Cheers,
Marian
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
