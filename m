Return-Path: <SRS0=hSFH=5T=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C1C43331
	for <cip-dev@archiver.kernel.org>; Fri,  3 Apr 2020 01:50:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A892077D
	for <cip-dev@archiver.kernel.org>; Fri,  3 Apr 2020 01:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="kM20PvD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A892077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4415687EF6;
	Fri,  3 Apr 2020 01:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wlqpSXwmcvL2; Fri,  3 Apr 2020 01:50:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9E51387EE3;
	Fri,  3 Apr 2020 01:50:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D1ABC07FF;
	Fri,  3 Apr 2020 01:50:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 923E3C07FF;
 Fri,  3 Apr 2020 01:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8886C87EF6;
 Fri,  3 Apr 2020 01:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHGmx4KRMr-8; Fri,  3 Apr 2020 01:50:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410102.outbound.protection.outlook.com [40.107.141.102])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA27887EE3;
 Fri,  3 Apr 2020 01:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUgqolCbzNBK+VK1kjhgduxtAM47xY4NdXmwV/1GN2iehgKy++GISUEt8kNBgZUnMzJPIrgAFXeUIRV7rJPbHM/uxKtbvs5oBizZ2MYOYqy3CGeAzSl3Cxs5FnPRrvf0fAGhgCNKcjZGooZzQtWatQhKZY6OczdYvhmHRMGlV7quA1eqPxf2ARzjxCgJs3aO2/X6eBjtqwR7kH98tQja0dRP1NXWj9UMrNU1Y+6OcHy+q+CdOa4sUb/rL1SWxNQ0zd8vlHeqeidawIfYuqJGEFl8vIEkwd60m9iVr7mvYLHROfwSafqUqdzGkLCqT1KP+0BJDVNqHV8d0N1Nu9am/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m+FVEaxVyqnipE69snJBYQkn9GDkMwsitZQdUcH3Ts=;
 b=I7xoawrixCZnHU6zvvmYfDuA9KPmmSXm2wRRfD2+N61R339AJExDIoXy0B9+MpRLBbs4IOEqmuJL+3F44SzXe5VXYszhFjIxyThqQpej/NldPPRj0EGu8IFPy7kQCIcQHdzm4BjXI1iyUQrXV5kibEyNyYabvE5t/boegF2EP3Y5aK8sQlNe+f8kgwacol5yJqTR+6HMrehssXfoBtJBx/IlQ9QMZ8f0WIu+tXjzcD8dIeJ0xEstRaTSjZtqnwgyWA8kEk3cfCbsI1mdN00K2cjZmACYXyLbz1sehwScXmLFNib73fG76eWVQc1wXy0ausDUFumrHBCyrZVMcR5wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m+FVEaxVyqnipE69snJBYQkn9GDkMwsitZQdUcH3Ts=;
 b=kM20PvD1gO8m+QJv2SSWOoXEZH5VBLsZLj7+CcbuCbl1g7VPSVwdzWq0cN5xQC7GNwuYdycGH1GDq6Bsc90MhOf3c71XynzYyYZ1GMDXWQ0s82miQQ/f0ljcaU/LpqZUVRnrdFXeMDUDUbIr+LtmEKy0PSceHCoAkpR61H+7x8Q=
Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com (20.177.101.84) by
 TYAPR01MB4334.jpnprd01.prod.outlook.com (20.179.173.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 01:50:44 +0000
Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::e52d:16f1:7b5:a1a0]) by TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::e52d:16f1:7b5:a1a0%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 01:50:44 +0000
From: Kento Yoshida <kento.yoshida.wz@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Thread-Topic: Python 3.x vs 2.7
Thread-Index: AdYI0Y7wF02Ds+P+SQqCBlZlaiG5IAAclJdAAAVmudA=
Date: Fri, 3 Apr 2020 01:50:43 +0000
Message-ID: <TYAPR01MB23993BE82FAB5F84728C6C37DFC70@TYAPR01MB2399.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <OSAPR01MB36671C415EDE77F710011BF692C60@OSAPR01MB3667.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB36671C415EDE77F710011BF692C60@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kento.yoshida.wz@renesas.com; 
x-originating-ip: [2001:268:c0a0:349f:81ae:22bf:22f6:6de0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9debbe18-3442-4fc6-f775-08d7d7716c24
x-ms-traffictypediagnostic: TYAPR01MB4334:
x-microsoft-antispam-prvs: <TYAPR01MB43345A49AC5658BC38E52A5BDFC70@TYAPR01MB4334.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB2399.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10001)(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(66446008)(81156014)(66556008)(64756008)(478600001)(186003)(66946007)(7696005)(8936002)(55016002)(76116006)(9686003)(966005)(52536014)(33656002)(6506007)(66476007)(2906002)(5660300002)(81166006)(8676002)(86362001)(71200400001)(316002)(110136005)(4326008);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLwje2RWicNyxV5byGK6tFWqjLeVyQ3iMs+UN5k9fIgDIIA2b+SCA5/B4dX2PS715U3BA9X1xMggbWVSJ2tw9BtU8ZZR26sk8b1ECCy+ZVwIp+yvBLxlNWGOn/gSp8dfa7h1wtR/+qHzSqpV9A9lXY876MUHw4Vw3JtQJviJe1MtI1DdRyLVvShXyEruUi9ViwNGjjuHu1m139wTp5Bx7o4YExwzNF7QnDJ7c8RjeTaZPDPrGnySs832VAuZGsd+L2iWXeK6or0JvGSwz9I6Ml1XE0kqp0O9IFIRkrGTaSs3LQCM484fbkIugM3zdwnHJaliayn3yOR0s6fbG2Ho8QVPKaZu2xq0ckQk1lD4zsnajb1kJOK6P7RlXnKDjYcUnwOLN9n6xkGj3o/TF+/x9WH1dR8iQDu5Sj1zFobxd1/OumvDahNxwQ3NiWckuZtJQQeYKop83Hiz2IaWLgOyHpDbQQPQYtXe34YZkxy7fb3J9qus5SSuFRJY/k09vp7Srzj6Dd+V+oqS05psDbd050Wa7LQrOZT+qmIEPWpDiXcSucBJkLw0wWLeu9yObJJplKyERg5QplmFSNrFWqFAlEiEXliOyaEiLA3uZ5+cDzbj1RfiXLaQfJhoEJnmzoPI
x-ms-exchange-antispam-messagedata: dl+80xYeVpvJuA4d5WVrivNlTyfbogIeL+bbbK0mey95Z6HvQ7QxebhfcAi0RlA6354mzJv0MdX/ThyzR+cfsCexip3JzRO1fBk9GoRkRqzxFw2JdVRNiK6jMKK4xPMt6gcUtDjJYHG1pBjTt7SBWvgVlQNL/Ax/MewQ+5nWvBWwA14cEmOI9nmppSA9paiuR5wawIVm+kBP7SaAmIiZmA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9debbe18-3442-4fc6-f775-08d7d7716c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 01:50:44.0373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JnYOHbP/USjJxQnOHfLigSqOIJzspeo2TDCOr/cj2d99P2ngcg3tMtYqA8zhz4Wi8CZMZM0RH2g3G2jitiuI7we+L/p4/KmCyhXi+Co8DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4334
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: Re: [cip-dev] Python 3.x vs 2.7
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

Thank you for your feedback, Iwamatsu-san.

>-----Original Message-----
>From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
>Sent: Friday, April 3, 2020 8:19 AM
>To: Kento Yoshida <kento.yoshida.wz@renesas.com>; cip-dev@lists.cip-project.org
>Cc: cip-security@lists.cip-project.org
>Subject: RE: Python 3.x vs 2.7
>
>Hi,
>
>> As you may know, some of other packages we selected are dependent on python
>3.x, so we may have the below options:
>>
>> 1. Maintain python 2.7 as well
>> 2. Backport the upper duplicity which migrated python 3.x in bullseye
>> archive 3. Others
>>
>> What do you think is best?
>> I hope we can decide the policy within the CIP core group because there shall be
>similar problems for the others of python.
>
>In my opinion, it is difficult to support Python2 for a super long term. And I think
>it is difficult to support each library using Python2.
>Therefore, I think Option2 is good. And if necessary, we can use
>backposts.debian.org.

Actually, option-2 is dominant in the security team as well.

>However, packages with large dependencies can be difficult to backports. For
>example Kbuckup is difficult, I think.
>

Agree. We are not going to select the package which is GPL-3 or has a lot of dependent package, so the duplicity is only one candidate for us substantially.

>Best regards,
>  Nobuhiro
>
>From: cip-dev [mailto:cip-dev-bounces@lists.cip-project.org] On Behalf Of Kento
>Yoshida
>Sent: Thursday, April 2, 2020 6:59 PM
>To: cip-dev@lists.cip-project.org
>Cc: cip-security@lists.cip-project.org
>Subject: [cip-dev] Python 3.x vs 2.7
>
>Hi CIP core group,
>
>The security package proposal is suspended now, but I'd like to discuss about the
>python version which is suitable to maintain.
>
>We selected "duplicity" for the requirement of system backup according to the
>functionality, license, the number of dependencies and so on.
>However, the duplicity in the Debian buster [1] dependent on python 2.7, which is
>not maintained anymore [2].
>
>[1] https://packages.debian.org/source/buster/duplicity
>[2] https://pythonclock.org/
>
>As you may know, some of other packages we selected are dependent on python
>3.x, so we may have the below options:
>
>1. Maintain python 2.7 as well
>2. Backport the upper duplicity which migrated python 3.x in bullseye archive 3.
>Others
>
>What do you think is best?
>I hope we can decide the policy within the CIP core group because there shall be
>similar problems for the others of python.
>
>FYI, unfortunately we couldn't find the alternative package for system backup. The
>duplicity is the best package for us from the license and num of dependencies
>point of view.
>See the following.
>
><Rsync>
>Encryption: No
>Schedule backup: No
>Incremental backup: Yes
>License: GPL v3
>Dependencies count (aprox): 24
>Reference: https://rsync.samba.org/features.html
>
><duplicity>
>Encryption: Yes
>Schedule backup: No
>Incremental backup: Yes
>License: GPL v2
>Dependencies count (aprox): 80
>Reference: http://duplicity.nongnu.org/features.ht
>
><Backuppc>
>Encryption: No
>Schedule backup: Yes
>Incremental backup: Yes
>License: GPL-2+, X11
>Dependencies count (aprox): 132
>Reference: http://backuppc.sourceforge.net/info.html
>
><Amanda>
>Encryption: Yes
>Schedule backup: Yes
>Incremental backup: Yes
>License: GPL-2+
>Dependencies count (aprox): 289
>Reference: https://www.zmanda.com/amanda-community-edition.html
>
><Kbackup>
>Encryption: Yes
>Schedule backup: Yes
>Incremental backup: Yes
>License: GPL-2, LGPL-2.1, GFDL-1.2+, KDEeV Dependencies count (aprox): 414
>Reference: https://kde.org/applications/utilities/org.kde.kbackup
>
>Best regards,
>Kent
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
