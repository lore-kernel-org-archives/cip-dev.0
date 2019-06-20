From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 20 Jun 2019 05:54:25 +0000
Subject: [cip-dev] [cip-kernel-sec 1/3] remotes: check that remotes exist
In-Reply-To: <1560870435.21054.38.camel@codethink.co.uk>
References: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
	<20190618024025.8274-2-daniel.sangorrin@toshiba.co.jp>
	<1560870435.21054.38.camel@codethink.co.uk>
Message-ID: <TY2PR01MB3323C21364ABEEB897992805D0E40@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> -----Original Message-----
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Sent: Wednesday, June 19, 2019 12:07 AM
> To: sangorrin daniel(????? ???? ????????) <daniel.sangorrin@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-kernel-sec 1/3] remotes: check that remotes exist
> 
> 
> 
> > -----Original Message-----
> > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > Sent: Wednesday, June 19, 2019 12:07 AM
> > To: sangorrin daniel(????? ???? ????????) <daniel.sangorrin@toshiba.co.jp>
> > Cc: cip-dev at lists.cip-project.org
> > Subject: Re: [cip-kernel-sec 1/3] remotes: check that remotes exist
> >
> > This mostly looks fine, except:
> >
> > On Tue, 2019-06-18 at 11:40 +0900, Daniel Sangorrin wrote:
> > [...]
> > > --- /dev/null
> > > +++ b/scripts/prepare_remotes.py
> > [...]
> > > +def main(git_repo, remotes, debug=False):
> > > +????kernel_sec.branch.check_git_repo(git_repo, remotes, create=True)
> >
> > The debug flag doesn't have any effect...
> >
> > [...]
> > > +????parser.add_argument('--debug',
> > > +????????????????????????dest='debug', action='store_true',
> > > +????????????????????????help='enable debugging output')
> > [...]
> >
> > ...so neither does the --debug option.
> >
> > I think you can remove them both.

Thanks.
I have sent you a 2nd version of the 3 patch series.

Kind regards,
Daniel


> >
> > Ben.
> >
> > --
> > Ben Hutchings, Software Developer                ?        Codethink Ltd
> > https://www.codethink.co.uk/                 Dale House, 35 Dale Street
> >                                      Manchester, M1 2HF, United Kingdom
