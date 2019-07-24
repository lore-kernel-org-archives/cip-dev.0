From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Wed, 24 Jul 2019 15:00:46 +0200
Subject: [cip-dev] [ANNOUNCE] v4.19.50-cip3-rt2
In-Reply-To: <20190724115306.GA26706@amd>
References: <20190723124015.GA13044@amd>
	<34180972-ec78-ec39-d191-297e2029c3f0@siemens.com>
	<20190723210608.GA23154@amd>
	<CAEss1EKQ_6SWV+Z5aOCkdrtDGGXOhN_ASfDs6Zf1UcjJm5mX0w@mail.gmail.com>
	<20190724115306.GA26706@amd>
Message-ID: <CAEss1EKViv4UZ2gUh6h9EPHRvEG3xEeVOK65xoVEAhd5TDHYSg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> No problem. You should be able to use same .config
> with the new kernel...

U R targeting 4.19.50-cip3-rt2... I do agree 100%, but I have some
problems to do rt-tests (connecting BBB target to my VM).

Please, stay tuned. I'll resolve these problems ASAP (if ?, then Ill
publish the results) . Then I need to leave it for the time been.

Zoran
_______

On Wed, Jul 24, 2019 at 1:53 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > I finally was able to make the viable .config... For the previous
> > rt-kernel for BBB.
> >
> > root at beaglebone:~# uname -a
> > Linux beaglebone 4.19.13-cip1-rt1 #1 PREEMPT RT Tue Jul 23 12:18:18
> > GMT 2019 armv7l GNU/Linux
> >
> > It was very tough and rough... But I have it! Now I need to abandon
> > this effort, since I have another immediate things to do!
>
> No problem. You should be able to use same .config with the new
> kernel...
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
