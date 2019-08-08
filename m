From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 8 Aug 2019 12:05:09 +0000
Subject: [cip-dev] Testing CIP kernel with Debian gcc
In-Reply-To: <TYAPR01MB4286F48F657C60E5BBF5341DE1D70@TYAPR01MB4286.jpnprd01.prod.outlook.com>
References: <TYAPR01MB4286F48F657C60E5BBF5341DE1D70@TYAPR01MB4286.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Kazu-san,

> From: kazuhiro3.hayashi at toshiba.co.jp <kazuhiro3.hayashi@toshiba.co.jp>
> Sent: 08 August 2019 11:48
> 
> Hello Chris,
> 
> I would like to put this topic from IRC in cip-dev as well :-)
> 
> My current opinion is:
> > at least, CIP will support the following version combinations:
> > 4.4 + stretch, 4.19 + stretch, 4.19 + buster
> > So, the above kernel versions should be tested with gcc of each Debian
> version
> 
> > Will this testing happen as part of cip-core testing?
> > Or do I need to build each Kernel config with multiple GCC versions?
> I think that it takes much time to test all combinations
> of kernel(2) x configs(30?) x gcc(2) in the current kernel testing.

Indeed it would.
Although we could of course throw money at the problem to make it quicker if there was really a need.

> 
> GCC versions in Debian 9/10
> stretch: https://packages.debian.org/stretch/gcc (6.3.0-*)
> buster: https://packages.debian.org/buster/gcc (8.3.0-*)

And jessie: https://packages.debian.org/jessie/gcc (4.9.2-*) ?

> 
> Here is my idea about how to test them:
> 
> * In the kernel testing,
>   use gcc 6.3(Debian 9) for kernel 4.4, and
>   use gcc 8.3(Debian 10) for kernel 4.19

I see no problem with this, although it would be good to get input from the Kernel maintainers.

Do Debian make any changes/fixes in their gcc package?

The packages provided in the links above are presumably for compiling in the native system.
Does Debian provide suitable packages for cross-compiling?

For example I'm currently using the packages provided on kernel.org [0] which cover pretty much every build/target combination.
But there is nothing for v6.3 or v8.3

[0] https://cdn.kernel.org/pub/tools/crosstool/files/bin

Of course I could just build all the cross-compilers from source when I create the build container...

> 
> * In CIP core testing,
>   do test the three combinations above for
>   at least one CIP reference hardware [*]
> 
> [*] Regarding CIP core testing, we need to create test matrix
>     (kernel x Debian version x Reference hardware)
>     then decide which conditions should be tested considering the overwraps.
>     How many devices are actually tested depends on this matrix.

This would be useful.

Kind regards, Chris

> 
> What do you think?
> 
> Best regards,
> Kazu
