From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 16 Nov 2018 15:16:31 +0900
Subject: [cip-dev] List of patches that failed to apply to 4.4-stable
In-Reply-To: <CAFk6z8N7i2zQJhxSax3DNYPRg5piVMOzzbS9u=20hx5yY8z4vg@mail.gmail.com>
References: <002501d47a68$32e653d0$98b2fb70$@toshiba.co.jp>
	<CAFk6z8N7i2zQJhxSax3DNYPRg5piVMOzzbS9u=20hx5yY8z4vg@mail.gmail.com>
Message-ID: <000901d47d73$eadf22b0$c09d6810$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

To kernel team,

@SZLin: thanks for creating a page on the wiki just for that.

Yesterday, I checked the patches in my "failed to apply to 4.4-stable" list against the actual git repository using a short python script.
It turns out that some of the patches in the "to apply" list were already there applied.

I have updated our wiki page accordingly
https://wiki.linuxfoundation.org/civilinfrastructureplatform/linux-4.4-failed-patches

For the curious minds, you can find my (dirty) script attached to this e-mail.

Thanks,
Daniel



> -----Original Message-----
> From: SZ Lin (???) <sz.lin@moxa.com>
> Sent: Monday, November 12, 2018 8:04 PM
> To: daniel.sangorrin at toshiba.co.jp
> Cc: cip dev <cip-dev@lists.cip-project.org>
> Subject: Re: [cip-dev] List of patches that failed to apply to 4.4-stable
> 
> Hi Daniel,
> 
> Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp> ? 2018?11?12? ?? ?
> ?5:15???
> >
> > To: CIP Kernel team
> >
> > I have prepared a list of patches that failed to apply to 4.4-stable in the past. The
> list is based on the corresponding e-mails sent to the stable mailing list (since I
> subscribed, there may be more failed patches before my subscription). We can
> discuss today at the TSC meeting, and on Thursday during the IRC meeting whether
> we want to backport any of them or not.
> 
> I've created a draft wiki page for it, feel free to modify the format.
> 
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/linux-4.4-failed-patche
> s
> 
> SZ
> 
> > [Note] I still have to check if some of them were applied by any other means.
> >
> > Best regards,
> > Daniel
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: classify_failed_patches.py
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181116/1c747e0d/attachment.ksh>
