From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 18 Jun 2019 15:42:53 +0100
Subject: [cip-dev] [cip-kernel-sec 2/2] remotes: call
	_get_configured_remotes
In-Reply-To: <TY2PR01MB332350C9AD09DFF909EFF10BD0EB0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
References: <20190617022039.7197-1-daniel.sangorrin@toshiba.co.jp>
	<20190617022039.7197-2-daniel.sangorrin@toshiba.co.jp>
	<1560802573.21054.30.camel@codethink.co.uk>
	<TY2PR01MB332350C9AD09DFF909EFF10BD0EB0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <1560868973.21054.36.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2019-06-17 at 23:48 +0000, daniel.sangorrin at toshiba.co.jp
wrote:
> > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > 
> > On Mon, 2019-06-17 at 11:20 +0900, Daniel Sangorrin wrote:
> > > This is probably a copy&paste mistake that had no effect
> > > because the contents of _get_configured_remotes and
> > > _get_configured_branches is the same.
> > > 
> > > Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> > 
> > Maybe it would make more sense to merge the two functions instead?
> 
> I thought about that but in the future you may want to add some code
> that is specific to one of them. If you want me to consolidate them,
> what name would you use?

Actually these two functions aren't exactly the same, since the default
return value differs.  In practice that doesn't make a difference at
the moment, but logically it would be wrong to return one or the other.

So I'll apply your original patch.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
