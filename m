From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Thu, 19 Apr 2018 12:08:52 +0200
Subject: [cip-dev] Important: planned movement of the cip-kernel repo on
	Gitlab: Thursday 19th April 10:00 UTC
In-Reply-To: <CAEss1E+PfWHrGtfzp_cz3f0HGuJ8_Jv2MJzC3Ajc+vuxDV=oiw@mail.gmail.com>
References: <2728424.ub8oesVq9r@linux-if6s> <2715410.MnXGQhdvXK@linux-if6s>
	<CAEss1E+PfWHrGtfzp_cz3f0HGuJ8_Jv2MJzC3Ajc+vuxDV=oiw@mail.gmail.com>
Message-ID: <1871248.M76jf90Ws8@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Zoran

On Thursday, 19 April 2018 12:03:46 CEST Zoran S wrote:
> Here, I would like to propose the same to be replicated on GitHub.
> 
> Personally, I do like much more GitHub... But this is me and my
> wishes, only! ;-)

We use gitlab based on a TSC (Technical Steering Committee) decision.

> 
> Zoran
> 
> On Thu, Apr 19, 2018 at 10:51 AM, Agust?n Benito Bethencourt
> 
> <agustin.benito@codethink.co.uk> wrote:
> > Hi,
> > 
> > On Thursday, 12 April 2018 17:37:41 CEST Agust?n Benito Bethencourt wrote:
> >> Dear CIP lovers,
> >> 
> >> this week Ben H. and I agreed that we need a new repo to store the
> >> current
> >> kernel-configs provided by Members. Since we already have several repos
> >> related with the kernel, the right thing to do is to create a sub-project
> >> and store them there, so we decrease entropy.
> >> 
> >> The new sub-project for CIP kernel related repositories is: https://
> >> gitlab.com/cip-project/cip-kernel
> >> 
> >> Moving the CIP kernel repo to this new sub-project might affect users
> >> that
> >> are pointing to it. The planned movement date is:
> >> 
> >> * Thursday 19th April 2018 at 10:00 UTC.
> > 
> > Reminder: this will take place later today.
> > 
> >> In case you can automate the change, here are the links you need to have
> >> in
> >> consideration:
> >> * The current repo URL is:  https://gitlab.com/cip-project/linux-cip
> >> * The new URL will be:
> >> https://gitlab.com/cip-project/cip-kernel/linux-cip
> >> 
> >> Please plan accordingly.
> >> 
> >> I have no previous experience moving such big repos on gitlab.com so
> >> expect
> >> some downtine. In the worst scenario, please remember that you can point
> >> to
> >> Ben H. repo:
> >> git://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git
> >> 
> >> The reasons why we do not copy the repo into a new location and then
> >> deprecate the old one, instead of going for a hard/hot move, are storage
> >> limitations and failure rate on Gitlab when mirroring such big repos.
> >> 
> >> Best Regards
> > 
> > --
> > Agust?n Benito Bethencourt
> > Principal Consultant
> > Codethink Ltd
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev


-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
