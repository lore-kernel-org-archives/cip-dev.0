Return-Path: <SRS0=dl4z=OU=lists.cip-project.org=bounce+64572+6765+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93787C433FE
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 12:12:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D8361269
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 12:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2D8361269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EIIDYY4521723xdpTFK7SqNU; Thu, 30 Sep 2021 05:12:17 -0700
X-Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web08.11365.1633003935587017888
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Sep 2021 05:12:16 -0700
X-Received: by mail-oi1-f169.google.com with SMTP id w206so6962220oiw.4
        for <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 05:12:15 -0700 (PDT)
X-Gm-Message-State: jlhyW9xUF7qWqCVi9S8QBvkXx4520388AA=
X-Google-Smtp-Source: ABdhPJz2SvH7SYxhsCcz+0v+TSx7kLZLhqHiPJyPf8tWjZvUFb4fo5GjnXAjnQsC7+wCM+5U7kFi3Ew5UtZAvSGRTM4=
X-Received: by 2002:a05:6808:1709:: with SMTP id bc9mr2415255oib.116.1633003934561;
 Thu, 30 Sep 2021 05:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9qObzKXuh+WaSqh_KD=T2NfZw79d-NnXFX1vmNGj5wsqQ@mail.gmail.com>
 <TYAPR01MB625208BDE921AFB1D540B83D92AA9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB625208BDE921AFB1D540B83D92AA9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Sep 2021 21:11:38 +0900
Message-ID: <CAODzB9rM5dcTENMez8tm8FvhAgBR=2DCx7NK1xMevEnP53KP8g@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="VEtZcD6TkAaZnmKEk5t8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633003937;
 bh=o0pf+HKtTr/pr2YVrVxGfWrL0w4RIxgRDrcmjiKO3uQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fxZ/J5E+DOepUQ0sp9IwrIWnrVf8H9Icj/ro4x0rArZ/VxEGhn0hPOkap/haq4CF3gC
 7ck//X3wNDWLTVW66Rf/6J/lpDPUviQYNqcQqpSQS9MGPfi9n8Kv9lf2WZYd88Ek98iQo
 Plooki4fPTmVEYDLck90SGaWNm9p5ySUQiY=
Message-ID: <20210930121138.ba6B0esStkLxx9H0BrCe-GgRyGrIMaZdsUA11y3djnI@z>

--VEtZcD6TkAaZnmKEk5t8
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Sep 30, 2021 at 3:33 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.org] On Behalf Of Masami Ichikawa
> > Sent: Thursday, September 30, 2021 9:12 AM
> > To: cip-dev <cip-dev@lists.cip-project.org>
> > Subject: [cip-dev] New CVE entry this week
> >
> > Hi !
> >
> > It's this week's CVE report.
> >
> > This week reported one new CVE.
> >
> > * New CVEs
> >
> > CVE-2021-20317: lib/timerqueue: Rely on rbtree semantics for next timer
> >
> > This bug has been fixed in 5.4-rc1 so that before 5.4 kernels are
> > affected. For 4.19, patch can be applied without any modification. For
> > 4.4, it needs to modify patch to apply it.
> > According to the description in
> > cve.mitre.org(https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20317),
> > it describes "This flaw allows a local attacker with special user
> > privileges to cause a denial of service" so I think this vulnerability
> > severity may be low.
> >
> > CVSS v3 score is not provided.
> >
> > Fixed status
> >
> > mainline: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
> > stable/5.10: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
> > stable/5.14: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
> > stable/5.4: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
>
> This commit can be applied directly to 4.14 and 4.19.
> However, other LTSs need to be other commit or fixes.
>
> I attached a patch for 4.14 and 4.19.
>

Thank you for the patch!
It looks good to me.

> Best regards,
>   Nobuhiro
>
> 
>

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--VEtZcD6TkAaZnmKEk5t8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6765): https://lists.cip-project.org/g/cip-dev/message/=
6765
Mute This Topic: https://lists.cip-project.org/mt/85963258/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VEtZcD6TkAaZnmKEk5t8--
