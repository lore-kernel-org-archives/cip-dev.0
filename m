From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 14 Oct 2019 08:08:59 +0000
Subject: [cip-dev] Rethinking .yml files in the repositories was Re:
 [PATCH linux-4.19.y-cip 1/3] gitlab-ci: Split tests into separate jobs
In-Reply-To: <20191014073339.GA22886@amd>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
	<20191014073339.GA22886@amd>
Message-ID: <TYAPR01MB2285DCBC6701E9B25EE13C47B7900@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel, all,

> From: Pavel Machek <pavel@denx.de>
> Sent: 14 October 2019 08:34
>
> Hi!
>
> > This will allow tests to run as soon as the corresponding build job is
> > complete.
> >
> > This will help spread the load on the test infrastructure and save
> > time.
>
> When we agreed to merge .yml files into the git, I was assuming they
> would be kind of static... but apparently that was wrong assumption.
>
> It seems the .yml needs to change as boards are added/removed and as
> our test infrastructure changes.

Yep.

>
> There are complications we did not foresee: these updates are made in
> parallel to -cip and -cip-rt trees. That unfortunately means, that
> when I'm updating -cip-rt tree, each of them tends to show up as a
> conflict. And then, when updating -cip-rt-rebase, I get to solve them
> again.

Yes, this is an issue. Although I guess it's a fairly easy merge, albeit an annoying one.

>
> Which is not fun and it makes history more complex than it should have
> been. Jan already expressed concerns about too much churn.

Agreed, it's not ideal.

>
> So... there was proposal with separate repository for testing. I
> believe we need to explore that.

We can, and I already have a bit with the LTS stable rc testing.

The main problem with using a separate GitLab project to run the CI is that it's very difficult to see in the GitLab CI interface what commit etc. was actually tested.
The GitLab interface only shows the commit tested from the 'CI' project, not the project that was being built.
Please see [0] for an example, compared to a similar run where the CI is run from the same project as the source [1].

[0] https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/88564586
[1] https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/88520104

Some options, I'm sure there will be many more...
1) Stick with the current approach and rely on the maintainer to fix the gitlab-ci patches for RT. Fingers crossed for the next CIP Kernel we won't need a separate RT branch anyway.
Actually, I'm pretty sure I can find a way to modify the gitlab-ci.yml file so the same one can be used for RT and non-RT branches.
This would help with the RT merge issues, but won't help with the churn (although the churn should die down after a while).

2) Use a separate GitLab repository for CI work and use a different front end to view the CI results (e.g. KernelCI).

3) Stop using GitLab entirely and use another external CI setup like Jenkins.

Any thoughts?

Kind regards, Chris
