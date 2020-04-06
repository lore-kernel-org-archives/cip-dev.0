Return-Path: <SRS0=Wox9=5W=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD2FC2BA18
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AF32075E
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AF32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1B3E822F4C;
	Mon,  6 Apr 2020 07:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EznDmYAL4tqO; Mon,  6 Apr 2020 07:35:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 09D19230F3;
	Mon,  6 Apr 2020 07:35:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7778C0177;
	Mon,  6 Apr 2020 07:35:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE07C0177;
 Mon,  6 Apr 2020 07:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0FAD587C4A;
 Mon,  6 Apr 2020 07:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfuunyhoRQUW; Mon,  6 Apr 2020 07:35:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF7C48789E;
 Mon,  6 Apr 2020 07:35:31 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0367ZT8v010545;
 Mon, 6 Apr 2020 16:35:29 +0900
X-Iguazu-Qid: 2wHI1scKEvLGDqayGm
X-Iguazu-QSIG: v=2; s=0; t=1586158529; q=2wHI1scKEvLGDqayGm;
 m=OhmsSKrJI1X5Qh5/zCnlIRDkt/30peBawOiauxhfYu4=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1113) id 0367ZS9s018349;
 Mon, 6 Apr 2020 16:35:28 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 0367ZSJn011228;
 Mon, 6 Apr 2020 16:35:28 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 0367ZSav006093;
 Mon, 6 Apr 2020 16:35:28 +0900
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To: Kento Yoshida <kento.yoshida.wz@renesas.com>
References: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <OSAPR01MB36671C415EDE77F710011BF692C60@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <TYAPR01MB23993BE82FAB5F84728C6C37DFC70@TYAPR01MB2399.jpnprd01.prod.outlook.com>
Date: Mon, 06 Apr 2020 16:35:23 +0900
In-Reply-To: <TYAPR01MB23993BE82FAB5F84728C6C37DFC70@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 (Kento Yoshida's message of "Fri, 3 Apr 2020 01:50:43 +0000")
X-TSB-HOP: ON
Message-ID: <87r1x1yslg.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
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

Hi Kent,

Kento Yoshida <kento.yoshida.wz@renesas.com> writes:

> Thank you for your feedback, Iwamatsu-san.
>
>>-----Original Message-----
>>From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>

[...]

>>> As you may know, some of other packages we selected are dependent on python
>>3.x, so we may have the below options:
>>>
>>> 1. Maintain python 2.7 as well
>>> 2. Backport the upper duplicity which migrated python 3.x in bullseye
>>> archive 3. Others
>>>
>>> What do you think is best?
>>> I hope we can decide the policy within the CIP core group because there shall be
>>similar problems for the others of python.
>>
>>In my opinion, it is difficult to support Python2 for a super long term. And I think
>>it is difficult to support each library using Python2.
>>Therefore, I think Option2 is good. And if necessary, we can use
>>backposts.debian.org.
>
> Actually, option-2 is dominant in the security team as well.

From a brief look at the pros / cons between the two choices (below), I
am also biased towards backporting a python3 based version of duplicity.

Suggested next steps further down - 

* Python2

  Pros
  ----
  * No backport (to Buster) needed (least effort, right now)

  Cons
  ----
  * Has reached EOL in upstream. Not sure about ELTS support. It maybe
  that if we go with Python2, we (CIP) is on our own.


* Python3

  Pros
  ----
  * Python3 is available in Debian Buster
  * Likely to be supported for longer time - upstream and in Debian

  Cons
  ----
  * Needs backporting duplicity (and dependencies) to Buster via
    backports to align with upstream first approach of CIP.
    - From a quick check of dependencies in bullseye a backport of
      librsync2 might also be needed.


Next steps
----------
* Investigate the effort to backport duplicity (and dependencies) to
  buster-backports.
* If no major surprises are found during the investigation, work with
  Debian upstream to upload the new version.

Hope that makes sense.

Thanks,
Punit


>>However, packages with large dependencies can be difficult to backports. For
>>example Kbuckup is difficult, I think.
>>
>
> Agree. We are not going to select the package which is GPL-3 or has a lot of dependent package, so the duplicity is only one candidate for us substantially.
>
>>Best regards,
>>  Nobuhiro
>>
>>From: cip-dev [mailto:cip-dev-bounces@lists.cip-project.org] On Behalf Of Kento
>>Yoshida
>>Sent: Thursday, April 2, 2020 6:59 PM
>>To: cip-dev@lists.cip-project.org
>>Cc: cip-security@lists.cip-project.org
>>Subject: [cip-dev] Python 3.x vs 2.7
>>
>>Hi CIP core group,
>>
>>The security package proposal is suspended now, but I'd like to discuss about the
>>python version which is suitable to maintain.
>>
>>We selected "duplicity" for the requirement of system backup according to the
>>functionality, license, the number of dependencies and so on.
>>However, the duplicity in the Debian buster [1] dependent on python 2.7, which is
>>not maintained anymore [2].
>>
>>[1] https://packages.debian.org/source/buster/duplicity
>>[2] https://pythonclock.org/
>>
>>As you may know, some of other packages we selected are dependent on python
>>3.x, so we may have the below options:
>>
>>1. Maintain python 2.7 as well
>>2. Backport the upper duplicity which migrated python 3.x in bullseye archive 3.
>>Others
>>
>>What do you think is best?
>>I hope we can decide the policy within the CIP core group because there shall be
>>similar problems for the others of python.
>>
>>FYI, unfortunately we couldn't find the alternative package for system backup. The
>>duplicity is the best package for us from the license and num of dependencies
>>point of view.
>>See the following.
>>
>><Rsync>
>>Encryption: No
>>Schedule backup: No
>>Incremental backup: Yes
>>License: GPL v3
>>Dependencies count (aprox): 24
>>Reference: https://rsync.samba.org/features.html
>>
>><duplicity>
>>Encryption: Yes
>>Schedule backup: No
>>Incremental backup: Yes
>>License: GPL v2
>>Dependencies count (aprox): 80
>>Reference: http://duplicity.nongnu.org/features.ht
>>
>><Backuppc>
>>Encryption: No
>>Schedule backup: Yes
>>Incremental backup: Yes
>>License: GPL-2+, X11
>>Dependencies count (aprox): 132
>>Reference: http://backuppc.sourceforge.net/info.html
>>
>><Amanda>
>>Encryption: Yes
>>Schedule backup: Yes
>>Incremental backup: Yes
>>License: GPL-2+
>>Dependencies count (aprox): 289
>>Reference: https://www.zmanda.com/amanda-community-edition.html
>>
>><Kbackup>
>>Encryption: Yes
>>Schedule backup: Yes
>>Incremental backup: Yes
>>License: GPL-2, LGPL-2.1, GFDL-1.2+, KDEeV Dependencies count (aprox): 414
>>Reference: https://kde.org/applications/utilities/org.kde.kbackup
>>
>>Best regards,
>>Kent
> _______________________________________________
> cip-dev mailing list
> cip-dev@lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
