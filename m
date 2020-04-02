Return-Path: <SRS0=EZCl=5S=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12655C2BA17
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 23:19:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2CF2073B
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 23:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2CF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 95D10868FF;
	Thu,  2 Apr 2020 23:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kGNtp4XVZ9H0; Thu,  2 Apr 2020 23:19:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A1A3868C6;
	Thu,  2 Apr 2020 23:19:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF9AC07FF;
	Thu,  2 Apr 2020 23:19:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC2C9C07FF;
 Thu,  2 Apr 2020 23:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D34AB87210;
 Thu,  2 Apr 2020 23:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UV1vBWeD1ELN; Thu,  2 Apr 2020 23:19:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D749C8720F;
 Thu,  2 Apr 2020 23:19:23 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 032NJLiQ008898;
 Fri, 3 Apr 2020 08:19:21 +0900
X-Iguazu-Qid: 34tr8v5egy8gK11xjd
X-Iguazu-QSIG: v=2; s=0; t=1585869561; q=34tr8v5egy8gK11xjd;
 m=okvRrAp6OlcNvC8m26tC9CpKEnHUhSOXDDW3MzlwTLc=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1510) id 032NJKZw011846;
 Fri, 3 Apr 2020 08:19:21 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 032NJK5m026795;
 Fri, 3 Apr 2020 08:19:20 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 032NJKKB014791;
 Fri, 3 Apr 2020 08:19:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxmaskl9JWtVIn1eFRPdMoFw5fV4l4lGISqwMNcTgQrPPWhCMv72LHgS6fCDOMpPVyZhCOaN22UaL3Nq5Fo+Snhlv+hbj+Ild0Z9RcxRgY02wRnKmu12u1iYIgrGS4pQX+KP9eUSfGMkW2NM5Bphsh+aFVUSaUCwzELWgjwWnl273BuFF3oDrMcntkbDv2JJKtZMalS7OjeAnqvGYU0UgQjOJS7L14w8ePHYspdAaCLsqfeHfGF1CTlYrnblOoXc2sATWBE2lQ2bEqp3lGTBJt98nx91Ye96Xz4GIcdIa3o9H+m/px5x48hcKdkCfv2II+du2AugYvYIAgPRL6eKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nne80Enr6KQx23UVe+g+u+RyeBv5zrXjBIR3iyh9/jU=;
 b=lrXrBozkd3/uFyi8GunEpZFlSZVi9JVzm5v/Lc5DTozKrlVURs5CfYXvIm1cVSFiWYAFPazEBhBSYrmCcgNBIWmr7KSRgglQhzhxmF4q7lxZ/+VAWQQ8LHI5SxnsIPl4thN6YPRECDipv+3PzJ5vxGo90s/CSKBuTfqfUNJtlfYDS+72X+S9KXrMbaeWiH1Bpgdjs1u+fqTJcmEHvtsfNp43ncyZMhdFlDo/VKnyeMANRBaUF9Hu57CKG7V6R87V8BmbAjK+DmCe9axuGRDz6CZ0Co6ZfMdVk5XGkitmMHfZjL1vLOqZJfFrSvIvsdkuCnKtUrRMeVQLmTvpcE5uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <kento.yoshida.wz@renesas.com>, <cip-dev@lists.cip-project.org>
Thread-Topic: Python 3.x vs 2.7
Thread-Index: AdYI0Y7wF02Ds+P+SQqCBlZlaiG5IAAclJdA
Date: Thu, 2 Apr 2020 23:19:18 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB36671C415EDE77F710011BF692C60@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6fb01b8-7573-4a7c-5c28-08d7d75c44ea
x-ms-traffictypediagnostic: OSAPR01MB4257:
x-microsoft-antispam-prvs: <OSAPR01MB42575EFE2A3BECB4DDA7A4E292C60@OSAPR01MB4257.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB3667.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10001)(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(186003)(9686003)(71200400001)(26005)(33656002)(478600001)(8936002)(8676002)(966005)(81166006)(81156014)(64756008)(86362001)(66946007)(4326008)(316002)(6506007)(55016002)(7696005)(110136005)(53546011)(66476007)(66446008)(52536014)(66556008)(2906002)(5660300002)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZttLJY0B6JvCYE8FuH/PXUn83ysTzUMXoCFLijUjTJxQlpYumRUbqObRXkm70nI5is1KYX1dqL1jRJjHQmhTJn7MJHLwc3GS4qZoMKgIQipZIhNdx28Cttk4yRZSLJqRAKrPN1cuZhL8c7Imv8kHZmwnWWu2VljapboaYczW6XdW4S9LSWBwFalXOBvG/veVfm+YjbdXxJckS52r2pMnwcLqD/hm1FMNjKnlbI0tF51KzncF+qSxekD/463eq/O2u33XbgCqQuvA2SJghh2kxt/Gc5EAnUVxN8hjFpYtJqKLHpSO0gR1O2W/6Uz+qMowv0Gay4zbPOe6Qg/ECXkpmLDZw1/ii6dqiUv7SmKwrfUgVF93kHI9IMZO6nj4BMRAn5/tv9trEetRoqhGa5NE30fGGe28AI176lmh/XbtbbctujnnXslbpxgoWVz1bhD9nl6ADh9hj53X2TfezBjRf7P4V11bQ3gkSbpcVFicKziSXYC9UIW7J0C3r6WtEmfpUA/b55Yav9S3iOuXWb2mbsVhj8dmCNOPAKLn20Cm1HFl3tpz9Gz4OITBe+AGMekygR5XvPvD3DvoGhh20PIkuUIxCa76vlnciZ0p4/OxJda31Thl4tmwKim6BOoY8rUS
x-ms-exchange-antispam-messagedata: BNYlMhvuidgFWYBYOvgHW/yE043WOcOkkHugflur6dSA623nTevJiD8f0huQc/hb7sZb/1+2nboDRCXFzZX6iZdUDX+e4zy6fBenx9dFpVrysj6/Z2T/2yg8/bBeTJkbGj/lUOA/uDWZN4aYhVv0PQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fb01b8-7573-4a7c-5c28-08d7d75c44ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 23:19:18.8667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AoZfOeHJJXWCSJwO0wB4V345u9Q/iEzqRqkIKIIQvl9s0MI07pw9onrEAW5zwRhdJm2ILt429hxUQWShaKEykIvyXegnxvusL9khUDfz5/jbPEkfANOnfMtmrKIcXtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4257
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: cip-security@lists.cip-project.org
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

Hi, 

> As you may know, some of other packages we selected are dependent on python 3.x, so we may have the below options:
>
> 1. Maintain python 2.7 as well
> 2. Backport the upper duplicity which migrated python 3.x in bullseye archive
> 3. Others
>
> What do you think is best?
> I hope we can decide the policy within the CIP core group because there shall be similar problems for the others of python.

In my opinion, it is difficult to support Python2 for a super long term. And I think it is difficult to support each library using Python2.
Therefore, I think Option2 is good. And if necessary, we can use backposts.debian.org.
However, packages with large dependencies can be difficult to backports. For example Kbuckup is difficult, I think.

Best regards,
  Nobuhiro

From: cip-dev [mailto:cip-dev-bounces@lists.cip-project.org] On Behalf Of Kento Yoshida
Sent: Thursday, April 2, 2020 6:59 PM
To: cip-dev@lists.cip-project.org
Cc: cip-security@lists.cip-project.org
Subject: [cip-dev] Python 3.x vs 2.7

Hi CIP core group,

The security package proposal is suspended now, but I'd like to discuss about the python version which is suitable to maintain.

We selected "duplicity" for the requirement of system backup according to the functionality, license, the number of dependencies and so on.
However, the duplicity in the Debian buster [1] dependent on python 2.7, which is not maintained anymore [2].

[1] https://packages.debian.org/source/buster/duplicity
[2] https://pythonclock.org/

As you may know, some of other packages we selected are dependent on python 3.x, so we may have the below options:

1. Maintain python 2.7 as well
2. Backport the upper duplicity which migrated python 3.x in bullseye archive
3. Others

What do you think is best?
I hope we can decide the policy within the CIP core group because there shall be similar problems for the others of python.

FYI, unfortunately we couldn't find the alternative package for system backup. The duplicity is the best package for us from the license and num of dependencies point of view.
See the following.

<Rsync>
Encryption: No
Schedule backup: No
Incremental backup: Yes
License: GPL v3
Dependencies count (aprox): 24
Reference: https://rsync.samba.org/features.html

<duplicity>
Encryption: Yes
Schedule backup: No
Incremental backup: Yes
License: GPL v2
Dependencies count (aprox): 80
Reference: http://duplicity.nongnu.org/features.ht

<Backuppc>
Encryption: No
Schedule backup: Yes
Incremental backup: Yes
License: GPL-2+, X11
Dependencies count (aprox): 132
Reference: http://backuppc.sourceforge.net/info.html

<Amanda>
Encryption: Yes
Schedule backup: Yes
Incremental backup: Yes
License: GPL-2+
Dependencies count (aprox): 289
Reference: https://www.zmanda.com/amanda-community-edition.html

<Kbackup>
Encryption: Yes
Schedule backup: Yes
Incremental backup: Yes
License: GPL-2, LGPL-2.1, GFDL-1.2+, KDEeV
Dependencies count (aprox): 414
Reference: https://kde.org/applications/utilities/org.kde.kbackup

Best regards,
Kent
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
