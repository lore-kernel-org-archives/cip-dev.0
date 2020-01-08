From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 8 Jan 2020 12:36:46 +0000
Subject: [cip-dev] Force pushed linux-4.19.y and linux-4.19.y-rebase
 branches, and v4.19.88-cip16-rebase, v4.19.91-cip17-rebase,
 v4.19.91-cip17 tags (RE: Difference between
 v4.19.88-cip16-rebase..v4.19.88-cip16 was Re: Getting older -cip-rebase
 versions)
Message-ID: <OSAPR01MB36674712DA20D725552ED6B1923E0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

> > I'm trying to prepare -cip-rt release, and I ran into differences I
> > could not explain. After some head scratching, I realized they are in
> > -cip,
> > too:
> >
> > diff v4.19.88-cip16-rebase..v4.19.88-cip16.
> 
> That's my bad.
> I missed to cherry-pick b03f03030171c862ff1f6968e5413e5d8c4f651a and
> fixing merge conflict on -rebase branch.
> 
> >
> > One more line of difference exists in newer version: git diff
> > v4.19.91-cip17-rebase..v4.19.91-cip17
> >
> 
> This is the same.
> I missed to fixing merge conflict on -cip branch.
> 
> > Any idea what is going on there? Which version is ok and which should
> > be adjusted?
> 
> I already fixed these issue on local repository.
> Since first issue is on -rebase branch, I don't think it will have a big
> impact.
> Second issue is on cip branch, I will need to do force push and re-tag.
> 
> Also, to avoid the same problem, I will add a step to check the differences
> when rebase and merge.
> 

I just force-pushed v4.19.88-cip16-rebase, v4.19.91-cip17-rebase, v4.19.91-cip17 tags,
linux-4.19.y and linux-4.19.y-rebase branches to reflect the fix for these issues.
And I checked 4.4.y-cip, but couldn't find any problems.

Sorry, please apply the updates to your local repository.

Best regards,
   Nobuhiro
