From: pavel@denx.de (Pavel Machek)
Date: Fri, 26 Jul 2019 23:05:12 +0200
Subject: [cip-dev] [ANNOUNCE] v4.19.50-cip3-rt2
In-Reply-To: <CAEss1ELuRZRNNtOtESN9GTxNvBpp9BzzaJT-HZawRChuLvrYXg@mail.gmail.com>
References: <20190723124015.GA13044@amd>
	<34180972-ec78-ec39-d191-297e2029c3f0@siemens.com>
	<20190723210608.GA23154@amd>
	<CAEss1EKQ_6SWV+Z5aOCkdrtDGGXOhN_ASfDs6Zf1UcjJm5mX0w@mail.gmail.com>
	<20190724115306.GA26706@amd>
	<CAEss1EKViv4UZ2gUh6h9EPHRvEG3xEeVOK65xoVEAhd5TDHYSg@mail.gmail.com>
	<CAEss1ELuRZRNNtOtESN9GTxNvBpp9BzzaJT-HZawRChuLvrYXg@mail.gmail.com>
Message-ID: <20190726210512.GA23760@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2019-07-24 18:06:46, Zoran S wrote:
> (limitations): I could NOT connect with ETH to target (something is
> wrongly set with my local.conf for YOCTO rootfs)...
> 
> Here is my approximate recipe for rootfs I am using for the test
> (initramfs) for your inspection (it is thud, local.conf moved to
> warrior):
> https://github.com/ZoranStojsavljevic/bbb-yocto/blob/master/bbb-releases/bbb-warrior/local.conf
> 
> More or/and less, here are results after approximately 63 minutes of
> running rt-tests:
> 
> root at beaglebone:~# uname -a
> Linux beaglebone 4.19.13-cip1-rt1 #1 PREEMPT RT Tue Jul 23 12:18:18
> GMT 2019 armv7l GNU/Linux
> _______
> policy: fifo: loadavg: 291.28 287.63 267.78 21/486 30014
> policy: fifo: loadavg: 186.97 215.90 243.41 5/458 22788
> policy: fifo: loadavg: 248.16 243.95 244.63 194/486 8800
> policy: fifo: loadavg: 283.55 240.50 243.74 9/318 2383
> T: 0 (13903) P:80 I:1000 C:3942593 Min:     19 Act:   52 Avg:   45 Max:      93
> T: 0 (13903) P:80 I:1000 C:3785664 Min:     19 Act:   44 Avg:   45 Max:      935
> T: 0 (13903) P:80 I:1000 C:3716107 Min:     19 Act:   60 Avg:   45 Max:      936
> policy: fifo: loadavg: 222.11 176.72 90.66 5/213 21249
> T: 0 (13903) P:80 I:1000 C:2213895 Min:     19 Act:   38 Avg:   46 Max:      905
> T: 0 (13903) P:80 I:1000 C: 181403 Min:     21 Act:   49 Avg:   45 Max:      90
> T: 0 (13903) P:80 I:1000 C: 181320 Min:     21 Act:   29 Avg:   45 Max:      90

Your log is corrupted, see?

If it was real, it would be

Max: 905
Max:  90

But you have

Max:  905
Max:  90

Notice the whitespace.

> MIN 19 ns, MAX 936 ns (3x over 900 ns)... I would be really concerned
> about MAX over > 900 ns!

It is usec, not nsec, AFAICT.

Best regards,
								Pavel

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190726/fc1ed8b0/attachment.sig>
