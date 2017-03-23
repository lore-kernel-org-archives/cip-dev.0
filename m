From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 23 Mar 2017 16:32:21 +0000
Subject: [cip-dev] Kernel feature support
In-Reply-To: <58C9695D.9090908@codethink.co.uk>
References: <1489070021.2949.73.camel@codethink.co.uk>
	<58C9695D.9090908@codethink.co.uk>
Message-ID: <HK2PR0601MB1329D4E7B2FC29BE6F011CFBB73F0@HK2PR0601MB1329.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Agustin, Ben,

Sorry for the slow response to your query.

> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
> bounces at lists.cip-project.org] On Behalf Of Agustin Benito Bethencourt
> Sent: 15 March 2017 16:19
> Hi,
> 
> On 09/03/17 15:33, Ben Hutchings wrote:
> > We've previously agreed that not all kernel features (drivers,
> > filesystems, network protocols, etc.) can be supported in an SLTS
> > branch.  I'd like to start working out what the supported features
> > should be for the 4.4 branch.
> >
> > Are members able to share their kernel .config files, showing which
> > features are enabled?  Or would you prefer to specify your needs at a
> > slightly higher level?

>From an SoC vendor point of view, ideally we'd like the interfaces provided by the reference platform to be included. As support for our CIP reference platform is not yet mainlined, I can't provide the exact .config yet. However it will likely be very similar to shmobile_defconfig [1].

Of course, narrowing down configurations supported by the CIP Kernel should probably be lead more by the end use-cases, but hopefully this is a start.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/configs/shmobile_defconfig

Kind regards, Chris

> 
> Answering this question is important to discard features in 4.4 that are not of
> CIP interest so we can severely reduce the amount of effort that we will
> need to do in terms of fixes analysis, security etc. in the future.
> 
> Please take some time to provide feedback.
> 
> Best Regards
> 
> --
> Agustin Benito Bethencourt
> Principal Consultant - FOSS at Codethink agustin.benito at codethink.co.uk
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
