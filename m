From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 09 Jan 2018 21:05:37 +0000
Subject: [cip-dev] [ANNOUNCE] Linux 4.4.15-cip15-rt10
In-Reply-To: <20180108105621.osnfazlumesxkwv3@linutronix.de>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
	<20180108093350.lxjocaxlvrmjwpav@linutronix.de>
	<94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
	<20180108105621.osnfazlumesxkwv3@linutronix.de>
Message-ID: <1515531937.12097.1.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2018-01-08 at 11:56 +0100, Sebastian Andrzej Siewior wrote:
> On 2018-01-08 11:13:12 [+0100], Daniel Wagner wrote:
> > Hi Sebastian,
> 
> Hi Daniel,
> 
> > On 01/08/2018 10:33 AM, Sebastian Andrzej Siewior wrote:
> > > On 2018-01-02 12:56:11 [+0100], Daniel Wagner wrote:
> > > > The release is based on the Linux 4.4.75-rt88 version. That is I
> > > > applied the -rt88 patch on the 4.4.75-cip6 kernel and merged in all
> > > > CIP releases.
> > > 
> > > what is cip6?
> > 
> > CIP stands for Civil Infrastructure Platform [1]. Ben Hutchings maintains
> > the 4.4.x-cip kernel tree which is a super long stable tree [2].
> 
> So 4.4.x is maintained until Feb, 2022. I assumed that `cip' will take
> over / help Greg with the v4.4 tree and won't include its "own" things.

The 4.4-cip branch is not a regular stable branch.  It includes some
backported hardware enablement and other minor features that aren't
suitable for stable.  I am helping with review for 4.4-stable and
regularly merge it into 4.4-cip, but it's *not* planned for CIP to take
over maintenance of stable branches.  After EOL for 4.4-stable, 4.4-cip 
will get fixes for only the kernel components that CIP members use.

> > > > ? https://ci-rt.linutronix.de/RT-Test/kbuild.jsp?id=112
> > > > 
> > > > Some of the builds are failing (allmodconfig), though it
> > > > doesn't look cip-rt specific, eg:
> > > > 
> > > > > > > > ????kernel/utilities/compiletest-runner at 2/build/../include/linux/compiler.h:484 call to ?__compiletime_assert_150? declared with attribute error: BUILD_BUG_ON failed: hw_flag_names[NUM_IEEE80211_HW_FLAGS] != (void *)0x1
> > > > 
> > > > Not sure how to handle those. IIRC, we don't support allmodconfig.
> > > 
> > > yes but adding
> > > ? 68920c973254 ("net/mac80211/debugfs.c: prevent build failure with
> > > ? CONFIG_UBSAN=y")
> > > 
> > > could solve the issue.
> > 
> > Okay, I just don't know if Ben wants to add the patch to his tree though.
> 
> If the patch solves the issue then please forward the patch upstream.
> The "normal" v4.4 stable tree is affected by this, too.

4.4-stable doesn't have UBSAN.  Are some other configurations (or
compiler versions) where this code fails to build?  (I'm a bit
surprised that it ever compiled!)

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
