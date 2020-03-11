Return-Path: <SRS0=BiZv=44=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF3C0044D
	for <cip-dev@archiver.kernel.org>; Wed, 11 Mar 2020 23:45:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF34206B1
	for <cip-dev@archiver.kernel.org>; Wed, 11 Mar 2020 23:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF34206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EEB1420BF8;
	Wed, 11 Mar 2020 23:45:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gj3LYCAb5mHa; Wed, 11 Mar 2020 23:45:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1F54D20387;
	Wed, 11 Mar 2020 23:45:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12031C0177;
	Wed, 11 Mar 2020 23:45:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1D11C0177;
 Wed, 11 Mar 2020 23:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DDF258613E;
 Wed, 11 Mar 2020 23:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rvvg3Gww1P90; Wed, 11 Mar 2020 23:45:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DE2F685DC4;
 Wed, 11 Mar 2020 23:45:43 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 02BNjgTm009722;
 Thu, 12 Mar 2020 08:45:42 +0900
X-Iguazu-Qid: 34trcFcTQxFsHlJN1n
X-Iguazu-QSIG: v=2; s=0; t=1583970341; q=34trcFcTQxFsHlJN1n;
 m=pHltq/Kg2nWH6svB0XG2UKF36ejp2KFt47P6FVrZDdE=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1512) id 02BNjf56022908;
 Thu, 12 Mar 2020 08:45:41 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 02BNjfTx019433;
 Thu, 12 Mar 2020 08:45:41 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 02BNjfV2025665;
 Thu, 12 Mar 2020 08:45:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb77rgB3f+ejMdRNNDOuqxAVT3K8iznP17emYQa7JghQxs9JmN0z/D3nsxZW3Gpuj2bbdvPdduQhy3aeb5gCdcxDsiL90NYShGpxbQLbXVgm4bQXw9koUnausRyO+yPOoNB3RPEolvtaGZlUwTZTpbR2oB7qkmG6M8Nl3ICodLrhO/Ojme+Sl0InJhjBQ8FkprhWzv3bXHmA9nNBVPEUmFR9L9/Iy0hMhZAUxYnEM5a5D2Bgde40kdo2X/E1GKCaOSsXod68yxCCzLcBRW2B+wch/MVlrqwht8L2iwdZQoqIJo/PFynOafOCFXRc3+X9nXkRIsP84cmvLQ3FwiKwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajG42kzLJCDjTMsld1GPccgRkd5OPDKR5jIz3rKz8T8=;
 b=R3em4SYDkF6eCA6DWpuJ7vNnNt9qwEDzN7dT3rRtMD1r/plwMR5WzEgq5Egz5p5a3oZp/S1imFJZfWClWYj/1g2127ZfRelO/sSmSTFqHMpZYRYcriS6djFTIerEKLA0Vt4hO/RkzUKgNUxzRv1epB/Inir/R/ZR8kaoFjUwd6zpk2uVti9sPCy8m9mcmea0i2J+ftJkpELPcc9f4IDomFpfG3cF+YV4rxhP6vITf/+H4wK4Dsrdq3BsKZNsyHJl7Bme+AWVvq2iKJGppGjWAIMfLgCvSPmd0+OlXrY8ZW+4jbqdbcSR768zPL76mjlSfEDGt455upUSWiMff09Jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <Venkata.Pyla@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>
Thread-Topic: Sample image including security packages
Thread-Index: AdXod0daEQ5yvAxmSqGjegxSRddNWwH/ZrKgAAl2o6AAi1X9QAE8vGfQ
Date: Wed, 11 Mar 2020 23:45:38 +0000
X-TSB-HOP: ON
Message-ID: <TYXPR01MB1808B8B8709CBBC91634721EE1FC0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <TYXPR01MB1808AD5423CA82AE50EC4D90E1120@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <7ba7bb426c814ffcaefeccd646b0e302@TOSHIBA-TSIP.COM>
 <5dda4cb9fd40483d92ee99145522cca0@toshiba-tsip.com>
In-Reply-To: <5dda4cb9fd40483d92ee99145522cca0@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kazuhiro3.hayashi@toshiba.co.jp; 
x-originating-ip: [124.211.28.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc603876-d669-498d-3eed-08d7c6164d72
x-ms-traffictypediagnostic: TYXPR01MB1742:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <TYXPR01MB174270D505B9645A677D27E8E1FC0@TYXPR01MB1742.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(81156014)(2906002)(81166006)(8676002)(66574012)(110136005)(54906003)(9686003)(53546011)(55236004)(7696005)(86362001)(6506007)(966005)(55016002)(5660300002)(52536014)(478600001)(71200400001)(15650500001)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(4326008)(316002)(33656002)(186003)(26005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:TYXPR01MB1742;
 H:TYXPR01MB1808.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgphO/TF7J5uMYQTIFaTSv2vGSdQhUpHTyDDJcCptPr8FdamhZsximVRU1ewfyfAMOkR8AW6QmufjS9cjMPMb1PPJXCeRQ7LCGIOuRS9u5kR2GJKgaiYURFQUvbQErreexlPmUymXZ9R0QoC5Zq/2RBplqjBSBilFIY4EA+UP3IhVrNATHRWoUey5ijU2i0wlMSaF/JbsKJ79Jg0t/z0RbwbAwlNYZrYmVKsY6sd/PngisQ+Rf6Zif14j7hzyKeUd2LG/C0W3A20GqDiEkjNf7ctv7E9R/1eCxgI1jXsb9RHlxj4fXM1SK6WWgLS6eDZo+/s4tOqTAHXZr51MdeQX0FpEWnW5W7PBoCwgDaEr1BuG4FxVHaT1DSP0R9BWSjrtJj9NgrJFRAEx70t74sxQ3JmfhjzSCRcH7u3yMHx7bDj8ANTzkjitzRH98IFvFf33H56F0fVJPHWLCBVFD97Wlk/8R5oSRwivK268MXjt0YJfGFAPrN9KzFHnpQlDEuG5FUTP/4qi7NbUPxldGNZlA==
x-ms-exchange-antispam-messagedata: q9XY1Gwu0W2tmtxy8xqNdBCbyVEu44thLxK6D9E7VDI4QSEkF7UMOHdLqdW7cYrcFF1mQxiiiuAGkIbtIn8i4xm75o/Q4ZbJbzI3iW8KWmPiQLBd9dE6UTz2jCaDKCynDej3URCtznV6uIb0ei+24g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc603876-d669-498d-3eed-08d7c6164d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 23:45:38.6577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yX6E8X+X23eH9nn9TASiNT3kRnQRCRqXQScccvqhusjKla2uPonkRdWPfS6/dp8KV0QUUbYJkLgIzJzCIzrnFf/U6kCV+uqj8e6FAt5Izi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1742
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

Thank you for the information.

Regarding the usage of `IMAGE_PREINSTALL`, I'm not sure if we always need `+` in the image recipe.
Example: https://github.com/ilbers/isar/blob/master/doc/user_manual.md#create-a-custom-image-recipe
Could you dump the value of `IMAGE_PREINSTALL` with/without `+` by `bitbake -e` command?

Best regards,
Kazu

> -----Original Message-----
> From: Venkata Seshagiri Pyla [mailto:Venkata.Pyla@toshiba-tsip.com]
> Sent: Thursday, March 5, 2020 6:06 PM
> To: hayashi kazuhiro(林 和宏 ○ＳＷＣ□ＯＳＴ) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(ＴＳＩＰ DS Company)
> <dinesh.kumar@toshiba-tsip.com>
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: RE: Sample image including security packages
> 
> Hi Kazu-san and Dinesh,
> 
> I have created the image with all proposed security packages included.
> applied the below change, and booted the image in QEMU correctly.
> -----------------
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 70571f8..b883414 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -18,7 +18,7 @@ IMAGE_INSTALL += "customizations"
> 
>  # Debian packages that provide security features
>  # TODO: Add sudo or sudo-ldap which conflict each other
> -IMAGE_PREINSTALL = " \
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
> To: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>; kazuhiro3.hayashi@toshiba.co.jp
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: RE: Sample image including security packages
> 
> Hi Kazu-san and Dinesh,
> 
> >We found most of the packages are not included in the isar image, could you please confirm whether all the proposed packages
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
> From: Cip-security [mailto:cip-security-bounces@lists.cip-project.org] On Behalf Of Dinesh Kumar
> Sent: 02 March 2020 15:29
> To: kazuhiro3.hayashi@toshiba.co.jp
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: Re: [Cip-security] Sample image including security packages
> 
> Dear Kazu-san,
> 
> Thanks for sharing the isar-cip-core repository details with us.
> 
> We followed below steps to first confirm whether all the proposed binaries are included when we create CIP isar based
> image.
> 1. Create CIP isar based image from "https://gitlab.com/zuka0828/isar-cip-core/-/tree/master"  for QEMU_x86-64 platform
> 2. Booted the image in QEMU virtual machine 3. For each security package we compared the binaries listed on Debian page
> e.g. for acl package at (https://packages.debian.org/buster/amd64/acl/filelist)
>      According to the Debian page there are three binaries which should be present in the image "/bin/chacl", "/bin/getfacl",
> "/bin/setfacl".
>      Then we check in the CIP running image at /bin whether all three packages are included or not.
> 4. Based on this kind of investigation we have prepare the attached list of missing binary packages in current CIP isar
> image.
> 
> We found most of the packages are not included in the isar image, could you please confirm whether all the proposed packages
> are included in the given source?
> If it is included, could you please let us know how to install them in the image?
> 
> Once all the security packages are included in the CIP isar image, we will proceed to next step of verifying applicable
> IEC 62443-4-2 security requirements.
> 
> Thanks & Regards,
> Dinesh Kumar
> 
> 
> -----Original Message-----
> From: Cip-security <cip-security-bounces@lists.cip-project.org> On Behalf Of kazuhiro3.hayashi@toshiba.co.jp
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
> Introduction: https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/SECURITY.md
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
> The information contained in this e-mail message and in any attachments/annexure/appendices is confidential to the recipient
> and may contain privileged information.
> If you are not the intended recipient, please notify the sender and delete the message along with any
> attachments/annexure/appendices. You should not disclose, copy or otherwise use the information contained in the message
> or any annexure. Any views expressed in this e-mail are those of the individual sender except where the sender specifically
> states them to be the views of Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
> 
> Although this transmission and any attachments are believed to be free of any virus or other defect that might affect
> any computer system into which it is received and opened, it is the responsibility of the recipient to ensure that it
> is virus free and no responsibility is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or damage arising
> in any way from its use.
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
