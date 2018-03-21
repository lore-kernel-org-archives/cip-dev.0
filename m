From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Wed, 21 Mar 2018 09:36:48 +0100
Subject: [cip-dev] [cip-testing] Issue #167 - Build & test iw20gm kernel
 outside of cip-core/bitbake env
In-Reply-To: <1521571858.23626.112.camel@codethink.co.uk>
References: <CAEss1EK8ZXrCrtB4MxvW5FB0aqjzb7s=xyRcq0sSrx8eNrGvrA@mail.gmail.com>
	<1521571858.23626.112.camel@codethink.co.uk>
Message-ID: <CAEss1EJU0z6F9=iRLkOVPEKvc5NTw6-A1qnSM4fb+onD0aT8cQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> When I discussed this with Robert he hadn't yet seen the
> problem so I though it might be cable-dependent. (We are
> sharing the board but have used different Ethernet cables.)

As I see, Robert has also the problems with ETH1000. Please, find Robert's
Lava traces:
https://paste.baserock.org/selefaxabo

> Are you certain that the device tree is loaded successfully?  I don't
> know whether LAVA checks for error messages from u-boot.

Nope. You are correct. In order to do much better analysis, I need to make
iwg20m YOCTO load to work. But this task appeared to be NOT at all easy.

Since I have as host Fedora 27 with latest updates about two weeks ago, I
need to setup/make a Vbox VM of a supported at that time host distribution
(Jethro - EOL Fedora 22).

Zoran
_______

On Tue, Mar 20, 2018 at 7:50 PM, Ben Hutchings <
ben.hutchings@codethink.co.uk> wrote:

> On Thu, 2018-03-15 at 16:52 +0100, Zoran S wrote:
> > Hello to everyone,
> >
> > I did some testing on this issue: 167, which appear to be a show
> > stopper for Renesas iwg20m platform. I did change several times
> > shmobile_defconfig in order to build better CIP 4.4.120 kernel.
> > Unfortunately, every time (4 in total) I failed.
> >
> > Both me (testing CIP 4.4.120) and Robert (testing CIP 4.4.112) have
> > problems with iwg20m ETH1000 port.
>
> That's interesting. I've also sometimes had trouble getting a reliable
> link at 1000 Mbps.  When I discussed this with Robert he hadn't yet seen
> the problem so I though it might be cable-dependent.  (We are sharing the
> board but have used different Ethernet cables.)
>
> When I reconfigured my laptop's Ethernet port to only support 100 Mbps
> (ethtool -s <device> speed 100 duplex full) the link became more
> reliable.
>
> > I am able to progress up to running the "starting kernel" message,
> > then my tests fail (they hang).
> [...]
>
> So u-boot starts the kernel, but you don't get any kernel log messages?
>  Are you certain that the device tree is loaded successfully?  I don't
> know whether LAVA checks for error messages from u-boot.
>
> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180321/8fd73444/attachment.html>
