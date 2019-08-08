From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Fri, 9 Aug 2019 01:38:01 +0900
Subject: [cip-dev] Testing CIP kernel with Debian gcc
In-Reply-To: <TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB4286F48F657C60E5BBF5341DE1D70@TYAPR01MB4286.jpnprd01.prod.outlook.com>
	<TYAPR01MB228561299852241F36E8328BB7D70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <CABMQnV+s7TJOfM==wjt-8A2+9KYopV6wbUTA-dTakZMv8osGkQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

2019?8?8?(?) 21:05 Chris Paterson <Chris.Paterson2@renesas.com>:
>
> Hello Kazu-san,
>
> > From: kazuhiro3.hayashi at toshiba.co.jp <kazuhiro3.hayashi@toshiba.co.jp>
> > Sent: 08 August 2019 11:48
> >
> > Hello Chris,
> >
> > I would like to put this topic from IRC in cip-dev as well :-)
> >
> > My current opinion is:
> > > at least, CIP will support the following version combinations:
> > > 4.4 + stretch, 4.19 + stretch, 4.19 + buster
> > > So, the above kernel versions should be tested with gcc of each Debian
> > version
> >
> > > Will this testing happen as part of cip-core testing?
> > > Or do I need to build each Kernel config with multiple GCC versions?
> > I think that it takes much time to test all combinations
> > of kernel(2) x configs(30?) x gcc(2) in the current kernel testing.
>
> Indeed it would.
> Although we could of course throw money at the problem to make it quicker if there was really a need.
>
> >
> > GCC versions in Debian 9/10
> > stretch: https://packages.debian.org/stretch/gcc (6.3.0-*)
> > buster: https://packages.debian.org/buster/gcc (8.3.0-*)
>
> And jessie: https://packages.debian.org/jessie/gcc (4.9.2-*) ?
>
> >
> > Here is my idea about how to test them:
> >
> > * In the kernel testing,
> >   use gcc 6.3(Debian 9) for kernel 4.4, and
> >   use gcc 8.3(Debian 10) for kernel 4.19
>
> I see no problem with this, although it would be good to get input from the Kernel maintainers.
>
> Do Debian make any changes/fixes in their gcc package?
>
> The packages provided in the links above are presumably for compiling in the native system.
> Does Debian provide suitable packages for cross-compiling?
>
> For example I'm currently using the packages provided on kernel.org [0] which cover pretty much every build/target combination.
> But there is nothing for v6.3 or v8.3
>
> [0] https://cdn.kernel.org/pub/tools/crosstool/files/bin
>
> Of course I could just build all the cross-compilers from source when I create the build container...

If we use Debian, we can use cross toolchain packages.
But this depends on the distribution. buster provides a cross-tool
chain for gcc-8 but not gcc-6.
  - https://tracker.debian.org/pkg/gcc-8-cross
  - https://tracker.debian.org/pkg/gcc-6-cross

Best regards,
  Nobuhiro

--
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
