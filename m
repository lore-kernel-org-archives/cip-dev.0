From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 10 Jul 2019 23:47:33 +0000
Subject: [cip-dev] About CIP kernel maintenance policy for new hardware
 support backporting
In-Reply-To: <CACbBqgU4zFV5U48cxjfv+xho2ed1j74qP5S3zhmQHt=m60tk3A@mail.gmail.com>
References: <CADPJy8X1=bmekKrM+kAWYSsNQ=dbNgszD2K-aZ2JdH4NYGW4jQ@mail.gmail.com>
	<CACbBqgU4zFV5U48cxjfv+xho2ed1j74qP5S3zhmQHt=m60tk3A@mail.gmail.com>
Message-ID: <OSBPR01MB41845C469EB7F604B0B1908192F00@OSBPR01MB4184.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,


> Thanks for pointed out.
> You can find the following sentence on the page. 
> > an SLTS branch may include larger changes to support new hardware, to bridge the gap between SLTS branches.
> 
> I think we need to write much clear to mention what kind of patches we can accept to CIP SLTS tree and how to approve(?) it by CIP.

Agree.

We think that we need to add the following sentences.
---
We do not apply patches that have not been applied to upstream
 (Linus tree:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git).
If you want to add new features or hardware, they need to be applied into upstream.
Also, you may not be able to easily apply the patches on Upstream. In such a case, 
you need to describe in the commit message of patch what modifications have been made
from the original patch.
---

In addition to these, we may need to describe the supported hardware (CPU, boards) and
test environment as well.

Best regards,
  Nobuhiro

From: Yoshitake Kobayashi [mailto:yoshitake.kobayashi at gmail.com] 
Sent: Wednesday, July 10, 2019 9:56 PM
To: hiraku.toyooka at cybertrust.co.jp
Cc: cip-dev at lists.cip-project.org; pavel at denx.de; iwamatsu nobuhiro(?? ?? ????????) <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] About CIP kernel maintenance policy for new hardware support backporting

Hi,

Thanks for pointed out.
You can find the following sentence on the page.?
> an SLTS branch may include larger changes to support new hardware, to bridge the gap between SLTS branches.

I think we need to write much clear to mention what kind of patches we can accept to CIP SLTS tree and how to approve(?) it by CIP.

Best regards,
Yoshi



2019?7?10?(?) 15:42 <hiraku.toyooka@cybertrust.co.jp>:
Hello,

I have a question about CIP kernel maintenance policy.
Can CIP kernel accept backport patches for new hardware support (not
only fixes)?

I read the following document and it seems to describe only acceptable fixes.
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance

On the other hand, Current linux-4.19.y-cip branch accepts some hardware
support patches such as RZ/G2E(r8a774c0) from upstream.
So I wonder if some policy about new hardware support exists.

-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
