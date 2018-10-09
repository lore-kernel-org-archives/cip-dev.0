From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Tue, 9 Oct 2018 15:26:55 +0000
Subject: [cip-dev] Kernel configurations in the CIP project
In-Reply-To: <ff709c8c-27d9-0a50-780b-cfb5bea7c062@siemens.com>
References: <6D182B05-3DE6-4377-9BFA-AF45139C9960@bmw-carit.de>
	<005801d45aa8$51f7b1e0$f5e715a0$@toshiba.co.jp>
	<1538661106.3024.266.camel@codethink.co.uk>
	<20181005041038.GB30868@osadl.at>
	<ff709c8c-27d9-0a50-780b-cfb5bea7c062@siemens.com>
Message-ID: <20181009152655.GA12415@osadl.at>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, Oct 08, 2018 at 02:33:32PM +0200, Jan Kiszka wrote:
> On 05.10.18 06:10, Nicholas Mc Guire wrote:
> >On Thu, Oct 04, 2018 at 02:51:46PM +0100, Ben Hutchings wrote:
> >>On Wed, 2018-10-03 at 08:33 +0900, Daniel Sangorrin wrote:
> >>>Hello Lukas,
> >>>
> >>>>-----Original Message-----
> >>>>From: cip-dev-bounces at lists.cip-project.org
> >>>>Hi Robert,
> >>>>
> >>>>If I recall our conversation and follow the discussion on cip-dev correctly, you are still
> >>>>maintaining the test builds and infrastructure from the CIP project, right?
> >>>>
> >>>>Could you provide to Markus Kreidl, Nicholas McGuire (see CC) and me the kernel
> >>>>configurations you use in the test builds for the different CIP members?
> >>>
> >>>Not sure about the configs that Robert uses for testing, but the configurations from CIP members can be found here.
> >>>https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
> >>[...]
> >>
> >>I think these are the configurations that Lukas needs - they are the
> >>configurations that should be used for determining whether commits are
> >>relevant to CIP.
> >>
> >ok - we started playing with them the siemens iot config seems very large to me is that
> >a designed config or did that "happen" ?
> 
> The IOT2000 is an open platform, and that naturally brings in the need to
> have more features preconfigured than one would selected in a dedicated
> devices, e.g. drivers for pluggable devices.
>
ok - but that makes the evaluation of actual impact quite hard
so it would be very helpful to have a realistic reference example for
a particular use-case if that is possible. The current configuration
will give a very pesemistic view of the potential impact. Do you know
if there is some Use-Case that we could use as a comparison ?

thx!
hofrat
