From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 20 Nov 2018 11:53:46 +0000
Subject: [cip-dev] FW: [Lava-users] Git authentication
In-Reply-To: <CAJrz+7L86+dWGESRHFOw4JUuKnVOp=YQDmrDuvqR4X44OsRDqw@mail.gmail.com>
References: <CAFzu0rb=_FvcLuookQyUU7Lv6xrp10Mhzbs+EsXbwZpH0fyo4g@mail.gmail.com>
	<CAJrz+7L86+dWGESRHFOw4JUuKnVOp=YQDmrDuvqR4X44OsRDqw@mail.gmail.com>
Message-ID: <TYAPR01MB228546EDFD91988000F7E8B4B7D90@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

It was asked last week about if it is possible to keep jobs secret in the CIP LAVA test setup.

Test results/definitions can indeed be kept private, either on an individual or group bases.
https://lava.ciplatform.org/static/docs/v2/glossary.html#term-visibility

If a test job is kept private it is also possible to share 'secret' information with the board. For example, a private git repository.
https://lava.ciplatform.org/static/docs/v2/publishing-artifacts.html?highlight=secrets

Please see the mail below for more information.

Kind regards, Chris

-----Original Message-----
From: Lava-users <lava-users-bounces@lists.lavasoftware.org> On Behalf Of Milosz Wasilewski
Sent: 20 November 2018 10:46
To: axel.lebourhis at linaro.org
Cc: lava-users at lists.lavasoftware.org
Subject: Re: [Lava-users] Git authentication

On Tue, 20 Nov 2018 at 10:42, Axel Lebourhis <axel.lebourhis@linaro.org> wrote:
>
> Hi everyone,
>
> Is it possible to handle git authentication in a test job ?
> I need LAVA to clone a repo that can't be set to public,
> and obviously it won't work because of the authentication step.
> So is it possible to specify a password or a token ?

You can use 'secrets' section in the job definition. Docs here:
https://master.lavasoftware.org/static/docs/v2/publishing-artifacts.html?highlight=secrets

It might be also a good idea to limit access to the job to user or
group so the password doesn't leak. It has to be plain text
unfortunately.

milosz

_______________________________________________
Lava-users mailing list
Lava-users at lists.lavasoftware.org
https://lists.lavasoftware.org/mailman/listinfo/lava-users
