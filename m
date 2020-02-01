From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sat, 1 Feb 2020 12:46:06 +0900
Subject: [cip-dev] 4.19-cip: test failure
In-Reply-To: <20200131224345.GA7777@amd>
References: <20200131224345.GA7777@amd>
Message-ID: <CABMQnVLcW6LroC2f9fWr3JPZbHQMYaSR+WOpnWwJfuPLT9dLOA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

This seems to be because this board cannot log in to rootfs.
   https://lava.ciplatform.org/scheduler/job/10588

I retry this test now.

Best regards,
  Nobuhiro

2020?2?1?(?) 7:43 Pavel Machek <pavel@denx.de>:
>
> Hi!
>
> I see test failure with current 4.19-cip kernel:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/113826697
>
> I believe there's something wrong with the x86_siemens board (rather
> then real problem in code), but I guess someone should double check.
>
> Thanks and best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev



-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
