Return-Path: <SRS0=DIdx=45=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA787C10DCE
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 07:33:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC77820578
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 07:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC77820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 987F985B73;
	Thu, 12 Mar 2020 07:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAIsrztvJOCa; Thu, 12 Mar 2020 07:33:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E6E285B5B;
	Thu, 12 Mar 2020 07:33:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56CBFC0177;
	Thu, 12 Mar 2020 07:33:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD362C0177;
 Thu, 12 Mar 2020 07:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B656885B73;
 Thu, 12 Mar 2020 07:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id POze5LOgmrAo; Thu, 12 Mar 2020 07:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2FDDC85B5B;
 Thu, 12 Mar 2020 07:33:50 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 02C7Xm0O020990;
 Thu, 12 Mar 2020 16:33:48 +0900
X-Iguazu-Qid: 34trpDa8JzerXN5FQI
X-Iguazu-QSIG: v=2; s=0; t=1583998428; q=34trpDa8JzerXN5FQI;
 m=f31z1+D2/xpJUBg34P/Uf+79wFJi5gFhYqKOmHdKOtM=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1513) id 02C7XlqB013151;
 Thu, 12 Mar 2020 16:33:48 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 02C7Xl3t013567;
 Thu, 12 Mar 2020 16:33:47 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 02C7XlRc026350;
 Thu, 12 Mar 2020 16:33:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/M/VIEbMIJ/upRje886vcB3Y996/kopuy4xiDoDk6erPnOOVcxSUQFZBGO4PcRbxsokJjqpxEw4mUCVj74c4vJcpm5MGc2DgeLOi3fQj9x8zNlHJJUBJ+3RN8SbOlC/5EAcCbKM/Du9Pk9JMq8vD1FEcIZDa36flsxVtvX7JWIwyYEdSmCLrlLfcr4xqEupG4nMknx4eOzlt2XwP4V3L7nJm2yUM04V4jLcyFRO9/3kLa/+eOUfcw2qQpr8RPCMfxn0SD8suihmGfZPCE28EYtSswZSOR6TLhxIwYoOrj/yvDbLvnm+MAZYAAOO10hxQPcZZICG6AU8nUBVaIv4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8NExFASMrdYWdlNKvJn6uFDhSNcP61yQZmzdmvYPTM=;
 b=hD1bEbt3y6bJ7WttZ54jsRERyr0dASqzBLhfHKiyra7q+igKx9H91nmK/1VCKKf3yCcHxDdTJtpYkNYZ9abUlx6ohdILO2FsKR+3iS2Rn3ivB4ufDuaMnXWAkLxjoOWW548z0RyIctvm0LAU9BM0DlCgPUdqPPScQBq/TEvhCFlElJYi9WRqWppZ1dgcWRfQBQnStwuEyZ5b5CNC6ZxEcRFWA1sYCZteUT10NPmqEUVMTZVIQHLR5QIXa1mhTew4e2QKZEc3bQ5Mh/eBcEJqxztEXmkXlOOFCJX7njcH2xPdom0jCdbAynMeaA+GdGZrp5IlB+Uzi2dfS9oxiJZAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <Venkata.Pyla@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>
Thread-Topic: Sample image including security packages
Thread-Index: AdXod0daEQ5yvAxmSqGjegxSRddNWwH/ZrKgAAl2o6AAi1X9QAE8vGfQABlxYhAABxXXUAAAjNqgAABJS/A=
Date: Thu, 12 Mar 2020 07:33:41 +0000
X-TSB-HOP: ON
Message-ID: <TYXPR01MB180817C883F874B321DBA264E1FD0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <TYXPR01MB1808AD5423CA82AE50EC4D90E1120@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <7ba7bb426c814ffcaefeccd646b0e302@TOSHIBA-TSIP.COM>
 <5dda4cb9fd40483d92ee99145522cca0@toshiba-tsip.com>
 <TYXPR01MB1808B8B8709CBBC91634721EE1FC0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <d137306fa9f04073b09ee6f814fe4307@toshiba-tsip.com>
 <TYXPR01MB1808A5B2AD3CA8CA6FDC55C7E1FD0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <b0edc35e695b424583c0a4fc86e8b3bf@toshiba-tsip.com>
In-Reply-To: <b0edc35e695b424583c0a4fc86e8b3bf@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kazuhiro3.hayashi@toshiba.co.jp; 
x-originating-ip: [124.211.28.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d79246d7-5891-4921-fade-08d7c657b046
x-ms-traffictypediagnostic: TYXPR01MB1469:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <TYXPR01MB1469CF204E3A002737C33BACE1FD0@TYXPR01MB1469.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(66446008)(52536014)(33656002)(15650500001)(55016002)(186003)(86362001)(26005)(8936002)(64756008)(5660300002)(4326008)(9686003)(66556008)(478600001)(66476007)(7696005)(966005)(6506007)(53546011)(81156014)(71200400001)(66574012)(55236004)(110136005)(66946007)(76116006)(54906003)(8676002)(2906002)(316002)(30864003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:TYXPR01MB1469;
 H:TYXPR01MB1808.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4hFtukNk2t/JtUgvvZGUbi1HXveKQcSn6F+uDqikIvbbtovxLxaPTsY9HzpuVmq2CEE7WDKrf1wJRlcvwlwvy8+wToE3p6VW8EuswJ9r1hm4YV7blD1/N0q8uu0NjqJQ2HeiulZuVfIBIPZ58XCcWTnRO3OnU0GBLf3zQLACtYCZOhtHR5kXOxd/ZXcmxWO0laAefjfKjLwArckQVPyt75D213v6E6PmiyzVXbs9H2qr6gSBMm+L9k1v/YZFN0Lu7dduXN9phQkxJJJ3XOYQiXeTESKC+HUnDJcUHI6VmP5HnZFb3DAmq5YibMVwdnCseCvtiCaQaosMVAtWMpRoPbuVS+X/K1gMiogrYfBep7NBeI+isyjRPahPncnj28rKz3qAu1HDJ5YKInENtl3D7MsFgz+Ttr1v/scdvUEIYTOeRCeZ/EnDtXd1ZXAq0S5gJisjdUykNFXLS3R4BEoMtblKYVVtV9lAKLG+SB0w7Bc+0ZuvndhRCKKwiJmqr9oCtu4wbR5wulDa7oGGc93Yg==
x-ms-exchange-antispam-messagedata: EX2xJ2Zoougz4b/ZOUnTY4XcyIvfurXrC8hy+3jVJ8r0QWUTnKSGF8NyKVF5w2gF0oixb6qDS1P7uOr7OQgN5xR32B+kqwIqsX0l19883KRCgXYmPTuGc6jCgyvyZfTJMo20cDBdwhO+PODpuKcYUA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d79246d7-5891-4921-fade-08d7c657b046
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 07:33:41.7670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGuKcRhqpo4VX45PyqxiMKtPrWLqAHMFw6M4aeIg6S+sj5Xds6Gohm8tEQZWVzn29LQouu/YdOMVhYQ/YL9paSjcne+barH4f5j+aZaHI1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1469
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

> 
> Hello Kazu-san,
> 
> Thank you for confirming.
> Below is the merge request for the same.
> https://gitlab.com/zuka0828/isar-cip-core/-/merge_requests/1

Merged. Thank you for quick response.

Best regards,
Kazu

> 
> Thanks
> Venkata.
> 
> -----Original Message-----
> From: kazuhiro3.hayashi@toshiba.co.jp [mailto:kazuhiro3.hayashi@toshiba.co.jp]
> Sent: 12 March 2020 12:42
> To: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>; Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: RE: Sample image including security packages
> 
> Hello Venkata,
> 
> Thank you for checking the result.
> I confirmed that this variable should not be overwritten in the image recipe.
> Could you send MR including this update to https://gitlab.com/zuka0828/isar-cip-core ?
> 
> Best regards,
> Kazu
> 
> > -----Original Message-----
> > From: Venkata Seshagiri Pyla [mailto:Venkata.Pyla@toshiba-tsip.com]
> > Sent: Thursday, March 12, 2020 12:56 PM
> > To: hayashi kazuhiro(林 和宏 ○ＳＷＣ□ＯＳＴ) <kazuhiro3.hayashi@toshiba.co.jp>;
> > dinesh kumar(ＴＳＩＰ DS Company) <dinesh.kumar@toshiba-tsip.com>
> > Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> > Subject: RE: Sample image including security packages
> >
> > Hello Kazu-san,
> >
> > I observed 'init' system is not included in the image when append
> > operator is not used and so booting the image is not successful.
> >
> > Here is the output of `bitbake -e cip-core-image-security | grep
> > 'IMAGE_PREINSTALL'` when append is not used
> > ----------------------------------------------------------------------
> > ---------------------------
> > # $IMAGE_PREINSTALL [2 operations]
> > IMAGE_PREINSTALL=" 	openssl libssl1.1 	fail2ban 	openssh-server openssh-sftp-server openssh-client
> > 	syslog-ng-core syslog-ng-mod-journal 	aide aide-common 	libnftables0 nftables 	libpam-pkcs11
> > 	chrony 	tpm2-tools 	tpm2-abrmd 	libtss2-esys0 libtss2-udev 	libpam-cracklib 	acl
> > 	libauparse0 audispd-plugins auditd 	uuid-runtime 	vim "
> > #     "${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> > #   " ${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> > ----------------------------------------------------------------------
> > ---------------------------
> >
> > Output when append is used
> > ----------------------------------------------------------------------
> > ---------------------------
> > # $IMAGE_PREINSTALL [2 operations]
> > IMAGE_PREINSTALL=" init  	openssl libssl1.1 	fail2ban 	openssh-server openssh-sftp-server
> > openssh-client 	syslog-ng-core syslog-ng-mod-journal 	aide aide-common 	libnftables0 nftables
> > 	libpam-pkcs11 	chrony 	tpm2-tools 	tpm2-abrmd 	libtss2-esys0 libtss2-udev 	libpam-cracklib
> > 	acl 	libauparse0 audispd-plugins auditd 	uuid-runtime 	vim "
> > #     "${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> > #   " ${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
> > ----------------------------------------------------------------------
> > ---------------------------
> >
> >
> > Thanks,
> > Venkata.
> > -----Original Message-----
> > From: kazuhiro3.hayashi@toshiba.co.jp
> > [mailto:kazuhiro3.hayashi@toshiba.co.jp]
> > Sent: 12 March 2020 05:16
> > To: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>; Dinesh
> > Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
> > Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> > Subject: RE: Sample image including security packages
> >
> > Hello Venkata,
> >
> > Thank you for the information.
> >
> > Regarding the usage of `IMAGE_PREINSTALL`, I'm not sure if we always need `+` in the image recipe.
> > Example:
> > https://github.com/ilbers/isar/blob/master/doc/user_manual.md#create-a
> > -custom-image-recipe Could you dump the value of `IMAGE_PREINSTALL`
> > with/without `+` by `bitbake -e` command?
> >
> > Best regards,
> > Kazu
> >
> > > -----Original Message-----
> > > From: Venkata Seshagiri Pyla [mailto:Venkata.Pyla@toshiba-tsip.com]
> > > Sent: Thursday, March 5, 2020 6:06 PM
> > > To: hayashi kazuhiro(林 和宏 ○ＳＷＣ□ＯＳＴ)
> > > <kazuhiro3.hayashi@toshiba.co.jp>;
> > > dinesh kumar(ＴＳＩＰ DS Company) <dinesh.kumar@toshiba-tsip.com>
> > > Cc: cip-security@lists.cip-project.org;
> > > cip-dev@lists.cip-project.org
> > > Subject: RE: Sample image including security packages
> > >
> > > Hi Kazu-san and Dinesh,
> > >
> > > I have created the image with all proposed security packages included.
> > > applied the below change, and booted the image in QEMU correctly.
> > > -----------------
> > > diff --git a/recipes-core/images/cip-core-image-security.bb
> > > b/recipes-core/images/cip-core-image-security.bb
> > > index 70571f8..b883414 100644
> > > --- a/recipes-core/images/cip-core-image-security.bb
> > > +++ b/recipes-core/images/cip-core-image-security.bb
> > > @@ -18,7 +18,7 @@ IMAGE_INSTALL += "customizations"
> > >
> > >  # Debian packages that provide security features  # TODO: Add sudo
> > > or sudo-ldap which conflict each other -IMAGE_PREINSTALL = " \
> > > +IMAGE_PREINSTALL += " \
> > >  	openssl libssl1.1 \
> > >  	fail2ban \
> > >  	openssh-server openssh-sftp-server openssh-client \
> > > --
> > > -----------------
> > >
> > > Thanks
> > > venkata
> > > -----Original Message-----
> > > From: Venkata Seshagiri Pyla
> > > Sent: 02 March 2020 19:38
> > > To: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>;
> > > kazuhiro3.hayashi@toshiba.co.jp
> > > Cc: cip-security@lists.cip-project.org;
> > > cip-dev@lists.cip-project.org
> > > Subject: RE: Sample image including security packages
> > >
> > > Hi Kazu-san and Dinesh,
> > >
> > > >We found most of the packages are not included in the isar image,
> > > >could you please confirm whether all the proposed packages
> > > are included in the given source?
> > > >If it is included, could you please let us know how to install them in the image?
> > > I think we have to create the image for the target "cip-core-image-security" instead of "cip-core-image".
> > >
> > > All the security packages are configured to install are present in this file "cip-core-image-security.bb".
> > >
> > > I will generate the image for target "cip-core-image-security" and recheck all the security functionality.
> > >
> > > Thanks,
> > > Venkata.
> > >
> > > -----Original Message-----
> > > From: Cip-security
> > > [mailto:cip-security-bounces@lists.cip-project.org]
> > > On Behalf Of Dinesh Kumar
> > > Sent: 02 March 2020 15:29
> > > To: kazuhiro3.hayashi@toshiba.co.jp
> > > Cc: cip-security@lists.cip-project.org;
> > > cip-dev@lists.cip-project.org
> > > Subject: Re: [Cip-security] Sample image including security packages
> > >
> > > Dear Kazu-san,
> > >
> > > Thanks for sharing the isar-cip-core repository details with us.
> > >
> > > We followed below steps to first confirm whether all the proposed
> > > binaries are included when we create CIP isar based image.
> > > 1. Create CIP isar based image from
> > > "https://gitlab.com/zuka0828/isar-cip-core/-/tree/master"  for
> > > QEMU_x86-64 platform 2. Booted the image in QEMU virtual machine 3.
> > > For each security package we compared the binaries
> > listed on Debian page e.g. for acl package at
> > (https://packages.debian.org/buster/amd64/acl/filelist)
> > >      According to the Debian page there are three binaries which
> > > should be present in the image "/bin/chacl", "/bin/getfacl", "/bin/setfacl".
> > >      Then we check in the CIP running image at /bin whether all three packages are included or not.
> > > 4. Based on this kind of investigation we have prepare the attached
> > > list of missing binary packages in current CIP isar image.
> > >
> > > We found most of the packages are not included in the isar image,
> > > could you please confirm whether all the proposed packages are included in the given source?
> > > If it is included, could you please let us know how to install them in the image?
> > >
> > > Once all the security packages are included in the CIP isar image,
> > > we will proceed to next step of verifying applicable IEC 62443-4-2 security requirements.
> > >
> > > Thanks & Regards,
> > > Dinesh Kumar
> > >
> > >
> > > -----Original Message-----
> > > From: Cip-security <cip-security-bounces@lists.cip-project.org> On
> > > Behalf Of kazuhiro3.hayashi@toshiba.co.jp
> > > Sent: 21 February 2020 10:58
> > > To: cip-security@lists.cip-project.org
> > > Cc: cip-dev@lists.cip-project.org
> > > Subject: [Cip-security] Sample image including security packages
> > >
> > > Hello CIP Security WG,
> > >
> > > I've created a sample setting to customize CIP Core generic profile.
> > > https://gitlab.com/zuka0828/isar-cip-core/-/tree/master
> > > (Now in my personal account)
> > >
> > > Introduction:
> > > https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/SECURITY.md
> > >
> > > Please ask in cip-dev if you need more development information :)
> > >
> > > Note: `sudo` and `sudo-ldap` conflict each other, but both were proposed.
> > > We need to select one from them.
> > > I temporally removed the both from `IMAGE_PREINSTALL`.
> > >
> > > Best regards,
> > > Kazu
> > >
> > > _______________________________________________
> > > Cip-security mailing list
> > > Cip-security@lists.cip-project.org
> > > https://lists.cip-project.org/mailman/listinfo/cip-security
> > > The information contained in this e-mail message and in any
> > > attachments/annexure/appendices is confidential to the recipient and may contain privileged information.
> > > If you are not the intended recipient, please notify the sender and
> > > delete the message along with any attachments/annexure/appendices.
> > > You should not disclose, copy or otherwise use the information
> > > contained in the message or any annexure. Any views expressed in
> > > this e-mail are those of the individual sender except where the
> > sender specifically states them to be the views of Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
> > >
> > > Although this transmission and any attachments are believed to be
> > > free of any virus or other defect that might affect any computer
> > > system into which it is received and opened, it is the
> > > responsibility of the recipient to ensure that it is virus free and no responsibility is accepted by Toshiba Embedded
> Software India Pvt.
> > Ltd, for any loss or damage arising in any way from its use.
> > > The information contained in this e-mail message and in any
> > > attachments/annexure/appendices is confidential to the recipient and
> > > may contain privileged information.
> > > If you are not the intended recipient, please notify the sender and
> > > delete the message along with any attachments/annexure/appendices.
> > > You should not disclose, copy or otherwise use the information
> > > contained in the message or any annexure. Any views expressed in
> > > this e-mail are those of the individual sender except where the
> > > sender specifically states them to be the views of Toshiba Software India Pvt. Ltd.
> > > (TSIP),Bangalore.
> > >
> > > Although this transmission and any attachments are believed to be
> > > free of any virus or other defect that might affect any computer
> > > system into which it is received and opened, it is the
> > > responsibility of the recipient to ensure that it is virus free and
> > > no responsibility is accepted by Toshiba Embedded Software India
> > > Pvt. Ltd, for any loss or damage arising in any way from its use.
> >
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
