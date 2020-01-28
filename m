From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 28 Jan 2020 15:14:37 +0000
Subject: [cip-dev] 4.19.99: huge series, some changes in Renesas hardware,
 NFS, big changes in power management, AFS
In-Reply-To: <20200128150438.GA8660@duo.ucw.cz>
References: <20200128150438.GA8660@duo.ucw.cz>
Message-ID: <TYAPR01MB22853E66BB24BB5F8DBB64A7B70A0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,


> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Pavel
> Machek
> Sent: 28 January 2020 15:05
>
> Hi!
>
> 4.19.99 is out, and it is... huge series. It has some some changes in
> Renesas hardware and NFS, big changes in power management on PCs, AFS
> support.

Thanks for the heads up.

It's already been tested in our CI:
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/pipelines/112610333

But it's only doing boot testing on r8a7743-iwg20d-q7, r8a7745-iwg22d-sodimm, Altera-Terasic-Deo-Nano and the x86 devices.
(RZ/G2 boards aren't natively supported in the stable v4.19 Kernel)

Kind regards, Chris

>
> If you are familiar with areas above, you may want to look at the
> series; you may also want to do some additional testing.
>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
