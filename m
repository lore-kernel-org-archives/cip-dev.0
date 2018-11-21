From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 21 Nov 2018 09:22:03 +0900
Subject: [cip-dev] FW: [Lava-users] Git authentication
In-Reply-To: <TYAPR01MB228546EDFD91988000F7E8B4B7D90@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <CAFzu0rb=_FvcLuookQyUU7Lv6xrp10Mhzbs+EsXbwZpH0fyo4g@mail.gmail.com>	<CAJrz+7L86+dWGESRHFOw4JUuKnVOp=YQDmrDuvqR4X44OsRDqw@mail.gmail.com>
	<TYAPR01MB228546EDFD91988000F7E8B4B7D90@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <005c01d48130$3a1f9a70$ae5ecf50$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Good to know, thank you Chris.

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> <cip-dev-bounces@lists.cip-project.org> On Behalf Of Chris Paterson
> Sent: Tuesday, November 20, 2018 8:54 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] FW: [Lava-users] Git authentication
> 
> Hello all,
> 
> It was asked last week about if it is possible to keep jobs secret in the CIP LAVA test
> setup.
> 
> Test results/definitions can indeed be kept private, either on an individual or group
> bases.
> https://lava.ciplatform.org/static/docs/v2/glossary.html#term-visibility
> 
> If a test job is kept private it is also possible to share 'secret' information with the
> board. For example, a private git repository.
> https://lava.ciplatform.org/static/docs/v2/publishing-artifacts.html?highlight=sec
> rets
> 
> Please see the mail below for more information.
> 
> Kind regards, Chris
> 
> -----Original Message-----
> From: Lava-users <lava-users-bounces@lists.lavasoftware.org> On Behalf Of
> Milosz Wasilewski
> Sent: 20 November 2018 10:46
> To: axel.lebourhis at linaro.org
> Cc: lava-users at lists.lavasoftware.org
> Subject: Re: [Lava-users] Git authentication
> 
> On Tue, 20 Nov 2018 at 10:42, Axel Lebourhis <axel.lebourhis@linaro.org> wrote:
> >
> > Hi everyone,
> >
> > Is it possible to handle git authentication in a test job ?
> > I need LAVA to clone a repo that can't be set to public,
> > and obviously it won't work because of the authentication step.
> > So is it possible to specify a password or a token ?
> 
> You can use 'secrets' section in the job definition. Docs here:
> https://master.lavasoftware.org/static/docs/v2/publishing-artifacts.html?highligh
> t=secrets
> 
> It might be also a good idea to limit access to the job to user or
> group so the password doesn't leak. It has to be plain text
> unfortunately.
> 
> milosz
> 
> _______________________________________________
> Lava-users mailing list
> Lava-users at lists.lavasoftware.org
> https://lists.lavasoftware.org/mailman/listinfo/lava-users
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
