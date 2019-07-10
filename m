From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Wed, 10 Jul 2019 01:28:39 +0000
Subject: [cip-dev] [cip-kernel-sec 3/6] report_affected: fix code when
 branches are specified
In-Reply-To: <1561752543.21054.80.camel@codethink.co.uk>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
	<20190625032636.10694-4-daniel.sangorrin@toshiba.co.jp>
	<1561752543.21054.80.camel@codethink.co.uk>
Message-ID: <OSBPR01MB3077BA36398A4378C784B85ED0F00@OSBPR01MB3077.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> On Tue, 2019-06-25 at 12:26 +0900, Daniel Sangorrin wrote:
> > The previous code could not handle branches with names
> > other than stable branch names. For example, passing
> > "linux-4.4.y-cip" as a branch would return an error.
> [...]
> > --- a/scripts/report_affected.py
> > +++ b/scripts/report_affected.py
> > @@ -18,14 +18,17 @@ import kernel_sec.version
> >
> > ?def main(git_repo, remotes,
> > ??????????only_fixed_upstream, include_ignored, *branch_names):
> > +????live_branches = kernel_sec.branch.get_live_branches()
> > ?????if branch_names:
> > -????????# Support stable release strings as shorthand for stable branches
> > -????????branches = [kernel_sec.branch.get_base_ver_stable_branch(name)
> > -????????????????????if name[0].isdigit()
> > -????????????????????else kernel_sec.branch.get_stable_branch(name)
> > -????????????????????for name in branch_names]
> > +????????branches = []
> > +????????for branch in live_branches:
> > +????????????for name in branch_names:
> > +????????????????if name[0].isdigit():
> > +????????????????????name = 'linux-%s.y' % name
> > +????????????????if branch['short_name'] == name:
> > +????????????????????branches.append(branch)
> [...]
> 
> This results in quietly skipping arguments that don't match any known
> branch.  The current behaviour (failing with a TypeError) is not good
> but I think failing quietly is worse.

I was taking the approach of "doing as much as possible". Something like what a recovery tool does on a disk with broken sectors: if a broken sector is found skip it.

In the new version, the script will raise an argument error if it cannot find the corresponding stable branch.

Thanks,
Daniel


> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                ?        Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
