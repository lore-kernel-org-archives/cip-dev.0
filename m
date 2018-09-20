From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 20 Sep 2018 11:42:44 +0900
Subject: [cip-dev] DebConf trip report
In-Reply-To: <1537363969.3024.234.camel@codethink.co.uk>
References: <1537363969.3024.234.camel@codethink.co.uk>
Message-ID: <000601d4508b$9baab840$d30028c0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Thank you very much for your report, I wish I had been there.
Luckily, everything was videotaped.

[...]
> I said that I did not wish to take on a new branch myself, and that I
> thought having separate maintainers for the two branches would result
> in duplicated effort.  My experience with maintaining two stable
> branches at the same time is that much of the work done on one is
> directly applicable to the other, so it doesn't take nearly twice as
> much work as maintaining a single branch.  So I proposed instead that
> Iwamatsu-san and the other new maintainers should take on both 4.4 and
> the new branch, and I should only act as a mentor.  This was
> provisionally accepted.

That was a very good tip. Most of us were thinking that we would need separate maintainers for each kernel branch, but what you mention makes complete sense.

> Ian Jackson and Sean Whitton talked about a new tool called git-
> debrebase, which implements a new approach to managing patches in
> Debian packages
> <https://debconf18.debconf.org/talks/60-git-debrebase-new-tool-for-managing-d
> ebian-packaging-in-git/>.
> I think this has the potential to close the gap between normal git-
> based development and Debian source packaging, for those trying to do
> both.

This tool looks very interesting.

>From what I see in the link below, and correct me if I'm wrong, you are using quilt to manage the Debian patches for both the normal and the real-time version of the Debian kernel. Do you have any plans to move to git-debrebase?
https://salsa.debian.org/kernel-team/linux/tree/master/debian

Thanks,
Daniel
