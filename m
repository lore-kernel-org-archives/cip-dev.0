Return-Path: <SRS0=DIdx=45=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E78C10DCE
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 07:12:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5E3206B1
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 07:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5E3206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66A2989296;
	Thu, 12 Mar 2020 07:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YpHZ-XovNfNh; Thu, 12 Mar 2020 07:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 605C28929E;
	Thu, 12 Mar 2020 07:12:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E1F1C0177;
	Thu, 12 Mar 2020 07:12:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8FEC0177;
 Thu, 12 Mar 2020 07:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 573ED863A1;
 Thu, 12 Mar 2020 07:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4LHnVkow5ilT; Thu, 12 Mar 2020 07:12:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1116.securemx.jp [210.130.202.158])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DCC9586200;
 Thu, 12 Mar 2020 07:12:52 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 02C7Coxu010780;
 Thu, 12 Mar 2020 16:12:50 +0900
X-Iguazu-Qid: 2wHHidEfC22TBm7ndY
X-Iguazu-QSIG: v=2; s=0; t=1583997170; q=2wHHidEfC22TBm7ndY;
 m=d9IjJkDn+2A6H+aEc+14pE1ijtfg3H4BrtRed53ZNjI=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1113) id 02C7Cna6009642;
 Thu, 12 Mar 2020 16:12:50 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 02C7CnLS001165;
 Thu, 12 Mar 2020 16:12:49 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 02C7Cnbv005723;
 Thu, 12 Mar 2020 16:12:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg1OShd6jzejLhT5WOBoXFlHPE4CGAchNKi9SYh99XNyIsUuCfLo1KiL+YrcvE767xtGbM2nhvma/BSrg0zU2ET1OC0m+hn6S0SXSeysshFlPiAyDpoiTOByKSF2SfZGhPNljdaofdrI6xFV5Yuva/xUqkBSjk4Md4LJO2835kBwrLTj2CfbR74s1RpHotkBZArCl/JKViEXrTi+R862hMutnnzT3ZbWgkehxFkuCdVpxnqaF7qSzD0l8gXA1xTHRoVGc75hZdIgpOYtDLDiSOnGJXgJEL5l7w7/zPGxFWn1E8HRDkLR/aNVA+2RLuI8vm0f0YkdHB6pugmNm5sGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA9WFykdOHvyDTIr/5SA0v7XGfmAHPBJGyHTEanh8uw=;
 b=Rt2GeLbnGV5kJfBbitv8nv463m+j0ZCKe9ryu9cUz+ufOMryVTxch4PnBNCmTHv7ZCPUgykDg2SFVHqt9wBYFDIp/FzsXKw1XljHalvxdJWzcg3+C1jjLh+GJdU8T5HiE5U82wWhR0MckSDlAbp/ICKYOwkkZK7n78psNHChUmcNz0huoQvFuY+P0deWceMa4O0R2xWcqbdv12/5le2P0RBGJB0RV48kyU0YKHM2sFyw8okrH4GKSBkcWP3+T8nE9nG9YrskWdI+9X8A90OGGIMVuLbAz54AhDxpFHfyx3EDR/Xy9oMqHk3Y2POntEUVVGjluYyRhuQkEIUBJX7QTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <Venkata.Pyla@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>
Thread-Topic: Sample image including security packages
Thread-Index: AdXod0daEQ5yvAxmSqGjegxSRddNWwH/ZrKgAAl2o6AAi1X9QAE8vGfQABlxYhAABxXXUA==
Date: Thu, 12 Mar 2020 07:12:25 +0000
X-TSB-HOP: ON
Message-ID: <TYXPR01MB1808A5B2AD3CA8CA6FDC55C7E1FD0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <TYXPR01MB1808AD5423CA82AE50EC4D90E1120@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <7ba7bb426c814ffcaefeccd646b0e302@TOSHIBA-TSIP.COM>
 <5dda4cb9fd40483d92ee99145522cca0@toshiba-tsip.com>
 <TYXPR01MB1808B8B8709CBBC91634721EE1FC0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <d137306fa9f04073b09ee6f814fe4307@toshiba-tsip.com>
In-Reply-To: <d137306fa9f04073b09ee6f814fe4307@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kazuhiro3.hayashi@toshiba.co.jp; 
x-originating-ip: [124.211.28.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e57cb829-e55d-4401-f951-08d7c654b786
x-ms-traffictypediagnostic: TYXPR01MB1534:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <TYXPR01MB1534AA5FC6EECB801A7B334BE1FD0@TYXPR01MB1534.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(8936002)(76116006)(66946007)(110136005)(26005)(66556008)(66446008)(66574012)(52536014)(316002)(478600001)(2906002)(66476007)(86362001)(966005)(53546011)(33656002)(6506007)(55236004)(7696005)(71200400001)(8676002)(30864003)(81156014)(15650500001)(55016002)(81166006)(9686003)(4326008)(64756008)(54906003)(5660300002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:TYXPR01MB1534;
 H:TYXPR01MB1808.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCZHRh30YNmTeGNeRbxTl7Sae+5QTHtzBb3Oevej3aWUgyTeZsY62neApTKG5lnFB5sj2RHsctJPpj5VFbSC5OnZpPGA+LayfSjHDBK9kyDhZ38vmP90Ad4XfWgqsvh88dmuNiMSs7d/mRjEZCBKE0QGev/Bm3yiKgqGbvFHmYCFWL6F26hH9FYzRe9V0Unlfhxi4V4BlueapYWvsPNZFDQoZzAmgw8QIVj0Qk6hXqKOQLFKvHHFHfoGYCED8lLU2HijV99Cjhi1OlnShDCT1pt9pLFHmDbKP9gyFkzzhzunFmtcj2reg1PZCtYsjAlVURn+UbJbjS6Mzqkm00Eau23UgzkRvU6OHxXmxHYPIhK+s6kHZDOXwYkIbTuTEGw83iFL8Cboto8QZfwiALtB4OsE/EDOlI3hHUYy2PtbtdaNeCMUHTL3f6Xnvse9SQo8YgizzbR3GsK0FPojYBBata+kJXjfjT5egOJMAy/2u694sF7Jowceg3hS/1rrsEHqWqmSwrYK7GZ+T3QxSxjTcQ==
x-ms-exchange-antispam-messagedata: zUdn0KYpOGwyqe3+bE60VykU69Bnpq+CyTPaKcL8XfevIkpbVx6xf4ba05PJTlRkjSM6eFcB26b/MufgKrYvRthNjXkafdHiqVll8pG6kM37T+yHaKK9MkSsSowejj70lPQFt7y0UnNyBy85FLWbwg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e57cb829-e55d-4401-f951-08d7c654b786
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 07:12:25.4173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qGJXJt4QWNNjeRsdUt2CyW63n1iH2CMD8wLY1zJ9wiwY3r2P1YpephwzgRijq0kO2kDPKEHMZQoIRAV3BFqnji5ibdt5JU76pn9C3jy67A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1534
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Sample image including security packages
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hello Venkata,

Thank you for checking the result.
I confirmed that this variable should not be overwritten in the image recipe.
Could you send MR including this update to https://gitlab.com/zuka0828/isar-cip-core ?

Best regards,
Kazu

> -----Original Message-----
> From: Venkata Seshagiri Pyla [mailto:Venkata.Pyla@toshiba-tsip.com]
> Sent: Thursday, March 12, 2020 12:56 PM
> To: hayashi kazuhiro(林 和宏 ○ＳＷＣ□ＯＳＴ) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(ＴＳＩＰ DS Company)
> <dinesh.kumar@toshiba-tsip.com>
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: RE: Sample image including security packages
> 
> Hello Kazu-san,
> 
> I observed 'init' system is not included in the image when append operator is not used and so booting the image is not
> successful.
> 
> Here is the output of `bitbake -e cip-core-image-security | grep 'IMAGE_PREINSTALL'` when append is not used
> -------------------------------------------------------------------------------------------------
> # $IMAGE_PREINSTALL [2 operations]
> IMAGE_PREINSTALL=" 	openssl libssl1.1 	fail2ban 	openssh-server openssh-sftp-server openssh-client
> 	syslog-ng-core syslog-ng-mod-journal 	aide aide-common 	libnftables0 nftables 	libpam-pkcs11
> 	chrony 	tpm2-tools 	tpm2-abrmd 	libtss2-esys0 libtss2-udev 	libpam-cracklib 	acl
> 	libauparse0 audispd-plugins auditd 	uuid-runtime 	vim "
> #     "${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> #   " ${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> -------------------------------------------------------------------------------------------------
> 
> Output when append is used
> -------------------------------------------------------------------------------------------------
> # $IMAGE_PREINSTALL [2 operations]
> IMAGE_PREINSTALL=" init  	openssl libssl1.1 	fail2ban 	openssh-server openssh-sftp-server
> openssh-client 	syslog-ng-core syslog-ng-mod-journal 	aide aide-common 	libnftables0 nftables
> 	libpam-pkcs11 	chrony 	tpm2-tools 	tpm2-abrmd 	libtss2-esys0 libtss2-udev 	libpam-cracklib
> 	acl 	libauparse0 audispd-plugins auditd 	uuid-runtime 	vim "
> #     "${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> #   " ${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> -------------------------------------------------------------------------------------------------
> 
> 
> Thanks,
> Venkata.
> -----Original Message-----
> From: kazuhiro3.hayashi@toshiba.co.jp [mailto:kazuhiro3.hayashi@toshiba.co.jp]
> Sent: 12 March 2020 05:16
> To: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>; Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: RE: Sample image including security packages
> 
> Hello Venkata,
> 
> Thank you for the information.
> 
> Regarding the usage of `IMAGE_PREINSTALL`, I'm not sure if we always need `+` in the image recipe.
> Example: https://github.com/ilbers/isar/blob/master/doc/user_manual.md#create-a-custom-image-recipe
> Could you dump the value of `IMAGE_PREINSTALL` with/without `+` by `bitbake -e` command?
> 
> Best regards,
> Kazu
> 
> > -----Original Message-----
> > From: Venkata Seshagiri Pyla [mailto:Venkata.Pyla@toshiba-tsip.com]
> > Sent: Thursday, March 5, 2020 6:06 PM
> > To: hayashi kazuhiro(林 和宏 ○ＳＷＣ□ＯＳＴ) <kazuhiro3.hayashi@toshiba.co.jp>;
> > dinesh kumar(ＴＳＩＰ DS Company) <dinesh.kumar@toshiba-tsip.com>
> > Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> > Subject: RE: Sample image including security packages
> >
> > Hi Kazu-san and Dinesh,
> >
> > I have created the image with all proposed security packages included.
> > applied the below change, and booted the image in QEMU correctly.
> > -----------------
> > diff --git a/recipes-core/images/cip-core-image-security.bb
> > b/recipes-core/images/cip-core-image-security.bb
> > index 70571f8..b883414 100644
> > --- a/recipes-core/images/cip-core-image-security.bb
> > +++ b/recipes-core/images/cip-core-image-security.bb
> > @@ -18,7 +18,7 @@ IMAGE_INSTALL += "customizations"
> >
> >  # Debian packages that provide security features  # TODO: Add sudo or
> > sudo-ldap which conflict each other -IMAGE_PREINSTALL = " \
> > +IMAGE_PREINSTALL += " \
> >  	openssl libssl1.1 \
> >  	fail2ban \
> >  	openssh-server openssh-sftp-server openssh-client \
> > --
> > -----------------
> >
> > Thanks
> > venkata
> > -----Original Message-----
> > From: Venkata Seshagiri Pyla
> > Sent: 02 March 2020 19:38
> > To: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>;
> > kazuhiro3.hayashi@toshiba.co.jp
> > Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> > Subject: RE: Sample image including security packages
> >
> > Hi Kazu-san and Dinesh,
> >
> > >We found most of the packages are not included in the isar image,
> > >could you please confirm whether all the proposed packages
> > are included in the given source?
> > >If it is included, could you please let us know how to install them in the image?
> > I think we have to create the image for the target "cip-core-image-security" instead of "cip-core-image".
> >
> > All the security packages are configured to install are present in this file "cip-core-image-security.bb".
> >
> > I will generate the image for target "cip-core-image-security" and recheck all the security functionality.
> >
> > Thanks,
> > Venkata.
> >
> > -----Original Message-----
> > From: Cip-security [mailto:cip-security-bounces@lists.cip-project.org]
> > On Behalf Of Dinesh Kumar
> > Sent: 02 March 2020 15:29
> > To: kazuhiro3.hayashi@toshiba.co.jp
> > Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> > Subject: Re: [Cip-security] Sample image including security packages
> >
> > Dear Kazu-san,
> >
> > Thanks for sharing the isar-cip-core repository details with us.
> >
> > We followed below steps to first confirm whether all the proposed
> > binaries are included when we create CIP isar based image.
> > 1. Create CIP isar based image from
> > "https://gitlab.com/zuka0828/isar-cip-core/-/tree/master"  for
> > QEMU_x86-64 platform 2. Booted the image in QEMU virtual machine 3. For each security package we compared the binaries
> listed on Debian page e.g. for acl package at (https://packages.debian.org/buster/amd64/acl/filelist)
> >      According to the Debian page there are three binaries which
> > should be present in the image "/bin/chacl", "/bin/getfacl", "/bin/setfacl".
> >      Then we check in the CIP running image at /bin whether all three packages are included or not.
> > 4. Based on this kind of investigation we have prepare the attached
> > list of missing binary packages in current CIP isar image.
> >
> > We found most of the packages are not included in the isar image,
> > could you please confirm whether all the proposed packages are included in the given source?
> > If it is included, could you please let us know how to install them in the image?
> >
> > Once all the security packages are included in the CIP isar image, we
> > will proceed to next step of verifying applicable IEC 62443-4-2 security requirements.
> >
> > Thanks & Regards,
> > Dinesh Kumar
> >
> >
> > -----Original Message-----
> > From: Cip-security <cip-security-bounces@lists.cip-project.org> On
> > Behalf Of kazuhiro3.hayashi@toshiba.co.jp
> > Sent: 21 February 2020 10:58
> > To: cip-security@lists.cip-project.org
> > Cc: cip-dev@lists.cip-project.org
> > Subject: [Cip-security] Sample image including security packages
> >
> > Hello CIP Security WG,
> >
> > I've created a sample setting to customize CIP Core generic profile.
> > https://gitlab.com/zuka0828/isar-cip-core/-/tree/master
> > (Now in my personal account)
> >
> > Introduction:
> > https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/SECURITY.md
> >
> > Please ask in cip-dev if you need more development information :)
> >
> > Note: `sudo` and `sudo-ldap` conflict each other, but both were proposed.
> > We need to select one from them.
> > I temporally removed the both from `IMAGE_PREINSTALL`.
> >
> > Best regards,
> > Kazu
> >
> > _______________________________________________
> > Cip-security mailing list
> > Cip-security@lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-security
> > The information contained in this e-mail message and in any
> > attachments/annexure/appendices is confidential to the recipient and may contain privileged information.
> > If you are not the intended recipient, please notify the sender and
> > delete the message along with any attachments/annexure/appendices. You
> > should not disclose, copy or otherwise use the information contained
> > in the message or any annexure. Any views expressed in this e-mail are those of the individual sender except where the
> sender specifically states them to be the views of Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
> >
> > Although this transmission and any attachments are believed to be free
> > of any virus or other defect that might affect any computer system
> > into which it is received and opened, it is the responsibility of the
> > recipient to ensure that it is virus free and no responsibility is accepted by Toshiba Embedded Software India Pvt.
> Ltd, for any loss or damage arising in any way from its use.
> > The information contained in this e-mail message and in any
> > attachments/annexure/appendices is confidential to the recipient and
> > may contain privileged information.
> > If you are not the intended recipient, please notify the sender and
> > delete the message along with any attachments/annexure/appendices. You
> > should not disclose, copy or otherwise use the information contained
> > in the message or any annexure. Any views expressed in this e-mail are
> > those of the individual sender except where the sender specifically
> > states them to be the views of Toshiba Software India Pvt. Ltd.
> > (TSIP),Bangalore.
> >
> > Although this transmission and any attachments are believed to be free
> > of any virus or other defect that might affect any computer system
> > into which it is received and opened, it is the responsibility of the
> > recipient to ensure that it is virus free and no responsibility is
> > accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
> > damage arising in any way from its use.
> 
> The information contained in this e-mail message and in any
> attachments/annexure/appendices is confidential to the
> recipient and may contain privileged information.
> If you are not the intended recipient, please notify the
> sender and delete the message along with any
> attachments/annexure/appendices. You should not disclose,
> copy or otherwise use the information contained in the
> message or any annexure. Any views expressed in this e-mail
> are those of the individual sender except where the sender
> specifically states them to be the views of
> Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
> 
> Although this transmission and any attachments are believed to be
> free of any virus or other defect that might affect any computer
> system into which it is received and opened, it is the responsibility
> of the recipient to ensure that it is virus free and no responsibility
> is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
> damage arising in any way from its use.

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
