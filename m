Return-Path: <SRS0=mRBS=MV=lists.cip-project.org=bounce+64572+6642+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048CBC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 08:13:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C37761074
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 08:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C37761074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ClLvYY4521723xhps8yHhy6m; Thu, 29 Jul 2021 01:13:26 -0700
X-Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web08.6858.1627546405079825798
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jul 2021 01:13:25 -0700
X-Received: by mail-oi1-f175.google.com with SMTP id u25so7436151oiv.5
        for <cip-dev@lists.cip-project.org>; Thu, 29 Jul 2021 01:13:24 -0700 (PDT)
X-Gm-Message-State: 8eS86XOnnlH1YTy20Y8tWWx0x4520388AA=
X-Google-Smtp-Source: ABdhPJzIEflGcraRzHw3qvavXrWwYMOu2alUpnWc5xx1wWvjtpnaRnr0mFINzhGhKCgiPJPx6VuXLD1qW46CSyFbq+I=
X-Received: by 2002:a05:6808:1523:: with SMTP id u35mr2289460oiw.132.1627546404269;
 Thu, 29 Jul 2021 01:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
 <TYAPR01MB6252DB5C0B863E4028766A2692EB9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB6252DB5C0B863E4028766A2692EB9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Jul 2021 17:12:48 +0900
Message-ID: <CAODzB9rC-OAfamRuvMcS-nr7O_aWbqYReNnpYems78FCtCW1yQ@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="PuD6B9ddbUm4fdJzRSST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627546406;
 bh=mOj0Swf8xnPQ8MSJtfusaRE4BBX8mv0zxbWSeeYDuxA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=df07Tgm0w2XMEJbQ854NvznrKAmnEFPlRfn83xNFNGozG96ncWVi8mchs0Opo23Dilz
 ZbyBYyv07KBXWK4wl47iTvXDfHLTm+cqDWJdALg+oECiWTjKJ+dfR1ydMJKqWG9VMeVtq
 lb39MoBQT0TUzdMNztmy1gKsEQg8RBuqVLI=

--PuD6B9ddbUm4fdJzRSST
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi !

On Thu, Jul 29, 2021 at 4:50 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.=
org] On Behalf Of =E5=B8=82=E5=B7=9D=E6=AD=A3=E7=BE=8E
> > Sent: Thursday, July 29, 2021 10:19 AM
> > To: cip-dev <cip-dev@lists.cip-project.org>
> > Subject: [cip-dev] New CVE entries this week
> >
> > Hi !
> >
> > Here is this week's CVE report.
> >
> > * CVE short summary
> >
> > ** New CVEs
> >
> > CVE-2021-3640: there is no fixed information as of 2021/07/29.
> >
> > CVE-2021-37576: mainline and stable kernels are fixed. This CVE only
> > affects powerpc architecture.
> >
> > ** Updated CVEs
> >
> > CVE-2021-31829: I fixed wrong security information.
> >
> > CVE-2021-22543: added stable/4.19 fixed commit.
> >
> > ** Traking CVEs
> >
> > CVE-2021-29256: not fiexd in mainline yet
> >
> > CVE-2021-31615: not fiexd in mainline yet
> >
> > CVE-2021-21781: v4.4 is not fixed as of 2021/07/29
> >
> > CVE-2021-3655: v4.4 is not fixed as of 2021/07/29
>
> This has been fixed with the following commit.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/=
?h=3Dlinux-4.4.y&id=3D48cd035cad5b5fad0648aa8294c4223bedb166dd
>

Thank you! I'll add this one to fixed-by list.

> Best regards,
>   Nobuhiro
>
>=20
>


--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--PuD6B9ddbUm4fdJzRSST
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6642): https://lists.cip-project.org/g/cip-dev/message=
/6642
Mute This Topic: https://lists.cip-project.org/mt/84519830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PuD6B9ddbUm4fdJzRSST--
