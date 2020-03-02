Return-Path: <SRS0=Ya7F=4T=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F65C3F2D2
	for <cip-dev@archiver.kernel.org>; Mon,  2 Mar 2020 14:15:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848DD2173E
	for <cip-dev@archiver.kernel.org>; Mon,  2 Mar 2020 14:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848DD2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 46477875B9;
	Mon,  2 Mar 2020 14:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wq0YCNLXbGCe; Mon,  2 Mar 2020 14:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38E35875F4;
	Mon,  2 Mar 2020 14:15:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A6D8C013E;
	Mon,  2 Mar 2020 14:15:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 108C8C013E;
 Mon,  2 Mar 2020 14:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 003AC85C19;
 Mon,  2 Mar 2020 14:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m8JEDC2Qly8S; Mon,  2 Mar 2020 14:15:30 +0000 (UTC)
X-Greylist: delayed 00:07:12 by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from peak.toshiba-tesi.com (mail.toshiba-tsip.com [202.56.254.199])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4244D85BFA;
 Mon,  2 Mar 2020 14:15:29 +0000 (UTC)
IronPort-SDR: 4fMUbT5U+sblIPiS3lFBa+58LshtArd52hI5AKs0fUt765djmzwulfTogG99vzsw9G2a4S4sTR
 eFe3v8dvqNog==
X-IronPort-AV: E=Sophos;i="5.70,507,1574101800"; 
   d="scan'208";a="2215214"
Received: from unknown (HELO TOSBLRMBX0319.TOSHIBA-TSIP.COM) ([172.28.80.120])
 by peak.toshiba-tesi.com with ESMTP; 02 Mar 2020 19:54:05 +0530
Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 2 Mar 2020 19:38:12 +0530
Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::8d35:f069:2af2:deff%9]) with mapi id
 15.01.1847.003; Mon, 2 Mar 2020 19:38:12 +0530
From: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>
To: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Thread-Topic: Sample image including security packages
Thread-Index: AdXod0daEQ5yvAxmSqGjegxSRddNWwH/ZrKgAAl2o6A=
Date: Mon, 2 Mar 2020 14:08:12 +0000
Message-ID: <ef0872f23b424419b4894f1179c16e6b@toshiba-tsip.com>
References: <TYXPR01MB1808AD5423CA82AE50EC4D90E1120@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <7ba7bb426c814ffcaefeccd646b0e302@TOSHIBA-TSIP.COM>
In-Reply-To: <7ba7bb426c814ffcaefeccd646b0e302@TOSHIBA-TSIP.COM>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi Kazu-san and Dinesh,

>We found most of the packages are not included in the isar image, could you please confirm whether all the proposed packages are included in the given source?
>If it is included, could you please let us know how to install them in the image?
I think we have to create the image for the target "cip-core-image-security" instead of "cip-core-image".

All the security packages are configured to install are present in this file "cip-core-image-security.bb".

I will generate the image for target "cip-core-image-security" and recheck all the security functionality.

Thanks,
Venkata.

-----Original Message-----
From: Cip-security [mailto:cip-security-bounces@lists.cip-project.org] On Behalf Of Dinesh Kumar
Sent: 02 March 2020 15:29
To: kazuhiro3.hayashi@toshiba.co.jp
Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
Subject: Re: [Cip-security] Sample image including security packages

Dear Kazu-san,

Thanks for sharing the isar-cip-core repository details with us.

We followed below steps to first confirm whether all the proposed binaries are included when we create CIP isar based image.
1. Create CIP isar based image from "https://gitlab.com/zuka0828/isar-cip-core/-/tree/master"  for QEMU_x86-64 platform 2. Booted the image in QEMU virtual machine 3. For each security package we compared the binaries listed on Debian page e.g. for acl package at (https://packages.debian.org/buster/amd64/acl/filelist)
     According to the Debian page there are three binaries which should be present in the image "/bin/chacl", "/bin/getfacl", "/bin/setfacl".
     Then we check in the CIP running image at /bin whether all three packages are included or not.
4. Based on this kind of investigation we have prepare the attached list of missing binary packages in current CIP isar image.

We found most of the packages are not included in the isar image, could you please confirm whether all the proposed packages are included in the given source?
If it is included, could you please let us know how to install them in the image?

Once all the security packages are included in the CIP isar image, we will proceed to next step of verifying applicable IEC 62443-4-2 security requirements.

Thanks & Regards,
Dinesh Kumar


-----Original Message-----
From: Cip-security <cip-security-bounces@lists.cip-project.org> On Behalf Of kazuhiro3.hayashi@toshiba.co.jp
Sent: 21 February 2020 10:58
To: cip-security@lists.cip-project.org
Cc: cip-dev@lists.cip-project.org
Subject: [Cip-security] Sample image including security packages

Hello CIP Security WG,

I've created a sample setting to customize CIP Core generic profile.
https://gitlab.com/zuka0828/isar-cip-core/-/tree/master
(Now in my personal account)

Introduction: https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/SECURITY.md

Please ask in cip-dev if you need more development information :)

Note: `sudo` and `sudo-ldap` conflict each other, but both were proposed.
We need to select one from them.
I temporally removed the both from `IMAGE_PREINSTALL`.

Best regards,
Kazu

_______________________________________________
Cip-security mailing list
Cip-security@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-security
The information contained in this e-mail message and in any attachments/annexure/appendices is confidential to the recipient and may contain privileged information. 
If you are not the intended recipient, please notify the sender and delete the message along with any attachments/annexure/appendices. You should not disclose, copy or otherwise use the information contained in the message or any annexure. Any views expressed in this e-mail are those of the individual sender except where the sender specifically states them to be the views of Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be free of any virus or other defect that might affect any computer system into which it is received and opened, it is the responsibility of the recipient to ensure that it is virus free and no responsibility is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or damage arising in any way from its use.
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
