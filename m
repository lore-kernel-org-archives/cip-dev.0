From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 18 Jun 2019 14:00:47 +0100
Subject: [cip-dev] [cip-kernel-sec 1/2] remotes: automatically add
 remotes from configuration file
In-Reply-To: <TY2PR01MB33233462A88FCD3B578192EDD0EA0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
References: <20190617052127.9571-1-daniel.sangorrin@toshiba.co.jp>
	<1560804887.21054.33.camel@codethink.co.uk>
	<TY2PR01MB33233462A88FCD3B578192EDD0EA0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <1560862847.21054.34.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2019-06-18 at 03:54 +0000, daniel.sangorrin at toshiba.co.jp wrote:
> > > > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > On Mon, 2019-06-17 at 14:21 +0900, Daniel Sangorrin wrote:
> > > Currently the user is required to create its own remotes by
> > > hand. This should not be necessary, because the information
> > > is already collected in conf/remotes.yml. For that reason,
> > > if we detect that any remote has not been added to the
> > > local repo then we will add those.
> > 
> > I'm not yet convinced this is a good idea.
> 
> I sent a new patch that takes a different approach. The new patch will
> only check that the necessary remotes are there. I also prepared a
> new separate script, for new users to prepare the local repository.
> 
> > After this change, we would still be assuming that there is a kernel
> > repository or working tree next to kernel-config.??If we wanted to be
> > really helpful we could create a new repository if it's not there.
> 
> I didn't understand the kernel-config thing. Maybe I am missing something important.
[...]

Sorry, I meant "next to kernel-sec".

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
