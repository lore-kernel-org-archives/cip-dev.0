From: SZ.Lin@moxa.com (=?iso-2022-jp?B?U1ogTGluICgbJEJOUz5lQ1IbKEIp?=)
Date: Tue, 25 Jun 2019 03:55:26 +0000
Subject: [cip-dev] [RFC/RFT] -cip-rt kernels for review/testing
In-Reply-To: <20190623203704.GA12734@amd>
References: <20190623203704.GA12734@amd>
Message-ID: <HK0PR01MB29798DE214020C6889F9BE4CE2E30@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> From: Pavel Machek <pavel@denx.de> 
> Hi!
> 
> I played a bit with -rt kernels, and here are the results.

I appreciate your effort.

> 
> v4.19.50-rt22-cip3-rebase was reasonably easy to do, as -cip1 was empty.
> v4.4.179-rt181-cip34-rebase was more interesting.
> 
> Trees are at kernel.org:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.
> 4.179-rt181-cip34-rebase
> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.
> 19.50-rt22-cip3-rebase
> 
> Basically untested. Could I ask for reviews and testing?
> 
> I know that full preemption does not work on x86-32. I sent
> "PREEMPT_RT_FULL on x86-32 machine" mail to the lists
> 
> I don't know how to release useful non-rebasing trees. Is someone using
> those?

How about adding these questions into our question list and ask Wagner afterward :-)

SZ

> 
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
