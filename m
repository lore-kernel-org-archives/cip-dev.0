From: yoshitake.kobayashi@gmail.com (Yoshitake Kobayashi)
Date: Wed, 10 Jul 2019 21:55:32 +0900
Subject: [cip-dev] About CIP kernel maintenance policy for new hardware
 support backporting
In-Reply-To: <CADPJy8X1=bmekKrM+kAWYSsNQ=dbNgszD2K-aZ2JdH4NYGW4jQ@mail.gmail.com>
References: <CADPJy8X1=bmekKrM+kAWYSsNQ=dbNgszD2K-aZ2JdH4NYGW4jQ@mail.gmail.com>
Message-ID: <CACbBqgU4zFV5U48cxjfv+xho2ed1j74qP5S3zhmQHt=m60tk3A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

Thanks for pointed out.
You can find the following sentence on the page.
> an SLTS branch may include larger changes to support new hardware, to
bridge the gap between SLTS branches.

I think we need to write much clear to mention what kind of patches we can
accept to CIP SLTS tree and how to approve(?) it by CIP.

Best regards,
Yoshi




2019?7?10?(?) 15:42 <hiraku.toyooka@cybertrust.co.jp>:

> Hello,
>
> I have a question about CIP kernel maintenance policy.
> Can CIP kernel accept backport patches for new hardware support (not
> only fixes)?
>
> I read the following document and it seems to describe only acceptable
> fixes.
>
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance
>
> On the other hand, Current linux-4.19.y-cip branch accepts some hardware
> support patches such as RZ/G2E(r8a774c0) from upstream.
> So I wonder if some policy about new hardware support exists.
>
> --
> Hiraku Toyooka
> Cybertrust Japan Co., Ltd.
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190710/071dd506/attachment.html>
