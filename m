From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 8 Jan 2020 04:02:40 +0000
Subject: [cip-dev] Difference between
 v4.19.88-cip16-rebase..v4.19.88-cip16 was Re: Getting older -cip-rebase
 versions
In-Reply-To: <20200107120619.GB1234@duo.ucw.cz>
References: <20191229172557.GA18039@duo.ucw.cz>
 <OSAPR01MB3667987C41E9C68D6D0F5D6E923C0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <20200107120619.GB1234@duo.ucw.cz>
Message-ID: <OSAPR01MB3667464CB9CF546447FDEEE9923E0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Paval,

Thanks for your email!

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at ucw.cz]
> Sent: Tuesday, January 7, 2020 9:06 PM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org
> Subject: Difference between v4.19.88-cip16-rebase..v4.19.88-cip16 was
> Re: [cip-dev] Getting older -cip-rebase versions
> 
> Hi!
> 
> > > Is there way to get to that version? Would it be possible to keep
> > > those tags in future?
> >
> > Please use 'git fetch --tags' .
> > With git normal commands, you can only get tags that are reachable from
> the branch.
> > In this case, execute as above.
> 
> Thanks a lot for the pointer.
> 
> I'm trying to prepare -cip-rt release, and I ran into differences I could
> not explain. After some head scratching, I realized they are in -cip,
> too:
> 
> diff v4.19.88-cip16-rebase..v4.19.88-cip16.

That's my bad.
I missed to cherry-pick b03f03030171c862ff1f6968e5413e5d8c4f651a and 
fixing merge conflict on -rebase branch.

> 
> One more line of difference exists in newer version: git diff
> v4.19.91-cip17-rebase..v4.19.91-cip17
> 

This is the same.
I missed to fixing merge conflict on -cip branch.

> Any idea what is going on there? Which version is ok and which should
> be adjusted?

I already fixed these issue on local repository.
Since first issue is on -rebase branch, I don't think it will have a big impact.
Second issue is on cip branch, I will need to do force push and re-tag.

Also, to avoid the same problem, I will add a step to check the differences when rebase and merge.

> 
> Best regards,
> 
> 	Pavel
> 

Best regards,
  Nobuhiro
