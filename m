Return-Path: <SRS0=DIdx=45=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82755C10DCE
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 03:56:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3530D206E2
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 03:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3530D206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D84B3859D6;
	Thu, 12 Mar 2020 03:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PMrV5TqEk7P2; Thu, 12 Mar 2020 03:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B9D1859D5;
	Thu, 12 Mar 2020 03:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57F22C0177;
	Thu, 12 Mar 2020 03:56:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEB7CC0177;
 Thu, 12 Mar 2020 03:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E57FB891DB;
 Thu, 12 Mar 2020 03:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YT65U4kQYiu4; Thu, 12 Mar 2020 03:56:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from peak.toshiba-tesi.com (mail.toshiba-tsip.com [202.56.254.199])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6564587FDE;
 Thu, 12 Mar 2020 03:56:14 +0000 (UTC)
IronPort-SDR: LYvjr2V8+XE3i/Zut46jQoxj4i5VqDUsgMvB84j6fEP9V7BF0MSlUz54rXC3yvoFmPot4LN8GT
 y45aowhsnTPw==
X-IronPort-AV: E=Sophos;i="5.70,543,1574101800"; 
   d="scan'208";a="2410726"
Received: from unknown (HELO TOSBLRMBX0219.TOSHIBA-TSIP.COM) ([172.28.80.119])
 by peak.toshiba-tesi.com with ESMTP; 12 Mar 2020 09:43:12 +0530
Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 12 Mar 2020 09:26:04 +0530
Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::8d35:f069:2af2:deff%9]) with mapi id
 15.01.1847.003; Thu, 12 Mar 2020 09:26:04 +0530
From: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>
To: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
 Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
Thread-Topic: Sample image including security packages
Thread-Index: AdXod0daEQ5yvAxmSqGjegxSRddNWwH/ZrKgAAl2o6AAi1X9QAE8vGfQABlxYhA=
Date: Thu, 12 Mar 2020 03:56:04 +0000
Message-ID: <d137306fa9f04073b09ee6f814fe4307@toshiba-tsip.com>
References: <TYXPR01MB1808AD5423CA82AE50EC4D90E1120@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <7ba7bb426c814ffcaefeccd646b0e302@TOSHIBA-TSIP.COM>
 <5dda4cb9fd40483d92ee99145522cca0@toshiba-tsip.com>
 <TYXPR01MB1808B8B8709CBBC91634721EE1FC0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB1808B8B8709CBBC91634721EE1FC0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.80.121]
MIME-Version: 1.0
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
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

Hello Kazu-san,

I observed 'init' system is not included in the image when append operator is not used and so booting the image is not successful.

Here is the output of `bitbake -e cip-core-image-security | grep 'IMAGE_PREINSTALL'` when append is not used
-------------------------------------------------------------------------------------------------
# $IMAGE_PREINSTALL [2 operations]
IMAGE_PREINSTALL=" 	openssl libssl1.1 	fail2ban 	openssh-server openssh-sftp-server openssh-client 	syslog-ng-core syslog-ng-mod-journal 	aide aide-common 	libnftables0 nftables 	libpam-pkcs11 	chrony 	tpm2-tools 	tpm2-abrmd 	libtss2-esys0 libtss2-udev 	libpam-cracklib 	acl 	libauparse0 audispd-plugins auditd 	uuid-runtime 	vim "
#     "${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
#   " ${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
-------------------------------------------------------------------------------------------------

Output when append is used
-------------------------------------------------------------------------------------------------
# $IMAGE_PREINSTALL [2 operations]
IMAGE_PREINSTALL=" init  	openssl libssl1.1 	fail2ban 	openssh-server openssh-sftp-server openssh-client 	syslog-ng-core syslog-ng-mod-journal 	aide aide-common 	libnftables0 nftables 	libpam-pkcs11 	chrony 	tpm2-tools 	tpm2-abrmd 	libtss2-esys0 libtss2-udev 	libpam-cracklib 	acl 	libauparse0 audispd-plugins auditd 	uuid-runtime 	vim "
#     "${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
#   " ${IMAGE_PREINSTALL} ${IMAGE_INSTALL}"
-------------------------------------------------------------------------------------------------


Thanks,
Venkata.
-----Original Message-----
From: kazuhiro3.hayashi@toshiba.co.jp [mailto:kazuhiro3.hayashi@toshiba.co.jp] 
Sent: 12 March 2020 05:16
To: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>; Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
Subject: RE: Sample image including security packages

Hello Venkata,

Thank you for the information.

Regarding the usage of `IMAGE_PREINSTALL`, I'm not sure if we always need `+` in the image recipe.
Example: https://github.com/ilbers/isar/blob/master/doc/user_manual.md#create-a-custom-image-recipe
Could you dump the value of `IMAGE_PREINSTALL` with/without `+` by `bitbake -e` command?

Best regards,
Kazu

> -----Original Message-----
> From: Venkata Seshagiri Pyla [mailto:Venkata.Pyla@toshiba-tsip.com]
> Sent: Thursday, March 5, 2020 6:06 PM
> To: hayashi kazuhiro(林 和宏 ○ＳＷＣ□ＯＳＴ) <kazuhiro3.hayashi@toshiba.co.jp>; 
> dinesh kumar(ＴＳＩＰ DS Company) <dinesh.kumar@toshiba-tsip.com>
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: RE: Sample image including security packages
> 
> Hi Kazu-san and Dinesh,
> 
> I have created the image with all proposed security packages included.
> applied the below change, and booted the image in QEMU correctly.
> -----------------
> diff --git a/recipes-core/images/cip-core-image-security.bb 
> b/recipes-core/images/cip-core-image-security.bb
> index 70571f8..b883414 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -18,7 +18,7 @@ IMAGE_INSTALL += "customizations"
> 
>  # Debian packages that provide security features  # TODO: Add sudo or 
> sudo-ldap which conflict each other -IMAGE_PREINSTALL = " \
> +IMAGE_PREINSTALL += " \
>  	openssl libssl1.1 \
>  	fail2ban \
>  	openssh-server openssh-sftp-server openssh-client \
> --
> -----------------
> 
> Thanks
> venkata
> -----Original Message-----
> From: Venkata Seshagiri Pyla
> Sent: 02 March 2020 19:38
> To: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>; 
> kazuhiro3.hayashi@toshiba.co.jp
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: RE: Sample image including security packages
> 
> Hi Kazu-san and Dinesh,
> 
> >We found most of the packages are not included in the isar image, 
> >could you please confirm whether all the proposed packages
> are included in the given source?
> >If it is included, could you please let us know how to install them in the image?
> I think we have to create the image for the target "cip-core-image-security" instead of "cip-core-image".
> 
> All the security packages are configured to install are present in this file "cip-core-image-security.bb".
> 
> I will generate the image for target "cip-core-image-security" and recheck all the security functionality.
> 
> Thanks,
> Venkata.
> 
> -----Original Message-----
> From: Cip-security [mailto:cip-security-bounces@lists.cip-project.org] 
> On Behalf Of Dinesh Kumar
> Sent: 02 March 2020 15:29
> To: kazuhiro3.hayashi@toshiba.co.jp
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: Re: [Cip-security] Sample image including security packages
> 
> Dear Kazu-san,
> 
> Thanks for sharing the isar-cip-core repository details with us.
> 
> We followed below steps to first confirm whether all the proposed 
> binaries are included when we create CIP isar based image.
> 1. Create CIP isar based image from 
> "https://gitlab.com/zuka0828/isar-cip-core/-/tree/master"  for 
> QEMU_x86-64 platform 2. Booted the image in QEMU virtual machine 3. For each security package we compared the binaries listed on Debian page e.g. for acl package at (https://packages.debian.org/buster/amd64/acl/filelist)
>      According to the Debian page there are three binaries which 
> should be present in the image "/bin/chacl", "/bin/getfacl", "/bin/setfacl".
>      Then we check in the CIP running image at /bin whether all three packages are included or not.
> 4. Based on this kind of investigation we have prepare the attached 
> list of missing binary packages in current CIP isar image.
> 
> We found most of the packages are not included in the isar image, 
> could you please confirm whether all the proposed packages are included in the given source?
> If it is included, could you please let us know how to install them in the image?
> 
> Once all the security packages are included in the CIP isar image, we 
> will proceed to next step of verifying applicable IEC 62443-4-2 security requirements.
> 
> Thanks & Regards,
> Dinesh Kumar
> 
> 
> -----Original Message-----
> From: Cip-security <cip-security-bounces@lists.cip-project.org> On 
> Behalf Of kazuhiro3.hayashi@toshiba.co.jp
> Sent: 21 February 2020 10:58
> To: cip-security@lists.cip-project.org
> Cc: cip-dev@lists.cip-project.org
> Subject: [Cip-security] Sample image including security packages
> 
> Hello CIP Security WG,
> 
> I've created a sample setting to customize CIP Core generic profile.
> https://gitlab.com/zuka0828/isar-cip-core/-/tree/master
> (Now in my personal account)
> 
> Introduction: 
> https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/SECURITY.md
> 
> Please ask in cip-dev if you need more development information :)
> 
> Note: `sudo` and `sudo-ldap` conflict each other, but both were proposed.
> We need to select one from them.
> I temporally removed the both from `IMAGE_PREINSTALL`.
> 
> Best regards,
> Kazu
> 
> _______________________________________________
> Cip-security mailing list
> Cip-security@lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-security
> The information contained in this e-mail message and in any 
> attachments/annexure/appendices is confidential to the recipient and may contain privileged information.
> If you are not the intended recipient, please notify the sender and 
> delete the message along with any attachments/annexure/appendices. You 
> should not disclose, copy or otherwise use the information contained 
> in the message or any annexure. Any views expressed in this e-mail are those of the individual sender except where the sender specifically states them to be the views of Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
> 
> Although this transmission and any attachments are believed to be free 
> of any virus or other defect that might affect any computer system 
> into which it is received and opened, it is the responsibility of the 
> recipient to ensure that it is virus free and no responsibility is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or damage arising in any way from its use.
> The information contained in this e-mail message and in any 
> attachments/annexure/appendices is confidential to the recipient and 
> may contain privileged information.
> If you are not the intended recipient, please notify the sender and 
> delete the message along with any attachments/annexure/appendices. You 
> should not disclose, copy or otherwise use the information contained 
> in the message or any annexure. Any views expressed in this e-mail are 
> those of the individual sender except where the sender specifically 
> states them to be the views of Toshiba Software India Pvt. Ltd. 
> (TSIP),Bangalore.
> 
> Although this transmission and any attachments are believed to be free 
> of any virus or other defect that might affect any computer system 
> into which it is received and opened, it is the responsibility of the 
> recipient to ensure that it is virus free and no responsibility is 
> accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or 
> damage arising in any way from its use.

The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
