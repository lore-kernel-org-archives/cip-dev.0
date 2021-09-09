Return-Path: <SRS0=8gDH=N7=lists.cip-project.org=bounce+64572+6722+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B5C433FE
	for <cip-dev@archiver.kernel.org>; Thu,  9 Sep 2021 12:24:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBF360FE3
	for <cip-dev@archiver.kernel.org>; Thu,  9 Sep 2021 12:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFBF360FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8o9VYY4521723xo0AHvNoD3V; Thu, 09 Sep 2021 05:24:08 -0700
X-Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.6605.1631190245586573036
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Sep 2021 05:24:07 -0700
X-Received: by mail-ot1-f51.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso2230300otv.3
        for <cip-dev@lists.cip-project.org>; Thu, 09 Sep 2021 05:24:05 -0700 (PDT)
X-Gm-Message-State: 5DXgPsg0CrqmfwoVJxcbzLURx4520388AA=
X-Google-Smtp-Source: ABdhPJwrxZ2d1c6T4w13LjuqQTkjLwcc/gAOVfy/jZPnQgcXr6RzBKazrPkqAaWKE65DPe1PHF9JSakB9ao/W+GZtVE=
X-Received: by 2002:a9d:7299:: with SMTP id t25mr2198958otj.232.1631190244425;
 Thu, 09 Sep 2021 05:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9oqUztiFZjcd0=dSBJ-bDjfdZ4eW8R69=m0fuZmKOb0qg@mail.gmail.com>
 <20210909064148.GA5892@amd>
In-Reply-To: <20210909064148.GA5892@amd>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Sep 2021 21:23:28 +0900
Message-ID: <CAODzB9od8o4MfvqNuUfhTb=ZPaBvKAVmmd2yFk-pt9G2OFpGgw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="ndrVUbrrurZmjuHtUz1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631190248;
 bh=1VfBv89l4IozpamA9Hbh4tYyjEax7grsv0Aj4oO56rI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qTYTlugMB2Ky4uyaLgkbJjthvPgyq7eGNn9z6GceyPJgvENM0EG2JlSfylIBVugsyv6
 oBEWDE0sJ7BZ0Vv9btsJIqPcp8qJe6oZPGJOYJfeeVjLEuoGuL2qoxdAtaJSRKUC7veNH
 +TNdzoppjI6ST/Rn36D1zi5y+se4pVmDIt8=

--ndrVUbrrurZmjuHtUz1Z
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Sep 9, 2021 at 3:42 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > CVE-2021-3759: memcg: charge semaphores and sem_undo objects
> >
> > This causes DoS attack. Patch was merged into mainline this week.
> >
> > for 4.19, it needs modify or apply following patches to apply commit
> > 18319498fdd4.
>
> I don't think we need to care about this one. Embedded systems don't
> usually run untrusted code...
>

I think so too. maybe we don't have to track this CVE.

> > CVE-2021-40490: A race condition was discovered in
> > ext4_write_inline_data_end in fs/ext4/inline.c in the ext4 subsystem
> > in the Linux kernel through 5.13.13.
>
> This is already queued to 4.4 and 4.19; we can simply wait.
>

Thanks. I overlooked it.

> > CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
> > to get shadow page
> >
> > 4.14 has been fixed this week.
> >
> > mainline: [b1bd5cba3306691c771d558e94baa73e8b0b96b7]
> > stable/4.14: [cea9e8ee3b8059bd2b36d68f1f428d165e5d13ce]
>
> KVM. Tricky code and not exactly focus on CIP code. But perhaps
> someone fixes it for us :-).
>

I see.  We don't have to track it. I'll update information when there
is a new update .

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--ndrVUbrrurZmjuHtUz1Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6722): https://lists.cip-project.org/g/cip-dev/message/=
6722
Mute This Topic: https://lists.cip-project.org/mt/85476557/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ndrVUbrrurZmjuHtUz1Z--
