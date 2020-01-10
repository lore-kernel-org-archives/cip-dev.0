From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 10 Jan 2020 18:29:35 +0000
Subject: [cip-dev] Difference between
 v4.19.88-cip16-rebase..v4.19.88-cip16 was Re: Getting older -cip-rebase
 versions
In-Reply-To: <OSAPR01MB3667464CB9CF546447FDEEE9923E0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <20191229172557.GA18039@duo.ucw.cz>
 <OSAPR01MB3667987C41E9C68D6D0F5D6E923C0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <20200107120619.GB1234@duo.ucw.cz>
 <OSAPR01MB3667464CB9CF546447FDEEE9923E0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Message-ID: <1e5e351b5d1811aef41983e78d02296597865f98.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2020-01-08 at 04:02 +0000, nobuhiro1.iwamatsu at toshiba.co.jp wrote:
[...]
> > Any idea what is going on there? Which version is ok and which should
> > be adjusted?
> 
> I already fixed these issue on local repository.
> Since first issue is on -rebase branch, I don't think it will have a big impact.
> Second issue is on cip branch, I will need to do force push and re-tag.
> 
> Also, to avoid the same problem, I will add a step to check the differences when rebase and merge.

Anyone who has pulled the wrong tags already won't see updated tags. 
So at this point I would suggest using new names for the fixed tags
(e.g. -rebase-2).

Maybe it is worthwhile to test in CI for the -rc repository that the
rebased branches match the corresponding non-rebased branches?  (It is
probably not reasonable to require that this is true at other times.)

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
