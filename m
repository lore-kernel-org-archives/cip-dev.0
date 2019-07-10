From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Wed, 10 Jul 2019 01:36:42 +0000
Subject: [cip-dev] [cip-kernel-sec 5/6] report_affected: add support for
 reporting on tags
In-Reply-To: <1561754773.21054.86.camel@codethink.co.uk>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
	<20190625032636.10694-6-daniel.sangorrin@toshiba.co.jp>
	<1561754773.21054.86.camel@codethink.co.uk>
Message-ID: <OSBPR01MB3077C550C531A1A3BA97C10BD0F00@OSBPR01MB3077.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> On Tue, 2019-06-25 at 12:26 +0900, Daniel Sangorrin wrote:
> > Reporting on tags is useful for product engineers that
> > have shipped a kernel with a specific tag and need to know
> > which issues affect their product after some time.
> 
> I think this is a really important feature, but I'm not convinced about
> this implementation.

Glad to hear about the importance. Other members also expressed their interest.
 
> > Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> > ---
> > ?scripts/report_affected.py | 60 ++++++++++++++++++++++++++++++++------
> > ?1 file changed, 51 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/report_affected.py b/scripts/report_affected.py
> > index 7557dc8..32e9345 100755
> > --- a/scripts/report_affected.py
> > +++ b/scripts/report_affected.py
> > @@ -9,7 +9,9 @@
> > ?# Report issues affecting each stable branch.
> >
> > ?import argparse
> > +import copy
> > ?import subprocess
> > +import re
> >
> > ?import kernel_sec.branch
> > ?import kernel_sec.issue
> > @@ -23,10 +25,26 @@ def main(git_repo, remotes,
> > ?????????branches = []
> > ?????????for branch in live_branches:
> > ?????????????for name in branch_names:
> > +????????????????# there could be multiple tags for the same branch
> > +????????????????branch_copy = copy.deepcopy(branch)
> 
> This makes a lot of unnecessary copies!

Sorry about that. The new version only makes copies when necessary (one copy per branch name supplied by the user).


> 
> > +????????????????if name[0] == 'v':
> > +????????????????????# a stable tag, e.g. v4.4.92-cip11
> > +????????????????????branch_copy['tag'] = name
> > +????????????????????match = re.match(r'^v(\d+\.\d+).*', name)
> > +????????????????????if not match:
> > +????????????????????????raise ValueError('failed to parse tag %r' % name)
> > +????????????????????if 'cip' in name:
> > +????????????????????????name = 'linux-%s.y-cip' % match.group(1)
> > +????????????????????else:
> > +????????????????????????name = 'linux-%s.y' % match.group(1)
> 
> How about adding regexps for tags to the branch configuration?  Then
> here we could match tags to branches with
> re.matchall(branch['tag_regexp'], name).

OK, I have tried. Let me know if my implementation is what you had in mind.
I used re.match, not re.matchall (maybe you meant re.findall?). Let me know if there is a problem with that.
Tags that are not on a stable branch (e.g. 5.2 is in mainline but not in a stable branch) are ignored at the moment.

> 
> > +????????????????if '/' in name:
> 
> '/' is valid in a branch or tag name, so how about using ':' which is
> not?

Thanks, I had chosen '/' just for aesthetics (the final report uses : before displaying the issues).
Now fixed.

> 
> > +????????????????????# a possibly custom tag, e.g. product-v1
> > +????????????????????branch_copy['tag'] = name.split('/')[1]
> > +????????????????????name = name.split('/')[0]
> 
> It would be more Pythonic to write this as a tuple assginment.

I tried using tuples, but I'm not sure it is pythonic enough.
There is also a "tag = None" that may not be pythonic either.

> 
> > ?????????????????if name[0].isdigit():
> > ?????????????????????name = 'linux-%s.y' % name
> > -????????????????if branch['short_name'] == name:
> > -????????????????????branches.append(branch)
> > +????????????????if branch_copy['short_name'] == name:
> > +????????????????????branches.append(branch_copy)
> > ?????????if not branches:
> > ?????????????msg = "supplied branches didn't match any known branch"
> > ?????????????raise argparse.ArgumentError(None, msg)
> > @@ -40,6 +58,18 @@ def main(git_repo, remotes,
> >
> > ?????c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
> >
> > +????# cache tag commits and set full_name to show the tag
> > +????tag_commits = {}
> > +????for branch in branches:
> > +????????if 'tag' in branch:
> > +????????????start = 'v' + branch['base_ver']
> > +????????????end = branch['tag']
> > +????????????for commit in kernel_sec.branch._get_commits(git_repo, end, start):
> 
> The leading '_' means private, so it shouldn't be called from here.  I
> think it could be made public but it needs a better name, maybe
> 'iter_rev_list' matching the underlying command.

Fixed.

> > +????????????????tag_commits.setdefault(end, []).append(commit)
> [...]
> 
> Suppose I tried to query 'v4.4'; then I think we get start == end ==
> 'v4.4' and this loop doesn't execute at all.  tag_commits['v4.4'] won't
> be defined at all, and the reporting loop will crash.

Good catch, I should have tested the edge cases sorry.

> So this could be simply:
> 
>                tag_commits[end] = list(
>                    kernel_sec.branch.iter_rev_list(git_repo, end, start))
> 
> But I think the collection type should also be changed from list to
> set, so that tests for membership will be fast.

Thanks, I finally used "set" although I didn't see big performance changes.

Thanks,
Daniel

> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                ?        Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
